#!/bin/bash

# Get absolute path of this script
SCRIPT_ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source and destination files
cp_files_from=(
  "${SCRIPT_ABSOLUTE_PATH}/manual_fixes/riscv_cs_registers.sv"
  "${SCRIPT_ABSOLUTE_PATH}/manual_fixes/riscv_decoder.sv"
)

cp_files_to=(
  "${SCRIPT_ABSOLUTE_PATH}/ips/riscv/riscv_cs_registers.sv"
  "${SCRIPT_ABSOLUTE_PATH}/ips/riscv/riscv_decoder.sv"
)

# Loop through files
for i in "${!cp_files_from[@]}"; do
  src="${cp_files_from[$i]}"
  dst="${cp_files_to[$i]}"
  dst_dir="$(dirname "$dst")"

  # Check if source file exists
  if [[ ! -f "$src" ]]; then
    echo "Error: Source file does not exist: $src"
    continue
  fi

  # Check if destination directory exists
  if [[ ! -d "$dst_dir" ]]; then
    echo "Error: Destination directory does not exist: $dst_dir"
    continue
  fi

  # Copy file (overwrite if exists)
  cp -f "$src" "$dst"

  if [[ $? -eq 0 ]]; then
    echo "Copied: $src -> $dst"
  else
    echo "Failed to copy: $src -> $dst"
  fi
done
