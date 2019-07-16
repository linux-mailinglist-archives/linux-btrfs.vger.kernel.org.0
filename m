Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB836A6C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfGPKtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 06:49:08 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:32966 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPKtI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 06:49:08 -0400
Received: by mail-wr1-f44.google.com with SMTP id n9so20462815wru.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ww1r6+dmWJXa9/TA58IkjzQA3wdeEzt+KUqoL/YO9Z4=;
        b=GpfQT+ANr1Im0r45MvtuGdQve25IDW+k3CeHTkvBDr6cO7fHVpnecI1IXgjZm2EPhd
         s2HI0f5fHKh9Z9mBbeXh62bkEkeDAFUhvaXwMTPZ0uFR4rD+q7hcXERIXLGYPGZe3PTr
         itWsm0xm5k9zsxpHMMri7aI1GF7gZcXV4wX2fH3YmOV1BpKnuF45IoGt9I6UXeKQmoYg
         1eQnfY5Q3yv56E3OYkLyriE9uTmFsLZxy1NWlf5o5ecyoh86cTjCP1taKbdHCLMzA+6e
         JYq/crVct75+8sRxZWdqiW/QXh8n4t3prHHAGFfT+oycSTmdL7ymLVzdtTuiMbEcaAdj
         1MLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ww1r6+dmWJXa9/TA58IkjzQA3wdeEzt+KUqoL/YO9Z4=;
        b=ilLqtYhruJEsTEzESgwPyWqdi8BjE8EcBx+KZJs8cAm3PE/0CSGpOrsbAQOXYXI+Bf
         Z+9D39KMEAAZ0UXJS/pkNsIxAHlkR6xRuQZGOqJmpQuN953INEKsX4gj6a24mgu5tSFH
         H+A6dmNGy4BREKFCU7uUfmv0AHjwr8IW9VBIy7FGjj204v18rJjxU5wiSMsnn6M1NyTp
         zU5VfVdhhfNNPouxjPvKoOoGF8W4im2/MEGm0maQUtqGS0Fv5rc0L83LcHFZoG4IbDHd
         6v8XHVQNZguAepPZ+xcvOQEW5zFGRQR+uAbdZhRKFaTimkVe8AC80mEeaWB4Wbqu+hdr
         NZrw==
X-Gm-Message-State: APjAAAUsMnVs+IDLG2jWtigsjUPCipjbe2bBGTsQszMD9JBJZs9/Q/JQ
        cREIsbfoPuGTXfObe8zdnFjxAO5ujsse849/q/DSzfH4iJQ=
X-Google-Smtp-Source: APXvYqzhek81xm4IYe/RsmZNaGr2uM6T1a79TMrgbVpnL8jcAygO5zAmsUe7SzBO1sz6weL7H0res71dj/WxzOkNlN8=
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr36682371wrw.304.1563274139085;
 Tue, 16 Jul 2019 03:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABDitb8iKge1Ut41qxQSG2ep1ozp2Veieha072eANqn_L_LCNw@mail.gmail.com>
 <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
In-Reply-To: <c8ddfed7-bdae-4405-5bec-082b261e07cb@gmx.com>
From:   mangoblues@gmail.com
Date:   Tue, 16 Jul 2019 12:48:48 +0200
Message-ID: <CABDitb-q8EH-na9URkFbcfAPDoskFZV-qwKx3UCh4ZHvXUw0vw@mail.gmail.com>
Subject: Re: [BUG] Kernel 5.2: mount fails with can't read superblock on
 /dev/sdb1 (kernel 5.1.16 and 4.19 is fine)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I have now updated to kernel 5.2.1 and btrfs-progs 5.2, it didn't
change anything. (reverting back to kernels prior to 5.2 fixes the
problem)

dmesg shows:

---start cut---
[    9.499103] BTRFS: device label disk1 devid 1 transid 564351 /dev/sdh1
[    9.549915] BTRFS info (device sdh1): enabling auto defrag
[    9.549919] BTRFS info (device sdh1): disk space caching is enabled
[   11.040906] BTRFS critical (device sdb1): corrupt leaf: root=3D5
block=3D3210507616256 slot=3D24 ino=3D265, invalid inode generation: has
140000853721088 expect [0, 50548]
[   11.040912] BTRFS error (device sdb1): block=3D3210507616256 read
time tree block corruption detected
[   11.734989] audit: type=3D1130 audit(1563271482.275:8): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Demergency comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   11.810131] audit: type=3D1130 audit(1563271482.348:9): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   11.828681] audit: type=3D1127 audit(1563271482.368:10): pid=3D598
uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D' comm=3D"systemd-update-u=
tmp"
exe=3D"/usr/lib/systemd/systemd-update-utmp" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   11.833931] audit: type=3D1130 audit(1563271482.372:11): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-update-utmp
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   12.227881] audit: type=3D1130 audit(1563271482.765:12): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-timesyncd
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   13.781261] BTRFS critical (device sdc1): corrupt leaf: root=3D5
block=3D5051749396480 slot=3D24 ino=3D265, invalid inode generation: has
140471277748224 expect [0, 71589]
[   13.781268] BTRFS error (device sdc1): block=3D5051749396480 read
time tree block corruption detected
---end---

btrfsck shows everything is fine:

Opening filesystem to check...
Checking filesystem on /dev/sdb1
UUID: 37d68257-a2bf-44e4-82e6-7bda35d3af3c
found 1944732672000 bytes used, no error found
total csum bytes: 1828991772
total tree bytes: 2113806336
total fs tree bytes: 10858496
total extent tree bytes: 65564672
btree space waste bytes: 117676730
file data blocks allocated: 2099709243392
 referenced 1941403754496

Opening filesystem to check...
Checking filesystem on /dev/sdc1
UUID: 8b72d7bd-603c-41c0-a395-a763ffe0de8b
found 2917632086016 bytes used, no error found
total csum bytes: 2820778500
total tree bytes: 3325902848
total fs tree bytes: 26071040
total extent tree bytes: 114151424
btree space waste bytes: 238316653
file data blocks allocated: 3056736382976
 referenced 2913002852352

And finally, here is the full dmesg if you need more info:

[    0.000000] microcode: microcode updated early to revision 0x25,
date =3D 2019-02-26
[    0.000000] Linux version 5.2.1-arch1-1-ARCH
(builduser@heftig-55221) (gcc version 9.1.0 (GCC)) #1 SMP PREEMPT Sun
Jul 14 14:52:52 UTC 2019
[    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-linux
root=3DUUID=3Dc4835a50-8ef0-4342-80e2-4296f5ecc5a2 rw quiet
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
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is
832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c61dbfff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000c61dc000-0x00000000c61e2fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000c61e3000-0x00000000d9a73fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000d9a74000-0x00000000d9b07fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000d9b08000-0x00000000d9b21fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x00000000d9b22000-0x00000000d9c8afff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000d9c8b000-0x00000000d9f6bfff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000d9f6c000-0x00000000d9ffefff] type =
20
[    0.000000] BIOS-e820: [mem 0x00000000d9fff000-0x00000000d9ffffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x00000000db000000-0x00000000df1fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000021fdfffff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=3D0xd9b0d000  ACPI 2.0=3D0xd9b0d000  SMBIOS=3D0xd=
9f6a518
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI:  /D34010WYK, BIOS WYLPT10H.86A.0043.2016.1116.1449
11/16/2016
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1695.955 MHz processor
[    0.000148] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000150] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000160] last_pfn =3D 0x21fe00 max_arch_pfn =3D 0x400000000
[    0.000166] MTRR default type: uncachable
[    0.000168] MTRR fixed ranges enabled:
[    0.000169]   00000-9FFFF write-back
[    0.000171]   A0000-EFFFF uncachable
[    0.000172]   F0000-FFFFF write-protect
[    0.000173] MTRR variable ranges enabled:
[    0.000175]   0 base 0000000000 mask 7E00000000 write-back
[    0.000177]   1 base 0200000000 mask 7FE0000000 write-back
[    0.000178]   2 base 00E0000000 mask 7FE0000000 uncachable
[    0.000179]   3 base 00DC000000 mask 7FFC000000 uncachable
[    0.000181]   4 base 00DB000000 mask 7FFF000000 uncachable
[    0.000182]   5 base 021FE00000 mask 7FFFE00000 uncachable
[    0.000183]   6 disabled
[    0.000183]   7 disabled
[    0.000184]   8 disabled
[    0.000185]   9 disabled
[    0.001307] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.001556] total RAM covered: 8110M
[    0.001987] Found optimal setting for mtrr clean up
[    0.001989]  gran_size: 64K     chunk_size: 128M     num_reg: 8
 lose cover RAM: 0G
