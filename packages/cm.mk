# Required CM packages
#PRODUCT_PACKAGES += \
#    Focal \
#    Development \
#    LatinIME \
#    Superuser \
#    su

# Wallpaper in prbuilt
PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/apk/BasicDreams.apk:system/app/BasicDreams.apk \
        vendor/pa/prebuilt/common/apk/Galaxy4.apk:system/app/Galaxy4.apk \
        vendor/pa/prebuilt/common/apk/HoloSpiralWallpaper.apk:system/app/HoloSpiralWallpaper.apk \
        vendor/pa/prebuilt/common/apk/LiveWallpapers.apk:system/app/LiveWallpapers.apk \
        vendor/pa/prebuilt/common/apk/PhaseBeam.apk:system/app/PhaseBeam.apk

# RemixPA addons
PRODUCT_PACKAGES += \
    HALO \
    Trebuchet \
    CMFileManager \
    DSPManager

# Extra tools in CM
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs \
    bash \
    vim \
    nano \
    htop \
    powertop \
    lsof \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync
