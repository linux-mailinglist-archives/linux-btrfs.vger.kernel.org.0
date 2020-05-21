Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E411DC4DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 May 2020 03:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgEUBp1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 21:45:27 -0400
Received: from bezitopo.org ([45.55.162.231]:47710 "EHLO marozi.bezitopo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgEUBp1 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 21:45:27 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 21:45:20 EDT
Received: from bezitopo.org (unknown [IPv6:2001:5b0:211f:ee48:4e72:b9ff:fe7b:8dbf])
        by marozi.bezitopo.org (Postfix) with ESMTPSA id 42E845FC36
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 21:35:09 -0400 (EDT)
Received: from puma.localnet (localhost [127.0.0.1])
        by bezitopo.org (Postfix) with ESMTP id 80739154D3
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 21:34:57 -0400 (EDT)
From:   Pierre Abbat <phma@bezitopo.org>
To:     linux-btrfs@vger.kernel.org
Subject: Trying to mount hangs
Date:   Wed, 20 May 2020 21:34:57 -0400
Message-ID: <2549429.Qys7a5ZjRC@puma>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart28398691.g1t78HKg7O"
Content-Transfer-Encoding: 7Bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart28398691.g1t78HKg7O
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I am not on the list, so please copy me.

Yesterday there was a double power blink. I rebooted my box and it appeared 
normal, but a few hours later the web browser froze, then the panel froze. I 
tried to kill the panel, but couldn't, and ended up rebooting. Then I couldn't 
log in. I logged in as root on a text console and found out that /home wasn't 
mounted. Trying to mount it hung the mount process.

I booted a thumb drive and tried "btrfs check /dev/mapper/puma-cougar" (the 
device containing /home). It said it was busy. I ran btrfs-restore and 
recovered source code files into /crypt (/mnt/crypt since I had booted the 
thumb drive), which I then copied to another computer and pushed to GitHub. I 
tried mounting puma-cougar with -o ro,recover, but mount still hung.

The next day (today, this morning) I bought an SSD, which I installed in the 
afternoon. I ran btrfs-restore again, copying all files found to the SSD. I 
changed /etc/fstab to point to the SSD, rebooted, and am back in business. 
Running "btrfs check puma-cougar" now goes through, saying that there are some 
errors.

I'd like to send you the filesystem so that you could figure out why mounting 
hangs, but it's 138 GiB and I'd have to mail you a drive. Is there a way to 
extract a skeleton that would still make mount hang, but that I could attach 
to a bug report?

It was originally 128 GiB, but a week or two ago I ran out of space, moved the 
point clouds to /crypt, and enlarged the LV. Maybe the combination of resizing 
the filesystem and the power blink made it fail. Nothing went wrong with /
crypt/.

What does "looping too much" mean?

phma@puma:~$ uname -a
Linux puma 5.3.0-7625-generic #27~1576774560~19.10~f432cd8-Ubuntu SMP Thu Dec 
19 20:35:37 UTC  x86_64 x86_64 x86_64 GNU/Linux
phma@puma:~$ btrfs --version
btrfs-progs v5.2.1 
phma@puma:~$ sudo su
[sudo] password for phma: 
root@puma:/home/phma# btrfs fi show
Label: none  uuid: 155a20c7-2264-4923-b082-288a3c146384
        Total devices 1 FS bytes used 67.60GiB
        devid    1 size 158.00GiB used 70.02GiB path /dev/mapper/concolor-
cougar

Label: none  uuid: 10c61748-efe7-4b9c-b1f7-041dc45d894b
        Total devices 1 FS bytes used 53.36GiB
        devid    1 size 127.98GiB used 56.02GiB path /dev/mapper/cougar-crypt

Label: none  uuid: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
        Total devices 1 FS bytes used 92.58GiB
        devid    1 size 158.00GiB used 131.00GiB path /dev/mapper/puma-cougar

root@puma:/home/phma# btrfs check /dev/mapper/puma-cougar 
Opening filesystem to check...
Checking filesystem on /dev/mapper/puma-cougar
UUID: 1f5a6f23-a7ef-46c6-92b1-84fc2f684931
[1/7] checking root items
[2/7] checking extents
incorrect local backref count on 4186230784 root 257 owner 99013 offset 
5033684992 found 1 wanted 2097153 back 0x5589817e5ef0
backpointer mismatch on [4186230784 188416]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
[4/7] checking fs roots
root 257 inode 30648207 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648208 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648209 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648210 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648211 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648212 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648213 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648214 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648215 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648216 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648217 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648218 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648219 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
root 257 inode 30648220 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 4096
ERROR: errors found in fs roots
found 99403300864 bytes used, error(s) found
total csum bytes: 96230456
total tree bytes: 737820672
total fs tree bytes: 534069248
total extent tree bytes: 75481088
btree space waste bytes: 129276390
file data blocks allocated: 10627425239040
 referenced 68243042304

Pierre
-- 
li fi'u vu'u fi'u fi'u du li pa

--nextPart28398691.g1t78HKg7O
Content-Disposition: attachment; filename="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-log; charset="UTF-8"; name="dmesg.log"

[    0.000000] Linux version 5.3.0-7625-generic (buildd@lcy01-amd64-025) (g=
cc version 9.2.1 20191008 (Ubuntu 9.2.1-9ubuntu2)) #27~1576774560~19.10~f43=
2cd8-Ubuntu SMP Thu Dec 19 20:35:37 UTC  (Ubuntu 5.3.0-7625.27~1576774560~1=
9.10~f432cd8-generic 5.3.13)
[    0.000000] Command line: initrd=3D\EFI\Pop_OS-f16e5ff5-3e0e-4ae6-974f-a=
5a29a3eb889\initrd.img root=3DUUID=3Df16e5ff5-3e0e-4ae6-974f-a5a29a3eb889 r=
o quiet loglevel=3D0 systemd.show_status=3Dfalse splash
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Hygon HygonGenuine
[    0.000000]   Centaur CentaurHauls
[    0.000000]   zhaoxin   Shanghai =20
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point=
 registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 by=
tes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009e01fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009e02000-0x0000000009ffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20bfff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000000a20c000-0x000000000affffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000b000000-0x000000000b01ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000000b020000-0x00000000db77cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000db77d000-0x00000000db8e4fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000db8e5000-0x00000000dba67fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000dba68000-0x00000000dbe80fff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x00000000dbe81000-0x00000000dcb00fff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000dcb01000-0x00000000deffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000df000000-0x00000000dfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fd000000-0x00000000ffffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000081f37ffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xd6dfd018-0xd6e0e057] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0xd6dfd018-0xd6e0e057] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0xd6dbf018-0xd6ddbe57] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0xd6dbf018-0xd6ddbe57] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009e01f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000009e02000-0x0000000009ffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20bf=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000000a20c000-0x000000000affff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000000b000000-0x000000000b01ff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000000b020000-0x00000000d6dbf0=
17] usable
[    0.000000] reserve setup_data: [mem 0x00000000d6dbf018-0x00000000d6ddbe=
57] usable
[    0.000000] reserve setup_data: [mem 0x00000000d6ddbe58-0x00000000d6dfd0=
17] usable
[    0.000000] reserve setup_data: [mem 0x00000000d6dfd018-0x00000000d6e0e0=
57] usable
[    0.000000] reserve setup_data: [mem 0x00000000d6e0e058-0x00000000db77cf=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000db77d000-0x00000000db8e4f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000db8e5000-0x00000000dba67f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000dba68000-0x00000000dbe80f=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000dbe81000-0x00000000dcb00f=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000dcb01000-0x00000000deffff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x00000000df000000-0x00000000dfffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fd000000-0x00000000ffffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000081f37ff=
ff] usable
[    0.000000] efi: EFI v2.70 by American Megatrends
[    0.000000] efi:  ACPI 2.0=3D0xdbdfd000  ACPI=3D0xdbdfd000  SMBIOS=3D0xd=
c958000  SMBIOS 3.0=3D0xdc957000  MEMATTR=3D0xd7082018  ESRT=3D0xda0c8598=20
[    0.000000] secureboot: Secure boot disabled
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: System76 Thelio/Thelio, BIOS F42a Z5 08/22/2019
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3793.099 MHz processor
[    0.000757] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000758] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000761] last_pfn =3D 0x81f380 max_arch_pfn =3D 0x400000000
[    0.000764] MTRR default type: uncachable
[    0.000764] MTRR fixed ranges enabled:
[    0.000765]   00000-9FFFF write-back
[    0.000765]   A0000-BFFFF write-through
[    0.000766]   C0000-FFFFF write-protect
[    0.000766] MTRR variable ranges enabled:
[    0.000767]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000767]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000768]   2 base 0000C0000000 mask FFFFE0000000 write-back
[    0.000768]   3 base 0000DC260000 mask FFFFFFFF0000 uncachable
[    0.000769]   4 disabled
[    0.000769]   5 disabled
[    0.000769]   6 disabled
[    0.000769]   7 disabled
[    0.000770] TOM2: 0000000820000000 aka 33280M
[    0.001347] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT=
 =20
