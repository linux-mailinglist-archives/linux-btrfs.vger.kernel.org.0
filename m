Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514A73DB93A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jul 2021 15:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbhG3NTb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jul 2021 09:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbhG3NTX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jul 2021 09:19:23 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173DC06179A
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 06:19:15 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id f12so12353852ljn.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jul 2021 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=8+F537mS+3/rdb5FHWqm1Gxhz51e7h4c+7hNhjo/N+4=;
        b=idKYe/sZIpwGt3l/HtpCinFx1KqEpqb9J0Xhp9ddsYR0En3+LrGaTTePAV6FB1OdN2
         AYaIb7vNSsrzEoTgz69/7naygznCUUAYhQutWAgl2DwpT33e82HReOxAqV4HTpeHkktn
         W/4qzylhL4h5peE11Ant3IO3sX6rGYLUZIVa/JrL0i87GoPV1lcJ1D5z7gNCAl0tuSaJ
         lXoqTy3JrzATKUR8DXvl/V+Dl6JJZbW6K8eeKZUUFZR36FFPjgh8W6x+qJUb3CWcGyad
         olJMcIjMswCnroTlKQx+CLmoHPd+CUkmXSCxS+K4DEJPUEA98ssUFPgR/n0lNegwvWgd
         J+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=8+F537mS+3/rdb5FHWqm1Gxhz51e7h4c+7hNhjo/N+4=;
        b=Gfg6hI/vp6xd4Jpm2PRa7k0BE03qwanEmid7W0IrzxMOODOIxVyi6KNikEn/HjGXE5
         /jEuX2gRBsBBgdHHOzTWZv9kha1jcI2ZeStbRYNhseyoxePBf+Ib2qJ5oUQa7Scz3f8U
         /vlAf4uZP6+IPEnQtD7aXnXluUjTLg0zNP235qfNJ0+/FlAlnOb2koesbsNFOhKdsDXL
         JxWcyrht5UcPIPN0ZGsBnDF76MFXMym0F4GAIZ2wPr5VeamawHD4IUn4bn8qs9V1F7Z4
         rXOAL/tBPlqrEiEmVBVKwy9f+7Xzzw1fjQDrXId8rjMt8kgBRw2PRGfHAFxbyHAJoh0U
         wdaQ==
X-Gm-Message-State: AOAM533JzBuDVbJS3Xk5ZK1Ig7zSLPcCoNB9Jqn0VcEiUMZ7y76K5mPk
        OUWHkVm7x3C27DLBiM6p/elefTorqmc=
X-Google-Smtp-Source: ABdhPJy4X2k61jz2uEX+Zy1lK81cau+X/KjnmYN5ixYRgcDyxVK3MZHTrZTSfc347bVSfeyQwu6uqA==
X-Received: by 2002:a05:651c:4d4:: with SMTP id e20mr1666443lji.130.1627651153104;
        Fri, 30 Jul 2021 06:19:13 -0700 (PDT)
Received: from [192.168.1.22] ([128.0.141.47])
        by smtp.gmail.com with ESMTPSA id z19sm150010lfq.241.2021.07.30.06.19.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:19:12 -0700 (PDT)
From:   Aleksey Utkin <aleksey.utkin@gmail.com>
To:     linux-btrfs@vger.kernel.org
Subject: Cannot mount hm-smr drive with btrfs
Message-ID: <176713ca-c91e-6184-066d-5f78a39fc73f@gmail.com>
Date:   Fri, 30 Jul 2021 16:19:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4FC6B39DA92F1E4446845F3C"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------4FC6B39DA92F1E4446845F3C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello.


I had a problem with the mounting of the BTRFS file system.

Test case description:

1. Operation: Creating btrfs: sudo mkfs.btrfs -O zoned -d single -m 
single -f /dev/sdb
Result: The file system was created successfully

2. Operation: Mount new btrfs: sudo mount /dev/sdb /mnt/sdb
Result: Mounted successfully

3. Operation: Filling a file system data system (copy using MC)
Result: Filling a file system data has passed successfully, the data has 
passed integrity control

4. Operation: Umount file system: sudo umount /mnt/sdb/
Result: Umounted successfully

5. Operation: Mount btrfs: sudo mount /dev/sdb /mnt/sdb
Result: Mounted successfully

6. Operation: rebooted the host with mounted file system BTRFS
Result: Reboot successfully

7. Operation: Checking the btrfs file system: sudo btrfs check /dev/sdb
Result: successfully, console output:
Opening filesystem to check...
Checking filesystem on /dev/sdb
UUID: 4312bf2a-376d-4a44-a69a-6bb112b124f6
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 17978056441856 bytes used, no error found
total csum bytes: 17534343280
total tree bytes: 22888923136
total fs tree bytes: 2191491072
total extent tree bytes: 2166554624
btree space waste bytes: 990047274
file data blocks allocated: 17955167518720
  referenced 17955167518720

8. Operation: Attempt to mount 1: sudo mount /dev/sdb /mnt/sdb
Result: Mounted unsuccessful,
Console output: mount: /mnt/sdb: wrong fs type, bad option, bad 
superblock on /dev/sdb, missing codepage or helper program, or other error.

9. Operation: Attempt to mount 2: sudo mount -t btrfs /dev/sdb /mnt/sdb
Result: unsuccessful, no messages, the HDD activity LED is glow, the 
console frozen, ^C does not interrupt the mount operation, the sudo 
reboot is not performed, the restart of Alt+PRTSCR+B is performed.

Version of the kernel:
$ uname -a
Linux x79zd3 5.14.0-051400rc2-generic #202107182230 SMP Sun Jul 18 
22:34:12 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

$ btrfs --version
btrfs-progs v5.13
from https://github.com/kdave/btrfs-progs

$ btrfs fi show
nothing output

$ btrfs fi df /mnt/sdb
ERROR: not a btrfs filesystem: /mnt/sdb

Device:
$ sudo smartctl -i /dev/sdb
smartctl 7.2 2020-12-30 r5155 [x86_64-linux-5.14.0-051400rc2-generic] 
(local build)
Copyright (C) 2002-20, Bruce Allen, Christian Franke, www.smartmontools.org

=== START OF INFORMATION SECTION ===
Device Model:     ST18000NM009J-2UW101
Serial Number:    ZL2BH53L
LU WWN Device Id: 5 000c50 0c812bf64
Firmware Version: SE01
User Capacity:    18 000 207 937 536 bytes [18,0 TB]
Sector Sizes:     512 bytes logical, 4096 bytes physical
Rotation Rate:    7200 rpm
Form Factor:      3.5 inches
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-4 (minor revision not indicated)
SATA Version is:  SATA 3.3, 6.0 Gb/s (current: 3.0 Gb/s)
Local Time is:    Fri Jul 30 14:47:33 2021 MSK
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

# nc cwillu.com 10101 < /dev/kmsg
after operations 6,7,8,9 - http://cwillu.com:8080/128.0.141.47/2

$ sudo dmesg | nc termbin.com 9999
https://termbin.com/6g54


Best regards,
Aleksey Utkin


