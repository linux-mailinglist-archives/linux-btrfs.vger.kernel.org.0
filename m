Return-Path: <linux-btrfs+bounces-2624-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650AB85EFC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 04:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DCE1F236B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D67171A5;
	Thu, 22 Feb 2024 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WVs3fQ9v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C547101EC
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572365; cv=none; b=UffCVjCWJVGdJK7nX4dtbwrJZGh3j7yFodQVBL+ZQGArpuIzfNdZ0epDEW6XBXv41Oa4TO5BXr3k2ZX//8mgZRA31cpbyfIwmaTtdaRUYoO2krYVKaahD/w4zicq7qaq/KIaMaZjMO5xHff/Sr8fdnQwGPz+W31O8+IJSCyegVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572365; c=relaxed/simple;
	bh=LsYlXEEev6XkV+P3qzANiVJ635o6PIqSX+0lscZ7G5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cRdWedD2UeaF5yVmuT58HmS2RK/+vpMqW1iKjKlEgOTN5mXt7saTo20Y6DN3MqcjRlz+WQTu/wOxp2vDehPYTWSijyrvqzcPvaYQt7rowGjymNGOMI26y8EBhBI6YhQRZcjnlaA83hxC5vzEOlE6OF7zLQkxqh4EY6+Jr5KlX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WVs3fQ9v; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708572360; x=1709177160; i=quwenruo.btrfs@gmx.com;
	bh=LsYlXEEev6XkV+P3qzANiVJ635o6PIqSX+0lscZ7G5s=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=WVs3fQ9vxzlEXiWtID4EnLtYufMbVZQws3Xmhh4AwKFp599rI9JqRBfKVqOSg4dB
	 fgzej4r3UlsI1zFTFynw6RDvgqBPcN27ZmjND6AtE/+QhlnS1Q3AmWZMdHL8naXBR
	 bG/W8KO4qERlc5jKcNlGFyOQ5OAe4+BY+/EyyxvhmoEzBW8mfvjIKBzTWnyXVxFs/
	 aT7dRmAZQ6sAdK3UWJxZy7D7ZxvqAzp/Zivfb/bUmu7mMYQHBvESChGxbofxt4Soh
	 tjNVcguU76tokuh6tzdoiFQI7IooBlFrNWXwpfNQ56KDebbssaFrpMTh6RWnXvoNi
	 aewyV6NhoEDjmPuMIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N5GE1-1qu470308D-011Aos; Thu, 22
 Feb 2024 04:26:00 +0100
Message-ID: <7f994558-e786-4bc1-97bc-7090b9955de3@gmx.com>
Date: Thu, 22 Feb 2024 13:55:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apply different compress/compress-force settings on different
 subvolumes ?