[    0.007887] e820: update [mem 0xdb000000-0xffffffff] usable =3D=3D> rese=
rved
[    0.007894] last_pfn =3D 0xda000 max_arch_pfn =3D 0x400000000
[    0.020624] check: Scanning 1 areas for low memory corruption
[    0.020629] Using GB pages for direct mapping
[    0.020632] BRK [0x1ae001000, 0x1ae001fff] PGTABLE
[    0.020635] BRK [0x1ae002000, 0x1ae002fff] PGTABLE
[    0.020636] BRK [0x1ae003000, 0x1ae003fff] PGTABLE
[    0.020697] BRK [0x1ae004000, 0x1ae004fff] PGTABLE
[    0.020699] BRK [0x1ae005000, 0x1ae005fff] PGTABLE
[    0.021000] BRK [0x1ae006000, 0x1ae006fff] PGTABLE
[    0.021072] BRK [0x1ae007000, 0x1ae007fff] PGTABLE
[    0.021287] BRK [0x1ae008000, 0x1ae008fff] PGTABLE
[    0.021391] BRK [0x1ae009000, 0x1ae009fff] PGTABLE
[    0.021491] Secure boot could not be determined
[    0.021493] RAMDISK: [mem 0x36973000-0x374b0fff]
[    0.021501] ACPI: Early table checksum verification disabled
[    0.021505] ACPI: RSDP 0x00000000D9B0D000 000024 (v02 INTEL )
[    0.021510] ACPI: XSDT 0x00000000D9B0D088 00008C (v01 INTEL
D34010WY 0000002B AMI  00010013)
[    0.021517] ACPI: FACP 0x00000000D9B1CD18 00010C (v05 INTEL
D34010WY 0000002B AMI  00010013)
[    0.021524] ACPI: DSDT 0x00000000D9B0D1A0 00FB78 (v02 INTEL
D34010WY 0000002B INTL 20120711)
[    0.021528] ACPI: FACS 0x00000000D9C8AF80 000040
[    0.021532] ACPI: APIC 0x00000000D9B1CE28 000072 (v03 INTEL
D34010WY 0000002B AMI  00010013)
[    0.021535] ACPI: FPDT 0x00000000D9B1CEA0 000044 (v01 INTEL
D34010WY 0000002B AMI  00010013)
[    0.021539] ACPI: FIDT 0x00000000D9B1CEE8 00009C (v01 INTEL
D34010WY 0000002B AMI  00010013)
[    0.021543] ACPI: SSDT 0x00000000D9B1CF88 0004B5 (v01 INTEL
D34010WY 0000002B INTL 20120711)
[    0.021547] ACPI: SSDT 0x00000000D9B1D440 000AD8 (v01 INTEL
D34010WY 0000002B INTL 20120711)
[    0.021550] ACPI: MCFG 0x00000000D9B1DF18 00003C (v01 INTEL
D34010WY 0000002B MSFT 00000097)
[    0.021554] ACPI: HPET 0x00000000D9B1DF58 000038 (v01 INTEL
D34010WY 0000002B AMI. 00000005)
[    0.021558] ACPI: SSDT 0x00000000D9B1DF90 000315 (v01 INTEL
D34010WY 0000002B INTL 20120711)
[    0.021562] ACPI: SSDT 0x00000000D9B1E2A8 0030DF (v01 INTEL
D34010WY 0000002B INTL 20091112)
[    0.021565] ACPI: BGRT 0x00000000D9B21388 000038 (v00 INTEL
D34010WY 0000002B AMI  00010013)
[    0.021569] ACPI: DMAR 0x00000000D9B213C0 0001AC (v01 INTEL
D34010WY 0000002B INTL 00000001)
[    0.021573] ACPI: CSRT 0x00000000D9B21570 0000C4 (v01 INTEL
D34010WY 0000002B INTL 20100528)
[    0.021582] ACPI: Local APIC address 0xfee00000
[    0.021691] No NUMA configuration found
[    0.021692] Faking a node at [mem 0x0000000000000000-0x000000021fdfffff]
[    0.021697] NODE_DATA(0) allocated [mem 0x21fdfc000-0x21fdfffff]
[    0.021727] Zone ranges:
[    0.021728]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.021729]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.021731]   Normal   [mem 0x0000000100000000-0x000000021fdfffff]
[    0.021732]   Device   empty
[    0.021733] Movable zone start for each node
[    0.021734] Early memory node ranges
[    0.021735]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.021737]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.021738]   node   0: [mem 0x0000000000100000-0x00000000c61dbfff]
[    0.021739]   node   0: [mem 0x00000000c61e3000-0x00000000d9a73fff]
[    0.021739]   node   0: [mem 0x00000000d9fff000-0x00000000d9ffffff]
[    0.021740]   node   0: [mem 0x0000000100000000-0x000000021fdfffff]
[    0.021942] Zeroed struct page in unavailable ranges: 26102 pages
[    0.021943] Initmem setup node 0 [mem 0x0000000000001000-0x000000021fdff=
fff]
[    0.021945] On node 0 totalpages: 2070538
[    0.021947]   DMA zone: 64 pages used for memmap
[    0.021947]   DMA zone: 22 pages reserved
[    0.021949]   DMA zone: 3996 pages, LIFO batch:0
[    0.022018]   DMA32 zone: 13866 pages used for memmap
[    0.022020]   DMA32 zone: 887406 pages, LIFO batch:63
[    0.037460]   Normal zone: 18424 pages used for memmap
[    0.037462]   Normal zone: 1179136 pages, LIFO batch:63
[    0.056723] Reserving Intel graphics memory at [mem 0xdb200000-0xdf1ffff=
f]
[    0.056814] ACPI: PM-Timer IO Port: 0x1808
[    0.056817] ACPI: Local APIC address 0xfee00000
[    0.056825] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.056839] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-=
39
[    0.056842] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.056844] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.056845] ACPI: IRQ0 used by override.
[    0.056847] ACPI: IRQ9 used by override.
[    0.056849] Using ACPI (MADT) for SMP configuration information
[    0.056852] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.056865] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.056897] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.056899] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.056901] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.056902] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.056905] PM: Registered nosave memory: [mem 0xc61dc000-0xc61e2fff]
[    0.056907] PM: Registered nosave memory: [mem 0xd9a74000-0xd9b07fff]
[    0.056908] PM: Registered nosave memory: [mem 0xd9b08000-0xd9b21fff]
[    0.056909] PM: Registered nosave memory: [mem 0xd9b22000-0xd9c8afff]
[    0.056910] PM: Registered nosave memory: [mem 0xd9c8b000-0xd9f6bfff]
[    0.056910] PM: Registered nosave memory: [mem 0xd9f6c000-0xd9ffefff]
[    0.056913] PM: Registered nosave memory: [mem 0xda000000-0xdaffffff]
[    0.056914] PM: Registered nosave memory: [mem 0xdb000000-0xdf1fffff]
[    0.056915] PM: Registered nosave memory: [mem 0xdf200000-0xf7ffffff]
[    0.056915] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.056916] PM: Registered nosave memory: [mem 0xfc000000-0xfebfffff]
[    0.056917] PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.056918] PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.056919] PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
[    0.056919] PM: Registered nosave memory: [mem 0xfed04000-0xfed1bfff]
[    0.056920] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1ffff]
[    0.056921] PM: Registered nosave memory: [mem 0xfed20000-0xfedfffff]
[    0.056922] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.056923] PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
[    0.056924] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.056926] [mem 0xdf200000-0xf7ffffff] available for PCI devices
[    0.056928] Booting paravirtualized kernel on bare hardware
[    0.056931] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.273022] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320
nr_cpu_ids:4 nr_node_ids:1
[    0.273387] percpu: Embedded 54 pages/cpu s184320 r8192 d28672 u524288
[    0.273397] pcpu-alloc: s184320 r8192 d28672 u524288 alloc=3D1*2097152
[    0.273399] pcpu-alloc: [0] 0 1 2 3
[    0.273426] Built 1 zonelists, mobility grouping on.  Total pages: 20381=
62
[    0.273427] Policy zone: Normal
[    0.273430] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-linux
root=3DUUID=3Dc4835a50-8ef0-4342-80e2-4296f5ecc5a2 rw quiet
[    0.280978] Calgary: detecting Calgary via BIOS EBDA area
[    0.280979] Calgary: Unable to locate Rio Grande table in EBDA - bailing=
!
[    0.318779] Memory: 7968876K/8282152K available (12291K kernel
code, 1320K rwdata, 3888K rodata, 1612K init, 2880K bss, 313276K
reserved, 0K cma-reserved)
[    0.318954] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.318967] Kernel/User page tables isolation: enabled
[    0.318987] ftrace: allocating 37370 entries in 146 pages
[    0.341363] rcu: Preemptible hierarchical RCU implementation.
[    0.341365] rcu:     CONFIG_RCU_FANOUT set to non-default value of 32.
[    0.341366] rcu:     RCU dyntick-idle grace-period acceleration is enabl=
ed.
[    0.341367] rcu:     RCU restricting CPUs from NR_CPUS=3D320 to nr_cpu_i=
ds=3D4.
[    0.341368] rcu:     RCU priority boosting: priority 1 delay 500 ms.
[    0.341369]     Tasks RCU enabled.
[    0.341370] rcu: RCU calculated value of scheduler-enlistment delay
is 30 jiffies.
[    0.341371] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D4
[    0.343973] NR_IRQS: 20736, nr_irqs: 728, preallocated irqs: 16
[    0.344150] rcu:     Offload RCU callbacks from CPUs: (none).
[    0.344236] random: get_random_bytes called from
start_kernel+0x37e/0x559 with crng_init=3D0
[    0.344267] Console: colour dummy device 80x25
[    0.344273] printk: console [tty0] enabled
[    0.344298] ACPI: Core revision 20190509
[    0.344583] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484882848 ns
[    0.344591] hpet clockevent registered
[    0.344597] APIC: Switch to symmetric I/O mode setup
[    0.344599] DMAR: Host address width 39
[    0.344601] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.344607] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap
c0000020660462 ecap f0101a
[    0.344608] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.344613] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008020660462 ecap f010da
[    0.344614] DMAR: RMRR base: 0x000000d9eb0000 end: 0x000000d9ebefff
[    0.344615] DMAR: RMRR base: 0x000000db000000 end: 0x000000df1fffff
[    0.344617] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.344618] DMAR: ANDD device: 2 name: \_SB.PCI0.I2C1
[    0.344618] DMAR: ANDD device: 3 name: \_SB.PCI0.SPI0
[    0.344619] DMAR: ANDD device: 4 name: \_SB.PCI0.SPI1
[    0.344620] DMAR: ANDD device: 5 name: \_SB.PCI0.UA00
[    0.344620] DMAR: ANDD device: 6 name: \_SB.PCI0.UA01
[    0.344621] DMAR: ANDD device: 7 name: \_SB.PCI0.SDHC
[    0.344624] DMAR-IR: IOAPIC id 8 under DRHD base  0xfed91000 IOMMU 1
[    0.344625] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.344626] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    0.345406] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.345407] x2apic enabled
[    0.345413] Switched APIC routing to cluster x2apic.
[    0.346055] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.361270] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x18723a249bb, max_idle_ns: 440795273391 ns
[    0.361275] Calibrating delay loop (skipped), value calculated
using timer frequency.. 3393.23 BogoMIPS (lpj=3D5653183)
[    0.361278] pid_max: default: 32768 minimum: 301
[    0.365394] LSM: Security Framework initializing
[    0.365399] Yama: becoming mindful.
[    0.367329] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.368319] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.368365] Mount-cache hash table entries: 16384 (order: 5, 131072 byte=
s)
[    0.368395] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.368598] *** VALIDATE proc ***
[    0.368663] *** VALIDATE cgroup1 ***
[    0.368664] *** VALIDATE cgroup2 ***
[    0.368725] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.368740] process: using mwait in idle threads
[    0.368743] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 1024
[    0.368744] Last level dTLB entries: 4KB 1024, 2MB 1024, 4MB 1024, 1GB 4
[    0.368747] Spectre V2 : Mitigation: Full generic retpoline
[    0.368747] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.368748] Spectre V2 : Enabling Restricted Speculation for firmware ca=
lls
[    0.368751] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.368752] Spectre V2 : User space: Mitigation: STIBP via seccomp and p=
rctl
[    0.368754] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl and seccomp
[    0.368758] MDS: Mitigation: Clear CPU buffers
[    0.368995] Freeing SMP alternatives memory: 32K
[    0.370399] TSC deadline timer enabled
[    0.370402] smpboot: CPU0: Intel(R) Core(TM) i3-4010U CPU @ 1.70GHz
(family: 0x6, model: 0x45, stepping: 0x1)
[    0.387948] Performance Events: PEBS fmt2+, Haswell events, 16-deep
LBR, full-width counters, Intel PMU driver.
[    0.387994] ... version:                3
[    0.387994] ... bit width:              48
[    0.387995] ... generic registers:      4
[    0.387996] ... value mask:             0000ffffffffffff
[    0.387997] ... max period:             00007fffffffffff
[    0.387998] ... fixed-purpose events:   3
[    0.387999] ... event mask:             000000070000000f
[    0.394610] rcu: Hierarchical SRCU implementation.
[    0.418091] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.424618] smp: Bringing up secondary CPUs ...
[    0.464626] x86: Booting SMP configuration:
[    0.464627] .... node  #0, CPUs:      #1 #2
[    0.505094] MDS CPU bug present and SMT on, data leak possible. See
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html
for more details.
[    0.544627]  #3
[    0.545068] smp: Brought up 1 node, 4 CPUs
[    0.545068] smpboot: Max logical packages: 1
[    0.545068] smpboot: Total of 4 processors activated (13573.95 BogoMIPS)
[    0.548266] devtmpfs: initialized
[    0.548266] x86/mm: Memory block size: 128MB
[    0.548916] PM: Registering ACPI NVS region [mem
0xc61dc000-0xc61e2fff] (28672 bytes)
[    0.548916] PM: Registering ACPI NVS region [mem
0xd9b22000-0xd9c8afff] (1478656 bytes)
[    0.548916] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.548916] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.548916] pinctrl core: initialized pinctrl subsystem
[    0.548916] PM: RTC time: 10:04:31, date: 2019-07-16
[    0.548916] NET: Registered protocol family 16
[    0.548916] audit: initializing netlink subsys (disabled)
[    0.548916] audit: type=3D2000 audit(1563271470.203:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.548916] cpuidle: using governor ladder
[    0.548916] cpuidle: using governor menu
[    0.548916] ACPI FADT declares the system doesn't support PCIe
ASPM, so disable it
[    0.548916] ACPI: bus type PCI registered
[    0.548916] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.548916] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem
0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.548916] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E82=
0
[    0.548916] PCI: Using configuration type 1 for base access
[    0.548916] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    0.552069] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.552069] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.554750] ACPI: Added _OSI(Module Device)
[    0.554751] ACPI: Added _OSI(Processor Device)
[    0.554752] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.554753] ACPI: Added _OSI(Processor Aggregator Device)
[    0.554755] ACPI: Added _OSI(Linux-Dell-Video)
[    0.554756] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.554757] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.574676] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    0.578479] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.579957] ACPI: Dynamic OEM Table Load:
[    0.579964] ACPI: SSDT 0xFFFF8CA616286400 0003D3 (v01 PmRef
Cpu0Cst  00003001 INTL 20120711)
[    0.580852] ACPI: Dynamic OEM Table Load:
[    0.580858] ACPI: SSDT 0xFFFF8CA61623B000 0005AA (v01 PmRef  ApIst
  00003000 INTL 20120711)
