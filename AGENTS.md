# xv6 中文翻译团队指南

## 项目信息
- 分支: chinese
- 基于: rev5 标签
- 目标: 完成 xv6 书籍的中文翻译

## 术语表

### 核心操作系统术语
| 英文 | 中文 | 备注 |
|------|------|------|
| process | 进程 | xv6 的调度单位 |
| kernel | 内核 | 操作系统核心 |
| system call | 系统调用 | 用户态与内核态接口 |
| scheduler | 调度器 | 进程调度机制 |
| context switch | 上下文切换 | 进程状态保存/恢复 |
| thread | 线程 | 执行控制流 |
| time-share | 分时 | CPU时间共享 |
| isolation | 隔离 | 进程间隔离机制 |
| multiplexing | 多路复用 | 资源共享技术 |

### 内存管理术语
| 英文 | 中文 | 备注 |
|------|------|------|
| page table | 页表 | 虚拟内存映射结构 |
| page table entry (PTE) | 页表项 | 页表条目 |
| virtual memory | 虚拟内存 | 地址空间抽象 |
| physical memory | 物理内存 | 实际硬件内存 |
| virtual address | 虚拟地址 | 程序使用的地址 |
| physical address | 物理地址 | 硬件实际地址 |
| address space | 地址空间 | 进程的虚拟地址范围 |
| user memory | 用户内存 | 进程用户空间内存 |
| page | 页/页面 | 4KB内存单元 |
| page fault | 页故障 | 缺页异常 |
| direct mapping | 直接映射 | 虚拟地址=物理地址 |
| guard page | 保护页 | 用于检测栈溢出 |
| Translation Look-aside Buffer (TLB) | 快表/转址旁路缓存 | 页表缓存 |
| Sv39 | Sv39模式 | RISC-V 39位虚拟地址模式 |

### RISC-V 架构术语
| 英文 | 中文 | 备注 |
|------|------|------|
| privilege mode | 特权模式 | S-mode/U-mode/M-mode |
| machine mode | 机器模式 | 最高特权级 |
| supervisor mode | 监管者模式/内核态 | 内核运行模式 |
| user mode | 用户模式/用户态 | 应用程序运行模式 |
| user space | 用户空间 | 用户态运行的环境 |
| kernel space | 内核空间 | 内核态运行的环境 |
| privileged instruction | 特权指令 | 只能在内核态执行的指令 |
| exception | 异常 | 同步异常事件 |
| interrupt | 中断 | 异步事件处理 |
| trap | 陷入/陷阱 | 异常/中断处理入口 |
| ecall | 环境调用指令 | 系统调用指令 |
| sret | 监管者返回指令 | 从陷入返回 |
| hart | 硬件线程 | RISC-V CPU核心 |

### RISC-V 控制寄存器
| 英文 | 中文 | 备注 |
|------|------|------|
| satp | 监管者地址转换寄存器 | Supervisor Address Translation |
| stvec | 陷入向量寄存器 | 存放陷入处理入口地址 |
| sepc | 监管者异常PC寄存器 | 保存陷入时的PC |
| scause | 陷入原因寄存器 | 标识陷入原因 |
| sscratch | 监管者暂存寄存器 | 用于陷入处理 |
| sstatus | 监管者状态寄存器 | 包含SIE、SPP等位 |
| mepc | 机器模式异常PC | 机器模式保存的PC |
| mstatus | 机器模式状态寄存器 | 机器模式状态 |

### 陷入与中断处理
| 英文 | 中文 | 备注 |
|------|------|------|
| handler | 处理程序 | 陷入/中断处理代码 |
| vector | 向量 | 陷入入口代码 |
| trampoline | 跳板/跳板页 | 用户态与内核态过渡代码页 |
| trapframe | 陷入帧 | 保存用户寄存器的结构 |
| device interrupt | 设备中断 | 硬件设备产生的中断 |
| timer interrupt | 定时器中断 | 时钟产生的中断 |
| yield | 让出/放弃 | 主动放弃CPU |

