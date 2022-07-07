Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FEF5697E1
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 04:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiGGCUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 22:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiGGCUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 22:20:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612512F382
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657160397;
        bh=xkRZnfNOq4muM4ZwG00QaHSEYXSygOFxwKIPlY6TbEE=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ZoZHMnQ9Y9RA070HZGfFIQ31FO6/48wDnOew1Jawy1IVqJMORHnff7lopetq4ZlkV
         kPyCvBa7VrYjH94gxfRuA4T2FbEMvG0Cs6u/+OhUJXyn7eK8fYhr1whb+MqwaI7A6D
         1fxUZvcO22kASZhMX78eQHDffySPl+pjFeo55NwM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2aN-1nhg0i3lbD-00k6Tz; Thu, 07
 Jul 2022 04:19:56 +0200
Message-ID: <3ed7ee56-24fe-4fe6-b9ec-857adc8924cf@gmx.com>
Date:   Thu, 7 Jul 2022 10:19:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Denis Roy <denisjroy@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS critical (device md126): corrupt node: root=1
 block=13404298215424 slot=307, unaligned pointer, have 12567101254720864896
 should be aligned to 4096
In-Reply-To: <6a3407a3-2f24-c959-a00c-ec183ca466ed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GOZgz0f3TN/6eniBqQrtAvJ7+wcCVSUcSRcchNx+NszM7sVhALl
 2IfkSHXf+uSR340Y3X2jHXBDRhELWeTPZi2khv+V6TW2YnuS3s2hxJG12njwM4EBuU3gTzC
 DIg6q2jFeN7Lk4D73eIjiSjo1IaBe+zfk4KYVWwATndNZcV3KbCOF68512PveGRI85qLEpS
 nhzNC36B/VQENIYZNpDOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2DFssP5LM0o=:7H1QRdsEcTbQ/YN7xiFGpr
 KUZqeUaSkdtjtjMcsQvH58e4pDb7aMS46KwZfqzuPalRagRNDMDYyy3gTigsZ6tYyIUORzp0V
 s6U3jISy0R3q/qdvBr2JBsKhOFEiJJmPMHlGyrJNbccqqOjg9atctO1NuL42AQmr9/M7OlX/s
 2cobKGViZg8ePZqKJMWwsw+Ivac2ATtKyiZeR4GH5YAHjB9MtM6OdyIHhF3Qw/saXdxI4VyvJ
 u/ztt6C0QLXAZr8ButwPTgCmCdOCbeh06Wqv8Rk5yT4sg/Y+ax01eHf8CV8e5kDPgITS/3qn9
 sPtcTbLXYwGeE06gWBsMS1oR0b7kIQ7ubCSngjsRIJ04LfSOKI/XpIh0r5/cGGJCvhRAI58hD
 06LKDvYx1NO/HSYk3mOc4c5YoYvsfPm73pkaa8Wjx2GIdOQ4W0FKztPp96JymcGcTPVcGao4J
 MhWMZRSFEbMfTWLgZ5Go/vUn4zg/Kfehdpr9/NFuTErFg1jAMFDCLPrIdbTeL1Kb2wm2R4HUk
 yFksPE9uAf7COPnW2aDoNKaas8YOEOzZZvJEBxID8t5R6GtqaThBGao4lFpPjm9m+lj4iAbyd
 Cj4dI/5Xk5FL0CBC1vJm65Vn21V6piz9b8pmHM8MxJ9e2CJvkZV4r2N8yog4aifwZRVGvUOCP
 SM9X7tC4vIPqVY/AQSNRwMcprr6mh6uCRAVayMoRTJybC37meHyObLu/aEp55bwPzt9WllLIe
 uiuNclqxdmpgYUWBOPJJYlEJ/1S7PSs0ssQ6OvWqKgRPTlGrsVbUH9pDNCPjWsGLCtUoZX601
 8SWCyqqbgNotqO/Sxy7YSOXQd6jqqtEcZDpu2phpfL4OO4/bmpDgMYyxwS9F8Wzwa6ECRofYo
 H9mCd4DKF+8znYf9MUvOrS0o39r91a2NqN8kee1bNzdAJK28kU3+MDYI+qFPbwNhrtGHxyXNi
 l+zu8Mz1fGz9tbNYU7lqMnwUzxMpS5PhVn/168ngNxe136NKSTOrFdIAFlXexM4pkOdfUhJoL
 dBc3gc6YQ7bPxIHKs26Ys9F837VVWL5y0QIeBx75NvJIJByIgFUKCp2MCDKZ48rpncZHAsAo8
 MwfLPVIbskxEL9UOrSGuK10QdWZnuDvnsK1PDn+iwN0Ddblb2L+ncrg/A==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/7 09:32, Denis Roy wrote:
> I am using netgate readynas firmware 6.10.7, 5 drives ,X-RAID.=C2=A0 I h=
ad a
> power failure, but the nas never did a full shutdown. Nevertheless, the
> raid was in RO when I notice there was a problem. At the time I thought
> it was plex app, so I rebooted and then the raid never cam up. =C2=A0Eve=
r
> where you read up on BTRFS, they say don=E2=80=99t try commands you can =
do more
> dameage. So here I am. I added some info I believe you need and if there
> anything else, let me know.

That error message means, a tree node is pointing to a location which is
not aligned to sectorsize (the minimal unit of btrfs read/write).

But there are several problems:

- The bytenr 12567101254720864896, is aligned to 4096
   A quick python run shows:
   >>> 12567101254720864896 / 4096.0
   3068139954765836.0

   So I don't know why kernel would even output it.

- No extra context on the corrupted node.
   Mind to dump the tree block?

   # btrfs ins dump-tree -b 13404298215424 <dev>

   This should provide enough info on that.

- Extra btrfs check run on the array?
   Better to use the latest btrfs-progs to provide more comprehensive
   result.

Thanks,
Qu
>
> root@nas:~# btrfs version
>
> btrfs-progs v4.16
>
> root@nas:~# uname -a
>
> Linux nas 4.4.218.x86_64.1 #1 SMP Sun Nov 7 15:20:05 UTC 2021 x86_64
> GNU/Linux
>
> root@nas:~# btrfs fi show
>
> Label: '33ea130b:root'=C2=A0 uuid: 4a0317c0-214d-4204-b722-d6176eae04c0
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 1 FS bytes used 1.70=
GiB
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0 =C2=A0 1 size 4.00GiB =
used 2.86GiB path /dev/md0
>
> Label: '33ea130b:data'=C2=A0 uuid: cdc0bc68-6685-42df-a26f-63b1db286b12
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 2 FS bytes used 8.81=
TiB
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0 =C2=A0 1 size 10.90TiB=
 used 9.00TiB path /dev/md127
>
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0 =C2=A0 2 size 2.73TiB =
used 19.03GiB path /dev/md126
>
> root@nas:~# dmesg version
>
> [=C2=A0 =C2=A0 0.000000] Initializing cgroup subsys cpuset
>
> [=C2=A0 =C2=A0 0.000000] Initializing cgroup subsys cpu
>
> [=C2=A0 =C2=A0 0.000000] Initializing cgroup subsys cpuacct
>
> [=C2=A0 =C2=A0 0.000000] Linux version 4.4.218.x86_64.1 (root@blocks) (g=
cc version
> 8.3.0 (Debian 8.3.0-6) ) #1 SMP Sun Nov 7 15:20:05 UTC 2021
>
> [=C2=A0 =C2=A0 0.000000] Command line: initrd=3Dinitrd.gz reason=3Dnorma=
l
> BOOT_IMAGE=3Dkernel
>
> [=C2=A0 =C2=A0 0.000000] KERNEL supported cpus:
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 Intel GenuineIntel
>
> [=C2=A0 =C2=A0 0.000000] Disabled fast string operations
>
> [=C2=A0 =C2=A0 0.000000] x86/fpu: Legacy x87 FPU detected.
>
> [=C2=A0 =C2=A0 0.000000] e820: BIOS-provided physical RAM map:
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000=
09cbff]
> usable
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x000000000009cc00-0x0000000000=
09ffff]
> reserved
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000000e0000-0x0000000000=
0fffff]
> reserved
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000af=
eaffff]
> usable
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000afeb0000-0x00000000af=
ebdfff]
> ACPI data
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000afebe000-0x00000000af=
eeffff]
> ACPI NVS
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000afef0000-0x00000000af=
efffff]
> reserved
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fe=
e00fff]
> reserved
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x00000000ffb00000-0x00000000ff=
ffffff]
> reserved
>
> [=C2=A0 =C2=A0 0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000024f=
ffffff]
> usable
>
> [=C2=A0 =C2=A0 0.000000] NX (Execute Disable) protection: active
>
> [=C2=A0 =C2=A0 0.000000] SMBIOS 2.4 present.
>
> [=C2=A0 =C2=A0 0.000000] DMI: To Be Filled By O.E.M. To Be Filled By O.E=
.M./To be
> filled by O.E.M., BIOS 080014 07/26/2010
>
> [=C2=A0 =C2=A0 0.000000] e820: update [mem 0x00000000-0x00000fff] usable=
 =3D=3D> reserved
>
> [=C2=A0 =C2=A0 0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
>
> [=C2=A0 =C2=A0 0.000000] e820: last_pfn =3D 0x250000 max_arch_pfn =3D 0x=
400000000
>
> [=C2=A0 =C2=A0 0.000000] MTRR default type: uncachable
>
> [=C2=A0 =C2=A0 0.000000] MTRR fixed ranges enabled:
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 00000-9FFFF write-back
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 A0000-BFFFF uncachable
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 C0000-DFFFF write-protect
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 E0000-EFFFF write-through
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 F0000-FFFFF write-protect
>
> [=C2=A0 =C2=A0 0.000000] MTRR variable ranges enabled:
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 0 base 000000000 mask E00000000 write-ba=
ck
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 1 base 200000000 mask FC0000000 write-ba=
ck
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 2 base 240000000 mask FF0000000 write-ba=
ck
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 3 base 0B0000000 mask FF0000000 uncachab=
le
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 4 base 0C0000000 mask FC0000000 uncachab=
le
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 5 base 0AFF00000 mask FFFF00000 uncachab=
le
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 6 disabled
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 7 disabled
>
> [=C2=A0 =C2=A0 0.000000] x86/PAT: Configuration [0-7]: WB=C2=A0 WC=C2=A0=
 UC- UC=C2=A0 WB=C2=A0 WC=C2=A0 UC- WT
>
> [=C2=A0 =C2=A0 0.000000] e820: update [mem 0xaff00000-0xffffffff] usable=
 =3D=3D> reserved
>
> [=C2=A0 =C2=A0 0.000000] e820: last_pfn =3D 0xafeb0 max_arch_pfn =3D 0x4=
00000000
>
> [=C2=A0 =C2=A0 0.000000] Base memory trampoline at [ffff880000094000] 94=
000 size
> 28672
>
> [=C2=A0 =C2=A0 0.000000] BRK [0x08f56000, 0x08f56fff] PGTABLE
>
> [=C2=A0 =C2=A0 0.000000] BRK [0x08f57000, 0x08f57fff] PGTABLE
>
> [=C2=A0 =C2=A0 0.000000] BRK [0x08f58000, 0x08f58fff] PGTABLE
>
> [=C2=A0 =C2=A0 0.000000] BRK [0x08f59000, 0x08f59fff] PGTABLE
>
> [=C2=A0 =C2=A0 0.000000] BRK [0x08f5a000, 0x08f5afff] PGTABLE
>
> [=C2=A0 =C2=A0 0.000000] BRK [0x08f5b000, 0x08f5bfff] PGTABLE
>
> [=C2=A0 =C2=A0 0.000000] RAMDISK: [mem 0x7fb9f000-0x7fffffff]
>
> [=C2=A0 =C2=A0 0.000000] ACPI: Early table checksum verification disable=
d
>
> [=C2=A0 =C2=A0 0.000000] ACPI: RSDP 0x00000000000F9C00 000014 (v00 ACPIA=
M)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: RSDT 0x00000000AFEB0000 000038 (v01 A M I=
=C2=A0 OEMRSDT
> 07001026 MSFT 00000097)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: FACP 0x00000000AFEB0200 000084 (v02 A M I=
=C2=A0 OEMFACP
> 07001026 MSFT 00000097)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: DSDT 0x00000000AFEB0440 005B7A (v01 1ADHK=
=C2=A0 1ADHK007
> 00000007 INTL 20051117)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: FACS 0x00000000AFEBE000 000040
>
> [=C2=A0 =C2=A0 0.000000] ACPI: APIC 0x00000000AFEB0390 00006C (v01 A M I=
=C2=A0 OEMAPIC
> 07001026 MSFT 00000097)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: MCFG 0x00000000AFEB0400 00003C (v01 A M I=
=C2=A0 OEMMCFG
> 07001026 MSFT 00000097)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: OEMB 0x00000000AFEBE040 000060 (v01 A M I=
=C2=A0 AMI_OEM
> 07001026 MSFT 00000097)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: GSCI 0x00000000AFEBE0A0 002024 (v01 A M I=
=C2=A0 GMCHSCI
> 07001026 MSFT 00000097)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: Local APIC address 0xfee00000
>
> [=C2=A0 =C2=A0 0.000000] Zone ranges:
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA=C2=A0 =C2=A0 =C2=A0 [mem 0x000000000=
0001000-0x0000000000ffffff]
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA32=C2=A0 =C2=A0 [mem 0x00000000010000=
00-0x00000000ffffffff]
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 Normal =C2=A0 [mem 0x0000000100000000-0x=
000000024fffffff]
>
> [=C2=A0 =C2=A0 0.000000] Movable zone start for each node
>
> [=C2=A0 =C2=A0 0.000000] Early memory node ranges
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 node =C2=A0 0: [mem 0x0000000000001000-0=
x000000000009bfff]
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 node =C2=A0 0: [mem 0x0000000000100000-0=
x00000000afeaffff]
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 node =C2=A0 0: [mem 0x0000000100000000-0=
x000000024fffffff]
>
> [=C2=A0 =C2=A0 0.000000] Initmem setup node 0 [mem
> 0x0000000000001000-0x000000024fffffff]
>
> [=C2=A0 =C2=A0 0.000000] On node 0 totalpages: 2096715
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA zone: 64 pages used for memmap
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA zone: 22 pages reserved
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA zone: 3995 pages, LIFO batch:0
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA32 zone: 11195 pages used for memmap
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 DMA32 zone: 716464 pages, LIFO batch:31
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 Normal zone: 21504 pages used for memmap
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0 Normal zone: 1376256 pages, LIFO batch:3=
1
>
> [=C2=A0 =C2=A0 0.000000] Reserving Intel graphics stolen memory at
> 0xaff00000-0xafffffff
>
> [=C2=A0 =C2=A0 0.000000] ACPI: PM-Timer IO Port: 0x808
>
> [=C2=A0 =C2=A0 0.000000] ACPI: Local APIC address 0xfee00000
>
> [=C2=A0 =C2=A0 0.000000] IOAPIC[0]: apic_id 4, version 32, address 0xfec=
00000, GSI
> 0-23
>
> [=C2=A0 =C2=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2=
 dfl dfl)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9=
 high level)
