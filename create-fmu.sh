#!/bin/bash
set -e

IDF_FILE=$1
OUTPUT_DIR=${2:-/output}

if [ -z "$IDF_FILE" ]; then
  echo "用法: create-fmu.sh <idf文件> [输出目录]"
  exit 1
fi

# 检查并安装必要的编译工具
if ! command -v g++ &> /dev/null; then
  echo "正在安装 C++ 编译工具..."
  apt-get update && apt-get install -y build-essential
fi

cd $OUTPUT_DIR
echo "工作目录: $(pwd)"

# 查找 EnergyPlusToFMU.py 脚本
SCRIPT_PATH=$(find /usr/local/EnergyPlusToFMU -name "EnergyPlusToFMU.py" | head -1)
if [ -z "$SCRIPT_PATH" ]; then
  echo "错误: 找不到 EnergyPlusToFMU.py!"
  exit 1
fi
echo "找到 EnergyPlusToFMU.py: $SCRIPT_PATH"

# 查找 IDD 文件
IDD_PATH=$(find / -name "Energy+.idd" | head -1)
if [ -z "$IDD_PATH" ]; then
  echo "错误: 找不到 Energy+.idd 文件!"
  exit 1
fi
echo "找到 IDD 文件: $IDD_PATH"

# 执行命令 - 修正参数顺序，将 IDF 文件作为最后一个位置参数
CMD="python3 $SCRIPT_PATH -i $IDD_PATH -a 2 $IDF_FILE"
echo "执行: $CMD"
eval $CMD