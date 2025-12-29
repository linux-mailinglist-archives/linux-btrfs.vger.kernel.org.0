Return-Path: <linux-btrfs+bounces-20035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1165BCE85DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Dec 2025 00:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B9E3019BD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Dec 2025 23:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9C2FB965;
	Mon, 29 Dec 2025 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NWv9K3f3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVRMLaQW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5B22DA1C
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Dec 2025 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767052507; cv=none; b=u0fBDfKy8UsSnkBRV90s5ACIY8Zxu3eJtvfBuqZjfJYGwfbddcTdoQAShrxD/RuOywDBXu4XL8pAA8xc6I2HUCiW78F987yUYm1RDYZkfdsbiLOL7k5ZZ48wc5JwJRnd5UEaCeI64wFzKwv0Pj8PS2+cJr+fId51R7kiNQDrUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767052507; c=relaxed/simple;
	bh=wExKF5FCvsM6d1hOMdqNDNAVkGrLdKT+upNXmyyCWOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqmR5UAoUT4fRHaG5Cr25kZXIjp8CmKhevMJREGZwa88mbRzwdAjuCL935o/29LtaCjPcBvCBVpm5EjaSOeoRlNjslUMnck9ySdI+x2IE4Xu+yEhv1/SkcA/fTUIgok0f/OY3i7LkgYCgzN12GDOFaveFiWKjUxPMRjl2EKDMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NWv9K3f3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVRMLaQW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9AC301D000B9;
	Mon, 29 Dec 2025 18:55:03 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 29 Dec 2025 18:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767052503; x=1767138903; bh=FdO8HdNaP/
	q4tJy8RsDdzdxosA5miYdiSOpCdd02d3I=; b=NWv9K3f3wedLR/FfLL53ScJcin
	yy/7Y+VrWIho93tzZCYt9NaqKg9T7JF5pAiuPc+DCqsbxhoR1oO/3pLANqprTBv4
	CER5ijS0ewkuByAjMkWHlJQnIvDIFF8LGYvBsksaQFAA1vfCc7THobT3XUZOw4qz
	s+UfFwG4X3m01WlIQtTQWS3NCOOSB9BotWgIHyefrG6gd5w1a1UBn4uMzMxB5x8t
	PwZ7Ke/nWyXQZAScdJKb45Hg+WFEj4ieeuocI/MaC03zuJL+JC1Ubt6toj3eM+71
	QstSuH1jqTKhvuZWFxhcOtoDNYatA2n2BT14ljfVOfYPJ6RORthM5DniSzoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767052503; x=1767138903; bh=FdO8HdNaP/q4tJy8RsDdzdxosA5miYdiSOp
	Cdd02d3I=; b=eVRMLaQW5Cz/x6rM9DUwsKLx0pg7j2CtiOnM4wYf+fq+1E0xrfv
	Spq/knDDPkGQHDj4gg9yRWCjIDkt/tguhQXTCKWcfMgXj1Grt0vaCDWDtJ5eJfi+
	a086B8SWSwMJYiJjguZkIA+jL/zEJXm7kKKC50Sg7HuejWxjZNUM3m0r/lzzJ/OC
	t+d++029u5iEfibg7lCcGJZmPMMlvVufsNxqQjk3Ot+YYux/f9NudtSWKqkEG98H
	sjNpKjsDGpSaDuqA0sCkQpZPua9/bqhsEC1pmr5lyh2Izo7B8UQJBROiF9t2AfxX
	i9DKy7kASodWVDNuvDntRydrU3G3KbMK5bA==
X-ME-Sender: <xms:1xRTadoG8huM94mZQIteLF0ZfiFP7KnsAm0djc9zteoZ1UcI5GQPzg>
    <xme:1xRTaXG-_mYZ1wDLeLmZ0HOIq6MsrMq-vx9nhWxSEv95GjAvtfHEoF4-FQCfH40T2
    vMePrAGk1xbYnRhEiBboamziRnj4S-JVZZzvnQSyU6v6vKs82scyIg>
X-ME-Received: <xmr:1xRTaXmkOnwgYM8XWaL8CMR-65Jv91bSNMHzWebej_TZZBFHlB7OtAwJzT8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejkeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiie
    dugfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhkieejudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphhtthhope
    hlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1xRTaSlBEwsIOHcuEyjBwCKlKm_FDX1ZMnVkkt0kHgBR6GcNscJ0dQ>
    <xmx:1xRTaQsQ6w3GLlbaFPB89aHpmWuPtqnIMPaF4lrjIbjO_-xHEkyjxw>
    <xmx:1xRTadk3NXzCtc-5ZJ6RLNLSNcpq26Chnxau4WtJhS7csxPtALcAIQ>
    <xmx:1xRTaTvHtMrsuejiDptmOGyu1uog5lIyuRCJll5d4lZCDDNut8joow>
    <xmx:1xRTadmbHRDQ9l83270-KKCgL68BsnNvq934WRtzcPct_wuDYoZzIxcC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 18:55:02 -0500 (EST)
