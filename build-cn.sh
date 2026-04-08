#!/bin/bash
# xv6-book 中文编译脚本

set -e

echo "=== xv6-book 中文 LaTeX 编译脚本 ==="

# 检查 xelatex 是否安装
if ! command -v xelatex &> /dev/null; then
echo "错误: xelatex 未安装。请先安装 TeX Live 或 MiKTeX。"
    exit 1
fi

# 检查所需中文字体
echo ""
echo "检查中文字体..."

check_font() {
    fc-list : family | grep -i "$1" > /dev/null && echo "  ✓ $1" || echo "  ✗ $1 (未找到)"
}

echo "必需字体:"
check_font "FZShuSong"
check_font "FZHei"
check_font "FZKai"
check_font "FZLanTingHei"

echo ""
echo "备用系统字体:"
check_font "Noto Serif CJK"
check_font "Source Han Serif"
check_font "WenQuanYi"

# 准备构建目录
echo ""
echo "准备构建..."
mkdir -p latex.out

# 检查源文件
if [ ! -d "xv6-riscv-src" ]; then
    echo "获取 xv6-riscv 源代码..."
    git clone git@github.com:mit-pdos/xv6-riscv.git xv6-riscv-src || true
fi

# 运行 lineref 处理
echo ""
echo "处理源代码引用..."
for f in *.tex; do
    if [ "$f" != "book.tex" ] && [ -f "$f" ]; then
        ./lineref "$f" xv6-riscv-src/ xv6-riscv-src-booklet/fmt > "latex.out/$f" 2>/dev/null || true
    fi
done

# 编译
echo ""
echo "开始编译 (xelatex)..."

# 第一次编译
xelatex -interaction=nonstopmode book.tex || {
    echo "警告: 第一次编译可能有错误，继续..."
}

# 处理参考文献
if [ -f "book.aux" ]; then
    echo "处理参考文献..."
    bibtex book 2>/dev/null || true
fi

# 处理索引
if [ -f "book.idx" ]; then
    echo "处理索引..."
    makeindex book 2>/dev/null || true
fi

# 第二次编译
xelatex -interaction=nonstopmode book.tex || true

# 第三次编译（确保交叉引用正确）
xelatex -interaction=nonstopmode book.tex || true

# 检查结果
if [ -f "book.pdf" ]; then
    echo ""
    echo "=== 编译成功 ==="
    echo "输出文件: book.pdf"
    ls -lh book.pdf
else
    echo ""
    echo "=== 编译可能失败 ==="
    echo "请检查上述错误信息"
    exit 1
fi
