Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22895972F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 09:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfHUHF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 03:05:57 -0400
Received: from phi.wiserhosting.co.uk ([77.245.66.218]:41782 "EHLO
        phi.wiserhosting.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfHUHF5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 03:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D7Lj42G4ODW67ZiIxbSc01Z1ty8Qp8Q9WdvT7jr4bhc=; b=lAZH2IwC68WYepDQEKrpw761Pa
        zt4ipkOMP1N/WOWQfeFJlTzIjw0OaqTQJkjucfced7Rxrz7tYJZTDi01PDeD7GBcadBTEw5JdmrSM
        7/8WcyPPT3pcBjJf9Vz7zAVgXRDOR99ml//VAlb3ufO+WI8H6loBVLH/lIP3HjlPDQi9DArcr89GQ
        OQyDPS9j2AOMa+Q7Y+U+7qWESiJrpWKc8npCWgsq6L6Ngm/lHoLChr9f/JZKH6tYD2KJ6eCo7t9iS
        G8MjY852F0bzNdZXeIHRlM1PsWEm6y8Fmjg9437FvrhmutETuETmj0AE6NwGKSfLtu3gzv9BzX8S2
        HV66+CeQ==;
Received: from cpc75874-ando7-2-0-cust841.15-1.cable.virginm.net ([86.12.75.74]:35206 helo=[172.16.100.107])
        by phi.wiserhosting.co.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <pete@petezilla.co.uk>)
        id 1i0Kgj-00A0aM-4o; Wed, 21 Aug 2019 08:05:49 +0100
Subject: Re: Chasing IO errors. BTRFS: error (device dm-2) in
 btrfs_run_delayed_refs:2907: errno=-5 IO failure
To:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        quwenruo.btrfs@gmx.com
References: <fc2b166a-4466-4a5a-ee88-da5e57ee89b6@petezilla.co.uk>
 <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
From:   Peter Chant <pete@petezilla.co.uk>
Message-ID: <2433d4cb-e7f7-72c5-977b-02f51e9717b3@petezilla.co.uk>
Date:   Wed, 21 Aug 2019 09:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSWi+PUbOWXNwv0guCLRuSgZunWdvRBB4TKMG_X48jHFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-0.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - phi.wiserhosting.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - petezilla.co.uk
X-Get-Message-Sender-Via: phi.wiserhosting.co.uk: authenticated_id: pete@petezilla.co.uk
X-Authenticated-Sender: phi.wiserhosting.co.uk: pete@petezilla.co.uk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

hings
On 8/20/19 10:59 PM, Chris Murphy wrote:
> On Tue, Aug 20, 2019 at 3:10 PM Peter Chant <pete@petezilla.co.uk> wrote:
>>
>> Chasing IO errors.  BTRFS: error (device dm-2) in
>> btrfs_run_delayed_refs:2907: errno=-5 IO failure
>>
>>
>> I've just had an odd one.
>>
>> Over the last few days I've noticed a file system blocking, if that is
>> the correct term, and this morning go read only.  This resulted in a lot
>> of checksum errors.
> 
> That doesn't sound good. Checksum errors where? A complete start to
> finish dmesg is most useful in this case.
> 
Things to note:
System has five drives:
SSD for boot eith ext4 and btrfs partitions - no issues.
NVME for lxc and a database, via lvm it carries a btrfs and xfs file
systems, no issue.
Various overlayfs for lxc containers.

Three WD reds, 2x3TB, 1x4TB, RAID1 problematic.

I'll run the checks shortly.


Output of dmesg.

[    0.000000] Linux version 5.2.9 (root@slc-build) (gcc version 9.1.0
(GCC)) #1 SMP Sat Aug 17 10:20:58 BST 2019
[    0.000000] Command line: ro
initrd=initrd_desk-system-label-5.2.9.gz BOOT_IMAGE=vmlinuz-5.2.9-amd
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832
bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d3ff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009d400-0x000000000009ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000003ffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000004000000-0x0000000004009fff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000000400a000-0x0000000009cfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009d00000-0x0000000009ffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000d9a11fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000d9a12000-0x00000000daf0efff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000daf0f000-0x00000000dafc3fff]
ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000dafc4000-0x00000000db0d2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000db0d3000-0x00000000db494fff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000db495000-0x00000000dc53bfff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000dc53c000-0x00000000deffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df000000-0x00000000dfffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fd800000-0x00000000fdffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fea00000-0x00000000fea0ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000feb80000-0x00000000fec01fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec30000-0x00000000fec30fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed40000-0x00000000fed44fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed8ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc2000-0x00000000fedcffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedd4000-0x00000000fedd5fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000feefffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041f37ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 3.1.1 present.
[    0.000000] DMI: System manufacturer System Product Name/ROG
CROSSHAIR VII HERO (WI-FI), BIOS 1002 10/23/2018
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] last_pfn = 0x41f380 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF write-through
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000000]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] TOM2: 0000000420000000 aka 16896M
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-
WT
[    0.000000] e820: update [mem 0xe0000000-0xffffffff] usable ==> reserved
[    0.000000] last_pfn = 0xdf000 max_arch_pfn = 0x400000000
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x378601000, 0x378601fff] PGTABLE
[    0.000000] BRK [0x378602000, 0x378602fff] PGTABLE
[    0.000000] BRK [0x378603000, 0x378603fff] PGTABLE
[    0.000000] BRK [0x378604000, 0x378604fff] PGTABLE
[    0.000000] BRK [0x378605000, 0x378605fff] PGTABLE
[    0.000000] BRK [0x378606000, 0x378606fff] PGTABLE
[    0.000000] BRK [0x378607000, 0x378607fff] PGTABLE
[    0.000000] BRK [0x378608000, 0x378608fff] PGTABLE
[    0.000000] BRK [0x378609000, 0x378609fff] PGTABLE
[    0.000000] BRK [0x37860a000, 0x37860afff] PGTABLE
[    0.000000] BRK [0x37860b000, 0x37860bfff] PGTABLE
[    0.000000] BRK [0x37860c000, 0x37860cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x037ee000-0x03ffefff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F05B0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000DAF1A098 0000AC (v01 ALASKA A M I
 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000DAF29028 000114 (v06 ALASKA A M I
 01072009 AMI  00010013)
[    0.000000] ACPI BIOS Warning (bug): Optional FADT field
Pm2ControlBlock has valid Length but zero Address:
0x0000000000000000/0x1 (20190509/tbfadt-615)
[    0.000000] ACPI: DSDT 0x00000000DAF1A1E0 00EE43 (v02 ALASKA A M I
 01072009 INTL 20120913)
[    0.000000] ACPI: FACS 0x00000000DB47DE00 000040
[    0.000000] ACPI: APIC 0x00000000DAF29140 0000DE (v03 ALASKA A M I
 01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000DAF29220 000044 (v01 ALASKA A M I
 01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000DAF29268 00009C (v01 ALASKA A M I
 01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000DAF29308 008C98 (v02 AMD    AMD ALIB
00000002 MSFT 04000000)
[    0.000000] ACPI: SSDT 0x00000000DAF31FA0 002314 (v01 AMD    AMD CPU
 00000001 AMD  00000001)
[    0.000000] ACPI: CRAT 0x00000000DAF342B8 000F50 (v01 AMD    AMD CRAT
00000001 AMD  00000001)
[    0.000000] ACPI: CDIT 0x00000000DAF35208 000029 (v01 AMD    AMD CDIT
00000001 AMD  00000001)
[    0.000000] ACPI: SSDT 0x00000000DAF35238 002DA8 (v01 AMD    AMD AOD
 00000001 INTL 20120913)
[    0.000000] ACPI: MCFG 0x00000000DAF37FE0 00003C (v01 ALASKA A M I
 01072009 MSFT 00010013)
[    0.000000] ACPI: SSDT 0x00000000DAF39C78 0000F8 (v01 AMD    AMD PT
 00001000 INTL 20120913)
[    0.000000] ACPI: HPET 0x00000000DAF38078 000038 (v01 ALASKA A M I
 01072009 AMI  00000005)
[    0.000000] ACPI: SSDT 0x00000000DAF380B0 000024 (v01 AMDFCH FCHZP
 00001000 INTL 20120913)
[    0.000000] ACPI: UEFI 0x00000000DAF380D8 000042 (v01
 00000000      00000000)
[    0.000000] ACPI: WPBT 0x00000000DAF38120 00003C (v01 ALASKA A M I
 00000001 ASUS 00000001)
[    0.000000] ACPI: IVRS 0x00000000DAF38160 0000D0 (v02 AMD    AMD IVRS
00000001 AMD  00000000)
[    0.000000] ACPI: SSDT 0x00000000DAF38230 001A41 (v01 AMD    AmdTable
00000001 INTL 20120913)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000041f37ffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x41f37b000-0x41f37ffff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000041f37ffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x0000000003ffffff]
[    0.000000]   node   0: [mem 0x000000000400a000-0x0000000009cfffff]
[    0.000000]   node   0: [mem 0x000000000a000000-0x000000000affffff]
[    0.000000]   node   0: [mem 0x000000000b020000-0x00000000d9a11fff]
[    0.000000]   node   0: [mem 0x00000000dafc4000-0x00000000db0d2fff]
[    0.000000]   node   0: [mem 0x00000000dc53c000-0x00000000deffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000041f37ffff]
[    0.000000] Zeroed struct page in unavailable ranges: 15785 pages
[    0.000000] Initmem setup node 0 [mem
0x0000000000001000-0x000000041f37ffff]
[    0.000000] On node 0 totalpages: 4175319
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14027 pages used for memmap
[    0.000000]   DMA32 zone: 897723 pages, LIFO batch:63
[    0.000000]   Normal zone: 51150 pages used for memmap
[    0.000000]   Normal zone: 3273600 pages, LIFO batch:63
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 17, version 33, address 0xfec00000,
GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 18, version 33, address 0xfec01000,
GSI 24-55
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.000000] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x04000000-0x04009fff]
[    0.000000] PM: Registered nosave memory: [mem 0x09d00000-0x09ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x0b000000-0x0b01ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xd9a12000-0xdaf0efff]
[    0.000000] PM: Registered nosave memory: [mem 0xdaf0f000-0xdafc3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb0d3000-0xdb494fff]
[    0.000000] PM: Registered nosave memory: [mem 0xdb495000-0xdc53bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xdf000000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfc000000-0xfd7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfd800000-0xfdffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfe000000-0xfe9fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea00000-0xfea0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfea10000-0xfeb7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeb80000-0xfec01fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec02000-0xfec0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec11000-0xfec2ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec30000-0xfec30fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfec31000-0xfecfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed3ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed40000-0xfed44fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed45000-0xfed7ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed80000-0xfed8ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed90000-0xfedc1fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedc2000-0xfedcffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd0000-0xfedd3fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd4000-0xfedd5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfedd6000-0xfedfffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256
nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 51 pages/cpu s172032 r8192 d28672 u262144
[    0.000000] pcpu-alloc: s172032 r8192 d28672 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11
12 13 14 15
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
4110057
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: ro
initrd=initrd_desk-system-label-5.2.9.gz BOOT_IMAGE=vmlinuz-5.2.9-amd
[    0.000000] Memory: 16322544K/16701276K available (18436K kernel
code, 1800K rwdata, 4764K rodata, 1780K init, 3736K bss, 378732K
reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] ftrace: allocating 50389 entries in 197 pages
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	CONFIG_RCU_FANOUT set to non-default value of 32.
[    0.000000] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=16.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] NR_IRQS: 16640, nr_irqs: 1096, preallocated irqs: 16
[    0.000000] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.000000] random: crng done (trusting CPU's manufacturer)
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] ACPI: Core revision 20190509
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484873504 ns
[    0.000000] hpet clockevent registered
[    0.000000] APIC: Switch to symmetric I/O mode setup
[    0.002000] Switched APIC routing to physical flat.
[    0.003000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.009000] tsc: PIT calibration matches HPET. 1 loops
[    0.010000] tsc: Detected 3699.572 MHz processor
[    0.000001] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x6aa78389a33, max_idle_ns: 881591144153 ns
[    0.000224] Calibrating delay loop (skipped), value calculated using
timer frequency.. 7399.14 BogoMIPS (lpj=3699572)
[    0.000450] pid_max: default: 32768 minimum: 301
[    0.000616] LSM: Security Framework initializing
[    0.003043] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes)
[    0.004278] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.004543] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes)
[    0.004716] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes)
[    0.005059] *** VALIDATE proc ***
[    0.005236] *** VALIDATE cgroup1 ***
[    0.005369] *** VALIDATE cgroup2 ***
[    0.005547] LVT offset 1 assigned for vector 0xf9
[    0.005738] LVT offset 2 assigned for vector 0xf4
[    0.005880] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.006019] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
[    0.006156] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.006225] Spectre V2 : Mitigation: Full AMD retpoline
[    0.006360] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
RSB on context switch
[    0.006580] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.006797] Spectre V2 : User space: Vulnerable
[    0.006933] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.007374] Freeing SMP alternatives memory: 48K
[    0.009224] smpboot: CPU0: AMD Ryzen 7 2700X Eight-Core Processor
(family: 0x17, model: 0x8, stepping: 0x2)
[    0.009224] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.009224] ... version:                0
[    0.009224] ... bit width:              48
[    0.009224] ... generic registers:      6
[    0.009224] ... value mask:             0000ffffffffffff
[    0.009225] ... max period:             00007fffffffffff
[    0.009363] ... fixed-purpose events:   0
[    0.009498] ... event mask:             000000000000003f
[    0.009658] rcu: Hierarchical SRCU implementation.
[    0.009913] smp: Bringing up secondary CPUs ...
[    0.010106] x86: Booting SMP configuration:
[    0.010226] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11 #12 #13 #14 #15
[    0.027244] smp: Brought up 1 node, 16 CPUs
[    0.028360] smpboot: Max logical packages: 1
[    0.028496] smpboot: Total of 16 processors activated (118386.30
BogoMIPS)
[    0.029512] devtmpfs: initialized
[    0.029512] x86/mm: Memory block size: 128MB
[    0.030883] PM: Registering ACPI NVS region [mem
0x04000000-0x04009fff] (40960 bytes)
[    0.030883] PM: Registering ACPI NVS region [mem
0xdb0d3000-0xdb494fff] (3940352 bytes)
[    0.031318] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.031550] futex hash table entries: 4096 (order: 6, 262144 bytes)
[    0.031759] xor: automatically using best checksumming function   avx