[    0.581815] ACPI: Dynamic OEM Table Load:
[    0.581820] ACPI: SSDT 0xFFFF8CA615C8D000 000119 (v01 PmRef  ApCst
  00003000 INTL 20120711)
[    0.584098] ACPI: Interpreter enabled
[    0.584138] ACPI: (supports S0 S3 S4 S5)
[    0.584139] ACPI: Using IOAPIC for interrupt routing
[    0.584182] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    0.584835] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.606093] ACPI: Power Resource [FN00] (off)
[    0.606225] ACPI: Power Resource [FN01] (off)
[    0.606350] ACPI: Power Resource [FN02] (off)
[    0.606479] ACPI: Power Resource [FN03] (off)
[    0.606602] ACPI: Power Resource [FN04] (off)
[    0.607888] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    0.607895] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI HPX-Type3]
[    0.609138] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug
SHPCHotplug PME AER PCIeCapability LTR]
[    0.609140] acpi PNP0A08:00: FADT indicates ASPM is unsupported,
using BIOS configuration
[    0.609898] PCI host bridge to bus 0000:00
[    0.609901] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    0.609903] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    0.609905] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.609909] pci_bus 0000:00: root bus resource [mem
0x000c0000-0x000c3fff window]
[    0.609911] pci_bus 0000:00: root bus resource [mem
0x000c4000-0x000c7fff window]
[    0.609912] pci_bus 0000:00: root bus resource [mem
0x000c8000-0x000cbfff window]
[    0.609914] pci_bus 0000:00: root bus resource [mem
0x000cc000-0x000cffff window]
[    0.609915] pci_bus 0000:00: root bus resource [mem
0x000d0000-0x000d3fff window]
[    0.609917] pci_bus 0000:00: root bus resource [mem
0x000d4000-0x000d7fff window]
[    0.609918] pci_bus 0000:00: root bus resource [mem
0x000d8000-0x000dbfff window]
[    0.609920] pci_bus 0000:00: root bus resource [mem
0x000dc000-0x000dffff window]
[    0.609921] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000e3fff window]
[    0.609923] pci_bus 0000:00: root bus resource [mem
0x000e4000-0x000e7fff window]
[    0.609924] pci_bus 0000:00: root bus resource [mem
0x000e8000-0x000ebfff window]
[    0.609926] pci_bus 0000:00: root bus resource [mem
0x000ec000-0x000effff window]
[    0.609927] pci_bus 0000:00: root bus resource [mem
0xdf200000-0xfeafffff window]
[    0.609929] pci_bus 0000:00: root bus resource [bus 00-3e]
[    0.609939] pci 0000:00:00.0: [8086:0a04] type 00 class 0x060000
[    0.610115] pci 0000:00:02.0: [8086:0a16] type 00 class 0x030000
[    0.610131] pci 0000:00:02.0: reg 0x10: [mem 0xf7800000-0xf7bfffff 64bit=
]
[    0.610139] pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff
64bit pref]
[    0.610145] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
[    0.610162] pci 0000:00:02.0: BAR 2: assigned to efifb
[    0.610302] pci 0000:00:03.0: [8086:0a0c] type 00 class 0x040300
[    0.610314] pci 0000:00:03.0: reg 0x10: [mem 0xf7d34000-0xf7d37fff 64bit=
]
[    0.610487] pci 0000:00:14.0: [8086:9c31] type 00 class 0x0c0330
[    0.610509] pci 0000:00:14.0: reg 0x10: [mem 0xf7d20000-0xf7d2ffff 64bit=
]
[    0.610574] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.610712] pci 0000:00:16.0: [8086:9c3a] type 00 class 0x078000
[    0.610737] pci 0000:00:16.0: reg 0x10: [mem 0xf7d3e000-0xf7d3e01f 64bit=
]
[    0.610812] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.610949] pci 0000:00:19.0: [8086:1559] type 00 class 0x020000
[    0.610969] pci 0000:00:19.0: reg 0x10: [mem 0xf7d00000-0xf7d1ffff]
[    0.610977] pci 0000:00:19.0: reg 0x14: [mem 0xf7d3c000-0xf7d3cfff]
[    0.610985] pci 0000:00:19.0: reg 0x18: [io  0xf080-0xf09f]
[    0.611048] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.611185] pci 0000:00:1b.0: [8086:9c20] type 00 class 0x040300
[    0.611204] pci 0000:00:1b.0: reg 0x10: [mem 0xf7d30000-0xf7d33fff 64bit=
]
[    0.611269] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.611418] pci 0000:00:1c.0: [8086:9c10] type 01 class 0x060400
[    0.611518] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.611756] pci 0000:00:1c.3: [8086:9c16] type 01 class 0x060400
[    0.611862] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.612088] pci 0000:00:1d.0: [8086:9c26] type 00 class 0x0c0320
[    0.612112] pci 0000:00:1d.0: reg 0x10: [mem 0xf7d3b000-0xf7d3b3ff]
[    0.612205] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.612346] pci 0000:00:1f.0: [8086:9c43] type 00 class 0x060100
[    0.612592] pci 0000:00:1f.2: [8086:9c03] type 00 class 0x010601
[    0.612609] pci 0000:00:1f.2: reg 0x10: [io  0xf0d0-0xf0d7]
[    0.612617] pci 0000:00:1f.2: reg 0x14: [io  0xf0c0-0xf0c3]
[    0.612624] pci 0000:00:1f.2: reg 0x18: [io  0xf0b0-0xf0b7]
[    0.612632] pci 0000:00:1f.2: reg 0x1c: [io  0xf0a0-0xf0a3]
[    0.612639] pci 0000:00:1f.2: reg 0x20: [io  0xf060-0xf07f]
[    0.612647] pci 0000:00:1f.2: reg 0x24: [mem 0xf7d3a000-0xf7d3a7ff]
[    0.612686] pci 0000:00:1f.2: PME# supported from D3hot
[    0.612815] pci 0000:00:1f.3: [8086:9c22] type 00 class 0x0c0500
[    0.612834] pci 0000:00:1f.3: reg 0x10: [mem 0xf7d39000-0xf7d390ff 64bit=
]
[    0.612855] pci 0000:00:1f.3: reg 0x20: [io  0xf040-0xf05f]
[    0.613093] acpiphp: Slot [1] registered
[    0.613106] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.613223] pci 0000:02:00.0: [168c:002b] type 00 class 0x028000
[    0.613276] pci 0000:02:00.0: reg 0x10: [mem 0xf7c00000-0xf7c0ffff 64bit=
]
[    0.613623] pci 0000:02:00.0: supports D1
[    0.613624] pci 0000:02:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.613816] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.613821] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff=
]
[    0.615546] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.615646] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.615740] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.615833] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.615926] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.616017] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.616110] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.616202] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12
14 15) *0, disabled.
[    0.616870] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.616870] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    0.616870] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.616870] vgaarb: loaded
[    0.616870] ACPI: bus type USB registered
[    0.616870] usbcore: registered new interface driver usbfs
[    0.616870] usbcore: registered new interface driver hub
[    0.616870] usbcore: registered new device driver usb
[    0.616870] pps_core: LinuxPPS API ver. 1 registered
[    0.616870] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.616870] PTP clock support registered
[    0.616870] EDAC MC: Ver: 3.0.0
[    0.616870] Registered efivars operations
[    0.621382] PCI: Using ACPI for IRQ routing
[    0.622770] PCI: pci_cache_line_size set to 64 bytes
[    0.622823] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    0.622824] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    0.622825] e820: reserve RAM buffer [mem 0xc61dc000-0xc7ffffff]
[    0.622827] e820: reserve RAM buffer [mem 0xd9a74000-0xdbffffff]
[    0.622829] e820: reserve RAM buffer [mem 0xda000000-0xdbffffff]
[    0.622830] e820: reserve RAM buffer [mem 0x21fe00000-0x21fffffff]
[    0.622959] NetLabel: Initializing
[    0.622960] NetLabel:  domain hash size =3D 128
[    0.622961] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.622979] NetLabel:  unlabeled traffic allowed by default
[    0.624976] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.624982] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.627994] clocksource: Switched to clocksource tsc-early
[    0.644156] VFS: Disk quotas dquot_6.6.0
[    0.644175] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.644211] *** VALIDATE hugetlbfs ***
[    0.644268] pnp: PnP ACPI init
[    0.644416] system 00:00: [mem 0xfed40000-0xfed44fff] has been reserved
[    0.644423] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active=
)
[    0.644750] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.644752] system 00:01: [io  0xffff] has been reserved
[    0.644754] system 00:01: [io  0xffff] has been reserved
[    0.644756] system 00:01: [io  0xffff] has been reserved
[    0.644758] system 00:01: [io  0x1c00-0x1cfe] has been reserved
[    0.644759] system 00:01: [io  0x1d00-0x1dfe] has been reserved
[    0.644761] system 00:01: [io  0x1e00-0x1efe] has been reserved
[    0.644763] system 00:01: [io  0x1f00-0x1ffe] has been reserved
[    0.644765] system 00:01: [io  0x1800-0x18fe] has been reserved
[    0.644766] system 00:01: [io  0x164e-0x164f] has been reserved
[    0.644771] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.644804] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.644881] system 00:03: [io  0x1854-0x1857] has been reserved
[    0.644886] system 00:03: Plug and Play ACPI device, IDs INT3f0d
PNP0c02 (active)
[    0.645063] system 00:04: [io  0x0a00-0x0a1f] has been reserved
[    0.645065] system 00:04: [io  0x0a00-0x0a0f] has been reserved
[    0.645069] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.645256] pnp 00:05: Plug and Play ACPI device, IDs NTN0530 (disabled)
[    0.645325] system 00:06: [io  0x04d0-0x04d1] has been reserved
[    0.645329] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.646240] system 00:07: [mem 0xfe102000-0xfe102fff] has been reserved
[    0.646242] system 00:07: [mem 0xfe104000-0xfe104fff] has been reserved
[    0.646244] system 00:07: [mem 0xfe106000-0xfe106fff] has been reserved
[    0.646246] system 00:07: [mem 0xfe108000-0xfe108fff] has been reserved
[    0.646248] system 00:07: [mem 0xfe10a000-0xfe10afff] has been reserved
[    0.646250] system 00:07: [mem 0xfe10c000-0xfe10cfff] has been reserved
[    0.646252] system 00:07: [mem 0xfe10e000-0xfe10efff] has been reserved
[    0.646254] system 00:07: [mem 0xfe112000-0xfe112fff] has been reserved
[    0.646256] system 00:07: [mem 0xfe111000-0xfe111007] has been reserved
[    0.646258] system 00:07: [mem 0xfe111014-0xfe111fff] has been reserved
[    0.646263] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.646884] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.646886] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
[    0.646888] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
[    0.646890] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
[    0.646892] system 00:08: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.646893] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
[    0.646896] system 00:08: [mem 0xfed90000-0xfed93fff] could not be reser=
ved
[    0.646897] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
[    0.646899] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
[    0.646902] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reser=
ved
[    0.646903] system 00:08: [mem 0xf7fdf000-0xf7fdffff] has been reserved
[    0.646905] system 00:08: [mem 0xf7fe0000-0xf7feffff] has been reserved
[    0.646910] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active=
)
[    0.647341] pnp: PnP ACPI: found 9 devices
[    0.653543] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.653555] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    0.653576] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    0.653581] pci 0000:00:1c.3:   bridge window [mem 0xf7c00000-0xf7cfffff=
]
[    0.653591] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.653593] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.653595] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    0.653596] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff windo=
w]
[    0.653598] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff windo=
w]
[    0.653599] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff windo=
w]
[    0.653601] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff wind=
ow]
[    0.653603] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff wind=
ow]
[    0.653604] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff wind=
ow]
[    0.653606] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff wind=
ow]
[    0.653608] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff wind=
ow]
[    0.653609] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff wind=
ow]
[    0.653611] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff wind=
ow]
[    0.653612] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff wind=
ow]
[    0.653614] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff wind=
ow]
[    0.653616] pci_bus 0000:00: resource 19 [mem 0xdf200000-0xfeafffff wind=
ow]
[    0.653618] pci_bus 0000:02: resource 1 [mem 0xf7c00000-0xf7cfffff]
[    0.653844] NET: Registered protocol family 2
[    0.654015] tcp_listen_portaddr_hash hash table entries: 4096
(order: 4, 65536 bytes)
[    0.654058] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    0.654208] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.654398] TCP: Hash tables configured (established 65536 bind 65536)
[    0.654436] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.654468] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.654563] NET: Registered protocol family 1
[    0.654571] NET: Registered protocol family 44
[    0.654583] pci 0000:00:02.0: Video device with shadowed ROM at
[mem 0x000c0000-0x000dffff]
[    0.674757] pci 0000:00:1d.0: quirk_usb_early_handoff+0x0/0x649
took 19364 usecs
[    0.674781] PCI: CLS 64 bytes, default 64
[    0.674826] Trying to unpack rootfs image as initramfs...
[    0.858767] Freeing initrd memory: 11512K
[    0.858813] DMAR: ACPI device "INT33C2:00" under DMAR at fed91000 as 00:=
15.1
[    0.858817] DMAR: ACPI device "INT33C3:00" under DMAR at fed91000 as 00:=
15.2
[    0.858820] DMAR: ACPI device "INT33C0:00" under DMAR at fed91000 as 00:=
15.3
[    0.858823] DMAR: ACPI device "INT33C1:00" under DMAR at fed91000 as 00:=
15.4
[    0.858826] DMAR: ACPI device "INT33C4:00" under DMAR at fed91000 as 00:=
15.5
[    0.858829] DMAR: ACPI device "INT33C5:00" under DMAR at fed91000 as 00:=
15.6
[    0.858832] DMAR: ACPI device "INT33C6:00" under DMAR at fed91000 as 00:=
17.0
[    0.877980] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.877983] software IO TLB: mapped [mem 0xd1261000-0xd5261000] (64MB)
[    0.878129] check: Scanning for low memory corruption every 60 seconds
[    0.878903] Initialise system trusted keyrings
[    0.878915] Key type blacklist registered
[    0.878971] workingset: timestamp_bits=3D41 max_order=3D21 bucket_order=
=3D0
[    0.880800] zbud: loaded
[    0.883200] Key type asymmetric registered
[    0.883202] Asymmetric key parser 'x509' registered
[    0.883214] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 244)
[    0.883262] io scheduler mq-deadline registered
[    0.883263] io scheduler kyber registered
[    0.883327] io scheduler bfq registered
[    0.883796] pcieport 0000:00:1c.0: PME: Signaling with IRQ 42
[    0.884083] pcieport 0000:00:1c.3: PME: Signaling with IRQ 43
[    0.884173] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.884279] efifb: probing for efifb
[    0.884300] efifb: showing boot graphics
[    0.885692] efifb: framebuffer at 0xe0000000, using 8128k, total 8128k
[    0.885693] efifb: mode is 1920x1080x32, linelength=3D7680, pages=3D1
[    0.885694] efifb: scrolling: redraw
[    0.885696] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.885751] fbcon: Deferring console take-over
[    0.885753] fb0: EFI VGA frame buffer device
[    0.885765] intel_idle: MWAIT substates: 0x11142120
[    0.885766] intel_idle: v0.4.1 model 0x45
[    0.886081] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.886180] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.887991] ACPI: Power Button [PWRB]
[    0.888064] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.891324] ACPI: Power Button [PWRF]
[    0.892610] thermal LNXTHERM:00: registered as thermal_zone0
[    0.892612] ACPI: Thermal Zone [TZ00] (28 C)
[    0.893016] thermal LNXTHERM:01: registered as thermal_zone1
[    0.893017] ACPI: Thermal Zone [TZ01] (30 C)
[    0.893355] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.914151] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D
115200) is a 16550A
[    0.915594] usbcore: registered new interface driver usbserial_generic
[    0.915600] usbserial: USB Serial support registered for generic
[    0.915623] rtc_cmos 00:02: RTC can wake from S4
[    0.915800] rtc_cmos 00:02: registered as rtc0
[    0.915822] rtc_cmos 00:02: alarms up to one month, y3k, 242 bytes
nvram, hpet irqs
[    0.915892] intel_pstate: Intel P-state driver initializing
[    0.916102] ledtrig-cpu: registered to indicate activity on CPUs
[    0.916676] NET: Registered protocol family 10
[    0.937722] Segment Routing with IPv6
[    0.937784] NET: Registered protocol family 17
[    0.938228] mce: Using 7 MCE banks
[    0.938244] RAS: Correctable Errors collector initialized.
[    0.938317] microcode: sig=3D0x40651, pf=3D0x40, revision=3D0x25
[    0.938404] microcode: Microcode Update Driver: v2.2.
[    0.938419] sched_clock: Marking stable (937969138,
429094)->(943988668, -5590436)
[    0.938719] registered taskstats version 1
[    0.938728] Loading compiled-in X.509 certificates
[    0.944329] Loaded X.509 cert 'Build time autogenerated kernel key:
bc1e682951c6d55a59900fd12108abe436332297'
[    0.944358] zswap: loaded using pool lzo/zbud
[    0.955121] Key type big_key registered
[    0.955824] PM:   Magic number: 11:779:72
[    0.955958] rtc_cmos 00:02: setting system clock to
2019-07-16T10:04:31 UTC (1563271471)
[    0.957718] Freeing unused decrypted memory: 2040K
[    0.958167] Freeing unused kernel image memory: 1612K
[    0.978130] Write protecting the kernel read-only data: 18432k
[    0.979426] Freeing unused kernel image memory: 2012K
[    0.979679] Freeing unused kernel image memory: 208K
[    1.002812] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.002813] x86/mm: Checking user space page tables
[    1.017743] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.017746] Run /init as init process
[    1.056386] fbcon: Taking over console
[    1.056481] Console: switching to colour frame buffer device 240x67
[    1.177862] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.180275] ehci-pci: EHCI PCI platform driver
[    1.180590] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    1.180602] ehci-pci 0000:00:1d.0: new USB bus registered, assigned
bus number 1
[    1.180619] ehci-pci 0000:00:1d.0: debug port 2
[    1.184540] ehci-pci 0000:00:1d.0: cache line size of 64 is not supporte=
d
[    1.184569] ehci-pci 0000:00:1d.0: irq 23, io mem 0xf7d3b000
[    1.189718] SCSI subsystem initialized
[    1.194731] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    1.194814] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.02
[    1.194817] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.194820] usb usb1: Product: EHCI Host Controller
[    1.194823] usb usb1: Manufacturer: Linux 5.2.1-arch1-1-ARCH ehci_hcd
[    1.194825] usb usb1: SerialNumber: 0000:00:1d.0
[    1.195070] hub 1-0:1.0: USB hub found
[    1.195085] hub 1-0:1.0: 2 ports detected
[    1.195442] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.195456] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    1.196539] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci
version 0x100 quirks 0x000000000004b810
[    1.196549] xhci_hcd 0000:00:14.0: cache line size of 64 is not supporte=
d
[    1.196984] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 5.02
[    1.196988] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.196991] usb usb2: Product: xHCI Host Controller
[    1.196994] usb usb2: Manufacturer: Linux 5.2.1-arch1-1-ARCH xhci-hcd
[    1.196996] usb usb2: SerialNumber: 0000:00:14.0
[    1.197429] hub 2-0:1.0: USB hub found
[    1.197453] hub 2-0:1.0: 9 ports detected
[    1.202431] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.202440] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 3
[    1.202446] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    1.202526] usb usb3: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 5.02
[    1.202530] usb usb3: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    1.202532] usb usb3: Product: xHCI Host Controller
[    1.202535] usb usb3: Manufacturer: Linux 5.2.1-arch1-1-ARCH xhci-hcd
[    1.202538] usb usb3: SerialNumber: 0000:00:14.0
[    1.203042] hub 3-0:1.0: USB hub found
[    1.203061] hub 3-0:1.0: 4 ports detected
[    1.204067] libata version 3.00 loaded.
[    1.211258] ahci 0000:00:1f.2: version 3.0
[    1.211646] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 2 ports 6
Gbps 0x8 impl SATA mode
[    1.211652] ahci 0000:00:1f.2: flags: 64bit ncq pm led clo only pio
slum part deso sadm sds apst
[    1.213929] scsi host0: ahci
[    1.214194] scsi host1: ahci
[    1.214373] scsi host2: ahci
[    1.214508] scsi host3: ahci
[    1.214583] ata1: DUMMY
[    1.214584] ata2: DUMMY
[    1.214585] ata3: DUMMY
[    1.214589] ata4: SATA max UDMA/133 abar m2048@0xf7d3a000 port
0xf7d3a280 irq 45
[    1.524713] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.532114] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.532825] ata4.00: supports DRM functions and may not be fully accessi=
ble
[    1.533056] ata4.00: ATA-11: KINGSTON SUV500MS240G, 003056RI, max UDMA/1=
33
[    1.533062] ata4.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 32), A=
A
[    1.533977] ata4.00: Trusted Computing capability qword not valid!
[    1.534861] ata4.00: supports DRM functions and may not be fully accessi=
ble
[    1.534890] usb 2-1: new full-speed USB device number 2 using xhci_hcd
[    1.535729] ata4.00: Trusted Computing capability qword not valid!
[    1.535741] ata4.00: configured for UDMA/133
[    1.536411] scsi 3:0:0:0: Direct-Access     ATA      KINGSTON
SUV500M 56RI PQ: 0 ANSI: 5
[    1.550483] sd 3:0:0:0: [sda] 468862128 512-byte logical blocks:
(240 GB/224 GiB)
[    1.550489] sd 3:0:0:0: [sda] 4096-byte physical blocks
[    1.550520] sd 3:0:0:0: [sda] Write Protect is off
[    1.550525] sd 3:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.550574] sd 3:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.553115]  sda: sda1 sda2
[    1.553772] sd 3:0:0:0: [sda] Attached SCSI disk
[    1.653171] random: fast init done
[    1.675054] usb 1-1: New USB device found, idVendor=3D8087,
idProduct=3D8000, bcdDevice=3D 0.04
[    1.675058] usb 1-1: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    1.675402] hub 1-1:1.0: USB hub found
[    1.675536] hub 1-1:1.0: 8 ports detected
[    1.677930] usb 2-1: New USB device found, idVendor=3D046d,
idProduct=3Dc52b, bcdDevice=3D12.03
[    1.677936] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.677958] usb 2-1: Product: USB Receiver
[    1.677962] usb 2-1: Manufacturer: Logitech
[    1.688270] hidraw: raw HID events driver (C) Jiri Kosina
[    1.695861] usbcore: registered new interface driver usbhid
[    1.695862] usbhid: USB HID core driver
[    1.737876] EXT4-fs (sda2): mounted filesystem with ordered data
mode. Opts: (null)
[    1.798125] usb 3-3: new SuperSpeed Gen 1 USB device number 2 using xhci=
_hcd
[    1.817172] usb 3-3: New USB device found, idVendor=3D174c,
idProduct=3D3074, bcdDevice=3D 1.00
[    1.817175] usb 3-3: New USB device strings: Mfr=3D2, Product=3D3, Seria=
lNumber=3D1
[    1.817177] usb 3-3: Product: ASM107x
[    1.817179] usb 3-3: Manufacturer: Asmedia
[    1.817180] usb 3-3: SerialNumber: 0000000A0016
[    1.818473] hub 3-3:1.0: USB hub found
[    1.818621] hub 3-3:1.0: 4 ports detected
[    1.891308] tsc: Refined TSC clocksource calibration: 1696.075 MHz
[    1.891318] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x1872ab846c0, max_idle_ns: 440795273396 ns
[    1.891348] clocksource: Switched to clocksource tsc
[    1.898885] systemd[1]: systemd 242.32-3-arch running in system
mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dhybrid)
[    1.914866] systemd[1]: Detected architecture x86-64.
[    1.919708] systemd[1]: Set hostname to <HDA>.
[    1.937986] usb 2-3: new high-speed USB device number 3 using xhci_hcd
[    2.081045] usb 2-3: New USB device found, idVendor=3D174c,
idProduct=3D2074, bcdDevice=3D 1.00
[    2.081048] usb 2-3: New USB device strings: Mfr=3D2, Product=3D3, Seria=
lNumber=3D1
[    2.081050] usb 2-3: Product: ASM107x
[    2.081052] usb 2-3: Manufacturer: Asmedia
[    2.081053] usb 2-3: SerialNumber: 0000000A0016
[    2.081822] hub 2-3:1.0: USB hub found
[    2.082113] hub 2-3:1.0: 4 ports detected
[    2.083896] systemd[1]:
/usr/lib/systemd/system/fail2ban.service:13: PIDFile=3D references a
path below legacy directory /var/run/, updating
/var/run/fail2ban/fail2ban.pid =E2=86=92 /run/fail2ban/fail2ban.pid; please
update the unit file accordingly.
[    2.091058] systemd[1]: Created slice system-netctl.slice.
[    2.091437] systemd[1]: Created slice User and Session Slice.
[    2.091635] systemd[1]: Listening on Journal Socket.
[    2.092752] systemd[1]: Starting Create list of required static
device nodes for the current kernel...
[    2.094735] systemd[1]: Starting Load Kernel Modules...
[    2.094925] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    2.125272] EXT4-fs (sda2): re-mounted. Opts: (null)
[    2.134664] fuse: init (API version 7.31)
[    2.141895] random: lvm: uninitialized urandom read (4 bytes read)
[    2.154659] usb 3-3.3: new SuperSpeed Gen 1 USB device number 3
using xhci_hcd
[    2.173583] usb 3-3.3: New USB device found, idVendor=3D174c,
idProduct=3D3074, bcdDevice=3D 1.00
[    2.173587] usb 3-3.3: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    2.173590] usb 3-3.3: Product: ASM107x
[    2.173593] usb 3-3.3: Manufacturer: Asmedia
[    2.173596] usb 3-3.3: SerialNumber: 0000000A0018
[    2.173878] random: systemd-random-: uninitialized urandom read
(512 bytes read)
[    2.175113] hub 3-3.3:1.0: USB hub found
[    2.175447] hub 3-3.3:1.0: 4 ports detected
[    2.297960] usb 2-7: new full-speed USB device number 4 using xhci_hcd
[    2.438664] usb 2-7: New USB device found, idVendor=3D0cf3,
idProduct=3D3005, bcdDevice=3D 0.01
[    2.438667] usb 2-7: New USB device strings: Mfr=3D0, Product=3D0, Seria=
lNumber=3D0
[    2.511399] usb 3-3.4: new SuperSpeed Gen 1 USB device number 4
using xhci_hcd
[    2.530257] usb 3-3.4: New USB device found, idVendor=3D174c,
idProduct=3D3074, bcdDevice=3D 1.00
[    2.530260] usb 3-3.4: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    2.530263] usb 3-3.4: Product: ASM107x
[    2.530266] usb 3-3.4: Manufacturer: Asmedia
[    2.530268] usb 3-3.4: SerialNumber: 0000000A0012
[    2.547375] hub 3-3.4:1.0: USB hub found
[    2.547772] hub 3-3.4:1.0: 4 ports detected
[    2.596249] audit: type=3D1130 audit(1563271473.135:2): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journald
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    2.611852] systemd-journald[266]: Received request to flush
runtime journal from PID 1
[    2.672914] audit: type=3D1130 audit(1563271473.212:3): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-udevd comm=3D"syst=
emd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[    2.762787] audit: type=3D1130 audit(1563271473.302:4): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-journal-flush
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[    2.827838] nuvoton-cir 00:05: [io  0x0240-0x024f]
[    2.827910] nuvoton-cir 00:05: [irq 3]
[    2.827917] nuvoton-cir 00:05: [io  0x0250-0x025f]
[    2.829966] nuvoton-cir 00:05: activated
[    2.829995] nuvoton-cir 00:05: found NCT6776F or compatible: chip
id: 0xc3 0x33
[    2.867984] Registered IR keymap rc-rc6-mce
[    2.880453] IR RC6 protocol handler initialized
[    2.890193] input: Logitech USB Receiver as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.0/0003:046D:C52B.0001/input=
/input3
[    2.904690] rc rc0: Nuvoton w836x7hg Infrared Remote Transceiver as
/devices/pnp0/00:05/rc/rc0
[    2.904781] input: Nuvoton w836x7hg Infrared Remote Transceiver as
/devices/pnp0/00:05/rc/rc0/input2
[    2.913063] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    2.913107] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.918864] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    2.943203] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.943206] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.943617] e1000e 0000:00:19.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[    2.945045] rc rc0: lirc_dev: driver nuvoton-cir registered at
minor =3D 0, raw IR receiver, no transmitter
[    2.945113] hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID
v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-1/input0
[    2.945610] input: Logitech USB Receiver Mouse as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.1/0003:046D:C52B.0002/input=
/input5
[    2.945778] input: Logitech USB Receiver Consumer Control as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.1/0003:046D:C52B.0002/input=
/input6
[    2.946453] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters,
655360 ms ovfl timer
[    2.946455] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    2.946457] RAPL PMU: hw unit of domain package 2^-14 Joules
[    2.946458] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    2.946460] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    2.948047] nuvoton-cir 00:05: driver has been successfully loaded
[    2.994791] Linux agpgart interface v0.103
[    2.997031] cryptd: max_cpu_qlen set to 1000
[    3.001440] input: Logitech USB Receiver System Control as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.1/0003:046D:C52B.0002/input=
/input7
[    3.001684] hid-generic 0003:046D:C52B.0002: input,hiddev0,hidraw1:
USB HID v1.11 Mouse [Logitech USB Receiver] on
usb-0000:00:14.0-1/input1
[    3.002010] hid-generic 0003:046D:C52B.0003: hiddev1,hidraw2: USB
HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-1/input2
[    3.115140] AVX2 version of gcm_enc/dec engaged.
[    3.115143] AES CTR mode by8 optimization enabled
[    3.133034] audit: type=3D1130 audit(1563271473.672:5): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dlvm2-monitor comm=3D"syste=
md"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[    3.154801] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    3.180311] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.182164] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    3.182169] cfg80211: failed to load regulatory.db
[    3.219288] logitech-djreceiver 0003:046D:C52B.0003:
hiddev0,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on
usb-0000:00:14.0-1/input2
[    3.248838] iTCO_vendor_support: vendor-support=3D0
[    3.264243] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.264311] iTCO_wdt: Found a Lynx Point_LP TCO device (Version=3D2,
TCOBASE=3D0x1860)
[    3.264585] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    3.271393] snd_hda_intel 0000:00:03.0: enabling device (0000 -> 0002)
[    3.271550] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized):
registered PHC clock
[    3.271721] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[    3.291358] usb 3-3.1: new SuperSpeed Gen 1 USB device number 5
using xhci_hcd
[    3.308559] usb 3-3.1: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    3.308564] usb 3-3.1: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    3.308567] usb 3-3.1: Product: ASMT1053E
[    3.308570] usb 3-3.1: Manufacturer: asmedia
[    3.308573] usb 3-3.1: SerialNumber: 12345678925F
[    3.361426] Bluetooth: Core ver 2.22
[    3.361456] NET: Registered protocol family 31
[    3.361458] Bluetooth: HCI device and connection manager initialized
[    3.361464] Bluetooth: HCI socket layer initialized
[    3.361467] Bluetooth: L2CAP socket layer initialized
[    3.361477] Bluetooth: SCO socket layer initialized
[    3.362097] input: Logitech Unifying Device. Wireless PID:400e
Keyboard as /devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.2/0003:046D:C52=
B.0003/0003:046D:400E.0004/input/input9
[    3.362247] input: Logitech Unifying Device. Wireless PID:400e
Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.2/0003:046D:C52B.0=
003/0003:046D:400E.0004/input/input10
[    3.362398] input: Logitech Unifying Device. Wireless PID:400e
Consumer Control as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.2/0003:046D:C52B.0003/0003:=
046D:400E.0004/input/input11
[    3.362509] hid-generic 0003:046D:400E.0004: input,hidraw1: USB HID
v1.11 Keyboard [Logitech Unifying Device. Wireless PID:400e] on
usb-0000:00:14.0-1/input2:1
[    3.391346] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width
x1) ec:a8:6b:fd:05:6a
[    3.391686] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connecti=
on
[    3.391726] e1000e 0000:00:19.0 eth0: MAC: 11, PHY: 12, PBA No: FFFFFF-0=
FF
[    3.395348] snd_hda_codec_realtek hdaudioC1D0: autoconfig for
ALC283: line_outs=3D1 (0x21/0x0/0x0/0x0/0x0) type:hp
[    3.395354] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[    3.395357] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D0
(0x0/0x0/0x0/0x0/0x0)
[    3.395359] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    3.395361] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    3.395364] snd_hda_codec_realtek hdaudioC1D0:      Mic=3D0x19
[    3.406323] e1000e 0000:00:19.0 eno1: renamed from eth0
[    3.408623] intel-spi intel-spi: mx25l6405d (8192 Kbytes)
[    3.410163] usbcore: registered new interface driver usb-storage
[    3.428216] mousedev: PS/2 mouse device common for all mice
[    3.430668] Creating 1 MTD partitions on "intel-spi":
[    3.430674] 0x000000000000-0x000000800000 : "BIOS"
[    3.438486] input: HDA Digital PCBeep as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input15
[    3.438597] input: HDA Intel PCH Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input16
[    3.438706] input: HDA Intel PCH Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card1/input17
[    3.451781] scsi host4: uas
[    3.452273] scsi 4:0:0:0: Direct-Access     ASMT     2105
  0    PQ: 0 ANSI: 6
