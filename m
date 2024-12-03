Return-Path: <linux-btrfs+bounces-10029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341799E18BF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 11:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF13416691C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2024 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC91DF74D;
	Tue,  3 Dec 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Aj/bziej"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B213D890
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2024 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220255; cv=none; b=CqirxPvxpJ697tP+MrzyyhFzYx6n/b0MSLup+6CkBfg2KLP0YoZqYyOYqIiLYHC09o2X5Vke9OjFOK40gYQ6ICG4HxoXrQK7RS06mwewZNPjdxw2r0E5Em1Nk/4tEKM06kD0qO74FIdaB2N8KWWVIyncNT4dmNRhpTz0Zs8Krmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220255; c=relaxed/simple;
	bh=yuUMJ5E4yVdpwo9x6EnOJB/tmuyllSJ0/q59I9UJsxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr+opdPVZPQVypWPMmkf2HVD3/Nw9eswCKr47qRKKmzs4oEcnXQXS+Ox0FC4uyiELAL2sTSe7O8bmhjPCC+e9HcBlPF1QBXkLkLVNDa3uLIoc66Mo+q64vL1DMKgy0ToND3F7cfYmWj+sNcB8C17PpbeI4O58laOFKZv1Jk/8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Aj/bziej; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733220250; x=1733825050; i=quwenruo.btrfs@gmx.com;
	bh=KU2QIzFC6n6elEKFmDiWms2mTClmmwAe+DL7cFVKHMo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Aj/bziejIM9urP2zy6O6LwLFaj3mxAJ72v7hS+gVIlBJdecWQvvueZCpDlvr8Jxb
	 vc/R4Tj8ygNVcKvF6id54laMSb/rGtntL1iykHl44GVbEFgM36MAQ/ed/k7EigVIU
	 D63Mqk8J+tb3XXr6MhTHpwx/blWBFSBQB5h3fn7C9VTKZamY0DGWkt7coXnGA6Eh+
	 f2nid9aJQdz2Iw5hQtXiqinbzzs3EezIg2nFDv85u3RaeO4itarzK1XecF7ohvcjQ
	 DLKtWbhcSa7QhpUFCH0APXv9Pf7xL6nd1KkE5CTBYdsOC1uRdLOt7/NgyST1zcWVz
	 VGGd/iOOVSuMmN9YAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNbp3-1t2ezS2cWJ-00Z0D1; Tue, 03
 Dec 2024 11:04:10 +0100
