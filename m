Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B5B18E4FD
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Mar 2020 23:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgCUWGa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Mar 2020 18:06:30 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21193 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUWGa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Mar 2020 18:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584828385; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NPoTYqgKPTrWksYr/tTm6N7KoZW4W/2W65qKZAWvA+4BOvFOvY8OZ7Qg+pQK4MctQCVPBgo9fSMnDJeyaUqCHQ/y/bfWahjOGAZcxdLUlUeRDE0/lNjb7akKuC3Y67+jrJwH2POdhjgED4quCHfClHBWTZznrX9foKYLJImMo8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1584828385; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=IDH2YvjS7QyGWCMAuYsHWfknTnw2G/1MMNyalIULfcg=; 
        b=nW6Dg8pfCBiJThxIDLgptai1hbIqrAGLCostd1R+PG19VrOJPoNOgcLxVRi+bijb5ldoIzdUn5N+3FvzUstmuuQLFO4pRIZLUEQB6uEYn+dHm6ILlxl/m4DDiOSKvX1fSAB0YIc+gBMoyawswhcf6BAjzsjWfkn6mxRDGsM97Uk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=wcat.com;
        spf=pass  smtp.mailfrom=mkurth@wcat.com;
        dmarc=pass header.from=<mkurth@wcat.com> header.from=<mkurth@wcat.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1584828385;
        s=zoho; d=wcat.com; i=mkurth@wcat.com;
        h=Date:From:To:Message-Id:Subject:MIME-Version:Content-Type;
        bh=IDH2YvjS7QyGWCMAuYsHWfknTnw2G/1MMNyalIULfcg=;
        b=GXtu+sn3LEp8G9Wjth4aYCrtw6CIwA9eyX07kZZ1UC5jxlscBpTwQSQS0irhopkB
        Ol2tAmWpNaA0rC5TKwnVrXWE//fxMyYPhMc0nTzVg7dqDRW3pClegxGfScXN6N5tmTu
        fB1LjHruAe49rUEq/Bfd45Ua5ljLF2G3LAG4bz6s=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1584828383380418.83717544128785; Sat, 21 Mar 2020 15:06:23 -0700 (PDT)
Date:   Sat, 21 Mar 2020 18:06:23 -0400
From:   mkurth <mkurth@wcat.com>
To:     "linux-btrfs" <linux-btrfs@vger.kernel.org>
Message-Id: <170ff22007d.12a2b00971104001.6362376377372310236@wcat.com>
Subject: Unmountable partition
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_3630389_446126246.1584828383357"
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Zoho-Virus-Status: 1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_3630389_446126246.1584828383357
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello btrfs folks,

I have a partition I am attempting to recover.  This was previously the root partition of a Linux system which was originally OpenSuse Leap 42.1 upgraded to Leap 15.0 about a month ago.  About a week ago I woke up and the system had crashed and put itself into emergency mode upon reboot.

I've since built a Leap 15.3 system on a new SSD and am hoping to get what I can from the old partition.

Mounting -o usebackuproot puts this in /var/log/messages:

2020-03-21T17:05:10.662250-04:00 localhost kernel: [75806.017018] BTRFS info (device sdb1): trying to use backup root at mount time
2020-03-21T17:05:10.662271-04:00 localhost kernel: [75806.017022] BTRFS info (device sdb1): disk space caching is enabled
2020-03-21T17:05:10.662273-04:00 localhost kernel: [75806.017023] BTRFS info (device sdb1): has skinny extents
2020-03-21T17:05:10.665893-04:00 localhost kernel: [75806.020781] BTRFS critical (device sdb1): corrupt leaf: root=1 block=2642034688 slot=29, unexpected item end, have 1866556696 expect 12824
2020-03-21T17:05:10.665905-04:00 localhost kernel: [75806.021272] BTRFS critical (device sdb1): corrupt leaf: root=1 block=2642034688 slot=29, unexpected item end, have 1866556696 expect 12824
2020-03-21T17:05:10.669816-04:00 localhost kernel: [75806.022346] BTRFS critical (device sdb1): corrupt leaf: root=1 block=2637185024 slot=29, unexpected item end, have 1866556696 expect 12824
2020-03-21T17:05:10.669826-04:00 localhost kernel: [75806.022987] BTRFS error (device sdb1): parent transid verify failed on 2643361792 wanted 24068411 found 24068413
2020-03-21T17:05:10.669828-04:00 localhost kernel: [75806.022990] BTRFS warning (device sdb1): failed to read tree root
2020-03-21T17:05:10.669829-04:00 localhost kernel: [75806.023498] BTRFS error (device sdb1): parent transid verify failed on 2638479360 wanted 24068410 found 24068412
2020-03-21T17:05:10.669830-04:00 localhost kernel: [75806.023500] BTRFS warning (device sdb1): failed to read tree root
2020-03-21T17:05:10.714520-04:00 localhost kernel: [75806.070005] BTRFS error (device sdb1): open_ctree failed

Here's output from btrfs restore:

lisa:/ # btrfs restore /dev/sdb1 /mnt
incorrect offsets 12824 1866556696
Couldn't setup extent tree
incorrect offsets 12824 1866556696
Couldn't setup device tree
Could not open root, trying backup super
incorrect offsets 12824 1866556696
Couldn't setup extent tree
incorrect offsets 12824 1866556696
Couldn't setup device tree
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 42951770112
Could not open root, trying backup super

My system does not appear to have brtfs-find-root.

uname -a:
Linux lisa 4.12.14-lp151.28.40-default #1 SMP Fri Mar 6 13:48:15 UTC 2020 (f0f1262) x86_64 x86_64 x86_64 GNU/Linux

btrfs --version
btrfs-progs v4.19.1

btrfs fi show
Label: none  uuid: 11e7b516-5486-4637-bf67-7bd72abc314e 
        Total devices 1 FS bytes used 30.29GiB
        devid    1 size 40.00GiB used 40.00GiB path /dev/sdb1

btrfs fi df /home # Replace /home with the mount point of your btrfs-filesystem
Not available as drive is not mountable

dmesg > dmesg.log
attached

What should I try next?

Thanks,
Matthew




------=_Part_3630389_446126246.1584828383357
Content-Type: application/octet-stream; name=dmesg.log
Content-Transfer-Encoding: 7bit
X-ZM_AttachId: 138041195376160100
Content-Disposition: attachment; filename=dmesg.log

