Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1839D2B8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfJJNkl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 09:40:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43312 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfJJNkk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 09:40:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so5594099qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 06:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a0a4DJQGXGtXDHooqUK1TjoB0xuwglB2xEOUvEuHULM=;
        b=H2V1OacteLnxzHtFiAmnEYZTjlZK/h/hsTim7FR9VY0MFo77G8F4Rh9fVQYXiiNtP1
         TblvMAVN7tSaTHuKJlVXeIYkKuA6mGyVhZd6wpuu/V/o37BoZCMSucT1CJ2cL9Fa/ior
         qIDTJ1jsQkXpzKtxIT+n6rE7kq2K3YE1fF9QDZYLO2TKbIgO6i5ZIRaZTneCgRMRxlbV
         C0KVji+w+rdxSEHP7Nb26nb+NDFm2vGh+hJ3dO7UoyQd56dS0dkQf7y2NTghbsCBqk20
         kdvKJzuXgsupeEymTzQkC/E+sZ/ZCWpgL2ED+kKu6ULO0ChtthIPUivaeMlIVKZoHm+Y
         hbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a0a4DJQGXGtXDHooqUK1TjoB0xuwglB2xEOUvEuHULM=;
        b=ucLfJxGAYj6sb1w9iNL8UbNNji+zIsjghDIm15r4kMwWn8FF4sxE/V2p/9ePKO3M7z
         WTyrXYb5Oct8lYBpxZD5FkSMQhcGu4rFv+EEA47CPv7KT72p5mixjLM5cxRp4Lp59cuf
         dbYbq+9cBabTYcxHL9Fo5S6/OGKluHE+iw1oxQqdmdIycVQxG3Vlzpv7v0yYQ1c7CEdG
         mKfdYaVic/xErJStGXCn5M5rFzZKwuA1YUh0mYEEhgXKP1Z8EU2rM10eaEjjmYSv1Ucp
         K2xeik508wYE4fWsePyiUyychozEG3C+s2Oi62sKA1iLEulMStSwm8SbhDPJN7LJNRLS
         W+yg==
X-Gm-Message-State: APjAAAUbfYXQfsiF+5W8WAJ2L/SbFl6SIcK0hx2DQQHZQC0CVl9nUQW8
        5y8ufQvv9uDtnl1OYeW8DdYCsQ==
X-Google-Smtp-Source: APXvYqxKhY8ZWY/+UYyFj24v5YI9hy3Fqzk32ZJWaWEPUxyVN63xUm84r0IEZNPpiMPXpwNCVdYRww==
X-Received: by 2002:ae9:f44d:: with SMTP id z13mr9547298qkl.90.1570714839278;
        Thu, 10 Oct 2019 06:40:39 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j5sm2300212qkd.56.2019.10.10.06.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:40:38 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:40:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/19] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191010134035.khr6ifhfu37afrav@MacBook-Pro-91.local>
References: <cover.1570479299.git.dennis@kernel.org>
 <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
 <20191007203727.26np5hdnr4nqx3kk@MacBook-Pro-91.local>
 <20191007223810.GB26876@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007223810.GB26876@dennisz-mbp.dhcp.thefacebook.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 06:38:10PM -0400, Dennis Zhou wrote:
> On Mon, Oct 07, 2019 at 04:37:28PM -0400, Josef Bacik wrote:
> > On Mon, Oct 07, 2019 at 04:17:34PM -0400, Dennis Zhou wrote:
> > > Async discard will use the free space cache as backing knowledge for
> > > which extents to discard. This patch plumbs knowledge about which
> > > extents need to be discarded into the free space cache from
> > > unpin_extent_range().
> > > 
> > > An untrimmed extent can merge with everything as this is a new region.
> > > Absorbing trimmed extents is a tradeoff to for greater coalescing which
> > > makes life better for find_free_extent(). Additionally, it seems the
> > > size of a trim isn't as problematic as the trim io itself.
> > > 
> > > When reading in the free space cache from disk, if sync is set, mark all
> > > extents as trimmed. The current code ensures at transaction commit that
> > > all free space is trimmed when sync is set, so this reflects that.
> > > 
> > > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > > ---
> > >  fs/btrfs/extent-tree.c      | 15 ++++++++++-----
> > >  fs/btrfs/free-space-cache.c | 38 ++++++++++++++++++++++++++++++-------
> > >  fs/btrfs/free-space-cache.h | 10 +++++++++-
> > >  fs/btrfs/inode-map.c        | 13 +++++++------
> > >  4 files changed, 57 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > index 77a5904756c5..b9e3bedad878 100644
> > > --- a/fs/btrfs/extent-tree.c
> > > +++ b/fs/btrfs/extent-tree.c
> > > @@ -2782,7 +2782,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
> > >  }
> > >  
> > >  static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> > > -			      u64 start, u64 end,
> > > +			      u64 start, u64 end, u32 fsc_flags,
> > >  			      const bool return_free_space)
> > >  {
> > >  	struct btrfs_block_group_cache *cache = NULL;
> > > @@ -2816,7 +2816,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> > >  		if (start < cache->last_byte_to_unpin) {
> > >  			len = min(len, cache->last_byte_to_unpin - start);
> > >  			if (return_free_space)
> > > -				btrfs_add_free_space(cache, start, len);
> > > +				__btrfs_add_free_space(fs_info,
> > > +						       cache->free_space_ctl,
> > > +						       start, len, fsc_flags);
> > >  		}
> > >  
> > >  		start += len;
> > > @@ -2894,6 +2896,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> > >  
> > >  	while (!trans->aborted) {
> > >  		struct extent_state *cached_state = NULL;
> > > +		u32 fsc_flags = 0;
> > >  
> > >  		mutex_lock(&fs_info->unused_bg_unpin_mutex);
> > >  		ret = find_first_extent_bit(unpin, 0, &start, &end,
> > > @@ -2903,12 +2906,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> > >  			break;
> > >  		}
> > >  
> > > -		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> > > +		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
> > >  			ret = btrfs_discard_extent(fs_info, start,
> > >  						   end + 1 - start, NULL);
> > > +			fsc_flags |= BTRFS_FSC_TRIMMED;
> > > +		}
> > >  
> > >  		clear_extent_dirty(unpin, start, end, &cached_state);
> > > -		unpin_extent_range(fs_info, start, end, true);
> > > +		unpin_extent_range(fs_info, start, end, fsc_flags, true);
> > >  		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
> > >  		free_extent_state(cached_state);
> > >  		cond_resched();
> > > @@ -5512,7 +5517,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
> > >  int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
> > >  				   u64 start, u64 end)
> > >  {
> > > -	return unpin_extent_range(fs_info, start, end, false);
> > > +	return unpin_extent_range(fs_info, start, end, 0, false);
> > >  }
> > >  
> > >  /*
> > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > > index d54dcd0ab230..f119895292b8 100644
> > > --- a/fs/btrfs/free-space-cache.c
> > > +++ b/fs/btrfs/free-space-cache.c
> > > @@ -747,6 +747,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
> > >  			goto free_cache;
> > >  		}
> > >  
> > > +		/*
> > > +		 * Sync discard ensures that the free space cache is always
> > > +		 * trimmed.  So when reading this in, the state should reflect
> > > +		 * that.
> > > +		 */
> > > +		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> > > +			e->flags |= BTRFS_FSC_TRIMMED;
> > > +
> > >  		if (!e->bytes) {
> > >  			kmem_cache_free(btrfs_free_space_cachep, e);
> > >  			goto free_cache;
> > > @@ -2165,6 +2173,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> > >  	bool merged = false;
> > >  	u64 offset = info->offset;
> > >  	u64 bytes = info->bytes;
> > > +	bool is_trimmed = btrfs_free_space_trimmed(info);
> > >  
> > >  	/*
> > >  	 * first we want to see if there is free space adjacent to the range we
> > > @@ -2178,7 +2187,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> > >  	else
> > >  		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
> > >  
> > > -	if (right_info && !right_info->bitmap) {
> > > +	if (right_info && !right_info->bitmap &&
> > > +	    (!is_trimmed || btrfs_free_space_trimmed(right_info))) {
> > >  		if (update_stat)
> > >  			unlink_free_space(ctl, right_info);
> > >  		else
> > > @@ -2189,7 +2199,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
> > >  	}
> > >  
> > >  	if (left_info && !left_info->bitmap &&
> > > -	    left_info->offset + left_info->bytes == offset) {
> > > +	    left_info->offset + left_info->bytes == offset &&
> > > +	    (!is_trimmed || btrfs_free_space_trimmed(left_info))) {
> > 
> > So we allow merging if we haven't trimmed this entry, or if the adjacent entry
> > is already trimmed?  This means we'll merge if we trimmed the new entry
> > regardless of the adjacent entries status, or if the new entry is drity.  Why is
> > that?  Thanks,
> > 
> 
> This is the tradeoff I called out above here:
> 
> > > Absorbing trimmed extents is a tradeoff to for greater coalescing which
> > > makes life better for find_free_extent(). Additionally, it seems the
> > > size of a trim isn't as problematic as the trim io itself.
> 
> A problematic example case:
> 
> |----trimmed----|/////X/////|-----trimmed-----|
> 
> If region X gets freed and returned to the free space cache, we end up
> with the following:
> 
> |----trimmed----|-untrimmed-|-----trimmed-----|
> 
> This isn't great because now we need to teach find_free_extent() to span
> multiple btrfs_free_space entries, something I didn't want to do. So the
> other option is to overtrim trading for a simpler find_free_extent().
> Then the above becomes:
> 
> |-------------------trimmed-------------------|
> 
> It makes the assumption that if we're inserting, it's generally is free
> space being returned rather than we needed to slice out from the middle
> of a block. It does still have degenerative cases, but it's better than
> the above. The merging also allows for stuff to come out of bitmaps more
> proactively too.
> 
> Also from what it seems, the cost of a discard operation is quite costly
> relative to the amount your discarding (1 larger discard is better than
> several smaller discards) as it will clog up the device too.


OOOOOh I fucking get it now.  That's going to need a comment, because it's not
obvious at all.

However I still wonder if this is right.  Your above examples are legitimate,
but say you have

| 512mib adding back that isn't trimmed |------- 512mib trimmed ------|

we'll merge these two, but really we should probably trim that 512mib chunk
we're adding right?  Thanks,

Josef
