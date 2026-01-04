Return-Path: <linux-btrfs+bounces-20095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57890CF1436
	for <lists+linux-btrfs@lfdr.de>; Sun, 04 Jan 2026 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E2D530047A6
	for <lists+linux-btrfs@lfdr.de>; Sun,  4 Jan 2026 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E3225A3B;
	Sun,  4 Jan 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="gKZHMxJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgpw/R2X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0173A1E7F
	for <linux-btrfs@vger.kernel.org>; Sun,  4 Jan 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555597; cv=none; b=PKO1XDcsCERzZ/B0r2Al/m9gZ/8wyfp8kVBXXfPUM6MyPCRkX95fqKwPBvzSI3aXQBHrXyQkKk0GECygYYHmTdaf7G1zvD0+NAvvxWvOUCX3d4k7dqEcljKvhaQlXqoEBlS9xyeUDePAOQ3JHNBSJevrHYBu4xNXGqxSsLskcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555597; c=relaxed/simple;
	bh=KnU4SGEmddf4VfiqkuAxwPQJmeckDJAu/Xix0mCooS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORRP6el7qYTf4VFdEpL81NR7oRuQaYl492nmKsdkpbuNSrSyDu3tPOZZ3zwO5If5JxE+OImxG2syFMWKsC2uou/FZ5JWUGIDXoP7/+/kyhKNePiJzZDvJhUOs6gdL+Jsgl5n/uB+KVF6cMxtGCHF81LRLkl+WtJWu/yvIc1yRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=gKZHMxJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgpw/R2X; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E15127A0087;
	Sun,  4 Jan 2026 14:39:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 04 Jan 2026 14:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767555592; x=1767641992; bh=rctQQ+7/In
	gMJi3nv1uYCY8tTDoiAVN3C3mOtJzEe5I=; b=gKZHMxJ7x8PhLgmvXOJYwe3h/U
	xxuGpk4qdd6sAwtVLZly/t2w4RkcUeaMgtnn+g7H+dPuaSQYsh1YFSA9fW30MKv9
	uKLZh+TEVJJZVYt8XelCGJm6ynr5wN4Z9rSyGX+wZPCctk1qddUssw2rnv5/lksI
	d9fFcsCMzUd/VHu2phEglBvimtw/3LtusuoWi243BZg4j9knKU1iB7BNGhQ3V6KA
	QJB7PaviHNnVK+XxIWYLJHQZw46FewxZu41nG4QNzq4jMKasRhA2MWCFlsSDakY+
	tJI2Spy0/O+ZLQ4lfPhJenzoh/gM38z05r0+8iyrcyskXHKS1bWo81rb2gbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767555592; x=1767641992; bh=rctQQ+7/IngMJi3nv1uYCY8tTDoiAVN3C3m
	OtJzEe5I=; b=bgpw/R2XLM6lfdWes7bhhTKTCyw18TZweMqtpNZf7BcGXEjI0EB
	6lJJlHNbhbTC4GJgxY/8xckjDERekGzuwFkM7GH96IdYG6NsSfmldiGDRypfnB2a
	YSA0ocIVJ/APEWHLA//tN/fjdPIbmfh8NX9CC5z23MgOV0UbnloXkwGobK66V56s
	fZ2b5h+UnGvHk5SodJgwwljW0g7wQWqrtq0/mScZIhkh7lVDWbEscK8l3BC5BUuH
	BZVCT/huDsukySZUxehno5ftkq8pFLRpwg/3SaWzhiXSp4FfOPhEaWLVqbCcEWUh
	j9RTggpfiuiPIdKJIBgSM8b7TlpNdlc6hQQ==
X-ME-Sender: <xms:CMJaaRm6txMjgbC_qMvcZyhTfBqTLUxqCa69f3UuXarVW-enuUd7zQ>
    <xme:CMJaaS1SDIx36kkLRePGC5XFtTHLyKUByuTuPu_J4qat3SSoGRA0ecL3EpoSuZ1oq
    BxvGVuwuRhUj5mU-XfZHI0R8dvaAlZrm2dwhTENHQHjehv6SvjB>
