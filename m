Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD13F7E24
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 00:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhHYWEQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 25 Aug 2021 18:04:16 -0400
Received: from rin.romanrm.net ([51.158.148.128]:56608 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhHYWEP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 18:04:15 -0400
Received: from natsu (natsu2.home.romanrm.net [IPv6:fd39::e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id 7E0E62C6;
        Wed, 25 Aug 2021 22:03:23 +0000 (UTC)
Date:   Thu, 26 Aug 2021 03:03:22 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Evan Zimmerman <wolfblitz98@gmail.com>, linux-btrfs@vger.kernel.org
Subject: Re: BTRFS - Error After Power Outage
Message-ID: <20210826030322.5379d606@natsu>
In-Reply-To: <CA+9Jo8uye5N-cj+70mVx_6AfgWHwWqYJjrzCU9jkbATK+_U0QA@mail.gmail.com>
References: <CA+9Jo8u1RbB=pzPj6bpAYLc5BGaZe2S17s-SxA8t+bm-D=wj-g@mail.gmail.com>
        <20210826025358.7cba5c44@natsu>
        <CA+9Jo8uye5N-cj+70mVx_6AfgWHwWqYJjrzCU9jkbATK+_U0QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I meant just send to the list, not to me directly. I have not seen an error
state like this. Maybe someone else can help.

What does "btrfs check /dev/sdd" return? Do not use --repair for now.

On Wed, 25 Aug 2021 14:58:29 -0700
Evan Zimmerman <wolfblitz98@gmail.com> wrote:

> [    0.000000] Linux version 5.9.0-5-amd64
> (debian-kernel@lists.debian.org) (gcc-10 (Debian 10.2.1-1) 10.2.1
> 20201207, GNU ld (GNU Binutils for Debian) 2.35.1) #1 SMP Debian
> 5.9.15-1 (2020-12-17)
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.9.0-5-amd64
> root=UUID=32c8fba7-d657-496b-8ae9-0e6e8b16969b ro quiet
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
> point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
> 832 bytes, using 'standard' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000a9b1bfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000a9b1c000-0x00000000a9b22fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000a9b23000-0x00000000aa809fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000aa80a000-0x00000000aad20fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000aad21000-0x00000000bd459fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bd45a000-0x00000000bd4c0fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bd4c1000-0x00000000bd506fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bd507000-0x00000000bd63dfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bd63e000-0x00000000bdffefff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bdfff000-0x00000000bdffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bf000000-0x00000000cf1fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000042edfffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.8 present.
> [    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./H97M
> Pro4, BIOS P2.00 07/27/2015
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 3298.919 MHz processor
> [    0.000543] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000544] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000549] last_pfn = 0x42ee00 max_arch_pfn = 0x400000000
> [    0.000551] MTRR default type: uncachable
> [    0.000552] MTRR fixed ranges enabled:
> [    0.000553]   00000-9FFFF write-back
> [    0.000553]   A0000-BFFFF uncachable
> [    0.000554]   C0000-CFFFF write-protect
> [    0.000554]   D0000-E7FFF uncachable
> [    0.000555]   E8000-FFFFF write-protect
> [    0.000555] MTRR variable ranges enabled:
> [    0.000556]   0 base 0000000000 mask 7C00000000 write-back
> [    0.000557]   1 base 0400000000 mask 7FE0000000 write-back
> [    0.000557]   2 base 0420000000 mask 7FF0000000 write-back
> [    0.000558]   3 base 00C0000000 mask 7FC0000000 uncachable
> [    0.000558]   4 base 00BF000000 mask 7FFF000000 uncachable
> [    0.000559]   5 base 042F000000 mask 7FFF000000 uncachable
> [    0.000559]   6 base 042EE00000 mask 7FFFE00000 uncachable
> [    0.000559]   7 disabled
> [    0.000560]   8 disabled
> [    0.000560]   9 disabled
> [    0.000785] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
> [    0.000877] e820: update [mem 0xbf000000-0xffffffff] usable ==> reserved
> [    0.000879] last_pfn = 0xbe000 max_arch_pfn = 0x400000000
> [    0.006922] found SMP MP-table at [mem 0x000fd170-0x000fd17f]
> [    0.023502] Using GB pages for direct mapping
> [    0.023785] RAMDISK: [mem 0x330bb000-0x35854fff]
> [    0.023788] ACPI: Early table checksum verification disabled
> [    0.023789] ACPI: RSDP 0x00000000000F04A0 000024 (v02 ALASKA)
> [    0.023792] ACPI: XSDT 0x00000000BD60B088 00008C (v01 ALASKA A M I
>   01072009 AMI  00010013)
> [    0.023795] ACPI: FACP 0x00000000BD61C330 00010C (v05 ALASKA A M I
>   01072009 AMI  00010013)
> [    0.023798] ACPI: DSDT 0x00000000BD60B1A8 011187 (v02 ALASKA A M I
>   00000191 INTL 20120711)
> [    0.023801] ACPI: FACS 0x00000000BD63DF80 000040
> [    0.023802] ACPI: APIC 0x00000000BD61C440 000072 (v03 ALASKA A M I
>   01072009 AMI  00010013)
> [    0.023804] ACPI: FPDT 0x00000000BD61C4B8 000044 (v01 ALASKA A M I
>   01072009 AMI  00010013)
> [    0.023805] ACPI: SSDT 0x00000000BD61C500 000539 (v01 PmRef
> Cpu0Ist  00003000 INTL 20051117)
> [    0.023807] ACPI: SSDT 0x00000000BD61CA40 000B74 (v01 CpuRef
> CpuSsdt  00003000 INTL 20051117)
> [    0.023809] ACPI: MCFG 0x00000000BD61D5B8 00003C (v01 ALASKA A M I
>   01072009 MSFT 00000097)
> [    0.023811] ACPI: HPET 0x00000000BD61D5F8 000038 (v01 ALASKA A M I
>   01072009 AMI. 00000005)
> [    0.023812] ACPI: SSDT 0x00000000BD61D630 00036D (v01 SataRe
> SataTabl 00001000 INTL 20120711)
> [    0.023814] ACPI: SSDT 0x00000000BD61D9A0 005B5E (v01 SaSsdt SaSsdt
>   00003000 INTL 20120711)
> [    0.023816] ACPI: ASF! 0x00000000BD623500 0000A5 (v32 INTEL   HCG
>   00000001 TFSM 000F4240)
> [    0.023817] ACPI: AAFT 0x00000000BD6235A8 00022C (v01 ALASKA
> OEMAAFT  01072009 MSFT 00000097)
> [    0.023819] ACPI: UEFI 0x00000000BD6237D8 000042 (v01 ALASKA A M I
>   01072009      00000000)
> [    0.023821] ACPI: SSDT 0x00000000BD623820 000579 (v01 Intel_
> IsctTabl 00001000 INTL 20120711)
> [    0.023826] ACPI: Local APIC address 0xfee00000
> [    0.023861] No NUMA configuration found
> [    0.023861] Faking a node at [mem 0x0000000000000000-0x000000042edfffff]
> [    0.023864] NODE_DATA(0) allocated [mem 0x42edf9000-0x42edfdfff]
> [    0.023890] Zone ranges:
> [    0.023891]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.023892]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.023892]   Normal   [mem 0x0000000100000000-0x000000042edfffff]
> [    0.023893]   Device   empty
> [    0.023893] Movable zone start for each node
> [    0.023894] Early memory node ranges
> [    0.023894]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
> [    0.023895]   node   0: [mem 0x0000000000100000-0x00000000a9b1bfff]
> [    0.023896]   node   0: [mem 0x00000000a9b23000-0x00000000aa809fff]
> [    0.023896]   node   0: [mem 0x00000000aad21000-0x00000000bd459fff]
> [    0.023897]   node   0: [mem 0x00000000bd4c1000-0x00000000bd506fff]
> [    0.023897]   node   0: [mem 0x00000000bdfff000-0x00000000bdffffff]
> [    0.023897]   node   0: [mem 0x0000000100000000-0x000000042edfffff]
> [    0.024016] Zeroed struct page in unavailable ranges: 17121 pages
> [    0.024016] Initmem setup node 0 [mem 0x0000000000001000-0x000000042edfffff]
> [    0.024017] On node 0 totalpages: 4111647
> [    0.024018]   DMA zone: 64 pages used for memmap
> [    0.024018]   DMA zone: 21 pages reserved
> [    0.024019]   DMA zone: 3996 pages, LIFO batch:0
> [    0.024053]   DMA32 zone: 12031 pages used for memmap
> [    0.024053]   DMA32 zone: 769923 pages, LIFO batch:63
> [    0.029912]   Normal zone: 52152 pages used for memmap
> [    0.029913]   Normal zone: 3337728 pages, LIFO batch:63
> [    0.030197] Reserving Intel graphics memory at [mem 0xbf200000-0xcf1fffff]
> [    0.030268] ACPI: PM-Timer IO Port: 0x1808
> [    0.030270] ACPI: Local APIC address 0xfee00000
> [    0.030274] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
> [    0.030282] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
> [    0.030284] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.030285] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.030285] ACPI: IRQ0 used by override.
> [    0.030286] ACPI: IRQ9 used by override.
> [    0.030287] Using ACPI (MADT) for SMP configuration information
> [    0.030288] ACPI: HPET id: 0x8086a701 base: 0xfed00000
> [    0.030292] [Firmware Bug]: TSC_DEADLINE disabled due to Errata;
> please update microcode to version: 0x22 (or later)
> [    0.030293] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> [    0.030307] PM: hibernation: Registered nosave memory: [mem
> 0x00000000-0x00000fff]
> [    0.030309] PM: hibernation: Registered nosave memory: [mem
> 0x0009d000-0x0009dfff]
> [    0.030309] PM: hibernation: Registered nosave memory: [mem
> 0x0009e000-0x0009ffff]
> [    0.030309] PM: hibernation: Registered nosave memory: [mem
> 0x000a0000-0x000dffff]
> [    0.030310] PM: hibernation: Registered nosave memory: [mem
> 0x000e0000-0x000fffff]
> [    0.030311] PM: hibernation: Registered nosave memory: [mem
> 0xa9b1c000-0xa9b22fff]
> [    0.030312] PM: hibernation: Registered nosave memory: [mem
> 0xaa80a000-0xaad20fff]
> [    0.030313] PM: hibernation: Registered nosave memory: [mem
> 0xbd45a000-0xbd4c0fff]
> [    0.030314] PM: hibernation: Registered nosave memory: [mem
> 0xbd507000-0xbd63dfff]
> [    0.030315] PM: hibernation: Registered nosave memory: [mem
> 0xbd63e000-0xbdffefff]
> [    0.030316] PM: hibernation: Registered nosave memory: [mem
> 0xbe000000-0xbeffffff]
> [    0.030316] PM: hibernation: Registered nosave memory: [mem
> 0xbf000000-0xcf1fffff]
> [    0.030317] PM: hibernation: Registered nosave memory: [mem
> 0xcf200000-0xefffffff]
> [    0.030317] PM: hibernation: Registered nosave memory: [mem
> 0xf0000000-0xf7ffffff]
> [    0.030317] PM: hibernation: Registered nosave memory: [mem
> 0xf8000000-0xfebfffff]
> [    0.030318] PM: hibernation: Registered nosave memory: [mem
> 0xfec00000-0xfec00fff]
> [    0.030318] PM: hibernation: Registered nosave memory: [mem
> 0xfec01000-0xfecfffff]
> [    0.030319] PM: hibernation: Registered nosave memory: [mem
> 0xfed00000-0xfed03fff]
> [    0.030319] PM: hibernation: Registered nosave memory: [mem
> 0xfed04000-0xfed1bfff]
> [    0.030319] PM: hibernation: Registered nosave memory: [mem
> 0xfed1c000-0xfed1ffff]
> [    0.030320] PM: hibernation: Registered nosave memory: [mem
> 0xfed20000-0xfedfffff]
> [    0.030320] PM: hibernation: Registered nosave memory: [mem
> 0xfee00000-0xfee00fff]
> [    0.030321] PM: hibernation: Registered nosave memory: [mem
> 0xfee01000-0xfeffffff]
> [    0.030321] PM: hibernation: Registered nosave memory: [mem
> 0xff000000-0xffffffff]
> [    0.030322] [mem 0xcf200000-0xefffffff] available for PCI devices
> [    0.030323] Booting paravirtualized kernel on bare hardware
> [    0.030325] clocksource: refined-jiffies: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
> [    0.033441] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
> nr_cpu_ids:4 nr_node_ids:1
> [    0.033576] percpu: Embedded 55 pages/cpu s185048 r8192 d32040 u524288
> [    0.033580] pcpu-alloc: s185048 r8192 d32040 u524288 alloc=1*2097152
> [    0.033581] pcpu-alloc: [0] 0 1 2 3
> [    0.033598] Built 1 zonelists, mobility grouping on.  Total pages: 4047379
> [    0.033598] Policy zone: Normal
> [    0.033599] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-5.9.0-5-amd64
> root=UUID=32c8fba7-d657-496b-8ae9-0e6e8b16969b ro quiet
> [    0.034305] Dentry cache hash table entries: 2097152 (order: 12,
> 16777216 bytes, linear)
> [    0.034644] Inode-cache hash table entries: 1048576 (order: 11,
> 8388608 bytes, linear)
> [    0.034676] mem auto-init: stack:off, heap alloc:on, heap free:off
> [    0.047775] Memory: 3093640K/16446588K available (12291K kernel
> code, 1298K rwdata, 3808K rodata, 1636K init, 1768K bss, 416840K
> reserved, 0K cma-reserved)
> [    0.047781] random: get_random_u64 called from
> __kmem_cache_create+0x2e/0x540 with crng_init=0
> [    0.047867] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> [    0.047875] Kernel/User page tables isolation: enabled
> [    0.047885] ftrace: allocating 34827 entries in 137 pages
> [    0.057122] ftrace: allocated 137 pages with 3 groups
> [    0.057200] rcu: Hierarchical RCU implementation.
> [    0.057200] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
> [    0.057201]     Rude variant of Tasks RCU enabled.
> [    0.057201] rcu: RCU calculated value of scheduler-enlistment delay
> is 25 jiffies.
> [    0.057202] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> [    0.059631] NR_IRQS: 33024, nr_irqs: 456, preallocated irqs: 16
> [    0.059834] random: crng done (trusting CPU's manufacturer)
> [    0.061403] Console: colour VGA+ 80x25
> [    0.061455] printk: console [tty0] enabled
> [    0.061466] ACPI: Core revision 20200717
> [    0.061560] clocksource: hpet: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 133484882848 ns
> [    0.061569] APIC: Switch to symmetric I/O mode setup
> [    0.061633] x2apic: IRQ remapping doesn't support X2APIC mode
> [    0.061971] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
> [    0.081571] clocksource: tsc-early: mask: 0xffffffffffffffff
> max_cycles: 0x2f8d4f3f13a, max_idle_ns: 440795344257 ns
> [    0.081573] Calibrating delay loop (skipped), value calculated
> using timer frequency.. 6597.83 BogoMIPS (lpj=13195676)
> [    0.081575] pid_max: default: 32768 minimum: 301
> [    0.081592] LSM: Security Framework initializing
> [    0.081597] Yama: disabled by default; enable with sysctl kernel.yama.*
> [    0.081613] AppArmor: AppArmor initialized
> [    0.081614] TOMOYO Linux initialized
> [    0.081647] Mount-cache hash table entries: 32768 (order: 6, 262144
> bytes, linear)
> [    0.081671] Mountpoint-cache hash table entries: 32768 (order: 6,
> 262144 bytes, linear)
> [    0.081848] mce: CPU0: Thermal monitoring enabled (TM1)
> [    0.081860] process: using mwait in idle threads
> [    0.081862] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
> [    0.081862] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
> [    0.081864] Spectre V1 : Mitigation: usercopy/swapgs barriers and
> __user pointer sanitization
> [    0.081865] Spectre V2 : Mitigation: Full generic retpoline
> [    0.081865] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
> Filling RSB on context switch
> [    0.081865] Speculative Store Bypass: Vulnerable
> [    0.081867] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
> [    0.081867] SRBDS: Vulnerable: No microcode
> [    0.081867] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [    0.081966] Freeing SMP alternatives memory: 32K
> [    0.191360] smpboot: CPU0: Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
> (family: 0x6, model: 0x3c, stepping: 0x3)
> [    0.191436] Performance Events: PEBS fmt2+, Haswell events, 16-deep
> LBR, full-width counters, Intel PMU driver.
> [    0.191445] ... version:                3
> [    0.191445] ... bit width:              48
> [    0.191445] ... generic registers:      8
> [    0.191446] ... value mask:             0000ffffffffffff
> [    0.191446] ... max period:             00007fffffffffff
> [    0.191447] ... fixed-purpose events:   3
> [    0.191447] ... event mask:             00000007000000ff
> [    0.191471] rcu: Hierarchical SRCU implementation.
> [    0.191727] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.191759] smp: Bringing up secondary CPUs ...
> [    0.191811] x86: Booting SMP configuration:
> [    0.191812] .... node  #0, CPUs:      #1 #2 #3
> [    0.192081] smp: Brought up 1 node, 4 CPUs
> [    0.192081] smpboot: Max logical packages: 1
> [    0.192081] smpboot: Total of 4 processors activated (26391.35 BogoMIPS)
> [    0.211906] node 0 deferred pages initialised in 20ms
> [    0.211909] devtmpfs: initialized
> [    0.211909] x86/mm: Memory block size: 128MB
> [    0.211909] PM: Registering ACPI NVS region [mem
> 0xa9b1c000-0xa9b22fff] (28672 bytes)
> [    0.211909] PM: Registering ACPI NVS region [mem
> 0xbd507000-0xbd63dfff] (1273856 bytes)
> [    0.211909] clocksource: jiffies: mask: 0xffffffff max_cycles:
> 0xffffffff, max_idle_ns: 7645041785100000 ns
> [    0.211909] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> [    0.211909] pinctrl core: initialized pinctrl subsystem
> [    0.211909] NET: Registered protocol family 16
> [    0.211909] audit: initializing netlink subsys (disabled)
> [    0.211909] audit: type=2000 audit(1629849114.148:1):
> state=initialized audit_enabled=0 res=1
> [    0.211909] thermal_sys: Registered thermal governor 'fair_share'
> [    0.211909] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.211909] thermal_sys: Registered thermal governor 'step_wise'
> [    0.211909] thermal_sys: Registered thermal governor 'user_space'
> [    0.211909] cpuidle: using governor ladder
> [    0.211909] cpuidle: using governor menu
> [    0.211909] ACPI FADT declares the system doesn't support PCIe
> ASPM, so disable it
> [    0.211909] ACPI: bus type PCI registered
> [    0.211909] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.211909] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem
> 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.211909] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> [    0.211909] pmd_set_huge: Cannot satisfy [mem
> 0xf0000000-0xf0200000] with a huge-page mapping due to MTRR override.
> [    0.211909] PCI: Using configuration type 1 for base access
> [    0.211909] core: PMU erratum BJ122, BV98, HSD29 workaround disabled, HT off
> [    0.213876] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.213876] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.326592] ACPI: Added _OSI(Module Device)
> [    0.326592] ACPI: Added _OSI(Processor Device)
> [    0.326592] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.326592] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.326592] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.326592] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.326592] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.338866] ACPI: 6 ACPI AML tables successfully acquired and loaded
> [    0.340672] ACPI: Dynamic OEM Table Load:
> [    0.340676] ACPI: SSDT 0xFFFF99FDC7413400 0003D3 (v01 PmRef
> Cpu0Cst  00003001 INTL 20051117)
> [    0.341388] ACPI: Dynamic OEM Table Load:
> [    0.341391] ACPI: SSDT 0xFFFF99FDC7FF4000 0005AA (v01 PmRef  ApIst
>   00003000 INTL 20051117)
> [    0.342139] ACPI: Dynamic OEM Table Load:
> [    0.342141] ACPI: SSDT 0xFFFF99FDC7586C00 000119 (v01 PmRef  ApCst
>   00003000 INTL 20051117)
> [    0.344025] ACPI: Interpreter enabled
> [    0.344050] ACPI: (supports S0 S3 S4 S5)
> [    0.344051] ACPI: Using IOAPIC for interrupt routing
> [    0.344101] PCI: Using host bridge windows from ACPI; if necessary,
> use "pci=nocrs" and report a bug
> [    0.344663] ACPI: Enabled 12 GPEs in block 00 to 3F
> [    0.345134] ACPI: Power Resource [PG00] (on)
> [    0.345417] ACPI: Power Resource [PG01] (on)
> [    0.345698] ACPI: Power Resource [PG02] (on)
> [    0.355203] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
> [    0.355207] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> ClockPM Segments MSI HPX-Type3]
> [    0.355388] acpi PNP0A08:00: _OSC: platform does not support
> [PCIeHotplug SHPCHotplug PME LTR]
> [    0.355503] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
> [    0.355504] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
> using BIOS configuration
> [    0.355793] PCI host bridge to bus 0000:00
> [    0.355795] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.355796] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.355796] pci_bus 0000:00: root bus resource [mem
> 0x000a0000-0x000bffff window]
> [    0.355797] pci_bus 0000:00: root bus resource [mem
> 0x000d0000-0x000d3fff window]
> [    0.355798] pci_bus 0000:00: root bus resource [mem
> 0x000d4000-0x000d7fff window]
> [    0.355798] pci_bus 0000:00: root bus resource [mem
> 0x000d8000-0x000dbfff window]
> [    0.355799] pci_bus 0000:00: root bus resource [mem
> 0x000dc000-0x000dffff window]
> [    0.355800] pci_bus 0000:00: root bus resource [mem
> 0x000e0000-0x000e3fff window]
> [    0.355800] pci_bus 0000:00: root bus resource [mem
> 0x000e4000-0x000e7fff window]
> [    0.355801] pci_bus 0000:00: root bus resource [mem
> 0xcf200000-0xfeafffff window]
> [    0.355802] pci_bus 0000:00: root bus resource [bus 00-7e]
> [    0.355810] pci 0000:00:00.0: [8086:0c00] type 00 class 0x060000
> [    0.355879] pci 0000:00:02.0: [8086:0412] type 00 class 0x030000
> [    0.355886] pci 0000:00:02.0: reg 0x10: [mem 0xef800000-0xefbfffff 64bit]
> [    0.355890] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff
> 64bit pref]
> [    0.355893] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> [    0.355966] pci 0000:00:03.0: [8086:0c0c] type 00 class 0x040300
> [    0.355972] pci 0000:00:03.0: reg 0x10: [mem 0xefc34000-0xefc37fff 64bit]
> [    0.356063] pci 0000:00:14.0: [8086:8cb1] type 00 class 0x0c0330
> [    0.356077] pci 0000:00:14.0: reg 0x10: [mem 0xefc20000-0xefc2ffff 64bit]
> [    0.356128] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.356196] pci 0000:00:16.0: [8086:8cba] type 00 class 0x078000
> [    0.356210] pci 0000:00:16.0: reg 0x10: [mem 0xefc3f000-0xefc3f00f 64bit]
> [    0.356264] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
> [    0.356347] pci 0000:00:19.0: [8086:15a1] type 00 class 0x020000
> [    0.356358] pci 0000:00:19.0: reg 0x10: [mem 0xefc00000-0xefc1ffff]
> [    0.356364] pci 0000:00:19.0: reg 0x14: [mem 0xefc3c000-0xefc3cfff]
> [    0.356370] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
> [    0.356419] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
> [    0.356487] pci 0000:00:1a.0: [8086:8cad] type 00 class 0x0c0320
> [    0.356501] pci 0000:00:1a.0: reg 0x10: [mem 0xefc3b000-0xefc3b3ff]
> [    0.356574] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
> [    0.356644] pci 0000:00:1b.0: [8086:8ca0] type 00 class 0x040300
> [    0.356657] pci 0000:00:1b.0: reg 0x10: [mem 0xefc30000-0xefc33fff 64bit]
> [    0.356719] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.356786] pci 0000:00:1c.0: [8086:8c90] type 01 class 0x060400
> [    0.356851] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.356958] pci 0000:00:1c.3: [8086:244e] type 01 class 0x060401
> [    0.357022] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
> [    0.357132] pci 0000:00:1d.0: [8086:8ca6] type 00 class 0x0c0320
> [    0.357146] pci 0000:00:1d.0: reg 0x10: [mem 0xefc3a000-0xefc3a3ff]
> [    0.357219] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.357291] pci 0000:00:1f.0: [8086:8cc6] type 00 class 0x060100
> [    0.357441] pci 0000:00:1f.2: [8086:8c82] type 00 class 0x010601
> [    0.357451] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
> [    0.357456] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
> [    0.357461] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
> [    0.357467] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
> [    0.357472] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
> [    0.357478] pci 0000:00:1f.2: reg 0x24: [mem 0xefc39000-0xefc397ff]
> [    0.357507] pci 0000:00:1f.2: PME# supported from D3hot
> [    0.357565] pci 0000:00:1f.3: [8086:8ca2] type 00 class 0x0c0500
> [    0.357580] pci 0000:00:1f.3: reg 0x10: [mem 0xefc38000-0xefc380ff 64bit]
> [    0.357597] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
> [    0.357721] acpiphp: Slot [1] registered
> [    0.357724] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.357799] pci 0000:02:00.0: [1b21:1080] type 01 class 0x060401
> [    0.357952] pci 0000:00:1c.3: PCI bridge to [bus 02-03] (subtractive decode)
> [    0.357959] pci 0000:00:1c.3:   bridge window [io  0x0000-0x0cf7
> window] (subtractive decode)
> [    0.357959] pci 0000:00:1c.3:   bridge window [io  0x0d00-0xffff
> window] (subtractive decode)
> [    0.357961] pci 0000:00:1c.3:   bridge window [mem
> 0x000a0000-0x000bffff window] (subtractive decode)
> [    0.357962] pci 0000:00:1c.3:   bridge window [mem
> 0x000d0000-0x000d3fff window] (subtractive decode)
> [    0.357962] pci 0000:00:1c.3:   bridge window [mem
> 0x000d4000-0x000d7fff window] (subtractive decode)
> [    0.357963] pci 0000:00:1c.3:   bridge window [mem
> 0x000d8000-0x000dbfff window] (subtractive decode)
> [    0.357964] pci 0000:00:1c.3:   bridge window [mem
> 0x000dc000-0x000dffff window] (subtractive decode)
> [    0.357964] pci 0000:00:1c.3:   bridge window [mem
> 0x000e0000-0x000e3fff window] (subtractive decode)
> [    0.357965] pci 0000:00:1c.3:   bridge window [mem
> 0x000e4000-0x000e7fff window] (subtractive decode)
> [    0.357966] pci 0000:00:1c.3:   bridge window [mem
> 0xcf200000-0xfeafffff window] (subtractive decode)
> [    0.357991] pci_bus 0000:03: extended config space not accessible
> [    0.358058] pci 0000:02:00.0: PCI bridge to [bus 03] (subtractive decode)
> [    0.358074] pci 0000:02:00.0:   bridge window [io  0x0000-0x0cf7
> window] (subtractive decode)
> [    0.358075] pci 0000:02:00.0:   bridge window [io  0x0d00-0xffff
> window] (subtractive decode)
> [    0.358076] pci 0000:02:00.0:   bridge window [mem
> 0x000a0000-0x000bffff window] (subtractive decode)
> [    0.358076] pci 0000:02:00.0:   bridge window [mem
> 0x000d0000-0x000d3fff window] (subtractive decode)
> [    0.358077] pci 0000:02:00.0:   bridge window [mem
> 0x000d4000-0x000d7fff window] (subtractive decode)
> [    0.358077] pci 0000:02:00.0:   bridge window [mem
> 0x000d8000-0x000dbfff window] (subtractive decode)
> [    0.358078] pci 0000:02:00.0:   bridge window [mem
> 0x000dc000-0x000dffff window] (subtractive decode)
> [    0.358079] pci 0000:02:00.0:   bridge window [mem
> 0x000e0000-0x000e3fff window] (subtractive decode)
> [    0.358079] pci 0000:02:00.0:   bridge window [mem
> 0x000e4000-0x000e7fff window] (subtractive decode)
> [    0.358080] pci 0000:02:00.0:   bridge window [mem
> 0xcf200000-0xfeafffff window] (subtractive decode)
> [    0.358770] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.358805] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12
> 14 15) *0, disabled.
> [    0.358839] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 10 11 12 14 15)
> [    0.358872] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.358905] ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 10 11 12 14 15)
> [    0.358938] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12
> 14 15) *0, disabled.
> [    0.358971] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.359004] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.359181] iommu: Default domain type: Translated
> [    0.359191] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.359191] pci 0000:00:02.0: vgaarb: VGA device added:
> decodes=io+mem,owns=io+mem,locks=none
> [    0.359191] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.359191] vgaarb: loaded
> [    0.359191] EDAC MC: Ver: 3.0.0
> [    0.359191] NetLabel: Initializing
> [    0.359191] NetLabel:  domain hash size = 128
> [    0.359191] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.359191] NetLabel:  unlabeled traffic allowed by default
> [    0.359191] PCI: Using ACPI for IRQ routing
> [    0.361966] PCI: pci_cache_line_size set to 64 bytes
> [    0.361995] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
> [    0.361996] e820: reserve RAM buffer [mem 0xa9b1c000-0xabffffff]
> [    0.361997] e820: reserve RAM buffer [mem 0xaa80a000-0xabffffff]
> [    0.361997] e820: reserve RAM buffer [mem 0xbd45a000-0xbfffffff]
> [    0.361998] e820: reserve RAM buffer [mem 0xbd507000-0xbfffffff]
> [    0.361999] e820: reserve RAM buffer [mem 0xbe000000-0xbfffffff]
> [    0.361999] e820: reserve RAM buffer [mem 0x42ee00000-0x42fffffff]
> [    0.362012] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> [    0.362014] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
> [    0.364030] clocksource: Switched to clocksource tsc-early
> [    0.369098] VFS: Disk quotas dquot_6.6.0
> [    0.369108] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.369190] AppArmor: AppArmor Filesystem Enabled
> [    0.369202] pnp: PnP ACPI init
> [    0.369314] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
> [    0.369318] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.369394] system 00:01: [io  0x0800-0x087f] has been reserved
> [    0.369396] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.369410] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.369434] system 00:03: [io  0x1854-0x1857] has been reserved
> [    0.369437] system 00:03: Plug and Play ACPI device, IDs INT3f0d
> PNP0c02 (active)
> [    0.369498] system 00:04: [io  0x0290-0x029f] has been reserved
> [    0.369500] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.369701] pnp 00:05: [dma 3]
> [    0.369764] pnp 00:05: Plug and Play ACPI device, IDs PNP0401 (active)
> [    0.369842] system 00:06: [io  0x04d0-0x04d1] has been reserved
> [    0.369844] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.369949] pnp 00:07: [dma 0 disabled]
> [    0.369974] pnp 00:07: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.370319] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.370320] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.370321] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.370321] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.370322] system 00:08: [mem 0xf0000000-0xf7ffffff] has been reserved
> [    0.370323] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.370324] system 00:08: [mem 0xfed90000-0xfed93fff] has been reserved
> [    0.370325] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.370326] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
> [    0.370327] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.370328] system 00:08: [mem 0xeffe0000-0xeffeffff] has been reserved
> [    0.370330] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.370459] pnp: PnP ACPI: found 9 devices
> [    0.375894] clocksource: acpi_pm: mask: 0xffffff max_cycles:
> 0xffffff, max_idle_ns: 2085701024 ns
> [    0.375930] NET: Registered protocol family 2
> [    0.376023] tcp_listen_portaddr_hash hash table entries: 8192
> (order: 5, 131072 bytes, linear)
> [    0.376087] TCP established hash table entries: 131072 (order: 8,
> 1048576 bytes, linear)
> [    0.376221] TCP bind hash table entries: 65536 (order: 8, 1048576
> bytes, linear)
> [    0.376278] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.376307] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.376340] UDP-Lite hash table entries: 8192 (order: 6, 262144
> bytes, linear)
> [    0.376382] NET: Registered protocol family 1
> [    0.376385] NET: Registered protocol family 44
> [    0.376392] pci 0000:00:1c.0: PCI bridge to [bus 01]
> [    0.376400] pci 0000:02:00.0: PCI bridge to [bus 03]
> [    0.376416] pci 0000:00:1c.3: PCI bridge to [bus 02-03]
> [    0.376424] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.376425] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.376426] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.376427] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000d3fff window]
> [    0.376427] pci_bus 0000:00: resource 8 [mem 0x000d4000-0x000d7fff window]
> [    0.376428] pci_bus 0000:00: resource 9 [mem 0x000d8000-0x000dbfff window]
> [    0.376429] pci_bus 0000:00: resource 10 [mem 0x000dc000-0x000dffff window]
> [    0.376429] pci_bus 0000:00: resource 11 [mem 0x000e0000-0x000e3fff window]
> [    0.376430] pci_bus 0000:00: resource 12 [mem 0x000e4000-0x000e7fff window]
> [    0.376431] pci_bus 0000:00: resource 13 [mem 0xcf200000-0xfeafffff window]
> [    0.376432] pci_bus 0000:02: resource 4 [io  0x0000-0x0cf7 window]
> [    0.376432] pci_bus 0000:02: resource 5 [io  0x0d00-0xffff window]
> [    0.376433] pci_bus 0000:02: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.376434] pci_bus 0000:02: resource 7 [mem 0x000d0000-0x000d3fff window]
> [    0.376434] pci_bus 0000:02: resource 8 [mem 0x000d4000-0x000d7fff window]
> [    0.376435] pci_bus 0000:02: resource 9 [mem 0x000d8000-0x000dbfff window]
> [    0.376436] pci_bus 0000:02: resource 10 [mem 0x000dc000-0x000dffff window]
> [    0.376436] pci_bus 0000:02: resource 11 [mem 0x000e0000-0x000e3fff window]
> [    0.376437] pci_bus 0000:02: resource 12 [mem 0x000e4000-0x000e7fff window]
> [    0.376438] pci_bus 0000:02: resource 13 [mem 0xcf200000-0xfeafffff window]
> [    0.376438] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7 window]
> [    0.376439] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff window]
> [    0.376440] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.376440] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x000d3fff window]
> [    0.376441] pci_bus 0000:03: resource 8 [mem 0x000d4000-0x000d7fff window]
> [    0.376442] pci_bus 0000:03: resource 9 [mem 0x000d8000-0x000dbfff window]
> [    0.376442] pci_bus 0000:03: resource 10 [mem 0x000dc000-0x000dffff window]
> [    0.376443] pci_bus 0000:03: resource 11 [mem 0x000e0000-0x000e3fff window]
> [    0.376444] pci_bus 0000:03: resource 12 [mem 0x000e4000-0x000e7fff window]
> [    0.376444] pci_bus 0000:03: resource 13 [mem 0xcf200000-0xfeafffff window]
> [    0.376523] pci 0000:00:02.0: Video device with shadowed ROM at
> [mem 0x000c0000-0x000dffff]
> [    0.399190] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x6b0
> took 21991 usecs
> [    0.419182] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x6b0
> took 19514 usecs
> [    0.419190] pci 0000:02:00.0: Disabling ASPM L0s/L1
> [    0.419193] PCI: CLS 64 bytes, default 64
> [    0.419220] Trying to unpack rootfs image as initramfs...
> [    0.896069] Freeing initrd memory: 40552K
> [    0.896086] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.896087] software IO TLB: mapped [mem 0xb945a000-0xbd45a000] (64MB)
> [    0.896383] Initialise system trusted keyrings
> [    0.896388] Key type blacklist registered
> [    0.896418] workingset: timestamp_bits=40 max_order=22 bucket_order=0
> [    0.897185] zbud: loaded
> [    0.897281] integrity: Platform Keyring initialized
> [    0.897282] Key type asymmetric registered
> [    0.897283] Asymmetric key parser 'x509' registered
> [    0.897288] Block layer SCSI generic (bsg) driver version 0.4
> loaded (major 251)
> [    0.897322] io scheduler mq-deadline registered
> [    0.897619] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    0.897627] intel_idle: MWAIT substates: 0x42120
> [    0.897627] intel_idle: v0.5.1 model 0x3C
> [    0.897736] intel_idle: Local APIC timer is reliable in all C-states
> [    0.897962] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    0.898096] 00:07: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200)
> is a 16550A
> [    0.899302] Linux agpgart interface v0.103
> [    0.899322] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    0.899323] AMD-Vi: AMD IOMMUv2 functionality not available on this system
> [    0.899611] i8042: PNP: No PS/2 controller found.
> [    0.899663] mousedev: PS/2 mouse device common for all mice
> [    0.899682] rtc_cmos 00:02: RTC can wake from S4
> [    0.899825] rtc_cmos 00:02: registered as rtc0
> [    0.899861] rtc_cmos 00:02: setting system clock to
> 2021-08-24T23:51:55 UTC (1629849115)
> [    0.899870] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes
> nvram, hpet irqs
> [    0.899876] intel_pstate: Intel P-state driver initializing
> [    0.900124] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.900773] NET: Registered protocol family 10
> [    0.905965] Segment Routing with IPv6
> [    0.905977] mip6: Mobile IPv6
> [    0.905978] NET: Registered protocol family 17
> [    0.906117] mpls_gso: MPLS GSO support
> [    0.906418] microcode: sig=0x306c3, pf=0x2, revision=0x19
> [    0.906474] microcode: Microcode Update Driver: v2.2.
> [    0.906476] IPI shorthand broadcast: enabled
> [    0.906479] sched_clock: Marking stable (904574708,
> 1761390)->(912058891, -5722793)
> [    0.906632] registered taskstats version 1
> [    0.906634] Loading compiled-in X.509 certificates
> [    0.930743] Loaded X.509 cert 'Debian Secure Boot CA:
> 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
> [    0.930763] Loaded X.509 cert 'Debian Secure Boot Signer 2020: 00b55eb3b9'
> [    0.930777] zswap: loaded using pool lzo/zbud
> [    0.931143] Key type ._fscrypt registered
> [    0.931144] Key type .fscrypt registered
> [    0.931144] Key type fscrypt-provisioning registered
> [    0.931185] AppArmor: AppArmor sha1 policy hashing enabled
> [    0.932177] Freeing unused kernel image (initmem) memory: 1636K
> [    0.947130] Write protecting the kernel read-only data: 18432k
> [    0.947507] Freeing unused kernel image (text/rodata gap) memory: 2044K
> [    0.947586] Freeing unused kernel image (rodata/data gap) memory: 288K
> [    0.984876] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    0.984877] x86/mm: Checking user space page tables
> [    1.019384] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.019403] Run /init as init process
> [    1.019404]   with arguments:
> [    1.019405]     /init
> [    1.019405]   with environment:
> [    1.019405]     HOME=/
> [    1.019405]     TERM=linux
> [    1.019406]     BOOT_IMAGE=/boot/vmlinuz-5.9.0-5-amd64
> [    1.056366] input: Power Button as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    1.056383] ACPI: Power Button [PWRB]
> [    1.056418] input: Sleep Button as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> [    1.056432] ACPI: Sleep Button [SLPB]
> [    1.056454] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    1.068072] pps_core: LinuxPPS API ver. 1 registered
> [    1.068073] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
> Rodolfo Giometti <giometti@linux.it>
> [    1.068938] PTP clock support registered
> [    1.069650] ACPI: Power Button [PWRF]
> [    1.075816] ACPI: bus type USB registered
> [    1.075827] usbcore: registered new interface driver usbfs
> [    1.075832] usbcore: registered new interface driver hub
> [    1.075841] usbcore: registered new device driver usb
> [    1.078568] e1000e: Intel(R) PRO/1000 Network Driver
> [    1.078568] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.078702] e1000e 0000:00:19.0: Interrupt Throttling Rate
> (ints/sec) set to dynamic conservative mode
> [    1.081872] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.083200] ehci-pci: EHCI PCI platform driver
> [    1.083301] ehci-pci 0000:00:1a.0: EHCI Host Controller
> [    1.083305] ehci-pci 0000:00:1a.0: new USB bus registered, assigned
> bus number 1
> [    1.083314] ehci-pci 0000:00:1a.0: debug port 2
> [    1.083320] ACPI Warning: SystemIO range
> 0x0000000000001828-0x000000000000182F conflicts with OpRegion
> 0x0000000000001800-0x000000000000187F (\PMIO) (20200717/utaddress-204)
> [    1.083323] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
> [    1.083325] ACPI Warning: SystemIO range
> 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001FFF (\GPR2) (20200717/utaddress-204)
> [    1.083327] ACPI Warning: SystemIO range
> 0x0000000000001C40-0x0000000000001C4F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001FFF (\GPR) (20200717/utaddress-204)
> [    1.083328] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
> [    1.083329] ACPI Warning: SystemIO range
> 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001FFF (\GPR2) (20200717/utaddress-204)
> [    1.083330] ACPI Warning: SystemIO range
> 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20200717/utaddress-204)
> [    1.083331] ACPI Warning: SystemIO range
> 0x0000000000001C30-0x0000000000001C3F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001FFF (\GPR) (20200717/utaddress-204)
> [    1.083332] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
> [    1.083333] ACPI Warning: SystemIO range
> 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001FFF (\GPR2) (20200717/utaddress-204)
> [    1.083334] ACPI Warning: SystemIO range
> 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001C3F (\GPRL) (20200717/utaddress-204)
> [    1.083335] ACPI Warning: SystemIO range
> 0x0000000000001C00-0x0000000000001C2F conflicts with OpRegion
> 0x0000000000001C00-0x0000000000001FFF (\GPR) (20200717/utaddress-204)
> [    1.083336] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
> [    1.083337] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [    1.087221] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
> [    1.087231] ehci-pci 0000:00:1a.0: irq 16, io mem 0xefc3b000
> [    1.090692] SCSI subsystem initialized
> [    1.090726] i801_smbus 0000:00:1f.3: SPD Write Disable is set
> [    1.090743] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
> [    1.091614] i2c i2c-0: 4/4 memory slots populated (from DMI)
> [    1.093542] i2c i2c-0: Successfully instantiated SPD at 0x50
> [    1.096709] i2c i2c-0: Successfully instantiated SPD at 0x51
> [    1.099501] i2c i2c-0: Successfully instantiated SPD at 0x52
> [    1.099783] i2c i2c-0: Successfully instantiated SPD at 0x53
> [    1.101580] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
> [    1.101620] usb usb1: New USB device found, idVendor=1d6b,
> idProduct=0002, bcdDevice= 5.09
> [    1.101621] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.101621] usb usb1: Product: EHCI Host Controller
> [    1.101622] usb usb1: Manufacturer: Linux 5.9.0-5-amd64 ehci_hcd
> [    1.101623] usb usb1: SerialNumber: 0000:00:1a.0
> [    1.101706] hub 1-0:1.0: USB hub found
> [    1.101713] hub 1-0:1.0: 2 ports detected
> [    1.101835] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.101839] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
> bus number 2
> [    1.102537] libata version 3.00 loaded.
> [    1.102883] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
> version 0x100 quirks 0x0000000000009810
> [    1.102886] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [    1.102992] usb usb2: New USB device found, idVendor=1d6b,
> idProduct=0002, bcdDevice= 5.09
> [    1.102993] usb usb2: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.102994] usb usb2: Product: xHCI Host Controller
> [    1.102994] usb usb2: Manufacturer: Linux 5.9.0-5-amd64 xhci-hcd
> [    1.102995] usb usb2: SerialNumber: 0000:00:14.0
> [    1.103143] hub 2-0:1.0: USB hub found
> [    1.103157] hub 2-0:1.0: 14 ports detected
> [    1.105088] ehci-pci 0000:00:1d.0: EHCI Host Controller
> [    1.105091] ehci-pci 0000:00:1d.0: new USB bus registered, assigned
> bus number 3
> [    1.105105] ehci-pci 0000:00:1d.0: debug port 2
> [    1.105115] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    1.105117] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
> bus number 4
> [    1.105119] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    1.105145] usb usb4: New USB device found, idVendor=1d6b,
> idProduct=0003, bcdDevice= 5.09
> [    1.105145] usb usb4: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.105146] usb usb4: Product: xHCI Host Controller
> [    1.105147] usb usb4: Manufacturer: Linux 5.9.0-5-amd64 xhci-hcd
> [    1.105147] usb usb4: SerialNumber: 0000:00:14.0
> [    1.105205] ahci 0000:00:1f.2: version 3.0
> [    1.105208] hub 4-0:1.0: USB hub found
> [    1.105221] hub 4-0:1.0: 6 ports detected
> [    1.105907] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6
> Gbps 0x3f impl SATA mode
> [    1.105908] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum
> part ems apst
> [    1.109013] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
> [    1.109020] ehci-pci 0000:00:1d.0: irq 23, io mem 0xefc3a000
> [    1.121610] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
> [    1.121655] usb usb3: New USB device found, idVendor=1d6b,
> idProduct=0002, bcdDevice= 5.09
> [    1.121656] usb usb3: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    1.121657] usb usb3: Product: EHCI Host Controller
> [    1.121658] usb usb3: Manufacturer: Linux 5.9.0-5-amd64 ehci_hcd
> [    1.121658] usb usb3: SerialNumber: 0000:00:1d.0
> [    1.121802] hub 3-0:1.0: USB hub found
> [    1.121805] hub 3-0:1.0: 2 ports detected
> [    1.154652] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized):
> registered PHC clock
> [    1.166240] scsi host0: ahci
> [    1.166353] scsi host1: ahci
> [    1.166510] scsi host2: ahci
> [    1.166611] scsi host3: ahci
> [    1.166755] scsi host4: ahci
> [    1.169369] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    1.169666] scsi host5: ahci
> [    1.169706] ata1: SATA max UDMA/133 abar m2048@0xefc39000 port
> 0xefc39100 irq 28
> [    1.169708] ata2: SATA max UDMA/133 abar m2048@0xefc39000 port
> 0xefc39180 irq 28
> [    1.169709] ata3: SATA max UDMA/133 abar m2048@0xefc39000 port
> 0xefc39200 irq 28
> [    1.169710] ata4: SATA max UDMA/133 abar m2048@0xefc39000 port
> 0xefc39280 irq 28
> [    1.169711] ata5: SATA max UDMA/133 abar m2048@0xefc39000 port
> 0xefc39300 irq 28
> [    1.169712] ata6: SATA max UDMA/133 abar m2048@0xefc39000 port
> 0xefc39380 irq 28
> [    1.170400] Console: switching to colour dummy device 80x25
> [    1.171377] i915 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    1.184526] [drm] Initialized i915 1.6.0 20200715 for 0000:00:02.0 on minor 0
> [    1.185734] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    1.185918] input: Video Bus as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
> [    1.198896] fbcon: i915drmfb (fb0) is primary device
> [    1.221166] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width
> x1) d0:50:99:80:a0:ae
> [    1.221167] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
> [    1.221192] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0FF
> [    1.221908] e1000e 0000:00:19.0 enp0s25: renamed from eth0
> [    1.272818] Console: switching to colour frame buffer device 128x48
> [    1.290620] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
> [    1.437636] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [    1.437639] usb 2-11: new high-speed USB device number 2 using xhci_hcd
> [    1.461636] usb 3-1: new high-speed USB device number 2 using ehci-pci
> [    1.484344] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.484626] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.484647] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.484665] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.484765] ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.484984] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.485153] ata3.00: supports DRM functions and may not be fully accessible
> [    1.485162] ata3.00: ATA-8: ST33000651NS, G009, max UDMA/133
> [    1.485165] ata3.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32)
> [    1.485437] ata3.00: ATA Identify Device Log not supported
> [    1.485439] ata3.00: Security Log not supported
> [    1.487878] ata3.00: supports DRM functions and may not be fully accessible
> [    1.487889] ata5.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
> [    1.487894] ata5.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
> LOCK) filtered out
> [    1.487897] ata5.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
> CONFIGURATION OVERLAY) filtered out
> [    1.488053] ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
> [    1.488057] ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
> LOCK) filtered out
> [    1.488059] ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
> CONFIGURATION OVERLAY) filtered out
> [    1.488069] ata2.00: ATA-8: Hitachi HDS5C4040ALE630, MPAOA3B0, max UDMA/133
> [    1.488072] ata2.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.488193] ata3.00: ATA Identify Device Log not supported
> [    1.488195] ata3.00: Security Log not supported
> [    1.488202] ata3.00: configured for UDMA/133
> [    1.489507] ata5.00: ATA-8: Hitachi HUA723030ALA640, MKAOAA10, max UDMA/133
> [    1.489511] ata5.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.489970] ata1.00: ATA-9: HP SSD M700 120GB, Q1107A1, max UDMA/133
> [    1.489973] ata1.00: 234441648 sectors, multi 1: LBA48 NCQ (depth 32), AA
> [    1.489990] ata2.00: configured for UDMA/133
> [    1.490058] ata6.00: ATA-8: Hitachi HUS724030ALE641, MJ8OA5F0, max UDMA/133
> [    1.490061] ata6.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.492413] ata4.00: ATA-9: WDC WD120EMAZ-11BLFA0, 81.00A81, max UDMA/133
> [    1.492417] ata4.00: 23437770752 sectors, multi 16: LBA48 NCQ (depth 32), AA
> [    1.492426] ata5.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
> [    1.492430] ata5.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
> LOCK) filtered out
> [    1.492433] ata5.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
> CONFIGURATION OVERLAY) filtered out
> [    1.492581] ata6.00: ACPI cmd ef/10:06:00:00:00:00 (SET FEATURES) succeeded
> [    1.492585] ata6.00: ACPI cmd f5/00:00:00:00:00:00 (SECURITY FREEZE
> LOCK) filtered out
> [    1.492588] ata6.00: ACPI cmd b1/c1:00:00:00:00:00 (DEVICE
> CONFIGURATION OVERLAY) filtered out
> [    1.494047] ata5.00: configured for UDMA/133
> [    1.494616] ata6.00: configured for UDMA/133
> [    1.498279] ata1.00: configured for UDMA/133
> [    1.498467] scsi 0:0:0:0: Direct-Access     ATA      HP SSD M700
> 120G 7A1  PQ: 0 ANSI: 5
> [    1.498904] scsi 1:0:0:0: Direct-Access     ATA      Hitachi
> HDS5C404 A3B0 PQ: 0 ANSI: 5
> [    1.499125] scsi 2:0:0:0: Direct-Access     ATA      ST33000651NS
>   G009 PQ: 0 ANSI: 5
> [    1.504493] ata4.00: configured for UDMA/133
> [    1.504594] scsi 3:0:0:0: Direct-Access     ATA      WDC
> WD120EMAZ-11 0A81 PQ: 0 ANSI: 5
> [    1.504802] scsi 4:0:0:0: Direct-Access     ATA      Hitachi
> HUA72303 AA10 PQ: 0 ANSI: 5
> [    1.504984] scsi 5:0:0:0: Direct-Access     ATA      Hitachi
> HUS72403 A5F0 PQ: 0 ANSI: 5
> [    1.511872] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks:
> (120 GB/112 GiB)
> [    1.511873] sd 0:0:0:0: [sda] 4096-byte physical blocks
> [    1.511878] sd 0:0:0:0: [sda] Write Protect is off
> [    1.511879] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.511883] sd 1:0:0:0: [sdb] 7814037168 512-byte logical blocks:
> (4.00 TB/3.64 TiB)
> [    1.511884] sd 1:0:0:0: [sdb] 4096-byte physical blocks
> [    1.511886] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.511887] sd 1:0:0:0: [sdb] Write Protect is off
> [    1.511888] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.511894] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.511924] sd 2:0:0:0: [sdc] 5860533168 512-byte logical blocks:
> (3.00 TB/2.73 TiB)
> [    1.511928] sd 2:0:0:0: [sdc] Write Protect is off
> [    1.511929] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [    1.511936] sd 2:0:0:0: [sdc] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.511948] sd 5:0:0:0: [sdf] 5860533168 512-byte logical blocks:
> (3.00 TB/2.73 TiB)
> [    1.511949] sd 5:0:0:0: [sdf] 4096-byte physical blocks
> [    1.511952] sd 5:0:0:0: [sdf] Write Protect is off
> [    1.511953] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
> [    1.511956] sd 3:0:0:0: [sdd] 23437770752 512-byte logical blocks:
> (12.0 TB/10.9 TiB)
> [    1.511957] sd 3:0:0:0: [sdd] 4096-byte physical blocks
> [    1.511958] sd 4:0:0:0: [sde] 5860533168 512-byte logical blocks:
> (3.00 TB/2.73 TiB)
> [    1.511960] sd 5:0:0:0: [sdf] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.511960] sd 3:0:0:0: [sdd] Write Protect is off
> [    1.511961] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
> [    1.511962] sd 4:0:0:0: [sde] Write Protect is off
> [    1.511963] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
> [    1.511968] sd 3:0:0:0: [sdd] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.511970] sd 4:0:0:0: [sde] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> [    1.538530]  sda: sda1 sda2 < sda5 >
> [    1.538751] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.550873] sd 4:0:0:0: [sde] Attached SCSI disk
> [    1.555572] sd 2:0:0:0: [sdc] Attached SCSI disk
> [    1.560888] sd 3:0:0:0: [sdd] Attached SCSI disk
> [    1.561016] sd 5:0:0:0: [sdf] Attached SCSI disk
> [    1.563985] sd 1:0:0:0: [sdb] Attached SCSI disk
> [    1.593943] usb 1-1: New USB device found, idVendor=8087,
> idProduct=8009, bcdDevice= 0.00
> [    1.593944] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.594199] hub 1-1:1.0: USB hub found
> [    1.594284] hub 1-1:1.0: 6 ports detected
> [    1.603142] usb 2-11: New USB device found, idVendor=1058,
> idProduct=25fb, bcdDevice=30.05
> [    1.603143] usb 2-11: New USB device strings: Mfr=2, Product=3,
> SerialNumber=1
> [    1.603144] usb 2-11: Product: easystore 25FB
> [    1.603145] usb 2-11: Manufacturer: Western Digital
> [    1.603145] usb 2-11: SerialNumber: 4A4547545A30374E
> [    1.606740] usb-storage 2-11:1.0: USB Mass Storage device detected
> [    1.606877] scsi host6: usb-storage 2-11:1.0
> [    1.606937] usbcore: registered new interface driver usb-storage
> [    1.608012] usbcore: registered new interface driver uas
> [    1.617924] usb 3-1: New USB device found, idVendor=8087,
> idProduct=8001, bcdDevice= 0.00
> [    1.617925] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    1.618230] hub 3-1:1.0: USB hub found
> [    1.618295] hub 3-1:1.0: 8 ports detected
> [    1.729579] usb 2-12: new full-speed USB device number 3 using xhci_hcd
> [    1.878710] usb 2-12: New USB device found, idVendor=0c45,
> idProduct=5004, bcdDevice= 1.05
> [    1.878711] usb 2-12: New USB device strings: Mfr=1, Product=2,
> SerialNumber=0
> [    1.878712] usb 2-12: Product: USB DEVICE
> [    1.878713] usb 2-12: Manufacturer: SONiX
> [    1.883721] hid: raw HID events driver (C) Jiri Kosina
> [    1.886439] usbcore: registered new interface driver usbhid
> [    1.886439] usbhid: USB HID core driver
> [    1.887456] input: SONiX USB DEVICE as
> /devices/pci0000:00/0000:00:14.0/usb2/2-12/2-12:1.0/0003:0C45:5004.0001/input/input4
> [    1.917574] raid6: avx2x4   gen() 31784 MB/s
> [    1.945762] hid-generic 0003:0C45:5004.0001: input,hidraw0: USB HID
> v1.11 Keyboard [SONiX USB DEVICE] on usb-0000:00:14.0-12/input0
> [    1.946206] input: SONiX USB DEVICE Keyboard as
> /devices/pci0000:00/0000:00:14.0/usb2/2-12/2-12:1.1/0003:0C45:5004.0002/input/input5
> [    1.985573] raid6: avx2x4   xor() 12097 MB/s
> [    2.005640] input: SONiX USB DEVICE System Control as
> /devices/pci0000:00/0000:00:14.0/usb2/2-12/2-12:1.1/0003:0C45:5004.0002/input/input6
> [    2.005673] input: SONiX USB DEVICE Consumer Control as
> /devices/pci0000:00/0000:00:14.0/usb2/2-12/2-12:1.1/0003:0C45:5004.0002/input/input7
> [    2.005686] input: SONiX USB DEVICE as
> /devices/pci0000:00/0000:00:14.0/usb2/2-12/2-12:1.1/0003:0C45:5004.0002/input/input8
> [    2.005860] hid-generic 0003:0C45:5004.0002: input,hiddev0,hidraw1:
> USB HID v1.11 Keyboard [SONiX USB DEVICE] on
> usb-0000:00:14.0-12/input1
> [    2.053573] raid6: avx2x2   gen() 34109 MB/s
> [    2.121573] raid6: avx2x2   xor() 20540 MB/s
> [    2.189573] raid6: avx2x1   gen() 27881 MB/s
> [    2.257573] raid6: avx2x1   xor() 18784 MB/s
> [    2.325573] raid6: sse2x4   gen() 17787 MB/s
> [    2.393574] raid6: sse2x4   xor()  6682 MB/s
> [    2.461573] raid6: sse2x2   gen() 19040 MB/s
> [    2.529574] raid6: sse2x2   xor() 11871 MB/s
> [    2.597573] raid6: sse2x1   gen() 14804 MB/s
> [    2.665574] raid6: sse2x1   xor() 10690 MB/s
> [    2.665574] raid6: using algorithm avx2x2 gen() 34109 MB/s
> [    2.665575] raid6: .... xor() 20540 MB/s, rmw enabled
> [    2.665575] raid6: using avx2x2 recovery algorithm
> [    2.665595] tsc: Refined TSC clocksource calibration: 3299.042 MHz
> [    2.665597] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
> 0x2f8dc3bba88, max_idle_ns: 440795361811 ns
> [    2.665609] clocksource: Switched to clocksource tsc
> [    2.666320] scsi 6:0:0:0: Direct-Access     WD       easystore 25FB
>   3005 PQ: 0 ANSI: 6
> [    2.666823] scsi 6:0:0:1: Enclosure         WD       SES Device
>   3005 PQ: 0 ANSI: 6
> [    2.669893] xor: automatically using best checksumming function   avx
> [    2.670023] sd 6:0:0:0: [sdg] Spinning up disk...
> [    2.672367] scsi 6:0:0:1: Wrong diagnostic page; asked for 1 got 8
> [    2.672389] scsi 6:0:0:1: Failed to get diagnostic page 0x1
> [    2.672405] scsi 6:0:0:1: Failed to bind enclosure -19
> [    2.714369] Btrfs loaded, crc32c=crc32c-intel
> [    2.776095] BTRFS: device label Media devid 3 transid 3072649
> /dev/sdb scanned by btrfs (190)
> [    2.776330] BTRFS: device label Media devid 5 transid 3072649
> /dev/sdf scanned by btrfs (190)
> [    2.777188] BTRFS: device label Media devid 2 transid 3072649
> /dev/sdc scanned by btrfs (190)
> [    2.777588] BTRFS: device label Media devid 1 transid 3072649
> /dev/sdd scanned by btrfs (190)
> [    2.778424] BTRFS: device label Media devid 4 transid 3072649
> /dev/sde scanned by btrfs (190)
> [    3.705581] .........
> [   12.801567] PM: Image not found (code -22)
> [   12.921612] .ready
> [   13.082349] sd 6:0:0:0: [sdg] Very big device. Trying to use READ
> CAPACITY(16).
> [   13.082700] sd 6:0:0:0: [sdg] 19532873728 512-byte logical blocks:
> (10.0 TB/9.10 TiB)
> [   13.082701] sd 6:0:0:0: [sdg] 4096-byte physical blocks
> [   13.083064] sd 6:0:0:0: [sdg] Write Protect is off
> [   13.083065] sd 6:0:0:0: [sdg] Mode Sense: 47 00 10 08
> [   13.083408] sd 6:0:0:0: [sdg] No Caching mode page found
> [   13.083424] sd 6:0:0:0: [sdg] Assuming drive cache: write through
> [   14.363169] sd 6:0:0:0: [sdg] Attached SCSI disk
> [   14.363208] ses 6:0:0:1: Attached Enclosure device
> [   15.498619] EXT4-fs (sda1): mounted filesystem with ordered data
> mode. Opts: (null)
> [   15.531966] Not activating Mandatory Access Control as
> /sbin/tomoyo-init does not exist.
> [   15.608707] systemd[1]: Inserted module 'autofs4'
> [   15.620788] systemd[1]: systemd 247.1-3+deb11u1 running in system
> mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
> +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID
> +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [   15.637656] systemd[1]: Detected architecture x86-64.
> [   15.665954] systemd[1]: Set hostname to <KoolKidsKlub>.
> [   15.689435] systemd-sysv-generator[244]: SysV service
> '/etc/init.d/php7-fpm' lacks a native systemd unit file. Automatically
> generating a unit file for compatibility. Please update package to
> include a native systemd unit file, in order to make it more safe and
> robust.
> [   15.726008] systemd[1]: /lib/systemd/system/docker.socket:5:
> ListenStream= references a path below legacy directory /var/run/,
> updating /var/run/docker.sock → /run/docker.sock; please update the
> unit file accordingly.
> [   15.745553] systemd[1]:
> /lib/systemd/system/plymouth-start.service:16: Unit configured to use
> KillMode=none. This is unsafe, as it disables systemd's process
> lifecycle management for the service. Please update your service to
> use a safer KillMode=, such as 'mixed' or 'control-group'. Support for
> KillMode=none is deprecated and will eventually be removed.
> [   15.760553] systemd[1]: Queued start job for default target
> Graphical Interface.
> [   15.765508] systemd[1]: Created slice system-getty.slice.
> [   15.765840] systemd[1]: Created slice system-modprobe.slice.
> [   15.766059] systemd[1]: Created slice User and Session Slice.
> [   15.766114] systemd[1]: Started Forward Password Requests to Wall
> Directory Watch.
> [   15.766211] systemd[1]: Set up automount Arbitrary Executable File
> Formats File System Automount Point.
> [   15.766247] systemd[1]: Reached target Remote File Systems.
> [   15.766254] systemd[1]: Reached target Slices.
> [   15.766440] systemd[1]: Listening on Syslog Socket.
> [   15.766497] systemd[1]: Listening on fsck to fsckd communication Socket.
> [   15.766527] systemd[1]: Listening on initctl Compatibility Named Pipe.
> [   15.766616] systemd[1]: Listening on Journal Audit Socket.
> [   15.766666] systemd[1]: Listening on Journal Socket (/dev/log).
> [   15.766727] systemd[1]: Listening on Journal Socket.
> [   15.767145] systemd[1]: Listening on udev Control Socket.
> [   15.767197] systemd[1]: Listening on udev Kernel Socket.
> [   15.767756] systemd[1]: Mounting Huge Pages File System...
> [   15.768329] systemd[1]: Mounting POSIX Message Queue File System...
> [   15.768892] systemd[1]: Mounting Kernel Debug File System...
> [   15.769460] systemd[1]: Mounting Kernel Trace File System...
> [   15.770282] systemd[1]: Starting Set the console keyboard layout...
> [   15.770877] systemd[1]: Starting Create list of static device nodes
> for the current kernel...
> [   15.771427] systemd[1]: Starting Load Kernel Module configfs...
> [   15.771919] systemd[1]: Starting Load Kernel Module drm...
> [   15.772388] systemd[1]: Starting Load Kernel Module fuse...
> [   15.774207] systemd[1]: Condition check resulted in Set Up
> Additional Binary Formats being skipped.
> [   15.774231] systemd[1]: Condition check resulted in File System
> Check on Root Device being skipped.
> [   15.775136] systemd[1]: Starting Journal Service...
> [   15.778026] systemd[1]: Starting Load Kernel Modules...
> [   15.778628] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   15.779176] systemd[1]: Starting Coldplug All udev Devices...
> [   15.780206] systemd[1]: Mounted Huge Pages File System.
> [   15.780328] systemd[1]: Mounted POSIX Message Queue File System.
> [   15.780418] systemd[1]: Mounted Kernel Debug File System.
> [   15.780502] systemd[1]: Mounted Kernel Trace File System.
> [   15.780880] systemd[1]: Finished Create list of static device nodes
> for the current kernel.
> [   15.781075] systemd[1]: modprobe@drm.service: Succeeded.
> [   15.781270] systemd[1]: Finished Load Kernel Module drm.
> [   15.785297] systemd[1]: modprobe@configfs.service: Succeeded.
> [   15.785524] systemd[1]: Finished Load Kernel Module configfs.
> [   15.786221] systemd[1]: Mounting Kernel Configuration File System...
> [   15.787884] systemd[1]: Mounted Kernel Configuration File System.
> [   15.788819] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
> [   15.789669] systemd[1]: Finished Remount Root and Kernel File Systems.
> [   15.789916] fuse: init (API version 7.31)
> [   15.792354] systemd[1]: Condition check resulted in Rebuild
> Hardware Database being skipped.
> [   15.792383] systemd[1]: Condition check resulted in Platform
> Persistent Storage Archival being skipped.
> [   15.792979] systemd[1]: Starting Load/Save Random Seed...
> [   15.793604] systemd[1]: Starting Create System Users...
> [   15.793825] systemd[1]: modprobe@fuse.service: Succeeded.
> [   15.794057] systemd[1]: Finished Load Kernel Module fuse.
> [   15.794748] systemd[1]: Mounting FUSE Control File System...
> [   15.799025] systemd[1]: Mounted FUSE Control File System.
> [   15.799439] lp: driver loaded but no devices found
> [   15.802585] ppdev: user-space parallel port driver
> [   15.804616] systemd[1]: Finished Create System Users.
> [   15.805290] systemd[1]: Starting Create Static Device Nodes in /dev...
> [   15.805792] parport_pc 00:05: reported by Plug and Play ACPI
> [   15.805844] parport0: PC-style at 0x378 (0x778), irq 5 [PCSPP,TRISTATE,EPP]
> [   15.806421] systemd[1]: Finished Load/Save Random Seed.
> [   15.806549] systemd[1]: Condition check resulted in First Boot
> Complete being skipped.
> [   15.823183] systemd[1]: Finished Create Static Device Nodes in /dev.
> [   15.824141] systemd[1]: Starting Rule-based Manager for Device
> Events and Files...
> [   15.833919] systemd[1]: Started Journal Service.
> [   15.909671] lp0: using parport0 (interrupt-driven).
> [   16.046551] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [   16.046574] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [   16.046657] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [   16.046683] sd 3:0:0:0: Attached scsi generic sg3 type 0
> [   16.046703] sd 4:0:0:0: Attached scsi generic sg4 type 0
> [   16.046772] sd 5:0:0:0: Attached scsi generic sg5 type 0
> [   16.046797] sd 6:0:0:0: Attached scsi generic sg6 type 0
> [   16.046827] ses 6:0:0:1: Attached scsi generic sg7 type 13
> [   16.047119] at24 0-0050: supply vcc not found, using dummy regulator
> [   16.047672] at24 0-0050: 256 byte spd EEPROM, read-only
> [   16.047687] at24 0-0051: supply vcc not found, using dummy regulator
> [   16.048214] iTCO_vendor_support: vendor-support=0
> [   16.048284] at24 0-0051: 256 byte spd EEPROM, read-only
> [   16.048299] at24 0-0052: supply vcc not found, using dummy regulator
> [   16.051304] at24 0-0052: 256 byte spd EEPROM, read-only
> [   16.051322] at24 0-0053: supply vcc not found, using dummy regulator
> [   16.055439] at24 0-0053: 256 byte spd EEPROM, read-only
> [   16.059334] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
> [   16.059364] iTCO_wdt: Found a 9 Series TCO device (Version=2, TCOBASE=0x1860)
> [   16.061344] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
> [   16.086007] input: PC Speaker as /devices/platform/pcspkr/input/input9
> [   16.106923] BTRFS: device label Media devid 6 transid 3072649
> /dev/sdg scanned by systemd-udevd (301)
> [   16.120175] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops
> i915_audio_component_bind_ops [i915])
> [   16.122014] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters,
> 655360 ms ovfl timer
> [   16.122015] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [   16.122015] RAPL PMU: hw unit of domain package 2^-14 Joules
> [   16.122016] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [   16.122016] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [   16.128504] cryptd: max_cpu_qlen set to 1000
> [   16.150809] input: HDA Intel HDMI HDMI/DP,pcm=3 as
> /devices/pci0000:00/0000:00:03.0/sound/card0/input10
> [   16.150843] input: HDA Intel HDMI HDMI/DP,pcm=7 as
> /devices/pci0000:00/0000:00:03.0/sound/card0/input11
> [   16.150871] input: HDA Intel HDMI HDMI/DP,pcm=8 as
> /devices/pci0000:00/0000:00:03.0/sound/card0/input12
> [   16.150896] input: HDA Intel HDMI HDMI/DP,pcm=9 as
> /devices/pci0000:00/0000:00:03.0/sound/card0/input13
> [   16.150922] input: HDA Intel HDMI HDMI/DP,pcm=10 as
> /devices/pci0000:00/0000:00:03.0/sound/card0/input14
> [   16.166219] AVX2 version of gcm_enc/dec engaged.
> [   16.166220] AES CTR mode by8 optimization enabled
> [   16.175219] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
> ALC892: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
> [   16.175220] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0
> (0x0/0x0/0x0/0x0/0x0)
> [   16.175221] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1
> (0x1b/0x0/0x0/0x0/0x0)
> [   16.175222] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [   16.175222] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
> [   16.175222] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [   16.175223] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
> [   16.175224] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
> [   16.175224] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
> [   16.238133] input: HDA Digital PCBeep as
> /devices/pci0000:00/0000:00:1b.0/sound/card1/input15
> [   16.238224] input: HDA Intel PCH Rear Mic as
> /devices/pci0000:00/0000:00:1b.0/sound/card1/input16
> [   16.238268] input: HDA Intel PCH Line as
> /devices/pci0000:00/0000:00:1b.0/sound/card1/input17
> [   16.238298] input: HDA Intel PCH Line Out Front as
> /devices/pci0000:00/0000:00:1b.0/sound/card1/input18
> [   16.238327] input: HDA Intel PCH Line Out Surround as
> /devices/pci0000:00/0000:00:1b.0/sound/card1/input19
> [   16.238355] input: HDA Intel PCH Line Out CLFE as
> /devices/pci0000:00/0000:00:1b.0/sound/card1/input20
> [   16.238407] snd_hda_intel 0000:00:1b.0: device 1849:c892 is on the
> power_save denylist, forcing power_save to 0
> [   16.492767] BTRFS info (device sdd): setting incompat feature flag
> for COMPRESS_ZSTD (0x10)
> [   16.492768] BTRFS info (device sdd): force zstd compression, level 2
> [   16.492768] BTRFS info (device sdd): using free space tree
> [   16.492769] BTRFS info (device sdd): has skinny extents
> [   16.498923] intel_rapl_common: Found RAPL domain package
> [   16.498924] intel_rapl_common: Found RAPL domain core
> [   16.498925] intel_rapl_common: Found RAPL domain uncore
> [   16.498925] intel_rapl_common: Found RAPL domain dram
> [   16.725608] Adding 998396k swap on /dev/sda5.  Priority:-2
> extents:1 across:998396k SSFS
> [  114.864229] BTRFS error (device sdd): open_ctree failed
> [  114.892847] audit: type=1400 audit(1629849229.485:2):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="lsb_release" pid=1155 comm="apparmor_parser"
> [  114.893290] audit: type=1400 audit(1629849229.485:3):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/bin/man" pid=1153 comm="apparmor_parser"
> [  114.893292] audit: type=1400 audit(1629849229.485:4):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="man_filter" pid=1153 comm="apparmor_parser"
> [  114.893293] audit: type=1400 audit(1629849229.485:5):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="man_groff" pid=1153 comm="apparmor_parser"
> [  114.896132] audit: type=1400 audit(1629849229.489:6):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="nvidia_modprobe" pid=1158 comm="apparmor_parser"
> [  114.896134] audit: type=1400 audit(1629849229.489:7):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="nvidia_modprobe//kmod" pid=1158 comm="apparmor_parser"
> [  114.897544] audit: type=1400 audit(1629849229.489:8):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/sbin/cups-browsed" pid=1159 comm="apparmor_parser"
> [  114.903187] audit: type=1400 audit(1629849229.497:9):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/lib/cups/backend/cups-pdf" pid=1157 comm="apparmor_parser"
> [  114.903189] audit: type=1400 audit(1629849229.497:10):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/sbin/cupsd" pid=1157 comm="apparmor_parser"
> [  114.903191] audit: type=1400 audit(1629849229.497:11):
> apparmor="STATUS" operation="profile_load" profile="unconfined"
> name="/usr/sbin/cupsd//third_party" pid=1157 comm="apparmor_parser"
> 
> I don't believe there is anything else related, but here is the
> complete output of the command.
> 
> On Wed, Aug 25, 2021 at 2:54 PM Roman Mamedov <rm@romanrm.net> wrote:
> >
> > On Wed, 25 Aug 2021 14:50:18 -0700
> > Evan Zimmerman <wolfblitz98@gmail.com> wrote:
> >
> > > Hello!
> > >
> > > I have a multi device btrfs array of 6 devices that is timing out or
> > > otherwise failing to mount on boot causing me to enter recovery mode,
> > > though I can manually mount the drives in recovery mode and can still
> > > see my data.
> > >
> > > I was working in my house the other day, when our power had gone out.
> > > I turned my Debian server back on and it started up in emergency mode
> > > saying BTRFS error: open_ctree failed. I also got a "failed to mount
> > > /mnt/data", which is where I have my data.
> > >
> > > Now, I've had a similar problem before where I believe one of my
> > > EasyStore drives was taking too long to be read from and causing
> > > Debian to boot into emergency mode, but after restarting it a few
> > > times, it would manage to finally boot up. This "fix" is not working
> > > this time around and I fear something corrupted during that power
> > > outage.
> > >
> > > I'm hoping to get some advice on this to see what I can do to get
> > > things up and running again. Now, trying to mount manually actually
> > > worked in emergency mode. Thank you in advance for any help you all
> > > can provide!
> > >
> > > # uname -a
> > > Linux [server_name] 5.9.0-5-amd64 #1 SMP Debian 5.9.15-1 (2020-12-17)
> > > x86_64 GNU/Linux
> > >
> > > # btrfs --version
> > > btrfs-progs v5.9
> > >
> > > # btrfs fi show
> > > Label: 'Media'  uuid: c29b9859-ae32-4be2-ad28-9193c9ebcc87
> > > Total devices 6 FS bytes used 28.24TiB
> > > devid    1 size 10.91TiB used 9.80TiB path /dev/sdd
> > > devid    2 size 2.73TiB used 2.68TiB path /dev/sdc
> > > devid    3 size 3.64TiB used 3.58TiB path /dev/sdb
> > > devid    4 size 2.73TiB used 2.67TiB path /dev/sde
> > > devid    5 size 2.73TiB used 1.61TiB path /dev/sdf
> > > devid    6 size 9.10TiB used 7.98TiB path /dev/sdg
> > >
> > > # dmesg | grep btrfs
> >
> > Are you sure it's the actual and complete output of the command?
> > "grep btrfs" without -i would not have returned any of those lines.
> > And most importantly it looks as if a few might be missing, better just post
> > the entire dmesg.
> >
> > > [   16.106923] BTRFS: device label Media devid 6 transid 3072649
> > > /dev/sdg scanned by systemd-udevd (301)
> > > [   16.492767] BTRFS info (device sdd): setting incompat feature flag
> > > for COMPRESS_ZSTD (0x10)
> > > [   16.492768] BTRFS info (device sdd): force zstd compression, level 2
> > > [   16.492768] BTRFS info (device sdd): using free space tree
> > > [   16.492769] BTRFS info (device sdd): has skinny extents
> > > [  114.864229] BTRFS error (device sdd): open_ctree failed
> >
> >
> > --
> > With respect,
> > Roman


-- 
With respect,
Roman