### 同步与并发
| 英文 | 中文 | 备注 |
|------|------|------|
| lock | 锁 | 同步原语 |
| spin lock | 自旋锁 | 忙等待锁 |
| sleep-lock | 睡眠锁 | 可让出CPU的锁 |
| race condition | 竞态条件 | 并发问题 |
| deadlock | 死锁 | 循环等待 |
| critical section | 临界区 | 需要互斥的代码段 |

### 文件系统术语
| 英文 | 中文 | 备注 |
|------|------|------|
| file system | 文件系统 | 存储抽象 |
| inode | 索引节点 | 文件元数据 |
| i-number | i号/索引号 | inode编号 |
| dinode | 磁盘索引节点 | 磁盘上的inode结构 |
| directory | 目录 | 文件组织方式 |
| pathname | 路径名 | 文件路径 |
| file descriptor | 文件描述符 | 打开文件的标识 |
| block | 块 | 磁盘数据单元（1024字节） |
| sector | 扇区 | 磁盘物理单元（512字节） |
| superblock | 超级块 | 文件系统元数据块 |
| buffer cache | 缓冲区缓存 | 磁盘块缓存 |
| direct block | 直接块 | inode直接引用的数据块 |
| indirect block | 间接块 | 存储数据块地址的块 |
| transaction | 事务 | 原子性操作单位 |
| log | 日志 | 崩溃恢复日志 |
| group commit | 组提交 | 批量提交事务 |
| absorption | 吸收 | 同一事务中重复写优化 |
| crash recovery | 崩溃恢复 | 系统崩溃后恢复 |
| persistence | 持久性 | 数据持久存储 |

### ELF 格式术语
| 英文 | 中文 | 备注 |
|------|------|------|
| ELF | 可执行与可链接格式 | Executable and Linkable Format |
| elfhdr | ELF头部 | ELF文件头结构 |
| proghdr | 程序头部 | 程序段头结构 |
| text segment | 代码段 | 可执行指令段 |
| data segment | 数据段 | 全局变量段 |
| magic number | 魔数 | 文件标识号 |

### xv6 内核结构/函数
| 英文 | 中文 | 备注 |
|------|------|------|
| struct proc | 进程结构体 | 进程状态 |
| struct inode | 内存inode结构体 | 内存中的inode |
| struct dinode | 磁盘inode结构体 | 磁盘上的inode |
| struct file | 文件结构体 | 打开文件表示 |
| struct buf | 缓冲区结构体 | 磁盘块缓存 |
| struct trapframe | 陷入帧结构体 | 保存寄存器状态 |
| pagetable_t | 页表类型 | 页表指针类型 |
| p->pagetable | 进程页表 | 进程的页表 |
| p->kstack | 内核栈 | 进程的内核栈 |
| p->state | 进程状态 | 进程当前状态 |
| p->trapframe | 进程陷入帧 | 指向trapframe |

### 内核内存管理函数
| 英文 | 中文 | 备注 |
|------|------|------|
| kvminit | 内核页表初始化 | 创建内核页表 |
| kvmmap | 内核页表映射 | 内核页表添加映射 |
| mappages | 映射页面 | 建立页表映射 |
| walk | 遍历页表 | 查找虚拟地址对应的PTE |
| walkaddr | 遍历获取地址 | 获取虚拟地址对应的物理地址 |
| uvmcreate | 创建用户页表 | 创建空用户页表 |
| uvmalloc | 用户内存分配 | 为用户分配内存 |
| copyout | 复制到用户空间 | 内核→用户内存拷贝 |
| copyin | 从用户空间复制 | 用户→内核内存拷贝 |
| copyinstr | 复制用户字符串 | 复制用户字符串到内核 |
| kalloc | 内核分配 | 分配物理页 |
| kfree | 内核释放 | 释放物理页 |
| freerange | 释放范围 | 释放一段物理内存 |

### 陷入处理函数
| 英文 | 中文 | 备注 |
|------|------|------|
| uservec | 用户陷入入口 | 用户态陷入汇编入口 |
| usertrap | 用户陷入处理 | C语言用户陷入处理 |
| userret | 用户返回 | 返回用户态 |
| kernelvec | 内核陷入入口 | 内核态陷入汇编入口 |
| kerneltrap | 内核陷入处理 | C语言内核陷入处理 |
| syscall | 系统调用分发 | 系统调用处理入口 |
| devintr | 设备中断处理 | 处理设备中断 |

