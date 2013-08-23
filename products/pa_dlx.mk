# Copyright (C) 2012 ParanoidAndroid Project
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

# Inherit AOSP device configuration for dlx.
$(call inherit-product, device/htc/dlx/full_dlx.mk)

# Inherit CDMA common stuff.
$(call inherit-product, vendor/pa/config/cdma.mk)

# Inherit common Verizon Wireless Perms and Lib
# $(call inherit-product, vendor/pa/config/vzw.mk)

# Inherit RemixPA common bits
$(call inherit-product, vendor/pa/config/pa_common.mk)

# DLX Overlays
PRODUCT_PACKAGE_OVERLAYS += device/htc/dlx/overlay

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# PA OVERLAY_TARGET
OVERLAY_TARGET := pa_xxhdpi

# Build paprefs from sources
PREFS_FROM_SOURCE ?= true

# Include CM extras
EXTRA_CM_PACKAGES ?= true

# Release name
PRODUCT_RELEASE_NAME := HTC-DNA

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := dlx
PRODUCT_NAME := pa_dlx
PRODUCT_BRAND := htc
PRODUCT_MODEL := HTC6435LVW
PRODUCT_MANUFACTURER := HTC
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_dlx BUILD_FINGERPRINT=verizon_wwe/dlx/dlx:4.1.1/JRO03C/147796.1:user/release-keys PRIVATE_BUILD_DESC="2.06.605.1 CL147796 release-keys" BUILD_NUMBER=123160

# Copy Bootanimation
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bootanimation/XHDPI.zip:system/media/bootanimation.zip

# Include ParanoidAndroid repos configuration
include vendor/pa/config/pa_addons.mk