[    3.452426] usbcore: registered new interface driver uas
[    3.457937] sd 4:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    3.458061] sd 4:0:0:0: [sdb] Write Protect is off
[    3.458065] sd 4:0:0:0: [sdb] Mode Sense: 43 00 00 00
[    3.458227] sd 4:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    3.458429] sd 4:0:0:0: [sdb] Optimal transfer size 33553920 bytes
[    3.510656]  sdb: sdb1
[    3.511857] sd 4:0:0:0: [sdb] Attached SCSI disk
[    3.588295] usbcore: registered new interface driver btusb
[    3.621504] audit: type=3D1130 audit(1563271474.162:6): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"sys=
temd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[    3.767428] checking generic (e0000000 7f0000) vs hw (e0000000 10000000)
[    3.767431] fb0: switching to inteldrmfb from EFI VGA
[    3.767467] Console: switching to colour dummy device 80x25
[    3.771451] i915 0000:00:02.0: vgaarb: deactivate vga console
[    3.773045] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.773047] [drm] Driver supports precise vblank timestamp query.
[    3.773786] i915 0000:00:02.0: vgaarb: changed VGA decodes:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
[    3.802623] [drm] Initialized i915 1.6.0 20190417 for 0000:00:02.0 on mi=
nor 0
[    3.810289] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: n=
o)
[    3.811264] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input18
[    3.811677] snd_hda_intel 0000:00:03.0: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    3.840448] fbcon: i915drmfb (fb0) is primary device
[    3.850573] intel_rapl: Found RAPL domain package
[    3.850576] intel_rapl: Found RAPL domain core
[    3.850578] intel_rapl: Found RAPL domain uncore
[    3.850580] intel_rapl: Found RAPL domain dram
[    3.882998] ath9k 0000:02:00.0: enabling device (0000 -> 0002)
[    3.883241] ath: phy0: Set BT/WLAN RX diversity capability
[    3.898042] Console: switching to colour frame buffer device 240x67
[    3.920701] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
[    3.934881] ath: phy0: ASPM enabled: 0x43
[    3.934886] ath: EEPROM regdomain: 0x60
[    3.934888] ath: EEPROM indicates we should expect a direct regpair map
[    3.934892] ath: Country alpha2 being used: 00
[    3.934893] ath: Regpair used: 0x60
[    3.948842] ieee80211 phy0: Selected rate control algorithm 'minstrel_ht=
'
[    3.949506] ieee80211 phy0: Atheros AR9285 Rev:2
mem=3D0xffff9757c1390000, irq=3D19
[    3.954264] ath9k 0000:02:00.0 wlp2s0: renamed from wlan0
[    3.967046] input: HDA Intel HDMI HDMI/DP,pcm=3D3 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input19
[    3.967153] input: HDA Intel HDMI HDMI/DP,pcm=3D7 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input20
[    3.967257] input: HDA Intel HDMI HDMI/DP,pcm=3D8 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input21
[    3.967366] input: HDA Intel HDMI HDMI/DP,pcm=3D9 as
/devices/pci0000:00/0000:00:03.0/sound/card0/input22
[    4.011299] raid6: avx2x4   gen() 13151 MB/s
[    4.053931] logitech-hidpp-device 0003:046D:400E.0004: HID++ 2.0
device connected.
[    4.068098] raid6: avx2x4   xor()  9111 MB/s
[    4.071369] usb 3-3.2: new SuperSpeed Gen 1 USB device number 6
using xhci_hcd
[    4.091881] usb 3-3.2: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    4.091885] usb 3-3.2: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    4.091887] usb 3-3.2: Product: ASMT1053E
[    4.091888] usb 3-3.2: Manufacturer: asmedia
[    4.091890] usb 3-3.2: SerialNumber: 123456789260
[    4.116241] scsi host5: uas
[    4.116771] scsi 5:0:0:0: Direct-Access     ASMT     2105
  0    PQ: 0 ANSI: 6