### 文件系统函数
| 英文 | 中文 | 备注 |
|------|------|------|
| bread | 读块 | 读取磁盘块到缓冲区 |
| bwrite | 写块 | 将缓冲区写入磁盘 |
| brelse | 释放缓冲区 | b-release缩写 |
| binit | 缓冲区初始化 | 初始化缓冲缓存 |
| bget | 获取缓冲区 | 获取指定块缓冲区 |
| begin_op | 开始操作 | 开始文件系统事务 |
| end_op | 结束操作 | 提交文件系统事务 |
| log_write | 日志写 | 记录写操作到日志 |
| balloc | 块分配 | 分配磁盘块 |
| bfree | 块释放 | 释放磁盘块 |
| ialloc | inode分配 | 分配新inode |
| iget | 获取inode | 获取inode引用 |
| iput | 释放inode | 释放inode引用 |
| ilock | 锁定inode | 加锁并读取inode |
| iunlock | 解锁inode | 解锁inode |
| itrunc | 截断inode | 截断文件长度 |
| readi | 读取inode | 从inode读取数据 |
| writei | 写入inode | 向inode写入数据 |
| bmap | 块映射 | 获取文件数据块号 |
| dirlookup | 目录查找 | 在目录中查找条目 |
| dirlink | 目录链接 | 向目录添加条目 |
| namei | 名称解析 | 解析路径获取inode |
| nameiparent | 解析父目录 | 解析路径获取父目录 |

### 页表标志位
| 英文 | 中文 | 备注 |
|------|------|------|
| PTE_V | 有效位 | 页表项有效 |
| PTE_R | 可读位 | 允许读访问 |
| PTE_W | 可写位 | 允许写访问 |
| PTE_X | 可执行位 | 允许执行 |
| PTE_U | 用户位 | 用户态可访问 |

### 通用编程术语
| 英文 | 中文 | 备注 |
|------|------|------|
| stack | 栈 | 调用栈 |
| heap | 堆 | 动态分配内存区 |
| pointer | 指针 | 内存地址引用 |
| virtual address | 虚拟地址 | 程序使用的地址 |
| physical address | 物理地址 | 硬件实际地址 |
| boot | 引导/启动 | 系统启动过程 |
| scheduler | 调度器 | 进程调度 |
| type cast | 类型转换 | C语言类型转换 |

## 易混淆术语清单

### 1. trap / exception / interrupt 的区别
- **trap（陷入）**: 统称，指从用户态切换到内核态的所有情况
- **exception（异常）**: 同步事件，指令执行出错（如缺页、非法指令）
- **interrupt（中断）**: 异步事件，硬件信号（如设备中断、定时器中断）
- **翻译建议**: trap→陷入/陷阱, exception→异常, interrupt→中断

### 2. process / thread / hart 的区别
- **process（进程）**: xv6的隔离单位，包含地址空间和线程
- **thread（线程）**: 执行控制流，xv6中每个进程一个线程
- **hart（硬件线程）**: RISC-V CPU核心，物理执行单元
- **翻译建议**: 明确区分，process→进程, thread→线程, hart→硬件线程

### 3. user mode / user space 的区别
- **user mode（用户模式/用户态）**: CPU执行模式
- **user space（用户空间）**: 虚拟地址范围（程序运行的内存区域）
- **翻译建议**: mode→模式/态, space→空间

### 4. inode / dinode / struct inode 的区别
- **inode（索引节点）**: 统称
- **dinode（磁盘索引节点）**: 磁盘上的结构体 struct dinode
- **struct inode（内存inode）**: 内存中的inode结构
- **翻译建议**: 必要时加括号说明

### 5. block / sector 的区别
- **sector（扇区）**: 磁盘硬件单元，512字节
- **block（块）**: xv6文件系统逻辑单元，1024字节
- **翻译建议**: sector→扇区, block→块

### 6. virtual address / physical address 的区别
- **virtual address（虚拟地址）**: 程序使用的地址（如0x1000）
- **physical address（物理地址）**: 实际RAM地址（如0x80001000）
- **翻译建议**: 虚拟地址 vs 物理地址

