Return-Path: <linux-btrfs+bounces-7012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A97949AFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 00:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00D1B279C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098F16EC0B;
	Tue,  6 Aug 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="b5CNSkzz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D614C59A
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982264; cv=none; b=iJ011eM9BZKtNKZcHaaKqUi5BBM13VqRK3MXX380bf7KuolVEbH2jmAAzUPPuek6iBDWXg3GzEVhCq2+h+cbFrQZuMS3qUEfMoX2N7jevL7YcbRMYFq9DNWrliDnm3pYvFnrpPZKNRb/JBfep0KeD+WHwrHApqBCxVP+eYOgfZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982264; c=relaxed/simple;
	bh=oB1yBzrV67eCu8+oKu3wm/TD5swQolh07NXG/hiclcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FPG1uKnDEtxPsz9kawpETD9Vf1QWdEiye55E6gaaxuh6tbBofVNIB+R3FEl3p/rmyiiKS32ssQ2R5EAvEKJQKdsQHuTB3EeFwLutjI8d2kDRDdl+1ZJq+MhlNwQPSRQdWsicUXl2r9GELyNmT62Z6DJStKkQqIP8tSEbSivjpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=b5CNSkzz; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722982259; x=1723587059; i=quwenruo.btrfs@gmx.com;
	bh=oB1yBzrV67eCu8+oKu3wm/TD5swQolh07NXG/hiclcA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b5CNSkzzt36RcxOi4/NaZvQUXHrZjUpQCAAi3i7U9ta+5acB1dpmki5U4r4cG+LO
	 hk0kcK92u1IA77tq7Y+xaMi2ho2aDvbR0RKCw8WTo1BTa0DnLxQV5l6o0ga/jWPAo
	 lGMuKcM2BBoagtpmN9EcBM/BLL2/IuOUFIIY5/mJt/7QYpotuqDRI4JXeBXpS/Yj1
	 FPijeGfd3UivSix6gXwdM2NWde00VyfsbtgHlctdjiVGpCYHvG/Z/wadO8nFXVMf8
	 Li9rKOZfqglYKH6cjqyLPgnw9YqWdZMIbshSPHC61jSH1E4aIlZNdGvoflWHT6Zku
	 kPJfYJe6ZAO0a1dFuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MtwYu-1sN4oB09Zk-013nIX; Wed, 07
 Aug 2024 00:10:59 +0200
Message-ID: <55a368af-ab0b-4bb8-b61b-53d20b163d63@gmx.com>
Date: Wed, 7 Aug 2024 07:40:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 'btrfs filesystem defragment' makes files explode in size,
 especially fallocated ones
To: Hanabishi <i.r.e.c.c.a.k.u.n+kernel.org@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <d190ad2e-26d5-4113-ab43-f39010b3896e@gmail.com>
 <7a85ea4e-814f-4940-bd3e-13299197530f@gmx.com>
 <90dab7d5-0ab8-48fe-8993-f821aa8a0db8@gmail.com>
 <0f6cc8e0-ab32-4792-863e-0ef795258051@gmx.com>
 <837fb96f-989c-4b56-8bd4-6f8fb5e60e7d@gmail.com>
 <bbec0e87-8469-488b-9008-f7d85d5ee34c@gmx.com>
 <62433c69-5d07-4781-bf2f-6558d7e79134@gmail.com>
 <e72e1aed-4493-4d03-81cd-a88abcda5051@gmx.com>
 <ef164317-6472-4808-83cf-acaa2b8ab758@gmail.com>
 <d089a164-b2e8-4d29-8d96-41b12cbfae42@gmx.com>
 <30687f37-32e9-4482-a453-7451ab05277a@gmail.com>
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
In-Reply-To: <30687f37-32e9-4482-a453-7451ab05277a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Zujsu5cB0HoSvzRx54yUWOQMW7HsXmfvSj25KO0fRsOFsbG2fo
 94mxmWbh6fctra4aPBnuTS5HcudBocrpl+Q9HLo3Guz1cHFqiWLLO5a/+EbUoza1IpJvRww
 BwxHOCvT6GrvgnmEfhd3bqPXCNhpa5buR+FYjoOtxPuqVMBb2L3etduuNLNpztWpSUCCH8d
 jx0wYW+qmWZ+AO97l/egQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MdDwPkVZdUE=;7c+7Zm/sIEiwMQGCXyZHRoDTYM/
 MAbVkFNi4GNH+sFPqFhyCpSCNFamtD/gqtNq1srRG3V6BAnixfAixG/QQpaG8ZpE+8WTqxuSD
 /oquDUbUv0MJHhJg2Q7q8hHePEQP+RLk0DSXNxcTtUXNyhHusK3UMem1EYs31N0Bqs5/9S8uz
 Cn9B6RisnInIOkKguXdEx4Hc08E1Ombc8UFjzSA8jQPSKOh85u8Zbdlv4fYwC9zRgNUrIocum
 c7jFi0/Ely/4cXpRYAprapGQq636yrVEnWx8bx7on59PArmrg1n8E+8z2fb5H3e2ntMDy6mfa
 0bdMZAz5EXY21CFqx8VTBTvaPrLWaGc/vspLkKTLVCxaNAWZpsF4OdTcfuT9DXEOWdCgu7Ihl
 tC4VuIARK/vXl0TNdxb8+GJgk0uJzU/ksYmddravs7EG2qG6DOxMCtB2ACA6UeEHICaGNs6vv
 gHrS9+qYQpzv0Rc9m/6MRkCid/GqLSva33Neiy6g52tSyfwVX3Y3WZ680ZvkZ0g0LAkSxsILd
 +3w44pnB0ndwkZdlH+JbldxYTH7jmKNALtAUQoh+XEkG/LzdPea0mFxR3HHpqYjXBLiCkQR8R
 JPnHADXiNRlkMagE0mzveWQxZT8fT2nzl7Ozpce66JyVnbJKxwxnTAg57wz/DhqvPkYifl6s+
 VkxD9dq+zuq4IvTXeWt7El0wOYhOyXW5Di3pu0dhRLYHUeLWIhX50UHYhwjCKrUFLTXXihAiw
 1ne767hUwWyA/OUOK/uZK9alaz5URMuDnxBKpze/PA61hVlbkWCJ/+qcf/G6cnevQX4BGxxbi
 89axQXZDUCqLJMhFfHl84Uxw==



