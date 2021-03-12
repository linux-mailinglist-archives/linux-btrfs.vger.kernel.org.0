Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4B3386C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 08:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhCLHsL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhCLHrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 02:47:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92728C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 23:47:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mm21so51463402ejb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 23:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=NEmv5/VespBrdBGI3rtYtNRNor+0csrKiyW4gt0QxxQ=;
        b=Tb8gZTMFFngWHEgY9YckEbc37XAiVXJG/I3dI0HMseVIwkjfd6zyUYqTN22kqoa/Rd
         tkTvkiOL9glfB7JwAxUdUXflNFUJY3wst1Xxd29a2AiLic/Lu1A6sQsP6tZTA9UW5XqJ
         07+4Bv5SiLdnU4q+jA07gSeQsLTVNsSgceH1rgzZcLviUykiVm4ltxW/s9cjOwDqn+lv
         NL6MpStHp2ndTGWLBK9+bVI7eFzJYRNX2A6fu17DN2tq8sXlntCcUJbW/o2c5hAY2d0i
         M8qImCq52TpakuI6V0exAuXEdJmcLe7TGf8ELOiFpHo/PN6iuEZgnmmux/aE6dgQdxFV
         K/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=NEmv5/VespBrdBGI3rtYtNRNor+0csrKiyW4gt0QxxQ=;
        b=iXh5KxVPj8mRuxswr4ByrM5VJLEuoLCyI4wqZozQw2IV7dDX8r8FZEBPtAL74oG9+A
         NICYSVOy7IMR3ecHHlFS/3rpZMNzKu2kzKYHNHXPDLn4TYT4Q33Kfyf0iPwFVXB29a52
         b+LfjOVwkvUux6va8FnFctUUTF5U/5Spzdj8P9ugY/BaHl8ePfPFSryQYuT9RNg6WDBO
         uBPD3MDuy9zAdvYSeqs+ShA6l+3PiKBoKSCjYU223gvE/MCkvNxXzJl+ACrlOK52GbpU
         HgrLguzJI84lqqLMqPbvsn7eMILc1kIOm6oCo8/d6wjTfJdwCaiZhIH9aROnhhOn4PiB
         6dKw==
X-Gm-Message-State: AOAM531rlKxZlbKPRXuCxiDQMr2XVNel2Uah37GzW+PTWLiJWR7eTS99
        QsV4Qw+cu7iRzHYQf8LympgYyjX1ntY=
X-Google-Smtp-Source: ABdhPJx98HgiuJ9OOXtzVhMg4dwhuU16EnUp3Sq7viSuF1CEoqrWomN0LQUdjxl1ShrGKOtl+lguEA==
X-Received: by 2002:a17:906:f210:: with SMTP id gt16mr7019817ejb.206.1615535259218;
        Thu, 11 Mar 2021 23:47:39 -0800 (PST)
Received: from [192.168.1.11] (b2b-94-79-184-225.unitymedia.biz. [94.79.184.225])
        by smtp.gmail.com with ESMTPSA id gj26sm2301818ejb.67.2021.03.11.23.47.37
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 23:47:38 -0800 (PST)
To:     linux-btrfs@vger.kernel.org
From:   Thomas <74cmonty@gmail.com>
Subject: BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd
 2719033, flush 0, corrupt 6, gen 0
Message-ID: <ef3da480-d00d-877e-2349-6d7b2ebda05e@gmail.com>
Date:   Fri, 12 Mar 2021 08:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B8888A802AA19D7DE9FF1BA0"
Content-Language: de-DE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------B8888A802AA19D7DE9FF1BA0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

I have observed this error messages in systemd journal:
BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719033,
flush 0, corrupt 6, gen 0

Here are the bottom lines of journalctl -xb:
är 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=524288, want=497859712,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=524288, want=497859840,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=256, want=497859704,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719033, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=256, want=497859720,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=524288, want=497859968,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719034, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=256, want=497859728,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=256, want=497859712,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719035, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=524288, want=497860096,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719036, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=256, want=497859736,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: attempt to access beyond end of device
                                     sdb1: rw=256, want=497859848,
limit=496091703
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719037, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719038, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719039, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719040, flush 0, corrupt 6, gen 0
Mär 12 08:30:41 pc1-desktop kernel: BTRFS error (device sda1): bdev
/dev/sdb1 errs: wr 2702175, rd 2719041, flush 0, corrupt 6, gen 0


I have configured a multidrive setup with 2 identical SSDs.

[root@pc1-desktop ~]# uname -a
Linux pc1-desktop 5.10.22-2-lts #1 SMP Wed, 10 Mar 2021 10:30:57 +0000
x86_64 GNU/Linux
[root@pc1-desktop ~]# btrfs --version
btrfs-progs v5.11
[root@pc1-desktop ~]# btrfs fi show
Label: 'archlinux'  uuid: 78462a70-55ad-4444-9d91-e71e42cce51c
    Total devices 2 FS bytes used 178.93GiB
    devid    1 size 236.55GiB used 233.50GiB path /dev/sda1
    devid    2 size 238.47GiB used 233.50GiB path /dev/sdb1

Label: 'backup'  uuid: de094dc0-58b7-4931-b948-4b920495bf94
    Total devices 1 FS bytes used 210.97GiB
    devid    1 size 232.89GiB used 228.87GiB path /dev/sdd

[root@pc1-desktop ~]# btrfs fi df /
Data, RAID1: total=229.47GiB, used=175.82GiB
System, RAID1: total=32.00MiB, used=64.00KiB
Metadata, RAID1: total=4.00GiB, used=3.11GiB
GlobalReserve, single: total=512.00MiB, used=0.00B


Can you please advise how to fix these errors?


Regards
Thomas

