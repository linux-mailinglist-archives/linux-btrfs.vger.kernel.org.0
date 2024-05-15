Return-Path: <linux-btrfs+bounces-5029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67F8C6E5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 00:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732AC1F23592
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1CB15B56A;
	Wed, 15 May 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qSSvPiWU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442033BBEA
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715810585; cv=none; b=gbqOLUqQJH4IgXsLgDXm+XojBM5CNRZ5YBtAYcDg6LcyDbHgxFh3zvBqDT6VLLGuFCdYiAtMWjKPewZqHolcmyI5TZD4i7UwgmGTKXpSHoGN81PG+BeWU8upmoX8ID9gX+WoK61BSqe9txdKMMuKiGjntz/06RvIq5V1cpUsOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715810585; c=relaxed/simple;
	bh=gOwAGPyv5whFt15l3/gVrSFxsRrqAwMUadsynEajCsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bklukowaZtPQ3fS/ubWISmP1gVmwByuCNV8K6RAKPE/b7yYO6FRujw+Ngn1MwyZ3zox72Hcd2147WKWAW2huR2XP3THY4GsssOEfK1BQ5QBk6vYl35ttOh95kRanZkxi4rHRNBrbNqlEKOHfSH5IvEiA1KUnjxjXUou+NEcwQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qSSvPiWU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715810576; x=1716415376; i=quwenruo.btrfs@gmx.com;
	bh=g1JSWAL4cGR3ach0ZtmZB2MhQHfljXYYNLAlRAulE9I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qSSvPiWUuecHdBlRrd8mz4NF8Nh07a6tmA9FNKONDxh9+G3RZXsnFUQe13uPvRsE
	 CyNTXZqiQzPFYwPbN+ag2fQOvlo/y7wplezzmtFVh0/AvVL+izqSATjNcQbOYjJrE
	 AKQAOH7WNaIa+Qeb8fONZ7Qbayb4pUq6xu+hOfclHwVBUtSLz2+r7Q6NVTrcPskDa
	 MPOeTsTnoU0WdIcPgCSuJO1B/9rYNC7IX8kL30DV6x1ls3dBQmAtHb2VUbKPnC0Te
	 wqJxu/TY/e0JEC3zjEbTAF9fgF6/ZIRHXf0BwtRBchDx23TRPbEHky+D68/hJxQrt
	 QFJnW05ZiZDs+nqXPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1sfsiV04pT-00bIMi; Thu, 16
 May 2024 00:02:56 +0200
Message-ID: <879bf1fa-14ce-44b1-93ba-258701ebab85@gmx.com>
Date: Thu, 16 May 2024 07:32:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: immediately drop extent maps after failed
 COW write
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715798440.git.fdmanana@suse.com>
 <c9d7a03ee9730e1d864cb6fbe2d511dd8899a953.1715798440.git.fdmanana@suse.com>
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
In-Reply-To: <c9d7a03ee9730e1d864cb6fbe2d511dd8899a953.1715798440.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ku5eZVjkAcTUwgAhrb+loWeMOcNS2I0uVbv0IAeEE0S5wdTwUNW
 sdDvP9s+H/Vox5tneLwpf2WYEJGzJPDrlHCgB3nzwUJ1XvSYl3iA2AfUVwHnPJjTRVCTPL+
 cn+ERc17PCzoNn5GLdVOdZ5y90gQrV89RKIPAUidH8ndNZWhlVstcyryXJ8ulyZU8Q2dxCW
 jlD6oGB6Fm8xlTLVnB9oQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zdgir0bFks4=;vZ4TUpwqrmPp0mJslyEHwOL4X0x
 3cX3evjDrYi9fEPjYDOJBKCTOpryuPy2/riu2raft5yQ4F6KC6Dfx7pXprlcCWlQc6zj29ynJ
 v6agaFA7S4pZBLhLUbsDyG5kHQv9AiPeRC9MHaX9ZRxLM6KYgH8YjPfvUmjhNqFI4hqMEjq+r
 eMF3WDFy9DgiG9N2JCyKskU7OCmQrxYk2f8zDytx1mgh8Y806mHLQjWXCr4On1gNP9bnU8f/t
 U68Fpq6iZonVKT8+yrNntN19xWyD4rw0tlJPQomsgmhR6YokS5r4j3DStd/NOXcbbAZQMioTs
 iHjdqf32VQpE+92je1So0GKJEDhDez6Uki7lOrkrAhjt5O6ey2G3PbmeGtiaXWD3QGE7hKbst
 4ggG8SWydrXL0DXy0KHJdjR07b4tFOX/f9a53RfrEy+niIkAVxrMQnDf0xYia8Lzo9ZNgGxGB
 gUC7ZG8naw5xTjXPjQ0IJWlYjfJ8QMKzEwIMSK0+KwPcKb4YNlV+7jnqPS7SDlNN4XuDY+tow
 wa+hXSiqTdtq7fwZd+DpIMi58Jrh/lC3F6i2++kvMHFSCPP2yNRwhkINITjAPcrjjiuKWJAu2
 Yc1tIn1n+aAddamIACVEqKIJZkGuGi8YIvvzK7vTzsxq5vWZ4splV9FtaLFJzTNVdXkRpmrW2
 YURfCe9iKMLOv05dI2/EMiL4Jpz9/BI8RZFJhhsQGXCU2eKiS8QpxF+e/lzhSgbczMSFaZ0wQ
 sSUHjkel7xci+XBT9uonwOWfTQg9IgwlFod2X/TJonL/0SR4DSQxLzzhJUL7j2hC1+9bwJcRA
 cLvyzKDJFczdt8Xmj9aX9H2GwUVZ4Tm8TjscfXFAsAHp8=



