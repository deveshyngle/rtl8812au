EXTRA_CFLAGS += $(USER_EXTRA_CFLAGS)
EXTRA_CFLAGS += -O1
#EXTRA_CFLAGS += -O3
#EXTRA_CFLAGS += -Wall
#EXTRA_CFLAGS += -Wextra
#EXTRA_CFLAGS += -Werror
#EXTRA_CFLAGS += -pedantic
#EXTRA_CFLAGS += -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes

EXTRA_CFLAGS += -Wno-unused-variable
EXTRA_CFLAGS += -Wno-unused-value
EXTRA_CFLAGS += -Wno-unused-label
EXTRA_CFLAGS += -Wno-unused-parameter
EXTRA_CFLAGS += -Wno-unused-function
EXTRA_CFLAGS += -Wno-unused

EXTRA_CFLAGS += -Wno-uninitialized
EXTRA_CFLAGS += -Wno-int-to-pointer-cast

EXTRA_CFLAGS += -I$(src)/include

CONFIG_AUTOCFG_CP = n

CONFIG_MULTIDRV = n
CONFIG_RTL8192C = n
CONFIG_RTL8192D = n
CONFIG_RTL8723A = n
CONFIG_RTL8188E = n
CONFIG_RTL8812A = y
CONFIG_RTL8821A = y
CONFIG_RTL8192E = n
CONFIG_RTL8723B = n

CONFIG_USB_HCI = y
CONFIG_PCI_HCI = n
CONFIG_SDIO_HCI = n
CONFIG_GSPI_HCI = n

CONFIG_MP_INCLUDED = y
CONFIG_POWER_SAVING = y
CONFIG_USB_AUTOSUSPEND = n
CONFIG_HW_PWRP_DETECTION = n
CONFIG_WIFI_TEST = n
CONFIG_BT_COEXIST = n
CONFIG_RTL8192CU_REDEFINE_1X1 = n
CONFIG_INTEL_WIDI = n
CONFIG_WAPI_SUPPORT = n
CONFIG_EFUSE_CONFIG_FILE = n
CONFIG_EXT_CLK = n
CONFIG_FTP_PROTECT = n
CONFIG_WOWLAN = n

CONFIG_DRVEXT_MODULE = n

export TopDIR ?= $(shell pwd)

########### COMMON  #################################
ifeq ($(CONFIG_GSPI_HCI), y)
HCI_NAME = gspi
endif

ifeq ($(CONFIG_SDIO_HCI), y)
HCI_NAME = sdio
endif

ifeq ($(CONFIG_USB_HCI), y)
HCI_NAME = usb
endif

ifeq ($(CONFIG_PCI_HCI), y)
HCI_NAME = pci
endif


_OS_INTFS_FILES :=	os_dep/osdep_service.o \
			os_dep/os_intfs.o \
			os_dep/$(HCI_NAME)_intf.o \
			os_dep/$(HCI_NAME)_ops_linux.o \
			os_dep/ioctl_linux.o \
			os_dep/xmit_linux.o \
			os_dep/mlme_linux.o \
			os_dep/recv_linux.o \
			os_dep/ioctl_cfg80211.o \
			os_dep/rtw_android.o

ifeq ($(CONFIG_SDIO_HCI), y)
_OS_INTFS_FILES += os_dep/custom_gpio_linux.o
_OS_INTFS_FILES += os_dep/$(HCI_NAME)_ops_linux.o
endif

ifeq ($(CONFIG_GSPI_HCI), y)
_OS_INTFS_FILES += os_dep/custom_gpio_linux.o
_OS_INTFS_FILES += os_dep/$(HCI_NAME)_ops_linux.o
endif


_HAL_INTFS_FILES :=	hal/hal_intf.o \
			hal/hal_com.o \
			hal/hal_com_phycfg.o \
			hal/hal_phy.o \
			hal/hal_$(HCI_NAME)_led.o

_OUTSRC_FILES := hal/odm_debug.o	\
		hal/odm_interface.o\
		hal/odm_HWConfig.o\
		hal/odm.o\
		hal/HalPhyRf.o

		
########### HAL_RTL8192C #################################										

ifeq ($(CONFIG_RTL8192C), y)
RTL871X = rtl8192c
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8192cu
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8192ce
endif
EXTRA_CFLAGS += -DCONFIG_RTL8192C