--------------B8888A802AA19D7DE9FF1BA0
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] microcode: microcode updated early to revision 0x70a, date = 2010-09-29
[    0.000000] Linux version 5.10.22-2-lts (linux-lts@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP Wed, 10 Mar 2021 10:30:57 +0000
[    0.000000] Command line: BOOT_IMAGE=/@/boot/vmlinuz-linux-lts root=UUID=78462a70-55ad-4444-9d91-e71e42cce51c rw rootflags=subvol=@ loglevel=3
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f800-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000cfedffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cfee0000-0x00000000cfee2fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cfee3000-0x00000000cfeeffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cfef0000-0x00000000cfefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. P35-DS4/P35-DS4, BIOS F15b 12/22/2010
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2833.366 MHz processor
[    0.003264] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.003268] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.003273] last_pfn = 0x230000 max_arch_pfn = 0x400000000
[    0.003278] MTRR default type: uncachable
[    0.003279] MTRR fixed ranges enabled:
[    0.003281]   00000-9FFFF write-back
[    0.003282]   A0000-BFFFF uncachable
[    0.003283]   C0000-CDFFF write-protect
[    0.003284]   CE000-EFFFF uncachable
[    0.003285]   F0000-FFFFF write-through
[    0.003286] MTRR variable ranges enabled:
[    0.003288]   0 base 000000000 mask F00000000 write-back
[    0.003289]   1 base 0E0000000 mask FE0000000 uncachable
[    0.003290]   2 base 0D0000000 mask FF0000000 uncachable
[    0.003292]   3 base 100000000 mask F00000000 write-back
[    0.003293]   4 base 200000000 mask FC0000000 write-back
[    0.003294]   5 base 230000000 mask FF0000000 uncachable
[    0.003295]   6 base 0CFF00000 mask FFFF00000 uncachable
[    0.003296]   7 disabled
[    0.004656] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.004843] total RAM covered: 8191M
[    0.005191] Found optimal setting for mtrr clean up
[    0.005193]  gran_size: 64K 	chunk_size: 2M 	num_reg: 7  	lose cover RAM: 0G
[    0.006510] e820: update [mem 0xcff00000-0xffffffff] usable ==> reserved
[    0.006518] last_pfn = 0xcfee0 max_arch_pfn = 0x400000000
[    0.011544] found SMP MP-table at [mem 0x000f5030-0x000f503f]
[    0.020541] check: Scanning 1 areas for low memory corruption
[    0.020834] RAMDISK: [mem 0x36027000-0x3700afff]
[    0.020843] ACPI: Early table checksum verification disabled
[    0.020848] ACPI: RSDP 0x00000000000F6A20 000014 (v00 GBT   )
[    0.020852] ACPI: RSDT 0x00000000CFEE3040 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.020859] ACPI: FACP 0x00000000CFEE30C0 000074 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.020866] ACPI: DSDT 0x00000000CFEE3180 004B2A (v01 GBT    GBTUACPI 00001000 MSFT 0100000C)
[    0.020870] ACPI: FACS 0x00000000CFEE0000 000040
[    0.020874] ACPI: HPET 0x00000000CFEE7E00 000038 (v01 GBT    GBTUACPI 42302E31 GBTU 00000098)
[    0.020878] ACPI: MCFG 0x00000000CFEE7E80 00003C (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.020882] ACPI: APIC 0x00000000CFEE7D00 000084 (v01 GBT    GBTUACPI 42302E31 GBTU 01010101)
[    0.020887] ACPI: SSDT 0x00000000CFEE87E0 0003AB (v01 PmRef  CpuPm    00003000 INTL 20040311)
[    0.020897] ACPI: Local APIC address 0xfee00000
[    0.020939] No NUMA configuration found
[    0.020940] Faking a node at [mem 0x0000000000000000-0x000000022fffffff]
[    0.020944] NODE_DATA(0) allocated [mem 0x22fff8000-0x22fffbfff]
[    0.070183] Zone ranges:
[    0.070186]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.070189]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.070191]   Normal   [mem 0x0000000100000000-0x000000022fffffff]
[    0.070193]   Device   empty
[    0.070194] Movable zone start for each node
[    0.070195] Early memory node ranges
[    0.070197]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.070198]   node   0: [mem 0x0000000000100000-0x00000000cfedffff]
[    0.070200]   node   0: [mem 0x0000000100000000-0x000000022fffffff]
[    0.070216] Zeroed struct page in unavailable ranges: 388 pages
[    0.070218] Initmem setup node 0 [mem 0x0000000000001000-0x000000022fffffff]
[    0.070220] On node 0 totalpages: 2096764
[    0.070222]   DMA zone: 64 pages used for memmap
[    0.070223]   DMA zone: 21 pages reserved
[    0.070224]   DMA zone: 3996 pages, LIFO batch:0
[    0.070324]   DMA32 zone: 13244 pages used for memmap
[    0.070325]   DMA32 zone: 847584 pages, LIFO batch:63
[    0.090952]   Normal zone: 19456 pages used for memmap
[    0.090954]   Normal zone: 1245184 pages, LIFO batch:63
[    0.121419] ACPI: PM-Timer IO Port: 0x408
[    0.121421] ACPI: Local APIC address 0xfee00000
[    0.121431] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.121432] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.121433] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
[    0.121434] ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
[    0.121446] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.121448] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.121450] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.121452] ACPI: IRQ0 used by override.
[    0.121453] ACPI: IRQ9 used by override.
[    0.121455] Using ACPI (MADT) for SMP configuration information
[    0.121457] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.121464] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.121481] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.121483] PM: hibernation: Registered nosave memory: [mem 0x0009d000-0x0009ffff]
[    0.121484] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.121485] PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.121487] PM: hibernation: Registered nosave memory: [mem 0xcfee0000-0xcfee2fff]
[    0.121488] PM: hibernation: Registered nosave memory: [mem 0xcfee3000-0xcfeeffff]
[    0.121488] PM: hibernation: Registered nosave memory: [mem 0xcfef0000-0xcfefffff]
[    0.121489] PM: hibernation: Registered nosave memory: [mem 0xcff00000-0xefffffff]
[    0.121490] PM: hibernation: Registered nosave memory: [mem 0xf0000000-0xf3ffffff]
[    0.121491] PM: hibernation: Registered nosave memory: [mem 0xf4000000-0xfebfffff]
[    0.121492] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xffffffff]
[    0.121494] [mem 0xcff00000-0xefffffff] available for PCI devices
[    0.121495] Booting paravirtualized kernel on bare hardware
[    0.121500] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.127714] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:4 nr_node_ids:1
[    0.128301] percpu: Embedded 55 pages/cpu s188416 r8192 d28672 u524288
[    0.128307] pcpu-alloc: s188416 r8192 d28672 u524288 alloc=1*2097152
[    0.128308] pcpu-alloc: [0] 0 1 2 3 
[    0.128335] Built 1 zonelists, mobility grouping on.  Total pages: 2063979
[    0.128336] Policy zone: Normal
[    0.128338] Kernel command line: BOOT_IMAGE=/@/boot/vmlinuz-linux-lts root=UUID=78462a70-55ad-4444-9d91-e71e42cce51c rw rootflags=subvol=@ loglevel=3
[    0.130059] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.130985] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.131043] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
[    0.204585] Memory: 8121232K/8387056K available (14344K kernel code, 2031K rwdata, 8820K rodata, 1772K init, 4284K bss, 265564K reserved, 0K cma-reserved)
[    0.204598] random: get_random_u64 called from __kmem_cache_create+0x26/0x520 with crng_init=0
[    0.204749] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.204768] Kernel/User page tables isolation: enabled
[    0.204794] ftrace: allocating 41667 entries in 163 pages
[    0.220242] ftrace: allocated 163 pages with 4 groups
[    0.220431] rcu: Hierarchical RCU implementation.
[    0.220433] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=4.
[    0.220434] 	Rude variant of Tasks RCU enabled.
[    0.220435] 	Tracing variant of Tasks RCU enabled.
[    0.220436] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.220437] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.224789] NR_IRQS: 20736, nr_irqs: 456, preallocated irqs: 16
[    0.225038] Console: colour dummy device 80x25
[    0.225051] printk: console [tty0] enabled
[    0.225075] ACPI: Core revision 20200925
[    0.225823] hpet: Config register invalid. Disabling HPET
[    0.225852] APIC: Switch to symmetric I/O mode setup
[    0.226204] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.275839] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28d76054f1c, max_idle_ns: 440795235282 ns
[    0.275843] Calibrating delay loop (skipped), value calculated using timer frequency.. 5666.73 BogoMIPS (lpj=28333660)
[    0.275846] pid_max: default: 32768 minimum: 301
[    0.275870] LSM: Security Framework initializing
[    0.275876] Yama: becoming mindful.
[    0.275885] LSM support for eBPF active
[    0.275938] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.275976] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.276284] mce: CPU0: Thermal monitoring enabled (TM2)
[    0.276287] process: using mwait in idle threads
[    0.276291] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.276292] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.276294] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.276296] Spectre V2 : Mitigation: Full generic retpoline
[    0.276297] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.276298] Speculative Store Bypass: Vulnerable
[    0.276300] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.276475] Freeing SMP alternatives memory: 36K
[    0.400670] smpboot: CPU0: Intel(R) Core(TM)2 Quad  CPU   Q9550  @ 2.83GHz (family: 0x6, model: 0x17, stepping: 0x7)
[    0.400851] Performance Events: PEBS fmt0+, Core2 events, 4-deep LBR, Intel PMU driver.
[    0.400860] ... version:                2
[    0.400861] ... bit width:              40
[    0.400862] ... generic registers:      2
[    0.400863] ... value mask:             000000ffffffffff
[    0.400864] ... max period:             000000007fffffff
[    0.400865] ... fixed-purpose events:   3
[    0.400866] ... event mask:             0000000700000003
[    0.400986] rcu: Hierarchical SRCU implementation.
[    0.401562] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.401633] smp: Bringing up secondary CPUs ...
[    0.401780] x86: Booting SMP configuration:
[    0.401781] .... node  #0, CPUs:      #1 #2 #3
[    0.417887] smp: Brought up 1 node, 4 CPUs
[    0.417887] smpboot: Max logical packages: 1
[    0.417887] smpboot: Total of 4 processors activated (22666.92 BogoMIPS)
[    0.426455] devtmpfs: initialized
[    0.426455] x86/mm: Memory block size: 128MB
[    0.426697] PM: Registering ACPI NVS region [mem 0xcfee0000-0xcfee2fff] (12288 bytes)
[    0.426697] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.426697] futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
[    0.426697] pinctrl core: initialized pinctrl subsystem
[    0.426697] PM: RTC time: 06:18:44, date: 2021-03-12
[    0.426697] NET: Registered protocol family 16
[    0.426697] DMA: preallocated 1024 KiB GFP_KERNEL pool for atomic allocations
[    0.426697] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.426772] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.426783] audit: initializing netlink subsys (disabled)
[    0.426793] audit: type=2000 audit(1615529923.210:1): state=initialized audit_enabled=0 res=1
[    0.426793] thermal_sys: Registered thermal governor 'fair_share'
[    0.426793] thermal_sys: Registered thermal governor 'bang_bang'
[    0.426793] thermal_sys: Registered thermal governor 'step_wise'
[    0.426793] thermal_sys: Registered thermal governor 'user_space'
[    0.426793] thermal_sys: Registered thermal governor 'power_allocator'
[    0.426793] cpuidle: using governor ladder
[    0.426793] cpuidle: using governor menu
[    0.426793] ACPI: bus type PCI registered
[    0.426793] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.426793] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf0000000-0xf3ffffff] (base 0xf0000000)
[    0.426793] PCI: MMCONFIG at [mem 0xf0000000-0xf3ffffff] reserved in E820
[    0.426793] PCI: Using configuration type 1 for base access
[    0.427594] Kprobes globally optimized
[    0.427600] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.427600] ACPI: Added _OSI(Module Device)
[    0.427600] ACPI: Added _OSI(Processor Device)
[    0.427600] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.427600] ACPI: Added _OSI(Processor Aggregator Device)
[    0.427600] ACPI: Added _OSI(Linux-Dell-Video)
[    0.427600] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.427600] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.429727] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.432884] ACPI: Dynamic OEM Table Load:
[    0.432890] ACPI: SSDT 0xFFFF99F4C098A400 00022A (v01 PmRef  Cpu0Ist  00003000 INTL 20040311)
[    0.433310] ACPI: Dynamic OEM Table Load:
[    0.433315] ACPI: SSDT 0xFFFF99F4C0B53A00 000152 (v01 PmRef  Cpu1Ist  00003000 INTL 20040311)
[    0.433689] ACPI: Dynamic OEM Table Load:
[    0.433693] ACPI: SSDT 0xFFFF99F4C0B53600 000152 (v01 PmRef  Cpu2Ist  00003000 INTL 20040311)
[    0.434069] ACPI: Dynamic OEM Table Load:
[    0.434073] ACPI: SSDT 0xFFFF99F4C0B52E00 000152 (v01 PmRef  Cpu3Ist  00003000 INTL 20040311)
[    0.434626] ACPI: Interpreter enabled
[    0.434646] ACPI: (supports S0 S1 S4 S5)
[    0.434647] ACPI: Using IOAPIC for interrupt routing
[    0.434672] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.434862] ACPI: Enabled 11 GPEs in block 00 to 3F
[    0.441031] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    0.441037] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.441338] PCI host bridge to bus 0000:00
[    0.441341] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.441342] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.441344] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.441345] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.441347] pci_bus 0000:00: root bus resource [mem 0xcff00000-0xfebfffff window]
[    0.441348] pci_bus 0000:00: root bus resource [bus 00-3f]
[    0.441361] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
[    0.441477] pci 0000:00:01.0: [8086:29c1] type 01 class 0x060400
[    0.441512] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.441625] pci 0000:00:1a.0: [8086:2937] type 00 class 0x0c0300
[    0.441659] pci 0000:00:1a.0: reg 0x20: [io  0xe000-0xe01f]
[    0.441804] pci 0000:00:1a.1: [8086:2938] type 00 class 0x0c0300
[    0.441837] pci 0000:00:1a.1: reg 0x20: [io  0xe100-0xe11f]
[    0.441981] pci 0000:00:1a.2: [8086:2939] type 00 class 0x0c0300
[    0.442014] pci 0000:00:1a.2: reg 0x20: [io  0xe500-0xe51f]
[    0.442158] pci 0000:00:1a.7: [8086:293c] type 00 class 0x0c0320
[    0.442172] pci 0000:00:1a.7: reg 0x10: [mem 0xf9305000-0xf93053ff]
[    0.442348] pci 0000:00:1b.0: [8086:293e] type 00 class 0x040300
[    0.442362] pci 0000:00:1b.0: reg 0x10: [mem 0xf9300000-0xf9303fff 64bit]
[    0.442425] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.442553] pci 0000:00:1c.0: [8086:2940] type 01 class 0x060400
[    0.442619] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.442750] pci 0000:00:1c.4: [8086:2948] type 01 class 0x060400
[    0.442816] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.442943] pci 0000:00:1c.5: [8086:294a] type 01 class 0x060400
[    0.443009] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.443136] pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300
[    0.443170] pci 0000:00:1d.0: reg 0x20: [io  0xe200-0xe21f]
[    0.443310] pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300
[    0.443344] pci 0000:00:1d.1: reg 0x20: [io  0xe300-0xe31f]
[    0.443484] pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300
[    0.443518] pci 0000:00:1d.2: reg 0x20: [io  0xe400-0xe41f]
[    0.443663] pci 0000:00:1d.7: [8086:293a] type 00 class 0x0c0320
[    0.443677] pci 0000:00:1d.7: reg 0x10: [mem 0xf9304000-0xf93043ff]
[    0.443849] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.444012] pci 0000:00:1f.0: [8086:2916] type 00 class 0x060100
[    0.444082] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000
[    0.444087] pci 0000:00:1f.0: quirk: [io  0x0400-0x047f] claimed by ICH6 ACPI/GPIO/TCO
[    0.444091] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by ICH6 GPIO
[    0.444094] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0800 (mask 000f)
[    0.444096] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 2 PIO at 0290 (mask 000f)
[    0.444239] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
[    0.444249] pci 0000:00:1f.2: reg 0x10: [io  0xe600-0xe607]
[    0.444255] pci 0000:00:1f.2: reg 0x14: [io  0xe700-0xe703]
[    0.444261] pci 0000:00:1f.2: reg 0x18: [io  0xe800-0xe807]
[    0.444267] pci 0000:00:1f.2: reg 0x1c: [io  0xe900-0xe903]
[    0.444273] pci 0000:00:1f.2: reg 0x20: [io  0xea00-0xea1f]
[    0.444279] pci 0000:00:1f.2: reg 0x24: [mem 0xf9306000-0xf93067ff]
[    0.444313] pci 0000:00:1f.2: PME# supported from D3hot
[    0.444424] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
[    0.444438] pci 0000:00:1f.3: reg 0x10: [mem 0xf9307000-0xf93070ff 64bit]
[    0.444454] pci 0000:00:1f.3: reg 0x20: [io  0x0500-0x051f]
[    0.444609] pci 0000:01:00.0: [10de:1402] type 00 class 0x030000
[    0.444620] pci 0000:01:00.0: reg 0x10: [mem 0xf4000000-0xf4ffffff]
[    0.444630] pci 0000:01:00.0: reg 0x14: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.444639] pci 0000:01:00.0: reg 0x1c: [mem 0xe0000000-0xe1ffffff 64bit pref]
[    0.444645] pci 0000:01:00.0: reg 0x24: [io  0xa000-0xa07f]
[    0.444651] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    0.444729] pci 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:00:01.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
[    0.444773] pci 0000:01:00.1: [10de:0fba] type 00 class 0x040300
[    0.444784] pci 0000:01:00.1: reg 0x10: [mem 0xf6000000-0xf6003fff]
[    0.444901] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.444903] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.444905] pci 0000:00:01.0:   bridge window [mem 0xf4000000-0xf6ffffff]
[    0.444908] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xefffffff 64bit pref]
[    0.444967] pci 0000:02:00.0: [1033:0194] type 00 class 0x0c0330
[    0.444995] pci 0000:02:00.0: reg 0x10: [mem 0xf9100000-0xf9101fff 64bit]
[    0.445143] pci 0000:02:00.0: PME# supported from D0 D3hot
[    0.445193] pci 0000:02:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:00:1c.0 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
[    0.445244] pci 0000:00:1c.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[    0.475867] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.475872] pci 0000:00:1c.0:   bridge window [mem 0xf9100000-0xf91fffff]
[    0.475985] pci 0000:03:00.0: [197b:2363] type 00 class 0x010601
[    0.476058] pci 0000:03:00.0: reg 0x24: [mem 0xf9000000-0xf9001fff]
[    0.476125] pci 0000:03:00.0: PME# supported from D3hot
[    0.476232] pci 0000:03:00.1: [197b:2363] type 00 class 0x010185
[    0.476253] pci 0000:03:00.1: reg 0x10: [io  0xb000-0xb007]
[    0.476265] pci 0000:03:00.1: reg 0x14: [io  0xb100-0xb103]
[    0.476277] pci 0000:03:00.1: reg 0x18: [io  0xb200-0xb207]
[    0.476288] pci 0000:03:00.1: reg 0x1c: [io  0xb300-0xb303]
[    0.476300] pci 0000:03:00.1: reg 0x20: [io  0xb400-0xb40f]
[    0.476438] pci 0000:03:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.476448] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.476451] pci 0000:00:1c.4:   bridge window [io  0xb000-0xbfff]
[    0.476453] pci 0000:00:1c.4:   bridge window [mem 0xf9000000-0xf90fffff]
[    0.476514] pci 0000:04:00.0: [10ec:8168] type 00 class 0x020000
[    0.476535] pci 0000:04:00.0: reg 0x10: [io  0xc000-0xc0ff]
[    0.476562] pci 0000:04:00.0: reg 0x18: [mem 0xf8000000-0xf8000fff 64bit]
[    0.476593] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    0.476602] pci 0000:04:00.0: enabling Extended Tags
[    0.476695] pci 0000:04:00.0: supports D1 D2
[    0.476696] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.476788] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.476797] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.476800] pci 0000:00:1c.5:   bridge window [io  0xc000-0xcfff]
[    0.476803] pci 0000:00:1c.5:   bridge window [mem 0xf7000000-0xf8ffffff]
[    0.476819] pci_bus 0000:05: extended config space not accessible
[    0.476846] pci 0000:05:00.0: [10ec:8139] type 00 class 0x020000
[    0.476860] pci 0000:05:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.476868] pci 0000:05:00.0: reg 0x14: [mem 0xf9205000-0xf92050ff]
[    0.476928] pci 0000:05:00.0: supports D1 D2
[    0.476929] pci 0000:05:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.476980] pci 0000:05:06.0: [104c:8024] type 00 class 0x0c0010
[    0.476994] pci 0000:05:06.0: reg 0x10: [mem 0xf9204000-0xf92047ff]
[    0.477002] pci 0000:05:06.0: reg 0x14: [mem 0xf9200000-0xf9203fff]
[    0.477063] pci 0000:05:06.0: supports D1 D2
[    0.477065] pci 0000:05:06.0: PME# supported from D0 D1 D2 D3hot
[    0.477126] pci 0000:00:1e.0: PCI bridge to [bus 05] (subtractive decode)
[    0.477129] pci 0000:00:1e.0:   bridge window [io  0xd000-0xdfff]
[    0.477132] pci 0000:00:1e.0:   bridge window [mem 0xf9200000-0xf92fffff]
[    0.477136] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.477137] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.477139] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.477140] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.477142] pci 0000:00:1e.0:   bridge window [mem 0xcff00000-0xfebfffff window] (subtractive decode)
[    0.477955] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[    0.478045] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
[    0.478134] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
[    0.478224] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
[    0.478313] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 *14 15)
[    0.478402] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 *15)
[    0.478491] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[    0.478581] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[    0.478744] iommu: Default domain type: Translated 
[    0.485872] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.485872] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.485872] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.485872] vgaarb: loaded
[    0.486067] SCSI subsystem initialized
[    0.486072] libata version 3.00 loaded.
[    0.486072] ACPI: bus type USB registered
[    0.486072] usbcore: registered new interface driver usbfs
[    0.486072] usbcore: registered new interface driver hub
[    0.486072] usbcore: registered new device driver usb
[    0.486072] pps_core: LinuxPPS API ver. 1 registered
[    0.486072] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.486072] PTP clock support registered
[    0.486072] EDAC MC: Ver: 3.0.0
[    0.486094] NetLabel: Initializing
[    0.486094] NetLabel:  domain hash size = 128
[    0.486094] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.486094] NetLabel:  unlabeled traffic allowed by default
[    0.486094] PCI: Using ACPI for IRQ routing
[    0.487161] PCI: pci_cache_line_size set to 64 bytes
[    0.487224] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.487226] e820: reserve RAM buffer [mem 0xcfee0000-0xcfffffff]
[    0.487231] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.487231] hpet: 4 channels of 0 reserved for per-cpu timers
[    0.487231] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.487231] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.488885] clocksource: Switched to clocksource tsc-early
[    0.502063] VFS: Disk quotas dquot_6.6.0
[    0.502083] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.502178] pnp: PnP ACPI init
[    0.502441] system 00:00: [io  0x04d0-0x04d1] has been reserved
[    0.502443] system 00:00: [io  0x0290-0x029f] has been reserved
[    0.502444] system 00:00: [io  0x0800-0x087f] has been reserved
[    0.502446] system 00:00: [io  0x0290-0x0294] has been reserved
[    0.502447] system 00:00: [io  0x0880-0x088f] has been reserved
[    0.502455] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.502546] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.502728] pnp 00:02: [dma 2]
[    0.502758] pnp 00:02: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.503034] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.503449] pnp 00:04: [dma 3]
[    0.503488] pnp 00:04: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.503608] system 00:05: [io  0x0400-0x04bf] could not be reserved
[    0.503613] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.503889] system 00:06: [mem 0xf0000000-0xf3ffffff] has been reserved
[    0.503894] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.504179] system 00:07: [mem 0x000d7000-0x000d7fff] has been reserved
[    0.504181] system 00:07: [mem 0x000f0000-0x000f7fff] could not be reserved
[    0.504183] system 00:07: [mem 0x000f8000-0x000fbfff] could not be reserved
[    0.504185] system 00:07: [mem 0x000fc000-0x000fffff] could not be reserved
[    0.504186] system 00:07: [mem 0xcfee0000-0xcfefffff] could not be reserved
[    0.504188] system 00:07: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.504190] system 00:07: [mem 0x00100000-0xcfedffff] could not be reserved
[    0.504192] system 00:07: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.504193] system 00:07: [mem 0xfed10000-0xfed1dfff] has been reserved
[    0.504195] system 00:07: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.504196] system 00:07: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.504198] system 00:07: [mem 0xffb00000-0xffb7ffff] has been reserved
[    0.504199] system 00:07: [mem 0xfff00000-0xffffffff] has been reserved
[    0.504201] system 00:07: [mem 0x000e0000-0x000effff] has been reserved
[    0.504206] system 00:07: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.504212] pnp: PnP ACPI: found 8 devices
[    0.510282] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.510346] NET: Registered protocol family 2
[    0.510627] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.510761] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.511068] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.511193] TCP: Hash tables configured (established 65536 bind 65536)
[    0.511314] MPTCP token hash table entries: 8192 (order: 5, 196608 bytes, linear)
[    0.511374] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.511421] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.511479] NET: Registered protocol family 1
[    0.511484] NET: Registered protocol family 44
[    0.511493] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.511496] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.511498] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.511501] pci 0000:00:1c.5: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[    0.511515] pci 0000:00:1c.0: BAR 15: assigned [mem 0xf9400000-0xf95fffff 64bit pref]
[    0.511518] pci 0000:00:1c.4: BAR 15: assigned [mem 0xf9600000-0xf97fffff 64bit pref]
[    0.511522] pci 0000:00:1c.5: BAR 15: assigned [mem 0xf9800000-0xf99fffff 64bit pref]
[    0.511524] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.511528] pci 0000:01:00.0: BAR 6: assigned [mem 0xf5000000-0xf507ffff pref]
[    0.511530] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.511533] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.511535] pci 0000:00:01.0:   bridge window [mem 0xf4000000-0xf6ffffff]
[    0.511537] pci 0000:00:01.0:   bridge window [mem 0xd0000000-0xefffffff 64bit pref]
[    0.511540] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.511542] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.511546] pci 0000:00:1c.0:   bridge window [mem 0xf9100000-0xf91fffff]
[    0.511548] pci 0000:00:1c.0:   bridge window [mem 0xf9400000-0xf95fffff 64bit pref]
[    0.511553] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.511555] pci 0000:00:1c.4:   bridge window [io  0xb000-0xbfff]
[    0.511558] pci 0000:00:1c.4:   bridge window [mem 0xf9000000-0xf90fffff]
[    0.511561] pci 0000:00:1c.4:   bridge window [mem 0xf9600000-0xf97fffff 64bit pref]
[    0.511565] pci 0000:04:00.0: BAR 6: assigned [mem 0xf7000000-0xf700ffff pref]
[    0.511567] pci 0000:00:1c.5: PCI bridge to [bus 04]
[    0.511569] pci 0000:00:1c.5:   bridge window [io  0xc000-0xcfff]
[    0.511572] pci 0000:00:1c.5:   bridge window [mem 0xf7000000-0xf8ffffff]
[    0.511575] pci 0000:00:1c.5:   bridge window [mem 0xf9800000-0xf99fffff 64bit pref]
[    0.511580] pci 0000:00:1e.0: PCI bridge to [bus 05]
[    0.511582] pci 0000:00:1e.0:   bridge window [io  0xd000-0xdfff]
[    0.511585] pci 0000:00:1e.0:   bridge window [mem 0xf9200000-0xf92fffff]
[    0.511591] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.511592] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.511594] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.511595] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000dffff window]
[    0.511597] pci_bus 0000:00: resource 8 [mem 0xcff00000-0xfebfffff window]
[    0.511598] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    0.511599] pci_bus 0000:01: resource 1 [mem 0xf4000000-0xf6ffffff]
[    0.511601] pci_bus 0000:01: resource 2 [mem 0xd0000000-0xefffffff 64bit pref]
[    0.511602] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    0.511604] pci_bus 0000:02: resource 1 [mem 0xf9100000-0xf91fffff]
[    0.511605] pci_bus 0000:02: resource 2 [mem 0xf9400000-0xf95fffff 64bit pref]
[    0.511607] pci_bus 0000:03: resource 0 [io  0xb000-0xbfff]
[    0.511608] pci_bus 0000:03: resource 1 [mem 0xf9000000-0xf90fffff]
[    0.511609] pci_bus 0000:03: resource 2 [mem 0xf9600000-0xf97fffff 64bit pref]
[    0.511611] pci_bus 0000:04: resource 0 [io  0xc000-0xcfff]
[    0.511612] pci_bus 0000:04: resource 1 [mem 0xf7000000-0xf8ffffff]
[    0.511613] pci_bus 0000:04: resource 2 [mem 0xf9800000-0xf99fffff 64bit pref]
[    0.511615] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    0.511616] pci_bus 0000:05: resource 1 [mem 0xf9200000-0xf92fffff]
[    0.511617] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7 window]
[    0.511619] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff window]
[    0.511620] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.511621] pci_bus 0000:05: resource 7 [mem 0x000c0000-0x000dffff window]
[    0.511623] pci_bus 0000:05: resource 8 [mem 0xcff00000-0xfebfffff window]
[    0.512835] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.512866] pci 0000:01:00.1: D0 power state depends on 0000:01:00.0
[    0.513049] pci 0000:03:00.0: async suspend disabled to avoid multi-function power-on ordering issue
[    0.513053] pci 0000:03:00.1: async suspend disabled to avoid multi-function power-on ordering issue
[    0.513063] PCI: CLS 32 bytes, default 64
[    0.513112] Trying to unpack rootfs image as initramfs...
[    0.610405] Freeing initrd memory: 16272K
[    0.610462] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.610465] software IO TLB: mapped [mem 0x00000000cbee0000-0x00000000cfee0000] (64MB)
[    0.611240] check: Scanning for low memory corruption every 60 seconds
[    0.611610] Initialise system trusted keyrings
[    0.611623] Key type blacklist registered
[    0.611726] workingset: timestamp_bits=41 max_order=21 bucket_order=0
[    0.613226] zbud: loaded
[    0.623397] Key type asymmetric registered
[    0.623400] Asymmetric key parser 'x509' registered
[    0.623408] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.623481] io scheduler mq-deadline registered
[    0.623483] io scheduler kyber registered
[    0.623507] io scheduler bfq registered
[    0.623639] atomic64_test: passed for x86-64 platform with CX8 and with SSE
[    0.624302] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.624333] vesafb: mode is 640x480x32, linelength=2560, pages=0
[    0.624334] vesafb: scrolling: redraw
[    0.624336] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.624350] vesafb: framebuffer at 0xe1000000, mapped to 0x(____ptrval____), using 1216k, total 1216k
[    0.624389] fbcon: Deferring console take-over
[    0.624390] fb0: VESA VGA frame buffer device
[    0.624404] intel_idle: MWAIT substates: 0x20
[    0.624413] intel_idle: ACPI _CST not found or not usable
[    0.624518] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.624545] ACPI: Power Button [PWRB]
[    0.624590] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.624628] ACPI: Power Button [PWRF]
[    0.625172] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.625300] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    0.627248] Non-volatile memory driver v1.3
[    0.627249] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.627250] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    0.627856] ahci 0000:00:1f.2: version 3.0
[    0.627992] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    0.628021] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    0.628023] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ccc ems 
[    0.778335] scsi host0: ahci
[    0.778527] scsi host1: ahci
[    0.778693] scsi host2: ahci
[    0.778856] scsi host3: ahci
[    0.779028] scsi host4: ahci
[    0.779194] scsi host5: ahci
[    0.779246] ata1: SATA max UDMA/133 abar m2048@0xf9306000 port 0xf9306100 irq 28
[    0.779248] ata2: SATA max UDMA/133 abar m2048@0xf9306000 port 0xf9306180 irq 28
[    0.779249] ata3: SATA max UDMA/133 abar m2048@0xf9306000 port 0xf9306200 irq 28
[    0.779251] ata4: SATA max UDMA/133 abar m2048@0xf9306000 port 0xf9306280 irq 28
[    0.779253] ata5: SATA max UDMA/133 abar m2048@0xf9306000 port 0xf9306300 irq 28
[    0.779254] ata6: SATA max UDMA/133 abar m2048@0xf9306000 port 0xf9306380 irq 28
[    0.797825] ahci 0000:03:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
[    0.797828] ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
[    0.798191] scsi host6: ahci
[    0.798375] scsi host7: ahci
[    0.798422] ata7: SATA max UDMA/133 abar m8192@0xf9000000 port 0xf9000100 irq 16
[    0.798425] ata8: SATA max UDMA/133 abar m8192@0xf9000000 port 0xf9000180 irq 16
[    0.798457] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.798466] ehci-pci: EHCI PCI platform driver
[    0.798571] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    0.798577] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.802498] ehci-pci 0000:00:1a.7: cache line size of 32 is not supported
[    0.802508] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9305000
[    0.837803] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.837875] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    0.837877] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.837879] usb usb1: Product: EHCI Host Controller
[    0.837881] usb usb1: Manufacturer: Linux 5.10.22-2-lts ehci_hcd
[    0.837883] usb usb1: SerialNumber: 0000:00:1a.7
[    0.838014] hub 1-0:1.0: USB hub found
[    0.838022] hub 1-0:1.0: 6 ports detected
[    0.838270] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    0.838274] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.842171] ehci-pci 0000:00:1d.7: cache line size of 32 is not supported
[    0.842180] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9304000
[    0.877805] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.877867] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    0.877870] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.877872] usb usb2: Product: EHCI Host Controller
[    0.877874] usb usb2: Manufacturer: Linux 5.10.22-2-lts ehci_hcd
[    0.877875] usb usb2: SerialNumber: 0000:00:1d.7
[    0.877977] hub 2-0:1.0: USB hub found
[    0.877985] hub 2-0:1.0: 6 ports detected
[    0.878149] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.878153] ohci-pci: OHCI PCI platform driver
[    0.878163] uhci_hcd: USB Universal Host Controller Interface driver
[    0.878247] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.878252] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.878257] uhci_hcd 0000:00:1a.0: detected 2 ports
[    0.878273] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e000
[    0.878332] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    0.878334] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.878335] usb usb3: Product: UHCI Host Controller
[    0.878336] usb usb3: Manufacturer: Linux 5.10.22-2-lts uhci_hcd
[    0.878338] usb usb3: SerialNumber: 0000:00:1a.0
[    0.878418] hub 3-0:1.0: USB hub found
[    0.878427] hub 3-0:1.0: 2 ports detected
[    0.878599] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.878604] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.878618] uhci_hcd 0000:00:1a.1: detected 2 ports
[    0.878642] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000e100
[    0.878695] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    0.878697] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.878698] usb usb4: Product: UHCI Host Controller
[    0.878700] usb usb4: Manufacturer: Linux 5.10.22-2-lts uhci_hcd
[    0.878701] usb usb4: SerialNumber: 0000:00:1a.1
[    0.878782] hub 4-0:1.0: USB hub found
[    0.878790] hub 4-0:1.0: 2 ports detected
[    0.878957] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.878962] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.878967] uhci_hcd 0000:00:1a.2: detected 2 ports
[    0.878983] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000e500
[    0.879037] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    0.879039] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.879040] usb usb5: Product: UHCI Host Controller
[    0.879042] usb usb5: Manufacturer: Linux 5.10.22-2-lts uhci_hcd
[    0.879043] usb usb5: SerialNumber: 0000:00:1a.2
[    0.879122] hub 5-0:1.0: USB hub found
[    0.879130] hub 5-0:1.0: 2 ports detected
[    0.879293] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.879298] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.879303] uhci_hcd 0000:00:1d.0: detected 2 ports
[    0.879318] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000e200
[    0.879369] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    0.879371] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.879372] usb usb6: Product: UHCI Host Controller
[    0.879373] usb usb6: Manufacturer: Linux 5.10.22-2-lts uhci_hcd
[    0.879374] usb usb6: SerialNumber: 0000:00:1d.0
[    0.879454] hub 6-0:1.0: USB hub found
[    0.879462] hub 6-0:1.0: 2 ports detected
[    0.879650] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.879655] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.879660] uhci_hcd 0000:00:1d.1: detected 2 ports
[    0.879681] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000e300
[    0.879747] usb usb7: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    0.879749] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.879750] usb usb7: Product: UHCI Host Controller
[    0.879752] usb usb7: Manufacturer: Linux 5.10.22-2-lts uhci_hcd
[    0.879753] usb usb7: SerialNumber: 0000:00:1d.1
[    0.879833] hub 7-0:1.0: USB hub found
[    0.879841] hub 7-0:1.0: 2 ports detected
[    0.880003] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.880008] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.880013] uhci_hcd 0000:00:1d.2: detected 2 ports
[    0.880028] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e400
[    0.880079] usb usb8: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.10
[    0.880080] usb usb8: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.880082] usb usb8: Product: UHCI Host Controller
[    0.880083] usb usb8: Manufacturer: Linux 5.10.22-2-lts uhci_hcd
[    0.880084] usb usb8: SerialNumber: 0000:00:1d.2
[    0.880165] hub 8-0:1.0: USB hub found
[    0.880173] hub 8-0:1.0: 2 ports detected
[    0.880303] usbcore: registered new interface driver usbserial_generic
[    0.880308] usbserial: USB Serial support registered for generic
[    0.880331] i8042: PNP: No PS/2 controller found.
[    0.880332] i8042: Probing ports directly.
[    0.880705] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.880709] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.880842] rtc_cmos 00:01: RTC can wake from S4
[    0.881008] rtc_cmos 00:01: registered as rtc0
[    0.881037] rtc_cmos 00:01: setting system clock to 2021-03-12T06:18:44 UTC (1615529924)
[    0.881060] rtc_cmos 00:01: alarms up to one month, 242 bytes nvram, hpet irqs
[    0.881093] intel_pstate: CPU model not supported
[    0.881175] ledtrig-cpu: registered to indicate activity on CPUs
[    0.881322] hid: raw HID events driver (C) Jiri Kosina
[    0.881397] drop_monitor: Initializing network drop monitor service
[    0.881464] Initializing XFRM netlink socket
[    0.881581] NET: Registered protocol family 10
[    0.887406] Segment Routing with IPv6
[    0.887407] RPL Segment Routing with IPv6
[    0.887431] NET: Registered protocol family 17
[    0.887744] microcode: sig=0x10677, pf=0x10, revision=0x70a
[    0.887769] microcode: Microcode Update Driver: v2.2.
[    0.887779] IPI shorthand broadcast: enabled
[    0.887789] sched_clock: Marking stable (896818122, -9145321)->(898884106, -11211305)
[    0.887925] registered taskstats version 1
[    0.887945] Loading compiled-in X.509 certificates
[    0.891411] Loaded X.509 cert 'Build time autogenerated kernel key: a57be8a38e39487ee87408c6c0d03e72ad4e10e2'
[    0.891580] zswap: loaded using pool lz4/z3fold
[    0.891783] Key type ._fscrypt registered
[    0.891784] Key type .fscrypt registered
[    0.891785] Key type fscrypt-provisioning registered
[    0.892215] PM:   Magic number: 13:786:316
[    0.892263] tty tty41: hash matches
[    0.892421] RAS: Correctable Errors collector initialized.
[    1.136124] ata8: SATA link down (SStatus 0 SControl 300)
[    1.139534] ata7: SATA link down (SStatus 0 SControl 300)
[    1.199512] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.305858] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.307217] ata1.00: ATA-9: SanDisk SD8SBAT256G1122, Z2201000, max UDMA/133
[    1.307220] ata1.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.314721] ata1.00: configured for UDMA/133
[    1.314864] scsi 0:0:0:0: Direct-Access     ATA      SanDisk SD8SBAT2 1000 PQ: 0 ANSI: 5
[    1.315081] sd 0:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.315093] sd 0:0:0:0: [sda] Write Protect is off
[    1.315095] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.315113] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.315570]  sda: sda1 sda2
[    1.315935] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.397043] usb 1-1: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice= 9.01
[    1.397046] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.397048] usb 1-1: Product: USB2.0 Hub
[    1.397455] hub 1-1:1.0: USB hub found
[    1.397792] hub 1-1:1.0: 4 ports detected
[    1.475852] usb 8-1: new full-speed USB device number 2 using uhci_hcd
[    1.635853] usb 8-1: device descriptor read/64, error -71
[    1.645853] tsc: Refined TSC clocksource calibration: 2833.332 MHz
[    1.645859] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28d740293ac, max_idle_ns: 440795206647 ns
[    1.645883] clocksource: Switched to clocksource tsc
[    1.815859] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.816644] ata2.00: supports DRM functions and may not be fully accessible
[    1.817451] ata2.00: ATA-11: SanDisk SD9TB8W256G1001, X6107101, max UDMA/133
[    1.817453] ata2.00: 500118192 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.820585] ata2.00: supports DRM functions and may not be fully accessible
[    1.823682] ata2.00: configured for UDMA/133
[    1.823773] scsi 1:0:0:0: Direct-Access     ATA      SanDisk SD9TB8W2 7101 PQ: 0 ANSI: 5
[    1.823976] sd 1:0:0:0: [sdb] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    1.823987] sd 1:0:0:0: [sdb] Write Protect is off
[    1.823989] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.824007] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.824294]  sdb: sdb1
[    1.925854] usb 8-1: device descriptor read/64, error -71
[    1.939867] sd 1:0:0:0: [sdb] supports TCG Opal
[    1.939870] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.195853] usb 8-1: new full-speed USB device number 3 using uhci_hcd
[    2.315863] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.319813] ata3.00: HPA detected: current 781420655, native 781422768
[    2.319866] ata3.00: ATA-8: SAMSUNG HD403LJ, CT100-10, max UDMA7
[    2.319868] ata3.00: 781420655 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    2.321840] ata3.00: configured for UDMA/133
[    2.321923] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD403LJ  0-10 PQ: 0 ANSI: 5
[    2.322091] sd 2:0:0:0: [sdc] 781420655 512-byte logical blocks: (400 GB/373 GiB)
[    2.322102] sd 2:0:0:0: [sdc] Write Protect is off
[    2.322104] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.322121] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.355851] usb 8-1: device descriptor read/64, error -71
[    2.358686]  sdc: sdc1 sdc2
[    2.359036] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.635852] usb 8-1: device descriptor read/64, error -71
[    2.755871] usb usb8-port1: attempt power cycle
[    2.815859] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.818568] ata4.00: ATAPI: HL-DT-ST DVDRAM GSA-H62N, CL00, max UDMA/100
[    2.822432] ata4.00: configured for UDMA/100
[    2.931973] scsi 3:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-H62N  CL00 PQ: 0 ANSI: 5
[    3.245853] usb 8-1: new full-speed USB device number 4 using uhci_hcd
[    3.337048] ata5: SATA link down (SStatus 0 SControl 300)
[    3.667043] ata6: SATA link down (SStatus 0 SControl 300)
[    3.668885] Freeing unused decrypted memory: 2036K
[    3.669366] Freeing unused kernel image (initmem) memory: 1772K
[    3.669399] Write protecting the kernel read-only data: 26624k
[    3.670143] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    3.670650] Freeing unused kernel image (rodata/data gap) memory: 1420K
[    3.716211] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.716216] rodata_test: all tests were successful
[    3.716233] x86/mm: Checking user space page tables
[    3.759695] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    3.759705] Run /init as init process
[    3.759706]   with arguments:
[    3.759708]     /init
[    3.759709]   with environment:
[    3.759710]     HOME=/
[    3.759711]     TERM=linux
[    3.759712]     BOOT_IMAGE=/@/boot/vmlinuz-linux-lts
[    3.759751] usb 8-1: device not accepting address 4, error -71
[    3.774552] systemd[1]: systemd 247.3-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.795986] systemd[1]: Detected architecture x86-64.
[    3.795989] systemd[1]: Running in initial RAM disk.
[    3.876087] fbcon: Taking over console
[    3.876159] random: systemd: uninitialized urandom read (16 bytes read)
[    3.876166] systemd[1]: Initializing machine ID from random generator.
[    3.892288] Console: switching to colour frame buffer device 80x30
[    3.915869] usb 8-1: new full-speed USB device number 5 using uhci_hcd
[    3.916971] systemd[1]: Queued start job for default target Initrd Default Target.
[    3.917074] random: systemd: uninitialized urandom read (16 bytes read)
[    3.917087] systemd[1]: Reached target Local File Systems.
[    3.917334] random: systemd: uninitialized urandom read (16 bytes read)
[    3.917342] systemd[1]: Reached target Paths.
[    3.917505] systemd[1]: Reached target Slices.
[    3.917668] systemd[1]: Reached target Swap.
[    3.917825] systemd[1]: Reached target Timers.
[    3.918124] systemd[1]: Listening on Journal Audit Socket.
[    3.918421] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.918741] systemd[1]: Listening on Journal Socket.
[    3.919006] systemd[1]: Listening on udev Control Socket.
[    3.919257] systemd[1]: Listening on udev Kernel Socket.
[    3.919452] systemd[1]: Reached target Sockets.
[    3.931353] systemd[1]: Starting Archlogo...
[    3.932506] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    3.934419] systemd[1]: Starting Journal Service...
[    3.935630] systemd[1]: Starting Load Kernel Modules...
[    3.936724] systemd[1]: Starting Coldplug All udev Devices...
[    3.938033] systemd[1]: Finished Archlogo.
[    3.942170] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    3.945949] systemd[1]: Finished Load Kernel Modules.
[    3.950120] systemd[1]: Starting Create Static Device Nodes in /dev...
[    3.955321] systemd[1]: Finished Create Static Device Nodes in /dev.
[    3.960757] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    3.997011] systemd[1]: Started Rule-based Manager for Device Events and Files.
[    4.012009] audit: type=1130 audit(1615529927.614:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[    4.041689] systemd[1]: Finished Coldplug All udev Devices.
[    4.045584] audit: type=1130 audit(1615529927.644:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udev-trigger comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[    4.049109] Floppy drive(s): fd0 is 1.44M
[    4.050775] systemd[1]: Started Journal Service.
[    4.050929] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    4.050937] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 9
[    4.051056] xhci_hcd 0000:02:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x0000000000000004
[    4.051341] usb usb9: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
[    4.051342] usb usb9: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.051344] usb usb9: Product: xHCI Host Controller
[    4.051345] usb usb9: Manufacturer: Linux 5.10.22-2-lts xhci-hcd
[    4.051346] usb usb9: SerialNumber: 0000:02:00.0
[    4.052181] hub 9-0:1.0: USB hub found
[    4.052195] hub 9-0:1.0: 2 ports detected
[    4.052523] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    4.052526] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 10
[    4.052529] xhci_hcd 0000:02:00.0: Host supports USB 3.0 SuperSpeed
[    4.054435] usb usb10: We don't know the algorithms for LPM for this host, disabling LPM.
[    4.054467] usb usb10: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
[    4.054469] usb usb10: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.054470] usb usb10: Product: xHCI Host Controller
[    4.054471] usb usb10: Manufacturer: Linux 5.10.22-2-lts xhci-hcd
[    4.054472] usb usb10: SerialNumber: 0000:02:00.0
[    4.054617] hub 10-0:1.0: USB hub found
[    4.054633] hub 10-0:1.0: 2 ports detected
[    4.056982] audit: type=1130 audit(1615529927.664:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[    4.068317] scsi host8: pata_jmicron
[    4.080228] FDC 0 is a post-1991 82077
[    4.086492] scsi host9: pata_jmicron
[    4.086556] ata9: PATA max UDMA/100 cmd 0xb000 ctl 0xb100 bmdma 0xb400 irq 17
[    4.086558] ata10: PATA max UDMA/100 cmd 0xb200 ctl 0xb300 bmdma 0xb408 irq 17
[    4.135815] raid6: skip pq benchmark and using algorithm sse2x4
[    4.135818] raid6: using ssse3x2 recovery algorithm
[    4.135906] firewire_ohci 0000:05:06.0: added OHCI v1.10 device as card 0, 4 IR + 8 IT contexts, quirks 0x2
[    4.137476] xor: measuring software checksum speed
[    4.138175]    prefetch64-sse  : 14133 MB/sec
[    4.138996]    generic_sse     : 12236 MB/sec
[    4.138997] xor: using function: prefetch64-sse (14133 MB/sec)
[    4.180202] random: fast init done
[    4.258761] ata9.00: ATA-7: SAMSUNG SP2514N, VF100-41, max UDMA/100
[    4.258765] ata9.00: 488397168 sectors, multi 0: LBA48 
[    4.279642] Btrfs loaded, crc32c=crc32c-generic
[    4.280367] BTRFS: device label archlinux devid 1 transid 137439 /dev/sda1 scanned by systemd-udevd (165)
[    4.290977] scsi 8:0:0:0: Direct-Access     ATA      SAMSUNG SP2514N  0-41 PQ: 0 ANSI: 5
[    4.291218] sd 8:0:0:0: [sdd] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    4.291233] sd 8:0:0:0: [sdd] Write Protect is off
[    4.291236] sd 8:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    4.291254] sd 8:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.299096] sr 3:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    4.299101] cdrom: Uniform CD-ROM driver Revision: 3.20
[    4.338829] sd 8:0:0:0: [sdd] Attached SCSI disk
[    4.365859] usb 8-1: device not accepting address 5, error -71
[    4.365920] usb usb8-port1: unable to enumerate USB device
[    4.366419] BTRFS: device label archlinux devid 2 transid 137439 /dev/sdb1 scanned by systemd-udevd (169)
[    4.413446] audit: type=1130 audit(1615529928.014:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck-root comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[    4.426299] BTRFS info (device sda1): using free space tree
[    4.426303] BTRFS info (device sda1): has skinny extents
[    4.433539] BTRFS info (device sda1): bdev /dev/sdb1 errs: wr 2701995, rd 2718862, flush 0, corrupt 6, gen 0
[    4.532225] BTRFS info (device sda1): enabling ssd optimizations
[    4.536191] sr 3:0:0:0: Attached scsi CD-ROM sr0
[    4.553394] audit: type=1334 audit(1615529928.154:6): prog-id=6 op=UNLOAD
[    4.553401] audit: type=1334 audit(1615529928.154:7): prog-id=5 op=UNLOAD
[    4.554893] audit: type=1334 audit(1615529928.154:8): prog-id=4 op=UNLOAD
[    4.555040] audit: type=1334 audit(1615529928.154:9): prog-id=3 op=UNLOAD
[    4.633068] BTRFS: device label backup devid 1 transid 1335 /dev/sdd scanned by systemd-udevd (169)
[    4.645957] firewire_core 0000:05:06.0: created device fw0: GUID 00c43cc000001a4d, S400
[    4.658633] audit: type=1334 audit(1615529928.264:10): prog-id=7 op=LOAD
[    4.755888] usb 8-2: new full-speed USB device number 6 using uhci_hcd
[    4.973534] usb 8-2: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=24.00
[    4.973538] usb 8-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    4.973540] usb 8-2: Product: USB Receiver
[    4.973542] usb 8-2: Manufacturer: Logitech
[    5.246311] usb 10-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    5.282289] usb 10-1: New USB device found, idVendor=8564, idProduct=4000, bcdDevice= 0.3a
[    5.282291] usb 10-1: New USB device strings: Mfr=3, Product=4, SerialNumber=5
[    5.282292] usb 10-1: Product: Transcend
[    5.282293] usb 10-1: Manufacturer: TS-RDF5 
[    5.282295] usb 10-1: SerialNumber: 000000000037
[    6.245983] usb 10-2: new SuperSpeed Gen 1 USB device number 3 using xhci_hcd
[    6.282444] usb 10-2: New USB device found, idVendor=1058, idProduct=107c, bcdDevice=10.65
[    6.282446] usb 10-2: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[    6.282448] usb 10-2: Product: Elements 107C
[    6.282450] usb 10-2: Manufacturer: Western Digital
[    6.282452] usb 10-2: SerialNumber: 575834314432353954414350
[   16.914959] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   16.914963] floppy: error 10 while reading block 0
[   16.918529] kauditd_printk_skb: 10 callbacks suppressed
[   16.918530] audit: type=1131 audit(1615529940.524:21): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[   16.935778] audit: type=1131 audit(1615529940.534:22): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[   16.939825] audit: type=1131 audit(1615529940.544:23): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=kmod-static-nodes comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[   16.943963] audit: type=1130 audit(1615529940.544:24): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-udevadm-cleanup-db comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[   16.943967] audit: type=1131 audit(1615529940.544:25): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=initrd-udevadm-cleanup-db comm="systemd" exe="/init" hostname=? addr=? terminal=? res=success'
[   16.960033] audit: type=1334 audit(1615529940.564:26): prog-id=10 op=UNLOAD
[   16.960039] audit: type=1334 audit(1615529940.564:27): prog-id=9 op=UNLOAD
[   16.986345] audit: type=1334 audit(1615529940.594:28): prog-id=8 op=UNLOAD
[   16.986350] audit: type=1334 audit(1615529940.594:29): prog-id=7 op=UNLOAD
[   17.059210] systemd-journald[140]: Received SIGTERM from PID 1 (systemd).
[   17.227596] systemd[1]: systemd 247.3-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[   17.265955] systemd[1]: Detected architecture x86-64.
[   17.276240] systemd[1]: Set hostname to <pc1-desktop>.
[   17.279845] audit: type=1334 audit(1615529940.884:30): prog-id=11 op=LOAD
[   17.788185] systemd[1]: initrd-switch-root.service: Succeeded.
[   17.788686] systemd[1]: Stopped Switch Root.
[   17.792017] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[   17.792376] systemd[1]: Created slice Virtual Machine and Container Slice.
[   17.795882] systemd[1]: Created slice system-getty.slice.
[   17.799234] systemd[1]: Created slice system-modprobe.slice.
[   17.802559] systemd[1]: Created slice User and Session Slice.
[   17.805626] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   17.808876] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   17.812278] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   17.815655] systemd[1]: Reached target Local Encrypted Volumes.
[   17.819225] systemd[1]: Stopped target Switch Root.
[   17.822626] systemd[1]: Stopped target Initrd File Systems.
[   17.826052] systemd[1]: Stopped target Initrd Root File System.
[   17.829525] systemd[1]: Reached target Paths.
[   17.832979] systemd[1]: Reached target Remote File Systems.
[   17.836772] systemd[1]: Reached target Slices.
[   17.840295] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   17.844319] systemd[1]: Listening on LVM2 poll daemon socket.
[   17.849000] systemd[1]: Listening on Process Core Dump Socket.
[   17.853525] systemd[1]: Listening on udev Control Socket.
[   17.856826] systemd[1]: Listening on udev Kernel Socket.
[   17.860924] systemd[1]: Activating swap /dev/disk/by-uuid/f500539a-35cd-46b6-88be-3f027c45a6c6...
[   17.865628] systemd[1]: Mounting /dev/hugepages...
[   17.870282] systemd[1]: Mounting POSIX Message Queue File System...
[   17.875145] systemd[1]: Mounting Kernel Debug File System...
[   17.879550] systemd[1]: Mounting Kernel Trace File System...
[   17.884050] systemd[1]: Starting Create list of static device nodes for the current kernel...
[   17.888702] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   17.893454] systemd[1]: Starting Load Kernel Module configfs...
[   17.898233] systemd[1]: Starting Load Kernel Module drm...
[   17.902709] systemd[1]: Starting Load Kernel Module fuse...
[   17.905675] Linux agpgart interface v0.103
[   17.908133] systemd[1]: Starting Set Up Additional Binary Formats...
[   17.911839] systemd[1]: systemd-fsck-root.service: Succeeded.
[   17.912402] systemd[1]: Stopped File System Check on Root Device.
[   17.915990] systemd[1]: Stopped Journal Service.
[   17.919245] fuse: init (API version 7.32)
[   17.921488] systemd[1]: Starting Journal Service...
[   17.926443] systemd[1]: Starting Load Kernel Modules...
[   17.931144] systemd[1]: Starting Remount Root and Kernel File Systems...
[   17.934985] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
[   17.935883] Adding 2011476k swap on /dev/sda2.  Priority:-2 extents:1 across:2011476k SSFS
[   17.936306] systemd[1]: Starting Coldplug All udev Devices...
[   17.938183] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   17.938223] sd 1:0:0:0: Attached scsi generic sg1 type 0
[   17.938259] sd 2:0:0:0: Attached scsi generic sg2 type 0
[   17.938296] sr 3:0:0:0: Attached scsi generic sg3 type 5
[   17.938332] sd 8:0:0:0: Attached scsi generic sg4 type 0
[   17.942246] systemd[1]: sysroot.mount: Succeeded.
[   17.944784] systemd[1]: Activated swap /dev/disk/by-uuid/f500539a-35cd-46b6-88be-3f027c45a6c6.
[   17.959341] systemd[1]: Mounted /dev/hugepages.
[   17.966146] systemd[1]: Mounted POSIX Message Queue File System.
[   17.969835] systemd[1]: Started Journal Service.
[   18.114945] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   18.118678] Bridge firewalling registered
[   18.795140] BTRFS info (device sda1): use zstd compression, level 3
[   18.795144] BTRFS info (device sda1): using free space tree
[   19.085379] IT8718 SuperIO detected
[   19.085535] parport_pc 00:04: reported by Plug and Play ACPI
[   19.085598] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[   19.240778] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042F conflicts with OpRegion 0x000000000000042C-0x000000000000042D (\GP2C) (20200925/utaddress-204)
[   19.240786] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   19.240819] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   19.243095] usb-storage 10-1:1.0: USB Mass Storage device detected
[   19.246435] 8139cp: 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[   19.246439] 8139cp 0000:05:00.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip, use 8139too
[   19.247241] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.0/0003:046D:C52B.0001/input/input4
[   19.248737] scsi host10: usb-storage 10-1:1.0
[   19.248822] usb-storage 10-2:1.0: USB Mass Storage device detected
[   19.265260] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   19.268461] eeprom 0-0050: eeprom driver is deprecated, please use at24 instead
[   19.274855] r8169 0000:04:00.0: can't disable ASPM; OS doesn't have ASPM control
[   19.275639] scsi host11: usb-storage 10-2:1.0
[   19.275766] usbcore: registered new interface driver usb-storage
[   19.279106] usbcore: registered new interface driver uas
[   19.279232] 8139too: 8139too Fast Ethernet driver 0.9.28
[   19.279846] 8139too 0000:05:00.0 eth0: RealTek RTL8139 at 0x(____ptrval____), 00:40:95:30:3f:96, IRQ 20
[   19.280371] eeprom 0-0051: eeprom driver is deprecated, please use at24 instead
[   19.284153] eeprom 0-0052: eeprom driver is deprecated, please use at24 instead
[   19.284918] eeprom 0-0053: eeprom driver is deprecated, please use at24 instead
[   19.316080] hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:1d.2-2/input0
[   19.321424] input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.1/0003:046D:C52B.0002/input/input5
[   19.321515] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.1/0003:046D:C52B.0002/input/input6
[   19.322245] libphy: r8169: probed
[   19.322889] r8169 0000:04:00.0 eth1: RTL8168b/8111b, 00:1a:4d:47:b3:48, XID 380, IRQ 17
[   19.322892] r8169 0000:04:00.0 eth1: jumbo features [frames: 4074 bytes, tx checksumming: ko]
[   19.386642] input: PC Speaker as /devices/platform/pcspkr/input/input9
[   19.396340] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.1/0003:046D:C52B.0002/input/input7
[   19.396865] hid-generic 0003:046D:C52B.0002: input,hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.2-2/input1
[   19.398039] device-mapper: uevent: version 1.0.3
[   19.398105] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
[   19.407291] hid-generic 0003:046D:C52B.0003: hiddev97,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1d.2-2/input2
[   19.407332] usbcore: registered new interface driver usbhid
[   19.407334] usbhid: USB HID core driver
[   19.420871] gpio_ich gpio_ich.2.auto: GPIO from 451 to 511
[   19.441132] 8139too 0000:05:00.0 enp5s0: renamed from eth0
[   19.470160] iTCO_vendor_support: vendor-support=0
[   19.493787] ppdev: user-space parallel port driver
[   19.517069] r8169 0000:04:00.0 enp4s0: renamed from eth1
[   19.656228] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   19.656287] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   19.728478] intel_powerclamp: No package C-state available
[   19.736607] snd_hda_intel 0000:00:1b.0: position_fix set to 1 for device 1458:a022
[   19.736740] snd_hda_intel 0000:01:00.1: Disabling MSI
[   19.736748] snd_hda_intel 0000:01:00.1: Handle vga_switcheroo audio client
[   19.765295] snd_hda_codec_realtek hdaudioC0D2: autoconfig for ALC889A: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   19.765300] snd_hda_codec_realtek hdaudioC0D2:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   19.765302] snd_hda_codec_realtek hdaudioC0D2:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[   19.765304] snd_hda_codec_realtek hdaudioC0D2:    mono: mono_out=0x0
[   19.765305] snd_hda_codec_realtek hdaudioC0D2:    dig-out=0x1e/0x0
[   19.765306] snd_hda_codec_realtek hdaudioC0D2:    inputs:
[   19.765308] snd_hda_codec_realtek hdaudioC0D2:      Rear Mic=0x18
[   19.765310] snd_hda_codec_realtek hdaudioC0D2:      Front Mic=0x19
[   19.765311] snd_hda_codec_realtek hdaudioC0D2:      Line=0x1a
[   19.765313] snd_hda_codec_realtek hdaudioC0D2:      CD=0x1c
[   19.765314] snd_hda_codec_realtek hdaudioC0D2:    dig-in=0x1f
[   19.780388] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input11
[   19.796261] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input12
[   19.801450] random: crng init done
[   19.801455] random: 7 urandom warning(s) missed due to ratelimiting
[   19.846753] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[   19.847073] intel_powerclamp: No package C-state available
[   19.886064] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input13
[   19.886149] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input14
[   19.886226] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[   19.886296] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input20
[   19.886353] input: HDA NVidia HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
[   19.886411] input: HDA NVidia HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
[   19.886469] input: HDA Intel Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input21
[   19.886524] input: HDA Intel Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input22
[   19.886581] input: HDA NVidia HDMI/DP,pcm=12 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input17
[   19.886754] input: HDA Intel Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input23
[   19.886811] input: HDA Intel Line Out Side as /devices/pci0000:00/0000:00:1b.0/sound/card0/input24
[   19.887078] logitech-djreceiver 0003:046D:C52B.0003: hiddev96,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:1d.2-2/input2
[   19.946568] intel_powerclamp: No package C-state available
[   20.030084] input: Logitech Wireless Device PID:101b Mouse as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/0003:046D:C52B.0003/0003:046D:101B.0004/input/input25
[   20.030167] hid-generic 0003:046D:101B.0004: input,hidraw1: USB HID v1.11 Mouse [Logitech Wireless Device PID:101b] on usb-0000:00:1d.2-2/input2:1
[   20.032279] input: Logitech Wireless Device PID:2008 Keyboard as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/0003:046D:C52B.0003/0003:046D:2008.0005/input/input29
[   20.032446] input: Logitech Wireless Device PID:2008 Consumer Control as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/0003:046D:C52B.0003/0003:046D:2008.0005/input/input30
[   20.032499] input: Logitech Wireless Device PID:2008 System Control as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/0003:046D:C52B.0003/0003:046D:2008.0005/input/input31
[   20.032561] hid-generic 0003:046D:2008.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:2008] on usb-0000:00:1d.2-2/input2:2
[   20.079108] intel_powerclamp: No package C-state available
[   20.092745] mousedev: PS/2 mouse device common for all mice
[   20.286734] scsi 11:0:0:0: Direct-Access     WD       Elements 107C    1065 PQ: 0 ANSI: 6
[   20.287351] scsi 10:0:0:0: Direct-Access     TS-RDF5  SD  Transcend    TS3A PQ: 0 ANSI: 6
[   20.287579] sd 10:0:0:0: Attached scsi generic sg5 type 0
[   20.287786] sd 11:0:0:0: Attached scsi generic sg6 type 0
[   20.288421] sd 11:0:0:0: [sdf] 1220934400 4096-byte logical blocks: (5.00 TB/4.55 TiB)
[   20.288961] sd 11:0:0:0: [sdf] Write Protect is off
[   20.288963] sd 11:0:0:0: [sdf] Mode Sense: 53 00 10 08
[   20.289460] sd 11:0:0:0: [sdf] No Caching mode page found
[   20.289462] sd 11:0:0:0: [sdf] Assuming drive cache: write through
[   20.327603] input: Logitech M705 as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/0003:046D:C52B.0003/0003:046D:101B.0004/input/input36
[   20.327715] logitech-hidpp-device 0003:046D:101B.0004: input,hidraw1: USB HID v1.11 Mouse [Logitech M705] on usb-0000:00:1d.2-2/input2:1
[   20.337597] sd 10:0:0:0: [sde] Attached SCSI removable disk
[   20.338099] BTRFS info (device sdd): use zstd compression, level 3
[   20.338102] BTRFS info (device sdd): using free space tree
[   20.338103] BTRFS info (device sdd): has skinny extents
[   20.443805] systemd-journald[250]: Received client request to flush runtime journal.
[   20.541382] nvidia: loading out-of-tree module taints kernel.
[   20.541396] nvidia: module license 'NVIDIA' taints kernel.
[   20.541397] Disabling lock debugging due to kernel taint
[   20.588830] nvidia: module verification failed: signature and/or required key missing - tainting kernel
[   20.622528] nvidia-nvlink: Nvlink Core is being initialized, major device number 236

