Return-Path: <linux-btrfs+bounces-4470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB958AC549
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 09:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB0E282BD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Apr 2024 07:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B1A4CE0F;
	Mon, 22 Apr 2024 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Fas+PG21"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD84482FF
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Apr 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770172; cv=none; b=WNOlVATvSyO19NotwQ828/RG7pOOApC7fosBw286geVCyLuMD61j7BAk78uTBBoG7fDlKbpPyOajAQlmLS7/evaWVt+VevVxVeJcy/1whS79Ae31Q91Lai9gz5lKEFGxRTON6UFsAx3fcwmX1lyZrLbhsRU0gOPoftr0Gq5Q16M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770172; c=relaxed/simple;
	bh=L6R+wgB+toPLuRufpV0A9DMXqFK67XNwB8MR8ZavXZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDDeQ9AXgZsZl2iIQFJnaYuyG5AVM4mbQPBOZCmRbqxUtI24KtAVYG+iN4mrdPpKJOV4WA89vyN3iz1p4ypEoKH64v/1qsBL0xmmQxgj29pprjD95D/2cFyuulRr/UKVI7horrTNCPx555fk6s04lObvkpFFopoFGgclTjVzMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Fas+PG21; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713770156; x=1714374956; i=quwenruo.btrfs@gmx.com;
	bh=uoE5L2twvooST21nx5EdbMerKIDYDBL5aPVi9PhcJ9o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fas+PG21+wR6K2nV2AAII/IDQx2/MlYFVAa6AcIZMSISVHh12x08/frAccTWhktK
	 Tu0TxxGXGNOhKNTOYX41SoJJLjgF8n65oY80PVraDNCaMCyz9Dpe+XpqhfbZ3dmPM
	 LSZuQqWrEoYdWCkGbV0TxwsoywGcIXi39JLhvRws0qmBcSduEDNz1rS1C42bfI1Va
	 K19ausJKSQ8qS0kpExZ9GWyaj2PnWfJJ+j7NTbhlm9mp4Iq9sy4hfFnYPq6Pw/BrZ
	 bREURaoLNs3IhfPfhfv1cAYfBIAkuOemOAQ3LzvEPmbPXfiftdo7y6SJAxeDVLlRh
	 P/3GoBb6524t/IIwIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMbU-1rtLqx1Gzs-00EPJs; Mon, 22
 Apr 2024 09:15:56 +0200