--------------4FC6B39DA92F1E4446845F3C
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] microcode: microcode updated early to revision 0x42e, date = 2019-03-14
[    0.000000] Linux version 5.14.0-051400rc2-generic (kernel@kathleen) (gcc (Ubuntu 10.3.0-6ubuntu1) 10.3.0, GNU ld (GNU Binutils for Ubuntu) 2.36.90.20210712) #202107182230 SMP Sun Jul 18 22:34:12 UTC 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-051400rc2-generic root=UUID=957581cc-6dd3-4cf5-8363-7c84a7a0aa4e ro quiet splash libata.force=3.0 vt.handoff=7
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai  
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x00000000000953ff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000095400-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ba49fff] usable
[    0.000000] BIOS-e820: [mem 0x000000007ba4a000-0x000000007bbf5fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007bbf6000-0x000000007bee5fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007bee6000-0x000000007c7d3fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000007c7d4000-0x000000007cc98fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000007cc99000-0x000000007cffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000107fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: To be filled by O.E.M. To be filled by O.E.M./X79-ZD3, BIOS 4.6.5 12/24/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2600.147 MHz processor
[    0.001398] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001402] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001408] last_pfn = 0x1080000 max_arch_pfn = 0x400000000
[    0.001564] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002520] total RAM covered: 65504M
[    0.002846] Found optimal setting for mtrr clean up
[    0.002847]  gran_size: 64K 	chunk_size: 64M 	num_reg: 7  	lose cover RAM: 0G
[    0.003330] e820: update [mem 0x7e000000-0xffffffff] usable ==> reserved
[    0.003334] last_pfn = 0x7ba4a max_arch_pfn = 0x400000000
[    0.014791] found SMP MP-table at [mem 0x000fd9b0-0x000fd9bf]
[    0.014810] Using GB pages for direct mapping
[    0.015086] RAMDISK: [mem 0x30653000-0x34320fff]
[    0.015093] ACPI: Early table checksum verification disabled
[    0.015097] ACPI: RSDP 0x00000000000F04A0 000024 (v02 ALASKA)
[    0.015102] ACPI: XSDT 0x000000007BE06080 00007C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.015109] ACPI: FACP 0x000000007BE0EC70 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.015116] ACPI: DSDT 0x000000007BE06190 008AD9 (v02 ALASKA A M I    00000017 INTL 20051117)
[    0.015120] ACPI: FACS 0x000000007BEDDF80 000040
[    0.015123] ACPI: APIC 0x000000007BE0ED80 000138 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.015127] ACPI: FPDT 0x000000007BE0EEB8 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.015131] ACPI: FIDT 0x000000007BE0EF00 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.015134] ACPI: MCFG 0x000000007BE0EFA0 00003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
[    0.015139] ACPI: HPET 0x000000007BE0EFE0 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
[    0.015142] ACPI: SSDT 0x000000007BE0F018 0CD380 (v02 INTEL  CpuPm    00004000 INTL 20051117)
[    0.015146] ACPI: EINJ 0x000000007BEDC398 000130 (v01 AMI    AMI EINJ 00000000      00000000)
[    0.015150] ACPI: ERST 0x000000007BEDC4C8 000230 (v01 AMIER  AMI ERST 00000000      00000000)
[    0.015154] ACPI: HEST 0x000000007BEDC6F8 0000A8 (v01 AMI    AMI HEST 00000000      00000000)
[    0.015158] ACPI: BERT 0x000000007BEDC7A0 000030 (v01 AMI    AMI BERT 00000000      00000000)
[    0.015160] ACPI: Reserving FACP table memory at [mem 0x7be0ec70-0x7be0ed7b]
[    0.015162] ACPI: Reserving DSDT table memory at [mem 0x7be06190-0x7be0ec68]
[    0.015163] ACPI: Reserving FACS table memory at [mem 0x7beddf80-0x7beddfbf]
[    0.015165] ACPI: Reserving APIC table memory at [mem 0x7be0ed80-0x7be0eeb7]
[    0.015166] ACPI: Reserving FPDT table memory at [mem 0x7be0eeb8-0x7be0eefb]
[    0.015167] ACPI: Reserving FIDT table memory at [mem 0x7be0ef00-0x7be0ef9b]
[    0.015168] ACPI: Reserving MCFG table memory at [mem 0x7be0efa0-0x7be0efdb]
[    0.015169] ACPI: Reserving HPET table memory at [mem 0x7be0efe0-0x7be0f017]
[    0.015170] ACPI: Reserving SSDT table memory at [mem 0x7be0f018-0x7bedc397]
[    0.015171] ACPI: Reserving EINJ table memory at [mem 0x7bedc398-0x7bedc4c7]
[    0.015172] ACPI: Reserving ERST table memory at [mem 0x7bedc4c8-0x7bedc6f7]
[    0.015173] ACPI: Reserving HEST table memory at [mem 0x7bedc6f8-0x7bedc79f]
[    0.015174] ACPI: Reserving BERT table memory at [mem 0x7bedc7a0-0x7bedc7cf]
[    0.015231] No NUMA configuration found
[    0.015232] Faking a node at [mem 0x0000000000000000-0x000000107fffffff]
[    0.015244] NODE_DATA(0) allocated [mem 0x107ffd6000-0x107fffffff]
[    0.015759] Zone ranges:
[    0.015761]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015763]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015765]   Normal   [mem 0x0000000100000000-0x000000107fffffff]
[    0.015767]   Device   empty
[    0.015768] Movable zone start for each node
[    0.015772] Early memory node ranges
[    0.015773]   node   0: [mem 0x0000000000001000-0x0000000000094fff]
[    0.015774]   node   0: [mem 0x0000000000100000-0x000000007ba49fff]
[    0.015776]   node   0: [mem 0x0000000100000000-0x000000107fffffff]
[    0.015784] Initmem setup node 0 [mem 0x0000000000001000-0x000000107fffffff]
[    0.015790] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.015832] On node 0, zone DMA: 107 pages in unavailable ranges
[    0.198311] On node 0, zone Normal: 17846 pages in unavailable ranges
[    0.198615] ACPI: PM-Timer IO Port: 0x408
[    0.198628] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.198630] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.198632] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.198633] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.198633] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.198634] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.198635] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.198636] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.198637] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.198638] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.198639] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.198640] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.198641] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.198642] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.198643] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.198644] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.198656] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.198662] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.198664] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.198667] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.198672] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.198674] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.198680] TSC deadline timer available
[    0.198681] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.198696] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.198698] PM: hibernation: Registered nosave memory: [mem 0x00095000-0x00095fff]
[    0.198699] PM: hibernation: Registered nosave memory: [mem 0x00096000-0x0009ffff]
[    0.198701] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.198701] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.198703] PM: hibernation: Registered nosave memory: [mem 0x7ba4a000-0x7bbf5fff]
[    0.198704] PM: hibernation: Registered nosave memory: [mem 0x7bbf6000-0x7bee5fff]
[    0.198705] PM: hibernation: Registered nosave memory: [mem 0x7bee6000-0x7c7d3fff]
[    0.198706] PM: hibernation: Registered nosave memory: [mem 0x7c7d4000-0x7cc98fff]
[    0.198707] PM: hibernation: Registered nosave memory: [mem 0x7cc99000-0x7cffffff]
[    0.198708] PM: hibernation: Registered nosave memory: [mem 0x7d000000-0x7fffffff]
[    0.198709] PM: hibernation: Registered nosave memory: [mem 0x80000000-0x8fffffff]
[    0.198710] PM: hibernation: Registered nosave memory: [mem 0x90000000-0xfed1bfff]
[    0.198711] PM: hibernation: Registered nosave memory: [mem 0xfed1c000-0xfed3ffff]
[    0.198712] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xfeffffff]
[    0.198713] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.198715] [mem 0x90000000-0xfed1bfff] available for PCI devices
[    0.198717] Booting paravirtualized kernel on bare hardware
[    0.198720] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.198728] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.199204] percpu: Embedded 57 pages/cpu s196608 r8192 d28672 u262144
[    0.199211] pcpu-alloc: s196608 r8192 d28672 u262144 alloc=1*2097152
[    0.199214] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.199252] Built 1 zonelists, mobility grouping on.  Total pages: 16497248
[    0.199254] Policy zone: Normal
[    0.199256] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-051400rc2-generic root=UUID=957581cc-6dd3-4cf5-8363-7c84a7a0aa4e ro quiet splash libata.force=3.0 vt.handoff=7
[    0.199341] Unknown command line parameters: splash BOOT_IMAGE=/boot/vmlinuz-5.14.0-051400rc2-generic
[    0.204504] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.207233] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.207422] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.382588] Memory: 65713764K/67037048K available (16393K kernel code, 3518K rwdata, 10596K rodata, 2900K init, 5716K bss, 1323024K reserved, 0K cma-reserved)
[    0.382597] random: get_random_u64 called from kmem_cache_open+0x23/0x230 with crng_init=0
[    0.382779] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.382795] Kernel/User page tables isolation: enabled
[    0.382822] ftrace: allocating 52116 entries in 204 pages
[    0.402267] ftrace: allocated 204 pages with 4 groups
[    0.402420] rcu: Hierarchical RCU implementation.
[    0.402422] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
[    0.402424] 	Rude variant of Tasks RCU enabled.
[    0.402424] 	Tracing variant of Tasks RCU enabled.
[    0.402425] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.402426] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.407348] NR_IRQS: 524544, nr_irqs: 960, preallocated irqs: 16
[    0.407588] random: crng done (trusting CPU's manufacturer)
[    0.407621] Console: colour dummy device 80x25
[    0.407635] printk: console [tty0] enabled
[    0.407662] ACPI: Core revision 20210604
[    0.408426] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.408453] APIC: Switch to symmetric I/O mode setup
[    0.408546] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.408592] Switched APIC routing to physical flat.
[    0.409076] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.428441] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x257ac6bd610, max_idle_ns: 440795231169 ns
[    0.428448] Calibrating delay loop (skipped), value calculated using timer frequency.. 5200.29 BogoMIPS (lpj=10400588)
[    0.428451] pid_max: default: 32768 minimum: 301
[    0.428481] LSM: Security Framework initializing
[    0.428492] Yama: becoming mindful.
[    0.428516] AppArmor: AppArmor initialized
[    0.428672] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.428809] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.429100] CPU0: Thermal monitoring enabled (TM1)
[    0.429173] process: using mwait in idle threads
[    0.429176] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.429177] Last level dTLB entries: 4KB 512, 2MB 0, 4MB 0, 1GB 4
[    0.429181] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.429183] Spectre V2 : Mitigation: Full generic retpoline
[    0.429184] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.429185] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.429187] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.429188] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.429189] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.429192] MDS: Mitigation: Clear CPU buffers
[    0.434300] Freeing SMP alternatives memory: 40K
[    0.435967] smpboot: Estimated ratio of average max frequency by base frequency (times 1024): 1220
[    0.435975] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz (family: 0x6, model: 0x3e, stepping: 0x4)
[    0.436138] Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.436147] ... version:                3
[    0.436148] ... bit width:              48
[    0.436148] ... generic registers:      4
[    0.436149] ... value mask:             0000ffffffffffff
[    0.436150] ... max period:             00007fffffffffff
[    0.436151] ... fixed-purpose events:   3
[    0.436152] ... event mask:             000000070000000f
[    0.436286] rcu: Hierarchical SRCU implementation.
[    0.436445] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.436445] smp: Bringing up secondary CPUs ...
[    0.436445] x86: Booting SMP configuration:
[    0.436445] .... node  #0, CPUs:        #1
[    0.440293] TSC synchronization [CPU#0 -> CPU#1]:
[    0.440298] Measured 182538 cycles TSC warp between CPUs, turning off TSC clock.
[    0.440300] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.440564]   #2  #3  #4  #5  #6  #7  #8
[    0.453589] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.453589]   #9 #10 #11 #12 #13 #14 #15
[    0.461407] smp: Brought up 1 node, 16 CPUs
[    0.461407] smpboot: Max logical packages: 1
[    0.461407] smpboot: Total of 16 processors activated (83204.70 BogoMIPS)
[    0.468188] devtmpfs: initialized
[    0.468188] x86/mm: Memory block size: 2048MB
[    0.468778] ACPI: PM: Registering ACPI NVS region [mem 0x7bbf6000-0x7bee5fff] (3080192 bytes)
[    0.468778] ACPI: PM: Registering ACPI NVS region [mem 0x7c7d4000-0x7cc98fff] (5001216 bytes)
[    0.468778] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.468778] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.468778] pinctrl core: initialized pinctrl subsystem
[    0.468878] PM: RTC time: 12:55:31, date: 2021-07-30
[    0.469040] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.469468] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.469798] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.470126] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.470135] audit: initializing netlink subsys (disabled)
[    0.470144] audit: type=2000 audit(1627649731.064:1): state=initialized audit_enabled=0 res=1
[    0.470144] thermal_sys: Registered thermal governor 'fair_share'
[    0.470144] thermal_sys: Registered thermal governor 'bang_bang'
[    0.470144] thermal_sys: Registered thermal governor 'step_wise'
[    0.470144] thermal_sys: Registered thermal governor 'user_space'
[    0.470144] thermal_sys: Registered thermal governor 'power_allocator'
[    0.470144] EISA bus registered
[    0.470144] cpuidle: using governor ladder
[    0.470144] cpuidle: using governor menu
[    0.470144] ACPI: bus type PCI registered
[    0.470144] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.470144] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
[    0.470144] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E820
[    0.470144] PCI: Using configuration type 1 for base access
[    0.470144] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.472955] Kprobes globally optimized
[    0.472961] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.472961] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.472961] ACPI: PRMT not present
[    0.472961] PRM: found 4294967277 modules
[    0.472961] ACPI: Added _OSI(Module Device)
[    0.472961] ACPI: Added _OSI(Processor Device)
[    0.472961] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.472961] ACPI: Added _OSI(Processor Aggregator Device)
[    0.472961] ACPI: Added _OSI(Linux-Dell-Video)
[    0.472961] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.472961] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.664728] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.691092] ACPI: Interpreter enabled
[    0.691112] ACPI: PM: (supports S0 S1 S4 S5)
[    0.691113] ACPI: Using IOAPIC for interrupt routing
[    0.691201] HEST: Table parsing has been initialized.
[    0.691205] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.691832] ACPI: Enabled 7 GPEs in block 00 to 3F
[    0.713796] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-fe])
[    0.713804] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.714032] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
[    0.714244] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.714667] PCI host bridge to bus 0000:00
[    0.714669] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.714672] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.714673] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.714674] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.714676] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.714678] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    0.714679] pci_bus 0000:00: root bus resource [mem 0x80000000-0xfbffffff window]
[    0.714681] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.714706] pci 0000:00:00.0: [8086:0e00] type 00 class 0x060000
[    0.714782] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.714916] pci 0000:00:01.0: [8086:0e02] type 01 class 0x060400
[    0.715004] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.715180] pci 0000:00:01.1: [8086:0e03] type 01 class 0x060400
[    0.715266] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.715432] pci 0000:00:02.0: [8086:0e04] type 01 class 0x060400
[    0.715519] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.715685] pci 0000:00:03.0: [8086:0e08] type 01 class 0x060400
[    0.715720] pci 0000:00:03.0: enabling Extended Tags
[    0.715778] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.715940] pci 0000:00:05.0: [8086:0e28] type 00 class 0x088000
[    0.716088] pci 0000:00:05.2: [8086:0e2a] type 00 class 0x088000
[    0.716231] pci 0000:00:05.4: [8086:0e2c] type 00 class 0x080020
[    0.716243] pci 0000:00:05.4: reg 0x10: [mem 0xfb408000-0xfb408fff]
[    0.716406] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    0.716514] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    0.716683] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    0.716699] pci 0000:00:1a.0: reg 0x10: [mem 0xfb407000-0xfb4073ff]
[    0.716782] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.716904] pci 0000:00:1b.0: [8086:1d20] type 00 class 0x040300
[    0.716921] pci 0000:00:1b.0: reg 0x10: [mem 0xfb400000-0xfb403fff 64bit]
[    0.716997] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.717099] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    0.717188] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.717326] pci 0000:00:1c.1: [8086:1d12] type 01 class 0x060400
[    0.717415] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.717550] pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400
[    0.717639] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.717778] pci 0000:00:1c.3: [8086:1d16] type 01 class 0x060400
[    0.717867] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.718009] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    0.718025] pci 0000:00:1d.0: reg 0x10: [mem 0xfb406000-0xfb4063ff]
[    0.718108] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.718226] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.718392] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    0.718605] pci 0000:00:1f.2: [8086:2826] type 00 class 0x010400
[    0.718618] pci 0000:00:1f.2: reg 0x10: [io  0xf070-0xf077]
[    0.718625] pci 0000:00:1f.2: reg 0x14: [io  0xf060-0xf063]
[    0.718632] pci 0000:00:1f.2: reg 0x18: [io  0xf050-0xf057]
[    0.718640] pci 0000:00:1f.2: reg 0x1c: [io  0xf040-0xf043]
[    0.718647] pci 0000:00:1f.2: reg 0x20: [io  0xf020-0xf03f]
[    0.718654] pci 0000:00:1f.2: reg 0x24: [mem 0xfb405000-0xfb4057ff]
[    0.718693] pci 0000:00:1f.2: PME# supported from D3hot
[    0.718805] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    0.718822] pci 0000:00:1f.3: reg 0x10: [mem 0xfb404000-0xfb4040ff 64bit]
[    0.718842] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[    0.718995] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.719036] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.719078] pci 0000:00:02.0: PCI bridge to [bus 03]
[    0.719131] pci 0000:04:00.0: [10de:1c02] type 00 class 0x030000
[    0.719142] pci 0000:04:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
[    0.719152] pci 0000:04:00.0: reg 0x14: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.719162] pci 0000:04:00.0: reg 0x1c: [mem 0xf0000000-0xf1ffffff 64bit pref]
[    0.719168] pci 0000:04:00.0: reg 0x24: [io  0xe000-0xe07f]
[    0.719175] pci 0000:04:00.0: reg 0x30: [mem 0xfb000000-0xfb07ffff pref]
[    0.719181] pci 0000:04:00.0: enabling Extended Tags
[    0.719270] pci 0000:04:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:00:03.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
[    0.719315] pci 0000:04:00.1: [10de:10f1] type 00 class 0x040300
[    0.719326] pci 0000:04:00.1: reg 0x10: [mem 0xfb080000-0xfb083fff]
[    0.719362] pci 0000:04:00.1: enabling Extended Tags
[    0.719459] pci 0000:00:03.0: PCI bridge to [bus 04]
[    0.719462] pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
[    0.719466] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfb0fffff]
[    0.719470] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.719512] pci 0000:00:11.0: PCI bridge to [bus 05]
[    0.719559] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.719634] pci 0000:07:00.0: [8086:2526] type 00 class 0x028000
[    0.719669] pci 0000:07:00.0: reg 0x10: [mem 0xfb300000-0xfb303fff 64bit]
[    0.719847] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    0.719972] pci 0000:00:1c.1: PCI bridge to [bus 07]
[    0.719978] pci 0000:00:1c.1:   bridge window [mem 0xfb300000-0xfb3fffff]
[    0.720052] pci 0000:08:00.0: [10ec:8168] type 00 class 0x020000
[    0.720077] pci 0000:08:00.0: reg 0x10: [io  0xd000-0xd0ff]
[    0.720110] pci 0000:08:00.0: reg 0x18: [mem 0xfb204000-0xfb204fff 64bit]
[    0.720131] pci 0000:08:00.0: reg 0x20: [mem 0xfb200000-0xfb203fff 64bit]
[    0.720263] pci 0000:08:00.0: supports D1 D2
[    0.720264] pci 0000:08:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.720411] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.720414] pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
[    0.720418] pci 0000:00:1c.2:   bridge window [mem 0xfb200000-0xfb2fffff]
[    0.720482] pci 0000:09:00.0: [1106:3483] type 00 class 0x0c0330
[    0.720511] pci 0000:09:00.0: reg 0x10: [mem 0xfb100000-0xfb100fff 64bit]
[    0.720634] pci 0000:09:00.0: PME# supported from D0 D3cold
[    0.720720] pci 0000:00:1c.3: PCI bridge to [bus 09]
[    0.720725] pci 0000:00:1c.3:   bridge window [mem 0xfb100000-0xfb1fffff]
[    0.720746] pci_bus 0000:0a: extended config space not accessible
[    0.720795] pci 0000:00:1e.0: PCI bridge to [bus 0a] (subtractive decode)
[    0.720804] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    0.720806] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    0.720807] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    0.720809] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.720810] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.720812] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    0.720813] pci 0000:00:1e.0:   bridge window [mem 0x80000000-0xfbffffff window] (subtractive decode)
[    0.721412] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus ff])
[    0.721418] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.721451] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
[    0.721523] PCI host bridge to bus 0000:ff
[    0.721525] pci_bus 0000:ff: root bus resource [bus ff]
[    0.721537] pci 0000:ff:08.0: [8086:0e80] type 00 class 0x088000
[    0.721593] pci 0000:ff:09.0: [8086:0e90] type 00 class 0x088000
[    0.721643] pci 0000:ff:0a.0: [8086:0ec0] type 00 class 0x088000
[    0.721690] pci 0000:ff:0a.1: [8086:0ec1] type 00 class 0x088000
[    0.721733] pci 0000:ff:0a.2: [8086:0ec2] type 00 class 0x088000
[    0.721777] pci 0000:ff:0a.3: [8086:0ec3] type 00 class 0x088000
[    0.721821] pci 0000:ff:0b.0: [8086:0e1e] type 00 class 0x088000
[    0.721861] pci 0000:ff:0b.3: [8086:0e1f] type 00 class 0x088000
[    0.721907] pci 0000:ff:0c.0: [8086:0ee0] type 00 class 0x088000
[    0.721948] pci 0000:ff:0c.1: [8086:0ee2] type 00 class 0x088000
[    0.721992] pci 0000:ff:0c.2: [8086:0ee4] type 00 class 0x088000
[    0.722032] pci 0000:ff:0c.3: [8086:0ee6] type 00 class 0x088000
[    0.722074] pci 0000:ff:0d.0: [8086:0ee1] type 00 class 0x088000
[    0.722116] pci 0000:ff:0d.1: [8086:0ee3] type 00 class 0x088000
[    0.722156] pci 0000:ff:0d.2: [8086:0ee5] type 00 class 0x088000
[    0.722197] pci 0000:ff:0d.3: [8086:0ee7] type 00 class 0x088000
[    0.722244] pci 0000:ff:0e.0: [8086:0ea0] type 00 class 0x088000
[    0.722289] pci 0000:ff:0e.1: [8086:0e30] type 00 class 0x110100
[    0.722339] pci 0000:ff:0f.0: [8086:0ea8] type 00 class 0x088000
[    0.722399] pci 0000:ff:0f.1: [8086:0e71] type 00 class 0x088000
[    0.722458] pci 0000:ff:0f.2: [8086:0eaa] type 00 class 0x088000
[    0.722518] pci 0000:ff:0f.3: [8086:0eab] type 00 class 0x088000
[    0.722579] pci 0000:ff:0f.4: [8086:0eac] type 00 class 0x088000
[    0.722638] pci 0000:ff:0f.5: [8086:0ead] type 00 class 0x088000
[    0.722702] pci 0000:ff:10.0: [8086:0eb0] type 00 class 0x088000
[    0.722763] pci 0000:ff:10.1: [8086:0eb1] type 00 class 0x088000
[    0.722823] pci 0000:ff:10.2: [8086:0eb2] type 00 class 0x088000
[    0.722882] pci 0000:ff:10.3: [8086:0eb3] type 00 class 0x088000
[    0.722940] pci 0000:ff:10.4: [8086:0eb4] type 00 class 0x088000
[    0.723000] pci 0000:ff:10.5: [8086:0eb5] type 00 class 0x088000
[    0.723060] pci 0000:ff:10.6: [8086:0eb6] type 00 class 0x088000
[    0.723119] pci 0000:ff:10.7: [8086:0eb7] type 00 class 0x088000
[    0.723181] pci 0000:ff:13.0: [8086:0e1d] type 00 class 0x088000
[    0.723222] pci 0000:ff:13.1: [8086:0e34] type 00 class 0x110100
[    0.723265] pci 0000:ff:13.4: [8086:0e81] type 00 class 0x088000
[    0.723308] pci 0000:ff:13.5: [8086:0e36] type 00 class 0x110100
[    0.723353] pci 0000:ff:16.0: [8086:0ec8] type 00 class 0x088000
[    0.723394] pci 0000:ff:16.1: [8086:0ec9] type 00 class 0x088000
[    0.723435] pci 0000:ff:16.2: [8086:0eca] type 00 class 0x088000
[    0.723626] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.723697] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.723766] ACPI: PCI: Interrupt link LNKC configured for IRQ 3
[    0.723835] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.723903] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.723971] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.724040] ACPI: PCI: Interrupt link LNKG configured for IRQ 5
[    0.724108] ACPI: PCI: Interrupt link LNKH configured for IRQ 7
[    0.726383] iommu: Default domain type: Translated 
[    0.726383] pci 0000:04:00.0: vgaarb: setting as boot VGA device
[    0.726383] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.726383] pci 0000:04:00.0: vgaarb: bridge control possible
[    0.726383] vgaarb: loaded
[    0.726383] SCSI subsystem initialized
[    0.726383] libata version 3.00 loaded.
[    0.726383] ACPI: bus type USB registered
[    0.726383] usbcore: registered new interface driver usbfs
[    0.726383] usbcore: registered new interface driver hub
[    0.726383] usbcore: registered new device driver usb
[    0.726383] pps_core: LinuxPPS API ver. 1 registered
[    0.726383] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.726383] PTP clock support registered
[    0.726383] EDAC MC: Ver: 3.0.0
[    0.726383] NetLabel: Initializing
[    0.726383] NetLabel:  domain hash size = 128
[    0.726383] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.726383] NetLabel:  unlabeled traffic allowed by default
[    0.726383] PCI: Using ACPI for IRQ routing
[    0.733398] PCI: pci_cache_line_size set to 64 bytes
[    0.733492] e820: reserve RAM buffer [mem 0x00095400-0x0009ffff]
[    0.733495] e820: reserve RAM buffer [mem 0x7ba4a000-0x7bffffff]
[    0.733501] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.733501] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.736504] clocksource: Switched to clocksource hpet
[    0.747155] VFS: Disk quotas dquot_6.6.0
[    0.747174] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.747295] AppArmor: AppArmor Filesystem Enabled
[    0.747336] pnp: PnP ACPI init
[    0.747446] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.747450] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.747452] system 00:00: [mem 0xfe000000-0xfeafffff] has been reserved
[    0.747454] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.747455] system 00:00: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    0.747457] system 00:00: [mem 0xfed45000-0xfedfffff] has been reserved
[    0.747693] system 00:01: [io  0x0a00-0x0a0f] has been reserved
[    0.747696] system 00:01: [io  0x0a10-0x0a1f] has been reserved
[    0.747697] system 00:01: [io  0x0a20-0x0a2f] has been reserved
[    0.748000] pnp 00:02: [dma 0 disabled]
[    0.748150] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.748467] system 00:05: [io  0x0400-0x0453] has been reserved
[    0.748469] system 00:05: [io  0x0458-0x047f] has been reserved
[    0.748474] system 00:05: [io  0x1180-0x119f] has been reserved
[    0.748475] system 00:05: [io  0x0500-0x057f] has been reserved
[    0.748477] system 00:05: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.748479] system 00:05: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.748481] system 00:05: [mem 0xfed08000-0xfed08fff] has been reserved
[    0.748483] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    0.748583] system 00:06: [io  0x0454-0x0457] has been reserved
[    0.749135] pnp: PnP ACPI: found 7 devices
[    0.755267] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.755331] NET: Registered PF_INET protocol family
[    0.755554] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.757886] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    0.758341] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.759047] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.759128] TCP: Hash tables configured (established 524288 bind 65536)
[    0.759376] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
[    0.759694] UDP hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.759894] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.760064] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.760070] NET: Registered PF_XDP protocol family
[    0.760087] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.760098] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.760107] pci 0000:00:02.0: PCI bridge to [bus 03]
[    0.760116] pci 0000:00:03.0: PCI bridge to [bus 04]
[    0.760118] pci 0000:00:03.0:   bridge window [io  0xe000-0xefff]
[    0.760122] pci 0000:00:03.0:   bridge window [mem 0xfa000000-0xfb0fffff]
[    0.760125] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.760130] pci 0000:00:11.0: PCI bridge to [bus 05]
[    0.760142] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    0.760153] pci 0000:00:1c.1: PCI bridge to [bus 07]
[    0.760157] pci 0000:00:1c.1:   bridge window [mem 0xfb300000-0xfb3fffff]
[    0.760164] pci 0000:00:1c.2: PCI bridge to [bus 08]
[    0.760167] pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
[    0.760171] pci 0000:00:1c.2:   bridge window [mem 0xfb200000-0xfb2fffff]
[    0.760179] pci 0000:00:1c.3: PCI bridge to [bus 09]
[    0.760183] pci 0000:00:1c.3:   bridge window [mem 0xfb100000-0xfb1fffff]
[    0.760190] pci 0000:00:1e.0: PCI bridge to [bus 0a]
[    0.760201] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.760203] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.760204] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.760206] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.760207] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.760209] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.760210] pci_bus 0000:00: resource 10 [mem 0x80000000-0xfbffffff window]
[    0.760212] pci_bus 0000:04: resource 0 [io  0xe000-0xefff]
[    0.760214] pci_bus 0000:04: resource 1 [mem 0xfa000000-0xfb0fffff]
[    0.760215] pci_bus 0000:04: resource 2 [mem 0xe0000000-0xf1ffffff 64bit pref]
[    0.760217] pci_bus 0000:07: resource 1 [mem 0xfb300000-0xfb3fffff]
[    0.760219] pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
[    0.760220] pci_bus 0000:08: resource 1 [mem 0xfb200000-0xfb2fffff]
[    0.760222] pci_bus 0000:09: resource 1 [mem 0xfb100000-0xfb1fffff]
[    0.760223] pci_bus 0000:0a: resource 4 [io  0x0000-0x03af window]
[    0.760225] pci_bus 0000:0a: resource 5 [io  0x03e0-0x0cf7 window]
[    0.760226] pci_bus 0000:0a: resource 6 [io  0x03b0-0x03df window]
[    0.760227] pci_bus 0000:0a: resource 7 [io  0x0d00-0xffff window]
[    0.760229] pci_bus 0000:0a: resource 8 [mem 0x000a0000-0x000bffff window]
[    0.760230] pci_bus 0000:0a: resource 9 [mem 0x000c0000-0x000dffff window]
[    0.760232] pci_bus 0000:0a: resource 10 [mem 0x80000000-0xfbffffff window]
[    0.760314] pci 0000:00:05.0: disabled boot interrupts on device [8086:0e28]
[    0.784564] pci 0000:00:1a.0: quirk_usb_early_handoff+0x0/0x120 took 23668 usecs
[    0.808559] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x120 took 23409 usecs
[    0.808585] pci 0000:04:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.808617] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
[    0.808869] PCI: CLS 64 bytes, default 64
[    0.808877] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.808878] software IO TLB: mapped [mem 0x0000000077a4a000-0x000000007ba4a000] (64MB)
[    0.808932] Trying to unpack rootfs image as initramfs...
[    0.809944] Initialise system trusted keyrings
[    0.809958] Key type blacklist registered
[    0.810002] workingset: timestamp_bits=36 max_order=24 bucket_order=0
[    0.811174] zbud: loaded
[    0.811496] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.811648] fuse: init (API version 7.34)
[    0.811819] integrity: Platform Keyring initialized
[    0.822867] Key type asymmetric registered
[    0.822871] Asymmetric key parser 'x509' registered
[    0.822889] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
[    0.822945] io scheduler mq-deadline registered
[    0.823473] pcieport 0000:00:01.0: PME: Signaling with IRQ 25
[    0.823548] pcieport 0000:00:01.0: AER: enabled with IRQ 25
[    0.823777] pcieport 0000:00:01.1: PME: Signaling with IRQ 26
[    0.823843] pcieport 0000:00:01.1: AER: enabled with IRQ 26
[    0.824066] pcieport 0000:00:02.0: PME: Signaling with IRQ 28
[    0.824140] pcieport 0000:00:02.0: AER: enabled with IRQ 28
[    0.824361] pcieport 0000:00:03.0: PME: Signaling with IRQ 30
[    0.824440] pcieport 0000:00:03.0: AER: enabled with IRQ 30
[    0.824664] pcieport 0000:00:11.0: PME: Signaling with IRQ 31
[    0.824736] pcieport 0000:00:11.0: AER: enabled with IRQ 31
[    0.824951] pcieport 0000:00:1c.0: PME: Signaling with IRQ 32
[    0.825145] pcieport 0000:00:1c.1: PME: Signaling with IRQ 33
[    0.825336] pcieport 0000:00:1c.2: PME: Signaling with IRQ 34
[    0.825452] pcieport 0000:00:1c.3: PME: Signaling with IRQ 35
[    0.825589] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.825656] vesafb: mode is 640x480x32, linelength=2560, pages=0
[    0.825659] vesafb: scrolling: redraw
[    0.825660] vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.825675] vesafb: framebuffer at 0xf1000000, mapped to 0x000000009bc8a364, using 1216k, total 1216k
[    0.825725] fbcon: Deferring console take-over
[    0.825726] fb0: VESA VGA frame buffer device
[    0.825866] Monitor-Mwait will be used to enter C-1 state
[    0.825870] Monitor-Mwait will be used to enter C-2 state
[    0.825874] ACPI: \_SB_.SCK0.C000: Found 2 idle states
[    0.828657] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.828701] ACPI: button: Power Button [PWRB]
[    0.828745] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.828771] ACPI: button: Power Button [PWRF]
[    0.852624] ERST: Error Record Serialization Table (ERST) support is initialized.
[    0.852630] pstore: Registered erst as persistent store backend
[    0.852755] GHES: APEI firmware first mode is enabled by APEI bit and WHEA _OSC.
[    0.852928] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.873429] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.875961] Linux agpgart interface v0.103
[    0.886809] loop: module loaded
[    0.887186] libphy: Fixed MDIO Bus: probed
[    0.887188] tun: Universal TUN/TAP device driver, 1.6
[    0.887254] PPP generic driver version 2.4.2
[    0.887324] VFIO - User Level meta-driver version: 0.3
[    0.887460] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.887464] ehci-pci: EHCI PCI platform driver
[    0.887654] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    0.887662] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    0.887675] ehci-pci 0000:00:1a.0: debug port 2
[    0.891591] ehci-pci 0000:00:1a.0: irq 16, io mem 0xfb407000
[    0.904478] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    0.904547] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
[    0.904551] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.904552] usb usb1: Product: EHCI Host Controller
[    0.904554] usb usb1: Manufacturer: Linux 5.14.0-051400rc2-generic ehci_hcd
[    0.904555] usb usb1: SerialNumber: 0000:00:1a.0
[    0.904710] hub 1-0:1.0: USB hub found
[    0.904718] hub 1-0:1.0: 2 ports detected
[    0.905037] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    0.905044] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.905055] ehci-pci 0000:00:1d.0: debug port 2
[    0.908987] ehci-pci 0000:00:1d.0: irq 23, io mem 0xfb406000
[    0.924472] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    0.924538] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
[    0.924541] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.924543] usb usb2: Product: EHCI Host Controller
[    0.924544] usb usb2: Manufacturer: Linux 5.14.0-051400rc2-generic ehci_hcd
[    0.924546] usb usb2: SerialNumber: 0000:00:1d.0
[    0.924704] hub 2-0:1.0: USB hub found
[    0.924712] hub 2-0:1.0: 2 ports detected
[    0.924890] ehci-platform: EHCI generic platform driver
[    0.924908] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.924912] ohci-pci: OHCI PCI platform driver
[    0.924928] ohci-platform: OHCI generic platform driver
[    0.924934] uhci_hcd: USB Universal Host Controller Interface driver
[    0.924979] i8042: PNP: No PS/2 controller found.
[    0.925072] mousedev: PS/2 mouse device common for all mice
[    0.925188] rtc_cmos 00:03: RTC can wake from S4
[    0.925421] rtc_cmos 00:03: registered as rtc0
[    0.925496] rtc_cmos 00:03: setting system clock to 2021-07-30T12:55:31 UTC (1627649731)
[    0.925516] rtc_cmos 00:03: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.925525] i2c /dev entries driver
[    0.925869] device-mapper: uevent: version 1.0.3
[    0.925924] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
[    0.925950] platform eisa.0: Probing EISA bus 0
[    0.925953] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.925954] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.925956] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.925957] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.925958] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.925959] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.925961] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.925962] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.925963] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.925964] platform eisa.0: EISA: Detected 0 cards
[    0.925970] intel_pstate: Intel P-state driver initializing
[    0.927091] ledtrig-cpu: registered to indicate activity on CPUs
[    0.927230] drop_monitor: Initializing network drop monitor service
[    0.927399] NET: Registered PF_INET6 protocol family
[    0.965926] Freeing initrd memory: 62264K
[    0.976511] Segment Routing with IPv6
[    0.976543] NET: Registered PF_PACKET protocol family
[    0.976600] Key type dns_resolver registered
[    0.978127] microcode: sig=0x306e4, pf=0x1, revision=0x42e
[    0.978350] microcode: Microcode Update Driver: v2.2.
[    0.978356] IPI shorthand broadcast: enabled
[    0.978431] registered taskstats version 1
[    0.978680] Loading compiled-in X.509 certificates
[    0.979564] Loaded X.509 cert 'Build time autogenerated kernel key: 73e1e8ccf95978ddbf430f7d6ab7c5a583d39b43'
[    0.980329] Loaded X.509 cert 'Canonical Ltd. Live Patch Signing: 14df34d1a87cf37625abec039ef2bf521249b969'
[    0.981392] Loaded X.509 cert 'Canonical Ltd. Kernel Module Signing: 88f752e560a1e0737e31163a466ad7b70a850c19'
[    0.981395] blacklist: Loading compiled-in revocation X.509 certificates
[    0.981428] Loaded X.509 cert 'Canonical Ltd. Secure Boot Signing: 61482aa2830d0ab2ad5af10b7250da9033ddcef0'
[    0.982206] zswap: loaded using pool lzo/zbud
[    0.982484] Key type ._fscrypt registered
[    0.982485] Key type .fscrypt registered
[    0.982486] Key type fscrypt-provisioning registered
[    0.982562] pstore: Using crash dump compression: deflate
[    0.985914] Key type encrypted registered
[    0.985920] AppArmor: AppArmor sha1 policy hashing enabled
[    0.985932] ima: No TPM chip found, activating TPM-bypass!
[    0.985938] Loading compiled-in module X.509 certificates
[    0.986681] Loaded X.509 cert 'Build time autogenerated kernel key: 73e1e8ccf95978ddbf430f7d6ab7c5a583d39b43'
[    0.986684] ima: Allocated hash algorithm: sha1
[    0.986693] ima: No architecture policies found
[    0.986702] evm: Initialising EVM extended attributes:
[    0.986703] evm: security.selinux
[    0.986704] evm: security.SMACK64
[    0.986705] evm: security.SMACK64EXEC
[    0.986706] evm: security.SMACK64TRANSMUTE
[    0.986707] evm: security.SMACK64MMAP
[    0.986707] evm: security.apparmor
[    0.986708] evm: security.ima
[    0.986709] evm: security.capability
[    0.986709] evm: HMAC attrs: 0x1
[    0.987042] PM:   Magic number: 13:424:937
[    0.987056] misc lightnvm: hash matches
[    0.987100] platform PNP0103:00: hash matches
[    0.987134] acpi PNP0103:00: hash matches
[    0.987289] RAS: Correctable Errors collector initialized.
[    0.987299] Unstable clock detected, switching default tracing clock to "global"
               If you want to keep using the local clock, then add:
                 "trace_clock=local"
               on the kernel command line