[    0.001417] total RAM covered: 3583M
[    0.001540] Found optimal setting for mtrr clean up
[    0.001541]  gran_size: 64K 	chunk_size: 64M 	num_reg: 4  	lose cover RA=
M: 0G
[    0.001609] e820: update [mem 0xdc260000-0xdc26ffff] usable =3D=3D> rese=
rved
[    0.001611] e820: update [mem 0xe0000000-0xffffffff] usable =3D=3D> rese=
rved
[    0.001614] last_pfn =3D 0xdf000 max_arch_pfn =3D 0x400000000
[    0.004824] esrt: Reserving ESRT space from 0x00000000da0c8598 to 0x0000=
0000da0c85d0.
[    0.004876] check: Scanning 1 areas for low memory corruption
[    0.004879] Using GB pages for direct mapping
[    0.004880] BRK [0x290401000, 0x290401fff] PGTABLE
[    0.004881] BRK [0x290402000, 0x290402fff] PGTABLE
[    0.004882] BRK [0x290403000, 0x290403fff] PGTABLE
[    0.004903] BRK [0x290404000, 0x290404fff] PGTABLE
[    0.004904] BRK [0x290405000, 0x290405fff] PGTABLE
[    0.004987] BRK [0x290406000, 0x290406fff] PGTABLE
[    0.005044] BRK [0x290407000, 0x290407fff] PGTABLE
[    0.005075] BRK [0x290408000, 0x290408fff] PGTABLE
[    0.005109] BRK [0x290409000, 0x290409fff] PGTABLE
[    0.005133] BRK [0x29040a000, 0x29040afff] PGTABLE
[    0.005166] BRK [0x29040b000, 0x29040bfff] PGTABLE
[    0.005168] BRK [0x29040c000, 0x29040cfff] PGTABLE
[    0.005300] RAMDISK: [mem 0x7b18f000-0x7fffefff]
[    0.005306] ACPI: Early table checksum verification disabled
[    0.005309] ACPI: RSDP 0x00000000DBDFD000 000024 (v02 ALASKA)
[    0.005311] ACPI: XSDT 0x00000000DBDFD0A8 0000CC (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005315] ACPI: FACP 0x00000000DBE03FB8 000114 (v06 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005319] ACPI: DSDT 0x00000000DBDFD208 006DAD (v02 ALASKA A M I    01=
072009 INTL 20160930)
[    0.005320] ACPI: FACS 0x00000000DBE69E00 000040
[    0.005322] ACPI: APIC 0x00000000DBE040D0 00015E (v03 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005323] ACPI: FPDT 0x00000000DBE04230 000044 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005325] ACPI: FIDT 0x00000000DBE04278 00009C (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005327] ACPI: SSDT 0x00000000DBE04318 0000C8 (v02 ALASKA A M I    01=
072009 AMI  01072009)
[    0.005328] ACPI: SSDT 0x00000000DBE043E0 008C98 (v02 ALASKA A M I    00=
000002 MSFT 04000000)
[    0.005330] ACPI: SSDT 0x00000000DBE0D078 0033A6 (v01 ALASKA A M I    00=
000001 INTL 20160930)
[    0.005331] ACPI: MCFG 0x00000000DBE10420 00003C (v01 ALASKA A M I    01=
072009 MSFT 00010013)
[    0.005333] ACPI: SSDT 0x00000000DBE10460 00675A (v01 ALASKA A M I    00=
000001 INTL 20160930)
[    0.005334] ACPI: HPET 0x00000000DBE16BC0 000038 (v01 ALASKA A M I    01=
072009 AMI  00000005)
[    0.005336] ACPI: UEFI 0x00000000DBE16BF8 000042 (v01 ALASKA A M I    00=
000002      01000013)
[    0.005337] ACPI: BGRT 0x00000000DBE16C40 000038 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005339] ACPI: IVRS 0x00000000DBE16C78 0000D0 (v02 ALASKA A M I    00=
000001 AMD  00000000)
[    0.005340] ACPI: PCCT 0x00000000DBE16D48 00006E (v01 ALASKA A M I    00=
000001 AMD  00000000)
[    0.005342] ACPI: SSDT 0x00000000DBE16DB8 002F29 (v01 ALASKA A M I    00=
000001 AMD  00000001)
[    0.005343] ACPI: CRAT 0x00000000DBE19CE8 001058 (v01 ALASKA A M I    00=
000001 AMD  00000001)
[    0.005345] ACPI: CDIT 0x00000000DBE1AD40 000029 (v01 ALASKA A M I    00=
000001 AMD  00000001)
[    0.005346] ACPI: SSDT 0x00000000DBE1AD70 001EC3 (v01 ALASKA A M I    00=
000001 INTL 20160930)
[    0.005348] ACPI: SSDT 0x00000000DBE1CC38 0000BF (v01 ALASKA A M I    00=
001000 INTL 20160930)
[    0.005349] ACPI: WSMT 0x00000000DBE1CCF8 000028 (v01 ALASKA A M I    01=
072009 AMI  00010013)
[    0.005351] ACPI: SSDT 0x00000000DBE1CD20 0013F0 (v01 ALASKA A M I    00=
000001 INTL 20160930)
[    0.005355] ACPI: Local APIC address 0xfee00000
[    0.005439] No NUMA configuration found
[    0.005440] Faking a node at [mem 0x0000000000000000-0x000000081f37ffff]
[    0.005446] NODE_DATA(0) allocated [mem 0x81f355000-0x81f37ffff]
[    0.005594] Zone ranges:
[    0.005595]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.005595]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.005596]   Normal   [mem 0x0000000100000000-0x000000081f37ffff]
[    0.005597]   Device   empty
[    0.005597] Movable zone start for each node
[    0.005598] Early memory node ranges
[    0.005599]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.005599]   node   0: [mem 0x0000000000100000-0x0000000009e01fff]
[    0.005599]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
[    0.005600]   node   0: [mem 0x000000000a20c000-0x000000000affffff]
[    0.005600]   node   0: [mem 0x000000000b020000-0x00000000db77cfff]
[    0.005601]   node   0: [mem 0x00000000db8e5000-0x00000000dba67fff]
[    0.005601]   node   0: [mem 0x00000000dcb01000-0x00000000deffffff]
[    0.005601]   node   0: [mem 0x0000000100000000-0x000000081f37ffff]
[    0.005645] Zeroed struct page in unavailable ranges: 9356 pages
[    0.005646] Initmem setup node 0 [mem 0x0000000000001000-0x000000081f37f=
fff]
[    0.005647] On node 0 totalpages: 8376052
[    0.005648]   DMA zone: 64 pages used for memmap
[    0.005648]   DMA zone: 29 pages reserved
[    0.005648]   DMA zone: 3999 pages, LIFO batch:0
[    0.005684]   DMA32 zone: 14128 pages used for memmap
[    0.005684]   DMA32 zone: 904149 pages, LIFO batch:63
[    0.013997]   Normal zone: 116686 pages used for memmap
[    0.013998]   Normal zone: 7467904 pages, LIFO batch:63
[    0.079987] ACPI: PM-Timer IO Port: 0x808
[    0.079990] ACPI: Local APIC address 0xfee00000
[    0.079995] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.080007] IOAPIC[0]: apic_id 13, version 33, address 0xfec00000, GSI 0=
=2D23
[    0.080012] IOAPIC[1]: apic_id 14, version 33, address 0xfec01000, GSI 2=
4-55
[    0.080013] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.080014] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.080015] ACPI: IRQ0 used by override.
[    0.080016] ACPI: IRQ9 used by override.
[    0.080017] Using ACPI (MADT) for SMP configuration information
[    0.080018] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.080030] smpboot: Allowing 32 CPUs, 20 hotplug CPUs
[    0.080045] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.080046] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.080047] PM: Registered nosave memory: [mem 0x09e02000-0x09ffffff]
[    0.080048] PM: Registered nosave memory: [mem 0x0a200000-0x0a20bfff]
[    0.080049] PM: Registered nosave memory: [mem 0x0b000000-0x0b01ffff]
[    0.080050] PM: Registered nosave memory: [mem 0xd6dbf000-0xd6dbffff]
[    0.080051] PM: Registered nosave memory: [mem 0xd6ddb000-0xd6ddbfff]
[    0.080051] PM: Registered nosave memory: [mem 0xd6dfd000-0xd6dfdfff]
[    0.080052] PM: Registered nosave memory: [mem 0xd6e0e000-0xd6e0efff]
[    0.080053] PM: Registered nosave memory: [mem 0xdb77d000-0xdb8e4fff]
[    0.080054] PM: Registered nosave memory: [mem 0xdba68000-0xdbe80fff]
[    0.080054] PM: Registered nosave memory: [mem 0xdbe81000-0xdcb00fff]
[    0.080055] PM: Registered nosave memory: [mem 0xdf000000-0xdfffffff]
[    0.080056] PM: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
[    0.080056] PM: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.080056] PM: Registered nosave memory: [mem 0xfc000000-0xfcffffff]
[    0.080056] PM: Registered nosave memory: [mem 0xfd000000-0xffffffff]
[    0.080058] [mem 0xe0000000-0xf7ffffff] available for PCI devices
[    0.080059] Booting paravirtualized kernel on bare hardware
[    0.080061] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0=
xffffffff, max_idle_ns: 7645519600211568 ns
[    0.080065] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 =
nr_node_ids:1
[    0.080800] percpu: Embedded 54 pages/cpu s184320 r8192 d28672 u262144
[    0.080805] pcpu-alloc: s184320 r8192 d28672 u262144 alloc=3D1*2097152
[    0.080806] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 1=
3 14 15=20
[    0.080808] pcpu-alloc: [0] 16 17 18 19 20 21 22 23 [0] 24 25 26 27 28 2=
9 30 31=20
[    0.080832] Built 1 zonelists, mobility grouping on.  Total pages: 82451=
45
[    0.080832] Policy zone: Normal
[    0.080833] Kernel command line: initrd=3D\EFI\Pop_OS-f16e5ff5-3e0e-4ae6=
=2D974f-a5a29a3eb889\initrd.img root=3DUUID=3Df16e5ff5-3e0e-4ae6-974f-a5a29=
a3eb889 ro quiet loglevel=3D0 systemd.show_status=3Dfalse splash
[    0.082992] Dentry cache hash table entries: 4194304 (order: 13, 3355443=
2 bytes, linear)
[    0.084023] Inode-cache hash table entries: 2097152 (order: 12, 16777216=
 bytes, linear)
[    0.084084] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.088694] Calgary: detecting Calgary via BIOS EBDA area
[    0.088695] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.131581] Memory: 32631412K/33504208K available (14339K kernel code, 2=
388K rwdata, 4728K rodata, 2668K init, 5056K bss, 872796K reserved, 0K cma-=
reserved)
[    0.131747] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D32, =
Nodes=3D1
[    0.131759] ftrace: allocating 43225 entries in 169 pages
[    0.141647] rcu: Hierarchical RCU implementation.
[    0.141647] rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=
=3D32.
[    0.141648] 	Tasks RCU enabled.
[    0.141648] rcu: RCU calculated value of scheduler-enlistment delay is 2=
5 jiffies.
[    0.141649] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D32
[    0.143463] NR_IRQS: 524544, nr_irqs: 1224, preallocated irqs: 16
[    0.143745] random: crng done (trusting CPU's manufacturer)
[    0.143771] Console: colour dummy device 80x25
[    0.143773] printk: console [tty0] enabled
[    0.143786] ACPI: Core revision 20190703
[    0.143908] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    0.143925] APIC: Switch to symmetric I/O mode setup
[    0.463792] Switched APIC routing to physical flat.
[    0.464518] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
=2D1
[    0.483902] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles:=
 0x6d59c2d9741, max_idle_ns: 881591170928 ns
[    0.483904] Calibrating delay loop (skipped), value calculated using tim=
er frequency.. 7586.19 BogoMIPS (lpj=3D15172396)
[    0.483905] pid_max: default: 32768 minimum: 301
[    0.486940] LSM: Security Framework initializing
[    0.486946] Yama: becoming mindful.
[    0.487019] AppArmor: AppArmor initialized
[    0.487083] Mount-cache hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
[    0.487118] Mountpoint-cache hash table entries: 65536 (order: 7, 524288=
 bytes, linear)
[    0.487230] *** VALIDATE proc ***
[    0.487264] *** VALIDATE cgroup1 ***
[    0.487265] *** VALIDATE cgroup2 ***
[    0.487293] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.487385] LVT offset 2 assigned for vector 0xf4
[    0.487412] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.487412] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.487414] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user=
 pointer sanitization
[    0.487415] Spectre V2 : Mitigation: Full AMD retpoline
[    0.487415] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB=
 on context switch
