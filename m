Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADF16031F
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2020 10:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgBPJZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Feb 2020 04:25:50 -0500
Received: from www521.your-server.de ([159.69.224.3]:52428 "EHLO
        www521.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgBPJZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Feb 2020 04:25:49 -0500
X-Greylist: delayed 1379 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2020 04:25:33 EST
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www521.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <simeon_btrfs@sfelis.de>)
        id 1j3Fow-00033Q-1s
        for linux-btrfs@vger.kernel.org; Sun, 16 Feb 2020 10:02:34 +0100
Received: from [62.216.209.46] (helo=[192.168.178.25])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <simeon_btrfs@sfelis.de>)
        id 1j3Fov-00096F-Kz
        for linux-btrfs@vger.kernel.org; Sun, 16 Feb 2020 10:02:33 +0100
From:   Simeon Felis <simeon_btrfs@sfelis.de>
Subject: kernel incompatibility?
To:     linux-btrfs@vger.kernel.org
Message-ID: <8fb8442b-dbf9-4d4b-42bb-ce460048f891@sfelis.de>
Date:   Sun, 16 Feb 2020 10:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2F0C5F2203717CCE29A72ED8"
Content-Language: en-US
X-Authenticated-Sender: simeon@sfelis.de
X-Virus-Scanned: Clear (ClamAV 0.102.1/25724/Sat Feb 15 13:01:56 2020)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F0C5F2203717CCE29A72ED8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I had a btrfs raid1 running on raspbian (linux 4.19 arm) which overheated. To fix corruptions I attached the raid1 on my workstation (linux 5.5 x86_64) and performed scrub, defrag and --full-balance (not necessarily in this order) and fixed the corruptions.

Back on raspbian a mount fails:

root@omv:~# mount /dev/disk/by-label/URAID /mnt/URAID/
mount: /mnt/URAID: wrong fs type, bad option, bad superblock on /dev/sda1, missing codepage or helper program, or other error.

dmesg-4.19 attached.


root@omv:~# uname -a
Linux omv 4.19.97-v7l+ #1294 SMP Thu Jan 30 13:21:14 GMT 2020 armv7l GNU/Linux
root@omv:~# btrfs --version
btrfs-progs v4.20.1 
root@omv:~# btrfs fi show
Label: 'URAID'  uuid: 489b8eca-1357-48ea-a9e2-050d3d78d383
	Total devices 2 FS bytes used 1.69TiB
	devid    7 size 3.64TiB used 2.45TiB path /dev/sda1
	devid    8 size 3.64TiB used 2.45TiB path /dev/sdb1


I cannot provide btrfs fi df /mnt from raspbian since the mount fails.

On my workstation I can mount the raid1 without problems.

On Arch Linux mailing list [1] Chris Murphy gained some more information and tried to help me with no success. Did I hit some known btrfs bug and should go to raspbian mailing list, or is this something new?

[1] https://lists.archlinux.org/pipermail/arch-general/2020-February/047463.html