[   20.623618] nvidia 0000:01:00.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[   20.685589] attempt to access beyond end of device
               sdb1: rw=524288, want=496544128, limit=496091703
[   20.685798] attempt to access beyond end of device
               sdb1: rw=2049, want=496544128, limit=496091703
[   20.685804] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718862, flush 0, corrupt 6, gen 0
[   20.740413] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  460.56  Tue Feb 23 23:31:36 UTC 2021
[   20.805936] nvidia-modeset: Loading NVIDIA Kernel Mode Setting Driver for UNIX platforms  460.56  Tue Feb 23 23:20:29 UTC 2021
[   20.842957] [drm] [nvidia-drm] [GPU ID 0x00000100] Loading driver
[   20.842960] [drm] Initialized nvidia-drm 0.0.0 20160202 for 0000:01:00.0 on minor 0
[   20.925760] input: Logitech MK700 as /devices/pci0000:00/0000:00:1d.2/usb8/8-2/8-2:1.2/0003:046D:C52B.0003/0003:046D:2008.0005/input/input37
[   20.926631] logitech-hidpp-device 0003:046D:2008.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech MK700] on usb-0000:00:1d.2-2/input2:2
[   20.940265]  sdf: sdf1
[   20.941832] sd 11:0:0:0: [sdf] Attached SCSI disk
[   21.334496] attempt to access beyond end of device
               sdb1: rw=0, want=496474752, limit=496091703