[    4.122434] sd 5:0:0:0: [sdc] 5860533168 512-byte logical blocks:
(3.00 TB/2.73 TiB)
[    4.122437] sd 5:0:0:0: [sdc] 4096-byte physical blocks
[    4.122512] sd 5:0:0:0: [sdc] Write Protect is off
[    4.122514] sd 5:0:0:0: [sdc] Mode Sense: 43 00 00 00
[    4.122674] sd 5:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.122873] sd 5:0:0:0: [sdc] Optimal transfer size 33553920 bytes
not a multiple of physical block size (4096 bytes)
[    4.124843] raid6: avx2x2   gen() 12012 MB/s
[    4.181320] usb 2-3.3: new high-speed USB device number 7 using xhci_hcd
[    4.181337] raid6: avx2x2   xor()  7957 MB/s
[    4.237958] raid6: avx2x1   gen() 11425 MB/s
[    4.290776] usb 2-3.3: New USB device found, idVendor=3D174c,
idProduct=3D2074, bcdDevice=3D 1.00
[    4.290779] usb 2-3.3: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    4.290780] usb 2-3.3: Product: ASM107x
[    4.290782] usb 2-3.3: Manufacturer: Asmedia
[    4.290783] usb 2-3.3: SerialNumber: 0000000A0018
[    4.291747] hub 2-3.3:1.0: USB hub found
[    4.291935] hub 2-3.3:1.0: 4 ports detected
[    4.294620] raid6: avx2x1   xor()  8113 MB/s
[    4.351296] raid6: sse2x4   gen()  8357 MB/s
[    4.384648] usb 2-3.4: new high-speed USB device number 8 using xhci_hcd
[    4.407965] raid6: sse2x4   xor()  5286 MB/s
[    4.464641] raid6: sse2x2   gen()  7003 MB/s
[    4.494265] usb 2-3.4: New USB device found, idVendor=3D174c,
idProduct=3D2074, bcdDevice=3D 1.00
[    4.494268] usb 2-3.4: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    4.494270] usb 2-3.4: Product: ASM107x
[    4.494272] usb 2-3.4: Manufacturer: Asmedia
[    4.494273] usb 2-3.4: SerialNumber: 0000000A0012
[    4.495216] hub 2-3.4:1.0: USB hub found
[    4.495485] hub 2-3.4:1.0: 4 ports detected
[    4.521296] raid6: sse2x2   xor()  4624 MB/s
[    4.577968] raid6: sse2x1   gen()  6039 MB/s
[    4.629148]  sdc: sdc1
[    4.630140] sd 5:0:0:0: [sdc] Attached SCSI disk
[    4.634624] raid6: sse2x1   xor()  4250 MB/s
[    4.634628] raid6: using algorithm avx2x4 gen() 13151 MB/s
[    4.634629] raid6: .... xor() 9111 MB/s, rmw enabled
[    4.634631] raid6: using avx2x2 recovery algorithm
[    4.637321] xor: automatically using best checksumming function   avx
[    4.776545] Btrfs loaded, crc32c=3Dcrc32c-intel
[    4.777580] BTRFS: device label disk3 devid 1 transid 50547 /dev/sdb1
[    4.814375] BTRFS info (device sdb1): enabling auto defrag
[    4.814378] BTRFS info (device sdb1): disk space caching is enabled
[    4.828715] random: crng init done
[    4.854300] BTRFS: device label disk4 devid 1 transid 71588 /dev/sdc1
[    4.899938] BTRFS info (device sdc1): enabling auto defrag
[    4.899943] BTRFS info (device sdc1): disk space caching is enabled
[    5.264714] usb 3-3.3.1: new SuperSpeed Gen 1 USB device number 7
using xhci_hcd
[    5.282235] usb 3-3.3.1: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    5.282241] usb 3-3.3.1: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    5.282245] usb 3-3.3.1: Product: ASMT1053E
[    5.282249] usb 3-3.3.1: Manufacturer: asmedia
[    5.282252] usb 3-3.3.1: SerialNumber: 123456789262
[    5.289385] scsi host6: uas
[    5.290197] scsi 6:0:0:0: Direct-Access     ASMT     2105
  0    PQ: 0 ANSI: 6
