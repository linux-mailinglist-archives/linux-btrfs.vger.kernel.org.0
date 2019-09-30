Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB7C1A69
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 05:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfI3Duk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Sep 2019 23:50:40 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:50674 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbfI3Duj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Sep 2019 23:50:39 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Sep 2019 23:50:30 EDT
Received: from mxback23o.mail.yandex.net (mxback23o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::74])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 52CE34D4056B
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 06:44:19 +0300 (MSK)
Received: from myt4-6a59ac13d093.qloud-c.yandex.net (myt4-6a59ac13d093.qloud-c.yandex.net [2a02:6b8:c12:88f:0:640:6a59:ac13])
        by mxback23o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id BPvfIHAOVV-iJB8jdWA;
        Mon, 30 Sep 2019 06:44:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1569815059;
        bh=bovZM1uReNO0yJ6ChiCU4CZe6KX7aZKwZEseYHGNfIQ=;
        h=Subject:From:To:Date:Message-ID;
        b=GYjHc/8FbKYmjrcLM6t7vBtHmQdXHq2h1KnRjWcii7ACEFqSom0xLu8hmE4IeRMAu
         otUgmW7Cc5a33q2l0ptRuSz40ClsIoc0IQ1MZJh73rkQiCgGTLNpAseYmU+GF3zHrU
         wjRocPHOMWNttsUSiLsfNoF3k907BNC9RUbk3fJ8=
Authentication-Results: mxback23o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-6a59ac13d093.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id cwwKwUgBwN-iIqSqlVa;
        Mon, 30 Sep 2019 06:44:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     linux-btrfs@vger.kernel.org
From:   Andrey Ivanov <andrey-ivanov-ml@yandex.ru>
Subject: Btrfs partition mount error
Message-ID: <79466812-e999-32d8-ce20-0589fb64a433@yandex.ru>
Date:   Mon, 30 Sep 2019 06:44:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C767770073C14F2702418BFD"
Content-Language: ru-RU
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------C767770073C14F2702418BFD
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 7bit


During work I had experienced problems with access to files on the btfs partition.
I rebooted the computer and after that the partition did not mount.

# mount /dev/sdc1 /data
mount: /data: wrong fs type, bad option, bad superblock on /dev/sdc1, missing codepage or helper program, or other error.


I think the logical structure of partition is corrupted.
Can it be restored somehow?


System info:

# uname -a
Linux tux64 4.19.72-gentoo #1 SMP Sun Sep 15 12:27:44 MSK 2019 x86_64 Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz GenuineIntel GNU/Linux

# btrfs --version
btrfs-progs v4.19

# btrfs fi show
Label: none  uuid: a942b8da-e92d-4348-8de9-ded1e5e095ad
         Total devices 1 FS bytes used 101.56GiB
         devid    1 size 465.01GiB used 105.01GiB path /dev/sda4

Label: none  uuid: 62164480-0c5e-45da-807b-33f8bfe76ecf
         Total devices 1 FS bytes used 1.36TiB
         devid    1 size 2.70TiB used 1.38TiB path /dev/sdc1


dmesg.log attached