=E5=9C=A8 2024/8/6 21:38, Hanabishi =E5=86=99=E9=81=93:
> On 8/6/24 11:23, Qu Wenruo wrote:
[...]
>
>> If we try to lock the defrag range, to ensure them to land in a larger
>> extent, I'm 100% sure MM guys won't be happy, it's blocking the most
>> common way to reclaim memory.
>
> Hmm, but couldn't Btrfs simply preallocate that space? I copied files
> much larger in size than the page cache and even entire RAM, they are
> totally fine as you could guess.

For preallocation, welcome into the rabbit hole.

TL;DR, preallocation of btrfs is never reliable, it doesn't even ensure
the next write will success.

The biggest reason here is snapshot.

Even if we preallocate the range, the end user is still fully allowed to
do any snapshot.

And a preallocated range shared by multiple subvolumes will never be
overwritten, causing the same problem.


As you have already experienced, if set to NOCOW, everything will be
(mostly) fine, just as all the other non-COW filesystems.

But you're using btrfs for its super fast snapshot, and that will force
data COW, causing all the complexity.

> Is moving extents under the hood that different from copying files aroun=
d?

Ext4 uses move_extent to do defrag, but unfortunately we do not go that
path, as mentioned even preallocation is not reliable.

>
>> IIRC it's already in the document, although not that clear:
>>
>> =C2=A0=C2=A0 The value is only advisory and the final size of the exten=
ts may
>> =C2=A0=C2=A0 differ, depending on the state of the free space and fragm=
entation or
>> =C2=A0=C2=A0 other internal logic.
>>
>> To be honest, defrag is not recommended for modern extent based file
>> systems already, thus there is no longer a common and good example to
>> follow.
>>
>> And for COW file systems, along with btrfs' specific bookend behavior,
>> it brings a new level of complexity.
>>
>> So overall, if you're not sure what the defrag internal logic is, nor
>> have a clear problem you want to solve, do not defrag.
>
> Well, I went into this hole for a reason.
> I worked with some software piece which writes files sequentally, but in
> a very primitive POSIX-compliant way. For reference, ~17G file it
> produced was split into more than 1 million(!) extents. Basically
> shredding entire file into 16K pieces. Producing a no-joke access
> performance penalty even on SSD. In fact I only noticed the problem
> because of horrible disk performance with the file.
>
> And I even tried to write it in NOCOW mode, but it didn't help,
> fragmentation level was the same. So it has nothing to do with CoW, it's
> Btrfs itself not really getting intentions of the software.
> I'm not sure how it would behave with other filesystems, but for me it
> doesn't really look as a FS fault anyway.

To me, any fs will follow the sync/fsync request from the user space
process, so if the tool wants fragmentation, it will get fragmentation.

>
> So I ended up falling back to the old good defragmentation. Discovering
> the reported issue along the way, becaming a double-trouble for me.
>

In that case, if you do not use snapshot for that subvolume, it's
recommended to go with NOCOW first, then preallocate space for the log
file. By this, the log file is always using continous range on disk.

And finally go with defrag (with high enough writeback threshold), to
reduce the number of extents (fully internal, won't even be reported by
fiemap).


BTW, forgot to mention in your previous reply mentioning the powerloss
of a fs, it doesn't help btrfs at least.

Even we aggressively writeback the dirty data, our metadata is purely
protected by COW, and a transactional system.

It means, even you have written 10GiB new data, as long as our
transaction is not committed, you will only get all the old data after a
power loss (unless it's explicitly fsynced).
That's another point very different from old non-COW filesystems.

Instead "commit=3D" with a lower value is more helpful for btrfs, but that
would cause more metadata writes though.

Thanks,
Qu