Message-ID: <a2f8b6d2-7f11-4827-a061-ff2f822a5f08@gmx.com>
Date: Tue, 3 Dec 2024 20:34:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Balance failed with tree block error
To: Neil Parton <njparton@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <CAAYHqBbMeLYXdhNondp8JwQCsp-n1cCvnAubS3f2FxD6PBOEsQ@mail.gmail.com>
 <8276d833-d4f2-42dd-8190-c98265896ee3@gmx.com>
 <CAAYHqBZMBmD2yT2C95KrGXNqYjkecEO3jQQ74X5iT+MKxWhpMA@mail.gmail.com>
 <ba4f665d-f7fe-438f-a7ba-dc92d16b9f68@gmx.com>
 <CAAYHqBZmXtW_Z1KBNzOODNHgC=hMVXUrS3HGvKsBy3cd=jW-mQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <CAAYHqBZmXtW_Z1KBNzOODNHgC=hMVXUrS3HGvKsBy3cd=jW-mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2albJ8w7Racqe7HdzTxv+XZ72iWuB8kziAm6IrjI4JGCk5URLiC
 yBzHGMw9IejCQgcV413ozd5k+apIkmEOzB8O4D2Lgt4+9X56r4MQ/uCM/P67Z2GxWLKfHfg
 gmb5sWUF21VOSysbhK31ILQKUY8GK4VX8bASAihmdSs2b/4rctAEQ7Zch/8ujq0Ai/gKm5k
 KU5Qtl/X57FqMr5iF6jCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2Vko0lfjiqk=;GUGthsIQaqKLdt+3CXqPlyzq2jI
 5mh9Y5e18bhRxoaVTPXoxTVpZMVOW4U5L7ZbYLDvh0sOB3E1wSQ8+EVukCEDrPoQDvhHWSaGk
 6OXQsq3g606S6NRaYR1VaMe+L3YCYx+mqCcWHWouB5Yx/43q9X0ASNLVyRDLUlT1Bj9ZEu2pH
 hms9y2lBvP8c3zQNQcXAkB5o55ZOIk6UcTdN0VxfbBxtk5oPEQRXSH1PzLQ24W6wEwV8mvGRS
 suk4C5/KQyQtakbJZ5js3Ey1rdODP3JcZI8C+Z+GHEFVMNjAJMZD/JdnBn/jSOxMdbEcbkf6I
 Q4Mjk6b8BwmoetEpnFrwv+C9oS1BT+pXQYaaDmsb4A1FHYSft67/cZ5c/N1vAiol3vkelt9W3
 Wm2Ou4oHLCMx7oOOxH9I6dwz9K5G8KdZIISI2wb+re1QKwQLXJ01AsuI2TvvMOB//w6Kz5gG5
 nHyimChgaF58Bzc73qdjCODztitq428p1oDu4wP38/DUoXxR7lRz3xLTrvUX6nFqBlWd0FGIu
 qYWVVZ1pDV0H26VxRRJgh/nkXP0gNbVPoxDOuRJQ/GjVyq5SnjiTsufV0ZAyJ/jQ7geTyDuPi
 6Bwr4dpR7KvsYEQotwZq7Gf+7whDiuntd9RY750lQswdORIoVtTyU7aGBChxZEQk7zKU6x2eS
 WycwO40Uqo0VbuNmgxBI7RpQtMWF61+rry6SYrR58U63lbZaImNFxtvZC1TQ4vtF7GSVCB0PC
 gXVJaYIsdUP0Q64cTk6OKdAZDuFsxxPAbWMFc0fE6bVKsWE1N/K4RebJxdr8F8QNKelhkU2Ah
 pT/jyJfZkoLibhbc5YNRXG72NWmiyqdwMhSaJG4s6pjpXhsKj43TyZzR+xUkcdsKHqWNKXJoM
 3G7ccC6RK1d04+sOF/Gt7ucm26B02+VQF9/Yub5fJvPqoi4T0JM2R9cYtSqcm7qrDR9AWd7TF
 GldqvXX97S+vWpdDxFIwPYZ+5mGPNWOor2SYJBr5NV6coseqLGoVSsfH06w/Uzu+fXuHcWm9M
 5VkAfOjM9cjWQRVyWapAFb8ba3J9BQMl5ipDikenWYAJQ81Ot9oef8WwWWVhc0mKQHsyS3vpu
 Z459eJG6GcdpDDiiM4zvXOFxMBb6MB



=E5=9C=A8 2024/12/3 20:15, Neil Parton =E5=86=99=E9=81=93:
> OK I unmounted the filesystem and ran sudo btrfs check --readonly
> /dev/sdd 1> stdout.txt 2> stderr.txt > check.txt (sdd appeared to be
> the drive with issues from the dmesg logs).
>
> stderr and check outputs attached, stdout was blank

It looks like the problem is more like a bitflip now.

All the involved back tree backrefs have the same parent
332886134538240, which matches the dmesg bytenr.

If the fs is an old one, it may be some older corruption.

Anyway, you should still be able to backup all the data (no special
mount option needed even), after making sure your hardware memory is all
fine.

Then I'd recommend to reformat the fs after backing up needed data.

