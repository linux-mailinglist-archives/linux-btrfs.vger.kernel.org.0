Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1E4C196A11
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Mar 2020 00:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgC1Xkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Mar 2020 19:40:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45439 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgC1Xkg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Mar 2020 19:40:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id u59so16357878edc.12
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Mar 2020 16:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AU3GUpe3uwkqMZi7Y0XOFIP/RVTLCnZ8Rh7adJ/35no=;
        b=vee2n0/BaX+3Iui+AA6r2bwexiUlA755YlD+lX9pDwN7WwyWxOuHWm3AcL52mdrZdJ
         9wDrrp3EpqpYcEjQxmECd3YjcPMQqOa+BwOLLCJpOag0uBBvMz45S32e7lRjRJ5SXalp
         H754eBgCvnvzDPAdt7XKbe475XTZ+xpU7Kdj+37g2EW2wmUnlCeSATnBgfoYIUOP2SZV
         mzOfrRz9HFaU/PN36UNjN0ZCylx4m6zdeHH2wBxnh2HD1kuQ6vrcriYS7TAJPh6hceRQ
         ZQHU7z4sxZsvsfxiYEO4gsN/qIKS37OSl/DqtcRIifLCaOx4W+OjjKM2Aa+GPLvEgbg6
         6pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AU3GUpe3uwkqMZi7Y0XOFIP/RVTLCnZ8Rh7adJ/35no=;
        b=pp0ZGOClKfmsOwxCmTATI9oxLn54u3djZp9Ar/xhGidMv8Wn2Qxm1cTq0tA8uzx4f6
         U08MeldmYDyL27JvnjRDLtiJAYmwkmMNeG4LtFlYGQzBtHTUTDQ4KLaggUhgC7YJxN5v
         SiwC3dTGhh9X+BerEboQh/5g2iXVTqeffmnz0JX9SHU0c/Vnk5tep3Xq+WB0NMY/G9HN
         VhfYiCPdurcPYThTI3prdM+u+NAINUc6msArYeirYGNGImtGbpQFS6EK0mO2dIltHh7X
         /qHt2tdmthchpd6oRgvfZ9OPr6GqApNmOePof8TIIXKzuwtvriGATZdbfixuWmYCz8E6
         3iJA==
X-Gm-Message-State: ANhLgQ3gYCQY9kf5fWpxtWLb+7UYOMZleSHsJIp6NsN1BdjVU/PczMZt
        rqE2HTHtNau+hR2jWVFaU8P6PnqsyRXMQJifHYwzkRV5iQc=
X-Google-Smtp-Source: ADFU+vu814AE4X1K3BoZeSybHZc5Faavowj6Pc+5ww8H2UY6qAXC/xiQ0zFIXDJNzVGzGVzxSDx+xY8ErEBQPRiD4Zc=
X-Received: by 2002:aa7:d7d7:: with SMTP id e23mr5525292eds.350.1585438827178;
 Sat, 28 Mar 2020 16:40:27 -0700 (PDT)
MIME-Version: 1.0
From:   carlos ortega <carlosortega0113z@gmail.com>
Date:   Sun, 29 Mar 2020 00:38:00 +0100
Message-ID: <CAOH-_yXQD9D1emP6bPw1vO3SYfxxVqy8D5ONRXnZTbBeEgyPrw@mail.gmail.com>
Subject: Corrupted btrfs after cpu overheat
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!, due to a cpu overheat, my pc powered off, and now my fs cannot be m=
ount.
I have tried every repairing utility, please take a look to my reddit
post, there are many tests I have done an much more info about the
problem.
https://www.reddit.com/r/linuxquestions/comments/fq7ub5/corrupted_btrfs_enc=
rypted_with_luks/

Thanks you very much, I hope I can repair ir, I have not backup.

uname -a
Linux anub1wrksttn 5.4.0-4parrot1-amd64 #1 SMP Parrot 5.4.19-4parrot1
(2020-02-27) x86_64 GNU/Linux

btrfs fi show
Label: 'parrot-opt'  uuid: c1346b7a-c13e-4a30-90be-f54666cc725b
Total devices 1 FS bytes used 71.99MiB
devid    1 size 15.26GiB used 1.52GiB path /dev/mapper/parrot--vg-opt

Label: 'parrot-home'  uuid: f40ac7fc-633d-44c2-a5a9-0f2842eab935
Total devices 1 FS bytes used 12.15GiB
devid    1 size 42.39GiB used 13.52GiB path /dev/mapper/parrot--vg-home

version
btrfs-progs v5.4.1