[   21.334501] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718863, flush 0, corrupt 6, gen 0
[   21.334512] attempt to access beyond end of device
               sdb1: rw=0, want=496474784, limit=496091703
[   21.334514] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718864, flush 0, corrupt 6, gen 0
[   21.334542] attempt to access beyond end of device
               sdb1: rw=0, want=496474752, limit=496091703
[   21.334545] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718865, flush 0, corrupt 6, gen 0
[   21.334551] attempt to access beyond end of device
               sdb1: rw=0, want=496474784, limit=496091703
[   21.334553] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718866, flush 0, corrupt 6, gen 0
[   21.334576] attempt to access beyond end of device
               sdb1: rw=0, want=496474752, limit=496091703
[   21.334578] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718867, flush 0, corrupt 6, gen 0
[   21.334584] attempt to access beyond end of device
               sdb1: rw=0, want=496474784, limit=496091703
[   21.334586] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718868, flush 0, corrupt 6, gen 0
[   21.334613] attempt to access beyond end of device
               sdb1: rw=0, want=496474752, limit=496091703
[   21.334615] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718869, flush 0, corrupt 6, gen 0
[   21.334620] attempt to access beyond end of device
               sdb1: rw=0, want=496474784, limit=496091703
[   21.334622] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718870, flush 0, corrupt 6, gen 0
[   21.334649] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2701996, rd 2718871, flush 0, corrupt 6, gen 0
[   21.396485] it87: Found IT8718F chip at 0x290, revision 4
[   21.396495] it87: VID is disabled (pins used for GPIO)
[   21.396503] it87: Beeping is supported
[   21.937285] RTL8211B Gigabit Ethernet r8169-400:00: attached PHY driver [RTL8211B Gigabit Ethernet] (mii_bus:phy_addr=r8169-400:00, irq=IGNORE)
[   21.965191] kauditd_printk_skb: 71 callbacks suppressed
[   21.965194] audit: type=1130 audit(1615529945.564:102): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   22.018251] r8169 0000:04:00.0 enp4s0: Link is Down
[   22.030061] 8139too 0000:05:00.0 enp5s0: link down
[   22.066610] audit: type=1130 audit(1615529945.674:103): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=polkit comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   22.071773] audit: type=1130 audit(1615529945.674:104): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=accounts-daemon comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   22.346657] resource sanity check: requesting [mem 0x000c0000-0x000fffff], which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000dffff window]
[   22.347052] caller _nv000708rm+0x1af/0x200 [nvidia] mapping multiple BARs
[   22.381462] audit: type=1130 audit(1615529945.984:105): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=pcscd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.381746] audit: type=1130 audit(1615529946.984:106): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=smartd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.568140] audit: type=1103 audit(1615529947.174:107): pid=965 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_env,pam_permit acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
[   23.601093] audit: type=1130 audit(1615529947.204:108): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@975 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.614122] audit: type=1101 audit(1615529947.214:109): pid=969 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="lightdm" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   23.614127] audit: type=1103 audit(1615529947.214:110): pid=969 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=? acct="lightdm" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[   23.614130] audit: type=1006 audit(1615529947.214:111): pid=969 uid=0 old-auid=4294967295 auid=975 tty=(none) old-ses=4294967295 ses=1 res=1
[   24.695631] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
[   24.695648] IPv6: ADDRCONF(NETDEV_CHANGE): enp4s0: link becomes ready
[   24.701401] br0: port 1(enp4s0) entered blocking state
[   24.701406] br0: port 1(enp4s0) entered disabled state
[   24.701500] device enp4s0 entered promiscuous mode
[   24.701570] br0: port 1(enp4s0) entered blocking state
[   24.701573] br0: port 1(enp4s0) entered forwarding state
[   24.701603] IPv6: ADDRCONF(NETDEV_CHANGE): br0: link becomes ready
[   28.407633] logitech-hidpp-device 0003:046D:2008.0005: HID++ 1.0 device connected.
[   31.714307] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[   31.714315] floppy: error 10 while reading block 0
[   31.998968] kauditd_printk_skb: 11 callbacks suppressed
[   31.998970] audit: type=1131 audit(1615529955.604:123): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   32.088582] audit: type=1100 audit(1615529955.694:124): pid=2135 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_shells,pam_unix,pam_permit,pam_gnome_keyring acct="thomas" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
[   32.088855] audit: type=1101 audit(1615529955.694:125): pid=2135 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
[   32.136243] audit: type=1106 audit(1615529955.744:126): pid=965 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_close grantors=pam_unix,pam_systemd acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
[   32.136249] audit: type=1104 audit(1615529955.744:127): pid=965 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_env,pam_permit acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
[   32.140420] audit: type=1103 audit(1615529955.744:128): pid=2135 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_shells,pam_unix,pam_permit,pam_gnome_keyring acct="thomas" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
[   32.140563] audit: type=1006 audit(1615529955.744:129): pid=2135 uid=0 old-auid=4294967295 auid=1001 tty=(none) old-ses=4294967295 ses=2 res=1
[   32.169702] audit: type=1130 audit(1615529955.774:130): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1001 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   32.178083] audit: type=1101 audit(1615529955.784:131): pid=2157 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   32.179318] audit: type=1103 audit(1615529955.784:132): pid=2157 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=? acct="thomas" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
[   32.806026] handle_bad_sector: 213 callbacks suppressed
[   32.806029] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806035] btrfs_dev_stat_print_on_error: 212 callbacks suppressed
[   32.806039] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718992, flush 0, corrupt 6, gen 0
[   32.806133] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806142] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718993, flush 0, corrupt 6, gen 0
[   32.806170] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806172] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718994, flush 0, corrupt 6, gen 0
[   32.806226] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806229] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718995, flush 0, corrupt 6, gen 0
[   32.806281] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806283] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718996, flush 0, corrupt 6, gen 0
[   32.806334] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806336] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718997, flush 0, corrupt 6, gen 0
[   32.806379] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806382] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718998, flush 0, corrupt 6, gen 0
[   32.806435] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806437] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2718999, flush 0, corrupt 6, gen 0
[   32.806479] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806481] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2719000, flush 0, corrupt 6, gen 0
[   32.806524] attempt to access beyond end of device
               sdb1: rw=0, want=496724096, limit=496091703
