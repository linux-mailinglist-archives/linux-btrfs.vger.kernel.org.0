Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EC3D8F49
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 15:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbhG1Nlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbhG1Nlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 09:41:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6BC061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:41:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k4so1445138wms.3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=g1O7vERaXUzhdGBpnMV16QMelILx3j/l4i1+J4/d8yg=;
        b=lfuLy0gW5v4FEYRYWyeQiZzOTEQZ5J02XSu36WmcsPTGJL5fxRG//uZtlXDZrV0QsJ
         a1EI1el20RQWXTMvh3bA3QxFJyj1MY7munkQtzglhGdoGBsJvgB0BQ7D0l35XBcNWtqj
         WVctmAq/Ea1pdsfZlFcvHiyDmJwLRm4WMrpNJ8zCGl3zxgmfFf6o3A5/OoZoD8sfKhwz
         zMyTiLOnnzjPFh72O5wnCbfrvEsY+k1x6GqU+dl8Um1hS3n3Vo4w3dR+ds1JmOL4m4X5
         gkNELFwFzhoY3LzWv6Cp1os4UnTGHsSOW6n1BAuXqD/No2U9LTqO7VgaXsq/E4wybhq9
         o0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=g1O7vERaXUzhdGBpnMV16QMelILx3j/l4i1+J4/d8yg=;
        b=ppYupLq6/IcBGueSnh1aib7hPjQUW16dT86N6E32EL9vOFUdNUZnPFUP6LQxFSbKMR
         w6QXXadHuseeYHmAEDEyKCGK/btLd+4dmBvViYHoHZcD/6THoMdUsDLD0C6Llioy6Irb
         hCXZeqCGDJ+AYpnsdx2XhZGBLM0sffbX/of9L5VBqLHr8ZdhbWjmJsApx0JCxjy4O42x
         28UwXa7kCGG7G7o6wmTWI852eQReii1PqA2jBEA+UmQvTlW9CR5GN+Fkdsq6/04be5hu
         6B0sPivzsI2Csqby/y3Jetjai7/7IK8lZ4F7h6BfVZCiSCWIcyC+KGFkWCJrfHTKDnoN
         53gA==
X-Gm-Message-State: AOAM533Di+jaA7kP5Q8ALGLz4DiuiUJXdlx98691J4NxwMXk70X/SQKm
        o2Ac8KsU0dJZPj1jVCqR4I19iNbksgc=
X-Google-Smtp-Source: ABdhPJwxCF56tKewBpu6LLeOeMR1oDnXmAVG86aIhSKiwwi+WjTQVXyJHLCXpOLXjApop2EdTfPyjQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr9471975wmi.54.1627479707678;
        Wed, 28 Jul 2021 06:41:47 -0700 (PDT)
Received: from [192.168.0.5] (80-44-88-84.dynamic.dsl.as9105.com. [80.44.88.84])
        by smtp.gmail.com with ESMTPSA id b14sm1397465wrm.43.2021.07.28.06.41.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jul 2021 06:41:46 -0700 (PDT)
From:   Ian B <ianpeterball@gmail.com>
Subject: Unmountable Volume
To:     linux-btrfs@vger.kernel.org
Message-ID: <9ab13a41-619f-1aaf-2c41-2ef4a67802f3@gmail.com>
Date:   Wed, 28 Jul 2021 14:41:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Antivirus: AVG (VPS 210728-2, 28/7/2021), Outbound message
X-Antivirus-Status: Clean
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signature Hi,

I've been advised to post here, for a opinion on which way is best to go 
forward with my problem.

The volume(?) hasn't mounted in my NAS (NetGear rndp6000). I'm advised 
that the files are there, as a dummy run of restore (btrfs restore -DviF 
/dev/md125 /dev/null), showed. There is one folder & it's subfolders 
which isn't backed-up. If the whole volume can't mount, can this one 
folder be copied elsewhere, where I can access the files?

So far the options put forward are.

1. Try to repair the filesystem (BTRFSCK) which might not work either 
and can cause more damage than good.
2. Dump the data somewhere else via BTRFS restore (giving you a backup 
essentially). Then some how verify this is good, then factory reset the 
NAS.
3. Forget about the data and just reset the NAS.
4. Put my faith in the btrfs community to come up with a plan.

I have some spare disks, which at some point where in the NAS and 
haven't been touch since removal. I have four 6TB, three 2TB, three 
1.5TB and one 500GB. I also have the logs from the NAS.

Many thanks for you time and insite.

Ian

REQUESTED OUTPUTS



*root@Pro:~# uname -a *

Linux Pro 4.4.218.x86_64.1 #1 SMP Mon Jan 11 06:25:23 UTC 2021 x86_64 
GNU/Linux


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*root@Pro:~# btrfs --version *

btrfs-progs v4.16



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*root@Pro:~# btrfs fi show *

Label: '33eb0773:root'  uuid: 13624a2a-e24e-48ae-ad2b-f786913ec748
         Total devices 1 FS bytes used 1.03GiB
         devid    1 size 4.00GiB used 4.00GiB path /dev/md0

Label: '33eb0773:Dual'  uuid: 29bccc98-ff07-426d-a82d-1a79b34131a3
         Total devices 3 FS bytes used 21.57TiB
         devid    1 size 7.26TiB used 6.49TiB path /dev/md127
         devid    2 size 14.55TiB used 12.34TiB path /dev/md126
         devid    3 size 10.91TiB used 2.80TiB path /dev/md125


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*root@Pro:~# btrfs fi df /Dual*
*
*
Data, single: total=3.58GiB, used=1.02GiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=204.56MiB, used=14.98MiB
GlobalReserve, single: total=16.00MiB, used=0.00B

