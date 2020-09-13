Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F23F268139
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Sep 2020 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgIMU47 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Sep 2020 16:56:59 -0400
Received: from st43p00im-ztbu10063701.me.com ([17.58.63.178]:51747 "EHLO
        st43p00im-ztbu10063701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbgIMU46 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Sep 2020 16:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1600030611;
        bh=a2WcDTzjqO4DPAlBFdeWRNoDIsSazZOBGyCGB2YV91s=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=PdaMvUhxItDMAfKzfpH7vR9XCeUd36gGOWsAbh+lIzzSi/Vp5sCHMvEpVkLzGUE0P
         i1v0fo4vYl2EDJ1UAsWon4hmJQTNeaQeuyu9VlizkglZ+c0TtwiiE+M43KbszzDrky
         Sa95gLJ9qdAApSWcuVwvkkz/9yiuQe7rF1k9kfr0BnYBOAOB9D2H0EiWcqZ+zavXtZ
         z1yP2fhCeJltfNgZX/InDYih3ygo0Q/Pp/L+6E86TFgcQbZf1SxyRuLhcQzU2NJQHc
         RyhjHwfZTELu4ikNCArbHwRZvzZgRbC0xkPcH3LqKXjj6IzR5DzoY49NBwrW7HEsTV
         qJfOf4NKDhLVQ==
Received: from [192.168.10.109] (108-230-77-122.lightspeed.chtnsc.sbcglobal.net [108.230.77.122])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id A5EA09A0606
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Sep 2020 20:56:50 +0000 (UTC)
From:   J J <j333111@icloud.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_B658B118-B818-4D1F-99B7-178C0AB701C3"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Drive won't mount, please help
Message-Id: <91595165-FA0C-4BFB-BA8F-30BEAE6281A3@icloud.com>
Date:   Sun, 13 Sep 2020 16:56:48 -0400
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-13_08:2020-09-10,2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=634 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2009130195
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Apple-Mail=_B658B118-B818-4D1F-99B7-178C0AB701C3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

 I=E2=80=99m new to a lot of this, just trying to use a NAS at home, =
single usb external disk, not RAID. Was working great for a few months, =
I=E2=80=99m not sure what changed today when it stopped mounting. Any =
advice appreciated.

Dmesg log attached


uname -a
Linux rock64 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 #1 SMP Wed Aug =
28 08:59:34 UTC 2019 aarch64 GNU/Linux



btrfs --version
btrfs-progs v4.7.3



btrfs fi show
Label: '3TBRock64'  uuid: 71eda2e3-384c-4868-b5d4-683f222865e6
	Total devices 1 FS bytes used 2.48TiB
	devid    1 size 2.73TiB used 2.59TiB path /dev/mapper/sda-crypt


btrfs fi df /dev/mapper/sda-crypt
ERROR: not a btrfs filesystem: /dev/mapper/sda-crypt


btrfs inspect-internal dump-super /dev/mapper/sda-crypt=20
superblock: bytenr=3D65536, device=3D/dev/mapper/sda-crypt
---------------------------------------------------------
csum_type		0 (crc32c)
csum_size		4
csum			0x9e8b0c33 [match]
bytenr			65536
flags			0x1
			( WRITTEN )
magic			_BHRfS_M [match]
fsid			71eda2e3-384c-4868-b5d4-683f222865e6
label			3TBRock64
generation		395886
root			2638934654976
sys_array_size		129
chunk_root_generation	377485
root_level		1
chunk_root		20971520
chunk_root_level	1
log_root		2638952366080
log_root_transid	0
log_root_level		0
total_bytes		3000556847104
bytes_used		2729422221312
sectorsize		4096
nodesize		16384
leafsize		16384
stripesize		4096
root_dir		6
num_devices		1
compat_flags		0x0
compat_ro_flags		0x0
incompat_flags		0x161
			( MIXED_BACKREF |
			  BIG_METADATA |
			  EXTENDED_IREF |
			  SKINNY_METADATA )
cache_generation	395886
uuid_tree_generation	395886
dev_item.uuid		b7f4386a-18e0-437b-9588-6064ff483fd5
dev_item.fsid		71eda2e3-384c-4868-b5d4-683f222865e6 [match]
dev_item.type		0
dev_item.total_bytes	3000556847104
dev_item.bytes_used	2843293515776
dev_item.io_align	4096
dev_item.io_width	4096
dev_item.sector_size	4096
dev_item.devid		1
dev_item.dev_group	0
dev_item.seek_speed	0
dev_item.bandwidth	0


dev_item.generation	0

--Apple-Mail=_B658B118-B818-4D1F-99B7-178C0AB701C3
Content-Disposition: attachment;
	filename=dmesg.log
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg.log"
Content-Transfer-Encoding: 7bit

~# dmesg
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 (root@runner-f725ff63-project-5943294-concurrent-0) (gcc version 7.4.0 (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) ) #1 SMP Wed Aug 28 08:59:34 UTC 2019
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] earlycon: Early serial console at MMIO32 0xff130000 (options '')
[    0.000000] bootconsole [uart0] enabled
[    0.000000] On node 0 totalpages: 261632
[    0.000000]   DMA zone: 4088 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 261632 pages, LIFO batch:31
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.0 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] PERCPU: Embedded 21 pages/cpu @ffffffc03ff3e000 s46248 r8192 d31576 u86016
[    0.000000] pcpu-alloc: s46248 r8192 d31576 u86016 alloc=21*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257544
[    0.000000] Kernel command line: earlycon=uart8250,mmio32,0xff130000 swiotlb=1 kpti=0 no_console_suspend=1 usbcore.autosuspend=-1 rw panic=10 init=/sbin/init coherent_pool=1M ethaddr=5e:8a:93:87:43:3b eth1addr=5e:8a:93:87:43:5b serial=b6e8c9bb3b16f01 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1 root=LABEL=linux-root rootwait rootfstype=ext4
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.000000] software IO TLB: mapped [mem 0x3fdf6000-0x3fe36000] (0MB)
[    0.000000] Memory: 999876K/1046528K available (12478K kernel code, 1760K rwdata, 4552K rodata, 1216K init, 1962K bss, 46652K reserved, 0K cma-reserved)
[    0.000000] Virtual kernel memory layout:
                   modules : 0xffffff8000000000 - 0xffffff8008000000   (   128 MB)
                   vmalloc : 0xffffff8008000000 - 0xffffffbdbfff0000   (   246 GB)
                     .init : 0xffffff8009130000 - 0xffffff8009260000   (  1216 KB)
                     .text : 0xffffff8008080000 - 0xffffff8008cb0000   ( 12480 KB)
                   .rodata : 0xffffff8008cb0000 - 0xffffff8009130000   (  4608 KB)
                     .data : 0xffffff8009260000 - 0xffffff8009418008   (  1761 KB)
                   vmemmap : 0xffffffbdc0000000 - 0xffffffbfc0000000   (     8 GB maximum)
                             0xffffffbdc0008000 - 0xffffffbdc1000000   (    15 MB actual)
                   fixed   : 0xffffffbffe7fb000 - 0xffffffbffec00000   (  4116 KB)
                   PCI I/O : 0xffffffbffee00000 - 0xffffffbfffe00000   (    16 MB)
                   memory  : 0xffffffc000200000 - 0xffffffc040000000   (  1022 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] rockchip_mmc_get_phase: invalid clk rate