[    0.031922] pinctrl core: initialized pinctrl subsystem
[    0.032385] NET: Registered protocol family 16
[    0.032576] audit: initializing netlink subsys (disabled)
[    0.032717] audit: type=2000 audit(1566340202.042:1):
state=initialized audit_enabled=0 res=1
[    0.032717] cpuidle: using governor ladder
[    0.032717] cpuidle: using governor menu
[    0.033250] ACPI: bus type PCI registered
[    0.033384] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.033569] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.033794] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.033939] PCI: Using configuration type 1 for base access
[    0.036234] cryptd: max_cpu_qlen set to 1000
[    0.056226] raid6: avx2x4   gen() 28812 MB/s
[    0.073225] raid6: avx2x4   xor() 16083 MB/s
[    0.090226] raid6: avx2x2   gen() 30023 MB/s
[    0.107225] raid6: avx2x2   xor() 17576 MB/s
[    0.124227] raid6: avx2x1   gen() 22074 MB/s
[    0.141225] raid6: avx2x1   xor() 16306 MB/s
[    0.158224] raid6: sse2x4   gen() 19492 MB/s
[    0.175225] raid6: sse2x4   xor() 11279 MB/s
[    0.192228] raid6: sse2x2   gen() 17273 MB/s
[    0.209227] raid6: sse2x2   xor() 12205 MB/s
[    0.226231] raid6: sse2x1   gen()  9242 MB/s
[    0.243226] raid6: sse2x1   xor()  8845 MB/s
[    0.243361] raid6: using algorithm avx2x2 gen() 30023 MB/s
[    0.243500] raid6: .... xor() 17576 MB/s, rmw enabled
[    0.243637] raid6: using avx2x2 recovery algorithm
[    0.243827] ACPI: Added _OSI(Module Device)
[    0.243965] ACPI: Added _OSI(Processor Device)
[    0.244101] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.244225] ACPI: Added _OSI(Processor Aggregator Device)
[    0.244363] ACPI: Added _OSI(Linux-Dell-Video)
[    0.244500] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.244638] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.251836] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.253151] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.254959] ACPI: EC: EC started
[    0.255092] ACPI: EC: interrupt blocked
[    0.255269] ACPI: \_SB_.PCI0.SBRG.EC0_: Used as first EC
[    0.255408] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x2, EC_CMD/EC_SC=0x66,
EC_DATA=0x62
[    0.255630] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle
transactions
[    0.255852] ACPI: Interpreter enabled
[    0.255997] ACPI: (supports S0 S3 S4 S5)
[    0.256132] ACPI: Using IOAPIC for interrupt routing
[    0.256486] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.256893] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.262075] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.262216] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.262327] acpi PNP0A08:00: _OSC: platform does not support
[PCIeHotplug PME LTR]
[    0.262640] acpi PNP0A08:00: _OSC: OS now controls [AER PCIeCapability]
[    0.262787] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain
0000 [bus 00-3f] only partially covers this bridge
[    0.263422] PCI host bridge to bus 0000:00
[    0.263557] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.263696] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.263836] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.263975] pci_bus 0000:00: root bus resource [io  0x0d00-0xefff window]
[    0.264115] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.264225] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000dffff window]
[    0.264443] pci_bus 0000:00: root bus resource [mem
0xe0000000-0xfec2ffff window]
[    0.264663] pci_bus 0000:00: root bus resource [mem
0xfee00000-0xffffffff window]
[    0.264881] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.265023] pci 0000:00:00.0: [1022:1450] type 00 class 0x060000
[    0.265284] pci 0000:00:00.2: [1022:1451] type 00 class 0x080600
[    0.265498] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
[    0.265684] pci 0000:00:01.1: [1022:1453] type 01 class 0x060400
[    0.265988] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.266289] pci 0000:00:01.3: [1022:1453] type 01 class 0x060400
[    0.267305] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.268294] pci 0000:00:02.0: [1022:1452] type 00 class 0x060000
[    0.269228] pci 0000:00:03.0: [1022:1452] type 00 class 0x060000
[    0.269416] pci 0000:00:03.1: [1022:1453] type 01 class 0x060400
[    0.270056] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.270306] pci 0000:00:04.0: [1022:1452] type 00 class 0x060000
[    0.271245] pci 0000:00:07.0: [1022:1452] type 00 class 0x060000
[    0.271432] pci 0000:00:07.1: [1022:1454] type 01 class 0x060400
[    0.271963] pci 0000:00:07.1: enabling Extended Tags
[    0.272287] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.273295] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
[    0.273482] pci 0000:00:08.1: [1022:1454] type 01 class 0x060400
[    0.274829] pci 0000:00:08.1: enabling Extended Tags
[    0.275043] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.275330] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.276424] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.276770] pci 0000:00:18.0: [1022:1460] type 00 class 0x060000
[    0.276946] pci 0000:00:18.1: [1022:1461] type 00 class 0x060000
[    0.277123] pci 0000:00:18.2: [1022:1462] type 00 class 0x060000
[    0.277261] pci 0000:00:18.3: [1022:1463] type 00 class 0x060000
[    0.277437] pci 0000:00:18.4: [1022:1464] type 00 class 0x060000
[    0.277613] pci 0000:00:18.5: [1022:1465] type 00 class 0x060000
[    0.277787] pci 0000:00:18.6: [1022:1466] type 00 class 0x060000
[    0.277963] pci 0000:00:18.7: [1022:1467] type 00 class 0x060000
[    0.278270] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[    0.278431] pci 0000:01:00.0: reg 0x10: [mem 0xfe900000-0xfe903fff 64bit]
[    0.279386] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.280227] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.280771] pci 0000:02:00.0: [1022:43d0] type 00 class 0x0c0330
[    0.280929] pci 0000:02:00.0: reg 0x10: [mem 0xfe6a0000-0xfe6a7fff 64bit]
[    0.281301] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.281504] pci 0000:02:00.1: [1022:43c8] type 00 class 0x010601
[    0.281684] pci 0000:02:00.1: reg 0x24: [mem 0xfe680000-0xfe69ffff]
[    0.281830] pci 0000:02:00.1: reg 0x30: [mem 0xfe600000-0xfe67ffff pref]
[    0.282006] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.282269] pci 0000:02:00.2: [1022:43c6] type 01 class 0x060400
[    0.282483] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.282695] pci 0000:00:01.3: PCI bridge to [bus 02-08]
[    0.282834] pci 0000:00:01.3:   bridge window [io  0xe000-0xefff]
[    0.282973] pci 0000:00:01.3:   bridge window [mem 0xfe400000-0xfe6fffff]
[    0.283185] pci 0000:03:00.0: [1022:43c7] type 01 class 0x060400
[    0.283314] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.283513] pci 0000:03:01.0: [1022:43c7] type 01 class 0x060400
[    0.283741] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.283941] pci 0000:03:02.0: [1022:43c7] type 01 class 0x060400
[    0.284275] pci 0000:03:02.0: PME# supported from D3hot D3cold
[    0.284476] pci 0000:03:04.0: [1022:43c7] type 01 class 0x060400
[    0.284704] pci 0000:03:04.0: PME# supported from D3hot D3cold
[    0.284908] pci 0000:03:09.0: [1022:43c7] type 01 class 0x060400
[    0.285137] pci 0000:03:09.0: PME# supported from D3hot D3cold
[    0.285296] pci 0000:02:00.2: PCI bridge to [bus 03-08]
[    0.285438] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.285578] pci 0000:02:00.2:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.285754] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.285931] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.286131] pci 0000:06:00.0: [8086:1539] type 00 class 0x020000
[    0.286267] pci 0000:06:00.0: reg 0x10: [mem 0xfe500000-0xfe51ffff]
[    0.286437] pci 0000:06:00.0: reg 0x18: [io  0xe000-0xe01f]
[    0.286590] pci 0000:06:00.0: reg 0x1c: [mem 0xfe520000-0xfe523fff]
[    0.286897] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
[    0.287272] pci 0000:03:02.0: PCI bridge to [bus 06]
[    0.287412] pci 0000:03:02.0:   bridge window [io  0xe000-0xefff]
[    0.287551] pci 0000:03:02.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.287725] pci 0000:03:04.0: PCI bridge to [bus 07]
[    0.287917] pci 0000:08:00.0: [1b21:2142] type 00 class 0x0c0330
[    0.288088] pci 0000:08:00.0: reg 0x10: [mem 0xfe400000-0xfe407fff 64bit]
[    0.288362] pci 0000:08:00.0: PME# supported from D0
[    0.288607] pci 0000:03:09.0: PCI bridge to [bus 08]
[    0.288748] pci 0000:03:09.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.289003] pci 0000:09:00.0: [1002:6759] type 00 class 0x030000
[    0.289168] pci 0000:09:00.0: reg 0x10: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.289237] pci 0000:09:00.0: reg 0x18: [mem 0xfe820000-0xfe83ffff 64bit]
[    0.289384] pci 0000:09:00.0: reg 0x20: [io  0xd000-0xd0ff]
[    0.289536] pci 0000:09:00.0: reg 0x30: [mem 0xfe800000-0xfe81ffff pref]
[    0.289729] pci 0000:09:00.0: supports D1 D2
[    0.289927] pci 0000:09:00.1: [1002:aa90] type 00 class 0x040300
[    0.290251] pci 0000:09:00.1: reg 0x10: [mem 0xfe840000-0xfe843fff 64bit]
[    0.290480] pci 0000:09:00.1: supports D1 D2
[    0.290695] pci 0000:00:03.1: PCI bridge to [bus 09]
[    0.290834] pci 0000:00:03.1:   bridge window [io  0xd000-0xdfff]
[    0.290973] pci 0000:00:03.1:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.291115] pci 0000:00:03.1:   bridge window [mem
0xe0000000-0xefffffff 64bit pref]
[    0.291785] pci 0000:0a:00.0: [1022:145a] type 00 class 0x130000
[    0.291951] pci 0000:0a:00.0: enabling Extended Tags
[    0.292264] pci 0000:0a:00.2: [1022:1456] type 00 class 0x108000
[    0.292416] pci 0000:0a:00.2: reg 0x18: [mem 0xfe200000-0xfe2fffff]
[    0.292563] pci 0000:0a:00.2: reg 0x24: [mem 0xfe300000-0xfe301fff]
[    0.292709] pci 0000:0a:00.2: enabling Extended Tags
[    0.292904] pci 0000:0a:00.3: [1022:145f] type 00 class 0x0c0330
[    0.293053] pci 0000:0a:00.3: reg 0x10: [mem 0xfe100000-0xfe1fffff 64bit]
[    0.293208] pci 0000:0a:00.3: enabling Extended Tags
[    0.293251] pci 0000:0a:00.3: PME# supported from D0 D3hot D3cold
[    0.293437] pci 0000:00:07.1: PCI bridge to [bus 0a]
[    0.293576] pci 0000:00:07.1:   bridge window [mem 0xfe100000-0xfe3fffff]
[    0.293781] pci 0000:0b:00.0: [1022:1455] type 00 class 0x130000
[    0.293949] pci 0000:0b:00.0: enabling Extended Tags
[    0.294269] pci 0000:0b:00.2: [1022:7901] type 00 class 0x010601
[    0.294432] pci 0000:0b:00.2: reg 0x24: [mem 0xfe708000-0xfe708fff]
[    0.294577] pci 0000:0b:00.2: enabling Extended Tags
[    0.294738] pci 0000:0b:00.2: PME# supported from D3hot D3cold
[    0.294916] pci 0000:0b:00.3: [1022:1457] type 00 class 0x040300
[    0.295063] pci 0000:0b:00.3: reg 0x10: [mem 0xfe700000-0xfe707fff]
[    0.295222] pci 0000:0b:00.3: enabling Extended Tags
[    0.295249] pci 0000:0b:00.3: PME# supported from D0 D3hot D3cold
[    0.295441] pci 0000:00:08.1: PCI bridge to [bus 0b]
[    0.295580] pci 0000:00:08.1:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.295904] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.296080] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.296255] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.296435] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.296611] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.296779] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.296947] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.297251] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.297704] ACPI: EC: interrupt unblocked
[    0.297855] ACPI: EC: event unblocked
[    0.297995] ACPI: \_SB_.PCI0.SBRG.EC0_: GPE=0x2, EC_CMD/EC_SC=0x66,
EC_DATA=0x62
[    0.298215] ACPI: \_SB_.PCI0.SBRG.EC0_: Boot DSDT EC used to handle
transactions and events
[    0.298254] pci 0000:09:00.0: vgaarb: setting as boot VGA device
[    0.298371] pci 0000:09:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=io+mem,locks=none
[    0.298592] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.298728] vgaarb: loaded
[    0.298931] SCSI subsystem initialized
[    0.299242] libata version 3.00 loaded.
[    0.299242] ACPI: bus type USB registered
[    0.299376] usbcore: registered new interface driver usbfs
[    0.299520] usbcore: registered new interface driver hub
[    0.299683] usbcore: registered new device driver usb
[    0.299826] pps_core: LinuxPPS API ver. 1 registered
[    0.299963] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.300226] PTP clock support registered
[    0.300380] EDAC MC: Ver: 3.0.0
[    0.300457] PCI: Using ACPI for IRQ routing
[    0.305059] PCI: pci_cache_line_size set to 64 bytes
[    0.305119] e820: reserve RAM buffer [mem 0x0009d400-0x0009ffff]
[    0.305120] e820: reserve RAM buffer [mem 0x09d00000-0x0bffffff]
[    0.305121] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.305121] e820: reserve RAM buffer [mem 0xd9a12000-0xdbffffff]
[    0.305122] e820: reserve RAM buffer [mem 0xdb0d3000-0xdbffffff]
[    0.305122] e820: reserve RAM buffer [mem 0xdf000000-0xdfffffff]
[    0.305123] e820: reserve RAM buffer [mem 0x41f380000-0x41fffffff]
[    0.305230] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.305367] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.307261] clocksource: Switched to clocksource tsc-early
[    0.409456] VFS: Disk quotas dquot_6.6.0
[    0.409606] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    0.409774] pnp: PnP ACPI init
[    0.410010] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.410154] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.410204] system 00:01: [mem 0xfeb80000-0xfebfffff] could not be
reserved
[    0.410347] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.410399] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.410502] system 00:03: [io  0x02a0-0x02af] has been reserved
[    0.410644] system 00:03: [io  0x0230-0x023f] has been reserved
[    0.410784] system 00:03: [io  0x0290-0x029f] has been reserved
[    0.410927] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.411086] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.411225] system 00:04: [io  0x040b] has been reserved
[    0.411362] system 00:04: [io  0x04d6] has been reserved
[    0.411500] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.411639] system 00:04: [io  0x0c14] has been reserved
[    0.411776] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.411917] system 00:04: [io  0x0c52] has been reserved
[    0.412056] system 00:04: [io  0x0c6c] has been reserved
[    0.412194] system 00:04: [io  0x0c6f] has been reserved
[    0.412332] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    0.412470] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    0.412610] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    0.412750] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    0.412888] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.413030] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.413169] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.413309] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.413449] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.413588] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.413728] system 00:04: [mem 0xfec00000-0xfec00fff] could not be
reserved
[    0.413869] system 00:04: [mem 0xfec01000-0xfec01fff] could not be
reserved
[    0.414011] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.414152] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.414293] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be
reserved
[    0.414435] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.414575] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.414716] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.414997] pnp: PnP ACPI: found 5 devices
[    0.420465] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.420696] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.420835] pci 0000:00:01.1:   bridge window [mem 0xfe900000-0xfe9fffff]
[    0.420980] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.421124] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.421268] pci 0000:03:02.0: PCI bridge to [bus 06]
[    0.421404] pci 0000:03:02.0:   bridge window [io  0xe000-0xefff]
[    0.421545] pci 0000:03:02.0:   bridge window [mem 0xfe500000-0xfe5fffff]
[    0.421690] pci 0000:03:04.0: PCI bridge to [bus 07]
[    0.421832] pci 0000:03:09.0: PCI bridge to [bus 08]
[    0.421972] pci 0000:03:09.0:   bridge window [mem 0xfe400000-0xfe4fffff]
[    0.422118] pci 0000:02:00.2: PCI bridge to [bus 03-08]
[    0.422255] pci 0000:02:00.2:   bridge window [io  0xe000-0xefff]
[    0.422395] pci 0000:02:00.2:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.422540] pci 0000:00:01.3: PCI bridge to [bus 02-08]
[    0.422677] pci 0000:00:01.3:   bridge window [io  0xe000-0xefff]
[    0.422816] pci 0000:00:01.3:   bridge window [mem 0xfe400000-0xfe6fffff]
[    0.422959] pci 0000:00:03.1: PCI bridge to [bus 09]
[    0.423095] pci 0000:00:03.1:   bridge window [io  0xd000-0xdfff]
[    0.423234] pci 0000:00:03.1:   bridge window [mem 0xfe800000-0xfe8fffff]
[    0.423376] pci 0000:00:03.1:   bridge window [mem
0xe0000000-0xefffffff 64bit pref]
[    0.423597] pci 0000:00:07.1: PCI bridge to [bus 0a]
[    0.423735] pci 0000:00:07.1:   bridge window [mem 0xfe100000-0xfe3fffff]
[    0.423878] pci 0000:00:08.1: PCI bridge to [bus 0b]
[    0.424016] pci 0000:00:08.1:   bridge window [mem 0xfe700000-0xfe7fffff]
[    0.424162] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.424300] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.424439] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.424577] pci_bus 0000:00: resource 7 [io  0x0d00-0xefff window]
[    0.427473] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff
window]
[    0.427613] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff
window]
[    0.427753] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff
window]
[    0.427892] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff
window]
[    0.428034] pci_bus 0000:01: resource 1 [mem 0xfe900000-0xfe9fffff]
[    0.428173] pci_bus 0000:02: resource 0 [io  0xe000-0xefff]
[    0.428311] pci_bus 0000:02: resource 1 [mem 0xfe400000-0xfe6fffff]
[    0.428450] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    0.428588] pci_bus 0000:03: resource 1 [mem 0xfe400000-0xfe5fffff]
[    0.428725] pci_bus 0000:06: resource 0 [io  0xe000-0xefff]
[    0.428862] pci_bus 0000:06: resource 1 [mem 0xfe500000-0xfe5fffff]
[    0.429002] pci_bus 0000:08: resource 1 [mem 0xfe400000-0xfe4fffff]
[    0.429140] pci_bus 0000:09: resource 0 [io  0xd000-0xdfff]
[    0.429278] pci_bus 0000:09: resource 1 [mem 0xfe800000-0xfe8fffff]
[    0.429416] pci_bus 0000:09: resource 2 [mem 0xe0000000-0xefffffff
64bit pref]
[    0.429634] pci_bus 0000:0a: resource 1 [mem 0xfe100000-0xfe3fffff]
[    0.429773] pci_bus 0000:0b: resource 1 [mem 0xfe700000-0xfe7fffff]
[    0.429970] NET: Registered protocol family 2
[    0.430224] tcp_listen_portaddr_hash hash table entries: 8192 (order:
5, 131072 bytes)
[    0.430473] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[    0.430829] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.431078] TCP: Hash tables configured (established 131072 bind 65536)
[    0.431249] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.431417] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.431617] NET: Registered protocol family 1
[    0.431837] RPC: Registered named UNIX socket transport module.
[    0.431977] RPC: Registered udp transport module.
[    0.432113] RPC: Registered tcp transport module.
[    0.432248] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.432390] NET: Registered protocol family 44
[    0.432731] pci 0000:09:00.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    0.433085] PCI: CLS 64 bytes, default 64
[    0.433240] Trying to unpack rootfs image as initramfs...
[    0.518783] Freeing initrd memory: 8260K
[    0.518941] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters
supported
[    0.519312] pci 0000:00:01.0: Adding to iommu group 0
[    0.519536] pci 0000:00:01.1: Adding to iommu group 1
[    0.519768] pci 0000:00:01.3: Adding to iommu group 2
[    0.519997] pci 0000:00:02.0: Adding to iommu group 3
[    0.520231] pci 0000:00:03.0: Adding to iommu group 4
[    0.520456] pci 0000:00:03.1: Adding to iommu group 5
[    0.520678] pci 0000:00:04.0: Adding to iommu group 6
[    0.520910] pci 0000:00:07.0: Adding to iommu group 7
[    0.521123] pci 0000:00:07.1: Adding to iommu group 8
[    0.521352] pci 0000:00:08.0: Adding to iommu group 9
[    0.521572] pci 0000:00:08.1: Adding to iommu group 10
[    0.521805] pci 0000:00:14.0: Adding to iommu group 11
[    0.521957] pci 0000:00:14.3: Adding to iommu group 11
[    0.522206] pci 0000:00:18.0: Adding to iommu group 12
[    0.522354] pci 0000:00:18.1: Adding to iommu group 12
[    0.522502] pci 0000:00:18.2: Adding to iommu group 12
[    0.522652] pci 0000:00:18.3: Adding to iommu group 12
[    0.522799] pci 0000:00:18.4: Adding to iommu group 12
[    0.522947] pci 0000:00:18.5: Adding to iommu group 12
[    0.523095] pci 0000:00:18.6: Adding to iommu group 12
[    0.523242] pci 0000:00:18.7: Adding to iommu group 12
[    0.523475] pci 0000:01:00.0: Adding to iommu group 13
[    0.523717] pci 0000:02:00.0: Adding to iommu group 14
[    0.523873] pci 0000:02:00.1: Adding to iommu group 14
[    0.524032] pci 0000:02:00.2: Adding to iommu group 14
[    0.524179] pci 0000:03:00.0: Adding to iommu group 14
[    0.524326] pci 0000:03:01.0: Adding to iommu group 14
[    0.524473] pci 0000:03:02.0: Adding to iommu group 14
[    0.524620] pci 0000:03:04.0: Adding to iommu group 14
[    0.524766] pci 0000:03:09.0: Adding to iommu group 14
[    0.524919] pci 0000:06:00.0: Adding to iommu group 14
[    0.525069] pci 0000:08:00.0: Adding to iommu group 14
[    0.525308] pci 0000:09:00.0: Adding to iommu group 15
[    0.525467] pci 0000:09:00.1: Adding to iommu group 15
[    0.525692] pci 0000:0a:00.0: Adding to iommu group 16
[    0.525925] pci 0000:0a:00.2: Adding to iommu group 17
[    0.526143] pci 0000:0a:00.3: Adding to iommu group 18
[    0.526367] pci 0000:0b:00.0: Adding to iommu group 19
[    0.526596] pci 0000:0b:00.2: Adding to iommu group 20
[    0.526829] pci 0000:0b:00.3: Adding to iommu group 21
[    0.527179] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.527317] pci 0000:00:00.2: AMD-Vi: Extended features
(0xf77ef22294ada):
[    0.527457]  PPR NX GT IA GA PC GA_vAPIC
[    0.527591] AMD-Vi: Interrupt remapping enabled
[    0.527727] AMD-Vi: Virtual APIC enabled
[    0.527942] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.528796] amd_uncore: AMD NB counters detected
[    0.528936] amd_uncore: AMD LLC counters detected
[    0.529251] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4
counters/bank).
[    0.534570] Initialise system trusted keyrings
[    0.534716] Key type blacklist registered
[    0.534879] workingset: timestamp_bits=40 max_order=22 bucket_order=0
[    0.535818] zbud: loaded
[    0.536204] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.536467] NFS: Registering the id_resolver key type
[    0.536606] Key type id_resolver registered
[    0.536741] Key type id_legacy registered
[    0.536877] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    0.537020] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[    0.537252] ntfs: driver 2.1.32 [Flags: R/W].
[    0.537414] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.537582] SGI XFS with ACLs, security attributes, scrub, no debug
enabled
[    0.538604] async_tx: api initialized (async)
[    0.538741] Key type asymmetric registered
[    0.538876] Asymmetric key parser 'x509' registered
[    0.539020] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 245)
[    0.539281] io scheduler mq-deadline registered
[    0.539418] io scheduler kyber registered
[    0.539567] io scheduler bfq registered
[    0.539785] atomic64_test: passed for x86-64 platform with CX8 and
with SSE
[    0.541744] pcieport 0000:00:01.1: AER: enabled with IRQ 28
[    0.542716] pcieport 0000:00:01.3: AER: enabled with IRQ 29
[    0.543712] pcieport 0000:00:03.1: AER: enabled with IRQ 30
[    0.544699] pcieport 0000:00:07.1: AER: enabled with IRQ 31
[    0.545741] pcieport 0000:00:08.1: AER: enabled with IRQ 33
[    0.547259] Monitor-Mwait will be used to enter C-1 state
[    0.548863] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.828103] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    0.830005] brd: module loaded
[    0.831416] loop: module loaded
[    0.831700] fnic: Cisco FCoE HBA Driver, ver 1.6.0.47
[    0.831858] fnic: Successfully Initialized Trace Buffer
[    0.832026] fnic: Successfully Initialized FC_CTLR Trace Buffer
[    0.832462] Loading Adaptec I2O RAID: Version 2.4 Build 5go
[    0.832604] Detecting Adaptec I2O RAID controllers...
[    0.832774] Adaptec aacraid driver 1.2.1[50877]-custom
[    0.832923] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
[    0.833099] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
[    0.833273] QLogic BR-series BFA FC/FCOE SCSI driver - version: 3.2.25.1
[    0.833450] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03
EST 2006)
[    0.833691] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST
2006)
[    0.833842] megasas: 07.707.51.00-rc1
[    0.833991] mpt3sas version 28.100.00.00 loaded
[    0.834166] GDT-HA: Storage RAID Controller Driver. Version: 3.05
[    0.834324] 3ware Storage Controller device driver for Linux
v1.26.02.003.
[    0.834475] 3ware 9000 Storage Controller device driver for Linux
v2.26.02.014.
[    0.834704] LSI 3ware SAS/SATA-RAID Controller device driver for
Linux v3.26.02.000.
[    0.834941] ipr: IBM Power RAID SCSI Device Driver version: 2.6.4
(March 14, 2017)
[    0.835176] RocketRAID 3xxx/4xxx Controller driver v1.10.0
[    0.835324] stex: Promise SuperTrak EX Driver version: 6.02.0000.01
[    0.835501] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    0.835808] nvme nvme0: pci function 0000:01:00.0
[    0.835970] ahci 0000:02:00.1: version 3.0
[    0.836072] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    0.836270] ahci 0000:02:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps
0xff impl SATA mode
[    0.836495] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo
only pmp pio slum part sxs deso sadm sds apst
[    0.837190] scsi host0: ahci
[    0.837411] scsi host1: ahci
[    0.837619] scsi host2: ahci
[    0.837818] scsi host3: ahci
[    0.838028] scsi host4: ahci
[    0.838230] scsi host5: ahci
[    0.838434] scsi host6: ahci
[    0.838639] scsi host7: ahci
[    0.838816] ata1: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680100 irq 40
[    0.839041] ata2: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680180 irq 40
[    0.839262] ata3: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680200 irq 40
[    0.839485] ata4: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680280 irq 40
[    0.839706] ata5: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680300 irq 40
[    0.839934] ata6: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680380 irq 40
[    0.840157] ata7: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680400 irq 40
[    0.840378] ata8: SATA max UDMA/133 abar m131072@0xfe680000 port
0xfe680480 irq 40
[    0.840699] ahci 0000:0b:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps
0x1 impl SATA mode
[    0.840933] ahci 0000:0b:00.2: flags: 64bit ncq sntf ilck pm led clo
only pmp fbs pio slum part
[    0.841264] scsi host8: ahci
[    0.844208] ata9: SATA max UDMA/133 abar m4096@0xfe708000 port
0xfe708100 irq 44
[    0.844947] scsi host9: pata_legacy
[    0.845106] ata10: PATA max PIO4 cmd 0x1f0 ctl 0x3f6 irq 14
[    1.031718] nvme nvme0: missing or invalid SUBNQN field.
[    1.031870] nvme nvme0: Shutdown timeout set to 8 seconds
[    1.048997] nvme nvme0: 16/0/0 default/read/poll queues
[    1.055665]  nvme0n1: p1
[    1.134921] ata9: SATA link down (SStatus 0 SControl 300)
[    1.293602] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.294412] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80, max UDMA/133
[    1.294646] ata1.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth
32), AA
[    1.295388] ata1.00: configured for UDMA/133
[    1.557579] tsc: Refined TSC clocksource calibration: 3700.009 MHz
[    1.557734] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x6aaabc71ca1, max_idle_ns: 881590766374 ns
[    1.558048] clocksource: Switched to clocksource tsc
[    3.861348] floppy0: no floppy controllers found
[    3.861824] scsi 0:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E
0A80 PQ: 0 ANSI: 5
[    3.862246] sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks:
(3.00 TB/2.73 TiB)
[    3.862497] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    3.862652] sd 0:0:0:0: [sda] Write Protect is off
[    3.862792] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.862811] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.876554] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.172529] ata2: SATA link down (SStatus 0 SControl 300)
[    4.645584] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.646403] ata3.00: ATA-9: WDC WD30EFRX-68EUZN0, 82.00A82, max UDMA/133
[    4.646638] ata3.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth
32), AA
[    4.647410] ata3.00: configured for UDMA/133
[    4.648185] scsi 2:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E
0A82 PQ: 0 ANSI: 5
[    4.648548] sd 2:0:0:0: [sdb] 5860533168 512-byte logical blocks:
(3.00 TB/2.73 TiB)
[    4.648779] sd 2:0:0:0: [sdb] 4096-byte physical blocks
[    4.648921] sd 2:0:0:0: [sdb] Write Protect is off
[    4.649057] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    4.649062] sd 2:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.653094] sd 2:0:0:0: [sdb] Attached SCSI disk
[    5.117583] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.118397] ata4.00: ATA-10: WDC WD40EFRX-68N32N0, 82.00A82, max UDMA/133
[    5.118632] ata4.00: 7814037168 sectors, multi 16: LBA48 NCQ (depth
32), AA
[    5.119416] ata4.00: configured for UDMA/133
[    5.120071] scsi 3:0:0:0: Direct-Access     ATA      WDC WD40EFRX-68N
0A82 PQ: 0 ANSI: 5
[    5.120421] sd 3:0:0:0: [sdc] 7814037168 512-byte logical blocks:
(4.00 TB/3.64 TiB)
[    5.120653] sd 3:0:0:0: [sdc] 4096-byte physical blocks
[    5.120794] sd 3:0:0:0: [sdc] Write Protect is off
[    5.120932] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[    5.120937] sd 3:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.139079] sd 3:0:0:0: [sdc] Attached SCSI disk
[    5.589583] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.590527] ata5.00: supports DRM functions and may not be fully
accessible
[    5.594049] ata5.00: disabling queued TRIM support
[    5.594051] ata5.00: ATA-9: Samsung SSD 850 EVO 500GB, EMT02B6Q, max
UDMA/133
[    5.594197] ata5.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    5.595475] ata5.00: supports DRM functions and may not be fully
accessible
[    5.596209] ata5.00: disabling queued TRIM support
[    5.597080] ata5.00: configured for UDMA/133
[    5.597873] scsi 4:0:0:0: Direct-Access     ATA      Samsung SSD 850
 2B6Q PQ: 0 ANSI: 5
