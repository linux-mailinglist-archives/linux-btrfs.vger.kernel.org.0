Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8946A17B307
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 01:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCFAgy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Mar 2020 19:36:54 -0500
Received: from fe4.lbl.gov ([131.243.228.53]:50719 "EHLO fe4.lbl.gov"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFAgy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Mar 2020 19:36:54 -0500
IronPort-SDR: aQVwlVRC0Ag0prvh1uCkTXBh8CyirTgdiAZ6ZsRIIlZr3kBE0F0FCTp7ZGdIsAnk+QUPQPj0Pg
 QamyAFVy7UvQ==
X-Ironport-SBRS: 2.8
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E1AACbmmFegMfSVdFkGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBEQEBAQEBAQEBAQEBgXuBfYEYVVyEFYNJizeBbIEmgm2VaYF?=
 =?us-ascii?q?nCQEBAQEBAQEBAQYBASMIBAQBAQKBAkuCdAKCDyQ4EwIDAQELAQEGAQEBAQE?=
 =?us-ascii?q?FBAICEAEBCQ0JCCeFXwyDU3ABAQEBAQEBAQEBAQEBAQEBAQEBARYCDVQmQwI?=
 =?us-ascii?q?BAxIIAQgEUhALEhwBARICAjQBBQEODgYBDAYCAQEegjkMPwGCewUKnEWBBD2?=
 =?us-ascii?q?LKH8zg31MQYNugS4QCQEIgSaKc4EXHRqBQT+BEAEnDIIsNT6CZAECAQKBJBQ?=
 =?us-ascii?q?LAQQKOxwCBYJCgl4EjVcGCCAciFkdVjl9h0WPOYJGg3GBE4EogSaFTYQahSc?=
 =?us-ascii?q?igkmBAIchhBQSJ4t9jnWBTZViHAaDfAIKBwYPI4FGTRqBFCsIAhgIIQ87gmw?=
 =?us-ascii?q?JRxgNV41PAgEXiGSBPYQlIDMCBYw7AQEPFQKCGwEB?=
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; 
   d="log'?scan'208";a="97252983"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by fe4.lbl.gov with ESMTP; 05 Mar 2020 16:36:47 -0800
Received: by mail-pf1-f199.google.com with SMTP id x21so234284pfp.12
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Mar 2020 16:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=ixV4N3EEh+/gZk5J602Yyw39OMdCslkmVI+tz2DAhVs=;
        b=GjIfOsUbO+wOaIb5Fq4Ti/7bi+KPKCWRkm0LTPRg+68FxOYW1ia/KYX6N/5wX6yNwc
         VHTvyhh5+snrSstLucIDWmUsCXlfvqPWfo9tPZawo4Xla85HM8EFgzdADm4N7RDdrdqa
         Ih39horZ4QlI49z0Pwfk3Gaa2XYsT0pPvS9teYDly68ZDUvM5OjB+fkc9ISnEUXtAFmK
         vJfIMXpMIw+XQN6KT3MMafTcx0vKjhF+80r3H1jjpnV4a/8w06wvKwE16Xh7DRhlHng6
         kUcj770CqzR5N1065paeRS8AChame+wb2eCLwSuTfco8ClheU8uBo7KpSs2slUpv35VH
         B8XQ==
X-Gm-Message-State: ANhLgQ1Zo+MX6fbA5qhj4f5VODosQqjvGqR3fwg9O/XjHKAVmricLBCA
        oyy4oXFlWjjQluMLNbhnPVWnF0Wdon7QS+KhvmxUePXlDzA1AtTlSvs1W8KWIzRcSmfvszl+ORM
        UslQt5G/LA0EztHHcJbfwN313QQ==
X-Received: by 2002:a17:90a:1697:: with SMTP id o23mr811320pja.62.1583455006320;
        Thu, 05 Mar 2020 16:36:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtizYZi+lIdRXRJeGL8GEnfndI7DFNcQVRyEK/nr9PW6dO4oEdloYtrEmEj/zooBDKDihVFJg==
X-Received: by 2002:a17:90a:1697:: with SMTP id o23mr811285pja.62.1583455005825;
        Thu, 05 Mar 2020 16:36:45 -0800 (PST)
Received: from [128.3.131.12] (apersaud.dhcp.lbl.gov. [128.3.131.12])
        by smtp.gmail.com with ESMTPSA id b15sm7265811pjc.37.2020.03.05.16.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 16:36:44 -0800 (PST)
Subject: Re: problem with newer kernels
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <e8904a49-bd28-46c7-77d0-d114627ce0d9@lbl.gov>
 <CAJCQCtT0CVBfupwj9wM3JAopg7YZ3FicLFGMo=is21CdyEg8Jg@mail.gmail.com>
 <aa4ba5af-1d0f-9db2-8cad-693b970bf843@lbl.gov>
 <dd0dffb5-e248-4498-dffb-4a6e6e4fd0fb@gmx.com>
From:   Arun Persaud <apersaud@lbl.gov>
Autocrypt: addr=apersaud@lbl.gov; prefer-encrypt=mutual; keydata=
 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
Message-ID: <99ddd844-3371-d496-701d-bc6ea9fb0779@lbl.gov>
Date:   Thu, 5 Mar 2020 16:36:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <dd0dffb5-e248-4498-dffb-4a6e6e4fd0fb@gmx.com>
Content-Type: multipart/mixed;
 boundary="------------29DA2D0F28ED13FCB8204740"
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------29DA2D0F28ED13FCB8204740
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi

>[...]
>>>> BTRFS critical, corrupt leaf...
>>>
>>> Complete dmesg is needed, thanks.
>>
>> dmesg is attached
> 
> It's inode generation underflow, caused by some older kernel.
> 
> It can be fixed by v5.4 btrfs-progs, by running btrfs check --repair.
> 
> Thanks,
> Qu
I just tried running

btrfs check --repair /dev/sda2

However, it didn't fix the problem.

I also tried it with the --mode=lowmem option, but no change

I then ran the same again to generate logs which are attached. Also
attached a dmesg from the reboot after calling the repair function.

Arun

--------------29DA2D0F28ED13FCB8204740
Content-Type: text/x-log; charset=UTF-8;
 name="btrfs_repair_standard.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="btrfs_repair_standard.log"

enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda2
UUID: e7b29c18-4707-48a4-8c29-dd4dd70378b8
No device size related problem found
cache and super generation don't match, space cache will be invalidated
reset nbytes for ino 394462 root 5
reset nbytes for ino 785218 root 5
found 17953656832 bytes used, no error found
total csum bytes: 10665012
total tree bytes: 145707008
total fs tree bytes: 90124288
total extent tree bytes: 36007936
btree space waste bytes: 33155393
file data blocks allocated: 30611271680
 referenced 14016724992

--------------29DA2D0F28ED13FCB8204740
Content-Type: text/x-log; charset=UTF-8;
 name="btrfs_repair_lowmem.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="btrfs_repair_lowmem.log"

enabling repair mode
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. Eg.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1WARNING: low-memory mode repair support is only parti=
al
[1/7] checking root items
Fixed 0 roots.
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
ERROR: root 5 EXTENT_DATA[394462 0] csum missing, have: 0, expected: 4096=

ERROR: root 5 EXTENT_DATA[785218 8192] csum missing, have: 0, expected: 4=
096
ERROR: root 5 EXTENT_DATA[785218 24576] csum missing, have: 0, expected: =
4096
ERROR: root 5 EXTENT_DATA[785218 32768] csum missing, have: 0, expected: =
98304
ERROR: root 5 EXTENT_DATA[785218 147456] csum missing, have: 0, expected:=
 143360
ERROR: root 5 EXTENT_DATA[785218 8192] csum missing, have: 0, expected: 4=
096
ERROR: root 5 EXTENT_DATA[785218 24576] csum missing, have: 0, expected: =
4096
ERROR: root 5 EXTENT_DATA[785218 32768] csum missing, have: 0, expected: =
98304
ERROR: root 5 EXTENT_DATA[785218 147456] csum missing, have: 0, expected:=
 143360
ERROR: errors found in fs roots

Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda2
UUID: e7b29c18-4707-48a4-8c29-dd4dd70378b8
No device size related problem found
cache and super generation don't match, space cache will be invalidated
Set nbytes in inode item 394462 root 5 to 4096
Set nbytes in inode item 785218 root 5 to 299008
found 17953656832 bytes used, error(s) found
total csum bytes: 10665012
total tree bytes: 145707008
total fs tree bytes: 90124288
total extent tree bytes: 36007936
btree space waste bytes: 33155393
file data blocks allocated: 30611271680
 referenced 14016724992

--------------29DA2D0F28ED13FCB8204740
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] microcode: microcode updated early to revision 0xa, date =3D=
 2018-05-08