X-ME-Received: <xmr:CMJaaVRh2K5qiy-1V9-vZRcdA81zyVIBfaLIi_eao2pYJ0amstOxmDUVfG1EUtwz9teOapmCd_wmHdk90rOyMo0vE6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelhedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhkieejudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:CMJaacsx3ZKZBIU8QSNhUAeK0yfTvYzdMUnsdwUe7agsKa7Ouvigzg>
    <xmx:CMJaaSYT1R3Fy1KV56wozwEiwU7ZOcnZQr7dZSxNLvnecfMgD4ooWA>
    <xmx:CMJaaZs2jVso3goWnIE9FDWrXW2xg16XNcp2BgEw8vhsKOXUTz9YLQ>
    <xmx:CMJaacE0qHZhvfk_PCRhl2nnCC2jWKNNYdCqWKlTJJ2BE4yLEZHiQg>
    <xmx:CMJaaaXuih_k59fPS1YO9mFQ9SEAT_PuK5dzfM-p3qbeFvJ7zo88aOu2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 14:39:52 -0500 (EST)
Date: Sun, 4 Jan 2026 11:40:08 -0800
From: Boris Burkov <boris@bur.io>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/7] btrfs: fix periodic reclaim condition
Message-ID: <20260104194008.GA416121@zen.localdomain>
References: <20260103122504.10924-2-sunk67188@gmail.com>
 <20260103122504.10924-3-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103122504.10924-3-sunk67188@gmail.com>

On Sat, Jan 03, 2026 at 08:19:48PM +0800, Sun YangKai wrote:

First off, thank you very much for your attention to this and for
your in depth fixes.

> Problems with current implementation:
> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>    negative reclaimable_bytes to trigger reclaim unexpectedly

Agreed, completely. IMO, the message here could use a bit more clarity
that negative reclaimable_bytes is an intentionally designed condition
so this is a fundamental bug, not a weird edge case.

> 2. The "space must be freed between scans" assumption breaks the
>    two-scan requirement: first scan marks block groups, second scan
>    reclaims them. Without the second scan, no reclamation occurs.

I think I understand what you are saying, but let me try to restate it
myself and confirm:

Previously, due to bug 1, we were calling
btrfs_set_periodic_reclaim_ready() too frequently (after an allocation
that made the reclaimable_bytes negative). With bug 1 fixed, you really
have to free a chunk_sz to call btrfs_set_periodic_reclaim_ready(). As a
result, periodic_reclaim became way too conservative. Now the
multi-sweep marking thing AND reclaim_ready mean we basically never
reclaim, as the second sweep doesn't get triggered later.

Is that about right? I agree that this needs some re-thinking / fixing,
if so.

> 
> Instead, track actual reclaim progress: pause reclaim when block groups
> will be reclaimed, and resume only when progress is made. This ensures
> reclaim continues until no further progress can be made, then resumes when
> space_info changes or new reclaimable groups appear.

I think you are making a much bigger change than merely fixing the bugs
in the original design, so it requires deeper explanation of the new
invariants you are introducing. Clearly, I am one to talk about it, as I
messed up with my attempt, but I still think it is very valuable for
future readers. Thanks for bearing with me :)

I think the simplest pure "fix" is to change the current "ready = false"
setting from unconditional on every run of periodic reclaim to only when
a sweep actually queues a block group for reclaim. I have compiled but
not yet tested the code I included in this mail :) We can do that more
carefully once we agree how we want to move forward.

If you still want to re-design things on top of a fix like this one, I
am totally open to that.

Thanks again for all your work on this, and happy new year,
Boris

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..aad402485763 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2095,12 +2095,13 @@ static bool is_reclaim_urgent(struct btrfs_space_info *space_info)
 	return unalloc < data_chunk_size;
 }

-static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
+static bool do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 {
 	struct btrfs_block_group *bg;
 	int thresh_pct;
 	bool try_again = true;
 	bool urgent;
+	bool ret = false;

 	spin_lock(&space_info->lock);
 	urgent = is_reclaim_urgent(space_info);
@@ -2122,8 +2123,10 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 		}
 		bg->reclaim_mark++;
 		spin_unlock(&bg->lock);
-		if (reclaim)
+		if (reclaim) {
 			btrfs_mark_bg_to_reclaim(bg);
+			ret = true;
+		}
 		btrfs_put_block_group(bg);
 	}

@@ -2140,6 +2143,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 	}

 	up_read(&space_info->groups_sem);
+	return ret;
 }

 void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
@@ -2149,7 +2153,8 @@ void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s6
 	lockdep_assert_held(&space_info->lock);
 	space_info->reclaimable_bytes += bytes;

