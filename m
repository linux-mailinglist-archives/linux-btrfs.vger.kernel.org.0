Return-Path: <linux-btrfs+bounces-2125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82384A814
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 22:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA84CB24837
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 21:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55C136663;
	Mon,  5 Feb 2024 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Iy+aho8c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133313664A
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 20:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165660; cv=none; b=Ei8d5X/nHPbdpGkwmo9rG2XKDaZUtQEQpIoABnH9V0yIupXsAdmFVDOpYJSYgyuzFAdC4zTFvtBN+zDunJPfn0jIXIvKdxg1qdyfncmoLcCjAkOKIzC1cZ1xaabY+qSY2M4z8JOJAtFmjIOmOP4G0z8FEjzhB7swP4NehDvNr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165660; c=relaxed/simple;
	bh=XTX16EMVCLsl4yyduwIQ3NWLweht/Bo6upfeWzSCFuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5KW4T4mJ/TlJl3CxTKRImm80JMYtbCrdZilEEJ94AMBJBmzPm4hhbDAu7qieeOkTrkL7pbuw/2rwkIdIBxxYpK/gWFcuAoHDqUrAbLR3wCMFKWEbm6ZdkOTMEZlFl4/BhXNWiMAd4bWu49wrQRhsPF2/ndbb9Zp/0nKb3m9W68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Iy+aho8c; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707165652; x=1707770452; i=quwenruo.btrfs@gmx.com;
	bh=XTX16EMVCLsl4yyduwIQ3NWLweht/Bo6upfeWzSCFuw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=Iy+aho8cbqzydpW1QNQxRNM/0k0XwU8QmW0R7dPHoFkW2VGHi5dX5KxvMofrUm+r
	 kPlZUyuHT9xdD1C5FQWN0auu+lBns4mMitfXsDqbFj1g/+aFaiXOaFIYS3MPrEdZ/
	 w+wuf/LRndduH0Yej6VDFsb7lVkqR5+WE4dnTjOP0ZxHIAHFihoEqtJMPsUfKTQTr
	 awBNxl3KmrYuMoejOFIEufV8+QcHw8fRz8twoAyGOYFps98PlQycwiYKsM+TJn5lT
	 ol6wW76hR454gEpBQaxcaq4QRJHmuV5e//yLd9udcTO+fg7JlwwI2aJcRZ5OiqAwU
	 zwpIO7ez71OYyHBr/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mo6ux-1rDlKC2J6B-00pdTC; Mon, 05
 Feb 2024 21:40:52 +0100
Message-ID: <b96844a3-41b6-4bb1-b4b1-85f07d1d1310@gmx.com>
Date: Tue, 6 Feb 2024 07:10:49 +1030
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
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <ED3C933B1371DD79+bdc357d3-3efb-49f4-9b54-8cb0ab9350d1@bupt.moe>
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
In-Reply-To: <ED3C933B1371DD79+bdc357d3-3efb-49f4-9b54-8cb0ab9350d1@bupt.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4uQxB+wGNdT176KD3qZ1GddlKjtXdOAVK0k96IxqQmU7X+Y5wSY
 T/7hmY2d1kmxIjK9tk/t3LtPqrIhTLLO4DSFJ0lj5bLZuKxJLB9I/VECDHy0MmGpQ8FY+od
 muNy+Q2rK01s11N/6a2mU3Ac3qVLyb9r/SAHUJdeHMSMsZUhsBPmVa3QfC1ACAgoFMoBOMa
 h8cZPxA0pAC95IwaH4Kxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Oc4oNdE5JI0=;3QspJOSSyIGHqX+hBFlLzoZz49n
 3elXjgkvkrTfp1YWLin4T75pSk7iBQsaQfwRyPspNASrHx6FLTnYmw2PHhboBatDAdJRHWoxd
 +l+52+FNTXPyigCqTVVpjpx11iBTd8bOOhOdqc85HT6MjVYDUoRq8xdkKKWaMDIkuo07XRya2
 LX+93ba5bDMGRFK5pZTG8081cTwJvUMN6ZeLReRLcdGV0QtVNeHAPciqc6eZ6sPUSMpBTjXTZ
 1FJW6wHFg7lgzuW8WLRFXo0ZLuvwEH/UpLenSTrpB/NT6vOxRXYEAhWi1x3qV1A2C68XTNEzE
 zWqoPKciFkueffKbVMeicRsTYAx3ukftdx0ESnvyGNGHkZYF111hpKRRzQeHcDNCNb9jTFblm
 eAc4KvfucQFOJKtscY3rxqtVVIvumTlGNkGkAQxXVPMgNiK419onabvtO2SrESkRyCCh8mdKy
 3zqqWfjLTE5eLxi5eVZ0t5/07TeY8qton5GlEO2JXLqfYn+7nxQ5loeqTuK7JEs5r+XLbMvy2
 Cqx30uj/bjD4IpUd7GKUGyuxUT6bLBTrQnioKkkF728NorJwyhhYcktocvzRsv6tF3O/nCG+j
 wUHlLDFeKzYhRItMggQYjDD1yZxn2JvbUKSx9TRcCz4bHGJaNZVxEvHo5xyILTamNZYBW5heM
 fPJY2KE5Z7SHbq8I4p6hiozCCL+7z7nDyjTix6Igjvc/rQmScNxxGr+QTh/s0b7rke4jWA/wN
 vqfbL4WYQ5MV1eFa+17DDmMTDBvT8yea0aPUVkhxx0EtZ79izfSwW+X6+oUs0ZJUNMM9SeR4/
 K3o1PeUu4STks2O6KirXmicJSMvZvX3CUIfejGHuHbgVg=



