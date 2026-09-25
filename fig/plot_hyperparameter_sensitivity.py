#!/usr/bin/env python3

from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np


X = np.array([0.25, 0.5, 1.0, 1.5, 2.0])
COLORS = ["#0173b2", "#de8f05", "#029e73", "#cc78bc"]
STYLES = ["-", "--", "-.", ":"]
MARKERS = ["o", "s", "^", "D"]

TEMPORAL = [
    (r"Past keyframes $H_p$", [70.2, 81.5, 89.8, 89.6, 88.7]),
    (r"Recent observations $T_o$", [82.4, 86.8, 89.8, 88.9, 87.1]),
    (r"Future keyframes $H_k$", [75.6, 84.1, 89.8, 89.5, 86.8]),
    (r"Action horizon $H_a$", [79.8, 85.7, 89.8, 84.9, 78.2]),
]

LOSSES = [
    (r"Object state $\lambda_M/\lambda_A$", [74.3, 83.0, 89.8, 87.7, 83.2]),
    (r"TCP $\lambda_E/\lambda_A$", [81.2, 86.0, 89.8, 88.6, 85.0]),
    (r"Gripper $\lambda_G/\lambda_A$", [85.1, 87.8, 89.8, 88.8, 86.9]),
]


def draw_panel(ax, title, series):
    for index, (label, values) in enumerate(series):
        ax.plot(
            X,
            values,
            color=COLORS[index],
            linestyle=STYLES[index],
            marker=MARKERS[index],
            linewidth=1.5,
            markersize=4,
            label=label,
        )

    ax.set_title(title, fontsize=10)
    ax.set_xlim(0.15, 2.1)
    ax.set_ylim(50, 100)
    ax.set_xticks(np.arange(0.25, 2.01, 0.25))
    ax.set_yticks(np.arange(50, 101, 10))
    ax.set_xlabel("Parameter value / reference value", fontsize=9)
    ax.set_ylabel("Mean success rate (%)", fontsize=9)
    ax.tick_params(labelsize=8)
    ax.grid(axis="y", color="#dddddd", linewidth=0.6)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.legend(
        loc="lower left",
        frameon=False,
        fontsize=7,
        ncol=2,
        columnspacing=0.9,
        handlelength=2.0,
    )


def main():
    plt.rcParams.update(
        {
            "font.family": "serif",
            "mathtext.fontset": "dejavuserif",
            "pdf.fonttype": 42,
        }
    )
    figure, axes = plt.subplots(1, 2, figsize=(7.5, 2.35))
    draw_panel(axes[0], "(a) Temporal parameters", TEMPORAL)
    draw_panel(axes[1], "(b) DiT training: loss ratios", LOSSES)
    figure.subplots_adjust(left=0.075, right=0.995, bottom=0.27, top=0.84, wspace=0.2)

    output = Path(__file__).with_name("6_hyperparameter_sensitivity.pdf")
    figure.savefig(output, bbox_inches="tight", pad_inches=0.02)


if __name__ == "__main__":
    main()