[    0.000000] Linux version 5.5.6-1-default (geeko@buildhost) (gcc versi=
on 9.2.1 20200128 [revision 83f65674e78d97d27537361de1a9d74067ff228d] (SU=
SE Linux)) #1 SMP Mon Feb 24 09:02:31 UTC 2020 (4a830b1)
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-5.5.6-1-default r=
oot=3DUUID=3Db914656e-7537-465b-a2ba-d08c6eea908a rd.convertfs rd.convert=
fs rd.convertfs
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e3ff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000db6cfbff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x00000000db6cfc00-0x00000000db723bff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x00000000db723c00-0x00000000db725bff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x00000000db725c00-0x00000000dbffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fed003ff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed9ffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ffffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041fffffff] usa=
ble
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Dell Inc. OptiPlex 980                 /0D441T, BIOS =
A17 05/10/2017
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2792.760 MHz processor
[    0.002744] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> re=
served
[    0.002746] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.002750] last_pfn =3D 0x420000 max_arch_pfn =3D 0x400000000
[    0.002754] MTRR default type: write-back
[    0.002755] MTRR fixed ranges enabled:
[    0.002756]   00000-9FFFF write-back
[    0.002757]   A0000-BFFFF uncachable
[    0.002758]   C0000-D7FFF write-protect
[    0.002759]   D8000-EFFFF uncachable
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
[    0.003422] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
[    0.003708] last_pfn =3D 0xdb6cf max_arch_pfn =3D 0x400000000
[    0.016427] found SMP MP-table at [mem 0x000fe710-0x000fe71f]
[    0.026866] check: Scanning 1 areas for low memory corruption
[    0.026872] BRK [0x359c01000, 0x359c01fff] PGTABLE
[    0.026874] BRK [0x359c02000, 0x359c02fff] PGTABLE
[    0.026875] BRK [0x359c03000, 0x359c03fff] PGTABLE
[    0.026911] BRK [0x359c04000, 0x359c04fff] PGTABLE
[    0.026913] BRK [0x359c05000, 0x359c05fff] PGTABLE
[    0.027022] BRK [0x359c06000, 0x359c06fff] PGTABLE
[    0.027035] BRK [0x359c07000, 0x359c07fff] PGTABLE
[    0.027049] BRK [0x359c08000, 0x359c08fff] PGTABLE
[    0.027089] BRK [0x359c09000, 0x359c09fff] PGTABLE
[    0.027322] RAMDISK: [mem 0x36037000-0x37012fff]
[    0.027329] ACPI: Early table checksum verification disabled
[    0.027333] ACPI: RSDP 0x00000000000FEC00 000024 (v02 DELL  )
[    0.027337] ACPI: XSDT 0x00000000000FC7E0 000074 (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027343] ACPI: FACP 0x00000000000FC8D0 0000F4 (v03 DELL   B11K     =
00000015 ASL  00000061)
[    0.027347] ACPI BIOS Warning (bug): 32/64X length mismatch in FADT/Gp=
e0Block: 128/64 (20191018/tbfadt-564)
[    0.027416] ACPI: DSDT 0x00000000FFDCBEE7 0047BC (v01 DELL   dt_ex    =
00001000 INTL 20050624)
[    0.027424] ACPI: FACS 0x00000000DB6CFC00 000040
[    0.027427] ACPI: FACS 0x00000000DB6CFC00 000040
[    0.027494] ACPI: SSDT 0x00000000FFDD0870 000088 (v01 DELL   st_ex    =
00001000 INTL 20050624)
[    0.027498] ACPI: APIC 0x00000000000FC9C4 000092 (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027502] ACPI: BOOT 0x00000000000FCA56 000028 (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027505] ACPI: ASF! 0x00000000000FCA7E 000096 (v32 DELL   B11K     =
00000015 ASL  00000061)
[    0.027509] ACPI: MCFG 0x00000000000FCB14 00003C (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027512] ACPI: HPET 0x00000000000FCB50 000038 (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027516] ACPI: TCPA 0x00000000000FCDAC 000032 (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027520] ACPI: DMAR 0x00000000000FCDDE 000068 (v01 DELL   B11K     =
00000015 ASL  00000061)
[    0.027523] ACPI: SSDT 0x00000000DB725C00 002094 (v01 INTEL  PPM RCM  =
80000001 INTL 20061109)
[    0.027696] ACPI: Local APIC address 0xfee00000
[    0.027793] No NUMA configuration found
[    0.027794] Faking a node at [mem 0x0000000000000000-0x000000041ffffff=
f]
[    0.027800] NODE_DATA(0) allocated [mem 0x41ffde000-0x41fff3fff]
[    0.027850] Zone ranges:
[    0.027851]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.027852]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.027853]   Normal   [mem 0x0000000100000000-0x000000041fffffff]
[    0.027855]   Device   empty
[    0.027856] Movable zone start for each node
[    0.027858] Early memory node ranges
[    0.027859]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.027860]   node   0: [mem 0x0000000000100000-0x00000000db6cefff]
[    0.027861]   node   0: [mem 0x0000000100000000-0x000000041fffffff]
[    0.028133] Zeroed struct page in unavailable ranges: 18836 pages
[    0.028134] Initmem setup node 0 [mem 0x0000000000001000-0x000000041ff=
fffff]
[    0.028135] On node 0 totalpages: 4175468
[    0.028136]   DMA zone: 64 pages used for memmap
[    0.028137]   DMA zone: 21 pages reserved
[    0.028138]   DMA zone: 3997 pages, LIFO batch:0
[    0.028227]   DMA32 zone: 13980 pages used for memmap
[    0.028228]   DMA32 zone: 894671 pages, LIFO batch:63
[    0.049248]   Normal zone: 51200 pages used for memmap
[    0.049250]   Normal zone: 3276800 pages, LIFO batch:63
[    0.050093] ACPI: PM-Timer IO Port: 0x808
[    0.050096] ACPI: Local APIC address 0xfee00000
[    0.050104] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.050115] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI =
0-23
[    0.050117] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.050119] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level=
)
[    0.050120] ACPI: IRQ0 used by override.
[    0.050121] ACPI: IRQ9 used by override.
[    0.050124] Using ACPI (MADT) for SMP configuration information
[    0.050125] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.050130] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.050143] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.050145] PM: Registered nosave memory: [mem 0x0009e000-0x000effff]
[    0.050146] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.050148] PM: Registered nosave memory: [mem 0xdb6cf000-0xdb6cffff]
[    0.050148] PM: Registered nosave memory: [mem 0xdb6d0000-0xdb722fff]
[    0.050149] PM: Registered nosave memory: [mem 0xdb723000-0xdb723fff]
[    0.050150] PM: Registered nosave memory: [mem 0xdb724000-0xdb724fff]
[    0.050151] PM: Registered nosave memory: [mem 0xdb725000-0xdb725fff]
[    0.050152] PM: Registered nosave memory: [mem 0xdb726000-0xdbffffff]
[    0.050153] PM: Registered nosave memory: [mem 0xdc000000-0xf7ffffff]
[    0.050153] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.050154] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.050155] PM: Registered nosave memory: [mem 0xfec00000-0xfecfffff]
[    0.050156] PM: Registered nosave memory: [mem 0xfed00000-0xfed1ffff]
[    0.050157] PM: Registered nosave memory: [mem 0xfed20000-0xfed9ffff]
[    0.050157] PM: Registered nosave memory: [mem 0xfeda0000-0xfedfffff]
[    0.050158] PM: Registered nosave memory: [mem 0xfee00000-0xfeefffff]
[    0.050159] PM: Registered nosave memory: [mem 0xfef00000-0xffafffff]
[    0.050160] PM: Registered nosave memory: [mem 0xffb00000-0xffffffff]
[    0.050162] [mem 0xdc000000-0xf7ffffff] available for PCI devices
[    0.050163] Booting paravirtualized kernel on bare hardware
[    0.050166] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.237977] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:8=
 nr_node_ids:1
[    0.238273] percpu: Embedded 59 pages/cpu s204800 r8192 d28672 u262144=

[    0.238279] pcpu-alloc: s204800 r8192 d28672 u262144 alloc=3D1*2097152=

[    0.238280] pcpu-alloc: [0] 0 1 2 3 4 5 6 7=20
[    0.238301] Built 1 zonelists, mobility grouping on.  Total pages: 411=
0203
[    0.238302] Policy zone: Normal
[    0.238303] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-5.5.6-1-de=
fault root=3DUUID=3Db914656e-7537-465b-a2ba-d08c6eea908a rd.convertfs rd.=
convertfs rd.convertfs
[    0.238392] printk: log_buf_len individual max cpu contribution: 32768=
 bytes
[    0.238393] printk: log_buf_len total cpu_extra contributions: 229376 =
bytes
[    0.238393] printk: log_buf_len min size: 262144 bytes
[    0.238496] printk: log_buf_len: 524288 bytes
[    0.238497] printk: early log buf free: 252568(96%)
[    0.239897] Dentry cache hash table entries: 2097152 (order: 12, 16777=
216 bytes, linear)
[    0.240597] Inode-cache hash table entries: 1048576 (order: 11, 838860=
8 bytes, linear)
[    0.240712] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.266041] Memory: 3643884K/16701872K available (12291K kernel code, =
1503K rwdata, 4448K rodata, 2148K init, 12848K bss, 412584K reserved, 0K =
cma-reserved)
[    0.266050] random: get_random_u64 called from kmem_cache_open+0x26/0x=
3e0 with crng_init=3D0
[    0.266202] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D8,=
 Nodes=3D1
[    0.266216] Kernel/User page tables isolation: enabled
[    0.266234] ftrace: allocating 39803 entries in 156 pages
[    0.281863] ftrace: allocated 156 pages with 4 groups
[    0.281965] rcu: Hierarchical RCU implementation.
[    0.281967] rcu: 	RCU event tracing is enabled.
[    0.281968] rcu: 	RCU restricting CPUs from NR_CPUS=3D512 to nr_cpu_id=
s=3D8.
[    0.281969] 	Tasks RCU enabled.
[    0.281970] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
[    0.281971] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D8
[    0.285397] NR_IRQS: 33024, nr_irqs: 488, preallocated irqs: 16
[    0.285731] Console: colour dummy device 80x25
[    0.285910] printk: console [tty0] enabled
[    0.285927] ACPI: Core revision 20191018
[    0.364301] ACPI BIOS Warning (bug): Incorrect checksum in table [TCPA=
] - 0x00, should be 0x7E (20191018/tbprint-173)
[    0.364348] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 133484882848 ns
[    0.364362] APIC: Switch to symmetric I/O mode setup
[    0.364365] DMAR: Host address width 36
[    0.364367] DMAR: DRHD base: 0x000000fedc0000 flags: 0x1
[    0.364373] DMAR: dmar0: reg_base_addr fedc0000 ver 1:0 cap c90780106f=
0462 ecap f020e2
[    0.364376] DMAR: RMRR base: 0x000000db730000 end: 0x000000db76ffff
[    0.364866] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.384364] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x2841898e168, max_idle_ns: 440795285313 ns
[    0.384370] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 5585.52 BogoMIPS (lpj=3D11171040)
[    0.384374] pid_max: default: 32768 minimum: 301
[    0.384408] LSM: Security Framework initializing
[    0.384432] AppArmor: AppArmor initialized
[    0.384506] Mount-cache hash table entries: 32768 (order: 6, 262144 by=
tes, linear)
[    0.384546] Mountpoint-cache hash table entries: 32768 (order: 6, 2621=
44 bytes, linear)
[    0.384783] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.384794] process: using mwait in idle threads
[    0.384798] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
[    0.384800] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.384803] Spectre V1 : Mitigation: usercopy/swapgs barriers and __us=
er pointer sanitization
[    0.384807] Spectre V2 : Mitigation: Full generic retpoline
[    0.384809] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on context switch
[    0.384811] Spectre V2 : Enabling Restricted Speculation for firmware =
calls
[    0.384814] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
[    0.384816] Spectre V2 : User space: Mitigation: STIBP via seccomp and=
 prctl