dmesg
[    0.000000] Linux version 5.4.0-4parrot1-amd64
(debian-kernel@lists.debian.org) (gcc version 9.2.1 20200203 (Debian
9.2.1-28)) #1 SMP Parrot 5.4.19-4parrot1 (2020-02-27)
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.4.0-4parrot1-amd64
root=3D/dev/mapper/parrot--vg-root ro quiet splash noautomount quiet
[    0.000000] [Firmware Bug]: TSC doesn't count with P0 frequency!
[    0.000000] random: get_random_u32 called from
bsp_init_amd+0x21c/0x2c0 with crng_init=3D0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000dffeffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000dfff0000-0x00000000dfffffff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000019fffffff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.5 present.
[    0.000000] DMI: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 4da21001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 5729025409 cycles
[    0.000002] clocksource: kvm-clock: mask: 0xffffffffffffffff
max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.000003] tsc: Detected 4294.964 MHz processor
[    0.001935] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.001937] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.026801] AGP: No AGP bridge found
[    0.027012] last_pfn =3D 0x1a0000 max_arch_pfn =3D 0x400000000
[    0.027024] MTRR default type: uncachable
[    0.027025] MTRR variable ranges disabled:
[    0.027026] Disabled
[    0.027026] x86/PAT: MTRRs disabled, skipping PAT initialization too.
[    0.027029] CPU MTRRs all blank - virtualized system.
[    0.027032] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
[    0.027033] last_pfn =3D 0xdfff0 max_arch_pfn =3D 0x400000000
[    0.027067] found SMP MP-table at [mem 0x0009fff0-0x0009ffff]
[    0.127812] BRK [0x4dc01000, 0x4dc01fff] PGTABLE
[    0.127815] BRK [0x4dc02000, 0x4dc02fff] PGTABLE
[    0.127816] BRK [0x4dc03000, 0x4dc03fff] PGTABLE
[    0.127847] BRK [0x4dc04000, 0x4dc04fff] PGTABLE
[    0.127848] BRK [0x4dc05000, 0x4dc05fff] PGTABLE
[    0.130719] BRK [0x4dc06000, 0x4dc06fff] PGTABLE
[    0.130731] BRK [0x4dc07000, 0x4dc07fff] PGTABLE
[    0.130770] RAMDISK: [mem 0x2f873000-0x33c30fff]
[    0.130782] ACPI: Early table checksum verification disabled
[    0.130786] ACPI: RSDP 0x00000000000E0000 000024 (v02 VBOX  )
[    0.130789] ACPI: XSDT 0x00000000DFFF0030 00003C (v01 VBOX
VBOXXSDT 00000001 ASL  00000061)
[    0.130794] ACPI: FACP 0x00000000DFFF00F0 0000F4 (v04 VBOX
VBOXFACP 00000001 ASL  00000061)
[    0.130799] ACPI: DSDT 0x00000000DFFF0480 0022EA (v02 VBOX
VBOXBIOS 00000002 INTL 20100528)
[    0.130802] ACPI: FACS 0x00000000DFFF0200 000040
[    0.130804] ACPI: FACS 0x00000000DFFF0200 000040
[    0.130806] ACPI: APIC 0x00000000DFFF0240 00006C (v02 VBOX
VBOXAPIC 00000001 ASL  00000061)
[    0.130809] ACPI: SSDT 0x00000000DFFF02B0 0001CC (v01 VBOX
VBOXCPUT 00000002 INTL 20100528)
[    0.130815] ACPI: Local APIC address 0xfee00000
[    0.131052] No NUMA configuration found
[    0.131053] Faking a node at [mem 0x0000000000000000-0x000000019fffffff]
[    0.131057] NODE_DATA(0) allocated [mem 0x19fff7000-0x19fffbfff]
[    0.133736] Zone ranges:
[    0.133737]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.133739]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.133740]   Normal   [mem 0x0000000100000000-0x000000019fffffff]
[    0.133741]   Device   empty
[    0.133741] Movable zone start for each node
[    0.133742] Early memory node ranges
[    0.133742]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.133743]   node   0: [mem 0x0000000000100000-0x00000000dffeffff]
[    0.133745]   node   0: [mem 0x0000000100000000-0x000000019fffffff]
[    0.138971] Zeroed struct page in unavailable ranges: 114 pages
[    0.138973] Initmem setup node 0 [mem 0x0000000000001000-0x000000019ffff=
fff]
[    0.138975] On node 0 totalpages: 1572750
[    0.138976]   DMA zone: 64 pages used for memmap
[    0.138977]   DMA zone: 21 pages reserved
[    0.138977]   DMA zone: 3998 pages, LIFO batch:0
[    0.139028]   DMA32 zone: 14272 pages used for memmap
[    0.139029]   DMA32 zone: 913392 pages, LIFO batch:63
[    0.218087]   Normal zone: 10240 pages used for memmap
[    0.218089]   Normal zone: 655360 pages, LIFO batch:63
[    0.279732] ACPI: PM-Timer IO Port: 0x4008
[    0.279735] ACPI: Local APIC address 0xfee00000
[    0.279801] IOAPIC[0]: apic_id 4, version 32, address 0xfec00000, GSI 0-=
23
[    0.279803] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.279805] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.279806] ACPI: IRQ0 used by override.
[    0.279807] ACPI: IRQ9 used by override.
[    0.279808] Using ACPI (MADT) for SMP configuration information
[    0.279815] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.279841] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.279842] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.279843] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.279843] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.279845] PM: Registered nosave memory: [mem 0xdfff0000-0xdfffffff]
[    0.279845] PM: Registered nosave memory: [mem 0xe0000000-0xfebfffff]
[    0.279846] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.279846] PM: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
[    0.279847] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.279847] PM: Registered nosave memory: [mem 0xfee01000-0xfffbffff]
[    0.279847] PM: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.279849] [mem 0xe0000000-0xfebfffff] available for PCI devices
[    0.279850] Booting paravirtualized kernel on KVM
[    0.279852] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.353792] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
nr_cpu_ids:4 nr_node_ids:1
[    0.356823] percpu: Embedded 53 pages/cpu s178584 r8192 d30312 u524288
[    0.356830] pcpu-alloc: s178584 r8192 d30312 u524288 alloc=3D1*2097152
[    0.356831] pcpu-alloc: [0] 0 1 2 3
[    0.356860] PV qspinlock hash table entries: 256 (order: 0, 4096
bytes, linear)
[    0.356866] Built 1 zonelists, mobility grouping on.  Total pages: 15481=
53
[    0.356867] Policy zone: Normal
[    0.356869] Kernel command line:
BOOT_IMAGE=3D/vmlinuz-5.4.0-4parrot1-amd64
root=3D/dev/mapper/parrot--vg-root ro quiet splash noautomount quiet
[    0.369157] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.376132] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.376174] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.469464] AGP: Checking aperture...
[    0.494943] AGP: No AGP bridge found
[    0.495171] Calgary: detecting Calgary via BIOS EBDA area
[    0.495172] Calgary: Unable to locate Rio Grande table in EBDA - bailing=
!
[    0.520410] Memory: 6019452K/6291000K available (10243K kernel
code, 1197K rwdata, 3736K rodata, 1672K init, 2048K bss, 271548K
reserved, 0K cma-reserved)
[    0.524840] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.524851] ftrace: allocating 33946 entries in 133 pages
[    0.541904] rcu: Hierarchical RCU implementation.
[    0.541909] rcu: RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_ids=
=3D4.
[    0.541910] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.541911] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.544674] NR_IRQS: 33024, nr_irqs: 456, preallocated irqs: 16
[    0.556691] Console: colour VGA+ 80x25
[    0.556694] printk: console [tty0] enabled
[    0.556710] ACPI: Core revision 20190816
[    0.556809] APIC: Switch to symmetric I/O mode setup
[    0.558399] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.558429] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x3de8ce9f4c0, max_idle_ns: 440795391740 ns
[    0.558434] Calibrating delay loop (skipped) preset value.. 8589.92
BogoMIPS (lpj=3D17179856)
[    0.558436] pid_max: default: 32768 minimum: 301
[    0.558463] LSM: Security Framework initializing
[    0.558468] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.558483] AppArmor: AppArmor initialized
[    0.558485] TOMOYO Linux initialized
[    0.558519] Mount-cache hash table entries: 16384 (order: 5, 131072
bytes, linear)
[    0.558540] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes, linear)
[    0.558848] Last level iTLB entries: 4KB 512, 2MB 1024, 4MB 512
[    0.558849] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 512, 1GB 0
[    0.558852] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.558853] Spectre V2 : Mitigation: Full AMD retpoline
[    0.558854] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.558855] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.558999] Freeing SMP alternatives memory: 24K
[    0.658644] APIC calibration not consistent with PM-Timer: 90ms
instead of 100ms
[    0.658646] APIC delta adjusted to PM-Timer: 6246290 (5640654)
[    0.658732] smpboot: CPU0: AMD FX(tm)-9370 Eight-Core Processor
(family: 0x15, model: 0x2, stepping: 0x0)
[    0.658901] Performance Events: PMU not available due to
virtualization, using software events only.
[    0.658949] rcu: Hierarchical SRCU implementation.
[    0.659214] NMI watchdog: Perf NMI watchdog permanently disabled
[    0.662525] smp: Bringing up secondary CPUs ...
[    0.662669] x86: Booting SMP configuration:
[    0.662670] .... node  #0, CPUs:      #1
[    0.017288] kvm-clock: cpu 1, msr 4da21041, secondary cpu clock
[    0.666519]  #2
[    0.017288] kvm-clock: cpu 2, msr 4da21081, secondary cpu clock
[    0.669016]  #3
[    0.017288] kvm-clock: cpu 3, msr 4da210c1, secondary cpu clock
[    0.672478] smp: Brought up 1 node, 4 CPUs
[    0.672478] smpboot: Max logical packages: 1
[    0.672478] smpboot: Total of 4 processors activated (34359.71 BogoMIPS)
[    0.672478] devtmpfs: initialized
[    0.672478] x86/mm: Memory block size: 128MB
[    0.672478] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.672478] futex hash table entries: 1024 (order: 4, 65536 bytes, linea=
r)
[    0.672478] pinctrl core: initialized pinctrl subsystem
[    0.672478] NET: Registered protocol family 16
[    0.672478] audit: initializing netlink subsys (disabled)
[    0.674438] audit: type=3D2000 audit(1585436043.254:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.674537] cpuidle: using governor ladder
[    0.674537] cpuidle: using governor menu
[    0.674704] ACPI: bus type PCI registered
[    0.674704] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.674704] PCI: Using configuration type 1 for base access
[    0.674704] PCI: Using configuration type 1 for extended access
[    0.675612] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.806756] ACPI: Added _OSI(Module Device)
[    0.806757] ACPI: Added _OSI(Processor Device)
[    0.806757] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.806758] ACPI: Added _OSI(Processor Aggregator Device)
[    0.806759] ACPI: Added _OSI(Linux-Dell-Video)
[    0.806760] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.806761] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.807913] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.810727] ACPI: Interpreter enabled
[    0.810737] ACPI: (supports S0 S5)
[    0.810738] ACPI: Using IOAPIC for interrupt routing
[    0.810886] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.810988] ACPI: Enabled 2 GPEs in block 00 to 07
[    0.814431] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.814431] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.814431] acpi PNP0A03:00: _OSC: platform does not support
[PCIeCapability LTR]
[    0.814736] acpi PNP0A03:00: _OSC: not requesting control; platform
does not support [PCIeCapability]
[    0.814738] acpi PNP0A03:00: _OSC: OS requested [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR]
[    0.814740] acpi PNP0A03:00: _OSC: platform willing to grant
[PCIeHotplug SHPCHotplug PME AER]
[    0.814741] acpi PNP0A03:00: _OSC failed (AE_SUPPORT); disabling ASPM
[    0.815022] PCI host bridge to bus 0000:00
[    0.815024] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.815025] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.815026] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.815027] pci_bus 0000:00: root bus resource [mem
0xe0000000-0xfdffffff window]
[    0.815029] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.815067] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.815808] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.816570] pci 0000:00:01.1: [8086:7111] type 00 class 0x01018a
[    0.817028] pci 0000:00:01.1: reg 0x20: [io  0xd000-0xd00f]
[    0.817197] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.817198] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.817199] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.817200] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.817455] pci 0000:00:02.0: [15ad:0405] type 00 class 0x030000
[    0.820911] pci 0000:00:02.0: reg 0x10: [io  0xd010-0xd01f]
[    0.822441] pci 0000:00:02.0: reg 0x14: [mem 0xf0000000-0xf7ffffff]
[    0.826441] pci 0000:00:02.0: reg 0x18: [mem 0xf8000000-0xf81fffff]
[    0.842818] pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
[    0.846431] pci 0000:00:03.0: reg 0x10: [mem 0xf8200000-0xf821ffff]
[    0.850431] pci 0000:00:03.0: reg 0x18: [io  0xd020-0xd027]
[    0.854431] pci 0000:00:04.0: [80ee:cafe] type 00 class 0x088000
[    0.854431] pci 0000:00:04.0: reg 0x10: [io  0xd040-0xd05f]
[    0.854546] pci 0000:00:04.0: reg 0x14: [mem 0xf8400000-0xf87fffff]
[    0.858431] pci 0000:00:04.0: reg 0x18: [mem 0xf8800000-0xf8803fff pref]
[    0.862431] pci 0000:00:05.0: [8086:2415] type 00 class 0x040100
[    0.862544] pci 0000:00:05.0: reg 0x10: [io  0xd100-0xd1ff]
[    0.862629] pci 0000:00:05.0: reg 0x14: [io  0xd200-0xd23f]
[    0.863245] pci 0000:00:07.0: [8086:7113] type 00 class 0x068000
[    0.863835] pci 0000:00:07.0: quirk: [io  0x4000-0x403f] claimed by
PIIX4 ACPI
[    0.863846] pci 0000:00:07.0: quirk: [io  0x4100-0x410f] claimed by PIIX=
4 SMB
[    0.864141] pci 0000:00:0c.0: [8086:1e31] type 00 class 0x0c0330
[    0.866431] pci 0000:00:0c.0: reg 0x10: [mem 0xf8810000-0xf881ffff]
[    0.875038] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 9 10 *11)
[    0.875252] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 9 *10 11)
[    0.875342] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 *9 10 11)
[    0.875458] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 9 10 *11)
[    0.875663] iommu: Default domain type: Translated
[    0.875694] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.875694] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.875694] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.875694] vgaarb: loaded
[    0.875694] EDAC MC: Ver: 3.0.0
[    0.875694] PCI: Using ACPI for IRQ routing
[    0.875694] PCI: pci_cache_line_size set to 64 bytes
[    0.875694] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.875694] e820: reserve RAM buffer [mem 0xdfff0000-0xdfffffff]
[    0.875694] clocksource: Switched to clocksource kvm-clock
[    0.901948] VFS: Disk quotas dquot_6.6.0
[    0.902159] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.902405] AppArmor: AppArmor Filesystem Enabled
[    0.902421] pnp: PnP ACPI init
[    0.902495] pnp 00:00: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.902554] pnp 00:01: Plug and Play ACPI device, IDs PNP0f03 (active)
[    0.903167] pnp: PnP ACPI: found 2 devices
[    0.909812] thermal_sys: Registered thermal governor 'fair_share'
[    0.909813] thermal_sys: Registered thermal governor 'bang_bang'
[    0.909814] thermal_sys: Registered thermal governor 'step_wise'
[    0.909814] thermal_sys: Registered thermal governor 'user_space'
[    0.914361] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.914393] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.914394] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.914395] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.914397] pci_bus 0000:00: resource 7 [mem 0xe0000000-0xfdffffff windo=
w]
[    0.914435] NET: Registered protocol family 2
[    0.914549] tcp_listen_portaddr_hash hash table entries: 4096
(order: 4, 65536 bytes, linear)
[    0.914563] TCP established hash table entries: 65536 (order: 7,
524288 bytes, linear)
[    0.914652] TCP bind hash table entries: 65536 (order: 8, 1048576
bytes, linear)
[    0.919612] TCP: Hash tables configured (established 65536 bind 65536)
[    0.919656] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear=
)
[    0.919680] UDP-Lite hash table entries: 4096 (order: 5, 131072
bytes, linear)
[    0.919744] NET: Registered protocol family 1
[    0.919749] NET: Registered protocol family 44
[    0.919774] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.919787] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.919842] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.920835] PCI: CLS 0 bytes, default 64
[    0.920871] Trying to unpack rootfs image as initramfs...
[    2.461363] Freeing initrd memory: 69368K
[    2.461367] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.461368] software IO TLB: mapped [mem 0xdbff0000-0xdfff0000] (64MB)
[    2.461534] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x3de8ce9f4c0, max_idle_ns: 440795391740 ns
[    2.462177] clocksource: Switched to clocksource tsc
[    2.462215] platform rtc_cmos: registered platform RTC device (no
PNP device found)
[    2.462728] Initialise system trusted keyrings
[    2.462736] Key type blacklist registered
[    2.462918] workingset: timestamp_bits=3D40 max_order=3D21 bucket_order=
=3D0
[    2.464338] zbud: loaded
[    2.464879] Platform Keyring initialized
[    2.464881] Key type asymmetric registered
[    2.464882] Asymmetric key parser 'x509' registered
[    2.464889] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
[    2.465201] io scheduler mq-deadline registered
[    2.465470] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.465988] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.466672] Linux agpgart interface v0.103
[    2.466757] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    2.466758] AMD-Vi: AMD IOMMUv2 functionality not available on this syst=
em
[    2.467372] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M]
at 0x60,0x64 irq 1,12
[    2.467896] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.467900] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.468126] mousedev: PS/2 mouse device common for all mice
[    2.468782] input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input0
[    2.468840] rtc_cmos rtc_cmos: registered as rtc0
[    2.468859] rtc_cmos rtc_cmos: alarms up to one day, 114 bytes nvram
[    2.469112] ledtrig-cpu: registered to indicate activity on CPUs
[    2.469169] x86/pm: family 0x15 cpu detected, MSR saving is needed
during suspending.
[    2.469279] drop_monitor: Initializing network drop monitor service
[    2.469433] NET: Registered protocol family 10
[    2.480758] Segment Routing with IPv6
[    2.480775] mip6: Mobile IPv6
[    2.480777] NET: Registered protocol family 17
[    2.480936] mpls_gso: MPLS GSO support
[    2.481255] IPI shorthand broadcast: enabled
[    2.481259] sched_clock: Marking stable (2467932326,
13288967)->(2663342996, -182121703)
[    2.481565] registered taskstats version 1
[    2.481565] Loading compiled-in X.509 certificates
[    2.517681] Loaded X.509 cert 'Debian Secure Boot CA:
6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1'
[    2.517696] Loaded X.509 cert 'Debian Secure Boot Signer: 00a7468def'
[    2.517714] zswap: loaded using pool lzo/zbud
[    2.518115] Key type ._fscrypt registered
[    2.518116] Key type .fscrypt registered
[    2.518129] AppArmor: AppArmor sha1 policy hashing enabled
[    2.518545] rtc_cmos rtc_cmos: setting system clock to
2020-03-28T22:53:57 UTC (1585436037)
[    2.519901] Freeing unused kernel image memory: 1672K
[    2.547274] Write protecting the kernel read-only data: 16384k
[    2.548120] Freeing unused kernel image memory: 2036K
[    2.548442] Freeing unused kernel image memory: 360K
[    2.556798] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    2.556802] Run /init as init process
[    2.693629] button: module verification failed: signature and/or
required key missing - tainting kernel
[    2.695582] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    2.695646] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A03:00/LNXVIDEO:00/input/input2
[    2.695896] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    2.695969] ACPI: Power Button [PWRF]
[    2.696045] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSLPBN:00/input/input4
[    2.696061] ACPI: Sleep Button [SLPF]
[    2.735184] piix4_smbus 0000:00:07.0: SMBus Host Controller at
0x4100, revision 0
[    2.742395] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    2.742396] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    2.742885] SCSI subsystem initialized
[    2.743625] cryptd: max_cpu_qlen set to 1000
[    2.759465] libata version 3.00 loaded.
[    2.771265] AVX version of gcm_enc/dec engaged.
[    2.771267] AES CTR mode by8 optimization enabled
[    2.771684] ata_piix 0000:00:01.1: version 2.13
[    2.773169] ACPI: bus type USB registered
[    2.773190] usbcore: registered new interface driver usbfs
[    2.773197] usbcore: registered new interface driver hub
[    2.773473] usbcore: registered new device driver usb
[    2.776736] scsi host0: ata_piix
[    2.777803] scsi host1: ata_piix
[    2.777860] ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 bmdma 0xd000 irq =
14
[    2.777861] ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 bmdma 0xd008 irq =
15
[    2.780904] [drm] DMA map mode: Caching DMA mappings.
[    2.780946] [drm] Capabilities:
[    2.780946] [drm]   Cursor.
[    2.780946] [drm]   Cursor bypass 2.
[    2.780947] [drm]   Alpha cursor.
[    2.780947] [drm]   3D.
[    2.780947] [drm]   Extended Fifo.
[    2.780948] [drm]   Pitchlock.
[    2.780948] [drm]   Irq mask.
[    2.780948] [drm]   GMR.
[    2.780949] [drm]   Traces.
[    2.780949] [drm]   GMR2.
[    2.780949] [drm]   Screen Object 2.
[    2.780950] [drm] Max GMR ids is 8192
[    2.780951] [drm] Max number of GMR pages is 1048576
[    2.780951] [drm] Max dedicated hypervisor surface memory is 393216 kiB
[    2.780952] [drm] Maximum display memory size is 131072 kiB
[    2.780952] [drm] VRAM at 0xf0000000 size is 131072 kiB
[    2.780953] [drm] MMIO at 0xf8000000 size is 2048 kiB
[    2.781288] [TTM] Zone  kernel: Available graphics memory: 3046456 KiB
[    2.781289] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    2.781289] [TTM] Initializing pool allocator
[    2.781295] [TTM] Initializing DMA pool allocator
[    2.781335] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.781336] [drm] No driver support for vblank timestamp query.
[    2.781724] [drm] Screen Objects Display Unit initialized
[    2.781877] [drm] width 720
[    2.781888] [drm] height 400
[    2.781907] [drm] bpp 32
[    2.782498] xhci_hcd 0000:00:0c.0: xHCI Host Controller
[    2.782505] xhci_hcd 0000:00:0c.0: new USB bus registered, assigned
bus number 1
[    2.782716] [drm] Fifo max 0x00200000 min 0x00001000 cap 0x00000355
[    2.792327] [drm] DX: no.
[    2.792329] [drm] Atomic: yes.
[    2.792329] [drm] SM4_1: no.
[    2.792355] [drm:vmw_host_log [vmwgfx]] *ERROR* Failed to send host
log message.
[    2.793399] [drm:vmw_host_log [vmwgfx]] *ERROR* Failed to send host
log message.
[    2.794585] xhci_hcd 0000:00:0c.0: hcc params 0x04000000 hci
version 0x100 quirks 0x000000000000b930
[    2.797460] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.04
[    2.797461] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    2.797462] usb usb1: Product: xHCI Host Controller
[    2.797463] usb usb1: Manufacturer: Linux 5.4.0-4parrot1-amd64 xhci-hcd
[    2.797464] usb usb1: SerialNumber: 0000:00:0c.0
[    2.797668] hub 1-0:1.0: USB hub found
[    2.797776] hub 1-0:1.0: 8 ports detected
[    2.809093] xhci_hcd 0000:00:0c.0: xHCI Host Controller
[    2.809097] xhci_hcd 0000:00:0c.0: new USB bus registered, assigned
bus number 2
[    2.809101] xhci_hcd 0000:00:0c.0: Host supports USB 3.0 SuperSpeed
[    2.809346] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 5.04
[    2.809347] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    2.809348] usb usb2: Product: xHCI Host Controller
[    2.809349] usb usb2: Manufacturer: Linux 5.4.0-4parrot1-amd64 xhci-hcd
[    2.809350] usb usb2: SerialNumber: 0000:00:0c.0
[    2.819128] hub 2-0:1.0: USB hub found
[    2.829020] hub 2-0:1.0: 6 ports detected
[    2.869844] fbcon: svgadrmfb (fb0) is primary device
[    2.877044] Console: switching to colour frame buffer device 100x37
[    2.880487] [drm] Initialized vmwgfx 2.15.0 20180704 for
0000:00:02.0 on minor 0
[    2.935875] ata1.01: NODEV after polling detection
[    2.936100] ata1.00: ATA-6: VBOX HARDDISK, 1.0, max UDMA/133
[    2.936102] ata1.00: 210795904 sectors, multi 128: LBA
[    2.936834] scsi 0:0:0:0: Direct-Access     ATA      VBOX HARDDISK
  1.0  PQ: 0 ANSI: 5