--------------C767770073C14F2702418BFD
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Linux version 4.19.72-gentoo (root@tux64) (gcc version 8.3.0 (Gentoo 8.3.0-r1 p1.1)) #1 SMP Sun Sep 15 12:27:44 MSK 2019
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.19.72-gentoo root=/dev/sda4 ro resume=/dev/sdc2
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ebff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ec00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000dd995fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dd996000-0x00000000ddcd8fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ddcd9000-0x00000000ddd64fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ddd65000-0x00000000dde02fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dde03000-0x00000000dedc2fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000dedc3000-0x00000000dedc3fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dedc4000-0x00000000dee06fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000dee07000-0x00000000df229fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df22a000-0x00000000df7f3fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000df7f4000-0x00000000df7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000061effffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: MSI MS-7673/P67A-C45 (MS-7673), BIOS V5.4 01/09/2013
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3100.276 MHz processor
[    0.001663] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001665] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001671] last_pfn = 0x61f000 max_arch_pfn = 0x400000000
[    0.001673] MTRR default type: uncachable
[    0.001674] MTRR fixed ranges enabled:
[    0.001675]   00000-9FFFF write-back
[    0.001675]   A0000-BFFFF uncachable
[    0.001676]   C0000-CFFFF write-protect
[    0.001676]   D0000-E7FFF uncachable
[    0.001677]   E8000-FFFFF write-protect
[    0.001677] MTRR variable ranges enabled:
[    0.001678]   0 base 000000000 mask C00000000 write-back
[    0.001679]   1 base 400000000 mask E00000000 write-back
[    0.001679]   2 base 600000000 mask FF0000000 write-back
[    0.001680]   3 base 610000000 mask FF8000000 write-back
[    0.001680]   4 base 618000000 mask FFC000000 write-back
[    0.001681]   5 base 61C000000 mask FFE000000 write-back
[    0.001681]   6 base 61E000000 mask FFF000000 write-back
[    0.001682]   7 base 0E0000000 mask FE0000000 uncachable
[    0.001682]   8 disabled
[    0.001683]   9 disabled
[    0.002398] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002905] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[    0.002910] last_pfn = 0xdf800 max_arch_pfn = 0x400000000
[    0.008876] found SMP MP-table at [mem 0x000fd820-0x000fd82f]
[    0.008888] Scanning 1 areas for low memory corruption
[    0.008893] BRK [0x492601000, 0x492601fff] PGTABLE
[    0.008895] BRK [0x492602000, 0x492602fff] PGTABLE
[    0.008895] BRK [0x492603000, 0x492603fff] PGTABLE
[    0.008909] BRK [0x492604000, 0x492604fff] PGTABLE
[    0.008911] BRK [0x492605000, 0x492605fff] PGTABLE
[    0.008949] BRK [0x492606000, 0x492606fff] PGTABLE
[    0.008969] BRK [0x492607000, 0x492607fff] PGTABLE
[    0.008975] BRK [0x492608000, 0x492608fff] PGTABLE
[    0.008981] BRK [0x492609000, 0x492609fff] PGTABLE
[    0.009002] BRK [0x49260a000, 0x49260afff] PGTABLE
[    0.009028] BRK [0x49260b000, 0x49260bfff] PGTABLE
[    0.009056] BRK [0x49260c000, 0x49260cfff] PGTABLE
[    0.009313] ACPI: Early table checksum verification disabled
[    0.018521] ACPI: RSDP 0x00000000000F0490 000024 (v02 ALASKA)
[    0.018524] ACPI: XSDT 0x00000000DDDF3078 00006C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018529] ACPI: FACP 0x00000000DDDFCD08 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.018534] ACPI: DSDT 0x00000000DDDF3178 009B8B (v02 ALASKA A M I    00000022 INTL 20051117)
[    0.018537] ACPI: FACS 0x00000000DDE01080 000040
[    0.018539] ACPI: APIC 0x00000000DDDFCE18 000072 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.018541] ACPI: FPDT 0x00000000DDDFCE90 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.018544] ACPI: MCFG 0x00000000DDDFCED8 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.018546] ACPI: SSDT 0x00000000DDDFCF18 0007CA (v01 Intel_ AoacTabl 00001000 INTL 20091112)
[    0.018549] ACPI: HPET 0x00000000DDDFD6E8 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
[    0.018551] ACPI: SSDT 0x00000000DDDFD720 0004E9 (v01 IdeRef IdeTable 00001000 INTL 20091112)
[    0.018554] ACPI: SSDT 0x00000000DDDFDC10 0009AA (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
[    0.018556] ACPI: SSDT 0x00000000DDDFE5C0 000A92 (v01 PmRef  CpuPm    00003000 INTL 20051117)
[    0.018563] ACPI: Local APIC address 0xfee00000
[    0.018630] No NUMA configuration found
[    0.018631] Faking a node at [mem 0x0000000000000000-0x000000061effffff]
[    0.018633] NODE_DATA(0) allocated [mem 0x61efe6000-0x61efe9fff]
[    0.018653] Zone ranges:
[    0.018654]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018655]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018656]   Normal   [mem 0x0000000100000000-0x000000061effffff]
[    0.018658] Movable zone start for each node
[    0.018658] Early memory node ranges
[    0.018659]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.018660]   node   0: [mem 0x0000000000100000-0x00000000dd995fff]
[    0.018661]   node   0: [mem 0x00000000ddcd9000-0x00000000ddd64fff]
[    0.018662]   node   0: [mem 0x00000000dedc3000-0x00000000dedc3fff]
[    0.018662]   node   0: [mem 0x00000000dee07000-0x00000000df229fff]
[    0.018663]   node   0: [mem 0x00000000df7f4000-0x00000000df7fffff]
[    0.018664]   node   0: [mem 0x0000000100000000-0x000000061effffff]
[    0.018667] Reserved but unavailable: 99 pages
[    0.018668] Initmem setup node 0 [mem 0x0000000000001000-0x000000061effffff]
[    0.018670] On node 0 totalpages: 6278639
[    0.018671]   DMA zone: 64 pages used for memmap
[    0.018671]   DMA zone: 21 pages reserved
[    0.018672]   DMA zone: 3997 pages, LIFO batch:0
[    0.018757]   DMA32 zone: 14138 pages used for memmap
[    0.018758]   DMA32 zone: 904786 pages, LIFO batch:63
[    0.037951]   Normal zone: 83904 pages used for memmap
[    0.037953]   Normal zone: 5369856 pages, LIFO batch:63
[    0.147575] ACPI: PM-Timer IO Port: 0x408
[    0.147578] ACPI: Local APIC address 0xfee00000
[    0.147583] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.147593] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.147595] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.147597] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.147598] ACPI: IRQ0 used by override.
[    0.147599] ACPI: IRQ9 used by override.
[    0.147600] Using ACPI (MADT) for SMP configuration information
[    0.147601] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.147606] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.147622] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.147624] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.147624] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.147625] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.147626] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.147627] PM: Registered nosave memory: [mem 0xdd996000-0xddcd8fff]
[    0.147629] PM: Registered nosave memory: [mem 0xddd65000-0xdde02fff]
[    0.147629] PM: Registered nosave memory: [mem 0xdde03000-0xdedc2fff]
[    0.147631] PM: Registered nosave memory: [mem 0xdedc4000-0xdee06fff]
[    0.147632] PM: Registered nosave memory: [mem 0xdf22a000-0xdf7f3fff]
[    0.147634] PM: Registered nosave memory: [mem 0xdf800000-0xf7ffffff]
[    0.147635] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.147635] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.147636] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.147637] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.147637] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.147638] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.147639] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.147640] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.147640] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.147641] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.147642] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.147644] [mem 0xdf800000-0xf7ffffff] available for PCI devices
[    0.147646] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.235846] random: get_random_bytes called from start_kernel+0x8a/0x4a0 with crng_init=0
[    0.235854] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.236003] percpu: Embedded 44 pages/cpu s141464 r8192 d30568 u524288
[    0.236009] pcpu-alloc: s141464 r8192 d30568 u524288 alloc=1*2097152
[    0.236010] pcpu-alloc: [0] 0 1 2 3 
[    0.236028] Built 1 zonelists, mobility grouping on.  Total pages: 6180512
[    0.236029] Policy zone: Normal
[    0.236031] Kernel command line: BOOT_IMAGE=/vmlinuz-4.19.72-gentoo root=/dev/sda4 ro resume=/dev/sdc2
[    0.239469] Calgary: detecting Calgary via BIOS EBDA area
[    0.239470] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.298627] Memory: 24625584K/25114556K available (14360K kernel code, 1558K rwdata, 3552K rodata, 1272K init, 1480K bss, 488972K reserved, 0K cma-reserved)
[    0.298662] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.298666] Kernel/User page tables isolation: enabled
[    0.298759] rcu: Hierarchical RCU implementation.
[    0.298760] rcu: 	RCU event tracing is enabled.
[    0.298761] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.298762] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.298895] NR_IRQS: 4352, nr_irqs: 456, preallocated irqs: 16
[    0.300632] Console: colour VGA+ 80x25
[    0.308769] console [tty0] enabled
[    0.308844] ACPI: Core revision 20180810
[    0.309052] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.309150] hpet clockevent registered
[    0.309154] APIC: Switch to symmetric I/O mode setup
[    0.309594] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.314153] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2cb04cad262, max_idle_ns: 440795289526 ns
[    0.314255] Calibrating delay loop (skipped), value calculated using timer frequency.. 6200.55 BogoMIPS (lpj=3100276)
[    0.314347] pid_max: default: 32768 minimum: 301
[    0.314426] Security Framework initialized
[    0.314494] SELinux:  Initializing.
[    0.318731] Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.320881] Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.321051] Mount-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.321184] Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.321375] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.321443] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.321520] CPU0: Thermal monitoring enabled (TM1)
[    0.321593] process: using mwait in idle threads
[    0.321662] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.321730] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.321799] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.321890] Spectre V2 : Mitigation: Full generic retpoline
[    0.321958] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.322049] Speculative Store Bypass: Vulnerable
[    0.322141] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.322416] Freeing SMP alternatives memory: 44K
[    0.323304] TSC deadline timer enabled
[    0.323306] smpboot: CPU0: Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz (family: 0x6, model: 0x2a, stepping: 0x7)
[    0.323465] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.323575] ... version:                3
[    0.323642] ... bit width:              48
[    0.323709] ... generic registers:      4
[    0.323776] ... value mask:             0000ffffffffffff
[    0.323844] ... max period:             00007fffffffffff
[    0.323912] ... fixed-purpose events:   3
[    0.323979] ... event mask:             000000070000000f
[    0.324075] rcu: Hierarchical SRCU implementation.
[    0.324228] smp: Bringing up secondary CPUs ...
[    0.324292] x86: Booting SMP configuration:
[    0.324360] .... node  #0, CPUs:      #1 #2
[    0.326341] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.326491]  #3
[    0.327267] smp: Brought up 1 node, 4 CPUs
[    0.327386] smpboot: Max logical packages: 1
[    0.328050] smpboot: Total of 4 processors activated (24802.20 BogoMIPS)
[    0.328788] devtmpfs: initialized
[    0.328788] PM: Registering ACPI NVS region [mem 0xddd65000-0xdde02fff] (647168 bytes)
[    0.328788] PM: Registering ACPI NVS region [mem 0xdedc4000-0xdee06fff] (274432 bytes)
[    0.329295] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.329285] kworker/u8:0 (32) used greatest stack depth: 14680 bytes left
[    0.329402] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.329558] xor: automatically using best checksumming function   avx       
[    0.329660] RTC time:  4:54:50, date: 09/30/19
[    0.329762] NET: Registered protocol family 16
[    0.329893] audit: initializing netlink subsys (disabled)
[    0.329964] audit: type=2000 audit(1569819290.020:1): state=initialized audit_enabled=0 res=1
[    0.329964] cpuidle: using governor menu
[    0.329964] kworker/u8:0 (48) used greatest stack depth: 14248 bytes left
[    0.329964] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.330248] ACPI: bus type PCI registered
[    0.330362] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.330456] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.330530] pmd_set_huge: Cannot satisfy [mem 0xf8000000-0xf8200000] with a huge-page mapping due to MTRR override.
[    0.330662] PCI: Using configuration type 1 for base access
[    0.330756] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.334282] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.350389] raid6: sse2x1   gen()  9535 MB/s
[    0.367401] raid6: sse2x1   xor()  6732 MB/s
[    0.384412] raid6: sse2x2   gen() 11191 MB/s
[    0.401422] raid6: sse2x2   xor()  7478 MB/s
[    0.418434] raid6: sse2x4   gen() 13355 MB/s
[    0.435440] raid6: sse2x4   xor()  9009 MB/s
[    0.435507] raid6: using algorithm sse2x4 gen() 13355 MB/s
[    0.435576] raid6: .... xor() 9009 MB/s, rmw enabled
[    0.435644] raid6: using ssse3x2 recovery algorithm
[    0.436264] ACPI: Added _OSI(Module Device)
[    0.436264] ACPI: Added _OSI(Processor Device)
[    0.436264] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.436264] ACPI: Added _OSI(Processor Aggregator Device)
[    0.436264] ACPI: Added _OSI(Linux-Dell-Video)
[    0.436264] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.440370] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.442329] ACPI: Dynamic OEM Table Load:
[    0.442401] ACPI: SSDT 0xFFFF9FF983386000 00083B (v01 PmRef  Cpu0Cst  00003001 INTL 20051117)
[    0.442767] ACPI: Dynamic OEM Table Load:
[    0.442837] ACPI: SSDT 0xFFFF9FF982FAA400 000303 (v01 PmRef  ApIst    00003000 INTL 20051117)
[    0.443100] ACPI: Dynamic OEM Table Load:
[    0.443171] ACPI: SSDT 0xFFFF9FF982D17600 000119 (v01 PmRef  ApCst    00003000 INTL 20051117)
[    0.443875] ACPI: Interpreter enabled
[    0.443957] ACPI: (supports S0 S3 S4 S5)
[    0.444025] ACPI: Using IOAPIC for interrupt routing
[    0.444114] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.444391] ACPI: Enabled 15 GPEs in block 00 to 3F
[    0.450255] ACPI: Power Resource [FN00] (off)
[    0.450255] ACPI: Power Resource [FN01] (off)
[    0.450255] ACPI: Power Resource [FN02] (off)
[    0.450255] ACPI: Power Resource [FN03] (off)
[    0.450257] ACPI: Power Resource [FN04] (off)
[    0.450604] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.450676] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.450927] acpi PNP0A08:00: _OSC: platform does not support [PME]
[    0.451091] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability LTR]
[    0.451160] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.451431] PCI host bridge to bus 0000:00
[    0.451500] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.451569] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.451638] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.451729] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    0.451819] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    0.451910] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    0.452001] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    0.452092] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    0.452182] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    0.452248] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfeafffff window]
[    0.452339] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.452413] pci 0000:00:00.0: [8086:0100] type 00 class 0x060000
[    0.452495] pci 0000:00:01.0: [8086:0101] type 01 class 0x060400
[    0.452524] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.453253] pci 0000:00:16.0: [8086:1c3a] type 00 class 0x078000
[    0.453253] pci 0000:00:16.0: reg 0x10: [mem 0xf7f05000-0xf7f0500f 64bit]
[    0.453253] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.453256] pci 0000:00:1a.0: [8086:1c2d] type 00 class 0x0c0320
[    0.453256] pci 0000:00:1a.0: reg 0x10: [mem 0xf7f02000-0xf7f023ff]
[    0.453256] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.453259] pci 0000:00:1c.0: [8086:1c10] type 01 class 0x060400
[    0.453259] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.453259] pci 0000:00:1c.3: [8086:1c16] type 01 class 0x060400
[    0.453259] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.453259] pci 0000:00:1c.4: [8086:244e] type 01 class 0x060401
[    0.453331] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.453405] pci 0000:00:1c.5: [8086:1c1a] type 01 class 0x060400
[    0.453485] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.453558] pci 0000:00:1c.6: [8086:1c1c] type 01 class 0x060400
[    0.453638] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    0.454255] pci 0000:00:1c.7: [8086:1c1e] type 01 class 0x060400
[    0.454255] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    0.454255] pci 0000:00:1d.0: [8086:1c26] type 00 class 0x0c0320
[    0.454255] pci 0000:00:1d.0: reg 0x10: [mem 0xf7f01000-0xf7f013ff]
[    0.454255] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.454258] pci 0000:00:1f.0: [8086:1c46] type 00 class 0x060100
[    0.454258] pci 0000:00:1f.2: [8086:1c00] type 00 class 0x01018a
[    0.454258] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    0.454258] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    0.454258] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    0.454258] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    0.454258] pci 0000:00:1f.2: reg 0x20: [io  0xf090-0xf09f]
[    0.454258] pci 0000:00:1f.2: reg 0x24: [io  0xf080-0xf08f]
[    0.454258] pci 0000:00:1f.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.454317] pci 0000:00:1f.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.454386] pci 0000:00:1f.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.454456] pci 0000:00:1f.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.454600] pci 0000:00:1f.3: [8086:1c22] type 00 class 0x0c0500
[    0.454617] pci 0000:00:1f.3: reg 0x10: [mem 0xf7f00000-0xf7f000ff 64bit]
[    0.454636] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[    0.455253] pci 0000:00:1f.5: [8086:1c08] type 00 class 0x010185
[    0.455253] pci 0000:00:1f.5: reg 0x10: [io  0xf070-0xf077]
[    0.455253] pci 0000:00:1f.5: reg 0x14: [io  0xf060-0xf063]
[    0.455253] pci 0000:00:1f.5: reg 0x18: [io  0xf050-0xf057]
[    0.455253] pci 0000:00:1f.5: reg 0x1c: [io  0xf040-0xf043]
[    0.455253] pci 0000:00:1f.5: reg 0x20: [io  0xf030-0xf03f]
[    0.455253] pci 0000:00:1f.5: reg 0x24: [io  0xf020-0xf02f]
[    0.455256] pci 0000:01:00.0: [1002:68e1] type 00 class 0x030000
[    0.455256] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.455256] pci 0000:01:00.0: reg 0x18: [mem 0xf7e20000-0xf7e3ffff 64bit]
[    0.455256] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.455256] pci 0000:01:00.0: reg 0x30: [mem 0xf7e00000-0xf7e1ffff pref]
[    0.455256] pci 0000:01:00.0: enabling Extended Tags
[    0.455256] pci 0000:01:00.0: supports D1 D2
[    0.455256] pci 0000:01:00.1: [1002:aa68] type 00 class 0x040300
[    0.455256] pci 0000:01:00.1: reg 0x10: [mem 0xf7e40000-0xf7e43fff 64bit]
[    0.455256] pci 0000:01:00.1: enabling Extended Tags
[    0.455256] pci 0000:01:00.1: supports D1 D2
[    0.455256] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.455256] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.455256] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.455256] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.455303] pci 0000:02:00.0: [168c:0032] type 00 class 0x028000
[    0.455343] pci 0000:02:00.0: reg 0x10: [mem 0xf7d00000-0xf7d7ffff 64bit]
[    0.455405] pci 0000:02:00.0: reg 0x30: [mem 0xf7d80000-0xf7d8ffff pref]
[    0.455501] pci 0000:02:00.0: supports D1 D2
[    0.455502] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.455600] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.455672] pci 0000:00:1c.0:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.456253] pci 0000:03:00.0: [1033:0194] type 00 class 0x0c0330
[    0.456253] pci 0000:03:00.0: reg 0x10: [mem 0xf7c00000-0xf7c01fff 64bit]
[    0.456253] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.456255] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    0.456255] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.456255] pci 0000:04:00.0: [1b21:1080] type 01 class 0x060400
[    0.456335] pci 0000:04:00.0: supports D1 D2
[    0.456336] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.460261] pci 0000:00:1c.4: PCI bridge to [bus 04-05] (subtractive decode)
[    0.460333] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.460336] pci 0000:00:1c.4:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.460341] pci 0000:00:1c.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.460342] pci 0000:00:1c.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.460343] pci 0000:00:1c.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.460344] pci 0000:00:1c.4:   bridge window [mem 0x000d0000-0x000d3fff window] (subtractive decode)
[    0.460344] pci 0000:00:1c.4:   bridge window [mem 0x000d4000-0x000d7fff window] (subtractive decode)
[    0.460345] pci 0000:00:1c.4:   bridge window [mem 0x000d8000-0x000dbfff window] (subtractive decode)
[    0.460346] pci 0000:00:1c.4:   bridge window [mem 0x000dc000-0x000dffff window] (subtractive decode)
[    0.460347] pci 0000:00:1c.4:   bridge window [mem 0x000e0000-0x000e3fff window] (subtractive decode)
[    0.460348] pci 0000:00:1c.4:   bridge window [mem 0x000e4000-0x000e7fff window] (subtractive decode)
[    0.460349] pci 0000:00:1c.4:   bridge window [mem 0xe0000000-0xfeafffff window] (subtractive decode)
[    0.460408] pci_bus 0000:05: extended config space not accessible
[    0.460503] pci 0000:05:01.0: [1102:0004] type 00 class 0x040100
[    0.460533] pci 0000:05:01.0: reg 0x10: [io  0xd000-0xd03f]
[    0.460685] pci 0000:05:01.0: supports D1 D2
[    0.461254] pci 0000:05:01.1: [1102:7003] type 00 class 0x098000
[    0.461254] pci 0000:05:01.1: reg 0x10: [io  0xd040-0xd047]
[    0.461254] pci 0000:05:01.1: supports D1 D2
[    0.461259] pci 0000:05:01.2: [1102:4001] type 00 class 0x0c0010
[    0.461259] pci 0000:05:01.2: reg 0x10: [mem 0xf7b04000-0xf7b047ff]
[    0.461259] pci 0000:05:01.2: reg 0x14: [mem 0xf7b00000-0xf7b03fff]
[    0.461259] pci 0000:05:01.2: supports D1 D2
[    0.461259] pci 0000:05:01.2: PME# supported from D0 D1 D2 D3hot
[    0.461259] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.461332] pci 0000:04:00.0:   bridge window [io  0xd000-0xdfff]
[    0.461337] pci 0000:04:00.0:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.461409] pci 0000:06:00.0: [1033:0194] type 00 class 0x0c0330
[    0.461448] pci 0000:06:00.0: reg 0x10: [mem 0xf7a00000-0xf7a01fff 64bit]
[    0.461606] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.462253] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.462253] pci 0000:00:1c.5:   bridge window [mem 0xf7a00000-0xf7afffff]
[    0.462255] pci 0000:07:00.0: [10ec:8168] type 00 class 0x020000
[    0.462255] pci 0000:07:00.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.462255] pci 0000:07:00.0: reg 0x18: [mem 0xf0004000-0xf0004fff 64bit pref]
[    0.462255] pci 0000:07:00.0: reg 0x20: [mem 0xf0000000-0xf0003fff 64bit pref]
[    0.462255] pci 0000:07:00.0: supports D1 D2
[    0.462255] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.462255] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    0.462255] pci 0000:00:1c.6:   bridge window [io  0xc000-0xcfff]
[    0.462255] pci 0000:00:1c.6:   bridge window [mem 0xf0000000-0xf00fffff 64bit pref]
[    0.462283] pci 0000:08:00.0: [1106:3403] type 00 class 0x0c0010
[    0.462322] pci 0000:08:00.0: reg 0x10: [mem 0xf7900000-0xf79007ff 64bit]
[    0.462335] pci 0000:08:00.0: reg 0x18: [io  0xb000-0xb0ff]
[    0.462469] pci 0000:08:00.0: supports D2
[    0.462469] pci 0000:08:00.0: PME# supported from D2 D3hot D3cold
[    0.466265] pci 0000:00:1c.7: PCI bridge to [bus 08]
[    0.466336] pci 0000:00:1c.7:   bridge window [io  0xb000-0xbfff]
[    0.466339] pci 0000:00:1c.7:   bridge window [mem 0xf7900000-0xf79fffff]
[    0.467258] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.467258] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.467258] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 10 11 12 14 15)
[    0.467258] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 10 11 12 14 15)
[    0.467258] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.467282] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.467411] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
[    0.467539] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    0.468261] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.468327] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.468420] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.468488] vgaarb: loaded
[    0.468621] SCSI subsystem initialized
[    0.468621] libata version 3.00 loaded.
[    0.468621] ACPI: bus type USB registered
[    0.469255] usbcore: registered new interface driver usbfs
[    0.469259] usbcore: registered new interface driver hub
[    0.469260] usbcore: registered new device driver usb
[    0.469280] EDAC MC: Ver: 3.0.0
[    0.469423] Advanced Linux Sound Architecture Driver Initialized.
[    0.469423] PCI: Using ACPI for IRQ routing
[    0.471341] PCI: pci_cache_line_size set to 64 bytes
[    0.471416] e820: reserve RAM buffer [mem 0x0009ec00-0x0009ffff]
[    0.471417] e820: reserve RAM buffer [mem 0xdd996000-0xdfffffff]
[    0.471418] e820: reserve RAM buffer [mem 0xddd65000-0xdfffffff]
[    0.471420] e820: reserve RAM buffer [mem 0xdedc4000-0xdfffffff]
[    0.471421] e820: reserve RAM buffer [mem 0xdf22a000-0xdfffffff]
[    0.471421] e820: reserve RAM buffer [mem 0xdf800000-0xdfffffff]
[    0.471422] e820: reserve RAM buffer [mem 0x61f000000-0x61fffffff]
[    0.471517] NetLabel: Initializing
[    0.471585] NetLabel:  domain hash size = 128
[    0.471652] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.471732] NetLabel:  unlabeled traffic allowed by default
[    0.471812] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.471812] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.473262] clocksource: Switched to clocksource tsc-early
[    0.483218] VFS: Disk quotas dquot_6.6.0
[    0.483305] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.484610] pnp: PnP ACPI init
[    0.484760] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.484834] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.484902] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.484971] system 00:01: [io  0x1000-0x100f] has been reserved
[    0.485040] system 00:01: [io  0xffff] has been reserved
[    0.485109] system 00:01: [io  0xffff] has been reserved
[    0.485177] system 00:01: [io  0x0400-0x0453] has been reserved
[    0.485246] system 00:01: [io  0x0458-0x047f] has been reserved
[    0.485321] system 00:01: [io  0x0500-0x057f] has been reserved
[    0.485389] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.485462] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.485481] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.485522] system 00:03: [io  0x0454-0x0457] has been reserved
[    0.485594] system 00:03: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.485732] system 00:04: [io  0x0a00-0x0a0f] has been reserved
[    0.485804] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.485920] pnp 00:05: [dma 0 disabled]
[    0.485953] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.485996] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.486067] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.486238] system 00:07: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.486310] system 00:07: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.486379] system 00:07: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.486448] system 00:07: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.486517] system 00:07: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.486586] system 00:07: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.486655] system 00:07: [mem 0xfed90000-0xfed93fff] has been reserved
[    0.486724] system 00:07: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.486793] system 00:07: [mem 0xff000000-0xffffffff] has been reserved
[    0.486863] system 00:07: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.486935] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.487032] pnp: PnP ACPI: found 8 devices
[    0.491636] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.491792] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.491862] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
[    0.491932] pci 0000:00:01.0:   bridge window [mem 0xf7e00000-0xf7efffff]
[    0.492002] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.492094] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.492166] pci 0000:00:1c.0:   bridge window [mem 0xf7d00000-0xf7dfffff]
[    0.492241] pci 0000:00:1c.3: PCI bridge to [bus 03]
[    0.492321] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff]
[    0.492396] pci 0000:04:00.0: PCI bridge to [bus 05]
[    0.492466] pci 0000:04:00.0:   bridge window [io  0xd000-0xdfff]
[    0.492541] pci 0000:04:00.0:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.492622] pci 0000:00:1c.4: PCI bridge to [bus 04-05]
[    0.492691] pci 0000:00:1c.4:   bridge window [io  0xd000-0xdfff]
[    0.493350] pci 0000:00:1c.4:   bridge window [mem 0xf7b00000-0xf7bfffff]
[    0.493426] pci 0000:00:1c.5: PCI bridge to [bus 06]
[    0.493497] pci 0000:00:1c.5:   bridge window [mem 0xf7a00000-0xf7afffff]
[    0.493573] pci 0000:00:1c.6: PCI bridge to [bus 07]
[    0.493642] pci 0000:00:1c.6:   bridge window [io  0xc000-0xcfff]
[    0.493716] pci 0000:00:1c.6:   bridge window [mem 0xf0000000-0xf00fffff 64bit pref]
[    0.493812] pci 0000:00:1c.7: PCI bridge to [bus 08]
[    0.493882] pci 0000:00:1c.7:   bridge window [io  0xb000-0xbfff]
[    0.493953] pci 0000:00:1c.7:   bridge window [mem 0xf7900000-0xf79fffff]
[    0.494030] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.494031] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.494032] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.494033] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff window]
[    0.494034] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff window]
[    0.494035] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff window]
[    0.494036] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff window]
[    0.494036] pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff window]
[    0.494037] pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff window]
[    0.494038] pci_bus 0000:00: resource 13 [mem 0xe0000000-0xfeafffff window]
[    0.494039] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
[    0.494040] pci_bus 0000:01: resource 1 [mem 0xf7e00000-0xf7efffff]
[    0.494041] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 64bit pref]
[    0.494042] pci_bus 0000:02: resource 1 [mem 0xf7d00000-0xf7dfffff]
[    0.494043] pci_bus 0000:03: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.494044] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
[    0.494045] pci_bus 0000:04: resource 1 [mem 0xf7b00000-0xf7bfffff]
[    0.494045] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
[    0.494046] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
[    0.494047] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.494048] pci_bus 0000:04: resource 7 [mem 0x000d0000-0x000d3fff window]
[    0.494049] pci_bus 0000:04: resource 8 [mem 0x000d4000-0x000d7fff window]
[    0.494050] pci_bus 0000:04: resource 9 [mem 0x000d8000-0x000dbfff window]
[    0.494051] pci_bus 0000:04: resource 10 [mem 0x000dc000-0x000dffff window]
[    0.494051] pci_bus 0000:04: resource 11 [mem 0x000e0000-0x000e3fff window]
[    0.494052] pci_bus 0000:04: resource 12 [mem 0x000e4000-0x000e7fff window]
[    0.494053] pci_bus 0000:04: resource 13 [mem 0xe0000000-0xfeafffff window]
[    0.494054] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.494055] pci_bus 0000:05: resource 1 [mem 0xf7b00000-0xf7bfffff]
[    0.494056] pci_bus 0000:06: resource 1 [mem 0xf7a00000-0xf7afffff]
[    0.494057] pci_bus 0000:07: resource 0 [io  0xc000-0xcfff]
[    0.494058] pci_bus 0000:07: resource 2 [mem 0xf0000000-0xf00fffff 64bit pref]
[    0.494058] pci_bus 0000:08: resource 0 [io  0xb000-0xbfff]
[    0.494059] pci_bus 0000:08: resource 1 [mem 0xf7900000-0xf79fffff]
[    0.494135] NET: Registered protocol family 2
[    0.494329] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 bytes)
[    0.494499] TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.494909] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.495090] TCP: Hash tables configured (established 262144 bind 65536)
[    0.495205] UDP hash table entries: 16384 (order: 7, 524288 bytes)
[    0.495363] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
[    0.495529] NET: Registered protocol family 1
[    0.495684] RPC: Registered named UNIX socket transport module.
[    0.495753] RPC: Registered udp transport module.
[    0.495821] RPC: Registered tcp transport module.
[    0.495888] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.496348] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.496446] pci 0000:01:00.1: Linked as a consumer to 0000:01:00.0
[    0.496520] PCI: CLS mismatch (64 != 32), using 64 bytes
[    0.496820] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.496890] software IO TLB: mapped [mem 0xd9996000-0xdd996000] (64MB)
[    0.497008] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    0.497099] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    0.497168] RAPL PMU: hw unit of domain package 2^-16 Joules
[    0.497236] RAPL PMU: hw unit of domain pp1-gpu 2^-16 Joules
[    0.497803] Scanning for low memory corruption every 60 seconds
[    0.498549] Initialise system trusted keyrings
[    0.498641] workingset: timestamp_bits=56 max_order=23 bucket_order=0
[    0.500594] NFS: Registering the id_resolver key type
[    0.500670] Key type id_resolver registered
[    0.500737] Key type id_legacy registered
[    0.500907] ntfs: driver 2.1.32 [Flags: R/O].
[    0.501045] fuse init (API version 7.27)
[    0.501995] Key type asymmetric registered
[    0.502063] Asymmetric key parser 'x509' registered
[    0.502139] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.502232] io scheduler noop registered
[    0.502307] io scheduler deadline registered
[    0.502394] io scheduler cfq registered (default)
[    0.502463] io scheduler mq-deadline registered
[    0.502531] io scheduler kyber registered
[    0.503167] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.523808] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.524280] Non-volatile memory driver v1.3
[    0.524365] Linux agpgart interface v0.103
[    0.524522] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.524624] ACPI: Power Button [PWRB]
[    0.524718] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.524813] ACPI: Power Button [PWRF]
[    0.525238] Monitor-Mwait will be used to enter C-1 state
[    0.525240] Monitor-Mwait will be used to enter C-3 state
[    0.525946] thermal LNXTHERM:00: registered as thermal_zone0
[    0.526016] ACPI: Thermal Zone [TZ00] (28 C)
[    0.526263] thermal LNXTHERM:01: registered as thermal_zone1
[    0.526333] ACPI: Thermal Zone [TZ01] (30 C)
[    0.526459] [drm] radeon kernel modesetting enabled.
[    0.526724] [drm] initializing kernel modesetting (CEDAR 0x1002:0x68E1 0x1043:0x3000 0x00).
[    0.526846] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000d0000-0x000d3fff window]
[    0.526944] caller pci_map_rom+0x65/0x19e mapping multiple BARs
[    0.527028] ATOM BIOS: 68E1.12.20.0.52.AS04
[    0.527136] radeon 0000:01:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    0.527229] radeon 0000:01:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    0.527347] [drm] Detected VRAM RAM=1024M, BAR=256M
[    0.527416] [drm] RAM width 64bits DDR
[    0.527547] [TTM] Zone  kernel: Available graphics memory: 12312814 kiB
[    0.527617] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    0.527687] [TTM] Initializing pool allocator
[    0.527757] [TTM] Initializing DMA pool allocator
[    0.527841] [drm] radeon: 1024M of VRAM memory ready
[    0.527909] [drm] radeon: 1024M of GTT memory ready.
[    0.527984] [drm] Loading CEDAR Microcode
[    0.528055] [drm] Internal thermal controller without fan control
[    0.560702] [drm] radeon: dpm initialized
[    0.560782] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    0.561344] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[    0.580165] [drm] PCIE GART of 1024M enabled (table at 0x000000000014C000).
[    0.580326] radeon 0000:01:00.0: WB enabled
[    0.580396] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x(____ptrval____)
[    0.580491] radeon 0000:01:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x(____ptrval____)
[    0.580948] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x000000000005c418 and cpu addr 0x(____ptrval____)
[    0.581043] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    0.581112] [drm] Driver supports precise vblank timestamp query.
[    0.581182] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    0.581286] radeon 0000:01:00.0: radeon: using MSI.
[    0.581373] [drm] radeon: irq initialized.
[    0.597761] [drm] ring test on 0 succeeded in 1 usecs
[    0.597833] [drm] ring test on 3 succeeded in 2 usecs
[    0.784985] [drm] ring test on 5 succeeded in 1 usecs
[    0.785057] [drm] UVD initialized successfully.
[    0.785225] [drm] ib test on ring 0 succeeded in 0 usecs
[    0.785333] [drm] ib test on ring 3 succeeded in 0 usecs
[    1.445357] [drm] ib test on ring 5 succeeded
[    1.445688] [drm] Radeon Display Connectors
[    1.445757] [drm] Connector 0:
[    1.445825] [drm]   HDMI-A-1
[    1.445892] [drm]   HPD1
[    1.445960] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468 0x646c 0x646c
[    1.446052] [drm]   Encoders:
[    1.446120] [drm]     DFP1: INTERNAL_UNIPHY1
[    1.446188] [drm] Connector 1:
[    1.446261] [drm]   DVI-I-1
[    1.446328] [drm]   HPD4
[    1.446396] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    1.446487] [drm]   Encoders:
[    1.446555] [drm]     DFP2: INTERNAL_UNIPHY
[    1.446623] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[    1.446692] [drm] Connector 2:
[    1.446759] [drm]   VGA-1
[    1.446827] [drm]   DDC: 0x6430 0x6430 0x6434 0x6434 0x6438 0x6438 0x643c 0x643c
[    1.446919] [drm]   Encoders:
[    1.446986] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    1.499300] [drm] fb mappable at 0xE034D000
[    1.499390] [drm] vram apper at 0xE0000000
[    1.499479] [drm] size 9216000
[    1.499567] [drm] fb depth is 24
[    1.499655] [drm]    pitch is 7680
[    1.499839] fbcon: radeondrmfb (fb0) is primary device
[    1.533042] Console: switching to colour frame buffer device 240x75
[    1.537059] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[    1.537124] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[    1.538798] loop: module loaded
[    1.538957] ata_piix 0000:00:1f.2: version 2.13
[    1.539024] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    1.557289] tsc: Refined TSC clocksource calibration: 3100.021 MHz
[    1.557342] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2caf5bd675d, max_idle_ns: 440795281274 ns
[    1.557383] clocksource: Switched to clocksource tsc
[    1.693480] kworker/u8:3 (1145) used greatest stack depth: 14008 bytes left
[    1.693596] scsi host0: ata_piix
[    1.693702] scsi host1: ata_piix
[    1.693740] ata1: SATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf090 irq 14
[    1.693764] ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf098 irq 15
[    1.693863] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    1.845292] ata_piix 0000:00:1f.5: SCR access via SIDPR is available but doesn't work
[    1.845557] scsi host2: ata_piix
[    1.845689] scsi host3: ata_piix
[    1.845729] ata3: SATA max UDMA/133 cmd 0xf070 ctl 0xf060 bmdma 0xf030 irq 19
[    1.845754] ata4: SATA max UDMA/133 cmd 0xf050 ctl 0xf040 bmdma 0xf038 irq 19
[    1.845829] PPP generic driver version 2.4.2
[    1.845893] PPP BSD Compression module registered
[    1.845921] PPP Deflate Compression module registered
[    1.845941] PPP MPPE Compression module registered
[    1.845957] NET: Registered protocol family 24
[    1.846034] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.846063] ehci-pci: EHCI PCI platform driver
[    1.846171] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    1.846214] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    1.846256] ehci-pci 0000:00:1a.0: debug port 2
[    1.850171] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[    1.850179] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7f02000
[    1.856281] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    1.856355] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.856381] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.856403] usb usb1: Product: EHCI Host Controller
[    1.856418] usb usb1: Manufacturer: Linux 4.19.72-gentoo ehci_hcd
[    1.856436] usb usb1: SerialNumber: 0000:00:1a.0
[    1.856592] hub 1-0:1.0: USB hub found
[    1.856620] hub 1-0:1.0: 2 ports detected
[    1.856830] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.856880] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    1.856922] ehci-pci 0000:00:1d.0: debug port 2
[    1.860822] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[    1.860830] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7f01000
[    1.867287] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.867357] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.867383] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.867404] usb usb2: Product: EHCI Host Controller
[    1.867420] usb usb2: Manufacturer: Linux 4.19.72-gentoo ehci_hcd
[    1.867438] usb usb2: SerialNumber: 0000:00:1d.0
[    1.867589] hub 2-0:1.0: USB hub found
[    1.867610] hub 2-0:1.0: 2 ports detected
[    1.868685] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.869676] ohci-pci: OHCI PCI platform driver
[    1.870640] uhci_hcd: USB Universal Host Controller Interface driver
[    1.871674] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    1.872729] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
[    1.873834] xhci_hcd 0000:03:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x0000000000000004
[    1.875025] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.876041] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.877047] usb usb3: Product: xHCI Host Controller
[    1.878017] usb usb3: Manufacturer: Linux 4.19.72-gentoo xhci-hcd
[    1.878995] usb usb3: SerialNumber: 0000:03:00.0
[    1.880119] hub 3-0:1.0: USB hub found
[    1.881116] hub 3-0:1.0: 2 ports detected
[    1.882181] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    1.883255] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 4
[    1.884251] xhci_hcd 0000:03:00.0: Host supports USB 3.0 SuperSpeed
[    1.885258] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.886276] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    1.887288] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.888303] usb usb4: Product: xHCI Host Controller
[    1.889321] usb usb4: Manufacturer: Linux 4.19.72-gentoo xhci-hcd
[    1.890343] usb usb4: SerialNumber: 0000:03:00.0
[    1.891496] hub 4-0:1.0: USB hub found
[    1.892558] hub 4-0:1.0: 2 ports detected
[    1.893735] xhci_hcd 0000:06:00.0: xHCI Host Controller
[    1.894815] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 5
[    1.895960] xhci_hcd 0000:06:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x0000000000000004
[    1.897175] usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 4.19
[    1.898210] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.899241] usb usb5: Product: xHCI Host Controller
[    1.900269] usb usb5: Manufacturer: Linux 4.19.72-gentoo xhci-hcd
[    1.901288] usb usb5: SerialNumber: 0000:06:00.0
[    1.902394] hub 5-0:1.0: USB hub found
[    1.903413] hub 5-0:1.0: 2 ports detected
[    1.904482] xhci_hcd 0000:06:00.0: xHCI Host Controller
[    1.905546] xhci_hcd 0000:06:00.0: new USB bus registered, assigned bus number 6
[    1.906550] xhci_hcd 0000:06:00.0: Host supports USB 3.0 SuperSpeed
[    1.907573] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.908602] usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 4.19
[    1.909622] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.910631] usb usb6: Product: xHCI Host Controller
[    1.911645] usb usb6: Manufacturer: Linux 4.19.72-gentoo xhci-hcd
[    1.912660] usb usb6: SerialNumber: 0000:06:00.0
[    1.913780] hub 6-0:1.0: USB hub found
[    1.914808] hub 6-0:1.0: 2 ports detected
[    1.915932] usbcore: registered new interface driver usb-storage
[    1.916974] i8042: PNP: No PS/2 controller found.
[    1.918077] mousedev: PS/2 mouse device common for all mice
[    1.919232] rtc_cmos 00:02: RTC can wake from S4
[    1.920395] rtc_cmos 00:02: registered as rtc0
[    1.921421] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    1.922583] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.923980] IR NEC protocol handler initialized
[    1.925008] IR RC5(x/sz) protocol handler initialized
[    1.926038] IR RC6 protocol handler initialized
[    1.927068] IR JVC protocol handler initialized
[    1.928080] IR Sony protocol handler initialized
[    1.929086] IR SANYO protocol handler initialized
[    1.930088] IR Sharp protocol handler initialized
[    1.931082] IR MCE Keyboard/mouse protocol handler initialized
[    1.932085] IR XMP protocol handler initialized
[    1.933152] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    1.934194] intel_pstate: Intel P-state driver initializing
[    1.935340] hidraw: raw HID events driver (C) Jiri Kosina
[    1.937601] usbcore: registered new interface driver usbhid
[    1.939599] usbhid: USB HID core driver
[    1.942241] Initializing XFRM netlink socket
[    1.944364] NET: Registered protocol family 10
[    1.946531] Segment Routing with IPv6
[    1.948627] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.949764] NET: Registered protocol family 17
[    1.950799] Key type dns_resolver registered
[    1.951978] mce: Using 7 MCE banks
[    1.953024] microcode: sig=0x206a7, pf=0x2, revision=0x28
[    1.954765] microcode: Microcode Update Driver: v2.2.
[    1.954778] sched_clock: Marking stable (1944582279, 10177633)->(1977695499, -22935587)
[    1.957022] registered taskstats version 1
[    1.958050] Loading compiled-in X.509 certificates
[    1.959236] Btrfs loaded, crc32c=crc32c-generic
[    1.960506]   Magic number: 3:586:920
[    1.961581] console [netcon0] enabled
[    1.962579] netconsole: network logging started
[    1.963608] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.965039] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.966073] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.967457] cfg80211: failed to load regulatory.db
[    2.175286] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.191286] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    2.305807] usb 1-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    2.307803] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.310078] hub 1-1:1.0: USB hub found
[    2.312203] hub 1-1:1.0: 6 ports detected
[    2.323670] usb 2-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    2.325418] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.327439] hub 2-1:1.0: USB hub found
[    2.329304] hub 2-1:1.0: 8 ports detected
[    2.461345] ata1.00: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
[    2.463295] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[    2.470060] ata1.00: ATA-11: WDC WDS500G2B0B-00YS70, X61130WD, max UDMA/133
[    2.472004] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    2.474024] ata1.01: ATA-8: WDC WD7500AACS-00D6B1, 01.01A01, max UDMA/133
[    2.475464] ata1.01: 1465149168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    2.480292] ata1.00: configured for UDMA/133
[    2.485284] ata1.01: configured for UDMA/133
[    2.487402] scsi 0:0:0:0: Direct-Access     ATA      WDC WDS500G2B0B- 30WD PQ: 0 ANSI: 5
[    2.489504] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    2.489570] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.492348] scsi 0:0:1:0: Direct-Access     ATA      WDC WD7500AACS-0 1A01 PQ: 0 ANSI: 5
[    2.494918] sd 0:0:0:0: [sda] Write Protect is off
[    2.497480] sd 0:0:1:0: Attached scsi generic sg1 type 0
[    2.497510] sd 0:0:1:0: [sdb] 1465149168 512-byte logical blocks: (750 GB/699 GiB)
[    2.497519] sd 0:0:1:0: [sdb] Write Protect is off
[    2.497521] sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
[    2.497537] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.499035] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.520427] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.566266]  sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 >
[    2.568369]  sda: sda1 sda2 sda3 sda4
[    2.568861] sd 0:0:1:0: [sdb] Attached SCSI disk
[    2.569956] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.589276] usb 1-1.3: new full-speed USB device number 3 using ehci-pci
[    2.606263] usb 2-1.1: new high-speed USB device number 3 using ehci-pci
[    2.670969] usb 1-1.3: New USB device found, idVendor=09da, idProduct=f624, bcdDevice=24.55
[    2.672929] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.674866] usb 1-1.3: Product: USB Device
[    2.676799] usb 1-1.3: Manufacturer: COMPANY
[    2.680319] input: COMPANY USB Device as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.0/0003:09DA:F624.0001/input/input2
[    2.693665] usb 2-1.1: New USB device found, idVendor=14cd, idProduct=168a, bcdDevice= 0.01
[    2.695231] usb 2-1.1: New USB device strings: Mfr=1, Product=3, SerialNumber=2
[    2.696767] usb 2-1.1: Product: USB Mass Storage Device
[    2.698299] usb 2-1.1: Manufacturer: USB Device  
[    2.699825] usb 2-1.1: SerialNumber: 816820130806
[    2.701711] usb-storage 2-1.1:1.0: USB Mass Storage device detected
[    2.703467] scsi host4: usb-storage 2-1.1:1.0
[    2.733566] hid-generic 0003:09DA:F624.0001: input,hidraw0: USB HID v1.11 Keyboard [COMPANY USB Device] on usb-0000:00:1a.0-1.3/input0
[    2.736972] input: COMPANY USB Device as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.1/0003:09DA:F624.0002/input/input3
[    2.739342] hid-generic 0003:09DA:F624.0002: input,hidraw1: USB HID v1.11 Mouse [COMPANY USB Device] on usb-0000:00:1a.0-1.3/input1
[    2.743458] input: COMPANY USB Device Keyboard as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:09DA:F624.0003/input/input4
[    2.768287] usb 2-1.6: new low-speed USB device number 4 using ehci-pci
[    2.797395] input: COMPANY USB Device System Control as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:09DA:F624.0003/input/input5
[    2.799798] input: COMPANY USB Device Consumer Control as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:09DA:F624.0003/input/input6
[    2.802187] input: COMPANY USB Device as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3:1.2/0003:09DA:F624.0003/input/input7
[    2.804695] hid-generic 0003:09DA:F624.0003: input,hiddev96,hidraw2: USB HID v1.11 Keyboard [COMPANY USB Device] on usb-0000:00:1a.0-1.3/input2
[    2.855039] usb 2-1.6: New USB device found, idVendor=046d, idProduct=c01e, bcdDevice=22.00
[    2.857406] usb 2-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.859757] usb 2-1.6: Product: USB-PS/2 Optical Mouse
[    2.861971] usb 2-1.6: Manufacturer: Logitech
[    2.868466] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/2-1.6:1.0/0003:046D:C01E.0004/input/input8
[    2.870874] hid-generic 0003:046D:C01E.0004: input,hidraw3: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:1d.0-1.6/input0
[    2.872575] usb 1-1.5: new high-speed USB device number 4 using ehci-pci
[    2.974026] usb 1-1.5: New USB device found, idVendor=0cf3, idProduct=9271, bcdDevice= 1.08
[    2.976523] usb 1-1.5: New USB device strings: Mfr=16, Product=32, SerialNumber=48
[    2.978992] usb 1-1.5: Product: UB91C
[    2.981436] usb 1-1.5: Manufacturer: ATHEROS
[    2.983880] usb 1-1.5: SerialNumber: 12345
[    3.037291] ata2.01: failed to resume link (SControl 30)
[    3.197348] ata2.00: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
[    3.199829] ata2.01: SATA link down (SStatus 4 SControl 30)
[    3.205129] ata2.00: ATA-10: ST3000DM007-1WY10G, 0001, max UDMA/133
[    3.207592] ata2.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.215074] ata2.00: configured for UDMA/133
[    3.217762] scsi 1:0:0:0: Direct-Access     ATA      ST3000DM007-1WY1 0001 PQ: 0 ANSI: 5
[    3.220652] sd 1:0:0:0: Attached scsi generic sg2 type 0
[    3.220703] sd 1:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[    3.225258] sd 1:0:0:0: [sdc] 4096-byte physical blocks
[    3.226830] sd 1:0:0:0: [sdc] Write Protect is off
[    3.228360] sd 1:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    3.228377] sd 1:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.293614]  sdc: sdc1 sdc2
[    3.296295] sd 1:0:0:0: [sdc] Attached SCSI disk
[    3.323041] PM: Image not found (code -22)
[    3.323045] ALSA device list:
[    3.325495]   No soundcards found.
[    3.327966] md: Waiting for all devices to be available before autodetect
[    3.330419] md: If you don't use raid, use raid=noautodetect
[    3.332177] md: Autodetecting RAID arrays.
[    3.333490] md: autorun ...
[    3.334789] md: ... autorun DONE.
[    3.351659] random: fast init done
[    3.357652] BTRFS: device fsid a942b8da-e92d-4348-8de9-ded1e5e095ad devid 1 transid 743928 /dev/root
[    3.359342] BTRFS info (device sda4): disk space caching is enabled
[    3.360649] BTRFS info (device sda4): has skinny extents
[    3.402059] BTRFS info (device sda4): enabling ssd optimizations
[    3.406415] VFS: Mounted root (btrfs filesystem) readonly on device 0:18.
[    3.409539] devtmpfs: mounted
[    3.412997] Freeing unused kernel image memory: 1272K
[    3.421334] Write protecting the kernel read-only data: 20480k
[    3.423086] Freeing unused kernel image memory: 1980K
[    3.424531] Freeing unused kernel image memory: 544K
[    3.425854] Run /sbin/init as init process
[    3.508965] kbd_mode (1458) used greatest stack depth: 13088 bytes left
[    3.520290] init-early.sh (1457) used greatest stack depth: 12792 bytes left
[    3.603628] grep (1476) used greatest stack depth: 12472 bytes left
[    3.735062] scsi 4:0:0:0: Direct-Access     USB Mass  Storage Device  1.00 PQ: 0 ANSI: 0
[    3.737198] sd 4:0:0:0: Attached scsi generic sg3 type 0
[    3.738489] sd 4:0:0:0: [sdd] Attached SCSI removable disk
[    3.928954] random: lvm: uninitialized urandom read (4 bytes read)
[    3.939082] random: lvm: uninitialized urandom read (4 bytes read)
[    4.686429] udevd[1957]: starting version 3.2.5
[    4.702695] random: udevd: uninitialized urandom read (16 bytes read)
[    4.726390] udevd[1957]: starting eudev-3.2.5
[    4.797858] r8169 0000:07:00.0: can't disable ASPM; OS doesn't have ASPM control
[    4.801465] libphy: r8169: probed
[    4.802001] r8169 0000:07:00.0 eth0: RTL8168e/8111e, 8c:89:a5:16:2f:11, XID 2c200000, IRQ 36
[    4.802004] r8169 0000:07:00.0 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    4.806290] usb 1-1.5: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
[    4.806574] usbcore: registered new interface driver ath9k_htc
[    4.817828] ath: EEPROM regdomain: 0x21
[    4.817829] ath: EEPROM indicates we should expect a direct regpair map
[    4.817830] ath: Country alpha2 being used: BB
[    4.817831] ath: Regpair used: 0x21
[    4.818530] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
[    4.818769] ieee80211 phy0: Atheros AR9485 Rev:1 mem=0xffffb1cec3400000, irq=16
[    4.839625] r8169 0000:07:00.0 enp7s0: renamed from eth0
[    4.841548] snd_emu10k1 0000:05:01.0: Installing spdif_bug patch: SB Audigy 2 ZS [SB0350]
[    4.857353] ath9k 0000:02:00.0 wlp2s0: renamed from wlan0
[    4.965599] BTRFS: device fsid 62164480-0c5e-45da-807b-33f8bfe76ecf devid 1 transid 120247 /dev/sdc1
[    5.087019] f71882fg: Found f71889a chip at 0x290, revision 49
[    5.087120] f71882fg f71882fg.656: Fan: 1 is in duty-cycle mode
[    5.087137] f71882fg f71882fg.656: Fan: 2 is in duty-cycle mode
[    5.087141] f71882fg f71882fg.656: Auto pwm controlled by raw digital data, disabling pwm auto_point sysfs attributes for fan 2
[    5.087146] f71882fg f71882fg.656: Fan: 3 is in duty-cycle mode
[    5.087150] f71882fg f71882fg.656: Auto pwm controlled by raw digital data, disabling pwm auto_point sysfs attributes for fan 3
[    5.087151] f71882fg f71882fg.656: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    5.090844] usb 1-1.5: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
[    5.174456] random: crng init done
[    5.174457] random: 7 urandom warning(s) missed due to ratelimiting
[    5.342587] ath9k_htc 1-1.5:1.0: ath9k_htc: HTC initialized with 33 credits
[    5.391508] BTRFS info (device sda4): device fsid a942b8da-e92d-4348-8de9-ded1e5e095ad devid 1 moved old:/dev/root new:/dev/sda4
[    5.579115] ath9k_htc 1-1.5:1.0: ath9k_htc: FW Version: 1.4
[    5.579118] ath9k_htc 1-1.5:1.0: FW RMW support: On
[    5.579120] ath: EEPROM regdomain: 0x833a
[    5.579120] ath: EEPROM indicates we should expect a country code
[    5.579122] ath: doing EEPROM country->regdmn map search
[    5.579123] ath: country maps to regdmn code: 0x37
[    5.579124] ath: Country alpha2 being used: GB
[    5.579124] ath: Regpair used: 0x37
[    5.583015] ieee80211 phy1: Atheros AR9271 Rev:1
[    5.583940] ath9k_htc 1-1.5:1.0 wlp0s26u1u5: renamed from wlan0
[    6.323007] BTRFS info (device sda4): disk space caching is enabled
[    6.455415] Adding 26214396k swap on /dev/sdc2.  Priority:-2 extents:1 across:26214396k 
[    6.503265] BTRFS info (device sdc1): disk space caching is enabled
[    6.503266] BTRFS info (device sdc1): has skinny extents
[    8.890135] BTRFS critical (device sdc1): corrupt leaf: root=2 block=855738744832 slot=20, unexpected item end, have 15287 expect 15223
[    8.899635] BTRFS critical (device sdc1): corrupt leaf: root=2 block=855738744832 slot=20, unexpected item end, have 15287 expect 15223
[    8.899654] BTRFS error (device sdc1): failed to read block groups: -5
[    8.906858] BTRFS error (device sdc1): open_ctree failed
[   11.281589] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   11.281712] ip (2998) used greatest stack depth: 12168 bytes left
[   12.342011] wlp2s0: authenticate with 78:94:b4:4d:f5:4d
[   12.362618] wlp2s0: send auth to 78:94:b4:4d:f5:4d (try 1/3)
[   12.364660] wlp2s0: authenticated
[   12.365283] wlp2s0: associate with 78:94:b4:4d:f5:4d (try 1/3)
[   12.371468] wlp2s0: RX AssocResp from 78:94:b4:4d:f5:4d (capab=0x411 status=0 aid=2)
[   12.371593] wlp2s0: associated
[   12.393477] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
[   29.259571] Guest personality initialized and is inactive
[   29.260283] VMCI host device registered (name=vmci, major=10, minor=57)
[   29.260284] Initialized host personality
[   29.268458] NET: Registered protocol family 40
[   29.273179] vmmon: loading out-of-tree module taints kernel.
[   29.273965] /dev/vmmon[4698]: Module vmmon: registered with major=10 minor=165
[   29.273969] /dev/vmmon[4698]: Using tsc_khz as TSC frequency: 3100021
[   29.273970] /dev/vmmon[4698]: Module vmmon: initialized
[   30.352196] userif-3: sent link down event.
[   30.352199] userif-3: sent link up event.
[   43.577239] elogind-daemon[4925]: New seat seat0.
[   43.578310] elogind-daemon[4925]: Watching system buttons on /dev/input/event1 (Power Button)
[   43.578391] elogind-daemon[4925]: Watching system buttons on /dev/input/event0 (Power Button)
[   43.578515] elogind-daemon[4925]: Watching system buttons on /dev/input/event2 (COMPANY USB Device)
[   43.578657] elogind-daemon[4925]: Watching system buttons on /dev/input/event4 (COMPANY USB Device Keyboard)
[   43.578778] elogind-daemon[4925]: Watching system buttons on /dev/input/event5 (COMPANY USB Device System Control)
[   43.578894] elogind-daemon[4925]: Watching system buttons on /dev/input/event6 (COMPANY USB Device Consumer Control)
[   49.479561] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[   49.479884] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.924852] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.925221] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.925560] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.925902] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.926257] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.926589] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.926896] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.927279] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.927629] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.928007] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.928369] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.928714] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.929053] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.929433] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.929761] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.930138] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[  346.930477] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1209.618572] kworker/dying (61) used greatest stack depth: 12080 bytes left
[ 1367.998898] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1367.999257] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1367.999591] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1367.999918] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.000243] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.000567] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.000888] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.001216] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.001540] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.001862] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.002491] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.002828] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.003129] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.003438] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.003737] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.004073] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 1368.004387] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2980.179713] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2980.180185] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2980.180510] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2982.187428] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2982.187929] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2982.188326] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2987.443228] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2987.443592] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 2987.443955] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3007.467286] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3007.467702] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3007.468038] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3023.986441] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3023.986957] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3023.987359] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3086.969816] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3102.297386] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3126.161205] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3126.529373] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3130.401471] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3171.089094] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3171.652405] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3171.899954] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3175.480719] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3175.937426] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3176.196326] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3176.460170] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3176.716493] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3176.956328] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3182.160090] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3182.506729] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3182.841023] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3244.291476] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3244.291816] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3252.471756] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3252.472868] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3255.584466] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3255.584883] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3359.845168] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3359.845505] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3372.824001] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3372.824382] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3399.376402] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3399.376710] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3399.377073] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3399.377369] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3405.680361] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3405.680776] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3405.681236] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3405.681586] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3420.066902] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0
[ 3420.067271] BTRFS critical (device sda4): corrupt leaf: root=5 block=134079905792 slot=0 ino=843063, dir item with invalid data len, have 256 expect 0

--------------C767770073C14F2702418BFD--