_HAL_INTFS_FILES += \
	hal/$(RTL871X)_sreset.o \
	hal/$(RTL871X)_xmit.o

_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o	

_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o


ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif

_OUTSRC_FILES += hal/odm_RTL8192C.o\
								hal/HalDMOutSrc8192C_CE.o

ifeq ($(CONFIG_USB_HCI), y)
_OUTSRC_FILES += hal/Hal8192CUFWImg_CE.o	\
								hal/Hal8192CUPHYImg_CE.o	\
								hal/Hal8192CUMACImg_CE.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
_OUTSRC_FILES += hal/Hal8192CEFWImg_CE.o	\
								hal/Hal8192CEPHYImg_CE.o	\
								hal/Hal8192CEMACImg_CE.o
endif

endif

########### HAL_RTL8192D #################################
ifeq ($(CONFIG_RTL8192D), y)
RTL871X = rtl8192d
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8192du
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8192de
endif
EXTRA_CFLAGS += -DCONFIG_RTL8192D

_HAL_INTFS_FILES += \
	hal/$(RTL871X)_xmit.o

_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o

_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif

_OUTSRC_FILES += hal/odm_RTL8192D.o\
								hal/HalDMOutSrc8192D_CE.o

								
ifeq ($(CONFIG_USB_HCI), y)
_OUTSRC_FILES += hal/Hal8192DUFWImg_CE.o \
								hal/Hal8192DUPHYImg_CE.o \
								hal/Hal8192DUMACImg_CE.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
_OUTSRC_FILES += hal/Hal8192DEFWImg_CE.o \
								hal/Hal8192DEPHYImg_CE.o \
								hal/Hal8192DEMACImg_CE.o
endif

endif

########### HAL_RTL8723A #################################
ifeq ($(CONFIG_RTL8723A), y)

RTL871X = rtl8723a
ifeq ($(CONFIG_GSPI_HCI), y)
MODULE_NAME = 8723as
endif
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8723as
endif
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8723au
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8723ae
endif
EXTRA_CFLAGS += -DCONFIG_RTL8723A

_HAL_INTFS_FILES += hal/HalPwrSeqCmd.o \
				hal/Hal8723PwrSeq.o\
				hal/$(RTL871X)_xmit.o \
				hal/$(RTL871X)_sreset.o
				
_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o
			