[   32.806526] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702088, rd 2719001, flush 0, corrupt 6, gen 0
[   41.305900] usb 1-1.1: new full-speed USB device number 3 using ehci-pci
[   41.399528] kauditd_printk_skb: 9 callbacks suppressed
[   41.399531] audit: type=1100 audit(1615529965.004:142): pid=3611 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_permit acct="locadmin" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.399537] audit: type=1101 audit(1615529965.004:143): pid=3611 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_unix acct="locadmin" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.399540] audit: type=1103 audit(1615529965.004:144): pid=3611 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_permit acct="locadmin" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.399543] audit: type=1006 audit(1615529965.004:145): pid=3611 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=4 res=1
[   41.399546] audit: type=1105 audit(1615529965.004:146): pid=3611 uid=0 auid=1000 ses=4 msg='op=PAM:session_open grantors=pam_permit,pam_loginuid acct="locadmin" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.406113] audit: type=1100 audit(1615529965.014:147): pid=3615 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_permit acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.406238] audit: type=1101 audit(1615529965.014:148): pid=3615 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_unix acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.406263] audit: type=1103 audit(1615529965.014:149): pid=3615 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_permit acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.406329] audit: type=1006 audit(1615529965.014:150): pid=3615 uid=0 old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=5 res=1
[   41.406349] audit: type=1105 audit(1615529965.014:151): pid=3615 uid=0 auid=0 ses=5 msg='op=PAM:session_open grantors=pam_permit,pam_loginuid acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[   41.469440] usb 1-1.1: New USB device found, idVendor=1050, idProduct=0407, bcdDevice= 5.24
[   41.469445] usb 1-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   41.469447] usb 1-1.1: Product: YubiKey OTP+FIDO+CCID
[   41.469449] usb 1-1.1: Manufacturer: Yubico
[   41.471401] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1:1.0/0003:1050:0407.0006/input/input38
[   41.536862] hid-generic 0003:1050:0407.0006: input,hidraw3: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input0
[   41.537938] hid-generic 0003:1050:0407.0007: hiddev97,hidraw4: USB HID v1.10 Device [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input1
[   43.095611] logitech-hidpp-device 0003:046D:101B.0004: HID++ 1.0 device connected.
[   45.507961] handle_bad_sector: 39 callbacks suppressed
[   45.507965] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.507970] btrfs_dev_stat_print_on_error: 39 callbacks suppressed
[   45.507974] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719017, flush 0, corrupt 6, gen 0
[   45.508057] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508066] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719018, flush 0, corrupt 6, gen 0
[   45.508086] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508088] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719019, flush 0, corrupt 6, gen 0
[   45.508107] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508109] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719020, flush 0, corrupt 6, gen 0
[   45.508130] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508132] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719021, flush 0, corrupt 6, gen 0
[   45.508152] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508154] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719022, flush 0, corrupt 6, gen 0
[   45.508173] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508175] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719023, flush 0, corrupt 6, gen 0
[   45.508191] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508193] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719024, flush 0, corrupt 6, gen 0
[   45.508209] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508211] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719025, flush 0, corrupt 6, gen 0
[   45.508228] attempt to access beyond end of device
               sdb1: rw=0, want=496476776, limit=496091703