Thanks,
Qu
>
> Thanks
>
> Neil
>
> On Tue, 3 Dec 2024 at 08:38, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/3 18:50, Neil Parton =E5=86=99=E9=81=93:
>>> OK I've output dmesg to a text file attached, glad you remembered my
>>> previous experience as I forgot to mention that!
>>
>> The tree block backref btrfs is searching for is 332886134538240.
>>
>> But there are only two tree block backref near that number:
>>
>> [16181.904739]  item 63 key (332886134521856 168 16384) itemoff 13019
>> itemsize 51
>> [16181.904740]          extent refs 1 gen 12802640 flags 2
>> [16181.904741]          tree block key (18446744073709551606 128
>> 334290896531456) level 0
>> [16181.904741]          ref#0: tree block backref root 7
>> [16181.904742]  item 64 key (332886134554624 168 16384) itemoff 12968
>> itemsize 51
>> [16181.904743]          extent refs 1 gen 12802640 flags 2
>> [16181.904744]          tree block key (18446744073709551606 128
>> 334290913148928) level 0
>> [16181.904745]          ref#0: tree block backref root 7
>>
>> So far it's very hard to judge if it's a memory bitflip.
>>
>> The bytenr 332886134538240 is 0x0x12ec217cc8000, meanwhile the target i=
s
>> 0x12ec217ccc000.
>>
>> The diff is 0x4000, so it may be a bit flip.
>>
>> On the other hand, it may also be a case where it's really an extent
>> tree corruption that cause some backref missing for that 0x12ec217ccc00=
0
>> bytenr.
>>
>> I do not have a good call just based on the dmesg.
>>
>> A full "btrfs check --readonly" output (including both stderr and
>> stdout) could help a lot.
>> And if your memtest exposed some error, then it's also very likely it's
>> a bitflip at runtime, and since such bitflip brings no obvious
>> corruption btrfs is unable to catch it and wrote it back to disk.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks
>>>
>>> Neil
>>>
>>> On Tue, 3 Dec 2024 at 08:16, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/3 18:41, Neil Parton =E5=86=99=E9=81=93:
>>>>> Arch Linux kernel 6.6.63-1-lts, btrfs-progs 6.12-1
>>>>>
>>>>> Yesterday I added a 5th drive to an existing raid 1 array (raid1c3
>>>>> metadata) and overnight it failed after a few percent complete.  btr=
fs
>>>>> stats are all zero and there are no SMART errors on any of the 5
>>>>> drives.
>>>>>
>>>>> dmesg shows the following:
>>>>>
>>>>> $ sudo dmesg | grep btrfs
>>>>> [16181.905236] WARNING: CPU: 0 PID: 23336 at
>>>>> fs/btrfs/relocation.c:3286 add_data_references+0x4f8/0x550 [btrfs]
>>>>> [16181.905347]  spi_intel xhci_pci_renesas drm_display_helper video
>>>>> cec wmi btrfs blake2b_generic libcrc32c crc32c_generic crc32c_intel
>>>>> xor raid6_pq
>>>>> [16181.905354] CPU: 0 PID: 23336 Comm: btrfs Tainted: G     U
>>>>>       6.6.63-1-lts #1 1935f30fe99b63e43ea69e5a59d364f11de63a00
>>>>> [16181.905358] RIP: 0010:add_data_references+0x4f8/0x550 [btrfs]
>>>>> [16181.905431]  ? add_data_references+0x4f8/0x550 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905488]  ? add_data_references+0x4f8/0x550 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905551]  ? add_data_references+0x4f8/0x550 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905601]  ? add_data_references+0x4f8/0x550 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905654]  relocate_block_group+0x336/0x500 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905705]  btrfs_relocate_block_group+0x27c/0x440 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905755]  btrfs_relocate_chunk+0x3f/0x170 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905811]  btrfs_balance+0x942/0x1340 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>> [16181.905866]  btrfs_ioctl+0x2388/0x2640 [btrfs
>>>>> 4407e530e6d61f5f220d43222ab0d6fd9f22e635]
>>>>>
>>>>> and
>>>>>
>>>>> $ sudo dmesg | grep BTRFS
>>>>> <deleted lots of repetitive lines for brevity>
>>>>> [16162.080878] BTRFS info (device sdd): relocating block group
>>>>> 338737521229824 flags data|raid1
>>>>> [16175.051355] BTRFS info (device sdd): found 5 extents, stage: move
>>>>> data extents
>>>>> [16180.023748] BTRFS info (device sdd): found 5 extents, stage: upda=
te
>>>>> data pointers
>>>>> [16181.904523] BTRFS info (device sdd): leaf 328610877177856 gen
>>>>> 12982316 total ptrs 206 free space 627 owner 2
>>>>> [16181.905206] BTRFS error (device sdd): tree block extent item
>>>>> (332886134538240) is not found in extent tree
>>>>
>>>> There is a leaf dump, please paste the full dmesg, or we can not be s=
ure
>>>> what the cause is.
>>>>
>>>> Although I guess it may be a memory bitflip, considering all the past
>>>> experience.
>>>>
>>>> So after pasting the full dmesg, you may also want to do a full memte=
st
>>>> just in case.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>> [16183.091659] BTRFS info (device sdd): balance: ended with status: =
-22
>>>>>
>>>>> What course of action should I take so that the balance completes ne=
xt time?
>>>>>
>>>>> Many thanks
>>>>>
>>>>> Neil
>>>>>
>>>>
>>