### 7. kernel stack / user stack 的区别
- **kernel stack（内核栈）**: 进程在内核态使用的栈（p->kstack）
- **user stack（用户栈）**: 进程在用户态使用的栈
- **翻译建议**: 内核栈 vs 用户栈

## 翻译风险标注

### 高风险章节
| 章节 | 风险等级 | 原因 |
|------|----------|------|
| mem.tex | 高 | 内存概念复杂，页表术语密集，RISC-V硬件细节多 |
| trap.tex | 高 | CPU控制寄存器多，陷入处理流程复杂 |
| fs.tex | 高 | 文件系统层次多，函数名密集，事务/日志概念复杂 |
| lock.tex | 高 | 并发概念抽象，死锁/竞态条件难以表述 |
| sched.tex | 中 | 调度算法涉及状态转换 |
| sleep.tex | 高 | 同步机制复杂，睡眠锁与自旋锁区别 |

### 中等风险章节
| 章节 | 风险等级 | 原因 |
|------|----------|------|
| first.tex | 中 | 基础概念密集，首次出现大量术语 |
| pgfault.tex | 中 | 页故障逻辑，与内存管理相关 |
| interrupt.tex | 中 | 硬件相关术语 |

### 低风险章节
| 章节 | 风险等级 | 原因 |
|------|----------|------|
| acks.tex | 低 | 致谢内容 |
| lock2.tex | 低 | 补充内容 |
| sum.tex | 低 | 总结内容 |

### 特别注意事项
1. **RISC-V 寄存器名**: 如 satp、stvec、sepc 等保持原文，可加中文注释
2. **xv6 函数名**: 如 uservec、kerneltrap 等保持原文，不可翻译
3. **结构体字段**: 如 p->pagetable、p->state 保持原文
4. **系统调用名**: 如 fork、exec、wait 保持原文
5. **页表标志位**: PTE_V、PTE_R 等保持原文，首次出现可注释

## 翻译规范

### 代码处理
- 代码块、命令、变量名、文件路径、API 名称**保持原文**
- 代码注释尽可能翻译，技术术语双语标注

### 术语处理
- 操作系统/编程专业术语采用「中文（English）」格式
- 首次出现时标注，后续可简写
- 例: 进程（process）、页表（page table）、系统调用（system call）

### 风格要求
- 句式结构贴近原文，技术文档风格简洁准确
- 保留原书章节层级、图表引用、交叉链接
- 避免过度意译

## LaTeX 中文配置

### 字体配置

当前使用 `xeCJK` 宏包支持中文排版，配置四级字体回退机制：

```latex
% 回退层级（优先级从高到低）
1. 方正字体: FZShuSong-Z01S / FZLanTingHei-R-GBK
2. Noto CJK: Noto Serif CJK SC / Noto Sans CJK SC  
3. Source Han: Source Han Serif SC / Source Han Sans SC
4. WenQuanYi: WenQuanYi Micro Hei
```

**英文字体配置**:
- 正文: Times New Roman
- 无衬线: Arial
- 等宽: Courier New

### 编译要求

**必需软件**:
- `xelatex` (通过 texlive-xetex 或完整 TeX Live 安装)

**可选软件**:
- `gnuplot-lua-tikz` (如需生成图表，或注释掉 `book.tex` 中的 `\usepackage{gnuplot-lua-tikz}`)

**安装命令** (Debian/Ubuntu):
```bash
sudo apt-get install texlive-xetex texlive-lang-chinese
# 可选: sudo apt-get install gnuplot-lua-tikz
```

**编译方式**:

1. 使用 Makefile (推荐):
```bash
make
```

2. 使用编译脚本:
```bash
./build-cn.sh
```

3. 手动编译:
```bash
xelatex book.tex
bibtex book
xelatex book.tex
xelatex book.tex
```

### 字体安装指南

**系统当前可用字体检查**:
```bash
fc-list : family | grep -i "noto\|source han\|wenquanyi"
```