--------------2F0C5F2203717CCE29A72ED8
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg-4.19.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="dmesg-4.19.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.19.97-v7l+ (dom@buildbot) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1294 SMP Thu Jan 30 13:21:14 GMT 2020
[    0.000000] CPU: ARMv7 Processor [410fd083] revision 3 (ARMv7), cr=30c5383d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: Raspberry Pi 4 Model B Rev 1.2
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 256 MiB at 0x000000001ec00000
[    0.000000] On node 0 totalpages: 1012736
[    0.000000]   DMA zone: 1728 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:63
[    0.000000]   HighMem zone: 816128 pages, LIFO batch:63
[    0.000000] random: get_random_bytes called from start_kernel+0xc0/0x4e8 with crng_init=0
[    0.000000] percpu: Embedded 17 pages/cpu s36928 r8192 d24512 u69632
[    0.000000] pcpu-alloc: s36928 r8192 d24512 u69632 alloc=17*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1011008
[    0.000000] Kernel command line: coherent_pool=1M 8250.nr_uarts=1 cma=64M cma=256M  smsc95xx.macaddr=DC:A6:32:5C:2D:6F vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000  console=ttyS0,115200 console=tty1 root=PARTUUID=6c586e13-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 3735564K/4050944K available (8192K kernel code, 687K rwdata, 2408K rodata, 2048K init, 850K bss, 53236K reserved, 262144K cma-reserved, 3264512K highmem)
[    0.000000] Virtual kernel memory layout:
                   vector  : 0xffff0000 - 0xffff1000   (   4 kB)
                   fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
                   vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
                   lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
                   pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
                   modules : 0xbf000000 - 0xbfe00000   (  14 MB)
                     .text : 0x(ptrval) - 0x(ptrval)   (10208 kB)
                     .init : 0x(ptrval) - 0x(ptrval)   (2048 kB)
                     .data : 0x(ptrval) - 0x(ptrval)   ( 688 kB)
                      .bss : 0x(ptrval) - 0x(ptrval)   ( 851 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] ftrace: allocating 28692 entries in 85 pages
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] arch_timer: cp15 timer(s) running at 54.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0xc743ce346, max_idle_ns: 440795203123 ns
[    0.000005] sched_clock: 56 bits at 54MHz, resolution 18ns, wraps every 4398046511102ns
[    0.000022] Switching to timer-based delay loop, resolution 18ns
[    0.000244] Console: colour dummy device 80x30
[    0.000696] console [tty1] enabled
[    0.000754] Calibrating delay loop (skipped), value calculated using timer frequency.. 108.00 BogoMIPS (lpj=540000)
[    0.000790] pid_max: default: 32768 minimum: 301
[    0.001072] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001103] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001863] CPU: Testing write buffer coherency: ok
[    0.002278] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002928] Setting up static identity map for 0x200000 - 0x20003c
[    0.003100] rcu: Hierarchical SRCU implementation.
[    0.003966] smp: Bringing up secondary CPUs ...
[    0.004760] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.005674] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.006548] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.006682] smp: Brought up 1 node, 4 CPUs
[    0.006748] SMP: Total of 4 processors activated (432.00 BogoMIPS).
[    0.006771] CPU: All CPU(s) started in HYP mode.
[    0.006792] CPU: Virtualization extensions available.
[    0.007582] devtmpfs: initialized
[    0.017721] VFP support v0.3: implementor 41 architecture 3 part 40 variant 8 rev 0
[    0.017950] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.017992] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.025454] pinctrl core: initialized pinctrl subsystem
[    0.026310] NET: Registered protocol family 16
[    0.028975] DMA: preallocated 1024 KiB pool for atomic coherent allocations
[    0.030404] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
[    0.030435] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.030635] Serial: AMBA PL011 UART driver
[    0.033699] bcm2835-mbox fe00b880.mailbox: mailbox enabled
[    0.050023] raspberrypi-firmware soc:firmware: Attached to firmware from 2020-01-30 13:50, variant start
[    0.060039] raspberrypi-firmware soc:firmware: Firmware hash is 8f792e011c8a0ea3c5d47e7cc10172cc10b93c09
[    0.102597] bcm2835-dma fe007000.dma: DMA legacy API manager at (ptrval), dmachans=0x1
[    0.105792] vgaarb: loaded
[    0.106160] SCSI subsystem initialized
[    0.106363] usbcore: registered new interface driver usbfs
[    0.106431] usbcore: registered new interface driver hub
[    0.106520] usbcore: registered new device driver usb
[    0.107739] clocksource: Switched to clocksource arch_sys_counter
[    0.186108] VFS: Disk quotas dquot_6.6.0
[    0.186207] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.186365] FS-Cache: Loaded
[    0.186536] CacheFiles: Loaded
[    0.187054] simple-framebuffer: probe of 0.framebuffer failed with error -12
[    0.194853] NET: Registered protocol family 2
[    0.195518] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes)
[    0.195564] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.195645] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.195729] TCP: Hash tables configured (established 8192 bind 8192)
[    0.195864] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.195909] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.196130] NET: Registered protocol family 1
[    0.196714] RPC: Registered named UNIX socket transport module.
[    0.196740] RPC: Registered udp transport module.
[    0.196761] RPC: Registered tcp transport module.
[    0.196782] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.196810] PCI: CLS 0 bytes, default 64
[    0.199736] Initialise system trusted keyrings
[    0.199926] workingset: timestamp_bits=14 max_order=20 bucket_order=6
[    0.208905] FS-Cache: Netfs 'nfs' registered for caching
[    0.209417] NFS: Registering the id_resolver key type
[    0.209453] Key type id_resolver registered
[    0.209474] Key type id_legacy registered
[    0.209510] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.211785] Key type asymmetric registered
[    0.211811] Asymmetric key parser 'x509' registered
[    0.211931] bounce: pool size: 64 pages
[    0.211984] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.212165] io scheduler noop registered
[    0.212189] io scheduler deadline registered (default)
[    0.212359] io scheduler cfq registered
[    0.212382] io scheduler mq-deadline registered (default)
[    0.212405] io scheduler kyber registered
[    0.235945] brcm-pcie fd500000.pcie: dmabounce: initialised - 32768 kB, threshold 0x00000000c0000000
[    0.235991] brcm-pcie fd500000.pcie: could not get clock
[    0.236063] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 ranges:
[    0.236115] brcm-pcie fd500000.pcie:   MEM 0x600000000..0x603ffffff -> 0xf8000000
[    0.287770] brcm-pcie fd500000.pcie: link up, 5.0 Gbps x1 (!SSC)
[    0.288038] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
[    0.288068] pci_bus 0000:00: root bus resource [bus 00-01]
[    0.288098] pci_bus 0000:00: root bus resource [mem 0x600000000-0x603ffffff] (bus address [0xf8000000-0xfbffffff])
[    0.288159] pci 0000:00:00.0: [14e4:2711] type 01 class 0x060400
[    0.288295] pci 0000:00:00.0: PME# supported from D0 D3hot
[    0.290997] PCI: bus0: Fast back to back transfers disabled
[    0.291028] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.291250] pci 0000:01:00.0: [1106:3483] type 00 class 0x0c0330
[    0.291374] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.291686] pci 0000:01:00.0: PME# supported from D0 D3cold
[    0.294408] PCI: bus1: Fast back to back transfers disabled
[    0.294438] pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
[    0.294484] pci 0000:00:00.0: BAR 8: assigned [mem 0x600000000-0x6000fffff]
[    0.294517] pci 0000:01:00.0: BAR 0: assigned [mem 0x600000000-0x600000fff 64bit]
[    0.294605] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.294634] pci 0000:00:00.0:   bridge window [mem 0x600000000-0x6000fffff]
[    0.294858] pcieport 0000:00:00.0: enabling device (0140 -> 0142)
[    0.295044] pcieport 0000:00:00.0: Signaling PME with IRQ 54
[    0.295215] pcieport 0000:00:00.0: AER enabled with IRQ 54
[    0.295395] pci 0000:01:00.0: enabling device (0140 -> 0142)
[    0.297853] Serial: 8250/16550 driver, 1 ports, IRQ sharing enabled
[    0.299798] iproc-rng200 fe104000.rng: hwrng registered
[    0.300037] vc-mem: phys_addr:0x00000000 mem_base=0x3ec00000 mem_size:0x40000000(1024 MiB)
[    0.300533] vc-sm: Videocore shared memory driver
[    0.300936] gpiomem-bcm2835 fe200000.gpiomem: Initialised: Registers at 0xfe200000
[    0.310796] brd: module loaded
[    0.320153] loop: module loaded
[    0.320895] Loading iSCSI transport class v2.0-870.
[    0.322574] libphy: Fixed MDIO Bus: probed
[    0.323004] bcmgenet fd580000.genet: failed to get enet clock
[    0.323035] bcmgenet fd580000.genet: GENET 5.0 EPHY: 0x0000
[    0.323065] bcmgenet fd580000.genet: failed to get enet-wol clock
[    0.323094] bcmgenet fd580000.genet: failed to get enet-eee clock
[    0.323130] bcmgenet: Skipping UMAC reset
[    0.323379] unimac-mdio unimac-mdio.-19: DMA mask not set
[    0.337768] libphy: bcmgenet MII bus: probed
[    0.378277] unimac-mdio unimac-mdio.-19: Broadcom UniMAC MDIO bus at 0x(ptrval)
[    0.379177] usbcore: registered new interface driver r8152
[    0.379260] usbcore: registered new interface driver lan78xx
[    0.379327] usbcore: registered new interface driver smsc95xx
[    0.379634] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    0.379678] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
[    0.381847] xhci_hcd 0000:01:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000001000000890
[    0.382151] genirq: irq_chip Brcm_MSI did not update eff. affinity mask of irq 55
[    0.383020] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    0.383054] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.383083] usb usb1: Product: xHCI Host Controller
[    0.383106] usb usb1: Manufacturer: Linux 4.19.97-v7l+ xhci-hcd
[    0.383130] usb usb1: SerialNumber: 0000:01:00.0
[    0.383629] hub 1-0:1.0: USB hub found
[    0.383721] hub 1-0:1.0: 1 port detected
[    0.384195] xhci_hcd 0000:01:00.0: xHCI Host Controller
[    0.384237] xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
[    0.384274] xhci_hcd 0000:01:00.0: Host supports USB 3.0 SuperSpeed
[    0.384651] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    0.384684] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.384713] usb usb2: Product: xHCI Host Controller
[    0.384736] usb usb2: Manufacturer: Linux 4.19.97-v7l+ xhci-hcd
[    0.384759] usb usb2: SerialNumber: 0000:01:00.0
[    0.385265] hub 2-0:1.0: USB hub found
[    0.385334] hub 2-0:1.0: 4 ports detected
[    0.386520] dwc_otg: version 3.00a 10-AUG-2012 (platform bus)
[    0.386730] dwc_otg: FIQ enabled
[    0.386739] dwc_otg: NAK holdoff enabled
[    0.386748] dwc_otg: FIQ split-transaction FSM enabled
[    0.386760] Module dwc_common_port init
[    0.386961] usbcore: registered new interface driver uas
[    0.387072] usbcore: registered new interface driver usb-storage
[    0.387259] mousedev: PS/2 mouse device common for all mice
[    0.388460] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
[    0.389906] sdhci: Secure Digital Host Controller Interface driver
[    0.389932] sdhci: Copyright(c) Pierre Ossman
[    0.390323] mmc-bcm2835 fe300000.mmcnr: could not get clk, deferring probe
[    0.390728] sdhci-pltfm: SDHCI platform and OF driver helper
[    0.393701] ledtrig-cpu: registered to indicate activity on CPUs
[    0.393875] hidraw: raw HID events driver (C) Jiri Kosina
[    0.394012] usbcore: registered new interface driver usbhid
[    0.394034] usbhid: USB HID core driver
[    0.394746] vchiq: vchiq_init_state: slot_zero = (ptrval), is_master = 0
[    0.396040] [vc_sm_connected_init]: start
[    0.402143] [vc_sm_connected_init]: end - returning 0
[    0.403296] Initializing XFRM netlink socket
[    0.403337] NET: Registered protocol family 17
[    0.403438] Key type dns_resolver registered
[    0.403703] Registering SWP/SWPB emulation handler
[    0.404256] registered taskstats version 1
[    0.404285] Loading compiled-in X.509 certificates
[    0.411248] uart-pl011 fe201000.serial: cts_event_workaround enabled
[    0.411327] fe201000.serial: ttyAMA0 at MMIO 0xfe201000 (irq = 34, base_baud = 0) is a PL011 rev2
[    0.416530] console [ttyS0] disabled
[    0.416576] fe215040.serial: ttyS0 at MMIO 0x0 (irq = 36, base_baud = 62500000) is a 16550
[    1.582834] console [ttyS0] enabled
[    1.586792] bcm2835-power bcm2835-power: Broadcom BCM2835 power domains driver
[    1.594646] brcmstb_thermal fd5d2200.thermal: registered AVS TMON of-sensor driver
[    1.602993] mmc-bcm2835 fe300000.mmcnr: mmc_debug:0 mmc_debug2:0
[    1.609125] mmc-bcm2835 fe300000.mmcnr: DMA channel allocated
[    1.641292] sdhci-iproc fe340000.emmc2: Linked as a consumer to regulator.3
[    1.648478] sdhci-iproc fe340000.emmc2: Linked as a consumer to regulator.4
[    1.673829] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    1.681055] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.688250] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.693869] mmc0: SDHCI controller on fe340000.emmc2 [fe340000.emmc2] using ADMA
[    1.703760] of_cfs_init
[    1.704074] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    1.706412] of_cfs_init: OK
[    1.713458] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    1.720586] Waiting for root device PARTUUID=6c586e13-02...
[    1.769283] random: fast init done
[    1.818658] mmc0: new ultra high speed DDR50 SDHC card at address 59b4
[    1.827944] mmcblk0: mmc0:59b4 USD   29.5 GiB
[    1.834512]  mmcblk0: p1 p2
[    1.839754] mmc1: new high speed SDIO card at address 0001
[    1.867784] usb 1-1: new high-speed USB device number 2 using xhci_hcd
[    1.891934] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
[    1.900264] VFS: Mounted root (ext4 filesystem) readonly on device 179:2.
[    1.913248] devtmpfs: mounted
[    1.923867] Freeing unused kernel memory: 2048K
[    1.928728] Run /sbin/init as init process
[    2.050397] usb 1-1: New USB device found, idVendor=2109, idProduct=3431, bcdDevice= 4.21
[    2.058757] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.066013] usb 1-1: Product: USB2.0 Hub
[    2.071672] hub 1-1:1.0: USB hub found
[    2.075713] hub 1-1:1.0: 4 ports detected
[    5.303509] systemd[1]: System time before build time, advancing clock.
[    5.440853] NET: Registered protocol family 10
[    5.446569] Segment Routing with IPv6
[    5.483654] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    5.506085] systemd[1]: Detected architecture arm.
[    5.530191] systemd[1]: Set hostname to <omv>.
[    5.536683] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid argument
[    6.043322] random: lvmconfig: uninitialized urandom read (4 bytes read)
[    6.568628] systemd[1]: /lib/systemd/system/smbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/smbd.pid → /run/samba/smbd.pid; please update the unit file accordingly.
[    6.624130] systemd[1]: /lib/systemd/system/nmbd.service:9: PIDFile= references path below legacy directory /var/run/, updating /var/run/samba/nmbd.pid → /run/samba/nmbd.pid; please update the unit file accordingly.
[    6.662688] systemd[1]: /lib/systemd/system/rpc-statd.service:13: PIDFile= references path below legacy directory /var/run/, updating /var/run/rpc.statd.pid → /run/rpc.statd.pid; please update the unit file accordingly.
[    6.880396] random: systemd: uninitialized urandom read (16 bytes read)
[    6.907487] random: systemd: uninitialized urandom read (16 bytes read)
[    6.919672] systemd[1]: Created slice system-getty.slice.
[    6.926406] systemd[1]: Listening on Network Service Netlink Socket.
[    6.933744] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.189077] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    7.772589] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
[    7.877173] systemd-journald[123]: Received request to flush runtime journal from PID 1
[    9.999086] rpivid-mem feb00000.hevc-decoder: rpivid-hevcmem initialised: Registers at 0xfeb00000 length 0x0000ffff
[    9.999622] rpivid-mem feb10000.rpivid-local-intc: rpivid-intcmem initialised: Registers at 0xfeb10000 length 0x00000fff
[   10.000171] rpivid-mem feb20000.h264-decoder: rpivid-h264mem initialised: Registers at 0xfeb20000 length 0x0000ffff
[   10.000688] rpivid-mem feb30000.vp9-decoder: rpivid-vp9mem initialised: Registers at 0xfeb30000 length 0x0000ffff
[   10.051920] vc_sm_cma: module is from the staging directory, the quality is unknown, you have been warned.
[   10.053829] bcm2835_vc_sm_cma_probe: Videocore shared memory driver
[   10.053845] [vc_sm_connected_init]: start
[   10.061144] [vc_sm_connected_init]: installed successfully
[   10.088784] media: Linux media interface: v0.10
[   10.144956] videodev: Linux video capture interface: v2.00
[   10.192957] snd_bcm2835: module is from the staging directory, the quality is unknown, you have been warned.
[   10.212456] bcm2835_mmal_vchiq: module is from the staging directory, the quality is unknown, you have been warned.
[   10.213779] bcm2835_mmal_vchiq: module is from the staging directory, the quality is unknown, you have been warned.
[   10.227608] bcm2835_v4l2: module is from the staging directory, the quality is unknown, you have been warned.
[   10.240201] bcm2835_audio soc:audio: card created with 8 channels
[   10.250265] bcm2835_codec: module is from the staging directory, the quality is unknown, you have been warned.
[   10.265761] bcm2835-codec bcm2835-codec: Device registered as /dev/video10
[   10.265796] bcm2835-codec bcm2835-codec: Loaded V4L2 decode
[   10.272095] bcm2835-codec bcm2835-codec: Device registered as /dev/video11
[   10.272127] bcm2835-codec bcm2835-codec: Loaded V4L2 encode
[   10.279287] bcm2835-codec bcm2835-codec: Device registered as /dev/video12
[   10.279327] bcm2835-codec bcm2835-codec: Loaded V4L2 isp
[   10.428629] [drm] Initialized v3d 1.0.0 20180419 for fec00000.v3d on minor 0
[   10.438163] bcmgenet: Skipping UMAC reset
[   10.465897] [drm] No displays found. Consider forcing hotplug if HDMI is attached
[   10.465989] vc4-drm soc:gpu: bound fe600000.firmwarekms (ops vc4_fkms_ops [vc4])
[   10.466473] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 1
[   10.466484] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.466493] [drm] No driver support for vblank timestamp query.
[   10.466502] [drm] Setting vblank_disable_immediate to false because get_vblank_timestamp == NULL
[   10.538469] bcmgenet fd580000.genet: configuring instance for external RGMII (no delay)
[   10.539180] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   10.596003] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.657283] brcmfmac: F1 signature read @0x18000000=0x15264345
[   10.666209] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[   10.666875] usbcore: registered new interface driver brcmfmac
[   10.907298] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[   10.925081] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Feb 27 2018 03:15:32 version 7.45.154 (r684107 CY) FWID 01-4fbe0b04
[   11.608001] bcmgenet fd580000.genet eth0: Link is Down
[   15.036430] uart-pl011 fe201000.serial: no DMA platform data
[   15.088026] 8021q: 802.1Q VLAN Support v1.8
[   15.397363] brcmfmac: power management disabled
[   17.600328] random: crng init done
[   17.600341] random: 7 urandom warning(s) missed due to ratelimiting
[   21.785494] Bluetooth: Core ver 2.22
[   21.785565] NET: Registered protocol family 31
[   21.785575] Bluetooth: HCI device and connection manager initialized
[   21.785594] Bluetooth: HCI socket layer initialized
[   21.785610] Bluetooth: L2CAP socket layer initialized
[   21.785657] Bluetooth: SCO socket layer initialized
[   21.798652] Bluetooth: HCI UART driver ver 2.3
[   21.798666] Bluetooth: HCI UART protocol H4 registered
[   21.798746] Bluetooth: HCI UART protocol Three-wire (H5) registered
[   21.798976] Bluetooth: HCI UART protocol Broadcom registered
[   21.998150] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[   22.029510] usb 2-2: New USB device found, idVendor=152d, idProduct=0567, bcdDevice=52.03
[   22.029526] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   22.029540] usb 2-2: Product: External USB 3.0
[   22.029552] usb 2-2: Manufacturer: JMicron
[   22.029565] usb 2-2: SerialNumber: 20170331000C3
[   22.035698] usb-storage 2-2:1.0: USB Mass Storage device detected
[   22.036269] usb-storage 2-2:1.0: Quirks match for vid 152d pid 0567: 5000000
[   22.036400] scsi host0: usb-storage 2-2:1.0
[   22.089437] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.089455] Bluetooth: BNEP filters: protocol multicast
[   22.089480] Bluetooth: BNEP socket layer initialized
[   23.048585] scsi 0:0:0:0: Direct-Access     External USB3.0 DISK03    5203 PQ: 0 ANSI: 6
[   23.050675] sd 0:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[   23.050955] sd 0:0:0:0: [sda] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[   23.050970] sd 0:0:0:0: [sda] 4096-byte physical blocks
[   23.051450] scsi 0:0:0:1: Direct-Access     External USB3.0 DISK04    5203 PQ: 0 ANSI: 6
[   23.052017] sd 0:0:0:0: [sda] Write Protect is off
[   23.052033] sd 0:0:0:0: [sda] Mode Sense: 2b 00 00 00
[   23.052683] sd 0:0:0:0: [sda] No Caching mode page found
[   23.052698] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   23.053330] sd 0:0:0:1: [sdb] Very big device. Trying to use READ CAPACITY(16).
[   23.053596] sd 0:0:0:1: [sdb] 7814037168 512-byte logical blocks: (4.00 TB/3.64 TiB)
[   23.053611] sd 0:0:0:1: [sdb] 4096-byte physical blocks
[   23.054377] sd 0:0:0:1: [sdb] Write Protect is off
[   23.054392] sd 0:0:0:1: [sdb] Mode Sense: 2b 00 00 00
[   23.055245] sd 0:0:0:1: [sdb] No Caching mode page found
[   23.055259] sd 0:0:0:1: [sdb] Assuming drive cache: write through
[   23.074905] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   23.075185] sd 0:0:0:1: Attached scsi generic sg1 type 0
[   23.206716]  sda: sda1
[   23.209644]  sdb: sdb1
[   23.210675] sd 0:0:0:0: [sda] Attached SCSI disk
[   23.213023] sd 0:0:0:1: [sdb] Attached SCSI disk
[   23.748011] raid6: int32x1  gen()   210 MB/s
[   23.917761] raid6: int32x1  xor()   143 MB/s
[   24.087917] raid6: int32x2  gen()   248 MB/s
[   24.257898] raid6: int32x2  xor()   169 MB/s
[   24.427898] raid6: int32x4  gen()   312 MB/s
[   24.597777] raid6: int32x4  xor()   180 MB/s
[   24.767878] raid6: int32x8  gen()   283 MB/s
[   24.937735] raid6: int32x8  xor()   179 MB/s
[   25.107816] raid6: neonx1   gen()   722 MB/s
[   25.277757] raid6: neonx1   xor()   618 MB/s
[   25.447781] raid6: neonx2   gen()   944 MB/s
[   25.617747] raid6: neonx2   xor()   890 MB/s
[   25.787782] raid6: neonx4   gen()  1278 MB/s
[   25.957762] raid6: neonx4   xor()  1038 MB/s
[   26.127781] raid6: neonx8   gen()  1116 MB/s
[   26.297762] raid6: neonx8   xor()   943 MB/s
[   26.297773] raid6: using algorithm neonx4 gen() 1278 MB/s
[   26.297783] raid6: .... xor() 1038 MB/s, rmw enabled
[   26.297793] raid6: using neon recovery algorithm
[   26.323094] xor: measuring software checksum speed
[   26.417738]    arm4regs  :  1719.200 MB/sec
[   26.517736]    8regs     :  1109.200 MB/sec
[   26.617733]    32regs    :   990.400 MB/sec
[   26.717735]    neon      :  2255.600 MB/sec
[   26.717746] xor: using function: neon (2255.600 MB/sec)
[   26.841239] Btrfs loaded, crc32c=crc32c-generic
[   26.845640] BTRFS: device label URAID devid 7 transid 1254652 /dev/sda1
[   26.851548] BTRFS: device label URAID devid 8 transid 1254652 /dev/sdb1
[   27.301605] BTRFS info (device sda1): disk space caching is enabled
[   27.301620] BTRFS info (device sda1): has skinny extents
[   27.304203] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[   27.312686] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[   27.321193] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[   27.329714] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[   27.338227] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[   27.346637] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[   27.355110] BTRFS error (device sda1): failed to read chunk root
[   27.408326] BTRFS error (device sda1): open_ctree failed
[   32.127225] NFSD: starting 90-second grace period (net f0000041)
[  118.114212] BTRFS info (device sda1): disk space caching is enabled
[  118.114226] BTRFS info (device sda1): has skinny extents
[  118.120391] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[  118.128885] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[  118.137365] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[  118.147088] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[  118.156003] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[  118.164511] BTRFS critical (device sda1): unable to find logical 4306137776128 length 4096
[  118.172986] BTRFS error (device sda1): failed to read chunk root
[  118.238345] BTRFS error (device sda1): open_ctree failed
[  130.259050] FS-Cache: Netfs 'cifs' registered for caching
[  130.259609] Key type cifs.spnego registered
[  130.259635] Key type cifs.idmap registered
[  131.711856] tun: Universal TUN/TAP device driver, 1.6
[  136.568392] CIFS VFS: Error connecting to socket. Aborting operation.
[  136.568414] CIFS VFS: cifs_mount failed w/return code = -113

--------------2F0C5F2203717CCE29A72ED8--
