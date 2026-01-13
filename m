Return-Path: <linux-btrfs+bounces-20460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D521D1AD8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9652E3010D40
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD231812E;
	Tue, 13 Jan 2026 18:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OrFAFiDM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVn1x+fp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5554288530
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329126; cv=none; b=sTaXu1wZLTjkC8ZKDsAyF/j3iEq9PoCmYfCNNTX0e9F5MaZYnegfhjxQErLVhlUIWGg8RAmOjwf/vTxXDuGYpwvPtzt7QDozatwNJFzgyqQmI5RR+LOh4CjVC2YH+bUy2gbvZN5f2D4h7BYVj9uFnCtNG8D8UupMfTVo12y0X0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329126; c=relaxed/simple;
	bh=3/izDv8qUFbouczQtT+M1m9mr1qY3AtA7Hkmd98bbc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSCiQ5rhgVL93lILRJzjHxDRM/u0EzHhrKsCy8mrrWr/Wxhi22s836yDq7XuMBovy2+eaAYSZRwaIz64BvcmsiMn2F0YvZYO54r5n3tMSfvaJ4KlM/LLKoimQ2bmBUoJd4E2qTW7xusEou7ZXFoATCVdiJVYqApDcEceUAryZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OrFAFiDM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVn1x+fp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F28CEC027E;
	Tue, 13 Jan 2026 13:32:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 13:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768329124; x=1768415524; bh=JV99ZgrLkf
	tnW4/JrCJLm0VZcecSW9ajVz5yhSgh4vM=; b=OrFAFiDMOE9kKXxB/jN6TvKEqK
	Q/ndToXsi8AmrTcOQ7+qmgOrvuRoy4VtPTAKo6npCVJ3BgxTMRa/ElLe/oUXZnGF
	l2u+fh2bXApVoEo3HxcR75KvdO75yBTp0Pnjkp5GgwqbXDGtKkeg7hgUzYfvY6CJ
	bJ3PvEBUUKvRuShH0DI88jE3tIhxyJdzLmiUhTh0S9IWtHDCV+1k4GGeI1gIRyxN
	Gk7//jEl4G+qJJ3bAkzfosBFFRhVkbaVDf2six9ncgMdRz+NAAgmT5IZkZ/8kkbl
	dsLHW5+bP8himj8gv5oxHJKSM+GwJRjeyi3ug6u3zjVTu5MotBQyJ5V3Vcog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768329124; x=1768415524; bh=JV99ZgrLkftnW4/JrCJLm0VZcecSW9ajVz5
	yhSgh4vM=; b=JVn1x+fp9m3vzUVgrmsWoaHwtC5aELCQ4IL/UPUIzyjH7tGhbYD
	kMDoIq4cP/ow3VP6sY7CMmeyqnOXqDTeuChUXxummHLx0wCcdpfwncXj9sSUjJ6K
	JOjo/VRmey+XUfx+sb9vjm55dj+sibiYjI5pBvNccedPVHOxMdYMPmRmNzXK5+q3
	VSt3WWoaqVpJX6BXQoGJ/iRPxn7u78PddB71oBkSWuVRC3FMZ2m2bHOEOQ5W4lXp
	YMxb+eOled34Iw+p2Tnk0whaGGKgORxy1Rve7M1ybWWz8KP/LKBTK63cYBgFhiVe
	bCv8/D+HonohuFQS5KJZDbXtft1arFEFXlA==
X-ME-Sender: <xms:pI9maS12MJEm0WhUd_mwcATQbyk67pqA3Uw3FAlyGz3-NooN4cup6w>
    <xme:pI9mabFe3itSS2Xp2Vc8ie3dxm_fcDvpPOly6J_QntI08LGPdllcHvFc9CzryMFuu
    8zGNlwAjINeGKWRaagDHYuOYMenGZ7F096Ixpd09VjuxXPZFbbZ5w>
X-ME-Received: <xmr:pI9maYhNNnQ_tVE5oHZeXpUuLsCHfQRWl6t-0AozYMKIvnPV3Qegw1ZN64kNWvWLljrEg19TWXDjNJ3T0dP5jwIeuGs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnkheijedukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:pI9mae97AdaFlU-xh90KmZBu_vJ7VOZvVJmrtD8jsldvZd_tFd2D1Q>
    <xmx:pI9maXr8FOBskRBiib8K0DWOt2M5K2IwvB8ACRp4ZB827iZDCN_7vQ>
    <xmx:pI9maV8H1W1y8MvoKglWECXCNRkWVXAaDNQJTwBdTb_VymijnNuzmw>
    <xmx:pI9maTUwfDGcqbSFqVuF7yU6TMu1gk7yOVJLBoDf616sFlHWsevODQ>
    <xmx:pI9maZWueTN4Qmpyobmc_SWdXhjE9xtEm44j3U88UN6Ac1A2n90LHvBg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 13:32:03 -0500 (EST)