ifeq ($(CONFIG_SDIO_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
ifeq ($(CONFIG_GSPI_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif

ifeq ($(CONFIG_BT_COEXIST), y)
_HAL_INTFS_FILES +=  hal/rtl8723a_bt-coexist.o
endif

ifeq ($(CONFIG_GSPI_HCI), y)
_OUTSRC_FILES += hal/Hal8723SHWImg_CE.o
endif

ifeq ($(CONFIG_SDIO_HCI), y)
_OUTSRC_FILES += hal/Hal8723SHWImg_CE.o
endif

ifeq ($(CONFIG_USB_HCI), y)
_OUTSRC_FILES += hal/Hal8723UHWImg_CE.o
endif

ifeq ($(CONFIG_PCI_HCI), y)
_OUTSRC_FILES += hal/Hal8723EHWImg_CE.o
endif

#hal/HalHWImg8723A_FW.o
_OUTSRC_FILES += hal/HalHWImg8723A_BB.o\
								hal/HalHWImg8723A_MAC.o\
								hal/HalHWImg8723A_RF.o\
								hal/odm_RegConfig8723A.o

_OUTSRC_FILES += hal/rtl8192c/HalDMOutSrc8192C_CE.o


endif


########### HAL_RTL8188E #################################
ifeq ($(CONFIG_RTL8188E), y)

RTL871X = rtl8188e
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8189es
endif

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8188eu
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8188ee
endif
EXTRA_CFLAGS += -DCONFIG_RTL8188E

_HAL_INTFS_FILES +=	hal/HalPwrSeqCmd.o \
					hal/Hal8188EPwrSeq.o\
 					hal/$(RTL871X)_xmit.o\
					hal/$(RTL871X)_sreset.o

_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o

ifeq ($(CONFIG_SDIO_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
ifeq ($(CONFIG_GSPI_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif			

#hal/Hal8188EFWImg_CE.o
_OUTSRC_FILES += hal/HalHWImg8188E_MAC.o\
		hal/HalHWImg8188E_BB.o\
		hal/HalHWImg8188E_RF.o\
		hal/HalHWImg8188E_FW.o\
		hal/HalPhyRf_8188e.o\
		hal/odm_RegConfig8188E.o\
		hal/Hal8188ERateAdaptive.o\
		hal/odm_RTL8188E.o

endif

########### HAL_RTL8192E #################################
ifeq ($(CONFIG_RTL8192E), y)

RTL871X = rtl8192e
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8192es
endif

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8192eu
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8192ee
endif
EXTRA_CFLAGS += -DCONFIG_RTL8192E
_HAL_INTFS_FILES += hal/HalPwrSeqCmd.o \
					hal/Hal8192EPwrSeq.o\
					hal/$(RTL871X)_xmit.o\
					hal/$(RTL871X)_sreset.o

_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o

ifeq ($(CONFIG_SDIO_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
ifeq ($(CONFIG_GSPI_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif

#hal/HalHWImg8188E_FW.o
_OUTSRC_FILES += hal/HalHWImg8192E_MAC.o\
		hal/HalHWImg8192E_BB.o\
		hal/HalHWImg8192E_RF.o\
		hal/HalHWImg8192E_FW.o\
		hal/HalPhyRf_8192e.o\
		hal/odm_RegConfig8192E.o\
		hal/odm_RTL8192E.o

endif

########### HAL_RTL8812A_RTL8821A #################################

ifneq ($(CONFIG_RTL8812A)_$(CONFIG_RTL8821A), n_n)

RTL871X = rtl8812a
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME = 8812au
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME = 8812ae
endif
ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME = 8812as
endif

_HAL_INTFS_FILES +=  hal/HalPwrSeqCmd.o \
					hal/Hal8812PwrSeq.o \
					hal/Hal8821APwrSeq.o\
					hal/$(RTL871X)_xmit.o\
					hal/$(RTL871X)_sreset.o

_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o

ifeq ($(CONFIG_SDIO_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
ifeq ($(CONFIG_GSPI_HCI), y)
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o
else
_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops_linux.o
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif

ifeq ($(CONFIG_RTL8812A), y)
EXTRA_CFLAGS += -DCONFIG_RTL8812A
_OUTSRC_FILES += hal/HalHWImg8812A_FW.o\
		hal/HalHWImg8812A_MAC.o\
		hal/HalHWImg8812A_BB.o\
		hal/HalHWImg8812A_RF.o\
		hal/HalHWImg8812A_TestChip_FW.o\
		hal/HalHWImg8812A_TestChip_MAC.o\
		hal/HalHWImg8812A_TestChip_BB.o\
		hal/HalHWImg8812A_TestChip_RF.o\
		hal/HalPhyRf_8812A.o\
		hal/odm_RegConfig8812A.o
endif

ifeq ($(CONFIG_RTL8821A), y)

ifeq ($(CONFIG_RTL8812A), n)
ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME := 8821au
endif
ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME := 8821ae
endif
endif

ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME := 8821as
endif

EXTRA_CFLAGS += -DCONFIG_RTL8821A
_OUTSRC_FILES += hal/HalHWImg8821A_FW.o\
		hal/HalHWImg8821A_MAC.o\
		hal/HalHWImg8821A_BB.o\
		hal/HalHWImg8821A_RF.o\
		hal/HalHWImg8821A_TestChip_MAC.o\
		hal/HalHWImg8821A_TestChip_BB.o\
		hal/HalHWImg8821A_TestChip_RF.o\
		hal/HalPhyRf_8812A.o\
		hal/HalPhyRf_8821A.o\
		hal/odm_RegConfig8821A.o		
endif	


endif

########### HAL_RTL8723B #################################
ifeq ($(CONFIG_RTL8723B), y)

RTL871X = rtl8723b
MODULE_NAME = 8723bs
EXTRA_CFLAGS += -DCONFIG_RTL8723B

_HAL_INTFS_FILES += hal/HalPwrSeqCmd.o \
					hal/Hal8723BPwrSeq.o\
					hal/$(RTL871X)_sreset.o

_HAL_INTFS_FILES +=	hal/$(RTL871X)_hal_init.o \
			hal/$(RTL871X)_phycfg.o \
			hal/$(RTL871X)_rf6052.o \
			hal/$(RTL871X)_dm.o \
			hal/$(RTL871X)_rxdesc.o \
			hal/$(RTL871X)_cmd.o \
			hal/$(HCI_NAME)_halinit.o \
			hal/rtl$(MODULE_NAME)_led.o \
			hal/rtl$(MODULE_NAME)_xmit.o \
			hal/rtl$(MODULE_NAME)_recv.o

_HAL_INTFS_FILES += hal/$(HCI_NAME)_ops.o

ifeq ($(CONFIG_MP_INCLUDED), y)
_HAL_INTFS_FILES += hal/$(RTL871X)_mp.o
endif
ifeq ($(CONFIG_BT_COEXIST), y)
_HAL_INTFS_FILES +=  hal/rtl8723b_bt-coexist.o
endif

_OUTSRC_FILES += hal/HalHWImg8723B_BB.o\
			hal/HalHWImg8723B_MAC.o\
			hal/HalHWImg8723B_RF.o\
			hal/HalHWImg8723B_FW.o\
			hal/HalHWImg8723B_MP.o\
			hal/odm_RegConfig8723B.o\
			hal/HalPhyRf_8723B.o\
			hal/odm_RTL8723B.o

endif

########### AUTO_CFG  #################################	
		
ifeq ($(CONFIG_AUTOCFG_CP), y)

ifeq ($(CONFIG_MULTIDRV), y)	
$(shell cp $(TopDIR)/autoconf_multidrv_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
else
ifeq ($(CONFIG_RTL8188E)$(CONFIG_SDIO_HCI),yy) 
$(shell cp $(TopDIR)/autoconf_rtl8189e_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
else
$(shell cp $(TopDIR)/autoconf_$(RTL871X)_$(HCI_NAME)_linux.h $(TopDIR)/include/autoconf.h)
endif
endif

endif

########### END OF PATH  #################################


ifeq ($(CONFIG_USB_HCI), y)
ifeq ($(CONFIG_USB_AUTOSUSPEND), y)
EXTRA_CFLAGS += -DCONFIG_USB_AUTOSUSPEND
endif
endif

ifeq ($(CONFIG_MP_INCLUDED), y)
#MODULE_NAME := $(MODULE_NAME)_mp
EXTRA_CFLAGS += -DCONFIG_MP_INCLUDED
endif

ifeq ($(CONFIG_POWER_SAVING), y)
EXTRA_CFLAGS += -DCONFIG_POWER_SAVING
endif

ifeq ($(CONFIG_HW_PWRP_DETECTION), y)
EXTRA_CFLAGS += -DCONFIG_HW_PWRP_DETECTION
endif

ifeq ($(CONFIG_WIFI_TEST), y)
EXTRA_CFLAGS += -DCONFIG_WIFI_TEST
endif

ifeq ($(CONFIG_BT_COEXIST), y)
EXTRA_CFLAGS += -DCONFIG_BT_COEXIST
endif

ifeq ($(CONFIG_RTL8192CU_REDEFINE_1X1), y)
EXTRA_CFLAGS += -DRTL8192C_RECONFIG_TO_1T1R
endif

ifeq ($(CONFIG_INTEL_WIDI), y)
EXTRA_CFLAGS += -DCONFIG_INTEL_WIDI
endif

ifeq ($(CONFIG_WAPI_SUPPORT), y)
EXTRA_CFLAGS += -DCONFIG_WAPI_SUPPORT
endif

ifeq ($(CONFIG_EFUSE_CONFIG_FILE), y)
EXTRA_CFLAGS += -DCONFIG_EFUSE_CONFIG_FILE
endif

ifeq ($(CONFIG_EXT_CLK), y)
EXTRA_CFLAGS += -DCONFIG_EXT_CLK
endif

ifeq ($(CONFIG_FTP_PROTECT), y)
EXTRA_CFLAGS += -DCONFIG_FTP_PROTECT
endif

ifeq ($(CONFIG_RTL8188E), y)
ifeq ($(CONFIG_WOWLAN), y)
EXTRA_CFLAGS += -DCONFIG_WOWLAN
endif
endif

EXTRA_CFLAGS += -DCONFIG_LITTLE_ENDIAN
SUBARCH := $(shell uname -m | sed -e s/i.86/i386/)
ARCH ?= $(SUBARCH)
CROSS_COMPILE ?=
KVER  := $(shell uname -r)
KSRC := /lib/modules/$(KVER)/build
MODDESTDIR := /lib/modules/$(KVER)/kernel/drivers/net/wireless/
INSTALL_PREFIX :=

ifeq ($(CONFIG_MULTIDRV), y)	

ifeq ($(CONFIG_SDIO_HCI), y)
MODULE_NAME := rtw_sdio
endif

ifeq ($(CONFIG_USB_HCI), y)
MODULE_NAME := rtw_usb
endif

ifeq ($(CONFIG_PCI_HCI), y)
MODULE_NAME := rtw_pci
endif


endif

ifneq ($(USER_MODULE_NAME),)
MODULE_NAME := $(USER_MODULE_NAME)
endif

ifneq ($(KERNELRELEASE),)

rtk_core :=	core/rtw_cmd.o \
		core/rtw_security.o \
		core/rtw_debug.o \
		core/rtw_io.o \
		core/rtw_ioctl_query.o \
		core/rtw_ioctl_set.o \
		core/rtw_ieee80211.o \
		core/rtw_mlme.o \
		core/rtw_mlme_ext.o \
		core/rtw_wlan_util.o \
		core/rtw_vht.o \
		core/rtw_pwrctrl.o \
		core/rtw_rf.o \
		core/rtw_recv.o \
		core/rtw_sta_mgt.o \
		core/rtw_ap.o \
		core/rtw_xmit.o	\
		core/rtw_p2p.o \
		core/rtw_tdls.o \
		core/rtw_br_ext.o \
		core/rtw_iol.o \
		core/rtw_sreset.o\
		core/efuse/rtw_efuse.o

$(MODULE_NAME)-y += $(rtk_core)

$(MODULE_NAME)-$(CONFIG_INTEL_WIDI) += core/rtw_intel_widi.o

$(MODULE_NAME)-$(CONFIG_WAPI_SUPPORT) += core/rtw_wapi.o	\
					core/rtw_wapi_sms4.o
					
$(MODULE_NAME)-y += $(_OS_INTFS_FILES)
$(MODULE_NAME)-y += $(_HAL_INTFS_FILES)
$(MODULE_NAME)-y += $(_OUTSRC_FILES)

$(MODULE_NAME)-$(CONFIG_MP_INCLUDED) += core/rtw_mp.o \
					core/rtw_mp_ioctl.o

ifeq ($(CONFIG_RTL8723A), y)
$(MODULE_NAME)-$(CONFIG_MP_INCLUDED)+= core/rtw_bt_mp.o
endif
ifeq ($(CONFIG_RTL8723B), y)
$(MODULE_NAME)-$(CONFIG_MP_INCLUDED)+= core/rtw_bt_mp.o
endif

obj-$(CONFIG_RTL8812AU_8821AU) := $(MODULE_NAME).o

else

export CONFIG_RTL8812AU_8821AU = m

all: modules

modules:
	$(MAKE) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KSRC) M=$(shell pwd)  modules

strip:
	$(CROSS_COMPILE)strip $(MODULE_NAME).ko --strip-unneeded

install:
	install -p -m 644 $(MODULE_NAME).ko  $(MODDESTDIR)
	/sbin/depmod -a ${KVER}

uninstall:
	rm -f $(MODDESTDIR)/$(MODULE_NAME).ko
	/sbin/depmod -a ${KVER}

config_r:
	@echo "make config"
	/bin/bash script/Configure script/config.in

.PHONY: modules clean

clean:
	cd hal ; rm -fr */*.mod.c */*.mod */*.o */.*.cmd */*.ko
	cd hal ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd core/efuse ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd core ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd os_dep/linux ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	cd os_dep ; rm -fr *.mod.c *.mod *.o .*.cmd *.ko
	rm -fr Module.symvers ; rm -fr Module.markers ; rm -fr modules.order
	rm -fr *.mod.c *.mod *.o .*.cmd *.ko *~
	rm -fr .tmp_versions
endif

