Return-Path: <linux-btrfs+bounces-4027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3D89CE34
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 571F5B219C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77340149002;
	Mon,  8 Apr 2024 22:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="tPT0BsPT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450D7E8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613941; cv=none; b=plsPKrXxFIbZB3kwilUbs65SFGR8GK4R7V3MwVMerLcnTCEKZE7J44falv/mesK/O3jq/EB1zkl/J0Dv/jYswifZlPKZ1ia4rkBsLQXKIZCR34WNvdZXMsjsrJzhlqCReCx5vKiNcWN60y4qj+ZMezP2eQUSAB5QAwbJaUzEJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613941; c=relaxed/simple;
	bh=uzftG0c8XBWCsuPr8yVjWIwOTJ5rePkWxGUZX7RQQsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcxeRtoi0rM3yQ4WZ4pTyJn4QNh0wscf0nazlWlyr+xXrVaHauDIpYvnuLXOVm6SHBCZ5wcH4/sga/Srmns5nuTJ57VMeT7TI5h+nEjlkNEg9eNy7OK9KtLqDl5Lw8ujJpo0fSsKVTho9pdC1vSiEUCtzixoM3JjlFb/Y9RsbDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=tPT0BsPT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1712613932; x=1713218732; i=quwenruo.btrfs@gmx.com;
	bh=QjjKODahMJfWvu65nqbF0hNp3uwvJnVWfYvOWPuGTLE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=tPT0BsPT4RINBjlcRAzYtrTyvrZqxJMdU3h5l8CCUKiyjn5bOE4ljJN30isrw5CO
	 7Cnrk8GcKPtgp0c6nsB7n55mj+0QrYUECWJb9kx6jLAoxj2c0z5IsZP+OrvnJBdjq
	 BM3IuVOKdAP0rsvcKVG61I1SL3X6UQ4ECt21YzuaqG1CyLNKgWcSZwpkhxNNe46Fs
	 c1kjH2a2EZVZbFEE0L1941rVJnue8BD6dGTPgUL4LNSRfO1eCCE481HF3v0NP3zbx
	 Lj7XsiQYW2usubSX2gDCFvxMz72+XxeYIuZBiZOUChtkUyRTNWFX7qxKq5R5zfScA
	 NHGMgD+/xAR9bLcPUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mt79P-1snHn82R1l-00tPTB; Tue, 09
 Apr 2024 00:05:32 +0200
Message-ID: <2c546dcb-25eb-488c-9ebe-718d268d721b@gmx.com>
Date: Tue, 9 Apr 2024 07:35:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] btrfs: add extra comments on extent_map members
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1712287421.git.wqu@suse.com>
 <261cf7744120a2312ce2cdb22dbbfe439a11268a.1712287421.git.wqu@suse.com>
 <CAL3q7H5-2gfkd7xjy9QVrtgDZGv34jhQrTTtuNL8Qs08rNimrA@mail.gmail.com>
 <bbc9acb4-a8a3-4fde-9e55-6b49a009dc00@gmx.com>
 <CAL3q7H41R98aw5V=sOw8VedObDJL3XaqWkRNcOD73hLdjUf-=Q@mail.gmail.com>
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
In-Reply-To: <CAL3q7H41R98aw5V=sOw8VedObDJL3XaqWkRNcOD73hLdjUf-=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HkpkOrJkug7oOGNd2tta3z6KXz6QZQ+TbLB35dAYIfXC5KlGKBk
 A1XUKdAhheaSvKuik5gY/9n5vAOYakRrpLfmrVoAYfatPa7M3HTpJJg1EvZkqhQ9ynH4g0k
 LWvIP0Bva6r/Sbue1EDQz5BCrDyU0pruSuXgZ21jUA+fXBNpXrsMyiHwndqeBvoTmE2iADr
 3KslwMkrQuNYrnAIg3uWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SuQbCV7sQlc=;Ds46WzBLviT/zliusA5yLpq22J3
 +uqwpRwiCP/E4lKGCth/0hRGZF58JYF1myY/0ULfhbc/GYC8cyIoCUb77Whd1loAxllJ/pNRE
 ZMRNca7UXgbWz3kPtOBeJgkG8a1oXB85H17Hhr/t008hNY+ZcPBVfrycIzWhuwZxlkMyTC6DY
 TEW0v/+2VKjssCxoHP+dSEA8Ef0dA+PZDOWPTolfM4hj5QwN1qREl94W3GEvq8Soh2syeHL0j
 awAruCM4D/XsMpm+0akV0JefLOlNyNOiVQAu2W7amW6+pFH1LkpYBmvzT5xyY3gfq+/sQrBf7
 70hX8rqMJbQBc1fAaF4biDWhzJLmVW2cTo/dAIyVgp4jk4ptCF/Op0nEeWvGcasD0KNMbYMLP
 8e/DZl36gqYTPyoN0RZAVciYwDx7hkA4JXCXN4Y8VP71X3JYisaxD/JdH89f60AytoLrOce0r
 JmVzTcqpuO/Wz1sB1DsgJ3JKiNCNCF0r93GJoRwm0kVMd6rIKKwI8EF2/Rem/j8XC02/D2zW6
 23ZiMjRwsvEsjC8zt7oxDNwOJrMrQdidbhz/Jvwo1evITVpeMZ9vXPHhfylos0fbv1tBh7J3c
 4HYqGpOMa/QVzSalaX8daQP2o3Sej6778DyceywgdW9Osb1XtEoju4bPuigORdpfjUjEd66zW
 FnkTB4rhPFX0e+/zRl4THfXkNpo6/BX/D34JlYFyGdhzn55ZlOkZASbSx06Ek2Tip2trR/vi0
 oYz1qfY0L/sSOeezUr11SOKUjesayelHhp43GTSHBLAxQFEri8b6qVniWlqqlYWTHyXE5K+5c
 55c1AsuQbwn1d1cVVuZwY9tL2ySisFGHLA2sVCyhXu31I=



