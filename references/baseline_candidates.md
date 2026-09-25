# Baseline candidate checklist

This is a broad editorial shortlist, not a record of completed reproductions.
Verified published LIBERO scores and a ManiSkill2 StackCube reference score
have now been filled; other new result cells remain `--`.
Published results are not in-house reproductions.
Delete candidates from both the relevant table and experiment prose when narrowing
the list. Native support for the exact tasks, action space, and observations must
be verified before running an experiment.

## Allocation in this draft

| Table | Newly added candidates |
| --- | --- |
| RLBench2 | DP (end-effector variant only), SAM2Act+, GROOT, SPOT |
| ManiSkill | BAKU, FlowPolicy, VIOLA, GROOT, SPOT, Im2Flow2Act |
| LIBERO | BAKU, MDT, MemoryVLA, BPP, VPP, UWM, VIOLA, GROOT |
| Real world | SAM2Act+, MemoryVLA, MPI, VPP, VIOLA, GROOT, SPOT, Im2Flow2Act |

## Official-source checks and adaptation TODOs

- SAM2Act+: `https://github.com/sam2act/sam2act`.
  Retain only the memory-enabled variant as a baseline. Check the
  RLBench2 two-arm action space; RLBench/MemoryBench support is not RLBench2 support.
- MemoryVLA: `https://github.com/shihao1895/MemoryVLA`.
  LIBERO interfaces are available. Verify the exact four-suite configuration,
  pretrained weights, and task demonstrations; adapt the real robot separately.
- UWM: `https://github.com/WEIRDLabUW/unified-world-model`.
  Verify the LIBERO-90 pretraining/downstream split and additional video data.
  Do not transfer a published average into our four-suite table without checking.
- GROOT: `https://github.com/UT-Austin-RPL/GROOT`.
  Requires object-centric preprocessing and benchmark-specific adapters.
- SPOT: `https://github.com/NVlabs/object_centric_diffusion`.
  Official RLBench and real-robot workflows are available. Verify mesh/pose
  requirements and the public pose-estimator version. ManiSkill and RLBench2
  entries are proposed ports, not verified native benchmark integrations.
- VPP: `https://github.com/roboterax/video-prediction-policy`.
  The original workflows target CALVIN and real-world manipulation. ODEWorld
  subsequently reports a LIBERO-Long reproduction (see the score audit below).
  Other LIBERO suites still require verified results; disclose pretraining separately.
- MPI: `https://github.com/OpenDriveLab/MPI`.
  Representation pretraining, not PPI. Specify the downstream policy head,
  finetuning procedure, and external data before comparing real-world results.
- ReMem-VLA and WorldDP were removed from the LIBERO baseline pool after
  the conference-publication check below; their related-work citations remain.
- BPP: `https://arxiv.org/abs/2602.15010`.
  Conference publication is confirmed at RSS 2026. Still verify
  released code, checkpoints, and benchmark interfaces before committing runs.
- BAKU, MDT, FlowPolicy, VIOLA, and Im2Flow2Act reuse existing bibliography
  entries. TODO: verify official release, preprocessing, supervision requirements,
  and adapters for the allocated benchmarks; inclusion is not a support claim.

## LIBERO conference-publication pruning (2026-09-16)

Scope: LIBERO baselines only. PPI is removed by explicit user request,
not for lack of publication (RSS 2025). Other benchmark tables and
related-work citations are retained. This pass uses main-conference
publication as the criterion; workshop-only evidence is identified separately.
The criterion concerns the method paper, not the later paper supplying
a reproduced score. No retained numerical result is changed in this pass.

Removed:

- ReMem-VLA: `https://arxiv.org/abs/2603.12942` remains a preprint with no
  confirmed conference publication found in this check.
- WorldDP: the author's page `https://raktimgg.github.io/` marks the work
  as under review; `https://openreview.net/pdf?id=1ExV3HqQjN` is labeled
  under review as a submission to TMLR. No conference publication confirmed.
- OCWM: confirmed on the ICLR 2025 World Models workshop accepted-paper list,
  `https://sites.google.com/view/worldmodel-iclr2025/accepted-papers`.
  This is workshop acceptance, not an ICLR main-conference paper; excluded
  under the main-conference criterion, not described as wholly unpublished.

Retained publication evidence:

| Method | Confirmed venue | Primary source |
| --- | --- | --- |
| Diffusion Policy | RSS 2023 | `https://roboticsproceedings.org/rss19/p026.html` |
| ACT | RSS 2023 | `https://roboticsproceedings.org/rss19/p016.html` |
| DP3 | RSS 2024 | `https://www.roboticsproceedings.org/rss20/p067.html` |
| BAKU | NeurIPS 2024 | `https://proceedings.nips.cc/paper_files/paper/2024/hash/ff887781480973bd3cb6026feb378d1e-Abstract-Conference.html` |
| MDT | RSS 2024 | `https://roboticsproceedings.org/rss20/p121.html` |
| MemoryVLA | ICLR 2026 | `https://shihao1895.github.io/MemoryVLA/static/files/MemoryVLA_paper.pdf` |
| BPP | RSS 2026 | `https://www.roboticsproceedings.org/rss22/p201.html` |
| VPP | ICML 2025 | `https://proceedings.mlr.press/v267/hu25g.html` |
| UWM | RSS 2025 | `https://www.roboticsproceedings.org/rss21/p015.html` |
| VIOLA | CoRL 2022 (PMLR publication 2023) | `https://proceedings.mlr.press/v205/zhu23a.html` |
| GROOT | CoRL 2023 | `https://proceedings.mlr.press/v229/zhu23b.html` |

Some current BibTeX entries still cite preprints; that alone is not evidence
of non-publication. Conference publication also does not establish native
LIBERO support or the existence of scores for every suite.

## PPI citation correction

Use `yang2025ppi` for PPI, with metadata from
`https://www.roboticsproceedings.org/rss21/p160.html`.
The RSS title is *Gripper Pose and Object Pointflow as Interfaces for Robotic
Bimanual Manipulation*. Keep `zeng2024mpi` for MPI only.
The existing RLBench2 task-wise baseline values were checked against Table VI
of that paper (PDF page 8). The draft recomputes ACT's average as 15.5 from
displayed means; the source prints 15.4. Other original values are preserved.
PPI regenerated demonstrations: data and simulator equivalence to OSTRA still
requires confirmation. Matching a source table does not establish protocol parity.

## Published-score audit (2026-09-16)

### Filled in `tab/1_rlbench2.tex`: later DP reproductions

Source: *Spatial-Temporal Graph Diffusion Policy with Kinematic Modeling for
Bimanual Robotic Manipulation* (KStar Diffuser, CVPR 2025), Table 1,
**100-demo** block: `https://arxiv.org/html/2503.10743`.
Three training seeds, 100 rollouts per task per seed. Only the end-effector
variant (DP-EE in the source) is retained, labeled **DP** in our table.
The joint-angle variant DP-J is excluded. Values reordered to our task columns:

| Variant | Box | Ball | Drawer | Laptop | Dustpan | Tray | Handover Easy | Seven-task Avg. |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| DP (source: DP-EE) | 61.0 ± 2.0 | 59.7 ± 3.5 | -- | 10.3 ± 3.1 | 69.7 ± 2.5 | -- | 2.0 ± 1.0 | -- |

Appendix A.1 names `push_box`, `lift_ball`, `pick_laptop`, `sweep_dustpan`,
and `handover_item_easy`. Drawer/Tray are not evaluated. The source Overall
value 40.5 covers five tasks, not seven, and is not copied into Avg.
Do not overwrite the
existing PPI-derived ACT/DP3 results with this different reproduction.
Protocol parity with OSTRA remains unverified; provenance stays here, not
in the experiment prose.

### Filled in `tab/3_libero.tex`

All values below are percentages. `--` means missing, not zero. Source-specific
protocols differ; the LaTeX table labels the scores as published references
and deliberately does not apply a cross-protocol best/second-best ranking.
Exact numerical sources and evaluation details are maintained here, not in
the experiment prose or the LIBERO table's visible note.