[    0.487416] Spectre V2 : mitigation: Enabling conditional Indirect Branc=
h Prediction Barrier
[    0.487416] Spectre V2 : User space: Mitigation: STIBP always-on protect=
ion
[    0.487417] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    0.487559] Freeing SMP alternatives memory: 36K
[    0.601581] smpboot: CPU0: AMD Ryzen 5 3600X 6-Core Processor (family: 0=
x17, model: 0x71, stepping: 0x0)
[    0.601655] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    0.601657] ... version:                0
[    0.601657] ... bit width:              48
[    0.601658] ... generic registers:      6
[    0.601658] ... value mask:             0000ffffffffffff
[    0.601658] ... max period:             00007fffffffffff
[    0.601658] ... fixed-purpose events:   0
[    0.601659] ... event mask:             000000000000003f
[    0.601676] rcu: Hierarchical SRCU implementation.
[    0.602008] NMI watchdog: Enabled. Permanently consumes one hw-PMU count=
er.
[    0.602165] smp: Bringing up secondary CPUs ...
[    0.602220] x86: Booting SMP configuration:
[    0.602220] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
[    0.614126] Spectre V2 : Update user space SMT mitigation: STIBP always-=
on
[    0.614126]   #7  #8  #9 #10 #11
[    0.623946] smp: Brought up 1 node, 12 CPUs
[    0.623946] smpboot: Max logical packages: 3
[    0.623946] smpboot: Total of 12 processors activated (91034.37 BogoMIPS)
[    0.624829] devtmpfs: initialized
[    0.624829] x86/mm: Memory block size: 128MB
[    0.629419] PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20bfff] =
(49152 bytes)
[    0.629419] PM: Registering ACPI NVS region [mem 0xdba68000-0xdbe80fff] =
(4296704 bytes)
[    0.629419] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffffff=
f, max_idle_ns: 7645041785100000 ns
[    0.629419] futex hash table entries: 8192 (order: 7, 524288 bytes, line=
ar)
[    0.629419] pinctrl core: initialized pinctrl subsystem
[    0.629419] PM: RTC time: 00:27:07, date: 2020-05-21
[    0.629419] NET: Registered protocol family 16
[    0.629419] audit: initializing netlink subsys (disabled)
[    0.629419] audit: type=3D2000 audit(1590020827.172:1): state=3Dinitiali=
zed audit_enabled=3D0 res=3D1
[    0.629419] EISA bus registered
[    0.629419] cpuidle: using governor ladder
[    0.629419] cpuidle: using governor menu
[    0.629419] Detected 1 PCC Subspaces
[    0.629419] Registering PCC driver as Mailbox controller
[    0.629419] ACPI: bus type PCI registered
[    0.629419] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.629419] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000=
=2D0xfbffffff] (base 0xf8000000)
[    0.629419] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.629419] PCI: Using configuration type 1 for base access
[    0.632094] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.632094] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.632094] ACPI: Added _OSI(Module Device)
[    0.632094] ACPI: Added _OSI(Processor Device)
[    0.632094] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.632094] ACPI: Added _OSI(Processor Aggregator Device)
[    0.632094] ACPI: Added _OSI(Linux-Dell-Video)
[    0.632094] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.632094] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.642245] ACPI: 9 ACPI AML tables successfully acquired and loaded
[    0.643188] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.651904] ACPI: Interpreter enabled
[    0.651904] ACPI: (supports S0 S3 S4 S5)
[    0.651904] ACPI: Using IOAPIC for interrupt routing
[    0.651904] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.651904] ACPI: Enabled 2 GPEs in block 00 to 1F
[    0.657659] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.657659] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI HPX-Type3]
[    0.659980] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplu=
g LTR]
[    0.660097] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER =
PCIeCapability]
[    0.660104] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [=
bus 00-3f] only partially covers this bridge
[    0.660368] PCI host bridge to bus 0000:00
[    0.660370] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.660370] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    0.660371] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    0.660371] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.660372] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    0.660373] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dfff=
f window]
[    0.660373] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xfec2fff=
f window]
[    0.660374] pci_bus 0000:00: root bus resource [mem 0xfee00000-0xfffffff=
f window]
[    0.660374] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.660380] pci 0000:00:00.0: [1022:1480] type 00 class 0x060000
[    0.660458] pci 0000:00:00.2: [1022:1481] type 00 class 0x080600
[    0.660548] pci 0000:00:01.0: [1022:1482] type 00 class 0x060000
[    0.660614] pci 0000:00:01.1: [1022:1483] type 01 class 0x060400
[    0.660651] pci 0000:00:01.1: enabling Extended Tags
[    0.660706] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.660807] pci 0000:00:01.3: [1022:1483] type 01 class 0x060400
[    0.660844] pci 0000:00:01.3: enabling Extended Tags
[    0.660899] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
[    0.660998] pci 0000:00:02.0: [1022:1482] type 00 class 0x060000
[    0.661068] pci 0000:00:03.0: [1022:1482] type 00 class 0x060000
[    0.661132] pci 0000:00:03.1: [1022:1483] type 01 class 0x060400
[    0.661209] pci 0000:00:03.1: PME# supported from D0 D3hot D3cold
[    0.661299] pci 0000:00:04.0: [1022:1482] type 00 class 0x060000
[    0.661370] pci 0000:00:05.0: [1022:1482] type 00 class 0x060000
[    0.661439] pci 0000:00:07.0: [1022:1482] type 00 class 0x060000
[    0.661501] pci 0000:00:07.1: [1022:1484] type 01 class 0x060400
[    0.661528] pci 0000:00:07.1: enabling Extended Tags
[    0.661560] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.661627] pci 0000:00:08.0: [1022:1482] type 00 class 0x060000
[    0.661690] pci 0000:00:08.1: [1022:1484] type 01 class 0x060400
[    0.661719] pci 0000:00:08.1: enabling Extended Tags
[    0.661754] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.661834] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.661944] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.662060] pci 0000:00:18.0: [1022:1440] type 00 class 0x060000
[    0.662102] pci 0000:00:18.1: [1022:1441] type 00 class 0x060000
[    0.662143] pci 0000:00:18.2: [1022:1442] type 00 class 0x060000
[    0.662184] pci 0000:00:18.3: [1022:1443] type 00 class 0x060000
[    0.662227] pci 0000:00:18.4: [1022:1444] type 00 class 0x060000
[    0.662269] pci 0000:00:18.5: [1022:1445] type 00 class 0x060000
[    0.662312] pci 0000:00:18.6: [1022:1446] type 00 class 0x060000
[    0.662355] pci 0000:00:18.7: [1022:1447] type 00 class 0x060000
[    0.662446] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[    0.662474] pci 0000:01:00.0: reg 0x10: [mem 0xfcf00000-0xfcf03fff 64bit]
[    0.662682] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.662687] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
[    0.662739] pci 0000:02:00.0: [1022:43d5] type 00 class 0x0c0330
[    0.662765] pci 0000:02:00.0: reg 0x10: [mem 0xfcda0000-0xfcda7fff 64bit]
[    0.662808] pci 0000:02:00.0: enabling Extended Tags
[    0.662863] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.662937] pci 0000:02:00.1: [1022:43c8] type 00 class 0x010601
[    0.662994] pci 0000:02:00.1: reg 0x24: [mem 0xfcd80000-0xfcd9ffff]
[    0.663002] pci 0000:02:00.1: reg 0x30: [mem 0xfcd00000-0xfcd7ffff pref]
[    0.663008] pci 0000:02:00.1: enabling Extended Tags
[    0.663052] pci 0000:02:00.1: PME# supported from D3hot D3cold
[    0.663103] pci 0000:02:00.2: [1022:43c6] type 01 class 0x060400
[    0.663155] pci 0000:02:00.2: enabling Extended Tags
[    0.663203] pci 0000:02:00.2: PME# supported from D3hot D3cold
[    0.663295] pci 0000:00:01.3: PCI bridge to [bus 02-09]
[    0.663298] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.663300] pci 0000:00:01.3:   bridge window [mem 0xfcb00000-0xfcdfffff]
[    0.663384] pci 0000:03:00.0: [1022:43c7] type 01 class 0x060400
[    0.663442] pci 0000:03:00.0: enabling Extended Tags
[    0.663501] pci 0000:03:00.0: PME# supported from D3hot D3cold
[    0.663572] pci 0000:03:01.0: [1022:43c7] type 01 class 0x060400
[    0.663629] pci 0000:03:01.0: enabling Extended Tags
[    0.663689] pci 0000:03:01.0: PME# supported from D3hot D3cold
[    0.663761] pci 0000:03:04.0: [1022:43c7] type 01 class 0x060400
[    0.663818] pci 0000:03:04.0: enabling Extended Tags
[    0.663878] pci 0000:03:04.0: PME# supported from D3hot D3cold
[    0.663953] pci 0000:03:05.0: [1022:43c7] type 01 class 0x060400
[    0.664010] pci 0000:03:05.0: enabling Extended Tags
[    0.664069] pci 0000:03:05.0: PME# supported from D3hot D3cold
[    0.664141] pci 0000:03:06.0: [1022:43c7] type 01 class 0x060400
[    0.664198] pci 0000:03:06.0: enabling Extended Tags
[    0.664258] pci 0000:03:06.0: PME# supported from D3hot D3cold
[    0.664330] pci 0000:03:07.0: [1022:43c7] type 01 class 0x060400
[    0.664387] pci 0000:03:07.0: enabling Extended Tags
[    0.664447] pci 0000:03:07.0: PME# supported from D3hot D3cold
[    0.664536] pci 0000:02:00.2: PCI bridge to [bus 03-09]
[    0.664541] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
[    0.664543] pci 0000:02:00.2:   bridge window [mem 0xfcb00000-0xfccfffff]
[    0.664586] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.664636] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.664685] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.664749] pci 0000:07:00.0: [8086:2526] type 00 class 0x028000
[    0.664792] pci 0000:07:00.0: reg 0x10: [mem 0xfcc00000-0xfcc03fff 64bit]
[    0.664957] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    0.665098] pci 0000:03:05.0: PCI bridge to [bus 07]
[    0.665105] pci 0000:03:05.0:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.665142] pci 0000:03:06.0: PCI bridge to [bus 08]
[    0.665215] pci 0000:09:00.0: [8086:1539] type 00 class 0x020000
[    0.665263] pci 0000:09:00.0: reg 0x10: [mem 0xfcb00000-0xfcb1ffff]
[    0.665298] pci 0000:09:00.0: reg 0x18: [io  0xf000-0xf01f]
[    0.665316] pci 0000:09:00.0: reg 0x1c: [mem 0xfcb20000-0xfcb23fff]
[    0.665505] pci 0000:09:00.0: PME# supported from D0 D3hot D3cold
[    0.665653] pci 0000:03:07.0: PCI bridge to [bus 09]
[    0.665658] pci 0000:03:07.0:   bridge window [io  0xf000-0xffff]
[    0.665661] pci 0000:03:07.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
[    0.665735] pci 0000:0a:00.0: [1002:67df] type 00 class 0x030000
[    0.665761] pci 0000:0a:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit=
 pref]
[    0.665771] pci 0000:0a:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit=
 pref]
[    0.665777] pci 0000:0a:00.0: reg 0x20: [io  0xe000-0xe0ff]
[    0.665784] pci 0000:0a:00.0: reg 0x24: [mem 0xfce00000-0xfce3ffff]
[    0.665790] pci 0000:0a:00.0: reg 0x30: [mem 0xfce40000-0xfce5ffff pref]
[    0.665802] pci 0000:0a:00.0: BAR 0: assigned to efifb
[    0.665860] pci 0000:0a:00.0: supports D1 D2
[    0.665861] pci 0000:0a:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.665945] pci 0000:0a:00.1: [1002:aaf0] type 00 class 0x040300
[    0.665966] pci 0000:0a:00.1: reg 0x10: [mem 0xfce60000-0xfce63fff 64bit]
[    0.666045] pci 0000:0a:00.1: supports D1 D2
[    0.666126] pci 0000:00:03.1: PCI bridge to [bus 0a]
[    0.666129] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    0.666131] pci 0000:00:03.1:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.666134] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xf01fffff=
 64bit pref]
