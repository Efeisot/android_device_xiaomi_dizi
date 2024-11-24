#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm8250-common
# include device/xiaomi/sm8250-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/dizi

# Board
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Display
TARGET_SCREEN_DENSITY := 249

# Kernel - Bakılacak
# TARGET_KERNEL_CONFIG += vendor/xiaomi/elish.config

ifeq ($(TARGET_USE_PREBUILT_KERNEL),true)
TARGET_NO_KERNEL_OVERRIDE := true

DIZI_PREBUILT := device/xiaomi/dizi-prebuilt

PRODUCT_COPY_FILES += \
    $(DIZI_PREBUILT)/Image:kernel \
    $(DIZI_PREBUILT)/dtb.img:dtb.img

BOARD_PREBUILT_DTBOIMAGE := $(DIZI_PREBUILT)/dtbo.img

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DIZI_PREBUILT)/modules/modules.load))
BOARD_VENDOR_KERNEL_MODULES += $(wildcard $(DIZI_PREBUILT)/modules/*.ko)
endif

# OTA assert
TARGET_OTA_ASSERT_DEVICE := dizi

# Power
TARGET_POWER_LIBPERFMGR_MODE_EXTENSION_LIB := //$(DEVICE_PATH):libperfmgr-ext-xiaomi

# Properties
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Sepolicy
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
SYSTEM_EXT_PUBLIC_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/public
BOARD_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Manifest
DEVICE_MANIFEST_FILE := $(COMMON_PATH)/manifest.xml

# VINTF
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    $(DEVICE_PATH)/interfaces/peripherals/1.0/default/device_framework_matrix.xml

# Inherit from the proprietary version - Bakılacak
# include vendor/xiaomi/dizi/BoardConfigVendor.mk