[    5.292572] sd 6:0:0:0: [sdd] 7814037168 512-byte logical blocks:
(4.00 TB/3.64 TiB)
[    5.292580] sd 6:0:0:0: [sdd] 4096-byte physical blocks
[    5.292670] sd 6:0:0:0: [sdd] Write Protect is off
[    5.292674] sd 6:0:0:0: [sdd] Mode Sense: 43 00 00 00
[    5.292835] sd 6:0:0:0: [sdd] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    5.293040] sd 6:0:0:0: [sdd] Optimal transfer size 33553920 bytes
not a multiple of physical block size (4096 bytes)
[    5.356833]  sdd: sdd1
[    5.358177] sd 6:0:0:0: [sdd] Attached SCSI disk
[    5.567838] BTRFS info (device sdc1): bdev /dev/sdc1 errs: wr 113,
rd 17, flush 0, corrupt 0, gen 0
[    5.619542] BTRFS: device label disk6 devid 1 transid 333949 /dev/sdd1
[    5.666880] BTRFS info (device sdd1): enabling auto defrag
[    5.666885] BTRFS info (device sdd1): disk space caching is enabled
[    6.754791] usb 3-3.4.2: new SuperSpeed Gen 1 USB device number 8
using xhci_hcd
[    6.772183] usb 3-3.4.2: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    6.772189] usb 3-3.4.2: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    6.772193] usb 3-3.4.2: Product: ASMT1053E
[    6.772196] usb 3-3.4.2: Manufacturer: asmedia
[    6.772199] usb 3-3.4.2: SerialNumber: 123456789263
[    6.779807] scsi host7: uas
[    6.780637] scsi 7:0:0:0: Direct-Access     ASMT     2105
  0    PQ: 0 ANSI: 6
