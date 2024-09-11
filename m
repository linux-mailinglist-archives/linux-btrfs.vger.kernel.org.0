Return-Path: <linux-btrfs+bounces-7953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF07975D4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 00:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FC61C21DE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4041A3031;
	Wed, 11 Sep 2024 22:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="j5euCHjx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F1157A5C
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726094084; cv=none; b=bSktzeGJ9BkfbPYWymARXGZTx0fhYBdGJ7KfPc6xYikK+nSH5W0SUVTnGqOcBpMD/N8xb9B9CZ4BytalIz6mXt81Nv7ZlIDRQLgummajvKaI2lpOqNq5gRQfjMda/g3KV+S3B8xm7su7ltRQoA3osAWlBZr1JfnPjOrSBn9ZrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726094084; c=relaxed/simple;
	bh=Qffq7xbYaiPglTZC+QQYS/QPkQwiMa7FU+4S8TdAXKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oO8jQD8+eyuJ2tbG4GFOgjeVrhbWu8cl4pLV00s6sSvPJY49RSZGYquLKYw6Y/hhoGsBsS9ztvhx1hVszvdOEf7pOMw4044p6/SSMz2tmkdS5pJJWWIt0F2aORrgZX0ItITddGQGdkiPhrUEfsKyaadhsuenjVxpXji4iaNqTic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=j5euCHjx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726094078; x=1726698878; i=quwenruo.btrfs@gmx.com;
	bh=Ekp5LhYMQ1mW/kK2z5usKIZone1upltlEeL0AHzr1Dc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=j5euCHjxGvt+UOW9im64SpN6tXt8+4194K8RfPDmCq/j0cH/qlqkBz1G4JZJUNTl
	 y4ZuBYrZH+xzUEKBCgkLxdaunOPyESBpgsPY73h8dumVG0ih2zVuI1/k+nYCuuBDg
	 RJdw9hCnMZ7YT7mBvvwOjbmlmrZaQ9BGiNnT1xPA9Uft1spFbzFm0I10eLKne+cZ+
	 6k38v44X9NJyzk7xigOdiHOuxzCaPz1KzsTWgsyj89w1wUCtwUN7aC2Xnx9vThyus
	 vmTCe8paU5V3CZh0++nq2SJ4JmZPLlKN+ypOhSC7zolMegVSWVUdJ3/k3Q66vhXIs
	 oqpxyOVvbu5noRA3uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MoO2E-1sDGHG1M5o-00aZPh; Thu, 12
 Sep 2024 00:34:38 +0200
Message-ID: <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
Date: Thu, 12 Sep 2024 08:04:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
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
In-Reply-To: <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RiT6iipQF0EqdHG99PM5vQpiloDt5Wnll48AwDmyYx0w+Mw7rKv
 Z1nvrb9gncmkcSOIu/PymDMtkoB0iyybGfoO5aXe5BGVuO9w+hdEUzKRoBYodne8Jvk34KD
 Kavns1ptHL/z/506rtzb4kjyTlk4jr70Nmw+OuYSzFuLS06VPJMC+kLfApd0bElNu0Uyzwi
 gEccZDDW3qLxolV0HnWMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9q7zx8S/6hA=;Z71xT8PDLyzd6XS57dpyf8LZXDc
 AEf4qODD66uB3/NF6cnth9rViNzCqvN+MGnB1J15x6VYS3YD11vSJ9wbk9LKCh4tU0zjVHn9m
 ddW7zZO6NNJeTOFDNDbGVRqNYDUkxDn+7eSIMeBHI6GbWalO2hVfT2YL/8oBTzEXz8as1bQPP
 NXNwnIusmCi1nGg16C255aMWb693G9A2xOAUQ2nUVVbvYleSEUCyrbuGrl8gIAShLJtU0mnRg
 +TdPGc/C6XvV7obbkKh7ZyaD9YCRino4bEu3sAIDuCQ/+bNvk93i56GdjmkM1K+snh+BydYV7
 m+SGb9K938hTyPfGk+JrcT4E2ecxs/dlM/4Va8gc3osqHCbR0tmxR0K1kmCycU0LhjbDpbmfH
 bK1zVBqVTVGaJIdQv6pvP8vUdILaYqYMIXSJvNJ6StYyqA74ZCHlfoILR2PNmzFxVFbNxatpe
 WchIIsL0SSeLHbp9CpMtUk8RIrxjTyCvklybvXFSn4LeZ4NzbJ85xdj1p230iHtOarKhIhA/f
 nbEWZ8Rnm2xsjVfJvfTzz04E3laNdvDGwf3F5DNm24sTmCOmoCeeb0Q5PHnrUyDVVf/UJvziq
 +hN3vB4qh/T/McqBaev7qOSf6a3lkaEdv4dnEQKyDoOgMSCsrORKe5mC+gTFNXecFhIdDLUdK
 npKaV6GT0TwPJfNXa83ckTsQNeENa4hbhwj45P5NPdHxRQ7WZ6y4u4JebhKKn3NVZGV1UWz/j
 NIGpZeB26M9QMR592nurvJfZAED360I4D/cux0OTLogF1588FX+uIffSGu4QW4G1HgNkl42Uf
 JYBxbhhIC5p3Qbf5uKBtnKuw==