[    0.384819] Speculative Store Bypass: Mitigation: Speculative Store By=
pass disabled via prctl and seccomp
[    0.384824] MDS: Vulnerable: Clear CPU buffers attempted, no microcode=

[    0.385013] Freeing SMP alternatives memory: 36K
[    0.494763] smpboot: CPU0: Intel(R) Core(TM) i7 CPU         860  @ 2.8=
0GHz (family: 0x6, model: 0x1e, stepping: 0x5)
[    0.494863] Performance Events: PEBS fmt1+, Nehalem events, 16-deep LB=
R, Intel PMU driver.
[    0.494871] core: CPU erratum AAJ80 worked around
[    0.494873] core: CPUID marked event: 'bus cycles' unavailable
[    0.494875] ... version:                3
[    0.494877] ... bit width:              48
[    0.494878] ... generic registers:      4
[    0.494880] ... value mask:             0000ffffffffffff
[    0.494882] ... max period:             000000007fffffff
[    0.494884] ... fixed-purpose events:   3
[    0.494886] ... event mask:             000000070000000f
[    0.494923] rcu: Hierarchical SRCU implementation.
[    0.495670] NMI watchdog: Enabled. Permanently consumes one hw-PMU cou=
nter.
[    0.495746] smp: Bringing up secondary CPUs ...
[    0.495839] x86: Booting SMP configuration:
[    0.495842] .... node  #0, CPUs:      #1 #2 #3 #4
[    0.504443] MDS CPU bug present and SMT on, data leak possible. See ht=
tps://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for mor=
e details.
[    0.504516]  #5 #6 #7
[    0.510774] smp: Brought up 1 node, 8 CPUs
[    0.510774] smpboot: Max logical packages: 1
[    0.510774] smpboot: Total of 8 processors activated (44684.16 BogoMIP=
S)
[    0.564382] node 0 initialised, 3161351 pages in 52ms
[    0.564815] devtmpfs: initialized
[    0.564815] x86/mm: Memory block size: 128MB
[    0.568838] PM: Registering ACPI NVS region [mem 0xdb6cfc00-0xdb723bff=
] (344064 bytes)
[    0.568838] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
[    0.568838] futex hash table entries: 2048 (order: 5, 131072 bytes, li=
near)
[    0.568838] pinctrl core: initialized pinctrl subsystem
[    0.568838] PM: RTC time: 00:27:19, date: 2020-03-06
[    0.568838] thermal_sys: Registered thermal governor 'fair_share'
[    0.568838] thermal_sys: Registered thermal governor 'bang_bang'
[    0.568838] thermal_sys: Registered thermal governor 'step_wise'
[    0.568838] thermal_sys: Registered thermal governor 'user_space'
[    0.568838] NET: Registered protocol family 16
[    0.568838] audit: initializing netlink subsys (disabled)
[    0.568838] audit: type=3D2000 audit(1583454438.204:1): state=3Dinitia=
lized audit_enabled=3D0 res=3D1
[    0.568838] cpuidle: using governor ladder
[    0.568838] cpuidle: using governor menu
[    0.568838] Simple Boot Flag at 0x7a set to 0x80
[    0.568838] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
[    0.568838] ACPI: bus type PCI registered
[    0.568838] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.568838] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf80000=
00-0xfbffffff] (base 0xf8000000)
[    0.568838] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E=
820
[    0.568838] PCI: Using configuration type 1 for base access
[    0.570353] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    0.572427] ACPI: Added _OSI(Module Device)
[    0.572430] ACPI: Added _OSI(Processor Device)
[    0.572432] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.572434] ACPI: Added _OSI(Processor Aggregator Device)
[    0.572437] ACPI: Added _OSI(Linux-Dell-Video)
[    0.572439] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.572441] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.633961] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    0.637772] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.641442] ACPI: Interpreter enabled
[    0.641461] ACPI: (supports S0 S1 S4 S5)
[    0.641463] ACPI: Using IOAPIC for interrupt routing
[    0.641576] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[    0.641778] ACPI: Enabled 9 GPEs in block 00 to 3F
[    0.718437] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.718446] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI HPX-Type3]
[    0.718461] acpi PNP0A03:00: [Firmware Info]: MMCONFIG for domain 0000=
 [bus 00-3f] only partially covers this bridge
[    0.724611] PCI host bridge to bus 0000:00
[    0.724615] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 wind=
ow]
[    0.724618] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff wind=
ow]
[    0.724621] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
[    0.724624] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000ef=
fff window]
[    0.724627] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ff=
fff window]
[    0.724630] pci_bus 0000:00: root bus resource [mem 0xdb800000-0xf7fff=
fff window]
[    0.724633] pci_bus 0000:00: root bus resource [mem 0xff87c000-0xff87f=
fff window]
[    0.724636] pci_bus 0000:00: root bus resource [mem 0xff870000-0xff870=
7ff window]
[    0.724639] pci_bus 0000:00: root bus resource [mem 0xfed20000-0xfed9f=
fff window]
[    0.724642] pci_bus 0000:00: root bus resource [mem 0xfeda6000-0xfeda6=
fff window]
[    0.724645] pci_bus 0000:00: root bus resource [mem 0xfeda7000-0xfeda7=
fff window]
[    0.724649] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.724660] pci 0000:00:00.0: [8086:d131] type 00 class 0x060000
[    0.724994] pci 0000:00:03.0: [8086:d138] type 01 class 0x060400
[    0.725025] pci 0000:00:03.0: enabling Extended Tags
[    0.725061] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.725362] pci 0000:00:08.0: [8086:d155] type 00 class 0x088000
[    0.725687] pci 0000:00:08.1: [8086:d156] type 00 class 0x088000
[    0.726010] pci 0000:00:08.2: [8086:d157] type 00 class 0x088000
[    0.726337] pci 0000:00:10.0: [8086:d150] type 00 class 0x088000
[    0.726641] pci 0000:00:10.1: [8086:d151] type 00 class 0x088000
[    0.726965] pci 0000:00:16.0: [8086:3b64] type 00 class 0x078000
[    0.726997] pci 0000:00:16.0: reg 0x10: [mem 0xfeda6000-0xfeda600f 64b=
it]
[    0.727086] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.727382] pci 0000:00:16.2: [8086:3b66] type 00 class 0x010185
[    0.727407] pci 0000:00:16.2: reg 0x10: [io  0xfe80-0xfe87]
[    0.727418] pci 0000:00:16.2: reg 0x14: [io  0xfe90-0xfe93]
[    0.727428] pci 0000:00:16.2: reg 0x18: [io  0xfea0-0xfea7]
[    0.727438] pci 0000:00:16.2: reg 0x1c: [io  0xfeb0-0xfeb3]
[    0.727448] pci 0000:00:16.2: reg 0x20: [io  0xfef0-0xfeff]
[    0.727793] pci 0000:00:16.3: [8086:3b67] type 00 class 0x070002
[    0.727816] pci 0000:00:16.3: reg 0x10: [io  0xec98-0xec9f]
[    0.727826] pci 0000:00:16.3: reg 0x14: [mem 0xf7fdb000-0xf7fdbfff]
[    0.728191] pci 0000:00:19.0: [8086:10ef] type 00 class 0x020000
[    0.728211] pci 0000:00:19.0: reg 0x10: [mem 0xf7fe0000-0xf7ffffff]
[    0.728219] pci 0000:00:19.0: reg 0x14: [mem 0xf7fdc000-0xf7fdcfff]
[    0.728228] pci 0000:00:19.0: reg 0x18: [io  0xecc0-0xecdf]
[    0.728284] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.728577] pci 0000:00:1a.0: [8086:3b3c] type 00 class 0x0c0320
[    0.728600] pci 0000:00:1a.0: reg 0x10: [mem 0xf7fdd000-0xf7fdd3ff]
[    0.728679] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.728991] pci 0000:00:1b.0: [8086:3b56] type 00 class 0x040300
[    0.729013] pci 0000:00:1b.0: reg 0x10: [mem 0xff87c000-0xff87ffff 64b=
it]
[    0.729084] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.729381] pci 0000:00:1c.0: [8086:3b42] type 01 class 0x060400
[    0.729460] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.729779] pci 0000:00:1c.4: [8086:3b4a] type 01 class 0x060400
[    0.729858] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.730176] pci 0000:00:1d.0: [8086:3b34] type 00 class 0x0c0320
[    0.730199] pci 0000:00:1d.0: reg 0x10: [mem 0xf7fde000-0xf7fde3ff]
[    0.730278] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.730585] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.730942] pci 0000:00:1f.0: [8086:3b0a] type 00 class 0x060100
[    0.731343] pci 0000:00:1f.2: [8086:3b22] type 00 class 0x010601
[    0.731362] pci 0000:00:1f.2: reg 0x10: [io  0xfe00-0xfe07]
[    0.731370] pci 0000:00:1f.2: reg 0x14: [io  0xfe10-0xfe13]
[    0.731377] pci 0000:00:1f.2: reg 0x18: [io  0xfe20-0xfe27]
[    0.731385] pci 0000:00:1f.2: reg 0x1c: [io  0xfe30-0xfe33]
[    0.731393] pci 0000:00:1f.2: reg 0x20: [io  0xfec0-0xfedf]
[    0.731401] pci 0000:00:1f.2: reg 0x24: [mem 0xff870000-0xff8707ff]
[    0.731441] pci 0000:00:1f.2: PME# supported from D3hot
[    0.731730] pci 0000:00:1f.3: [8086:3b30] type 00 class 0x0c0500
[    0.731749] pci 0000:00:1f.3: reg 0x10: [mem 0xf7fdf000-0xf7fdf0ff 64b=
it]
[    0.731768] pci 0000:00:1f.3: reg 0x20: [io  0xece0-0xecff]
[    0.732098] pci 0000:01:00.0: [1002:95c5] type 00 class 0x030000
[    0.732118] pci 0000:01:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64b=
it pref]
[    0.732129] pci 0000:01:00.0: reg 0x18: [mem 0xf7df0000-0xf7dfffff 64b=
it]
[    0.732136] pci 0000:01:00.0: reg 0x20: [io  0xdc00-0xdcff]
[    0.732149] pci 0000:01:00.0: reg 0x30: [mem 0xf7e00000-0xf7e1ffff pre=
f]
[    0.732156] pci 0000:01:00.0: enabling Extended Tags
[    0.732190] pci 0000:01:00.0: supports D1 D2
[    0.732247] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.732251] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    0.732255] pci 0000:00:03.0:   bridge window [mem 0xf7d00000-0xf7efff=
ff]
[    0.732260] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffff=
ff 64bit pref]
[    0.732297] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.732342] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.732371] pci_bus 0000:04: extended config space not accessible
[    0.732421] pci 0000:00:1e.0: PCI bridge to [bus 04] (subtractive deco=
de)
[    0.732430] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7 windo=
w] (subtractive decode)
[    0.732434] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff windo=
w] (subtractive decode)
[    0.732437] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bff=
ff window] (subtractive decode)
[    0.732440] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000eff=
ff window] (subtractive decode)
[    0.732444] pci 0000:00:1e.0:   bridge window [mem 0x000f0000-0x000fff=
ff window] (subtractive decode)
[    0.732447] pci 0000:00:1e.0:   bridge window [mem 0xdb800000-0xf7ffff=
ff window] (subtractive decode)
[    0.732450] pci 0000:00:1e.0:   bridge window [mem 0xff87c000-0xff87ff=
ff window] (subtractive decode)
[    0.732454] pci 0000:00:1e.0:   bridge window [mem 0xff870000-0xff8707=
ff window] (subtractive decode)
[    0.732457] pci 0000:00:1e.0:   bridge window [mem 0xfed20000-0xfed9ff=
ff window] (subtractive decode)
[    0.732460] pci 0000:00:1e.0:   bridge window [mem 0xfeda6000-0xfeda6f=
ff window] (subtractive decode)
[    0.732464] pci 0000:00:1e.0:   bridge window [mem 0xfeda7000-0xfeda7f=
ff window] (subtractive decode)
[    0.745588] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 1=
2 15)
[    0.746500] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 1=
2 15)
[    0.747410] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 1=
2 15)
[    0.748336] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[    0.749271] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[    0.750178] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 1=
2 15)
[    0.751110] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12=
 15) *0, disabled.