Date: Mon, 29 Dec 2025 15:54:59 -0800
From: Boris Burkov <boris@bur.io>
To: Sun Yangkai <sunk67188@gmail.com>
Cc: kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/6] btrfs: prevent pathological periodic reclaim loops
Message-ID: <aVMU08bgkt79Pl/Q@devvm12410.ftw0.facebook.com>
References: <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>
 <29f9e528-9dbe-48fb-9353-6ad7177be50f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f9e528-9dbe-48fb-9353-6ad7177be50f@gmail.com>

On Fri, Dec 26, 2025 at 12:18:51PM +0800, Sun Yangkai wrote:
> > Periodic reclaim runs the risk of getting stuck in a state where it
> > keeps reclaiming the same block group over and over. This can happen if
> > 1. reclaiming that block_group fails
> > 2. reclaiming that block_group fails to move any extents into existing
> >    block_groups and just allocates a fresh chunk and moves everything.
> > 
> > Currently, 1. is a very tight loop inside the reclaim worker. That is
> > critical for edge triggered reclaim or else we risk forgetting about a
> > reclaimable group. On the other hand, with level triggered reclaim we
> > can break out of that loop and get it later.
> > 
> > With that fixed, 2. applies to both failures and "successes" with no
> > progress. If we have done a periodic reclaim on a space_info and nothing
> > has changed in that space_info, there is not much point to trying again,
> > so don't, until enough space gets free, which we capture with a
> > heuristic of needing to net free 1 chunk.
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/block-group.c | 12 ++++++---
> >  fs/btrfs/space-info.c  | 56 ++++++++++++++++++++++++++++++++++++------
> >  fs/btrfs/space-info.h  | 14 +++++++++++
> >  3 files changed, 71 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 6bcf24f2ac79..ba9afb94e7ce 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -1933,6 +1933,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >  			reclaimed = 0;
> >  			spin_lock(&space_info->lock);
> >  			space_info->reclaim_errors++;
> > +			if (READ_ONCE(space_info->periodic_reclaim))
> > +				space_info->periodic_reclaim_ready = false;
> 
> I wonder why we're not clearing the reclaimble_bytes count here.
> 

As far as I can tell, it's an oversight. I think it ought to use
btrfs_set_reclaim_ready(fs_info, false) here. However, FWIW, the
reclaimable bytes already got reset when we checked whether reclaim was
ready, so this would extra re-clear it after. It honestly might make the
most sense to just get rid of this logic here entirely, as it's pretty
redundant with setting ready=false at the start of each invocation of
periodic_reclaim.