Message-ID: <995dd168-8e1e-4b99-896c-ece4dc88d6e9@gmx.com>
Date: Mon, 22 Apr 2024 16:45:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS use-after-free bug at free_extent_buffer_internal
To: Sachi King <nakato@nakato.io>, u-boot@lists.denx.de
Cc: kabel@kernel.org, wqu@suse.com, linux-btrfs@vger.kernel.org
References: <3281192.oiGErgHkdL@youmu>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <3281192.oiGErgHkdL@youmu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nb2no6jzXdD1t4WOrACtoyqvjuXQmlgmRi0WQUn44IqZTwd/7n0
 GmGwtECFOTcrXdvQdoO+dw/sQ5zXKm15I/QBjNryXID1sEO0qIV9YFcyA30ZiMmAp71e+R4
 Rd+0slrPRZ7hLzuvwKj6YEpUXC/5qX/atwtfBTfldA5s3vbJPjMHyI9doCYDdFigE1n/1Km
 R+1uyjx7g/xSYuEAQidWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p2to0LcfYCI=;DMzPj2j+ACq5nbAPCXZlIi2ePCm
 irxd5sLAwjYARnBNXv4tt9wCH97pxJiqaEVs0uMfCCUKdFHjmcyk6/nMsFjWixEpchnEQsCCH
 zxmJ1UhqnwPVrOhckR4d61PTP3gREbpBx1CkVD4xTcNIBWIWZLnVwCceyXIwMZ3ncsNBA1syP
 pGqLrNj2sLVMbz3j7VPwwnDNGuTYjx8oN7/hShMcBqfzVjgK1ppXpwJiDdzBsNPSPRmKDsXul
 MdMVuGnQ6Vy5ONqw5f2cc2E54QvA1+dm3BduLjt7/Ouir2c5v9YUxaa1qcZLrBU9CCFl0bRvZ
 ha9HH+8q/Pd2XPaWCJ3bDD8XShJjCMSqaSUHFRVgwbFc9PUknmQxj06GBS2M1b2BOYggxvm9Q
 nxssDAymtTKf/vqf4E1PHXa2VMEF15lobDmk1MjOJLVzSC6O/Ex1ofBuKGfo3W1m84RLAEDfm
 iCXd1sokm/QQ8y04SxKmbjiW9m+f4HzpM9jyIy8/kPV1hyczvvbO/FDubYWk7JOygep8zZCET
 zApIyhSOxKg19YDpRRem9C3sdc4aZF51AbGu4GTB4V96Hng86a+LDUxSLkEbiVaHinzWBD2Ca
 YdtrBXKN0zm3qCqkH+arQgVpq1h/xd22kh3Y8n4gvD+EcywOakQ6tfDdiI+BLt+ujN1cbz2z8
 WAoYQVTsKUAcW8uahFm2AabNiuXZt6P5jobYpJYpOTzXyHypaJIZDhuxLmfN9gWjCdyZI/QBZ
 xv9z+CltOGIkdnTU4rmpUowZ+JfgEt64tIJldH6wW3abN898Yo63Q3wi6TsHtIQg2+8mczySt
 UOHvJvDxs1+PuxOpLpsWJf9juvmBjRM8k+IU0iPK7WZ04=



=E5=9C=A8 2024/4/22 16:07, Sachi King =E5=86=99=E9=81=93:
> Hi,
>
> I've hit a bug with u-boot on my BTRFS filesystem, and I'm fairly certai=
n
> it's a bug and not a corruption issue.
>
> A bit of history on the filesystem.  It is a fairly new filesystem as it=
 was
> being used to give me access to test a wayland application on a
> Raspberry Pi.  The filesystem was about 3 days old when I hit the bug, a=
nd
> I'm fairly certain it never had an unclean shutdown.  I have checked the
> filesystem with "btrfs check" which has found no errors.  The filesystem
> mounts on Linux and is functional.
>
>> # btrfs check --check-data-csum /dev/sda2
>> Opening filesystem to check...
>> Checking filesystem on /dev/sda2
>> UUID: 18db6211-ac36-42c1-a22f-5e15e1486e0d
>> [1/7] checking root items
>> [2/7] checking extents
>> [3/7] checking free space tree
>> [4/7] checking fs roots
>> [5/7] checking csums against data
>> [6/7] checking root refs
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 5070573568 bytes used, no error found
>> total csum bytes: 4451620
>> total tree bytes: 370458624
>> total fs tree bytes: 353124352
>> total extent tree bytes: 10010624
>> btree space waste bytes: 62303284
>> file data blocks allocated: 6786519040
>>   referenced 6328619008

Since btrfs check reports no error, the fs must be valid.

But considering how new it is, it may be related to some new features
not properly implemented in Uboot.

Is it possible to provide the whole binary dump of the fs?

