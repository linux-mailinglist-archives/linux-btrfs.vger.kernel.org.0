Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC344ADD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 00:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfFRWXa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 18:23:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38697 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRWXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 18:23:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so8441388pfa.5
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=storix-com.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:message-id:date:to;
        bh=SIfZsjay+s8FMAirvenU8JLWMOCXqPeLQh2njsE9DOI=;
        b=cdtWhbo3NcIUQ2wMQOssdkhnp4QqTqrQZodz/lIeuANtQ2HrQW5DXWgn9zHTck0Y3P
         kLON9Cdml5zuR8GFnzAVCpkTm7iHpEZr5yDQDsHbfFBIq7nioh9TU89tIah8FeWe73i6
         Ftn5bDMg6zqhWvsJ1aMKNqHYsNhVr9JhEs7L5uqkiCGtlZSO8JOTV8EQKztTfZMuKRTf
         7m9XMXeTjDfM/t/MQv8y+fIKTPqAa9xPh4r2EhSpTa9+ognprPj4lXp0qieQxHEeBttV
         2D+LasyeD7azUYE8RCWeObH4kBouznlT7TSEYSSyPtTOT1L2D5hgmfEuhiAiOhu+lQZd
         /Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:to;
        bh=SIfZsjay+s8FMAirvenU8JLWMOCXqPeLQh2njsE9DOI=;
        b=NZvgaM6jnXzoDZtGXjbGblb+RWjPA34/s1oFgDeE8L7F2FVzgSBYNBja9UlPz8yKrT
         n3FFflPaND1MbGOmuaSJQKHVQ9jPvr5CCKSeBWXxNGmlGQZOLm3zFomDTUbVz6MuDs26
         U3uwMBi80Pn8jbI/rA/ahPDzFc3dQBHhgRMrSjRWlVh/l8x222DMpuolk30dU9gINNYk
         bzgoXZ8pxsb4t3QCYpu7IV0tbwZ2G8EFfP0Y5wtEZ3PnKYcIkdFXk1EHOG86m3D+SDaf
         I7D5pn1dFI2RI441Txj1zlq8NH6D69ZibXfiydh0ZFJtnqMM9sYW4arYVSCn1kPEOuHG
         If2Q==
X-Gm-Message-State: APjAAAVywqh3JomchmQlfktvFdh1Lx5IgXkf7PYiUmQfXOXZnc5+OPDW
        VHfS5eiDsuQpA/Xxp1U3NHrxgYhyEVQ=
X-Google-Smtp-Source: APXvYqzIMB1bELMkZCy/nCuE32y/HOQFtE8amFSAhDh6PiZ/wrhduzyD7gjtQLFdvOQWXuQ6qZFyWw==
X-Received: by 2002:a63:205b:: with SMTP id r27mr4818790pgm.330.1560896608939;
        Tue, 18 Jun 2019 15:23:28 -0700 (PDT)
Received: from dhcp106.storix (172-126-90-129.lightspeed.sndgca.sbcglobal.net. [172.126.90.129])
        by smtp.gmail.com with ESMTPSA id p7sm30812501pfp.131.2019.06.18.15.23.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 15:23:28 -0700 (PDT)
From:   Rich Turner <rturner@storix.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_ED20109D-7241-4E01-8263-1453F104C5E9"
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: "no space left on device" from tar on ppc64le
Message-Id: <405184D6-3E29-4308-B2CA-BF5644A6CED7@storix.com>
Date:   Tue, 18 Jun 2019 15:23:26 -0700
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


--Apple-Mail=_ED20109D-7241-4E01-8263-1453F104C5E9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi List,

I am attempting to extract a tar archive into a btrfs filesystem and =
more often than not tar will fail with =E2=80=9CNo space left on =
device=E2=80=9D error. I say =E2=80=9Cmore often than not=E2=80=9D =
because sometimes the extraction completes successfully even though I am =
following the same steps.

# mkfs.btrfs -f -s 65536 -n 65536 -d single -m dup /dev/system/turner_lv
# mount -v -o rw,relatime,space_cache /dev/system/turner_lv /turner
# cd /turner
# tar -xpf ~/turner.tar --selinux --xattrs --xattrs-include=3D*

Here is the error message for the latest attempt. Note that filename in =
the =E2=80=9Cno space=E2=80=9D message from tar is not consistent in =
that it could fail on a different file on a separate attempt.

