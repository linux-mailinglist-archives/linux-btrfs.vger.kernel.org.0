Return-Path: <linux-btrfs+bounces-5924-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F3C91531A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DE7EB22476
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F7E19D88B;
	Mon, 24 Jun 2024 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lNBrEu0L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1vQvOu7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="21AnBXmk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kU+9zHdb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACD919D062
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245133; cv=none; b=BbdFXxS3uvC7gD8SJXYsfc/u6id9LNurg5p3QbzGPf4NC0z5LeZfEKCLIjeGU9Xswt33jDXGI9RT/qzj6clo2WWnOd1r0mD86sFFXJIWsV0qUklibdNkKWEZYGMvbyUJLE1sCJbLk8sym+l9H73dptejTcKz0DuF+ro8HkGvo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245133; c=relaxed/simple;
	bh=dtMbZluLaOs/shULV/xg3YIDZN5Pm8pq6DCuQXkQfv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVwpognX5xePkH+656hjc2tmwcaNClbC43OVTFMCcWOqdIx3kw8T9qDgj2GldnGj5IaLN1ELMCdBAgRcBs/XVbhKlg6Afp2RJBIiN+562GI+kzfg9JG7Vo6r95KjWMGbTltBKYXnxOBf7sfJEPQntIQrgW6sb1f7uiY9cRg4dkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lNBrEu0L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1vQvOu7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=21AnBXmk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kU+9zHdb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD634219EF;
	Mon, 24 Jun 2024 16:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719245130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNml2q/TiXgoXjBRDKtAHoXk0ljR6Dbg4TyFik2D+M=;
	b=lNBrEu0LyZsWBPskkxiNWt1w5HiSCpK/sBkkDGSv6aRAfogcrl407/ymmt3aYiD8viyAgD
	Rp7h2JMu76BVfC2NqNQUz38DuoCU60dGHmTDzcyxJe3ompjbxIqg7AqNLXETWvW3Dd1GZP
	Gm6FMNFdmxChzQqrIUnWWN66OTs3ILE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719245130;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNml2q/TiXgoXjBRDKtAHoXk0ljR6Dbg4TyFik2D+M=;
	b=n1vQvOu7GaGEiCdEDJe0vv/tGBJT8uHoIuN0ekfz0Un9vSmYA9WvSK7gNFKpertVmbDEFA
	5hMOQ9s4Fn46znDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719245128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNml2q/TiXgoXjBRDKtAHoXk0ljR6Dbg4TyFik2D+M=;
	b=21AnBXmkQZbqoJdElrWZ77hILYTbeQpGF3fYOX0hCHUQjmCc6/U7eWAYfxEZvU3IZwKGEp
	NhRVMAzsLaaKme1BVuxSe3H7Ld/I/4zm2RP8Cti6KnBoNS2GLWUJ6acM2ca37htoMz3i7i
	GwyDbDAy0s8I462YmbIcD4Yzqq3Sjo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719245128;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjNml2q/TiXgoXjBRDKtAHoXk0ljR6Dbg4TyFik2D+M=;
	b=kU+9zHdbrnuNONyPKcEnZBfbEoEhEQLykH8TPMsiRATp+2dRObDkbhwBGB40zg4v59O/ki
	yly99NF6DKZRccCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A791384C;
	Mon, 24 Jun 2024 16:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jqErI0iZeWbMKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 16:05:28 +0000
Date: Mon, 24 Jun 2024 18:05:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v2 5/6] btrfs: prevent pathological periodic reclaim loops
Message-ID: <20240624160527.GP25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718665689.git.boris@bur.io>
 <34fe3a28628bcd97e2b7c9659da73f43744f4bdf.1718665689.git.boris@bur.io>
 <20240624152300.GA2513195@perftesting>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624152300.GA2513195@perftesting>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,btrfs.readthedocs.io:url,imap1.dmz-prg2.suse.org:helo,bur.io:email]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Jun 24, 2024 at 11:23:00AM -0400, Josef Bacik wrote:
> On Mon, Jun 17, 2024 at 04:11:17PM -0700, Boris Burkov wrote:
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
> > +		btrfs_set_periodic_reclaim_ready(space_info, true);
> > +}
> > +
> > +void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready)
> > +{
> > +	assert_spin_locked(&space_info->lock);
> 
> This is essentially
> 
> BUG_ON(!locked(spin_lock));
> 
> instead use
> 
> lockdep_assert_held()
> 
> which will just yell at us so we can fix it.  Thanks,

Also documented

https://btrfs.readthedocs.io/en/latest/dev/Development-notes.html#locking