[    0.666166] pci 0000:0b:00.0: [1022:148a] type 00 class 0x130000
[    0.666198] pci 0000:0b:00.0: enabling Extended Tags
[    0.666279] pci 0000:00:07.1: PCI bridge to [bus 0b]
[    0.666327] pci 0000:0c:00.0: [1022:1485] type 00 class 0x130000
[    0.666366] pci 0000:0c:00.0: enabling Extended Tags
[    0.666446] pci 0000:0c:00.1: [1022:1486] type 00 class 0x108000
[    0.666465] pci 0000:0c:00.1: reg 0x18: [mem 0xfc900000-0xfc9fffff]
[    0.666476] pci 0000:0c:00.1: reg 0x24: [mem 0xfca08000-0xfca09fff]
[    0.666484] pci 0000:0c:00.1: enabling Extended Tags
[    0.666555] pci 0000:0c:00.3: [1022:149c] type 00 class 0x0c0330
[    0.666572] pci 0000:0c:00.3: reg 0x10: [mem 0xfc800000-0xfc8fffff 64bit]
[    0.666600] pci 0000:0c:00.3: enabling Extended Tags
[    0.666639] pci 0000:0c:00.3: PME# supported from D0 D3hot D3cold
[    0.666678] pci 0000:0c:00.4: [1022:1487] type 00 class 0x040300
[    0.666690] pci 0000:0c:00.4: reg 0x10: [mem 0xfca00000-0xfca07fff]
[    0.666715] pci 0000:0c:00.4: enabling Extended Tags
[    0.666751] pci 0000:0c:00.4: PME# supported from D0 D3hot D3cold
[    0.666807] pci 0000:00:08.1: PCI bridge to [bus 0c]
[    0.666811] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcafffff]
[    0.667023] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *0
[    0.667065] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *0
[    0.667101] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *0
[    0.667145] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *0
[    0.667184] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *0
[    0.667217] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *0
[    0.667250] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *0
[    0.667282] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *0
[    0.667654] SCSI subsystem initialized
[    0.667654] libata version 3.00 loaded.
[    0.667915] pci 0000:0a:00.0: vgaarb: setting as boot VGA device
[    0.667915] pci 0000:0a:00.0: vgaarb: VGA device added: decodes=3Dio+mem=
,owns=3Dio+mem,locks=3Dnone
[    0.667915] pci 0000:0a:00.0: vgaarb: bridge control possible
[    0.667915] vgaarb: loaded
[    0.667930] ACPI: bus type USB registered
[    0.667936] usbcore: registered new interface driver usbfs
[    0.667940] usbcore: registered new interface driver hub
[    0.667958] usbcore: registered new device driver usb
[    0.667970] pps_core: LinuxPPS API ver. 1 registered
[    0.667970] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.667972] PTP clock support registered
[    0.667987] EDAC MC: Ver: 3.0.0
[    0.668009] Registered efivars operations
[    0.668009] PCI: Using ACPI for IRQ routing
[    0.669589] PCI: pci_cache_line_size set to 64 bytes
[    0.669658] Expanded resource Reserved due to conflict with PCI Bus 0000=
:00
[    0.669658] e820: reserve RAM buffer [mem 0x09e02000-0x0bffffff]
[    0.669659] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
[    0.669659] e820: reserve RAM buffer [mem 0x0b000000-0x0bffffff]
[    0.669660] e820: reserve RAM buffer [mem 0xd6dbf018-0xd7ffffff]
[    0.669660] e820: reserve RAM buffer [mem 0xd6dfd018-0xd7ffffff]
[    0.669661] e820: reserve RAM buffer [mem 0xdb77d000-0xdbffffff]
[    0.669661] e820: reserve RAM buffer [mem 0xdba68000-0xdbffffff]
[    0.669662] e820: reserve RAM buffer [mem 0xdf000000-0xdfffffff]
[    0.669662] e820: reserve RAM buffer [mem 0x81f380000-0x81fffffff]
[    0.669726] NetLabel: Initializing
[    0.669726] NetLabel:  domain hash size =3D 128
[    0.669726] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.669733] NetLabel:  unlabeled traffic allowed by default
[    0.669739] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.669739] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.671907] clocksource: Switched to clocksource tsc-early
[    0.678734] VFS: Disk quotas dquot_6.6.0
[    0.678746] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    0.678762] *** VALIDATE hugetlbfs ***
[    0.678812] AppArmor: AppArmor Filesystem Enabled
[    0.678823] pnp: PnP ACPI init
[    0.678887] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.678890] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.678949] system 00:01: [mem 0xfd000000-0xfd0fffff] has been reserved
[    0.678951] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.678981] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.679096] system 00:03: [io  0x0a00-0x0a2f] has been reserved
[    0.679097] system 00:03: [io  0x0a30-0x0a3f] has been reserved
[    0.679097] system 00:03: [io  0x0a40-0x0a4f] has been reserved
[    0.679099] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.679273] system 00:04: [io  0x04d0-0x04d1] has been reserved
[    0.679274] system 00:04: [io  0x040b] has been reserved
[    0.679275] system 00:04: [io  0x04d6] has been reserved
[    0.679275] system 00:04: [io  0x0c00-0x0c01] has been reserved
[    0.679276] system 00:04: [io  0x0c14] has been reserved
[    0.679277] system 00:04: [io  0x0c50-0x0c51] has been reserved
[    0.679277] system 00:04: [io  0x0c52] has been reserved
[    0.679278] system 00:04: [io  0x0c6c] has been reserved
[    0.679278] system 00:04: [io  0x0c6f] has been reserved
[    0.679279] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
[    0.679280] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
[    0.679280] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
[    0.679281] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
[    0.679281] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
[    0.679282] system 00:04: [io  0x0800-0x089f] has been reserved
[    0.679283] system 00:04: [io  0x0b00-0x0b0f] has been reserved
[    0.679283] system 00:04: [io  0x0b20-0x0b3f] has been reserved
[    0.679284] system 00:04: [io  0x0900-0x090f] has been reserved
[    0.679285] system 00:04: [io  0x0910-0x091f] has been reserved
[    0.679286] system 00:04: [mem 0xfec00000-0xfec00fff] could not be reser=
ved
[    0.679286] system 00:04: [mem 0xfec01000-0xfec01fff] could not be reser=
ved
[    0.679287] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
[    0.679288] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.679289] system 00:04: [mem 0xfed80000-0xfed8ffff] could not be reser=
ved
[    0.679290] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
[    0.679291] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
[    0.679292] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.679605] pnp: PnP ACPI: found 5 devices
[    0.680487] thermal_sys: Registered thermal governor 'fair_share'
[    0.680487] thermal_sys: Registered thermal governor 'bang_bang'
[    0.680487] thermal_sys: Registered thermal governor 'step_wise'
[    0.680488] thermal_sys: Registered thermal governor 'user_space'
[    0.680488] thermal_sys: Registered thermal governor 'power_allocator'
[    0.684992] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, m=
ax_idle_ns: 2085701024 ns
[    0.685016] pci 0000:00:01.1: PCI bridge to [bus 01]
[    0.685019] pci 0000:00:01.1:   bridge window [mem 0xfcf00000-0xfcffffff]
[    0.685024] pci 0000:03:00.0: PCI bridge to [bus 04]
[    0.685034] pci 0000:03:01.0: PCI bridge to [bus 05]
[    0.685045] pci 0000:03:04.0: PCI bridge to [bus 06]
[    0.685055] pci 0000:03:05.0: PCI bridge to [bus 07]
[    0.685059] pci 0000:03:05.0:   bridge window [mem 0xfcc00000-0xfccfffff]
[    0.685067] pci 0000:03:06.0: PCI bridge to [bus 08]
[    0.685077] pci 0000:03:07.0: PCI bridge to [bus 09]
[    0.685079] pci 0000:03:07.0:   bridge window [io  0xf000-0xffff]
[    0.685083] pci 0000:03:07.0:   bridge window [mem 0xfcb00000-0xfcbfffff]
[    0.685090] pci 0000:02:00.2: PCI bridge to [bus 03-09]
[    0.685092] pci 0000:02:00.2:   bridge window [io  0xf000-0xffff]
[    0.685095] pci 0000:02:00.2:   bridge window [mem 0xfcb00000-0xfccfffff]
[    0.685102] pci 0000:00:01.3: PCI bridge to [bus 02-09]
[    0.685103] pci 0000:00:01.3:   bridge window [io  0xf000-0xffff]
[    0.685106] pci 0000:00:01.3:   bridge window [mem 0xfcb00000-0xfcdfffff]
[    0.685110] pci 0000:00:03.1: PCI bridge to [bus 0a]
[    0.685111] pci 0000:00:03.1:   bridge window [io  0xe000-0xefff]
[    0.685113] pci 0000:00:03.1:   bridge window [mem 0xfce00000-0xfcefffff]
[    0.685115] pci 0000:00:03.1:   bridge window [mem 0xe0000000-0xf01fffff=
 64bit pref]
[    0.685118] pci 0000:00:07.1: PCI bridge to [bus 0b]
[    0.685124] pci 0000:00:08.1: PCI bridge to [bus 0c]
[    0.685126] pci 0000:00:08.1:   bridge window [mem 0xfc800000-0xfcafffff]
[    0.685131] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    0.685131] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    0.685132] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    0.685132] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    0.685133] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff windo=
w]
[    0.685133] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff windo=
w]
[    0.685134] pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff wind=
ow]
[    0.685135] pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff wind=
ow]
[    0.685135] pci_bus 0000:01: resource 1 [mem 0xfcf00000-0xfcffffff]
[    0.685136] pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
[    0.685136] pci_bus 0000:02: resource 1 [mem 0xfcb00000-0xfcdfffff]
[    0.685137] pci_bus 0000:03: resource 0 [io  0xf000-0xffff]
[    0.685137] pci_bus 0000:03: resource 1 [mem 0xfcb00000-0xfccfffff]
[    0.685138] pci_bus 0000:07: resource 1 [mem 0xfcc00000-0xfccfffff]
[    0.685139] pci_bus 0000:09: resource 0 [io  0xf000-0xffff]
[    0.685139] pci_bus 0000:09: resource 1 [mem 0xfcb00000-0xfcbfffff]
[    0.685140] pci_bus 0000:0a: resource 0 [io  0xe000-0xefff]
[    0.685140] pci_bus 0000:0a: resource 1 [mem 0xfce00000-0xfcefffff]
[    0.685141] pci_bus 0000:0a: resource 2 [mem 0xe0000000-0xf01fffff 64bit=
 pref]
[    0.685142] pci_bus 0000:0c: resource 1 [mem 0xfc800000-0xfcafffff]
[    0.685208] NET: Registered protocol family 2
[    0.685348] tcp_listen_portaddr_hash hash table entries: 16384 (order: 6=
, 262144 bytes, linear)
[    0.685484] TCP established hash table entries: 262144 (order: 9, 209715=
2 bytes, linear)
[    0.685726] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes,=
 linear)
