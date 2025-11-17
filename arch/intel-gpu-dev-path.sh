# This script automatically creates the udev rule at $RULE_PATH to create the symlink for the intel GPU
#
# This is used so we can specify that we want the intel GPU to control the displays instead of the nvidia GPU.
#
# After running this, run `sudo udevadm control --reload && sudo udevadm trigger` to create the symlink in /dev/dri
# You can confirm it worked with `ls -l /dev/dri` and finding `intel-gpu` there.

SYMLINK_NAME="intel-gpu"
RULE_PATH="/etc/udev/rules.d/intel-gpu-dev-path.rules"
INTEL_GPU_ID=$(lspci -d ::03xx | grep 'Intel' | cut -f1 -d' ')
UDEV_RULE="$(cat <<EOF
KERNEL=="card*", \
KERNELS=="0000:$INTEL_GPU_ID", \
SUBSYSTEM=="drm", \
SUBSYSTEMS=="pci", \
SYMLINK+="dri/$SYMLINK_NAME"
EOF
)"

echo "$UDEV_RULE" | sudo tee "$RULE_PATH"