[    0.752018] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 9 10 11 1=
2 15)
[    0.752541] iommu: Default domain type: Passthrough=20
[    0.752541] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.752541] pci 0000:01:00.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dio+mem,locks=3Dnone
[    0.752541] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.752541] vgaarb: loaded
[    0.752541] SCSI subsystem initialized
[    0.752541] libata version 3.00 loaded.
[    0.752541] pps_core: LinuxPPS API ver. 1 registered
[    0.752541] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
[    0.752541] PTP clock support registered
[    0.752541] EDAC MC: Ver: 3.0.0
[    0.752541] PCI: Using ACPI for IRQ routing
[    0.753715] PCI: Discovered peer bus 3f
[    0.753717] PCI: root bus 3f: using default resources
[    0.753717] PCI: Probing PCI hardware (bus 3f)
[    0.753735] PCI host bridge to bus 0000:3f
[    0.753738] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    0.753740] pci_bus 0000:3f: root bus resource [mem 0x00000000-0xfffff=
ffff]
[    0.753743] pci_bus 0000:3f: No busn resource found for root bus, will=
 use [bus 3f-ff]
[    0.753747] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] unde=
r domain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.753754] pci 0000:3f:00.0: [8086:2c51] type 00 class 0x060000
[    0.753793] pci 0000:3f:00.1: [8086:2c81] type 00 class 0x060000
[    0.753833] pci 0000:3f:02.0: [8086:2c90] type 00 class 0x060000
[    0.753869] pci 0000:3f:02.1: [8086:2c91] type 00 class 0x060000
[    0.753906] pci 0000:3f:03.0: [8086:2c98] type 00 class 0x060000
[    0.753945] pci 0000:3f:03.1: [8086:2c99] type 00 class 0x060000
[    0.753982] pci 0000:3f:03.4: [8086:2c9c] type 00 class 0x060000
[    0.754019] pci 0000:3f:04.0: [8086:2ca0] type 00 class 0x060000
[    0.754055] pci 0000:3f:04.1: [8086:2ca1] type 00 class 0x060000
[    0.754091] pci 0000:3f:04.2: [8086:2ca2] type 00 class 0x060000
[    0.754127] pci 0000:3f:04.3: [8086:2ca3] type 00 class 0x060000
[    0.754164] pci 0000:3f:05.0: [8086:2ca8] type 00 class 0x060000
[    0.754199] pci 0000:3f:05.1: [8086:2ca9] type 00 class 0x060000
[    0.754238] pci 0000:3f:05.2: [8086:2caa] type 00 class 0x060000
[    0.754275] pci 0000:3f:05.3: [8086:2cab] type 00 class 0x060000
[    0.754320] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3=
f
[    0.754323] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under d=
omain [bus 00-ff] (conflicts with (null) [bus 00-ff])
[    0.754330] PCI: pci_cache_line_size set to 64 bytes
[    0.754381] Expanded resource Reserved due to conflict with PCI Bus 00=
00:00
[    0.754384] e820: reserve RAM buffer [mem 0x0009e400-0x0009ffff]
[    0.754385] e820: reserve RAM buffer [mem 0xdb6cfc00-0xdbffffff]
[    0.754477] NetLabel: Initializing
[    0.754479] NetLabel:  domain hash size =3D 128
[    0.754481] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.754498] NetLabel:  unlabeled traffic allowed by default
[    0.756452] hpet: 8 channels of 5 reserved for per-cpu timers
[    0.756457] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 24, 25, 26, 27, 2=
8
[    0.756461] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.756461] clocksource: Switched to clocksource tsc-early
[    0.768896] VFS: Disk quotas dquot_6.6.0
[    0.768917] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[    0.769012] AppArmor: AppArmor Filesystem Enabled
[    0.769030] pnp: PnP ACPI init
[    0.771517] system 00:00: [io  0x0800-0x085f] has been reserved
[    0.771522] system 00:00: [io  0x0c00-0x0c7f] has been reserved
[    0.771525] system 00:00: [io  0x0860-0x08ff] has been reserved
[    0.771531] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (acti=
ve)
[    0.771763] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)=

[    0.778415] pnp 00:02: [dma 0 disabled]
[    0.778476] pnp 00:02: Plug and Play ACPI device, IDs PNP0401 (active)=

[    0.783033] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)=