[    5.598250] sd 4:0:0:0: [sdd] 976773168 512-byte logical blocks: (500
GB/466 GiB)
[    5.598498] sd 4:0:0:0: [sdd] Write Protect is off
[    5.598638] sd 4:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[    5.598646] sd 4:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.606502]  sdd: sdd1 sdd2 sdd3
[    5.607206] sd 4:0:0:0: [sdd] supports TCG Opal
[    5.607348] sd 4:0:0:0: [sdd] Attached SCSI disk
[    6.069581] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    6.072634] ata6.00: ATAPI: ATAPI   iHAS122, ZL0E, max UDMA/100
[    6.073540] ata6.00: configured for UDMA/100
[    6.079007] scsi 5:0:0:0: CD-ROM            ATAPI    iHAS122
 ZL0E PQ: 0 ANSI: 5
[    6.139080] sr 5:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram
cd/rw xa/form2 cdda tray
[    6.139427] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.139884] sr 5:0:0:0: Attached scsi CD-ROM sr0
[    6.452543] ata7: SATA link down (SStatus 0 SControl 330)
[    7.493562] ata8: failed to resume link (SControl 0)
[    7.493805] ata8: SATA link down (SStatus 0 SControl 0)
[    7.509945] scsi host9: pata_legacy
[    7.510191] ata11: PATA max PIO4 cmd 0x170 ctl 0x376 irq 15
[    7.681668] Fusion MPT base driver 3.04.20
[    7.681887] Copyright (c) 1999-2008 LSI Corporation
[    7.682111] Fusion MPT SPI Host driver 3.04.20
[    7.682362] Fusion MPT FC Host driver 3.04.20
[    7.682590] Fusion MPT SAS Host driver 3.04.20
[    7.682818] Fusion MPT misc device (ioctl) driver 3.04.20
[    7.683052] mptctl: Registered with Fusion MPT base driver
[    7.683190] mptctl: /dev/mptctl @ (major,minor=10,220)
[    7.683329] Fusion MPT LAN driver 3.04.20
[    7.683504] i8042: PNP: No PS/2 controller found.
[    7.683673] mousedev: PS/2 mouse device common for all mice
[    7.683844] rtc_cmos 00:02: RTC can wake from S4
[    7.684213] rtc_cmos 00:02: registered as rtc0
[    7.684359] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes
nvram, hpet irqs
[    7.684941] device-mapper: uevent: version 1.0.3
[    7.685121] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18)
initialised: dm-devel@redhat.com
[    7.685408] hidraw: raw HID events driver (C) Jiri Kosina
[    7.685552] usbcore: registered new interface driver usbhid
[    7.685689] usbhid: USB HID core driver
[    7.685842] input: Speakup as /devices/virtual/input/input0
[    7.686004] initialized device: /dev/synth, node (MAJOR 10, MINOR 25)
[    7.686171] speakup 3.1.6: initialized
[    7.686310] synth name on entry is: (null)
[    7.686531] Initializing XFRM netlink socket
[    7.686672] NET: Registered protocol family 17
[    7.686854] 9pnet: Installing 9P2000 support
[    7.686999] Key type dns_resolver registered
[    7.687855] mce: Using 23 MCE banks
[    7.688024] microcode: CPU0: patch_level=0x08008206
[    7.688169] microcode: CPU1: patch_level=0x08008206
[    7.688311] microcode: CPU2: patch_level=0x08008206
[    7.688453] microcode: CPU3: patch_level=0x08008206
[    7.688609] microcode: CPU4: patch_level=0x08008206
[    7.688755] microcode: CPU5: patch_level=0x08008206
[    7.688909] microcode: CPU6: patch_level=0x08008206
[    7.689054] microcode: CPU7: patch_level=0x08008206
[    7.689208] microcode: CPU8: patch_level=0x08008206
[    7.689356] microcode: CPU9: patch_level=0x08008206
[    7.689511] microcode: CPU10: patch_level=0x08008206
[    7.689657] microcode: CPU11: patch_level=0x08008206
[    7.689812] microcode: CPU12: patch_level=0x08008206
[    7.689960] microcode: CPU13: patch_level=0x08008206
[    7.690113] microcode: CPU14: patch_level=0x08008206
[    7.690260] microcode: CPU15: patch_level=0x08008206
[    7.690428] microcode: Microcode Update Driver: v2.2.
[    7.690435] AVX2 version of gcm_enc/dec engaged.
[    7.690713] AES CTR mode by8 optimization enabled
[    7.695642] sched_clock: Marking stable (7705414840,
-9775955)->(7939608112, -243969227)
[    7.695953] registered taskstats version 1
[    7.696090] Loading compiled-in X.509 certificates
[    7.696249] zswap: loaded using pool lzo/zbud
[    7.696521] Btrfs loaded, crc32c=crc32c-generic
[    7.697825] Key type encrypted registered
[    7.698861] Freeing unused decrypted memory: 2040K
[    7.699242] Freeing unused kernel image memory: 1780K
[    7.709693] Write protecting the kernel read-only data: 26624k
[    7.710326] Freeing unused kernel image memory: 2028K
[    7.710749] Freeing unused kernel image memory: 1380K
[    7.710894] rodata_test: all tests were successful
[    7.711038] Run /init as init process
[    7.728319] udevd[416]: starting eudev-3.1.5
[    7.827761] BTRFS: device label system devid 1 transid 416487 /dev/sdd2
[    7.980415] usbcore: registered new interface driver usb-storage
[    7.981874] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    7.982979] ehci-pci: EHCI PCI platform driver
[    7.986583] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    7.986761] xhci_hcd 0000:02:00.0: new USB bus registered, assigned
bus number 1
[    8.042190] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version
0x110 quirks 0x0000000000000410
[    8.042690] usb usb1: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.02
[    8.042917] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.043143] usb usb1: Product: xHCI Host Controller
[    8.043287] usb usb1: Manufacturer: Linux 5.2.9 xhci-hcd
[    8.043433] usb usb1: SerialNumber: 0000:02:00.0
[    8.043644] hub 1-0:1.0: USB hub found
[    8.043798] hub 1-0:1.0: 14 ports detected
[    8.047909] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    8.048303] xhci_hcd 0000:02:00.0: new USB bus registered, assigned
bus number 2
[    8.048530] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced
SuperSpeed
[    8.048707] usb usb2: We don't know the algorithms for LPM for this
host, disabling LPM.
[    8.048946] usb usb2: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.02
[    8.052002] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.052263] usb usb2: Product: xHCI Host Controller
[    8.052438] usb usb2: Manufacturer: Linux 5.2.9 xhci-hcd
[    8.052613] usb usb2: SerialNumber: 0000:02:00.0
[    8.052807] hub 2-0:1.0: USB hub found
[    8.052956] hub 2-0:1.0: 8 ports detected
[    8.053641] usb: port power management may be unreliable
[    8.055612] xhci_hcd 0000:08:00.0: xHCI Host Controller
[    8.055985] xhci_hcd 0000:08:00.0: new USB bus registered, assigned
bus number 3
[    8.111030] xhci_hcd 0000:08:00.0: hcc params 0x0200ef81 hci version
0x110 quirks 0x0000000000000010
[    8.111545] usb usb3: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.02
[    8.111773] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.111999] usb usb3: Product: xHCI Host Controller
[    8.112139] usb usb3: Manufacturer: Linux 5.2.9 xhci-hcd
[    8.112282] usb usb3: SerialNumber: 0000:08:00.0
[    8.112743] hub 3-0:1.0: USB hub found
[    8.112890] hub 3-0:1.0: 2 ports detected
[    8.113138] xhci_hcd 0000:08:00.0: xHCI Host Controller
[    8.113305] xhci_hcd 0000:08:00.0: new USB bus registered, assigned
bus number 4
[    8.113532] xhci_hcd 0000:08:00.0: Host supports USB 3.0 SuperSpeed
[    8.113704] usb usb4: We don't know the algorithms for LPM for this
host, disabling LPM.
[    8.113944] usb usb4: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.02
[    8.114174] usb usb4: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.114403] usb usb4: Product: xHCI Host Controller
[    8.114545] usb usb4: Manufacturer: Linux 5.2.9 xhci-hcd
[    8.114687] usb usb4: SerialNumber: 0000:08:00.0
[    8.114899] hub 4-0:1.0: USB hub found
[    8.115043] hub 4-0:1.0: 2 ports detected
[    8.115312] xhci_hcd 0000:0a:00.3: xHCI Host Controller
[    8.115478] xhci_hcd 0000:0a:00.3: new USB bus registered, assigned
bus number 5
[    8.115794] xhci_hcd 0000:0a:00.3: hcc params 0x0270f665 hci version
0x100 quirks 0x0000000000000410
[    8.116238] usb usb5: New USB device found, idVendor=1d6b,
idProduct=0002, bcdDevice= 5.02
[    8.116467] usb usb5: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.116694] usb usb5: Product: xHCI Host Controller
[    8.116835] usb usb5: Manufacturer: Linux 5.2.9 xhci-hcd
[    8.116977] usb usb5: SerialNumber: 0000:0a:00.3
[    8.117184] hub 5-0:1.0: USB hub found
[    8.117336] hub 5-0:1.0: 4 ports detected
[    8.117570] xhci_hcd 0000:0a:00.3: xHCI Host Controller
[    8.117730] xhci_hcd 0000:0a:00.3: new USB bus registered, assigned
bus number 6
[    8.117953] xhci_hcd 0000:0a:00.3: Host supports USB 3.0 SuperSpeed
[    8.118112] usb usb6: We don't know the algorithms for LPM for this
host, disabling LPM.
[    8.118348] usb usb6: New USB device found, idVendor=1d6b,
idProduct=0003, bcdDevice= 5.02
[    8.118577] usb usb6: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    8.118803] usb usb6: Product: xHCI Host Controller
[    8.118944] usb usb6: Manufacturer: Linux 5.2.9 xhci-hcd
[    8.119082] usb usb6: SerialNumber: 0000:0a:00.3
[    8.119290] hub 6-0:1.0: USB hub found
[    8.119434] hub 6-0:1.0: 4 ports detected
[    8.120842] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    8.121918] ohci-pci: OHCI PCI platform driver
[    8.123101] uhci_hcd: USB Universal Host Controller Interface driver
[    8.429590] usb 1-9: new full-speed USB device number 2 using xhci_hcd
[    8.439592] usb 5-2: new low-speed USB device number 2 using xhci_hcd
[    8.618572] usb 5-2: New USB device found, idVendor=046a,
idProduct=0011, bcdDevice= 1.00
[    8.618913] usb 5-2: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    8.668779] input: HID 046a:0011 as
/devices/pci0000:00/0000:00:07.1/0000:0a:00.3/usb5/5-2/5-2:1.0/0003:046A:0011.0001/input/input1
[    8.720727] hid-generic 0003:046A:0011.0001: input,hidraw0: USB HID
v1.11 Keyboard [HID 046a:0011] on usb-0000:0a:00.3-2/input0
[    8.803978] usb 1-9: New USB device found, idVendor=0b05,
idProduct=1872, bcdDevice= 2.00
[    8.804211] usb 1-9: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    8.804363] usb 1-9: Product: AURA LED Controller
[    8.804504] usb 1-9: Manufacturer: AsusTek Computer Inc.
[    8.804648] usb 1-9: SerialNumber: 00000000001A
[    8.815957] usb 2-3: new SuperSpeed Gen 1 USB device number 2 using
xhci_hcd
[    8.822016] hid-generic 0003:0B05:1872.0002: hiddev96,hidraw1: USB
HID v1.11 Device [AsusTek Computer Inc. AURA LED Controller] on
usb-0000:02:00.0-9/input0
[    8.832900] usb 2-3: New USB device found, idVendor=26bd,
idProduct=9917, bcdDevice= 1.10
[    8.833127] usb 2-3: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[    8.833275] usb 2-3: Product: USB DISK 3.0
[    8.833415] usb 2-3: Manufacturer:
[    8.833556] usb 2-3: SerialNumber: 07018352EB9B2F41
[    8.834229] usb 5-3: new low-speed USB device number 3 using xhci_hcd
[    8.841929] usb-storage 2-3:1.0: USB Mass Storage device detected
[    8.842242] scsi host9: usb-storage 2-3:1.0
[    8.993223] usb 5-3: New USB device found, idVendor=046d,
idProduct=c408, bcdDevice=14.00
[    8.993463] usb 5-3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    8.993609] usb 5-3: Product: USB Trackball
[    8.993748] usb 5-3: Manufacturer: Logitech
[    9.020413] input: Logitech USB Trackball as
/devices/pci0000:00/0000:00:07.1/0000:0a:00.3/usb5/5-3/5-3:1.0/0003:046D:C408.0003/input/input2
[    9.020867] hid-generic 0003:046D:C408.0003: input,hidraw2: USB HID
v1.10 Mouse [Logitech USB Trackball] on usb-0000:0a:00.3-3/input0
[    9.183267] BTRFS info (device sdd2): disk space caching is enabled
[    9.183415] BTRFS info (device sdd2): has skinny extents
[    9.501181] BTRFS info (device sdd2): enabling ssd optimizations
[    9.877852] scsi 9:0:0:0: Direct-Access              USB DISK 3.0
 PMAP PQ: 0 ANSI: 6