tar: ./lib/firmware/keyspan/usa18x.fw: Cannot open: No space left on =
device
tar: ./lib/firmware/nvidia/gm200/gr/sw_ctx.bin: Cannot open: No space =
left on device
tar: ./lib/modules/4.4.73-7-default/kernel/drivers/md/faulty.ko: Cannot =
open: No space left on device
tar: =
./lib/modules/4.4.73-7-default/kernel/net/dns_resolver/dns_resolver.ko: =
Cannot open: No space left on device
tar: ./lib/modules/4.4.73-7-default/kernel/net/ipv4/ip_gre.ko;5cc1f748: =
Cannot open: No space left on device
tar: Exiting with failure status due to previous errors

The tar archive contains about 566M when extracted and the btrfs =
filesystem is 5G in size.

A few other tidbits that I have noticed:
- this behavior is only so far found on ppc64le. I have performed the =
same steps on x86-64 without issue.
- when I slow down the write speed I have more successes =
(https://www.spinics.net/lists/linux-btrfs/msg83384.html)
- the btrfs filesystem is created on a LVM logical volume, whose volume =
group is using a device-mapper multipath device as the physical volume. =
note that I have replicated this same issue by removing LVM and =
multipath.

# uname -a
Linux mpath6pwr8 4.4.73-7-default #1 SMP Fri Jul 21 13:26:40 UTC 2017 =
(6beeafd) ppc64le ppc64le ppc64le GNU/Linux

# cat /etc/os-release=20
NAME=3D"SLES"
VERSION=3D"12-SP3"
VERSION_ID=3D"12.3"
PRETTY_NAME=3D"SUSE Linux Enterprise Server 12 SP3"
ID=3D"sles"
ANSI_COLOR=3D"0;32"
CPE_NAME=3D"cpe:/o:suse:sles_sap:12:sp3=E2=80=9D

# btrfs --version
btrfs-progs v4.5.3+20160729

# mkfs.btrfs --version
mkfs.btrfs, part of btrfs-progs v4.5.3+20160729

# tar --version
tar (GNU tar) 1.27.1

# btrfs fi show
Label: none  uuid: 5895b3f8-6d36-4d37-aabd-0cbdbca62144
	Total devices 1 FS bytes used 544.62MiB
	devid    1 size 5.00GiB used 1.32GiB path =
/dev/mapper/system-root

Label: none  uuid: 8e71ab0d-0ef7-4b21-af05-c792ad0ac28d
	Total devices 1 FS bytes used 9.76GiB
	devid    1 size 15.00GiB used 12.02GiB path =
/dev/mapper/system-usr_lv

Label: none  uuid: bf684abc-34db-4033-872f-c7cb46139263
	Total devices 1 FS bytes used 1.56MiB
	devid    1 size 5.00GiB used 536.00MiB path =
/dev/mapper/system-home_lv

Label: none  uuid: cb0e6369-4579-4145-9c0e-a94f0fdffcc5
	Total devices 1 FS bytes used 406.56MiB
	devid    1 size 2.00GiB used 852.75MiB path =
/dev/mapper/system-root_lv

Label: none  uuid: ba3219c3-f5f4-438c-86c6-80ac2fa2454d
	Total devices 1 FS bytes used 92.31MiB
	devid    1 size 5.00GiB used 1.02GiB path =
/dev/mapper/system-tmp_lv

Label: none  uuid: 43418ec3-4a96-4fe9-9646-f6d2e976f85d
	Total devices 1 FS bytes used 212.12MiB
	devid    1 size 5.00GiB used 1.02GiB path =
/dev/mapper/system-var_lv

Label: none  uuid: 8917ac61-6d5a-40c7-8605-7c48990baf8a
	Total devices 1 FS bytes used 19.19MiB
	devid    1 size 5.00GiB used 1.02GiB path =
/dev/mapper/system-opt_lv

Label: none  uuid: 4b47b636-785a-4498-af16-8496deee26ac
	Total devices 1 FS bytes used 543.75MiB
	devid    1 size 5.00GiB used 1.52GiB path =
/dev/mapper/system-turner_lv

# btrfs fi df /turner
Data, single: total=3D1.01GiB, used=3D538.69MiB
System, DUP: total=3D8.00MiB, used=3D64.00KiB
Metadata, DUP: total=3D256.00MiB, used=3D5.00MiB
GlobalReserve, single: total=3D16.00MiB, used=3D0.00B

# btrfs fi usage /turner
Overall:
    Device size:		   5.00GiB
    Device allocated:		   1.52GiB
    Device unallocated:		   3.48GiB
    Device missing:		     0.00B
    Used:			 548.81MiB
    Free (estimated):		   3.96GiB	(min: 2.22GiB)
    Data ratio:			      1.00
    Metadata ratio:		      2.00
    Global reserve:		  16.00MiB	(used: 0.00B)

Data,single: Size:1.01GiB, Used:538.69MiB
   /dev/mapper/system-turner_lv	   1.01GiB

Metadata,DUP: Size:256.00MiB, Used:5.00MiB
   /dev/mapper/system-turner_lv	 512.00MiB

System,DUP: Size:8.00MiB, Used:64.00KiB
   /dev/mapper/system-turner_lv	  16.00MiB

Unallocated:
   /dev/mapper/system-turner_lv	   3.48GiB




--Apple-Mail=_ED20109D-7241-4E01-8263-1453F104C5E9
Content-Disposition: attachment;
	filename=dmesg.out
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="dmesg.out"
Content-Transfer-Encoding: 7bit

[    0.000000] Allocated 6291456 bytes for 2048 pacas at c00000000fa00000
[    0.000000] Using pSeries machine description
[    0.000000] Page sizes from device-tree:
[    0.000000] base_shift=12: shift=12, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=0
[    0.000000] base_shift=12: shift=16, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=7
[    0.000000] base_shift=12: shift=24, sllp=0x0000, avpnm=0x00000000, tlbiel=1, penc=56
[    0.000000] base_shift=16: shift=16, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=1
[    0.000000] base_shift=16: shift=24, sllp=0x0110, avpnm=0x00000000, tlbiel=1, penc=8
[    0.000000] base_shift=24: shift=24, sllp=0x0100, avpnm=0x00000001, tlbiel=0, penc=0
[    0.000000] base_shift=34: shift=34, sllp=0x0120, avpnm=0x000007ff, tlbiel=0, penc=3
[    0.000000] Page orders: linear mapping = 24, virtual = 16, io = 16, vmemmap = 24
[    0.000000] Using 1TB segments
[    0.000000] Found initrd at 0xc000000009b00000:0xc00000000ab4dad0
[    0.000000] bootconsole [udbg0] enabled
[    0.000000] Partition configured for 48 cpus.
[    0.000000] CPU maps initialized for 8 threads per core
[    0.000000]  (thread shift is 3)
[    0.000000] Freed 6094848 bytes for unused pacas
[    0.000000] Starting Linux ppc64le #1 SMP Fri Jul 21 13:26:40 UTC 2017 (6beeafd)
[    0.000000] -----------------------------------------------------
[    0.000000] ppc64_pft_size    = 0x19
[    0.000000] phys_mem_size     = 0x80000000
[    0.000000] cpu_features      = 0x27fc7aec18500249
[    0.000000]   possible        = 0x7fffffff18500649
[    0.000000]   always          = 0x0000000018100040
[    0.000000] cpu_user_features = 0xdc0065c2 0xef000000
[    0.000000] mmu_features      = 0x7c002001
[    0.000000] firmware_features = 0x00000001c45ffc5f
[    0.000000] htab_hash_mask    = 0x3ffff
[    0.000000] -----------------------------------------------------
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.73-7-default (geeko@buildhost) (gcc version 4.8.5 (SUSE Linux) ) #1 SMP Fri Jul 21 13:26:40 UTC 2017 (6beeafd)
[    0.000000] Node 0 Memory: 0x0-0x80000000
[    0.000000] numa: Initmem setup node 0 [mem 0x00000000-0x7fffffff]
[    0.000000] numa:   NODE_DATA [mem 0x7fe62100-0x7fe6bfff]
[    0.000000] PPC64 nvram contains 15360 bytes
[    0.000000] Top of RAM: 0x80000000, Total RAM: 0x80000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
[    0.000000] On node 0 totalpages: 32768
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 32768 pages, LIFO batch:1
[    0.000000] PERCPU: Embedded 3 pages/cpu @c00000007f200000 s123288 r0 d73320 u262144
[    0.000000] pcpu-alloc: s123288 r0 d73320 u262144 alloc=1*1048576
[    0.000000] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.000000] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.000000] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    0.000000] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    0.000000] pcpu-alloc: [0] 32 33 34 35 [0] 36 37 38 39 
[    0.000000] pcpu-alloc: [0] 40 41 42 43 [0] 44 45 46 47 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 32736
[    0.000000] Policy zone: DMA
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinux-4.4.73-7-default root=/dev/mapper/system-root splash=silent quiet showopts
[    0.000000] PID hash table entries: 4096 (order: -1, 32768 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 2011456K/2097152K available (8256K kernel code, 1280K rwdata, 2540K rodata, 3456K init, 3549K bss, 85696K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU debugfs-based tracing is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=2048 to nr_cpu_ids=48.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=48
[    0.000000] NR_IRQS:512 nr_irqs:512 16
[    0.000000] pic: no ISA interrupt controller
[    0.000000] time_init: decrementer frequency = 512.000000 MHz
[    0.000000] time_init: processor frequency   = 3891.000000 MHz
[    0.000002] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000005] clocksource: timebase mult[1f40000] shift[24] registered
[    0.000007] clockevent: decrementer mult[83126e98] shift[32] cpu[0]
[    0.000688] Console: colour dummy device 80x25
[    0.000694] console [hvc0] enabled
[    0.000696] bootconsole [udbg0] disabled
[    0.000736] pid_max: default: 49152 minimum: 384
[    0.000853] Security Framework initialized
[    0.000861] AppArmor: AppArmor initialized
[    0.000961] Dentry cache hash table entries: 262144 (order: 5, 2097152 bytes)
[    0.001639] Inode-cache hash table entries: 131072 (order: 4, 1048576 bytes)
[    0.001986] Mount-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.001989] Mountpoint-cache hash table entries: 8192 (order: 0, 65536 bytes)
[    0.002399] Initializing cgroup subsys io
[    0.002404] Initializing cgroup subsys memory
[    0.002423] Initializing cgroup subsys devices
[    0.002427] Initializing cgroup subsys freezer
[    0.002432] Initializing cgroup subsys net_cls
[    0.002435] Initializing cgroup subsys perf_event
[    0.002442] Initializing cgroup subsys net_prio
[    0.002446] Initializing cgroup subsys hugetlb
[    0.002448] Initializing cgroup subsys pids
[    0.002481] ftrace: allocating 22370 entries in 9 pages
[    0.015399] EEH: pSeries platform initialized
[    0.015414] POWER8 performance monitor hardware support registered
[    0.018868] Brought up 8 CPUs
[    0.018874] Node 0 CPUs: 0-7
[    0.019522] devtmpfs: initialized
[    0.033828] evm: security.selinux
[    0.033829] evm: security.ima
[    0.033830] evm: security.capability
[    0.033956] EEH: devices created
[    0.034080] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.034101] futex hash table entries: 16384 (order: 5, 2097152 bytes)
[    0.034761] NET: Registered protocol family 16
[    0.034809] EEH: No capable adapters found
[    0.060094] cpuidle: using governor ladder
[    0.090153] cpuidle: using governor menu
[    0.090360] pstore: Registered nvram as persistent store backend
[    0.093810] PCI: Probing PCI hardware
[    0.093812] PCI: Probing PCI hardware done
[    0.093980] pseries-rng: Registering arch random hook.
[    0.121419] vgaarb: loaded
[    0.121477] EDAC MC: Ver: 3.0.0
[    0.121811] NetLabel: Initializing
[    0.121812] NetLabel:  domain hash size = 128
[    0.121813] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.121828] NetLabel:  unlabeled traffic allowed by default
[    0.127020] clocksource: Switched to clocksource timebase
[    0.137796] AppArmor: AppArmor Filesystem Enabled
[    0.140766] NET: Registered protocol family 2
[    0.141071] TCP established hash table entries: 16384 (order: 1, 131072 bytes)
[    0.141133] TCP bind hash table entries: 16384 (order: 2, 262144 bytes)
[    0.141179] TCP: Hash tables configured (established 16384 bind 16384)
[    0.141197] UDP hash table entries: 2048 (order: 0, 65536 bytes)
[    0.141213] UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
[    0.141448] NET: Registered protocol family 1
[    0.141461] PCI: CLS 0 bytes, default 128
[    0.141547] Unpacking initramfs...
[    1.608078] Freeing initrd memory: 16640K (c000000009b00000 - c00000000ab40000)
[    1.608174] RTAS daemon started
[    1.614398] IOMMU table initialized, virtual merging enabled
[    1.652425] hv-24x7: read 1246 catalog entries, created 253 event attrs (0 failures), 127 descs
[    1.652518] kgr: successfully initialized
[    1.653170] audit: initializing netlink subsys (disabled)
[    1.653179] audit: type=2000 audit(1560892894.650:1): initialized
[    1.653702] Initialise system trusted keyring
[    1.653872] HugeTLB registered 16 MB page size, pre-allocated 0 pages
[    1.653873] HugeTLB registered 16 GB page size, pre-allocated 0 pages
[    1.653920] zbud: loaded
[    1.654187] VFS: Disk quotas dquot_6.6.0
[    1.654258] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
[    1.654996] Key type asymmetric registered
[    1.654998] Asymmetric key parser 'x509' registered
[    1.655037] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.655094] io scheduler noop registered
[    1.655096] io scheduler deadline registered
[    1.655102] io scheduler cfq registered (default)
[    1.655150] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.655156] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.655415] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.655619] pseries_rng: Registering IBM pSeries RNG driver
[    1.655802] mousedev: PS/2 mouse device common for all mice
[    1.656209] pseries_idle_driver registered
[    1.656267] ledtrig-cpu: registered to indicate activity on CPUs
[    1.701943] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: device disabled
[    1.731976] hidraw: raw HID events driver (C) Jiri Kosina
[    1.732262] NET: Registered protocol family 10
[    1.732628] NET: Registered protocol family 15
[    1.732859] registered taskstats version 1
[    1.732877] Loading compiled-in X.509 certificates
[    1.732908] Loaded X.509 cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    1.732956] Loaded X.509 cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    1.732988] zswap: loaded using pool lzo/zbud
[    1.733010] page_owner is disabled
[    1.735271] Key type trusted registered
[    1.739657] Key type encrypted registered
[    1.739665] AppArmor: AppArmor sha1 policy hashing enabled
[    1.739671] ima: No TPM chip found, activating TPM-bypass!
[    1.739700] evm: HMAC attrs: 0x1
[    1.740686] Freeing unused kernel memory: 3456K (c000000000aa0000 - c000000000e00000)
[    1.748921] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.749350] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.749375] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.751294] systemd[1]: systemd 228 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD -IDN)
[    1.751433] systemd[1]: Detected architecture ppc64-le.
[    1.751438] systemd[1]: Running in initial RAM disk.
[    1.751471] systemd[1]: Set hostname to <mpath6pwr8>.
[    1.906545] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.906580] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.906629] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.906711] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.907473] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.907932] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.908600] random: systemd: uninitialized urandom read (16 bytes read, 0 bits of entropy available)
[    1.915171] systemd[1]: Listening on Journal Audit Socket.
[    1.915223] systemd[1]: Reached target Timers.
[    1.915254] systemd[1]: Listening on udev Kernel Socket.
[    1.915735] systemd[1]: Created slice System Slice.
[    1.915757] systemd[1]: Reached target Slices.
[    1.915799] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.996722] SCSI subsystem initialized
[    1.998844] alua: device handler registered
[    2.000740] emc: device handler registered
[    2.002437] rdac: device handler registered
[    2.013090] device-mapper: uevent: version 1.0.3
[    2.013250] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
[    2.299402] ibmvscsi: externally supported module, setting X kernel taint flag.
[    2.304976] ibmvfc: externally supported module, setting X kernel taint flag.
[    2.305004] ibmvfc: IBM Virtual Fibre Channel Driver version: 1.0.11 (April 12, 2013)
[    2.312203] ibmvscsi 30000002: SRP_VERSION: 16.a
[    2.312422] ibmvscsi 30000002: Maximum ID: 64 Maximum LUN: 32 Maximum Channel: 3
[    2.312430] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
[    2.312742] ibmvscsi 30000002: partner initialization complete
[    2.312809] ibmvscsi 30000002: host srp version: 16.a, host partition 21-CC0EV (1), OS 3, max io 262144
[    2.312893] ibmvscsi 30000002: Client reserve enabled
[    2.312906] ibmvscsi 30000002: sent SRP login
[    2.312970] ibmvscsi 30000002: SRP_LOGIN succeeded
[    2.332511] scsi 0:0:1:0: CD-ROM            AIX      VOPTA                 PQ: 0 ANSI: 4
[    2.332693] scsi 0:0:1:0: Attached scsi generic sg0 type 5
[    2.390707] scsi host1: IBM POWER Virtual FC Adapter
[    2.391462] ibmvfc 30000005: Partner initialization complete
[    2.394384] ibmvfc 30000005: Host partition: 21-CC0EV, device: vfchost1 U78CB.001.WZS077E-P1-C11-T2 U8284.22A.21CC0EV-V1-C18 max sectors 2048
[    2.395238] sr 0:0:1:0: [sr0] scsi-1 drive
[    2.395240] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.395384] sr 0:0:1:0: Attached scsi CD-ROM sr0
[    2.405556] scsi 1:0:0:0: Direct-Access     DGC      RAID 5           0226 PQ: 0 ANSI: 4
[    2.406316] scsi 1:0:0:0: emc: detected Clariion CX300, flags 0
[    2.406492] scsi 1:0:0:0: emc: connected to SP B Port 0 (owned, default SP B)
[    2.406597] scsi 1:0:0:0: Attached scsi generic sg1 type 0
[    2.413282] scsi 1:0:1:0: Direct-Access     DGC      RAID 5           0226 PQ: 0 ANSI: 4
[    2.414011] scsi 1:0:1:0: emc: detected Clariion CX300, flags 0
[    2.414184] scsi 1:0:1:0: emc: connected to SP A Port 0 (bound, default SP B)
[    2.414290] scsi 1:0:1:0: Attached scsi generic sg2 type 0
[    2.426452] sd 1:0:0:0: Power-on or device reset occurred
[    2.426997] sd 1:0:1:0: Power-on or device reset occurred
[    2.442600] sd 1:0:1:0: [sdb] 104857600 512-byte logical blocks: (53.7 GB/50.0 GiB)
[    2.442600] sd 1:0:0:0: [sda] 104857600 512-byte logical blocks: (53.7 GB/50.0 GiB)
[    2.442787] sd 1:0:0:0: [sda] Write Protect is off
[    2.442790] sd 1:0:0:0: [sda] Mode Sense: 87 00 00 08
[    2.443152] sd 1:0:1:0: [sdb] Test WP failed, assume Write Enabled
[    2.443153] sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.443340] sd 1:0:1:0: [sdb] Asking for cache data failed
[    2.443343] sd 1:0:1:0: [sdb] Assuming drive cache: write through
[    2.445601] ldm_validate_partition_table(): Disk read failed.
[    2.445630]  sdb: unable to read partition table
[    2.447617] sd 1:0:1:0: [sdb] Attached SCSI disk
[    2.451621]  sda: sda1 sda2
[    2.453188] sd 1:0:0:0: [sda] Attached SCSI disk
[    2.763294] device-mapper: multipath service-time: version 0.3.0 loaded
[    2.858041] sd 1:0:0:0: emc: at SP B Port 0 (owned, default SP B)
[    3.721920] raid6: altivecx1 gen()  6981 MB/s
[    3.891919] raid6: altivecx2 gen() 18062 MB/s
[    4.061928] raid6: altivecx4 gen() 25325 MB/s
[    4.231917] raid6: altivecx8 gen() 13656 MB/s
[    4.401925] raid6: int64x1  gen()  4578 MB/s
[    4.571942] raid6: int64x1  xor()  1602 MB/s
[    4.741919] raid6: int64x2  gen()  9121 MB/s
[    4.911919] raid6: int64x2  xor()  2910 MB/s
[    5.081928] raid6: int64x4  gen() 12303 MB/s
[    5.251933] raid6: int64x4  xor()  2539 MB/s
[    5.421939] raid6: int64x8  gen()  4043 MB/s
[    5.591932] raid6: int64x8  xor()  1600 MB/s
[    5.591933] raid6: using algorithm altivecx4 gen() 25325 MB/s
[    5.591934] raid6: using intx1 recovery algorithm
[    5.592329] xor: measuring software checksum speed
[    5.691921]    8regs     : 19366.400 MB/sec
[    5.791917]    8regs_prefetch: 17785.600 MB/sec
[    5.891923]    32regs    : 20038.400 MB/sec
[    5.991921]    32regs_prefetch: 17971.200 MB/sec
[    6.091922]    altivec   : 27884.800 MB/sec
[    6.091925] xor: using function: altivec (27884.800 MB/sec)
[    6.117377] Btrfs loaded, crc32c=crc32c-generic, assert=on
[    6.131533] BTRFS: device fsid 5895b3f8-6d36-4d37-aabd-0cbdbca62144 devid 1 transid 2564 /dev/dm-3
[    6.358620] BTRFS: device fsid 8e71ab0d-0ef7-4b21-af05-c792ad0ac28d devid 1 transid 818 /dev/dm-4
[    6.767691] BTRFS info (device dm-3): disk space caching is enabled
[    6.767697] BTRFS info (device dm-3): has skinny extents
[    7.087861] BTRFS info (device dm-4): disk space caching is enabled
[    7.087865] BTRFS info (device dm-4): has skinny extents
[    7.365132] random: nonblocking pool is initialized
[    7.584707] systemd-journald[149]: Received SIGTERM from PID 1 (systemd).
[    7.678067] systemd: 13 output lines suppressed due to ratelimiting
[    8.435079] systemd-sysv-generator[948]: Overwriting existing symlink /run/systemd/generator.late/inputattach.service with real service.
[    9.111273] BTRFS info (device dm-3): disk space caching is enabled
[   10.136629] BTRFS info (device dm-4): disk space caching is enabled
[   10.776101] rtc-generic rtc-generic: rtc core: registered rtc-generic as rtc0
[   10.799731] ibmveth: externally supported module, setting X kernel taint flag.
[   10.799776] ibmveth: IBM Power Virtual Ethernet Driver 1.06
[   11.710381] Adding 2097088k swap on /dev/mapper/system-swap.  Priority:-1 extents:1 across:2097088k FS
[   12.669240] BTRFS: device fsid 8917ac61-6d5a-40c7-8605-7c48990baf8a devid 1 transid 85 /dev/dm-7
[   12.704330] BTRFS: device fsid ba3219c3-f5f4-438c-86c6-80ac2fa2454d devid 1 transid 4668 /dev/dm-9
[   12.738530] BTRFS: device fsid bf684abc-34db-4033-872f-c7cb46139263 devid 1 transid 28 /dev/dm-6
[   12.787619] BTRFS info (device dm-7): disk space caching is enabled
[   12.787623] BTRFS info (device dm-7): has skinny extents
[   12.827092] BTRFS: device fsid cb0e6369-4579-4145-9c0e-a94f0fdffcc5 devid 1 transid 100 /dev/dm-8
[   12.838586] BTRFS: device fsid 43418ec3-4a96-4fe9-9646-f6d2e976f85d devid 1 transid 69186 /dev/dm-10
[   12.840073] BTRFS: device fsid 4b104f11-f801-4472-8542-86ab9a6af193 devid 1 transid 32 /dev/dm-11
[   12.921336] BTRFS info (device dm-9): disk space caching is enabled
[   12.921341] BTRFS info (device dm-9): has skinny extents
[   12.981084] BTRFS info (device dm-6): disk space caching is enabled
[   12.981090] BTRFS info (device dm-6): has skinny extents
[   13.045913] BTRFS info (device dm-8): disk space caching is enabled
[   13.045918] BTRFS info (device dm-8): has skinny extents
[   13.114193] BTRFS info (device dm-10): disk space caching is enabled
[   13.114199] BTRFS info (device dm-10): has skinny extents
[   13.428284] systemd-journald[959]: Received request to flush runtime journal from PID 1
[   15.068826] NET: Registered protocol family 17
[   23.596645] pagecache limit set to 0.Feature is supported only for SLES for SAP appliance
[  151.609566] BTRFS: device fsid 4b47b636-785a-4498-af16-8496deee26ac devid 1 transid 1 /dev/dm-11
[  156.921063] BTRFS info (device dm-11): disk space caching is enabled
[  156.921069] BTRFS info (device dm-11): has skinny extents
[  156.963006] BTRFS info (device dm-11): creating UUID tree

--Apple-Mail=_ED20109D-7241-4E01-8263-1453F104C5E9--
