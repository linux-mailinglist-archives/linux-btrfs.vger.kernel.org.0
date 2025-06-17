Return-Path: <linux-btrfs+bounces-14754-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084BDADDE37
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 23:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997BB17E898
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 21:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F728ECE5;
	Tue, 17 Jun 2025 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Xk19Orp6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ao2NRnP7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01AA255F31
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197064; cv=none; b=cALOh+CIN/747MkB6J2k9qzZN2FqStSppxw1B6JxCccNAPfMqVnxUQUDidi3u++Yu+CK+cuVSTZqXiS+8/hf3qLPA6HnYFXO7Ioy+qYeqYKuP1rVHvBqKgdlyfVjYfy3b9bTwf9JY1kF3XTbTxmYURaD74KpZHe3yX4VssLC3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197064; c=relaxed/simple;
	bh=d8Jm6lD0g2WPw04ZfrHTaOMQChoyibpXMcq5MscwllI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYHhixKji+lPKYukgNLD8DVE4ZwCqUORIYft31+5+xSKWTONvULhiicM+Uan4HPAd8ZnnPztA048QZ25vbr9BI5EJfE+eCf05HN4+C7tNblvnktrrR99cM0fU/BkBf3QbCIdelu3O7WigdefOR2s5pCnsJyI/fK0V4Xn4gY/rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Xk19Orp6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ao2NRnP7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0022111400D2;
	Tue, 17 Jun 2025 17:51:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Jun 2025 17:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1750197060; x=1750283460; bh=ZkPwkSUpGT
	393iIU2Q0jJmuSmSZHMWIShBSJV9AddkY=; b=Xk19Orp6T4ViFmwupQF1uF9wy7
	LyKTysHCfeO6vtNOtN6D06sLkdGwIeFlhIEjkQU/R2Atb0fNfetWXHYM9QxJ9YTK
	m31/mouAMW5otLJFrk0DO1qX5c+tWgxOI3k1DK4G8id2MO/iENka7G+NEkCImb8v
	9aoR1wnOEb9SncPAZUdRdJ/LBBexEmP724k6Hyvuk9A41EWxE0J5NMXYDklP4a2H
	9qra1dzCN4m0vIrz2T/jw//LRLbTUO3gL3jFMXGu49E6v/tEQOJq+6M/HdDNBnbE
	t6zpk6HTBnBTmayrYG7f96tYAAkJyqCt7e4DFAk93P4vHbKS//ZbbB9E7SMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750197060; x=1750283460; bh=ZkPwkSUpGT393iIU2Q0jJmuSmSZHMWIShBS
	JV9AddkY=; b=Ao2NRnP7kSRbNwnvEI8gsFI1lrVvBZ3Twx50w0YQRe9+dSqrW0L
	W6Ovv1uodoHBKH1PBVDPfmLJkgWHkGpuwtUTUQxrfUHqBkSb4s1WKEnIQEEccbgf
	RSACHO/+u0dzIlypqUt4KXPTx9gYuEj9b3HkTb4+ovJwRbQOCn3UctxrfzZskzhG
	6Nt1u3Q/PEv+fzAMA9kaFHDfdTMiTNxpZ6NolSt1PrHwpi2JDX8y2dewjq5t2UU+
	Gi82EKTHfeH6HaBt2dLCSDLC679f3Ml5/iIaSt42jkzCrjgMquEvi7tc/oGiG62X
	wB4+T6L+MFv0H2O7/8E1bWgysHgj+UyyLFQ==
X-ME-Sender: <xms:RONRaMODlIcRks-4XTVcR-PPxaU8FRcH2cqrQFdvcWhhxB-B3bSr9Q>
    <xme:RONRaC9oVwLT4ioRN9ApVhXc7C-33jMkFnvW_ClQJCy3XrWxswxo1Wljj8X8TXDHh
    4BFUI5zeocHbrAZMwc>