[    0.792386] pnp: PnP ACPI: found 4 devices
[    0.798029] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
[    0.798068] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bu=
s 02] add_size 1000
[    0.798073] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 02] add_size 200000 add_align 100000
[    0.798079] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff=
] to [bus 02] add_size 200000 add_align 100000
[    0.798083] pci 0000:00:1c.4: bridge window [io  0x1000-0x0fff] to [bu=
s 03] add_size 1000
[    0.798087] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff=
 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.798091] pci 0000:00:1c.4: bridge window [mem 0x00100000-0x000fffff=
] to [bus 03] add_size 200000 add_align 100000
[    0.798100] pci 0000:00:1c.0: BAR 14: assigned [mem 0xdc000000-0xdc1ff=
fff]
[    0.798107] pci 0000:00:1c.0: BAR 15: assigned [mem 0xdc200000-0xdc3ff=
fff 64bit pref]
[    0.798111] pci 0000:00:1c.4: BAR 14: assigned [mem 0xdc400000-0xdc5ff=
fff]
[    0.798117] pci 0000:00:1c.4: BAR 15: assigned [mem 0xdc600000-0xdc7ff=
fff 64bit pref]
[    0.798121] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.798124] pci 0000:00:1c.4: BAR 13: assigned [io  0x2000-0x2fff]
[    0.798128] pci 0000:00:03.0: PCI bridge to [bus 01]
[    0.798131] pci 0000:00:03.0:   bridge window [io  0xd000-0xdfff]
[    0.798136] pci 0000:00:03.0:   bridge window [mem 0xf7d00000-0xf7efff=
ff]
[    0.798140] pci 0000:00:03.0:   bridge window [mem 0xe0000000-0xefffff=
ff 64bit pref]
[    0.798145] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.798149] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
[    0.798153] pci 0000:00:1c.0:   bridge window [mem 0xdc000000-0xdc1fff=
ff]
[    0.798158] pci 0000:00:1c.0:   bridge window [mem 0xdc200000-0xdc3fff=
ff 64bit pref]
[    0.798164] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.798167] pci 0000:00:1c.4:   bridge window [io  0x2000-0x2fff]
[    0.798172] pci 0000:00:1c.4:   bridge window [mem 0xdc400000-0xdc5fff=
ff]
[    0.798176] pci 0000:00:1c.4:   bridge window [mem 0xdc600000-0xdc7fff=
ff 64bit pref]
[    0.798182] pci 0000:00:1e.0: PCI bridge to [bus 04]
[    0.798192] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.798195] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.798198] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    0.798200] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000effff win=
dow]
[    0.798203] pci_bus 0000:00: resource 8 [mem 0x000f0000-0x000fffff win=
dow]
[    0.798206] pci_bus 0000:00: resource 9 [mem 0xdb800000-0xf7ffffff win=
dow]
[    0.798209] pci_bus 0000:00: resource 10 [mem 0xff87c000-0xff87ffff wi=
ndow]
[    0.798211] pci_bus 0000:00: resource 11 [mem 0xff870000-0xff8707ff wi=
ndow]
[    0.798214] pci_bus 0000:00: resource 12 [mem 0xfed20000-0xfed9ffff wi=
ndow]
[    0.798217] pci_bus 0000:00: resource 13 [mem 0xfeda6000-0xfeda6fff wi=
ndow]
[    0.798219] pci_bus 0000:00: resource 14 [mem 0xfeda7000-0xfeda7fff wi=
ndow]
[    0.798222] pci_bus 0000:01: resource 0 [io  0xd000-0xdfff]
[    0.798225] pci_bus 0000:01: resource 1 [mem 0xf7d00000-0xf7efffff]
[    0.798227] pci_bus 0000:01: resource 2 [mem 0xe0000000-0xefffffff 64b=
it pref]
[    0.798230] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
[    0.798233] pci_bus 0000:02: resource 1 [mem 0xdc000000-0xdc1fffff]
[    0.798235] pci_bus 0000:02: resource 2 [mem 0xdc200000-0xdc3fffff 64b=
it pref]
[    0.798238] pci_bus 0000:03: resource 0 [io  0x2000-0x2fff]
[    0.798241] pci_bus 0000:03: resource 1 [mem 0xdc400000-0xdc5fffff]
[    0.798243] pci_bus 0000:03: resource 2 [mem 0xdc600000-0xdc7fffff 64b=
it pref]
[    0.798247] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7 window]
[    0.798249] pci_bus 0000:04: resource 5 [io  0x0d00-0xffff window]
[    0.798252] pci_bus 0000:04: resource 6 [mem 0x000a0000-0x000bffff win=
dow]
[    0.798254] pci_bus 0000:04: resource 7 [mem 0x000c0000-0x000effff win=
dow]
[    0.798257] pci_bus 0000:04: resource 8 [mem 0x000f0000-0x000fffff win=
dow]
[    0.798260] pci_bus 0000:04: resource 9 [mem 0xdb800000-0xf7ffffff win=
dow]
[    0.798262] pci_bus 0000:04: resource 10 [mem 0xff87c000-0xff87ffff wi=
ndow]
[    0.798265] pci_bus 0000:04: resource 11 [mem 0xff870000-0xff8707ff wi=
ndow]
[    0.798268] pci_bus 0000:04: resource 12 [mem 0xfed20000-0xfed9ffff wi=
ndow]
[    0.798271] pci_bus 0000:04: resource 13 [mem 0xfeda6000-0xfeda6fff wi=
ndow]
[    0.798273] pci_bus 0000:04: resource 14 [mem 0xfeda7000-0xfeda7fff wi=
ndow]
[    0.798313] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    0.798316] pci_bus 0000:3f: resource 5 [mem 0x00000000-0xfffffffff]
[    0.798353] NET: Registered protocol family 2
[    0.798482] tcp_listen_portaddr_hash hash table entries: 8192 (order: =
5, 131072 bytes, linear)
[    0.798536] TCP established hash table entries: 131072 (order: 8, 1048=
576 bytes, linear)
[    0.798816] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s, linear)
[    0.799073] TCP: Hash tables configured (established 131072 bind 65536=
)
[    0.799108] UDP hash table entries: 8192 (order: 6, 262144 bytes, line=
ar)
[    0.799204] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes,=
 linear)
[    0.799359] NET: Registered protocol family 1
[    0.799367] NET: Registered protocol family 44
[    0.801133] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0=
x000c0000-0x000dffff]
[    0.801158] PCI: CLS 64 bytes, default 64
[    0.801196] Trying to unpack rootfs image as initramfs...
[    1.012379] random: fast init done
[    1.012380] random: fast init done
[    2.179065] Freeing initrd memory: 16240K
[    2.204401] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.204411] software IO TLB: mapped [mem 0xd76cf000-0xdb6cf000] (64MB)=

[    2.204728] check: Scanning for low memory corruption every 60 seconds=

[    2.205080] Initialise system trusted keyrings
[    2.205090] Key type blacklist registered
[    2.205128] workingset: timestamp_bits=3D37 max_order=3D22 bucket_orde=
r=3D0
[    2.206405] zbud: loaded
[    2.206802] Platform Keyring initialized
[    2.212785] Key type asymmetric registered
[    2.212789] Asymmetric key parser 'x509' registered
[    2.212797] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 246)
[    2.212848] io scheduler mq-deadline registered
[    2.212852] io scheduler kyber registered
[    2.212884] io scheduler bfq registered
[    2.214539] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
=2E4
[    2.214565] vesafb: mode is 1400x1050x32, linelength=3D5632, pages=3D0=

[    2.214567] vesafb: scrolling: redraw
[    2.214569] vesafb: Truecolor: size=3D0:8:8:8, shift=3D0:16:8:0
[    2.214585] vesafb: framebuffer at 0xe0000000, mapped to 0x(____ptrval=
____), using 5824k, total 5824k
[    2.401412] Console: switching to colour frame buffer device 175x65
[    2.588471] fb0: VESA VGA frame buffer device
[    2.589301] intel_idle: MWAIT substates: 0x1120
[    2.589301] intel_idle: v0.4.1 model 0x1E
[    2.589612] intel_idle: lapic_timer_reliable_states 0x2
[    2.589982] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    2.611633] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
[    2.634807] 0000:00:16.3: ttyS4 at I/O 0xec98 (irq =3D 17, base_baud =3D=
 115200) is a 16550A
[    2.637040] Non-volatile memory driver v1.3
[    2.637983] Linux agpgart interface v0.103
[    2.641429] ahci 0000:00:1f.2: version 3.0
[    2.652068] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 3 Gbps =
0x17 impl SATA mode
[    2.653649] ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp fbs p=
io ems sxs apst=20
[    2.655114] ahci 0000:00:1f.2: port 0 is not capable of FBS
[    2.656156] ahci 0000:00:1f.2: port 1 is not capable of FBS
[    2.657234] ahci 0000:00:1f.2: port 2 is not capable of FBS
[    2.681263] scsi host0: ahci
[    2.682127] scsi host1: ahci
[    2.682971] scsi host2: ahci
[    2.683661] scsi host3: ahci
[    2.684488] scsi host4: ahci
[    2.685189] scsi host5: ahci
[    2.685764] ata1: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870=
100 irq 32
[    2.687139] ata2: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870=
180 irq 32
[    2.688519] ata3: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870=
200 irq 32
[    2.689893] ata4: DUMMY
[    2.690347] ata5: SATA max UDMA/133 abar m2048@0xff870000 port 0xff870=
300 irq 32
[    2.691720] ata6: DUMMY
[    2.692221] i8042: PNP: No PS/2 controller found.
[    2.693108] i8042: Probing ports directly.
[    2.696779] serio: i8042 KBD port at 0x60,0x64 irq 1
[    2.697711] serio: i8042 AUX port at 0x60,0x64 irq 12
[    2.698820] mousedev: PS/2 mouse device common for all mice
[    2.699921] rtc_cmos 00:01: RTC can wake from S4
[    2.701306] rtc_cmos 00:01: registered as rtc0
[    2.702156] rtc_cmos 00:01: alarms up to one day, 242 bytes nvram, hpe=
t irqs
[    2.703460] intel_pstate: CPU model not supported
[    2.705008] ledtrig-cpu: registered to indicate activity on CPUs
[    2.706131] hid: raw HID events driver (C) Jiri Kosina
[    2.707122] drop_monitor: Initializing network drop monitor service
[    2.708494] NET: Registered protocol family 10
[    2.725060] Segment Routing with IPv6
[    2.727380] RAS: Correctable Errors collector initialized.
[    2.728528] microcode: sig=3D0x106e5, pf=3D0x2, revision=3D0xa
[    2.729793] microcode: Microcode Update Driver: v2.2.
[    2.729798] IPI shorthand broadcast: enabled
[    2.822056] sched_clock: Marking stable (2743347249, 78686531)->(28322=
73427, -10239647)
[    2.870064] registered taskstats version 1
[    2.917223] Loading compiled-in X.509 certificates
[    2.964457] Loaded X.509 cert 'openSUSE Secure Boot Signkey: 0332fa9cb=
f0d88bf21924b0de82a09a54d5defc8'
[    3.012993] zswap: loaded using pool lzo/zbud
[    3.024709] ata5: SATA link down (SStatus 0 SControl 300)
[    3.110484] page_owner is disabled
[    3.158629] Key type ._fscrypt registered
[    3.168462] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    3.206711] Key type .fscrypt registered
[    3.208424] tsc: Refined TSC clocksource calibration: 2792.984 MHz
[    3.221347] Key type big_key registered
[    3.228313] Key type encrypted registered
[    3.228316] AppArmor: AppArmor sha1 policy hashing enabled
[    3.228325] ima: No TPM chip found, activating TPM-bypass!
[    3.228330] ima: Allocated hash algorithm: sha256
[    3.228337] ima: No architecture policies found
[    3.228344] evm: Initialising EVM extended attributes:
[    3.228345] evm: security.selinux
[    3.228345] evm: security.apparmor
[    3.228345] evm: security.ima
[    3.228346] evm: security.capability
[    3.228346] evm: HMAC attrs: 0x1
[    3.228680] PM:   Magic number: 12:353:455
[    3.255709] rtc_cmos 00:01: setting system clock to 2020-03-06T00:27:2=
1 UTC (1583454441)
[    3.255727] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.304633] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2=
8425d3d70e, max_idle_ns: 440795282348 ns
[    4.115427] clocksource: Switched to clocksource tsc
[    4.115434] ata2.00: LPM support broken, forcing max_power
[    4.115451] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.253753] ata2.00: supports DRM functions and may not be fully acces=
sible
[    4.300131] ata1.00: ATAPI: TSSTcorp DVD+/-RW TS-H653G, DW10, max UDMA=
/100
[    4.346853] ata1.00: applying bridge limits
[    4.393983] ata2.00: READ LOG DMA EXT failed, trying PIO
[    4.441681] ata3.00: ATA-8: WDC WD5000AAKX-00ERMA0, 15.01H15, max UDMA=
/133
[    4.489851] ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 32),=
 AA