=E5=9C=A8 2024/5/16 04:21, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> If a write path in COW mode fails, either before submitting a bio for th=
e
> new extents or an actual IO error happens, we can end up allowing a fast
> fsync to log file extent items that point to unwritten extents.
>
> This is because the ordered extent completion for a failed write is
> executed in a work queue. This means that once the write path unlocks th=
e
> inode, a fast fsync can come and log the extent maps created by the writ=
e
> attempt before the work queue completes the ordered extent.
>
> For example consider a direct IO write, in COW mode, that fails at
> btrfs_dio_submit_io() because btrfs_extract_ordered_extent() returned an
> error:
>
> 1) We call btrfs_finish_ordered_extent() with the 'uptodate' parameter
>     set to false, meaning an error happened;
>
> 2) That results in marking the ordered extent with the BTRFS_ORDERED_IOE=
RR
>     flag;
>
> 3) btrfs_finish_ordered_extent() queues the completion of the ordered
>     extent - so that btrfs_finish_one_ordered() will be executed later i=
n
>     a work queue. That function will drop extents maps in the range when
>     it's executed, since the extent maps point to unwritten locations
>     (signaled by the BTRFS_ORDERED_IOERR flag);
>
> 4) After calling btrfs_finish_ordered_extent() we keep going down the
>     write path and unlock the inode;
>
> 5) After that a fast fsync starts and locks the inode;
>
> 6) Before the work queue executes btrfs_finish_one_ordered(), the fsync
>     task sees the extent maps that point to the unwritten locations and
>     logs file extent items based on them - it does not know they are
>     unwritten, and the fast fsync path does not wait for ordered extents
>     to complete in order to reduce latency.
>
> So to fix this make btrfs_finish_ordered_extent() drop the extent maps
> in the range if an error happened for a COW write.
>
> Note that this issues of using extent maps that point to unwritten
> locations can not happen for reads, because in read paths we start by
> locking the extent range and wait for any ordered extents in the range
> to complete before looking for extent maps.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for the detailed explanation on the issue.

Thanks,
Qu
> ---
>   fs/btrfs/ordered-data.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> index 304d94f6d29b..3a3f21da6eb7 100644
> --- a/fs/btrfs/ordered-data.c
> +++ b/fs/btrfs/ordered-data.c
> @@ -388,6 +388,33 @@ bool btrfs_finish_ordered_extent(struct btrfs_order=
ed_extent *ordered,
>   	ret =3D can_finish_ordered_extent(ordered, page, file_offset, len, up=
todate);
>   	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
>
> +	/*
> +	 * If this is a COW write it means we created new extent maps for the
> +	 * range and they point to an unwritten location if we got an error
> +	 * either before submitting a bio or during IO.
> +	 *
> +	 * We have marked the ordered extent with BTRFS_ORDERED_IOERR, and we
> +	 * are queuing its completion below. During completion, at
> +	 * btrfs_finish_one_ordered(), we will drop the extent maps for the
> +	 * unwritten extents.
> +	 *
> +	 * However because completion runs in a work queue we can end up
> +	 * unlocking the inode before the ordered extent is completed.
> +	 *
> +	 * That means that a fast fsync can happen before the work queue
> +	 * executes the completion of the ordered extent, and in that case
> +	 * the fsync will use the extent maps that point to unwritten extents,
> +	 * resulting in logging file extent items that point to unwritten
> +	 * locations. Unlike read paths, a fast fsync doesn't wait for ordered
> +	 * extent completion before proceeding (intentional to reduce latency)=
.
> +	 *
> +	 * To be safe drop the new extent maps in the range (if are doing COW)
> +	 * right here before we unlock the inode and allow a fsync to run.
> +	 */
> +	if (!uptodate && !test_bit(BTRFS_ORDERED_NOCOW, &ordered->flags))
> +		btrfs_drop_extent_map_range(inode, file_offset,
> +					    file_offset + len - 1, false);
> +
>   	if (ret)
>   		btrfs_queue_ordered_fn(ordered);
>   	return ret;

