Return-Path: <linux-btrfs+bounces-5964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB292916DDD
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 18:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB881F22183
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4117106D;
	Tue, 25 Jun 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GaaT1nhF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ephY4ScB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3416A945
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332267; cv=none; b=PbCJecMAESBRC9VnAjRMjhBA5Qu7dUI5G74iyy8BdJoFHvUjss0dnWnYsuG+ZFGN4A6yOHBKW9GeiAzY4xmzitiDBopYtTHJ05bKVaza4vLOoo5FgnJVtXeFeGSQpUxgSgnFfKGZEGIxoYB90u0L/XlZAJSlNgKvyfKJ3idXAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332267; c=relaxed/simple;
	bh=kc9kG9HorYmW1eDLIWRO3XUvuRvupneNifG4YKFjN4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFLUInMxNjK8mqkye2FWi6M4euRt8Ad2Wmp+Hbe/kEIU8QotMRDbLnioT7QnmOEa0XWOtvJLRpuDcTqEsc7y54AZ9pJ/iX1JaYxNGO1A6J/hL5bCDHdYlZlfP0w9DS6r0AVGucpxILnZyjZBmp1ROQJtyWvYJ2QVPOK3BKXo2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GaaT1nhF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ephY4ScB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2428A11401F5;
	Tue, 25 Jun 2024 12:17:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 25 Jun 2024 12:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1719332264; x=1719418664; bh=AuKCrNXFEE
	r3ElhY5GbTRTsISkNKWet1EBfyKhuP0YE=; b=GaaT1nhFbwCAUSvR6suQrtCNnZ
	KjUxpQmJ4gKc665w/P1mh5Q+77N0eX5gUKvq9SzqhQHljM17VcPWlEHRczl68OC8
	Q9GPssc3AAus7ynQA2H7HezZRJs6d06CzFvzOd1aZVxTJ/nhd/TuWEd33Ph4CTCB
	54oJBNslVq0oJvv0Y8LAjx/XcM5QBWd3JoTeA2Wk4Fmb9FOjyACVXMR5S4ePQOX7
	OZBqMvhNulSC7v/pRyLuZ2ZVnnTfw9+BWknCFXSSplLsZS9y7hk6VmvQQRbJjc17
	lNQi4tqn7bV0+hrv3mFHPI10F85mLBpKExl2cX9eHVHkVCV0A3JcgtEf/34g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719332264; x=1719418664; bh=AuKCrNXFEEr3ElhY5GbTRTsISkNK
	Wet1EBfyKhuP0YE=; b=ephY4ScBejYH0cyKqP/Fne3GeOOu8bbTswSVVXA9oe12
	Do/xXQQ29qmEuiXvb+ISM1z01MdL9F93PFZEMWvmwAx8i8bk8kKL2dNhV7LJTvc0
	kcm6r3WbkvKk79Xj8GhMV23yqSLaWY9AjyOk615/0GNYs6LBN/I0QBVOaIem1pEg
	giNx7ZjNOnFAuV4KW0fJSqmdZoJcAiA0AuHnfj5chNNpf7tToyfrksYDGh0bAXge
	eDXZ1BvTk4STxernaXimGffn1TJL2A9tiSE08428qWRyD++PwRyyfJ0eeh9hByJZ
	0uOXEu21ElRu93rEn6vZoZPhLP+fTKnRhVEEANjQuw==
X-ME-Sender: <xms:p-16ZlE2qshL3SgBbCOG-8U65BngqT-bI5as1CEiE6rZ6ZHHaZFGkQ>
    <xme:p-16ZqUC6PVlEWCidtN9dg005DtdhVn-KOQIr5HbCYVH-iiUaA3qn6bfaZAo8BKaW
    qVmIhT-nhAZXp4IZLU>
X-ME-Received: <xmr:p-16ZnK2paMyK7aGN_jrvNaFmz1WyS59Z8C8P5PMdBh8iIHdCZZGEU8v8la3rvZuUrIG2mxZre6PdS0cOQpxfXZnrOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhephe
    dthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:p-16ZrGGdOHJ_UI1hvJYx8S8jhap8x6vp2S5EhMPewholNl8jSS56A>
    <xmx:p-16ZrUjEJW9Q6m73laVU_ctMe1T6NIQ-SZd4RWdxyP5Gw8YCTqBVQ>
    <xmx:p-16ZmNutlndnufBGPjcyqwWYILUpZbGI9uAqU1HKgG-iRD96HBN2A>
    <xmx:p-16Zq2DuymndmiZ1-80NDvkSzTtGSp3vqmOmctWvEdh2IT46xKpyw>
    <xmx:qO16ZogSNo7EzSkgkbV7rs3jsNxpMOBaIAXBBnIWAMcVrSUyV-ysRbJw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 12:17:43 -0400 (EDT)