[    2.939257] ata2.00: ATAPI: VBOX CD-ROM, 1.0, max UDMA/133
[    2.940147] scsi 1:0:0:0: CD-ROM            VBOX     CD-ROM
  1.0  PQ: 0 ANSI: 5
[    2.958395] sd 0:0:0:0: [sda] 210795904 512-byte logical blocks:
(108 GB/101 GiB)
[    2.958407] sd 0:0:0:0: [sda] Write Protect is off
[    2.958408] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.958426] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.969110] input: ImExPS/2 Generic Explorer Mouse as
/devices/platform/i8042/serio1/input/input5
[    3.146579] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    3.185084]  sda: sda1 sda2 < sda5 >
[    3.186100] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.247658] sr 1:0:0:0: [sr0] scsi3-mmc drive: 32x/32x xa/form2 tray
[    3.247661] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.271446] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    3.285900] e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 08:00:27:88:fc:4=
c
[    3.285904] e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connectio=
n
[    3.304160] usb 1-1: New USB device found, idVendor=3D80ee,
idProduct=3D0021, bcdDevice=3D 1.00
[    3.304162] usb 1-1: New USB device strings: Mfr=3D1, Product=3D3, Seria=
lNumber=3D0
[    3.304163] usb 1-1: Product: USB Tablet
[    3.304164] usb 1-1: Manufacturer: VirtualBox
[    3.306937] hidraw: raw HID events driver (C) Jiri Kosina
[    3.308819] usbcore: registered new interface driver usbhid
[    3.308820] usbhid: USB HID core driver
[    3.310502] input: VirtualBox USB Tablet as
/devices/pci0000:00/0000:00:0c.0/usb1/1-1/1-1:1.0/0003:80EE:0021.0001/input=
/input6
[    3.310706] hid-generic 0003:80EE:0021.0001: input,hidraw0: USB HID
v1.10 Mouse [VirtualBox USB Tablet] on usb-0000:00:0c.0-1/input0
[    3.447955] random: fast init done
[    3.675333] raid6: sse2x4   gen() 12338 MB/s
[    3.742523] raid6: sse2x4   xor()  5789 MB/s
[    3.810803] raid6: sse2x2   gen() 11052 MB/s
[    3.879106] raid6: sse2x2   xor()  6333 MB/s
[    3.947316] raid6: sse2x1   gen()  6944 MB/s
[    4.014541] raid6: sse2x1   xor()  4492 MB/s
[    4.014542] raid6: using algorithm sse2x4 gen() 12338 MB/s
[    4.014543] raid6: .... xor() 5789 MB/s, rmw enabled
[    4.014544] raid6: using ssse3x2 recovery algorithm
[    4.017657] xor: automatically using best checksumming function   avx
[    4.056499] Btrfs loaded, crc32c=3Dcrc32c-intel
[    4.108717] SGI XFS with ACLs, security attributes, realtime, no
debug enabled
[    4.126530] async_tx: api initialized (async)
[    4.608288] random: plymouthd: uninitialized urandom read (8 bytes read)
[    4.608413] random: plymouthd: uninitialized urandom read (8 bytes read)
[    4.642021] random: lvm: uninitialized urandom read (4 bytes read)
[    4.722917] device-mapper: uevent: version 1.0.3
[    4.723093] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16)
initialised: dm-devel@redhat.com
[    9.731332] random: crng init done
[    9.731336] random: 1 urandom warning(s) missed due to ratelimiting
[   24.426496] BTRFS: device label parrot-home devid 1 transid 10086
/dev/mapper/parrot--vg-home
[   24.426790] BTRFS: device label parrot-opt devid 1 transid 69
/dev/mapper/parrot--vg-opt
[   24.441166] PM: Image not found (code -22)
[   24.450667] XFS (dm-1): Mounting V5 Filesystem
[   25.134956] XFS (dm-1): Ending clean mount
[   25.344503] Not activating Mandatory Access Control as
/sbin/tomoyo-init does not exist.
[   26.995437] systemd[1]: Inserted module 'autofs4'
[   27.171056] systemd[1]: systemd 244.3-1 running in system mode.
(+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dhybrid)
[   27.171089] systemd[1]: Detected virtualization oracle.
[   27.171094] systemd[1]: Detected architecture x86-64.
[   27.213378] systemd[1]: Set hostname to <anub1wrksttn>.
[   32.099613] systemd[1]: /lib/systemd/system/dbus.socket:5:
ListenStream=3D references a path below legacy directory /var/run/,
updating /var/run/dbus/system_bus_socket =E2=86=92
/run/dbus/system_bus_socket; please update the unit file accordingly.
[   32.667784] systemd[1]: /lib/systemd/system/faraday.service:9:
Ignoring unknown escape sequences: "if ! su postgres -c "psql -lqt" |
cut -d \| -f 1 | grep -qw faraday; then faraday-manage initdb; fi"
[   32.712137] systemd[1]: /lib/systemd/system/docker.socket:6:
ListenStream=3D references a path below legacy directory /var/run/,
updating /var/run/docker.sock =E2=86=92 /run/docker.sock; please update the
unit file accordingly.
[   33.073428] systemd[1]: Created slice system-getty.slice.
[   33.073751] systemd[1]: Created slice system-postgresql.slice.
[   33.074018] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice=
.
[   33.074342] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   33.074586] systemd[1]: Created slice User and Session Slice.
[   33.074670] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[   33.074896] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[   33.074945] systemd[1]: Reached target User and Group Name Lookups.
[   33.074956] systemd[1]: Reached target Remote File Systems.
[   33.074965] systemd[1]: Reached target Slices.
[   33.074983] systemd[1]: Reached target System Time Set.
[   33.074992] systemd[1]: Reached target System Time Synchronized.
[   33.075056] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   33.075148] systemd[1]: Listening on LVM2 poll daemon socket.
[   33.075216] systemd[1]: Listening on Syslog Socket.
[   33.085406] systemd[1]: Listening on fsck to fsckd communication Socket.
[   33.085507] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   33.086049] systemd[1]: Listening on Journal Audit Socket.
[   33.086146] systemd[1]: Listening on Journal Socket (/dev/log).
[   33.086230] systemd[1]: Listening on Journal Socket.
[   33.107863] systemd[1]: Listening on udev Control Socket.
[   33.107970] systemd[1]: Listening on udev Kernel Socket.
[   33.109096] systemd[1]: Mounting Huge Pages File System...
[   33.110112] systemd[1]: Mounting POSIX Message Queue File System...
[   33.111331] systemd[1]: Mounting Kernel Debug File System...
[   33.112228] systemd[1]: Starting Availability of block devices...
[   33.141465] systemd[1]: Starting Set the console keyboard layout...
[   33.158808] systemd[1]: Starting Create list of static device nodes
for the current kernel...
[   33.159700] systemd[1]: Starting Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling...
[   33.160621] systemd[1]: Started Nameserver information manager.
[   33.160791] systemd[1]: Reached target Network (Pre).
[   33.253648] systemd[1]: Condition check resulted in Set Up
Additional Binary Formats being skipped.
[   33.256067] systemd[1]: Starting Journal Service...
[   33.325553] systemd[1]: Starting Load Kernel Modules...
[   33.326517] systemd[1]: Starting Remount Root and Kernel File Systems...
[   33.327463] systemd[1]: Starting udev Coldplug all Devices...
[   33.328339] systemd[1]: Starting Uncomplicated firewall...
[   33.329662] systemd[1]: Mounted Huge Pages File System.
[   33.329865] systemd[1]: Mounted POSIX Message Queue File System.
[   33.329979] systemd[1]: Mounted Kernel Debug File System.
[   33.330536] systemd[1]: Started Availability of block devices.
[   33.335241] systemd[1]: Started Create list of static device nodes
for the current kernel.
[   33.340736] systemd[1]: Started Monitoring of LVM2 mirrors,
snapshots etc. using dmeventd or progress polling.
[   33.430113] systemd[1]: Started Set the console keyboard layout.
[   33.465149] systemd[1]: Started Uncomplicated firewall.
[   33.625248] xfs filesystem being remounted at / supports timestamps
until 2038 (0x7fffffff)
[   33.630253] systemd[1]: Started Remount Root and Kernel File Systems.
[   33.665449] systemd[1]: Condition check resulted in Rebuild
Hardware Database being skipped.
[   33.666508] systemd[1]: Starting Load/Save Random Seed...
[   33.667423] systemd[1]: Starting Create System Users...
[   33.697956] systemd[1]: Started udev Coldplug all Devices.
[   33.754847] lp: driver loaded but no devices found
[   33.778955] systemd[1]: Starting Helper to synchronize boot up for
ifupdown...
[   33.822048] ppdev: user-space parallel port driver
[   33.932730] systemd[1]: Started Helper to synchronize boot up for ifupdo=
wn.
[   33.940512] systemd[1]: Started Load Kernel Modules.
[   33.940800] systemd[1]: Condition check resulted in FUSE Control
File System being skipped.
[   33.940860] systemd[1]: Condition check resulted in Kernel
Configuration File System being skipped.
[   33.941869] systemd[1]: Starting Apply Kernel Variables...
[   33.947174] systemd[1]: Started Journal Service.
[   34.015803] systemd-journald[577]: Received client request to flush
runtime journal.
[   37.036692] MCE: In-kernel MCE decoding enabled.
[   37.261641] input: PC Speaker as /devices/platform/pcspkr/input/input7
[   37.377002] ACPI: AC Adapter [AC] (on-line)
[   37.905068] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   37.905746] sr 1:0:0:0: Attached scsi generic sg1 type 5
[   38.784659] pktcdvd: pktcdvd0: writer mapped to sr0
[   39.141310] BTRFS info (device dm-2): setting nodatacow, compression dis=
abled
[   39.141313] BTRFS info (device dm-2): use zlib compression, level 3
[   39.141314] BTRFS info (device dm-2): turning on discard
[   39.141315] BTRFS info (device dm-2): disk space caching is enabled
[   39.141316] BTRFS info (device dm-2): has skinny extents
[   39.353529] BTRFS info (device dm-3): setting nodatacow, compression dis=
abled
[   39.353532] BTRFS info (device dm-3): use zlib compression, level 3
[   39.353534] BTRFS info (device dm-3): turning on discard
[   39.353535] BTRFS info (device dm-3): disk space caching is enabled
[   39.353536] BTRFS info (device dm-3): has skinny extents
[   39.841262] BTRFS info (device dm-3): checking UUID tree
[   39.842514] BTRFS error (device dm-3): parent transid verify failed
on 37978112 wanted 10077 found 10086
[   39.859415] BTRFS error (device dm-3): parent transid verify failed
on 37978112 wanted 10077 found 10086
[   39.859968] ------------[ cut here ]------------
[   39.860007] WARNING: CPU: 0 PID: 727 at fs/btrfs/extent-tree.c:3071
__btrfs_free_extent.isra.0+0x6a0/0x980 [btrfs]
[   39.860008] Modules linked in: joydev(E) pktcdvd(E)
snd_intel8x0(E+) snd_ac97_codec(E) ac97_bus(E) snd_pcm(E) snd_timer(E)
snd(E) soundcore(E) sg(E) evdev(E) serio_raw(E) ac(E) pcspkr(E)
edac_mce_amd(E) parport_pc(E) ppdev(E) lp(E) parport(E) ip_tables(E)
x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) xfs(E)
btrfs(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E)
libcrc32c(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E)
nls_ascii(E) hid_generic(E) usbhid(E) hid(E) crct10dif_pclmul(E)
crc32_pclmul(E) crc32c_intel(E) sr_mod(E) cdrom(E) sd_mod(E)
ghash_clmulni_intel(E) ata_generic(E) xhci_pci(E) vmwgfx(E)
xhci_hcd(E) ttm(E) ata_piix(E) aesni_intel(E) libata(E) crypto_simd(E)
drm_kms_helper(E) cryptd(E) e1000(E) glue_helper(E) usbcore(E)
psmouse(E) usb_common(E) i2c_piix4(E) drm(E) scsi_mod(E) video(E)
button(E)
[   39.860036] CPU: 0 PID: 727 Comm: mount Tainted: G            E
5.4.0-4parrot1-amd64 #1 Parrot 5.4.19-4parrot1
[   39.860037] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[   39.860051] RIP: 0010:__btrfs_free_extent.isra.0+0x6a0/0x980 [btrfs]
[   39.860053] Code: ff ff 48 8b 3c 24 4d 89 f0 4c 89 e9 48 c7 44 24
48 00 00 00 00 48 89 ea 4c 89 e6 e8 9a b4 ff ff 41 89 c7 e9 8e fb ff
ff 0f 0b <0f> 0b 49 8b 3c 24 e8 65 5a 00 00 49 89 d9 4d 89 f0 4c 89 e9
ff b4
[   39.860054] RSP: 0018:ffffae6f40427938 EFLAGS: 00010246
[   39.860055] RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 00000000000=
00002
[   39.860055] RDX: 00000000fffffffe RSI: 0000000000000000 RDI: 00000000000=
00000
[   39.860056] RBP: 0000000001504000 R08: 0000000000000000 R09: 00000000000=
00000
[   39.860057] R10: 0000000000000002 R11: 0000000000000000 R12: ffff890aca4=
801c0
[   39.860057] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000fff=
ffffe
[   39.860058] FS:  00007fc7f83b6c80(0000) GS:ffff890ad9a00000(0000)
knlGS:0000000000000000
[   39.860059] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.860059] CR2: 000055a574d179d8 CR3: 000000019772a000 CR4: 00000000000=
406f0
[   39.860063] Call Trace:
[   39.860099]  ? btrfs_merge_delayed_refs+0x31a/0x370 [btrfs]
[   39.860114]  __btrfs_run_delayed_refs+0x749/0xf90 [btrfs]
[   39.860119]  ? kmem_cache_alloc+0x159/0x210
[   39.860132]  btrfs_run_delayed_refs+0x72/0x190 [btrfs]
[   39.860165]  btrfs_commit_transaction+0x54/0x9a0 [btrfs]
[   39.860201]  ? start_transaction+0x95/0x480 [btrfs]
[   39.860216]  close_ctree+0x29d/0x2f0 [btrfs]
[   39.860230]  btrfs_mount_root+0x66c/0x690 [btrfs]
[   39.860233]  ? __lookup_constant+0x46/0x60
[   39.860234]  legacy_get_tree+0x27/0x40
[   39.860237]  vfs_get_tree+0x25/0xb0
[   39.860238]  fc_mount+0xe/0x30
[   39.860240]  vfs_kern_mount.part.0+0x71/0x90
[   39.860253]  btrfs_mount+0x155/0x8a0 [btrfs]
[   39.860256]  ? filename_lookup+0xf1/0x170
[   39.860258]  ? tomoyo_init_request_info+0x86/0x90
[   39.860259]  ? tomoyo_mount_permission+0x3e/0x1c0
[   39.860260]  ? __lookup_constant+0x46/0x60
[   39.860262]  ? legacy_get_tree+0x27/0x40
[   39.860263]  legacy_get_tree+0x27/0x40
[   39.860264]  vfs_get_tree+0x25/0xb0
[   39.860266]  do_mount+0x770/0x980
[   39.860267]  ksys_mount+0x7e/0xc0
[   39.860269]  __x64_sys_mount+0x21/0x30
[   39.860271]  do_syscall_64+0x52/0x160
[   39.860273]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   39.860275] RIP: 0033:0x7fc7f825acda
[   39.860277] Code: 48 8b 0d b9 e1 0b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 86 e1 0b 00 f7 d8 64 89
01 48
[   39.860278] RSP: 002b:00007fffe3040f48 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[   39.860289] RAX: ffffffffffffffda RBX: 00005633fb563a00 RCX: 00007fc7f82=
5acda
[   39.860290] RDX: 00005633fb563c10 RSI: 00005633fb563cf0 RDI: 00005633fb5=
63c30
[   39.860298] RBP: 00007fc7f83b0204 R08: 00005633fb563c80 R09: 00007fc7f82=
9b4c0
[   39.860299] R10: 0000000000000c00 R11: 0000000000000246 R12: 00000000000=
00000
[   39.860299] R13: 0000000000000c00 R14: 00005633fb563c30 R15: 00005633fb5=
63c10
[   39.860301] ---[ end trace 2155c25bb5f33a74 ]---
[   39.860304] BTRFS info (device dm-3): leaf 30605312 gen 10087 total
ptrs 8 free space 15846 owner 2
[   39.860305] item 0 key (22020096 169 0) itemoff 16250 itemsize 33
[   39.860306] extent refs 1 gen 10087 flags 2
[   39.860306] ref#0: tree block backref root 3
[   39.860307] item 1 key (22020096 192 8388608) itemoff 16226 itemsize 24
[   39.860308] block group used 0 chunk_objectid 256 flags 34
[   39.860309] item 2 key (30408704 192 268435456) itemoff 16202 itemsize 2=
4
[   39.860310] block group used 65536 chunk_objectid 256 flags 36
[   39.860311] item 3 key (30441472 169 0) itemoff 16169 itemsize 33
[   39.860312] extent refs 1 gen 10079 flags 2
[   39.860312] ref#0: tree block backref root 18446744073709551607
[   39.860313] item 4 key (30457856 169 0) itemoff 16136 itemsize 33
[   39.860314] extent refs 1 gen 10086 flags 2
[   39.860314] ref#0: tree block backref root 7
[   39.860315] item 5 key (30474240 169 0) itemoff 16103 itemsize 33
[   39.860316] extent refs 1 gen 10086 flags 2
[   39.860316] ref#0: tree block backref root 2
[   39.860317] item 6 key (30490624 169 0) itemoff 16070 itemsize 33
[   39.860318] extent refs 1 gen 10086 flags 2
[   39.860318] ref#0: tree block backref root 1
[   39.860319] item 7 key (13183746048 192 1073741824) itemoff 16046 itemsi=
ze 24
[   39.860320] block group used 0 chunk_objectid 256 flags 1
[   39.860321] BTRFS error (device dm-3): unable to find ref byte nr
22036480 parent 0 root 3  owner 0 offset 0
[   39.860323] ------------[ cut here ]------------
[   39.860324] BTRFS: Transaction aborted (error -2)
[   39.860350] WARNING: CPU: 0 PID: 727 at fs/btrfs/extent-tree.c:3077
__btrfs_free_extent.isra.0+0x6ff/0x980 [btrfs]
[   39.860351] Modules linked in: joydev(E) pktcdvd(E)
snd_intel8x0(E+) snd_ac97_codec(E) ac97_bus(E) snd_pcm(E) snd_timer(E)
snd(E) soundcore(E) sg(E) evdev(E) serio_raw(E) ac(E) pcspkr(E)
edac_mce_amd(E) parport_pc(E) ppdev(E) lp(E) parport(E) ip_tables(E)
x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) xfs(E)
btrfs(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E)
libcrc32c(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E)
nls_ascii(E) hid_generic(E) usbhid(E) hid(E) crct10dif_pclmul(E)
crc32_pclmul(E) crc32c_intel(E) sr_mod(E) cdrom(E) sd_mod(E)
ghash_clmulni_intel(E) ata_generic(E) xhci_pci(E) vmwgfx(E)
xhci_hcd(E) ttm(E) ata_piix(E) aesni_intel(E) libata(E) crypto_simd(E)
drm_kms_helper(E) cryptd(E) e1000(E) glue_helper(E) usbcore(E)
psmouse(E) usb_common(E) i2c_piix4(E) drm(E) scsi_mod(E) video(E)
button(E)
[   39.860377] CPU: 0 PID: 727 Comm: mount Tainted: G        W   E
5.4.0-4parrot1-amd64 #1 Parrot 5.4.19-4parrot1
[   39.860377] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[   39.860401] RIP: 0010:__btrfs_free_extent.isra.0+0x6ff/0x980 [btrfs]
[   39.860402] Code: 8b 40 50 f0 48 0f ba a8 30 17 00 00 02 0f 92 c0
5e 84 c0 0f 85 74 7e 0a 00 be fe ff ff ff 48 c7 c7 28 ce 7f c0 e8 6f
31 34 e7 <0f> 0b e9 5c 7e 0a 00 83 e8 01 49 8b 3c 24 b9 11 00 00 00 48
8d 74
[   39.860403] RSP: 0018:ffffae6f40427938 EFLAGS: 00010282
[   39.860404] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00006
[   39.860404] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff890ad9a=
17680
[   39.860405] RBP: 0000000001504000 R08: 0000000000000278 R09: 00000000000=
00004
[   39.860406] R10: 0000000000000000 R11: 0000000000000001 R12: ffff890aca4=
801c0
[   39.860406] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000fff=
ffffe
[   39.860407] FS:  00007fc7f83b6c80(0000) GS:ffff890ad9a00000(0000)
knlGS:0000000000000000
[   39.860415] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.860416] CR2: 000055a574d179d8 CR3: 000000019772a000 CR4: 00000000000=
406f0
[   39.860419] Call Trace:
[   39.860438]  ? btrfs_merge_delayed_refs+0x31a/0x370 [btrfs]
[   39.860452]  __btrfs_run_delayed_refs+0x749/0xf90 [btrfs]
[   39.860454]  ? kmem_cache_alloc+0x159/0x210
[   39.860468]  btrfs_run_delayed_refs+0x72/0x190 [btrfs]
[   39.860483]  btrfs_commit_transaction+0x54/0x9a0 [btrfs]
[   39.860498]  ? start_transaction+0x95/0x480 [btrfs]
[   39.860512]  close_ctree+0x29d/0x2f0 [btrfs]
[   39.860541]  btrfs_mount_root+0x66c/0x690 [btrfs]
[   39.860543]  ? __lookup_constant+0x46/0x60
[   39.860544]  legacy_get_tree+0x27/0x40
[   39.860546]  vfs_get_tree+0x25/0xb0
[   39.860547]  fc_mount+0xe/0x30
[   39.860548]  vfs_kern_mount.part.0+0x71/0x90
[   39.860562]  btrfs_mount+0x155/0x8a0 [btrfs]
[   39.860564]  ? filename_lookup+0xf1/0x170
[   39.860566]  ? tomoyo_init_request_info+0x86/0x90
[   39.860567]  ? tomoyo_mount_permission+0x3e/0x1c0
[   39.860569]  ? __lookup_constant+0x46/0x60
[   39.860571]  ? legacy_get_tree+0x27/0x40
[   39.860573]  legacy_get_tree+0x27/0x40
[   39.860574]  vfs_get_tree+0x25/0xb0
[   39.860576]  do_mount+0x770/0x980
[   39.860578]  ksys_mount+0x7e/0xc0
[   39.860579]  __x64_sys_mount+0x21/0x30
[   39.860580]  do_syscall_64+0x52/0x160
[   39.860582]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   39.860583] RIP: 0033:0x7fc7f825acda
[   39.860584] Code: 48 8b 0d b9 e1 0b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 86 e1 0b 00 f7 d8 64 89
01 48
[   39.860585] RSP: 002b:00007fffe3040f48 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[   39.860586] RAX: ffffffffffffffda RBX: 00005633fb563a00 RCX: 00007fc7f82=
5acda
[   39.860586] RDX: 00005633fb563c10 RSI: 00005633fb563cf0 RDI: 00005633fb5=
63c30
[   39.860587] RBP: 00007fc7f83b0204 R08: 00005633fb563c80 R09: 00007fc7f82=
9b4c0
[   39.860588] R10: 0000000000000c00 R11: 0000000000000246 R12: 00000000000=
00000
[   39.860588] R13: 0000000000000c00 R14: 00005633fb563c30 R15: 00005633fb5=
63c10
[   39.860590] ---[ end trace 2155c25bb5f33a75 ]---
[   39.860592] BTRFS: error (device dm-3) in __btrfs_free_extent:3077:
errno=3D-2 No such entry
[   39.860594] BTRFS: error (device dm-3) in
btrfs_run_delayed_refs:2188: errno=3D-2 No such entry
[   39.860618] BTRFS error (device dm-3): commit super ret -2
[   39.932199] vboxguest: loading out-of-tree module taints kernel.
[   40.418019] Adding 5246972k swap on /dev/mapper/parrot--vg-swap_1.
Priority:-2 extents:1 across:5246972k FS
[   40.779979] vgdrvHeartbeatInit: Setting up heartbeat to trigger
every 2000 milliseconds
[   40.780115] input: Unspecified device as
/devices/pci0000:00/0000:00:04.0/input/input8
[   40.780867] vboxguest: misc device minor 60, IRQ 20, I/O port d040,
MMIO at 00000000f8400000 (size 0x400000)
[   40.780868] vboxguest: Successfully loaded version 6.0.18
(interface 0x00010004)
[   40.866726] EXT4-fs (sda1): mounted filesystem with ordered data
mode. Opts: (null)
[   42.350631] snd_intel8x0 0000:00:05.0: intel8x0_measure_ac97_clock:
measured 57999 usecs (8192 samples)
[   42.350633] snd_intel8x0 0000:00:05.0: measured clock 141243 rejected
[   42.731577] snd_intel8x0 0000:00:05.0: intel8x0_measure_ac97_clock:
measured 60660 usecs (9600 samples)
[   42.731580] snd_intel8x0 0000:00:05.0: measured clock 158259 rejected
[   43.119880] snd_intel8x0 0000:00:05.0: measure - unreliable DMA position=
..
[   43.119884] snd_intel8x0 0000:00:05.0: clocking to 48000
[   43.203100] audit: type=3D1400 audit(1585436078.184:2):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"firejail-default" pid=3D778 comm=3D"apparmor_parser"
[   43.315019] audit: type=3D1400 audit(1585436078.296:3):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"nvidia_modprobe" pid=3D783 comm=3D"apparmor_parser"
[   43.315023] audit: type=3D1400 audit(1585436078.296:4):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"nvidia_modprobe//kmod" pid=3D783 comm=3D"apparmor_parser"
[   43.327935] audit: type=3D1400 audit(1585436078.308:5):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"lsb_release" pid=3D782 comm=3D"apparmor_parser"
[   43.343806] audit: type=3D1400 audit(1585436078.324:6):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"klogd" pid=3D784 comm=3D"apparmor_parser"
[   43.351744] audit: type=3D1400 audit(1585436078.332:7):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"ping" pid=3D777 comm=3D"apparmor_parser"
[   43.363873] audit: type=3D1400 audit(1585436078.344:8):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"syslog-ng" pid=3D785 comm=3D"apparmor_parser"
[   43.369651] audit: type=3D1400 audit(1585436078.348:9):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"syslogd" pid=3D786 comm=3D"apparmor_parser"
[   43.413207] audit: type=3D1400 audit(1585436078.392:10):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"system_tor" pid=3D788 comm=3D"apparmor_parser"
[   43.415977] audit: type=3D1400 audit(1585436078.396:11):
apparmor=3D"STATUS" operation=3D"profile_load" profile=3D"unconfined"
name=3D"/usr/lib/x86_64-linux-gnu/lightdm/lightdm-guest-session" pid=3D779
comm=3D"apparmor_parser"
[  158.875680] usb 1-2: new high-speed USB device number 3 using xhci_hcd
[  158.917898] usb 1-2: New USB device found, idVendor=3D0951,
idProduct=3D1666, bcdDevice=3D 0.01
[  158.917900] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3
[  158.917901] usb 1-2: Product: DataTraveler 3.0
[  158.917902] usb 1-2: Manufacturer: Kingston
[  158.917903] usb 1-2: SerialNumber: 60A44C3FAE22F261D9795502
[  159.047039] usb-storage 1-2:1.0: USB Mass Storage device detected
[  159.047498] scsi host2: usb-storage 1-2:1.0
[  159.047634] usbcore: registered new interface driver usb-storage
[  159.072497] usbcore: registered new interface driver uas
[  160.090260] scsi 2:0:0:0: Direct-Access     Kingston DataTraveler
3.0      PQ: 0 ANSI: 6
[  160.090626] sd 2:0:0:0: Attached scsi generic sg2 type 0
[  160.092191] sd 2:0:0:0: [sdb] 60437492 512-byte logical blocks:
(30.9 GB/28.8 GiB)
[  160.093082] sd 2:0:0:0: [sdb] Write Protect is off
[  160.093084] sd 2:0:0:0: [sdb] Mode Sense: 4f 00 00 00
[  160.093898] sd 2:0:0:0: [sdb] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[  160.114357]  sdb: sdb1
[  160.120329] sd 2:0:0:0: [sdb] Attached SCSI removable disk
[  198.553901] FAT-fs (sdb1): Volume was not properly unmounted. Some
data may be corrupt. Please run fsck.
[  581.945367] BTRFS info (device dm-3): disk space caching is enabled
[  581.945369] BTRFS info (device dm-3): has skinny extents
[  581.953033] BTRFS info (device dm-3): checking UUID tree
[  581.953474] BTRFS error (device dm-3): parent transid verify failed
on 37978112 wanted 10077 found 10086
[  581.955009] BTRFS error (device dm-3): parent transid verify failed
on 37978112 wanted 10077 found 10086
[  581.956499] ------------[ cut here ]------------
[  581.956534] WARNING: CPU: 2 PID: 1121 at
fs/btrfs/extent-tree.c:3071 __btrfs_free_extent.isra.0+0x6a0/0x980
[btrfs]
[  581.956535] Modules linked in: nls_cp437(E) vfat(E) fat(E) uas(E)
usb_storage(E) binfmt_misc(E) vboxguest(OE) joydev(E) pktcdvd(E)
snd_intel8x0(E) snd_ac97_codec(E) ac97_bus(E) snd_pcm(E) snd_timer(E)
snd(E) soundcore(E) sg(E) evdev(E) serio_raw(E) ac(E) pcspkr(E)
edac_mce_amd(E) parport_pc(E) ppdev(E) lp(E) parport(E) ip_tables(E)
x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) xfs(E)
btrfs(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E)
libcrc32c(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E)
nls_ascii(E) hid_generic(E) usbhid(E) hid(E) crct10dif_pclmul(E)
crc32_pclmul(E) crc32c_intel(E) sr_mod(E) cdrom(E) sd_mod(E)
ghash_clmulni_intel(E) ata_generic(E) xhci_pci(E) vmwgfx(E)
xhci_hcd(E) ttm(E) ata_piix(E) aesni_intel(E) libata(E) crypto_simd(E)
drm_kms_helper(E) cryptd(E) e1000(E) glue_helper(E) usbcore(E)
psmouse(E)
[  581.956561]  usb_common(E) i2c_piix4(E) drm(E) scsi_mod(E) video(E) butt=
on(E)
[  581.956566] CPU: 2 PID: 1121 Comm: mount Tainted: G        W  OE
 5.4.0-4parrot1-amd64 #1 Parrot 5.4.19-4parrot1