>
>
> I've made an image of the filesystem so I could reproduce the bug in an
> environment that doesn't require the physical SBC, and have reproduced
> the issue using the head of the master branch with "qemu-x86_64_defconfi=
g".
>
> My testing qemu was produced with the following:
>> # make qemu-x86_64_defconfig
>> # cat << EOF >> .config
>> CONFIG_AUTOBOOT=3Dy
>> CONFIG_BOOTDELAY=3D1
>> CONFIG_USE_BOOTCOMMAND=3Dy
>> CONFIG_BOOTSTD_DEFAULTS=3Dy
>> CONFIG_BOOTSTD_FULL=3Dy
>> CONFIG_CMD_BOOTFLOW_FULL=3Dy
>> CONFIG_BOOTCOMMAND=3D"bootflow scan -lb"
>> CONFIG_ENV_IS_NOWHERE=3Dy
>> CONFIG_LZ4=3Dy
>> CONFIG_BZIP2=3Dy
>> CONFIG_ZSTD=3Dy
>> CONFIG_FS_BTRFS=3Dy
>> CONFIG_CMD_BTRFS=3Dy
>> CONFIG_GZIP=3Dy
>> CONFIG_DEVICE_TREE_INCLUDES=3D"bootstd.dtsi"
>> EOF
>> # make -j24
>
> bootstd.dtsi is placed at "arch/x86/dts/bootstd.dtsi" and contains:
>> / {
>>          bootstd {
>>                  compatible =3D "u-boot,boot-std";
>>                  filename-prefixes =3D "/@boot/", "/boot/", "/";
>>                  bootdev-order =3D "scsi";
>>                  extlinux {
>>                          compatible =3D "u-boot,extlinux";
>>                  };
>>          };
>> };
>
>
> The VM was run with
>> qemu-system-x86_64 -bios u-boot.rom -nographic -M q35 -action reboot=3D=
shutdown -drive file=3D/mnt/dbg/u-boot-debug.img
>
> The error message I recive on boot is
>> BUG at fs/btrfs/extent-io.c:629/free_extent_buffer_internal()!
>> BUG!
>> resetting ...
>
>
> I added a print statement to free_extent_buffer_internal that prints the
> start address of the extent_buffer as I'm not sure what to be looking fo=
r
> here.  This print statement is before the decrement.
>> printf("free_extent_buffer_internal: eb->start[%llx] eb->refs[%i]\n", e=
b->start, eb->refs);
>
> The last message before the crash reported eb->start to be "0", with 0 r=
efs.
>> free_extent_buffer_internal: eb->start[0] eb->refs[0]
>
> The extent at 0 struck me as odd, so I tried commenting out the freeing,=
 by
> removing the call to free_extent_buffer_final, and this resulted in boot=
flow
> succeeding and showing me the boot menu, which suprised me.
> I expected to see the bug reproduce itself, with refs being zero, but eb=
->start
> pointing somewhere valid, but I instead got a valid address with refs at=
 2.
>
> I'm assuming that the order free_extent_buffer_internal is called is
> deterministic, so by counting the print outputs the line that prior held
> the extent_buffer with a 0 start was replaced with:
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>
> Interestingly, as can be seen in the full logs with my included print
> messages, 249c000 is being used just before this, with a ref count of
> 2.  249c000 does appear to reach a point where it should have been freed
> in the past, before it gets used again as seen in both logs.
>
> The failing boot log:
>> U-Boot SPL 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:32:37 +100=
0)
>> Trying to boot from SPI
>> Jumping to 64-bit U-Boot: Note many features are missing
>>
>>
>> U-Boot 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:32:37 +1000)
>>
>> CPU:   QEMU Virtual CPU version 2.5+
>> DRAM:  128 MiB
>> Core:  13 devices, 13 uclasses, devicetree: separate
>> Loading Environment from nowhere... OK
>> Model: QEMU x86 (I440FX)
>> Net:   e1000: 00:00:00:00:00:00
>>
>> Error: e1000#0 No valid MAC address found.
>>        eth_initialize() No ethernet found.
>>
>>
>> Hit any key to stop autoboot:  0
>> Scanning for bootflows in all bootdevs
>> Seq  Method       State   Uclass    Part  Name                      Fil=
ename
>> ---  -----------  ------  --------  ----  ------------------------  ---=
-------------
>> scanning bus for devices...
>> Target spinup took 0 ms.
>> SATA link 1 timeout.
>> Target spinup took 0 ms.
>> SATA link 3 timeout.
>> SATA link 4 timeout.
>> SATA link 5 timeout.
>> AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
>> flags: 64bit ncq only
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>>    Device 0: (0:0) Vendor: ATA Prod.: QEMU HARDDISK Rev: 2.5+
>>              Type: Hard Disk
>>              Capacity: 58680.0 MB =3D 57.3 GB (120176640 x 512)
>> timeout exit!
>> Scanning bootdev 'ahci_scsi.id0lun0.bootdev':
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[0] eb->refs[0]
>> BUG at fs/btrfs/extent-io.c:626/free_extent_buffer_internal()!