[    4.539040] ata1.00: configured for UDMA/100
[    4.588364] ata2.00: disabling queued TRIM support
[    4.588366] ata2.00: ATA-9: Crucial_CT480M500SSD1, MU03, max UDMA/133
[    4.638834] ata2.00: 937703088 sectors, multi 16: LBA48 NCQ (depth 32)=
, AA
[    4.690407] ata3.00: configured for UDMA/133
[    4.743419] scsi 0:0:0:0: CD-ROM            TSSTcorp DVD+-RW TS-H653G =
DW10 PQ: 0 ANSI: 5
[    4.751923] ata2.00: LPM support broken, forcing max_power
[    4.847876] ata2.00: supports DRM functions and may not be fully acces=
sible
[    4.907335] ata2.00: disabling queued TRIM support
[    4.920543] ata2.00: configured for UDMA/133
[    4.981585] scsi 1:0:0:0: Direct-Access     ATA      Crucial_CT480M50 =
MU03 PQ: 0 ANSI: 5
[    5.035913] ata2.00: Enabling discard_zeroes_data
[    5.089700] scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000AAKX-0 =
1H15 PQ: 0 ANSI: 5
[    5.089745] sd 1:0:0:0: [sda] 937703088 512-byte logical blocks: (480 =
GB/447 GiB)
[    5.144802] sd 2:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 =
GB/466 GiB)
[    5.200051] sd 1:0:0:0: [sda] 4096-byte physical blocks
[    5.200064] sd 1:0:0:0: [sda] Write Protect is off
[    5.255464] sd 2:0:0:0: [sdb] Write Protect is off
[    5.310757] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.310828] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    5.365583] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.365601] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, doesn't support DPO or FUA
[    5.529561] ata2.00: Enabling discard_zeroes_data
[    5.584847]  sda: sda1 sda2 sda3 sda4
[    5.596085]  sdb: sdb1
[    5.639482] ata2.00: Enabling discard_zeroes_data
[    5.745858] sd 2:0:0:0: [sdb] Attached SCSI disk
[    5.746018] sd 1:0:0:0: [sda] supports TCG Opal
[    5.851931] sd 1:0:0:0: [sda] Attached SCSI disk
[    5.905820] Freeing unused decrypted memory: 2040K
[    5.958527] Freeing unused kernel image (initmem) memory: 2148K
[    6.011011] Write protecting the kernel read-only data: 20480k
[    6.064323] Freeing unused kernel image (text/rodata gap) memory: 2044=
K
[    6.117205] Freeing unused kernel image (rodata/data gap) memory: 1696=
K
[    6.168880] Run /init as init process
[    6.228180] systemd[1]: systemd +suse.138.gf8adabc2b1 running in syste=
m mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBC=
RYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -=
IDN2 -IDN +PCRE2 default-hierarchy=3Dhybrid)
[    6.356704] systemd[1]: Detected architecture x86-64.
[    6.410827] systemd[1]: Running in initial RAM disk.
[    6.643256] systemd[1]: Set hostname to <ndcxii>.
[    6.752838] random: systemd: uninitialized urandom read (16 bytes read=
)
[    6.809481] systemd[1]: Reached target Local File Systems.
[    6.920905] random: systemd: uninitialized urandom read (16 bytes read=
)
[    6.977111] systemd[1]: Reached target Slices.
[    7.089518] random: systemd: uninitialized urandom read (16 bytes read=
)
[    7.146634] systemd[1]: Reached target Swap.
[    7.261378] systemd[1]: Reached target Timers.
[    7.378586] systemd[1]: Listening on Journal Socket (/dev/log).
[    7.498834] systemd[1]: Listening on Journal Socket.
[    7.618258] systemd[1]: Listening on udev Control Socket.
[    7.735639] systemd[1]: Listening on udev Kernel Socket.
[    7.852914] urandom_read: 5 callbacks suppressed
[    7.852915] random: systemd: uninitialized urandom read (16 bytes read=
)
[    7.969790] systemd[1]: Reached target Sockets.
[    8.086681] random: systemd: uninitialized urandom read (16 bytes read=
)
[    8.146927] systemd[1]: Started Entropy Daemon based on the HAVEGE alg=
orithm.
[    8.268040] systemd[1]: Starting Create list of static device nodes fo=
r the current kernel...
[    8.393515] systemd[1]: Starting Journal Service...
[    8.487149] random: crng init done
[    8.578029] systemd[1]: Starting Load Kernel Modules...
[    8.638740] alua: device handler registered
[    8.699164] emc: device handler registered
[    8.760094] rdac: device handler registered
[    8.831958] device-mapper: uevent: version 1.0.3
[    8.832030] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialise=
d: dm-devel@redhat.com
[    8.838096] scsi 0:0:0:0: Attached scsi generic sg0 type 5
[    8.838123] sd 1:0:0:0: Attached scsi generic sg1 type 0
[    8.838148] sd 2:0:0:0: Attached scsi generic sg2 type 0
[    9.181396] systemd[1]: Starting Setup Virtual Console...
[    9.304833] systemd[1]: Started Journal Service.
[   11.028462] wmi_bus wmi_bus-PNP0C14:00: WQBC data block query control =
method not found
[   11.090096] scsi host6: ata_generic
[   11.090228] scsi host7: ata_generic
[   11.090282] ata7: PATA max UDMA/100 cmd 0xfe80 ctl 0xfe90 bmdma 0xfef0=
 irq 18
[   11.090283] ata8: PATA max UDMA/100 cmd 0xfea0 ctl 0xfeb0 bmdma 0xfef8=
 irq 18
[   11.092186] ACPI: bus type USB registered
[   11.092210] usbcore: registered new interface driver usbfs
[   11.092221] usbcore: registered new interface driver hub
[   11.092281] usbcore: registered new device driver usb
[   11.101700] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[   11.103034] ehci-pci: EHCI PCI platform driver
[   11.103648] ehci-pci 0000:00:1a.0: EHCI Host Controller
[   11.103655] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bu=
s number 1
[   11.103668] ehci-pci 0000:00:1a.0: debug port 2
[   11.107577] ehci-pci 0000:00:1a.0: cache line size of 64 is not suppor=
ted
[   11.107593] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf7fdd000
[   11.120360] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[   11.120415] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.05
[   11.120416] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[   11.120417] usb usb1: Product: EHCI Host Controller
[   11.120418] usb usb1: Manufacturer: Linux 5.5.6-1-default ehci_hcd
[   11.120419] usb usb1: SerialNumber: 0000:00:1a.0
[   11.120545] hub 1-0:1.0: USB hub found
[   11.120552] hub 1-0:1.0: 3 ports detected
[   11.123081] ehci-pci 0000:00:1d.0: EHCI Host Controller
[   11.123087] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bu=
s number 2
[   11.123099] ehci-pci 0000:00:1d.0: debug port 2
[   11.127022] ehci-pci 0000:00:1d.0: cache line size of 64 is not suppor=
ted
[   11.127326] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7fde000
[   11.138204] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram =
cd/rw xa/form2 cdda tray
[   11.138207] cdrom: Uniform CD-ROM driver Revision: 3.20
[   11.140350] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[   11.140405] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.05
[   11.140406] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
[   11.140407] usb usb2: Product: EHCI Host Controller
[   11.140408] usb usb2: Manufacturer: Linux 5.5.6-1-default ehci_hcd
[   11.140409] usb usb2: SerialNumber: 0000:00:1d.0
[   11.140554] hub 2-0:1.0: USB hub found
[   11.140561] hub 2-0:1.0: 3 ports detected
[   11.436718] sr 0:0:0:0: Attached scsi CD-ROM sr0
[   11.447643] raid6: sse2x4   gen() 10526 MB/s
[   11.508348] usb 1-1: new high-speed USB device number 2 using ehci-pci=

[   11.512305] raid6: sse2x4   xor()  7228 MB/s
[   11.580303] raid6: sse2x2   gen()  6029 MB/s
[   11.598407] usb 2-1: new high-speed USB device number 2 using ehci-pci=

[   11.720420] raid6: sse2x2   xor()  4516 MB/s
[   11.784764] usb 2-1: New USB device found, idVendor=3D8087, idProduct=3D=
0020, bcdDevice=3D 0.00
[   11.880340] raid6: sse2x1   gen()  4879 MB/s
[   11.919784] usb 2-1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[   12.024531] [drm] radeon kernel modesetting enabled.
[   12.077005] raid6: sse2x1   xor()  6279 MB/s
[   12.077006] raid6: using algorithm sse2x4 gen() 10526 MB/s
[   12.077006] raid6: .... xor() 7228 MB/s, rmw enabled
[   12.077007] raid6: using ssse3x2 recovery algorithm
[   12.129885] hub 2-1:1.0: USB hub found
[   12.182197] checking generic (e0000000 5b0000) vs hw (e0000000 1000000=
0)
[   12.234549] hub 2-1:1.0: 8 ports detected
[   12.286192] fb0: switching to radeondrmfb from VESA VGA
[   12.337652] xor: measuring software checksum speed
[   12.337933] usb 1-1: New USB device found, idVendor=3D8087, idProduct=3D=
0020, bcdDevice=3D 0.00
[   12.337935] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Ser=
ialNumber=3D0
[   12.338174] hub 1-1:1.0: USB hub found
[   12.338258] hub 1-1:1.0: 6 ports detected
[   12.636391] usb 2-1.7: new low-speed USB device number 3 using ehci-pc=
i
[   12.720343]    prefetch64-sse: 14973.000 MB/sec
[   12.860804] usb 2-1.7: New USB device found, idVendor=3D413c, idProduc=
t=3D2105, bcdDevice=3D 3.52
[   12.916413]    generic_sse: 14543.000 MB/sec
[   12.926422] usb 2-1.7: New USB device strings: Mfr=3D1, Product=3D2, S=
erialNumber=3D0
[   12.975211] xor: using function: prefetch64-sse (14973.000 MB/sec)
[   13.759987] Btrfs loaded, crc32c=3Dcrc32c-intel, assert=3Don
[   13.802232] usb 2-1.7: Product: Dell USB Keyboard
[   13.949409] BTRFS: device fsid 25ad4760-1e0e-439b-b5ac-bd506408795b de=
vid 1 transid 3355919 /dev/sda4 scanned by systemd-udevd (391)
[   13.997382] usb 2-1.7: Manufacturer: Dell
[   14.047718] BTRFS: device fsid b914656e-7537-465b-a2ba-d08c6eea908a de=
vid 1 transid 731254 /dev/sda1 scanned by systemd-udevd (365)
[   14.306319] usbcore: registered new interface driver usbhid
[   14.349528] BTRFS: device fsid e7b29c18-4707-48a4-8c29-dd4dd70378b8 de=
vid 1 transid 6596908 /dev/sda2 scanned by systemd-udevd (385)
[   14.399780] usbhid: USB HID core driver
[   14.953108] Console: switching to colour dummy device 80x25
[   14.953256] radeon 0000:01:00.0: vgaarb: deactivate vga console
[   14.953923] [drm] initializing kernel modesetting (RV620 0x1002:0x95C5=
 0x1028:0x0342 0x00).