[    0.000000] Architected cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000008] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.001873] Console: colour dummy device 80x25
[    0.002328] console [tty0] enabled
[    0.002653] bootconsole [uart0] disabled
[    0.003036] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.003073] pid_max: default: 32768 minimum: 301
[    0.003219] Security Framework initialized
[    0.003241] Yama: becoming mindful.
[    0.003274] AppArmor: AppArmor disabled by boot time parameter
[    0.003350] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.003378] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes)
[    0.004219] Initializing cgroup subsys io
[    0.004253] Initializing cgroup subsys memory
[    0.004301] Initializing cgroup subsys devices
[    0.004329] Initializing cgroup subsys freezer
[    0.004356] Initializing cgroup subsys net_cls
[    0.004387] Initializing cgroup subsys perf_event
[    0.004415] Initializing cgroup subsys net_prio
[    0.004447] Initializing cgroup subsys hugetlb
[    0.004471] Initializing cgroup subsys pids
[    0.004533] ftrace: allocating 46086 entries in 181 pages
[    0.146742] sched-energy: CPU device node has no sched-energy-costs
[    0.146780] Invalid sched_group_energy for CPU0
[    0.146798] CPU0: update cpu_capacity 1024
[    0.146875] ASID allocator initialised with 32768 entries
[    0.152547] Detected VIPT I-cache on CPU1
[    0.152606] Invalid sched_group_energy for CPU1
[    0.152613] CPU1: update cpu_capacity 1024
[    0.152619] CPU1: Booted secondary processor [410fd034]
[    0.153336] Detected VIPT I-cache on CPU2
[    0.153382] Invalid sched_group_energy for CPU2
[    0.153388] CPU2: update cpu_capacity 1024
[    0.153394] CPU2: Booted secondary processor [410fd034]
[    0.154086] Detected VIPT I-cache on CPU3
[    0.154131] Invalid sched_group_energy for CPU3
[    0.154137] CPU3: update cpu_capacity 1024
[    0.154142] CPU3: Booted secondary processor [410fd034]
[    0.154244] Brought up 4 CPUs
[    0.154750] SMP: Total of 4 processors activated.
[    0.154795] CPU features: kernel page table isolation forced OFF by command line option
[    0.154866] CPU features: detected feature: 32-bit EL0 Support
[    0.154913] CPU: All CPU(s) started at EL2
[    0.154985] alternatives: patching kernel code
[    0.155288] Invalid sched_group_energy for CPU3
[    0.155334] Invalid sched_group_energy for Cluster3
[    0.155375] Invalid sched_group_energy for CPU2
[    0.155416] Invalid sched_group_energy for Cluster2
[    0.155455] Invalid sched_group_energy for CPU1
[    0.155497] Invalid sched_group_energy for Cluster1
[    0.155538] Invalid sched_group_energy for CPU0
[    0.155579] Invalid sched_group_energy for Cluster0
[    0.156381] devtmpfs: initialized
[    0.180528] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.180637] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.181221] xor: measuring software checksum speed
[    0.218709]    8regs     :  1080.000 MB/sec
[    0.258804]    8regs_prefetch:   968.000 MB/sec
[    0.298899]    32regs    :  1458.000 MB/sec
[    0.338991]    32regs_prefetch:  1223.000 MB/sec
[    0.339034] xor: using function: 32regs (1458.000 MB/sec)
[    0.339098] pinctrl core: initialized pinctrl subsystem
[    0.339506] regulator-dummy: no parameters
[    0.341940] Failed to find legacy iommu devices
[    0.342678] NET: Registered protocol family 16
[    0.355113] cpuidle: using governor ladder
[    0.364957] cpuidle: using governor menu
[    0.365027] Registered FIQ tty driver
[    0.366079] vdso: 2 pages (1 code @ ffffff8008cb6000, 1 data @ ffffff8009264000)
[    0.366186] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.366683] DMA: preallocated 1024 KiB pool for atomic allocations
[    0.385891] gpiochip_add_data: registered GPIOs 0 to 31 on device: gpio0
[    0.386034] gpiochip_add_data: registered GPIOs 32 to 63 on device: gpio1
[    0.386164] gpiochip_add_data: registered GPIOs 64 to 95 on device: gpio2
[    0.386306] gpiochip_add_data: registered GPIOs 96 to 127 on device: gpio3
[    0.491674] raid6: int64x1  gen()   202 MB/s
[    0.559505] raid6: int64x1  xor()   181 MB/s
[    0.627796] raid6: int64x2  gen()   323 MB/s
[    0.695825] raid6: int64x2  xor()   250 MB/s
[    0.763963] raid6: int64x4  gen()   478 MB/s
[    0.832071] raid6: int64x4  xor()   337 MB/s
[    0.900125] raid6: int64x8  gen()   386 MB/s
[    0.968253] raid6: int64x8  xor()   308 MB/s
[    1.036432] raid6: neonx1   gen()   360 MB/s
[    1.104498] raid6: neonx1   xor()   319 MB/s
[    1.172634] raid6: neonx2   gen()   548 MB/s
[    1.240763] raid6: neonx2   xor()   489 MB/s
[    1.308916] raid6: neonx4   gen()   744 MB/s
[    1.376998] raid6: neonx4   xor()   575 MB/s
[    1.445181] raid6: neonx8   gen()   763 MB/s
[    1.513259] raid6: neonx8   xor()   575 MB/s
[    1.513302] raid6: using algorithm neonx8 gen() 763 MB/s
[    1.513344] raid6: .... xor() 575 MB/s, rmw enabled
[    1.513385] raid6: using intx1 recovery algorithm
[    1.513882] mpp venc_srv: mpp_probe enter
[    1.513965] mpp venc_srv: init success
[    1.514721] rockchip-pm rockchip-suspend: not set wakeup-config
[    1.514771] rockchip-pm rockchip-suspend: not set pwm-regulator-config
[    1.516220] of_get_named_gpiod_flags: parsed 'gpio' property of node '/sdmmc-regulator[0]' - status (0)
[    1.516299] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.516324] vcc_sd: unable to resolve supply
[    1.516342] vcc_sd: 3300 mV 
[    1.516599] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.516624] vcc_sd: regulator get failed, ret=-517
[    1.516676] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.516696] vcc_sd: unable to resolve supply
[    1.516713] reg-fixed-voltage sdmmc-regulator: vcc_sd supplying 3300000uV
[    1.516985] of_get_named_gpiod_flags: parsed 'gpio' property of node '/vcc-host-5v-regulator[0]' - status (0)
[    1.517047] reg-fixed-voltage vcc-host-5v-regulator: Looking up vin-supply from device tree
[    1.517107] vcc_host_5v: unable to resolve supply
[    1.517132] vcc_host_5v: no parameters
[    1.517374] reg-fixed-voltage vcc-host-5v-regulator: Looking up vin-supply from device tree
[    1.517431] vcc_host_5v: regulator get failed, ret=-517
[    1.517485] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.517507] vcc_sd: unable to resolve supply
[    1.517523] reg-fixed-voltage vcc-host-5v-regulator: Looking up vin-supply from device tree
[    1.517571] vcc_host_5v: unable to resolve supply
[    1.517589] reg-fixed-voltage vcc-host-5v-regulator: vcc_host_5v supplying 0uV
[    1.517812] of_get_named_gpiod_flags: parsed 'gpio' property of node '/vcc-host1-5v-regulator[0]' - status (0)
[    1.517875] reg-fixed-voltage vcc-host1-5v-regulator: Looking up vin-supply from device tree
[    1.517927] vcc_host1_5v: unable to resolve supply
[    1.517949] vcc_host1_5v: no parameters
[    1.518210] reg-fixed-voltage vcc-host1-5v-regulator: Looking up vin-supply from device tree
[    1.518266] vcc_host1_5v: regulator get failed, ret=-517
[    1.518319] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.518342] vcc_sd: unable to resolve supply
[    1.518358] reg-fixed-voltage vcc-host-5v-regulator: Looking up vin-supply from device tree
[    1.518407] vcc_host_5v: unable to resolve supply
[    1.518424] reg-fixed-voltage vcc-host1-5v-regulator: Looking up vin-supply from device tree
[    1.518474] vcc_host1_5v: unable to resolve supply
[    1.518492] reg-fixed-voltage vcc-host1-5v-regulator: vcc_host1_5v supplying 0uV
[    1.518595] of_get_named_gpiod_flags: can't parse 'gpio' property of node '/vcc-phy-regulator[0]'
[    1.518625] vcc_phy: no parameters
[    1.518901] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.518927] vcc_sd: unable to resolve supply
[    1.518943] reg-fixed-voltage vcc-host-5v-regulator: Looking up vin-supply from device tree
[    1.518996] vcc_host_5v: unable to resolve supply
[    1.519012] reg-fixed-voltage vcc-host1-5v-regulator: Looking up vin-supply from device tree
[    1.519062] vcc_host1_5v: unable to resolve supply
[    1.519081] reg-fixed-voltage vcc-phy-regulator: vcc_phy supplying 0uV
[    1.519177] of_get_named_gpiod_flags: can't parse 'gpio' property of node '/vcc-sys[0]'
[    1.519206] vcc_sys: 5000 mV 
[    1.519497] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    1.519525] vcc_sd: unable to resolve supply
[    1.519541] reg-fixed-voltage vcc-host-5v-regulator: Looking up vin-supply from device tree
[    1.519597] vcc_host_5v: supplied by vcc_sys
[    1.519700] reg-fixed-voltage vcc-host1-5v-regulator: Looking up vin-supply from device tree
[    1.519796] vcc_host1_5v: supplied by vcc_sys
[    1.519904] reg-fixed-voltage vcc-sys: vcc_sys supplying 5000000uV
[    1.520726] iommu: Adding device ff350000.vpu_service to group 0
[    1.520861] iommu: Adding device ff351000.avsd to group 1
[    1.520985] iommu: Adding device ff360000.rkvdec to group 2
[    1.521115] iommu: Adding device ff330000.h265e to group 3
[    1.521241] iommu: Adding device ff340000.vepu to group 4
[    1.521389] iommu: Adding device ff370000.vop to group 5
[    1.521522] iommu: Adding device ff3a0000.iep to group 6
[    1.522196] rk_iommu ff350800.iommu: can't get sclk
[    1.522684] rk_iommu ff360480.iommu: can't get aclk
[    1.522740] rk_iommu ff360480.iommu: can't get hclk
[    1.522789] rk_iommu ff360480.iommu: can't get sclk
[    1.523160] rk_iommu ff330200.iommu: can't get sclk
[    1.523500] rk_iommu ff340800.iommu: can't get sclk
[    1.523781] rk_iommu ff373f00.iommu: can't get sclk
[    1.524107] rk_iommu ff3a0800.iommu: can't get sclk
[    1.524841] SCSI subsystem initialized
[    1.525179] libata version 3.00 loaded.
[    1.525554] usbcore: registered new interface driver usbfs
[    1.525673] usbcore: registered new interface driver hub
[    1.525846] usbcore: registered new device driver usb
[    1.526052] media: Linux media interface: v0.10
[    1.526149] Linux video capture interface: v2.00
[    1.526386] pps_core: LinuxPPS API ver. 1 registered
[    1.526430] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    1.526525] PTP clock support registered
[    1.528774] Advanced Linux Sound Architecture Driver Initialized.
[    1.529721] Bluetooth: Core ver 2.21
[    1.529809] NET: Registered protocol family 31
[    1.529851] Bluetooth: HCI device and connection manager initialized
[    1.529904] Bluetooth: HCI socket layer initialized
[    1.529953] Bluetooth: L2CAP socket layer initialized
[    1.530028] Bluetooth: SCO socket layer initialized
[    1.530767] NetLabel: Initializing
[    1.530814] NetLabel:  domain hash size = 128
[    1.530853] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.530980] NetLabel:  unlabeled traffic allowed by default
[    1.531550] rockchip-cpuinfo cpuinfo: Serial		: b6e8c9bb3b16f015
[    1.532994] clocksource: Switched to clocksource arch_sys_counter
[    1.667399] NET: Registered protocol family 2
[    1.668185] TCP established hash table entries: 8192 (order: 4, 65536 bytes)
[    1.668360] TCP bind hash table entries: 8192 (order: 6, 262144 bytes)
[    1.668754] TCP: Hash tables configured (established 8192 bind 8192)
[    1.668887] UDP hash table entries: 512 (order: 3, 49152 bytes)
[    1.669070] UDP-Lite hash table entries: 512 (order: 3, 49152 bytes)
[    1.669481] NET: Registered protocol family 1
[    1.669967] RPC: Registered named UNIX socket transport module.
[    1.670018] RPC: Registered udp transport module.
[    1.670059] RPC: Registered tcp transport module.
[    1.670100] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.670338] PCI: CLS 0 bytes, default 64
[    1.671060] Trying to unpack rootfs image as initramfs...
[    2.085209] Freeing initrd memory: 5492K
[    2.086662] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
[    2.088077] kvm [1]: 8-bit VMID
[    2.088119] kvm [1]: Hyp mode initialized successfully
[    2.088660] kvm [1]: interrupt-controller@ff814000 IRQ48
[    2.089055] kvm [1]: timer IRQ3
[    2.093348] audit: initializing netlink subsys (disabled)
[    2.093444] audit: type=2000 audit(2.008:1): initialized
[    2.094610] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.107870] VFS: Disk quotas dquot_6.6.0
[    2.108170] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.110773] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.112879] NFS: Registering the id_resolver key type
[    2.112967] Key type id_resolver registered
[    2.113045] Key type id_legacy registered
[    2.113112] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    2.114247] fuse init (API version 7.23)
[    2.115535] JFS: nTxBlock = 7854, nTxLock = 62835
[    2.122049] SGI XFS with ACLs, security attributes, realtime, no debug enabled
[    2.126125] Key type big_key registered
[    2.126270] 
               TEE Core Framework initialization (ver 1:0.1)