>
> [=C2=A0 =C2=A0 0.000000] ACPI: IRQ0 used by override.
>
> [=C2=A0 =C2=A0 0.000000] ACPI: IRQ9 used by override.
>
> [=C2=A0 =C2=A0 0.000000] Using ACPI (MADT) for SMP configuration informa=
tion
>
> [=C2=A0 =C2=A0 0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
>
> [=C2=A0 =C2=A0 0.000000] e820: [mem 0xb0000000-0xfedfffff] available for=
 PCI devices
>
> [=C2=A0 =C2=A0 0.000000] clocksource: refined-jiffies: mask: 0xffffffff
> max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
>
> [=C2=A0 =C2=A0 0.000000] setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cp=
u_ids:4
> nr_node_ids:1
>
> [=C2=A0 =C2=A0 0.000000] PERCPU: Embedded 30 pages/cpu @ffff88024fc00000=
 s82392
> r8192 d32296 u524288
>
> [=C2=A0 =C2=A0 0.000000] pcpu-alloc: s82392 r8192 d32296 u524288 alloc=
=3D1*2097152
>
> [=C2=A0 =C2=A0 0.000000] pcpu-alloc: [0] 0 1 2 3
>
> [=C2=A0 =C2=A0 0.000000] Built 1 zonelists in Zone order, mobility group=
ing on.
> Total pages: 2063930
>
> [=C2=A0 =C2=A0 0.000000] Kernel command line: console=3Dtty0 console=3Dt=
tyS0,115200
> hpet=3Ddisable initrd=3Dinitrd.gz reason=3Dnormal BOOT_IMAGE=3Dkernel
>
> [=C2=A0 =C2=A0 0.000000] PID hash table entries: 4096 (order: 3, 32768 b=
ytes)
>
> [=C2=A0 =C2=A0 0.000000] Dentry cache hash table entries: 1048576 (order=
: 11,
> 8388608 bytes)
>
> [=C2=A0 =C2=A0 0.000000] Inode-cache hash table entries: 524288 (order: =
10,
> 4194304 bytes)
>
> [=C2=A0 =C2=A0 0.000000] Memory: 8156496K/8386860K available (9142K kern=
el code,
> 989K rwdata, 3940K rodata, 872K init, 696K bss, 230364K reserved, 0K
> cma-reserved)
>
> [=C2=A0 =C2=A0 0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0=
, CPUs=3D4, Nodes=3D1
>
> [=C2=A0 =C2=A0 0.000000] Kernel/User page tables isolation: enabled
>
> [=C2=A0 =C2=A0 0.000000] Hierarchical RCU implementation.
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0=C2=A0=C2=A0=C2=A0 RCU debugfs-based trac=
ing is enabled.
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0=C2=A0=C2=A0=C2=A0 Build-time adjustment =
of leaf fanout to 64.
>
> [=C2=A0 =C2=A0 0.000000] =C2=A0=C2=A0=C2=A0=C2=A0 RCU restricting CPUs f=
rom NR_CPUS=3D8 to nr_cpu_ids=3D4.
>
> [=C2=A0 =C2=A0 0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D6=
4, nr_cpu_ids=3D4
>
> [=C2=A0 =C2=A0 0.000000] NR_IRQS:4352 nr_irqs:456 16
>
> [=C2=A0 =C2=A0 0.000000] Console: colour VGA+ 80x25
>
> [=C2=A0 =C2=A0 0.000000] console [tty0] enabled
>
> [=C2=A0 =C2=A0 0.000000] console [ttyS0] enabled
>
> [=C2=A0 =C2=A0 0.000000] tsc: Fast TSC calibration using PIT
>
> [=C2=A0 =C2=A0 0.000000] tsc: Detected 2660.100 MHz processor
>
> [=C2=A0 =C2=A0 0.001011] Calibrating delay loop (skipped), value calcula=
ted using
> timer frequency.. 5320.20 BogoMIPS (lpj=3D2660100)
>
> [=C2=A0 =C2=A0 0.001014] pid_max: default: 32768 minimum: 301
>
> [=C2=A0 =C2=A0 0.001020] ACPI: Core revision 20150930
>
> [=C2=A0 =C2=A0 0.004916] ACPI: 1 ACPI AML tables successfully acquired a=
nd loaded
>
> [=C2=A0 =C2=A0 0.004937] Security Framework initialized
>
> [=C2=A0 =C2=A0 0.004948] Mount-cache hash table entries: 16384 (order: 5=
, 131072
> bytes)
>
> [=C2=A0 =C2=A0 0.004951] Mountpoint-cache hash table entries: 16384 (ord=
er: 5,
> 131072 bytes)
>
> [=C2=A0 =C2=A0 0.005355] Initializing cgroup subsys io
>
> [=C2=A0 =C2=A0 0.005360] Initializing cgroup subsys memory
>
> [=C2=A0 =C2=A0 0.005370] Initializing cgroup subsys devices
>
> [=C2=A0 =C2=A0 0.005374] Initializing cgroup subsys freezer
>
> [=C2=A0 =C2=A0 0.005378] Initializing cgroup subsys net_cls
>
> [=C2=A0 =C2=A0 0.005382] Initializing cgroup subsys perf_event
>
> [=C2=A0 =C2=A0 0.005385] Initializing cgroup subsys net_prio
>
> [=C2=A0 =C2=A0 0.005389] Initializing cgroup subsys pids
>
> [=C2=A0 =C2=A0 0.005406] Disabled fast string operations
>
> [=C2=A0 =C2=A0 0.005410] CPU: Physical Processor ID: 0
>
> [=C2=A0 =C2=A0 0.005411] CPU: Processor Core ID: 0
>
> [=C2=A0 =C2=A0 0.005413] mce: CPU supports 6 MCE banks
>
> [=C2=A0 =C2=A0 0.005423] CPU0: Thermal monitoring enabled (TM2)
>
> [=C2=A0 =C2=A0 0.005426] process: using mwait in idle threads
>
> [=C2=A0 =C2=A0 0.005431] Last level iTLB entries: 4KB 128, 2MB 4, 4MB 4
>
> [=C2=A0 =C2=A0 0.005433] Last level dTLB entries: 4KB 256, 2MB 0, 4MB 32=
, 1GB 0
>
> [=C2=A0 =C2=A0 0.005435] Spectre V1 : Mitigation: usercopy/swapgs barrie=
rs and
> __user pointer sanitization
>
> [=C2=A0 =C2=A0 0.005438] Spectre V2 : Mitigation: Full generic retpoline
>
> [=C2=A0 =C2=A0 0.005439] Spectre V2 : Spectre v2 / SpectreRSB mitigation=
: Filling
> RSB on context switch
>
> [=C2=A0 =C2=A0 0.005441] Speculative Store Bypass: Vulnerable
>
> [=C2=A0 =C2=A0 0.005464] MDS: Vulnerable: Clear CPU buffers attempted, n=
o microcode
>
> [=C2=A0 =C2=A0 0.005833] Freeing SMP alternatives memory: 40K
>
> [=C2=A0 =C2=A0 0.006445] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=
=3D-1 pin2=3D-1
>
> [=C2=A0 =C2=A0 0.118836] smpboot: CPU0: Intel(R) Xeon(R) CPU =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 X3230=C2=A0 @
> 2.66GHz (family: 0x6, model: 0xf, stepping: 0xb)
>
> [=C2=A0 =C2=A0 0.118850] Performance Events: PEBS fmt0+, 4-deep LBR, Cor=
e2 events,
> Intel PMU driver.
>
> [=C2=A0 =C2=A0 0.118861] perf_event_intel: PEBS disabled due to CPU erra=
ta
>
> [=C2=A0 =C2=A0 0.118864] ... version: 2
>
> [=C2=A0 =C2=A0 0.118865] ... bit width: 40
>
> [=C2=A0 =C2=A0 0.118866] ... generic registers: 2
>
> [=C2=A0 =C2=A0 0.118868] ... value mask: 000000ffffffffff
>
> [=C2=A0 =C2=A0 0.118869] ... max period: 000000007fffffff
>
> [=C2=A0 =C2=A0 0.118870] ... fixed-purpose events: 3
>
> [=C2=A0 =C2=A0 0.118872] ... event mask: 0000000700000003
>
> [=C2=A0 =C2=A0 0.119646] x86: Booting SMP configuration:
>
> [=C2=A0 =C2=A0 0.119649] .... node=C2=A0 #0, CPUs: #1 #2 #3
>
> [=C2=A0 =C2=A0 0.124026] x86: Booted up 1 node, 4 CPUs
>
> [=C2=A0 =C2=A0 0.124031] smpboot: Total of 4 processors activated (21280=
.80 BogoMIPS)
>
> [=C2=A0 =C2=A0 0.125124] NMI watchdog: enabled on all CPUs, permanently =
consumes
> one hw-PMU counter.
>
> [=C2=A0 =C2=A0 0.125195] devtmpfs: initialized
>
> [=C2=A0 =C2=A0 0.126201] clocksource: jiffies: mask: 0xffffffff max_cycl=
es:
> 0xffffffff, max_idle_ns: 1911260446275000 ns
>
> [=C2=A0 =C2=A0 0.126209] futex hash table entries: 1024 (order: 4, 65536=
 bytes)
>
> [=C2=A0 =C2=A0 0.126263] xor: measuring software checksum speed
>
> [=C2=A0 =C2=A0 0.136001]=C2=A0 =C2=A0 prefetch64-sse: 15092.000 MB/sec
>
> [=C2=A0 =C2=A0 0.146001]=C2=A0 =C2=A0 generic_sse: 12756.000 MB/sec
>
> [=C2=A0 =C2=A0 0.146003] xor: using function: prefetch64-sse (15092.000 =
MB/sec)
>
> [=C2=A0 =C2=A0 0.146010] pinctrl core: initialized pinctrl subsystem
>
> [=C2=A0 =C2=A0 0.146193] NET: Registered protocol family 16
>
> [=C2=A0 =C2=A0 0.150006] cpuidle: using governor ladder
>
> [=C2=A0 =C2=A0 0.154004] cpuidle: using governor menu
>
> [=C2=A0 =C2=A0 0.154232] ACPI: bus type PCI registered
>
> [=C2=A0 =C2=A0 0.154339] dca service started, version 1.12.1
>
> [=C2=A0 =C2=A0 0.154354] PCI: Using configuration type 1 for base access
>
> [=C2=A0 =C2=A0 0.180775] raid6: sse2x1 =C2=A0 gen()=C2=A0 4031 MB/s
>
> [=C2=A0 =C2=A0 0.197772] raid6: sse2x1 =C2=A0 xor()=C2=A0 4281 MB/s
>
> [=C2=A0 =C2=A0 0.214771] raid6: sse2x2 =C2=A0 gen()=C2=A0 4476 MB/s
>
> [=C2=A0 =C2=A0 0.231775] raid6: sse2x2 =C2=A0 xor()=C2=A0 5458 MB/s
>
> [=C2=A0 =C2=A0 0.248772] raid6: sse2x4 =C2=A0 gen()=C2=A0 7894 MB/s
>
> [=C2=A0 =C2=A0 0.265772] raid6: sse2x4 =C2=A0 xor()=C2=A0 5812 MB/s
>
> [=C2=A0 =C2=A0 0.265774] raid6: using algorithm sse2x4 gen() 7894 MB/s
>
> [=C2=A0 =C2=A0 0.265775] raid6: .... xor() 5812 MB/s, rmw enabled
>
> [=C2=A0 =C2=A0 0.265777] raid6: using ssse3x2 recovery algorithm
>
> [=C2=A0 =C2=A0 0.266024] ACPI: Added _OSI(Module Device)
>
> [=C2=A0 =C2=A0 0.266024] ACPI: Added _OSI(Processor Device)
>
> [=C2=A0 =C2=A0 0.266024] ACPI: Added _OSI(3.0 _SCP Extensions)
>
> [=C2=A0 =C2=A0 0.266024] ACPI: Added _OSI(Processor Aggregator Device)
>
> [=C2=A0 =C2=A0 0.267725] ACPI: Executed 1 blocks of module-level executa=
ble AML code
>
> [=C2=A0 =C2=A0 0.270238] ACPI: Interpreter enabled
>
> [=C2=A0 =C2=A0 0.270244] ACPI: (supports S0 S5)
>
> [=C2=A0 =C2=A0 0.270246] ACPI: Using IOAPIC for interrupt routing
>
> [=C2=A0 =C2=A0 0.270278] PCI: Using host bridge windows from ACPI; if ne=
cessary,
> use "pci=3Dnocrs" and report a bug
>
> [=C2=A0 =C2=A0 0.276431] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus =
00-ff])
>
> [=C2=A0 =C2=A0 0.276436] acpi PNP0A08:00: _OSC: OS supports [ASPM ClockP=
M Segments
> MSI]
>
> [=C2=A0 =C2=A0 0.276442] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); di=
sabling ASPM
>
> [=C2=A0 =C2=A0 0.276535] PCI host bridge to bus 0000:00
>
> [=C2=A0 =C2=A0 0.276539] pci_bus 0000:00: root bus resource [io=C2=A0 0x=
0000-0x0cf7
> window]
>
> [=C2=A0 =C2=A0 0.276541] pci_bus 0000:00: root bus resource [io=C2=A0 0x=
0d00-0xffff
> window]
>
> [=C2=A0 =C2=A0 0.276544] pci_bus 0000:00: root bus resource [mem
> 0x000a0000-0x000bffff window]
>
> [=C2=A0 =C2=A0 0.276546] pci_bus 0000:00: root bus resource [mem
> 0x000d0000-0x000dffff window]
>
> [=C2=A0 =C2=A0 0.276549] pci_bus 0000:00: root bus resource [mem
> 0xaff00000-0xffffffff window]
>
> [=C2=A0 =C2=A0 0.276551] pci_bus 0000:00: root bus resource [bus 00-ff]
>
> [=C2=A0 =C2=A0 0.276566] pci 0000:00:00.0: [8086:2990] type 00 class 0x0=
60000
>
> [=C2=A0 =C2=A0 0.276676] pci 0000:00:02.0: [8086:2992] type 00 class 0x0=
30000
>
> [=C2=A0 =C2=A0 0.276689] pci 0000:00:02.0: reg 0x10: [mem 0xffa00000-0xf=
fafffff]
>
> [=C2=A0 =C2=A0 0.276705] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xd=
fffffff
> 64bit pref]
>
> [=C2=A0 =C2=A0 0.276710] pci 0000:00:02.0: reg 0x20: [io=C2=A0 0xec00-0x=
ec07]
>
> [=C2=A0 =C2=A0 0.276829] pci 0000:00:1a.0: [8086:2834] type 00 class 0x0=
c0300
>
> [=C2=A0 =C2=A0 0.276873] pci 0000:00:1a.0: reg 0x20: [io=C2=A0 0xe000-0x=
e01f]
>
> [=C2=A0 =C2=A0 0.277017] pci 0000:00:1a.1: [8086:2835] type 00 class 0x0=
c0300
>
> [=C2=A0 =C2=A0 0.277023] pci 0000:00:1a.1: reg 0x20: [io=C2=A0 0xdc00-0x=
dc1f]
>
> [=C2=A0 =C2=A0 0.277130] pci 0000:00:1a.7: [8086:283a] type 00 class 0x0=
c0320
>
> [=C2=A0 =C2=A0 0.277159] pci 0000:00:1a.7: reg 0x10: [mem 0xff9fb400-0xf=
f9fb7ff]
>
> [=C2=A0 =C2=A0 0.277223] pci 0000:00:1a.7: PME# supported from D0 D3hot =
D3cold
>
> [=C2=A0 =C2=A0 0.277312] pci 0000:00:1b.0: [8086:284b] type 00 class 0x0=
40300
>
> [=C2=A0 =C2=A0 0.277340] pci 0000:00:1b.0: reg 0x10: [mem 0xff9f4000-0xf=
f9f7fff
> 64bit]
>
> [=C2=A0 =C2=A0 0.277391] pci 0000:00:1b.0: PME# supported from D0 D3hot =
D3cold
>
> [=C2=A0 =C2=A0 0.277473] pci 0000:00:1c.0: [8086:283f] type 01 class 0x0=
60400
>
> [=C2=A0 =C2=A0 0.277536] pci 0000:00:1c.0: PME# supported from D0 D3hot =
D3cold
>
> [=C2=A0 =C2=A0 0.277624] pci 0000:00:1c.1: [8086:2841] type 01 class 0x0=
60400
>
> [=C2=A0 =C2=A0 0.277688] pci 0000:00:1c.1: PME# supported from D0 D3hot =
D3cold
>
> [=C2=A0 =C2=A0 0.277778] pci 0000:00:1d.0: [8086:2830] type 00 class 0x0=
c0300
>
> [=C2=A0 =C2=A0 0.277821] pci 0000:00:1d.0: reg 0x20: [io=C2=A0 0xd880-0x=
d89f]
>
> [=C2=A0 =C2=A0 0.277920] pci 0000:00:1d.1: [8086:2831] type 00 class 0x0=
c0300
>
> [=C2=A0 =C2=A0 0.277963] pci 0000:00:1d.1: reg 0x20: [io=C2=A0 0xd800-0x=
d81f]
>
> [=C2=A0 =C2=A0 0.278070] pci 0000:00:1d.2: [8086:2832] type 00 class 0x0=
c0300
>
> [=C2=A0 =C2=A0 0.278114] pci 0000:00:1d.2: reg 0x20: [io=C2=A0 0xd480-0x=
d49f]
>
> [=C2=A0 =C2=A0 0.278222] pci 0000:00:1d.7: [8086:2836] type 00 class 0x0=
c0320
>
> [=C2=A0 =C2=A0 0.278252] pci 0000:00:1d.7: reg 0x10: [mem 0xff9fb000-0xf=
f9fb3ff]
>
> [=C2=A0 =C2=A0 0.278316] pci 0000:00:1d.7: PME# supported from D0 D3hot =
D3cold
>
> [=C2=A0 =C2=A0 0.278400] pci 0000:00:1e.0: [8086:244e] type 01 class 0x0=
60401
>
> [=C2=A0 =C2=A0 0.278535] pci 0000:00:1f.0: [8086:2810] type 00 class 0x0=
60100
>
> [=C2=A0 =C2=A0 0.278620] pci 0000:00:1f.0: quirk: [io=C2=A0 0x0800-0x087=
f] claimed by
> ICH6 ACPI/GPIO/TCO
>
> [=C2=A0 =C2=A0 0.278625] pci 0000:00:1f.0: quirk: [io=C2=A0 0x0480-0x04b=
f] claimed by
> ICH6 GPIO
>
> [=C2=A0 =C2=A0 0.278629] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 =
PIO at
> 0a00 (mask 00ff)
>
> [=C2=A0 =C2=A0 0.278732] pci 0000:00:1f.2: [8086:2821] type 00 class 0x0=
10601
>
> [=C2=A0 =C2=A0 0.278759] pci 0000:00:1f.2: reg 0x10: [io=C2=A0 0xe880-0x=
e887]
>
> [=C2=A0 =C2=A0 0.278766] pci 0000:00:1f.2: reg 0x14: [io=C2=A0 0xe800-0x=
e803]
>
> [=C2=A0 =C2=A0 0.278774] pci 0000:00:1f.2: reg 0x18: [io=C2=A0 0xe480-0x=
e487]
>
> [=C2=A0 =C2=A0 0.278782] pci 0000:00:1f.2: reg 0x1c: [io=C2=A0 0xe400-0x=
e403]
>
> [=C2=A0 =C2=A0 0.278789] pci 0000:00:1f.2: reg 0x20: [io=C2=A0 0xe080-0x=
e09f]
>
> [=C2=A0 =C2=A0 0.278797] pci 0000:00:1f.2: reg 0x24: [mem 0xff9fb800-0xf=
f9fbfff]
>
> [=C2=A0 =C2=A0 0.278825] pci 0000:00:1f.2: PME# supported from D3hot
>
> [=C2=A0 =C2=A0 0.278907] pci 0000:00:1f.3: [8086:283e] type 00 class 0x0=
c0500
>
> [=C2=A0 =C2=A0 0.278920] pci 0000:00:1f.3: reg 0x10: [mem 0xff9fac00-0xf=
f9facff]
>
> [=C2=A0 =C2=A0 0.278950] pci 0000:00:1f.3: reg 0x20: [io=C2=A0 0x0400-0x=
041f]
>
> [=C2=A0 =C2=A0 0.279124] pci 0000:01:00.0: [11ab:4362] type 00 class 0x0=
20000
>
> [=C2=A0 =C2=A0 0.279168] pci 0000:01:00.0: reg 0x10: [mem 0xff6fc000-0xf=
f6fffff
> 64bit]
>
> [=C2=A0 =C2=A0 0.279180] pci 0000:01:00.0: reg 0x18: [io=C2=A0 0xb800-0x=
b8ff]
>
> [=C2=A0 =C2=A0 0.279221] pci 0000:01:00.0: reg 0x30: [mem 0xff6c0000-0xf=
f6dffff pref]
>
> [=C2=A0 =C2=A0 0.279262] pci 0000:01:00.0: supports D1 D2
>
> [=C2=A0 =C2=A0 0.279264] pci 0000:01:00.0: PME# supported from D0 D1 D2 =
D3hot D3cold
>
> [=C2=A0 =C2=A0 0.279317] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCI=
e device.
> You can enable it with 'pcie_aspm=3Dforce'
>
> [=C2=A0 =C2=A0 0.279328] pci 0000:00:1c.0: PCI bridge to [bus 01]
>
> [=C2=A0 =C2=A0 0.279332] pci 0000:00:1c.0: =C2=A0 bridge window [io=C2=
=A0 0xb000-0xbfff]
>
> [=C2=A0 =C2=A0 0.279336] pci 0000:00:1c.0: =C2=A0 bridge window [mem
> 0xff600000-0xff6fffff]
>
> [=C2=A0 =C2=A0 0.279410] pci 0000:02:00.0: [11ab:4362] type 00 class 0x0=
20000
>
> [=C2=A0 =C2=A0 0.279454] pci 0000:02:00.0: reg 0x10: [mem 0xff7fc000-0xf=
f7fffff
> 64bit]
>
> [=C2=A0 =C2=A0 0.279466] pci 0000:02:00.0: reg 0x18: [io=C2=A0 0xc800-0x=
c8ff]
>
> [=C2=A0 =C2=A0 0.279506] pci 0000:02:00.0: reg 0x30: [mem 0xff7c0000-0xf=
f7dffff pref]
>
> [=C2=A0 =C2=A0 0.279548] pci 0000:02:00.0: supports D1 D2
>
> [=C2=A0 =C2=A0 0.279550] pci 0000:02:00.0: PME# supported from D0 D1 D2 =
D3hot D3cold
>
> [=C2=A0 =C2=A0 0.279599] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCI=
e device.
> You can enable it with 'pcie_aspm=3Dforce'
>
> [=C2=A0 =C2=A0 0.279609] pci 0000:00:1c.1: PCI bridge to [bus 02]
>
> [=C2=A0 =C2=A0 0.279613] pci 0000:00:1c.1: =C2=A0 bridge window [io=C2=
=A0 0xc000-0xcfff]
>
> [=C2=A0 =C2=A0 0.279618] pci 0000:00:1c.1: =C2=A0 bridge window [mem
> 0xff700000-0xff7fffff]
>
> [=C2=A0 =C2=A0 0.279706] pci 0000:00:1e.0: PCI bridge to [bus 03] (subtr=
active
> decode)
>
> [=C2=A0 =C2=A0 0.279715] pci 0000:00:1e.0: =C2=A0 bridge window [io=C2=
=A0 0x0000-0x0cf7
> window] (subtractive decode)
>
> [=C2=A0 =C2=A0 0.279718] pci 0000:00:1e.0: =C2=A0 bridge window [io=C2=
=A0 0x0d00-0xffff
> window] (subtractive decode)
>
> [=C2=A0 =C2=A0 0.279720] pci 0000:00:1e.0: =C2=A0 bridge window [mem
> 0x000a0000-0x000bffff window] (subtractive decode)
>
> [=C2=A0 =C2=A0 0.279723] pci 0000:00:1e.0: =C2=A0 bridge window [mem
> 0x000d0000-0x000dffff window] (subtractive decode)
>
> [=C2=A0 =C2=A0 0.279725] pci 0000:00:1e.0: =C2=A0 bridge window [mem
> 0xaff00000-0xffffffff window] (subtractive decode)
>
> [=C2=A0 =C2=A0 0.279740] pci_bus 0000:00: on NUMA node 0
>
> [=C2=A0 =C2=A0 0.280490] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7=
 10 *11 12
