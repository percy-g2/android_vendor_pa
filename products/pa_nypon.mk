# Copyright (C) 2014 ParanoidAndroid Project
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

# Check for target product

ifeq (pa_nypon,$(TARGET_PRODUCT))

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

PREFS_FROM_SOURCE ?= false

# Inherit telephony common stuff
$(call inherit-product, vendor/pa/configs/telephony.mk)

# Include AOSPA common configuration
include vendor/pa/main.mk

# Inherit device configuration
$(call inherit-product, device/sony/nypon/full_nypon.mk)

# Override AOSP build properties
PRODUCT_NAME := pa_nypon
PRODUCT_DEVICE := nypon
PRODUCT_BRAND := sony
PRODUCT_MANUFACTURER := sony
PRODUCT_MODEL := Xperia P
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=LT22i_1257-4009 BUILD_FINGERPRINT=SEMC/LT22i_1257-4009/LT22i:4.4/6.1.A.0.452/O_5_zw:user/release-keys PRIVATE_BUILD_DESC="LT22i-user 4.4 6.1.A.0.452 O_5_zw test-keys"

endif