X-ME-Received: <xmr:RONRaDTuhUvMHE7GsXN0moKZ1sjj_pDAysKae6NpXvAlCr8Jw8q80trb9BgBXd3D7PLLtQEp2ucU3AAXECCFFythn9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcu
    oegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhve
    ehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghn
    rghnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RONRaEuQ3HDw7iGRWi6YSc_HJjb3oH4UDhb-psCfCa_k1WIFu1miKA>
    <xmx:RONRaEeW9IJsb199aZAeXLQHnYHUz27-PrTfzC10_e1WGfzgnUszMg>
    <xmx:RONRaI1igh3x7v4XQ1uC3WcW6lQ8ocUMwMPZZrBSZWvsucgEGdfwmg>
    <xmx:RONRaI81qEf2NrT5sZLC_EhqbdAxCncU52j1kWkzCqW0h76g9u5n2w>
    <xmx:RONRaDqSYkiTPqhIsu3fdvCUnVyQNV_wrBdrdOpqOyLYyvKJr1iKHLty>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 17:51:00 -0400 (EDT)
Date: Tue, 17 Jun 2025 14:52:39 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 16/16] btrfs: cache if we are using free space bitmaps
 for a block group
Message-ID: <20250617215239.GB2330659@zen.localdomain>
References: <cover.1750075579.git.fdmanana@suse.com>
 <b8dfd9adca4be0d65661e90e7c742b1c66ff4fe9.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8dfd9adca4be0d65661e90e7c742b1c66ff4fe9.1750075579.git.fdmanana@suse.com>