> 14 15)
>
> [=C2=A0 =C2=A0 0.280545] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7=
 *10 11 12
> 14 15)
>
> [=C2=A0 =C2=A0 0.280598] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7=
 10 11 12
> *14 15)
>
> [=C2=A0 =C2=A0 0.280651] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 =
7 10 11 12
> 14 15)
>
> [=C2=A0 =C2=A0 0.280713] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7=
 10 11 12
> 14 15) *0, disabled.
>
> [=C2=A0 =C2=A0 0.280766] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7=
 10 11 12
> 14 *15)
>
> [=C2=A0 =C2=A0 0.280819] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *=
7 10 11 12
> 14 15)
>
> [=C2=A0 =C2=A0 0.280871] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7=
 *10 11 12
> 14 15)
>
> [=C2=A0 =C2=A0 0.280925] ACPI: Enabled 2 GPEs in block 00 to 1F
>
> [=C2=A0 =C2=A0 0.281098] SCSI subsystem initialized
>
> [=C2=A0 =C2=A0 0.281130] libata version 3.00 loaded.
>
> [=C2=A0 =C2=A0 0.281137] ACPI: bus type USB registered
>
> [=C2=A0 =C2=A0 0.281175] usbcore: registered new interface driver usbfs
>
> [=C2=A0 =C2=A0 0.281190] usbcore: registered new interface driver hub
>
> [=C2=A0 =C2=A0 0.281211] usbcore: registered new device driver usb
>
> [=C2=A0 =C2=A0 0.281255] pps_core: LinuxPPS API ver. 1 registered
>
> [=C2=A0 =C2=A0 0.281256] pps_core: Software ver. 5.3.6 - Copyright 2005-=
2007
> Rodolfo Giometti <giometti@linux.it>
>
> [=C2=A0 =C2=A0 0.281266] PTP clock support registered
>
> [=C2=A0 =C2=A0 0.281307] Advanced Linux Sound Architecture Driver Initia=
lized.
>
> [=C2=A0 =C2=A0 0.281307] PCI: Using ACPI for IRQ routing
>
> [=C2=A0 =C2=A0 0.281307] PCI: pci_cache_line_size set to 64 bytes
>
> [=C2=A0 =C2=A0 0.281307] Expanded resource reserved due to conflict with=
 PCI Bus