-	if (space_info->reclaimable_bytes >= chunk_sz)
+	if (space_info->reclaimable_bytes > 0 &&
+	    space_info->reclaimable_bytes >= chunk_sz)
 		btrfs_set_periodic_reclaim_ready(space_info, true);
 }

@@ -2176,7 +2181,6 @@ static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)

 	spin_lock(&space_info->lock);
 	ret = space_info->periodic_reclaim_ready;
-	btrfs_set_periodic_reclaim_ready(space_info, false);
 	spin_unlock(&space_info->lock);

 	return ret;
@@ -2190,8 +2194,10 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 	list_for_each_entry(space_info, &fs_info->space_info, list) {
 		if (!btrfs_should_periodic_reclaim(space_info))
 			continue;
-		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++)
-			do_reclaim_sweep(space_info, raid);
+		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
+			if (do_reclaim_sweep(space_info, raid))
+				btrfs_set_periodic_reclaim_ready(space_info, false);
+		}
 	}
 }

> 
> CC: Boris Burkov <boris@bur.io>
> Fixes: 813d4c6422516 ("btrfs: prevent pathological periodic reclaim loops")
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  fs/btrfs/block-group.c | 15 +++++++-------
>  fs/btrfs/space-info.c  | 44 +++++++++++++++++++-----------------------
>  fs/btrfs/space-info.h  | 28 ++++++++++++++++++---------
>  3 files changed, 46 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index e417aba4c4c7..94a4068cd42a 100644
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
> @@ -1988,14 +1990,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  			reserved = 0;
>  			spin_lock(&space_info->lock);
>  			space_info->reclaim_errors++;
> -			if (READ_ONCE(space_info->periodic_reclaim))
> -				space_info->periodic_reclaim_ready = false;
>  			spin_unlock(&space_info->lock);
>  		}
>  		spin_lock(&space_info->lock);
>  		space_info->reclaim_count++;
>  		space_info->reclaim_bytes += used;
>  		space_info->reclaim_bytes += reserved;
> +		if (space_info->total_bytes < old_total)
> +			btrfs_resume_periodic_reclaim(space_info);

Why is this here? We've just completed a reclaim, which I would expect
to be neutral to the space_info->total_bytes (just moving them around).
So if (any) unrelated freeing happens to happen while we are reclaiming,
we resume? Doesn't seem wrong, but also seems a little specific and
random. I am probably missing some aspect of your new design.

Put a different way, what is special about frees that happen *while* we
are reclaiming?