[    2.126364] TEE armv7 Driver initialization
[    2.126905] tz_tee_probe: name="armv7sec", id=0, pdev_name="armv7sec.0"
[    2.126957] TEE core: Alloc the misc device "opteearmtz00" (id=0)
[    2.127337] TEE Core: Register the misc device "opteearmtz00" (id=0,minor=62)
[    2.133315] NET: Registered protocol family 38
[    2.133413] Key type asymmetric registered
[    2.133464] Asymmetric key parser 'x509' registered
[    2.133837] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    2.134123] io scheduler noop registered
[    2.134179] io scheduler deadline registered (default)
[    2.134290] io scheduler cfq registered
[    2.135795] phy phy-ff450000.syscon:usb2-phy@100.0: Looking up phy-supply from device tree
[    2.135917] vcc_host1_5v: could not add device link phy-ff450000.syscon:usb2-phy@100.0 err -2
[    2.136453] phy phy-ff450000.syscon:usb2-phy@100.1: Looking up phy-supply from device tree
[    2.136562] vcc_host1_5v: could not add device link phy-ff450000.syscon:usb2-phy@100.1 err -2
[    2.137094] phy phy-ff450000.syscon:usb2-phy@100.1: Looking up vbus-supply from device tree
[    2.137117] phy phy-ff450000.syscon:usb2-phy@100.1: Looking up vbus-supply property in node /syscon@ff450000/usb2-phy@100/otg-port failed
[    2.137143] phy phy-ff450000.syscon:usb2-phy@100.1: Failed to get VBUS supply regulator
[    2.138262] rockchip-u3phy ff470000.usb3-phy: Looking up vbus-supply from device tree
[    2.138286] rockchip-u3phy ff470000.usb3-phy: Looking up vbus-supply property in node /usb3-phy@ff470000 failed
[    2.138311] rockchip-u3phy ff470000.usb3-phy: Failed to get VBUS supply regulator
[    2.138839] phy phy-ff470000.usb3-phy.2: Looking up phy-supply from device tree
[    2.138859] phy phy-ff470000.usb3-phy.2: Looking up phy-supply property in node /usb3-phy@ff470000/utmi@ff470000 failed
[    2.139267] phy phy-ff470000.usb3-phy.3: Looking up phy-supply from device tree
[    2.139287] phy phy-ff470000.usb3-phy.3: Looking up phy-supply property in node /usb3-phy@ff470000/pipe@ff478000 failed
[    2.141063] rockchip-u3phy ff470000.usb3-phy: Rockchip u3phy initialized successfully
[    2.141916] phy phy-ff430000.hdmiphy.4: Looking up phy-supply from device tree
[    2.141938] phy phy-ff430000.hdmiphy.4: Looking up phy-supply property in node /hdmiphy@ff430000 failed
[    2.145959] iep: failed to find iep power down clock source.
[    2.146651] IEP Power ON
[    2.146986] IEP Power OFF
[    2.147064] IEP Driver loaded succesfully
[    2.147316] Module initialized.
[    2.147745] rk-vcodec vpu_combo: Looking up vcodec-supply from device tree
[    2.147765] rk-vcodec vpu_combo: Looking up vcodec-supply property in node /vpu_combo failed
[    2.147790] rk-vcodec vpu_combo: no regulator for vcodec
[    2.148099] rk-vcodec vpu_combo: failed on clk_get clk_cabac
[    2.148154] rk-vcodec vpu_combo: failed on clk_get clk_core
[    2.148289] platform ff350000.vpu_service: probe device
[    2.148651] platform ff350000.vpu_service: drm allocator with mmu enabled
[    2.149684] platform ff351000.avsd: probe device
[    2.150151] platform ff351000.avsd: drm allocator with mmu enabled
[    2.152306] rk-vcodec vpu_combo: could not find power_model node
[    2.152362] rk-vcodec vpu_combo: init success
[    2.152743] rk-vcodec ff360000.rkvdec: Looking up vcodec-supply from device tree
[    2.152777] rk-vcodec ff360000.rkvdec: vcodec regulator not ready, retry
[    2.153842] probe device ff330000.h265e
[    2.154264] mpp_dev ff330000.h265e: try to get iommu dev ffffffc03e03e810
[    2.154786] mpp_dev ff330000.h265e: resource ready, register device
[    2.155318] probe device ff340000.vepu
[    2.155710] mpp_dev ff340000.vepu: try to get iommu dev ffffffc03e03f010
[    2.156137] mpp_dev ff340000.vepu: resource ready, register device
[    2.159385] dma-pl330 ff1f0000.dmac: Loaded driver for PL330 DMAC-241330
[    2.159447] dma-pl330 ff1f0000.dmac: 	DBUFF-128x8bytes Num_Chans-8 Num_Peri-20 Num_Events-16
[    2.160617] Serial: 8250/16550 driver, 5 ports, IRQ sharing disabled
[    2.161554] ff130000.serial: ttyS2 at MMIO 0xff130000 (irq = 13, base_baud = 1500000) is a 16550A
[    2.281912] console [ttyS2] enabled
[    2.284028] [drm] Initialized drm 1.1.0 20060810
[    2.289786] [drm] Rockchip DRM driver version: v1.0.1
[    2.290511] rockchip-drm display-subsystem: devfreq is not set
[    2.291794] rockchip-drm display-subsystem: bound ff370000.vop (ops 0xffffff8008d86950)
[    2.292969] i2c i2c-4: of_i2c: modalias failure on /hdmi@ff3c0000/ports
[    2.293659] dwhdmi-rockchip ff3c0000.hdmi: registered DesignWare HDMI I2C bus driver
[    2.294537] dwhdmi-rockchip ff3c0000.hdmi: Detected HDMI TX controller v2.11a with HDCP (inno_dw_hdmi_phy2)
[    2.296637] rockchip-drm display-subsystem: bound ff3c0000.hdmi (ops 0xffffff8008d7afa8)
[    2.297476] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.298096] [drm] No driver support for vblank timestamp query.
[    2.298745] rockchip-drm display-subsystem: failed to parse display resources
[    2.299455] rockchip-drm display-subsystem: No connectors reported connected with modes
[    2.300284] [drm] Cannot find any crtc or sizes - going 1024x768
[    2.326202] Console: switching to colour frame buffer device 128x48
[    2.345004] rockchip-drm display-subsystem: fb0:  frame buffer device
[    2.358751] usbcore: registered new interface driver udl
[    2.363023] Unable to detect cache hierarchy for CPU 0
[    2.364919] brd: module loaded
[    2.374070] loop: module loaded
[    2.374539] lkdtm: No crash points registered, enable through debugfs
[    2.377814] rockchip-spi ff190000.spi: no high_speed pinctrl state
[    2.379524] m25p80 spi32766.0: gd25q128 (16384 Kbytes)
[    2.380217] 1 ofpart partitions found on MTD device spi32766.0
[    2.380959] Creating 1 MTD partitions on "spi32766.0":
[    2.381655] 0x000000008000-0x0000003f8000 : "loader"
[    2.386493] rk_gmac-dwmac ff540000.ethernet: Looking up phy-supply from device tree
[    2.386633] rk_gmac-dwmac ff540000.ethernet: clock input or output? (input).
[    2.387548] rk_gmac-dwmac ff540000.ethernet: TX delay(0x26).
[    2.388273] rk_gmac-dwmac ff540000.ethernet: RX delay(0x11).
[    2.389057] rk_gmac-dwmac ff540000.ethernet: integrated PHY? (no).
[    2.390095] rk_gmac-dwmac ff540000.ethernet: cannot get clock clk_mac_speed
[    2.390977] rk_gmac-dwmac ff540000.ethernet: clock input from PHY
[    2.396770] rk_gmac-dwmac ff540000.ethernet: init for RGMII
[    2.405111] stmmac - user ID: 0x10, Synopsys ID: 0x35
[    2.413095]  Ring mode enabled
[    2.420756]  DMA HW capability register supported
[    2.421353]  Normal descriptors
[    2.436037]  RX Checksum Offload Engine supported (type 2)
[    2.443835]  TX Checksum insertion supported
[    2.451485]  Enable RX Mitigation via HW Watchdog Timer
[    2.459446] of_get_named_gpiod_flags: parsed 'snps,reset-gpio' property of node '/ethernet@ff540000[0]' - status (0)
[    2.555189] libphy: stmmac: probed
[    2.562781] eth%d: PHY ID 001cc916 at 0 IRQ POLL (stmmac-0:00) active
[    2.570761] eth%d: PHY ID 001cc916 at 1 IRQ POLL (stmmac-0:01)
[    2.580087] Rockchip WiFi SYS interface (V1.00) ... 
[    2.587836] usbcore: registered new interface driver cdc_ether
[    2.595543] usbcore: registered new interface driver rndis_host
[    2.605224] phy phy-ff470000.usb3-phy.2: u3phy u2 power on
[    2.612628] phy phy-ff470000.usb3-phy.3: u3phy u3 power on
[    2.620966] dwc2 ff580000.usb: Looking up vusb_d-supply from device tree
[    2.621026] dwc2 ff580000.usb: Looking up vusb_d-supply property in node /usb@ff580000 failed
[    2.621049] ff580000.usb supply vusb_d not found, using dummy regulator
[    2.628368] dwc2 ff580000.usb: Looking up vusb_a-supply from device tree
[    2.628389] dwc2 ff580000.usb: Looking up vusb_a-supply property in node /usb@ff580000 failed
[    2.628406] ff580000.usb supply vusb_a not found, using dummy regulator
[    2.648068] dwc2 ff580000.usb: DWC OTG Controller
[    2.654882] dwc2 ff580000.usb: new USB bus registered, assigned bus number 1
[    2.661920] dwc2 ff580000.usb: irq 45, io mem 0xff580000
[    2.668948] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.675959] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.682910] usb usb1: Product: DWC OTG Controller
[    2.689539] usb usb1: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 dwc2_hsotg
[    2.696714] usb usb1: SerialNumber: ff580000.usb
[    2.704312] hub 1-0:1.0: USB hub found
[    2.710957] hub 1-0:1.0: 1 port detected
[    2.718778] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.725704] ehci-pci: EHCI PCI platform driver
[    2.732510] ehci-platform: EHCI generic platform driver
[    2.741928] ehci-platform ff5c0000.usb: EHCI Host Controller
[    2.749056] ehci-platform ff5c0000.usb: new USB bus registered, assigned bus number 2
[    2.756223] ehci-platform ff5c0000.usb: irq 46, io mem 0xff5c0000
[    2.773034] ehci-platform ff5c0000.usb: USB 2.0 started, EHCI 1.00
[    2.780026] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    2.786857] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.793672] usb usb2: Product: EHCI Host Controller
[    2.800276] usb usb2: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 ehci_hcd
[    2.807531] usb usb2: SerialNumber: ff5c0000.usb
[    2.815290] hub 2-0:1.0: USB hub found
[    2.822215] hub 2-0:1.0: 1 port detected
[    2.829761] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.837035] ohci-platform: OHCI generic platform driver
[    2.844691] ohci-platform ff5d0000.usb: Generic Platform OHCI controller
[    2.852381] ohci-platform ff5d0000.usb: new USB bus registered, assigned bus number 3
[    2.859996] ohci-platform ff5d0000.usb: irq 47, io mem 0xff5d0000
[    2.925284] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    2.932709] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.940184] usb usb3: Product: Generic Platform OHCI controller
[    2.947538] usb usb3: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 ohci_hcd
[    2.955295] usb usb3: SerialNumber: ff5d0000.usb
[    2.963472] hub 3-0:1.0: USB hub found
[    2.970877] hub 3-0:1.0: 1 port detected
[    2.979470] xhci-hcd xhci-hcd.10.auto: xHCI Host Controller
[    2.987259] xhci-hcd xhci-hcd.10.auto: new USB bus registered, assigned bus number 4
[    2.995288] xhci-hcd xhci-hcd.10.auto: hcc params 0x0220fe64 hci version 0x110 quirks 0x04210010
[    3.003278] xhci-hcd xhci-hcd.10.auto: irq 183, io mem 0xff600000
[    3.011420] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    3.019274] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.027287] usb usb4: Product: xHCI Host Controller
[    3.035010] usb usb4: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 xhci-hcd
[    3.043274] usb usb4: SerialNumber: xhci-hcd.10.auto
[    3.052070] hub 4-0:1.0: USB hub found
[    3.059837] hub 4-0:1.0: 1 port detected
[    3.067998] xhci-hcd xhci-hcd.10.auto: xHCI Host Controller
[    3.076095] xhci-hcd xhci-hcd.10.auto: new USB bus registered, assigned bus number 5
[    3.084230] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
[    3.092470] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003
[    3.100438] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.108537] usb usb5: Product: xHCI Host Controller
[    3.116357] usb usb5: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 xhci-hcd
[    3.116371] usb usb5: SerialNumber: xhci-hcd.10.auto
[    3.117322] hub 5-0:1.0: USB hub found
[    3.117369] hub 5-0:1.0: 1 port detected
[    3.119549] usbcore: registered new interface driver iforce
[    3.119668] usbcore: registered new interface driver xpad
[    3.120184] usbcore: registered new interface driver usbtouchscreen
[    3.120624] .. rk pwm remotectl v1.1 init
[    3.121182] input: ff1b0030.pwm as /devices/platform/ff1b0030.pwm/input/input0
[    3.122819] i2c /dev entries driver
[    3.124131] rk3x-i2c ff150000.i2c: Initialized RK3xxx I2C bus at ffffff8009d38000
[    3.126546] rk808 1-0018: Pmic Chip id: 0x8050
[    3.127613] rk808 1-0018: source: on=0x10, off=0x02
[    3.134059] rk808 1-0018: Looking up vcc1-supply from device tree
[    3.134200] DCDC_REG1: supplied by vcc_sys
[    3.134213] vcc_sys: could not add device link regulator.6 err -2
[    3.136803] vdd_logic: 712 <--> 1450 mV at 1100 mV 
[    3.137241] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    3.137275] vcc_sd: unable to resolve supply
[    3.137300] rk808 1-0018: Looking up vcc2-supply from device tree
[    3.137413] DCDC_REG2: supplied by vcc_sys
[    3.137425] vcc_sys: could not add device link regulator.7 err -2
[    3.139490] vdd_arm: 712 <--> 1450 mV at 1100 mV 
[    3.139875] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    3.139903] vcc_sd: unable to resolve supply
[    3.139928] rk808 1-0018: Looking up vcc3-supply from device tree
[    3.140024] DCDC_REG3: supplied by vcc_sys
[    3.140034] vcc_sys: could not add device link regulator.8 err -2
[    3.141272] vcc_ddr: at 5000 mV 
[    3.141630] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    3.141659] vcc_sd: unable to resolve supply
[    3.141687] rk808 1-0018: Looking up vcc4-supply from device tree
[    3.141783] DCDC_REG4: supplied by vcc_sys
[    3.141794] vcc_sys: could not add device link regulator.9 err -2
[    3.143035] vcc_io: 3300 mV 
[    3.143423] reg-fixed-voltage sdmmc-regulator: Looking up vin-supply from device tree
[    3.143449] vcc_sd: supplied by vcc_io
[    3.143530] rk808 1-0018: Looking up vcc5-supply from device tree
[    3.143552] LDO_REG1: supplied by vcc_io
[    3.143562] vcc_io: could not add device link regulator.10 err -2
[    3.145911] vdd_18: 1800 mV 
[    3.146781] rk808 1-0018: Looking up vcc5-supply from device tree
[    3.146809] LDO_REG2: supplied by vcc_io
[    3.146820] vcc_io: could not add device link regulator.11 err -2
[    3.149158] vcc18_emmc: 1800 mV 
[    3.150039] rk808 1-0018: Looking up vcc6-supply from device tree
[    3.150163] LDO_REG3: supplied by vcc_sys
[    3.150174] vcc_sys: could not add device link regulator.12 err -2
[    3.152514] vdd_10: 1000 mV 
[    3.153362] rk808 1-0018: register rk8050 regulators
[    3.153598] gpiochip_find_base: found new base at 510
[    3.153743] gpiochip_add_data: registered GPIOs 510 to 511 on device: rk8xx-gpio
[    3.153753] rk8xx-gpio rk8xx-gpio: register rk8050 gpio successful
[    3.155818] input: rk8xx_pwrkey as /devices/platform/ff160000.i2c/i2c-1/1-0018/input/input1
[    3.165832] rk808-rtc rk808-rtc: rtc core: registered rk808-rtc as rtc0
[    3.166673] rk3x-i2c ff160000.i2c: Initialized RK3xxx I2C bus at ffffff8009d3a000
[    3.168512] IR NEC protocol handler initialized
[    3.168521] IR RC5(x/sz) protocol handler initialized
[    3.168531] IR RC6 protocol handler initialized
[    3.168539] IR JVC protocol handler initialized
[    3.168548] IR Sony protocol handler initialized
[    3.168557] IR SANYO protocol handler initialized
[    3.168566] IR Sharp protocol handler initialized
[    3.168576] IR MCE Keyboard/mouse protocol handler initialized
[    3.168585] IR XMP protocol handler initialized
[    3.169871] usbcore: registered new interface driver uvcvideo
[    3.169874] USB Video Class driver (1.1.1)
[    3.170531] rockchip-iodomain ff100000.syscon:io-domains: Looking up vccio1-supply from device tree
[    3.170687] rockchip-iodomain ff100000.syscon:io-domains: Looking up vccio2-supply from device tree
[    3.171301] rockchip-iodomain ff100000.syscon:io-domains: Looking up vccio3-supply from device tree
[    3.171400] rockchip-iodomain ff100000.syscon:io-domains: Looking up vccio4-supply from device tree
[    3.171961] rockchip-iodomain ff100000.syscon:io-domains: Looking up vccio5-supply from device tree
[    3.172081] rockchip-iodomain ff100000.syscon:io-domains: Looking up vccio6-supply from device tree
[    3.172164] rockchip-iodomain ff100000.syscon:io-domains: Looking up pmuio-supply from device tree
[    3.175260] rockchip-thermal ff250000.tsadc: tsadc is probed successfully!
[    3.176787] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[    3.176804] Bluetooth: Virtual HCI driver ver 1.5
[    3.177021] Bluetooth: HCI UART driver ver 2.3
[    3.177028] Bluetooth: HCI UART protocol H4 registered
[    3.177032] Bluetooth: HCI UART protocol LL registered
[    3.177036] Bluetooth: HCI UART protocol ATH3K registered
[    3.177148] usbcore: registered new interface driver bfusb
[    3.177256] usbcore: registered new interface driver btusb
[    3.177661] cpu cpu0: leakage=11
[    3.177678] cpu cpu0: leakage-volt-sel=1
[    3.177722] cpu cpu0: Looking up cpu-supply from device tree
[    3.177821] cpu cpu0: Failed to get pvtm
[    3.178315] cpu cpu0: Looking up cpu-supply from device tree
[    3.178494] cpu cpu0: Looking up cpu-supply from device tree
[    3.180496] sdhci: Secure Digital Host Controller Interface driver
[    3.180500] sdhci: Copyright(c) Pierre Ossman
[    3.180511] Synopsys Designware Multimedia Card Interface Driver
[    3.182037] dwmmc_rockchip ff520000.dwmmc: IDMAC supports 32-bit address mode.
[    3.182072] dwmmc_rockchip ff520000.dwmmc: Using internal DMA controller.
[    3.182087] dwmmc_rockchip ff520000.dwmmc: Version ID is 270a
[    3.182161] dwmmc_rockchip ff520000.dwmmc: DW MMC controller at irq 42,32 bit host data width,256 deep fifo
[    3.182201] dwmmc_rockchip ff520000.dwmmc: Looking up vmmc-supply from device tree
[    3.182314] dwmmc_rockchip ff520000.dwmmc: Looking up vqmmc-supply from device tree
[    3.182939] dwmmc_rockchip ff520000.dwmmc: GPIO lookup for consumer wp
[    3.182947] dwmmc_rockchip ff520000.dwmmc: using device tree for GPIO lookup
[    3.182960] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/dwmmc@ff520000[0]'
[    3.182970] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/dwmmc@ff520000[0]'
[    3.182978] dwmmc_rockchip ff520000.dwmmc: using lookup tables for GPIO lookup
[    3.182988] dwmmc_rockchip ff520000.dwmmc: lookup for GPIO wp failed
[    3.197042] mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    3.214073] dwmmc_rockchip ff520000.dwmmc: 1 slots initialized
[    3.216694] dwmmc_rockchip ff500000.dwmmc: IDMAC supports 32-bit address mode.
[    3.216725] dwmmc_rockchip ff500000.dwmmc: Using internal DMA controller.
[    3.216735] dwmmc_rockchip ff500000.dwmmc: Version ID is 270a
[    3.216781] dwmmc_rockchip ff500000.dwmmc: DW MMC controller at irq 43,32 bit host data width,256 deep fifo
[    3.216805] dwmmc_rockchip ff500000.dwmmc: Looking up vmmc-supply from device tree
[    3.216937] dwmmc_rockchip ff500000.dwmmc: Looking up vqmmc-supply from device tree
[    3.217095] dwmmc_rockchip ff500000.dwmmc: GPIO lookup for consumer cd
[    3.217101] dwmmc_rockchip ff500000.dwmmc: using device tree for GPIO lookup
[    3.217109] of_get_named_gpiod_flags: can't parse 'cd-gpios' property of node '/dwmmc@ff500000[0]'
[    3.217115] of_get_named_gpiod_flags: can't parse 'cd-gpio' property of node '/dwmmc@ff500000[0]'
[    3.217120] dwmmc_rockchip ff500000.dwmmc: using lookup tables for GPIO lookup
[    3.217126] dwmmc_rockchip ff500000.dwmmc: lookup for GPIO cd failed
[    3.217133] dwmmc_rockchip ff500000.dwmmc: GPIO lookup for consumer wp
[    3.217138] dwmmc_rockchip ff500000.dwmmc: using device tree for GPIO lookup
[    3.217143] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/dwmmc@ff500000[0]'
[    3.217149] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/dwmmc@ff500000[0]'
[    3.217153] dwmmc_rockchip ff500000.dwmmc: using lookup tables for GPIO lookup
[    3.217158] dwmmc_rockchip ff500000.dwmmc: lookup for GPIO wp failed
[    3.233043] mmc_host mmc0: Bus speed (slot 0) = 300000Hz (slot req 300000Hz, actual 300000HZ div = 0)
[    3.233137] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
[    3.250086] dwmmc_rockchip ff500000.dwmmc: 1 slots initialized
[    3.255321] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.255848] of_get_named_gpiod_flags: parsed 'gpios' property of node '/leds/work-led[0]' - status (0)
[    3.260194] of_get_named_gpiod_flags: parsed 'gpios' property of node '/leds/standby-led[0]' - status (0)
[    3.260755] of_get_named_gpiod_flags: parsed 'gpios' property of node '/switches/usb-switch[0]' - status (0)
[    3.260761] gpio-2 (vcc_host1_5v): gpiod_request: status -16
[    3.260766] of_get_named_gpiod_flags: can't parse 'gpio' property of node '/switches/usb-switch[0]'
[    3.260777] leds-gpio: probe of switches failed with error -2
[    3.260943] hidraw: raw HID events driver (C) Jiri Kosina
[    3.264138] usbcore: registered new interface driver usbhid
[    3.264140] usbhid: USB HID core driver
[    3.265321] rockchip-dmc dmc: unable to get devfreq-event device : dfi
[    3.266678] usbcore: registered new interface driver snd-usb-audio
[    3.267765] rk3328-codec ff410000.codec: spk_depop_time use default value.
[    3.272630] u32 classifier
[    3.272644] Netfilter messages via NETLINK v0.30.
[    3.272698] ip_set: protocol 6
[    3.272872] Initializing XFRM netlink socket
[    3.273088] mmc_host mmc0: Bus speed (slot 0) = 200000Hz (slot req 200000Hz, actual 200000HZ div = 0)
[    3.273626] NET: Registered protocol family 10
[    3.274321] NET: Registered protocol family 17
[    3.274340] NET: Registered protocol family 15
[    3.274368] bridge: automatic filtering via arp/ip/ip6tables has been deprecated. Update your scripts to load br_netfilter if you need this.
[    3.274389] Bridge firewalling registered
[    3.274478] Bluetooth: RFCOMM socket layer initialized
[    3.274505] Bluetooth: RFCOMM ver 1.11
[    3.274522] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    3.274530] Bluetooth: HIDP socket layer initialized
[    3.274586] 8021q: 802.1Q VLAN Support v1.8
[    3.274611] [WLAN_RFKILL]: Enter rfkill_wlan_init
[    3.274887] [BT_RFKILL]: Enter rfkill_rk_init
[    3.275046] Key type dns_resolver registered
[    3.278968] Registered cp15_barrier emulation handler
[    3.282373] Registered setend emulation handler
[    3.283017] registered taskstats version 1
[    3.284642] Btrfs loaded, integrity-checker=on
[    3.284718] BTRFS: selftest: Running btrfs free space cache tests
[    3.284745] BTRFS: selftest: Running extent only tests
[    3.284761] BTRFS: selftest: Running bitmap only tests
[    3.284779] BTRFS: selftest: Running bitmap and extent tests
[    3.284798] BTRFS: selftest: Running space stealing from bitmap to extent
[    3.285618] BTRFS: selftest: Free space cache tests finished
[    3.285622] BTRFS: selftest: Running extent buffer operation tests
[    3.285622] BTRFS: selftest: Running btrfs_split_item tests
[    3.285660] BTRFS: selftest: Running find delalloc tests
[    3.309095] mmc_host mmc0: Bus speed (slot 0) = 100000Hz (slot req 100000Hz, actual 100000HZ div = 0)
[    3.310974] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
[    3.311031] mmc1: new high speed SDHC card at address e624
[    3.311541] mmcblk1: mmc1:e624 SB16G 14.8 GiB 
[    3.318337]  mmcblk1: p1 p2 p3 p4 p5 p6 p7
[    3.503614] BTRFS: selftest: Running btrfs_get_extent tests
[    3.503810] BTRFS: selftest: Running hole first btrfs_get_extent test
[    3.503841] BTRFS: selftest: Running outstanding_extents tests
[    3.503897] BTRFS: selftest: Running qgroup tests
[    3.503900] BTRFS: selftest: Qgroup basic add
[    3.503970] BTRFS: selftest: Qgroup multiple refs test
[    3.620931] Key type encrypted registered
[    3.624792] rockchip ion idev is NULL
[    3.627990] rga2 ff390000.rga: rga ion client create success!
[    3.631560] rga: Driver loaded successfully ver:4.00
[    3.635012] rga2: Module initialized.
[    3.638547] rk-vcodec ff360000.rkvdec: Looking up vcodec-supply from device tree
[    3.638643] rk-vcodec ff360000.rkvdec: parent devfreq retry
[    3.642750] rockchip-dmc dmc: Looking up center-supply from device tree
[    3.642844] rockchip-dmc dmc: current ATF version 0x101!
[    3.646256] rockchip-dmc dmc: read tf version 0x101!
[    3.650754] rockchip-dmc dmc: leakage=10
[    3.653743] rockchip-dmc dmc: leakage-volt-sel=0
[    3.656734] rockchip-dmc dmc: Looking up center-supply from device tree
[    3.656768] vdd_logic: could not add device link dmc err -17
[    3.656781] vdd_logic: Failed to create debugfs directory
[    3.656794] rockchip-dmc dmc: Failed to get pvtm
[    3.659944] rockchip-dmc dmc: failed to get vop bandwidth to dmc rate
[    3.663099] rockchip-dmc dmc: failed to get vop pn to msch rl
[    3.667282] of_get_named_gpiod_flags: can't parse 'simple-audio-card,hp-det-gpio' property of node '/hdmi-sound[0]'
[    3.667294] of_get_named_gpiod_flags: can't parse 'simple-audio-card,mic-det-gpio' property of node '/hdmi-sound[0]'
[    3.667800] asoc-simple-card hdmi-sound: i2s-hifi <-> ff000000.i2s mapping ok
[    3.672141] of_get_named_gpiod_flags: can't parse 'simple-audio-card,hp-det-gpio' property of node '/headphones-sound[0]'
[    3.672154] of_get_named_gpiod_flags: can't parse 'simple-audio-card,mic-det-gpio' property of node '/headphones-sound[0]'
[    3.692856] asoc-simple-card headphones-sound: rk3328-hifi <-> ff010000.i2s mapping ok
[    3.696719] asoc-simple-card headphones-sound: snd-soc-dummy-dai <-> ff010000.i2s mapping ok
[    3.701600] of_get_named_gpiod_flags: can't parse 'simple-audio-card,hp-det-gpio' property of node '/spdif-sound[0]'
[    3.701612] of_get_named_gpiod_flags: can't parse 'simple-audio-card,mic-det-gpio' property of node '/spdif-sound[0]'
[    3.702020] asoc-simple-card spdif-sound: dit-hifi <-> ff030000.spdif mapping ok
[    3.706290] rk-vcodec ff360000.rkvdec: Looking up vcodec-supply from device tree
[    3.706372] rk-vcodec ff360000.rkvdec: parent devfreq is ok
[    3.709987] rk-vcodec ff360000.rkvdec: leakage=10
[    3.713104] rk-vcodec ff360000.rkvdec: leakage-volt-sel=0
[    3.716242] rk-vcodec ff360000.rkvdec: Looking up vcodec-supply from device tree
[    3.716276] vdd_logic: could not add device link ff360000.rkvdec err -17
[    3.716289] vdd_logic: Failed to create debugfs directory
[    3.716302] rk-vcodec ff360000.rkvdec: Failed to get pvtm
[    3.719815] rk-vcodec ff360000.rkvdec: probe device
[    3.723241] rk-vcodec ff360000.rkvdec: drm allocator with mmu enabled
[    3.727157] rk-vcodec ff360000.rkvdec: init success
[    3.732376] rk808-rtc rk808-rtc: setting system clock to 2020-09-13 19:07:00 UTC (1600024020)
[    3.735939] of_cfs_init
[    3.738928] of_cfs_init: OK
[    3.753482] ALSA device list:
[    3.756450]   #0: rk-hdmi-sound
[    3.759389]   #1: rk-i2s-sound
[    3.762292]   #2: rk-spdif-sound
[    3.765401] of_dma_request_slave_channel: dma-names property of node '/serial@ff130000' missing or empty
[    3.768959] ttyS2 - failed to request DMA, use interrupt mode
[    3.772681] Freeing unused kernel memory: 1216K
[    3.821485] random: systemd-udevd: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.824520] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.824666] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.825054] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.825411] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.825685] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.825945] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.826267] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.826519] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    3.826975] random: udevadm: uninitialized urandom read (16 bytes read, 7 bits of entropy available)
[    4.237134] md: linear personality registered for level -1
[    4.246007] md: multipath personality registered for level -4
[    4.252942] md: raid0 personality registered for level 0
[    4.260314] md: raid1 personality registered for level 1
[    4.267372] async_tx: api initialized (async)
[    4.274937] md: raid6 personality registered for level 6
[    4.278065] md: raid5 personality registered for level 5
[    4.281106] md: raid4 personality registered for level 4
[    4.295078] md: raid10 personality registered for level 10
[    5.037255] EXT4-fs (mmcblk1p7): recovery complete
[    5.049344] EXT4-fs (mmcblk1p7): mounted filesystem with writeback data mode. Opts: (null)
[    5.613354] ip_tables: (C) 2000-2006 Netfilter Core Team
[    5.651242] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    5.671325] systemd[1]: Detected architecture arm64.
[    5.700590] systemd[1]: Set hostname to <rock64>.
[    6.149046] iep dpi mode inactivity
[    6.985435] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[    7.001503] systemd[1]: Listening on RPCbind Server Activation Socket.
[    7.017601] systemd[1]: Listening on udev Control Socket.
[    7.029537] systemd[1]: Listening on udev Kernel Socket.
[    7.042177] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    7.057501] systemd[1]: Listening on fsck to fsckd communication Socket.
[    7.075973] systemd[1]: Created slice User and Session Slice.
[    7.089397] systemd[1]: Reached target Swap.
[    7.101672] systemd[1]: Listening on Journal Socket.
[    7.117668] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    7.133656] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    7.149596] systemd[1]: Listening on Syslog Socket.
[    7.165609] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    7.181343] systemd[1]: Reached target Encrypted Volumes.
[    7.193821] systemd[1]: Listening on Journal Audit Socket.
[    7.209507] systemd[1]: Listening on LVM2 poll daemon socket.
[    7.221472] systemd[1]: Listening on LVM2 metadata daemon socket.
[    7.233539] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.247688] systemd[1]: Created slice System Slice.
[    7.266515] systemd[1]: Mounting NFSD configuration filesystem...
[    7.287289] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[    7.307041] systemd[1]: Starting Journal Service...
[    7.320180] systemd[1]: Starting Restore / save the current clock...
[    7.337298] systemd[1]: Mounting POSIX Message Queue File System...
[    7.351609] systemd[1]: Mounting RPC Pipe File System...
[    7.363460] systemd[1]: Created slice system-getty.slice.
[    7.377071] systemd[1]: Starting Create list of required static device nodes for the current kernel...
[    7.391176] systemd[1]: Created slice system-serial\x2dgetty.slice.
[    7.412824] systemd[1]: Starting Load Kernel Modules...
[    7.424941] systemd[1]: Mounting Debug File System...
[    7.433761] systemd[1]: Mounting Huge Pages File System...
[    7.449077] systemd[1]: Starting Remount Root and Kernel File Systems...
[    7.461342] systemd[1]: Reached target Slices.
[    7.475170] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[    7.488211] systemd[1]: Starting Nameserver information manager...
[    7.512539] systemd[1]: Mounted NFSD configuration filesystem.
[    7.525313] systemd[1]: Mounted RPC Pipe File System.
[    7.537326] systemd[1]: Mounted Debug File System.
[    7.549295] systemd[1]: Mounted POSIX Message Queue File System.
[    7.561265] systemd[1]: Mounted Huge Pages File System.
[    7.575848] systemd[1]: Started Restore / save the current clock.
[    7.588590] systemd[1]: Started Create list of required static device nodes for the current kernel.
[    7.603502] systemd[1]: Started Load Kernel Modules.
[    7.616067] systemd[1]: Started Remount Root and Kernel File Systems.
[    7.636528] systemd[1]: Started Journal Service.
[    7.815731] random: nonblocking pool is initialized
[    7.843729] systemd-journald[301]: Received request to flush runtime journal from PID 1
[    9.506624] I : [File] : drivers/gpu/arm/mali400/mali/linux/mali_kernel_linux.c; [Line] : 417; [Func] : mali_module_init(); svn_rev_string_from_arm of this mali_ko is '', rk_ko_ver is '5', built at '08:53:19', on 'Aug 28 2019'.
[    9.517966] mali-utgard ff300000.gpu: mali_platform_device->num_resources = 9
[    9.522210] mali-utgard ff300000.gpu: resource[0].start = 0x0x00000000ff300000
[    9.526466] mali-utgard ff300000.gpu: resource[1].start = 0x0x00000000ff300000
[    9.530676] mali-utgard ff300000.gpu: resource[2].start = 0x0x0000000000000014
[    9.534801] mali-utgard ff300000.gpu: resource[3].start = 0x0x0000000000000015
[    9.538836] mali-utgard ff300000.gpu: resource[4].start = 0x0x0000000000000016
[    9.542818] mali-utgard ff300000.gpu: resource[5].start = 0x0x0000000000000017
[    9.542825] mali-utgard ff300000.gpu: resource[6].start = 0x0x0000000000000018
[    9.542829] mali-utgard ff300000.gpu: resource[7].start = 0x0x0000000000000019
[    9.542837] mali-utgard ff300000.gpu: resource[8].start = 0x0x000000000000001a
[    9.542843] D : [File] : drivers/gpu/arm/mali400/mali/platform/rk/rk.c; [Line] : 623; [Func] : mali_platform_device_init(); to add platform_specific_data to platform_device_of_mali.
[    9.553764] mali-utgard ff300000.gpu: Looking up mali-supply from device tree
[    9.553935] mali-utgard ff300000.gpu: leakage=10
[    9.553944] mali-utgard ff300000.gpu: leakage-volt-sel=0
[    9.553979] mali-utgard ff300000.gpu: Looking up mali-supply from device tree
[    9.554008] vdd_logic: could not add device link ff300000.gpu err -17
[    9.554016] vdd_logic: Failed to create debugfs directory
[    9.554025] mali-utgard ff300000.gpu: Failed to get pvtm
[    9.556247] Mali: Mali device driver loaded
[    9.653151] devfreq ff300000.gpu: Couldn't update frequency transition information.
[    9.806869] FAT-fs (mmcblk1p6): utf8 is not a recommended IO charset for FAT filesystems, filesystem will be case sensitive!
[    9.824920] FAT-fs (mmcblk1p6): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   12.337430] rk_gmac-dwmac ff540000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   34.100026] NFSD: starting 90-second grace period (net ffffff80093a3540)
[   37.325294] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf542fff4
[   37.329433] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf54300f8
[   37.333639] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf5430160
[   37.364900] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf52877e4
[   37.369364] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf544e0e8
[   37.373504] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf528b27c
[   37.377540] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf544e178
[   37.381574] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf5450b18
[   37.390912] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf52056ec
[   37.748081] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520b374
[   41.505329] nf_conntrack version 0.5.0 (7863 buckets, 31452 max)
[   41.887499] ctnetlink v0.93: registering with nfnetlink.
[   48.157547] device veth7983221 entered promiscuous mode
[   48.199892] device veth76951d7 entered promiscuous mode
[   48.202142] docker0: port 2(veth76951d7) entered forwarding state
[   48.202897] docker0: port 2(veth76951d7) entered forwarding state
[   48.206109] docker0: port 2(veth76951d7) entered disabled state
[   48.243644] docker0: port 1(veth7983221) entered disabled state
[   48.246704] device veth7983221 left promiscuous mode
[   48.247340] docker0: port 1(veth7983221) entered disabled state
[   48.291940] device veth9589b8b entered promiscuous mode
[   48.293129] docker0: port 1(veth9589b8b) entered forwarding state
[   48.294017] docker0: port 1(veth9589b8b) entered forwarding state
[   48.298807] docker0: port 1(veth9589b8b) entered disabled state
[   48.418565] device vethd39fad3 entered promiscuous mode
[   48.419608] docker0: port 3(vethd39fad3) entered forwarding state
[   48.420371] docker0: port 3(vethd39fad3) entered forwarding state
[   48.460747] docker0: port 1(veth9589b8b) entered disabled state
[   48.464065] device veth9589b8b left promiscuous mode
[   48.464675] docker0: port 1(veth9589b8b) entered disabled state
[   48.645372] device veth583c034 entered promiscuous mode
[   48.646630] docker0: port 1(veth583c034) entered forwarding state
[   48.647363] docker0: port 1(veth583c034) entered forwarding state
[   48.659676] docker0: port 3(vethd39fad3) entered disabled state
[   48.664205] device vethd39fad3 left promiscuous mode
[   48.664781] docker0: port 3(vethd39fad3) entered disabled state
[   48.777099] docker0: port 1(veth583c034) entered disabled state
[   48.786127] device veth583c034 left promiscuous mode
[   48.786737] docker0: port 1(veth583c034) entered disabled state
[   50.114940] eth0: renamed from vethe03d1e5
[   50.142369] docker0: port 2(veth76951d7) entered forwarding state
[   50.146343] docker0: port 2(veth76951d7) entered forwarding state
[   50.582478] cp15barrier_handler: 492 callbacks suppressed
[   50.586282] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520b374
[   50.601194] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520b374
[   50.605914] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   50.609846] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   50.613827] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   50.617751] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520d7cc
[   50.621628] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf53d8a84
[   50.625435] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   50.629092] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   50.632749] "Main" (1240) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   55.780543] cp15barrier_handler: 3309 callbacks suppressed
[   55.783925] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53bbc80
[   55.787646] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520b374
[   55.791287] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   55.794843] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   55.798294] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   55.801590] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d7cc
[   55.804821] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53d8a84
[   55.808085] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   55.811344] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   55.814527] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   60.787049] cp15barrier_handler: 101 callbacks suppressed
[   60.792960] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520b374
[   60.800757] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   60.807926] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   60.813367] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   60.817203] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7cc
[   60.821086] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53d8a84
[   60.824962] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   60.828726] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   60.832421] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   60.836099] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7cc
[   65.168760] docker0: port 2(veth76951d7) entered forwarding state
[   66.785296] cp15barrier_handler: 121 callbacks suppressed
[   66.797830] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53bbc80
[   66.815219] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520b374
[   66.831706] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   66.848375] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   66.861709] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   66.872896] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7cc
[   66.883811] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53d8a84
[   66.894743] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   66.905594] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   66.916066] "Threadpool work" (2426) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   71.814362] cp15barrier_handler: 100 callbacks suppressed
[   71.884992] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53bbc80
[   71.987132] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520b374
[   72.089210] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   72.191136] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   72.293167] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[   72.395147] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d7cc
[   72.497051] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53d8a84
[   72.599034] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf53d8a48
[   72.701060] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d6f4
[   72.802977] "Threadpool work" (2425) uses deprecated CP15 Barrier instruction at 0xf520d7bc
[  138.714722] docker0: port 2(veth76951d7) entered disabled state
[  138.788863] vethe03d1e5: renamed from eth0
[  139.195420] docker0: port 2(veth76951d7) entered disabled state
[  139.271091] device veth76951d7 left promiscuous mode
[  139.332481] docker0: port 2(veth76951d7) entered disabled state
[  163.848101] systemd[1]: anacron.timer: Adding 45.937163s random time.
[  163.928330] systemd[1]: apt-daily-upgrade.timer: Adding 54min 55.389748s random time.
[  164.025661] systemd[1]: apt-daily.timer: Adding 6h 56min 22.944996s random time.
[  205.919417] usb 5-1: new SuperSpeed USB device number 2 using xhci-hcd
[  206.016271] usb 5-1: New USB device found, idVendor=1058, idProduct=25a1
[  206.098995] usb 5-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[  206.186922] usb 5-1: Product: Elements 25A1
[  206.239498] usb 5-1: Manufacturer: Western Digital
[  206.299442] usb 5-1: SerialNumber: 575855314542364656395736
[  206.454930] usb-storage 5-1:1.0: USB Mass Storage device detected
[  206.530984] scsi host0: usb-storage 5-1:1.0
[  206.584139] usbcore: registered new interface driver usb-storage
[  206.664451] usbcore: registered new interface driver uas
[  206.991364] rockchip-u3phy ff470000.usb3-phy: U3 device has disconnected
[  207.074347] usb 5-1: USB disconnect, device number 2
[  207.137032] xhci-hcd xhci-hcd.10.auto: remove, state 1
[  207.201475] usb usb5: USB disconnect, device number 1
[  207.266631] xhci-hcd xhci-hcd.10.auto: USB bus 5 deregistered
[  207.338773] xhci-hcd xhci-hcd.10.auto: remove, state 1
[  207.403377] usb usb4: USB disconnect, device number 1
[  207.467768] xhci-hcd xhci-hcd.10.auto: USB bus 4 deregistered
[  207.539770] xhci-hcd xhci-hcd.10.auto: xHCI Host Controller
[  207.609732] xhci-hcd xhci-hcd.10.auto: new USB bus registered, assigned bus number 4
[  207.705768] xhci-hcd xhci-hcd.10.auto: hcc params 0x0220fe64 hci version 0x110 quirks 0x04210010
[  207.814028] xhci-hcd xhci-hcd.10.auto: irq 183, io mem 0xff600000
[  207.890267] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[  207.974787] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  208.064486] usb usb4: Product: xHCI Host Controller
[  208.126115] usb usb4: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 xhci-hcd
[  208.231654] usb usb4: SerialNumber: xhci-hcd.10.auto
[  208.295225] hub 4-0:1.0: USB hub found
[  208.343669] hub 4-0:1.0: 1 port detected
[  208.394364] xhci-hcd xhci-hcd.10.auto: xHCI Host Controller
[  208.464855] xhci-hcd xhci-hcd.10.auto: new USB bus registered, assigned bus number 5
[  208.561246] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
[  208.661974] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003
[  208.746853] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  208.837032] usb usb5: Product: xHCI Host Controller
[  208.899119] usb usb5: Manufacturer: Linux 4.4.190-1233-rockchip-ayufan-gd3f1be0ed310 xhci-hcd
[  209.005029] usb usb5: SerialNumber: xhci-hcd.10.auto
[  209.068997] hub 5-0:1.0: USB hub found
[  209.117891] hub 5-0:1.0: 1 port detected
[  209.515507] usb 5-1: new SuperSpeed USB device number 2 using xhci-hcd
[  209.612443] usb 5-1: New USB device found, idVendor=1058, idProduct=25a1
[  209.696618] usb 5-1: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[  209.786039] usb 5-1: Product: Elements 25A1
[  209.840014] usb 5-1: Manufacturer: Western Digital
[  209.901336] usb 5-1: SerialNumber: 575855314542364656395736
[  209.973161] usb-storage 5-1:1.0: USB Mass Storage device detected
[  210.050525] scsi host1: usb-storage 5-1:1.0
[  211.104182] scsi 1:0:0:0: Direct-Access     WD       Elements 25A1    1013 PQ: 0 ANSI: 6
[  211.211176] sd 1:0:0:0: [sda] Spinning up disk...
[  212.279662] ...ready
[  214.325332] sd 1:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[  214.425992] sd 1:0:0:0: [sda] 5860466688 512-byte logical blocks: (3.00 TB/2.73 TiB)
[  214.522689] sd 1:0:0:0: [sda] 4096-byte physical blocks
[  214.589712] sd 1:0:0:0: [sda] Write Protect is off
[  214.650933] sd 1:0:0:0: [sda] Mode Sense: 47 00 10 08
[  214.651411] sd 1:0:0:0: [sda] No Caching mode page found
[  214.718838] sd 1:0:0:0: [sda] Assuming drive cache: write through
[  214.796961] sd 1:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[  215.069925] sd 1:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[  215.162580] sd 1:0:0:0: [sda] Attached SCSI disk
[  236.108460] sd 1:0:0:0: [sda] Very big device. Trying to use READ CAPACITY(16).
[  236.465551] BTRFS: device label 3TBRock64 devid 1 transid 395886 /dev/dm-0
[  236.745437] BTRFS info (device dm-0): disk space caching is enabled
[  236.824343] BTRFS: has skinny extents
[  247.896844] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  248.029328] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  248.154209] BTRFS: Failed to read block groups: -5
[  248.273623] BTRFS: open_ctree failed
[  248.766064] BTRFS info (device dm-0): disk space caching is enabled
[  248.845039] BTRFS: has skinny extents
[  260.233001] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  260.362909] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  260.487709] BTRFS: Failed to read block groups: -5
[  260.592561] BTRFS: open_ctree failed
[  269.087399] BTRFS info (device dm-0): disk space caching is enabled
[  269.166329] BTRFS: has skinny extents
[  280.400256] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  280.529803] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  280.654657] BTRFS: Failed to read block groups: -5
[  280.769082] BTRFS: open_ctree failed
[  668.515191] BTRFS info (device dm-0): enabling auto recovery
[  668.586879] BTRFS info (device dm-0): disk space caching is enabled
[  668.665789] BTRFS: has skinny extents
[  680.539424] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  680.668989] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[  680.793756] BTRFS: Failed to read block groups: -5
[  680.898459] BTRFS: open_ctree failed
[ 1420.589413] BTRFS info (device dm-0): enabling auto recovery
[ 1420.661102] BTRFS info (device dm-0): disk space caching is enabled
[ 1420.740044] BTRFS: has skinny extents
[ 1432.350755] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 1432.480280] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 1432.605121] BTRFS: Failed to read block groups: -5
[ 1432.713323] BTRFS: open_ctree failed
[ 1481.397196] BTRFS info (device dm-0): allowing degraded mounts
[ 1481.471014] BTRFS info (device dm-0): disk space caching is enabled
[ 1481.549937] BTRFS: has skinny extents
[ 1492.418316] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 1492.570085] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 1492.694868] BTRFS: Failed to read block groups: -5
[ 1492.806757] BTRFS: open_ctree failed
[ 1566.464898] BTRFS info (device dm-0): allowing degraded mounts
[ 1566.538676] BTRFS info (device dm-0): disk space caching is enabled
[ 1566.617592] BTRFS: has skinny extents
[ 1577.585931] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 1577.715816] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 1577.840716] BTRFS: Failed to read block groups: -5
[ 1577.952647] BTRFS: open_ctree failed
[ 2012.869326] BTRFS info (device dm-0): enabling auto recovery
[ 2012.941148] BTRFS info (device dm-0): disk space caching is enabled
[ 2013.020126] BTRFS: has skinny extents
[ 2024.548028] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 2024.700185] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 2024.825053] BTRFS: Failed to read block groups: -5
[ 2024.931042] BTRFS: open_ctree failed
[ 2049.471978] BTRFS info (device dm-0): disk space caching is enabled
[ 2049.551004] BTRFS: has skinny extents
[ 2060.481693] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 2060.634028] BTRFS error (device dm-0): parent transid verify failed on 2639007596544 wanted 395882 found 395362
[ 2060.758893] BTRFS: Failed to read block groups: -5
[ 2060.867961] BTRFS: open_ctree failed

--Apple-Mail=_B658B118-B818-4D1F-99B7-178C0AB701C3--