[    0.988775] Freeing unused decrypted memory: 2036K
[    0.989152] Freeing unused kernel image (initmem) memory: 2900K
[    1.036532] Write protecting the kernel read-only data: 30720k
[    1.037090] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    1.037461] Freeing unused kernel image (rodata/data gap) memory: 1692K
[    1.094449] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.094451] x86/mm: Checking user space page tables
[    1.147343] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.147348] Run /init as init process
[    1.147350]   with arguments:
[    1.147351]     /init
[    1.147352]     splash
[    1.147353]   with environment:
[    1.147354]     HOME=/
[    1.147355]     TERM=linux
[    1.147355]     BOOT_IMAGE=/boot/vmlinuz-5.14.0-051400rc2-generic
[    1.164467] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.184466] usb 2-1: new high-speed USB device number 2 using ehci-pci
[    1.275251] xhci_hcd 0000:09:00.0: xHCI Host Controller
[    1.275263] xhci_hcd 0000:09:00.0: new USB bus registered, assigned bus number 3
[    1.275385] xhci_hcd 0000:09:00.0: hcc params 0x002841eb hci version 0x100 quirks 0x0000000000000890
[    1.275545] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    1.275801] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.14
[    1.275805] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.275807] usb usb3: Product: xHCI Host Controller
[    1.275808] usb usb3: Manufacturer: Linux 5.14.0-051400rc2-generic xhci-hcd
[    1.275809] usb usb3: SerialNumber: 0000:09:00.0
[    1.275918] hub 3-0:1.0: USB hub found
[    1.275927] hub 3-0:1.0: 1 port detected
[    1.276085] xhci_hcd 0000:09:00.0: xHCI Host Controller
[    1.276090] xhci_hcd 0000:09:00.0: new USB bus registered, assigned bus number 4
[    1.276093] xhci_hcd 0000:09:00.0: Host supports USB 3.0 SuperSpeed
[    1.276152] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.14
[    1.276155] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.276156] usb usb4: Product: xHCI Host Controller
[    1.276157] usb usb4: Manufacturer: Linux 5.14.0-051400rc2-generic xhci-hcd
[    1.276159] usb usb4: SerialNumber: 0000:09:00.0
[    1.276187] ahci 0000:00:1f.2: version 3.0
[    1.276246] hub 4-0:1.0: USB hub found
[    1.276257] hub 4-0:1.0: 4 ports detected
[    1.276589] i2c i2c-0: 4/8 memory slots populated (from DMI)
[    1.276592] i2c i2c-0: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    1.286553] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x6 impl RAID mode
[    1.286559] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    1.294717] libphy: r8169: probed
[    1.294907] r8169 0000:08:00.0 eth0: RTL8168h/8111h, 00:e0:1d:68:2b:db, XID 541, IRQ 38
[    1.294912] r8169 0000:08:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    1.296018] r8169 0000:08:00.0 enp8s0: renamed from eth0
[    1.297003] scsi host0: ahci
[    1.297228] scsi host1: ahci
[    1.297471] scsi host2: ahci
[    1.297646] scsi host3: ahci
[    1.297840] scsi host4: ahci
[    1.297990] scsi host5: ahci
[    1.298034] ata1: DUMMY
[    1.298037] ata2: FORCE: PHY spd limit set to 3.0Gbps
[    1.298039] ata2: SATA max UDMA/133 abar m2048@0xfb405000 port 0xfb405180 irq 37
[    1.298041] ata3: FORCE: PHY spd limit set to 3.0Gbps
[    1.298042] ata3: SATA max UDMA/133 abar m2048@0xfb405000 port 0xfb405200 irq 37
[    1.298043] ata4: DUMMY
[    1.298044] ata5: DUMMY
[    1.298045] ata6: DUMMY
[    1.328820] usb 1-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    1.328824] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.329092] hub 1-1:1.0: USB hub found
[    1.329141] hub 1-1:1.0: 6 ports detected
[    1.348761] usb 2-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    1.348766] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.348915] hub 2-1:1.0: USB hub found
[    1.349010] hub 2-1:1.0: 8 ports detected
[    1.532512] usb 3-1: new high-speed USB device number 2 using xhci_hcd
[    1.611490] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    1.615435] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    1.617065] ata2.00: supports DRM functions and may not be fully accessible
[    1.617932] ata2.00: disabling queued TRIM support
[    1.617942] ata2.00: ATA-9: Samsung SSD 850 EVO M.2 250GB, EMT21B6Q, max UDMA/133
[    1.617945] ata2.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.620261] ata2.00: supports DRM functions and may not be fully accessible
[    1.620498] usb 1-1.3: new full-speed USB device number 3 using ehci-pci
[    1.621030] ata2.00: disabling queued TRIM support
[    1.623068] ata2.00: configured for UDMA/133
[    1.623283] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 850  1B6Q PQ: 0 ANSI: 5
[    1.623678] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.623730] sd 1:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/233 GiB)
[    1.623743] sd 1:0:0:0: [sda] Write Protect is off
[    1.623745] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.623760] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.637349]  sda: sda1 sda2 sda3 < sda5 >
[    1.657052] sd 1:0:0:0: [sda] supports TCG Opal
[    1.657057] sd 1:0:0:0: [sda] Attached SCSI disk
[    1.687107] usb 3-1: New USB device found, idVendor=2109, idProduct=3431, bcdDevice= 4.20
[    1.687117] usb 3-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    1.687121] usb 3-1: Product: USB2.0 Hub
[    1.688383] hub 3-1:1.0: USB hub found
[    1.688655] hub 3-1:1.0: 4 ports detected
[    1.734846] usb 1-1.3: New USB device found, idVendor=8087, idProduct=0025, bcdDevice= 0.02
[    1.734850] usb 1-1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.867933] ata3.00: ATA-11: ST18000NM009J-2UW101, SE01, max UDMA/133
[    1.867938] ata3.00: 35156656128 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.911607] ata3.00: configured for UDMA/133
[    1.911858] scsi 2:0:0:0: Direct-Access-ZBC ATA      ST18000NM009J-2U SE01 PQ: 0 ANSI: 7
[    1.912099] sd 2:0:0:0: Attached scsi generic sg1 type 20
[    1.912164] sd 2:0:0:0: [sdb] Host-managed zoned block device
[    1.912359] sd 2:0:0:0: [sdb] 35156656128 512-byte logical blocks: (18.0 TB/16.4 TiB)
[    1.912362] sd 2:0:0:0: [sdb] 4096-byte physical blocks
[    1.912375] sd 2:0:0:0: [sdb] Write Protect is off
[    1.912377] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    1.912394] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.067617] sd 2:0:0:0: [sdb] 67056 zones of 524288 logical blocks
[    2.106728] sd 2:0:0:0: [sdb] Attached SCSI disk
[    2.412450] raid6: sse2x4   gen() 13157 MB/s
[    2.480451] raid6: sse2x4   xor()  7140 MB/s
[    2.548450] raid6: sse2x2   gen() 13181 MB/s
[    2.616451] raid6: sse2x2   xor()  7256 MB/s
[    2.684451] raid6: sse2x1   gen() 11061 MB/s
[    2.752452] raid6: sse2x1   xor()  6585 MB/s
[    2.752453] raid6: using algorithm sse2x2 gen() 13181 MB/s
[    2.752454] raid6: .... xor() 7256 MB/s, rmw enabled
[    2.752456] raid6: using ssse3x2 recovery algorithm
[    2.753538] xor: automatically using best checksumming function   avx       
[    2.754542] async_tx: api initialized (async)
[    2.804419] fbcon: Taking over console
[    2.804505] Console: switching to colour frame buffer device 80x30
[    2.833057] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[    2.978116] systemd[1]: Inserted module 'autofs4'
[    2.999241] systemd[1]: systemd 247.3-3ubuntu3.4 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    3.016577] systemd[1]: Detected architecture x86-64.
[    3.049537] systemd[1]: Set hostname to <x79zd3>.
[    4.214601] systemd[1]: /lib/systemd/system/plymouth-start.service:17: Unit configured to use KillMode=none. This is unsafe, as it disables systemd's process lifecycle management for the service. Please update your service to use a safer KillMode=, such as 'mixed' or 'control-group'. Support for KillMode=none is deprecated and will eventually be removed.
[    4.257329] systemd[1]: Queued start job for default target Graphical Interface.
[    4.274835] systemd[1]: Created slice system-modprobe.slice.
[    4.275222] systemd[1]: Created slice system-postfix.slice.
[    4.275574] systemd[1]: Created slice User and Session Slice.
[    4.275668] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    4.275863] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    4.275926] systemd[1]: Reached target Remote File Systems.
[    4.275950] systemd[1]: Reached target Slices.
[    4.276091] systemd[1]: Listening on multipathd control socket.
[    4.277060] systemd[1]: Listening on Syslog Socket.
[    4.277970] systemd[1]: Listening on fsck to fsckd communication Socket.
[    4.278045] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    4.278266] systemd[1]: Listening on Journal Audit Socket.
[    4.278388] systemd[1]: Listening on Journal Socket (/dev/log).
[    4.278526] systemd[1]: Listening on Journal Socket.
[    4.278928] systemd[1]: Listening on udev Control Socket.
[    4.279043] systemd[1]: Listening on udev Kernel Socket.
[    4.279960] systemd[1]: Mounting Huge Pages File System...
[    4.280935] systemd[1]: Mounting POSIX Message Queue File System...
[    4.281996] systemd[1]: Mounting Kernel Debug File System...
[    4.282950] systemd[1]: Mounting Kernel Trace File System...
[    4.284578] systemd[1]: Starting Journal Service...
[    4.285850] systemd[1]: Starting Set the console keyboard layout...
[    4.287024] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    4.288061] systemd[1]: Starting Load Kernel Module configfs...
[    4.289201] systemd[1]: Starting Load Kernel Module drm...
[    4.290155] systemd[1]: Starting Load Kernel Module fuse...
[    4.290938] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[    4.290987] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
[    4.293027] systemd[1]: Starting Load Kernel Modules...
[    4.294013] systemd[1]: Starting Remount Root and Kernel File Systems...
[    4.294978] systemd[1]: Starting Coldplug All udev Devices...
[    4.295926] systemd[1]: Starting Uncomplicated firewall...
[    4.298143] systemd[1]: Mounted Huge Pages File System.
[    4.298266] systemd[1]: Mounted POSIX Message Queue File System.
[    4.298372] systemd[1]: Mounted Kernel Debug File System.
[    4.298477] systemd[1]: Mounted Kernel Trace File System.
[    4.298966] systemd[1]: Finished Create list of static device nodes for the current kernel.
[    4.299288] systemd[1]: modprobe@configfs.service: Succeeded.
[    4.299654] systemd[1]: Finished Load Kernel Module configfs.
[    4.299918] systemd[1]: modprobe@fuse.service: Succeeded.
[    4.300271] systemd[1]: Finished Load Kernel Module fuse.
[    4.300867] systemd[1]: Finished Uncomplicated firewall.
[    4.301913] systemd[1]: Mounting FUSE Control File System...
[    4.302925] systemd[1]: Mounting Kernel Configuration File System...
[    4.303797] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro. Quota mode: none.
[    4.305945] systemd[1]: modprobe@drm.service: Succeeded.
[    4.306329] systemd[1]: Finished Load Kernel Module drm.
[    4.306887] systemd[1]: Finished Remount Root and Kernel File Systems.
[    4.307038] systemd[1]: Mounted FUSE Control File System.
[    4.307146] systemd[1]: Mounted Kernel Configuration File System.
[    4.307995] systemd[1]: Activating swap /swapfile...
[    4.309195] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[    4.309288] systemd[1]: Condition check resulted in Platform Persistent Storage Archival being skipped.
[    4.310147] systemd[1]: Starting Load/Save Random Seed...
[    4.311361] systemd[1]: Starting Create System Users...
[    4.313163] Adding 2097148k swap on /swapfile.  Priority:-2 extents:6 across:2260988k SSFS
[    4.313280] systemd[1]: Activated swap /swapfile.
[    4.313366] systemd[1]: Reached target Swap.
[    4.314880] lp: driver loaded but no devices found
[    4.318195] ppdev: user-space parallel port driver
[    4.321291] parport0: PC-style at 0x378 (0x778)
[    4.321890] systemd[1]: Finished Load/Save Random Seed.
[    4.322055] systemd[1]: Condition check resulted in First Boot Complete being skipped.
[    4.327635] systemd[1]: Finished Create System Users.
[    4.328677] systemd[1]: Starting Create Static Device Nodes in /dev...
[    4.339777] systemd[1]: Finished Create Static Device Nodes in /dev.
[    4.341365] systemd[1]: Starting Rule-based Manager for Device Events and Files...
[    4.357482] systemd[1]: Finished Set the console keyboard layout.
[    4.391703] systemd[1]: Started Journal Service.
[    4.396569] systemd-journald[429]: Received client request to flush runtime journal.
[    4.461218]  [PCSPP,TRISTATE,EPP]
[    4.541166] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.541603] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.548666] lp0: using parport0 (polling).
[    4.602284] Bluetooth: Core ver 2.22
[    4.602305] NET: Registered PF_BLUETOOTH protocol family
[    4.602306] Bluetooth: HCI device and connection manager initialized
[    4.602309] Bluetooth: HCI socket layer initialized
[    4.602311] Bluetooth: L2CAP socket layer initialized
[    4.602314] Bluetooth: SCO socket layer initialized
[    4.605402] Intel(R) Wireless WiFi driver for Linux
[    4.633018] iwlwifi 0000:07:00.0: WRT: Overriding region id 0
[    4.633024] iwlwifi 0000:07:00.0: WRT: Overriding region id 1
[    4.633028] iwlwifi 0000:07:00.0: WRT: Overriding region id 2
[    4.633030] iwlwifi 0000:07:00.0: WRT: Overriding region id 3
[    4.633032] iwlwifi 0000:07:00.0: WRT: Overriding region id 4
[    4.633035] iwlwifi 0000:07:00.0: WRT: Overriding region id 6
[    4.633037] iwlwifi 0000:07:00.0: WRT: Overriding region id 8
[    4.633039] iwlwifi 0000:07:00.0: WRT: Overriding region id 9
[    4.633041] iwlwifi 0000:07:00.0: WRT: Overriding region id 10
[    4.633043] iwlwifi 0000:07:00.0: WRT: Overriding region id 11
[    4.633045] iwlwifi 0000:07:00.0: WRT: Overriding region id 15
[    4.633048] iwlwifi 0000:07:00.0: WRT: Overriding region id 16
[    4.633050] iwlwifi 0000:07:00.0: WRT: Overriding region id 18
[    4.633052] iwlwifi 0000:07:00.0: WRT: Overriding region id 19
[    4.633054] iwlwifi 0000:07:00.0: WRT: Overriding region id 20
[    4.633057] iwlwifi 0000:07:00.0: WRT: Overriding region id 21
[    4.633059] iwlwifi 0000:07:00.0: WRT: Overriding region id 28
[    4.633434] iwlwifi 0000:07:00.0: loaded firmware version 46.6f9f215c.0 9260-th-b0-jf-b0-46.ucode op_mode iwlmvm
[    4.636386] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[    4.636389] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    4.636390] RAPL PMU: hw unit of domain package 2^-16 Joules
[    4.639272] cryptd: max_cpu_qlen set to 1000
[    4.651299] AVX version of gcm_enc/dec engaged.
[    4.651351] AES CTR mode by8 optimization enabled
[    4.717469] nct6775: Found NCT6779D or compatible chip at 0x2e:0xa10
[    4.736749] snd_hda_intel 0000:04:00.1: Disabling MSI
[    4.736760] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
[    4.754933] iwlwifi 0000:07:00.0: Detected Intel(R) Wireless-AC 9260 160MHz, REV=0x324
[    4.760873] usbcore: registered new interface driver btusb
[    4.761769] Bluetooth: hci0: Firmware revision 0.1 build 168 week 48 2020
[    4.763925] snd_hda_codec_realtek hdaudioC0D0: ALC662 rev3: SKU not ready 0x00000100
[    4.764471] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC662 rev3: line_outs=3 (0x14/0x16/0x15/0x0/0x0) type:line
[    4.764477] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.764481] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
[    4.764484] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.764486] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x1e/0x0
[    4.764488] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.764490] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
[    4.764493] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
[    4.764495] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
[    4.764497] snd_hda_codec_realtek hdaudioC0D0:      CD=0x1c
[    4.765113] thermal thermal_zone0: failed to read out thermal zone (-61)
[    4.766475] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/0000:04:00.1/sound/card1/input2
[    4.766558] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/0000:04:00.1/sound/card1/input3
[    4.766651] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.0/0000:04:00.1/sound/card1/input4
[    4.766726] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.0/0000:04:00.1/sound/card1/input5
[    4.766797] input: HDA NVidia HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.0/0000:04:00.1/sound/card1/input6
[    4.766866] input: HDA NVidia HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:03.0/0000:04:00.1/sound/card1/input7
[    4.773845] Bluetooth: hci0: Found device firmware: intel/ibt-18-16-1.sfi
[    4.773882] Bluetooth: hci0: Boot Address: 0x40800
[    4.773884] Bluetooth: hci0: Firmware Version: 168-48.20
[    4.773887] Bluetooth: hci0: Firmware already loaded
[    4.805282] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    4.805337] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    4.805378] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    4.805428] input: HDA Intel PCH Line Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    4.805474] input: HDA Intel PCH Line Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[    4.805515] input: HDA Intel PCH Line Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[    4.805559] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[    4.805658] iwlwifi 0000:07:00.0: base HW address: 54:8d:5a:46:f7:cb
[    4.817949] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    4.817967] EDAC sbridge: Seeking for: PCI ID 8086:0ea0
[    4.817973] EDAC sbridge: Seeking for: PCI ID 8086:0e60
[    4.817978] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    4.817983] EDAC sbridge: Seeking for: PCI ID 8086:0ea8
[    4.817986] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    4.817991] EDAC sbridge: Seeking for: PCI ID 8086:0e71
[    4.817994] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    4.817999] EDAC sbridge: Seeking for: PCI ID 8086:0eaa
[    4.818002] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    4.818007] EDAC sbridge: Seeking for: PCI ID 8086:0eab
[    4.818010] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    4.818015] EDAC sbridge: Seeking for: PCI ID 8086:0eac
[    4.818017] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    4.818024] EDAC sbridge: Seeking for: PCI ID 8086:0ead
[    4.818026] EDAC sbridge: Seeking for: PCI ID 8086:0e68
[    4.818031] EDAC sbridge: Seeking for: PCI ID 8086:0e79
[    4.818036] EDAC sbridge: Seeking for: PCI ID 8086:0e6a
[    4.818041] EDAC sbridge: Seeking for: PCI ID 8086:0e6b
[    4.818046] EDAC sbridge: Seeking for: PCI ID 8086:0e6c
[    4.818051] EDAC sbridge: Seeking for: PCI ID 8086:0e6d
[    4.818055] EDAC sbridge: Seeking for: PCI ID 8086:0eb8
[    4.818060] EDAC sbridge: Seeking for: PCI ID 8086:0ebc
[    4.818066] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    4.818072] EDAC sbridge: Seeking for: PCI ID 8086:0ec8
[    4.818073] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    4.818079] EDAC sbridge: Seeking for: PCI ID 8086:0ec9
[    4.818081] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    4.818087] EDAC sbridge: Seeking for: PCI ID 8086:0eca
[    4.818198] EDAC MC0: Giving out device to module sb_edac controller Ivy Bridge SrcID#0_Ha#0: DEV 0000:ff:0e.0 (INTERRUPT)
[    4.818201] EDAC sbridge:  Ver: 1.1.2 
[    4.823450] intel_rapl_common: Found RAPL domain package
[    4.823452] intel_rapl_common: Found RAPL domain core
[    4.833821] Bluetooth: hci0: MSFT filter_enable is already on
[    4.873787] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    4.876643] iwlwifi 0000:07:00.0 wlp7s0: renamed from wlan0
[    4.965844] alua: device handler registered
[    4.966925] emc: device handler registered
[    4.968180] rdac: device handler registered
[    5.006131] loop0: detected capacity change from 0 to 113560
[    5.044680] loop1: detected capacity change from 0 to 113544
[    5.044746] loop2: detected capacity change from 0 to 133320
[    5.044854] loop3: detected capacity change from 0 to 66144
[    5.076621] loop4: detected capacity change from 0 to 104536
[    5.124651] loop5: detected capacity change from 0 to 132648
[    5.156598] loop6: detected capacity change from 0 to 337424
[    5.196629] loop7: detected capacity change from 0 to 448496
[    5.244611] loop8: detected capacity change from 0 to 66120
[    5.344998] loop9: detected capacity change from 0 to 448512
[    5.368868] loop10: detected capacity change from 0 to 104360
[    5.448829] loop11: detected capacity change from 0 to 333552
[    5.522537] audit: type=1400 audit(1627649736.092:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-xpdfimport" pid=789 comm="apparmor_parser"
[    5.522775] audit: type=1400 audit(1627649736.092:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-senddoc" pid=791 comm="apparmor_parser"
[    5.522811] audit: type=1400 audit(1627649736.092:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ippusbxd" pid=786 comm="apparmor_parser"
[    5.523885] audit: type=1400 audit(1627649736.092:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=779 comm="apparmor_parser"
[    5.523891] audit: type=1400 audit(1627649736.092:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="libreoffice-oosplash" pid=792 comm="apparmor_parser"
[    5.523895] audit: type=1400 audit(1627649736.092:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=790 comm="apparmor_parser"
[    5.523899] audit: type=1400 audit(1627649736.092:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=790 comm="apparmor_parser"
[    5.523997] audit: type=1400 audit(1627649736.092:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=783 comm="apparmor_parser"
[    5.524003] audit: type=1400 audit(1627649736.092:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=783 comm="apparmor_parser"
[    5.524007] audit: type=1400 audit(1627649736.092:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=783 comm="apparmor_parser"
[    5.901244] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.901248] Bluetooth: BNEP filters: protocol multicast
[    5.901252] Bluetooth: BNEP socket layer initialized
[    5.915518] NET: Registered PF_ALG protocol family
[    6.060486] Generic FE-GE Realtek PHY r8169-800:00: attached PHY driver (mii_bus:phy_addr=r8169-800:00, irq=MAC)
[    6.260598] r8169 0000:08:00.0 enp8s0: Link is Down
[    6.457248] ACPI: \: failed to evaluate _DSM (0x1001)
[    6.457253] ACPI: \: failed to evaluate _DSM (0x1001)
[    6.457255] ACPI: \: failed to evaluate _DSM (0x1001)
[    6.457256] ACPI: \: failed to evaluate _DSM (0x1001)
[    6.560855] loop12: detected capacity change from 0 to 8
[    9.317861] r8169 0000:08:00.0 enp8s0: Link is Up - 1Gbps/Full - flow control rx/tx
[    9.317884] IPv6: ADDRCONF(NETDEV_CHANGE): enp8s0: link becomes ready
[   19.256813] rfkill: input handler disabled
[   23.393487] wlp7s0: authenticate with 2c:4d:54:83:78:14
[   23.395501] wlp7s0: send auth to 2c:4d:54:83:78:14 (try 1/3)
[   23.541254] wlp7s0: send auth to 2c:4d:54:83:78:14 (try 2/3)
[   23.606377] wlp7s0: authenticated
[   23.608505] wlp7s0: associate with 2c:4d:54:83:78:14 (try 1/3)
[   23.713581] wlp7s0: associate with 2c:4d:54:83:78:14 (try 2/3)
[   23.774945] wlp7s0: RX AssocResp from 2c:4d:54:83:78:14 (capab=0x511 status=0 aid=103)
[   23.778229] wlp7s0: associated
[   28.044808] IPv6: ADDRCONF(NETDEV_CHANGE): wlp7s0: link becomes ready
[   31.006976] wlp7s0: deauthenticated from 2c:4d:54:83:78:14 (Reason: 2=PREV_AUTH_NOT_VALID)
[   32.534794] wlp7s0: authenticate with 2c:4d:54:83:78:14
[   32.542571] wlp7s0: send auth to 2c:4d:54:83:78:14 (try 1/3)
[   32.585991] wlp7s0: authenticated
[   32.588506] wlp7s0: associate with 2c:4d:54:83:78:14 (try 1/3)
[   32.592104] wlp7s0: RX AssocResp from 2c:4d:54:83:78:14 (capab=0x511 status=0 aid=104)
[   32.596156] wlp7s0: associated
[   41.790238] Bluetooth: RFCOMM TTY layer initialized
[   41.790247] Bluetooth: RFCOMM socket layer initialized
[   41.790252] Bluetooth: RFCOMM ver 1.11
[   78.049241] wlp7s0: deauthenticating from 2c:4d:54:83:78:14 by local choice (Reason: 3=DEAUTH_LEAVING)
[   81.647470] wlp7s0: authenticate with 2c:4d:54:83:78:14
[   81.650606] wlp7s0: send auth to 2c:4d:54:83:78:14 (try 1/3)
[   81.690015] wlp7s0: authenticated
[   81.692513] wlp7s0: associate with 2c:4d:54:83:78:14 (try 1/3)
[   81.799675] wlp7s0: associate with 2c:4d:54:83:78:14 (try 2/3)
[   81.885627] wlp7s0: RX AssocResp from 2c:4d:54:83:78:14 (capab=0x511 status=0 aid=105)
[   81.888927] wlp7s0: associated
[ 1054.626456] Btrfs loaded, crc32c=crc32c-intel, zoned=yes
[ 1054.705975] BTRFS: device fsid 4312bf2a-376d-4a44-a69a-6bb112b124f6 devid 1 transid 4672 /dev/sdb scanned by mount (1926)
[ 1054.855944] BTRFS info (device sdb): has skinny extents
[ 1055.315175] BTRFS info (device sdb): host-managed zoned block device /dev/sdb, 67056 zones of 268435456 bytes
[ 1057.219336] BTRFS info (device sdb): zoned mode enabled with zone size 268435456

--------------4FC6B39DA92F1E4446845F3C--
