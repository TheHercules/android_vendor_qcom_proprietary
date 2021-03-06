# sources and intermediate files are separated
vpath %.c $(SRCDIR)

#CFLAGS   += $(QCT_CFLAGS)
# XXX muzzle warnings
CFLAGS   += $(patsubst -Werror,,$(QCT_CFLAGS))
CFLAGS   += -g

CPPFLAGS += $(QCT_CPPFLAGS)
CPPFLAGS += -DFEATURE_BT_QSOC
CPPFLAGS += -DFEATURE_BT_QSOC_SLEEP
CPPFLAGS += -I$(SRCDIR)
CPPFLAGS += -I$(SRCDIR)/../../common/inc

CPPFLAGS += -DFEATURE_BT_QSOC_BTS4020_BDB0
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4020_BDB1
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4020_R3
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4021_B1
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4025_B0
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4025_B1
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4025_B2
CPPFLAGS += -DFEATURE_BT_QSOC_BTS4025_B3
CPPFLAGS += -DFEATURE_BT_QSOC_MARIMBA_A0
CPPFLAGS += -DFEATURE_BT_QSOC_MARIMBA_B0
CPPFLAGS += -DFEATURE_BT_QSOC_MARIMBA_B1
CPPFLAGS += -DFEATURE_BT_QSOC_BAHAMA_A0
CPPFLAGS += -DFEATURE_BT_QSOC_BAHAMA_B0
CPPFLAGS += -DFEATURE_BT_QSOC_BAHAMA_B1

ifndef BT_QSOC_USE_RPC
CPPFLAGS += -DBT_QSOC_GET_ITEMS_FROM_NV
endif

ifdef BT_QSOC_GET_BD_ADDR_FROM_NV
CPPFLAGS += -DBT_QSOC_GET_BD_ADDR_FROM_NV
endif

ifdef BT_QSOC_POWER_ONOFF_PATH
CPPFLAGS += '-DBT_QSOC_POWER_ONOFF_PATH="$(BT_QSOC_POWER_ONOFF_PATH)"'
endif

ifdef BT_QSOC_DISABLE_SLEEP_MODE
CPPFLAGS += -DBT_QSOC_DISABLE_SLEEP_MODE
endif

ifdef BT_QSOC_HCI_DEVICE
CPPFLAGS += '-DBT_QSOC_HCI_DEVICE="$(BT_QSOC_HCI_DEVICE)"'
endif

ifdef BT_QSOC_HCI_BAUD_RATE
CPPFLAGS += -DBT_QSOC_HCI_BAUD_RATE=$(BT_QSOC_HCI_BAUD_RATE)
endif

ifdef BT_QSOC_REF_CLOCK
CPPFLAGS += -DBT_QSOC_REF_CLOCK=$(BT_QSOC_REF_CLOCK)
endif

ifdef BT_QSOC_ENABLE_CLOCK_SHARING
CPPFLAGS += -DBT_QSOC_ENABLE_CLOCK_SHARING
endif

ifdef BT_QSOC_WLAN_COEXISTENCE
CPPFLAGS += -DFEATURE_BT_WLAN_COEXISTENCE
# CPPFLAGS += -DFEATURE_BT_QSOC_WLAN_LIBRA
endif

# Not needed
#CPPFLAGS += -DFEATURE_BT_SOC_BITRATE_460800
#CPPFLAGS += -DFEATURE_BT_QSOC_NV

APP_NAME := hci_qcomm_init

SRCLIST := bthci_qcomm_linux.cpp bthci_qcomm_linux_uart.c
SRCLIST += bthci_qcomm_common.c btqsocnvmplatform_linux.c
SRCLIST += bt_qsoc_nvm_BTS4020_BDB0_19P2Mhz.c bt_qsoc_nvm_BTS4020_BDB0_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4020_BDB1_19P2Mhz.c bt_qsoc_nvm_BTS4020_BDB1_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4020_R3_19P2Mhz.c bt_qsoc_nvm_BTS4020_R3_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4021_B1_19P2Mhz.c bt_qsoc_nvm_BTS4021_B1_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4025_B0_19P2Mhz.c bt_qsoc_nvm_BTS4025_B0_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4025_B1_19P2Mhz.c bt_qsoc_nvm_BTS4025_B1_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4025_B2_19P2Mhz.c bt_qsoc_nvm_BTS4025_B2_32Mhz.c
SRCLIST += bt_qsoc_nvm_BTS4025_B3_19P2Mhz.c bt_qsoc_nvm_BTS4025_B3_32Mhz.c
SRCLIST += bt_qsoc_nvm_MARIMBA_A0.c bt_qsoc_nvm_MARIMBA_B0.c bt_qsoc_nvm_MARIMBA_B1.c
SRCLIST += bt_qsoc_nvm_BAHAMA_A0.c bt_qsoc_nvm_BAHAMA_B0.c bt_qsoc_nvm_BAHAMA_B1.c
SRCLIST += btqsocnvm.c btqsocnvmefsmode.c
SRCLIST += btqsocnvmtags.c btqsocnvmprsr.c btqsocnvmutils.c

LDLIBS += -lrt
ifdef BT_QSOC_USE_RPC
LDLIBS += -ldsm
LDLIBS += -loncrpc
LDLIBS += -lpthread
LDLIBS += -lqueue
LDLIBS += -ldiag
endif
ifdef BT_QSOC_GET_BD_ADDR_FROM_NV
LDLIBS += -lnv
endif

all: $(APP_NAME)

$(APP_NAME): $(SRCLIST)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