> 0000:00
>
> [=C2=A0 =C2=A0 0.281307] e820: reserve RAM buffer [mem 0x0009cc00-0x0009=
ffff]
>
> [=C2=A0 =C2=A0 0.281307] e820: reserve RAM buffer [mem 0xafeb0000-0xafff=
ffff]
>
> [=C2=A0 =C2=A0 0.281517] Bluetooth: Core ver 2.21
>
> [=C2=A0 =C2=A0 0.281534] NET: Registered protocol family 31
>
> [=C2=A0 =C2=A0 0.281536] Bluetooth: HCI device and connection manager in=
itialized
>
> [=C2=A0 =C2=A0 0.281540] Bluetooth: HCI socket layer initialized
>
> [=C2=A0 =C2=A0 0.281543] Bluetooth: L2CAP socket layer initialized
>
> [=C2=A0 =C2=A0 0.281551] Bluetooth: SCO socket layer initialized
>
> [=C2=A0 =C2=A0 0.282186] clocksource: Switched to clocksource refined-ji=
ffies
>
> [=C2=A0 =C2=A0 0.282299] FS-Cache: Loaded
>
> [=C2=A0 =C2=A0 0.282369] pnp: PnP ACPI init
>
> [=C2=A0 =C2=A0 0.282461] system 00:00: [mem 0xfed14000-0xfed19fff] has b=
een reserved
>
> [=C2=A0 =C2=A0 0.282465] system 00:00: Plug and Play ACPI device, IDs PN=
P0c01
> (active)
>
> [=C2=A0 =C2=A0 0.282547] pnp 00:01: Plug and Play ACPI device, IDs PNP0b=
00 (active)
>
> [=C2=A0 =C2=A0 0.282616] pnp 00:02: Plug and Play ACPI device, IDs PNP03=
03 PNP030b
> (active)
>
> [=C2=A0 =C2=A0 0.282829] pnp 00:03: [dma 0 disabled]
>
> [=C2=A0 =C2=A0 0.282903] pnp 00:03: Plug and Play ACPI device, IDs PNP05=
01 (active)
>
> [=C2=A0 =C2=A0 0.283151] pnp 00:04: [dma 0 disabled]
>
> [=C2=A0 =C2=A0 0.283244] pnp 00:04: Plug and Play ACPI device, IDs PNP05=
01 (active)
>
> [=C2=A0 =C2=A0 0.283542] system 00:05: [io 0x0a00-0x0a0f] has been reser=
ved
>
> [=C2=A0 =C2=A0 0.283545] system 00:05: [io 0x0a10-0x0a1f] has been reser=
ved
>
> [=C2=A0 =C2=A0 0.283548] system 00:05: Plug and Play ACPI device, IDs PN=
P0c02
> (active)
>
> [=C2=A0 =C2=A0 0.283692] system 00:06: [io 0x04d0-0x04d1] has been reser=
ved
>
> [=C2=A0 =C2=A0 0.283695] system 00:06: [io 0x0800-0x087f] has been reser=
ved
>
> [=C2=A0 =C2=A0 0.283698] system 00:06: [io 0x0480-0x04bf] has been reser=
ved
>
> [=C2=A0 =C2=A0 0.283701] system 00:06: [mem 0xfed1c000-0xfed1ffff] has b=
een reserved
>
> [=C2=A0 =C2=A0 0.283704] system 00:06: [mem 0xfed20000-0xfed8ffff] has b=
een reserved
>
> [=C2=A0 =C2=A0 0.283707] system 00:06: Plug and Play ACPI device, IDs PN=
P0c02
> (active)
>
> [=C2=A0 =C2=A0 0.283832] system 00:07: [mem 0xffc00000-0xffefffff] has b=
een reserved
>
> [=C2=A0 =C2=A0 0.283836] system 00:07: Plug and Play ACPI device, IDs PN=
P0c02
> (active)
>
> [=C2=A0 =C2=A0 0.283933] system 00:08: [mem 0xfec00000-0xfec00fff] could=
 not be
> reserved
>
> [=C2=A0 =C2=A0 0.283936] system 00:08: [mem 0xfee00000-0xfee00fff] has b=
een reserved
>
> [=C2=A0 =C2=A0 0.283939] system 00:08: Plug and Play ACPI device, IDs PN=
P0c02
> (active)
>
> [=C2=A0 =C2=A0 0.284038] system 00:09: [mem 0xe0000000-0xefffffff] has b=
een reserved
>
> [=C2=A0 =C2=A0 0.284042] system 00:09: Plug and Play ACPI device, IDs PN=
P0c02
> (active)
>
> [=C2=A0 =C2=A0 0.284235] system 00:0a: [mem 0x00000000-0x0009ffff] could=
 not be
> reserved
>
> [=C2=A0 =C2=A0 0.284238] system 00:0a: [mem 0x000c0000-0x000cffff] could=
 not be
> reserved
>
> [=C2=A0 =C2=A0 0.284241] system 00:0a: [mem 0x000e0000-0x000fffff] could=
 not be
> reserved
>
> [=C2=A0 =C2=A0 0.284244] system 00:0a: [mem 0x00100000-0xafefffff] could=
 not be
> reserved
>
> [=C2=A0 =C2=A0 0.284247] system 00:0a: Plug and Play ACPI device, IDs PN=
P0c01
> (active)
>
> [=C2=A0 =C2=A0 0.284367] pnp: PnP ACPI: found 11 devices
>
> [=C2=A0 =C2=A0 0.292469] clocksource: acpi_pm: mask: 0xffffff max_cycles=
:
> 0xffffff, max_idle_ns: 2085701024 ns
>
> [=C2=A0 =C2=A0 0.292493] clocksource: Switched to clocksource acpi_pm
>
> [=C2=A0 =C2=A0 0.292511] pci 0000:00:1c.0: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align
> 100000
>
> [=C2=A0 =C2=A0 0.292520] pci 0000:00:1c.1: bridge window [mem
> 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align
> 100000
>
> [=C2=A0 =C2=A0 0.292530] pci 0000:00:1c.0: res[9]=3D[mem 0x00100000-0x00=
0fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
>
> [=C2=A0 =C2=A0 0.292533] pci 0000:00:1c.0: res[9]=3D[mem 0x00100000-0x00=
2fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
>
> [=C2=A0 =C2=A0 0.292536] pci 0000:00:1c.1: res[9]=3D[mem 0x00100000-0x00=
0fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
>
> [=C2=A0 =C2=A0 0.292539] pci 0000:00:1c.1: res[9]=3D[mem 0x00100000-0x00=
2fffff 64bit
> pref] res_to_dev_res add_size 200000 min_align 100000
>
> [=C2=A0 =C2=A0 0.292547] pci 0000:00:1c.0: BAR 9: assigned [mem
> 0xb0000000-0xb01fffff 64bit pref]
>
> [=C2=A0 =C2=A0 0.292552] pci 0000:00:1c.1: BAR 9: assigned [mem
> 0xb0200000-0xb03fffff 64bit pref]
>
> [=C2=A0 =C2=A0 0.292555] pci 0000:00:1c.0: PCI bridge to [bus 01]
>
> [=C2=A0 =C2=A0 0.292559] pci 0000:00:1c.0: =C2=A0 bridge window [io=C2=
=A0 0xb000-0xbfff]
>
> [=C2=A0 =C2=A0 0.292563] pci 0000:00:1c.0: =C2=A0 bridge window [mem
> 0xff600000-0xff6fffff]
>
> [=C2=A0 =C2=A0 0.292568] pci 0000:00:1c.0: =C2=A0 bridge window [mem
> 0xb0000000-0xb01fffff 64bit pref]
>
> [=C2=A0 =C2=A0 0.292573] pci 0000:00:1c.1: PCI bridge to [bus 02]
>
> [=C2=A0 =C2=A0 0.292576] pci 0000:00:1c.1: =C2=A0 bridge window [io=C2=
=A0 0xc000-0xcfff]
>
> [=C2=A0 =C2=A0 0.292581] pci 0000:00:1c.1: =C2=A0 bridge window [mem
> 0xff700000-0xff7fffff]
>
> [=C2=A0 =C2=A0 0.292585] pci 0000:00:1c.1: =C2=A0 bridge window [mem
> 0xb0200000-0xb03fffff 64bit pref]
>
> [=C2=A0 =C2=A0 0.292591] pci 0000:00:1e.0: PCI bridge to [bus 03]
>
> [=C2=A0 =C2=A0 0.292601] pci_bus 0000:00: resource 4 [io=C2=A0 0x0000-0x=
0cf7 window]
>
> [=C2=A0 =C2=A0 0.292603] pci_bus 0000:00: resource 5 [io=C2=A0 0x0d00-0x=
ffff window]
>
> [=C2=A0 =C2=A0 0.292606] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x0=
00bffff
> window]
>
> [=C2=A0 =C2=A0 0.292608] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x0=
00dffff
> window]
>
> [=C2=A0 =C2=A0 0.292611] pci_bus 0000:00: resource 8 [mem 0xaff00000-0xf=
fffffff
> window]
>
> [=C2=A0 =C2=A0 0.292613] pci_bus 0000:01: resource 0 [io=C2=A0 0xb000-0x=
bfff]
>
> [=C2=A0 =C2=A0 0.292616] pci_bus 0000:01: resource 1 [mem 0xff600000-0xf=
f6fffff]
>
> [=C2=A0 =C2=A0 0.292618] pci_bus 0000:01: resource 2 [mem 0xb0000000-0xb=
01fffff
> 64bit pref]
>
> [=C2=A0 =C2=A0 0.292620] pci_bus 0000:02: resource 0 [io=C2=A0 0xc000-0x=
cfff]
>
> [=C2=A0 =C2=A0 0.292623] pci_bus 0000:02: resource 1 [mem 0xff700000-0xf=
f7fffff]
>
> [=C2=A0 =C2=A0 0.292625] pci_bus 0000:02: resource 2 [mem 0xb0200000-0xb=
03fffff
> 64bit pref]
>
> [=C2=A0 =C2=A0 0.292628] pci_bus 0000:03: resource 4 [io=C2=A0 0x0000-0x=
0cf7 window]
>
> [=C2=A0 =C2=A0 0.292630] pci_bus 0000:03: resource 5 [io=C2=A0 0x0d00-0x=
ffff window]
>
> [=C2=A0 =C2=A0 0.292632] pci_bus 0000:03: resource 6 [mem 0x000a0000-0x0=
00bffff
> window]
>
> [=C2=A0 =C2=A0 0.292635] pci_bus 0000:03: resource 7 [mem 0x000d0000-0x0=
00dffff
> window]
>
> [=C2=A0 =C2=A0 0.292637] pci_bus 0000:03: resource 8 [mem 0xaff00000-0xf=
fffffff
> window]
>
> [=C2=A0 =C2=A0 0.292667] NET: Registered protocol family 2
>
> [=C2=A0 =C2=A0 0.292840] TCP established hash table entries: 65536 (orde=
r: 7,
> 524288 bytes)
>
> [=C2=A0 =C2=A0 0.292996] TCP bind hash table entries: 65536 (order: 8, 1=
048576 bytes)
>
> [=C2=A0 =C2=A0 0.292996] TCP: Hash tables configured (established 65536 =
bind 65536)
>
> [=C2=A0 =C2=A0 0.292996] UDP hash table entries: 4096 (order: 5, 131072 =
bytes)
>
> [=C2=A0 =C2=A0 0.292996] UDP-Lite hash table entries: 4096 (order: 5, 13=
1072 bytes)
>
> [=C2=A0 =C2=A0 0.292996] NET: Registered protocol family 1
>
> [=C2=A0 =C2=A0 0.293156] RPC: Registered named UNIX socket transport mod=
ule.
>
> [=C2=A0 =C2=A0 0.293158] RPC: Registered udp transport module.
>
> [=C2=A0 =C2=A0 0.293159] RPC: Registered tcp transport module.
>
> [=C2=A0 =C2=A0 0.293160] RPC: Registered tcp NFSv4.1 backchannel transpo=
rt module.
>
> [=C2=A0 =C2=A0 0.293173] pci 0000:00:02.0: Video device with shadowed RO=
M
>
> [=C2=A0 =C2=A0 1.393031] pci 0000:00:1a.7: EHCI: BIOS handoff failed (BI=
OS bug?)
> 01010001
>
> [=C2=A0 =C2=A0 1.393628] PCI: CLS 32 bytes, default 64
>
> [=C2=A0 =C2=A0 1.393679] Unpacking initramfs...
>
> [=C2=A0 =C2=A0 2.059003] Freeing initrd memory: 4484K
>
> [=C2=A0 =C2=A0 2.059042] PCI-DMA: Using software bounce buffering for IO=
 (SWIOTLB)
>
> [=C2=A0 =C2=A0 2.059045] software IO TLB: mapped [mem 0xabeb0000-0xafeb0=
000] (64MB)
>
> [=C2=A0 =C2=A0 2.060866] audit: initializing netlink subsys (disabled)
>
> [=C2=A0 =C2=A0 2.060882] audit: type=3D2000 audit(1656560745.059:1): ini=
tialized
>
> [=C2=A0 =C2=A0 2.069056] VFS: Disk quotas dquot_6.6.0
>
> [=C2=A0 =C2=A0 2.069111] VFS: Dquot-cache hash table entries: 512 (order=
 0, 4096
> bytes)
>
> [=C2=A0 =C2=A0 2.078991] NFS: Registering the id_resolver key type
>
> [=C2=A0 =C2=A0 2.079000] Key type id_resolver registered
>
> [=C2=A0 =C2=A0 2.079039] Key type id_legacy registered
>
> [=C2=A0 =C2=A0 2.079044] Installing knfsd (copyright (C) 1996okir@monad.=
swb.de).
>
> [=C2=A0 =C2=A0 2.082125] Key type cifs.spnego registered
>
> [=C2=A0 =C2=A0 2.082132] Key type cifs.idmap registered
>
> [=C2=A0 =C2=A0 2.082186] fuse init (API version 7.23)
>
> [=C2=A0 =C2=A0 2.084994] NET: Registered protocol family 38
>
> [=C2=A0 =C2=A0 2.085013] async_tx: api initialized (async)
>
> [=C2=A0 =C2=A0 2.085146] Block layer SCSI generic (bsg) driver version 0=
.4 loaded
> (major 251)
>
> [=C2=A0 =C2=A0 2.085216] io scheduler noop registered
>
> [=C2=A0 =C2=A0 2.085221] io scheduler deadline registered
>
> [=C2=A0 =C2=A0 2.085290] io scheduler cfq registered (default)
>
> [=C2=A0 =C2=A0 2.085374] io scheduler bfq registered
>
> [=C2=A0 =C2=A0 2.085376] BFQ I/O-scheduler: v7r11
>
> [=C2=A0 =C2=A0 2.085432] gpio_it87: no device
>
> [=C2=A0 =C2=A0 2.089082] intel_idle: does not run on family 6 model 15
>
> [=C2=A0 =C2=A0 2.089186] input: Power Button as
> /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
>
> [=C2=A0 =C2=A0 2.089190] ACPI: Power Button [PWRB]
>
> [=C2=A0 =C2=A0 2.089249] input: Power Button as
> /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
>
> [=C2=A0 =C2=A0 2.089252] ACPI: Power Button [PWRF]
>
> [=C2=A0 =C2=A0 2.089534] ioatdma: Intel(R) QuickData Technology Driver 4=
.00
>
> [=C2=A0 =C2=A0 2.089655] Serial: 8250/16550 driver, 4 ports, IRQ sharing=
 enabled
>
> [=C2=A0 =C2=A0 2.110208] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud=
 =3D 115200)
> is a 16550A
>
> [=C2=A0 =C2=A0 2.130803] 00:04: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud=
 =3D 115200)
