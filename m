Return-Path: <linux-btrfs+bounces-2338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFEB852249
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 00:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C9C28534B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 23:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595D4F8A3;
	Mon, 12 Feb 2024 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HzoGk2S2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92A4F896
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779199; cv=none; b=DdXdLu2tWT//PwSKPj6khVXZcSCRwCgzisgBsypOVF4xQjxJRel/ZJivBnEWnX01TqdjnCpSQprkBpmiqviAZlnE7xTNzuZ5hYyTbHbsF7eHEX4Zu/0RdKWOnFTDXZbT3V2w1k41CC0LZWRhV51ItwSkH0mYgiJ55JK1+Yep8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779199; c=relaxed/simple;
	bh=LMytGpJC5TLH1uHrE5fVfyUHvH/Ug9QjadgSdY7VnGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l622uN33gn8OuI1lOWTCC2rZdyH73s4HNnRZulzwF0sFWZNsl36oEtFDlfCphAFq9xByWVefJMFpuy8Sprn1D1aknnQkmiq8CmaY+iLBSGEWEzHVVqos4Qpq0e9ui7YECvScP5AFIaiDWEjjpAzu9YL9baKKFxCzUMyy9LOvGm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HzoGk2S2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707779189; x=1708383989; i=quwenruo.btrfs@gmx.com;
	bh=LMytGpJC5TLH1uHrE5fVfyUHvH/Ug9QjadgSdY7VnGc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=HzoGk2S2sHLDfi4y7BDdGn8hBBlTRTqXbcRSNEg4lssUHvQr253fOSJ0Oqw/zN1e
	 gtXZOaIDzy4W90CAY/JF/+FUQYAX7FOYklALpgRsXS/NAMwRvvP5cFIkSBwarb1gA
	 QYRznTVnZ0tJafqNe4I5U5rFItBpEDEkcP6KnkRQyddiRfsT5KcG9/qiEVBV98uMq
	 QM7N9aBcIBIBfwF6UQDSc75ZyrNY8vOuKU0/gMDJPBKVw82UXf++a6cn914H3Tcoo
	 Od5AqZVtyaln/mdryrhR3cag6JKHICBvYJ1lTXrEcfuBblwHryO8NJkyumN8bCBDe
	 N5U1pi4X3yjd1BIIgg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7b6b-1rdGPZ3qE1-0082uP; Tue, 13
 Feb 2024 00:06:29 +0100
Message-ID: <1268fba4-de90-44c6-8bfa-382f5faad2a0@gmx.com>
Date: Tue, 13 Feb 2024 09:36:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] btrfs: remove non-standard extent handling in
 __extent_writepage_io
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20230531060505.468704-1-hch@lst.de>
 <20230531060505.468704-11-hch@lst.de>
 <91eda445-e58c-4fab-ae49-a10951edfa8d@gmx.com>
 <20240212155230.GA29259@lst.de>
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
In-Reply-To: <20240212155230.GA29259@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j6eGkeHwfXodQoGXSYOPIvnWLuegANTQxYQd+eHibjrFqBiOYYN
 Bo84AlBh66jV9bilPRrG0OA5bPOD0s+mgRl4o/SN3czKVu/1ibUu9KbQLqJDjWNFFPGgaQ2
 T+MSAEwBSgccwCg/ttga3GqYJnuA9bUuEwyAMCA/qK/H5QFAEtgRtUj7jUF632LL4B/ewQI
 Li+TM+2eGubbkaqf80RxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xitc8T64q9U=;RVb7te651G1lWB/Rb0hIydMQW5z
 bCQ106Fjy0wURMOyPIPvtqop8qh5nwJjy3X94YFK8CKFNDZJicGvmS18ZGACoD/lnSjtvPy69
 gX89DextkjUDPCrvH5+AV+I1CPn7ZWbpyZEBdSNKuYNbRIhKMgKwiEPq1la9ITC/Mx+7xwUpf
 WKfe7u+tTh6VtLNG3cX5Quwn6aszpvHL4RMxPKiQHvdMWF0kC1DimIoBPoJgFOZ42IWfV8Mjh
 oetBZ861CHvXW0Jta1qx2wdHuSR2ymzcgWRRppyifjWrI2tJSmnV+NLt58wA3w4bn+MSs+MS+
 TPFa+bVEWimpZYcOrOhl3gUERlonItPH2KSCgK+x1s+kEg+M5z1DQuHCxcyJG+iS/jM0AT1r4
 H8uRj4h+JR1YmVDo3XGtGZrdlfj+nhO1+ZqVXqoOPWEGnhwaQx5E3/oYBvuaSLQ8N/wfKSpo7
 0BtaIrVEDiaHS+lTPmCYsZ9wNm1ObP1t0U2UyfvTD4Dw7G8ASIZcoaHnFS4v6jxy1gAhZSPo6
 Qh+H3+9OzNuOVfYp9iBZferAxRpm1dySdtCR294lMuJ0g07oAVIpfNK3N8usQFdiU1cZZ8HPP
 VWUf1+6lW0xavdCeH5rpT1Yt7GxHWpww4tYj6qpbypS0ADP6gKtGCo9mzfGlW40hQu4BkuUAl
 +wYV4tKA14AbAQ9p58xH+zofAMyTpxnBGpWuDZr4JVNElnJd5IGqVWuxx088zafWupNgRlyRq
 vocGpQdzmQA7jI1Dun+i660HiaROYPgo450WVDOx9tTQ7856/iuAB01BseUyi/dAMq0CkIrb2
 OZCQ0ybm4RYcB4Sw9LSW0x4F04eA/N69HzqCKt+ZqRHZo=