The eb[0] seems very weird.
Even for superblock reading, we got eb at 64K, and every eb should have
at least one ref at creation time.

So this indeed looks like the direct cause.
But without a full call trace (is it possible inside U-boot runtime?), I
do not have an immediate clue.

Thanks,
Qu

>> BUG!
>> resetting ...
>
> The succeeding log with the removed freeing:
>> U-Boot SPL 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:38:25 +100=
0)
>> Trying to boot from SPI
>> Jumping to 64-bit U-Boot: Note many features are missing
>>
>>
>> U-Boot 2024.04-00949-g1dd659fd62-dirty (Apr 22 2024 - 11:38:25 +1000)
>>
>> CPU:   QEMU Virtual CPU version 2.5+
>> DRAM:  128 MiB
>> Core:  13 devices, 13 uclasses, devicetree: separate
>> Loading Environment from nowhere... OK
>> Model: QEMU x86 (I440FX)
>> Net:   e1000: 00:00:00:00:00:00
>>
>> Error: e1000#0 No valid MAC address found.
>>        eth_initialize() No ethernet found.
>>
>>
>> Hit any key to stop autoboot:  0
>> Scanning for bootflows in all bootdevs
>> Seq  Method       State   Uclass    Part  Name                      Fil=
ename
>> ---  -----------  ------  --------  ----  ------------------------  ---=
-------------
>> scanning bus for devices...
>> Target spinup took 0 ms.
>> SATA link 1 timeout.
>> Target spinup took 0 ms.
>> SATA link 3 timeout.
>> SATA link 4 timeout.
>> SATA link 5 timeout.
>> AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
>> flags: 64bit ncq only
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>>    Device 0: (0:0) Vendor: ATA Prod.: QEMU HARDDISK Rev: 2.5+
>>              Type: Hard Disk
>>              Capacity: 58680.0 MB =3D 57.3 GB (120176640 x 512)
>> timeout exit!
>> Scanning bootdev 'ahci_scsi.id0lun0.bootdev':
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1548000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[150c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[154c000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[24a4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[249c000] eb->refs[2]
>> free_extent_buffer_internal: eb->start[2490000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[6de0000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[28f4000] eb->refs[1]
>> free_extent_buffer_internal: eb->start[1544000] eb->refs[1]
>>    0  extlinux     ready   scsi         2  ahci_scsi.id0lun0.bootdev /@=
boot/extlinux/extlinux.conf
>> ** Booting bootflow 'ahci_scsi.id0lun0.bootdev.part_2' with extlinux
>> ------------------------------------------------------------
>> 1:      NixOS - Default
>> 2:      NixOS - Configuration 5 (2024-03-04 11:00 - 24.05.20240205.faf9=
12b)
>> 3:      NixOS - Configuration 4 (2024-03-02 15:05 - 24.05.20240205.faf9=
12b)
>> 4:      NixOS - Configuration 3 (2024-03-02 14:26 - 24.05.20240205.faf9=
12b)
>> 5:      NixOS - Configuration 2 (2024-03-02 14:06 - 24.05.20240205.faf9=
12b)
>> 6:      NixOS - Configuration 1 (1970-01-01 10:00 - 24.05.20240205.faf9=
12b)
>> Enter choice: 1:        NixOS - Default
>> Retrieving file: /@boot/extlinux/../nixos/gq8jsgxnhq2wvsjrni3cjw1wb5540=
wjw-linux-6.1.63-stable_20231123-Image
>> free_extent_buffer_internal: eb->start[10000] eb->refs[1]
>
>
> I'm not sure where to go from here with the bug, so I'm hoping for some
> help in tracking it down so it can be fixed.
>
> Thanks,
> Sachi
>
>
>