*root@Pro:~# btrfs fi df /dev/md126*
ERROR: not a btrfs filesystem: /dev/md126




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*root@Pro:~# dmesg *

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.218.x86_64.1 (root@blocks) (gcc version 
8.3.0 (Debian 8.3.0-6) ) #1 SMP Mon Jan 11 06:25:23 UTC 2021
[    0.000000] Command line: initrd=initrd.gz reason=normal 
BOOT_IMAGE=kernel
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] Disabled fast string operations
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating 
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 
bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cbff] 
usable
[    0.000000] BIOS-e820: [mem 0x000000000009cc00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000afeaffff] 
usable
[    0.000000] BIOS-e820: [mem 0x00000000afeb0000-0x00000000afebdfff] 
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000afebe000-0x00000000afeeffff] 
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000afef0000-0x00000000afefffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000001cfffffff] 
usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./To be 
filled by O.E.M., BIOS 080014  07/26/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1d0000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 1D0000000 mask FF0000000 uncachable
[    0.000000]   1 base 1E0000000 mask FE0000000 uncachable
[    0.000000]   2 base 000000000 mask E00000000 write-back
[    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   5 base 0AFF00000 mask FFFF00000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB WC  UC- WT
[    0.000000] e820: update [mem 0xaff00000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xafeb0 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000094000] 94000 size 
28672
[    0.000000] BRK [0x08f56000, 0x08f56fff] PGTABLE
[    0.000000] BRK [0x08f57000, 0x08f57fff] PGTABLE
[    0.000000] BRK [0x08f58000, 0x08f58fff] PGTABLE
[    0.000000] BRK [0x08f59000, 0x08f59fff] PGTABLE
[    0.000000] BRK [0x08f5a000, 0x08f5afff] PGTABLE
[    0.000000] BRK [0x08f5b000, 0x08f5bfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x7fb9e000-0x7fffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F9C00 000014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 0x00000000AFEB0000 000038 (v01 A M I OEMRSDT  
07001026 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000AFEB0200 000084 (v02 A M I OEMFACP  
07001026 MSFT 00000097)
[    0.000000] ACPI: DSDT 0x00000000AFEB0440 005B7A (v01 1ADHK 1ADHK007 
00000007 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000AFEBE000 000040
[    0.000000] ACPI: APIC 0x00000000AFEB0390 00006C (v01 A M I OEMAPIC  
07001026 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000AFEB0400 00003C (v01 A M I OEMMCFG  
07001026 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000AFEBE040 000060 (v01 A M I AMI_OEM  
07001026 MSFT 00000097)
[    0.000000] ACPI: GSCI 0x00000000AFEBE0A0 002024 (v01 A M I GMCHSCI  
07001026 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000001cfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000afeaffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000001cfffffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000001000-0x00000001cfffffff]
[    0.000000] On node 0 totalpages: 1572427
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11195 pages used for memmap
[    0.000000]   DMA32 zone: 716464 pages, LIFO batch:31
[    0.000000]   Normal zone: 13312 pages used for memmap
[    0.000000]   Normal zone: 851968 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 
0xaff00000-0xafffffff
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] e820: [mem 0xb0000000-0xfedfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 
nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff8801cfc00000 s82392 
r8192 d32296 u524288
[    0.000000] pcpu-alloc: s82392 r8192 d32296 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 1547834
[    0.000000] Kernel command line: console=tty0 console=ttyS0,115200 
hpet=disable initrd=initrd.gz reason=normal BOOT_IMAGE=kernel
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 
8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 
4194304 bytes)
[    0.000000] Memory: 6092116K/6289708K available (9142K kernel code, 
989K rwdata, 3940K rodata, 872K init, 696K bss, 197592K reserved, 0K 
cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU debugfs-based tracing is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:456 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2593.562 MHz processor
[    0.001013] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 5187.12 BogoMIPS (lpj=2593562)
[    0.001016] pid_max: default: 32768 minimum: 301
[    0.001022] ACPI: Core revision 20150930
[    0.005344] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.005365] Security Framework initialized
[    0.005377] Mount-cache hash table entries: 16384 (order: 5, 131072 
bytes)
[    0.005379] Mountpoint-cache hash table entries: 16384 (order: 5, 
131072 bytes)
[    0.005870] Initializing cgroup subsys io
[    0.005876] Initializing cgroup subsys memory
[    0.005888] Initializing cgroup subsys devices
[    0.005893] Initializing cgroup subsys freezer
[    0.005898] Initializing cgroup subsys net_cls
[    0.005902] Initializing cgroup subsys perf_event
[    0.005906] Initializing cgroup subsys net_prio
[    0.005911] Initializing cgroup subsys pids
[    0.005931] Disabled fast string operations
[    0.005936] CPU: Physical Processor ID: 0
[    0.005937] CPU: Processor Core ID: 0
[    0.005939] mce: CPU supports 6 MCE banks
[    0.005950] CPU0: Thermal monitoring enabled (TM2)
[    0.005954] process: using mwait in idle threads
[    0.005959] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.005961] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.005963] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.005965] Spectre V2 : Mitigation: Full generic retpoline
[    0.005967] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling 
RSB on context switch
[    0.005968] Speculative Store Bypass: Vulnerable
[    0.005992] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.006436] Freeing SMP alternatives memory: 40K
[    0.008415] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.120458] smpboot: CPU0: Intel Pentium(R) Dual-Core  CPU E5300  @ 
2.60GHz (family: 0x6, model: 0x17, stepping: 0xa)
[    0.120475] Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events, 
Intel PMU driver.
[    0.120488] ... version:                2
[    0.120489] ... bit width:              40
[    0.120491] ... generic registers:      2
[    0.120492] ... value mask:             000000ffffffffff
[    0.120493] ... max period:             000000007fffffff
[    0.120494] ... fixed-purpose events:   3
[    0.120496] ... event mask:             0000000700000003
[    0.121800] x86: Booting SMP configuration:
[    0.121803] .... node  #0, CPUs:      #1
[    0.123049] x86: Booted up 1 node, 2 CPUs
[    0.123054] smpboot: Total of 2 processors activated (10374.24 BogoMIPS)
[    0.124120] NMI watchdog: enabled on all CPUs, permanently consumes 
one hw-PMU counter.
[    0.124176] devtmpfs: initialized
[    0.125228] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.125234] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.125336] xor: measuring software checksum speed
[    0.135001]    prefetch64-sse: 14784.000 MB/sec
[    0.145001]    generic_sse: 12472.000 MB/sec
[    0.145003] xor: using function: prefetch64-sse (14784.000 MB/sec)
[    0.145009] pinctrl core: initialized pinctrl subsystem
[    0.145186] NET: Registered protocol family 16
[    0.149014] cpuidle: using governor ladder
[    0.152006] cpuidle: using governor menu
[    0.152204] ACPI: bus type PCI registered
[    0.152282] dca service started, version 1.12.1
[    0.152294] PCI: Using configuration type 1 for base access
[    0.177882] raid6: sse2x1   gen()  3648 MB/s
[    0.194874] raid6: sse2x1   xor()  4152 MB/s
[    0.211878] raid6: sse2x2   gen()  4281 MB/s
[    0.228878] raid6: sse2x2   xor()  5283 MB/s
[    0.245879] raid6: sse2x4   gen()  7726 MB/s
[    0.262876] raid6: sse2x4   xor()  5720 MB/s
[    0.262878] raid6: using algorithm sse2x4 gen() 7726 MB/s
[    0.262879] raid6: .... xor() 5720 MB/s, rmw enabled
[    0.262881] raid6: using ssse3x2 recovery algorithm
[    0.263140] ACPI: Added _OSI(Module Device)
[    0.263140] ACPI: Added _OSI(Processor Device)
[    0.263140] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.263140] ACPI: Added _OSI(Processor Aggregator Device)
[    0.264808] ACPI: Executed 1 blocks of module-level executable AML code
[    0.267149] ACPI: Interpreter enabled
[    0.267155] ACPI: (supports S0 S5)
[    0.267157] ACPI: Using IOAPIC for interrupt routing
[    0.267191] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[    0.273185] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.273194] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments 
MSI]
[    0.273200] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.273297] PCI host bridge to bus 0000:00
[    0.273301] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7 window]
[    0.273304] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff window]
[    0.273307] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[    0.273310] pci_bus 0000:00: root bus resource [mem 
0x000d0000-0x000dffff window]
[    0.273312] pci_bus 0000:00: root bus resource [mem 
0xaff00000-0xffffffff window]
[    0.273315] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.273326] pci 0000:00:00.0: [8086:2990] type 00 class 0x060000
[    0.273436] pci 0000:00:02.0: [8086:2992] type 00 class 0x030000
[    0.273451] pci 0000:00:02.0: reg 0x10: [mem 0xffa00000-0xffafffff]
[    0.273462] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 
64bit pref]
[    0.273467] pci 0000:00:02.0: reg 0x20: [io  0xec00-0xec07]
[    0.273587] pci 0000:00:1a.0: [8086:2834] type 00 class 0x0c0300
[    0.273626] pci 0000:00:1a.0: reg 0x20: [io  0xe000-0xe01f]
[    0.273725] pci 0000:00:1a.1: [8086:2835] type 00 class 0x0c0300
[    0.273766] pci 0000:00:1a.1: reg 0x20: [io  0xdc00-0xdc1f]
[    0.273871] pci 0000:00:1a.7: [8086:283a] type 00 class 0x0c0320
[    0.273896] pci 0000:00:1a.7: reg 0x10: [mem 0xff9fb400-0xff9fb7ff]
[    0.273963] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.274054] pci 0000:00:1b.0: [8086:284b] type 00 class 0x040300
[    0.274078] pci 0000:00:1b.0: reg 0x10: [mem 0xff9f4000-0xff9f7fff 
64bit]
[    0.274131] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.274209] pci 0000:00:1c.0: [8086:283f] type 01 class 0x060400
[    0.274269] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.274354] pci 0000:00:1c.1: [8086:2841] type 01 class 0x060400
[    0.274414] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.274502] pci 0000:00:1d.0: [8086:2830] type 00 class 0x0c0300
[    0.274541] pci 0000:00:1d.0: reg 0x20: [io  0xd880-0xd89f]
[    0.274638] pci 0000:00:1d.1: [8086:2831] type 00 class 0x0c0300
[    0.274678] pci 0000:00:1d.1: reg 0x20: [io  0xd800-0xd81f]
[    0.274775] pci 0000:00:1d.2: [8086:2832] type 00 class 0x0c0300
[    0.274814] pci 0000:00:1d.2: reg 0x20: [io  0xd480-0xd49f]
[    0.275002] pci 0000:00:1d.7: [8086:2836] type 00 class 0x0c0320
[    0.275002] pci 0000:00:1d.7: reg 0x10: [mem 0xff9fb000-0xff9fb3ff]
[    0.275011] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.275094] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.275216] pci 0000:00:1f.0: [8086:2810] type 00 class 0x060100
[    0.275298] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by 
ICH6 ACPI/GPIO/TCO
[    0.275303] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by 
ICH6 GPIO
[    0.275307] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 
0a00 (mask 00ff)
[    0.275415] pci 0000:00:1f.2: [8086:2821] type 00 class 0x010601
[    0.275436] pci 0000:00:1f.2: reg 0x10: [io  0xe880-0xe887]
[    0.275444] pci 0000:00:1f.2: reg 0x14: [io  0xe800-0xe803]
[    0.275452] pci 0000:00:1f.2: reg 0x18: [io  0xe480-0xe487]
[    0.275459] pci 0000:00:1f.2: reg 0x1c: [io  0xe400-0xe403]
[    0.275467] pci 0000:00:1f.2: reg 0x20: [io  0xe080-0xe09f]
[    0.275475] pci 0000:00:1f.2: reg 0x24: [mem 0xff9fb800-0xff9fbfff]
[    0.275503] pci 0000:00:1f.2: PME# supported from D3hot
[    0.275584] pci 0000:00:1f.3: [8086:283e] type 00 class 0x0c0500
[    0.275598] pci 0000:00:1f.3: reg 0x10: [mem 0xff9fac00-0xff9facff]
[    0.275624] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    0.275778] pci 0000:01:00.0: [11ab:4362] type 00 class 0x020000
[    0.275817] pci 0000:01:00.0: reg 0x10: [mem 0xff6fc000-0xff6fffff 
64bit]
[    0.275829] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb8ff]
[    0.275869] pci 0000:01:00.0: reg 0x30: [mem 0xff6c0000-0xff6dffff pref]
[    0.275912] pci 0000:01:00.0: supports D1 D2
[    0.275914] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.276005] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.276005] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.276005] pci 0000:00:1c.0:   bridge window [io 0xb000-0xbfff]
[    0.276005] pci 0000:00:1c.0:   bridge window [mem 
0xff600000-0xff6fffff]
[    0.276056] pci 0000:02:00.0: [11ab:4362] type 00 class 0x020000
[    0.276095] pci 0000:02:00.0: reg 0x10: [mem 0xff7fc000-0xff7fffff 
64bit]
[    0.276107] pci 0000:02:00.0: reg 0x18: [io  0xc800-0xc8ff]
[    0.276148] pci 0000:02:00.0: reg 0x30: [mem 0xff7c0000-0xff7dffff pref]
[    0.276190] pci 0000:02:00.0: supports D1 D2
[    0.276193] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.276239] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  
You can enable it with 'pcie_aspm=force'
[    0.276250] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.276255] pci 0000:00:1c.1:   bridge window [io 0xc000-0xcfff]
[    0.276259] pci 0000:00:1c.1:   bridge window [mem 
0xff700000-0xff7fffff]
[    0.276336] pci 0000:00:1e.0: PCI bridge to [bus 03] (subtractive 
decode)
[    0.276345] pci 0000:00:1e.0:   bridge window [io 0x0000-0x0cf7 
window] (subtractive decode)
[    0.276347] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xffff 
window] (subtractive decode)
[    0.276350] pci 0000:00:1e.0:   bridge window [mem 
0x000a0000-0x000bffff window] (subtractive decode)
[    0.276352] pci 0000:00:1e.0:   bridge window [mem 
0x000d0000-0x000dffff window] (subtractive decode)
[    0.276355] pci 0000:00:1e.0:   bridge window [mem 
0xaff00000-0xffffffff window] (subtractive decode)
[    0.276370] pci_bus 0000:00: on NUMA node 0
[    0.277163] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 
14 15)
[    0.277219] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 
14 15)
[    0.277273] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 
*14 15)
[    0.277327] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 
14 15)
[    0.277381] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 
14 15) *0, disabled.
[    0.277436] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 
14 *15)
[    0.277490] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 
14 15)
[    0.277544] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 
14 15)
[    0.277600] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.277792] SCSI subsystem initialized
[    0.277818] libata version 3.00 loaded.
[    0.277826] ACPI: bus type USB registered
[    0.277869] usbcore: registered new interface driver usbfs
[    0.277886] usbcore: registered new interface driver hub
[    0.278021] usbcore: registered new device driver usb
[    0.278062] pps_core: LinuxPPS API ver. 1 registered
[    0.278062] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    0.278062] PTP clock support registered
[    0.278261] Advanced Linux Sound Architecture Driver Initialized.
[    0.278261] PCI: Using ACPI for IRQ routing
[    0.278261] PCI: pci_cache_line_size set to 64 bytes
[    0.278261] Expanded resource reserved due to conflict with PCI Bus 
0000:00
[    0.278261] e820: reserve RAM buffer [mem 0x0009cc00-0x0009ffff]
[    0.278261] e820: reserve RAM buffer [mem 0xafeb0000-0xafffffff]
[    0.278397] Bluetooth: Core ver 2.21
[    0.278407] NET: Registered protocol family 31
[    0.278409] Bluetooth: HCI device and connection manager initialized
[    0.278412] Bluetooth: HCI socket layer initialized
[    0.278415] Bluetooth: L2CAP socket layer initialized
[    0.278422] Bluetooth: SCO socket layer initialized
[    0.278783] clocksource: Switched to clocksource refined-jiffies
[    0.278869] FS-Cache: Loaded
[    0.279028] pnp: PnP ACPI init
[    0.279051] system 00:00: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.279051] system 00:00: Plug and Play ACPI device, IDs PNP0c01 
(active)
[    0.279110] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.279166] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b 
(active)
[    0.279378] pnp 00:03: [dma 0 disabled]
[    0.279439] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.279625] pnp 00:04: [dma 0 disabled]
[    0.279709] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.280000] system 00:05: [io  0x0a00-0x0a0f] has been reserved
[    0.280000] system 00:05: [io  0x0a10-0x0a1f] has been reserved
[    0.280000] system 00:05: Plug and Play ACPI device, IDs PNP0c02 
(active)
[    0.280121] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.280124] system 00:06: [io  0x0800-0x087f] has been reserved
[    0.280127] system 00:06: [io  0x0480-0x04bf] has been reserved
[    0.280130] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.280133] system 00:06: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.280137] system 00:06: Plug and Play ACPI device, IDs PNP0c02 
(active)
[    0.280241] system 00:07: [mem 0xffc00000-0xffefffff] has been reserved
[    0.280244] system 00:07: Plug and Play ACPI device, IDs PNP0c02 
(active)
[    0.280326] system 00:08: [mem 0xfec00000-0xfec00fff] could not be 
reserved
[    0.280330] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.280333] system 00:08: Plug and Play ACPI device, IDs PNP0c02 
(active)
[    0.280401] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
[    0.280404] system 00:09: Plug and Play ACPI device, IDs PNP0c02 
(active)
[    0.280583] system 00:0a: [mem 0x00000000-0x0009ffff] could not be 
reserved
[    0.280586] system 00:0a: [mem 0x000c0000-0x000cffff] could not be 
reserved
[    0.280589] system 00:0a: [mem 0x000e0000-0x000fffff] could not be 
reserved
[    0.280592] system 00:0a: [mem 0x00100000-0xafefffff] could not be 
reserved
[    0.280595] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 
(active)
[    0.280715] pnp: PnP ACPI: found 11 devices
[    0.289087] clocksource: acpi_pm: mask: 0xffffff max_cycles: 
0xffffff, max_idle_ns: 2085701024 ns
[    0.289104] clocksource: Switched to clocksource acpi_pm
[    0.289128] pci 0000:00:1c.0: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 
100000
[    0.289142] pci 0000:00:1c.1: bridge window [mem 
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 
100000
[    0.289161] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x000fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.289164] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x002fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.289167] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x000fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.289170] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x002fffff 64bit 
pref] res_to_dev_res add_size 200000 min_align 100000
[    0.289180] pci 0000:00:1c.0: BAR 9: assigned [mem 
0xb0000000-0xb01fffff 64bit pref]
[    0.289186] pci 0000:00:1c.1: BAR 9: assigned [mem 
0xb0200000-0xb03fffff 64bit pref]
[    0.289190] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.289193] pci 0000:00:1c.0:   bridge window [io 0xb000-0xbfff]
[    0.289198] pci 0000:00:1c.0:   bridge window [mem 
0xff600000-0xff6fffff]
[    0.289202] pci 0000:00:1c.0:   bridge window [mem 
0xb0000000-0xb01fffff 64bit pref]
[    0.289208] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.289211] pci 0000:00:1c.1:   bridge window [io 0xc000-0xcfff]
[    0.289216] pci 0000:00:1c.1:   bridge window [mem 
0xff700000-0xff7fffff]
[    0.289221] pci 0000:00:1c.1:   bridge window [mem 
0xb0200000-0xb03fffff 64bit pref]
[    0.289227] pci 0000:00:1e.0: PCI bridge to [bus 03]
[    0.289237] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.289240] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.289242] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.289245] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.289247] pci_bus 0000:00: resource 8 [mem 0xaff00000-0xffffffff 
window]
[    0.289250] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.289253] pci_bus 0000:01: resource 1 [mem 0xff600000-0xff6fffff]
[    0.289255] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xb01fffff 
64bit pref]
[    0.289258] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.289260] pci_bus 0000:02: resource 1 [mem 0xff700000-0xff7fffff]
[    0.289262] pci_bus 0000:02: resource 2 [mem 0xb0200000-0xb03fffff 
64bit pref]
[    0.289265] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7 window]
[    0.289267] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff window]
[    0.289269] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff 
window]
[    0.289272] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x000dffff 
window]
[    0.289274] pci_bus 0000:03: resource 8 [mem 0xaff00000-0xffffffff 
window]
[    0.289320] NET: Registered protocol family 2
[    0.289520] TCP established hash table entries: 65536 (order: 7, 
524288 bytes)
[    0.289825] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.290306] TCP: Hash tables configured (established 65536 bind 65536)
[    0.290395] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.290470] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.290664] NET: Registered protocol family 1
[    0.290822] RPC: Registered named UNIX socket transport module.
[    0.290824] RPC: Registered udp transport module.
[    0.290826] RPC: Registered tcp transport module.
[    0.290827] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.290845] pci 0000:00:02.0: Video device with shadowed ROM
[    0.396792] PCI: CLS 32 bytes, default 64
[    0.396868] Unpacking initramfs...
[    1.081825] Freeing initrd memory: 4488K
[    1.081844] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.081847] software IO TLB: mapped [mem 0xabeb0000-0xafeb0000] (64MB)
[    1.084618] audit: initializing netlink subsys (disabled)
[    1.084639] audit: type=2000 audit(1627404787.083:1): initialized
[    1.098929] VFS: Disk quotas dquot_6.6.0
[    1.099060] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    1.122301] NFS: Registering the id_resolver key type
[    1.122312] Key type id_resolver registered
[    1.122314] Key type id_legacy registered
[    1.122318] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    1.126924] Key type cifs.spnego registered
[    1.126933] Key type cifs.idmap registered
[    1.127019] fuse init (API version 7.23)
[    1.131780] NET: Registered protocol family 38
[    1.131791] async_tx: api initialized (async)
[    1.131910] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 251)
[    1.132792] io scheduler noop registered
[    1.132796] io scheduler deadline registered
[    1.132854] io scheduler cfq registered (default)
[    1.132943] io scheduler bfq registered
[    1.132944] BFQ I/O-scheduler: v7r11
[    1.133025] gpio_it87: no device
[    1.136705] intel_idle: does not run on family 6 model 23
[    1.136813] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.136819] ACPI: Power Button [PWRB]
[    1.136881] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.136884] ACPI: Power Button [PWRF]
[    1.137130] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    1.137244] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.157799] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) 
is a 16550A
[    1.179881] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) 
is a 16550A
[    1.180401] Linux agpgart interface v0.103
[    1.180447] agpgart-intel 0000:00:00.0: Intel 965Q Chipset
[    1.180471] agpgart-intel 0000:00:00.0: detected gtt size: 524288K 
total, 262144K mappable
[    1.180970] agpgart-intel 0000:00:00.0: detected 1024K stolen memory
[    1.181157] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 
0xd0000000
[    1.181221] [drm] Initialized drm 1.1.0 20060810
[    1.181912] [drm] Memory usable by graphics device = 512M
[    1.181915] [drm] Replacing VGA console driver
[    1.182695] Console: switching to colour dummy device 80x25
[    1.182751] pmd_set_huge: Cannot satisfy [mem 0xd0000000-0xd0200000] 
with a huge-page mapping due to MTRR override.
[    1.189361] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.189365] [drm] Driver supports precise vblank timestamp query.
[    1.196870] [drm] initialized overlay support
[    1.196955] [drm] Initialized i915 1.6.0 20151010 for 0000:00:02.0 on 
minor 0
[    1.204086] loop: module loaded
[    1.204452] gpio_ich: GPIO from 462 to 511 on gpio_ich
[    1.204623] mpt3sas version 12.100.00.00 loaded
[    1.210275] ahci 0000:00:1f.2: version 3.0
[    1.210513] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    1.210545] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 
0x3f impl SATA mode
[    1.210549] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo 
pio slum part ccc ems sxs
[    1.210658] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.210758] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.212138] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.214133] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.216087] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.218092] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.223539] scsi host0: ahci
[    1.227813] scsi host1: ahci
[    1.228293] scsi host2: ahci
[    1.229151] scsi host3: ahci
[    1.229983] scsi host4: ahci
[    1.230831] scsi host5: ahci
[    1.230907] ata1: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fb900 irq 25
[    1.230910] ata2: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fb980 irq 25
[    1.230912] ata3: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fba00 irq 25
[    1.230915] ata4: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fba80 irq 25
[    1.230918] ata5: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fbb00 irq 25
[    1.230920] ata6: SATA max UDMA/133 abar m2048@0xff9fb800 port 
0xff9fbb80 irq 25
[    1.231918] Rounding down aligned max_sectors from 4294967295 to 
4294967288
[    1.232044] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    1.232071] tun: Universal TUN/TAP device driver, 1.6
[    1.232072] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.232139] e1000: Intel(R) PRO/1000 Network Driver - version 
7.3.21-k8-NAPI
[    1.232140] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.232170] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.232172] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.232195] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.3.0-k
[    1.232197] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.232217] Intel(R) 10GbE PCI Express Linux Network Driver - version 
5.3.8
[    1.232219] Copyright(c) 1999 - 2018 Intel Corporation.
[    1.232273] i40e: Intel(R) 40-10 Gigabit Ethernet Connection Network 
Driver - version 2.4.10
[    1.232275] i40e: Copyright(c) 2013 - 2018 Intel Corporation.
[    1.232325] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver 
bnx2x 1.712.30-0 (2014/02/10)
[    1.232482] sk98lin: Network Device Driver v10.93.3.3 (C)Copyright 
1999-2012 Marvell(R).
[    1.287425] eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
[    1.342343] eth1: Marvell Yukon 88E8053 Gigabit Ethernet Controller
[    1.342378] Fusion MPT base driver 3.04.20
[    1.342380] Copyright (c) 1999-2008 LSI Corporation
[    1.342392] Fusion MPT SAS Host driver 3.04.20
[    1.342431] Fusion MPT misc device (ioctl) driver 3.04.20
[    1.343261] mptctl: Registered with Fusion MPT base driver
[    1.343263] mptctl: /dev/mptctl @ (major,minor=10,220)
[    1.343271] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.343280] ehci-pci: EHCI PCI platform driver
[    1.343431] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.343441] ehci-pci 0000:00:1a.7: new USB bus registered, assigned 
bus number 1
[    1.343454] ehci-pci 0000:00:1a.7: debug port 1
[    1.347357] ehci-pci 0000:00:1a.7: cache line size of 32 is not 
supported
[    1.347374] ehci-pci 0000:00:1a.7: irq 18, io mem 0xff9fb400
[    1.353026] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.353388] hub 1-0:1.0: USB hub found
[    1.353398] hub 1-0:1.0: 4 ports detected
[    1.353710] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.353719] ehci-pci 0000:00:1d.7: new USB bus registered, assigned 
bus number 2
[    1.353731] ehci-pci 0000:00:1d.7: debug port 1
[    1.357640] ehci-pci 0000:00:1d.7: cache line size of 32 is not 
supported
[    1.357658] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff9fb000
[    1.363035] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.363333] hub 2-0:1.0: USB hub found
[    1.363342] hub 2-0:1.0: 6 ports detected
[    1.363523] uhci_hcd: USB Universal Host Controller Interface driver
[    1.363625] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.363632] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned 
bus number 3
[    1.363639] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.363667] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e000
[    1.363830] hub 3-0:1.0: USB hub found
[    1.363839] hub 3-0:1.0: 2 ports detected
[    1.363995] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.364016] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned 
bus number 4
[    1.364022] uhci_hcd 0000:00:1a.1: detected 2 ports
[    1.364046] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000dc00
[    1.364213] hub 4-0:1.0: USB hub found
[    1.364220] hub 4-0:1.0: 2 ports detected
[    1.364376] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.364383] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned 
bus number 5
[    1.364389] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.364407] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d880
[    1.364565] hub 5-0:1.0: USB hub found
[    1.364573] hub 5-0:1.0: 2 ports detected
[    1.364720] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.364727] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned 
bus number 6
[    1.364733] uhci_hcd 0000:00:1d.1: detected 2 ports
[    1.364757] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800
[    1.364913] hub 6-0:1.0: USB hub found
[    1.364920] hub 6-0:1.0: 2 ports detected
[    1.365101] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.365108] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned 
bus number 7
[    1.365114] uhci_hcd 0000:00:1d.2: detected 2 ports
[    1.365133] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d480
[    1.365297] hub 7-0:1.0: USB hub found
[    1.365305] hub 7-0:1.0: 2 ports detected
[    1.365519] usbcore: registered new interface driver cdc_acm
[    1.365521] cdc_acm: USB Abstract Control Model driver for USB modems 
and ISDN adapters
[    1.365543] usbcore: registered new interface driver usblp
[    1.365588] usbcore: registered new interface driver usb-storage
[    1.365653] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 
irq 1
[    1.365654] i8042: PNP: PS/2 appears to have AUX port disabled, if 
this is incorrect please boot with i8042.nopnp
[    1.366400] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.367365] rtc_cmos 00:01: RTC can wake from S4
[    1.367539] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.367565] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    1.367585] i2c /dev entries driver
[    1.370198] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.375742] w83627ehf: Found W83627DHG chip at 0xa10
[    1.376155] md: raid0 personality registered for level 0
[    1.376159] md: raid1 personality registered for level 1
[    1.376163] md: raid10 personality registered for level 10
[    1.382101] md: raid6 personality registered for level 6
[    1.382105] md: raid5 personality registered for level 5
[    1.382107] md: raid4 personality registered for level 4
[    1.382232] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) 
initialised: dm-devel@redhat.com
[    1.385778] usbcore: registered new interface driver btusb
[    1.385843] usbcore: registered new interface driver usbhid
[    1.385844] usbhid: USB HID core driver
[    1.386138] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.386383] NET: Registered protocol family 10
[    1.391228] NET: Registered protocol family 17
[    1.391261] 8021q: 802.1Q VLAN Support v1.8
[    1.391279] Key type dns_resolver registered
[    1.391489] readynas_io_init: initializing ReadyNAS I/O.
[    1.391491] procfs_init: initializing ReadyNAS procfs.
[    1.391500] ReadyNAS model: To Be Filled By O.E.M.
[    1.391531] pwr_button_state_init: initializing ReadyNAS PWR button 
state handler .
[    1.391539] button_init: initializing ReadyNAS button set.
[    1.391542] __button_init: button 'backup' gpio_ich:15 (POLL)
[    1.391554] __button_init: button 'reset' gpio_ich:8 (POLL)
[    1.392127] input: rn_button as /devices/virtual/input/input3
[    1.392181] readynas_io_init: initialization successfully completed.
[    1.392273] readynas_lcd_init: installing ReadyNAS LCD driver.
[    1.392354] readynas_led_init: installing ReadyNAS LED driver.
[    1.393238] snd_hda_intel 0000:00:1b.0: no codecs found!
[    1.398073] register_led: registering LED "readynas:green:backup"
[    1.398365] microcode: CPU0 sig=0x1067a, pf=0x1, revision=0xa07
[    1.398067] microcode: CPU1 sig=0x1067a, pf=0x1, revision=0xa07
[    1.398676] microcode: Microcode Update Driver: v2.01 
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.398955] registered taskstats version 1
[    1.400188] Btrfs loaded, crc32c=crc32c-generic
[    1.405986] rtc_cmos 00:01: setting system clock to 2021-07-27 
16:53:07 UTC (1627404787)
[    1.406129] ALSA device list:
[    1.406131]   No soundcards found.
[    1.536023] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.536036] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.536659] ata1.00: ATA-9: WDC WD60EFRX-68L0BN1, 82.00A82, max UDMA/133
[    1.536664] ata1.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    1.537319] ata1.00: configured for UDMA/133
[    1.537526] scsi 0:0:0:0: Direct-Access     ATA      WDC WD60EFRX-68L 
0A82 PQ: 0 ANSI: 5
[    1.537947] sd 0:0:0:0: [sda] 11721045168 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[    1.537951] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.538016] sd 0:0:0:0: [sda] Write Protect is off
[    1.538019] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.538043] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.538337] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.574048]  sda: sda1 sda2 sda3 sda4
[    1.574629] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.665027] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.781239] usb-storage 2-1:1.0: USB Mass Storage device detected
[    1.781979] usb-storage 2-1:1.0: Quirks match for vid 090c pid 1000: 400
[    1.782026] scsi host6: usb-storage 2-1:1.0
[    1.843027] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    1.843040] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.847974] ata2.00: ATA-9: WDC WD120EFAX-68UNTN0, 81.00A81, max 
UDMA/133
[    1.847980] ata2.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    1.856069] ata2.00: configured for UDMA/133
[    1.856318] scsi 1:0:0:0: Direct-Access     ATA      WDC WD120EFAX-68 
0A81 PQ: 0 ANSI: 5
[    1.856725] sd 1:0:0:0: [sdb] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    1.856728] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    1.856781] sd 1:0:0:0: [sdb] Write Protect is off
[    1.856784] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.856808] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    1.857108] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.884030] usb 2-2: new high-speed USB device number 3 using ehci-pci
[    1.907344]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5
[    1.907978] sd 1:0:0:0: [sdb] Attached SCSI disk
[    1.998858] hub 2-2:1.0: USB hub found
[    1.998948] hub 2-2:1.0: 4 ports detected
[    2.083027] tsc: Refined TSC clocksource calibration: 2593.499 MHz
[    2.083033] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 
0x25623ef959c, max_idle_ns: 440795271101 ns
[    2.162026] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    2.162038] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.166495] ata3.00: ATA-9: WDC WD120EFBX-68B0EN0, 85.00A85, max 
UDMA/133
[    2.166500] ata3.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    2.181695] ata3.00: configured for UDMA/133
[    2.181956] scsi 2:0:0:0: Direct-Access     ATA      WDC WD120EFBX-68 
0A85 PQ: 0 ANSI: 5
[    2.182280] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.182307] sd 2:0:0:0: [sdc] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    2.182310] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    2.182365] sd 2:0:0:0: [sdc] Write Protect is off
[    2.182368] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.182404] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.239271]  sdc: sdc1 sdc2 sdc3 sdc4 sdc5
[    2.239888] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.261029] usb 2-2.3: new high-speed USB device number 4 using ehci-pci
[    2.336370] usb-storage 2-2.3:1.0: USB Mass Storage device detected
[    2.337066] scsi host7: usb-storage 2-2.3:1.0
[    2.399024] usb 2-2.4: new high-speed USB device number 5 using ehci-pci
[    2.482470] usb-storage 2-2.4:1.0: USB Mass Storage device detected
[    2.482922] scsi host8: usb-storage 2-2.4:1.0
[    2.487024] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    2.487037] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.487658] ata4.00: ATA-9: WDC WD60EFRX-68L0BN1, 82.00A82, max UDMA/133
[    2.487663] ata4.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    2.488313] ata4.00: configured for UDMA/133
[    2.488590] scsi 3:0:0:0: Direct-Access     ATA      WDC WD60EFRX-68L 
0A82 PQ: 0 ANSI: 5
[    2.488858] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.488904] sd 3:0:0:0: [sdd] 11721045168 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[    2.488907] sd 3:0:0:0: [sdd] 4096-byte physical blocks
[    2.488974] sd 3:0:0:0: [sdd] Write Protect is off
[    2.488977] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.489012] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.536774]  sdd: sdd1 sdd2 sdd3 sdd4
[    2.537371] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.793028] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    2.793044] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.797530] ata5.00: ATA-9: WDC WD120EFBX-68B0EN0, 85.00A85, max 
UDMA/133
[    2.797535] ata5.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    2.805019] ata5.00: configured for UDMA/133
[    2.805284] scsi 4:0:0:0: Direct-Access     ATA      WDC WD120EFBX-68 
0A85 PQ: 0 ANSI: 5
[    2.805622] sd 4:0:0:0: [sde] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    2.805625] sd 4:0:0:0: [sde] 4096-byte physical blocks
[    2.805677] sd 4:0:0:0: [sde] Write Protect is off
[    2.805681] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.805704] sd 4:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.805954] sd 4:0:0:0: Attached scsi generic sg4 type 0
[    2.854221]  sde: sde1 sde2 sde3 sde4 sde5
[    2.854747] sd 4:0:0:0: [sde] Attached SCSI disk
[    3.083106] clocksource: Switched to clocksource tsc
[    3.111019] do_marvell_9170_recover: ignoring PCI device (8086:2821) 
at PCI#0
[    3.111032] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.121359] ata6.00: ATA-9: WDC WD120EFBX-68B0EN0, 85.00A85, max 
UDMA/133
[    3.121364] ata6.00: 23437770752 sectors, multi 0: LBA48 NCQ (depth 
31/32), AA
[    3.130914] ata6.00: configured for UDMA/133
[    3.131159] scsi 5:0:0:0: Direct-Access     ATA      WDC WD120EFBX-68 
0A85 PQ: 0 ANSI: 5
[    3.131406] sd 5:0:0:0: Attached scsi generic sg5 type 0
[    3.131449] sd 5:0:0:0: [sdf] 23437770752 512-byte logical blocks: 
(12.0 TB/10.9 TiB)
[    3.131453] sd 5:0:0:0: [sdf] 4096-byte physical blocks
[    3.131500] sd 5:0:0:0: [sdf] Write Protect is off
[    3.131503] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    3.131524] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    3.187845]  sdf: sdf1 sdf2 sdf3 sdf4 sdf5
[    3.188404] sd 5:0:0:0: [sdf] Attached SCSI disk
[    3.189287] Freeing unused kernel memory: 872K
[    3.192932] vpd: loading out-of-tree module taints kernel.
[    3.192939] vpd: module license 'Proprietary' taints kernel.
[    3.192940] Disabling lock debugging due to kernel taint
[    3.193137] ReadyNAS VPD init
[    6.761021] nv6lcd v3.1 loaded.
[    6.783987] scsi 6:0:0:0: Direct-Access     SMI      USB DISK         
1100 PQ: 0 ANSI: 0 CCS
[    6.784378] sd 6:0:0:0: Attached scsi generic sg6 type 0
[    6.784381] sd 6:0:0:0: Embedded Enclosure Device
[    6.785469] sd 6:0:0:0: Wrong diagnostic page; asked for 1 got 0
[    6.785833] sd 6:0:0:0: [sdg] 250880 512-byte logical blocks: (128 
MB/123 MiB)
[    6.786704] sd 6:0:0:0: [sdg] Write Protect is off
[    6.786706] sd 6:0:0:0: [sdg] Mode Sense: 43 00 00 00
[    6.787576] sd 6:0:0:0: [sdg] No Caching mode page found
[    6.787578] sd 6:0:0:0: [sdg] Assuming drive cache: write through
[    6.794736]  sdg: sdg1
[    6.797083] sd 6:0:0:0: [sdg] Attached SCSI removable disk
[    6.802912] sd 6:0:0:0: Failed to get diagnostic page 0xffffffea
[    6.808922] sd 6:0:0:0: Failed to bind enclosure -19
[    7.343612] scsi 7:0:0:0: Direct-Access     USB2.0   CardReader CF    
0100 PQ: 0 ANSI: 0
[    7.344098] scsi 7:0:0:1: Direct-Access     USB2.0   CardReader SM XD 
0100 PQ: 0 ANSI: 0
[    7.344595] scsi 7:0:0:2: Direct-Access     USB2.0   CardReader MS    
0100 PQ: 0 ANSI: 0
[    7.345097] scsi 7:0:0:3: Direct-Access     USB2.0   CardReader SD    
0100 PQ: 0 ANSI: 0
[    7.345493] sd 7:0:0:0: Attached scsi generic sg7 type 0
[    7.345749] sd 7:0:0:1: Attached scsi generic sg8 type 0
[    7.345954] sd 7:0:0:2: Attached scsi generic sg9 type 0
[    7.346256] sd 7:0:0:3: Attached scsi generic sg10 type 0
[    7.350843] sd 7:0:0:1: [sdi] Attached SCSI removable disk
[    7.351713] sd 7:0:0:2: [sdj] Attached SCSI removable disk
[    7.353489] sd 7:0:0:0: [sdh] Attached SCSI removable disk
[    7.355217] sd 7:0:0:3: [sdk] Attached SCSI removable disk
[    7.487736] scsi 8:0:0:0: Direct-Access     WDC WD60 
EFRX-68L0BN1          PQ: 0 ANSI: 5
[    7.488137] sd 8:0:0:0: Attached scsi generic sg11 type 0
[    7.488706] sd 8:0:0:0: [sdl] Very big device. Trying to use READ 
CAPACITY(16).
[    7.489088] sd 8:0:0:0: [sdl] 11721044995 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[    7.490084] sd 8:0:0:0: [sdl] Write Protect is off
[    7.490088] sd 8:0:0:0: [sdl] Mode Sense: 28 00 00 00
[    7.491096] sd 8:0:0:0: [sdl] No Caching mode page found
[    7.496439] sd 8:0:0:0: [sdl] Assuming drive cache: write through
[    7.503203] sd 8:0:0:0: [sdl] Very big device. Trying to use READ 
CAPACITY(16).
[    7.505973] random: nonblocking pool is initialized
[    7.509581] sd 8:0:0:0: [sdl] Very big device. Trying to use READ 
CAPACITY(16).
[    7.511964] sd 8:0:0:0: [sdl] Attached SCSI disk
[   19.506139] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   19.509021] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   21.963475] eth0: network connection up using port A
[   21.963475]     interrupt src:   MSI
[   21.963475]     speed:           1000
[   21.963475]     autonegotiation: yes
[   21.963475]     duplex mode:     full
[   21.963475]     flowctrl:        symmetric
[   21.963475]     role:            slave
[   21.963475]     tcp offload:     enabled
[   21.963475]     scatter-gather:  enabled
[   21.963475]     tx-checksum:     enabled
[   21.963475]     rx-checksum:     enabled
[   21.963475]     rx-polling:      enabled
[   21.963475] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   22.127923] eth1: network connection up using port A
[   22.127923]     interrupt src:   MSI
[   22.127923]     speed:           1000
[   22.127923]     autonegotiation: yes
[   22.127923]     duplex mode:     full
[   22.127923]     flowctrl:        symmetric
[   22.127923]     role:            master
[   22.127923]     tcp offload:     enabled
[   22.127923]     scatter-gather:  enabled
[   22.127923]     tx-checksum:     enabled
[   22.127923]     rx-checksum:     enabled
[   22.127923]     rx-polling:      enabled
[   22.127923] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   24.321480] md: md0 stopped.
[   24.322474] md: bind<sdb1>
[   24.322604] md: bind<sdc1>
[   24.322733] md: bind<sdd1>
[   24.322920] md: bind<sde1>
[   24.323119] md: bind<sdf1>
[   24.323247] md: bind<sda1>
[   24.326118] md/raid1:md0: active with 6 out of 6 mirrors
[   24.326194] md0: detected capacity change from 0 to 4290772992
[   24.360181] md: md1 stopped.
[   24.361781] md: bind<sdb2>
[   24.361986] md: bind<sdc2>
[   24.362169] md: bind<sdd2>
[   24.362369] md: bind<sde2>
[   24.362567] md: bind<sdf2>
[   24.362690] md: bind<sda2>
[   24.363488] md/raid10:md1: active with 6 out of 6 devices
[   24.363557] md1: detected capacity change from 0 to 1604321280
[   24.766427] BTRFS: device label 33eb0773:root devid 1 transid 2761035 
/dev/md0
[   24.766956] BTRFS info (device md0): has skinny extents
[   25.682428] systemd[1]: Failed to insert module 'kdbus': Function not 
implemented
[   25.702319] systemd[1]: systemd 230 running in system mode. (+PAM 
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP 
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   25.702495] systemd[1]: Detected architecture x86-64.
[   25.707102] systemd[1]: Set hostname to <Pro>.
[   25.816717] systemd[1]: systemd-journald-audit.socket: Cannot add 
dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
[   25.816780] systemd[1]: systemd-journald-audit.socket: Cannot add 
dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
[   25.817690] systemd[1]: Set up automount Arbitrary Executable File 
Formats File System Automount Point.
[   25.826170] systemd[1]: Listening on udev Control Socket.
[   25.832177] systemd[1]: Created slice System Slice.
[   25.838181] systemd[1]: Listening on Journal Socket.
[   25.848237] systemd[1]: Starting Load Kernel Modules...
[   25.853872] systemd[1]: Mounting RPC Pipe File System...
[   25.858940] systemd[1]: Mounting POSIX Message Queue File System...
[   25.865293] systemd[1]: Created slice system-getty.slice.
[   25.876248] systemd[1]: Starting Remount Root and Kernel File Systems...
[   25.883169] systemd[1]: Mounting RPC Pipe File System...
[   25.888869] systemd[1]: Mounting Debug File System...
[   25.893269] systemd[1]: Listening on Journal Socket (/dev/log).
[   25.903322] systemd[1]: Starting Journal Service...
[   25.908314] systemd[1]: Started Forward Password Requests to Wall 
Directory Watch.
[   25.917174] systemd[1]: Reached target Encrypted Volumes.
[   25.923268] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   25.930217] systemd[1]: Listening on udev Kernel Socket.
[   25.936228] systemd[1]: Started Dispatch Password Requests to Console 
Directory Watch.
[   25.945069] systemd[1]: Reached target Paths.
[   25.954243] systemd[1]: Starting Create Static Device Nodes in /dev...
[   25.960212] systemd[1]: Created slice User and Session Slice.
[   25.966234] systemd[1]: Listening on /dev/initctl Compatibility Named 
Pipe.
[   25.973098] systemd[1]: Reached target Slices.
[   25.983250] systemd[1]: Started ReadyNAS LCD splasher.
[   25.990093] systemd[1]: Starting ReadyNASOS system prep...
[   25.997886] systemd[1]: Mounted RPC Pipe File System.
[   26.004127] systemd[1]: Mounted RPC Pipe File System.
[   26.010121] systemd[1]: Mounted POSIX Message Queue File System.
[   26.016104] systemd[1]: Mounted Debug File System.
[   26.022377] systemd[1]: Started Load Kernel Modules.
[   26.028582] systemd[1]: Started Remount Root and Kernel File Systems.
[   26.036522] systemd[1]: Started Create Static Device Nodes in /dev.
[   26.050357] systemd[1]: Starting udev Kernel Device Manager...
[   26.078274] systemd[1]: Starting Rebuild Hardware Database...
[   26.083859] systemd[1]: Starting Load/Save Random Seed...
[   26.088936] systemd[1]: Mounting FUSE Control File System...
[   26.100133] systemd[1]: Mounting Configuration File System...
[   26.105831] systemd[1]: Starting Apply Kernel Variables...
[   26.111406] systemd[1]: Mounted Configuration File System.
[   26.118296] systemd[1]: Mounted FUSE Control File System.
[   26.129366] systemd[1]: Started ReadyNASOS system prep.
[   26.135489] systemd[1]: Started Load/Save Random Seed.
[   26.141666] systemd[1]: Started Apply Kernel Variables.
[   26.190889] systemd[1]: Started Journal Service.
[   26.227507] systemd-journald[1581]: Received request to flush runtime 
journal from PID 1
[   26.887240] md: md127 stopped.
[   26.888727] md: bind<sdb3>
[   26.888889] md: bind<sdc3>
[   26.889171] md: bind<sdd3>
[   26.889319] md: bind<sde3>
[   26.892036] md: bind<sdf3>
[   26.894285] md: bind<sda3>
[   26.912499] md/raid:md127: device sda3 operational as raid disk 0
[   26.912503] md/raid:md127: device sdf3 operational as raid disk 5
[   26.912505] md/raid:md127: device sde3 operational as raid disk 4
[   26.912507] md/raid:md127: device sdd3 operational as raid disk 3
[   26.912509] md/raid:md127: device sdc3 operational as raid disk 2
[   26.912511] md/raid:md127: device sdb3 operational as raid disk 1
[   26.913141] md/raid:md127: allocated 6474kB
[   26.913517] md/raid:md127: raid level 6 active with 6 out of 6 
devices, algorithm 2
[   26.913520] RAID conf printout:
[   26.913521]  --- level:6 rd:6 wd:6
[   26.913523]  disk 0, o:1, dev:sda3
[   26.913525]  disk 1, o:1, dev:sdb3
[   26.913527]  disk 2, o:1, dev:sdc3
[   26.913529]  disk 3, o:1, dev:sdd3
[   26.913531]  disk 4, o:1, dev:sde3
[   26.913533]  disk 5, o:1, dev:sdf3
[   26.913666] md127: detected capacity change from 0 to 7981731151872
[   27.090783] Adding 1566716k swap on /dev/md1.  Priority:-1 extents:1 
across:1566716k
[   27.128189] BTRFS: device label 33eb0773:Dual devid 1 transid 8127491 
/dev/md127
[   27.203747] md: md126 stopped.
[   27.205244] md: bind<sdd4>
[   27.205399] md: bind<sde4>
[   27.205540] md: bind<sdf4>
[   27.205671] md: bind<sda4>
[   27.205937] md: bind<sdb4>
[   27.206269] md: bind<sdc4>
[   27.207217] md/raid:md126: device sdc4 operational as raid disk 0
[   27.207221] md/raid:md126: device sdb4 operational as raid disk 5
[   27.207222] md/raid:md126: device sda4 operational as raid disk 4
[   27.207224] md/raid:md126: device sdf4 operational as raid disk 3
[   27.207226] md/raid:md126: device sde4 operational as raid disk 2
[   27.207228] md/raid:md126: device sdd4 operational as raid disk 1
[   27.207692] md/raid:md126: allocated 6474kB
[   27.207720] md/raid:md126: raid level 6 active with 6 out of 6 
devices, algorithm 2
[   27.207722] RAID conf printout:
[   27.207723]  --- level:6 rd:6 wd:6
[   27.207725]  disk 0, o:1, dev:sdc4
[   27.207727]  disk 1, o:1, dev:sdd4
[   27.207728]  disk 2, o:1, dev:sde4
[   27.207730]  disk 3, o:1, dev:sdf4
[   27.207731]  disk 4, o:1, dev:sda4
[   27.207733]  disk 5, o:1, dev:sdb4
[   27.207828] md126: detected capacity change from 0 to 16002567897088
[   27.430836] BTRFS: device label 33eb0773:Dual devid 2 transid 8127491 
/dev/md126
[   27.515994] md: md125 stopped.
[   27.517084] md: bind<sdc5>
[   27.517246] md: bind<sde5>
[   27.517391] md: bind<sdf5>
[   27.517543] md: bind<sdb5>
[   27.519248] md/raid:md125: device sdb5 operational as raid disk 0
[   27.519252] md/raid:md125: device sdf5 operational as raid disk 3
[   27.519254] md/raid:md125: device sde5 operational as raid disk 2
[   27.519256] md/raid:md125: device sdc5 operational as raid disk 1
[   27.519835] md/raid:md125: allocated 4362kB
[   27.519891] md/raid:md125: raid level 6 active with 4 out of 4 
devices, algorithm 2
[   27.519893] RAID conf printout:
[   27.519895]  --- level:6 rd:4 wd:4
[   27.519897]  disk 0, o:1, dev:sdb5
[   27.519899]  disk 1, o:1, dev:sdc5
[   27.519900]  disk 2, o:1, dev:sde5
[   27.519902]  disk 3, o:1, dev:sdf5
[   27.520463] md125: detected capacity change from 0 to 11997656383488
[   27.778816] BTRFS: device label 33eb0773:Dual devid 3 transid 8127491 
/dev/md125
[   27.993787] BTRFS info (device md125): has skinny extents
[   87.445169] BTRFS info (device md125): start tree-log replay
[   87.454146] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[   87.471037] BTRFS error (device md125): parent transid verify failed 
on 25029252612096 wanted 8127492 found 8126807
[   87.471041] BTRFS warning (device md125): failed to read log tree
[   87.544061] BTRFS error (device md125): open_ctree failed
[   88.012782] eth0: network connection down
[   88.018130] eth1: network connection down
[   88.189553] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state 
recovery directory
[   88.189566] NFSD: starting 90-second grace period (net ffffffff88d782c0)
[   88.218288] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   88.221860] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   91.513025] eth0: network connection up using port A
[   91.513025]     interrupt src:   MSI
[   91.513025]     speed:           1000
[   91.513025]     autonegotiation: yes
[   91.513025]     duplex mode:     full
[   91.513025]     flowctrl:        symmetric
[   91.513025]     role:            master
[   91.513025]     tcp offload:     enabled
[   91.513025]     scatter-gather:  enabled
[   91.513025]     tx-checksum:     enabled
[   91.513025]     rx-checksum:     enabled
[   91.513025]     rx-polling:      enabled
[   91.513025] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   91.907007] Adjusting tsc more than 11% (7517526 vs 7180534)
[   92.864129] eth1: network connection up using port A
[   92.864129]     interrupt src:   MSI
[   92.864129]     speed:           1000
[   92.864129]     autonegotiation: yes
[   92.864129]     duplex mode:     full
[   92.864129]     flowctrl:        symmetric
[   92.864129]     role:            master
[   92.864129]     tcp offload:     enabled
[   92.864129]     scatter-gather:  enabled
[   92.864129]     tx-checksum:     enabled
[   92.864129]     rx-checksum:     enabled
[   92.864129]     rx-polling:      enabled
[   92.864129] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[  110.353335] nfsd: last server has exited, flushing export cache
[  110.430969] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state 
recovery directory
[  110.430996] NFSD: starting 90-second grace period (net ffffffff88d782c0)


-- 
This email has been checked for viruses by AVG.
https://www.avg.com

