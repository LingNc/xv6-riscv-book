# xv6-riscv 中文翻译版

本仓库 Fork 自 [mit-pdos/xv6-riscv](https://github.com/mit-pdos/xv6-riscv)，包含 MIT 6.S081 课程所使用的 xv6 操作系统配套书籍的源代码。

已完整翻译了配套书籍《xv6: a simple, Unix-like teaching operating system》的全文。

本项目使用 Claude Code 完成所有的翻译工作，提示词在 `docs/INIT.md` 中，并且使用 Kimi-K2.5 模型完成所有的规划和翻译工作，如果需要使用其他模型或润色，需要重新翻译请使用 `INIT.md` 的提示词。

## 关于翻译

- **原著名称**：*xv6: a simple, Unix-like teaching operating system*
- **中文译名**：*xv6: 一个简单的类 Unix 教学操作系统*
- **翻译范围**：全书完整翻译（包含全部章节、代码注释引用说明及附录）。
- **翻译目的**：便于中文母语者阅读和学习 RISC-V 版本 xv6 的设计与实现。
- **使用工具**：Claude Code（Kimi-K2.5 模型）进行翻译执行，严格按照 `docs/INIT.md` 中的提示词设定进行操作。

## 阅读

  在 release 中选择版本进行下载阅读。

## 源仓库说明

  本书的这一版本已转换为LaTeX格式。

  为构建此书，请确保您的TeX发行版包含`pdflatex`命令。拥有该命令后，您应能通过运行`make`来构建书籍，这将克隆操作系统本身，并将书籍编译至主目录下的`book.pdf`文件中。

  书中插图采用`inkscape`绘制。

## 致谢

  感谢 MIT PDOS 实验室提供如此优秀的教学操作系统与文档。
  原项目地址：[mit-pdos/xv6-riscv](https://github.com/mit-pdos/xv6-riscv)
  翻译工作基于 [CC BY 4.0 或 MIT 许可证] 进行。

## 声明

  本仓库中的中文译文仅供学习交流使用。
  如有翻译不当之处，欢迎提交 Issue 或 Pull Request。
  原著版权归原作者所有。