> >  			spin_unlock(&space_info->lock);
> >  		}
> >  		spin_lock(&space_info->lock);
> > @@ -1941,7 +1943,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
> >  		spin_unlock(&space_info->lock);
> >  
> >  next:
> > -		if (ret) {
> > +		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
> >  			/* Refcount held by the reclaim_bgs list after splice. */
> >  			btrfs_get_block_group(bg);
> >  			list_add_tail(&bg->bg_list, &retry_list);
> > @@ -3677,6 +3679,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> >  		space_info->bytes_reserved -= num_bytes;
> >  		space_info->bytes_used += num_bytes;
> >  		space_info->disk_used += num_bytes * factor;
> > +		if (READ_ONCE(space_info->periodic_reclaim))
> > +			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
> >  		spin_unlock(&cache->lock);
> >  		spin_unlock(&space_info->lock);
> >  	} else {
> > @@ -3686,8 +3690,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> >  		btrfs_space_info_update_bytes_pinned(info, space_info, num_bytes);
> >  		space_info->bytes_used -= num_bytes;
> >  		space_info->disk_used -= num_bytes * factor;
> > -
> > -		reclaim = should_reclaim_block_group(cache, num_bytes);
> > +		if (READ_ONCE(space_info->periodic_reclaim))
> > +			btrfs_space_info_update_reclaimable(space_info, num_bytes);
> > +		else
> > +			reclaim = should_reclaim_block_group(cache, num_bytes);
> >  
> >  		spin_unlock(&cache->lock);
> >  		spin_unlock(&space_info->lock);
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index ff92ad26ffa2..e7a2aa751f8f 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  
> > +#include "linux/spinlock.h"
> >  #include <linux/minmax.h>
> >  #include "misc.h"
> >  #include "ctree.h"
> > @@ -1899,7 +1900,9 @@ static u64 calc_pct_ratio(u64 x, u64 y)
> >   */
> >  static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
> >  {
> > -	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * calc_effective_data_chunk_size(fs_info);
> > +	u64 chunk_sz = calc_effective_data_chunk_size(fs_info);
> > +
> > +	return BTRFS_UNALLOC_BLOCK_GROUP_TARGET * chunk_sz;
> >  }
> >  
> >  /*
> > @@ -1935,14 +1938,13 @@ static int calc_dynamic_reclaim_threshold(struct btrfs_space_info *space_info)
> >  	u64 unused = alloc - used;
> >  	u64 want = target > unalloc ? target - unalloc : 0;
> >  	u64 data_chunk_size = calc_effective_data_chunk_size(fs_info);
> > -	/* Cast to int is OK because want <= target */
> > -	int ratio = calc_pct_ratio(want, target);
> >  
> > -	/* If we have no unused space, don't bother, it won't work anyway */
> > +	/* If we have no unused space, don't bother, it won't work anyway. */
> >  	if (unused < data_chunk_size)
> >  		return 0;
> >  
> > -	return ratio;
> > +	/* Cast to int is OK because want <= target. */
> > +	return calc_pct_ratio(want, target);
> >  }
> >  
> >  int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info)
> > @@ -1984,6 +1986,46 @@ static int do_reclaim_sweep(struct btrfs_fs_info *fs_info,
> >  	return 0;
> >  }
> >  
> > +void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes)
> > +{
> > +	u64 chunk_sz = calc_effective_data_chunk_size(space_info->fs_info);
> > +
> > +	assert_spin_locked(&space_info->lock);
> > +	space_info->reclaimable_bytes += bytes;
> > +
> > +	if (space_info->reclaimable_bytes >= chunk_sz)
> 
> We're comparing s64 with u64 here, and it won't work as expected.

Good catch. Since we could do a bunch of allocation and make
reclaimable_bytes negative, we need to check for negative
reclaimable_bytes first, as the coercion to a giant u64 is actually
quite possible in practice.

> 
> Even after fixing this by changing chunk_sz to s64, it will not work as expected
> in the following case:
> 
> - We're filling the disk so reclaimable_bytes is always negative.
> - There's less than 10G unallocated so dynamic_reclaim kicked in.
> - periodic_reclaim will never work since reclaimable_bytes is always negetive.
> 

Yes, I agree that this case will thrash the reclaim if we keep
allocating constantly (without going enospc).

Good catch! Hopefully that's what is happening in your report on the
other email.

> > +		btrfs_set_periodic_reclaim_ready(space_info, true);
> > +}
> > +
> > +void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
> > +{
> > +	assert_spin_locked(&space_info->lock);
> > +	if (!READ_ONCE(space_info->periodic_reclaim))
> > +		return;
> > +	if (ready != space_info->periodic_reclaim_ready) {
> > +		space_info->periodic_reclaim_ready = ready;
> > +		if (!ready)
> > +			space_info->reclaimable_bytes = 0;
> > +	}
> > +}
> > +
> > +bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
> > +{
> > +	bool ret;
> > +
> > +	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> > +		return false;
> > +	if (!READ_ONCE(space_info->periodic_reclaim))
> > +		return false;
> > +
> > +	spin_lock(&space_info->lock);
> > +	ret = space_info->periodic_reclaim_ready;
> > +	btrfs_set_periodic_reclaim_ready(space_info, false);
> > +	spin_unlock(&space_info->lock);
> > +
> > +	return ret;
> > +}
> > +
> >  int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
> >  {
> >  	int ret;
> > @@ -1991,9 +2033,7 @@ int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info)
> >  	struct btrfs_space_info *space_info;
> >  
> >  	list_for_each_entry(space_info, &fs_info->space_info, list) {
> > -		if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
> > -			continue;
> > -		if (!READ_ONCE(space_info->periodic_reclaim))
> > +		if (!btrfs_should_periodic_reclaim(space_info))
> >  			continue;
> >  		for (raid = 0; raid < BTRFS_NR_RAID_TYPES; raid++) {
> >  			ret = do_reclaim_sweep(fs_info, space_info, raid);
> > diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> > index ae4a1f7d5856..4db8a0267c16 100644
> > --- a/fs/btrfs/space-info.h
> > +++ b/fs/btrfs/space-info.h
> > @@ -196,6 +196,17 @@ struct btrfs_space_info {
> >  	 * threshold in the cleaner thread.
> >  	 */
> >  	bool periodic_reclaim;
> > +
> > +	/*
> > +	 * Periodic reclaim should be a no-op if a space_info hasn't
> > +	 * freed any space since the last time we tried.
> > +	 */
> > +	bool periodic_reclaim_ready;
> 
> Also, I wonder why we need this bool flag. I think we care more about if
> reclaimable_bytes' value is more than 1G when calling
> btrfs_should_periodic_reclaim() rather than if it has been more than 1G during
> two calls of btrfs_should_periodic_reclaim().

This is probably an accident of how the logic evolved as I iterated on
the design. The first version was to set ready false on a failure then
set it true on a deallocation, then I "enhanced" it with the
reclaimable_bytes logic to make it more conservative.

I think getting rid of periodic_reclaim_ready and just doing it off of
bytes_reclaimable (which still gets reset after every reclaim attempt)
would make sense.

Thanks,
Boris

> 
> Thanks,
> Sun YangKai
> 
> > +
> > +	/*
> > +	 * Net bytes freed or allocated since the last reclaim pass.
> > +	 */
> > +	s64 reclaimable_bytes;
> >  };
> >  
> >  struct reserve_ticket {
> > @@ -278,6 +289,9 @@ void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
> >  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
> >  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
> >  
> > +void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
> > +void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
> > +bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
> >  int btrfs_calc_reclaim_threshold(struct btrfs_space_info *space_info);
> >  int btrfs_reclaim_sweep(struct btrfs_fs_info *fs_info);
> >  
> > -- 
> > 2.45.2
> 