| Method | Spatial | Object | Goal | Long-10 | Four-suite mean | Numerical source |
| --- | ---: | ---: | ---: | ---: | ---: | --- |
| Diffusion Policy | 78.3 | 92.5 | 68.3 | 50.5 | 72.4 | OpenVLA, Table 12 |
| BAKU | 94.0 | 95.0 | 96.0 | 87.0 | 93.0 | User-updated Object value; see revision note below |
| MDT | 78.5 | 87.5 | 73.5 | 64.8 | 76.1 | MDT, Table II, both auxiliary losses |
| MemoryVLA | 98.4 | 98.4 | 96.4 | 93.4 | 96.7 | MemoryVLA, Tables 3 and 17(b) |
| ACT | 82.0 | 78.8 | 66.1 | 44.0 | 67.7 | STAR, Table 1, ACT reproduction |
| VPP | -- | -- | -- | 81.0 | -- | ODEWorld, LIBERO-LONG results table |
| DP3 | -- | -- | -- | 29.1 | -- | Sparse2Act, Table 8, reproduced DP3 baseline |

- DP source: `https://arxiv.org/html/2406.09246v3`, Appendix E / Table 12.
  Language-conditioned DROID implementation; third-person RGB; cleaned and
  re-rendered demonstrations; three seeds, 500 trials per suite per seed.
  Source reports **standard errors**, not standard deviations: Spatial 1.1,
  Object 0.7, Goal 1.2, Long 1.3, average 0.7. The table displays means only.
- BAKU user revision (2026-09-16): Object was updated to 95.0 in the draft.
  The current average is (94 + 95 + 96 + 87) / 4 = 93.0.
  The source of the revised Object score has not been specified; do not
  attribute 95.0 or the revised average to GeoAware-VLA. The earlier
  published row is documented below for traceability.
- BAKU earlier published source: *GeoAware-VLA: Implicit Geometry Aware
  Vision-Language-Action Model*, `https://arxiv.org/html/2509.14117`,
  Table I, the plain BAKU row and Original-view columns only (not GeoAware
  BAKU, Evo-0 BAKU, or Unseen-view results). Section V-A reports 50
  demonstrations and 10 evaluation rollouts per task. The previously used
  four-suite row was 94.0 / 100.0 / 96.0 / 87.0.
  Our displayed-mean convention gives (94 + 100 + 96 + 87) / 4 = 94.25,
  rounded half-up to 94.3. The source prints 94.2; retain this distinction
  rather than attributing our recomputed average to the paper.
- BAKU previous alternative: `https://arxiv.org/html/2406.07539v2`, Section 4.3 / Table 2.
  LIBERO-10 success 0.86 becomes 86.0%; 50 demonstrations and 10 rollouts per
  task. Its separate LIBERO-90 result is not a four-suite average. MT-ACT's
  68.0% in that table is not silently relabeled as vanilla ACT.
  Its Long-only 86.0 is retained here for provenance but no longer used in
  the table; do not combine it with the selected reproduction's other suites.
- MDT source: `https://arxiv.org/html/2407.05996`, Table II / Appendix A-B.
  Uses 50 demonstrations per task with 2% language annotations; three seeds
  and 20 rollouts per task. Source-reported per-suite variation: 1.5, 0.9,
  2.0, 0.3. Four-suite mean is recomputed as 76.075 -> 76.1; no aggregate
  uncertainty is inferred. Do not mix in an ablated row or the five-suite mean.
- MemoryVLA source: `https://arxiv.org/html/2508.19236`, Section 4.3,
  Table 3 and Table 17(b). Third-person RGB; 50 trials per task; best-validation
  checkpoint; Long-10 and Long-90 are jointly trained. Four-suite mean is
  96.65 -> 96.7, not the paper's five-suite 96.5. No error bars are invented.
- ACT source: *STAR: Learning Diverse Robot Skill Abstractions through
  Rotation-Augmented Vector Quantization*,
  `https://arxiv.org/html/2506.03863v3`, Table 1 and Appendix A.5.2.
  Source columns start Object, Spatial; reordered to our Spatial, Object layout.
  Three seeds, 50 episodes per task. In our order, the reported standard
  deviations are 0.5, 1.2, 1.6, 0.5. We show means only.
  Four-suite mean: (82.0 + 78.8 + 66.1 + 44.0) / 4 = 67.725 -> 67.7;
  do not copy the source's five-suite Overall of 66.8.
  This is STAR's ACT reproduction, not the original ACT evaluation.
  Appendix A.5.2 specifies ResNet-18, CLIP text features, and 256-bin
  action discretization, an implementation difference requiring review
  before treating it as a matched vanilla-ACT comparison.