[    6.783295] sd 7:0:0:0: [sde] 15628053168 512-byte logical blocks:
(8.00 TB/7.28 TiB)
[    6.783301] sd 7:0:0:0: [sde] 4096-byte physical blocks
[    6.783423] sd 7:0:0:0: [sde] Write Protect is off
[    6.783428] sd 7:0:0:0: [sde] Mode Sense: 43 00 00 00
[    6.783586] sd 7:0:0:0: [sde] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.783806] sd 7:0:0:0: [sde] Optimal transfer size 33553920 bytes
not a multiple of physical block size (4096 bytes)
[    6.829088]  sde: sde1
[    6.830476] sd 7:0:0:0: [sde] Attached SCSI disk
[    6.844703] usb 3-3.3.2: new SuperSpeed Gen 1 USB device number 9
using xhci_hcd
[    6.862035] usb 3-3.3.2: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    6.862040] usb 3-3.3.2: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    6.862042] usb 3-3.3.2: Product: ASMT1053E
[    6.862044] usb 3-3.3.2: Manufacturer: asmedia
[    6.862046] usb 3-3.3.2: SerialNumber: 123456789265
[    6.888971] scsi host8: uas
[    6.889614] scsi 8:0:0:0: Direct-Access     ASMT     2105
  0    PQ: 0 ANSI: 6
