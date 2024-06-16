Return-Path: <linux-btrfs+bounces-5746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D29990A078
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 00:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9021C20BC9
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14036E614;
	Sun, 16 Jun 2024 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YF1DGYg5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D756BFA6
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Jun 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718576094; cv=none; b=hGxQwMmusHQeue+cDDO9S0WbAOZooHkx4xQeN7ICcdgHNMHRKy76hmxlehE2R29dPH/ydOArcCgArF4keXteSbe9LLLaGeZXZ++of1aoIs8w5Rz7hCn5m5+tIr0n4jaY75FPiVhq2T4ONbTvf93+4zLWDdxEk6/uJHzp1b4KhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718576094; c=relaxed/simple;
	bh=hwxVgRH3Ssyq1BmZqoJ/vUWc+ul9bqbQIhLp1J+Dh9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZZvMOd26ijAcnYhcRoKdkIYQ34ZDb2NboszdzEeFwbxxSrFC2qC39x0QpIfWPJup0e8X2sS47JdsiyGWzmZoHvxsma8cWfgSVA8kT4ndxVSSBwF/vlR4aCVRAkDTwmQFjhP69OBRI8w/hkEW2xq6S52BdZHK43MNMkEpfDAMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YF1DGYg5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1718576081; x=1719180881; i=quwenruo.btrfs@gmx.com;
	bh=hwxVgRH3Ssyq1BmZqoJ/vUWc+ul9bqbQIhLp1J+Dh9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YF1DGYg5ok0LQBMmJMTYGqY89UWn76gUoiSrv8u0Bv+ZDbtlVKQytSlo/oGfpOUM
	 c7JQ0qLJAV59AepJwnhw24XZ6TrHAtE/c0Zu4pV+nrQFC6cZCQoSZD6Vm+MOu1NpY
	 aVKu9EOk4eoiretcYHFDs3omCAJxOqaZdUtRrow/O/Dq5164Ug/Un5baViUS8i2so
	 8UZk87LtCkYg4E3Uu5NmIooQmRr1fjngYPGBjsKjFW/3JPP/0r+lgumD4kj1MPReI
	 cq4jhTKRr3YJ93QIQivqYnoslNT38mu0WFd4GZmT480Gw0fKU+KqbUwwN3wojuJRG
	 +fVO5rn1vPFGrQxykg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgesG-1stQxI3M9k-00iZ3q; Mon, 17
 Jun 2024 00:14:41 +0200
Message-ID: <cfa1ca63-0bbe-4287-b941-0b064fa0a489@gmx.com>
Date: Mon, 17 Jun 2024 07:44:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] btrfs: scrub: don't call calc_sector_number on failed
 bios
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Qu Wenruo
 <wqu@suse.com>, Johannes Thumshirn <jth@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
