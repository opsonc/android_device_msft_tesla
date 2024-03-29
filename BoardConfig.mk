#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from mainline-common
include device/linux/mainline-common/BoardConfigCommon.mk

DEVICE_PATH := device/nokia/tesla

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a7

# Display
TARGET_SCREEN_DENSITY := 226

# Kernel
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_CMDLINE := video=efifb
BOARD_KERNEL_CMDLINE += fbcon=map:2
BOARD_KERNEL_CMDLINE += androidboot.hardware=mainline
BOARD_KERNEL_CMDLINE += loop.max_part=7
# eMMC
BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/f9824900.sdhci
# SDCard
#BOARD_KERNEL_CMDLINE += androidboot.boot_devices=soc/f98a4900.sdhci
BOARD_KERNEL_CMDLINE += androidboot.init_fatal_reboot_target=recovery
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_INCLUDE_DTB_IN_BOOTIMG := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true
TARGET_KERNEL_SOURCE := kernel/nokia/tesla
TARGET_KERNEL_CONFIG := gki_defconfig vendor/nokia/tesla_gki.config

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 134217728
BOARD_CACHEIMAGE_PARTITION_SIZE := 402653184
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5209325568

SSI_PARTITIONS := product system system_ext
TREBLE_PARTITIONS := odm vendor
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions - dynamic
BOARD_SUPER_PARTITION_SIZE := 9126805504 # 8.5GiB
BOARD_SUPER_PARTITION_GROUPS := nokia_dynamic_partitions
BOARD_NOKIA_DYNAMIC_PARTITIONS_PARTITION_LIST := $(ALL_PARTITIONS)
BOARD_NOKIA_DYNAMIC_PARTITIONS_SIZE := 9122611200 # (BOARD_SUPER_PARTITION_SIZE - 4MiB)

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.mainline
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888