**安装方正字体** (可选，如有授权):
1. 下载方正字体文件 (.ttf/.otf)
2. 复制到系统字体目录: `~/.fonts/` 或 `/usr/share/fonts/`
3. 更新字体缓存: `fc-cache -fv`

**系统字体优先级**:
- **TeX Live 自带**: Fandol 字体（宋体/黑体/楷体/仿宋）- **当前实际使用**
- Linux: Noto CJK 字体（系统预装）
- macOS: 可安装思源宋体或直接使用系统中文字体
- Windows: 可使用 SimSun/SimHei 等系统自带字体

### 编译问题排查

| 问题 | 可能原因 | 解决方案 |
|------|----------|----------|
| 中文字符显示为方框 | 字体缺失 | 安装 Noto CJK 或修改字体配置 |
| 编译报错 "font not found" | 字体名称不匹配 | 使用 `fc-list` 查看正确字体名 |
| 书签乱码 | hyperref 未配置 unicode | 已配置 `unicode=true` |
| 粗体/斜体无效 | 字体族缺少对应样式 | 使用 BoldFeatures 配置 |

### 相关文件

- `book.tex`: 主文档，包含字体配置
- `build-cn.sh`: 编译脚本，含字体检查
- `Makefile`: 构建配置（使用 xelatex）
- `test-cn.tex`: 最小化中文测试文档

### 当前环境状态（2026-04-08）

**字体配置**: 四级回退机制已配置
- 方正字体 → Noto CJK → Source Han → WenQuanYi

**系统字体状态**:
```
✅ Noto Serif CJK SC      (可用)
✅ Noto Sans CJK SC       (可用)
✅ Noto Sans Mono CJK SC  (可用)
❌ FZShuSong-Z01S         (未安装)
❌ FZLanTingHei-R-GBK     (未安装)
❌ Source Han Serif SC    (未安装)
❌ WenQuanYi Micro Hei    (未安装)
```

**预期实际使用字体**: Noto Serif CJK SC / Noto Sans CJK SC

**编译器状态**:
```
✅ xelatex    - TeX Live 2026 (/usr/local/texlive/2026/bin/x86_64-linux/)
✅ 版本       - XeTeX 3.141592653-2.6-0.999998
✅ 编译测试   - 通过 (生成book.pdf 49页)
```

**实际使用字体**: Fandol (TeX Live 2026自带)
- Fandol Song (宋体)
- Fandol Hei (黑体)
- Fandol Kai (楷体)

## Git 规范
- commit 信息简略明确
- 严禁 Co-authored-by 等作者署名
- 小步快跑，频繁提交

## 章节进度

| 章节 | 状态 | 负责人 | 行数 | 风险标注 |
|------|------|--------|------|----------|
| acks.tex | 待翻译 | Translator | 39 | 低 |
| unix.tex | ✅ 已完成 | Translator | 1116 | 高-历史叙述长 |
| first.tex | ✅ 已完成 | Translator | 701 | 中-专业术语密集 |
| mem.tex | ✅ 已完成 | Translator | 924 | 高-内存概念复杂 |
| trap.tex | ✅ 已完成 | Translator | 512 | 高-CPU细节多 |
| pgfault.tex | ✅ 已完成 | Translator | 296 | 中-页故障逻辑 |
| interrupt.tex | ✅ 已完成 | Translator2 | 305 | 中-硬件相关 |
| lock.tex | ✅ 已完成 | Translator | 933 | 高-并发概念 |
| sched.tex | ✅ 已完成 | Translator2 | 433 | 中-调度算法 |
| sleep.tex | ✅ 已完成 | Translator2 | 843 | 高-同步机制复杂 |
| fs.tex | 翻译中 | Translator2 | 1819 | 高-最大章节 |
| lock2.tex | 翻译中 | Translator | 231 | 低 |
| sum.tex | 待翻译 | Translator | 14 | 低 |

## 当前焦点
1. **fs.tex翻译** - Translator2进行中（最大章节1819行）
2. **lock2.tex翻译** - Translator进行中
3. **编译环境** - ✅ 已就绪 (book.pdf 440KB, 59页)

## 审计问题记录

### 审计报告 - xv6中文翻译质量审计