References: <20240610144229.26373-1-jth@kernel.org>
 <16516c00-845c-4cb8-9bb5-6e5e38bc71c3@suse.com>
 <a04c6fb6-bd77-400e-a80b-178dd2e6c582@wdc.com>
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
In-Reply-To: <a04c6fb6-bd77-400e-a80b-178dd2e6c582@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UI9tQEBSLmN+JqOPdtToOvN2D6l+d2Mg28Q0i7LkEyhqoir7nG8
 EDBHFcnUwnI3gjM2JbKBcreEZViR5OREAEqdLPqLhN/xDuTGlB6CwtALytaro+9lBw8/bug
 3U6tz7EPufH2MMWm24/E3BomA+gEIe3uw+bbdGWbh2bjCdK0757tlTHbo2jpGiEU2cPxDUn
 HJHgYLYM0M5rymZiENLKg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+RjHBcE77Kw=;hvnoV+dNCwf1cHjwiaj1I7BCsGd
 rj2JNrysxs7Cj1CSRfO2q9CmG9RM2YGMtTFICkg14RfK1oEg4qqs7gn+24tN7K9A/KPHD8bS2
 ze9U1zuIjBpMev4WuicPspelD/OHxUUD3rnccJUQ05Ofmua/r1SOad/iBoktMnjyzWV/ABEkH
 T52lwC47Wa4MHNABeaHgFntPCqyerG8Mz9AlXYqeeS+ezxDRb1CWFjaHFLB7OmpYJPe4H7L2h
 2bcmzVj4xOrZvE39hDS/NLaVlPZIRwvKASGgZo2uzY1VdbTCWnSzEWJc77U8uqm9H/JGZvtzt
 EkgXIGaX1JdPCx1m+nJzo37JAqe/NQ8JXctkuhYgrEeeCULohy1NgDB5sBQowT2Yg1KoiPX2P
 m7Ps7CA/q2A7Iy56TqIcxI5LZbVan6GN+Nj7azJfd0bwhDfq5KI1eobTWtV41QDixqFfd7rtO
 oOhq4RLgYYV/h3CLpShtz57S6u6ESXDnjvblsrB1uqkP2I+rANTNkXxP3J78P6NpuNozIp6n5
 14yYzxSCn6GKH7bQlv8TpOnLBqzbuAhTLgNWvtuMf4CyH4nVIwdZRrOKBZ5BH4CAZo9HIXK8k
 SZMZfGovpNG4AWHbrTK0iM7G5+PXJTO43L9H5fA3Zl0QZoqCH1OUdA6gFm5GkY9uGXQWAbpe4
 2ulRfucnd1FYiI3YMy4jYTZtGoBb9PaFudz8tITW8m8fOZe1yMHzpYmBR2i/y3US/i4P5krCS
 09QrFCJYbhL/smwbm0ny2xuTv4kfCMsZGUVtDUinnINGipvugt2fDnkykyegWOGQpxJ1vFHVB
 Fp1OfrspP1SdHUTeFg7jA319zIHVk+IP2TAx0ccMArldE=



=E5=9C=A8 2024/6/11 15:56, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 10.06.24 23:24, Qu Wenruo wrote:
>>
>> =E5=9C=A8 2024/6/11 00:12, Johannes Thumshirn =E5=86=99=E9=81=93:
[...]
>> I'm more interested in why we got a bi_vec with all zeros.
>
> Yes me too, hence the RFC. TBH I was hoping you had an idea :D
>
>> Especially if the bv_len is 0, we won't update the error bitmap at all.
>>
>> So it's not simply ignore it if the IO failed.
>>
>> To me it looks more like at some stage (RST layer?) the bio is
>> reseted/modified unexpected?
>
> Most probably. But btrfs_submit_bio() will only split a bio if it's
> needed (due to i.e. RST stripe crossing, etc).

I guess I got the direct cause, but not yet to the root cause.

[DIRECT CAUSE]
It turns out it's not RST layer, but the RST handling inside scrub
causing the empty bbio.

In `scrub_submit_extent_sector_read()`, everytime we allocated a new
bbio we call `btrfs_map_block()` to do a scrub specific map lookup.

But if that `btrfs_map_block()` failed, the bbio is still empty, but we
call `btrfs_bio_end_io()` on it, resulting such problem.

The problem is happening because there is no other error path inside
scrub that can lead to such empty bbio.
All other paths go `btrfs_alloc_bio()` then immediately add pages into
it (either the whole stripe or a simple sector).

[PROPER FIX]
So for the fix, I'd prefer to do a 0 length check first.
If it's 0 length, we do not need to get the sector nr and error out
immediately.
If it's not zero length, go the regular routine to mark error bitmaps.

Meanwhile the RFC fix has the side effect that, if a non-RST read scrub
bbio ended with error, we can wrongly updated the error bitmap (since
the sector_nr is set to 0).

[UNCERTAIN ROOT CAUSE]
Then let's talk about the ugly part, why `btrfs_map_block()` failed?
In the dump, it shows there is no such RST entry found for the target
bytenr.
Meanwhile at `fill_one_extent_info()` we fill `extent_sector_bitmap`
correctly using commit extent root.

This means, by somehow the extent commit root desync with rst commit root.
My current guess is, between we do the extent commit root search and do
the rst commit root search, a commit transaction happened.

This is not a problem for non RST case because we only did the extent
root search once, and in one go, so there is no transaction commit
happening between.

But for RST-routine, the RST lookup happens much later than
scrub_find_fill_first_stripe(), thus it could happen a transaction
committed, updating RST.

My current plan is to do the RST lookup inside
scrub_find_fill_first_stripe too, so everything can happen at the same
transaction.
But I'll need to do extra debugging to confirm the guess.

Thanks,
Qu

