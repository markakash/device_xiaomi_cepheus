# Inherit proprietary targets
$(call inherit-product-if-exists, vendor/xiaomi/cepheus/cepheus-vendor.mk)

# By default this target is new-launch config, so set the default shipping level to 29 (if not set explictly earlier)
SHIPPING_API_LEVEL := 28

BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flag 2
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Enable AVB 2.0
BOARD_AVB_ENABLE := true

TARGET_DEFINES_DALVIK_HEAP := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

#Inherit all except heap growth limit from phone-xhdpi-2048-dalvik-heap.mk
PRODUCT_PROPERTY_OVERRIDES  += \
	dalvik.vm.heapstartsize=8m \
	dalvik.vm.heapsize=512m \
	dalvik.vm.heaptargetutilization=0.75 \
	dalvik.vm.heapminfree=512k \
	dalvik.vm.heapmaxfree=8m

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    aaudio.hw_burst_min_usec=2000 \
    aaudio.mmap_exclusive_policy=2 \
    aaudio.mmap_policy=2 \
    af.fast_track_multiplier=1 \
    audio.deep_buffer.media=true \
    audio.offload.video=true \
    persist.vendor.audio.fluence.speaker=true \
    persist.vendor.audio.fluence.tmic.enabled=false \
    persist.vendor.audio.fluence.voicecall=true \
    persist.vendor.audio.fluence.voicecomm=true \
    persist.vendor.audio.fluence.voicerec=true \
    persist.vendor.audio.ras.enabled=false \
    persist.vendor.audio.voicecall.speaker.stereo=true \
    persist.vendor.audio_hal.dsp_bit_width_enforce_mode=24 \
    ro.af.client_heap_size_kbyte=7168 \
    ro.config.vc_call_vol_steps=7 \
    ro.config.media_vol_steps=25 \
    ro.vendor.audio.sdk.fluencetype=fluence \
    ro.vendor.audio.sdk.ssr=false \
    ro.vendor.audio.sfx.earadj=true \
    ro.vendor.audio.soundfx.type=mi \
    ro.vendor.audio.soundfx.usb=true \
    ro.vendor.audio.soundtrigger.cnn.adsp.level=27 \
    ro.vendor.audio.soundtrigger.cnn.level=27 \
    ro.vendor.audio.soundtrigger.gmm.adsp.level=50 \
    ro.vendor.audio.soundtrigger.gmm.level=50 \
    ro.vendor.audio.soundtrigger.gmm.user.adsp.level=10 \
    ro.vendor.audio.soundtrigger.gmm.user.level=10 \
    ro.vendor.audio.soundtrigger.lowpower=true \
    ro.vendor.audio.soundtrigger.training.level=50 \
    ro.vendor.audio.soundtrigger.vop.adsp.level=10 \
    ro.vendor.audio.soundtrigger.vop.level=10 \
    ro.vendor.audio.soundtrigger=sva \
    vendor.audio.adm.buffering.ms=16 \
    vendor.audio.feature.a2dp_offload.enable=true \
    vendor.audio.feature.afe_proxy.enable=true \
    vendor.audio.feature.anc_headset.enable=true \
    vendor.audio.feature.audiozoom.enable=false \
    vendor.audio.feature.battery_listener.enable=true \
    vendor.audio.feature.compr_cap.enable=false \
    vendor.audio.feature.compr_voip.enable=false \
    vendor.audio.feature.compress_in.enable=false \
    vendor.audio.feature.compress_meta_data.enable=true \
    vendor.audio.feature.concurrent_capture.enable=false \
    vendor.audio.feature.custom_stereo.enable=true \
    vendor.audio.feature.deepbuffer_as_primary.enable=false \
    vendor.audio.feature.display_port.enable=true \
    vendor.audio.feature.dsm_feedback.enable=false \
    vendor.audio.feature.dynamic_ecns.enable=false \
    vendor.audio.feature.ext_hw_plugin.enable=true \
    vendor.audio.feature.external_dsp.enable=false \
    vendor.audio.feature.external_speaker.enable=false \
    vendor.audio.feature.external_speaker_tfa.enable=false \
    vendor.audio.feature.fluence.enable=true \
    vendor.audio.feature.fm.enable=true \
    vendor.audio.feature.hdmi_edid.enable=true \
    vendor.audio.feature.hdmi_passthrough.enable=true \
    vendor.audio.feature.hfp.enable=true \
    vendor.audio.feature.hifi_audio.enable=false \
    vendor.audio.feature.hwdep_cal.enable=false \
    vendor.audio.feature.incall_music.enable=true \
    vendor.audio.feature.keep_alive.enable=true \
    vendor.audio.feature.kpi_optimize.enable=true \
    vendor.audio.feature.maxx_audio.enable=false \
    vendor.audio.feature.multi_voice_session.enable=true \
    vendor.audio.feature.ras.enable=true \
    vendor.audio.feature.record_play_concurency.enable=false \
    vendor.audio.feature.snd_mon.enable=false \
    vendor.audio.feature.spkr_prot.enable=true \
    vendor.audio.feature.src_trkn.enable=true \
    vendor.audio.feature.ssrec.enable=false \
    vendor.audio.feature.usb_offload.enable=true \
    vendor.audio.feature.usb_offload_burst_mode.enable=true \
    vendor.audio.feature.usb_offload_sidetone_volume.enable=false \
    vendor.audio.feature.vbat.enable=true \
    vendor.audio.feature.wsa.enable=false \
    vendor.audio.flac.sw.decoder.24bit=true \
    vendor.audio.hal.output.suspend.supported=false \
    vendor.audio.hw.aac.encoder=false \
    vendor.audio.offload.buffer.size.kb=256 \
    vendor.audio.hal.boot.timeout.ms=20000 \
    vendor.audio.offload.gapless.enabled=true \
    vendor.audio.offload.multiaac.enable=true \
    vendor.audio.offload.multiple.enabled=false \
    vendor.audio.offload.passthrough=false \
    vendor.audio.offload.track.enable=false \
    vendor.audio.parser.ip.buffer.size=262144 \
    vendor.audio.safx.pbe.enabled=false \
    vendor.audio.spkr_prot.tx.sampling_rate=48000 \
    vendor.audio.tunnel.encode=false \
    vendor.audio.usb.disable.sidetone=true \
    vendor.audio.use.sw.alac.decoder=true \
    vendor.audio.use.sw.ape.decoder=true \
    vendor.audio.volume.headset.gain.depcal=true \
    vendor.audio_hal.in_period_size=144 \
    vendor.audio_hal.period_multiplier=3 \
    vendor.audio_hal.period_size=192

