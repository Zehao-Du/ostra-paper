# Hyperparameter sensitivity：绘图数据填写表

本文件是绘图脚本的数据源，不作为论文表格插入。
上面的 Measured 表填实测数据；下面的 Simulated 表仅用于预览，不是实验结果。

## 填写方法

- `Reference` 填该参数的实际默认值。四个时序参数填数量；三个 loss 参数填相对 action loss 的比例。
- `0.25x` 等列表示相对默认值的扫描位置，单元格填平均成功率（0--100），缺失保留 `--`。
- 时序参数的实际取值 = Reference × 列标题倍数，必须是整数；如不是整数，该格留空，或修改整张表的倍数列标题。
- 每条曲线只变当前参数，其余参数固定；所有 `1x` 单元格应填写同一默认配置的成功率。
- 固定 action loss 系数；扫描某个 loss 比例时，另外两个比例不变。
- 可调整倍数列或增加扫描列，标题保持 `数字x` 格式；不要修改参数标识。
- 默认值和扫描点尚未确定，Measured 表没有预填模拟设置。

实测绘图命令（从项目根目录运行）：
`python fig/plot_hyperparameter_sensitivity.py`

模拟预览命令：
`python fig/plot_hyperparameter_sensitivity.py --demo`

脚本始终读取对应表，不会用模拟数据补齐缺失的实测结果。
脚本同时生成 PDF 和可直接编译的 LaTeX 曲线；论文使用 `.tex`，不依赖生成的 PDF。
模拟预览与实测图分别保存为 `fig/hyperparameter_sensitivity_demo.tex`
和 `fig/hyperparameter_sensitivity.tex`。切换到实测图时，在
`fig/6_hyperparameter_sensitivity.tex` 的 input 文件名中去掉 `_demo`，并删除模拟预览声明。

## Measured

| Parameter | Reference | 0.25x | 0.5x | 1x | 1.5x | 2x |
| --- | --- | --- | --- | --- | --- | --- |
| H_p | -- | -- | -- | -- | -- | -- |
| T_o | -- | -- | -- | -- | -- | -- |
| H_k | -- | -- | -- | -- | -- | -- |
| H_a | -- | -- | -- | -- | -- | -- |
| lambda_M/lambda_A | -- | -- | -- | -- | -- | -- |
| lambda_E/lambda_A | -- | -- | -- | -- | -- | -- |
| lambda_G/lambda_A | -- | -- | -- | -- | -- | -- |

## Simulated

以下默认值与成功率全部为人工构造的排版示例，不代表实际配置或结果。

| Parameter | Reference | 0.25x | 0.5x | 1x | 1.5x | 2x |
| --- | --- | --- | --- | --- | --- | --- |
| H_p | 4 | 68 | 79 | 88 | 90 | 89 |
| T_o | 4 | 80 | 85 | 88 | 87 | 85 |
| H_k | 4 | 73 | 82 | 88 | 89 | 86 |
| H_a | 16 | 78 | 84 | 88 | 83 | 76 |
| lambda_M/lambda_A | 1 | 72 | 81 | 88 | 86 | 81 |
| lambda_E/lambda_A | 1 | 79 | 84 | 88 | 87 | 83 |
| lambda_G/lambda_A | 1 | 83 | 86 | 88 | 87 | 85 |