[    0.685788] TCP: Hash tables configured (established 262144 bind 65536)
[    0.685840] UDP hash table entries: 16384 (order: 7, 524288 bytes, linea=
r)
[    0.685900] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, =
linear)
[    0.685986] NET: Registered protocol family 1
[    0.685988] NET: Registered protocol family 44
[    0.686127] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x0=
00c0000-0x000dffff]
[    0.686132] pci 0000:0a:00.1: D0 power state depends on 0000:0a:00.0
[    0.686223] PCI: CLS 64 bytes, default 64
[    0.686254] Trying to unpack rootfs image as initramfs...
[    0.790624] Freeing initrd memory: 80320K
[    0.790662] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters support=
ed
[    0.790964] pci 0000:00:01.0: Adding to iommu group 0
[    0.791080] pci 0000:00:01.1: Adding to iommu group 1
[    0.791233] pci 0000:00:01.3: Adding to iommu group 2
[    0.791342] pci 0000:00:02.0: Adding to iommu group 3
[    0.791484] pci 0000:00:03.0: Adding to iommu group 4
[    0.791630] pci 0000:00:03.1: Adding to iommu group 5
[    0.791734] pci 0000:00:04.0: Adding to iommu group 6
[    0.791880] pci 0000:00:05.0: Adding to iommu group 7
[    0.791988] pci 0000:00:07.0: Adding to iommu group 8
[    0.792009] pci 0000:00:07.1: Adding to iommu group 8
[    0.792153] pci 0000:00:08.0: Adding to iommu group 9
[    0.792175] pci 0000:00:08.1: Adding to iommu group 9
[    0.792279] pci 0000:00:14.0: Adding to iommu group 10
[    0.792296] pci 0000:00:14.3: Adding to iommu group 10
[    0.792451] pci 0000:00:18.0: Adding to iommu group 11
[    0.792468] pci 0000:00:18.1: Adding to iommu group 11
[    0.792484] pci 0000:00:18.2: Adding to iommu group 11
[    0.792500] pci 0000:00:18.3: Adding to iommu group 11
[    0.792518] pci 0000:00:18.4: Adding to iommu group 11
[    0.792533] pci 0000:00:18.5: Adding to iommu group 11
[    0.792549] pci 0000:00:18.6: Adding to iommu group 11
[    0.792566] pci 0000:00:18.7: Adding to iommu group 11
[    0.792675] pci 0000:01:00.0: Adding to iommu group 12
[    0.792835] pci 0000:02:00.0: Adding to iommu group 13
[    0.792862] pci 0000:02:00.1: Adding to iommu group 13
[    0.792888] pci 0000:02:00.2: Adding to iommu group 13
[    0.792906] pci 0000:03:00.0: Adding to iommu group 13
[    0.792923] pci 0000:03:01.0: Adding to iommu group 13
[    0.792941] pci 0000:03:04.0: Adding to iommu group 13
[    0.792959] pci 0000:03:05.0: Adding to iommu group 13
[    0.792976] pci 0000:03:06.0: Adding to iommu group 13
[    0.792995] pci 0000:03:07.0: Adding to iommu group 13
[    0.793017] pci 0000:07:00.0: Adding to iommu group 13
[    0.793040] pci 0000:09:00.0: Adding to iommu group 13
[    0.793176] pci 0000:0a:00.0: Adding to iommu group 14
[    0.793205] pci 0000:0a:00.0: Using iommu direct mapping
[    0.793233] pci 0000:0a:00.1: Adding to iommu group 14
[    0.793251] pci 0000:0b:00.0: Adding to iommu group 8
[    0.793271] pci 0000:0c:00.0: Adding to iommu group 9
[    0.793288] pci 0000:0c:00.1: Adding to iommu group 9
[    0.793304] pci 0000:0c:00.3: Adding to iommu group 9
[    0.793321] pci 0000:0c:00.4: Adding to iommu group 9
[    0.793480] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.793481] pci 0000:00:00.2: AMD-Vi: Extended features (0x58f77ef22294a=
de):
[    0.793481]  PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.793483] AMD-Vi: Interrupt remapping enabled
[    0.793483] AMD-Vi: Virtual APIC enabled
[    0.793483] AMD-Vi: X2APIC enabled
[    0.793575] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.794205] amd_uncore: AMD NB counters detected
[    0.794209] amd_uncore: AMD LLC counters detected
[    0.794734] LVT offset 0 assigned for vector 0x400
[    0.794875] perf: AMD IBS detected (0x000003ff)
[    0.794879] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/b=
ank).
[    0.794910] check: Scanning for low memory corruption every 60 seconds
[    0.796007] Initialise system trusted keyrings
[    0.796015] Key type blacklist registered
[    0.796045] workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=
=3D0
[    0.796763] zbud: loaded
[    0.796999] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.797111] fuse: init (API version 7.31)
[    0.797201] Platform Keyring initialized
[    0.798709] Key type asymmetric registered
[    0.798710] Asymmetric key parser 'x509' registered
[    0.798715] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 244)
[    0.798743] io scheduler mq-deadline registered
[    0.799636] pcieport 0000:00:01.1: PME: Signaling with IRQ 26
[    0.799672] pcieport 0000:00:01.1: AER: enabled with IRQ 26
[    0.799698] pcieport 0000:00:01.1: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
[    0.799803] pcieport 0000:00:01.3: PME: Signaling with IRQ 27
[    0.799846] pcieport 0000:00:01.3: AER: enabled with IRQ 27
[    0.799869] pcieport 0000:00:01.3: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
[    0.799973] pcieport 0000:00:03.1: PME: Signaling with IRQ 28
[    0.800003] pcieport 0000:00:03.1: AER: enabled with IRQ 28
[    0.800023] pcieport 0000:00:03.1: DPC: error containment capabilities: =
Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 6, DL_ActiveErr+
[    0.800168] pcieport 0000:00:07.1: PME: Signaling with IRQ 30
[    0.800239] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    0.801028] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.801060] efifb: probing for efifb
[    0.801487] efifb: showing boot graphics
[    0.802267] efifb: framebuffer at 0xe0000000, using 3072k, total 3072k
[    0.802268] efifb: mode is 1024x768x32, linelength=3D4096, pages=3D1
[    0.802268] efifb: scrolling: redraw
[    0.802269] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    0.802304] fbcon: Deferring console take-over
[    0.802305] fb0: EFI VGA frame buffer device
[    0.802378] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0=
C0C:00/input/input0
[    0.802382] ACPI: Power Button [PWRB]
[    0.802400] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input1
[    0.802411] ACPI: Power Button [PWRF]
[    0.802470] Monitor-Mwait will be used to enter C-1 state
[    0.803673] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.804533] Linux agpgart interface v0.103
[    0.806831] loop: module loaded
[    0.806952] libphy: Fixed MDIO Bus: probed
[    0.806952] tun: Universal TUN/TAP device driver, 1.6
[    0.806985] PPP generic driver version 2.4.2
[    0.807012] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.807013] ehci-pci: EHCI PCI platform driver
[    0.807021] ehci-platform: EHCI generic platform driver
[    0.807024] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.807025] ohci-pci: OHCI PCI platform driver
[    0.807029] ohci-platform: OHCI generic platform driver
[    0.807032] uhci_hcd: USB Universal Host Controller Interface driver
[    0.807082] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.807086] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 1
[    0.862381] xhci_hcd 0000:02:00.0: hcc params 0x0200ef81 hci version 0x1=
10 quirks 0x0000000000000410
[    0.862517] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.03
[    0.862518] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.862518] usb usb1: Product: xHCI Host Controller
[    0.862519] usb usb1: Manufacturer: Linux 5.3.0-7625-generic xhci-hcd
[    0.862519] usb usb1: SerialNumber: 0000:02:00.0
[    0.862587] hub 1-0:1.0: USB hub found
[    0.862600] hub 1-0:1.0: 10 ports detected
[    0.862781] xhci_hcd 0000:02:00.0: xHCI Host Controller
[    0.862783] xhci_hcd 0000:02:00.0: new USB bus registered, assigned bus =
number 2
[    0.862784] xhci_hcd 0000:02:00.0: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.862820] usb usb2: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.862830] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.03
[    0.862830] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.862831] usb usb2: Product: xHCI Host Controller
[    0.862831] usb usb2: Manufacturer: Linux 5.3.0-7625-generic xhci-hcd
[    0.862832] usb usb2: SerialNumber: 0000:02:00.0
[    0.862892] hub 2-0:1.0: USB hub found
[    0.862898] hub 2-0:1.0: 4 ports detected
[    0.862944] usb: port power management may be unreliable
[    0.863014] xhci_hcd 0000:0c:00.3: xHCI Host Controller
[    0.863017] xhci_hcd 0000:0c:00.3: new USB bus registered, assigned bus =
number 3
[    0.863118] xhci_hcd 0000:0c:00.3: hcc params 0x0278ffe5 hci version 0x1=
10 quirks 0x0000000000000410
[    0.863356] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002, bcdDevice=3D 5.03
[    0.863357] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.863357] usb usb3: Product: xHCI Host Controller
[    0.863358] usb usb3: Manufacturer: Linux 5.3.0-7625-generic xhci-hcd
[    0.863358] usb usb3: SerialNumber: 0000:0c:00.3
[    0.863417] hub 3-0:1.0: USB hub found
[    0.863422] hub 3-0:1.0: 4 ports detected
[    0.863511] xhci_hcd 0000:0c:00.3: xHCI Host Controller
[    0.863512] xhci_hcd 0000:0c:00.3: new USB bus registered, assigned bus =
number 4
[    0.863514] xhci_hcd 0000:0c:00.3: Host supports USB 3.1 Enhanced SuperS=
peed
[    0.863521] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[    0.863529] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0003, bcdDevice=3D 5.03
[    0.863530] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.863530] usb usb4: Product: xHCI Host Controller
[    0.863531] usb usb4: Manufacturer: Linux 5.3.0-7625-generic xhci-hcd
[    0.863531] usb usb4: SerialNumber: 0000:0c:00.3
[    0.863583] hub 4-0:1.0: USB hub found
[    0.863587] hub 4-0:1.0: 4 ports detected
[    0.863674] i8042: PNP: No PS/2 controller found.
[    0.863715] mousedev: PS/2 mouse device common for all mice
[    0.863774] rtc_cmos 00:02: RTC can wake from S4
[    0.863906] rtc_cmos 00:02: registered as rtc0
[    0.863914] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram=
, hpet irqs
[    0.863916] i2c /dev entries driver
[    0.863937] device-mapper: uevent: version 1.0.3
[    0.863982] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised:=
 dm-devel@redhat.com