On 2024/2/5 21:20, =E9=9F=A9=E4=BA=8E=E6=83=9F wrote:
>
> =E5=9C=A8 2024/2/5 15:56, Qu Wenruo =E5=86=99=E9=81=93:
>>
>>
>> On 2024/2/5 17:16, =E9=9F=A9=E4=BA=8E=E6=83=9F wrote:
>>> =C2=A0> Any clue how can I purchase such disks?
>>> =C2=A0> And what's the interface? (NVME? SATA? U2?)
>>>
>>> I purchased these on used market app called Xianyu(=E9=97=B2=E9=B1=BC)=
 which may be
>>> difficult for users
>>> outside China mainland. And its supply is extremely unstable.
>>>
>>> Its interface is SATA. Mine model is HSH721414ALN6M0. Spec link:
>>> https://documents.westerndigital.com/content/dam/doc-library/en_us/ass=
ets/public/western-digital/product/data-center-drives/ultrastar-dc-hc600-s=
eries/data-sheet-ultrastar-dc-hc620.pdf
>>>
>>> =C2=A0> And have you tried emulated zoned device (no matter if it's qe=
mu
>>> zoned
>>> =C2=A0> emulation or nbd or whatever) with 4K sectorsize?
>>>
>>> Have tried on my loongson with this script from
>>> https://github.com/Rongronggg9
>>>
>>> =C2=A0> ./nullb setup
>>> =C2=A0> ./nullb create -s 4096 -z 256
>>> =C2=A0> ./nullb create -s 4096 -z 256
>>> =C2=A0> ./nullb ls
>>> =C2=A0> mkfs.btrfs -s 16k /dev/nullb0
>>> =C2=A0> mount /dev/nullb0 /mnt/tmp
>>> =C2=A0> btrfs device add /dev/nullb1 /mnt/tmp
>>> =C2=A0> btrfs balance start -dconvert=3Draid1 -mconvert=3Draid1 /mnt/t=
mp
>>
>> Just want to be sure, for your case, you're doing the same mkfs (4K
>> sectorsize) on the physical disk, then add a new disk, and finally
>> balanced the fs?
>>
> No. I didn't specified sector size in first place, just "mkfs.btrfs
> $dev" on default loongarchlinux (kernel 6.7.0).

Mind to re-run the mkfs.btrfs on the physical disk and provide the output?

I believe this is because you're using the latest btrfs-progs, which by
default is using 4K sectorsize by default.

Thanks,
Qu