[   14.953992] ATOM BIOS: 113
[   14.954011] radeon 0000:01:00.0: VRAM: 256M 0x0000000000000000 - 0x000=
000000FFFFFFF (256M used)
[   14.954015] radeon 0000:01:00.0: GTT: 512M 0x0000000010000000 - 0x0000=
00002FFFFFFF
[   14.954020] [drm] Detected VRAM RAM=3D256M, BAR=3D256M
[   14.954022] [drm] RAM width 64bits DDR
[   14.954075] [TTM] Zone  kernel: Available graphics memory: 8156746 KiB=

[   14.954078] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB=

[   14.954080] [TTM] Initializing pool allocator
[   14.954085] [TTM] Initializing DMA pool allocator
[   14.954102] [drm] radeon: 256M of VRAM memory ready
[   14.954105] [drm] radeon: 512M of GTT memory ready.
[   14.954117] [drm] Loading RV620 Microcode
[   14.954163] [drm] Internal thermal controller with fan control
[   14.954190] [drm] radeon: power management initialized
[   14.954236] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   14.954770] [drm] enabling PCIE gen 2 link speeds, disable with radeon=
=2Epcie_gen2=3D0
[   14.956141] input: Dell Dell USB Keyboard as /devices/pci0000:00/0000:=
00:1d.0/usb2/2-1/2-1.7/2-1.7:1.0/0003:413C:2105.0001/input/input3
[   14.963988] [drm] PCIE GART of 512M enabled (table at 0x00000000001420=
00).
[   14.964037] radeon 0000:01:00.0: WB enabled
[   14.964041] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0=
x0000000010000c00 and cpu addr 0x0000000021a5c8d1
[   14.964383] radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0=
x00000000000521d0 and cpu addr 0x00000000926be5f3
[   14.964388] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
=2E
[   14.964390] [drm] Driver supports precise vblank timestamp query.
[   14.964392] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[   14.964428] radeon 0000:01:00.0: radeon: using MSI.
[   14.964451] [drm] radeon: irq initialized.
[   14.996271] [drm] ring test on 0 succeeded in 1 usecs
[   15.012490] hid-generic 0003:413C:2105.0001: input,hidraw0: USB HID v1=
=2E10 Keyboard [Dell Dell USB Keyboard] on usb-0000:00:1d.0-1.7/input0
[   15.171418] [drm] ring test on 5 succeeded in 1 usecs
[   15.171427] [drm] UVD initialized successfully.
[   15.171526] [drm] ib test on ring 0 succeeded in 0 usecs
[   15.171567] BTRFS info (device sda1): disk space caching is enabled
[   15.350410] BTRFS info (device sda1): enabling ssd optimizations
[   15.547292] BTRFS info (device sda1): disk space caching is enabled
[   15.562981] BTRFS info (device sda1): disk space caching is enabled
[   15.848497] [drm] ib test on ring 5 succeeded
[   15.848788] [drm] Radeon Display Connectors
[   15.848791] [drm] Connector 0:
[   15.848793] [drm]   DIN-1
[   15.848794] [drm]   Encoders:
[   15.848796] [drm]     TV1: INTERNAL_KLDSCP_DAC2
[   15.848798] [drm] Connector 1:
[   15.848799] [drm]   DVI-I-1
[   15.848801] [drm]   HPD1
[   15.848803] [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7=
e6c 0x7e6c
[   15.848805] [drm]   Encoders:
[   15.848806] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   15.848808] [drm]     DFP2: INTERNAL_KLDSCP_LVTMA
[   15.848810] [drm] Connector 2:
[   15.848811] [drm]   DVI-I-2
[   15.848813] [drm]   HPD2
[   15.848815] [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7=
e2c 0x7e2c
[   15.848817] [drm]   Encoders:
[   15.848818] [drm]     CRT2: INTERNAL_KLDSCP_DAC2
[   15.848820] [drm]     DFP1: INTERNAL_UNIPHY
[   15.910987] [drm] fb mappable at 0xE0243000
[   15.910990] [drm] vram apper at 0xE0000000
[   15.910992] [drm] size 8294400
[   15.910993] [drm] fb depth is 24
[   15.910995] [drm]    pitch is 7680
[   15.911158] fbcon: radeondrmfb (fb0) is primary device
[   15.944520] Console: switching to colour frame buffer device 240x67
[   15.947976] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
[   15.960521] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:00.0 =
on minor 0
[   16.103372] systemd-journald[262]: Received SIGTERM from PID 1 (system=
d).
[   16.244046] systemd[1]: systemd +suse.138.gf8adabc2b1 running in syste=
m mode. (+PAM -AUDIT +SELINUX -IMA +APPARMOR -SMACK +SYSVINIT +UTMP +LIBC=
RYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -=
IDN2 -IDN +PCRE2 default-hierarchy=3Dhybrid)
[   16.244316] systemd[1]: Detected architecture x86-64.
[   16.245858] systemd[1]: Set hostname to <ndcxii>.
[   16.556422] systemd[1]: /usr/lib/systemd/system/isdn.service:3: Failed=
 to add dependency on hylafax-hfaxd, ignoring: Invalid argument
[   16.558131] systemd[1]: /usr/lib/systemd/system/ntpd.service:15: PIDFi=
le=3D references a path below legacy directory /var/run/, updating /var/r=
un/ntp/ntpd.pid =E2=86=92 /run/ntp/ntpd.pid; please update the unit file =
accordingly.
[   16.564653] systemd[1]: /usr/lib/systemd/system/display-manager.servic=
e:12: PIDFile=3D references a path below legacy directory /var/run/, upda=
ting /var/run/displaymanager.pid =E2=86=92 /run/displaymanager.pid; pleas=
e update the unit file accordingly.
[   16.603151] systemd[1]: /usr/lib/systemd/system/pcscd.socket:5: Listen=
Stream=3D references a path below legacy directory /var/run/, updating /v=
ar/run/pcscd/pcscd.comm =E2=86=92 /run/pcscd/pcscd.comm; please update th=
e unit file accordingly.
[   16.674378] systemd[1]: haveged.service: Main process exited, code=3De=
xited, status=3D1/FAILURE
[   16.674529] systemd[1]: haveged.service: Failed with result 'exit-code=
'.
[   16.674872] systemd[1]: Stopped Entropy Daemon based on the HAVEGE alg=
orithm.
[   16.675210] systemd[1]: initrd-switch-root.service: Succeeded.
[   16.675545] systemd[1]: Stopped Switch Root.
[   16.675815] systemd[1]: systemd-journald.service: Scheduled restart jo=
b, restart counter is at 1.
[   16.676090] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   16.676372] systemd[1]: Created slice User and Session Slice.
[   16.679584] systemd[1]: Set up automount Arbitrary Executable File For=
mats File System Automount Point.
[   16.682567] systemd[1]: Reached target Login Prompts.
[   16.684157] systemd[1]: Stopped target Switch Root.
[   16.685753] systemd[1]: Stopped target Initrd File Systems.
[   16.687365] systemd[1]: Stopped target Initrd Root File System.
[   16.691206] systemd[1]: Reached target Remote File Systems.
[   16.695102] systemd[1]: Reached target Slices.
[   16.696807] systemd[1]: Reached target System Time Set.
[   16.700675] systemd[1]: Listening on Device-mapper event daemon FIFOs.=

[   16.704687] systemd[1]: Listening on LVM2 poll daemon socket.
[   16.709545] systemd[1]: Listening on Process Core Dump Socket.
[   16.711943] systemd[1]: Listening on initctl Compatibility Named Pipe.=

[   16.715727] systemd[1]: Listening on udev Control Socket.
[   16.719936] systemd[1]: Listening on udev Kernel Socket.
[   16.724386] systemd[1]: Activating swap /dev/disk/by-id/ata-Crucial_CT=
480M500SSD1_1344095684C1-part3...
[   16.728573] systemd[1]: Mounting Huge Pages File System...
[   16.732658] systemd[1]: Mounting POSIX Message Queue File System...
[   16.736539] systemd[1]: Mounting Kernel Debug File System...
[   16.740445] systemd[1]: Starting Create list of static device nodes fo=
r the current kernel...
[   16.744255] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots=
 etc. using dmeventd or progress polling...