=E5=9C=A8 2024/4/8 20:41, Filipe Manana =E5=86=99=E9=81=93:
> On Fri, Apr 5, 2024 at 10:36=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.co=
m> wrote:
[...]
>>
>> But on the other hand, it's a little too obvious, thus I didn't mention
>> through the whole series.
>
> Well, a lot of the comments this patch is adding are too obvious as well=
.
> So I don't see why mentioning an extent map may represent merged
> extents is too obvious, if anything, it's less obvious than the
> comments for some of the fields the patch is adding.

Well, considering how many members are not properly populated (for tests
though), and other members like "orig_start" only makes sense for
non-mergeable extents (compressed), I strongly doubt if the extent_map
itself designed is that obvious.

>
>>
>>>
>>> Holes can also be merged of course (e.g. read part of a hole, we
>>> create an extent map for that part, read the remainder of the hole,
>>> create another extent map for that remainder, which then merges with
>>> the former).
>>>
>> [...]
>>>> +
>>>> +       /*
>>>> +        * The full on-disk extent length, matching
>>>> +        * btrfs_file_extent_item::disk_num_bytes.
>>>> +        */
>>>
>>> So yes and no.
>>> When merging extent maps, it's not updated, so it's tricky.
>>
>> And that's already found in my sanity checks.
>>
>>> But that's ok because an extent map only needs to represent exactly
>>> one file extent item if it's new and was not fsynced yet.
>>
>> I can update the comments to add extra comments on merged behavior, and
>> fix the unexpected handling for merging/split.
>
> Fix what?
> It's only important to be accurate for extents that need to be logged
> (in the modified list of extents), and those are never merged or
> split.

My bad, the "merged/split handling" is for my new sanity checks on the
extent map structure, which cross checks the old members
(orig_start/block_start/block_len) against the new members
(disk_bytenr/offset).

It turns out certain members do not really much sense after merging.
E.g. orig_start.

>
> Otherwise it doesn't affect use cases other than fsync.
>
>>
>>>
>>>>           u64 orig_block_len;
>>>> +
>>>> +       /*
>>>> +        * The decompressed size of the whole on-disk extent, matchin=
g
>>>> +        * btrfs_file_extent_item::ram_bytes.
>>>> +        */
>>>>           u64 ram_bytes;
>>>
>>> Same here regarding the merging.
>>>
>>> Sorry I forgot this before.
>>
>> No big deal, as my super strict sanity checks are crashing everywhere, =
I
>> have already experienced this quirk.
>>
>> So I would add extra comments on the merging behaviors, but I'm afraid
>> since the current code doesn't handle certain members correctly (and a
>> lot of callers even do not populate things like ram_bytes), I'm afraid
>> those extra comments would only come after I fixed all of them.
>
> Well, as mentioned before it's ok for some fields to not be updated
> after merging, and to a lesser extent, splitted.
> Having all fields correct only makes sense when the mapping to a file
> extent item is exactly 1 to 1 and the extent is new and needs to be
> logged.

I'd say, even only for the sake of consistence, we should populate every
member correctly no matter what.

That's why I'm adding strict sanity checks for all extent maps (only for
DEBUG build).

And it already exposed several bugs:

- The @block_start mis-calculation fix you just commented on
   Thankfully it's harmless

- Weird ram_bytes generated by g/311 test case
   We can create a file extent whose ram_bytes is double its
   disk_num_bytes, and is not compressed.

I'll spend time on pinning down the ram_bytes anomaly later, even it
doesn't cause data corruption.

Thanks,
Qu

>
>>
>> Thanks,
>> Qu

