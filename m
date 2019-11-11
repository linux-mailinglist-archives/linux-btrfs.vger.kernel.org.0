Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6864DF79AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 18:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKKRUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 12:20:21 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45634 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKRUU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 12:20:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id q70so11809295qke.12
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2019 09:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/A1PDgETGlkzQxJcy2IhUatXEJoiQGMjawADbV+FE/Y=;
        b=HGplHicVTwS1s7Jru9JaNsgAAHqy2qdzIuIGASbFnX25hU4ZmnY9x3H2yPoqaSCZuv
         pEnSksNmuCfgOlCpl8bKPKmgk9yR/16E04o5w+dGluhwoSY/mc291eScIAB2nDC+Lbti
         2hxffkK7OTtPcg7dAyO5EVK3UXdJs6Yo4OwAZ/n5zbkKzU8DVM3Cxpj+N2Sk2kQUtWDg
         QU7TOGfloMbtdDkxvLOmPJXw+GombSuO9QAExZHGY0YeZ3lf0OsebfZjxJMqIYcVayyL
         oT02am1pMeBLE34892a1AiYTWTBMmGscFzdVX05XbLH2sAxP5i69gy7Y3HV7u5yDQ/1Y
         as7g==
X-Gm-Message-State: APjAAAWNljSBg1LCf4IfySnuQaVQ/vSpbGTq0Dft4LpQSUE7eG12BZD6
        xjpIkPsyR9cHcxjmzPVPAxY=
X-Google-Smtp-Source: APXvYqyqhohQ0WIfmaYDlS2xJisolWZ6Zgx0mae5LadBrntxNYinwEDaSYin2sqmY5Dcww0CdqDYSw==
X-Received: by 2002:a05:620a:5ed:: with SMTP id z13mr11390046qkg.62.1573492819700;
        Mon, 11 Nov 2019 09:20:19 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::8ff1])
        by smtp.gmail.com with ESMTPSA id 130sm7731163qkd.33.2019.11.11.09.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 09:20:18 -0800 (PST)
Date:   Mon, 11 Nov 2019 12:20:16 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dennis Zhou <dennis@kernel.org>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Omar Sandoval <osandov@osandov.com>,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/22] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191111172016.GA79848@dennisz-mbp>
References: <cover.1571865774.git.dennis@kernel.org>
 <63a78fbbd4d742ab13484d0cdad2264173ca7411.1571865774.git.dennis@kernel.org>
 <20191108190502.yutl2muwbgdjdqbt@macbook-pro-91.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108190502.yutl2muwbgdjdqbt@macbook-pro-91.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 08, 2019 at 02:05:03PM -0500, Josef Bacik wrote:
> On Wed, Oct 23, 2019 at 06:52:57PM -0400, Dennis Zhou wrote:
> > Async discard will use the free space cache as backing knowledge for
> > which extents to discard. This patch plumbs knowledge about which
> > extents need to be discarded into the free space cache from
> > unpin_extent_range().
> > 
> > An untrimmed extent can merge with everything as this is a new region.
> > Absorbing trimmed extents is a tradeoff to for greater coalescing which
> > makes life better for find_free_extent(). Additionally, it seems the
> > size of a trim isn't as problematic as the trim io itself.
> > 
> > When reading in the free space cache from disk, if sync is set, mark all
> > extents as trimmed. The current code ensures at transaction commit that
> > all free space is trimmed when sync is set, so this reflects that.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/extent-tree.c      | 15 +++++++---
> >  fs/btrfs/free-space-cache.c | 60 ++++++++++++++++++++++++++++++++-----
> >  fs/btrfs/free-space-cache.h | 17 ++++++++++-
> >  fs/btrfs/inode-map.c        | 13 ++++----
> >  4 files changed, 87 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 77a5904756c5..6a40bba3cb19 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2783,6 +2783,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
> >  
> >  static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> >  			      u64 start, u64 end,
> > +			      enum btrfs_trim_state trim_state,
> >  			      const bool return_free_space)
> >  {
> >  	struct btrfs_block_group_cache *cache = NULL;
> > @@ -2816,7 +2817,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> >  		if (start < cache->last_byte_to_unpin) {
> >  			len = min(len, cache->last_byte_to_unpin - start);
> >  			if (return_free_space)
> > -				btrfs_add_free_space(cache, start, len);
> > +				__btrfs_add_free_space(fs_info,
> > +						       cache->free_space_ctl,
> > +						       start, len, trim_state);
> >  		}
> >  
> >  		start += len;
> > @@ -2894,6 +2897,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> >  
> >  	while (!trans->aborted) {
> >  		struct extent_state *cached_state = NULL;
> > +		enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
> >  
> >  		mutex_lock(&fs_info->unused_bg_unpin_mutex);
> >  		ret = find_first_extent_bit(unpin, 0, &start, &end,
> > @@ -2903,12 +2907,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
> >  			break;
> >  		}
> >  
> > -		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> > +		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
> >  			ret = btrfs_discard_extent(fs_info, start,
> >  						   end + 1 - start, NULL);
> > +			trim_state = BTRFS_TRIM_STATE_TRIMMED;
> > +		}
> >  
> >  		clear_extent_dirty(unpin, start, end, &cached_state);
> > -		unpin_extent_range(fs_info, start, end, true);
> > +		unpin_extent_range(fs_info, start, end, trim_state, true);
> >  		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
> >  		free_extent_state(cached_state);
> >  		cond_resched();
> > @@ -5512,7 +5518,8 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
> >  int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
> >  				   u64 start, u64 end)
> >  {
> > -	return unpin_extent_range(fs_info, start, end, false);
> > +	return unpin_extent_range(fs_info, start, end,
> > +				  BTRFS_TRIM_STATE_UNTRIMMED, false);
> >  }
> >  
> >  /*
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index d54dcd0ab230..d7f0cb961496 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -747,6 +747,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
> >  			goto free_cache;
> >  		}
> >  
> > +		/*
> > +		 * Sync discard ensures that the free space cache is always
> > +		 * trimmed.  So when reading this in, the state should reflect
> > +		 * that.
> > +		 */
> > +		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> > +			e->trim_state = BTRFS_TRIM_STATE_TRIMMED;
> > +
> 
> BTRFS_TRIM_STATE_TRIMMED == 0, so if we don't have DISCARD_SYNC set, we'll still
> end up with TRIMMED.  Which means we'll end up with weirdness later because
> unpinned extents will come back as UNTRIMMED in the !DISCARD_SYNC case.  I'm
> thinking about spinning rust here where we'll never have discard, so we should
> either always treat the free space as trimmed, or always treat it as untrimmed,
> so we don't end up with different allocator behavior for the undiscardable
> devices.  Thanks,
> 
Ah, that is a good catch. I think having everything be treated as
untrimmed should be fine. I moved BTRFS_TRIM_STATE_UNTRIMMED to be 0 in
the enum.

Thanks,
Dennis