[   45.508230] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702112, rd 2719026, flush 0, corrupt 6, gen 0
[   51.799101] kauditd_printk_skb: 12 callbacks suppressed
[   51.799103] audit: type=1131 audit(1615529975.858:164): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   52.066076] audit: type=1334 audit(1615529976.128:165): prog-id=24 op=UNLOAD
[   52.066083] audit: type=1334 audit(1615529976.128:166): prog-id=23 op=UNLOAD
[   84.481203] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1:1.0/0003:1050:0407.0008/input/input39
[   84.546641] hid-generic 0003:1050:0407.0008: input,hidraw3: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input0
[   84.548371] audit: type=1100 audit(1615530008.607:167): pid=12300 uid=1001 auid=1001 ses=2 msg='op=PAM:authentication grantors=pam_yubico acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   84.548376] audit: type=1101 audit(1615530008.607:168): pid=12300 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   84.564619] audit: type=1101 audit(1615530008.617:169): pid=12389 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   84.567497] audit: type=1110 audit(1615530008.627:170): pid=12389 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   84.568841] audit: type=1105 audit(1615530008.627:171): pid=12389 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   85.262271] audit: type=1106 audit(1615530009.317:172): pid=12389 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   85.262277] audit: type=1104 audit(1615530009.317:173): pid=12389 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[   95.971032] audit: type=1131 audit(1615530020.024:174): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=pcscd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   98.416603] audit: type=1130 audit(1615530022.464:175): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=man-db comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   98.416608] audit: type=1131 audit(1615530022.464:176): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=man-db comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  103.373572] audit: type=1131 audit(1615530027.423:177): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  113.837220] audit: type=1101 audit(1615530037.882:178): pid=14706 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  113.855459] audit: type=1101 audit(1615530037.902:179): pid=14707 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  113.856328] audit: type=1110 audit(1615530037.902:180): pid=14707 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  113.857395] audit: type=1105 audit(1615530037.902:181): pid=14707 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  113.860908] audit: type=1106 audit(1615530037.902:182): pid=14707 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  113.860959] audit: type=1104 audit(1615530037.902:183): pid=14707 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  132.793247] audit: type=1101 audit(1615530056.842:184): pid=14734 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  132.810380] audit: type=1101 audit(1615530056.852:185): pid=14735 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  132.810555] audit: type=1110 audit(1615530056.852:186): pid=14735 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  132.811262] audit: type=1105 audit(1615530056.852:187): pid=14735 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  133.549715] EXT4-fs (sdf1): mounted filesystem with ordered data mode. Opts: (null)
[  133.553580] audit: type=1106 audit(1615530057.602:188): pid=14735 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  133.553584] audit: type=1104 audit(1615530057.602:189): pid=14735 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  142.050471] audit: type=1131 audit(1615530066.092:190): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=libvirtd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  168.042220] audit: type=1101 audit(1615530092.092:191): pid=14818 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  168.058823] audit: type=1101 audit(1615530092.102:192): pid=14819 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  168.059090] audit: type=1110 audit(1615530092.102:193): pid=14819 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  168.060059] audit: type=1105 audit(1615530092.102:194): pid=14819 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  175.877323] audit: type=1106 audit(1615530099.922:195): pid=14819 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  175.877330] audit: type=1104 audit(1615530099.922:196): pid=14819 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  180.927054] handle_bad_sector: 17 callbacks suppressed
[  180.927057] attempt to access beyond end of device
               sdb1: rw=524288, want=496239584, limit=496091703
