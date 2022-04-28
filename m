Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550865135D3
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbiD1N6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbiD1N6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:58:44 -0400
X-Greylist: delayed 71 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Apr 2022 06:55:25 PDT
Received: from re-prd-fep-043.btinternet.com (mailomta32-re.btinternet.com [213.120.69.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CCD24BEA
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:55:22 -0700 (PDT)
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20220428135409.QLOC3069.re-prd-fep-049.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
          for <linux-btrfs@vger.kernel.org>;
          Thu, 28 Apr 2022 14:54:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1651154049; 
        bh=88fR0NW8Zj0oEmZP6G2boT8eo5dHvskYrnaWok2m8LE=;
        h=To:Message-ID:Subject:MIME-Version:From:Reply-To:Date;
        b=XaPBEi0fwjcgGL567UmSaxD6HN0yYgOFsH+uHs6o6CDd43vTt6SqHoT1qotBu64TJTJOIe5hG8HNp5zLQhH1V2B3sNJ6fAVC0oJk7uhEj70THD4bPgamTEYTQCS7lLm3JH2ymICBTHO8GY1C5dJMv3uKnIqw4Ufm/9o9OPzSntnLbmn8RUZiBr2u+MhmzxCEVepqcjKwA2n1V5bGKuAxGYZA71gW4wBAF5WyYsaowdBx/aDcLpFGPmqGp8B4G5hM45Mku1kg04Ae08aK2W/BLe4dNx5qX4mV8h/v5xl5FDs31GkUCLECrWlRUj7vG+BVJxGH5PNYixPRq/fg23C8ZQ==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613A9124206EF3C6
X-OWM-Env-Sender: alex.challis@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudejgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefvkffugggtfghihfhrffesmhdtregstderjeenucfhrhhomhepfdgrlhgvgidrtghhrghllhhishdfuceorghlvgigrdgthhgrlhhlihhssegsthhinhhtvghrnhgvthdrtghomheqnecuggftrfgrthhtvghrnhepveejffdutefhgeelheevvefgjedtteehgfehtdehkefhkeeglefffeeiudehiedtnecukfhppedutddrvddrheegrdduudejpdekiedrudejiedrudehhedrleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehrvgdqphhrugdquhigfhgvphdqtdefiedrsghtmhigqdhprhgurdhshihntghhrhhonhhoshhsrdhnvghtpdhinhgvthepuddtrddvrdehgedruddujedpmhgrihhlfhhrohhmpegrlhgvgidrtghhrghllhhishessghtihhnthgvrhhnvghtrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from re-prd-uxfep-036.btmx-prd.synchronoss.net (10.2.54.117) by re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.716.04)
        id 613A9124206EF3C6 for linux-btrfs@vger.kernel.org; Thu, 28 Apr 2022 14:54:09 +0100
Received: from [86.176.155.9]
        by email.bt.com with HTTP; Thu, 28 Apr 2022 14:54:09 +0100
To:     linux-btrfs@vger.kernel.org
Message-ID: <24c3cfee.732c.180707358a1.Webtop.117@btinternet.com>
Subject: Recovery of BTRFS critical (device md126): corrupt  leaf, bad key
 order: block=10872141938688, root=1, slot=119
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_167607_2019865139.1651154049166"
User-Agent: OWM Mail 3
X-SID:  117
X-Originating-IP: [86.176.155.9]
From:   "alex.challis" <alex.challis@btinternet.com>
Reply-To: alex.challis@btinternet.com
Date:   Thu, 28 Apr 2022 14:54:09 +0100 (BST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------=_Part_167607_2019865139.1651154049166
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=no
Content-Transfer-Encoding: 7bit

Dear BTRFS Team

Have a NetGear ReadyNas that uses brtfs for the data volume 
(/dev/disk/by-label/33eaff11\:HDD1).

Was attempting to stop a running container (Docker CE) around the time 
the failure happened. Had just docker pulled a new version of 
container. Not 100% sure they were related but NAS dropped data volume 
into RO mode around the time of stopping the container. Subsequent 
attempts to docker rm the container failed with read-only file system 
errors. Upon re-boot the data volume would no longer mount.

  uname -a:
Linux fatterboy 4.4.218.x86_64.1 #1 SMP Sun Nov 7 15:20:05 UTC 2021 
x86_64 GNU/Linux

   btrfs --version:
btrfs-progs v4.16

   btrfs fi show:
Label: '33eaff11:root'  uuid: e360cd8a-7496-4714-a0b7-dadb4829e6f5
         Total devices 1 FS bytes used 993.29MiB
         devid    1 size 4.00GiB used 2.45GiB path /dev/md0

Label: '33eaff11:HDD1'  uuid: 9dbd11f2-da2f-4f68-a4e9-552cbc90d1e0
         Total devices 2 FS bytes used 4.25TiB
         devid    1 size 5.44TiB used 4.41TiB path /dev/md126
         devid    2 size 461.13GiB used 7.03GiB path /dev/md127

   btrfs fi df /HDD1 :
Data, single: total=2.04GiB, used=979.09MiB
System, DUP: total=8.00MiB, used=16.00KiB
Metadata, DUP: total=204.56MiB, used=14.19MiB
GlobalReserve, single: total=16.00MiB, used=0.00B

   dmesg > dmesg.log
Attached


Culprit seems to be:
  dmesg | grep -i btrfs
[    1.337264] Btrfs loaded, crc32c=crc32c-generic
[   23.296969] BTRFS: device label 33eaff11:root devid 1 transid 2341967 
/dev/md0
[   23.297437] BTRFS info (device md0): has skinny extents
[   24.505292] BTRFS: device label 33eaff11:HDD1 devid 2 transid 1424350 
/dev/md127
[   24.643613] BTRFS: device label 33eaff11:HDD1 devid 1 transid 1424350 
/dev/md126
[   24.800256] BTRFS info (device md126): has skinny extents
[   24.894582] BTRFS critical (device md126): corrupt leaf, bad key 
order: block=10872141938688, root=1, slot=119
[   24.894596] BTRFS error (device md126): failed to read block groups: 
-5
[   24.894811] BTRFS error (device md126): failed to read block groups: 
-17
[   24.898074] BTRFS error (device md126): failed to read block groups: 
-17
[   24.912298] BTRFS error (device md126): failed to read block groups: 
-17
[   24.912851] BTRFS error (device md126): parent transid verify failed 
on 10872188272640 wanted 1424347 found 1424349
[   24.912857] BTRFS warning (device md126): failed to read tree root
[   24.933058] BTRFS error (device md126): open_ctree failed

  btrfs-debug-tree -b 10872141938688 /dev/disk/by-label/33eaff11\:HDD1
<clip>
         item 117 key (1127493074944 METADATA_ITEM 0) itemoff 27954 
itemsize 33
                 refs 1 gen 23101 flags TREE_BLOCK
                 tree block skinny level 0
                 tree block backref root 7
         item 118 key (1127493107712 METADATA_ITEM 0) itemoff 27894 
itemsize 60
                 refs 4 gen 718838 flags TREE_BLOCK|FULL_BACKREF
                 tree block skinny level 0
                 shared block backref parent 4593432821760
                 shared block backref parent 4593432788992
                 shared block backref parent 4593432756224
                 shared block backref parent 4593432723456
         item 119 key (2211708928 UNKNOWN.0 0) itemoff 27834 itemsize 60
         item 120 key (1127493173248 METADATA_ITEM 0) itemoff 27801 
itemsize 33
                 refs 1 gen 29828 flags TREE_BLOCK
                 tree block skinny level 0
                 tree block backref root 7
<clip>

Key 119 is out of sequence and type UNKNOWN (!?)



Please advise on recovery please?


Cheers
Alex.

------=_Part_167607_2019865139.1651154049166
Content-Type: application/unknown; name=dmesg.log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dmesg.log

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 4.4.218.x86_64.1 (root@blocks) (gcc version 8.3.0 (Debian 8.3.0-6) ) #1 SMP Sun Nov 7 15:20:05 UTC 2021
[    0.000000] Command line: initrd=initrd.gz reason=normal BOOT_IMAGE=kernel 
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] Disabled fast string operations
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Enabled xstate features 0x3, context size is 576 bytes, using 'standard' format.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009cbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009cc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000afeaffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000afeb0000-0x00000000afebdfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000afebe000-0x00000000afeeffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000afef0000-0x00000000afefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000014fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 080014  07/26/2010
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x150000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 100000000 mask FC0000000 write-back
[    0.000000]   2 base 140000000 mask FF0000000 write-back
[    0.000000]   3 base 0B0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   5 base 0AFF00000 mask FFFF00000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xaff00000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xafeb0 max_arch_pfn = 0x400000000
[    0.000000] Base memory trampoline at [ffff880000094000] 94000 size 28672
[    0.000000] BRK [0x08f56000, 0x08f56fff] PGTABLE
[    0.000000] BRK [0x08f57000, 0x08f57fff] PGTABLE
[    0.000000] BRK [0x08f58000, 0x08f58fff] PGTABLE
[    0.000000] BRK [0x08f59000, 0x08f59fff] PGTABLE
[    0.000000] BRK [0x08f5a000, 0x08f5afff] PGTABLE
[    0.000000] RAMDISK: [mem 0x7fb9f000-0x7fffffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F9C00 000014 (v00 ACPIAM)
[    0.000000] ACPI: RSDT 0x00000000AFEB0000 000038 (v01 A M I  OEMRSDT  07001026 MSFT 00000097)
[    0.000000] ACPI: FACP 0x00000000AFEB0200 000084 (v02 A M I  OEMFACP  07001026 MSFT 00000097)
[    0.000000] ACPI: DSDT 0x00000000AFEB0440 005B7A (v01 1ADHK  1ADHK007 00000007 INTL 20051117)
[    0.000000] ACPI: FACS 0x00000000AFEBE000 000040
[    0.000000] ACPI: APIC 0x00000000AFEB0390 00006C (v01 A M I  OEMAPIC  07001026 MSFT 00000097)
[    0.000000] ACPI: MCFG 0x00000000AFEB0400 00003C (v01 A M I  OEMMCFG  07001026 MSFT 00000097)
[    0.000000] ACPI: OEMB 0x00000000AFEBE040 000060 (v01 A M I  AMI_OEM  07001026 MSFT 00000097)
[    0.000000] ACPI: GSCI 0x00000000AFEBE0A0 002024 (v01 A M I  GMCHSCI  07001026 MSFT 00000097)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000014fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009bfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000afeaffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000014fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000014fffffff]
[    0.000000] On node 0 totalpages: 1048139
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3995 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 11195 pages used for memmap
[    0.000000]   DMA32 zone: 716464 pages, LIFO batch:31
[    0.000000]   Normal zone: 5120 pages used for memmap
[    0.000000]   Normal zone: 327680 pages, LIFO batch:31
[    0.000000] Reserving Intel graphics stolen memory at 0xaff00000-0xafffffff
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] e820: [mem 0xb0000000-0xfedfffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff88014fc00000 s82392 r8192 d32296 u524288
[    0.000000] pcpu-alloc: s82392 r8192 d32296 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1031738
[    0.000000] Kernel command line: console=tty0 console=ttyS0,115200 hpet=disable initrd=initrd.gz reason=normal BOOT_IMAGE=kernel 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] Memory: 4033932K/4192556K available (9142K kernel code, 989K rwdata, 3940K rodata, 872K init, 696K bss, 158624K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU debugfs-based tracing is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:4352 nr_irqs:456 16
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS0] enabled
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3059.233 MHz processor
[    0.001010] Calibrating delay loop (skipped), value calculated using timer frequency.. 6118.46 BogoMIPS (lpj=3059233)
[    0.001012] pid_max: default: 32768 minimum: 301
[    0.001018] ACPI: Core revision 20150930
[    0.005294] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.005312] Security Framework initialized
[    0.005322] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.005324] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.005634] Initializing cgroup subsys io
[    0.005639] Initializing cgroup subsys memory
[    0.005648] Initializing cgroup subsys devices
[    0.005652] Initializing cgroup subsys freezer
[    0.005655] Initializing cgroup subsys net_cls
[    0.005659] Initializing cgroup subsys perf_event
[    0.005661] Initializing cgroup subsys net_prio
[    0.005665] Initializing cgroup subsys pids
[    0.005682] Disabled fast string operations
[    0.005686] CPU: Physical Processor ID: 0
[    0.005687] CPU: Processor Core ID: 0
[    0.005689] mce: CPU supports 6 MCE banks
[    0.005698] CPU0: Thermal monitoring enabled (TM2)
[    0.005701] process: using mwait in idle threads
[    0.005706] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
[    0.005707] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32, 1GB 0
[    0.005709] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.005711] Spectre V2 : Mitigation: Full generic retpoline
[    0.005712] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.005714] Speculative Store Bypass: Vulnerable
[    0.005734] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.006110] Freeing SMP alternatives memory: 40K
[    0.007438] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.119047] smpboot: CPU0: Intel(R) Core(TM)2 Duo CPU     E7600  @ 3.06GHz (family: 0x6, model: 0x17, stepping: 0xa)
[    0.119061] Performance Events: PEBS fmt0+, 4-deep LBR, Core2 events, Intel PMU driver.
[    0.119071] ... version:                2
[    0.119072] ... bit width:              40
[    0.119073] ... generic registers:      2
[    0.119074] ... value mask:             000000ffffffffff
[    0.119075] ... max period:             000000007fffffff
[    0.119077] ... fixed-purpose events:   3
[    0.119078] ... event mask:             0000000700000003
[    0.120492] x86: Booting SMP configuration:
[    0.120494] .... node  #0, CPUs:      #1
[    0.121036] x86: Booted up 1 node, 2 CPUs
[    0.121040] smpboot: Total of 2 processors activated (12236.93 BogoMIPS)
[    0.122102] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.122148] devtmpfs: initialized
[    0.123022] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.123027] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.123109] xor: measuring software checksum speed
[    0.133001]    prefetch64-sse: 17440.000 MB/sec
[    0.143001]    generic_sse: 14712.000 MB/sec
[    0.143002] xor: using function: prefetch64-sse (17440.000 MB/sec)
[    0.143008] pinctrl core: initialized pinctrl subsystem
[    0.143153] NET: Registered protocol family 16
[    0.147010] cpuidle: using governor ladder
[    0.150004] cpuidle: using governor menu
[    0.150223] ACPI: bus type PCI registered
[    0.151035] dca service started, version 1.12.1
[    0.151035] PCI: Using configuration type 1 for base access
[    0.173120] raid6: sse2x1   gen()  4617 MB/s
[    0.190109] raid6: sse2x1   xor()  4900 MB/s
[    0.207109] raid6: sse2x2   gen()  5066 MB/s
[    0.224112] raid6: sse2x2   xor()  5562 MB/s
[    0.241112] raid6: sse2x4   gen()  9125 MB/s
[    0.258112] raid6: sse2x4   xor()  6861 MB/s
[    0.258114] raid6: using algorithm sse2x4 gen() 9125 MB/s
[    0.258115] raid6: .... xor() 6861 MB/s, rmw enabled
[    0.258117] raid6: using ssse3x2 recovery algorithm
[    0.259109] ACPI: Added _OSI(Module Device)
[    0.259109] ACPI: Added _OSI(Processor Device)
[    0.259109] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.259109] ACPI: Added _OSI(Processor Aggregator Device)
[    0.259758] ACPI: Executed 1 blocks of module-level executable AML code
[    0.261750] ACPI: Interpreter enabled
[    0.261755] ACPI: (supports S0 S5)
[    0.261756] ACPI: Using IOAPIC for interrupt routing
[    0.262004] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.267022] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.267022] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.267022] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.267022] PCI host bridge to bus 0000:00
[    0.267022] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.267022] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.267022] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.267022] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000dffff window]
[    0.267022] pci_bus 0000:00: root bus resource [mem 0xaff00000-0xffffffff window]
[    0.267022] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.267022] pci 0000:00:00.0: [8086:2990] type 00 class 0x060000
[    0.267046] pci 0000:00:02.0: [8086:2992] type 00 class 0x030000
[    0.267058] pci 0000:00:02.0: reg 0x10: [mem 0xffa00000-0xffafffff]
[    0.267067] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    0.267071] pci 0000:00:02.0: reg 0x20: [io  0xec00-0xec07]
[    0.268000] pci 0000:00:1a.0: [8086:2834] type 00 class 0x0c0300
[    0.268000] pci 0000:00:1a.0: reg 0x20: [io  0xe000-0xe01f]
[    0.268020] pci 0000:00:1a.1: [8086:2835] type 00 class 0x0c0300
[    0.268020] pci 0000:00:1a.1: reg 0x20: [io  0xdc00-0xdc1f]
[    0.268020] pci 0000:00:1a.7: [8086:283a] type 00 class 0x0c0320
[    0.268020] pci 0000:00:1a.7: reg 0x10: [mem 0xff9fb400-0xff9fb7ff]
[    0.268020] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.268022] pci 0000:00:1b.0: [8086:284b] type 00 class 0x040300
[    0.268022] pci 0000:00:1b.0: reg 0x10: [mem 0xff9f4000-0xff9f7fff 64bit]
[    0.268022] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.268022] pci 0000:00:1c.0: [8086:283f] type 01 class 0x060400
[    0.268022] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.268022] pci 0000:00:1c.1: [8086:2841] type 01 class 0x060400
[    0.268022] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.268022] pci 0000:00:1d.0: [8086:2830] type 00 class 0x0c0300
[    0.268022] pci 0000:00:1d.0: reg 0x20: [io  0xd880-0xd89f]
[    0.268083] pci 0000:00:1d.1: [8086:2831] type 00 class 0x0c0300
[    0.268119] pci 0000:00:1d.1: reg 0x20: [io  0xd800-0xd81f]
[    0.269004] pci 0000:00:1d.2: [8086:2832] type 00 class 0x0c0300
[    0.269004] pci 0000:00:1d.2: reg 0x20: [io  0xd480-0xd49f]
[    0.269022] pci 0000:00:1d.7: [8086:2836] type 00 class 0x0c0320
[    0.269022] pci 0000:00:1d.7: reg 0x10: [mem 0xff9fb000-0xff9fb3ff]
[    0.269022] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.269024] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.269024] pci 0000:00:1f.0: [8086:2810] type 00 class 0x060100
[    0.269024] pci 0000:00:1f.0: quirk: [io  0x0800-0x087f] claimed by ICH6 ACPI/GPIO/TCO
[    0.269024] pci 0000:00:1f.0: quirk: [io  0x0480-0x04bf] claimed by ICH6 GPIO
[    0.269024] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00 (mask 00ff)
[    0.269024] pci 0000:00:1f.2: [8086:2821] type 00 class 0x010601
[    0.269024] pci 0000:00:1f.2: reg 0x10: [io  0xe880-0xe887]
[    0.269024] pci 0000:00:1f.2: reg 0x14: [io  0xe800-0xe803]
[    0.269024] pci 0000:00:1f.2: reg 0x18: [io  0xe480-0xe487]
[    0.269024] pci 0000:00:1f.2: reg 0x1c: [io  0xe400-0xe403]
[    0.269024] pci 0000:00:1f.2: reg 0x20: [io  0xe080-0xe09f]
[    0.269024] pci 0000:00:1f.2: reg 0x24: [mem 0xff9fb800-0xff9fbfff]
[    0.269024] pci 0000:00:1f.2: PME# supported from D3hot
[    0.269024] pci 0000:00:1f.3: [8086:283e] type 00 class 0x0c0500
[    0.269024] pci 0000:00:1f.3: reg 0x10: [mem 0xff9fac00-0xff9facff]
[    0.269024] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
[    0.269071] pci 0000:01:00.0: [11ab:4362] type 00 class 0x020000
[    0.269108] pci 0000:01:00.0: reg 0x10: [mem 0xff6fc000-0xff6fffff 64bit]
[    0.269119] pci 0000:01:00.0: reg 0x18: [io  0xb800-0xb8ff]
[    0.269157] pci 0000:01:00.0: reg 0x30: [mem 0xff6c0000-0xff6dffff pref]
[    0.269197] pci 0000:01:00.0: supports D1 D2
[    0.269199] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.270000] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.270000] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.270000] pci 0000:00:1c.0:   bridge window [io  0xb000-0xbfff]
[    0.270000] pci 0000:00:1c.0:   bridge window [mem 0xff600000-0xff6fffff]
[    0.270021] pci 0000:02:00.0: [11ab:4362] type 00 class 0x020000
[    0.270021] pci 0000:02:00.0: reg 0x10: [mem 0xff7fc000-0xff7fffff 64bit]
[    0.270021] pci 0000:02:00.0: reg 0x18: [io  0xc800-0xc8ff]
[    0.270021] pci 0000:02:00.0: reg 0x30: [mem 0xff7c0000-0xff7dffff pref]
[    0.270021] pci 0000:02:00.0: supports D1 D2
[    0.270021] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.270021] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.270021] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.270021] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
[    0.270021] pci 0000:00:1c.1:   bridge window [mem 0xff700000-0xff7fffff]
[    0.270021] pci 0000:00:1e.0: PCI bridge to [bus 03] (subtractive decode)
[    0.270021] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.270021] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.270021] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.270021] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dffff window] (subtractive decode)
[    0.270021] pci 0000:00:1e.0:   bridge window [mem 0xaff00000-0xffffffff window] (subtractive decode)
[    0.270021] pci_bus 0000:00: on NUMA node 0
[    0.271020] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.271020] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.271020] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 *14 15)
[    0.271020] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.271020] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.271020] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 *15)
[    0.271020] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.271020] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.271020] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.271068] SCSI subsystem initialized
[    0.271068] libata version 3.00 loaded.
[    0.271068] ACPI: bus type USB registered
[    0.271068] usbcore: registered new interface driver usbfs
[    0.271102] usbcore: registered new interface driver hub
[    0.271102] usbcore: registered new device driver usb
[    0.271148] pps_core: LinuxPPS API ver. 1 registered
[    0.271148] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.271148] PTP clock support registered
[    0.271324] Advanced Linux Sound Architecture Driver Initialized.
[    0.271324] PCI: Using ACPI for IRQ routing
[    0.271324] PCI: pci_cache_line_size set to 64 bytes
[    0.271324] Expanded resource reserved due to conflict with PCI Bus 0000:00
[    0.271324] e820: reserve RAM buffer [mem 0x0009cc00-0x0009ffff]
[    0.271324] e820: reserve RAM buffer [mem 0xafeb0000-0xafffffff]
[    0.272087] Bluetooth: Core ver 2.21
[    0.272087] NET: Registered protocol family 31
[    0.272087] Bluetooth: HCI device and connection manager initialized
[    0.272087] Bluetooth: HCI socket layer initialized
[    0.272087] Bluetooth: L2CAP socket layer initialized
[    0.272087] Bluetooth: SCO socket layer initialized
[    0.272436] clocksource: Switched to clocksource refined-jiffies
[    0.272496] FS-Cache: Loaded
[    0.272496] pnp: PnP ACPI init
[    0.272496] system 00:00: [mem 0xfed14000-0xfed19fff] has been reserved
[    0.272496] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.272496] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.272496] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 PNP030b (active)
[    0.272496] pnp 00:03: [dma 0 disabled]
[    0.272496] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.272496] pnp 00:04: [dma 0 disabled]
[    0.273018] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.273018] system 00:05: [io  0x0a00-0x0a0f] has been reserved
[    0.273018] system 00:05: [io  0x0a10-0x0a1f] has been reserved
[    0.273018] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.273019] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.273019] system 00:06: [io  0x0800-0x087f] has been reserved
[    0.273019] system 00:06: [io  0x0480-0x04bf] has been reserved
[    0.273019] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.273019] system 00:06: [mem 0xfed20000-0xfed8ffff] has been reserved
[    0.273019] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.273019] system 00:07: [mem 0xffc00000-0xffefffff] has been reserved
[    0.273019] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.273020] system 00:08: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.273020] system 00:08: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.273020] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.273020] system 00:09: [mem 0xe0000000-0xefffffff] has been reserved
[    0.273020] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.273075] system 00:0a: [mem 0x00000000-0x0009ffff] could not be reserved
[    0.273078] system 00:0a: [mem 0x000c0000-0x000cffff] could not be reserved
[    0.273080] system 00:0a: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.273082] system 00:0a: [mem 0x00100000-0xafefffff] could not be reserved
[    0.273085] system 00:0a: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.274002] pnp: PnP ACPI: found 11 devices
[    0.280928] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.281070] clocksource: Switched to clocksource acpi_pm
[    0.281088] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    0.281096] pci 0000:00:1c.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.281110] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.281112] pci 0000:00:1c.0: res[9]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.281115] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x000fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.281117] pci 0000:00:1c.1: res[9]=[mem 0x00100000-0x002fffff 64bit pref] res_to_dev_res add_size 200000 min_align 100000
[    0.281125] pci 0000:00:1c.0: BAR 9: assigned [mem 0xb0000000-0xb01fffff 64bit pref]
[    0.281130] pci 0000:00:1c.1: BAR 9: assigned [mem 0xb0200000-0xb03fffff 64bit pref]
[    0.281133] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.281136] pci 0000:00:1c.0:   bridge window [io  0xb000-0xbfff]
[    0.281141] pci 0000:00:1c.0:   bridge window [mem 0xff600000-0xff6fffff]
[    0.281144] pci 0000:00:1c.0:   bridge window [mem 0xb0000000-0xb01fffff 64bit pref]
[    0.281149] pci 0000:00:1c.1: PCI bridge to [bus 02]
[    0.281152] pci 0000:00:1c.1:   bridge window [io  0xc000-0xcfff]
[    0.281156] pci 0000:00:1c.1:   bridge window [mem 0xff700000-0xff7fffff]
[    0.281160] pci 0000:00:1c.1:   bridge window [mem 0xb0200000-0xb03fffff 64bit pref]
[    0.281165] pci 0000:00:1e.0: PCI bridge to [bus 03]
[    0.281180] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.281182] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.281184] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.281186] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.281188] pci_bus 0000:00: resource 8 [mem 0xaff00000-0xffffffff window]
[    0.281190] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
[    0.281192] pci_bus 0000:01: resource 1 [mem 0xff600000-0xff6fffff]
[    0.281194] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xb01fffff 64bit pref]
[    0.281196] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
[    0.281198] pci_bus 0000:02: resource 1 [mem 0xff700000-0xff7fffff]
[    0.281200] pci_bus 0000:02: resource 2 [mem 0xb0200000-0xb03fffff 64bit pref]
[    0.281203] pci_bus 0000:03: resource 4 [io  0x0000-0x0cf7 window]
[    0.281205] pci_bus 0000:03: resource 5 [io  0x0d00-0xffff window]
[    0.281207] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.281209] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x000dffff window]
[    0.281211] pci_bus 0000:03: resource 8 [mem 0xaff00000-0xffffffff window]
[    0.281245] NET: Registered protocol family 2
[    0.281384] TCP established hash table entries: 32768 (order: 6, 262144 bytes)
[    0.281481] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.281666] TCP: Hash tables configured (established 32768 bind 32768)
[    0.281717] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.281737] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.281792] NET: Registered protocol family 1
[    0.281872] RPC: Registered named UNIX socket transport module.
[    0.281874] RPC: Registered udp transport module.
[    0.281875] RPC: Registered tcp transport module.
[    0.281876] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.281888] pci 0000:00:02.0: Video device with shadowed ROM
[    0.459494] PCI: CLS 32 bytes, default 64
[    0.459542] Unpacking initramfs...
[    1.037253] Freeing initrd memory: 4484K
[    1.037267] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.037270] software IO TLB: mapped [mem 0xabeb0000-0xafeb0000] (64MB)
[    1.038971] audit: initializing netlink subsys (disabled)
[    1.038989] audit: type=2000 audit(1651152086.037:1): initialized
[    1.056017] VFS: Disk quotas dquot_6.6.0
[    1.056093] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.072221] NFS: Registering the id_resolver key type
[    1.072230] Key type id_resolver registered
[    1.072231] Key type id_legacy registered
[    1.072235] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    1.073184] Key type cifs.spnego registered
[    1.073193] Key type cifs.idmap registered
[    1.073253] fuse init (API version 7.23)
[    1.078256] NET: Registered protocol family 38
[    1.078265] async_tx: api initialized (async)
[    1.078334] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.078972] io scheduler noop registered
[    1.078975] io scheduler deadline registered
[    1.079047] io scheduler cfq registered (default)
[    1.079119] io scheduler bfq registered
[    1.079120] BFQ I/O-scheduler: v7r11
[    1.079177] gpio_it87: no device
[    1.082770] intel_idle: does not run on family 6 model 23
[    1.082854] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    1.082859] ACPI: Power Button [PWRB]
[    1.082908] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    1.082911] ACPI: Power Button [PWRF]
[    1.083154] ioatdma: Intel(R) QuickData Technology Driver 4.00
[    1.083245] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.103780] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    1.124305] 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    1.124619] Linux agpgart interface v0.103
[    1.124656] agpgart-intel 0000:00:00.0: Intel 965Q Chipset
[    1.124675] agpgart-intel 0000:00:00.0: detected gtt size: 524288K total, 262144K mappable
[    1.125317] agpgart-intel 0000:00:00.0: detected 1024K stolen memory
[    1.125420] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[    1.125476] [drm] Initialized drm 1.1.0 20060810
[    1.125938] [drm] Memory usable by graphics device = 512M
[    1.125941] [drm] Replacing VGA console driver
[    1.126626] Console: switching to colour dummy device 80x25
[    1.126643] pmd_set_huge: Cannot satisfy [mem 0xd0000000-0xd0200000] with a huge-page mapping due to MTRR override.
[    1.132208] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.132210] [drm] Driver supports precise vblank timestamp query.
[    1.142555] [drm] initialized overlay support
[    1.142615] [drm] Initialized i915 1.6.0 20151010 for 0000:00:02.0 on minor 0
[    1.148164] loop: module loaded
[    1.148460] gpio_ich: GPIO from 462 to 511 on gpio_ich
[    1.148598] mpt3sas version 12.100.00.00 loaded
[    1.151337] ahci 0000:00:1f.2: version 3.0
[    1.151499] ahci 0000:00:1f.2: SSS flag set, parallel bus scan disabled
[    1.151529] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
[    1.151532] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pio slum part ccc ems sxs 
[    1.151575] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.151612] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.153051] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.155050] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.157050] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.159100] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.166108] scsi host0: ahci
[    1.167394] scsi host1: ahci
[    1.168117] scsi host2: ahci
[    1.168819] scsi host3: ahci
[    1.169585] scsi host4: ahci
[    1.170308] scsi host5: ahci
[    1.170400] ata1: SATA max UDMA/133 abar m2048@0xff9fb800 port 0xff9fb900 irq 25
[    1.170403] ata2: SATA max UDMA/133 abar m2048@0xff9fb800 port 0xff9fb980 irq 25
[    1.170405] ata3: SATA max UDMA/133 abar m2048@0xff9fb800 port 0xff9fba00 irq 25
[    1.170407] ata4: SATA max UDMA/133 abar m2048@0xff9fb800 port 0xff9fba80 irq 25
[    1.170409] ata5: SATA max UDMA/133 abar m2048@0xff9fb800 port 0xff9fbb00 irq 25
[    1.170411] ata6: SATA max UDMA/133 abar m2048@0xff9fb800 port 0xff9fbb80 irq 25
[    1.170676] Rounding down aligned max_sectors from 4294967295 to 4294967288
[    1.170803] Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[    1.170824] tun: Universal TUN/TAP device driver, 1.6
[    1.170825] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.170886] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    1.170887] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    1.170915] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.170916] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.170942] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    1.170943] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.170968] Intel(R) 10GbE PCI Express Linux Network Driver - version 5.3.8
[    1.170969] Copyright(c) 1999 - 2018 Intel Corporation.
[    1.171573] i40e: Intel(R) 40-10 Gigabit Ethernet Connection Network Driver - version 2.4.10
[    1.171575] i40e: Copyright(c) 2013 - 2018 Intel Corporation.
[    1.173276] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
[    1.174315] sk98lin: Network Device Driver v10.93.3.3
(C)Copyright 1999-2012 Marvell(R).
[    1.229114] eth0: Marvell Yukon 88E8053 Gigabit Ethernet Controller
[    1.283946] eth1: Marvell Yukon 88E8053 Gigabit Ethernet Controller
[    1.283973] Fusion MPT base driver 3.04.20
[    1.283975] Copyright (c) 1999-2008 LSI Corporation
[    1.283986] Fusion MPT SAS Host driver 3.04.20
[    1.284031] Fusion MPT misc device (ioctl) driver 3.04.20
[    1.284688] mptctl: Registered with Fusion MPT base driver
[    1.284690] mptctl: /dev/mptctl @ (major,minor=10,220)
[    1.284695] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.284700] ehci-pci: EHCI PCI platform driver
[    1.284808] ehci-pci 0000:00:1a.7: EHCI Host Controller
[    1.284816] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    1.284828] ehci-pci 0000:00:1a.7: debug port 1
[    1.288736] ehci-pci 0000:00:1a.7: cache line size of 32 is not supported
[    1.288752] ehci-pci 0000:00:1a.7: irq 18, io mem 0xff9fb400
[    1.294016] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    1.294293] hub 1-0:1.0: USB hub found
[    1.294302] hub 1-0:1.0: 4 ports detected
[    1.294484] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.294490] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    1.294499] ehci-pci 0000:00:1d.7: debug port 1
[    1.298410] ehci-pci 0000:00:1d.7: cache line size of 32 is not supported
[    1.298419] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff9fb000
[    1.304026] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.304287] hub 2-0:1.0: USB hub found
[    1.304294] hub 2-0:1.0: 6 ports detected
[    1.304505] uhci_hcd: USB Universal Host Controller Interface driver
[    1.304580] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    1.304586] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    1.304593] uhci_hcd 0000:00:1a.0: detected 2 ports
[    1.304620] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e000
[    1.304798] hub 3-0:1.0: USB hub found
[    1.304805] hub 3-0:1.0: 2 ports detected
[    1.304975] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    1.304982] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    1.304987] uhci_hcd 0000:00:1a.1: detected 2 ports
[    1.305025] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000dc00
[    1.305204] hub 4-0:1.0: USB hub found
[    1.305210] hub 4-0:1.0: 2 ports detected
[    1.305374] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.305380] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 5
[    1.305386] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.305402] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d880
[    1.305580] hub 5-0:1.0: USB hub found
[    1.305587] hub 5-0:1.0: 2 ports detected
[    1.305750] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.305756] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 6
[    1.305761] uhci_hcd 0000:00:1d.1: detected 2 ports
[    1.305788] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d800
[    1.305967] hub 6-0:1.0: USB hub found
[    1.305974] hub 6-0:1.0: 2 ports detected
[    1.306149] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.306155] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 7
[    1.306161] uhci_hcd 0000:00:1d.2: detected 2 ports
[    1.306178] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d480
[    1.306359] hub 7-0:1.0: USB hub found
[    1.306365] hub 7-0:1.0: 2 ports detected
[    1.306586] usbcore: registered new interface driver cdc_acm
[    1.306587] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    1.306614] usbcore: registered new interface driver usblp
[    1.306654] usbcore: registered new interface driver usb-storage
[    1.306711] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.306713] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.307455] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.307682] rtc_cmos 00:01: RTC can wake from S4
[    1.307852] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[    1.307873] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram
[    1.307887] i2c /dev entries driver
[    1.310141] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.314774] w83627ehf: Found W83627DHG chip at 0xa10
[    1.315240] md: raid0 personality registered for level 0
[    1.315243] md: raid1 personality registered for level 1
[    1.315246] md: raid10 personality registered for level 10
[    1.322086] md: raid6 personality registered for level 6
[    1.322088] md: raid5 personality registered for level 5
[    1.322089] md: raid4 personality registered for level 4
[    1.322235] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
[    1.322486] usbcore: registered new interface driver btusb
[    1.322562] usbcore: registered new interface driver usbhid
[    1.322563] usbhid: USB HID core driver
[    1.322799] ip_tables: (C) 2000-2006 Netfilter Core Team
[    1.323145] NET: Registered protocol family 10
[    1.324605] NET: Registered protocol family 17
[    1.324631] 8021q: 802.1Q VLAN Support v1.8
[    1.324644] Key type dns_resolver registered
[    1.324810] readynas_io_init: initializing ReadyNAS I/O.
[    1.324812] procfs_init: initializing ReadyNAS procfs.
[    1.324822] ReadyNAS model: To Be Filled By O.E.M.
[    1.324847] pwr_button_state_init: initializing ReadyNAS PWR button state handler .
[    1.324853] button_init: initializing ReadyNAS button set.
[    1.324855] __button_init: button 'backup' gpio_ich:15 (POLL)
[    1.324866] __button_init: button 'reset' gpio_ich:8 (POLL)
[    1.327417] input: rn_button as /devices/virtual/input/input3
[    1.327467] readynas_io_init: initialization successfully completed.
[    1.327556] readynas_lcd_init: installing ReadyNAS LCD driver.
[    1.327640] readynas_led_init: installing ReadyNAS LED driver.
[    1.329253] register_led: registering LED "readynas:green:backup"
[    1.329484] microcode: CPU0 sig=0x1067a, pf=0x1, revision=0xa07
[    1.329493] microcode: CPU1 sig=0x1067a, pf=0x1, revision=0xa07
[    1.329534] snd_hda_intel 0000:00:1b.0: no codecs found!
[    1.334240] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.334430] registered taskstats version 1
[    1.337264] Btrfs loaded, crc32c=crc32c-generic
[    1.339084] rtc_cmos 00:01: setting system clock to 2022-04-28 13:21:26 UTC (1651152086)
[    1.339154] ALSA device list:
[    1.339155]   No soundcards found.
[    1.475018] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.475029] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.475753] ata1.00: supports DRM functions and may not be fully accessible
[    1.475782] ata1.00: ATA-10: CT500MX500SSD1, M3CR023, max UDMA/133
[    1.475786] ata1.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    1.476032] ata1.00: supports DRM functions and may not be fully accessible
[    1.476197] ata1.00: configured for UDMA/133
[    1.476411] scsi 0:0:0:0: Direct-Access     ATA      CT500MX500SSD1   023  PQ: 0 ANSI: 5
[    1.476672] sd 0:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    1.476674] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    1.476696] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.476758] sd 0:0:0:0: [sda] Write Protect is off
[    1.476760] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.476782] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.477857]  sda: sda1 sda2 sda3
[    1.478136] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.606019] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.722126] usb-storage 2-1:1.0: USB Mass Storage device detected
[    1.722620] usb-storage 2-1:1.0: Quirks match for vid 090c pid 1000: 400
[    1.722643] scsi host6: usb-storage 2-1:1.0
[    1.781019] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    1.781030] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.781759] ata2.00: ATA-9: ST2000DM006-2DM164, CC26, max UDMA/133
[    1.781763] ata2.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    1.782460] ata2.00: configured for UDMA/133
[    1.782628] scsi 1:0:0:0: Direct-Access     ATA      ST2000DM006-2DM1 CC26 PQ: 0 ANSI: 5
[    1.782876] sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    1.782878] sd 1:0:0:0: [sdb] 4096-byte physical blocks
[    1.782924] sd 1:0:0:0: [sdb] Write Protect is off
[    1.782927] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.782947] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.783149] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    1.819669]  sdb: sdb1 sdb2 sdb3
[    1.820091] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.040021] tsc: Refined TSC clocksource calibration: 3058.999 MHz
[    2.040027] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2c17fc00cd7, max_idle_ns: 440795338802 ns
[    2.088018] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    2.088028] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.088752] ata3.00: ATA-9: ST2000DM006-2DM164, CC26, max UDMA/133
[    2.088755] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.089451] ata3.00: configured for UDMA/133
[    2.089624] scsi 2:0:0:0: Direct-Access     ATA      ST2000DM006-2DM1 CC26 PQ: 0 ANSI: 5
[    2.089868] sd 2:0:0:0: [sdc] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    2.089870] sd 2:0:0:0: [sdc] 4096-byte physical blocks
[    2.089914] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    2.089932] sd 2:0:0:0: [sdc] Write Protect is off
[    2.089935] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    2.089961] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.118962]  sdc: sdc1 sdc2 sdc3
[    2.119381] sd 2:0:0:0: [sdc] Attached SCSI disk
[    2.395019] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    2.395030] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.395754] ata4.00: supports DRM functions and may not be fully accessible
[    2.395784] ata4.00: ATA-10: CT500MX500SSD1, M3CR023, max UDMA/133
[    2.395788] ata4.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 31/32), AA
[    2.396038] ata4.00: supports DRM functions and may not be fully accessible
[    2.396205] ata4.00: configured for UDMA/133
[    2.396422] scsi 3:0:0:0: Direct-Access     ATA      CT500MX500SSD1   023  PQ: 0 ANSI: 5
[    2.396622] sd 3:0:0:0: Attached scsi generic sg3 type 0
[    2.396685] sd 3:0:0:0: [sdd] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    2.396688] sd 3:0:0:0: [sdd] 4096-byte physical blocks
[    2.396752] sd 3:0:0:0: [sdd] Write Protect is off
[    2.396754] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    2.396775] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.397989]  sdd: sdd1 sdd2 sdd3
[    2.398357] sd 3:0:0:0: [sdd] Attached SCSI disk
[    2.701019] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    2.701030] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.701745] ata5.00: ATA-9: ST2000DM006-2DM164, CC26, max UDMA/133
[    2.701749] ata5.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    2.702434] ata5.00: configured for UDMA/133
[    2.702608] scsi 4:0:0:0: Direct-Access     ATA      ST2000DM006-2DM1 CC26 PQ: 0 ANSI: 5
[    2.702856] sd 4:0:0:0: [sde] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    2.702859] sd 4:0:0:0: [sde] 4096-byte physical blocks
[    2.702906] sd 4:0:0:0: Attached scsi generic sg4 type 0
[    2.702917] sd 4:0:0:0: [sde] Write Protect is off
[    2.702920] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
[    2.702946] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.734871]  sde: sde1 sde2 sde3
[    2.735287] sd 4:0:0:0: [sde] Attached SCSI disk
[    3.008019] do_marvell_9170_recover: ignoring PCI device (8086:2821) at PCI#0
[    3.008030] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.008751] ata6.00: ATA-9: ST2000DM006-2DM164, CC26, max UDMA/133
[    3.008755] ata6.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
[    3.009440] ata6.00: configured for UDMA/133
[    3.009616] scsi 5:0:0:0: Direct-Access     ATA      ST2000DM006-2DM1 CC26 PQ: 0 ANSI: 5
[    3.009815] sd 5:0:0:0: [sdf] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    3.009818] sd 5:0:0:0: [sdf] 4096-byte physical blocks
[    3.009834] sd 5:0:0:0: Attached scsi generic sg5 type 0
[    3.009865] sd 5:0:0:0: [sdf] Write Protect is off
[    3.009867] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[    3.009889] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.040086] clocksource: Switched to clocksource tsc
[    3.047451]  sdf: sdf1 sdf2 sdf3
[    3.047829] sd 5:0:0:0: [sdf] Attached SCSI disk
[    3.048368] Freeing unused kernel memory: 872K
[    3.050795] vpd: loading out-of-tree module taints kernel.
[    3.050799] vpd: module license 'Proprietary' taints kernel.
[    3.050800] Disabling lock debugging due to kernel taint
[    3.050928] ReadyNAS VPD init
[    6.618013] nv6lcd v3.1 loaded.
[    6.736863] scsi 6:0:0:0: Direct-Access     SMI      USB DISK         1100 PQ: 0 ANSI: 0 CCS
[    6.737137] sd 6:0:0:0: Attached scsi generic sg6 type 0
[    6.737140] sd 6:0:0:0: Embedded Enclosure Device
[    6.738217] sd 6:0:0:0: Wrong diagnostic page; asked for 1 got 0
[    6.744228] sd 6:0:0:0: Failed to get diagnostic page 0xffffffea
[    6.750245] sd 6:0:0:0: Failed to bind enclosure -19
[    6.755464] sd 6:0:0:0: [sdg] 250880 512-byte logical blocks: (128 MB/123 MiB)
[    6.756346] sd 6:0:0:0: [sdg] Write Protect is off
[    6.756352] sd 6:0:0:0: [sdg] Mode Sense: 43 00 00 00
[    6.757219] sd 6:0:0:0: [sdg] No Caching mode page found
[    6.762541] sd 6:0:0:0: [sdg] Assuming drive cache: write through
[    6.772640]  sdg: sdg1
[    6.774839] sd 6:0:0:0: [sdg] Attached SCSI removable disk
[   19.303981] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   19.307219] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
[   20.339714] random: nonblocking pool is initialized
[   22.249861] eth0: network connection up using port A
[   22.249861]     interrupt src:   MSI
[   22.249861]     speed:           1000
[   22.249861]     autonegotiation: yes
[   22.249861]     duplex mode:     full
[   22.249861]     flowctrl:        symmetric
[   22.249861]     role:            slave
[   22.249861]     tcp offload:     enabled
[   22.249861]     scatter-gather:  enabled
[   22.249861]     tx-checksum:     enabled
[   22.249861]     rx-checksum:     enabled
[   22.249861]     rx-polling:      enabled
[   22.249861] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   22.270001] eth1: network connection up using port A
[   22.270001]     interrupt src:   MSI
[   22.270001]     speed:           1000
[   22.270001]     autonegotiation: yes
[   22.270001]     duplex mode:     full
[   22.270001]     flowctrl:        symmetric
[   22.270001]     role:            slave
[   22.270001]     tcp offload:     enabled
[   22.270001]     scatter-gather:  enabled
[   22.270001]     tx-checksum:     enabled
[   22.270001]     rx-checksum:     enabled
[   22.270001]     rx-polling:      enabled
[   22.270134] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   22.909584] md: md0 stopped.
[   22.911585] md: bind<sdc1>
[   22.911751] md: bind<sde1>
[   22.911964] md: bind<sdf1>
[   22.912159] md: bind<sdd1>
[   22.912368] md: bind<sda1>
[   22.912583] md: bind<sdb1>
[   22.914832] md/raid1:md0: active with 6 out of 6 mirrors
[   22.914974] created bitmap (1 pages) for device md0
[   22.915163] md0: bitmap initialized from disk: read 1 pages, set 1 of 64 bits
[   22.925506] md0: detected capacity change from 0 to 4290772992
[   22.939664] md: md1 stopped.
[   22.940940] md: bind<sdb2>
[   22.941126] md: bind<sdc2>
[   22.941330] md: bind<sdd2>
[   22.941509] md: bind<sde2>
[   22.941721] md: bind<sdf2>
[   22.941895] md: bind<sda2>
[   22.942442] md/raid10:md1: active with 6 out of 6 devices
[   22.942486] md1: detected capacity change from 0 to 1604321280
[   23.296969] BTRFS: device label 33eaff11:root devid 1 transid 2341967 /dev/md0
[   23.297437] BTRFS info (device md0): has skinny extents
[   23.801432] systemd[1]: Failed to insert module 'kdbus': Function not implemented
[   23.804156] systemd[1]: systemd 230 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   23.804298] systemd[1]: Detected architecture x86-64.
[   23.809079] systemd[1]: Set hostname to <fatterboy>.
[   23.853264] systemd[1]: [/lib/systemd/system/fvapp-plexmediaserver.service:10] Invalid escape sequences in line, correcting: "/bin/sh -c ' PLEX_MEDIA_SERVER_INFO_VENDOR=Netgear  PLEX_MEDIA_SERVER_INFO_DEVICE="$(rn_nml -g systeminfo | grep "<Model>" | awk -F "[<>]" "{print \$3}")"  PLEX_MEDIA_SERVER_INFO_MODEL="$(uname -m)"  PLEX_MEDIA_SERVER_INFO_PLATFORM_VERSION="ReadyNAS OS $(rn_nml -g systeminfo | grep "<Firmware_Version>" | awk -F "[<>]" "{print \$3}")"  /apps/plexmediaserver/Binaries/Plex\ Media\ Server'"
[   23.860395] systemd[1]: systemd-journald-audit.socket: Cannot add dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
[   23.860435] systemd[1]: systemd-journald-audit.socket: Cannot add dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
[   23.860456] systemd[1]: rsyslog.service: Cannot add dependency job, ignoring: Unit rsyslog.service is masked.
[   23.861481] systemd[1]: Created slice System Slice.
[   23.867153] systemd[1]: Listening on Journal Socket.
[   23.873070] systemd[1]: Reached target Encrypted Volumes.
[   23.886168] systemd[1]: Starting Load Kernel Modules...
[   23.892153] systemd[1]: Mounting Debug File System...
[   23.897085] systemd[1]: Reached target Remote File Systems (Pre).
[   23.903163] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
[   23.910663] systemd[1]: Created slice system-getty.slice.
[   23.916600] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   23.924165] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   23.937165] systemd[1]: Started ReadyNAS LCD splasher.
[   23.950197] systemd[1]: Starting ReadyNASOS system prep...
[   23.955137] systemd[1]: Listening on udev Control Socket.
[   23.961158] systemd[1]: Listening on Journal Socket (/dev/log).
[   23.967281] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   23.982155] systemd[1]: Starting Remount Root and Kernel File Systems...
[   23.988625] systemd[1]: Created slice User and Session Slice.
[   23.994071] systemd[1]: Reached target Slices.
[   24.004202] systemd[1]: Starting Journal Service...
[   24.010236] systemd[1]: Starting Create Static Device Nodes in /dev...
[   24.016157] systemd[1]: Listening on udev Kernel Socket.
[   24.022094] systemd[1]: Reached target Remote File Systems.
[   24.028204] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   24.037111] systemd[1]: Reached target Paths.
[   24.047096] systemd[1]: Mounting POSIX Message Queue File System...
[   24.055058] systemd[1]: Mounted Debug File System.
[   24.061197] systemd[1]: Mounted POSIX Message Queue File System.
[   24.067799] systemd[1]: Started Load Kernel Modules.
[   24.073849] systemd[1]: Started ReadyNASOS system prep.
[   24.080755] systemd[1]: Started Remount Root and Kernel File Systems.
[   24.088817] systemd[1]: Started Create Static Device Nodes in /dev.
[   24.102249] systemd[1]: Starting udev Kernel Device Manager...
[   24.109261] systemd[1]: Starting Load/Save Random Seed...
[   24.115309] systemd[1]: Starting Rebuild Hardware Database...
[   24.125218] systemd[1]: Starting Apply Kernel Variables...
[   24.131296] systemd[1]: Mounting FUSE Control File System...
[   24.141129] systemd[1]: Mounting Configuration File System...
[   24.148633] systemd[1]: Mounted FUSE Control File System.
[   24.154154] systemd[1]: Mounted Configuration File System.
[   24.160264] systemd[1]: Started udev Kernel Device Manager.
[   24.166883] systemd[1]: Started Load/Save Random Seed.
[   24.173844] systemd[1]: Started Apply Kernel Variables.
[   24.186222] systemd[1]: Starting MD arrays...
[   24.192386] systemd[1]: Started Journal Service.
[   24.217042] systemd-journald[1466]: Received request to flush runtime journal from PID 1
[   24.470231] md: md127 stopped.
[   24.470744] md: bind<sdd3>
[   24.470867] md: bind<sda3>
[   24.480440] md/raid:md127: device sda3 operational as raid disk 0
[   24.480444] md/raid:md127: device sdd3 operational as raid disk 1
[   24.480700] md/raid:md127: allocated 2250kB
[   24.480765] md/raid:md127: raid level 5 active with 2 out of 2 devices, algorithm 2
[   24.480766] RAID conf printout:
[   24.480767]  --- level:5 rd:2 wd:2
[   24.480769]  disk 0, o:1, dev:sda3
[   24.480770]  disk 1, o:1, dev:sdd3
[   24.480825] md127: detected capacity change from 0 to 495140667392
[   24.505292] BTRFS: device label 33eaff11:HDD1 devid 2 transid 1424350 /dev/md127
[   24.530984] md: md126 stopped.
[   24.537545] md: bind<sdc3>
[   24.537722] md: bind<sde3>
[   24.538396] md: bind<sdf3>
[   24.538588] md: bind<sdb3>
[   24.539746] md/raid:md126: device sdb3 operational as raid disk 0
[   24.539748] md/raid:md126: device sdf3 operational as raid disk 3
[   24.539750] md/raid:md126: device sde3 operational as raid disk 2
[   24.539751] md/raid:md126: device sdc3 operational as raid disk 1
[   24.540129] md/raid:md126: allocated 4362kB
[   24.540307] md/raid:md126: raid level 5 active with 4 out of 4 devices, algorithm 2
[   24.540309] RAID conf printout:
[   24.540310]  --- level:5 rd:4 wd:4
[   24.540312]  disk 0, o:1, dev:sdb3
[   24.540313]  disk 1, o:1, dev:sdc3
[   24.540315]  disk 2, o:1, dev:sde3
[   24.540316]  disk 3, o:1, dev:sdf3
[   24.540376] md126: detected capacity change from 0 to 5986295218176
[   24.557189] Adding 1566716k swap on /dev/md1.  Priority:-1 extents:1 across:1566716k 
[   24.643613] BTRFS: device label 33eaff11:HDD1 devid 1 transid 1424350 /dev/md126
[   24.800256] BTRFS info (device md126): has skinny extents
[   24.894582] BTRFS critical (device md126): corrupt leaf, bad key order: block=10872141938688, root=1, slot=119
[   24.894596] BTRFS error (device md126): failed to read block groups: -5
[   24.894811] BTRFS error (device md126): failed to read block groups: -17
[   24.898074] BTRFS error (device md126): failed to read block groups: -17
[   24.912298] BTRFS error (device md126): failed to read block groups: -17
[   24.912851] BTRFS error (device md126): parent transid verify failed on 10872188272640 wanted 1424347 found 1424349
[   24.912857] BTRFS warning (device md126): failed to read tree root
[   24.933058] BTRFS error (device md126): open_ctree failed
[   25.767588] bonding: bond0 is being created...
[   25.796633] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[   25.796637] 8021q: adding VLAN 0 to HW filter on device bond0
[   25.797051] bond0: Setting MII monitoring interval to 100
[   25.802528] eth0: network connection down
[   25.807000] bond0: Adding slave eth0
[   25.817645] bond0: Enslaving eth0 as an active interface with a down link
[   25.828233] eth1: network connection down
[   25.837033] bond0: Adding slave eth1
[   25.840009] bond0: Enslaving eth1 as an active interface with a down link
[   25.840082] bond0: Setting eth0 as primary slave
[   25.840218] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[   25.840220] 8021q: adding VLAN 0 to HW filter on device bond0
[   25.849912] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
[   25.849915] 8021q: adding VLAN 0 to HW filter on device bond0
[   29.363225] eth1: network connection up using port A
[   29.363225]     interrupt src:   MSI
[   29.363225]     speed:           1000
[   29.363225]     autonegotiation: yes
[   29.363225]     duplex mode:     full
[   29.363225]     flowctrl:        symmetric
[   29.363225]     role:            slave
[   29.363225]     tcp offload:     enabled
[   29.363225]     scatter-gather:  enabled
[   29.363225]     tx-checksum:     enabled
[   29.363225]     rx-checksum:     enabled
[   29.363225]     rx-polling:      enabled
[   29.363225] eth0: network connection up using port A
[   29.363225]     interrupt src:   MSI
[   29.363225]     speed:           1000
[   29.363225]     autonegotiation: yes
[   29.363225]     duplex mode:     full
[   29.363225]     flowctrl:        symmetric
[   29.363225]     role:            slave
[   29.363225]     tcp offload:     enabled
[   29.363225]     scatter-gather:  enabled
[   29.363225]     tx-checksum:     enabled
[   29.363225]     rx-checksum:     enabled
[   29.363225]     rx-polling:      enabled
[   29.450019] bond0: link status definitely up for interface eth0, 1000 Mbps full duplex
[   29.450023] bond0: making interface eth0 the new active one
[   29.450299] bond0: first active interface up!
[   29.450301] bond0: link status definitely up for interface eth1, 1000 Mbps full duplex
[   29.450311] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes ready

------=_Part_167607_2019865139.1651154049166--
