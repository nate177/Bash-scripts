#!/bin/bash

# Get all installed kernels
kernels=$(ls /lib/modules)

echo "Installed kernels:"
echo "$kernels"
echo

# Get DKMS module list
mapfile -t dkms_modules < <(dkms status | cut -d',' -f1 | uniq)

# Process each module
for mod in "${dkms_modules[@]}"; do
  module_name=$(echo "$mod" | cut -d'/' -f1)
  module_ver=$(echo "$mod" | cut -d'/' -f2)

  echo "=== Checking $module_name/$module_ver ==="

  for kernel in $kernels; do
    echo "-> For kernel $kernel:"
    dkms status -m "$module_name" -v "$module_ver" | grep -q "$kernel"

    if [ $? -eq 0 ]; then
      echo "   🔁 Reinstalling with --force"
      sudo dkms install "$module_name/$module_ver" -k "$kernel" --force
    else
      echo "   ✅ Already clean or not required"
    fi
  done

  echo
done

echo "✅ DKMS repair process complete!"