[  180.927283] attempt to access beyond end of device
               sdb1: rw=2049, want=496239584, limit=496091703
[  180.927290] btrfs_dev_stat_print_on_error: 17 callbacks suppressed
[  180.927294] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702126, rd 2719030, flush 0, corrupt 6, gen 0
[  180.948865] attempt to access beyond end of device
               sdb1: rw=524288, want=496239720, limit=496091703
[  180.957841] attempt to access beyond end of device
               sdb1: rw=2049, want=496239720, limit=496091703
[  180.957848] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702127, rd 2719030, flush 0, corrupt 6, gen 0
[  180.980486] attempt to access beyond end of device
               sdb1: rw=524288, want=497027224, limit=496091703
[  180.980846] attempt to access beyond end of device
               sdb1: rw=2049, want=497027224, limit=496091703
[  180.980856] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702128, rd 2719030, flush 0, corrupt 6, gen 0
[  180.989001] attempt to access beyond end of device
               sdb1: rw=524288, want=497027160, limit=496091703
[  180.989015] attempt to access beyond end of device
               sdb1: rw=524288, want=497027096, limit=496091703
[  180.989024] attempt to access beyond end of device
               sdb1: rw=524288, want=497027152, limit=496091703
[  180.989048] attempt to access beyond end of device
               sdb1: rw=524288, want=497027280, limit=496091703
[  180.992157] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702129, rd 2719030, flush 0, corrupt 6, gen 0
[  180.992169] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702130, rd 2719030, flush 0, corrupt 6, gen 0
[  180.992178] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702131, rd 2719030, flush 0, corrupt 6, gen 0
[  180.992204] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702132, rd 2719030, flush 0, corrupt 6, gen 0
[  180.995526] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702133, rd 2719030, flush 0, corrupt 6, gen 0
[  181.007441] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702134, rd 2719030, flush 0, corrupt 6, gen 0
[  181.007455] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702135, rd 2719030, flush 0, corrupt 6, gen 0
[  189.746637] audit: type=1130 audit(1615530113.793:197): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=pcscd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  214.905806] handle_bad_sector: 63 callbacks suppressed
[  214.905809] attempt to access beyond end of device
               sdb1: rw=2049, want=497027120, limit=496091703
