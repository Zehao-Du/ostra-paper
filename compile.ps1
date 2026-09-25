[CmdletBinding()]
param(
    [switch]$Clean,
    [switch]$Rebuild
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$mainFile = 'iclr2027_conference.tex'
$jobName = [System.IO.Path]::GetFileNameWithoutExtension($mainFile)
$pdfPath = Join-Path $projectRoot ($jobName + '.pdf')

function Invoke-Checked {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Program,

        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    Write-Host ("> {0} {1}" -f $Program, ($Arguments -join ' '))
    & $Program @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Program failed with exit code $LASTEXITCODE."
    }
}

function Clear-LatexOutputs {
    $latexmk = Get-Command latexmk -ErrorAction SilentlyContinue
    if ($null -ne $latexmk) {
        Invoke-Checked $latexmk.Source @('-C', $mainFile)
    }

    $extensions = @(
        '.aux', '.bbl', '.bcf', '.blg', '.fdb_latexmk', '.fls', '.idx',
        '.ilg', '.ind', '.lof', '.log', '.lot', '.nav', '.out', '.run.xml',
        '.snm', '.synctex.gz', '.toc', '.vrb', '.xdv'
    )

    foreach ($extension in $extensions) {
        $path = Join-Path $projectRoot ($jobName + $extension)
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            Remove-Item -LiteralPath $path -Force
        }
    }

    if (Test-Path -LiteralPath $pdfPath -PathType Leaf) {
        Remove-Item -LiteralPath $pdfPath -Force
    }
}

Push-Location $projectRoot
try {
    if (-not (Test-Path -LiteralPath (Join-Path $projectRoot $mainFile) -PathType Leaf)) {
        throw "Main TeX file not found: $mainFile"
    }

    if ($Clean -or $Rebuild) {
        Write-Host 'Cleaning LaTeX build outputs...'
        Clear-LatexOutputs
    }

    if ($Clean -and -not $Rebuild) {
        Write-Host 'Clean complete.'
        exit 0
    }

    $latexmk = Get-Command latexmk -ErrorAction SilentlyContinue
    if ($null -ne $latexmk) {
        Invoke-Checked $latexmk.Source @(
            '-pdf',
            '-interaction=nonstopmode',
            '-file-line-error',
            '-halt-on-error',
            '-synctex=1',
            $mainFile
        )
    }
    else {
        $pdflatex = Get-Command pdflatex -ErrorAction SilentlyContinue
        $bibtex = Get-Command bibtex -ErrorAction SilentlyContinue
        if ($null -eq $pdflatex -or $null -eq $bibtex) {
            throw 'No usable LaTeX toolchain found. Install latexmk, or both pdflatex and bibtex.'
        }

        $pdfArgs = @(
            '-interaction=nonstopmode',
            '-file-line-error',
            '-halt-on-error',
            '-synctex=1',
            $mainFile
        )

        Invoke-Checked $pdflatex.Source $pdfArgs
        Invoke-Checked $bibtex.Source @($jobName)
        Invoke-Checked $pdflatex.Source $pdfArgs
        Invoke-Checked $pdflatex.Source $pdfArgs
    }

    if (-not (Test-Path -LiteralPath $pdfPath -PathType Leaf)) {
        throw "Compilation finished without producing $pdfPath."
    }

    $pdf = Get-Item -LiteralPath $pdfPath
    Write-Host ("Build succeeded: {0} ({1:N0} bytes)" -f $pdf.FullName, $pdf.Length)
}
finally {
    Pop-Location
}