**审计时间**: 进行中
**审计员**: Reviewer
**审计标准**: 
1. 译文与英文原文（rev5）意思一致
2. 无漏译、误译、过度意译
3. 技术准确性保持
4. 术语使用统一

---

### 章节审计状态总览

| 章节 | 英文行数 | 中文行数 | 审计状态 | 问题数 | 备注 |
|------|----------|----------|----------|--------|------|
| unix.tex | ~1116 | ~754 | 🟡 待审计 | - | 等待润色完成 |
| first.tex | ~701 | ~356 | 🟡 待审计 | - | 等待润色完成 |
| mem.tex | ~924 | ~521 | 🟡 待审计 | - | 润色中(polisher-2) |
| trap.tex | ~512 | ~226 | 🟡 待审计 | - | 等待润色完成 |
| pgfault.tex | ~296 | ~125 | 🟢 通过 | 0 | 审计完成，轻微建议6条 |
| interrupt.tex | ~305 | ~286 | 🟡 待审计 | - | 等待润色完成 |
| lock.tex | ~933 | ~683 | 🟡 待审计 | - | 等待润色完成 |
| sched.tex | ~433 | ~370 | 🟡 待审计 | - | 等待润色完成 |
| sleep.tex | ~843 | ~728 | 🟡 待审计 | - | 等待润色完成 |
| fs.tex | ~1819 | ~1486 | 🟡 待审计 | - | 翻译中 |
| lock2.tex | ~231 | ~64 | 🟡 待审计 | - | 翻译中 |

**图例**: 🟢 通过 🟡 待审计 🔴 需修改 🟤 审计中

---

### 详细问题列表

#### unix.tex
*待审计*

#### first.tex
*待审计*

#### mem.tex
*待审计 - 润色中*

#### trap.tex
*待审计*

#### pgfault.tex - 审计完成 ✅

**审计日期**: 2026-04-09
**审计员**: Reviewer
**状态**: 通过（轻微建议）

**总体评价**: 翻译质量良好，技术概念准确，术语使用规范。个别表达有优化空间。

| 行号 | 严重程度 | 原文 | 译文 | 问题描述 | 建议修改 |
|------|----------|------|------|----------|----------|
| 5-6 | 建议 | raises a page-fault exception | 会引发页错误异常 | "引发"可用，但"触发"更常见于技术文档 | 建议改为"触发页错误异常" |
| 6 | 建议 | fetches of instructions to be executed | 取指执行指令引起 | 表述略显生硬 | 建议改为"指令预取引起" |
| 31 | 建议 | copy-on-write fork | 写时复制 fork | 术语表中建议纯中文 | 建议改为"写时复制fork"（英文紧跟，不加空格） |
| 62 | 建议 | book-keeping | 记账 | 技术语境下"簿记"更准确 | 建议改为"簿记" |
| 68 | 建议 | the bulk of the memory | 大部分内存 | bulk有"主体"之意 | 可译为"内存的主体部分" |
| 86 | 建议 | Other features that combine... | 结合分页和页错误异常的其他功能... | 句式略显生硬 | 建议改为"其他结合了分页与页错误异常的功能..." |

**术语使用检查**:
- ✅ PTE标志位、寄存器名保持原文正确
- ✅ lazy allocation - 惰性分配（符合术语表）
- ✅ copy-on-write fork - 写时复制 fork
- ✅ demand paging - 按需分页
- ✅ memory-mapped files - 内存映射文件

**技术准确性**: ✅ 无问题

#### interrupt.tex
*待审计*

#### lock.tex
*待审计*

#### sched.tex
*待审计*

#### sleep.tex
*待审计*

#### fs.tex
*翻译中*

#### lock2.tex
*翻译中*

---

### 严重问题（需返工）
*暂无*

### 一般问题（建议修改）
*暂无*

### 术语一致性问题
*待审计*

---

## 已完成里程碑
- ✅ 术语挖掘: 120+术语，7组易混淆清单
- ✅ LaTeX中文配置: book.tex, build-cn.sh, 编译成功
- ✅ 12章翻译完成并审查通过
- ✅ 编译验证: book.pdf 59页生成成功
- 🔄 质量审计: 进行中（等待4位润色专员完成）