[    9.878331] sd 9:0:0:0: [sde] 60555264 512-byte logical blocks: (31.0
GB/28.9 GiB)
[    9.878748] sd 9:0:0:0: [sde] Write Protect is off
[    9.878893] sd 9:0:0:0: [sde] Mode Sense: 45 00 00 00
[    9.879094] sd 9:0:0:0: [sde] Write cache: disabled, read cache:
enabled, doesn't support DPO or FUA
[    9.880721]  sde: sde1 sde2
[    9.881668] sd 9:0:0:0: [sde] Attached SCSI removable disk
[   10.097121] udevd[882]: specified group 'kvm' unknown
[   10.124722] udevd[883]: starting eudev-3.1.5
[   10.227700] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[   10.227934] ACPI: Power Button [PWRB]
[   10.228110] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[   10.228344] ACPI: Power Button [PWRF]
[   10.229214] acpi_cpufreq: overriding BIOS provided _PSD data
[   10.234208] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00,
revision 0
[   10.234444] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus
port selection
[   10.234958] acpi PNP0C14:02: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[   10.235289] acpi PNP0C14:03: duplicate WMI GUID
05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
[   10.256506] ccp 0000:0a:00.2: ccp enabled
[   10.268530] dca service started, version 1.12.1
[   10.302419] Linux agpgart interface v0.103
[   10.337285] igb: Intel(R) Gigabit Ethernet Network Driver - version
5.6.0-k
[   10.337433] igb: Copyright (c) 2007-2014 Intel Corporation.
[   10.365809] pps pps0: new PPS source ptp0
[   10.365969] igb 0000:06:00.0: added PHC on eth0
[   10.366045] kvm: Nested Virtualization enabled
[   10.366115] igb 0000:06:00.0: Intel(R) Gigabit Ethernet Network
Connection
[   10.366270] kvm: Nested Paging enabled
[   10.366424] igb 0000:06:00.0: eth0: (PCIe:2.5Gb/s:Width x1)
4c:ed:fb:76:71:84
[   10.366568] SVM: Virtual VMLOAD VMSAVE supported
[   10.366721] igb 0000:06:00.0: eth0: PBA No: FFFFFF-0FF
[   10.366866] SVM: Virtual GIF supported
[   10.367164] igb 0000:06:00.0: Using MSI-X interrupts. 2 rx queue(s),
2 tx queue(s)
[   10.408759] MCE: In-kernel MCE decoding enabled.
[   10.438022] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.438169] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.439154] snd_hda_intel 0000:09:00.1: Handle vga_switcheroo audio
client
[   10.464203] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.464368] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.468776] input: HDA ATI HDMI HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:03.1/0000:09:00.1/sound/card0/input5
[   10.496153] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.496308] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.510841] [drm] radeon kernel modesetting enabled.
[   10.511046] radeon 0000:09:00.0: remove_conflicting_pci_framebuffers:
bar 0: 0xe0000000 -> 0xefffffff
[   10.511276] radeon 0000:09:00.0: remove_conflicting_pci_framebuffers:
bar 2: 0xfe820000 -> 0xfe83ffff
[   10.511503] radeon 0000:09:00.0: vgaarb: deactivate vga console
[   10.513420] Console: switching to colour dummy device 80x25
[   10.513580] [drm] initializing kernel modesetting (TURKS
0x1002:0x6759 0x103C:0x3130 0x00).
[   10.513641] ATOM BIOS: Bobafet
[   10.513827] radeon 0000:09:00.0: VRAM: 1024M 0x0000000000000000 -
0x000000003FFFFFFF (1024M used)
[   10.513831] radeon 0000:09:00.0: GTT: 1024M 0x0000000040000000 -
0x000000007FFFFFFF
[   10.513836] [drm] Detected VRAM RAM=1024M, BAR=256M
[   10.513837] [drm] RAM width 128bits DDR
[   10.513884] [TTM] Zone  kernel: Available graphics memory: 8202000 KiB
[   10.513887] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   10.513889] [TTM] Initializing pool allocator
[   10.513892] [TTM] Initializing DMA pool allocator
[   10.513906] [drm] radeon: 1024M of VRAM memory ready
[   10.513908] [drm] radeon: 1024M of GTT memory ready.
[   10.513917] [drm] Loading TURKS Microcode
[   10.534239] i2c /dev entries driver
[   10.534271] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.534278] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.536341] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   10.536352] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[   10.536360] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   10.536367] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   10.536372] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   10.536377] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   10.536383] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
[   10.536388] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   10.536393] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   10.555795] input: HD-Audio Generic Front Mic as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input6
[   10.555863] input: HD-Audio Generic Rear Mic as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input7
[   10.555922] input: HD-Audio Generic Line as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input8
[   10.555983] input: HD-Audio Generic Line Out Front as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input9
[   10.556044] input: HD-Audio Generic Line Out Surround as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input10
[   10.556105] input: HD-Audio Generic Line Out CLFE as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input11
[   10.556164] input: HD-Audio Generic Front Headphone as
/devices/pci0000:00/0000:00:08.1/0000:0b:00.3/sound/card1/input12
[   10.570110] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.570115] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.598448] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.598456] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.605332] BTRFS info (device sdd2): device fsid
e1c5134c-dc32-4981-9ac4-1de6342c7e21 devid 1 moved
old:/dev/disk/by-label/system new:/dev/sdd2
[   10.606900] [drm] Internal thermal controller with fan control
[   10.611359] [drm] radeon: dpm initialized
[   10.625986] usbcore: registered new interface driver uas
[   10.626004] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.626011] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.633535] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   10.633995] [drm] enabling PCIE gen 2 link speeds, disable with
radeon.pcie_gen2=0
[   10.666552] [drm] PCIE GART of 1024M enabled (table at
0x0000000000162000).
[   10.666672] radeon 0000:09:00.0: WB enabled
[   10.666675] radeon 0000:09:00.0: fence driver on ring 0 use gpu addr
0x0000000040000c00 and cpu addr 0x0000000067512c98
[   10.666679] radeon 0000:09:00.0: fence driver on ring 3 use gpu addr
0x0000000040000c0c and cpu addr 0x00000000ebd21c7f
[   10.667426] radeon 0000:09:00.0: fence driver on ring 5 use gpu addr
0x0000000000072118 and cpu addr 0x0000000089669c8b
[   10.667431] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   10.667433] [drm] Driver supports precise vblank timestamp query.
[   10.667435] radeon 0000:09:00.0: radeon: MSI limited to 32-bit
[   10.667481] radeon 0000:09:00.0: radeon: using MSI.
[   10.667515] [drm] radeon: irq initialized.
[   10.683900] [drm] ring test on 0 succeeded in 2 usecs
[   10.683915] [drm] ring test on 3 succeeded in 6 usecs
[   10.861107] [drm] ring test on 5 succeeded in 2 usecs
[   10.861123] [drm] UVD initialized successfully.
[   10.861382] [drm] ib test on ring 0 succeeded in 0 usecs
[   10.861474] [drm] ib test on ring 3 succeeded in 0 usecs
[   10.865610] asus_wmi: ASUS WMI generic driver loaded
[   10.866249] EDAC amd64: Node 0: DRAM ECC disabled.
[   10.866256] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   10.870100] asus_wmi: Initialization: 0x0
[   10.870134] asus_wmi: BIOS WMI version: 0.9
[   10.870180] asus_wmi: SFUN value: 0x0
[   10.870566] input: Eee PC WMI hotkeys as
/devices/platform/eeepc-wmi/input/input13
[   10.870660] asus_wmi: Number of fans: 1
[   11.042260] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.042267] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.078216] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.078222] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.118158] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.118165] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.162118] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.162125] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.210033] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.210039] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.242037] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.242043] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.262128] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.262134] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.298156] EDAC amd64: Node 0: DRAM ECC disabled.
[   11.298161] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   11.517653] [drm] ib test on ring 5 succeeded
[   11.518502] [drm] Radeon Display Connectors
[   11.518507] [drm] Connector 0:
[   11.518509] [drm]   DP-1
[   11.518512] [drm]   HPD4
[   11.518515] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458
0x645c 0x645c
[   11.518519] [drm]   Encoders:
[   11.518522] [drm]     DFP1: INTERNAL_UNIPHY2
[   11.518525] [drm] Connector 1:
[   11.518527] [drm]   DP-2
[   11.518529] [drm]   HPD5
[   11.518532] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478
0x647c 0x647c
[   11.518536] [drm]   Encoders:
[   11.518539] [drm]     DFP2: INTERNAL_UNIPHY2
[   11.518541] [drm] Connector 2:
[   11.518544] [drm]   DVI-I-1
[   11.518546] [drm]   HPD1
[   11.518549] [drm]   DDC: 0x6460 0x6460 0x6464 0x6464 0x6468 0x6468
0x646c 0x646c
[   11.518553] [drm]   Encoders:
[   11.518555] [drm]     DFP3: INTERNAL_UNIPHY
[   11.518558] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   11.600240] [drm] fb mappable at 0xE0363000
[   11.600247] [drm] vram apper at 0xE0000000
[   11.600250] [drm] size 5242880
[   11.600253] [drm] fb depth is 24
[   11.600255] [drm]    pitch is 5120
[   11.600393] fbcon: radeondrmfb (fb0) is primary device
[   11.643768] Console: switching to colour frame buffer device 128x48
[   11.645472] radeon 0000:09:00.0: fb0: radeondrmfb frame buffer device
[   11.657298] [drm] Initialized radeon 2.50.0 20080528 for 0000:09:00.0
on minor 0
[   32.642622] NET: Registered protocol family 38
[   46.876929] BTRFS: device label Data devid 4 transid 2265510 /dev/dm-1
[   48.540518] BTRFS: device label Data devid 3 transid 2265510 /dev/dm-2
[   58.100588] BTRFS: device label LXC_BTRFS devid 1 transid 112263
/dev/dm-4
[   58.125251] Adding 16777212k swap on /dev/sdd3.  Priority:-2
extents:1 across:16777212k SSFS
[   58.134106] fuse: init (API version 7.31)
[   58.217535] BTRFS info (device sdd2): disk space caching is enabled
[   62.219602] BTRFS info (device dm-2): allowing degraded mounts
[   62.220612] BTRFS info (device dm-2): use zstd compression, level 3
[   62.221339] BTRFS info (device dm-2): enabling auto defrag
[   62.222031] BTRFS info (device dm-2): disk space caching is enabled
[   62.223323] BTRFS warning (device dm-2): devid 5 uuid
89195df2-4e3d-4856-aab0-2aa9f59b3846 is missing
[   62.232894] BTRFS warning (device dm-2): devid 5 uuid
89195df2-4e3d-4856-aab0-2aa9f59b3846 is missing
[   95.956952] BTRFS info (device dm-2): checking UUID tree
[   96.781194] BTRFS info (device dm-4): enabling auto defrag
[   96.782250] BTRFS info (device dm-4): use zlib compression, level 3
[   96.783257] BTRFS info (device dm-4): disk space caching is enabled
[   96.784242] BTRFS info (device dm-4): has skinny extents
[   96.837292] BTRFS info (device dm-4): enabling ssd optimizations
[   96.840638] XFS (dm-0): Mounting V5 Filesystem
[   96.849616] XFS (dm-0): Ending clean mount
[   98.858397] XFS (dm-5): Mounting V5 Filesystem
[   98.866516] XFS (dm-5): Ending clean mount
[   99.213821] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.213822] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.232089] BTRFS info (device dm-2): device fsid
159b8826-8380-45be-acb6-0cb992a8dfd7 devid 4 moved
old:/dev/mapper/data_disk_1 new:/dev/dm-1
[   99.232146] BTRFS info (device dm-2): device fsid
159b8826-8380-45be-acb6-0cb992a8dfd7 devid 3 moved
old:/dev/mapper/data_disk_2 new:/dev/dm-2
[   99.233954] BTRFS info (device dm-4): device fsid
6b0245ec-bdd4-4076-b800-2243d466b174 devid 1 moved
old:/dev/mapper/nvme0_vg-lxc new:/dev/dm-4
[   99.236992] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.236994] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.237670] BTRFS info (device dm-2): device fsid
159b8826-8380-45be-acb6-0cb992a8dfd7 devid 4 moved old:/dev/dm-1
new:/dev/mapper/data_disk_1
[   99.241061] BTRFS info (device dm-4): device fsid
6b0245ec-bdd4-4076-b800-2243d466b174 devid 1 moved old:/dev/dm-4
new:/dev/mapper/nvme0_vg-lxc
[   99.242692] BTRFS info (device dm-2): device fsid
159b8826-8380-45be-acb6-0cb992a8dfd7 devid 3 moved old:/dev/dm-2
new:/dev/mapper/data_disk_2
[   99.270078] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.270079] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.303995] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.303996] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.342285] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.342287] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.371236] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.371238] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.406321] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.406323] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.429165] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.429167] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.464139] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.464140] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.498011] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.498012] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.537115] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.537117] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.566753] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.566754] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.614145] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.614147] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.648250] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.648252] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.682155] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.682157] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.710315] EDAC amd64: Node 0: DRAM ECC disabled.
[   99.710317] EDAC amd64: ECC disabled in the BIOS or no ECC
capability, module will not load.
                Either enable ECC checking or force module loading by
setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side
effects.)
[   99.794858] udevd[883]: specified group 'kvm' unknown
[   99.864809] NET: Registered protocol family 10
[   99.870840] Segment Routing with IPv6
[   99.881095] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[   99.902317] device eth0 entered promiscuous mode
[   99.903101] lxc-br: port 1(eth0) entered blocking state
[   99.903103] lxc-br: port 1(eth0) entered disabled state
[  102.757553] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[  102.757558] NFSD: unable to find recovery directory
/var/lib/nfs/v4recovery
[  102.757559] NFSD: Unable to initialize client recovery tracking! (-2)
[  102.757560] NFSD: starting 90-second grace period (net f0000098)
[  102.872796] igb 0000:06:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps
Full Duplex, Flow Control: RX/TX
[  102.981481] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  102.981526] lxc-br: port 1(eth0) entered blocking state
[  102.981528] lxc-br: port 1(eth0) entered forwarding state
[  102.981720] IPv6: ADDRCONF(NETDEV_CHANGE): lxc-br: link becomes ready
[  131.526599] tun: Universal TUN/TAP device driver, 1.6
[  131.544381] IPv6: ADDRCONF(NETDEV_CHANGE): tap0: link becomes ready
[  131.545719] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready
[  131.547128] lxc-int: port 1(veth1) entered blocking state
[  131.547131] lxc-int: port 1(veth1) entered disabled state
[  131.547189] device veth1 entered promiscuous mode
[  131.547923] lxc-int: port 1(veth1) entered blocking state
[  131.547925] lxc-int: port 1(veth1) entered forwarding state
[  131.609258] overlayfs: failed to verify origin (base-sl14.2/rootfs,
ino=256, err=-116)
[  131.609259] overlayfs: failed to verify upper root origin
[  131.644035] overlayfs: failed to verify origin (base-sl14.2/rootfs,
ino=256, err=-116)
[  131.644036] overlayfs: failed to verify upper root origin
[  131.665755] overlayfs: failed to verify origin (base-sl14.2/rootfs,
ino=256, err=-116)
[  131.665757] overlayfs: failed to verify upper root origin
[  131.713529] lxc-br: port 2(vethHR7W40) entered blocking state
[  131.713532] lxc-br: port 2(vethHR7W40) entered disabled state
[  131.713578] device vethHR7W40 entered promiscuous mode
[  131.713654] lxc-br: port 2(vethHR7W40) entered blocking state
[  131.713656] lxc-br: port 2(vethHR7W40) entered forwarding state
[  131.731335] eth0: renamed from veth9PERB1
[  131.741674] IPv6: ADDRCONF(NETDEV_CHANGE): vethHR7W40: link becomes ready
[  132.729708] lxc-int: port 2(veth4OH9N0) entered blocking state
[  132.729710] lxc-int: port 2(veth4OH9N0) entered disabled state
[  132.729762] device veth4OH9N0 entered promiscuous mode
[  132.729851] lxc-int: port 2(veth4OH9N0) entered blocking state
[  132.729852] lxc-int: port 2(veth4OH9N0) entered forwarding state
[  132.751504] eth0: renamed from vethAECANP
[  132.761447] IPv6: ADDRCONF(NETDEV_CHANGE): veth4OH9N0: link becomes ready
[  133.744615] lxc-int: port 3(veth70VEEM) entered blocking state
[  133.744617] lxc-int: port 3(veth70VEEM) entered disabled state
[  133.744663] device veth70VEEM entered promiscuous mode
[  133.766962] eth0: renamed from vethKHND9O
[  133.777373] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  133.777400] IPv6: ADDRCONF(NETDEV_CHANGE): veth70VEEM: link becomes ready
[  133.777417] lxc-int: port 3(veth70VEEM) entered blocking state
[  133.777418] lxc-int: port 3(veth70VEEM) entered forwarding state
[  134.764629] lxc-int: port 4(vethNJGFQC) entered blocking state
[  134.764631] lxc-int: port 4(vethNJGFQC) entered disabled state
[  134.764681] device vethNJGFQC entered promiscuous mode
[  134.779432] eth0: renamed from vethJGFAGA
[  134.790951] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  134.790983] IPv6: ADDRCONF(NETDEV_CHANGE): vethNJGFQC: link becomes ready
[  134.791006] lxc-int: port 4(vethNJGFQC) entered blocking state
[  134.791007] lxc-int: port 4(vethNJGFQC) entered forwarding state
[  135.786559] lxc-int: port 5(vethUEM27C) entered blocking state
[  135.786561] lxc-int: port 5(vethUEM27C) entered disabled state
[  135.786613] device vethUEM27C entered promiscuous mode
[  135.807362] eth0: renamed from veth689EFP
[  135.821395] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  135.821429] IPv6: ADDRCONF(NETDEV_CHANGE): vethUEM27C: link becomes ready
[  135.821452] lxc-int: port 5(vethUEM27C) entered blocking state
[  135.821453] lxc-int: port 5(vethUEM27C) entered forwarding state
[  136.538475] lxc-int: port 6(tap0) entered blocking state
[  136.538477] lxc-int: port 6(tap0) entered disabled state
[  136.538551] device tap0 entered promiscuous mode
[  136.538577] lxc-int: port 6(tap0) entered blocking state
[  136.538578] lxc-int: port 6(tap0) entered forwarding state
[  136.620181] xt_physdev: --physdev-out and --physdev-is-out only
supported in the FORWARD and POSTROUTING chains with bridged traffic
[  136.622962] Bridge firewalling registered
[  136.626470] xt_physdev: --physdev-out and --physdev-is-out only
supported in the FORWARD and POSTROUTING chains with bridged traffic
[  136.627632] xt_physdev: --physdev-out and --physdev-is-out only
supported in the FORWARD and POSTROUTING chains with bridged traffic
[  136.682233] radeon_dp_aux_transfer_native: 76 callbacks suppressed
[  136.802788] lxc-br: port 3(vethDQ9H19) entered blocking state
[  136.802789] lxc-br: port 3(vethDQ9H19) entered disabled state
[  136.802820] device vethDQ9H19 entered promiscuous mode
[  136.818931] eth0: renamed from vethAN8KFT
[  136.829410] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  136.829446] IPv6: ADDRCONF(NETDEV_CHANGE): vethDQ9H19: link becomes ready
[  136.829472] lxc-br: port 3(vethDQ9H19) entered blocking state
[  136.829474] lxc-br: port 3(vethDQ9H19) entered forwarding state
[  137.325280] lxc-int: port 5(vethUEM27C) entered disabled state
[  137.373151] lxc-int: port 5(vethUEM27C) entered blocking state
[  137.373154] lxc-int: port 5(vethUEM27C) entered forwarding state
[  138.049600] lxc-br: port 3(vethDQ9H19) entered disabled state
[  138.090732] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  138.090776] lxc-br: port 3(vethDQ9H19) entered blocking state
[  138.090777] lxc-br: port 3(vethDQ9H19) entered forwarding state
[  139.061588] NFSD: attempt to initialize umh client tracking in a
container ignored.
[  139.075397] NFSD: attempt to initialize legacy client tracking in a
container ignored.
[  139.075399] NFSD: Unable to initialize client recovery tracking! (-22)
[  139.075400] NFSD: starting 90-second grace period (net f00003d4)
[  139.220825] lxc-br: port 2(vethHR7W40) entered disabled state
[  139.248103] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  139.248154] lxc-br: port 2(vethHR7W40) entered blocking state
[  139.248157] lxc-br: port 2(vethHR7W40) entered forwarding state
[  142.507291] BTRFS error (device dm-2): parent transid verify failed
on 13395960053760 wanted 2265296 found 2263090
[  142.544548] BTRFS error (device dm-2): parent transid verify failed
on 13395960053760 wanted 2265296 found 2263090
[  142.544561] BTRFS: error (device dm-2) in
btrfs_run_delayed_refs:2907: errno=-5 IO failure
[  142.544564] BTRFS info (device dm-2): forced readonly
[  144.108801] lxc-int: port 2(veth4OH9N0) entered disabled state
[  144.144061] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  144.144110] lxc-int: port 2(veth4OH9N0) entered blocking state
[  144.144113] lxc-int: port 2(veth4OH9N0) entered forwarding state
[  145.973587] NFSD: attempt to initialize umh client tracking in a
container ignored.
[  145.973629] NFSD: attempt to initialize legacy client tracking in a
container ignored.
[  145.973629] NFSD: Unable to initialize client recovery tracking! (-22)
[  145.973631] NFSD: starting 90-second grace period (net f0000492)
[  146.341292] lxc-int: port 4(vethNJGFQC) entered disabled state
[  146.379910] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  146.379947] lxc-int: port 4(vethNJGFQC) entered blocking state
[  146.379949] lxc-int: port 4(vethNJGFQC) entered forwarding state
[  156.039660] lxc-int: port 3(veth70VEEM) entered disabled state
[  156.069863] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  156.069900] lxc-int: port 3(veth70VEEM) entered blocking state
[  156.069902] lxc-int: port 3(veth70VEEM) entered forwarding state


