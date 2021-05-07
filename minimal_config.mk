#
#  Copyright (c) 2018, The Linux Foundation. All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are
#  met:
#       * Redistributions of source code must retain the above copyright
#         notice, this list of conditions and the following disclaimer.
#       * Redistributions in binary form must reproduce the above
#         copyright notice, this list of conditions and the following
#         disclaimer in the documentation and/or other materials provided
#         with the distribution.
#       * Neither the name of The Linux Foundation nor the names of its
#         contributors may be used to endorse or promote products derived
#         from this software without specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
#  ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
#  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
#  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
#  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
#  IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Minimal configuration definition for basic boot to shell

#INIT
INIT := init.qcom.rc
INIT += init.qcom.early_boot.sh
INIT += init.qcom.post_boot.sh
INIT := init.qcom.sh
INIT += init.target.rc
INIT += fstab.qcom
INIT += init.qcom.usb.rc
INIT += ueventd.qcom.rc
INIT += init.target.vendor.rc
INIT += init.veth_ipa_config.sh
PRODUCT_PACKAGES += $(INIT)

PRODUCT_COPY_FILES += \
    device/xiaomi/cepheus/rootdir/etc/fstab.qcom:$(TARGET_COPY_OUT_RAMDISK)/fstab.qcom

PRODUCT_COPY_FILES += \
    device/xiaomi/cepheus/rootdir/etc/init.recovery.qcom.rc:recovery/root/init.recovery.qcom.rc \
    device/xiaomi/cepheus/rootdir/bin/init.recovery.qcom.sh:recovery/root/init.recovery.qcom.sh

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/device/overlay \
    $(LOCAL_PATH)/product/overlay \
    $(LOCAL_PATH)/overlay \
    $(LOCAL_PATH)/overlay-404

# Properties
TARGET_SYSTEM_PROP += device/xiaomi/cepheus/system.prop
TARGET_VENDOR_PROP += device/xiaomi/cepheus/vendor.prop