> is a 16550A
>
> [=C2=A0 =C2=A0 2.131235] Linux agpgart interface v0.103
>
> [=C2=A0 =C2=A0 2.131278] agpgart-intel 0000:00:00.0: Intel 965Q Chipset
>
> [=C2=A0 =C2=A0 2.131297] agpgart-intel 0000:00:00.0: detected gtt size: =
524288K
> total, 262144K mappable
>
> [=C2=A0 =C2=A0 2.132491] agpgart-intel 0000:00:00.0: detected 1024K stol=
en memory
>
> [=C2=A0 =C2=A0 2.132612] agpgart-intel 0000:00:00.0: AGP aperture is 256=
M @
> 0xd0000000
>
> [=C2=A0 =C2=A0 2.132686] [drm] Initialized drm 1.1.0 20060810
>
> [=C2=A0 =C2=A0 2.133252] [drm] Memory usable by graphics device =3D 512M
>
> [=C2=A0 =C2=A0 2.133255] [drm] Replacing VGA console driver
>
> [=C2=A0 =C2=A0 2.133961] Console: switching to colour dummy device 80x25
>
> [=C2=A0 =C2=A0 2.134000] pmd_set_huge: Cannot satisfy [mem 0xd0000000-0x=
d0200000]
> with a huge-page mapping due to MTRR override.
>
> [=C2=A0 =C2=A0 2.140246] [drm] Supports vblank timestamp caching Rev 2 (=
21.10.2013).
>
> [=C2=A0 =C2=A0 2.140247] [drm] Driver supports precise vblank timestamp =
query.
>
> [=C2=A0 =C2=A0 2.148755] [drm] initialized overlay support
>
> [=C2=A0 =C2=A0 2.148812] [drm] Initialized i915 1.6.0 20151010 for 0000:=
00:02.0 on
> minor 0
>
> [=C2=A0 =C2=A0 2.152183] loop: module loaded
>
> [=C2=A0 =C2=A0 2.152451] gpio_ich: GPIO from 462 to 511 on gpio_ich
>
> [=C2=A0 =C2=A0 2.152569] mpt3sas version 12.100.00.00 loaded
>
> [=C2=A0 =C2=A0 2.154374] ahci 0000:00:1f.2: version 3.0
>
> [=C2=A0 =C2=A0 2.154564] ahci 0000:00:1f.2: SSS flag set, parallel bus s=
can disabled
>
> [=C2=A0 =C2=A0 2.154596] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 6 po=
rts 3 Gbps
> 0x3f impl SATA mode
>
> [=C2=A0 =C2=A0 2.154600] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag p=
m led clo
> pio slum part ccc ems sxs
>
> [=C2=A0 =C2=A0 2.154644] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.154685] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.156066] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.158079] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.160076] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.162081] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.167109] scsi host0: ahci
>
> [=C2=A0 =C2=A0 2.167359] scsi host1: ahci
>
> [=C2=A0 =C2=A0 2.168197] scsi host2: ahci
>
> [=C2=A0 =C2=A0 2.168304] scsi host3: ahci
>
> [=C2=A0 =C2=A0 2.169170] scsi host4: ahci
>
> [=C2=A0 =C2=A0 2.169281] scsi host5: ahci
>
> [=C2=A0 =C2=A0 2.169346] ata1: SATA max UDMA/133 abar m2048@0xff9fb800 p=
ort
> 0xff9fb900 irq 25
>
> [=C2=A0 =C2=A0 2.169348] ata2: SATA max UDMA/133 abar m2048@0xff9fb800 p=
ort
> 0xff9fb980 irq 25
>
> [=C2=A0 =C2=A0 2.169351] ata3: SATA max UDMA/133 abar m2048@0xff9fb800 p=
ort
> 0xff9fba00 irq 25
>
> [=C2=A0 =C2=A0 2.169353] ata4: SATA max UDMA/133 abar m2048@0xff9fb800 p=
ort
> 0xff9fba80 irq 25
>
> [=C2=A0 =C2=A0 2.169355] ata5: SATA max UDMA/133 abar m2048@0xff9fb800 p=
ort
> 0xff9fbb00 irq 25
>
> [=C2=A0 =C2=A0 2.169358] ata6: SATA max UDMA/133 abar m2048@0xff9fb800 p=
ort
> 0xff9fbb80 irq 25
>
> [=C2=A0 =C2=A0 2.169572] Rounding down aligned max_sectors from 42949672=
95 to
> 4294967288
>
> [=C2=A0 =C2=A0 2.169676] Ethernet Channel Bonding Driver: v3.7.1 (April =
27, 2011)
>
> [=C2=A0 =C2=A0 2.169699] tun: Universal TUN/TAP device driver, 1.6
>
> [=C2=A0 =C2=A0 2.169700] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualco=
mm.com>
>
> [=C2=A0 =C2=A0 2.169756] e1000: Intel(R) PRO/1000 Network Driver - versi=
on
> 7.3.21-k8-NAPI
>
> [=C2=A0 =C2=A0 2.169758] e1000: Copyright (c) 1999-2006 Intel Corporatio=
n.
>
> [=C2=A0 =C2=A0 2.169779] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.=
6-k
>
> [=C2=A0 =C2=A0 2.169781] e1000e: Copyright(c) 1999 - 2015 Intel Corporat=
ion.
>
> [=C2=A0 =C2=A0 2.169804] igb: Intel(R) Gigabit Ethernet Network Driver -=
 version
> 5.3.0-k
>
> [=C2=A0 =C2=A0 2.169806] igb: Copyright (c) 2007-2014 Intel Corporation.
>
> [=C2=A0 =C2=A0 2.169825] Intel(R) 10GbE PCI Express Linux Network Driver=
 - version
> 5.3.8
>
> [=C2=A0 =C2=A0 2.169827] Copyright(c) 1999 - 2018 Intel Corporation.
>
> [=C2=A0 =C2=A0 2.169874] i40e: Intel(R) 40-10 Gigabit Ethernet Connectio=
n Network
> Driver - version 2.4.10
>
> [=C2=A0 =C2=A0 2.169876] i40e: Copyright(c) 2013 - 2018 Intel Corporatio=
n.
>
> [=C2=A0 =C2=A0 2.169922] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Etherne=
t Driver
> bnx2x 1.712.30-0 (2014/02/10)
>
> [=C2=A0 =C2=A0 2.170073] sk98lin: Network Device Driver v10.93.3.3
>
> (C)Copyright 1999-2012 Marvell(R).
>
> [=C2=A0 =C2=A0 2.224898] eth0: Marvell Yukon 88E8053 Gigabit Ethernet Co=
ntroller
>
> [=C2=A0 =C2=A0 2.279721] eth1: Marvell Yukon 88E8053 Gigabit Ethernet Co=
ntroller
>
> [=C2=A0 =C2=A0 2.279746] Fusion MPT base driver 3.04.20
>
> [=C2=A0 =C2=A0 2.279747] Copyright (c) 1999-2008 LSI Corporation
>
> [=C2=A0 =C2=A0 2.279755] Fusion MPT SAS Host driver 3.04.20
>
> [=C2=A0 =C2=A0 2.279781] Fusion MPT misc device (ioctl) driver 3.04.20
>
> [=C2=A0 =C2=A0 2.279829] mptctl: Registered with Fusion MPT base driver
>
> [=C2=A0 =C2=A0 2.279831] mptctl: /dev/mptctl @ (major,minor=3D10,220)
>
> [=C2=A0 =C2=A0 2.279835] ehci_hcd: USB 2.0 'Enhanced' Host Controller (E=
HCI) Driver
>
> [=C2=A0 =C2=A0 2.279841] ehci-pci: EHCI PCI platform driver
>
> [=C2=A0 =C2=A0 2.279946] ehci-pci 0000:00:1a.7: EHCI Host Controller
>
> [=C2=A0 =C2=A0 2.279954] ehci-pci 0000:00:1a.7: new USB bus registered, =
assigned
> bus number 1
>
> [=C2=A0 =C2=A0 2.279966] ehci-pci 0000:00:1a.7: debug port 1
>
> [=C2=A0 =C2=A0 2.283872] ehci-pci 0000:00:1a.7: cache line size of 32 is=
 not