[    0.863990] platform eisa.0: Probing EISA bus 0
[    0.863991] platform eisa.0: EISA: Cannot allocate resource for mainboard
[    0.863992] platform eisa.0: Cannot allocate resource for EISA slot 1
[    0.863992] platform eisa.0: Cannot allocate resource for EISA slot 2
[    0.863993] platform eisa.0: Cannot allocate resource for EISA slot 3
[    0.863993] platform eisa.0: Cannot allocate resource for EISA slot 4
[    0.863994] platform eisa.0: Cannot allocate resource for EISA slot 5
[    0.863994] platform eisa.0: Cannot allocate resource for EISA slot 6
[    0.863994] platform eisa.0: Cannot allocate resource for EISA slot 7
[    0.863995] platform eisa.0: Cannot allocate resource for EISA slot 8
[    0.863995] platform eisa.0: EISA: Detected 0 cards
[    0.864266] ledtrig-cpu: registered to indicate activity on CPUs
[    0.864268] EFI Variables Facility v0.08 2004-May-17
[    0.875889] NET: Registered protocol family 10
[    0.879241] Segment Routing with IPv6
[    0.879252] NET: Registered protocol family 17
[    0.879277] Key type dns_resolver registered
[    0.879652] RAS: Correctable Errors collector initialized.
[    0.879667] microcode: CPU0: patch_level=3D0x08701013
[    0.879672] microcode: CPU1: patch_level=3D0x08701013
[    0.879673] microcode: CPU2: patch_level=3D0x08701013
[    0.879678] microcode: CPU3: patch_level=3D0x08701013
[    0.879684] microcode: CPU4: patch_level=3D0x08701013
[    0.879689] microcode: CPU5: patch_level=3D0x08701013
[    0.879695] microcode: CPU6: patch_level=3D0x08701013
[    0.879699] microcode: CPU7: patch_level=3D0x08701013
[    0.879703] microcode: CPU8: patch_level=3D0x08701013
[    0.879708] microcode: CPU9: patch_level=3D0x08701013
[    0.879713] microcode: CPU10: patch_level=3D0x08701013
[    0.879718] microcode: CPU11: patch_level=3D0x08701013
[    0.879737] microcode: Microcode Update Driver: v2.2.
[    0.879830] *** VALIDATE rdt ***
[    0.879832] resctrl: L3 allocation detected
[    0.879833] resctrl: L3DATA allocation detected
[    0.879833] resctrl: L3CODE allocation detected
[    0.879833] resctrl: MB allocation detected
[    0.879834] resctrl: L3 monitoring detected
[    0.879839] sched_clock: Marking stable (567560681, 312265189)->(8863293=
51, -6503481)
[    0.879944] registered taskstats version 1
[    0.879949] Loading compiled-in X.509 certificates
[    0.880917] Loaded X.509 cert 'Build time autogenerated kernel key: a824=
47c488e4f947a0590bea68e9999ca82ff5d4'
[    0.880947] zswap: loaded using pool lzo/zbud
[    0.884139] Key type big_key registered
[    0.885663] Key type encrypted registered
[    0.885664] AppArmor: AppArmor sha1 policy hashing enabled
[    0.886282] ima: No TPM chip found, activating TPM-bypass!
[    0.886285] ima: Allocated hash algorithm: sha1
[    0.886289] No architecture policies found
[    0.886293] evm: Initialising EVM extended attributes:
[    0.886293] evm: security.selinux
[    0.886293] evm: security.SMACK64
[    0.886293] evm: security.SMACK64EXEC
[    0.886293] evm: security.SMACK64TRANSMUTE
[    0.886294] evm: security.SMACK64MMAP
[    0.886294] evm: security.apparmor
[    0.886294] evm: security.ima
[    0.886294] evm: security.capability
[    0.886295] evm: HMAC attrs: 0x1
[    0.886587] PM:   Magic number: 4:494:456
[    0.886609] mem urandom: hash matches
[    0.886694] rtc_cmos 00:02: setting system clock to 2020-05-21T00:27:07 =
UTC (1590020827)
[    0.886864] acpi_cpufreq: overriding BIOS provided _PSD data
[    0.888126] Freeing unused decrypted memory: 2040K
[    0.888406] Freeing unused kernel image memory: 2668K
[    0.905508] Write protecting the kernel read-only data: 22528k
[    0.905855] Freeing unused kernel image memory: 2008K
[    0.906016] Freeing unused kernel image memory: 1416K
[    0.912710] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.912711] Run /init as init process
[    0.951711] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-=
00A0C9062910 (first instance was on PNP0C14:00)
[    0.953843] ahci 0000:02:00.1: version 3.0
[    0.953858] dca service started, version 1.12.1
[    0.953976] ahci 0000:02:00.1: SSS flag set, parallel bus scan disabled
[    0.954023] ahci 0000:02:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x=
33 impl SATA mode
[    0.954025] ahci 0000:02:00.1: flags: 64bit ncq sntf stag pm led clo onl=
y pmp pio slum part sxs deso sadm sds apst=20
[    0.954533] nvme nvme0: pci function 0000:01:00.0
[    0.954740] scsi host0: ahci
[    0.954865] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000=
000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B0F (\GSA1=
=2ESMBI) (20190703/utaddress-204)
[    0.954869] ACPI: If an ACPI driver is available for this device, you sh=
ould use it instead of the native driver
[    0.954945] scsi host1: ahci
[    0.955011] scsi host2: ahci
[    0.955201] scsi host3: ahci
[    0.955767] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.=
0-k
[    0.955768] igb: Copyright (c) 2007-2014 Intel Corporation.
[    0.956414] scsi host4: ahci
[    0.956497] scsi host5: ahci
[    0.959005] scsi host6: ahci
[    0.960057] scsi host7: ahci
[    0.960107] ata1: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80=
100 irq 51
[    0.960109] ata2: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80=
180 irq 51
[    0.960109] ata3: DUMMY
[    0.960110] ata4: DUMMY
[    0.960111] ata5: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80=
300 irq 51
[    0.960113] ata6: SATA max UDMA/133 abar m131072@0xfcd80000 port 0xfcd80=
380 irq 51
[    0.960114] ata7: DUMMY
[    0.960114] ata8: DUMMY
[    0.960498] cryptd: max_cpu_qlen set to 1000
[    0.966323] AVX2 version of gcm_enc/dec engaged.
[    0.966323] AES CTR mode by8 optimization enabled
[    0.987818] pps pps0: new PPS source ptp0
[    0.987820] igb 0000:09:00.0: added PHC on eth0
[    0.987821] igb 0000:09:00.0: Intel(R) Gigabit Ethernet Network Connecti=
on
[    0.987822] igb 0000:09:00.0: eth0: (PCIe:2.5Gb/s:Width x1) b4:2e:99:c2:=
8d:c9
[    0.987823] igb 0000:09:00.0: eth0: PBA No: FFFFFF-0FF
[    0.987823] igb 0000:09:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 t=
x queue(s)
[    0.987917] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.988408] igb 0000:09:00.0 enp9s0: renamed from eth0
[    1.013534] [drm] amdgpu kernel modesetting enabled.
[    1.013576] Parsing CRAT table with 1 nodes
[    1.013580] Ignoring ACPI CRAT on non-APU system
[    1.013581] Virtual CRAT table created for CPU
[    1.013582] Parsing CRAT table with 1 nodes
[    1.013582] Creating topology SYSFS entries
[    1.013590] Topology: Add CPU node
[    1.013590] Finished initializing topology
[    1.013653] amdgpu 0000:0a:00.0: remove_conflicting_pci_framebuffers: ba=
r 0: 0xe0000000 -> 0xefffffff
[    1.013654] amdgpu 0000:0a:00.0: remove_conflicting_pci_framebuffers: ba=
r 2: 0xf0000000 -> 0xf01fffff
[    1.013654] amdgpu 0000:0a:00.0: remove_conflicting_pci_framebuffers: ba=
r 5: 0xfce00000 -> 0xfce3ffff
[    1.013655] checking generic (e0000000 300000) vs hw (e0000000 10000000)
[    1.013656] fb0: switching to amdgpudrmfb from EFI VGA
[    1.013689] amdgpu 0000:0a:00.0: vgaarb: deactivate vga console
[    1.013827] [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67=
DF 0x1458:0x2311 0xE1).
[    1.013832] [drm] register mmio base: 0xFCE00000
[    1.013832] [drm] register mmio size: 262144
[    1.013839] [drm] add ip block number 0 <vi_common>
[    1.013839] [drm] add ip block number 1 <gmc_v8_0>
[    1.013839] [drm] add ip block number 2 <tonga_ih>
[    1.013839] [drm] add ip block number 3 <gfx_v8_0>
[    1.013840] [drm] add ip block number 4 <sdma_v3_0>
[    1.013840] [drm] add ip block number 5 <powerplay>
[    1.013840] [drm] add ip block number 6 <dm>
[    1.013840] [drm] add ip block number 7 <uvd_v6_0>
[    1.013841] [drm] add ip block number 8 <vce_v3_0>
[    1.014013] amdgpu 0000:0a:00.0: No more image in the PCI ROM
[    1.014026] ATOM BIOS: xxx-xxx-xxx
[    1.014036] [drm] UVD is enabled in VM mode
[    1.014036] [drm] UVD ENC is enabled in VM mode
[    1.014038] [drm] VCE enabled in VM mode
[    1.014054] [drm] vm size is 128 GB, 2 levels, block size is 10-bit, fra=
gment size is 9-bit
[    1.014077] amdgpu 0000:0a:00.0: VRAM: 8192M 0x000000F400000000 - 0x0000=
00F5FFFFFFFF (8192M used)
[    1.014078] amdgpu 0000:0a:00.0: GART: 256M 0x000000FF00000000 - 0x00000=
0FF0FFFFFFF
[    1.014081] [drm] Detected VRAM RAM=3D8192M, BAR=3D256M
[    1.014082] [drm] RAM width 256bits GDDR5
[    1.014108] [TTM] Zone  kernel: Available graphics memory: 16448594 KiB
[    1.014108] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    1.014109] [TTM] Initializing pool allocator
[    1.014111] [TTM] Initializing DMA pool allocator
[    1.014130] [drm] amdgpu: 8192M of VRAM memory ready
[    1.014132] [drm] amdgpu: 8192M of GTT memory ready.
[    1.014136] [drm] GART: num cpu pages 65536, num gpu pages 65536
[    1.016294] [drm] PCIE GART of 256M enabled (table at 0x000000F400300000=
).
[    1.016376] [drm] Chained IB support enabled!
[    1.017100] amdgpu: [powerplay] hwmgr_sw_init smu backed is polaris10_smu
[    1.017159] [drm] Found UVD firmware Version: 1.130 Family ID: 16
[    1.017632] [drm] Found VCE firmware Version: 53.26 Binary ID: 3
[    1.080281] [drm] DM_PPLIB: values for Engine clock
[    1.080282] [drm] DM_PPLIB:	 300000
[    1.080282] [drm] DM_PPLIB:	 909000
[    1.080282] [drm] DM_PPLIB:	 1134000
[    1.080282] [drm] DM_PPLIB:	 1266000
[    1.080283] [drm] DM_PPLIB:	 1365000
[    1.080283] [drm] DM_PPLIB:	 1432000
[    1.080283] [drm] DM_PPLIB:	 1490000
[    1.080283] [drm] DM_PPLIB:	 1545000
[    1.080283] [drm] DM_PPLIB: Validation clocks:
[    1.080284] [drm] DM_PPLIB:    engine_max_clock: 154500
[    1.080284] [drm] DM_PPLIB:    memory_max_clock: 200000
[    1.080284] [drm] DM_PPLIB:    level           : 8
[    1.080285] [drm] DM_PPLIB: values for Memory clock
[    1.080285] [drm] DM_PPLIB:	 400000
[    1.080285] [drm] DM_PPLIB:	 1000000
[    1.080285] [drm] DM_PPLIB:	 2000000
[    1.080285] [drm] DM_PPLIB: Validation clocks:
[    1.080286] [drm] DM_PPLIB:    engine_max_clock: 154500
[    1.080286] [drm] DM_PPLIB:    memory_max_clock: 200000
[    1.080286] [drm] DM_PPLIB:    level           : 8
[    1.094333] [drm] Display Core initialized with v3.2.35!
[    1.119732] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.119732] [drm] Driver supports precise vblank timestamp query.
[    1.146290] [drm] UVD and UVD ENC initialized successfully.
[    1.168996] nvme nvme0: missing or invalid SUBNQN field.
[    1.169018] nvme nvme0: Shutdown timeout set to 8 seconds
[    1.195942] usb 1-1: new full-speed USB device number 2 using xhci_hcd
[    1.197564] nvme nvme0: 32/0/0 default/read/poll queues
[    1.199940] usb 3-3: new low-speed USB device number 2 using xhci_hcd
[    1.203955]  nvme0n1: p1 p2 p3 p4
[    1.246237] [drm] VCE initialized successfully.
[    1.247273] kfd kfd: Allocated 3969056 bytes on gart
[    1.247715] Virtual CRAT table created for GPU
[    1.247715] Parsing CRAT table with 1 nodes
[    1.247720] Creating topology SYSFS entries
[    1.247765] Topology: Add dGPU node [0x67df:0x1002]
[    1.247766] kfd kfd: added device 1002:67df
[    1.249104] [drm] fb mappable at 0xE0830000
[    1.249104] [drm] vram apper at 0xE0000000
[    1.249105] [drm] size 8294400
[    1.249105] [drm] fb depth is 24
[    1.249105] [drm]    pitch is 7680
[    1.249144] fbcon: amdgpudrmfb (fb0) is primary device
[    1.249145] fbcon: Deferring console take-over
[    1.249146] amdgpu 0000:0a:00.0: fb0: amdgpudrmfb frame buffer device
[    1.265757] [drm] Initialized amdgpu 3.33.0 20150101 for 0000:0a:00.0 on=
 minor 0