=E5=9C=A8 2024/9/12 07:35, Archange =E5=86=99=E9=81=93:
>
> Le 12/09/2024 =C3=A0 01:23, Qu Wenruo a =C3=A9crit=C2=A0:
[...]
>
> While the previous one (see my second message in this thread) had no
> error, there is now one:
>
> # btrfs check /dev/mapper/rootext
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/rootext
> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> wanted bytes 688128, found 720896 for off 676326604800
> cache appears valid but isn't 676326604800

Minor problem, still I'd recommend to run
  `btrfs rescue clear-space-cache v1 <dev>` to clear the v1 cache first.

Then you can mount with v2 space cache or keep going with the v1 cache
(not recommended, will be deprecated soon)

And if your fs only have subvolumes 5 (the top level one), 257 and 258,
then you're totally fine to continue.
I guess that's the case?

If you have other subvolumes, then you may need to wait for my fix to
ino-clear code to clear the remaining subvolumes, just in case.

Thanks,
Qu

> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 478434086912 bytes used, error(s) found
> total csum bytes: 465136176
> total tree bytes: 1590493184
> total fs tree bytes: 870760448
> total extent tree bytes: 138231808
> btree space waste bytes: 326062620
> file data blocks allocated: 516090466304
>  =C2=A0referenced 492383629312
>
>> For the bad free space cache, I'd recommend to go v2 space cache instea=
d.
>
> Since the above error seems related to space cache, and that I had
> switching to v2 on my todo list for a long time, I=E2=80=99ve just did s=
o.
>
> dmesg mount messages right after (nothing unexpected I guess, outside
> the warning and =E2=80=9Ccorrupt 4=E2=80=9D still present):
>
> [=C2=A0 812.242212] BTRFS: device label root devid 1 transid 6065207
> /dev/mapper/rootext (254:1) scanned by mount (2145)
> [=C2=A0 812.243727] BTRFS info (device dm-1): first mount of filesystem
> e6614f01-6f56-4776-8b0a-c260089c35e7
> [=C2=A0 812.243770] BTRFS info (device dm-1): using crc32c (crc32c-intel=
)
> checksum algorithm
> [=C2=A0 812.243788] BTRFS info (device dm-1): using free-space-tree
> [=C2=A0 812.256356] BTRFS warning (device dm-1): devid 1 physical 0 len
> 4194304 inside the reserved space
> [=C2=A0 812.258504] BTRFS info (device dm-1): bdev /dev/mapper/rootext e=
rrs:
> wr 0, rd 0, flush 0, corrupt 4, gen 0
> [=C2=A0 812.810623] BTRFS info (device dm-1): creating free space tree
> [=C2=A0 819.778945] BTRFS info (device dm-1): setting compat-ro feature =
flag
> for FREE_SPACE_TREE (0x1)
> [=C2=A0 819.778949] BTRFS info (device dm-1): setting compat-ro feature =
flag
> for FREE_SPACE_TREE_VALID (0x2)
> [=C2=A0 819.877973] BTRFS info (device dm-1): cleaning free space cache =
v1
> [=C2=A0 819.885829] BTRFS info (device dm-1): checking UUID tree
> [=C2=A0 866.299565] BTRFS info (device dm-1): last unmount of filesystem
> e6614f01-6f56-4776-8b0a-c260089c35e7
>
> I=E2=80=99ve run check again after that:
>
> # btrfs check /dev/mapper/rootext
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/rootext
> UUID: e6614f01-6f56-4776-8b0a-c260089c35e7
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space tree
> there is no free space entry for 0-65536
> cache appears valid but isn't 0
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 478312665088 bytes used, error(s) found
> total csum bytes: 465136176
> total tree bytes: 1593524224
> total fs tree bytes: 870760448
> total extent tree bytes: 138231808
> btree space waste bytes: 326060271
> file data blocks allocated: 515966013440
>  =C2=A0referenced 492259176448
>
> So there is still an error, but different this time.
>
>

