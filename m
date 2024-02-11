Return-Path: <linux-btrfs+bounces-2306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711628507BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Feb 2024 05:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2797F2842DE
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Feb 2024 04:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04CA125CA;
	Sun, 11 Feb 2024 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rsJmkzH9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B1B11182;
	Sun, 11 Feb 2024 04:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707625356; cv=none; b=UspkSw525gebm4pzkjzHvHjpzjzb0TAzBaG80XYGXJtVwVsAQJvviSkkRMCBXASgUJL46FosvwFbcQfs0xs8IAf+ssJ4hn4e1JJUJyCaFkuBYYmsZpWScP1gpXu1tb5fIRJkr/z4UA+gqNQE4n0JwawgYLFE4MasUfsNkvg7lZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707625356; c=relaxed/simple;
	bh=onkhBhLNd/UzHJoZGIWoBTaGREzZBHhH/lrdzL/mwBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MScGgYFNO6Td7LbC5uzKJoz2lxoy7kkvGf4gHH7uuvD6r13yshEbKfCHJhCDZ9/T/78zK6ZXUY2eI2YiuYrR3OG6cnHtcScqlAdEpekG/auPa8pFaE3tMEUs7TOeTWihHNsqQV4MTN2JPyliGXgbKgy+AZ8evvOPTI8mDsH3wCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rsJmkzH9; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707625350; x=1708230150; i=quwenruo.btrfs@gmx.com;
	bh=onkhBhLNd/UzHJoZGIWoBTaGREzZBHhH/lrdzL/mwBo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rsJmkzH9XqW+JwddpxZWGnb+oFMa7Z9DFti04OSKEKi3AlXuvzbWPnsJZhjMnk7u
	 RAqjtb/yj7xHxlRH0mlFIERUsx3zMzWwLu+bpU8y7W4OJuFtYz0f5KKysYuKP83An
	 6Ztq0syi2QYXmViSwbJSAdaMezTDlaWg+wZBaue8ZHHNSweLrmB4uklk2IjcQiez7
	 C2QuoxUxvNz7G45IJeRXjn7spONnpdUD7D/VhB3UL1+l2ZAup5MXpD85WiU2DtH42
	 NU36ruvAVku83OElSafpo26R+RxiS7gdPD3RNGitD8x2/mcsnHfa9EHUmFkuF+vS/
	 PbbG2NHYXa5Z/YFgMQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOzOw-1rKfNJ1t2C-00PPbe; Sun, 11
 Feb 2024 05:22:30 +0100
Message-ID: <ee3b5a77-fc48-411d-8c1b-71bea5789d14@gmx.com>
Date: Sun, 11 Feb 2024 14:52:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
Content-Language: en-US
To: Celeste Liu <coelacanthushex@gmail.com>, wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
 <20240210143411.393544-1-CoelacanthusHex@gmail.com>
 <4fc1b0c6-f84d-43c7-b396-695658c7fcb4@gmx.com>
 <36af140d-63fd-4339-a4ed-b0068bfb5918@gmail.com>
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
In-Reply-To: <36af140d-63fd-4339-a4ed-b0068bfb5918@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oc3qACjnWuqscNi2lqHHiZAWSBN7WHsNLSOTFi0nu+fHFb/k79A
 wP56+j1t3RaTFfQShiUZJaqE9ONQiqTdiioGn+eCjkb9Mfpcde9I4P7y+zrLgkUX8shQaiO
 Xf2NIC3CxyALu2R4am5m1TWTEELK1WX9Ql8Tz6Wp3nPn9dlICU7/wisSpe8q4nDJK+s/2i/
 dshiNmor+x/adzdK5xDyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HXfdsYG9q9w=;2twYzBQ/ti/ayPaVgYC873j6HdI
 Q/mB+gRDRiDRXzBDxLjtuOGPHeI0faG5mSQqp/3GVPSnzFtcITbIpOVAossNOp+mFomxyB52m
 EY9OhC2WJvpdBLAch3r+xwbLy4XFFiRDQs+2UcqhYy0aYV/B0iu6yoTMaw/ngL3j6pWmtPvPS
 t7LBsub58JaItVV7znvnUmRr6u9gZewFN5EscAM3w39/JPW1rgwqfi4I/33tb5Gwwfovw6caP
 6eQo9YL9E8WqkilWdt+6v3Cq0ulWxJ4AtB6Bl3vAZGq98aUfZ8rUNYJgV987GeLUiEZebrVe/
 ECtg1h5IREOa29XYQxihN4xUCzstMPG2oEY4cnJE2wysOed/GkJ+7rLo2OHZi8y+dI073ngO1
 WRdu3oIVGmtc2W18fLKNWoSZf7/Fmga7QgExFUY4Tkq12ijmX7vvqb2ey7iGM9/q89MRHvz3y
 NKTJ/s/28ch2RAXqzov3S5OMTc2+jnCus7YeBPKafBvOwvpEbNQi788uO1xWiSKlO4gfooAy0
 r/QkrMbxn/6Iy6Enb6q0ZEvAyo8iSp608qY+w+UOaZMGxYxIzldXG/Mjcqbe0LDULmoOvMOCP
 Nx/ryoaA/pcK3Wlg6cwDo1qVjVP7pc7CQj33ccIxgIKnpcrcwEHtBPeQYJJPdCYkyyyRq/2x0
 NNiPvYnNKDCCoNbayWJJ047zfRs3KdVOjd5fAB7d0V4R3c3W3Dk1bWVTTXxZ8v5/0LtvZQ3jK
 q/hxKI7BbdsQBdb3V+yLqT67VPzI8fNQa0+lHy3ZDgSTOTbcJsjQk4qQX8CtY1MbE7N5ut5Hk
 0adHqZvTPLIGX9Ko5KsDAQuqn/4sZzKJDahjAu17GOm6U=



