Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 007F2D452B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2019 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfJKQPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Oct 2019 12:15:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38691 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfJKQPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Oct 2019 12:15:53 -0400
Received: by mail-qk1-f194.google.com with SMTP id x4so5454737qkx.5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2019 09:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2J0tktDt3UfWpRso/PnTYzUMiDFi9Lghc41olFAoXgI=;
        b=leD1vSyHaP+GBklTpLSTuPaeLGN+N/bVYbnsFKZw2iw7VjSywJz8nakL7Y1eTJoetc
         /p2fKpATum9fsQ92H7p8upRBeqKFgeRCj2xLKUYoyqZHFl7JUcVHzLXkf/s5GDjLvvpm
         wjaRiHQzLKvEGFKJfiC2/24EauWj9A/ZS7ECJfNllsuxeHuYHFpuThbfYCERxo8nQb/+
         +SGQRs4D0Wojsjbd3NaWxZnzyYiHurrLeYx7JzgoOAxlL0TCQBaYEPF0HOoCnCGhEdkw
         vKf44NEFSBZfdEkHza4aq4P6x4181VfKVRriZQNiWOn3G6U9NJqm6/oBxiFgMcvIZs6r
         7WfA==
X-Gm-Message-State: APjAAAX42uqtYa8OzIuSEa9G13S91uwDQ2Pk7S2gIvmsSgFHjJeJxfo+
        b68vTt04Enx/yQ1wZGYNnaM=
X-Google-Smtp-Source: APXvYqyi+F/QYtuzDsQKztNFw8y5vrxVNcKTBGQLYdmaqOHthAStSS5ujdgKaWbka6e6QJvpTmsnGQ==
X-Received: by 2002:a37:5b46:: with SMTP id p67mr16574820qkb.318.1570810552072;
        Fri, 11 Oct 2019 09:15:52 -0700 (PDT)
Received: from dennisz-mbp ([2620:10d:c091:500::2:985b])
        by smtp.gmail.com with ESMTPSA id g26sm4023901qtq.88.2019.10.11.09.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:15:51 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:15:49 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/19] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191011161549.GB29672@dennisz-mbp>
References: <cover.1570479299.git.dennis@kernel.org>
 <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
 <20191007203727.26np5hdnr4nqx3kk@MacBook-Pro-91.local>
 <20191007223810.GB26876@dennisz-mbp.dhcp.thefacebook.com>
 <20191010134035.khr6ifhfu37afrav@MacBook-Pro-91.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010134035.khr6ifhfu37afrav@MacBook-Pro-91.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 10, 2019 at 09:40:37AM -0400, Josef Bacik wrote:
> On Mon, Oct 07, 2019 at 06:38:10PM -0400, Dennis Zhou wrote:
> > On Mon, Oct 07, 2019 at 04:37:28PM -0400, Josef Bacik wrote:
> > > On Mon, Oct 07, 2019 at 04:17:34PM -0400, Dennis Zhou wrote:
> > > > Async discard will use the free space cache as backing knowledge for
> > > > which extents to discard. This patch plumbs knowledge about which
> > > > extents need to be discarded into the free space cache from
> > > > unpin_extent_range().
> > > > 
> > > > An untrimmed extent can merge with everything as this is a new region.
> > > > Absorbing trimmed extents is a tradeoff to for greater coalescing which
> > > > makes life better for find_free_extent(). Additionally, it seems the
> > > > size of a trim isn't as problematic as the trim io itself.
> > > > 
> > > > When reading in the free space cache from disk, if sync is set, mark all
> > > > extents as trimmed. The current code ensures at transaction commit that
> > > > all free space is trimmed when sync is set, so this reflects that.
> > > > 
> > > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > > ---
> > > >  fs/btrfs/extent-tree.c      | 15 ++++++++++-----
> > > >  fs/btrfs/free-space-cache.c | 38 ++++++++++++++++++++++++++++++-------
> > > >  fs/btrfs/free-space-cache.h | 10 +++++++++-
> > > >  fs/btrfs/inode-map.c        | 13 +++++++------
> > > >  4 files changed, 57 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > > index 77a5904756c5..b9e3bedad878 100644
> > > > --- a/fs/btrfs/extent-tree.c
> > > > +++ b/fs/btrfs/extent-tree.c
> > > > @@ -2782,7 +2782,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
> > > >  }
> > > >  
> > > >  static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> > > > -			      u64 start, u64 end,
> > > > +			      u64 start, u64 end, u32 fsc_flags,
> > > >  			      const bool return_free_space)
> > > >  {
> > > >  	struct btrfs_block_group_cache *cache = NULL;
> > > > @@ -2816,7 +2816,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> > > >  		if (start < cache->last_byte_to_unpin) {
> > > >  			len = min(len, cache->last_byte_to_unpin - start);
> > > >  			if (return_free_space)
> > > > -				btrfs_add_free_space(cache, start, len);
> > > > +				__btrfs_add_free_space(fs_info,
> > > > +						       cache->free_space_ctl,
> > > > +						       start, len, fsc_flags);
> > > >  		}
> > > >  
> > > >  		start += len;
> > > > @@ -2894,6 +2896,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> > > >  
> > > >  	while (!trans->aborted) {
> > > >  		struct extent_state *cached_state = NULL;
> > > > +		u32 fsc_flags = 0;
> > > >  
> > > >  		mutex_lock(&fs_info->unused_bg_unpin_mutex);
> > > >  		ret = find_first_extent_bit(unpin, 0, &start, &end,
> > > > @@ -2903,12 +2906,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> > > >  			break;
> > > >  		}
> > > >  
> > > > -		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> > > > +		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
> > > >  			ret = btrfs_discard_extent(fs_info, start,
> > > >  						   end + 1 - start, NULL);
> > > > +			fsc_flags |= BTRFS_FSC_TRIMMED;
> > > > +		}
> > > >  
> > > >  		clear_extent_dirty(unpin, start, end, &cached_state);
> > > > -		unpin_extent_range(fs_info, start, end, true);
> > > > +		unpin_extent_range(fs_info, start, end, fsc_flags, true);
> > > >  		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
> > > >  		free_extent_state(cached_state);
> > > >  		cond_resched();
> > > > @@ -5512,7 +5517,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
> > > >  int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
> > > >  				   u64 start, u64 end)
> > > >  {
> > > > -	return unpin_extent_range(fs_info, start, end, false);
> > > > +	return unpin_extent_range(fs_info, start, end, 0, false);
> > > >  }
> > > >  
> > > >  /*
> > > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > > > index d54dcd0ab230..f119895292b8 100644
> > > > --- a/fs/btrfs/free-space-cache.c
> > > > +++ b/fs/btrfs/free-space-cache.c
> > > > @@ -747,6 +747,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
> > > >  			goto free_cache;
> > > >  		}
> > > >  
> > > > +		/*
> > > > +		 * Sync discard ensures that the free space cache is always
> > > > +		 * trimmed.  So when reading this in, the state should reflect
> > > > +		 * that.
> > > > +		 */
> > > > +		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> > > > +			e->flags |= BTRFS_FSC_TRIMMED;
> > > > +
> > > >  		if (!e->bytes) {
> > > >  			kmem_cache_free(btrfs_free_space_cachep, e);
> > > >  			goto free_cache;
> > > > @@ -2165,6 +2173,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> > > >  	bool merged = false;
> > > >  	u64 offset = info->offset;
> > > >  	u64 bytes = info->bytes;
> > > > +	bool is_trimmed = btrfs_free_space_trimmed(info);
> > > >  
> > > >  	/*
> > > >  	 * first we want to see if there is free space adjacent to the range we
> > > > @@ -2178,7 +2187,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> > > >  	else
> > > >  		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
> > > >  
> > > > -	if (right_info && !right_info->bitmap) {
> > > > +	if (right_info && !right_info->bitmap &&
> > > > +	    (!is_trimmed || btrfs_free_space_trimmed(right_info))) {
> > > >  		if (update_stat)
> > > >  			unlink_free_space(ctl, right_info);
> > > >  		else
> > > > @@ -2189,7 +2199,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> > > >  	}
> > > >  
> > > >  	if (left_info && !left_info->bitmap &&
> > > > -	    left_info->offset + left_info->bytes == offset) {
> > > > +	    left_info->offset + left_info->bytes == offset &&
> > > > +	    (!is_trimmed || btrfs_free_space_trimmed(left_info))) {
> > > 
> > > So we allow merging if we haven't trimmed this entry, or if the adjacent entry
> > > is already trimmed?  This means we'll merge if we trimmed the new entry
> > > regardless of the adjacent entries status, or if the new entry is drity.  Why is
> > > that?  Thanks,
> > > 
> > 
> > This is the tradeoff I called out above here:
> > 
> > > > Absorbing trimmed extents is a tradeoff to for greater coalescing which
> > > > makes life better for find_free_extent(). Additionally, it seems the
> > > > size of a trim isn't as problematic as the trim io itself.
> > 
> > A problematic example case:
> > 
> > |----trimmed----|/////X/////|-----trimmed-----|
> > 
> > If region X gets freed and returned to the free space cache, we end up
> > with the following:
> > 
> > |----trimmed----|-untrimmed-|-----trimmed-----|
> > 
> > This isn't great because now we need to teach find_free_extent() to span
> > multiple btrfs_free_space entries, something I didn't want to do. So the
> > other option is to overtrim trading for a simpler find_free_extent().
> > Then the above becomes:
> > 
> > |-------------------trimmed-------------------|
> > 
> > It makes the assumption that if we're inserting, it's generally is free
> > space being returned rather than we needed to slice out from the middle
> > of a block. It does still have degenerative cases, but it's better than
> > the above. The merging also allows for stuff to come out of bitmaps more
> > proactively too.
> > 
> > Also from what it seems, the cost of a discard operation is quite costly
> > relative to the amount your discarding (1 larger discard is better than
> > several smaller discards) as it will clog up the device too.
> 
> 
> OOOOOh I fucking get it now.  That's going to need a comment, because it's not
> obvious at all.
> 
> However I still wonder if this is right.  Your above examples are legitimate,
> but say you have
> 
> | 512mib adding back that isn't trimmed |------- 512mib trimmed ------|
> 
> we'll merge these two, but really we should probably trim that 512mib chunk
> we're adding right?  Thanks,
> 

So that's the crux of the problem. I'm not sure if it's right to make
heuristics around this and have merging thresholds because it makes the
code tricker + not necessarily correct. A contrived case would be
something where we go through a few iterations of merging because we
pulled stuff out of the bitmaps and that then was able to merge more
free space. How do you what the right balance is for merging extents?

I kind of favor the overeager approach for now because it is always
correct to rediscard regions, but forgetting about regions means it may
go undiscarded until for some unbounded time in the future.  This also
makes life the easiest for find_free_extent().

As I said, I'm not sure what the right thing to do is, so I favored
being accurate.  This is something I'm happy to change depending on
discussion and on further data I collect.

I added a comment, I might need to make it more indepth, but it's a
start (I'll revisit before v2).

Thanks,
Dennis
