# config.mk
#
# Product-specific compile-time definitions.
#

#Generate DTBO image
BOARD_KERNEL_SEPARATED_DTBO := true

BOARD_SYSTEMSDK_VERSIONS:=$(SHIPPING_API_LEVEL)

TARGET_BOARD_PLATFORM := msmnile
TARGET_BOOTLOADER_BOARD_NAME := msmnile

BOARD_USES_QCOM_HARDWARE := true

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := kryo385

TARGET_HW_DISK_ENCRYPTION := true
TARGET_HW_DISK_ENCRYPTION_PERF := true

BOARD_SECCOMP_POLICY := device/qcom/$(TARGET_BOARD_PLATFORM)/seccomp

TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true
TARGET_NO_KERNEL := false

-include $(QCPATH)/common/msmnile/BoardConfigVendor.mk

USE_OPENGL_RENDERER := true

# Partitions (Boot)
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

# Partitions (Cache)
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456

# Partitions (DTBO)
BOARD_DTBOIMG_PARTITION_SIZE := 33554432

# Partitions (Metadata)
BOARD_USES_METADATA_PARTITION := true

# Partition (Recovery)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864

# Partition (System)
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

# Partition (Userdata)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 57453555712
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Partition (Vendor)
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
ifeq ($(TARGET_BUILD_VARIANT),user)
     KERNEL_DEFCONFIG := $(shell ls ./kernel/msm-4.14/arch/arm64/configs/vendor/ | grep sm8...-perf_defconfig)
endif

ifeq ($(KERNEL_DEFCONFIG),)
     KERNEL_DEFCONFIG := $(shell ls ./kernel/msm-4.14/arch/arm64/configs/vendor/ | grep sm8..._defconfig)
endif

BOARD_VENDOR_KERNEL_MODULES := \
    $(KERNEL_MODULES_OUT)/audio_apr.ko \
    $(KERNEL_MODULES_OUT)/audio_wglink.ko \
    $(KERNEL_MODULES_OUT)/audio_q6_pdr.ko \
    $(KERNEL_MODULES_OUT)/audio_q6_notifier.ko \
    $(KERNEL_MODULES_OUT)/audio_adsp_loader.ko \
    $(KERNEL_MODULES_OUT)/audio_q6.ko \
    $(KERNEL_MODULES_OUT)/audio_usf.ko \
    $(KERNEL_MODULES_OUT)/audio_pinctrl_wcd.ko \
    $(KERNEL_MODULES_OUT)/audio_swr.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd_core.ko \
    $(KERNEL_MODULES_OUT)/audio_swr_ctrl.ko \
    $(KERNEL_MODULES_OUT)/audio_wsa881x.ko \
    $(KERNEL_MODULES_OUT)/audio_platform.ko \
    $(KERNEL_MODULES_OUT)/audio_hdmi.ko \
    $(KERNEL_MODULES_OUT)/audio_stub.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd9xxx.ko \
    $(KERNEL_MODULES_OUT)/audio_mbhc.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd934x.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd9360.ko \
    $(KERNEL_MODULES_OUT)/audio_wcd_spi.ko \
    $(KERNEL_MODULES_OUT)/audio_native.ko \
    $(KERNEL_MODULES_OUT)/audio_machine_msmnile.ko \
    $(KERNEL_MODULES_OUT)/wil6210.ko \
    $(KERNEL_MODULES_OUT)/msm_11ad_proxy.ko \
    $(KERNEL_MODULES_OUT)/mpq-adapter.ko \
    $(KERNEL_MODULES_OUT)/mpq-dmx-hw-plugin.ko \
    $(KERNEL_MODULES_OUT)/tspp.ko \

# install lkdtm only for userdebug and eng build variants
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    ifeq (,$(findstring perf_defconfig, $(KERNEL_DEFCONFIG)))
        BOARD_VENDOR_KERNEL_MODULES += $(KERNEL_MODULES_OUT)/lkdtm.ko
    endif