[  581.956566] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  581.956580] RIP: 0010:__btrfs_free_extent.isra.0+0x6a0/0x980 [btrfs]
[  581.956582] Code: ff ff 48 8b 3c 24 4d 89 f0 4c 89 e9 48 c7 44 24
48 00 00 00 00 48 89 ea 4c 89 e6 e8 9a b4 ff ff 41 89 c7 e9 8e fb ff
ff 0f 0b <0f> 0b 49 8b 3c 24 e8 65 5a 00 00 49 89 d9 4d 89 f0 4c 89 e9
ff b4
[  581.956582] RSP: 0018:ffffae6f4098f938 EFLAGS: 00010246
[  581.956583] RAX: 00000000fffffffe RBX: 0000000000000000 RCX: 00000000000=
00002
[  581.956584] RDX: 00000000fffffffe RSI: 0000000000000000 RDI: 00000000000=
00000
[  581.956585] RBP: 0000000001504000 R08: 0000000000000000 R09: 00000000000=
00000
[  581.956585] R10: 0000000000000002 R11: 0000000000000000 R12: ffff890ad60=
34e70
[  581.956586] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000fff=
ffffe
[  581.956587] FS:  00007fdf879b6c80(0000) GS:ffff890ad9b00000(0000)
knlGS:0000000000000000
[  581.956588] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  581.956588] CR2: 0000560978b6fe70 CR3: 000000019678e000 CR4: 00000000000=
406e0
[  581.956592] Call Trace:
[  581.956617]  ? btrfs_merge_delayed_refs+0x31a/0x370 [btrfs]
[  581.956631]  __btrfs_run_delayed_refs+0x749/0xf90 [btrfs]
[  581.956635]  ? kmem_cache_alloc+0x159/0x210
[  581.956648]  btrfs_run_delayed_refs+0x72/0x190 [btrfs]
[  581.956664]  btrfs_commit_transaction+0x54/0x9a0 [btrfs]
[  581.956679]  ? start_transaction+0x95/0x480 [btrfs]
[  581.956693]  close_ctree+0x29d/0x2f0 [btrfs]
[  581.956707]  btrfs_mount_root+0x66c/0x690 [btrfs]
[  581.956711]  ? __lookup_constant+0x46/0x60
[  581.956712]  legacy_get_tree+0x27/0x40
[  581.956714]  vfs_get_tree+0x25/0xb0
[  581.956716]  fc_mount+0xe/0x30
[  581.956718]  vfs_kern_mount.part.0+0x71/0x90
[  581.956730]  btrfs_mount+0x155/0x8a0 [btrfs]
[  581.956732]  ? vfs_parse_fs_string+0x5d/0xb0
[  581.956734]  ? filename_lookup+0xf1/0x170
[  581.956736]  ? __lookup_constant+0x46/0x60
[  581.956737]  ? legacy_get_tree+0x27/0x40
[  581.956738]  legacy_get_tree+0x27/0x40
[  581.956739]  vfs_get_tree+0x25/0xb0
[  581.956741]  do_mount+0x770/0x980
[  581.956743]  ? memdup_user+0x4e/0x90
[  581.956744]  ksys_mount+0x7e/0xc0
[  581.956745]  __x64_sys_mount+0x21/0x30
[  581.956748]  do_syscall_64+0x52/0x160
[  581.956751]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  581.956753] RIP: 0033:0x7fdf8782acda
[  581.956754] Code: 48 8b 0d b9 e1 0b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 86 e1 0b 00 f7 d8 64 89
01 48
[  581.956755] RSP: 002b:00007fffd3661ee8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[  581.956756] RAX: ffffffffffffffda RBX: 0000557f5de81a00 RCX: 00007fdf878=
2acda
[  581.956756] RDX: 0000557f5de893f0 RSI: 0000557f5de83920 RDI: 0000557f5de=
81c10
[  581.956757] RBP: 00007fdf87980204 R08: 0000000000000000 R09: 00007fdf878=
6b4c0
[  581.956757] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[  581.956758] R13: 0000000000000000 R14: 0000557f5de81c10 R15: 0000557f5de=
893f0
[  581.956759] ---[ end trace 2155c25bb5f33a76 ]---
[  581.956761] BTRFS info (device dm-3): leaf 30605312 gen 10087 total
ptrs 8 free space 15846 owner 2
[  581.956763] item 0 key (22020096 169 0) itemoff 16250 itemsize 33
[  581.956763] extent refs 1 gen 10087 flags 2
[  581.956764] ref#0: tree block backref root 3
[  581.956765] item 1 key (22020096 192 8388608) itemoff 16226 itemsize 24
[  581.956766] block group used 0 chunk_objectid 256 flags 34
[  581.956767] item 2 key (30408704 192 268435456) itemoff 16202 itemsize 2=
4
[  581.956768] block group used 65536 chunk_objectid 256 flags 36
[  581.956769] item 3 key (30441472 169 0) itemoff 16169 itemsize 33
[  581.956769] extent refs 1 gen 10079 flags 2
[  581.956770] ref#0: tree block backref root 18446744073709551607
[  581.956771] item 4 key (30457856 169 0) itemoff 16136 itemsize 33
[  581.956771] extent refs 1 gen 10086 flags 2
[  581.956772] ref#0: tree block backref root 7
[  581.956773] item 5 key (30474240 169 0) itemoff 16103 itemsize 33
[  581.956773] extent refs 1 gen 10086 flags 2
[  581.956774] ref#0: tree block backref root 2
[  581.956775] item 6 key (30490624 169 0) itemoff 16070 itemsize 33
[  581.956775] extent refs 1 gen 10086 flags 2
[  581.956776] ref#0: tree block backref root 1
[  581.956777] item 7 key (13183746048 192 1073741824) itemoff 16046 itemsi=
ze 24
[  581.956777] block group used 0 chunk_objectid 256 flags 1
[  581.956779] BTRFS error (device dm-3): unable to find ref byte nr
22036480 parent 0 root 3  owner 0 offset 0
[  581.957839] ------------[ cut here ]------------
[  581.957840] BTRFS: Transaction aborted (error -2)
[  581.957874] WARNING: CPU: 2 PID: 1121 at
fs/btrfs/extent-tree.c:3077 __btrfs_free_extent.isra.0+0x6ff/0x980
[btrfs]
[  581.957874] Modules linked in: nls_cp437(E) vfat(E) fat(E) uas(E)
usb_storage(E) binfmt_misc(E) vboxguest(OE) joydev(E) pktcdvd(E)
snd_intel8x0(E) snd_ac97_codec(E) ac97_bus(E) snd_pcm(E) snd_timer(E)
snd(E) soundcore(E) sg(E) evdev(E) serio_raw(E) ac(E) pcspkr(E)
edac_mce_amd(E) parport_pc(E) ppdev(E) lp(E) parport(E) ip_tables(E)
x_tables(E) autofs4(E) dm_crypt(E) dm_mod(E) raid10(E) raid456(E)
async_raid6_recov(E) async_memcpy(E) async_pq(E) async_xor(E)
async_tx(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) xfs(E)
btrfs(E) xor(E) zstd_decompress(E) zstd_compress(E) raid6_pq(E)
libcrc32c(E) ext4(E) crc16(E) mbcache(E) jbd2(E) crc32c_generic(E)
nls_ascii(E) hid_generic(E) usbhid(E) hid(E) crct10dif_pclmul(E)
crc32_pclmul(E) crc32c_intel(E) sr_mod(E) cdrom(E) sd_mod(E)
ghash_clmulni_intel(E) ata_generic(E) xhci_pci(E) vmwgfx(E)
xhci_hcd(E) ttm(E) ata_piix(E) aesni_intel(E) libata(E) crypto_simd(E)
drm_kms_helper(E) cryptd(E) e1000(E) glue_helper(E) usbcore(E)
psmouse(E)
[  581.957912]  usb_common(E) i2c_piix4(E) drm(E) scsi_mod(E) video(E) butt=
on(E)
[  581.957915] CPU: 2 PID: 1121 Comm: mount Tainted: G        W  OE
 5.4.0-4parrot1-amd64 #1 Parrot 5.4.19-4parrot1