Date: Tue, 13 Jan 2026 10:32:04 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: fix periodic reclaim condition
Message-ID: <20260113183204.GD972704@zen.localdomain>
References: <20260113060935.21814-2-sunk67188@gmail.com>
 <20260113060935.21814-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113060935.21814-3-sunk67188@gmail.com>

On Tue, Jan 13, 2026 at 12:07:04PM +0800, Sun YangKai wrote:
> Problems with current implementation:
> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>    negative reclaimable_bytes to trigger reclaim unexpectedly
> 2. The "space must be freed between scans" assumption breaks the
>    two-scan requirement: first scan marks block groups, second scan
>    reclaims them. Without the second scan, no reclamation occurs.
> 
> Instead, track actual reclaim progress: pause reclaim when block groups
> will be reclaimed, and resume only when progress is made. This ensures
> reclaim continues until no further progress can be made. And resume
> perioidc reclaim  when there's enough free space.
> 
> Suggested-by: Boris Burkov <boris@bur.io>
> Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")

Made a small inline suggestion, but you can add
Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/block-group.c |  6 +++++-
>  fs/btrfs/space-info.c  | 21 ++++++++++++---------
>  2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e417aba4c4c7..f0945a799aed 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>  		u64 used;
>  		u64 reserved;
> +		u64 old_total;
>  		int ret = 0;
>  
>  		bg = list_first_entry(&fs_info->reclaim_bgs,
> @@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  		}
>  
>  		spin_unlock(&bg->lock);
> +		old_total = space_info->total_bytes;
>  		spin_unlock(&space_info->lock);
>  
>  		/*
> @@ -1989,13 +1991,15 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  			spin_lock(&space_info->lock);
>  			space_info->reclaim_errors++;
>  			if (READ_ONCE(space_info->periodic_reclaim))
> -				space_info->periodic_reclaim_ready = false;
> +				btrfs_set_periodic_reclaim_ready(space_info, false);

I think it probably makes more sense to remove this one entirely, since
it's already false from the sweep, then only set it true if we succeed
and the total_bytes goes down.

>  			spin_unlock(&space_info->lock);
>  		}
>  		spin_lock(&space_info->lock);
>  		space_info->reclaim_count++;
>  		space_info->reclaim_bytes += used;
>  		space_info->reclaim_bytes += reserved;
> +		if (space_info->total_bytes < old_total)
> +			btrfs_set_periodic_reclaim_ready(space_info, true);
>  		spin_unlock(&space_info->lock);
>  
>  next:
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 7b7b7255f7d8..7d2386ea86c5 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2079,11 +2079,11 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
>  	return unalloc < data_chunk_size;
>  }
>  
> -static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
> +static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  {
>  	struct btrfs_block_group *bg;
>  	int thresh_pct;
> -	bool try_again = true;
> +	bool will_reclaim = false;
>  	bool urgent;
>  
>  	spin_lock(&space_info->lock);
> @@ -2101,7 +2101,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  		spin_lock(&bg->lock);
>  		thresh = mult_perc(bg->length, thresh_pct);
>  		if (bg->used < thresh && bg->reclaim_mark) {
> -			try_again = false;
> +			will_reclaim = true;
>  			reclaim = true;
>  		}
>  		bg->reclaim_mark++;
> @@ -2118,12 +2118,13 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  	 * If we have any staler groups, we don't touch the fresher ones, but if we
>  	 * really need a block group, do take a fresh one.
>  	 */
> -	if (try_again && urgent) {
> -		try_again = false;
> +	if (!will_reclaim && urgent) {
> +		urgent = false;
>  		goto again;
>  	}
>  
>  	up_read(&space_info->groups_sem);
> +	return will_reclaim;
>  }
>  
>  void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> @@ -2133,7 +2134,8 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
>  	lockdep_assert_held(&space_info->lock);
>  	space_info->reclaimable_bytes += bytes;
>  
> -	if (space_info->reclaimable_bytes >= chunk_sz)
> +	if (space_info->reclaimable_bytes > 0 &&
> +	    space_info->reclaimable_bytes >= chunk_sz)
>  		btrfs_set_periodic_reclaim_ready(space_info, true);
>  }
>  
> @@ -2160,7 +2162,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>  
>  	spin_lock(&space_info->lock);
>  	ret = space_info->periodic_reclaim_ready;
> -	btrfs_set_periodic_reclaim_ready(space_info, false);
>  	spin_unlock(&space_info->lock);
>  
>  	return ret;
> @@ -2174,8 +2175,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
>  	list_for_each_entry(space_info, &fs_info->space_info, list) {
>  		if (!btrfs_should_periodic_reclaim(space_info))
>  			continue;
> -		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
> -			do_reclaim_sweep(space_info, raid);
> +		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> +			if (do_reclaim_sweep(space_info, raid))
> +				btrfs_set_periodic_reclaim_ready(space_info, false);
> +		}
>  	}
>  }
>  
> -- 
> 2.52.0
> 