endif

BOARD_DO_NOT_STRIP_VENDOR_MODULES := true
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_QCOM_BSP := false
BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0xa90000 androidboot.hardware=qcom androidboot.console=ttyMSM0 service_locator.enable=1 firmware_class.path=/vendor/firmware_mnt/image loop.max_part=16 androidboot.usbcontroller=a600000.dwc3
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_EGL_CFG := device/qcom/$(TARGET_BOARD_PLATFORM)/egl.cfg

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := $(shell pwd)/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-androidkernel-
TARGET_KERNEL_CLANG_COMPILE := true
TARGET_KERNEL_SOURCE := kernel/xiaomi/sm8150
TARGET_USES_UNCOMPRESSED_KERNEL := false

MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024

#File system for ODM
TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_PLATFORM_DEVICE_BASE := /devices/soc.0/
TARGET_INIT_VENDOR_LIB := libinit_msm

TARGET_COMPILE_WITH_MSM_KERNEL := true

#Audio policy
USE_XML_AUDIO_POLICY_CONF := 1

# Audio features
AUDIO_FEATURE_ENABLED_A2DP_OFFLOAD := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/xiaomi/cepheus/bluetooth/include

# Camera
TARGET_USES_QTI_CAMERA_DEVICE := true
USE_DEVICE_SPECIFIC_CAMERA := true

#Enable PD locater/notifier
TARGET_PD_SERVICE_ENABLED := true

#Enable peripheral manager
TARGET_PER_MGR_ENABLED := true

# Enable dex pre-opt to speed up initial boot
ifeq ($(HOST_OS),linux)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_PIC := true
      ifneq ($(TARGET_BUILD_VARIANT),user)
        # Retain classes.dex in APK's for non-user builds
        DEX_PREOPT_DEFAULT := nostripping
      endif
    endif
endif

TARGET_USES_GRALLOC1 := true

# Enable sensor multi HAL
USE_SENSOR_MULTI_HAL := true

#Add non-hlos files to ota packages
ADD_RADIO_FILES := true

#Enable INTERACTION_BOOST
TARGET_USES_INTERACTION_BOOST := true

#Enable DRM plugins 64 bit compilation
TARGET_ENABLE_MEDIADRM_64 := true

#----------------------------------------------------------------------
# wlan specific
#----------------------------------------------------------------------
ifeq ($(strip $(BOARD_HAS_QCOM_WLAN)),true)
include device/qcom/wlan/msmnile/BoardConfigWlan.mk
endif

ifeq ($(ENABLE_VENDOR_IMAGE), false)
  $(error "Vendor Image is mandatory !!")
endif

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_PREBUILT_ELF_FILES := true

BUILD_BROKEN_NINJA_USES_ENV_VARS := SDCLANG_AE_CONFIG SDCLANG_CONFIG SDCLANG_SA_ENABLED SDCLANG_CONFIG_AOSP
BUILD_BROKEN_NINJA_USES_ENV_VARS += TEMPORARY_DISABLE_PATH_RESTRICTIONS
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN
BUILD_BROKEN_PREBUILT_ELF_FILES := true
BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

#Enable VNDK Compliance
BOARD_VNDK_VERSION:=current
Q_BU_DISABLE_MODULE := true


#################################################################################
# This is the End of BoardConfig.mk file.
# Now, Pickup other split Board.mk files:
#################################################################################
# TODO: Relocate the system Board.mk files pickup into qssi lunch, once it is up.
-include vendor/qcom/defs/board-defs/system/*.mk
-include vendor/qcom/defs/board-defs/vendor/*.mk
#################################################################################

include device/qcom/sepolicy_vndr/SEPolicy.mk
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += device/xiaomi/cepheus/sepolicy/private
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += device/xiaomi/cepheus/sepolicy/public
BOARD_SEPOLICY_DIRS += device/xiaomi/cepheus/sepolicy/vendor
