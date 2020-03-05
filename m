Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76BD417AB16
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2020 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCERCF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 12:02:05 -0500
Received: from fe4.lbl.gov ([131.243.228.53]:2047 "EHLO fe4.lbl.gov"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgCERCE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 12:02:04 -0500
IronPort-SDR: lTMV1EFbF61vb0PneTim+4fd9VAV7zg6wT/7USpbXufgO8jM1nO9McJbpDvliC0OztaiQQU0Ei
 ekKq7FsL2paA==
X-Ironport-SBRS: 2.7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FCAAC/L2Fef8jSVdFmGgEBAQEBAQE?=
 =?us-ascii?q?BAQMBAQEBEQEBAQICAQEBAYF7gX2BGFVchBWDSYs4ghGBAYJtlWmBZwkBAQE?=
 =?us-ascii?q?BAQEBAQEGAQEjCAQEAQECgQJLgnQCgg8kOBMCAwEBCwEBBgEBAQEBBQQCAhA?=
 =?us-ascii?q?BAQkLCwgnhV8Mg1NwAQEBAQEBAQEBAQEBAQEBAQEBAQEWAg1UJkMBAQECARI?=
 =?us-ascii?q?IAQgEUhALDgQcAQESAgI0AQUBDg4GDQYCAQEegjkMPwGCWyAFCpoAgQQ9iyh?=
 =?us-ascii?q?/M4N9TEGECoEuEAkBCIEminOBFx0agUE/gRABJ4I4NT6CZAECAQKBJAgBCwc?=
 =?us-ascii?q?BAw87HAIFgkKCXgSNVwYIIByIWR1JDTl9h0WPOYJGg3GBE4EogSaFTYQahSc?=
 =?us-ascii?q?igkmBAIchhBQSJ4t9kEKVYhwGg3wCCgcGDyOBRk0aI3ErCAIYCCEPO4JsCUc?=
 =?us-ascii?q?YDVeNTwIBF4hkgT2EJSAzAgWMOwIPFQKCGwEB?=
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="log'?scan'208";a="97165464"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by fe4.lbl.gov with ESMTP; 05 Mar 2020 09:01:59 -0800
Received: by mail-pf1-f200.google.com with SMTP id i127so4060574pfb.9
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 09:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=b6li4JGoDL3x6EoSJNDD8leUX3BAojTCpG07UAKOxRQ=;
        b=cFlVW3UpdaRFF8fDqLOURtGmKjsYGIjm89aTFqFk+1St///Kbch0Dlm994cNQpQcPC
         LNddYv4MDdvWsETENSG27TwMAuYm7h40j7OI3L5f+2P4zvqTkFLJMpsOkmXgdpzOF6wc
         ip0yIUdO2Mzr8nRaQhS145qWL281ip47ioEDvGFGBiEHdfOJ2fMkhZyXL2daNm5E2c6T
         p9VgnKmYnD8TWRxGiVjQqcgy+ymqjtbYJex2medK+jofSe/onjglNNvvY7wXKD44EbCD
         iKRWDF9iCEbqghR/BZf+9Krb5xaWWPIjtqHEl3AUtsspsI2Mx0C/U5CvePVhvHhmozmP
         TY4A==
X-Gm-Message-State: ANhLgQ1Fs7f5WeTrqozQqE21YXOa5QAGl9QdK3jXX6dMs0bIWBO2Mwip
        SX6s3Gzk5o93/WzRt83JQPacgixAN7ElwanRgdWtXROfJmUmVyWcLTLb8m32o/ZnE0Oh6+YQ9wC
        L35YcCZQtMD+v3QsalHpgqDNm5g==
X-Received: by 2002:a17:902:bf4b:: with SMTP id u11mr9317100pls.324.1583427717935;
        Thu, 05 Mar 2020 09:01:57 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuQXXLDNVhwb8C3xZNgRyiFdj8nbHbAs6TMiFChKNx3aAxCuaXEKJBCTi6DagjimgersSd4Rw==
X-Received: by 2002:a17:902:bf4b:: with SMTP id u11mr9317054pls.324.1583427717349;
        Thu, 05 Mar 2020 09:01:57 -0800 (PST)
Received: from [128.3.131.12] (apersaud.dhcp.lbl.gov. [128.3.131.12])
        by smtp.gmail.com with ESMTPSA id l1sm6822587pjb.15.2020.03.05.09.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:01:56 -0800 (PST)
Subject: Re: problem with newer kernels
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
References: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
 <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
From:   Arun Persaud <apersaud@lbl.gov>
Autocrypt: addr=apersaud@lbl.gov; prefer-encrypt=mutual; keydata=
 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
Message-ID: <aa4ba5af-1d0f-9db2-8cad-693b970bf843@lbl.gov>
Date:   Thu, 5 Mar 2020 09:01:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------0BA12F5258A584B07869EA43"
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------0BA12F5258A584B07869EA43
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi

>> I use btrfs for a partition (/dev/sda2) and when I try to boot with a
>> newer kernel (on openSUSE tumbleweed), the system doesn't finish the
>> boot and goes into an emergency console and I get the following error
>> (don't have a log at the moment, but can produce one if needed):
>>
>> BTRFS critical, corrupt leaf...
> 
> Complete dmesg is needed, thanks.

dmesg is attached

>> However, if I boot with an older kernel (5.1.10), everything works OK.
> 
> Sounds like it's hitting the tree checker which is much more
> sophisticated in kernel 5.5 than 5.1, so the problem is still there
> it's just that 5.1 doesn't complain. What is the kernel history of the
> file system? Was kernel 5.2.0 through 5.2.14 used?

I'm pretty sure I tried all those kernels, but I don't have a history of
it (the problematic partition is used for /var, so no record via
journalctl).

Here are some more information about the system that doesn't boot:

uname -a

Linux ndcxii 5.5.6-1-default #1 SMP Mon Feb 24 09:02:31 UTC 2020
(4a830b1) x86_64 x86_64 x86_64 GNU/Linux

btrfs-progs v5.4.1

>> this was with btrfs-progs 5.4.1
>>
>> both didn't find any error or repaired anything, so they suggested to
>> email the list.
> 
> That's unexpected. What about:
> 
> btrfs check --mode=lowmem /dev/

This showed some errors:

[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 5 EXTENT_DATA[394462 0] csum missing, have: 0, expected: 4096
ERROR: root 5 INODE[394462] nbytes 0 not equal to extent_size 4096
ERROR: root 5 EXTENT_DATA[785218 8192] csum missing, have: 0, expected: 4096
ERROR: root 5 EXTENT_DATA[785218 24576] csum missing, have: 0, expected:
4096
ERROR: root 5 EXTENT_DATA[785218 32768] csum missing, have: 0, expected:
98304
ERROR: root 5 EXTENT_DATA[785218 147456] csum missing, have: 0,
expected: 143360
ERROR: root 5 INODE[785218] nbytes 49152 not equal to extent_size 299008
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sda2
UUID: e7b29c18-4707-48a4-8c29-dd4dd70378b8
found 17940045824 bytes used, error(s) found
total csum bytes: 10656228
total tree bytes: 145596416
total fs tree bytes: 90025984
total extent tree bytes: 35987456
btree space waste bytes: 33201183
file data blocks allocated: 28054265856
 referenced 14007422976

For the working system:

uname -a
Linux ndcxii 5.1.10-1-default #1 SMP Mon Jun 17 14:44:35 UTC 2019
(ad24342) x86_64 x86_64 x86_64 GNU/Linux

btrfs-progs v5.4.1


Let me know if I can provide anything else

Arun

--------------0BA12F5258A584B07869EA43
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] microcode: microcode updated early to revision 0xa, date = 2018-05-08
[    0.000000] Linux version 5.5.6-1-default (geeko@buildhost) (gcc version 9.2.1 20200128 [revision 83f65674e78d97d27537361de1a9d74067ff228d] (SUSE Linux)) #1 SMP Mon Feb 24 09:02:31 UTC 2020 (4a830b1)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.5.6-1-default root=UUID=b914656e-7537-465b-a2ba-d08c6eea908a rd.convertfs rd.convertfs rd.convertfs
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e3ff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000db6cfbff] usable
[    0.000000] BIOS-e820: [mem 0x00000000db6cfc00-0x00000000db723bff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db723c00-0x00000000db725bff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000db725c00-0x00000000dbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fed003ff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed9ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Dell Inc. OptiPlex 980                 /0D441T, BIOS A17 05/10/2017
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2792.715 MHz processor
[    0.002744] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.002746] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.002750] last_pfn = 0x420000 max_arch_pfn = 0x400000000
[    0.002754] MTRR default type: write-back
[    0.002755] MTRR fixed ranges enabled:
[    0.002756]   00000-9FFFF write-back
[    0.002757]   A0000-BFFFF uncachable
[    0.002758]   C0000-D7FFF write-protect
[    0.002758]   D8000-EFFFF uncachable
[    0.002759]   F0000-FFFFF write-protect
[    0.002760] MTRR variable ranges enabled:
[    0.002761]   0 base 0DF800000 mask FFF800000 uncachable
[    0.002762]   1 base 0E0000000 mask FE0000000 uncachable
[    0.002762]   2 disabled
[    0.002763]   3 disabled
[    0.002763]   4 disabled
[    0.002764]   5 disabled
[    0.002764]   6 disabled
[    0.002765]   7 disabled
[    0.003422] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.003706] last_pfn = 0xdb6cf max_arch_pfn = 0x400000000
[    0.016427] found SMP MP-table at [mem 0x000fe710-0x000fe71f]
[    0.026863] check: Scanning 1 areas for low memory corruption
[    0.026869] BRK [0x25b401000, 0x25b401fff] PGTABLE
[    0.026871] BRK [0x25b402000, 0x25b402fff] PGTABLE
[    0.026872] BRK [0x25b403000, 0x25b403fff] PGTABLE
[    0.026907] BRK [0x25b404000, 0x25b404fff] PGTABLE
[    0.026908] BRK [0x25b405000, 0x25b405fff] PGTABLE
[    0.027014] BRK [0x25b406000, 0x25b406fff] PGTABLE
[    0.027028] BRK [0x25b407000, 0x25b407fff] PGTABLE
[    0.027042] BRK [0x25b408000, 0x25b408fff] PGTABLE
[    0.027078] BRK [0x25b409000, 0x25b409fff] PGTABLE
[    0.027308] RAMDISK: [mem 0x36037000-0x37012fff]
[    0.027315] ACPI: Early table checksum verification disabled
[    0.027318] ACPI: RSDP 0x00000000000FEC00 000024 (v02 DELL  )
[    0.027322] ACPI: XSDT 0x00000000000FC7E0 000074 (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027328] ACPI: FACP 0x00000000000FC8D0 0000F4 (v03 DELL   B11K     00000015 ASL  00000061)
[    0.027333] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gpe0Block: 128/64 (20191018/tbfadt-564)
[    0.027401] ACPI: DSDT 0x00000000FFDCBEE7 0047BC (v01 DELL   dt_ex    00001000 INTL 20050624)
[    0.027409] ACPI: FACS 0x00000000DB6CFC00 000040
[    0.027413] ACPI: FACS 0x00000000DB6CFC00 000040
[    0.027479] ACPI: SSDT 0x00000000FFDD0870 000088 (v01 DELL   st_ex    00001000 INTL 20050624)
[    0.027483] ACPI: APIC 0x00000000000FC9C4 000092 (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027487] ACPI: BOOT 0x00000000000FCA56 000028 (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027490] ACPI: ASF! 0x00000000000FCA7E 000096 (v32 DELL   B11K     00000015 ASL  00000061)
[    0.027494] ACPI: MCFG 0x00000000000FCB14 00003C (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027498] ACPI: HPET 0x00000000000FCB50 000038 (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027501] ACPI: TCPA 0x00000000000FCDAC 000032 (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027505] ACPI: DMAR 0x00000000000FCDDE 000068 (v01 DELL   B11K     00000015 ASL  00000061)
[    0.027509] ACPI: SSDT 0x00000000DB725C00 002094 (v01 INTEL  PPM RCM  80000001 INTL 20061109)
[    0.027681] ACPI: Local APIC address 0xfee00000
[    0.027777] No NUMA configuration found
[    0.027779] Faking a node at [mem 0x0000000000000000-0x000000041fffffff]
[    0.027784] NODE_DATA(0) allocated [mem 0x41ffde000-0x41fff3fff]
[    0.027834] Zone ranges:
[    0.027835]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.027837]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.027838]   Normal   [mem 0x0000000100000000-0x000000041fffffff]
[    0.027839]   Device   empty
[    0.027840] Movable zone start for each node
[    0.027842] Early memory node ranges
[    0.027843]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.027844]   node   0: [mem 0x0000000000100000-0x00000000db6cefff]
[    0.027846]   node   0: [mem 0x0000000100000000-0x000000041fffffff]
[    0.028113] Zeroed struct page in unavailable ranges: 18836 pages
[    0.028114] Initmem setup node 0 [mem 0x0000000000001000-0x000000041fffffff]
[    0.028116] On node 0 totalpages: 4175468
[    0.028117]   DMA zone: 64 pages used for memmap
[    0.028117]   DMA zone: 21 pages reserved
[    0.028118]   DMA zone: 3997 pages, LIFO batch:0
[    0.028208]   DMA32 zone: 13980 pages used for memmap
[    0.028209]   DMA32 zone: 894671 pages, LIFO batch:63
[    0.049230]   Normal zone: 51200 pages used for memmap
[    0.049232]   Normal zone: 3276800 pages, LIFO batch:63
[    0.050075] ACPI: PM-Timer IO Port: 0x808
[    0.050078] ACPI: Local APIC address 0xfee00000
[    0.050085] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.050096] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.050099] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.050100] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.050102] ACPI: IRQ0 used by override.
[    0.050103] ACPI: IRQ9 used by override.
[    0.050105] Using ACPI (MADT) for SMP configuration information
[    0.050107] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.050111] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.050125] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.050127] PM: Registered nosave memory: [mem 0x0009e000-0x000effff]
[    0.050127] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.050129] PM: Registered nosave memory: [mem 0xdb6cf000-0xdb6cffff]
[    0.050130] PM: Registered nosave memory: [mem 0xdb6d0000-0xdb722fff]
[    0.050131] PM: Registered nosave memory: [mem 0xdb723000-0xdb723fff]
[    0.050132] PM: Registered nosave memory: [mem 0xdb724000-0xdb724fff]
[    0.050132] PM: Registered nosave memory: [mem 0xdb725000-0xdb725fff]
[    0.050133] PM: Registered nosave memory: [mem 0xdb726000-0xdbffffff]
[    0.050134] PM: Registered nosave memory: [mem 0xdc000000-0xf7ffffff]
[    0.050135] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.050136] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.050137] PM: Registered nosave memory: [mem 0xfec00000-0xfecfffff]
[    0.050137] PM: Registered nosave memory: [mem 0xfed00000-0xfed1ffff]
[    0.050138] PM: Registered nosave memory: [mem 0xfed20000-0xfed9ffff]
[    0.050139] PM: Registered nosave memory: [mem 0xfeda0000-0xfedfffff]
[    0.050140] PM: Registered nosave memory: [mem 0xfee00000-0xfeefffff]
[    0.050141] PM: Registered nosave memory: [mem 0xfef00000-0xffafffff]
[    0.050141] PM: Registered nosave memory: [mem 0xffb00000-0xffffffff]
[    0.050144] [mem 0xdc000000-0xf7ffffff] available for PCI devices
[    0.050145] Booting paravirtualized kernel on bare hardware
[    0.050148] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.237962] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8 nr_node_ids:1
[    0.238259] percpu: Embedded 59 pages/cpu s204800 r8192 d28672 u262144
[    0.238266] pcpu-alloc: s204800 r8192 d28672 u262144 alloc=1*2097152
[    0.238266] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
[    0.238287] Built 1 zonelists, mobility grouping on.  Total pages: 4110203
[    0.238288] Policy zone: Normal
[    0.238290] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.5.6-1-default root=UUID=b914656e-7537-465b-a2ba-d08c6eea908a rd.convertfs rd.convertfs rd.convertfs
[    0.238378] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.238379] printk: log_buf_len total cpu_extra contributions: 229376 bytes
[    0.238380] printk: log_buf_len min size: 262144 bytes
[    0.238484] printk: log_buf_len: 524288 bytes
[    0.238485] printk: early log buf free: 252568(96%)
[    0.239883] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.240583] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.240698] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.266006] Memory: 3643884K/16701872K available (12291K kernel code, 1503K rwdata, 4448K rodata, 2148K init, 12848K bss, 412584K reserved, 0K cma-reserved)
[    0.266014] random: get_random_u64 called from kmem_cache_open+0x26/0x3e0 with crng_init=0
[    0.266167] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.266181] Kernel/User page tables isolation: enabled
[    0.266198] ftrace: allocating 39803 entries in 156 pages
[    0.281833] ftrace: allocated 156 pages with 4 groups
[    0.281937] rcu: Hierarchical RCU implementation.
[    0.281938] rcu: 	RCU event tracing is enabled.
[    0.281939] rcu: 	RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=8.
[    0.281940] 	Tasks RCU enabled.
[    0.281941] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.281942] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.285361] NR_IRQS: 33024, nr_irqs: 488, preallocated irqs: 16
[    0.285694] Console: colour dummy device 80x25
[    0.285873] printk: console [tty0] enabled
[    0.285890] ACPI: Core revision 20191018
[    0.364203] ACPI BIOS Warning (bug): Incorrect checksum in table [TCPA] - 0x00, should be 0x7E (20191018/tbprint-173)
[    0.364250] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.364264] APIC: Switch to symmetric I/O mode setup
[    0.364267] DMAR: Host address width 36
[    0.364269] DMAR: DRHD base: 0x000000fedc0000 flags: 0x1
[    0.364275] DMAR: dmar0: reg_base_addr fedc0000 ver 1:0 cap c90780106f0462 ecap f020e2
[    0.364278] DMAR: RMRR base: 0x000000db730000 end: 0x000000db76ffff
[    0.364768] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.384267] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x28415ed3947, max_idle_ns: 440795236291 ns
[    0.384272] Calibrating delay loop (skipped), value calculated using timer frequency.. 5585.43 BogoMIPS (lpj=11170860)
[    0.384276] pid_max: default: 32768 minimum: 301
[    0.384310] LSM: Security Framework initializing
[    0.384334] AppArmor: AppArmor initialized
[    0.384408] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.384449] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.384687] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.384697] process: using mwait in idle threads
[    0.384701] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.384703] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.384706] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.384710] Spectre V2 : Mitigation: Full generic retpoline
[    0.384712] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.384714] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.384717] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.384719] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.384722] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.384727] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    0.384917] Freeing SMP alternatives memory: 36K
[    0.494663] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         860  @ 2.80GHz (family: 0x6, model: 0x1e, stepping: 0x5)
[    0.494764] Performance Events: PEBS fmt1+, Nehalem events, 16-deep LBR, Intel PMU driver.
[    0.494771] core: CPU erratum AAJ80 worked around
[    0.494773] core: CPUID marked event: 'bus cycles' unavailable
[    0.494776] ... version:                3
[    0.494777] ... bit width:              48
[    0.494779] ... generic registers:      4
[    0.494781] ... value mask:             0000ffffffffffff
[    0.494783] ... max period:             000000007fffffff
[    0.494784] ... fixed-purpose events:   3
[    0.494786] ... event mask:             000000070000000f
[    0.494824] rcu: Hierarchical SRCU implementation.
[    0.495572] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.495648] smp: Bringing up secondary CPUs ...
[    0.495741] x86: Booting SMP configuration:
[    0.495744] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.504346] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.504420]  #5 #6 #7
[    0.510676] smp: Brought up 1 node, 8 CPUs
[    0.510676] smpboot: Max logical packages: 1
[    0.510676] smpboot: Total of 8 processors activated (44683.44 BogoMIPS)
[    0.564284] node 0 initialised, 3161351 pages in 52ms
[    0.564717] devtmpfs: initialized
[    0.564717] x86/mm: Memory block size: 128MB
[    0.568842] PM: Registering ACPI NVS region [mem 0xdb6cfc00-0xdb723bff] (344064 bytes)
[    0.568842] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.568842] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.568842] pinctrl core: initialized pinctrl subsystem
[    0.568842] PM: RTC time: 16:48:06, date: 2020-03-05
[    0.568842] thermal_sys: Registered thermal governor 'fair_share'
[    0.568842] thermal_sys: Registered thermal governor 'bang_bang'
[    0.568842] thermal_sys: Registered thermal governor 'step_wise'
[    0.568842] thermal_sys: Registered thermal governor 'user_space'
[    0.568842] NET: Registered protocol family 16
[    0.568842] audit: initializing netlink subsys (disabled)
[    0.568842] audit: type=2000 audit(1583426885.204:1): state=initialized audit_enabled=0 res=1
[    0.568842] cpuidle: using governor ladder
[    0.568842] cpuidle: using governor menu
[    0.568842] Simple Boot Flag at 0x7a set to 0x80
[    0.568842] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.568842] ACPI: bus type PCI registered
[    0.568842] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.568842] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.568842] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.568842] PCI: Using configuration type 1 for base access
[    0.570257] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.572330] ACPI: Added _OSI(Module Device)
[    0.572333] ACPI: Added _OSI(Processor Device)
[    0.572335] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.572337] ACPI: Added _OSI(Processor Aggregator Device)
[    0.572340] ACPI: Added _OSI(Linux-Dell-Video)
[    0.572342] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.572344] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.633906] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.637716] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.641387] ACPI: Interpreter enabled
[    0.641406] ACPI: (supports S0 S1 S4 S5)
[    0.641409] ACPI: Using IOAPIC for interrupt routing
[    0.641521] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.641724] ACPI: Enabled 9 GPEs in block 00 to 3F
[    0.718320] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.718329] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.718344] acpi PNP0A03:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.724489] PCI host bridge to bus 0000:00
[    0.724494] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.724497] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.724499] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.724502] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000effff window]
[    0.724505] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    0.724509] pci_bus 0000:00: root bus resource [mem 0xdb800000-0xf7ffffff window]
[    0.724512] pci_bus 0000:00: root bus resource [mem 0xff87c000-0xff87ffff window]
[    0.724515] pci_bus 0000:00: root bus resource [mem 0xff870000-0xff8707ff window]
[    0.724518] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xfed9ffff window]
[    0.724521] pci_bus 0000:00: root bus resource [mem 0xfeda6000-0xfeda6fff window]
[    0.724524] pci_bus 0000:00: root bus resource [mem 0xfeda7000-0xfeda7fff window]
[    0.724527] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.724538] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.724873] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.724904] pci 0000:00:03.0: enabling Extended Tags
[    0.724940] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.725241] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.725567] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.725889] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.726216] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.726519] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.726842] pci 0000:00:16.0: [8086:3b64] type 00 class 0x078000
[    0.726874] pci 0000:00:16.0: reg 0x10: [mem 0xfeda6000-0xfeda600f 64bit]
[    0.726964] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.727261] pci 0000:00:16.2: [8086:3b66] type 00 class 0x010185
[    0.727284] pci 0000:00:16.2: reg 0x10: [io  0xfe80-0xfe87]
[    0.727294] pci 0000:00:16.2: reg 0x14: [io  0xfe90-0xfe93]
[    0.727306] pci 0000:00:16.2: reg 0x18: [io  0xfea0-0xfea7]
[    0.727316] pci 0000:00:16.2: reg 0x1c: [io  0xfeb0-0xfeb3]
[    0.727326] pci 0000:00:16.2: reg 0x20: [io  0xfef0-0xfeff]
[    0.727668] pci 0000:00:16.3: [8086:3b67] type 00 class 0x070002
[    0.727690] pci 0000:00:16.3: reg 0x10: [io  0xec98-0xec9f]
[    0.727701] pci 0000:00:16.3: reg 0x14: [mem 0xf7fdb000-0xf7fdbfff]
[    0.728065] pci 0000:00:19.0: [8086:10ef] type 00 class 0x020000
[    0.728084] pci 0000:00:19.0: reg 0x10: [mem 0xf7fe0000-0xf7ffffff]
[    0.728093] pci 0000:00:19.0: reg 0x14: [mem 0xf7fdc000-0xf7fdcfff]
[    0.728101] pci 0000:00:19.0: reg 0x18: [io  0xecc0-0xecdf]
[    0.728157] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.728454] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.728476] pci 0000:00:1a.0: reg 0x10: [mem 0xf7fdd000-0xf7fdd3ff]
[    0.728556] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.728867] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.728889] pci 0000:00:1b.0: reg 0x10: [mem 0xff87c000-0xff87ffff 64bit]
[    0.728959] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.729255] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.729334] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.729653] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.729731] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.730049] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.730071] pci 0000:00:1d.0: reg 0x10: [mem 0xf7fde000-0xf7fde3ff]
[    0.730151] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.730456] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.730812] pci 0000:00:1f.0: [8086:3b0a] type 00 class 0x060100
[    0.731211] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.731230] pci 0000:00:1f.2: reg 0x10: [io  0xfe00-0xfe07]
[    0.731238] pci 0000:00:1f.2: reg 0x14: [io  0xfe10-0xfe13]
[    0.731246] pci 0000:00:1f.2: reg 0x18: [io  0xfe20-0xfe27]
[    0.731254] pci 0000:00:1f.2: reg 0x1c: [io  0xfe30-0xfe33]
[    0.731261] pci 0000:00:1f.2: reg 0x20: [io  0xfec0-0xfedf]
[    0.731270] pci 0000:00:1f.2: reg 0x24: [mem 0xff870000-0xff8707ff]
[    0.731309] pci 0000:00:1f.2: PME# supported from D3hot
[    0.731597] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.731616] pci 0000:00:1f.3: reg 0x10: [mem 0xf7fdf000-0xf7fdf0ff 64bit]
[    0.731635] pci 0000:00:1f.3: reg 0x20: [io  0xece0-0xecff]
[    0.731963] pci 0000:01:00.0: [1002:95c5] type 00 class 0x030000
[    0.731984] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
[    0.731994] pci 0000:01:00.0: reg 0x18: [mem 0xf7df0000-0xf7dfffff 64bit]
[    0.732002] pci 0000:01:00.0: reg 0x20: [io  0xdc00-0xdcff]
[    0.732015] pci 0000:01:00.0: reg 0x30: [mem 0xf7e00000-0xf7e1ffff pref]
[    0.732021] pci 0000:01:00.0: enabling Extended Tags
[    0.732056] pci 0000:01:00.0: supports D1 D2
[    0.732113] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.732117] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    0.732120] pci 0000:00:03.0:   bridge window [mem 0xf7d00000-0xf7efffff]
[    0.732125] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.732163] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.732207] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.732230] pci_bus 0000:04: extended config space not accessible
[    0.732282] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive decode)
[    0.732292] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 window] (subtractive decode)
[    0.732295] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    0.732298] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    0.732302] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000effff window] (subtractive decode)
[    0.732305] pci 0000:00:1e.0:   bridge window [mem 0x000f0000-0x000fffff window] (subtractive decode)
[    0.732308] pci 0000:00:1e.0:   bridge window [mem 0xdb800000-0xf7ffffff window] (subtractive decode)
[    0.732312] pci 0000:00:1e.0:   bridge window [mem 0xff87c000-0xff87ffff window] (subtractive decode)
[    0.732315] pci 0000:00:1e.0:   bridge window [mem 0xff870000-0xff8707ff window] (subtractive decode)
[    0.732318] pci 0000:00:1e.0:   bridge window [mem 0xfed20000-0xfed9ffff window] (subtractive decode)
[    0.732322] pci 0000:00:1e.0:   bridge window [mem 0xfeda6000-0xfeda6fff window] (subtractive decode)
[    0.732325] pci 0000:00:1e.0:   bridge window [mem 0xfeda7000-0xfeda7fff window] (subtractive decode)
[    0.745419] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[    0.746330] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    0.747239] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[    0.748164] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    0.749113] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    0.750019] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
[    0.750950] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[    0.751856] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 12 15)
[    0.752382] iommu: Default domain type: Passthrough 
[    0.752382] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.752382] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.752382] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.752382] vgaarb: loaded
[    0.752382] SCSI subsystem initialized
[    0.752390] libata version 3.00 loaded.
[    0.752390] pps_core: LinuxPPS API ver. 1 registered
[    0.752390] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.752390] PTP clock support registered
[    0.752390] EDAC MC: Ver: 3.0.0
[    0.752390] PCI: Using ACPI for IRQ routing
[    0.753617] PCI: Discovered peer bus 3f
[    0.753619] PCI: root bus 3f: using default resources
[    0.753620] PCI: Probing PCI hardware (bus 3f)
[    0.753637] PCI host bridge to bus 0000:3f
[    0.753640] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.753643] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffffffff]
[    0.753646] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    0.753650] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.753656] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.753696] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.753735] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.753771] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.753808] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.753847] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.753884] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.753921] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.753956] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.753992] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.754029] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.754065] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.754101] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.754138] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.754173] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.754219] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    0.754223] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.754230] PCI: pci_cache_line_size set to 64 bytes
[    0.754281] Expanded resource Reserved due to conflict with PCI Bus 0000:00
[    0.754284] e820: reserve RAM buffer [mem 0x0009e400-0x0009ffff]
[    0.754285] e820: reserve RAM buffer [mem 0xdb6cfc00-0xdbffffff]
[    0.754378] NetLabel: Initializing
[    0.754380] NetLabel:  domain hash size = 128
[    0.754382] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.754399] NetLabel:  unlabeled traffic allowed by default
[    0.756355] hpet: 8 channels of 5 reserved for per-cpu timers
[    0.756359] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 24, 25, 26, 27, 28
[    0.756364] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.756364] clocksource: Switched to clocksource tsc-early
[    0.768813] VFS: Disk quotas dquot_6.6.0
[    0.768834] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.768929] AppArmor: AppArmor Filesystem Enabled
[    0.768947] pnp: PnP ACPI init
[    0.771430] system 00:00: [io  0x0800-0x085f] has been reserved
[    0.771434] system 00:00: [io  0x0c00-0x0c7f] has been reserved
[    0.771437] system 00:00: [io  0x0860-0x08ff] has been reserved
[    0.771444] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.771676] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.778321] pnp 00:02: [dma 0 disabled]
[    0.778382] pnp 00:02: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.782934] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.792284] pnp: PnP ACPI: found 4 devices
[    0.797917] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.797957] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
[    0.797961] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.797967] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff] to [bus 02] add_size 200000 add_align 100000
[    0.797971] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.797975] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.797979] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff] to [bus 03] add_size 200000 add_align 100000
[    0.797989] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdc000000-0xdc1fffff]
[    0.797996] pci 0000:00:1c.0: BAR 15: assigned [mem 0xdc200000-0xdc3fffff 64bit pref]
[    0.798000] pci 0000:00:1c.4: BAR 14: assigned [mem 0xdc400000-0xdc5fffff]
[    0.798005] pci 0000:00:1c.4: BAR 15: assigned [mem 0xdc600000-0xdc7fffff 64bit pref]
[    0.798009] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.798012] pci 0000:00:1c.4: BAR 13: assigned [io  0x2000-0x2fff]
[    0.798016] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.798020] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    0.798024] pci 0000:00:03.0:   bridge window [mem 0xf7d00000-0xf7efffff]
[    0.798028] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffffff 64bit pref]
[    0.798034] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.798037] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.798042] pci 0000:00:1c.0:   bridge window [mem 0xdc000000-0xdc1fffff]
[    0.798046] pci 0000:00:1c.0:   bridge window [mem 0xdc200000-0xdc3fffff 64bit pref]
[    0.798052] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.798055] pci 0000:00:1c.4:   bridge window [io  0x2000-0x2fff]
[    0.798060] pci 0000:00:1c.4:   bridge window [mem 0xdc400000-0xdc5fffff]
[    0.798064] pci 0000:00:1c.4:   bridge window [mem 0xdc600000-0xdc7fffff 64bit pref]
[    0.798071] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.798081] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.798083] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.798086] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.798089] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000effff window]
[    0.798091] pci_bus 0000:00: resource 8 [mem 0x000f0000-0x000fffff window]
[    0.798094] pci_bus 0000:00: resource 9 [mem 0xdb800000-0xf7ffffff window]
[    0.798097] pci_bus 0000:00: resource 10 [mem 0xff87c000-0xff87ffff window]
[    0.798100] pci_bus 0000:00: resource 11 [mem 0xff870000-0xff8707ff window]
[    0.798102] pci_bus 0000:00: resource 12 [mem 0xfed20000-0xfed9ffff window]
[    0.798105] pci_bus 0000:00: resource 13 [mem 0xfeda6000-0xfeda6fff window]
[    0.798108] pci_bus 0000:00: resource 14 [mem 0xfeda7000-0xfeda7fff window]
[    0.798110] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.798113] pci_bus 0000:01: resource 1 [mem 0xf7d00000-0xf7efffff]
[    0.798115] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 64bit pref]
[    0.798119] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    0.798121] pci_bus 0000:02: resource 1 [mem 0xdc000000-0xdc1fffff]
[    0.798124] pci_bus 0000:02: resource 2 [mem 0xdc200000-0xdc3fffff 64bit pref]
[    0.798127] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.798129] pci_bus 0000:03: resource 1 [mem 0xdc400000-0xdc5fffff]
[    0.798132] pci_bus 0000:03: resource 2 [mem 0xdc600000-0xdc7fffff 64bit pref]
[    0.798135] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
[    0.798137] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
[    0.798140] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.798143] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000effff window]
[    0.798145] pci_bus 0000:04: resource 8 [mem 0x000f0000-0x000fffff window]
[    0.798148] pci_bus 0000:04: resource 9 [mem 0xdb800000-0xf7ffffff window]
[    0.798151] pci_bus 0000:04: resource 10 [mem 0xff87c000-0xff87ffff window]
[    0.798153] pci_bus 0000:04: resource 11 [mem 0xff870000-0xff8707ff window]
[    0.798156] pci_bus 0000:04: resource 12 [mem 0xfed20000-0xfed9ffff window]
[    0.798159] pci_bus 0000:04: resource 13 [mem 0xfeda6000-0xfeda6fff window]
[    0.798161] pci_bus 0000:04: resource 14 [mem 0xfeda7000-0xfeda7fff window]
[    0.798201] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.798204] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.798242] NET: Registered protocol family 2
[    0.798372] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.798426] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.798706] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.798963] TCP: Hash tables configured (established 131072 bind 65536)
[    0.798997] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.799093] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.799248] NET: Registered protocol family 1
[    0.799255] NET: Registered protocol family 44
[    0.801024] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.801049] PCI: CLS 64 bytes, default 64
[    0.801086] Trying to unpack rootfs image as initramfs...
[    1.012280] random: fast init done
[    2.179018] Freeing initrd memory: 16240K
[    2.204304] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.204314] software IO TLB: mapped [mem 0xd76cf000-0xdb6cf000] (64MB)
[    2.204625] check: Scanning for low memory corruption every 60 seconds
[    2.204977] Initialise system trusted keyrings
[    2.204987] Key type blacklist registered
[    2.205025] workingset: timestamp_bits=37 max_order=22 bucket_order=0
[    2.206299] zbud: loaded
[    2.206692] Platform Keyring initialized
[    2.212591] Key type asymmetric registered
[    2.212594] Asymmetric key parser 'x509' registered
[    2.212604] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    2.212653] io scheduler mq-deadline registered
[    2.212657] io scheduler kyber registered
[    2.212689] io scheduler bfq registered
[    2.214343] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    2.214368] vesafb: mode is 1400x1050x32, linelength=5632, pages=0
[    2.214371] vesafb: scrolling: redraw
[    2.214373] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    2.214389] vesafb: framebuffer at 0xe0000000, mapped to 0x(____ptrval____), using 5824k, total 5824k
[    2.401221] Console: switching to colour frame buffer device 175x65
[    2.588284] fb0: VESA VGA frame buffer device
[    2.588299] intel_idle: MWAIT substates: 0x1120
[    2.588299] intel_idle: v0.4.1 model 0x1E
[    2.589254] intel_idle: lapic_timer_reliable_states 0x2
[    2.589769] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.611448] 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    2.637297] 0000:00:16.3: ttyS4 at I/O 0xec98 (irq = 17, base_baud = 115200) is a 16550A
[    2.639332] Non-volatile memory driver v1.3
[    2.640194] Linux agpgart interface v0.103
[    2.642681] ahci 0000:00:1f.2: version 3.0
[    2.653293] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps 0x17 impl SATA mode
[    2.654830] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp fbs pio ems sxs apst 
[    2.656384] ahci 0000:00:1f.2: port 0 is not capable of FBS
[    2.657436] ahci 0000:00:1f.2: port 1 is not capable of FBS
[    2.658477] ahci 0000:00:1f.2: port 2 is not capable of FBS
[    2.681287] scsi host0: ahci
[    2.682293] scsi host1: ahci
[    2.683209] scsi host2: ahci
[    2.683972] scsi host3: ahci
[    2.684796] scsi host4: ahci
[    2.685920] scsi host5: ahci
[    2.686525] ata1: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870100 irq 32
[    2.687901] ata2: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870180 irq 32
[    2.689287] ata3: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870200 irq 32
[    2.690647] ata4: DUMMY
[    2.691097] ata5: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870300 irq 32
[    2.692460] ata6: DUMMY
[    2.692953] i8042: PNP: No PS/2 controller found.
[    2.693849] i8042: Probing ports directly.
[    2.697506] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.698433] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.699632] mousedev: PS/2 mouse device common for all mice
[    2.700738] rtc_cmos 00:01: RTC can wake from S4
[    2.701991] rtc_cmos 00:01: registered as rtc0
[    2.702840] rtc_cmos 00:01: alarms up to one day, 242 bytes nvram, hpet irqs
[    2.704142] intel_pstate: CPU model not supported
[    2.705961] ledtrig-cpu: registered to indicate activity on CPUs
[    2.707113] hid: raw HID events driver (C) Jiri Kosina
[    2.708104] drop_monitor: Initializing network drop monitor service
[    2.709419] NET: Registered protocol family 10
[    2.726273] Segment Routing with IPv6
[    2.728630] RAS: Correctable Errors collector initialized.
[    2.729683] microcode: sig=0x106e5, pf=0x2, revision=0xa
[    2.730879] microcode: Microcode Update Driver: v2.2.
[    2.730881] IPI shorthand broadcast: enabled
[    2.824479] sched_clock: Marking stable (2745817968, 78625708)->(2834619174, -10175498)
[    2.872775] registered taskstats version 1
[    2.920151] Loading compiled-in X.509 certificates
[    2.967670] Loaded X.509 cert 'openSUSE Secure Boot Signkey: 0332fa9cbf0d88bf21924b0de82a09a54d5defc8'
[    3.008477] ata5: SATA link down (SStatus 0 SControl 300)
[    3.016385] zswap: loaded using pool lzo/zbud
[    3.065458] page_owner is disabled
[    3.162694] Key type ._fscrypt registered
[    3.208392] tsc: Refined TSC clocksource calibration: 2792.982 MHz
[    3.210243] Key type .fscrypt registered
[    3.258806] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x28425adda3a, max_idle_ns: 440795215496 ns
[    3.358858] clocksource: Switched to clocksource tsc
[    3.358866] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.373475] Key type big_key registered
[    3.380512] Key type encrypted registered
[    3.380514] AppArmor: AppArmor sha1 policy hashing enabled
[    3.380524] ima: No TPM chip found, activating TPM-bypass!
[    3.380529] ima: Allocated hash algorithm: sha256
[    3.380536] ima: No architecture policies found
[    3.380543] evm: Initialising EVM extended attributes:
[    3.380544] evm: security.selinux
[    3.380544] evm: security.apparmor
[    3.380545] evm: security.ima
[    3.380545] evm: security.capability
[    3.380546] evm: HMAC attrs: 0x1
[    3.380871] PM:   Magic number: 12:839:842
[    3.409255] rtc_cmos 00:01: setting system clock to 2020-03-05T16:48:08 UTC (1583426888)
[    4.137365] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.183499] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.229345] ata1.00: ATAPI: TSSTcorp DVD+/-RW TS-H653G, DW10, max UDMA/100
[    4.275213] ata1.00: applying bridge limits
[    4.320186] ata2.00: LPM support broken, forcing max_power
[    4.365606] ata2.00: supports DRM functions and may not be fully accessible
[    4.412130] ata3.00: ATA-8: WDC WD5000AAKX-00ERMA0, 15.01H15, max UDMA/133
[    4.459555] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32), AA
[    4.507194] ata1.00: configured for UDMA/100
[    4.555042] ata2.00: READ LOG DMA EXT failed, trying PIO
[    4.604229] ata3.00: configured for UDMA/133
[    4.653925] scsi 0:0:0:0: CD-ROM            TSSTcorp DVD+-RW TS-H653G DW10 PQ: 0 ANSI: 5
[    4.656319] ata2.00: disabling queued TRIM support
[    4.704438] ata2.00: ATA-9: Crucial_CT480M500SSD1, MU03, max UDMA/133
[    4.755440] ata2.00: 937703088 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    4.820146] ata2.00: LPM support broken, forcing max_power
[    4.871711] ata2.00: supports DRM functions and may not be fully accessible
[    4.930501] ata2.00: disabling queued TRIM support
[    4.943816] ata2.00: configured for UDMA/133
[    4.996048] scsi 1:0:0:0: Direct-Access     ATA      Crucial_CT480M50 MU03 PQ: 0 ANSI: 5
[    5.049015] ata2.00: Enabling discard_zeroes_data
[    5.101426] scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000AAKX-0 1H15 PQ: 0 ANSI: 5
[    5.101466] sd 1:0:0:0: [sda] 937703088 512-byte logical blocks: (480 GB/447 GiB)
[    5.155291] sd 2:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    5.209302] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    5.263229] sd 2:0:0:0: [sdb] Write Protect is off
[    5.317491] sd 1:0:0:0: [sda] Write Protect is off
[    5.371321] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.371338] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.424530] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.424544] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.533073] ata2.00: Enabling discard_zeroes_data
[    5.587393]  sda: sda1 sda2 sda3 sda4
[    5.597711]  sdb: sdb1
[    5.641194] ata2.00: Enabling discard_zeroes_data
[    5.745816] sd 2:0:0:0: [sdb] Attached SCSI disk
[    5.745980] sd 1:0:0:0: [sda] supports TCG Opal
[    5.850318] sd 1:0:0:0: [sda] Attached SCSI disk
[    5.903209] Freeing unused decrypted memory: 2040K
[    5.955104] Freeing unused kernel image (initmem) memory: 2148K
[    6.006836] Write protecting the kernel read-only data: 20480k
[    6.059495] Freeing unused kernel image (text/rodata gap) memory: 2044K
[    6.111573] Freeing unused kernel image (rodata/data gap) memory: 1696K
[    6.162380] Run /init as init process
[    6.220857] systemd[1]: systemd +suse.138.gf8adabc2b1 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    6.344602] systemd[1]: Detected architecture x86-64.
[    6.397858] systemd[1]: Running in initial RAM disk.
[    6.629442] systemd[1]: Set hostname to <ndcxii>.
[    6.740435] random: systemd: uninitialized urandom read (16 bytes read)
[    6.793824] systemd[1]: Reached target Local File Systems.
[    6.900251] random: systemd: uninitialized urandom read (16 bytes read)
[    6.954182] systemd[1]: Reached target Slices.
[    7.062233] random: systemd: uninitialized urandom read (16 bytes read)
[    7.116896] systemd[1]: Reached target Swap.
[    7.226524] systemd[1]: Reached target Timers.
[    7.337038] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.451487] systemd[1]: Listening on Journal Socket.
[    7.567731] systemd[1]: Listening on udev Control Socket.
[    7.683841] systemd[1]: Listening on udev Kernel Socket.
[    7.800855] urandom_read: 5 callbacks suppressed
[    7.800856] random: systemd: uninitialized urandom read (16 bytes read)
[    7.917697] systemd[1]: Reached target Sockets.
[    8.034505] random: systemd: uninitialized urandom read (16 bytes read)
[    8.094430] systemd[1]: Started Entropy Daemon based on the HAVEGE algorithm.
[    8.215943] systemd[1]: Starting Create list of static device nodes for the current kernel...
[    8.340656] systemd[1]: Starting Journal Service...
[    8.435237] random: crng init done
[    8.524451] systemd[1]: Starting Load Kernel Modules...
[    8.585239] alua: device handler registered
[    8.645762] emc: device handler registered
[    8.706749] rdac: device handler registered
[    8.778698] device-mapper: uevent: version 1.0.3
[    8.778768] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised: dm-devel@redhat.com
[    8.784816] scsi 0:0:0:0: Attached scsi generic sg0 type 5
[    8.784841] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    8.784868] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    9.128091] systemd[1]: Starting Setup Virtual Console...
[    9.250949] systemd[1]: Started Journal Service.
[   11.014625] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control method not found
[   11.015029] scsi host6: ata_generic
[   11.015452] scsi host7: ata_generic
[   11.015871] ata7: PATA max UDMA/100 cmd 0xfe80 ctl 0xfe90 bmdma 0xfef0 irq 18
[   11.015873] ata8: PATA max UDMA/100 cmd 0xfea0 ctl 0xfeb0 bmdma 0xfef8 irq 18
[   11.043180] ACPI: bus type USB registered
[   11.043208] usbcore: registered new interface driver usbfs
[   11.043220] usbcore: registered new interface driver hub
[   11.043260] usbcore: registered new device driver usb
[   11.051178] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   11.052644] ehci-pci: EHCI PCI platform driver
[   11.053294] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   11.053302] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 1
[   11.053314] ehci-pci 0000:00:1a.0: debug port 2
[   11.057272] ehci-pci 0000:00:1a.0: cache line size of 64 is not supported
[   11.057302] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7fdd000
[   11.072572] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   11.072653] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.05
[   11.072655] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   11.072656] usb usb1: Product: EHCI Host Controller
[   11.072658] usb usb1: Manufacturer: Linux 5.5.6-1-default ehci_hcd
[   11.072659] usb usb1: SerialNumber: 0000:00:1a.0
[   11.072947] hub 1-0:1.0: USB hub found
[   11.072970] hub 1-0:1.0: 3 ports detected
[   11.074062] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   11.074175] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[   11.074177] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.800312] raid6: sse2x4   gen()  9924 MB/s
[   11.839207] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 2
[   11.956272] raid6: sse2x4   xor()  7446 MB/s
[   11.997097] ehci-pci 0000:00:1d.0: debug port 2
[   12.116327] raid6: sse2x2   gen()  8701 MB/s
[   12.159016] ehci-pci 0000:00:1d.0: cache line size of 64 is not supported
[   12.264290] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   12.314404] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7fde000
[   12.364910] raid6: sse2x2   xor()  7175 MB/s
[   12.428339] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   12.468754] usb 1-1: New USB device found, idVendor=8087, idProduct=0020, bcdDevice= 0.00
[   12.516373] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.05
[   12.565768] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   12.615752] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   12.615754] raid6: sse2x1   gen()  7447 MB/s
[   12.665391] hub 1-1:1.0: USB hub found
[   12.714961] usb usb2: Product: EHCI Host Controller
[   12.764442] raid6: sse2x1   xor()  5678 MB/s
[   12.764469] hub 1-1:1.0: 6 ports detected
[   12.814261] usb usb2: Manufacturer: Linux 5.5.6-1-default ehci_hcd
[   12.863859] raid6: using algorithm sse2x4 gen() 9924 MB/s
[   12.863860] raid6: .... xor() 7446 MB/s, rmw enabled
[   12.913129] usb usb2: SerialNumber: 0000:00:1d.0
[   12.962369] raid6: using ssse3x2 recovery algorithm
[   12.964586] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   13.012419] hub 2-0:1.0: USB hub found
[   13.164064] xor: measuring software checksum speed
[   13.215774] hub 2-0:1.0: 3 ports detected
[   13.420811] [drm] radeon kernel modesetting enabled.
[   13.680258]    prefetch64-sse: 191401.000 MB/sec
[   13.726154] checking generic (e0000000 5b0000) vs hw (e0000000 10000000)
[   13.880349] usb 2-1: new high-speed USB device number 2 using ehci-pci
[   13.929691] fb0: switching to radeondrmfb from VESA VGA
[   14.084679] Console: switching to colour dummy device 80x25
[   14.084724] radeon 0000:01:00.0: vgaarb: deactivate vga console
[   14.085442] [drm] initializing kernel modesetting (RV620 0x1002:0x95C5 0x1028:0x0342 0x00).
[   14.085499] ATOM BIOS: 113
[   14.085515] radeon 0000:01:00.0: VRAM: 256M 0x0000000000000000 - 0x000000000FFFFFFF (256M used)
[   14.085518] radeon 0000:01:00.0: GTT: 512M 0x0000000010000000 - 0x000000002FFFFFFF
[   14.085523] [drm] Detected VRAM RAM=256M, BAR=256M
[   14.085525] [drm] RAM width 64bits DDR
[   14.085580] [TTM] Zone  kernel: Available graphics memory: 8156746 KiB
[   14.085583] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   14.085585] [TTM] Initializing pool allocator
[   14.085590] [TTM] Initializing DMA pool allocator
[   14.085607] [drm] radeon: 256M of VRAM memory ready
[   14.085610] [drm] radeon: 512M of GTT memory ready.
[   14.085617] [drm] Loading RV620 Microcode
[   14.085664] [drm] Internal thermal controller with fan control
[   14.085691] [drm] radeon: power management initialized
[   14.085735] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   14.086211] [drm] enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0
[   14.088722] usb 2-1: New USB device found, idVendor=8087, idProduct=0020, bcdDevice= 0.00
[   14.088729] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[   14.089015] hub 2-1:1.0: USB hub found
[   14.089098] hub 2-1:1.0: 8 ports detected
[   14.096262]    generic_sse: 167685.000 MB/sec
[   14.096268] xor: using function: prefetch64-sse (191401.000 MB/sec)
[   14.097281] [drm] PCIE GART of 512M enabled (table at 0x0000000000142000).
[   14.097333] radeon 0000:01:00.0: WB enabled
[   14.097340] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000010000c00 and cpu addr 0x000000001c440dfe
[   14.097695] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 and cpu addr 0x0000000008847452
[   14.097703] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   14.097706] [drm] Driver supports precise vblank timestamp query.
[   14.097711] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[   14.097750] radeon 0000:01:00.0: radeon: using MSI.
[   14.097779] [drm] radeon: irq initialized.
[   14.129658] [drm] ring test on 0 succeeded in 1 usecs
[   14.208088] Btrfs loaded, crc32c=crc32c-intel, assert=on
[   14.209096] BTRFS: device fsid e7b29c18-4707-48a4-8c29-dd4dd70378b8 devid 1 transid 6592332 /dev/sda2 scanned by systemd-udevd (364)
[   14.209318] BTRFS: device fsid b914656e-7537-465b-a2ba-d08c6eea908a devid 1 transid 731159 /dev/sda1 scanned by systemd-udevd (394)
[   14.209507] BTRFS: device fsid 25ad4760-1e0e-439b-b5ac-bd506408795b devid 1 transid 3355553 /dev/sda4 scanned by systemd-udevd (398)
[   14.259931] BTRFS info (device sda1): disk space caching is enabled
[   14.285519] BTRFS info (device sda1): enabling ssd optimizations
[   14.304408] [drm] ring test on 5 succeeded in 1 usecs
[   14.304417] [drm] UVD initialized successfully.
[   14.304585] [drm] ib test on ring 0 succeeded in 0 usecs
[   14.384358] usb 2-1.7: new low-speed USB device number 3 using ehci-pci
[   14.499667] BTRFS info (device sda1): disk space caching is enabled
[   14.515617] usb 2-1.7: New USB device found, idVendor=413c, idProduct=2105, bcdDevice= 3.52
[   14.515631] usb 2-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   14.515640] usb 2-1.7: Product: Dell USB Keyboard
[   14.515646] usb 2-1.7: Manufacturer: Dell
[   14.537977] usbcore: registered new interface driver usbhid
[   14.537983] usbhid: USB HID core driver
[   14.540101] input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.7/2-1.7:1.0/0003:413C:2105.0001/input/input3
[   14.554883] BTRFS info (device sda1): disk space caching is enabled
[   14.596441] hid-generic 0003:413C:2105.0001: input,hidraw0: USB HID v1.10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:1d.0-1.7/input0
[   14.984641] [drm] ib test on ring 5 succeeded
[   14.984935] [drm] Radeon Display Connectors
[   14.984938] [drm] Connector 0:
[   14.984939] [drm]   DIN-1
[   14.984941] [drm]   Encoders:
[   14.984942] [drm]     TV1: INTERNAL_KLDSCP_DAC2
[   14.984944] [drm] Connector 1:
[   14.984946] [drm]   DVI-I-1
[   14.984947] [drm]   HPD1
[   14.984949] [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
[   14.984952] [drm]   Encoders:
[   14.984956] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   14.984957] [drm]     DFP2: INTERNAL_KLDSCP_LVTMA
[   14.984959] [drm] Connector 2:
[   14.984960] [drm]   DVI-I-2
[   14.984961] [drm]   HPD2
[   14.984963] [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
[   14.984965] [drm]   Encoders:
[   14.984966] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[   14.984968] [drm]     DFP1: INTERNAL_UNIPHY
[   15.046853] [drm] fb mappable at 0xE0243000
[   15.046857] [drm] vram apper at 0xE0000000
[   15.046859] [drm] size 8294400
[   15.046860] [drm] fb depth is 24
[   15.046862] [drm]    pitch is 7680
[   15.046983] fbcon: radeondrmfb (fb0) is primary device
[   15.080367] Console: switching to colour frame buffer device 240x67
[   15.083940] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[   15.096397] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 on minor 0
[   15.227309] systemd-journald[262]: Received SIGTERM from PID 1 (systemd).
[   15.413496] systemd[1]: systemd +suse.138.gf8adabc2b1 running in system mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[   15.413884] systemd[1]: Detected architecture x86-64.
[   15.416484] systemd[1]: Set hostname to <ndcxii>.
[   15.744641] systemd[1]: /usr/lib/systemd/system/isdn.service:3: Failed to add dependency on hylafax-hfaxd, ignoring: Invalid argument
[   15.746350] systemd[1]: /usr/lib/systemd/system/ntpd.service:15: PIDFile= references a path below legacy directory /var/run/, updating /var/run/ntp/ntpd.pid → /run/ntp/ntpd.pid; please update the unit file accordingly.
[   15.753064] systemd[1]: /usr/lib/systemd/system/display-manager.service:12: PIDFile= references a path below legacy directory /var/run/, updating /var/run/displaymanager.pid → /run/displaymanager.pid; please update the unit file accordingly.
[   15.790346] systemd[1]: /usr/lib/systemd/system/pcscd.socket:5: ListenStream= references a path below legacy directory /var/run/, updating /var/run/pcscd/pcscd.comm → /run/pcscd/pcscd.comm; please update the unit file accordingly.
[   15.861953] systemd[1]: haveged.service: Main process exited, code=exited, status=1/FAILURE
[   15.862103] systemd[1]: haveged.service: Failed with result 'exit-code'.
[   15.862439] systemd[1]: Stopped Entropy Daemon based on the HAVEGE algorithm.
[   15.862797] systemd[1]: initrd-switch-root.service: Succeeded.
[   15.863129] systemd[1]: Stopped Switch Root.
[   15.863428] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[   15.863697] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   15.863983] systemd[1]: Created slice User and Session Slice.
[   15.864408] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   15.867352] systemd[1]: Reached target Login Prompts.
[   15.869190] systemd[1]: Stopped target Switch Root.
[   15.872431] systemd[1]: Stopped target Initrd File Systems.
[   15.874236] systemd[1]: Stopped target Initrd Root File System.
[   15.875958] systemd[1]: Reached target Remote File Systems.
[   15.880024] systemd[1]: Reached target Slices.
[   15.883792] systemd[1]: Reached target System Time Set.
[   15.885561] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[   15.889788] systemd[1]: Listening on LVM2 poll daemon socket.
[   15.894503] systemd[1]: Listening on Process Core Dump Socket.
[   15.897054] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   15.900963] systemd[1]: Listening on udev Control Socket.
[   15.904806] systemd[1]: Listening on udev Kernel Socket.
[   15.909565] systemd[1]: Activating swap /dev/disk/by-id/ata-Crucial_CT480M500SSD1_1344095684C1-part3...
[   15.914015] systemd[1]: Mounting Huge Pages File System...
[   15.918376] systemd[1]: Mounting POSIX Message Queue File System...
[   15.922290] systemd[1]: Mounting Kernel Debug File System...
[   15.926457] systemd[1]: Starting Create list of static device nodes for the current kernel...
[   15.930357] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   15.934003] systemd[1]: plymouth-start.service: Succeeded.
[   15.934103] systemd[1]: Stopped Show Plymouth Boot Screen.
[   15.940907] systemd[1]: Condition check resulted in Dispatch Password Requests to Console Directory Watch being skipped.
[   15.940930] systemd[1]: Reached target Local Encrypted Volumes.
[   15.948384] systemd[1]: Starting Set Up Additional Binary Formats...
[   15.951259] systemd[1]: systemd-fsck-root.service: Succeeded.
[   15.951591] systemd[1]: Stopped File System Check on Root Device.
[   15.952494] Adding 20973564k swap on /dev/sda3.  Priority:-2 extents:1 across:20973564k SSFS
[   15.958803] systemd[1]: Stopped Journal Service.
[   15.962037] systemd[1]: Starting Journal Service...
[   15.966037] systemd[1]: Starting Load Kernel Modules...
[   15.970012] systemd[1]: Starting Remount Root and Kernel File Systems...
[   15.974257] systemd[1]: Starting udev Coldplug all Devices...
[   15.977887] systemd[1]: Starting Setup Virtual Console...
[   15.978454] BTRFS info (device sda1): disk space caching is enabled
[   15.983563] systemd[1]: sysroot.mount: Succeeded.
[   15.985161] systemd[1]: Activated swap /dev/disk/by-id/ata-Crucial_CT480M500SSD1_1344095684C1-part3.
[   15.990103] systemd[1]: Mounted Huge Pages File System.
[   15.993864] systemd[1]: Mounted POSIX Message Queue File System.
[   15.997417] systemd[1]: Mounted Kernel Debug File System.
[   16.001627] systemd[1]: Started Create list of static device nodes for the current kernel.
[   16.005037] systemd[1]: Started Load Kernel Modules.
[   16.008588] systemd[1]: Started Remount Root and Kernel File Systems.
[   16.012651] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 552 (systemd-binfmt)
[   16.013065] systemd[1]: Reached target Swap.
[   16.018278] systemd[1]: Mounting Arbitrary Executable File Formats File System...
[   16.021124] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
[   16.021266] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
[   16.021302] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
[   16.022922] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[   16.024025] systemd[1]: Starting Apply Kernel Variables...
[   16.034505] systemd[1]: Condition check resulted in Create System Users being skipped.
[   16.035687] systemd[1]: Starting Create Static Device Nodes in /dev...
[   16.044385] systemd[1]: Mounted Arbitrary Executable File Formats File System.
[   16.051296] systemd[1]: Started Set Up Additional Binary Formats.
[   16.059204] systemd[1]: Started Apply Kernel Variables.
[   16.065800] systemd[1]: Started Create Static Device Nodes in /dev.
[   16.072514] systemd[1]: Starting udev Kernel Device Manager...
[   16.082343] systemd[1]: Started udev Coldplug all Devices.
[   16.088159] systemd[1]: Starting udev Wait for Complete Device Initialization...
[   16.096750] systemd[1]: systemd-vconsole-setup.service: Succeeded.
[   16.097075] systemd[1]: Started Setup Virtual Console.
[   16.248298] systemd[1]: Started Journal Service.
[   16.582900] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x000000000000082D (\GLBC) (20191018/utaddress-204)
[   16.585478] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x000000000000082A-0x000000000000082A (\SACT) (20191018/utaddress-204)
[   16.588039] ACPI Warning: SystemIO range 0x0000000000000828-0x000000000000082F conflicts with OpRegion 0x0000000000000828-0x0000000000000828 (\SSTS) (20191018/utaddress-204)
[   16.590600] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   16.593447] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   16.600164] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input4
[   16.603857] ACPI: Power Button [VBTN]
[   16.606450] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input5
[   16.612382] ACPI: Power Button [PWRF]
[   16.642611] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   16.645087] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   16.650267] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[   16.676669] input: PC Speaker as /devices/platform/pcspkr/input/input6
[   16.680226] EDAC MC0: Giving out device to module i7core_edac.c controller i7 core #0: DEV 0000:3f:03.0 (INTERRUPT)
[   16.682188] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   16.686652] EDAC PCI0: Giving out device to module i7core_edac controller EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[   16.691517] parport_pc 00:02: reported by Plug and Play ACPI
[   16.694217] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]
[   16.704312] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   16.763185] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.3)
[   16.813283] ppdev: user-space parallel port driver
[   16.838787] dell-smbios A80593CE-A997-11DA-B012-B622A1EF5492: WMI SMBIOS userspace interface not supported(0), try upgrading to a newer BIOS
[   16.852231] input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wmi_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input7
[   16.881769] snd_hda_codec_realtek hdaudioC0D0: ALC269VB: SKU not ready 0x411111f0
[   16.884795] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
[   16.887432] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   16.890150] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[   16.892809] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[   16.895446] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   16.902451] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x19
[   16.905098] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x18
[   16.916041] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) b8:ac:6f:ac:ec:6f
[   16.918921] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[   16.922320] e1000e 0000:00:19.0 eth0: MAC: 9, PHY: 9, PBA No: A002FF-0FF
[   16.932613] iTCO_vendor_support: vendor-support=0
[   16.936139] gpio_ich gpio_ich.2.auto: GPIO from 436 to 511
[   16.939065] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   16.941932] iTCO_wdt: Found a Q57 TCO device (Version=2, TCOBASE=0x0860)
[   16.943062] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work properly. Using workaround
[   16.945302] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   16.950132] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   16.952737] input: HDA Intel MID Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   16.955377] input: HDA Intel MID Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[   16.958046] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   16.962324] input: HDA Intel MID Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   17.008045] e1000e 0000:00:19.0 em1: renamed from eth0
[   17.112620] pktcdvd: pktcdvd0: writer mapped to sr0
[   17.120875] BTRFS info (device sda4): disk space caching is enabled
[   17.219589] BTRFS info (device sda4): enabling ssd optimizations
[   17.224337] BTRFS info (device sda2): disk space caching is enabled
[   17.242801] BTRFS info (device sda2): enabling ssd optimizations
[   17.247316] BTRFS critical (device sda2): corrupt leaf: root=5 block=14720090112 slot=44 ino=131072, invalid inode generation: has 18446744073709551492 expect [0, 6592333]
[   17.250174] BTRFS error (device sda2): block=14720090112 read time tree block corruption detected
[   17.265530] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[   17.474464] audit: type=1400 audit(1583426902.588:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ping" pid=806 comm="apparmor_parser"
[   17.533429] audit: type=1400 audit(1583426902.648:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ghostscript" pid=822 comm="apparmor_parser"
[   17.535535] audit: type=1400 audit(1583426902.648:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="ghostscript///usr/bin/hpijs" pid=822 comm="apparmor_parser"
[   17.578935] audit: type=1400 audit(1583426902.692:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=835 comm="apparmor_parser"
[   17.613861] audit: type=1400 audit(1583426902.728:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=842 comm="apparmor_parser"
[   17.616090] audit: type=1400 audit(1583426902.728:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=842 comm="apparmor_parser"
[   17.641609] audit: type=1400 audit(1583426902.756:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="klogd" pid=849 comm="apparmor_parser"
[   17.673133] audit: type=1400 audit(1583426902.788:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslog-ng" pid=856 comm="apparmor_parser"
[   17.702249] audit: type=1400 audit(1583426902.816:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="syslogd" pid=863 comm="apparmor_parser"
[   17.738378] audit: type=1400 audit(1583426902.852:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/lessopen.sh" pid=873 comm="apparmor_parser"

--------------0BA12F5258A584B07869EA43--