[    1.362574] usb 3-3: New USB device found, idVendor=3D047d, idProduct=3D=
1020, bcdDevice=3D 1.06
[    1.362576] usb 3-3: New USB device strings: Mfr=3D0, Product=3D1, Seria=
lNumber=3D0
[    1.362576] usb 3-3: Product: Kensington Expert Mouse
[    1.393022] hidraw: raw HID events driver (C) Jiri Kosina
[    1.398629] usbcore: registered new interface driver usbhid
[    1.398630] usbhid: USB HID core driver
[    1.399554] input: Kensington Expert Mouse as /devices/pci0000:00/0000:0=
0:08.1/0000:0c:00.3/usb3/3-3/3-3:1.0/0003:047D:1020.0001/input/input2
[    1.399614] hid-generic 0003:047D:1020.0001: input,hidraw0: USB HID v1.1=
1 Mouse [Kensington Expert Mouse] on usb-0000:0c:00.3-3/input0
[    1.443347] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.443701] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    1.444330] ata1.00: ATA-11: Samsung SSD 860 EVO 1TB, RVT04B6Q, max UDMA=
/133
[    1.444332] ata1.00: 1953525168 sectors, multi 1: LBA48 NCQ (depth 32), =
AA
[    1.446343] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    1.448530] ata1.00: configured for UDMA/133
[    1.448666] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD 860  4B=
6Q PQ: 0 ANSI: 5
[    1.448775] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    1.448779] ata1.00: Enabling discard_zeroes_data
[    1.448849] sd 0:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 =
TB/932 GiB)
[    1.448858] sd 0:0:0:0: [sda] Write Protect is off
[    1.448859] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.448872] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[    1.448982] ata1.00: Enabling discard_zeroes_data
[    1.450038]  sda: sda1
[    1.450226] ata1.00: Enabling discard_zeroes_data
[    1.451150] sd 0:0:0:0: [sda] supports TCG Opal
[    1.451151] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.496748] usb 1-1: New USB device found, idVendor=3D24f0, idProduct=3D=
0105, bcdDevice=3D 1.15
[    1.496749] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.496750] usb 1-1: Product: Das Keyboard P13
[    1.496750] usb 1-1: Manufacturer: Das Keyboard
[    1.504057] usb 3-4: new full-speed USB device number 3 using xhci_hcd
[    1.539562] input: Das Keyboard Das Keyboard P13 as /devices/pci0000:00/=
0000:00:01.3/0000:02:00.0/usb1/1-1/1-1:1.0/0003:24F0:0105.0002/input/input3
[    1.596389] hid-generic 0003:24F0:0105.0002: input,hidraw1: USB HID v1.1=
0 Keyboard [Das Keyboard Das Keyboard P13] on usb-0000:02:00.0-1/input0
[    1.650695] input: Das Keyboard Das Keyboard P13 Mouse as /devices/pci00=
00:00/0000:00:01.3/0000:02:00.0/usb1/1-1/1-1:1.1/0003:24F0:0105.0003/input/=
input4
[    1.650759] input: Das Keyboard Das Keyboard P13 System Control as /devi=
ces/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-1/1-1:1.1/0003:24F0:0105.00=
03/input/input5
[    1.664555] usb 3-4: New USB device found, idVendor=3D0d8c, idProduct=3D=
013c, bcdDevice=3D 1.00
[    1.664556] usb 3-4: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D0
[    1.664557] usb 3-4: Product: USB PnP Sound Device
[    1.664558] usb 3-4: Manufacturer: C-Media Electronics Inc.     =20
[    1.685596] input: C-Media Electronics Inc.       USB PnP Sound Device a=
s /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/usb3/3-4/3-4:1.3/0003:0D8C:=
013C.0004/input/input9
[    1.708073] input: Das Keyboard Das Keyboard P13 Consumer Control as /de=
vices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-1/1-1:1.1/0003:24F0:0105.=
0003/input/input6
[    1.708120] input: Das Keyboard Das Keyboard P13 Keyboard as /devices/pc=
i0000:00/0000:00:01.3/0000:02:00.0/usb1/1-1/1-1:1.1/0003:24F0:0105.0003/inp=
ut/input8
[    1.760295] ata2: SATA link down (SStatus 0 SControl 300)
[    1.768173] hid-generic 0003:0D8C:013C.0004: input,hidraw2: USB HID v1.0=
0 Device [C-Media Electronics Inc.       USB PnP Sound Device] on usb-0000:=
0c:00.3-4/input3
[    1.768266] hid-generic 0003:24F0:0105.0003: input,hiddev0,hidraw3: USB =
HID v1.10 Mouse [Das Keyboard Das Keyboard P13] on usb-0000:02:00.0-1/input1
[    1.781590] hid-generic 0003:24F0:0105.0005: hiddev1,hidraw4: USB HID v1=
=2E10 Device [Das Keyboard Das Keyboard P13] on usb-0000:02:00.0-1/input2
[    1.799922] tsc: Refined TSC clocksource calibration: 3792.874 MHz
[    1.799930] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x6d5=
818a734c, max_idle_ns: 881590694765 ns
[    1.800108] clocksource: Switched to clocksource tsc
[    1.908029] usb 1-5: new full-speed USB device number 3 using xhci_hcd
[    2.073984] ata5: SATA link down (SStatus 0 SControl 330)
[    2.179201] usb 1-5: New USB device found, idVendor=3D1209, idProduct=3D=
1776, bcdDevice=3D 0.01
[    2.179203] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D220
[    2.179204] usb 1-5: Product: Io
[    2.179205] usb 1-5: Manufacturer: System76
[    2.179205] usb 1-5: SerialNumber: 85831323831351A03181
[    2.195058] system76_io: loading out-of-tree module taints kernel.
[    2.195076] system76_io: module verification failed: signature and/or re=
quired key missing - tainting kernel
[    2.195422] system76-io 1-5:1.0: id 1209:1776 interface 0 probe
[    2.199950] system76-io 1-5:1.1: id 1209:1776 interface 1 probe
[    2.199952] system76-io 1-5:1.1: trying reset: 0
[    2.202570] usbcore: registered new interface driver system76-io
[    2.320293] usb 1-10: new full-speed USB device number 4 using xhci_hcd
[    2.388638] ata6: SATA link down (SStatus 0 SControl 330)
[    2.539348] system76: Model does not utilize this driver
[    2.635905] raid6: avx2x4   gen() 40562 MB/s
[    2.651875] usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x3 has=
 wMaxPacketSize 0, skipping
[    2.651877] usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x83 ha=
s wMaxPacketSize 0, skipping
[    2.651882] usb 1-10: New USB device found, idVendor=3D8087, idProduct=
=3D0025, bcdDevice=3D 0.02
[    2.651883] usb 1-10: New USB device strings: Mfr=3D0, Product=3D0, Seri=
alNumber=3D0
[    2.683905] raid6: avx2x4   xor() 21401 MB/s
[    2.731905] raid6: avx2x2   gen() 38400 MB/s
[    2.779907] raid6: avx2x2   xor() 24304 MB/s
[    2.827907] raid6: avx2x1   gen() 21244 MB/s
[    2.875905] raid6: avx2x1   xor() 17877 MB/s
[    2.923906] raid6: sse2x4   gen() 19385 MB/s
[    2.971908] raid6: sse2x4   xor() 11547 MB/s
[    3.019906] raid6: sse2x2   gen() 18678 MB/s
[    3.067905] raid6: sse2x2   xor() 12332 MB/s
[    3.115908] raid6: sse2x1   gen()  8901 MB/s
[    3.163907] raid6: sse2x1   xor()  9020 MB/s
[    3.163907] raid6: using algorithm avx2x4 gen() 40562 MB/s
[    3.163908] raid6: .... xor() 21401 MB/s, rmw enabled
[    3.163908] raid6: using avx2x2 recovery algorithm
[    3.164527] xor: automatically using best checksumming function   avx   =
   =20
