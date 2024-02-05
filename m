Return-Path: <linux-btrfs+bounces-2100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A0D8494E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 08:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C53B1C21E91
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146311184;
	Mon,  5 Feb 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lPE3QdAU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B56010A1E
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707119802; cv=none; b=Wfzdl1BWOG5DGtotJu0nGrrlp8ZEz7gEh9MnnzviwLa+dXEezlVjCan1d0yG7hHxSJ5nE3Vcg8badm+6Bb6N+R3KlHKRwEdmoEfkDC0rnXXLYNm38AxAjoCrVbZJz6Np2cVMLDeVTVEmMRYlqAaJXWL6K/8h+p16BdchYszcW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707119802; c=relaxed/simple;
	bh=KXAaqz/3cri6YhFj/o4Eb4sd7JKkk/h15Nc1KgTvVLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lx1dTT/FWEyRMIxACm7A84/ksjyZlyriDdPvDga6fRLdaoiDuC+p4/oDu91DgfMYe8iXL5zL8ePQ8trUBkPLrisyqagFNXkHxhlgQ0VL/FDC7wJDWOruFoeCqVCnZATtvLZdLushWGQILW3Loeb8nWlQP6LUxMWEGglQW2hfRys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lPE3QdAU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707119792; x=1707724592; i=quwenruo.btrfs@gmx.com;
	bh=KXAaqz/3cri6YhFj/o4Eb4sd7JKkk/h15Nc1KgTvVLs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=lPE3QdAU/SrOseUFey4ZA+ViHmh/9Nsrm5qNoxHID+PmlaSpw9XGCaPUpiySJBFk
	 CnT6PeH8tGAlCA+x6sFyFVJc/BiiCs+dQ5dm031SMUECywENkXVdWWH3bO0BvaYZ5
	 6QDrQfouC3GJGmO0idXO6+UJ1xrW0wRj5DHpAkR4trnStFkV/uBJl15TDiDu6IXza
	 8Mp02uRyZAWoXbGKPmvj0J++AJnCoWUP99e+Upy7k06Ol/QL0G7/clBzcaRqh70QB
	 cere4R6z2lG+7QgaLB37YlB0XNpwzn4xnMR7ms8hYtKPxoEjOFH7WWKuQC3AznVGe
	 H7qJPo8YCPXV2qUS/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Ml6mE-1r9hYp3UQ0-00lWjm; Mon, 05
 Feb 2024 08:56:32 +0100
Message-ID: <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
Date: Mon, 5 Feb 2024 18:26:28 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Content-Language: en-US
To: =?UTF-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Cc: linux-btrfs@vger.kernel.org
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
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
In-Reply-To: <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mvUFjXeCrgrDnGK81AlaXoV5ueYxSEHVrLeaP9/HOGoit2bafw3
 eSbNpxW734+5XEnDWjJsKm0TjSfo6DRb25ECWpSv7h2MYkPgJIXQSKn4r5rnaOemOA/vyNb
 GJxTkumxSyuXDeiGohqpsvcP3FKhg5QpYuzgD8MCp8WkQwvxkojGJBLhe8IVV3GnY9snOfw
 ILqqeilM5Hr8AjRj33cdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gs9g0vdfu0Y=;1PadViSRgH7jQyfPP81D0e3ZwIX
 6NHDMdh9aIrMoaAsLrBUMC2rwwpU076P1g7NayojWLJNWW+JNolskKKzjO69ujofz7YOv/ahQ
 JV1HGUXwF2wWpJ77/yWeHJwM1pO8+YsRp91J5Gm5zhxWNPcq1r6e88fC3iBuDA3dBpjrq25zT
 wHng1PWomah2vNcjc6hYY1ArkWI61DAGENzWlI7LC3CwWQHSU6Gg/u37q3gswRKdB5Y3nQISu
 rcqkgZrnc6ACWoD8xuK6tAR6+XZX/d4oVe/6YKBocsM3ellNr+gbTzEw3hgUojzY3E89IJsq6
 k+g+H2NkQiBQxMsrjANclw9J9J6DWHebkhRNu1KjC4SZ4YEmlazqcSkTc6cnRcuD7mvIbS/KY
 q46LvHA5VY73VuldnvNc1ichTHbc/MWy91zNc9v+KG3kU7FOcDazJcFN6+mvlH9pg69uIzgiX
 tLz/eXrHhWEjJpPMG/OdCGdbxnG4IhbUJrpqRmxxrUmadIxaZYNFQrlWisx9t8yyg4Cbi84VV
 OtP3IV/FPn+43bR1b96b+YaxN9kN+y7HI2eZOX9oEsBOVNrIsOcL5jPXQHjSZisvsOhLpcz6Q
 egWYjIvOAXluUaZpgGEWeRwYvYujGxOXDeuhyw4Js+L+5+U3xMytRPq0xeHP7CdxUDKp8hX4K
 80f9CdrNZviWGG5oF6sDqZ1lLV+UjED3d54OXGTbDMDYaZ5VM5AuNQaCYcQvWx4uC2FFILUJo
 llofQZhuTuLY/SBCXtQ8dzHhr1AmLAEg9R4mEZVp9eheUDMZJpNTtxoo8VwY294mwyd2A2tZ0
 QOCXKvCxa2vop3IUSDl1iSJb6rskKQxw//kOxpzlH0s+8=



