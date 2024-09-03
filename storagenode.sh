#!/bin/bash

# Dừng dịch vụ zgs
sudo systemctl stop zgs

# Cập nhật danh sách gói và cài đặt các gói cần thiết
sudo apt-get update
sudo apt-get install -y openssl libssl-dev pkg-config

# Sao lưu tệp cấu hình hiện tại
mv $HOME/0g-storage-node/run/config-testnet-turbo.toml $HOME/config-testnet-turbo_backup.toml

# Điều hướng đến thư mục 0g-storage-node
cd $HOME/0g-storage-node

# Tải về tất cả các thay đổi và thẻ từ git
git fetch --all --tags

# Chuyển sang nhánh hoặc thẻ v0.4.6
git checkout v0.4.6

# Cập nhật và khởi tạo các submodules
git submodule update --init

# Biên dịch mã nguồn với cargo
cargo build --release

# Khôi phục tệp cấu hình
mv $HOME/config-testnet-turbo_backup.toml $HOME/0g-storage-node/run/config-testnet-turbo.toml

# Khởi động lại dịch vụ zgs
sudo systemctl restart zgs