[    3.165054] async_tx: api initialized (async)
[    3.504969] Btrfs loaded, crc32c=3Dcrc32c-intel
[    3.530608] BTRFS: device fsid 155a20c7-2264-4923-b082-288a3c146384 devi=
d 1 transid 104 /dev/mapper/concolor-cougar
[    3.530694] BTRFS: device fsid 1f5a6f23-a7ef-46c6-92b1-84fc2f684931 devi=
d 1 transid 325214 /dev/mapper/puma-cougar
[    3.543848] EXT4-fs (nvme0n1p3): mounted filesystem with ordered data mo=
de. Opts: (null)
[    3.642185] systemd[1]: Inserted module 'autofs4'
[    3.673265] systemd[1]: systemd 242 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default=
=2Dhierarchy=3Dhybrid)
[    3.691942] systemd[1]: Detected architecture x86-64.
[    3.693810] systemd[1]: Set hostname to <puma>.
[    3.694080] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid ar=
gument
[    3.732368] systemd[1]: /lib/systemd/system/dbus.socket:4: ListenStream=
=3D references a path below legacy directory /var/run/, updating /var/run/d=
bus/system_bus_socket =E2=86=92 /run/dbus/system_bus_socket; please update =
the unit file accordingly.
[    3.761822] systemd[1]: Listening on fsck to fsckd communication Socket.
[    3.761844] systemd[1]: Reached target Remote File Systems.
[    3.761874] systemd[1]: Listening on Syslog Socket.
[    3.761904] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.761929] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.772768] lp: driver loaded but no devices found
[    3.774733] ppdev: user-space parallel port driver
[    3.775097] EXT4-fs (nvme0n1p3): re-mounted. Opts: errors=3Dremount-ro
[    3.960256] cfg80211: Loading compiled-in X.509 certificates for regulat=
ory database
[    3.961841] Bluetooth: Core ver 2.22
[    3.961857] NET: Registered protocol family 31
[    3.961857] Bluetooth: HCI device and connection manager initialized
[    3.961862] Bluetooth: HCI socket layer initialized
[    3.961864] Bluetooth: L2CAP socket layer initialized
[    3.961866] Bluetooth: SCO socket layer initialized
[    3.962209] ccp 0000:0c:00.1: enabling device (0000 -> 0002)
[    3.967986] ccp 0000:0c:00.1: ccp enabled
[    3.968038] ccp 0000:0c:00.1: psp enabled
[    3.970216] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    3.978727] usbcore: registered new interface driver btusb
[    3.979290] usbcore: registered new interface driver cdc_ether
[    3.980496] usbcore: registered new interface driver rndis_host
[    3.982849] Intel(R) Wireless WiFi driver for Linux
[    3.982850] Copyright(c) 2003- 2015 Intel Corporation
[    3.982914] iwlwifi 0000:07:00.0: enabling device (0000 -> 0002)
[    3.984052] usbcore: registered new interface driver rndis_wlan
[    3.984804] Bluetooth: hci0: Firmware revision 0.1 build 226 week 31 2019
[    3.998524] iwlwifi 0000:07:00.0: Found debug destination: EXTERNAL_DRAM
[    3.998526] iwlwifi 0000:07:00.0: Found debug configuration: 0
[    3.998793] iwlwifi 0000:07:00.0: loaded firmware version 46.6bf1df06.0 =
op_mode iwlmvm
[    4.027514] iwlwifi 0000:07:00.0: Detected Intel(R) Wireless-AC 9260 160=
MHz, REV=3D0x324
[    4.035173] iwlwifi 0000:07:00.0: Applying debug destination EXTERNAL_DR=
AM
[    4.035544] iwlwifi 0000:07:00.0: Allocated 0x00400000 bytes for firmwar=
e monitor.
[    4.040298] mc: Linux media interface: v0.10
[    4.059473] BTRFS info (device dm-4): disk space caching is enabled
[    4.059474] BTRFS info (device dm-4): has skinny extents
[    4.071995] systemd-journald[566]: Received request to flush runtime jou=
rnal from PID 1
[    4.075096] iwlwifi 0000:07:00.0: base HW address: 08:71:90:db:9c:d2
[    4.095428] BTRFS info (device dm-4): enabling ssd optimizations
[    4.099622] snd_hda_intel 0000:0a:00.1: Handle vga_switcheroo audio clie=
nt
[    4.099623] snd_hda_intel 0000:0a:00.1: Force to non-snoop mode
[    4.099784] snd_hda_intel 0000:0c:00.4: enabling device (0000 -> 0002)
[    4.108199] input: HDA ATI HDMI HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:03.1/0000:0a:00.1/sound/card0/input10
[    4.108242] input: HDA ATI HDMI HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:03.1/0000:0a:00.1/sound/card0/input11
[    4.108284] input: HDA ATI HDMI HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:03.1/0000:0a:00.1/sound/card0/input12
[    4.108322] input: HDA ATI HDMI HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:03.1/0000:0a:00.1/sound/card0/input13
[    4.108356] input: HDA ATI HDMI HDMI/DP,pcm=3D10 as /devices/pci0000:00/=
0000:00:03.1/0000:0a:00.1/sound/card0/input14
[    4.108390] input: HDA ATI HDMI HDMI/DP,pcm=3D11 as /devices/pci0000:00/=
0000:00:03.1/0000:0a:00.1/sound/card0/input15
[    4.115627] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: l=
ine_outs=3D1 (0x14/0x0/0x0/0x0/0x0) type:line
[    4.115629] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=3D0 (0x0/=
0x0/0x0/0x0/0x0)
[    4.115629] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=3D1 (0x1b/0x0/=
0x0/0x0/0x0)
[    4.115630] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=3D0x0
[    4.115630] snd_hda_codec_realtek hdaudioC1D0:    dig-out=3D0x1e/0x0
[    4.115631] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    4.115632] snd_hda_codec_realtek hdaudioC1D0:      Front Mic=3D0x19
[    4.115632] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=3D0x18
[    4.115633] snd_hda_codec_realtek hdaudioC1D0:      Line=3D0x1a
[    4.143736] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[    4.144095] thermal thermal_zone0: failed to read out thermal zone (-61)
[    4.145017] iwlwifi 0000:07:00.0 wlp7s0: renamed from wlan0
[    4.148869] input: HD-Audio Generic Front Mic as /devices/pci0000:00/000=
0:00:08.1/0000:0c:00.4/sound/card1/input16
[    4.148911] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000=
:00:08.1/0000:0c:00.4/sound/card1/input17
[    4.148954] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:=
08.1/0000:0c:00.4/sound/card1/input18
[    4.149002] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000=
:00:08.1/0000:0c:00.4/sound/card1/input19
[    4.149079] input: HD-Audio Generic Front Headphone as /devices/pci0000:=
00/0000:00:08.1/0000:0c:00.4/sound/card1/input20
[    4.171920] Adding 16776700k swap on /dev/mapper/cougar-swap.  Priority:=
1 extents:1 across:16776700k SSFS
[    4.279627] usbcore: registered new interface driver snd-usb-audio
[    9.124291] ccp 0000:0c:00.1: sev command 0x4 timed out, disabling PSP=20
[    9.124295] ccp 0000:0c:00.1: SEV: failed to get status. Error: 0x0
[    9.133530] kvm: disabled by bios
[    9.181309] kvm: disabled by bios
[    9.181666] MCE: In-kernel MCE decoding enabled.
[    9.182661] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.182661] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.253189] kvm: disabled by bios
[    9.253336] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.253337] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.308788] kvm: disabled by bios
[    9.309016] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.309017] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.368759] kvm: disabled by bios
[    9.369062] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.369062] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.437177] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.437178] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.437197] kvm: disabled by bios
[    9.493207] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.493209] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.493223] kvm: disabled by bios
[    9.560810] kvm: disabled by bios
[    9.561114] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.561115] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.620862] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.620863] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.620884] kvm: disabled by bios
[    9.688931] kvm: disabled by bios
[    9.688962] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.688963] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.729312] kvm: disabled by bios
[    9.768815] kvm: disabled by bios
[    9.768836] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.768837] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.828611] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.828612] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[    9.868364] EDAC amd64: Node 0: DRAM ECC disabled.
[    9.868365] EDAC amd64: ECC disabled in the BIOS or no ECC capability, m=
odule will not load.
                Either enable ECC checking or force module loading by setti=
ng 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effec=
ts.)
[  104.190747] audit: type=3D1400 audit(1590020930.797:2): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-x=
pdfimport" pid=3D1121 comm=3D"apparmor_parser"
[  104.190900] audit: type=3D1400 audit(1590020930.797:3): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/hav=
eged" pid=3D1116 comm=3D"apparmor_parser"
[  104.191476] audit: type=3D1400 audit(1590020930.797:4): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-o=
opslash" pid=3D1112 comm=3D"apparmor_parser"
[  104.191751] audit: type=3D1400 audit(1590020930.797:5): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/cup=
s-browsed" pid=3D1124 comm=3D"apparmor_parser"
[  104.191905] audit: type=3D1400 audit(1590020930.797:6): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/mys=
qld-akonadi" pid=3D1118 comm=3D"apparmor_parser"
[  104.191908] audit: type=3D1400 audit(1590020930.797:7): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/sbin/mys=
qld-akonadi///usr/sbin/mysqld" pid=3D1118 comm=3D"apparmor_parser"
[  104.191941] audit: type=3D1400 audit(1590020930.801:8): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/man"=
 pid=3D1122 comm=3D"apparmor_parser"
[  104.191943] audit: type=3D1400 audit(1590020930.801:9): apparmor=3D"STAT=
US" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_filter" p=
id=3D1122 comm=3D"apparmor_parser"
[  104.191946] audit: type=3D1400 audit(1590020930.801:10): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"man_groff" p=
id=3D1122 comm=3D"apparmor_parser"
[  104.191972] audit: type=3D1400 audit(1590020930.801:11): apparmor=3D"STA=
TUS" operation=3D"profile_load" profile=3D"unconfined" name=3D"libreoffice-=
senddoc" pid=3D1129 comm=3D"apparmor_parser"
[  104.470494] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[  104.470495] Bluetooth: BNEP filters: protocol multicast
[  104.470498] Bluetooth: BNEP socket layer initialized
[  104.553043] ahci 0000:02:00.1: port does not support device sleep
[  104.742631] iwlwifi 0000:07:00.0: Applying debug destination EXTERNAL_DR=
AM
[  104.856928] iwlwifi 0000:07:00.0: Applying debug destination EXTERNAL_DR=
AM
[  104.920091] iwlwifi 0000:07:00.0: FW already configured (0) - re-configu=
ring
[  106.527846] Bluetooth: RFCOMM TTY layer initialized
[  106.527849] Bluetooth: RFCOMM socket layer initialized
[  106.527851] Bluetooth: RFCOMM ver 1.11
[  106.980596] igb 0000:09:00.0 enp9s0: igb: enp9s0 NIC Link is Up 10 Mbps =
Half Duplex, Flow Control: None
[  106.980598] igb 0000:09:00.0: EEE Disabled: unsupported at half duplex. =
Re-enable using ethtool when at full duplex.
[  106.980855] IPv6: ADDRCONF(NETDEV_CHANGE): enp9s0: link becomes ready
[  117.662049] fbcon: Taking over console
[  117.662974] Console: switching to colour frame buffer device 240x67
[  145.925147] usb 1-5: io_dev_revision failed: 110: io_dev_read
[  155.325893] kauditd_printk_skb: 24 callbacks suppressed
[  155.325894] audit: type=3D1400 audit(1590020982.510:36): apparmor=3D"DEN=
IED" operation=3D"open" profile=3D"/usr/sbin/mysqld-akonadi///usr/sbin/mysq=
ld" name=3D"/etc/mysql/mariadb.cnf" pid=3D2860 comm=3D"mysqld" requested_ma=
sk=3D"r" denied_mask=3D"r" fsuid=3D1000 ouid=3D0
[  161.732108] usb 1-5: io_dev_revision failed: 110: io_dev_read
[  162.756092] usb 1-5: io_dev_revision failed: 110: io_dev_read
[  453.277303] BTRFS: device fsid 10c61748-efe7-4b9c-b1f7-041dc45d894b devi=
d 1 transid 5571 /dev/dm-6
[  481.152771] BTRFS info (device dm-6): disk space caching is enabled
[  481.152773] BTRFS info (device dm-6): has skinny extents
[  481.159981] BTRFS info (device dm-6): enabling ssd optimizations

--nextPart28398691.g1t78HKg7O--