On 2024/2/13 02:22, Christoph Hellwig wrote:
> On Sat, Feb 10, 2024 at 08:09:47PM +1030, Qu Wenruo wrote:
>>> @@ -1419,10 +1418,14 @@ static noinline_for_stack int __extent_writepa=
ge_io(struct btrfs_inode *inode,
>>>    		ASSERT(cur < end);
>>>    		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
>>>    		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
>>> +
>>>    		block_start =3D em->block_start;
>>> -		compressed =3D test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
>>>    		disk_bytenr =3D em->block_start + extent_offset;
>>>
>>> +		ASSERT(!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags));
>>> +		ASSERT(block_start !=3D EXTENT_MAP_HOLE);
>>
>> For subpage cases, __extent_writepage_io() can be triggered to write
>> only a subset of the page, from extent_write_locked_range().
>
> Yes.
>
>> In that case, if we have submitted the target range, since our @len is
>> to the end of the page, we can hit a hole.
>>
>> In that case, this ASSERT() would be triggered.
>> And even worse, if CONFIG_BTRFS_ASSERT() is not enabled, we can do wron=
g
>> writeback using the wrong disk_bytenr.
>>
>> So at least we need to skip the hole ranges for subpage.
>> And thankfully the remaining two cases are impossible for subpage.
>
> The patch below reinstates the hole handling.  I don't have a system
> that tests the btrfs subpage code right now, so this is untested:
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index cfd2967f04a293..a106036641104c 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1388,7 +1388,6 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   		disk_bytenr =3D em->block_start + extent_offset;
>
>   		ASSERT(!extent_map_is_compressed(em));
> -		ASSERT(block_start !=3D EXTENT_MAP_HOLE);
>   		ASSERT(block_start !=3D EXTENT_MAP_INLINE);
>
>   		/*
> @@ -1399,6 +1398,15 @@ static noinline_for_stack int __extent_writepage_=
io(struct btrfs_inode *inode,
>   		free_extent_map(em);
>   		em =3D NULL;
>
> +		if (block_start =3D=3D EXTENT_MAP_HOLE) {
> +			btrfs_mark_ordered_io_finished(inode, page, cur, iosize,
> +						       true);
> +			btrfs_folio_clear_dirty(fs_info, page_folio(page), cur,
> +						iosize);
> +			cur +=3D iosize;
> +			continue;
> +		}
> +
>   		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
>   		if (!PageWriteback(page)) {
>   			btrfs_err(inode->root->fs_info,

There are more problem than I initially thought.

In fact, I went another path to make __extent_writepage_io() to only
submit IO for the desired range.

But we would have another problem related to @locked_page handling.

For extent_write_locked_range(), we expect to unlock the @locked_page.
But for subpage case, we can have multiple dirty ranges.

In that case, if we unlock @locked_page for the first iteration, the
next extent_write_locked_range() iteration can still try to get the same
page, and found the page unlocked, triggering an ASSERT().

So the patch itself is not the root cause, it's the lack of subpage
locking causing the problem.

Sorry for the false alerts.

Thanks,
Qu

