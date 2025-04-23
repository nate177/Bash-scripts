#!/bin/bash

log_file="/var/log/dkms-repair.log"
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
echo "=== DKMS Maintenance Run @ $timestamp ===" >> "$log_file"

# Get installed kernels
kernels=$(ls /lib/modules)

# Get DKMS modules
mapfile -t dkms_entries < <(dkms status)

# Process each DKMS entry
for entry in "${dkms_entries[@]}"; do
  module=$(echo "$entry" | cut -d',' -f1)
  kernel=$(echo "$entry" | cut -d',' -f2 | awk '{$1=$1};1')
  status=$(echo "$entry" | cut -d':' -f2- | awk '{$1=$1};1')

  module_name=$(echo "$module" | cut -d'/' -f1)
  module_ver=$(echo "$module" | cut -d'/' -f2)

  echo ">> Checking $module_name/$module_ver for kernel $kernel" | tee -a "$log_file"

  # Check if this kernel is actually installed
  if [[ ! -d "/lib/modules/$kernel" ]]; then
    echo "   ⚠️ Kernel $kernel is no longer installed. Removing DKMS entry." | tee -a "$log_file"
    sudo dkms remove "$module_name/$module_ver" -k "$kernel" --quiet
    continue
  fi

  # If module is broken or not fully installed
  if [[ "$status" =~ broken ]] || [[ "$status" =~ missing ]]; then
    echo "   🧹 Removing broken module" | tee -a "$log_file"
    sudo dkms remove "$module_name/$module_ver" --all --quiet
    continue
  fi

  echo "   🔁 Forcing reinstall" | tee -a "$log_file"
  sudo dkms install "$module_name/$module_ver" -k "$kernel" --force >> "$log_file" 2>&1
done

echo -e "\n✅ DKMS maintenance completed at $(date)\n" | tee -a "$log_file"