# RRO configuration
TARGET_USES_RRO := true

TARGET_KERNEL_VERSION := 4.14

#Enable llvm support for kernel
KERNEL_LLVM_SUPPORT := true

#Enable sd-llvm suppport for kernel
KERNEL_SD_LLVM_SUPPORT := true

# Video seccomp policy files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/codec2.software.ext.policy:$(TARGET_COPY_OUT)/etc/seccomp_policy/codec2.software.ext.policy \

PRODUCT_PACKAGES += android.hardware.media.omx@1.0-impl

PRODUCT_PACKAGES += fs_config_files

# Fingerprint feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \

# Ipsec_tunnels feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.ipsec_tunnels.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.ipsec_tunnels.xml \

DEVICE_MANIFEST_FILE := device/xiaomi/cepheus/manifest.xml
DEVICE_MATRIX_FILE   := device/xiaomi/cepheus/compatibility_matrix.xml
DEVICE_FRAMEWORK_MANIFEST_FILE := device/xiaomi/cepheus/framework_manifest.xml

# Display/Graphics
PRODUCT_PACKAGES += \
    android.hardware.broadcastradio@1.0-impl

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += device/xiaomi/cepheus/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Powerhint configuration file
PRODUCT_COPY_FILES += device/xiaomi/cepheus/powerhint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.xml

# Context hub HAL
PRODUCT_PACKAGES += \
    android.hardware.contexthub@1.0-impl.generic \
    android.hardware.contexthub@1.0-service

#vendor prop to enable advanced network scanning
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.radio.enableadvancedscan=true

# system prop for enabling QFS (QTI Fingerprint Solution)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qfp=true

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.midi.xml

# Pro Audio feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml

# USB default HAL
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service

#PASR HAL and APP
PRODUCT_PACKAGES += \
    vendor.qti.power.pasrmanager@1.0-service \
    vendor.qti.power.pasrmanager@1.0-impl \
    pasrservice

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.opengles.aep.xml

PRODUCT_PROPERTY_OVERRIDES += \
ro.crypto.volume.filenames_mode = "aes-256-cts" \
ro.crypto.set_dun = true

# Enable incremental FS feature
PRODUCT_PROPERTY_OVERRIDES += ro.incremental.enable=1

#Enable Light AIDL HAL
PRODUCT_PACKAGES += android.hardware.lights-service.qti

# Target specific Netflix custom property
PRODUCT_PROPERTY_OVERRIDES += \
    ro.netflix.bsp_rev=Q855-16947-1

# Audio
PRODUCT_COPY_FILES += \
    device/xiaomi/cepheus/audio/audio_configs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_configs.xml \
    device/xiaomi/cepheus/audio/audio_configs_stock.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_configs_stock.xml \
    device/xiaomi/cepheus/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    device/xiaomi/cepheus/audio/audio_policy_configuration_a2dp_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_a2dp_offload_disabled.xml \
    device/xiaomi/cepheus/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    device/xiaomi/cepheus/audio/audio_io_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_io_policy.conf \
    device/xiaomi/cepheus/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml

PRODUCT_COPY_FILES += \
    device/xiaomi/cepheus/audio/sound_trigger_mixer_paths_wcd9340.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_mixer_paths_wcd9340.xml \
    device/xiaomi/cepheus/audio/sound_trigger_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/sound_trigger_platform_info.xml \
    device/xiaomi/cepheus/audio/mixer_paths_overlay_dynamic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_dynamic.xml \
    device/xiaomi/cepheus/audio/mixer_paths_overlay_static.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_overlay_static.xml \
    device/xiaomi/cepheus/audio/mixer_paths_tavil.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_tavil.xml

# NFC
PRODUCT_COPY_FILES += \
    device/xiaomi/cepheus/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf \
    device/xiaomi/cepheus/nfc/libnfc-nxp.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nxp.conf