Content-Language: en-US
To: Roland <devzero@web.de>, linux-btrfs@vger.kernel.org
References: <5bd227d2-187a-4e0a-9ae8-c199bf6d0c85@web.de>
 <1597160e-0b54-403b-8e9d-9435425f14f3@gmx.com>
 <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
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
In-Reply-To: <2790f277-fc10-43fc-b7d3-9a3cef1eced2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kFjR55DqKZv10IKiOdGwlsSbnRN2ezlbN++XBuGRAqkd0wC/7W+
 4Vs6vu7kt1rrqeI6j8AunNZpyMkrR0Up0WIZ+N2G2emLg9KJfTLVh75mta0F4vbMTFXfgBX
 GPeADXChwpyJmIlGOdx6P4/vPC5f6VQ8T9m207cczmT4ATTogvj2FErAIoE2mCJZ/RtoGSA
 khV76+/Ymvi1m7xJXCGIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k1Rhjz8suRY=;ni3K26qjnDI72Wc/JU4Ig9jNzLT
 Af6GOpNQ+6PEPq4V4bgaCt61HO7wLHs9dJ9sIjRppjm+EOOO2zrP5MbVHeXD2y2Y+1wPAdlXr
 AvaBexaryKO+N7uD+9SllYMxdGGkvD7XHJHasD1GFOAFfNS2klMy59nD1ClsybSqgPfuQCyV0
 f1nU4DIKcSiDv6vcICARnDb7LFQvCSNszFymIivvtoi69/a4YUw9KsYwFeKFrsI1pq/m+YP8p
 q6VeqHMXMZ/amrF/9CjEX9SZEDruGiJJqezFytglgjuHL1iMCzb17VfLrfwQirdXsdAZBILzN
 HI0MU7nTLtWnqg8879yfCU6QCPUKaF4q6cgStJyuiD2CJZ+wezrchIZs1q+tuIT+DTQajZ98X
 kdBRmxdiuunbEnNBj/cDH8u4+VZWqXxBoJp9xWxQDSIio7H17DUNsIS8fQ0RvDsdDFdKUhqGP
 go6HmQRj/aI6WeOxA9MqXrTZMc9LGmiQbOs5SlBthzjQhmA249MMSjvZdEh76JutRawTzumAM
 z3QmziLDqasujrQCGZmyavPphNbyo8Pv5+ZDLIgPxmljoYqL79LVtkR2WgwXsYThpwNHpwtzj
 BMZNp5Th4j2MOCBFsC4ef09X9WkCAafYF3wUD/gC1ws4vHG8sjbGeFmrpW+y48jgFFd9RL3xj
 0gQ/lCVJzevvKqyXZ4nr2ITThWnQk9tySaGWqc85YLSInPyFkjBNhxzZ9DHeJgvrFoYfPD6r4
 PUb4iSQiCFbAJ/16xI68wAYX8TU3CG/zyGNfRgoNwT+K0GtN6+70w9cRzv0fQMCduiEGjELAO
 lHwL2swVz19gzhgmM2aL9uS991ZnQNqCXVXeuJnUm2rgU=



=E5=9C=A8 2024/2/21 23:45, Roland =E5=86=99=E9=81=93:
> Am 21.02.24 um 10:33 schrieb Qu Wenruo:
>
>> =E5=9C=A8 2024/2/21 19:19, Roland =E5=86=99=E9=81=93:
>>> hello,
>>>
>>> what can be the reason , that multiple compress mount option do not wo=
rk
>>> on subvolume level , i.e. it's always the first that wins ?
>> In that case, you may want to use "btrfs prop" subcommand to setup
>> compression for each subvolume.
>>
>> The mount option one is really affecting the whole filesystem.
>>>
>>> and why is compress-force silently ignored? (see below)
>> Compress-force has no coresponding per-inode prop option though.
>>
>> But I don't think compress-force would cause much difference against
>> regular compress.
>
> apparently, force-compress can make a big difference (and compress only
> can lead to no compression at all):
>
> https://bugzilla.proxmox.com/show_bug.cgi?id=3D5250#c6

OK, didn't expect the compression ratio detection to cause so much
difference.

Which also means, we can further improve the compression detection.

In that case, I would purpose to change "compress-force" to
"skip_compress_heuristic" or something similar, and get rid of the
compression string/level for the new option.

The "compress-force=3D%s" is really confusing against the existing
"comrepss=3D%s" option.

To me, this sounds like a change which would improve the user interface.
And with the new option named determined, I'm pretty happy to add a new
prop to skip the heuristic.