[    0.000000] Linux version 4.12.14-lp151.28.40-default (geeko@buildhost) (gcc version 7.5.0 (SUSE Linux) ) #1 SMP Fri Mar 6 13:48:15 UTC 2020 (f0f1262)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-lp151.28.40-default root=UUID=a74b593c-dea8-4d7b-949d-c4cd209f4dbe splash=silent resume=/dev/disk/by-uuid/a81d7f4e-b53d-47c5-bb75-2cd7c5f5b286 mitigations=auto quiet
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e6000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cffaffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cffb0000-0x00000000cffbdfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cffbe000-0x00000000cffdffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cffe0000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff700000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./A7DA-S/A7DA, BIOS 080015  08/04/2009
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn = 0x220000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000230000000 aka 8960M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcffb0 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped at [ffffffffff200780]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000099000] 99000 size 24576
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x0308e000, 0x0308efff] PGTABLE
[    0.000000] BRK [0x0308f000, 0x0308ffff] PGTABLE
[    0.000000] BRK [0x03090000, 0x03090fff] PGTABLE
[    0.000000] BRK [0x03091000, 0x03091fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3445b000-0x36224fff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FA1F0 000014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 0x00000000CFFB0000 00003C (v01 080409 RSDT0751 20090804 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000CFFB0200 000084 (v01 080409 FACP0751 20090804 MSFT 00000097)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field Pm2ControlBlock has valid Length but zero Address: 0x0000000000000000/0x1 (20170303/tbfadt-624)
[    0.000000] ACPI: DSDT 0x00000000CFFB0450 009420 (v01 81BF1  81BF1P09 00000000 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000CFFBE000 000040
[    0.000000] ACPI: APIC 0x00000000CFFB0390 00007C (v01 080409 APIC0751 20090804 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000CFFB0410 00003C (v01 080409 OEMMCFG  20090804 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000CFFBE040 000072 (v01 080409 OEMB0751 20090804 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CFFB9870 000038 (v01 080409 OEMHPET  20090804 MSFT 00000097)
[    0.000000] ACPI: SSDT 0x00000000CFFB98B0 00088C (v01 A M I  POWERNOW 00000001 AMD  00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Scanning NUMA topology in Northbridge 24
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000021fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x21ffe8000-0x21fffdfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000021fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000cffaffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000021fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000021fffffff]
[    0.000000] On node 0 totalpages: 2031438
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3998 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 13247 pages used for memmap
[    0.000000]   DMA32 zone: 847792 pages, LIFO batch:63
[    0.000000]   Normal zone: 18432 pages used for memmap
[    0.000000]   Normal zone: 1179648 pages, LIFO batch:63
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8300 base: 0xfed00000
[    0.000000] smpboot: Allowing 6 CPUs, 2 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e5fff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e6000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcffb0000-0xcffbdfff]
[    0.000000] PM: Registered nosave memory: [mem 0xcffbe000-0xcffdffff]
[    0.000000] PM: Registered nosave memory: [mem 0xcffe0000-0xcfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd0000000-0xff6fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff700000-0xffffffff]
[    0.000000] e820: [mem 0xd0000000-0xff6fffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:6 nr_node_ids:1
[    0.000000] percpu: Embedded 48 pages/cpu @ffff88021fc00000 s159744 r8192 d28672 u262144
[    0.000000] pcpu-alloc: s159744 r8192 d28672 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 4 5 - - 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1999674
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-lp151.28.40-default root=UUID=a74b593c-dea8-4d7b-949d-c4cd209f4dbe splash=silent resume=/dev/disk/by-uuid/a81d7f4e-b53d-47c5-bb75-2cd7c5f5b286 mitigations=auto quiet
[    0.000000] log_buf_len individual max cpu contribution: 32768 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 163840 bytes
[    0.000000] log_buf_len min size: 262144 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 254076(96%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] AGP: Node 0: aperture [bus addr 0xc4000000-0xc5ffffff] (32MB)
[    0.000000] Aperture pointing to e820 RAM. Ignoring.
[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
[    0.000000] AGP: This costs you 64MB of RAM
[    0.000000] AGP: Mapping aperture over RAM [mem 0xc4000000-0xc7ffffff] (65536KB)
[    0.000000] PM: Registered nosave memory: [mem 0xc4000000-0xc7ffffff]
[    0.000000] Memory: 5440332K/8125752K available (10256K kernel code, 1479K rwdata, 3356K rodata, 2104K init, 9888K bss, 324240K reserved, 0K cma-reserved)
[    0.000000] ftrace: allocating 34429 entries in 135 pages
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU event tracing is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=6.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS:33024 nr_irqs:472 16
[    0.000000] spurious 8259A interrupt: IRQ7.
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 2999.988 MHz processor
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 5999.97 BogoMIPS (lpj=11999952)
[    0.004000] pid_max: default: 32768 minimum: 301
[    0.004000] ACPI: Core revision 20170303
[    0.004000] Security Framework initialized
[    0.004000] AppArmor: AppArmor initialized
[    0.004000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.009102] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.009155] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.009196] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.009427] LVT offset 0 assigned for vector 0xf9
[    0.009430] process: using AMD E400 aware idle routine
[    0.009431] Last level iTLB entries: 4KB 512, 2MB 16, 4MB 8
[    0.009432] Last level dTLB entries: 4KB 512, 2MB 128, 4MB 64, 1GB 0
[    0.009434] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.009436] Spectre V2 : Mitigation: Full AMD retpoline
[    0.009436] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.009587] Freeing SMP alternatives memory: 32K
[    0.012006] process: System has AMD C1E enabled
[    0.012466] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.056000] process: Switch to broadcast mode on CPU0
[    0.056000] smpboot: CPU0: AMD Phenom(tm) II X4 940 Processor (family: 0x10, model: 0x4, stepping: 0x2)
[    0.056000] Performance Events: AMD PMU driver.
[    0.056000] ... version:                0
[    0.056000] ... bit width:              48
[    0.056000] ... generic registers:      4
[    0.056000] ... value mask:             0000ffffffffffff
[    0.056000] ... max period:             00007fffffffffff
[    0.056000] ... fixed-purpose events:   0
[    0.056000] ... event mask:             000000000000000f
[    0.056000] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.056000] smp: Bringing up secondary CPUs ...
[    0.056000] x86: Booting SMP configuration:
[    0.056000] .... node  #0, CPUs:      #1
[    0.004000] process: Switch to broadcast mode on CPU1
[    0.056000]  #2
[    0.004000] process: Switch to broadcast mode on CPU2
[    0.058191]  #3
[    0.004000] process: Switch to broadcast mode on CPU3
[    0.060029] smp: Brought up 1 node, 4 CPUs
[    0.060029] smpboot: Max logical packages: 2
[    0.060029] smpboot: Total of 4 processors activated (23999.90 BogoMIPS)
[    0.078180] node 0 initialised, 590295 pages in 16ms
[    0.080427] devtmpfs: initialized
[    0.080427] x86/mm: Memory block size: 128MB
[    0.086197] evm: security.selinux
[    0.086197] evm: security.ima
[    0.086198] evm: security.capability
[    0.086228] PM: Registering ACPI NVS region [mem 0xcffbe000-0xcffdffff] (139264 bytes)
[    0.086228] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.086228] futex hash table entries: 2048 (order: 5, 131072 bytes)
[    0.086228] pinctrl core: initialized pinctrl subsystem
[    0.086228] RTC time:  0:01:48, date: 03/21/20
[    0.086228] NET: Registered protocol family 16
[    0.086228] cpuidle: using governor ladder
[    0.086228] cpuidle: using governor menu
[    0.086228] node 0 link 0: io port [1000, ffffff]
[    0.086228] TOM: 00000000d0000000 aka 3328M
[    0.086228] Fam 10h mmconf [mem 0xe0000000-0xefffffff]
[    0.086228] node 0 link 0: mmio [a0000, bffff]
[    0.086228] node 0 link 0: mmio [d0000000, efffffff] ==> [d0000000, dfffffff]
[    0.086228] node 0 link 0: mmio [f0000000, fe7fffff]
[    0.086228] node 0 link 0: mmio [fe800000, fe9fffff]
[    0.086228] node 0 link 0: mmio [fea00000, ffefffff]
[    0.086228] TOM2: 0000000230000000 aka 8960M
[    0.086228] bus: [bus 00-07] on node 0 link 0
[    0.086228] bus: 00 [io  0x0000-0xffff]
[    0.086228] bus: 00 [mem 0x000a0000-0x000bffff]
[    0.086228] bus: 00 [mem 0xd0000000-0xdfffffff]
[    0.086228] bus: 00 [mem 0xf0000000-0xffffffff]
[    0.086228] bus: 00 [mem 0x230000000-0xfcffffffff]
[    0.088064] ACPI: bus type PCI registered
[    0.088066] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.088139] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.088142] PCI: not using MMCONFIG
[    0.088143] PCI: Using configuration type 1 for base access
[    0.088143] PCI: Using configuration type 1 for extended access
[    0.088360] mtrr: your CPUs had inconsistent variable MTRR settings
[    0.088360] mtrr: probably your BIOS does not setup all CPUs.
[    0.088361] mtrr: corrected configuration.
[    0.089256] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    0.089256] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.089256] ACPI: Added _OSI(Module Device)
[    0.089256] ACPI: Added _OSI(Processor Device)
[    0.089256] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.089256] ACPI: Added _OSI(Processor Aggregator Device)
[    0.092802] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.097342] ACPI: Interpreter enabled
[    0.097363] ACPI: (supports S0 S3 S4 S5)
[    0.097364] ACPI: Using IOAPIC for interrupt routing
[    0.097400] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.097400] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in ACPI motherboard resources
[    0.097400] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.097847] ACPI: Enabled 7 GPEs in block 00 to 1F
[    0.109435] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.109441] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    0.109445] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.109562] acpi PNP0A03:00: ignoring host bridge window [mem 0x000d0000-0x000dffff window] (conflicts with Adapter ROM [mem 0x000cf000-0x000d37ff])
[    0.109800] PCI host bridge to bus 0000:00
[    0.109802] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.109803] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.109804] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.109805] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xdfffffff window]
[    0.109807] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfebfffff window]
[    0.109808] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.109816] pci 0000:00:00.0: [1022:9600] type 00 class 0x060000
[    0.109932] pci 0000:00:01.0: [105b:9602] type 01 class 0x060400
[    0.110038] pci 0000:00:09.0: [1022:9608] type 01 class 0x060400
[    0.110053] pci 0000:00:09.0: enabling Extended Tags
[    0.110076] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
[    0.110176] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
[    0.110193] pci 0000:00:11.0: reg 0x10: [io  0xc000-0xc007]
[    0.110201] pci 0000:00:11.0: reg 0x14: [io  0xb000-0xb003]
[    0.110210] pci 0000:00:11.0: reg 0x18: [io  0xa000-0xa007]
[    0.110219] pci 0000:00:11.0: reg 0x1c: [io  0x9000-0x9003]
[    0.110227] pci 0000:00:11.0: reg 0x20: [io  0x8000-0x800f]
[    0.110236] pci 0000:00:11.0: reg 0x24: [mem 0xfe7ffc00-0xfe7fffff]
[    0.110257] pci 0000:00:11.0: set SATA to AHCI mode
[    0.110368] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
[    0.110380] pci 0000:00:12.0: reg 0x10: [mem 0xfe7fe000-0xfe7fefff]
[    0.112000] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
[    0.112000] pci 0000:00:12.1: reg 0x10: [mem 0xfe7fd000-0xfe7fdfff]
[    0.112000] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
[    0.112000] pci 0000:00:12.2: reg 0x10: [mem 0xfe7ff800-0xfe7ff8ff]
[    0.112000] pci 0000:00:12.2: supports D1 D2
[    0.112000] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
[    0.112000] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
[    0.112000] pci 0000:00:13.0: reg 0x10: [mem 0xfe7fc000-0xfe7fcfff]
[    0.112000] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
[    0.112000] pci 0000:00:13.1: reg 0x10: [mem 0xfe7fb000-0xfe7fbfff]
[    0.112000] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
[    0.112000] pci 0000:00:13.2: reg 0x10: [mem 0xfe7ff400-0xfe7ff4ff]
[    0.112000] pci 0000:00:13.2: supports D1 D2
[    0.112000] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
[    0.112000] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
[    0.112000] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
[    0.112000] pci 0000:00:14.1: reg 0x10: [io  0x0000-0x0007]
[    0.112000] pci 0000:00:14.1: reg 0x14: [io  0x0000-0x0003]
[    0.112000] pci 0000:00:14.1: reg 0x18: [io  0x0000-0x0007]
[    0.112000] pci 0000:00:14.1: reg 0x1c: [io  0x0000-0x0003]
[    0.112000] pci 0000:00:14.1: reg 0x20: [io  0xff00-0xff0f]
[    0.112000] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.112000] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.112000] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.112000] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.112000] pci 0000:00:14.2: [1002:4383] type 00 class 0x040300
[    0.112000] pci 0000:00:14.2: reg 0x10: [mem 0xfe7f4000-0xfe7f7fff 64bit]
[    0.112000] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.112000] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
[    0.112000] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
[    0.112000] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
[    0.112000] pci 0000:00:14.5: reg 0x10: [mem 0xfe7fa000-0xfe7fafff]
[    0.112000] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
[    0.112000] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
[    0.112000] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
[    0.112000] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
[    0.112000] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
[    0.112000] pci 0000:01:05.0: [1002:9614] type 00 class 0x030000
[    0.112000] pci 0000:01:05.0: reg 0x10: [mem 0xd0000000-0xdfffffff pref]
[    0.112000] pci 0000:01:05.0: reg 0x14: [io  0xd000-0xd0ff]
[    0.112000] pci 0000:01:05.0: reg 0x18: [mem 0xfe9f0000-0xfe9fffff]
[    0.112000] pci 0000:01:05.0: reg 0x24: [mem 0xfe800000-0xfe8fffff]
[    0.112000] pci 0000:01:05.0: supports D1 D2
[    0.112000] pci 0000:01:05.1: [1002:960f] type 00 class 0x040300
[    0.112000] pci 0000:01:05.1: reg 0x10: [mem 0xfe9e8000-0xfe9ebfff]
[    0.112000] pci 0000:01:05.1: supports D1 D2
[    0.112000] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.112000] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.112000] pci 0000:00:01.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    0.112000] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.112000] pci 0000:02:00.0: [14e4:1698] type 00 class 0x020000
[    0.112000] pci 0000:02:00.0: reg 0x10: [mem 0xfeaf0000-0xfeafffff 64bit]
[    0.112000] pci 0000:02:00.0: enabling Extended Tags
[    0.112000] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.124018] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.124022] pci 0000:00:09.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.124060] pci 0000:03:05.0: [9004:7895] type 00 class 0x010000
[    0.124077] pci 0000:03:05.0: reg 0x10: [io  0xe800-0xe8ff]
[    0.124088] pci 0000:03:05.0: reg 0x14: [mem 0xfebff000-0xfebfffff]
[    0.124140] pci 0000:03:05.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.124187] pci 0000:03:05.1: [9004:7895] type 00 class 0x010000
[    0.124204] pci 0000:03:05.1: reg 0x10: [io  0xe400-0xe4ff]
[    0.124215] pci 0000:03:05.1: reg 0x14: [mem 0xfebfe000-0xfebfefff]
[    0.124326] pci 0000:03:07.0: [1106:3044] type 00 class 0x0c0010
[    0.124346] pci 0000:03:07.0: reg 0x10: [mem 0xfebfd800-0xfebfdfff]
[    0.124358] pci 0000:03:07.0: reg 0x14: [io  0xe000-0xe07f]
[    0.124450] pci 0000:03:07.0: supports D2
[    0.124451] pci 0000:03:07.0: PME# supported from D2 D3hot D3cold
[    0.124525] pci 0000:00:14.4: PCI bridge to [bus 03] (subtractive decode)
[    0.124528] pci 0000:00:14.4:   bridge window [io  0xe000-0xefff]
[    0.124531] pci 0000:00:14.4:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.124535] pci 0000:00:14.4:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.124536] pci 0000:00:14.4:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.124537] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.124538] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xdfffffff window] (subtractive decode)
[    0.124540] pci 0000:00:14.4:   bridge window [mem 0xf0000000-0xfebfffff window] (subtractive decode)
[    0.128093] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 7 *10 11 12 14 15)
[    0.128158] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 7 *10 11 12 14 15)
[    0.128221] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 7 10 *11 12 14 15)
[    0.128285] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 7 10 *11 12 14 15)
[    0.128348] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 7 *10 11 12 14 15)
[    0.128411] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 7 *10 11 12 14 15)
[    0.128474] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 *7 10 11 12 14 15)
[    0.128538] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 7 10 11 12 14 15) *0, disabled.
[    0.128672] iommu: Default domain type: Passthrough 
[    0.128690] pci 0000:01:05.0: vgaarb: setting as boot VGA device
[    0.128690] pci 0000:01:05.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.128690] pci 0000:01:05.0: vgaarb: bridge control possible
[    0.128690] vgaarb: loaded
[    0.128690] SCSI subsystem initialized
[    0.128690] libata version 3.00 loaded.
[    0.128690] Linux cec interface: v0.10
[    0.128690] EDAC MC: Ver: 3.0.0
[    0.128690] PCI: Using ACPI for IRQ routing
[    0.135930] PCI: pci_cache_line_size set to 64 bytes
[    0.135986] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.135988] e820: reserve RAM buffer [mem 0xcffb0000-0xcfffffff]
[    0.140004] NetLabel: Initializing
[    0.140004] NetLabel:  domain hash size = 128
[    0.140004] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.140004] NetLabel:  unlabeled traffic allowed by default
[    0.140062] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.140065] hpet0: 4 comparators, 32-bit 14.318180 MHz counter
[    0.142130] clocksource: Switched to clocksource hpet
[    0.153343] VFS: Disk quotas dquot_6.6.0
[    0.153365] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.153478] AppArmor: AppArmor Filesystem Enabled
[    0.153512] pnp: PnP ACPI init
[    0.153711] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.153782] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.154345] pnp 00:02: [dma 0 disabled]
[    0.154412] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.155006] pnp 00:03: [dma 2]
[    0.155041] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.155187] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.155188] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.155190] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.155430] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.155432] system 00:05: [io  0x040b] has been reserved
[    0.155433] system 00:05: [io  0x04d6] has been reserved
[    0.155434] system 00:05: [io  0x0c00-0x0c01] has been reserved
[    0.155436] system 00:05: [io  0x0c14] has been reserved
[    0.155437] system 00:05: [io  0x0c50-0x0c51] has been reserved
[    0.155438] system 00:05: [io  0x0c52] has been reserved
[    0.155439] system 00:05: [io  0x0c6c] has been reserved
[    0.155441] system 00:05: [io  0x0c6f] has been reserved
[    0.155442] system 00:05: [io  0x0cd0-0x0cd1] has been reserved
[    0.155443] system 00:05: [io  0x0cd2-0x0cd3] has been reserved
[    0.155444] system 00:05: [io  0x0cd4-0x0cd5] has been reserved
[    0.155446] system 00:05: [io  0x0cd6-0x0cd7] has been reserved
[    0.155447] system 00:05: [io  0x0cd8-0x0cdf] has been reserved
[    0.155448] system 00:05: [io  0x0800-0x089f] has been reserved
[    0.155450] system 00:05: [io  0x0b00-0x0b0f] has been reserved
[    0.155451] system 00:05: [io  0x0b20-0x0b3f] has been reserved
[    0.155452] system 00:05: [io  0x0900-0x090f] has been reserved
[    0.155454] system 00:05: [io  0x0910-0x091f] has been reserved
[    0.155455] system 00:05: [io  0xfe00-0xfefe] has been reserved
[    0.155457] system 00:05: [mem 0xffb80000-0xffbfffff] has been reserved
[    0.155458] system 00:05: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.155460] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.155512] pnp 00:06: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.155580] pnp 00:07: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 (active)
[    0.156058] system 00:08: [io  0x0e00-0x0e0f] has been reserved
[    0.156060] system 00:08: [io  0x0e80-0x0e8f] has been reserved
[    0.156061] system 00:08: [io  0x0f40-0x0f4f] has been reserved
[    0.156063] system 00:08: [io  0x0a30-0x0a3f] has been reserved
[    0.156065] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.156131] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
[    0.156133] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.156503] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.156505] system 00:0a: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.156506] system 00:0a: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.156508] system 00:0a: [mem 0x00100000-0xcfffffff] could not be reserved
[    0.156509] system 00:0a: [mem 0xfec00000-0xffffffff] could not be reserved
[    0.156511] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.156647] pnp: PnP ACPI: found 11 devices
[    0.163314] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.163334] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.163336] pci 0000:00:01.0:   bridge window [io  0xd000-0xdfff]
[    0.163339] pci 0000:00:01.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[    0.163341] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.163343] pci 0000:00:09.0: PCI bridge to [bus 02]
[    0.163345] pci 0000:00:09.0:   bridge window [mem 0xfea00000-0xfeafffff]
[    0.163350] pci 0000:00:14.4: PCI bridge to [bus 03]
[    0.163352] pci 0000:00:14.4:   bridge window [io  0xe000-0xefff]
[    0.163356] pci 0000:00:14.4:   bridge window [mem 0xfeb00000-0xfebfffff]
[    0.163364] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.163365] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.163367] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.163368] pci_bus 0000:00: resource 7 [mem 0xd0000000-0xdfffffff window]
[    0.163369] pci_bus 0000:00: resource 8 [mem 0xf0000000-0xfebfffff window]
[    0.163370] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.163371] pci_bus 0000:01: resource 1 [mem 0xfe800000-0xfe9fffff]
[    0.163372] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.163373] pci_bus 0000:02: resource 1 [mem 0xfea00000-0xfeafffff]
[    0.163374] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.163375] pci_bus 0000:03: resource 1 [mem 0xfeb00000-0xfebfffff]
[    0.163376] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7 window]
[    0.163377] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff window]
[    0.163378] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.163379] pci_bus 0000:03: resource 7 [mem 0xd0000000-0xdfffffff window]
[    0.163380] pci_bus 0000:03: resource 8 [mem 0xf0000000-0xfebfffff window]
[    0.163458] NET: Registered protocol family 2
[    0.163634] TCP established hash table entries: 65536 (order: 7, 524288 bytes)
[    0.163809] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.164128] TCP: Hash tables configured (established 65536 bind 65536)
[    0.164189] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.164240] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.164324] NET: Registered protocol family 1
[    0.164328] NET: Registered protocol family 44
[    0.164333] pci 0000:00:01.0: MSI quirk detected; subordinate MSI disabled
[    0.632381] pci 0000:01:05.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.632387] pci 0000:01:05.1: Linked as a consumer to 0000:01:05.0
[    0.632402] PCI: CLS 64 bytes, default 64
[    0.632460] Unpacking initramfs...
[    1.388021] random: fast init done
[    3.459005] Freeing initrd memory: 30504K
[    3.459266] PCI-DMA: Disabling AGP.
[    3.459368] PCI-DMA: aperture base @ c4000000 size 65536 KB
[    3.459368] PCI-DMA: using GART IOMMU.
[    3.459370] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
[    3.462707] LVT offset 1 assigned for vector 0x400
[    3.462716] IBS: LVT offset 1 assigned
[    3.462852] perf: AMD IBS detected (0x0000001f)
[    3.462908] Scanning for low memory corruption every 60 seconds
[    3.463188] audit: initializing netlink subsys (disabled)
[    3.463323] audit: type=2000 audit(1584748911.460:1): state=initialized audit_enabled=0 res=1
[    3.463695] workingset: timestamp_bits=37 max_order=21 bucket_order=0
[    3.463770] zbud: loaded
[    3.466411] Key type asymmetric registered
[    3.466412] Asymmetric key parser 'x509' registered
[    3.466419] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    3.466476] io scheduler noop registered
[    3.466477] io scheduler deadline registered
[    3.466488] io scheduler cfq registered (default)
[    3.466488] io scheduler mq-deadline registered
[    3.466489] io scheduler kyber registered
[    3.466496] io scheduler bfq registered
[    3.466855] shpchp 0000:00:01.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.P0P1)
[    3.466859] shpchp 0000:00:01.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
[    3.466861] shpchp 0000:00:01.0: Cannot get control of SHPC hotplug
[    3.466871] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    3.466892] vesafb: mode is 1400x1050x32, linelength=5632, pages=0
[    3.466893] vesafb: scrolling: redraw
[    3.466894] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    3.466905] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc90001800000, using 5824k, total 5824k
[    3.664522] Console: switching to colour frame buffer device 175x65
[    3.861426] fb0: VESA VGA frame buffer device
[    3.861495] ACPI: ACPI: processor limited to max C-state 1
[    3.861617] GHES: HEST is not enabled!
[    3.861728] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    3.882263] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    3.903254] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.904619] Non-volatile memory driver v1.3
[    3.904647] Linux agpgart interface v0.103
[    3.905094] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
[    3.905441] serio: i8042 KBD port at 0x60,0x64 irq 1
[    3.905445] serio: i8042 AUX port at 0x60,0x64 irq 12
[    3.905568] mousedev: PS/2 mouse device common for all mice
[    3.905636] rtc_cmos 00:01: RTC can wake from S4
[    3.905758] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    3.905780] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    3.905844] ledtrig-cpu: registered to indicate activity on CPUs
[    3.905854] hidraw: raw HID events driver (C) Jiri Kosina
[    3.905978] NET: Registered protocol family 10
[    3.910732] Segment Routing with IPv6
[    3.911030] mce: Using 6 MCE banks
[    3.911038] microcode: microcode updated early to new patch_level=0x010000db
[    3.911056] microcode: CPU0: patch_level=0x010000db
[    3.911065] microcode: CPU1: patch_level=0x010000db
[    3.911072] microcode: CPU2: patch_level=0x010000db
[    3.911080] microcode: CPU3: patch_level=0x010000db
[    3.911113] microcode: Microcode Update Driver: v2.2.
[    3.911122] sched_clock: Marking stable (3911109456, 0)->(4020304257, -109194801)
[    3.911363] registered taskstats version 1
[    3.911380] zswap: loaded using pool lzo/zbud
[    3.911473] page_owner is disabled
[    3.915512] Key type big_key registered
[    3.917520] Key type encrypted registered
[    3.917523] AppArmor: AppArmor sha1 policy hashing enabled
[    3.917526] ima: No TPM chip found, activating TPM-bypass! (rc=-19)
[    3.917528] ima: Allocated hash algorithm: sha256
[    3.917546] evm: HMAC attrs: 0x1
[    3.917698]   Magic number: 12:516:1
[    3.917756] memory memory49: hash matches
[    3.917808] rtc_cmos 00:01: setting system clock to 2020-03-21 00:01:52 UTC (1584748912)
[    3.917834] PM: Checking hibernation image partition /dev/disk/by-uuid/a81d7f4e-b53d-47c5-bb75-2cd7c5f5b286
[    3.925729] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    4.480303] tsc: Refined TSC clocksource calibration: 3000.106 MHz
[    4.480308] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2b3ea998311, max_idle_ns: 440795342554 ns
[    5.173462] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input2
[    5.176299] PM: Hibernation image not present or could not be loaded.
[    5.178531] Freeing unused kernel memory: 2104K
[    5.200300] Write protecting the kernel read-only data: 16384k
[    5.201111] Freeing unused kernel memory: 2020K
[    5.203039] Freeing unused kernel memory: 740K
[    5.209801] systemd[1]: systemd 234 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT -GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN default-hierarchy=hybrid)
[    5.209901] systemd[1]: Detected architecture x86-64.
[    5.209903] systemd[1]: Running in initial RAM disk.
[    5.209916] systemd[1]: No hostname configured.
[    5.209919] systemd[1]: Set hostname to <localhost>.
[    5.209939] random: systemd: uninitialized urandom read (16 bytes read)
[    5.209943] systemd[1]: Initializing machine ID from random generator.
[    5.250129] random: systemd: uninitialized urandom read (16 bytes read)
[    5.250170] systemd[1]: Listening on udev Control Socket.
[    5.250212] random: systemd: uninitialized urandom read (16 bytes read)
[    5.250220] systemd[1]: Reached target Local File Systems.
[    5.250250] systemd[1]: Listening on udev Kernel Socket.
[    5.250597] systemd[1]: Created slice System Slice.
[    5.255032] alua: device handler registered
[    5.255230] emc: device handler registered
[    5.255413] rdac: device handler registered
[    5.257367] device-mapper: uevent: version 1.0.3
[    5.257433] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised: dm-devel@redhat.com
[    5.590877] clocksource: Switched to clocksource tsc
[    5.826897] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[    5.826953] ACPI: Power Button [PWRB]
[    5.826998] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    5.827025] ACPI: Power Button [PWRF]
[    5.830646] random: crng init done
[    5.830649] random: 7 urandom warning(s) missed due to ratelimiting
[    5.838651] Floppy drive(s): fd0 is 1.44M
[    5.843280] ahci 0000:00:11.0: version 3.0
[    5.843542] ahci 0000:00:11.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
[    5.843545] ahci 0000:00:11.0: flags: 64bit ncq sntf ilck pm led clo pmp pio slum part ccc 
[    5.843678] ACPI: bus type USB registered
[    5.843701] usbcore: registered new interface driver usbfs
[    5.843712] usbcore: registered new interface driver hub
[    5.843739] usbcore: registered new device driver usb
[    5.844568] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.845076] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.845278] ehci-pci: EHCI PCI platform driver
[    5.850544] scsi host0: ahci
[    5.871084] scsi host1: ahci
[    5.872068] [drm] radeon kernel modesetting enabled.
[    5.872132] checking generic (d0000000 5b0000) vs hw (d0000000 10000000)
[    5.872132] fb: switching to radeondrmfb from VESA VGA
[    5.872184] Console: switching to colour dummy device 80x25
[    5.872471] [drm] initializing kernel modesetting (RS780 0x1002:0x9614 0x105B:0x0E14 0x00).
[    5.873236] ATOM BIOS: B27722
[    5.873250] radeon 0000:01:05.0: VRAM: 384M 0x00000000C0000000 - 0x00000000D7FFFFFF (384M used)
[    5.873251] radeon 0000:01:05.0: GTT: 512M 0x00000000A0000000 - 0x00000000BFFFFFFF
[    5.873256] [drm] Detected VRAM RAM=384M, BAR=256M
[    5.873257] [drm] RAM width 32bits DDR
[    5.873311] [TTM] Zone  kernel: Available graphics memory: 3951432 kiB
[    5.873312] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    5.873312] [TTM] Initializing pool allocator
[    5.873317] [TTM] Initializing DMA pool allocator
[    5.873335] [drm] radeon: 384M of VRAM memory ready
[    5.873336] [drm] radeon: 512M of GTT memory ready.
[    5.873343] [drm] Loading RS780 Microcode
[    5.873405] [drm] radeon: power management initialized
[    5.873465] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    5.874166] scsi host2: ahci
[    5.890972] FDC 0 is a post-1991 82077
[    5.891021] scsi host4: ahci
[    5.891081] ata1: SATA max UDMA/133 abar m1024@0xfe7ffc00 port 0xfe7ffd00 irq 22
[    5.891083] ata2: SATA max UDMA/133 abar m1024@0xfe7ffc00 port 0xfe7ffd80 irq 22
[    5.891085] ata3: SATA max UDMA/133 abar m1024@0xfe7ffc00 port 0xfe7ffe00 irq 22
[    5.891087] ata4: SATA max UDMA/133 abar m1024@0xfe7ffc00 port 0xfe7ffe80 irq 22
[    5.891262] QUIRK: Enable AMD PLL fix
[    5.891286] ehci-pci 0000:00:12.2: EHCI Host Controller
[    5.891294] ehci-pci 0000:00:12.2: new USB bus registered, assigned bus number 1
[    5.891299] ehci-pci 0000:00:12.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    5.891300] ehci-pci 0000:00:12.2: applying AMD SB600/SB700 USB freeze workaround
[    5.891315] ehci-pci 0000:00:12.2: debug port 1
[    5.891360] ehci-pci 0000:00:12.2: irq 17, io mem 0xfe7ff800
[    5.894217] [drm] PCIE GART of 512M enabled (table at 0x00000000C0146000).
[    5.894292] radeon 0000:01:05.0: WB enabled
[    5.894295] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x00000000a0000c00 and cpu addr 0xffff88020e377c00
[    5.896724] radeon 0000:01:05.0: fence driver on ring 5 use gpu addr 0x00000000c0056038 and cpu addr 0xffffc90001616038
[    5.896756] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    5.896756] [drm] Driver supports precise vblank timestamp query.
[    5.896757] radeon 0000:01:05.0: radeon: MSI limited to 32-bit
[    5.896774] [drm] radeon: irq initialized.
[    5.904059] ehci-pci 0000:00:12.2: USB 2.0 started, EHCI 1.00
[    5.904404] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.904406] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.904407] usb usb1: Product: EHCI Host Controller
[    5.904408] usb usb1: Manufacturer: Linux 4.12.14-lp151.28.40-default ehci_hcd
[    5.904409] usb usb1: SerialNumber: 0000:00:12.2
[    5.904524] hub 1-0:1.0: USB hub found
[    5.904530] hub 1-0:1.0: 6 ports detected
[    5.904825] ehci-pci 0000:00:13.2: EHCI Host Controller
[    5.904830] ehci-pci 0000:00:13.2: new USB bus registered, assigned bus number 2
[    5.904834] ehci-pci 0000:00:13.2: applying AMD SB700/SB800/Hudson-2/3 EHCI dummy qh workaround
[    5.904835] ehci-pci 0000:00:13.2: applying AMD SB600/SB700 USB freeze workaround
[    5.904846] ehci-pci 0000:00:13.2: debug port 1
[    5.904883] ehci-pci 0000:00:13.2: irq 19, io mem 0xfe7ff400
[    5.924056] ehci-pci 0000:00:13.2: USB 2.0 started, EHCI 1.00
[    5.924132] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    5.924134] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.924136] usb usb2: Product: EHCI Host Controller
[    5.924137] usb usb2: Manufacturer: Linux 4.12.14-lp151.28.40-default ehci_hcd
[    5.924137] usb usb2: SerialNumber: 0000:00:13.2
[    5.924253] hub 2-0:1.0: USB hub found
[    5.924263] hub 2-0:1.0: 6 ports detected
[    5.924742] ohci-pci: OHCI PCI platform driver
[    5.926656] scsi host5: pata_atiixp
[    5.926838] scsi host6: pata_atiixp
[    5.926871] ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00 irq 14
[    5.926872] ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xff08 irq 15
[    5.927017] ohci-pci 0000:00:12.0: OHCI PCI host controller
[    5.927021] ohci-pci 0000:00:12.0: new USB bus registered, assigned bus number 3
[    5.927046] ohci-pci 0000:00:12.0: irq 16, io mem 0xfe7fe000
[    5.928669] [drm] ring test on 0 succeeded in 0 usecs
[    5.988133] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    5.988135] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.988136] usb usb3: Product: OHCI PCI host controller
[    5.988137] usb usb3: Manufacturer: Linux 4.12.14-lp151.28.40-default ohci_hcd
[    5.988138] usb usb3: SerialNumber: 0000:00:12.0
[    5.988257] hub 3-0:1.0: USB hub found
[    5.988270] hub 3-0:1.0: 3 ports detected
[    5.988482] ohci-pci 0000:00:12.1: OHCI PCI host controller
[    5.988486] ohci-pci 0000:00:12.1: new USB bus registered, assigned bus number 4
[    5.988505] ohci-pci 0000:00:12.1: irq 16, io mem 0xfe7fd000
[    6.052087] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001
[    6.052089] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.052090] usb usb4: Product: OHCI PCI host controller
[    6.052091] usb usb4: Manufacturer: Linux 4.12.14-lp151.28.40-default ohci_hcd
[    6.052092] usb usb4: SerialNumber: 0000:00:12.1
[    6.052192] hub 4-0:1.0: USB hub found
[    6.052199] hub 4-0:1.0: 3 ports detected
[    6.052374] ohci-pci 0000:00:13.0: OHCI PCI host controller
[    6.052378] ohci-pci 0000:00:13.0: new USB bus registered, assigned bus number 5
[    6.052394] ohci-pci 0000:00:13.0: irq 18, io mem 0xfe7fc000
[    6.086830] ata6.00: ATAPI: HL-DT-STDVD-RAM GH22NP20, 2.00, max UDMA/66
[    6.090002] ata5.00: ATA-8: Hitachi HUA723030ALA640, MKAOAA50, max UDMA/133
[    6.090004] ata5.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    6.090008] ata5.01: ATA-11: SanDisk SDSSDH3512G, X6107000, max UDMA/133
[    6.090009] ata5.01: 1000215216 sectors, multi 1: LBA48 NCQ (depth 0/32)
[    6.092368] ata6.00: configured for UDMA/66
[    6.095256] ata5.00: configured for UDMA/100
[    6.098602] ata5.01: configured for UDMA/100
[    6.104299] [drm] ring test on 5 succeeded in 1 usecs
[    6.104304] [drm] UVD initialized successfully.
[    6.104405] [drm] ib test on ring 0 succeeded in 0 usecs
[    6.116088] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    6.116090] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.116091] usb usb5: Product: OHCI PCI host controller
[    6.116092] usb usb5: Manufacturer: Linux 4.12.14-lp151.28.40-default ohci_hcd
[    6.116093] usb usb5: SerialNumber: 0000:00:13.0
[    6.116187] hub 5-0:1.0: USB hub found
[    6.116194] hub 5-0:1.0: 3 ports detected
[    6.116369] ohci-pci 0000:00:13.1: OHCI PCI host controller
[    6.116373] ohci-pci 0000:00:13.1: new USB bus registered, assigned bus number 6
[    6.116391] ohci-pci 0000:00:13.1: irq 18, io mem 0xfe7fb000
[    6.180099] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    6.180101] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.180102] usb usb6: Product: OHCI PCI host controller
[    6.180103] usb usb6: Manufacturer: Linux 4.12.14-lp151.28.40-default ohci_hcd
[    6.180104] usb usb6: SerialNumber: 0000:00:13.1
[    6.180211] hub 6-0:1.0: USB hub found
[    6.180218] hub 6-0:1.0: 3 ports detected
[    6.180403] ohci-pci 0000:00:14.5: OHCI PCI host controller
[    6.180407] ohci-pci 0000:00:14.5: new USB bus registered, assigned bus number 7
[    6.180428] ohci-pci 0000:00:14.5: irq 18, io mem 0xfe7fa000
[    6.244086] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001
[    6.244088] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.244088] usb usb7: Product: OHCI PCI host controller
[    6.244089] usb usb7: Manufacturer: Linux 4.12.14-lp151.28.40-default ohci_hcd
[    6.244090] usb usb7: SerialNumber: 0000:00:14.5
[    6.244189] hub 7-0:1.0: USB hub found
[    6.244196] hub 7-0:1.0: 2 ports detected
[    6.368300] ata2: softreset failed (device not ready)
[    6.368306] ata2: applying PMP SRST workaround and retrying
[    6.368322] ata1: softreset failed (device not ready)
[    6.368329] ata1: applying PMP SRST workaround and retrying
[    6.368345] ata4: softreset failed (device not ready)
[    6.368352] ata4: applying PMP SRST workaround and retrying
[    6.368367] ata3: softreset failed (device not ready)
[    6.368374] ata3: applying PMP SRST workaround and retrying
[    6.380293] usb 1-3: new high-speed USB device number 2 using ehci-pci
[    6.528306] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.528328] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.528349] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.528370] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    6.529575] ata2.00: ATA-9: SPCC Solid State Disk, SAFM01.6, max UDMA/133
[    6.529576] ata2.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    6.530395] ata1.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    6.530397] ata1.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    6.530406] ata3.00: ATA-8: TOSHIBA DT01ACA300, MX6OABB0, max UDMA/133
[    6.530407] ata3.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    6.530756] ata4.00: ATA-8: Hitachi HUA723030ALA640, MKAOAA50, max UDMA/133
[    6.530757] ata4.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    6.530763] ata2.00: configured for UDMA/133
[    6.532262] ata1.00: configured for UDMA/133
[    6.532415] scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 ABB0 PQ: 0 ANSI: 5
[    6.532567] ata3.00: configured for UDMA/133
[    6.532598] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.532622] ata4.00: configured for UDMA/133
[    6.532696] sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[    6.532698] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    6.532714] sd 0:0:0:0: [sda] Write Protect is off
[    6.532716] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.532744] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.532757] scsi 1:0:0:0: Direct-Access     ATA      SPCC Solid State 01.6 PQ: 0 ANSI: 5
[    6.532995] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    6.533091] sd 1:0:0:0: [sdb] 468862128 512-byte logical blocks: (240 GB/224 GiB)
[    6.533107] sd 1:0:0:0: [sdb] Write Protect is off
[    6.533109] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    6.533116] scsi 2:0:0:0: Direct-Access     ATA      TOSHIBA DT01ACA3 ABB0 PQ: 0 ANSI: 5
[    6.533133] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.533313] sd 2:0:0:0: [sdc] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[    6.533315] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    6.533323] sd 2:0:0:0: [sdc] Write Protect is off
[    6.533324] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    6.533348] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    6.533351] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.533442] scsi 4:0:0:0: Direct-Access     ATA      Hitachi HUA72303 AA50 PQ: 0 ANSI: 5
[    6.533564] sd 4:0:0:0: Attached scsi generic sg3 type 0
[    6.533648] scsi 5:0:0:0: Direct-Access     ATA      Hitachi HUA72303 AA50 PQ: 0 ANSI: 5
[    6.533758] sd 5:0:0:0: Attached scsi generic sg4 type 0
[    6.533779] sd 5:0:0:0: [sde] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[    6.533786] sd 5:0:0:0: [sde] Write Protect is off
[    6.533787] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    6.533798] sd 5:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.533849] scsi 5:0:1:0: Direct-Access     ATA      SanDisk SDSSDH35 7000 PQ: 0 ANSI: 5
[    6.533857]  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
[    6.533897] sd 4:0:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
[    6.533913] sd 4:0:0:0: [sdd] Write Protect is off
[    6.533914] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    6.533939] sd 4:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.534008] sd 5:0:1:0: Attached scsi generic sg5 type 0
[    6.534399] sd 1:0:0:0: [sdb] Attached SCSI disk
[    6.539968] scsi 6:0:0:0: CD-ROM            HL-DT-ST DVD-RAM GH22NP20 2.00 PQ: 0 ANSI: 5
[    6.542198] usb 1-3: New USB device found, idVendor=14cd, idProduct=8601
[    6.542200] usb 1-3: New USB device strings: Mfr=1, Product=3, SerialNumber=0
[    6.542201] usb 1-3: Product: USB 2.0 Hub            
[    6.542202] usb 1-3: Manufacturer: USB Device  
[    6.542329] hub 1-3:1.0: USB hub found
[    6.542431] hub 1-3:1.0: 4 ports detected
[    6.567576] sd 5:0:1:0: [sdf] 1000215216 512-byte logical blocks: (512 GB/477 GiB)
[    6.567644] sd 5:0:1:0: [sdf] Write Protect is off
[    6.567645] sd 5:0:1:0: [sdf] Mode Sense: 00 3a 00 00
[    6.577376] scsi 6:0:0:0: Attached scsi generic sg6 type 5
[    6.585921]  sdd: sdd1
[    6.586156] sd 4:0:0:0: [sdd] Attached SCSI disk
[    6.591175] sd 5:0:1:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.591190]  sda: sda1
[    6.591449] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.591941]  sde: sde1
[    6.592181] sd 5:0:0:0: [sde] Attached SCSI disk
[    6.597073]  sdc: sdc1
[    6.597309] sd 2:0:0:0: [sdc] Attached SCSI disk
[    6.600689]  sdf: sdf1 sdf2 sdf3 sdf4
[    6.600935] sd 5:0:1:0: [sdf] Attached SCSI disk
[    6.649840] sr 6:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    6.649843] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.649983] sr 6:0:0:0: Attached scsi CD-ROM sr0
[    6.672399] usb 1-4: new high-speed USB device number 3 using ehci-pci
[    6.784069] [drm] ib test on ring 5 succeeded
[    6.784304] [drm] Radeon Display Connectors
[    6.784305] [drm] Connector 0:
[    6.784305] [drm]   VGA-1
[    6.784307] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48 0x7e4c 0x7e4c
[    6.784307] [drm]   Encoders:
[    6.784307] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    6.784308] [drm] Connector 1:
[    6.784308] [drm]   DVI-D-1
[    6.784309] [drm]   HPD3
[    6.784310] [drm]   DDC: 0x7e50 0x7e50 0x7e54 0x7e54 0x7e58 0x7e58 0x7e5c 0x7e5c
[    6.784310] [drm]   Encoders:
[    6.784310] [drm]     DFP3: INTERNAL_KLDSCP_LVTMA
[    6.834431] [drm] fb mappable at 0xD0247000
[    6.834432] [drm] vram apper at 0xD0000000
[    6.834432] [drm] size 8294400
[    6.834433] [drm] fb depth is 24
[    6.834433] [drm]    pitch is 7680
[    6.834559] fbcon: radeondrmfb (fb0) is primary device
[    6.875446] Console: switching to colour frame buffer device 240x67
[    6.894522] radeon 0000:01:05.0: fb0: radeondrmfb frame buffer device
[    6.895398] usb 1-4: New USB device found, idVendor=04b8, idProduct=0121
[    6.895399] usb 1-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    6.895401] usb 1-4: Product: EPSON Scanner
[    6.895402] usb 1-4: Manufacturer: EPSON
[    6.928205] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:05.0 on minor 0
[    6.942501] EXT4-fs (sdf2): mounted filesystem with ordered data mode. Opts: (null)
[    6.952049] usb 1-3.4: new high-speed USB device number 4 using ehci-pci
[    7.062509] usb 1-3.4: New USB device found, idVendor=2109, idProduct=2811
[    7.062512] usb 1-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    7.062513] usb 1-3.4: Product: USB2.0 Hub             
[    7.062514] usb 1-3.4: Manufacturer: VIA Labs, Inc.         
[    7.063037] hub 1-3.4:1.0: USB hub found
[    7.063256] hub 1-3.4:1.0: 4 ports detected
[   20.960318] scsi host3: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
                       <Adaptec 2940/DUAL Ultra SCSI adapter>
                       aic7895: Ultra Wide Channel A, SCSI Id=7, 32/253 SCBs