[    6.892150] sd 8:0:0:0: [sdf] 15628053168 512-byte logical blocks:
(8.00 TB/7.28 TiB)
[    6.892159] sd 8:0:0:0: [sdf] 4096-byte physical blocks
[    6.892276] sd 8:0:0:0: [sdf] Write Protect is off
[    6.892286] sd 8:0:0:0: [sdf] Mode Sense: 43 00 00 00
[    6.892484] sd 8:0:0:0: [sdf] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    6.892737] sd 8:0:0:0: [sdf] Optimal transfer size 33553920 bytes
not a multiple of physical block size (4096 bytes)
[    6.942067]  sdf: sdf1
[    6.943478] sd 8:0:0:0: [sdf] Attached SCSI disk
[    7.008226] BTRFS: device label disk7 devid 1 transid 384253 /dev/sde1
[    7.057579] BTRFS info (device sde1): enabling auto defrag
[    7.057582] BTRFS info (device sde1): disk space caching is enabled
[    7.057583] BTRFS info (device sde1): has skinny extents
[    7.120583] BTRFS: device label disk2 devid 1 transid 248621 /dev/sdf1
[    7.164656] BTRFS info (device sdf1): enabling auto defrag
[    7.164659] BTRFS info (device sdf1): disk space caching is enabled
[    7.164661] BTRFS info (device sdf1): has skinny extents
[    7.621388] usb 3-3.3.3: new SuperSpeed Gen 1 USB device number 10
using xhci_hcd
[    7.638819] usb 3-3.3.3: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    7.638826] usb 3-3.3.3: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    7.638830] usb 3-3.3.3: Product: ASMT1053E
[    7.638833] usb 3-3.3.3: Manufacturer: asmedia
[    7.638836] usb 3-3.3.3: SerialNumber: 123456789267
[    7.665323] scsi host9: uas
[    7.666190] scsi 9:0:0:0: Direct-Access     ASMT     2105
  0    PQ: 0 ANSI: 6
[    7.668570] sd 9:0:0:0: [sdg] 7814037168 512-byte logical blocks:
(4.00 TB/3.64 TiB)
[    7.668575] sd 9:0:0:0: [sdg] 4096-byte physical blocks
[    7.668670] sd 9:0:0:0: [sdg] Write Protect is off
[    7.668674] sd 9:0:0:0: [sdg] Mode Sense: 43 00 00 00
[    7.668846] sd 9:0:0:0: [sdg] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    7.669102] sd 9:0:0:0: [sdg] Optimal transfer size 33553920 bytes
not a multiple of physical block size (4096 bytes)
[    7.722495]  sdg: sdg1
[    7.723887] sd 9:0:0:0: [sdg] Attached SCSI disk
[    7.893310] BTRFS: device label disk5 devid 1 transid 198813 /dev/sdg1
[    7.937539] BTRFS info (device sdg1): enabling auto defrag
[    7.937543] BTRFS info (device sdg1): disk space caching is enabled
[    8.401384] usb 3-3.3.4: new SuperSpeed Gen 1 USB device number 11
using xhci_hcd
[    8.418800] usb 3-3.3.4: New USB device found, idVendor=3D174c,
idProduct=3D55aa, bcdDevice=3D 1.00
[    8.418806] usb 3-3.3.4: New USB device strings: Mfr=3D2, Product=3D3,
SerialNumber=3D1
[    8.418810] usb 3-3.3.4: Product: ASMT1053E
[    8.418813] usb 3-3.3.4: Manufacturer: asmedia
[    8.418816] usb 3-3.3.4: SerialNumber: 123456789264
[    8.426796] scsi host10: uas
[    8.427471] scsi 10:0:0:0: Direct-Access     ASMT     2105
   0    PQ: 0 ANSI: 6
[    8.429267] sd 10:0:0:0: [sdh] 7814037168 512-byte logical blocks:
(4.00 TB/3.64 TiB)
[    8.429276] sd 10:0:0:0: [sdh] 4096-byte physical blocks
[    8.429375] sd 10:0:0:0: [sdh] Write Protect is off
[    8.429382] sd 10:0:0:0: [sdh] Mode Sense: 43 00 00 00
[    8.429571] sd 10:0:0:0: [sdh] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    8.429859] sd 10:0:0:0: [sdh] Optimal transfer size 33553920 bytes
not a multiple of physical block size (4096 bytes)
[    8.516478] input: Logitech K400 as
/devices/pci0000:00/0000:00:14.0/usb2/2-1/2-1:1.2/0003:046D:C52B.0003/0003:=
046D:400E.0004/input/input23
[    8.517299] logitech-hidpp-device 0003:046D:400E.0004:
input,hidraw1: USB HID v1.11 Keyboard [Logitech K400] on
usb-0000:00:14.0-1/input2:1
[    8.964468] audit: type=3D1131 audit(1563271479.502:7): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-rfkill comm=3D"sys=
temd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[    9.300249]  sdh: sdh1
[    9.301870] sd 10:0:0:0: [sdh] Attached SCSI disk
[    9.499103] BTRFS: device label disk1 devid 1 transid 564351 /dev/sdh1
[    9.549915] BTRFS info (device sdh1): enabling auto defrag
[    9.549919] BTRFS info (device sdh1): disk space caching is enabled
[   11.040906] BTRFS critical (device sdb1): corrupt leaf: root=3D5
block=3D3210507616256 slot=3D24 ino=3D265, invalid inode generation: has
140000853721088 expect [0, 50548]
[   11.040912] BTRFS error (device sdb1): block=3D3210507616256 read
time tree block corruption detected
[   11.734989] audit: type=3D1130 audit(1563271482.275:8): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Demergency comm=3D"systemd"
exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=3D?
res=3Dsuccess'
[   11.810131] audit: type=3D1130 audit(1563271482.348:9): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-tmpfiles-setup
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   11.828681] audit: type=3D1127 audit(1563271482.368:10): pid=3D598
uid=3D0 auid=3D4294967295 ses=3D4294967295 msg=3D' comm=3D"systemd-update-u=
tmp"
exe=3D"/usr/lib/systemd/systemd-update-utmp" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   11.833931] audit: type=3D1130 audit(1563271482.372:11): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-update-utmp
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   12.227881] audit: type=3D1130 audit(1563271482.765:12): pid=3D1 uid=3D0
auid=3D4294967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-timesyncd
comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D?
terminal=3D? res=3Dsuccess'
[   13.781261] BTRFS critical (device sdc1): corrupt leaf: root=3D5
block=3D5051749396480 slot=3D24 ino=3D265, invalid inode generation: has
140471277748224 expect [0, 71589]
[   13.781268] BTRFS error (device sdc1): block=3D5051749396480 read
time tree block corruption detected



On Fri, Jul 12, 2019 at 2:18 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/7/12 =E4=B8=8B=E5=8D=887:05, mangoblues@gmail.com wrote:
> > Hi,
> >
> > After updating to kernel 5.2 (archlinux):  2 out of my 7 btrfs drives
> > fail to mount on boot.
> >
> > Error: can't read superblock on /dev/sdb1 and /dev/sdc1.
>
> Pull dmesg output please.
>
> Thanks,
> Qu
>
> >
> > Going back to kernel 5.1.16 (and 4.19 also) fixes the problem. Btrfsck
> > reports the 2 drives are OK.
> >
> > What can I do to fix this ?
> >
> > Thanks.
> >
> > $ btrfs fi show
> >
> > Label: 'disk3'  uuid: 37d68257-a2bf-44e4-82e6-7bda35d3af3c
> >         Total devices 1 FS bytes used 1.77TiB
> >         devid    1 size 1.82TiB used 1.82TiB path /dev/sdb1
> >
> > Label: 'disk4'  uuid: 8b72d7bd-603c-41c0-a395-a763ffe0de8b
> >         Total devices 1 FS bytes used 2.67TiB
> >         devid    1 size 2.73TiB used 2.73TiB path /dev/sdc1
> >
> > Label: 'disk5'  uuid: 1728d60b-bdf2-4baa-8372-de7014d85e1d
> >         Total devices 1 FS bytes used 3.59TiB
> >         devid    1 size 3.64TiB used 3.64TiB path /dev/sdg1
> >
> > Label: 'disk7'  uuid: 5e9437b5-bf53-4135-8b25-52539cfc491e
> >         Total devices 1 FS bytes used 6.66TiB
> >         devid    1 size 7.28TiB used 7.23TiB path /dev/sde1
> >
> > Label: 'disk6'  uuid: ce325155-0922-4c62-9f5d-70cbc1726b5c
> >         Total devices 1 FS bytes used 3.47TiB
> >         devid    1 size 3.64TiB used 3.63TiB path /dev/sdd1
> >
> > Label: 'disk1'  uuid: b9c65214-b1dc-4a97-b798-dc9639177880
> >         Total devices 1 FS bytes used 3.31TiB
> >         devid    1 size 3.64TiB used 3.62TiB path /dev/sdh1
> >
> > Label: 'disk2'  uuid: d77e4116-de32-4ff4-938c-9c6eea6cdd42
> >         Total devices 1 FS bytes used 6.83TiB
> >         devid    1 size 7.28TiB used 7.26TiB path /dev/sdf1
> >
>