- VPP source: *ODEWorld: A Continuous Predictive Architecture via Physical-Time
  Flow*, `https://arxiv.org/html/2607.27924`, Section 5.4 and Appendix A.4.
  The LIBERO-LONG table reports VPP's ten-task mean as 81.0 over three seeds.
  Its rendered HTML caption labels this Table 2, while the surrounding prose
  refers to Table 3; identify it by its LIBERO-LONG caption and VPP row.
  Appendix A.4 describes finetuning the official VPP implementation on LIBERO.
  No Spatial/Object/Goal results or aggregate uncertainty are supplied there.
  The four-suite mean remains `--`; this is a later reproduction, not a
  four-suite evaluation from the original VPP paper. Check conditioning and
  pretraining compatibility before making a matched comparison.

- DP3 source: *Sparse2Act: Learning Action-Aligned Sparse 3D Representations
  for Cross-Domain Robot Manipulation*, `https://arxiv.org/html/2606.12759`,
  Table 8 and Appendix A.2--A.3. The authors adapt the original DP3
  implementation to LIBERO-10 and train it from scratch for 20,000 steps,
  evaluating every 2,000 steps and averaging the top five checkpoints.
  Inputs are 1,024 xyz-only points and robot state. The ten displayed task
  means are 0, 0, 100, 90, 8, 0, 35, 0, 11, 47; their mean is 29.1.
  Table 8 prints an aggregate 29.1 +/- 36.4; we display only the mean,
  consistent with the LIBERO table, without interpreting that spread as
  seed-level uncertainty. Spatial/Object/Goal and the four-suite average
  remain unfilled. This is a later reproduction, not our matched-data run.

### Results found but not inserted into mismatched columns

| Candidate | Checked source / setting | Decision |
| --- | --- | --- |
| SAM2Act+ | `https://arxiv.org/html/2501.18564`: MemoryBench | Not the seven-task bimanual RLBench2 setting |
| SPOT | `https://arxiv.org/html/2411.00965`, Table I: 13 RLBench tasks | Not RLBench2; no transplant of its 79.4 average |
| UWM | `https://arxiv.org/html/2504.02792`, Appendix A-1: five modified LIBERO-10 tasks | Neither full Long-10 nor standard initialization distribution |
| ReMem-VLA | `https://arxiv.org/html/2603.12942`, Section 4.2: extended MemoryBench | No verified standard LIBERO four-suite row |
| BPP | `https://arxiv.org/html/2602.15010`: custom memory tasks | No verified standard LIBERO row |
| OCWM | `https://arxiv.org/html/2503.06170`, Section 4: Language-Table | Not LIBERO |
| WorldDP | `https://arxiv.org/html/2606.08775`, Section 4.1: modified OGBench tasks | Not LIBERO |
| FlowPolicy | `https://arxiv.org/html/2412.04987`: Adroit / Meta-World | Not the six ManiSkill tasks |
| VPP (remaining suites) | Original paper plus ODEWorld reproduction above | Long = 81.0 is filled; Spatial/Object/Goal remain unverified |
| GROOT / VIOLA / Im2Flow2Act | Official project pages / `https://arxiv.org/html/2407.15208` | No verified scores for our exact table columns found |

### Filled in `tab/2_maniskill.tex`: DP3 StackCube reference

Source: *R3D: Revisiting 3D Policy Learning*,
`https://arxiv.org/html/2604.15281`, Table 6 and Appendix E.3.
The plain DP3 row reports Stack Cube = 14%, now shown as a daggered
reference score, not as our controlled reproduction. Section 5.1 uses
1,000 demonstrations per task and 1,024-point cropped point clouds.
Appendix E.3 specifies DP3 without point-cloud RGB, a planning horizon of
8, batch size 2,048, and 1,000 training epochs.
Exact simulator revision, environment-ID equivalence to the draft's v1
tasks, and evaluation parity still require confirmation before treating
this as a matched comparison. No uncertainty is inferred.
The source also reports Pick Cube = 57 and PegIns. Grasp/Align/Insert =
41/3/0, with a five-column average of 23.0. These columns do not match our
six-task layout; do not import that average or substitute grasp/alignment
success for full-task success. Our remaining DP3 cells stay unfilled.

### Database follow-up: AllenAI leaderboard mirror

Checked on 2026-09-16:

- Requested site: `https://allenai.github.io/vla-evaluation-harness/leaderboard/`.
- Readable public mirror: `https://openmoss.ai/Awesome-WAM/leaderboard/`.
- Data: `https://raw.githubusercontent.com/OpenMOSS/Awesome-WAM/main/leaderboard/data/leaderboard.json`.
  The snapshot declares `last_updated: 2026-05-16`; this is not a claim
  that it is the latest AllenAI database as of our check date.

The mirror provides discovery leads for reproductions in later papers,
including the BAKU and DP3 references above. Numerical entries must still
be checked against the reported paper, its exact model row, and task columns.
Do not automatically merge all results sharing a canonical model name.

One excluded record labels a LIBERO-Long 90.0 result as VPP but gives
`name_in_paper: UVA` and cites *Video Generators are Robot Policies*,
`https://arxiv.org/html/2508.00795`, Table 2. That table reports UVA = 0.90,
not VPP. The result therefore cannot fill VPP or UWM; VPP remains 81.0
from the previously documented reproduction.

No additional compatible records were identified in this snapshot for the
remaining empty LIBERO candidate rows or our seven-task bimanual RLBench2
layout. This is a scoped search result, not evidence that no later paper
reports them. The previously documented unrelated-benchmark exclusions still apply.
The later paper-level search found the DP3 LIBERO-10 reproduction documented
above; its Long score has now been filled independently of this snapshot.

### ManiSkill numbers retained for protocol selection, not main-table results

The draft has not fixed its ManiSkill version, demonstration count, camera setup,
or episode limits. Its bibliography currently cites ManiSkill2, while the
following results use ManiSkill3. Do not merge unrelated reproductions into
one six-task average or import a modified insertion success criterion.

1. `https://arxiv.org/html/2602.21633`, SC-VLA Table 1, reports:

   | Variant | StackCube | PlaceSphere | LiftPegUpright | PegInsertion |
   | --- | ---: | ---: | ---: | ---: |
   | DP, separate task specialists | 88 | 100 | 80 | 40 |
   | ACT, separate task specialists | 64 | 90 | 46 | 4 |
   | DP, joint multi-task | 46 | 90 | 10 | 0 |
   | ACT, joint multi-task | 50 | 88 | 60 | 12 |

   100 demonstrations and 50 evaluation episodes per task. Exact PegInsertion
   environment-ID mapping to our PegInsertionSide-v1 is not verified.

2. `https://arxiv.org/html/2607.01166`, Table 2, reports:

   | Method | StackCube-v1 | PullCubeTool-v1 | PegInsertionSide-v1 (relaxed) |
   | --- | ---: | ---: | ---: |
   | DP | 56 | 87 | 24 |
   | DP3 | 47 | 94 | 7 |

   1,000 demonstrations per task, four observation cameras, 100 episodes.
   Peg insertion clearance is relaxed to 0.01 m. These are not results under
   the default insertion criterion. The source's three-task averages cannot
   populate our six-task average column.

Official ManiSkill ACT/DP baseline READMEs provide implementations and training
commands; an implementation alone is not a verified score for this table.
For our custom Realman/Pika task suite, no matching external scores were found;
all real-world cells stay unfilled rather than importing similarly named tasks.

## Fair comparison and pruning

- Use matched evaluation tasks, initialization distributions, and success criteria.
- Record RGB/RGB-D/point-cloud inputs, language/goal inputs, observation histories,
  action horizons, extra object annotations, and pretrained datasets separately.
- Do not silently force a memory-based method into a single-frame interface.
- Do not label externally pretrained VLA comparisons as equal-data training.
- Validate simulation and robot action adapters before collecting numerical results.
- Retain SAM2Act+ as the historical-memory baseline; omit the standard SAM2Act
  comparison. Keep their shared bibliography entry for the retained variant.
- MPI is useful only with a clearly defined and controlled action head.
- TACO/Relay Policy Learning and FOCUS are not inserted into every main table:
  task sketches, hierarchical/RL training, or exploration protocols would require
  a separately specified comparison setting. They remain related-work references.
- ORION's single-human-video setup likewise needs a separate protocol before
  mixing it into robot-demonstration imitation-learning tables.
- Optional controlled ablation: the same backbone with a longer observation
  history but no OST-Map or future-node loss. Label it as our own control,
  not as a reproduction of a published baseline.