[  214.905812] btrfs_dev_stat_print_on_error: 28 callbacks suppressed
[  214.905816] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702162, rd 2719032, flush 0, corrupt 6, gen 0
[  235.821052] audit: type=1101 audit(1615530159.873:198): pid=15334 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  235.837726] audit: type=1101 audit(1615530159.883:199): pid=15335 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  235.839752] audit: type=1110 audit(1615530159.883:200): pid=15335 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  235.839758] audit: type=1105 audit(1615530159.883:201): pid=15335 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  235.850195] audit: type=1106 audit(1615530159.893:202): pid=15335 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  235.850247] audit: type=1104 audit(1615530159.893:203): pid=15335 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  288.329728] audit: type=1101 audit(1615530212.373:204): pid=15428 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  288.343139] audit: type=1101 audit(1615530212.393:205): pid=15429 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  288.343560] audit: type=1110 audit(1615530212.393:206): pid=15429 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  288.344264] audit: type=1105 audit(1615530212.393:207): pid=15429 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  288.724157] audit: type=1106 audit(1615530212.773:208): pid=15429 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  288.724215] audit: type=1104 audit(1615530212.773:209): pid=15429 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[  637.036465] perf: interrupt took too long (2501 > 2500), lowering kernel.perf_event_max_sample_rate to 79900
[  638.705872] audit: type=1130 audit(1615530562.759:210): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapper-cleanup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  638.738221] audit: type=1130 audit(1615530562.799:211): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  640.354791] audit: type=1131 audit(1615530564.399:212): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapper-cleanup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  700.384996] audit: type=1131 audit(1615530624.439:213): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  928.732370] audit: type=1130 audit(1615530852.792:214): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  928.732375] audit: type=1131 audit(1615530852.792:215): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  928.907128] audit: type=1130 audit(1615530852.962:216): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=etckeeper comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[  928.907135] audit: type=1131 audit(1615530852.962:217): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=etckeeper comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 1203.736740] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1:1.0/0003:1050:0407.0009/input/input40
[ 1203.799110] hid-generic 0003:1050:0407.0009: input,hidraw3: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input0
[ 1236.318583] attempt to access beyond end of device
               sdb1: rw=2049, want=497027080, limit=496091703
[ 1236.318590] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702163, rd 2719032, flush 0, corrupt 6, gen 0
[ 1431.232415] attempt to access beyond end of device
               sdb1: rw=2049, want=497027120, limit=496091703
[ 1431.232420] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702164, rd 2719032, flush 0, corrupt 6, gen 0
[ 1508.209634] perf: interrupt took too long (3130 > 3126), lowering kernel.perf_event_max_sample_rate to 63900
[ 1640.339273] attempt to access beyond end of device
               sdb1: rw=2049, want=497027080, limit=496091703
[ 1640.339278] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702165, rd 2719032, flush 0, corrupt 6, gen 0
[ 2023.275538] attempt to access beyond end of device
               sdb1: rw=2049, want=497027120, limit=496091703
[ 2023.275544] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702166, rd 2719032, flush 0, corrupt 6, gen 0
[ 2035.970288] attempt to access beyond end of device
               sdb1: rw=2049, want=497027200, limit=496091703
[ 2035.970295] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702167, rd 2719032, flush 0, corrupt 6, gen 0
[ 2035.987838] attempt to access beyond end of device
               sdb1: rw=2049, want=497027208, limit=496091703
[ 2035.987844] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702168, rd 2719032, flush 0, corrupt 6, gen 0
[ 2046.208771] attempt to access beyond end of device
               sdb1: rw=2049, want=497027080, limit=496091703
[ 2046.208777] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702169, rd 2719032, flush 0, corrupt 6, gen 0
[ 2061.638792] attempt to access beyond end of device
               sdb1: rw=2049, want=497027120, limit=496091703
[ 2061.638797] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702170, rd 2719032, flush 0, corrupt 6, gen 0
[ 2102.394823] attempt to access beyond end of device
               sdb1: rw=2049, want=497027080, limit=496091703
[ 2102.394829] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702171, rd 2719032, flush 0, corrupt 6, gen 0
[ 2488.680322] audit: type=1130 audit(1615532412.764:218): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 2488.702156] audit: type=1130 audit(1615532412.784:219): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 2488.705790] audit: type=1131 audit(1615532412.784:220): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapper-timeline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 2536.011626] audit: type=1100 audit(1615532460.095:221): pid=18197 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_permit acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[ 2536.011798] audit: type=1101 audit(1615532460.095:222): pid=18197 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_unix acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[ 2536.011835] audit: type=1103 audit(1615532460.095:223): pid=18197 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_permit acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[ 2536.011927] audit: type=1006 audit(1615532460.095:224): pid=18197 uid=0 old-auid=4294967295 auid=0 tty=(none) old-ses=4294967295 ses=7 res=1
[ 2536.011953] audit: type=1105 audit(1615532460.095:225): pid=18197 uid=0 auid=0 ses=7 msg='op=PAM:session_open grantors=pam_permit,pam_loginuid acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[ 2536.020808] audit: type=1104 audit(1615532460.105:226): pid=18197 uid=0 auid=0 ses=7 msg='op=PAM:setcred grantors=pam_permit acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[ 2536.020836] audit: type=1106 audit(1615532460.105:227): pid=18197 uid=0 auid=0 ses=7 msg='op=PAM:session_close grantors=pam_permit,pam_loginuid acct="root" exe="/usr/bin/fcron" hostname=? addr=? terminal=? res=success'
[ 2548.761897] audit: type=1131 audit(1615532472.845:228): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=snapperd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[ 2573.912416] perf: interrupt took too long (3914 > 3912), lowering kernel.perf_event_max_sample_rate to 51100
[ 2763.239931] attempt to access beyond end of device
               sdb1: rw=2049, want=497027120, limit=496091703
[ 2763.239938] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702172, rd 2719032, flush 0, corrupt 6, gen 0
[ 2944.218349] attempt to access beyond end of device
               sdb1: rw=2049, want=497027080, limit=496091703
[ 2944.218355] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702173, rd 2719032, flush 0, corrupt 6, gen 0
[ 2957.644378] attempt to access beyond end of device
               sdb1: rw=2049, want=497027208, limit=496091703
[ 2957.644385] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702174, rd 2719032, flush 0, corrupt 6, gen 0
[ 3297.467464] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1:1.0/0003:1050:0407.000A/input/input41
[ 3297.539933] hid-generic 0003:1050:0407.000A: input,hidraw3: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input0
[ 3297.540297] audit: type=1100 audit(1615533221.636:229): pid=19084 uid=1001 auid=1001 ses=2 msg='op=PAM:authentication grantors=pam_yubico acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3297.540631] audit: type=1101 audit(1615533221.636:230): pid=19084 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3297.558333] audit: type=1101 audit(1615533221.656:231): pid=19094 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3297.559418] audit: type=1110 audit(1615533221.656:232): pid=19094 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3297.559422] audit: type=1105 audit(1615533221.656:233): pid=19094 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3297.857330] audit: type=1106 audit(1615533221.946:234): pid=19094 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3297.857336] audit: type=1104 audit(1615533221.946:235): pid=19094 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3301.250474] audit: type=1101 audit(1615533225.346:236): pid=19115 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3301.267280] audit: type=1101 audit(1615533225.356:237): pid=19116 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3301.267924] audit: type=1110 audit(1615533225.356:238): pid=19116 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3322.422584] attempt to access beyond end of device
               sdb1: rw=2049, want=497027080, limit=496091703
[ 3322.422590] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719032, flush 0, corrupt 6, gen 0
[ 3345.702100] kauditd_printk_skb: 3 callbacks suppressed
[ 3345.702102] audit: type=1101 audit(1615533269.796:242): pid=19245 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3345.714292] audit: type=1101 audit(1615533269.806:243): pid=19246 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3345.715641] audit: type=1110 audit(1615533269.806:244): pid=19246 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3345.715649] audit: type=1105 audit(1615533269.806:245): pid=19246 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3345.728285] audit: type=1106 audit(1615533269.826:246): pid=19246 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3345.728291] audit: type=1104 audit(1615533269.826:247): pid=19246 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3358.083392] audit: type=1101 audit(1615533282.176:248): pid=19274 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3358.098735] audit: type=1101 audit(1615533282.196:249): pid=19275 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3358.098933] audit: type=1110 audit(1615533282.196:250): pid=19275 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3358.099645] audit: type=1105 audit(1615533282.196:251): pid=19275 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3358.111125] audit: type=1106 audit(1615533282.206:252): pid=19275 uid=1001 auid=1001 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 3358.111151] audit: type=1104 audit(1615533282.206:253): pid=19275 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 4316.340946] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1:1.0/0003:1050:0407.000B/input/input42
[ 4316.402834] hid-generic 0003:1050:0407.000B: input,hidraw3: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input0
[ 4316.403128] audit: type=1100 audit(1615534240.511:254): pid=20270 uid=1001 auid=1001 ses=2 msg='op=PAM:authentication grantors=pam_yubico acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 4316.403501] audit: type=1101 audit(1615534240.511:255): pid=20270 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 4316.425832] audit: type=1101 audit(1615534240.531:256): pid=20281 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 4316.426857] audit: type=1110 audit(1615534240.531:257): pid=20281 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 4316.426861] audit: type=1105 audit(1615534240.531:258): pid=20281 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
[ 4317.462041] attempt to access beyond end of device
               sdb1: rw=524288, want=497859712, limit=496091703
[ 4317.462065] attempt to access beyond end of device
               sdb1: rw=524288, want=497859840, limit=496091703
[ 4317.462079] attempt to access beyond end of device
               sdb1: rw=256, want=497859704, limit=496091703
[ 4317.462087] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719033, flush 0, corrupt 6, gen 0
[ 4317.462090] attempt to access beyond end of device
               sdb1: rw=256, want=497859720, limit=496091703
[ 4317.462092] attempt to access beyond end of device
               sdb1: rw=524288, want=497859968, limit=496091703
[ 4317.462096] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719034, flush 0, corrupt 6, gen 0
[ 4317.462108] attempt to access beyond end of device
               sdb1: rw=256, want=497859728, limit=496091703
[ 4317.462110] attempt to access beyond end of device
               sdb1: rw=256, want=497859712, limit=496091703
[ 4317.462113] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719035, flush 0, corrupt 6, gen 0
[ 4317.462115] attempt to access beyond end of device
               sdb1: rw=524288, want=497860096, limit=496091703
[ 4317.462118] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719036, flush 0, corrupt 6, gen 0
[ 4317.462126] attempt to access beyond end of device
               sdb1: rw=256, want=497859736, limit=496091703
[ 4317.462128] attempt to access beyond end of device
               sdb1: rw=256, want=497859848, limit=496091703
[ 4317.462131] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719037, flush 0, corrupt 6, gen 0
[ 4317.462133] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719038, flush 0, corrupt 6, gen 0
[ 4317.462142] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719039, flush 0, corrupt 6, gen 0
[ 4317.462144] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719040, flush 0, corrupt 6, gen 0
[ 4317.462151] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719041, flush 0, corrupt 6, gen 0
[ 4317.462153] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702175, rd 2719042, flush 0, corrupt 6, gen 0
[ 4422.451691] handle_bad_sector: 200 callbacks suppressed
[ 4422.451694] attempt to access beyond end of device
               sdb1: rw=2049, want=497027120, limit=496091703
[ 4422.451699] btrfs_dev_stat_print_on_error: 190 callbacks suppressed
[ 4422.451702] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702277, rd 2719132, flush 0, corrupt 6, gen 0
[ 4434.754901] attempt to access beyond end of device
               sdb1: rw=2049, want=497027208, limit=496091703
[ 4434.754907] BTRFS error (device sda1): bdev /dev/sdb1 errs: wr 2702278, rd 2719132, flush 0, corrupt 6, gen 0
[ 4524.922812] input: Yubico YubiKey OTP+FIDO+CCID as /devices/pci0000:00/0000:00:1a.7/usb1/1-1/1-1.1/1-1.1:1.0/0003:1050:0407.000C/input/input43
[ 4524.997891] hid-generic 0003:1050:0407.000C: input,hidraw3: USB HID v1.10 Keyboard [Yubico YubiKey OTP+FIDO+CCID] on usb-0000:00:1a.7-1.1/input0
[ 4524.998152] audit: type=1100 audit(1615534449.116:259): pid=20816 uid=1001 auid=1001 ses=2 msg='op=PAM:authentication grantors=pam_yubico acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4524.998469] audit: type=1101 audit(1615534449.116:260): pid=20816 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.017845] audit: type=1101 audit(1615534449.136:261): pid=20824 uid=1001 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="thomas" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.019484] audit: type=1110 audit(1615534449.136:262): pid=20824 uid=1001 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_yubico acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.019488] audit: type=1105 audit(1615534449.136:263): pid=20824 uid=1001 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.024356] audit: type=1100 audit(1615534449.136:264): pid=20829 uid=0 auid=1001 ses=2 msg='op=PAM:authentication grantors=pam_rootok acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.024470] audit: type=1101 audit(1615534449.136:265): pid=20829 uid=0 auid=1001 ses=2 msg='op=PAM:accounting grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.024834] audit: type=1103 audit(1615534449.136:266): pid=20829 uid=0 auid=1001 ses=2 msg='op=PAM:setcred grantors=pam_rootok acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4525.024957] audit: type=1105 audit(1615534449.136:267): pid=20829 uid=0 auid=1001 ses=2 msg='op=PAM:session_open grantors=pam_unix acct="root" exe="/usr/bin/su" hostname=? addr=? terminal=/dev/pts/1 res=success'
[ 4539.476135] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 4539.476141] floppy: error 10 while reading block 0
[ 4567.404964] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 4567.404970] floppy: error 10 while reading block 0

--------------B8888A802AA19D7DE9FF1BA0--