On Tue, Jun 17, 2025 at 05:13:11PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Every time we add free space to the free space tree or we remove free
> space from the free space tree, we do a lookup for the block group's free
> space info item in the free space tree. This takes time, navigating the
> btree and we may block either on IO when reading extent buffers from disk
> or on extent buffer lock contention due to concurrency.
> 
> Instead of doing this lookup everytime, cache the result in the block
> structure and use it after the first lookup. This adds two boolean members
> to the block group structure but doesn't increase the structure's size.
> 
> The following script that runs fs_mark was used to measure the time spent
> on run_delayed_tree_ref(), since down that call chain we have calls to
> add and remove free space to/from the free space tree (calls to
> btrfs_add_to_free_space_tree() and btrfs_remove_from_free_space_tree()):
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/nullb0
>   MNT=/mnt
>   FILES=100000
>   THREADS=$(nproc --all)
> 
>   echo "performance" | \
>       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
>   umount $DEV &> /dev/null
>   mkfs.btrfs -f $DEV
>   mount -o ssd $DEV $MNT
> 
>   OPTS="-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
>   for ((i = 1; i <= $THREADS; i++)); do
>       OPTS="$OPTS -d $MNT/d$i"
>   done
> 
>   fs_mark $OPTS
> 
>   umount $MNT
> 
> This is a heavy metadata test as it's exercising only file creation, so a
> lot of allocations of metadata extents, creating delayed refs for adding
> new metadata extents and dropping existing ones due to COW. The results
> of the times it took to execute run_delayed_tree_ref(), in nanoseconds,
> are the following.
> 
> Before this change:
> 
>   Range: 1868.000 - 6482857.000; Mean: 10231.430; Median: 7005.000; Stddev: 27993.173
>   Percentiles:  90th: 13342.000; 95th: 23279.000; 99th: 82448.000
>   1868.000 - 4222.038: 270696 ############
>   4222.038 - 9541.029: 1201327 #####################################################
>   9541.029 - 21559.383: 385436 #################
>   21559.383 - 48715.063: 64942 ###
>   48715.063 - 110073.800: 31454 #
>   110073.800 - 248714.944:  8218 |
>   248714.944 - 561977.042:  1030 |
>   561977.042 - 1269798.254:   295 |
>   1269798.254 - 2869132.711:   116 |
>   2869132.711 - 6482857.000:    28 |
> 
> After this change:
> 
>   Range: 1554.000 - 4557014.000; Mean: 9168.164; Median: 6391.000; Stddev: 21467.060
>   Percentiles:  90th: 12478.000; 95th: 20964.000; 99th: 72234.000
>   1554.000 - 3453.820: 219004 ############
>   3453.820 - 7674.743: 980645 #####################################################
>   7674.743 - 17052.574: 552486 ##############################
>   17052.574 - 37887.762: 68558 ####
>   37887.762 - 84178.322: 31557 ##
>   84178.322 - 187024.331: 12102 #
>   187024.331 - 415522.355:  1364 |
>   415522.355 - 923187.626:   256 |
>   923187.626 - 2051092.468:   125 |
>   2051092.468 - 4557014.000:    21 |
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/block-group.h     |  5 +++++
>  fs/btrfs/free-space-tree.c | 12 +++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index aa176cc9a324..8a8f1fff7e5b 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -246,6 +246,11 @@ struct btrfs_block_group {
>  	/* Lock for free space tree operations. */
>  	struct mutex free_space_lock;
>  
> +	/* Protected by @free_space_lock. */
> +	bool use_free_space_bitmaps;
> +	/* Protected by @free_space_lock. */
> +	bool use_free_space_bitmaps_cached;
> +
>  	/*
>  	 * Number of extents in this block group used for swap files.
>  	 * All accesses protected by the spinlock 'lock'.
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index 3c8bb95fa044..1bd07e91fd5a 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -287,6 +287,8 @@ int btrfs_convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
>  	leaf = path->nodes[0];
>  	flags = btrfs_free_space_flags(leaf, info);
>  	flags |= BTRFS_FREE_SPACE_USING_BITMAPS;
> +	block_group->use_free_space_bitmaps = true;
> +	block_group->use_free_space_bitmaps_cached = true;
>  	btrfs_set_free_space_flags(leaf, info, flags);
>  	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
>  	btrfs_release_path(path);
> @@ -434,6 +436,8 @@ int btrfs_convert_free_space_to_extents(struct btrfs_trans_handle *trans,
>  	leaf = path->nodes[0];
>  	flags = btrfs_free_space_flags(leaf, info);
>  	flags &= ~BTRFS_FREE_SPACE_USING_BITMAPS;
> +	block_group->use_free_space_bitmaps = false;
> +	block_group->use_free_space_bitmaps_cached = true;
>  	btrfs_set_free_space_flags(leaf, info, flags);
>  	expected_extent_count = btrfs_free_space_extent_count(leaf, info);
>  	btrfs_release_path(path);
> @@ -796,13 +800,19 @@ static int use_bitmaps(struct btrfs_block_group *bg, struct btrfs_path *path)
>  	struct btrfs_free_space_info *info;
>  	u32 flags;
>  
> +	if (bg->use_free_space_bitmaps_cached)
> +		return bg->use_free_space_bitmaps;
> +

I'm a little worried about what happens if the reader observes the
writes out of order.

i.e., say T1 is calling btrfs_convert_free_space_to_bitmaps() and T2 is
calling use_bitmaps(). Then if T2 observes use_free_space_bitmaps_cached
set to true but not use_free_space_bitmaps set to true, it will get the
wrong value.

Or is there some higher level locking that I missed protecting us?

Thanks,
Boris

>  	info = btrfs_search_free_space_info(NULL, bg, path, 0);
>  	if (IS_ERR(info))
>  		return PTR_ERR(info);
>  	flags = btrfs_free_space_flags(path->nodes[0], info);
>  	btrfs_release_path(path);
>  
> -	return (flags & BTRFS_FREE_SPACE_USING_BITMAPS) ? 1 : 0;
> +	bg->use_free_space_bitmaps = (flags & BTRFS_FREE_SPACE_USING_BITMAPS);
> +	bg->use_free_space_bitmaps_cached = true;
> +
> +	return bg->use_free_space_bitmaps;
>  }
>  
>  EXPORT_FOR_TESTS
> -- 
> 2.47.2
> 