Thanks,
Qu
>
>
>>> regarding compress mount option, it seems that this can be overriden v=
ia
>>> subvolume property, which can work around the problem and have multipl=
e
>>> compression settings.
>>>
>>> but how to fix compress-force in the same way, i.e. how can we have
>>> differenty compress-force settings with one btrfs fs ?
>>>
>>> wouldn't it make sense to introduce compress-force property for this ?
>>>
>>> what about replacing compress with compress-force (i.e. make it the
>>> default), as there is not much overhead with modern/fast cpu ?
>>>
>>> i think compress-force / compress is VERY confusing from and end user
>>> perspective - and even worse, i have set "compress" on a subvolume use=
d
>>> for virtual machines and they do not get compressed at all (not a sing=
le
>>> bit) . so i think, compress option is pretty short-sighted and not, wh=
at
>>> an average user would expect (
>>> https://marc.info/?l=3Dlinux-btrfs&m=3D154523409314147&w=3D2 )
>>
>> IIRC compress prop needs to be set to all inodes.
>> If you set it on a directory, only new inodes would inherit the prop,
>> the existing ones won't get the new prop.
>
>
> that's clear, and no different from zfs.
>
> the big advantage of btrfs is, that we have btrfs filesystem defragment
> to recompress everything
> in place, whereas in zfs we need to move it forth and back to a
> different dataset.
>
> regards
> Roland
>
>>
>> Thanks,
>> Qu
>>>
>>> i'd be happy on some feedback. not subscribed to this list, so please
>>> CC.
>>>
>>> roland
>>>
>>>
>>> zstd compression applied to all subvolumes, though specified otherwise=
:
>>>
>>> cat /etc/fstab|grep btrfs
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>>
>>> mount|grep btrfs
>>> /dev/sdb1 on /btrfs/zstd type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D259,subvol=3D/zstd)
>>>
>>> /dev/sdb1 on /btrfs/lzo type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D257,subvol=3D/lzo)
>>>
>>> /dev/sdb1 on /btrfs/none type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D258,subvol=3D/none)
>>>
>>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D260,subvol=3D/zstd-force)
>>>
>>>
>>>
>>> different order in fstab has different result - first wins:
>>>
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>>
>>> /dev/sdb1 on /btrfs/lzo type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D257,subvol=3D/lzo)
>>>
>>> /dev/sdb1 on /btrfs/zstd type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D259,subvol=3D/zstd)
>>>
>>> /dev/sdb1 on /btrfs/none type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D258,subvol=3D/none)
>>>
>>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>>> (rw,relatime,compress=3Dlzo,ssd,discard=3Dasync,space_cache=3Dv2,subvo=
lid=3D260,subvol=3D/zstd-force)
>>>
>>>
>>>
>>> compress-force silently ignored:
>>>
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd btrfs
>>> subvol=3Dzstd,compress=3Dzstd,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/lzo=C2=A0 btrfs
>>> subvol=3Dlzo,compress=3Dlzo,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/none btrfs
>>> subvol=3Dnone,compress=3Dnone,defaults 0 1
>>> UUID=3Dda0fadf1-5db4-4f5b-a77e-2f0730f4e872 /btrfs/zstd-force btrfs
>>> subvol=3Dzstd-force,compress-force=3Dzstd,defaults 0 1
>>>
>>> /dev/sdb1 on /btrfs/zstd type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D259,subvol=3D/zstd)
>>>
>>> /dev/sdb1 on /btrfs/lzo type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D257,subvol=3D/lzo)
>>>
>>> /dev/sdb1 on /btrfs/none type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D258,subvol=3D/none)
>>>
>>> /dev/sdb1 on /btrfs/zstd-force type btrfs
>>> (rw,relatime,compress=3Dzstd:3,ssd,discard=3Dasync,space_cache=3Dv2,su=
bvolid=3D260,subvol=3D/zstd-force)
>>>
>>>
>>>
>>>
>>> this is the write speed i get with compress-force=3Dzstd on i7-7700
>>>
>>> # dd if=3D/dev/zero of=3Dtest.dat bs=3D1024k count=3D10240 ;time sync
>>> 10240+0 records in
>>> 10240+0 records out
>>> 10737418240 bytes (11 GB, 10 GiB) copied, 3.76111 s, 2.9 GB/s
>>>
>>> real=C2=A0=C2=A0=C2=A0 0m0.224s
>>> user=C2=A0=C2=A0=C2=A0 0m0.000s
>>> sys=C2=A0=C2=A0=C2=A0 0m0.081s
>>>
>>>
>>>
>