[  581.957915] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  581.957929] RIP: 0010:__btrfs_free_extent.isra.0+0x6ff/0x980 [btrfs]
[  581.957931] Code: 8b 40 50 f0 48 0f ba a8 30 17 00 00 02 0f 92 c0
5e 84 c0 0f 85 74 7e 0a 00 be fe ff ff ff 48 c7 c7 28 ce 7f c0 e8 6f
31 34 e7 <0f> 0b e9 5c 7e 0a 00 83 e8 01 49 8b 3c 24 b9 11 00 00 00 48
8d 74
[  581.957931] RSP: 0018:ffffae6f4098f938 EFLAGS: 00010282
[  581.957932] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00006
[  581.957933] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff890ad9b=
17680
[  581.957933] RBP: 0000000001504000 R08: 000000000000032b R09: 00000000000=
00004
[  581.957934] R10: 0000000000000000 R11: 0000000000000001 R12: ffff890ad60=
34e70
[  581.957935] R13: 0000000000000000 R14: 0000000000000003 R15: 00000000fff=
ffffe
[  581.957935] FS:  00007fdf879b6c80(0000) GS:ffff890ad9b00000(0000)
knlGS:0000000000000000
[  581.957936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  581.957937] CR2: 0000560978b6fe70 CR3: 000000019678e000 CR4: 00000000000=
406e0
[  581.957940] Call Trace:
[  581.957959]  ? btrfs_merge_delayed_refs+0x31a/0x370 [btrfs]
[  581.957973]  __btrfs_run_delayed_refs+0x749/0xf90 [btrfs]
[  581.957975]  ? kmem_cache_alloc+0x159/0x210
[  581.957989]  btrfs_run_delayed_refs+0x72/0x190 [btrfs]
[  581.958004]  btrfs_commit_transaction+0x54/0x9a0 [btrfs]
[  581.958018]  ? start_transaction+0x95/0x480 [btrfs]
[  581.958033]  close_ctree+0x29d/0x2f0 [btrfs]
[  581.958046]  btrfs_mount_root+0x66c/0x690 [btrfs]
[  581.958048]  ? __lookup_constant+0x46/0x60
[  581.958050]  legacy_get_tree+0x27/0x40
[  581.958051]  vfs_get_tree+0x25/0xb0
[  581.958052]  fc_mount+0xe/0x30
[  581.958053]  vfs_kern_mount.part.0+0x71/0x90
[  581.958066]  btrfs_mount+0x155/0x8a0 [btrfs]
[  581.958068]  ? vfs_parse_fs_string+0x5d/0xb0
[  581.958069]  ? filename_lookup+0xf1/0x170
[  581.958071]  ? __lookup_constant+0x46/0x60
[  581.958072]  ? legacy_get_tree+0x27/0x40
[  581.958073]  legacy_get_tree+0x27/0x40
[  581.958074]  vfs_get_tree+0x25/0xb0
[  581.958076]  do_mount+0x770/0x980
[  581.958077]  ? memdup_user+0x4e/0x90
[  581.958078]  ksys_mount+0x7e/0xc0
[  581.958079]  __x64_sys_mount+0x21/0x30
[  581.958081]  do_syscall_64+0x52/0x160
[  581.958082]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  581.958083] RIP: 0033:0x7fdf8782acda
[  581.958084] Code: 48 8b 0d b9 e1 0b 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 86 e1 0b 00 f7 d8 64 89
01 48
[  581.958085] RSP: 002b:00007fffd3661ee8 EFLAGS: 00000246 ORIG_RAX:
00000000000000a5
[  581.958086] RAX: ffffffffffffffda RBX: 0000557f5de81a00 RCX: 00007fdf878=
2acda
[  581.958087] RDX: 0000557f5de893f0 RSI: 0000557f5de83920 RDI: 0000557f5de=
81c10
[  581.958087] RBP: 00007fdf87980204 R08: 0000000000000000 R09: 00007fdf878=
6b4c0
[  581.958088] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[  581.958088] R13: 0000000000000000 R14: 0000557f5de81c10 R15: 0000557f5de=
893f0
[  581.958089] ---[ end trace 2155c25bb5f33a77 ]---
[  581.958091] BTRFS: error (device dm-3) in __btrfs_free_extent:3077:
errno=3D-2 No such entry
[  581.958594] BTRFS: error (device dm-3) in
btrfs_run_delayed_refs:2188: errno=3D-2 No such entry
[  581.959193] BTRFS error (device dm-3): commit super ret -2