On 2024/2/11 13:43, Celeste Liu wrote:
> On 2024-02-11 03:58, Qu Wenruo wrote:
>
>>
>>
>> On 2024/2/11 01:04, Celeste Liu wrote:
>>> On 3/2/23 09:54, Qu Wenruo wrote:
>>>> [BUG]
>>>> During my scrub rework, I did a stupid thing like this:
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bio->bi_iter.=
bi_sector =3D stripe->logical;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_submit_=
bio(fs_info, bio, stripe->mirror_num);
>>>>
>>>> Above bi_sector assignment is using logical address directly, which
>>>> lacks ">> SECTOR_SHIFT".
>>>>
>>>> This results a read on a range which has no chunk mapping.
>>>>
>>>> This results the following crash:
>>>>
>>>>  =C2=A0=C2=A0 BTRFS critical (device dm-1): unable to find logical 11=
274289152 length 65536
>>>>  =C2=A0=C2=A0 assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:63=
87
>>>>  =C2=A0=C2=A0 ------------[ cut here ]------------
>>>>
>>>> Sure this is all my fault, but this shows a possible problem in real
>>>> world, that some bitflip in file extents/tree block can point to
>>>> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSER=
T
>>>> is not configured, cause invalid pointer.
>>>>
>>>> [PROBLEMS]
>>>> In above call chain, we just don't handle the possible error from
>>>> btrfs_get_chunk_map() inside __btrfs_map_block().
>>>>
>>>> [FIX]
>>>> The fix is pretty straightforward, just replace the ASSERT() with pro=
per
>>>> error handling.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> Changelog:
>>>> v2:
>>>> - Rebased to latest misc-next
>>>>  =C2=A0=C2=A0=C2=A0 The error path in bio.c is already fixed, thus on=
ly need to replace
>>>>  =C2=A0=C2=A0=C2=A0 the ASSERT() in __btrfs_map_block().
>>>> ---
>>>>  =C2=A0=C2=A0 fs/btrfs/volumes.c | 3 ++-
>>>>  =C2=A0=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 4d479ac233a4..93bc45001e68 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_=
info, enum btrfs_map_op op,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
-EINVAL;
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em =3D btrfs_get_chunk_map(fs_i=
nfo, logical, *length);
>>>> -=C2=A0=C2=A0=C2=A0 ASSERT(!IS_ERR(em));
>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(em))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(em);
>>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 map =3D em->map_lookup;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_stripes =3D nr_data_stripe=
s(map);
>>>
>>> This bug affects 6.1.y LTS branch but no backport commit of this fix i=
n
>>> 6.1.y branch. Please include it. Thanks.
>>>
>> Just want to make sure, are you hitting the ASSERT()?
>
> No, in non-debug build, ASSERT() is noop. So em will be a pointer whose
> value is errno and there is no any error handle for it. And then it
> trigger kernel NULL Pointer Dereference exception in btrfs_get_io_geomet=
ry()
> with em->map_lookup (Of course, it's not 0 but 0x5a
> (-EINVAL + offsetof(map_lookup)). But it still is a illegal memory acces=
s),
> this kernel thread was killed but the lock hold by this thread are not
> released. After that, all fs operations was block by the lock.

I know, what I mean "hitting the ASSERT()" includes the cases where
CONFIG_BTRFS_ASSERT is not enabled.
As it would lead to an obvious invalid memory access immediately.

And lock/resources thing is the last thing you need to bother, as long
as the kernel fs module triggered invalid memory access inside kernel
space, it's busted already.

>
>>
>> If so, please provide the calltrace and btrfs-check output to pin down
>> the cause.
>
> It doesn't happen on my machine, I've notified the finder to send a
> backtrace to the mailing list

It's better to allow the reporter to send needed info directly to the ML.

Trust me, working with a man in the middle is only going to slow down
diagnosis and fix.

And don't forget "btrfs check --readonly", as on-disk corrupted is also
a very possible reason to lead IO out of chunk mapped ranges.

>
>> Just backporting the patch is only to make it a little more graceful,
>> but won't solve the root problem.
>
> No. In non debug build, ASSERT() is noop so it lead that there is no any
> error handle code. There is no RAII/SBRM, unexpected exit will lead the
> resources will not be released correctly. If it has unique holder (e.g. =
mutex),
> it will break all other code that need this resource!

Sure, but even with a backport, it would still cause (although graceful)
errors when such IO is triggered.

Hitting the ASSERT() is only a symptom, not the root cause.

I can definitely do a backport immediately, but I'm more interested in
the root cause.
What if it's caused by another hidden bug?

Thanks,
Qu
>
>>
>> Thanks,
>> Qu
>
>