> supported
>
> [=C2=A0 =C2=A0 2.283885] ehci-pci 0000:00:1a.7: irq 18, io mem 0xff9fb40=
0
>
> [=C2=A0 =C2=A0 2.289048] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.=
00
>
> [=C2=A0 =C2=A0 2.289291] hub 1-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.289303] hub 1-0:1.0: 4 ports detected
>
> [=C2=A0 =C2=A0 2.289515] ehci-pci 0000:00:1d.7: EHCI Host Controller
>
> [=C2=A0 =C2=A0 2.289521] ehci-pci 0000:00:1d.7: new USB bus registered, =
assigned
> bus number 2
>
> [=C2=A0 =C2=A0 2.289531] ehci-pci 0000:00:1d.7: debug port 1
>
> [=C2=A0 =C2=A0 2.293424] ehci-pci 0000:00:1d.7: cache line size of 32 is=
 not
> supported
>
> [=C2=A0 =C2=A0 2.293436] ehci-pci 0000:00:1d.7: irq 23, io mem 0xff9fb00=
0
>
> [=C2=A0 =C2=A0 2.299045] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.=
00
>
> [=C2=A0 =C2=A0 2.299286] hub 2-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.299295] hub 2-0:1.0: 6 ports detected
>
> [=C2=A0 =C2=A0 2.299460] uhci_hcd: USB Universal Host Controller Interfa=
ce driver
>
> [=C2=A0 =C2=A0 2.299543] uhci_hcd 0000:00:1a.0: UHCI Host Controller
>
> [=C2=A0 =C2=A0 2.299550] uhci_hcd 0000:00:1a.0: new USB bus registered, =
assigned
> bus number 3
>
> [=C2=A0 =C2=A0 2.299556] uhci_hcd 0000:00:1a.0: detected 2 ports
>
> [=C2=A0 =C2=A0 2.299581] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000e0=
00
>
> [=C2=A0 =C2=A0 2.299774] hub 3-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.299797] hub 3-0:1.0: 2 ports detected
>
> [=C2=A0 =C2=A0 2.299951] uhci_hcd 0000:00:1a.1: UHCI Host Controller
>
> [=C2=A0 =C2=A0 2.299958] uhci_hcd 0000:00:1a.1: new USB bus registered, =
assigned
> bus number 4
>
> [=C2=A0 =C2=A0 2.299964] uhci_hcd 0000:00:1a.1: detected 2 ports
>
> [=C2=A0 =C2=A0 2.299987] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000dc=
00
>
> [=C2=A0 =C2=A0 2.300183] hub 4-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.300208] hub 4-0:1.0: 2 ports detected
>
> [=C2=A0 =C2=A0 2.300388] uhci_hcd 0000:00:1d.0: UHCI Host Controller
>
> [=C2=A0 =C2=A0 2.300395] uhci_hcd 0000:00:1d.0: new USB bus registered, =
assigned
> bus number 5
>
> [=C2=A0 =C2=A0 2.300401] uhci_hcd 0000:00:1d.0: detected 2 ports
>
> [=C2=A0 =C2=A0 2.300418] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000d8=
80
>
> [=C2=A0 =C2=A0 2.300584] hub 5-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.300607] hub 5-0:1.0: 2 ports detected
>
> [=C2=A0 =C2=A0 2.300751] uhci_hcd 0000:00:1d.1: UHCI Host Controller
>
> [=C2=A0 =C2=A0 2.300758] uhci_hcd 0000:00:1d.1: new USB bus registered, =
assigned
> bus number 6
>
> [=C2=A0 =C2=A0 2.300764] uhci_hcd 0000:00:1d.1: detected 2 ports
>
> [=C2=A0 =C2=A0 2.300787] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000d8=
00
>
> [=C2=A0 =C2=A0 2.300975] hub 6-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.301018] hub 6-0:1.0: 2 ports detected
>
> [=C2=A0 =C2=A0 2.301173] uhci_hcd 0000:00:1d.2: UHCI Host Controller
>
> [=C2=A0 =C2=A0 2.301180] uhci_hcd 0000:00:1d.2: new USB bus registered, =
assigned
> bus number 7
>
> [=C2=A0 =C2=A0 2.301186] uhci_hcd 0000:00:1d.2: detected 2 ports
>
> [=C2=A0 =C2=A0 2.301204] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000d4=
80
>
> [=C2=A0 =C2=A0 2.301385] hub 7-0:1.0: USB hub found
>
> [=C2=A0 =C2=A0 2.301413] hub 7-0:1.0: 2 ports detected
>
> [=C2=A0 =C2=A0 2.301584] usbcore: registered new interface driver cdc_ac=
m
>
> [=C2=A0 =C2=A0 2.301586] cdc_acm: USB Abstract Control Model driver for =
USB modems
> and ISDN adapters
>
> [=C2=A0 =C2=A0 2.301607] usbcore: registered new interface driver usblp
>
> [=C2=A0 =C2=A0 2.301643] usbcore: registered new interface driver usb-st=
orage
>
> [=C2=A0 =C2=A0 2.301691] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0=
x60,0x64
> irq 1
>
> [=C2=A0 =C2=A0 2.301693] i8042: PNP: PS/2 appears to have AUX port disab=
led, if
> this is incorrect please boot with i8042.nopnp
>
> [=C2=A0 =C2=A0 2.302419] serio: i8042 KBD port at 0x60,0x64 irq 1
>
> [=C2=A0 =C2=A0 2.303448] rtc_cmos 00:01: RTC can wake from S4
>
> [=C2=A0 =C2=A0 2.303609] rtc_cmos 00:01: rtc core: registered rtc_cmos a=
s rtc0
>
> [=C2=A0 =C2=A0 2.303630] rtc_cmos 00:01: alarms up to one month, y3k, 11=
4 bytes nvram
>
> [=C2=A0 =C2=A0 2.303644] i2c /dev entries driver
>
> [=C2=A0 =C2=A0 2.304042] i801_smbus 0000:00:1f.3: SMBus using PCI interr=
upt
>
> [=C2=A0 =C2=A0 2.306134] coretemp coretemp.0: Using relative temperature=
 scale!
>
> [=C2=A0 =C2=A0 2.306150] coretemp coretemp.0: Using relative temperature=
 scale!
>
> [=C2=A0 =C2=A0 2.306163] coretemp coretemp.0: Using relative temperature=
 scale!
>
> [=C2=A0 =C2=A0 2.306178] coretemp coretemp.0: Using relative temperature=
 scale!
>
> [=C2=A0 =C2=A0 2.306289] w83627ehf: Found W83627DHG chip at 0xa10
>
> [=C2=A0 =C2=A0 2.306670] md: raid0 personality registered for level 0
>
> [=C2=A0 =C2=A0 2.306674] md: raid1 personality registered for level 1
>
> [=C2=A0 =C2=A0 2.306677] md: raid10 personality registered for level 10
>
> [=C2=A0 =C2=A0 2.309405] md: raid6 personality registered for level 6
>
> [=C2=A0 =C2=A0 2.309409] md: raid5 personality registered for level 5
>
> [=C2=A0 =C2=A0 2.309411] md: raid4 personality registered for level 4
>
> [=C2=A0 =C2=A0 2.309604] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28)
> initialised:dm-devel@redhat.com
>
> [=C2=A0 =C2=A0 2.310108] usbcore: registered new interface driver btusb
>
> [=C2=A0 =C2=A0 2.310189] usbcore: registered new interface driver usbhid
>
> [=C2=A0 =C2=A0 2.310190] usbhid: USB HID core driver
>
> [=C2=A0 =C2=A0 2.310452] ip_tables: (C) 2000-2006 Netfilter Core Team
>
> [=C2=A0 =C2=A0 2.310829] NET: Registered protocol family 10
>
> [=C2=A0 =C2=A0 2.311209] NET: Registered protocol family 17
>
> [=C2=A0 =C2=A0 2.311233] 8021q: 802.1Q VLAN Support v1.8
>
> [=C2=A0 =C2=A0 2.311248] Key type dns_resolver registered
>
> [=C2=A0 =C2=A0 2.311447] readynas_io_init: initializing ReadyNAS I/O.
>
> [=C2=A0 =C2=A0 2.311449] procfs_init: initializing ReadyNAS procfs.
>
> [=C2=A0 =C2=A0 2.311455] ReadyNAS model: To Be Filled By O.E.M.
>
> [=C2=A0 =C2=A0 2.311483] pwr_button_state_init: initializing ReadyNAS PW=
R button
> state handler .
>
> [=C2=A0 =C2=A0 2.311489] button_init: initializing ReadyNAS button set.
>
> [=C2=A0 =C2=A0 2.311492] __button_init: button 'backup' gpio_ich:15 (POL=
L)
>
> [=C2=A0 =C2=A0 2.311502] __button_init: button 'reset' gpio_ich:8 (POLL)
>
> [=C2=A0 =C2=A0 2.312880] input: rn_button as /devices/virtual/input/inpu=
t3
>
> [=C2=A0 =C2=A0 2.312938] readynas_io_init: initialization successfully c=
ompleted.
>
> [=C2=A0 =C2=A0 2.313019] readynas_lcd_init: installing ReadyNAS LCD driv=
er.
>
> [=C2=A0 =C2=A0 2.313087] readynas_led_init: installing ReadyNAS LED driv=
er.
>
> [=C2=A0 =C2=A0 2.314957] register_led: registering LED "readynas:green:b=
ackup"
>
> [=C2=A0 =C2=A0 2.315213] microcode: CPU0 sig=3D0x6fb, pf=3D0x10, revisio=
n=3D0xb6
>
> [=C2=A0 =C2=A0 2.315222] microcode: CPU1 sig=3D0x6fb, pf=3D0x10, revisio=
n=3D0xb6
>
> [=C2=A0 =C2=A0 2.315231] microcode: CPU2 sig=3D0x6fb, pf=3D0x10, revisio=
n=3D0xb6
>
> [=C2=A0 =C2=A0 2.315239] microcode: CPU3 sig=3D0x6fb, pf=3D0x10, revisio=
n=3D0xb6
>
> [=C2=A0 =C2=A0 2.315305] microcode: Microcode Update Driver: v2.01
> <tigran@aivazian.fsnet.co.uk>, Peter Oruba
>
> [=C2=A0 =C2=A0 2.315516] registered taskstats version 1
>
> [=C2=A0 =C2=A0 2.318139] Btrfs loaded, crc32c=3Dcrc32c-generic
>
> [=C2=A0 =C2=A0 2.319040] hdaudio hdaudioC0D0: Unable to bind the codec
>
> [=C2=A0 =C2=A0 2.324456] rtc_cmos 00:01: setting system clock to 2022-06=
-30
> 03:45:45 UTC (1656560745)
>
> [=C2=A0 =C2=A0 2.324599] ALSA device list:
>
> [=C2=A0 =C2=A0 2.324602] =C2=A0 No soundcards found.
>
> [=C2=A0 =C2=A0 2.474033] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.474044] ata1: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>
> [=C2=A0 =C2=A0 2.474590] ata1.00: ATA-9: WDC WD30EFRX-68EUZN0, 80.00A80,=
 max UDMA/133