On 2024/2/5 17:16, =E9=9F=A9=E4=BA=8E=E6=83=9F wrote:
>  > Any clue how can I purchase such disks?
>  > And what's the interface? (NVME? SATA? U2?)
>
> I purchased these on used market app called Xianyu(=E9=97=B2=E9=B1=BC) w=
hich may be
> difficult for users
> outside China mainland. And its supply is extremely unstable.
>
> Its interface is SATA. Mine model is HSH721414ALN6M0. Spec link:
> https://documents.westerndigital.com/content/dam/doc-library/en_us/asset=
s/public/western-digital/product/data-center-drives/ultrastar-dc-hc600-ser=
ies/data-sheet-ultrastar-dc-hc620.pdf
>
>  > And have you tried emulated zoned device (no matter if it's qemu zone=
d
>  > emulation or nbd or whatever) with 4K sectorsize?
>
> Have tried on my loongson with this script from
> https://github.com/Rongronggg9
>
>  > ./nullb setup
>  > ./nullb create -s 4096 -z 256
>  > ./nullb create -s 4096 -z 256
>  > ./nullb ls
>  > mkfs.btrfs -s 16k /dev/nullb0
>  > mount /dev/nullb0 /mnt/tmp
>  > btrfs device add /dev/nullb1 /mnt/tmp
>  > btrfs balance start -dconvert=3Draid1 -mconvert=3Draid1 /mnt/tmp

Just want to be sure, for your case, you're doing the same mkfs (4K
sectorsize) on the physical disk, then add a new disk, and finally
balanced the fs?

IIRC the balance itself should not succeed, no matter if it's emulated
or real disks, as data RAID1 requires zoned RST support.

If that's the case, it looks like some checks got bypassed, and one copy
of the raid1 bbio doesn't get its content setup properly thus leading to
the NULL pointer dereference.

Anyway, I'll try to reproduce it next week locally, or I'll ask for the
access to your loonson system soon.

Thanks,
Qu
>
> Whether it is 4k or 16k, kernel will have "zoned: data raid1 needs
> raid-stripe-tree"
>
>  > If you can provide some help, it would super great.
>
> Sure. I can provide access to my loongson w/ dual HC620 if you wish. You
> can contact me on t.me/hanyuwei70.
>
>  > can you provide the faddr2line output for
>  > "btrfs_finish_ordered_extent+0x24"?
>
> I have recompiled kernel to add DEBUG_INFO. Here's result.
>
> [hyw@loong3a6 linux-6.7.2]$ ./scripts/faddr2line fs/btrfs/btrfs.ko
> btrfs_finish_ordered_extent+0x24
> btrfs_finish_ordered_extent+0x24/0xc0:
> spinlock_check at
> /home/hyw/kernel_build/linux-6.7.2/./include/linux/spinlock.h:326
> (inlined by) btrfs_finish_ordered_extent at
> /home/hyw/kernel_build/linux-6.7.2/fs/btrfs/ordered-data.c:381
>
> =E5=9C=A8 2024/2/5 13:22, Qu Wenruo =E5=86=99=E9=81=93:
>>
>>
>> On 2024/2/4 20:04, =E9=9F=A9=E4=BA=8E=E6=83=9F wrote:
>>> =C2=A0> ie. mkfs.btrfs --sectorsize 16k. it works! I can sync without =
any
>>> problem now. I will continue to monitor if any issues occurred. seems
>>> like I can only use these disks on my loongson machine for a while.
>>
>> Any clue how can I purchase such disks?
>> And what's the interface? (NVME? SATA? U2?)
>>
>> I can go try qemu zoned nvme on my aarch64 host, but so far the SoC is
>> offline (won't be online until this weekend).
>>
>> And have you tried emulated zoned device (no matter if it's qemu zoned
>> emulation or nbd or whatever) with 4K sectorsize?
>>
>>
>> So far we don't have good enough coverage with zoned on subpage, I have
>> the physical hardware of aarch64 (and VMs with different page size), bu=
t
>> I don't have any zoned devices.
>>
>> If you can provide some help, it would super great.
>>
>>>
>>> Is there any progress or proposed patch for subpage layer fix?
>>>
>>> =E5=9C=A8 2024/2/4 6:15, David Sterba =E5=86=99=E9=81=93:
>>>> On Sat, Feb 03, 2024 at 06:18:09PM +0800, =E9=9F=A9=E4=BA=8E=E6=83=9F=
 wrote:
>>>>> When mkfs, I intentionally used "-s 4k" for better compatibility.
>>>>> And /sys/fs/btrfs/features/supported_sectorsizes is 4096 16384, whic=
h
>>>>> should be ok.
>>>>>
>>>>> btrfs-progs is 6.6.2-1, is this related?
>>>> No, this is something in kernel. You could test if same page and sect=
or
>>>> size works, ie. mkfs.btrfs --sectorsize 16k. This avoids using the
>>>> subpage layer that transalates the 4k sectors <-> 16k pages. This has
>>>> the known interoperability issues with different page and sector size=
s
>>>> but if it does not affect you, you can use it.
>>>>
>>
>> Another thing is, I don't know how the loongson kernel dump works, but
>> can you provide the faddr2line output for
>> "btrfs_finish_ordered_extent+0x24"?
>>
>> It looks like ordered->inode is not properly initialized but I'm not
>> 100% sure.
>>
>> Thanks,
>> Qu
>>