Date: Tue, 25 Jun 2024 09:17:14 -0700
From: Boris Burkov <boris@bur.io>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix calc_available_free_space for zoned
 mode
Message-ID: <20240625161714.GB1488399@zen.localdomain>
References: <0803c4de21aac935169b8289de1cb71c695452be.1719326990.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0803c4de21aac935169b8289de1cb71c695452be.1719326990.git.naohiro.aota@wdc.com>

On Tue, Jun 25, 2024 at 11:58:49PM +0900, Naohiro Aota wrote:
> calc_available_free_space() returns the total size of metadata (or system)
> block groups, which can be allocated from unallocated disk space. The logic
> is wrong on zoned mode in two places.
> 
> First, the calculation of data_chunk_size is wrong. We always allocate one
> zone as one chunk, and no partial allocation of a zone. So, we should use
> zone_size (= data_sinfo->chunk_size) as it is.
> 
> Second, the result "avail" may not be zone aligned. Since we always
> allocate one zone as one chunk on zoned mode, returning non-zone size
> alingned bytes will result in less pressure on the async metadata reclaim
> process.
> 
> This is serious for the nearly full state with a large zone size
> device. Allowing over-commit too much will result in less async reclaim
> work and end up in ENOSPC. We can align down to the zone size to avoid
> that.

I sort of wish we could get rid of the "data_sinfo->chunk_size is wrong"
thing. If we never actually use that value, perhaps we can try to really
fix it? I didn't do it in my patches either, so there must have been
something that made me hesitate that I'm now forgetting.

Obviously not the focus here, so with that said, the fix looks
good.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Fixes: cb6cbab79055 ("btrfs: adjust overcommit logic when very close to full")
> CC: stable@vger.kernel.org # 6.9
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
> As I mentioned in [1], I based this patch on for-next but before
> Boris's "dynamic block_group reclaim threshold" series, because it would
> be easier to backport this patch. I'll resend this patch basing on
> for-next, if you'd prefer that.

I looked at the merge conflict and it's the fact that I pulled the data
chunk logic into a helper function. Just fixing it is easy, but like you
said, makes backporting this fix fussier.

Since the conflict is pretty trivial, I support re-ordering things so
that this goes under the reclaim stuff, whether we pull my
calc_effective_data_chunk_size refactor into this patch and put it
under, or just edit the refactor to bring along the zoned fix. Let me
know if I can help with that!

> 
> [1] https://lore.kernel.org/linux-btrfs/avjakfevy3gtwcgxugnzwsfkld35tfgktd5ywpz3kac6gfraxh@uic6zl3jmgbl/
> ---
>  fs/btrfs/space-info.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 0283ee9bf813..85ff44a74223 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -373,11 +373,18 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
>  	 * "optimal" chunk size based on the fs size.  However when we actually
>  	 * allocate the chunk we will strip this down further, making it no more
>  	 * than 10% of the disk or 1G, whichever is smaller.
> +	 *
> +	 * On the zoned mode, we need to use zone_size (=
> +	 * data_sinfo->chunk_size) as it is.
>  	 */
>  	data_sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA);
> -	data_chunk_size = min(data_sinfo->chunk_size,
> -			      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
> -	data_chunk_size = min_t(u64, data_chunk_size, SZ_1G);
> +	if (!btrfs_is_zoned(fs_info)) {
> +		data_chunk_size = min(data_sinfo->chunk_size,
> +				      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
> +		data_chunk_size = min_t(u64, data_chunk_size, SZ_1G);
> +	} else {
> +		data_chunk_size = data_sinfo->chunk_size;
> +	}
>  
>  	/*
>  	 * Since data allocations immediately use block groups as part of the
> @@ -405,6 +412,17 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
>  		avail >>= 3;
>  	else
>  		avail >>= 1;
> +
> +	/*
> +	 * On the zoned mode, we always allocate one zone as one chunk.
> +	 * Returning non-zone size alingned bytes here will result in
> +	 * less pressure for the async metadata reclaim process, and it
> +	 * will over-commit too much leading to ENOSPC. Align down to the
> +	 * zone size to avoid that.
> +	 */
> +	if (btrfs_is_zoned(fs_info))
> +		avail = ALIGN_DOWN(avail, fs_info->zone_size);
> +
>  	return avail;
>  }
>  
> -- 
> 2.45.2
> 