[   16.747675] systemd[1]: plymouth-start.service: Succeeded.
[   16.747769] systemd[1]: Stopped Show Plymouth Boot Screen.
[   16.753446] systemd[1]: Condition check resulted in Dispatch Password =
Requests to Console Directory Watch being skipped.
[   16.753469] systemd[1]: Reached target Local Encrypted Volumes.
[   16.760369] Adding 20973564k swap on /dev/sda3.  Priority:-2 extents:1=
 across:20973564k SSFS
[   16.760596] systemd[1]: Starting Set Up Additional Binary Formats...
[   16.765511] systemd[1]: systemd-fsck-root.service: Succeeded.
[   16.765849] systemd[1]: Stopped File System Check on Root Device.
[   16.770997] systemd[1]: Stopped Journal Service.
[   16.776098] systemd[1]: Starting Journal Service...
[   16.780202] systemd[1]: Starting Load Kernel Modules...
[   16.784004] systemd[1]: Starting Remount Root and Kernel File Systems.=
=2E.
[   16.787744] systemd[1]: Starting udev Coldplug all Devices...
[   16.791641] systemd[1]: Starting Setup Virtual Console...
[   16.792861] BTRFS info (device sda1): disk space caching is enabled
[   16.797466] systemd[1]: sysroot.mount: Succeeded.
[   16.799023] systemd[1]: Activated swap /dev/disk/by-id/ata-Crucial_CT4=
80M500SSD1_1344095684C1-part3.
[   16.803776] systemd[1]: Mounted Huge Pages File System.
[   16.807422] systemd[1]: Mounted POSIX Message Queue File System.
[   16.810837] systemd[1]: Mounted Kernel Debug File System.
[   16.814793] systemd[1]: Started Create list of static device nodes for=
 the current kernel.
[   16.818535] systemd[1]: Started Load Kernel Modules.
[   16.822131] systemd[1]: Started Remount Root and Kernel File Systems.
[   16.826085] systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automou=
nt request for /proc/sys/fs/binfmt_misc, triggered by 563 (systemd-binfmt=
)
[   16.826513] systemd[1]: Reached target Swap.
[   16.831829] systemd[1]: Mounting Arbitrary Executable File Formats Fil=
e System...
[   16.835751] systemd[1]: Condition check resulted in FUSE Control File =
System being skipped.
[   16.835897] systemd[1]: Condition check resulted in Kernel Configurati=
on File System being skipped.
[   16.835930] systemd[1]: Condition check resulted in First Boot Wizard =
being skipped.
[   16.837456] systemd[1]: Condition check resulted in Rebuild Hardware D=
atabase being skipped.
[   16.838621] systemd[1]: Starting Apply Kernel Variables...
[   16.847322] systemd[1]: Condition check resulted in Create System User=
s being skipped.
[   16.848556] systemd[1]: Starting Create Static Device Nodes in /dev...=

[   16.855742] systemd[1]: Mounted Arbitrary Executable File Formats File=
 System.
[   16.861356] systemd[1]: Started Set Up Additional Binary Formats.
[   16.869733] systemd[1]: Started Apply Kernel Variables.
[   16.877067] systemd[1]: Started Create Static Device Nodes in /dev.
[   16.880126] systemd[1]: Starting udev Kernel Device Manager...
[   16.894176] systemd[1]: Started udev Coldplug all Devices.
[   16.897563] systemd[1]: Starting udev Wait for Complete Device Initial=
ization...
[   16.901446] systemd[1]: systemd-vconsole-setup.service: Succeeded.
[   16.901927] systemd[1]: Started Setup Virtual Console.
[   17.060282] systemd[1]: Started Journal Service.
[   17.386725] ACPI Warning: SystemIO range 0x0000000000000828-0x00000000=
0000082F conflicts with OpRegion 0x0000000000000828-0x000000000000082D (\=
GLBC) (20191018/utaddress-204)
[   17.389406] ACPI Warning: SystemIO range 0x0000000000000828-0x00000000=
0000082F conflicts with OpRegion 0x000000000000082A-0x000000000000082A (\=
SACT) (20191018/utaddress-204)
[   17.391904] ACPI Warning: SystemIO range 0x0000000000000828-0x00000000=
0000082F conflicts with OpRegion 0x0000000000000828-0x0000000000000828 (\=
SSTS) (20191018/utaddress-204)
[   17.394434] ACPI: If an ACPI driver is available for this device, you =
should use it instead of the native driver
[   17.398145] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   17.405938] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0C:00/input/input4
[   17.408704] ACPI: Power Button [VBTN]
[   17.410946] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input5
[   17.413599] ACPI: Power Button [PWRF]
[   17.430968] EDAC MC0: Giving out device to module i7core_edac.c contro=
ller i7 core #0: DEV 0000:3f:03.0 (INTERRUPT)
[   17.434648] EDAC PCI0: Giving out device to module i7core_edac control=
ler EDAC PCI controller: DEV 0000:3f:03.0 (POLLED)
[   17.444102] EDAC i7core: Driver loaded, 1 memory controller(s) found.
[   17.453701] input: PC Speaker as /devices/platform/pcspkr/input/input6=

[   17.454035] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   17.521137] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   17.523907] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   17.537722] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) =
set to dynamic conservative mode
[   17.540750] dcdbas dcdbas: Dell Systems Management Base Driver (versio=
n 5.6.0-3.3)
[   17.645346] parport_pc 00:02: reported by Plug and Play ACPI
[   17.648189] parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PC=
SPP,TRISTATE,COMPAT,EPP,ECP]
[   17.656543] dell-smbios A80593CE-A997-11DA-B012-B622A1EF5492: WMI SMBI=
OS userspace interface not supported(0), try upgrading to a newer BIOS
[   17.703327] input: Dell WMI hotkeys as /devices/platform/PNP0C14:00/wm=
i_bus/wmi_bus-PNP0C14:00/9DBB5994-A997-11DA-B012-B622A1EF5492/input/input=
7
[   17.708275] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work prop=
erly. Using workaround
[   17.735824] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) b=
8:ac:6f:ac:ec:6f
[   17.738481] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connec=
tion
[   17.741654] e1000e 0000:00:19.0 eth0: MAC: 9, PHY: 9, PBA No: A002FF-0=
FF
[   17.746763] gpio_ich gpio_ich.2.auto: GPIO from 436 to 511
[   17.749353] iTCO_vendor_support: vendor-support=3D0
[   17.753498] ppdev: user-space parallel port driver
[   17.756063] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   17.759306] snd_hda_codec_realtek hdaudioC0D0: ALC269VB: SKU not ready=
 0x411111f0
[   17.759548] iTCO_wdt: Found a Q57 TCO device (Version=3D2, TCOBASE=3D0=
x0860)
[   17.764448] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[   17.772317] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB=
: line_outs=3D1 (0x1b/0x0/0x0/0x0/0x0) type:line
[   17.772320] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=3D1 (0x=
14/0x0/0x0/0x0/0x0)
[   17.772322] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=3D1 (0x21/0x=
0/0x0/0x0/0x0)
[   17.772323] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=3D0x0=

[   17.772324] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[   17.772327] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=3D0x19
[   17.772328] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=3D0x18
[   17.796511] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1=
b.0/sound/card0/input8
[   17.796593] input: HDA Intel MID Rear Mic as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input9
[   17.796668] input: HDA Intel MID Front Mic as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input10
[   17.796742] input: HDA Intel MID Line Out as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input11
[   17.796814] input: HDA Intel MID Front Headphone as /devices/pci0000:0=
0/0000:00:1b.0/sound/card0/input12
[   17.822944] e1000e 0000:00:19.0 em1: renamed from eth0
[   17.928078] BTRFS info (device sda4): disk space caching is enabled
[   17.968998] pktcdvd: pktcdvd0: writer mapped to sr0
[   18.044561] BTRFS info (device sda4): enabling ssd optimizations
[   18.052044] BTRFS info (device sda2): disk space caching is enabled
[   18.067344] BTRFS info (device sda2): enabling ssd optimizations
[   18.070516] BTRFS info (device sda2): checking UUID tree
[   18.072912] BTRFS critical (device sda2): corrupt leaf: root=3D5 block=
=3D14720090112 slot=3D44 ino=3D131072, invalid inode generation: has 1844=
6744073709551492 expect [0, 6596909]
[   18.075911] BTRFS error (device sda2): block=3D14720090112 read time t=
ree block corruption detected
[   18.088293] EXT4-fs (sdb1): mounted filesystem with ordered data mode.=
 Opts: (null)
[   18.283981] audit: type=3D1400 audit(1583454456.550:2): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"ping" pid=
=3D818 comm=3D"apparmor_parser"
[   18.349656] audit: type=3D1400 audit(1583454456.618:3): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"ghostscri=
pt" pid=3D834 comm=3D"apparmor_parser"
[   18.352233] audit: type=3D1400 audit(1583454456.618:4): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"ghostscri=
pt///usr/bin/hpijs" pid=3D834 comm=3D"apparmor_parser"
[   18.405147] audit: type=3D1400 audit(1583454456.674:5): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"lsb_relea=
se" pid=3D847 comm=3D"apparmor_parser"
[   18.438577] audit: type=3D1400 audit(1583454456.706:6): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_mo=
dprobe" pid=3D854 comm=3D"apparmor_parser"
[   18.441094] audit: type=3D1400 audit(1583454456.706:7): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"nvidia_mo=
dprobe//kmod" pid=3D854 comm=3D"apparmor_parser"
[   18.465972] audit: type=3D1400 audit(1583454456.734:8): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"klogd" pi=
d=3D861 comm=3D"apparmor_parser"
[   18.497917] audit: type=3D1400 audit(1583454456.766:9): apparmor=3D"ST=
ATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"syslog-ng=
" pid=3D868 comm=3D"apparmor_parser"
[   18.528874] audit: type=3D1400 audit(1583454456.798:10): apparmor=3D"S=
TATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"syslogd"=
 pid=3D875 comm=3D"apparmor_parser"
[   18.564105] audit: type=3D1400 audit(1583454456.830:11): apparmor=3D"S=
TATUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin=
/lessopen.sh" pid=3D885 comm=3D"apparmor_parser"

--------------29DA2D0F28ED13FCB8204740--