[   40.160317] scsi host7: Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
                       <Adaptec 2940/DUAL Ultra SCSI adapter>
                       aic7895: Ultra Single Channel B, SCSI Id=7, 32/253 SCBs

[   42.072330] firewire_ohci 0000:03:07.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x11
[   42.162320] systemd-journald[150]: Received SIGTERM from PID 1 (systemd).
[   42.206073] systemd: 18 output lines suppressed due to ratelimiting
[   42.592174] firewire_core 0000:03:07.0: created device fw0: GUID 00016c2000589db1, S400
[   42.809351] EXT4-fs (sdf2): re-mounted. Opts: acl,user_xattr
[   42.858911] systemd-journald[414]: Received request to flush runtime journal from PID 1
[   42.897436] audit: type=1400 audit(1584748951.477:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ping" pid=447 comm="apparmor_parser"
[   42.915256] audit: type=1400 audit(1584748951.493:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="klogd" pid=456 comm="apparmor_parser"
[   42.925843] audit: type=1400 audit(1584748951.505:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslogd" pid=461 comm="apparmor_parser"
[   42.938763] audit: type=1400 audit(1584748951.517:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslog-ng" pid=466 comm="apparmor_parser"
[   42.948710] audit: type=1400 audit(1584748951.529:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lessopen.sh" pid=472 comm="apparmor_parser"
[   42.963156] audit: type=1400 audit(1584748951.541:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2" pid=477 comm="apparmor_parser"
[   42.963160] audit: type=1400 audit(1584748951.541:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2//DEFAULT_URI" pid=477 comm="apparmor_parser"
[   42.963161] audit: type=1400 audit(1584748951.541:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2//HANDLING_UNTRUSTED_INPUT" pid=477 comm="apparmor_parser"
[   42.963163] audit: type=1400 audit(1584748951.541:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/apache2/mpm-prefork/apache2//phpsysinfo" pid=477 comm="apparmor_parser"
[   42.986925] audit: type=1400 audit(1584748951.565:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/lib/dovecot/anvil" pid=506 comm="apparmor_parser"
[   43.006919] acpi_cpufreq: overriding BIOS provided _PSD data
[   43.026805] thermal LNXTHERM:00: registered as thermal_zone0
[   43.026808] ACPI: Thermal Zone [THRM] (40 C)
[   43.028926] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\SOR1) (20170303/utaddress-213)
[   43.028931] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   43.033882] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
[   43.033934] sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x3a
[   43.033953] sp5100_tco: failed to find MMIO address, giving up.
[   43.036977] pps_core: LinuxPPS API ver. 1 registered
[   43.036978] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   43.037931] PTP clock support registered
[   43.058428] tg3.c:v3.137 (May 11, 2014)
[   43.070934] k10temp 0000:00:18.3: unreliable CPU thermal sensor; monitoring disabled
[   43.082885] tg3 0000:02:00.0 eth0: Tigon3 [partno(none) rev 5784100] (PCI Express) MAC address 00:1f:e2:6c:d8:9d
[   43.082888] tg3 0000:02:00.0 eth0: attached PHY is 5784 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   43.082890] tg3 0000:02:00.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   43.082891] tg3 0000:02:00.0 eth0: dma_rwctrl[76180000] dma_mask[64-bit]
[   43.095537] input: PC Speaker as /devices/platform/pcspkr/input/input5
[   43.241658] kvm: Nested Virtualization enabled
[   43.241663] kvm: Nested Paging enabled
[   43.294109] MCE: In-kernel MCE decoding enabled.
[   43.296992] EDAC amd64: Node 0: DRAM ECC disabled.
[   43.296997] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   43.321173] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:05.1/sound/card1/input6
[   43.368031] raid6: sse2x1   gen()  3978 MB/s
[   43.436029] raid6: sse2x1   xor()  3967 MB/s
[   43.504046] raid6: sse2x2   gen()  6370 MB/s
[   43.572029] raid6: sse2x2   xor()  6823 MB/s
[   43.640030] raid6: sse2x4   gen()  7711 MB/s
[   43.708040] raid6: sse2x4   xor()  3446 MB/s
[   43.708046] raid6: using algorithm sse2x4 gen() 7711 MB/s
[   43.708046] raid6: .... xor() 3446 MB/s, rmw enabled
[   43.708047] raid6: using intx1 recovery algorithm
[   43.732358] xor: measuring software checksum speed
[   43.732983] EDAC amd64: Node 0: DRAM ECC disabled.
[   43.732986] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   43.746346] snd_hda_codec_realtek hdaudioC0D3: autoconfig for ALC888: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   43.746349] snd_hda_codec_realtek hdaudioC0D3:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   43.746350] snd_hda_codec_realtek hdaudioC0D3:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   43.746351] snd_hda_codec_realtek hdaudioC0D3:    mono: mono_out=0x0
[   43.746352] snd_hda_codec_realtek hdaudioC0D3:    dig-out=0x1e/0x0
[   43.746353] snd_hda_codec_realtek hdaudioC0D3:    inputs:
[   43.746355] snd_hda_codec_realtek hdaudioC0D3:      Front Mic=0x19
[   43.746356] snd_hda_codec_realtek hdaudioC0D3:      Rear Mic=0x18
[   43.746357] snd_hda_codec_realtek hdaudioC0D3:      Line=0x1a
[   43.763783] md/raid10:md127: active with 4 out of 4 devices
[   43.766902] input: HDA ATI SB Front Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input7
[   43.766949] input: HDA ATI SB Rear Mic as /devices/pci0000:00/0000:00:14.2/sound/card0/input8
[   43.766987] input: HDA ATI SB Line as /devices/pci0000:00/0000:00:14.2/sound/card0/input9
[   43.767026] input: HDA ATI SB Line Out Front as /devices/pci0000:00/0000:00:14.2/sound/card0/input10
[   43.767471] input: HDA ATI SB Line Out Surround as /devices/pci0000:00/0000:00:14.2/sound/card0/input11
[   43.767515] input: HDA ATI SB Line Out CLFE as /devices/pci0000:00/0000:00:14.2/sound/card0/input12
[   43.770201] input: HDA ATI SB Line Out Side as /devices/pci0000:00/0000:00:14.2/sound/card0/input13
[   43.770256] input: HDA ATI SB Front Headphone as /devices/pci0000:00/0000:00:14.2/sound/card0/input14
[   43.772023]    prefetch64-sse: 11759.000 MB/sec
[   43.792999] md127: detected capacity change from 0 to 6000914464768
[   43.801746]  md127: p1
[   43.812023]    generic_sse: 11313.000 MB/sec
[   43.812024] xor: using function: prefetch64-sse (11759.000 MB/sec)
[   43.835485] Adding 8389952k swap on /dev/sdf4.  Priority:-1 extents:1 across:8389952k SSFS
[   43.841328] EDAC amd64: Node 0: DRAM ECC disabled.
[   43.841330] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   43.857569] Btrfs loaded, crc32c=crc32c-generic, assert=on
[   43.862311] BTRFS: device fsid 11e7b516-5486-4637-bf67-7bd72abc314e devid 1 transid 24068413 /dev/sdb1
[   43.893497] EDAC amd64: Node 0: DRAM ECC disabled.
[   43.893500] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[   44.019986] EXT4-fs (sdf3): mounted filesystem with ordered data mode. Opts: (null)
[   44.081012] SGI XFS with ACLs, security attributes, no debug enabled
[   44.083799] XFS (md127p1): Mounting V5 Filesystem
[   44.360052] XFS (md127p1): Ending clean mount
[   44.712063] vboxdrv: loading out-of-tree module taints kernel.
[   44.717980] vboxdrv: Found 4 processor cores
[   44.736423] vboxdrv: TSC mode is Invariant, tentative frequency 3000029091 Hz
[   44.736426] vboxdrv: Successfully loaded version 6.1.4 (interface 0x002d0001)
[   44.955585] VBoxNetFlt: Successfully started.
[   44.963575] VBoxNetAdp: Successfully started.
[   45.413186] ip_tables: (C) 2000-2006 Netfilter Core Team
[   45.430009] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   45.470231] Ebtables v2.0 registered
[   45.538178] Loading iSCSI transport class v2.0-870.
[   45.573269] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[   45.623763] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   45.734964] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   45.901127] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   45.902247] Bridge firewalling registered
[   45.923218] Netfilter messages via NETLINK v0.30.
[   45.933636] ip_set: protocol 6
[   47.306978] tg3 0000:02:00.0 eth0: Link is up at 100 Mbps, full duplex
[   47.307005] tg3 0000:02:00.0 eth0: Flow control is on for TX and on for RX
[   47.307044] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   47.440564] NET: Registered protocol family 17
[   53.339039] fuse init (API version 7.26)
[44295.941677] SUPR0GipMap: fGetGipCpu=0xb
[44296.950258] vboxdrv: 0000000000000000 VMMR0.r0
[44297.104621] vboxdrv: 0000000000000000 VBoxDDR0.r0
[44297.247715] VBoxNetFlt: attached to 'eth0' / 00:1f:e2:6c:d8:9d
[44297.279950] vboxdrv: 0000000000000000 VBoxEhciR0.r0
[44297.281259] VMMR0InitVM: eflags=246 fKernelFeatures=0x0 (SUPKERNELFEATURES_SMAP=0)
[44297.288047] device eth0 entered promiscuous mode
[50436.653773] perf: interrupt took too long (2506 > 2500), lowering kernel.perf_event_max_sample_rate to 79750
[74091.705769] BTRFS info (device sdb1): disk space caching is enabled
[74091.705771] BTRFS info (device sdb1): has skinny extents
[74091.708866] BTRFS critical (device sdb1): corrupt leaf: root=1 block=2642034688 slot=29, unexpected item end, have 1866556696 expect 12824
[74091.738581] BTRFS error (device sdb1): open_ctree failed
[74362.190381] BTRFS info (device sdb1): disk space caching is enabled
[74362.190385] BTRFS info (device sdb1): has skinny extents
[74362.193008] BTRFS critical (device sdb1): corrupt leaf: root=1 block=2642034688 slot=29, unexpected item end, have 1866556696 expect 12824
[74362.233441] BTRFS error (device sdb1): open_ctree failed
[74775.440453] print_req_error: I/O error, dev fd0, sector 0
[74775.440460] floppy: error 10 while reading block 0

------=_Part_3630389_446126246.1584828383357--