>
> [=C2=A0 =C2=A0 2.474594] ata1.00: 5860533168 sectors, multi 0: LBA48 NCQ=
 (depth
> 31/32), AA
>
> [=C2=A0 =C2=A0 2.475220] ata1.00: configured for UDMA/133
>
> [=C2=A0 =C2=A0 2.475452] scsi 0:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA=
=C2=A0 =C2=A0 =C2=A0 WDC WD30EFRX-68E
> 0A80 PQ: 0 ANSI: 5
>
> [=C2=A0 =C2=A0 2.475760] sd 0:0:0:0: [sda] 5860533168 512-byte logical b=
locks:
> (3.00 TB/2.73 TiB)
>
> [=C2=A0 =C2=A0 2.475763] sd 0:0:0:0: [sda] 4096-byte physical blocks
>
> [=C2=A0 =C2=A0 2.475815] sd 0:0:0:0: [sda] Write Protect is off
>
> [=C2=A0 =C2=A0 2.475819] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
>
> [=C2=A0 =C2=A0 2.475841] sd 0:0:0:0: [sda] Write cache: enabled, read ca=
che:
> enabled, doesn't support DPO or FUA
>
> [=C2=A0 =C2=A0 2.476084] sd 0:0:0:0: Attached scsi generic sg0 type 0
>
> [=C2=A0 =C2=A0 2.522051]=C2=A0 sda: sda1 sda2 sda3
>
> [=C2=A0 =C2=A0 2.522379] sd 0:0:0:0: [sda] Attached SCSI disk
>
> [=C2=A0 =C2=A0 2.601041] usb 2-1: new high-speed USB device number 2 usi=
ng ehci-pci
>
> [=C2=A0 =C2=A0 2.717033] usb-storage 2-1:1.0: USB Mass Storage device de=
tected
>
> [=C2=A0 =C2=A0 2.717115] usb-storage 2-1:1.0: Quirks match for vid 090c =
pid 1000: 400
>
> [=C2=A0 =C2=A0 2.717139] scsi host6: usb-storage 2-1:1.0
>
> [=C2=A0 =C2=A0 2.781032] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 2.781042] ata2: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>
> [=C2=A0 =C2=A0 2.795031] ata2.00: ATA-11: ST4000NE001-2MA101, EN01, max =
UDMA/133
>
> [=C2=A0 =C2=A0 2.795035] ata2.00: 7814037168 sectors, multi 16: LBA48 NC=
Q (depth
> 31/32), AA
>
> [=C2=A0 =C2=A0 2.808741] ata2.00: configured for UDMA/133
>
> [=C2=A0 =C2=A0 2.808933] scsi 1:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA=
=C2=A0 =C2=A0 =C2=A0 ST4000NE001-2MA1
> EN01 PQ: 0 ANSI: 5
>
> [=C2=A0 =C2=A0 2.809213] sd 1:0:0:0: [sdb] 7814037168 512-byte logical b=
locks:
> (4.00 TB/3.64 TiB)
>
> [=C2=A0 =C2=A0 2.809216] sd 1:0:0:0: [sdb] 4096-byte physical blocks
>
> [=C2=A0 =C2=A0 2.809267] sd 1:0:0:0: [sdb] Write Protect is off
>
> [=C2=A0 =C2=A0 2.809270] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
>
> [=C2=A0 =C2=A0 2.809292] sd 1:0:0:0: [sdb] Write cache: enabled, read ca=
che:
> enabled, doesn't support DPO or FUA
>
> [=C2=A0 =C2=A0 2.809375] sd 1:0:0:0: Attached scsi generic sg1 type 0
>
> [=C2=A0 =C2=A0 2.847249]=C2=A0 sdb: sdb1 sdb2 sdb3 sdb4
>
> [=C2=A0 =C2=A0 2.847649] sd 1:0:0:0: [sdb] Attached SCSI disk
>
> [=C2=A0 =C2=A0 3.061040] tsc: Refined TSC clocksource calibration: 2659.=
998 MHz
>
> [=C2=A0 =C2=A0 3.061046] clocksource: tsc: mask: 0xffffffffffffffff max_=
cycles:
> 0x2657a1d9103, max_idle_ns: 440795229008 ns
>
> [=C2=A0 =C2=A0 3.114032] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 3.114043] ata3: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>
> [=C2=A0 =C2=A0 3.128035] ata3.00: ATA-11: ST4000NE001-2MA101, EN01, max =
UDMA/133
>
> [=C2=A0 =C2=A0 3.128040] ata3.00: 7814037168 sectors, multi 16: LBA48 NC=
Q (depth
> 31/32), AA
>
> [=C2=A0 =C2=A0 3.141737] ata3.00: configured for UDMA/133
>
> [=C2=A0 =C2=A0 3.141929] scsi 2:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA=
=C2=A0 =C2=A0 =C2=A0 ST4000NE001-2MA1
> EN01 PQ: 0 ANSI: 5
>
> [=C2=A0 =C2=A0 3.142203] sd 2:0:0:0: [sdc] 7814037168 512-byte logical b=
locks:
> (4.00 TB/3.64 TiB)
>
> [=C2=A0 =C2=A0 3.142207] sd 2:0:0:0: [sdc] 4096-byte physical blocks
>
> [=C2=A0 =C2=A0 3.142258] sd 2:0:0:0: [sdc] Write Protect is off
>
> [=C2=A0 =C2=A0 3.142261] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>
> [=C2=A0 =C2=A0 3.142284] sd 2:0:0:0: [sdc] Write cache: enabled, read ca=
che:
> enabled, doesn't support DPO or FUA
>
> [=C2=A0 =C2=A0 3.142475] sd 2:0:0:0: Attached scsi generic sg2 type 0
>
> [=C2=A0 =C2=A0 3.185724]=C2=A0 sdc: sdc1 sdc2 sdc3 sdc4
>
> [=C2=A0 =C2=A0 3.186153] sd 2:0:0:0: [sdc] Attached SCSI disk
>
> [=C2=A0 =C2=A0 3.394037] usb 6-1: new full-speed USB device number 2 usi=
ng uhci_hcd
>
> [=C2=A0 =C2=A0 3.447032] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 3.447043] ata4: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>
> [=C2=A0 =C2=A0 3.447587] ata4.00: ATA-10: WDC WD40EFRX-68N32N0, 82.00A82=
, max
> UDMA/133
>
> [=C2=A0 =C2=A0 3.447591] ata4.00: 7814037168 sectors, multi 16: LBA48 NC=
Q (depth
> 31/32), AA
>
> [=C2=A0 =C2=A0 3.448159] ata4.00: configured for UDMA/133
>
> [=C2=A0 =C2=A0 3.448410] scsi 3:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA=
=C2=A0 =C2=A0 =C2=A0 WDC WD40EFRX-68N
> 0A82 PQ: 0 ANSI: 5
>
> [=C2=A0 =C2=A0 3.448789] sd 3:0:0:0: [sdd] 7814037168 512-byte logical b=
locks:
> (4.00 TB/3.64 TiB)
>
> [=C2=A0 =C2=A0 3.448792] sd 3:0:0:0: [sdd] 4096-byte physical blocks
>
> [=C2=A0 =C2=A0 3.448847] sd 3:0:0:0: [sdd] Write Protect is off
>
> [=C2=A0 =C2=A0 3.448850] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
>
> [=C2=A0 =C2=A0 3.448873] sd 3:0:0:0: [sdd] Write cache: enabled, read ca=
che:
> enabled, doesn't support DPO or FUA
>
> [=C2=A0 =C2=A0 3.449186] sd 3:0:0:0: Attached scsi generic sg3 type 0
>
> [=C2=A0 =C2=A0 3.493627]=C2=A0 sdd: sdd1 sdd2 sdd3 sdd4
>
> [=C2=A0 =C2=A0 3.494094] sd 3:0:0:0: [sdd] Attached SCSI disk
>
> [=C2=A0 =C2=A0 3.754033] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 3.754044] ata5: SATA link up 3.0 Gbps (SStatus 123 SContr=
ol 300)
>
> [=C2=A0 =C2=A0 3.754592] ata5.00: ATA-10: WDC WD40EFRX-68N32N0, 82.00A82=
, max
> UDMA/133
>
> [=C2=A0 =C2=A0 3.754597] ata5.00: 7814037168 sectors, multi 16: LBA48 NC=
Q (depth
> 31/32), AA
>
> [=C2=A0 =C2=A0 3.755175] ata5.00: configured for UDMA/133
>
> [=C2=A0 =C2=A0 3.755334] scsi 4:0:0:0: Direct-Access =C2=A0 =C2=A0 ATA=
=C2=A0 =C2=A0 =C2=A0 WDC WD40EFRX-68N
> 0A82 PQ: 0 ANSI: 5
>
> [=C2=A0 =C2=A0 3.755709] sd 4:0:0:0: [sde] 7814037168 512-byte logical b=
locks:
> (4.00 TB/3.64 TiB)
>
> [=C2=A0 =C2=A0 3.755712] sd 4:0:0:0: [sde] 4096-byte physical blocks
>
> [=C2=A0 =C2=A0 3.755764] sd 4:0:0:0: [sde] Write Protect is off
>
> [=C2=A0 =C2=A0 3.755767] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
>
> [=C2=A0 =C2=A0 3.755790] sd 4:0:0:0: [sde] Write cache: enabled, read ca=
che:
> enabled, doesn't support DPO or FUA
>
> [=C2=A0 =C2=A0 3.756074] sd 4:0:0:0: Attached scsi generic sg4 type 0
>
> [=C2=A0 =C2=A0 3.794711]=C2=A0 sde: sde1 sde2 sde3 sde4
>
> [=C2=A0 =C2=A0 3.795199] sd 4:0:0:0: [sde] Attached SCSI disk
>
> [=C2=A0 =C2=A0 3.834190] hid-generic 0003:051D:0002.0001: hiddev0: USB H=
ID v1.00
> Device [American Power Conversion Back-UPS RS 1500MS FW:952.e3 .D USB
> FW:e3 =C2=A0 =C2=A0 ] on usb-0000:00:1d.1-1/input0
>
> [=C2=A0 =C2=A0 4.061032] do_marvell_9170_recover: ignoring PCI device (8=
086:2821)
> at PCI#0
>
> [=C2=A0 =C2=A0 4.061044] ata6: SATA link down (SStatus 0 SControl 300)
>
> [=C2=A0 =C2=A0 4.061652] Freeing unused kernel memory: 872K
>
> [=C2=A0 =C2=A0 4.061670] clocksource: Switched to clocksource tsc
>
> [=C2=A0 =C2=A0 4.064542] vpd: loading out-of-tree module taints kernel.
>
> [=C2=A0 =C2=A0 4.064547] vpd: module license 'Proprietary' taints kernel=
.
>
> [=C2=A0 =C2=A0 4.064549] Disabling lock debugging due to kernel taint
>
> [=C2=A0 =C2=A0 4.064661] ReadyNAS VPD init
>
> [=C2=A0 =C2=A0 7.631092] nv6lcd v3.1 loaded.
>
> [=C2=A0 =C2=A0 7.727886] scsi 6:0:0:0: Direct-Access =C2=A0 =C2=A0 SMI=
=C2=A0 =C2=A0 =C2=A0 USB DISK 1100
> PQ: 0 ANSI: 0 CCS
>
> [=C2=A0 =C2=A0 7.728297] sd 6:0:0:0: Attached scsi generic sg5 type 0
>
> [=C2=A0 =C2=A0 7.728300] sd 6:0:0:0: Embedded Enclosure Device
>
> [=C2=A0 =C2=A0 7.729368] sd 6:0:0:0: Wrong diagnostic page; asked for 1 =
got 0
>
> [=C2=A0 =C2=A0 7.729747] sd 6:0:0:0: [sdf] 250880 512-byte logical block=
s: (128
> MB/123 MiB)
>
> [=C2=A0 =C2=A0 7.730615] sd 6:0:0:0: [sdf] Write Protect is off
>
> [=C2=A0 =C2=A0 7.730617] sd 6:0:0:0: [sdf] Mode Sense: 43 00 00 00
>
> [=C2=A0 =C2=A0 7.731489] sd 6:0:0:0: [sdf] No Caching mode page found
>
> [=C2=A0 =C2=A0 7.731490] sd 6:0:0:0: [sdf] Assuming drive cache: write t=
hrough
>
> [=C2=A0 =C2=A0 7.735123]=C2=A0 sdf: sdf1
>
> [=C2=A0 =C2=A0 7.737365] sd 6:0:0:0: [sdf] Attached SCSI removable disk
>
> [=C2=A0 =C2=A0 7.746853] sd 6:0:0:0: Failed to get diagnostic page 0xfff=
fffea
>
> [=C2=A0 =C2=A0 7.752858] sd 6:0:0:0: Failed to bind enclosure -19
>
> [ =C2=A0 20.336052] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
>
> [ =C2=A0 20.338949] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
>
> [ =C2=A0 21.359543] random: nonblocking pool is initialized
>
> [ =C2=A0 22.700903] eth1: network connection up using port A
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 interrupt src: =C2=A0 MSI
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 speed: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1000
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 autonegotiation: yes
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 duplex mode: =C2=A0 =C2=A0 full
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 flowctrl:=C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
one
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 role:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 slave
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 tcp offload: enabled
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 scatter-gather: enabled
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 tx-checksum: enabled
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 rx-checksum: enabled
>
> [ =C2=A0 22.700903] =C2=A0 =C2=A0 rx-polling: enabled
>
> [ =C2=A0 22.700903] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes re=
ady
>
> [ =C2=A0 22.789894] eth0: network connection up using port A
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 interrupt src: =C2=A0 MSI
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 speed: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1000
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 autonegotiation: yes
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 duplex mode: =C2=A0 =C2=A0 full
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 flowctrl:=C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
one
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 role:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 slave
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 tcp offload: enabled
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 scatter-gather: enabled
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 tx-checksum: enabled
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 rx-checksum: enabled
>
> [ =C2=A0 22.789894] =C2=A0 =C2=A0 rx-polling: enabled
>
> [ =C2=A0 22.789894] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes re=
ady
>
> [ =C2=A0 29.469809] md: md0 stopped.
>
> [ =C2=A0 29.470692] md: bind<sdb1>
>
> [ =C2=A0 29.470859] md: bind<sdc1>
>
> [ =C2=A0 29.470997] md: bind<sdd1>
>
> [ =C2=A0 29.471172] md: bind<sde1>
>
> [ =C2=A0 29.471295] md: bind<sda1>
>
> [ =C2=A0 29.473870] md/raid1:md0: active with 5 out of 5 mirrors
>
> [ =C2=A0 29.473956] md0: detected capacity change from 0 to 4290772992
>
> [ =C2=A0 29.489973] md: md1 stopped.
>
> [ =C2=A0 29.490924] md: bind<sdc2>
>
> [ =C2=A0 29.491113] md: bind<sdd2>
>
> [ =C2=A0 29.491258] md: bind<sde2>
>
> [ =C2=A0 29.491440] md: bind<sdb2>
>
> [ =C2=A0 29.491580] md: bind<sda2>
>
> [ =C2=A0 29.492180] md/raid10:md1: active with 5 out of 5 devices
>
> [ =C2=A0 29.492275] md1: detected capacity change from 0 to 1336934400
>
> [ =C2=A0 29.902166] BTRFS: device label 33ea130b:root devid 1 transid 15=
25025
> /dev/md0
>
> [ =C2=A0 29.902551] BTRFS info (device md0): has skinny extents
>
> [ =C2=A0 30.813394] systemd[1]: Failed to insert module 'kdbus': Functio=
n not
> implemented
>
> [ =C2=A0 30.816561] systemd[1]: systemd 230 running in system mode. (+PA=
M
> +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
> +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
>
> [ =C2=A0 30.816755] systemd[1]: Detected architecture x86-64.
>
> [ =C2=A0 30.821162] systemd[1]: Set hostname to <nas>.
>
> [ =C2=A0 30.961126] systemd[1]: systemd-journald-audit.socket: Cannot ad=
d
> dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
>
> [ =C2=A0 30.961195] systemd[1]: systemd-journald-audit.socket: Cannot ad=
d
> dependency job, ignoring: Unit systemd-journald-audit.socket is masked.
>
> [ =C2=A0 30.961958] systemd[1]: Set up automount Arbitrary Executable Fi=
le
> Formats File System Automount Point.
>
> [ =C2=A0 30.972146] systemd[1]: Created slice User and Session Slice.
>
> [ =C2=A0 30.978124] systemd[1]: Listening on Journal Socket (/dev/log).
>
> [ =C2=A0 30.984114] systemd[1]: Listening on udev Control Socket.
>
> [ =C2=A0 30.990121] systemd[1]: Created slice System Slice.
>
> [ =C2=A0 30.996083] systemd[1]: Reached target Slices.
>
> [ =C2=A0 31.000064] systemd[1]: Reached target Remote File Systems (Pre)=
.
>
> [ =C2=A0 31.006129] systemd[1]: Created slice system-getty.slice.
>
> [ =C2=A0 31.012137] systemd[1]: Started Forward Password Requests to Wal=
l
> Directory Watch.
>
> [ =C2=A0 31.021113] systemd[1]: Listening on /dev/initctl Compatibility =
Named
> Pipe.
>
> [ =C2=A0 31.028127] systemd[1]: Listening on Journal Socket.
>
> [ =C2=A0 31.039179] systemd[1]: Starting Create Static Device Nodes in /=
dev...
>
> [ =C2=A0 31.045658] systemd[1]: Starting Journal Service...
>
> [ =C2=A0 31.050823] systemd[1]: Starting Load Kernel Modules...
>
> [ =C2=A0 31.055736] systemd[1]: Mounting POSIX Message Queue File System=
...
>
> [ =C2=A0 31.061761] systemd[1]: Started ReadyNAS LCD splasher.
>
> [ =C2=A0 31.067831] systemd[1]: Starting ReadyNASOS system prep...
>
> [ =C2=A0 31.072107] systemd[1]: Reached target Remote File Systems.
>
> [ =C2=A0 31.078136] systemd[1]: Listening on udev Kernel Socket.
>
> [ =C2=A0 31.084181] systemd[1]: Created slice system-serial\x2dgetty.sli=
ce.
>
> [ =C2=A0 31.099501] systemd[1]: Mounting Debug File System...
>
> [ =C2=A0 31.104203] systemd[1]: Reached target Encrypted Volumes.
>
> [ =C2=A0 31.111731] systemd[1]: Starting Remount Root and Kernel File Sy=
stems...
>
> [ =C2=A0 31.118206] systemd[1]: Started Dispatch Password Requests to Co=
nsole
> Directory Watch.
>
> [ =C2=A0 31.127120] systemd[1]: Reached target Paths.
>
> [ =C2=A0 31.141394] systemd[1]: Mounted Debug File System.
>
> [ =C2=A0 31.146116] systemd[1]: Mounted POSIX Message Queue File System.
>
> [ =C2=A0 31.152322] systemd[1]: Started Load Kernel Modules.
>
> [ =C2=A0 31.158382] systemd[1]: Started Create Static Device Nodes in /d=
ev.
>
> [ =C2=A0 31.165420] systemd[1]: Started ReadyNASOS system prep.
>
> [ =C2=A0 31.171379] systemd[1]: Started Remount Root and Kernel File Sys=
tems.
>
> [ =C2=A0 31.185199] systemd[1]: Starting Load/Save Random Seed...
>
> [ =C2=A0 31.190782] systemd[1]: Starting Rebuild Hardware Database...
>
> [ =C2=A0 31.197725] systemd[1]: Starting udev Kernel Device Manager...
>
> [ =C2=A0 31.203724] systemd[1]: Starting Apply Kernel Variables...
>
> [ =C2=A0 31.208719] systemd[1]: Mounting FUSE Control File System...
>
> [ =C2=A0 31.213707] systemd[1]: Mounting Configuration File System...
>
> [ =C2=A0 31.219475] systemd[1]: Mounted FUSE Control File System.
>
> [ =C2=A0 31.225160] systemd[1]: Mounted Configuration File System.
>
> [ =C2=A0 31.231339] systemd[1]: Started Load/Save Random Seed.
>
> [ =C2=A0 31.238326] systemd[1]: Started Apply Kernel Variables.
>
> [ =C2=A0 31.306716] systemd[1]: Started udev Kernel Device Manager.
>
> [ =C2=A0 31.322191] systemd[1]: Starting MD arrays...
>
> [ =C2=A0 31.487875] systemd[1]: Started Journal Service.
>
> [ =C2=A0 31.520876] systemd-journald[1420]: Received request to flush ru=
ntime
> journal from PID 1
>
> [ =C2=A0 32.202932] md: md127 stopped.
>
> [ =C2=A0 32.203990] md: bind<sdb3>
>
> [ =C2=A0 32.204155] md: bind<sdc3>
>
> [ =C2=A0 32.204286] md: bind<sdd3>
>
> [ =C2=A0 32.204422] md: bind<sde3>
>
> [ =C2=A0 32.204560] md: bind<sda3>
>
> [ =C2=A0 32.217830] md/raid:md127: device sda3 operational as raid disk =
0
>
> [ =C2=A0 32.217835] md/raid:md127: device sde3 operational as raid disk =
4
>
> [ =C2=A0 32.217838] md/raid:md127: device sdd3 operational as raid disk =
3
>
> [ =C2=A0 32.217841] md/raid:md127: device sdc3 operational as raid disk =
2
>
> [ =C2=A0 32.217844] md/raid:md127: device sdb3 operational as raid disk =
1
>
> [ =C2=A0 32.218402] md/raid:md127: allocated 5418kB
>
> [ =C2=A0 32.218445] md/raid:md127: raid level 5 active with 5 out of 5
> devices, algorithm 2
>
> [ =C2=A0 32.218449] RAID conf printout:
>
> [ =C2=A0 32.218451]=C2=A0 --- level:5 rd:5 wd:5
>
> [ =C2=A0 32.218454]=C2=A0 disk 0, o:1, dev:sda3
>
> [ =C2=A0 32.218457]=C2=A0 disk 1, o:1, dev:sdb3
>
> [ =C2=A0 32.218460]=C2=A0 disk 2, o:1, dev:sdc3
>
> [ =C2=A0 32.218463]=C2=A0 disk 3, o:1, dev:sdd3
>
> [ =C2=A0 32.218471]=C2=A0 disk 4, o:1, dev:sde3
>
> [ =C2=A0 32.218580] md127: detected capacity change from 0 to 1198250734=
3872
>
> [ =C2=A0 32.390150] Adding 1305596k swap on /dev/md1.=C2=A0 Priority:-1 =
extents:1
> across:1305596k
>
> [ =C2=A0 32.568400] BTRFS: device label 33ea130b:data devid 1 transid 32=
40438
> /dev/md127
>
> [ =C2=A0 32.795849] md: md126 stopped.
>
> [ =C2=A0 32.796664] md: bind<sde4>
>
> [ =C2=A0 32.796784] md: bind<sdc4>
>
> [ =C2=A0 32.796900] md: bind<sdb4>
>
> [ =C2=A0 32.797136] md: bind<sdd4>
>
> [ =C2=A0 32.797897] md/raid:md126: device sdd4 operational as raid disk =
0
>
> [ =C2=A0 32.797901] md/raid:md126: device sdb4 operational as raid disk =
3
>
> [ =C2=A0 32.797903] md/raid:md126: device sdc4 operational as raid disk =
2
>
> [ =C2=A0 32.797904] md/raid:md126: device sde4 operational as raid disk =
1
>
> [ =C2=A0 32.798455] md/raid:md126: allocated 4362kB
>
> [ =C2=A0 32.798760] md/raid:md126: raid level 5 active with 4 out of 4
> devices, algorithm 2
>
> [ =C2=A0 32.798762] RAID conf printout:
>
> [ =C2=A0 32.798764]=C2=A0 --- level:5 rd:4 wd:4
>
> [ =C2=A0 32.798765]=C2=A0 disk 0, o:1, dev:sdd4
>
> [ =C2=A0 32.798767]=C2=A0 disk 1, o:1, dev:sde4
>
> [ =C2=A0 32.798769]=C2=A0 disk 2, o:1, dev:sdc4
>
> [ =C2=A0 32.798771]=C2=A0 disk 3, o:1, dev:sdb4
>
> [ =C2=A0 32.798854] md126: detected capacity change from 0 to 3000179490=
816
>
> [ =C2=A0 32.905771] BTRFS: device label 33ea130b:data devid 2 transid 32=
40438
> /dev/md126
>
> [ =C2=A0 33.189453] BTRFS info (device md126): has skinny extents
>
> [ =C2=A0 35.277853] BTRFS critical (device md126): corrupt node: root=3D=
1
> block=3D13404298215424 slot=3D307, unaligned pointer, have
> 12567101254720864896 should be aligned to 4096
>
> [ =C2=A0 35.298299] BTRFS critical (device md126): corrupt node: root=3D=
1
> block=3D13404298215424 slot=3D307, unaligned pointer, have
> 12567101254720864896 should be aligned to 4096
>
> [ =C2=A0 35.298341] BTRFS error (device md126): failed to read block gro=
ups: -5
>
> [ =C2=A0 35.299177] BTRFS error (device md126): failed to read block gro=
ups: -17
>
> [ =C2=A0 35.379488] BTRFS error (device md126): failed to read block gro=
ups: -17
>
> [ =C2=A0 35.445317] BTRFS error (device md126): failed to read block gro=
ups: -17
>
> [ =C2=A0 35.708498] BTRFS error (device md126): failed to read block gro=
ups: -17
>
> [ =C2=A0 35.729143] BTRFS error (device md126): open_ctree failed
>
> [ =C2=A0 36.067098] bonding: bond0 is being created...
>
> [ =C2=A0 36.072256] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
>
> [ =C2=A0 36.072260] 8021q: adding VLAN 0 to HW filter on device bond0
>
> [ =C2=A0 36.072653] bond0: Setting min links value to 1
>
> [ =C2=A0 36.072744] bond0: Setting MII monitoring interval to 100
>
> [ =C2=A0 36.072788] bond0: Setting xmit hash policy to layer2 (0)
>
> [ =C2=A0 36.075361] eth0: network connection down
>
> [ =C2=A0 36.078790] bond0: Adding slave eth0
>
> [ =C2=A0 36.082048] bond0: Enslaving eth0 as a backup interface with a d=
own link
>
> [ =C2=A0 36.095452] eth1: network connection down
>
> [ =C2=A0 36.100443] bond0: Adding slave eth1
>
> [ =C2=A0 36.103517] bond0: Enslaving eth1 as a backup interface with a d=
own link
>
> [ =C2=A0 36.103741] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
>
> [ =C2=A0 36.103744] 8021q: adding VLAN 0 to HW filter on device bond0
>
> [ =C2=A0 36.104163] IPv6: ADDRCONF(NETDEV_UP): bond0: link is not ready
>
> [ =C2=A0 36.104165] 8021q: adding VLAN 0 to HW filter on device bond0
>
> [ =C2=A0 39.250788] eth0: network connection up using port A
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 interrupt src: =C2=A0 MSI
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 speed: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1000
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 autonegotiation: yes
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 duplex mode: =C2=A0 =C2=A0 full
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 flowctrl:=C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
one
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 role:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 slave
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 tcp offload: enabled
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 scatter-gather: enabled
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 tx-checksum: enabled
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 rx-checksum: enabled
>
> [ =C2=A0 39.250788] =C2=A0 =C2=A0 rx-polling: enabled
>
> [ =C2=A0 39.310027] bond0: link status definitely up for interface eth0,=
 1000
> Mbps full duplex
>
> [ =C2=A0 39.310036] bond0: now running without any active interface!
>
> [ =C2=A0 39.310166] IPv6: ADDRCONF(NETDEV_CHANGE): bond0: link becomes r=
eady
>
> [ =C2=A0 39.377955] eth1: network connection up using port A
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 interrupt src: =C2=A0 MSI
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 speed: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 1000
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 autonegotiation: yes
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 duplex mode: =C2=A0 =C2=A0 full
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 flowctrl:=C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
one
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 role:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 slave
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 tcp offload: enabled
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 scatter-gather: enabled
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 tx-checksum: enabled
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 rx-checksum: enabled
>
> [ =C2=A0 39.377955] =C2=A0 =C2=A0 rx-polling: enabled
>
> [ =C2=A0 39.410041] bond0: link status definitely up for interface eth1,=
 1000
> Mbps full duplex
>