>  		spin_unlock(&space_info->lock);
>  
>  next:
> @@ -3730,8 +3732,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		space_info->bytes_reserved -= num_bytes;
>  		space_info->bytes_used += num_bytes;
>  		space_info->disk_used += num_bytes * factor;
> -		if (READ_ONCE(space_info->periodic_reclaim))
> -			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
>  		spin_unlock(&cache->lock);
>  		spin_unlock(&space_info->lock);
>  	} else {
> @@ -3741,12 +3741,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
>  		space_info->bytes_used -= num_bytes;
>  		space_info->disk_used -= num_bytes * factor;
> -		if (READ_ONCE(space_info->periodic_reclaim))
> -			btrfs_space_info_update_reclaimable(space_info, num_bytes);
> -		else
> -			reclaim = should_reclaim_block_group(cache, num_bytes);
> +		reclaim = should_reclaim_block_group(cache, num_bytes);

I think this is a bug with periodic_reclaim == 1

In that case, if should_reclaim_block_group() returns true (could be a
fixed or dynamic threshold), we will put that block group directly on
the reclaim list, which is a complete contradiction of the point of
periodic_reclaim.

>  
>  		spin_unlock(&cache->lock);
> +		if (reclaim)
> +			btrfs_resume_periodic_reclaim(space_info);

This also makes me wonder about the idea behind your change. If you want
periodic reclaim to "pause" until a block group meets the condition and
then we "resume", that's not exactly in the spirit of checking at a
periodic cadence, rather than as block groups update.

>  		spin_unlock(&space_info->lock);
>  
>  		btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 7b7b7255f7d8..de8bde1081be 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2119,48 +2119,44 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
>  	 * really need a block group, do take a fresh one.
>  	 */
>  	if (try_again && urgent) {
> -		try_again = false;
> +		urgent = false;
>  		goto again;
>  	}
>  
>  	up_read(&space_info->groups_sem);
> -}
> -
> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> -{
> -	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
> -
> -	lockdep_assert_held(&space_info->lock);
> -	space_info->reclaimable_bytes += bytes;
>  
> -	if (space_info->reclaimable_bytes >= chunk_sz)
> -		btrfs_set_periodic_reclaim_ready(space_info, true);
> -}
> -
> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
> -{
> -	lockdep_assert_held(&space_info->lock);
> -	if (!READ_ONCE(space_info->periodic_reclaim))
> -		return;
> -	if (ready != space_info->periodic_reclaim_ready) {
> -		space_info->periodic_reclaim_ready = ready;
> -		if (!ready)
> -			space_info->reclaimable_bytes = 0;
> +	/*
> +	 * Temporary pause periodic reclaim until reclaim make some progress.
> +	 * This can prevent periodic reclaim keep happening but make no progress.
> +	 */
> +	if (!try_again) {
> +		spin_lock(&space_info->lock);
> +		btrfs_pause_periodic_reclaim(space_info);
> +		spin_unlock(&space_info->lock);
>  	}
>  }
>  
>  static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
>  {
>  	bool ret;
> +	u64 chunk_sz;
> +	u64 unused;
>  
>  	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		return false;
>  	if (!READ_ONCE(space_info->periodic_reclaim))
>  		return false;
> +	if (!READ_ONCE(space_info->periodic_reclaim_paused))
> +		return true;

This condition doesn't feel like a "pause". If the "pause" is set to
false, then we proceed no matter what, otherwise we check conditions? It
should be something like:

if (READ_ONCE(space_info->periodic_reclaim_force))
        return true;

as it is acting like a "force" not a "not paused".

Hope that makes sense, it's obviously a bit tied up in language semantics..

> +
> +	chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
>  
>  	spin_lock(&space_info->lock);
> -	ret = space_info->periodic_reclaim_ready;
> -	btrfs_set_periodic_reclaim_ready(space_info, false);
> +	unused = space_info->total_bytes - space_info->bytes_used;

Probably makes sense to use a zoned aware wrapper for this, just in
case we make this friendly with zones eventually.

> +	ret = (unused >= space_info->last_reclaim_unused + chunk_sz ||
> +	       btrfs_calc_reclaim_threshold(space_info) != space_info->last_reclaim_threshold);

This second condition is quite interesting to me, I hadn't thought of
it. I think it makes some sense to care again if the threshold changed,
but it is a new behavior, rather than a fix, per-se.

What made you want to add this?

> +	if (ret)
> +		btrfs_resume_periodic_reclaim(space_info);
>  	spin_unlock(&space_info->lock);
>  
>  	return ret;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 0703f24b23f7..a49a4c7b0a68 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -214,14 +214,11 @@ struct btrfs_space_info {
>  
>  	/*
>  	 * Periodic reclaim should be a no-op if a space_info hasn't
> -	 * freed any space since the last time we tried.
> +	 * freed any space since the last time we made no progress.
>  	 */
> -	bool periodic_reclaim_ready;
> -
> -	/*
> -	 * Net bytes freed or allocated since the last reclaim pass.
> -	 */
> -	s64 reclaimable_bytes;
> +	bool periodic_reclaim_paused;
> +	int last_reclaim_threshold;
> +	u64 last_reclaim_unused;
>  };
>  
>  static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
> @@ -301,9 +298,22 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
>  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
>  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
>  
> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
>  int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
> +static inline void btrfs_resume_periodic_reclaim(struct btrfs_space_info *space_info)
> +{
> +	lockdep_assert_held(&space_info->lock);
> +	if (space_info->periodic_reclaim_paused)
> +		space_info->periodic_reclaim_paused = false;
> +}
> +static inline void btrfs_pause_periodic_reclaim(struct btrfs_space_info *space_info)
> +{
> +	lockdep_assert_held(&space_info->lock);
> +	if (!space_info->periodic_reclaim_paused) {
> +		space_info->periodic_reclaim_paused = true;
> +		space_info->last_reclaim_threshold = btrfs_calc_reclaim_threshold(space_info);
> +		space_info->last_reclaim_unused = space_info->total_bytes - space_info->bytes_used;
> +	}
> +}
>  void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>  void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
>  
> -- 
> 2.51.2
> 