> And it succeed with add
> device & balance. Then I successfully write & read some small files. It
> oops when I started using transmission to download something and
> executed "sync".
>> IIRC the balance itself should not succeed, no matter if it's emulated
>> or real disks, as data RAID1 requires zoned RST support.
>>
>> If that's the case, it looks like some checks got bypassed, and one cop=
y
>> of the raid1 bbio doesn't get its content setup properly thus leading t=
o
>> the NULL pointer dereference.
>>
>> Anyway, I'll try to reproduce it next week locally, or I'll ask for the
>> access to your loonson system soon.
>>
>> Thanks,
>> Qu
>>>
>>> Whether it is 4k or 16k, kernel will have "zoned: data raid1 needs
>>> raid-stripe-tree"
>>>
>>> =C2=A0> If you can provide some help, it would super great.
>>>
>>> Sure. I can provide access to my loongson w/ dual HC620 if you wish. Y=
ou
>>> can contact me on t.me/hanyuwei70.
>>>
>>> =C2=A0> can you provide the faddr2line output for
>>> =C2=A0> "btrfs_finish_ordered_extent+0x24"?
>>>
>>> I have recompiled kernel to add DEBUG_INFO. Here's result.
>>>
>>> [hyw@loong3a6 linux-6.7.2]$ ./scripts/faddr2line fs/btrfs/btrfs.ko
>>> btrfs_finish_ordered_extent+0x24
>>> btrfs_finish_ordered_extent+0x24/0xc0:
>>> spinlock_check at
>>> /home/hyw/kernel_build/linux-6.7.2/./include/linux/spinlock.h:326
>>> (inlined by) btrfs_finish_ordered_extent at
>>> /home/hyw/kernel_build/linux-6.7.2/fs/btrfs/ordered-data.c:381
>>>
>>> =E5=9C=A8 2024/2/5 13:22, Qu Wenruo =E5=86=99=E9=81=93:
>>>>
>>>>
>>>> On 2024/2/4 20:04, =E9=9F=A9=E4=BA=8E=E6=83=9F wrote:
>>>>> =C2=A0> ie. mkfs.btrfs --sectorsize 16k. it works! I can sync withou=
t any
>>>>> problem now. I will continue to monitor if any issues occurred. seem=
s
>>>>> like I can only use these disks on my loongson machine for a while.
>>>>
>>>> Any clue how can I purchase such disks?
>>>> And what's the interface? (NVME? SATA? U2?)
>>>>
>>>> I can go try qemu zoned nvme on my aarch64 host, but so far the SoC i=
s
>>>> offline (won't be online until this weekend).
>>>>
>>>> And have you tried emulated zoned device (no matter if it's qemu zone=
d
>>>> emulation or nbd or whatever) with 4K sectorsize?
>>>>
>>>>
>>>> So far we don't have good enough coverage with zoned on subpage, I ha=
ve
>>>> the physical hardware of aarch64 (and VMs with different page size),
>>>> but
>>>> I don't have any zoned devices.
>>>>
>>>> If you can provide some help, it would super great.
>>>>
>>>>>
>>>>> Is there any progress or proposed patch for subpage layer fix?
>>>>>
>>>>> =E5=9C=A8 2024/2/4 6:15, David Sterba =E5=86=99=E9=81=93:
>>>>>> On Sat, Feb 03, 2024 at 06:18:09PM +0800, =E9=9F=A9=E4=BA=8E=E6=83=
=9F wrote:
>>>>>>> When mkfs, I intentionally used "-s 4k" for better compatibility.
>>>>>>> And /sys/fs/btrfs/features/supported_sectorsizes is 4096 16384,
>>>>>>> which
>>>>>>> should be ok.
>>>>>>>
>>>>>>> btrfs-progs is 6.6.2-1, is this related?
>>>>>> No, this is something in kernel. You could test if same page and
>>>>>> sector
>>>>>> size works, ie. mkfs.btrfs --sectorsize 16k. This avoids using the
>>>>>> subpage layer that transalates the 4k sectors <-> 16k pages. This h=
as
>>>>>> the known interoperability issues with different page and sector
>>>>>> sizes
>>>>>> but if it does not affect you, you can use it.
>>>>>>
>>>>
>>>> Another thing is, I don't know how the loongson kernel dump works, bu=
t
>>>> can you provide the faddr2line output for
>>>> "btrfs_finish_ordered_extent+0x24"?
>>>>
>>>> It looks like ordered->inode is not properly initialized but I'm not
>>>> 100% sure.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>
>
>

