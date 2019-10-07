Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614C1CED9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfJGUhc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:37:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42067 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUhc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:37:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id w14so21188652qto.9
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=87WlQhsn9Mz90d/jSZ1NaWICCa7Ut6q+5xnsKGzgvVA=;
        b=MKG68YR+efEnr6IRVmMQEKWSHxCtKCEaCKJYyCvC7IytvtwiC4KJgaM64mUyqzNmzb
         zPVdZ1IDALMdX9IwsE1+haDWwmvHb7lJPL5+JxkHwB3l56vOMXh3azw66wbRxGeDIzsR
         2EjlAEnOTHMtEvMEGlmONQeXohbHGQfgtXMO6kK5OeK4LuhmEGUSfgyUSn5ZCk5Ztl8h
         BlKgx0rSdg3vjI7VFigGoyRqyEs5Uom4n9Vg1azQACKVTpBEhCCPF4CSuryoY04Z01GY
         vOAVIIIrCwjFkbQJXbKlRur10iqdhqrB9U14oB3/C36Ioz3PgQPkaEyGkpZAOc2c0tHc
         Fj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=87WlQhsn9Mz90d/jSZ1NaWICCa7Ut6q+5xnsKGzgvVA=;
        b=AOFh9ZmkUfG4AuknIS74SkUXyE8JLsgBrOcIXHYS3VtUEZn4D3c2TifJhRgD2m2LvJ
         dJgB0vYtcIO8BwZ5lgKSFxpmG2Q7bWWsa+bq2UiYmT4IUK7COd9JdvvQHV3IlbwXEovt
         lct2WS8JcunUAIbe4orw6uW7jCG+mP3QgEHWPMHtV4lN84/htP2BcQ9+JTH+Vtka9Drd
         yMLBZqj3A62jdCLcsnap6Lc/uL+yRxZo0ZidOiuz8p9f+YPzwDEqYGpjPPuZHZSQB/kK
         0zZaCkxhHm1AL/SGVR5R9wfKWP3ivKTKNOCdYMAqgD2tnaD3n0ZezcHGkeAwKL+TGAlX
         Is1w==
X-Gm-Message-State: APjAAAVVZZr5C7eb7O7RKYCSb9Goi5dBtZGDuBsG19Kv3K80qy6ce7Yx
        avLVt0rrqHsImbM+WeZLZH/Bxw==
X-Google-Smtp-Source: APXvYqw50OHL4kswqO/xID8dnW481NbNExjHclZkwDi9Cc7yqtLnawoCQe4y2J9hRuZsSufEBdb1OA==
X-Received: by 2002:ac8:3f4c:: with SMTP id w12mr32417745qtk.168.1570480650725;
        Mon, 07 Oct 2019 13:37:30 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s23sm10673756qte.72.2019.10.07.13.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:37:30 -0700 (PDT)
Date:   Mon, 7 Oct 2019 16:37:28 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/19] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191007203727.26np5hdnr4nqx3kk@MacBook-Pro-91.local>
References: <cover.1570479299.git.dennis@kernel.org>
 <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 07, 2019 at 04:17:34PM -0400, Dennis Zhou wrote:
> Async discard will use the free space cache as backing knowledge for
> which extents to discard. This patch plumbs knowledge about which
> extents need to be discarded into the free space cache from
> unpin_extent_range().
> 
> An untrimmed extent can merge with everything as this is a new region.
> Absorbing trimmed extents is a tradeoff to for greater coalescing which
> makes life better for find_free_extent(). Additionally, it seems the
> size of a trim isn't as problematic as the trim io itself.
> 
> When reading in the free space cache from disk, if sync is set, mark all
> extents as trimmed. The current code ensures at transaction commit that
> all free space is trimmed when sync is set, so this reflects that.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
>  fs/btrfs/extent-tree.c      | 15 ++++++++++-----
>  fs/btrfs/free-space-cache.c | 38 ++++++++++++++++++++++++++++++-------
>  fs/btrfs/free-space-cache.h | 10 +++++++++-
>  fs/btrfs/inode-map.c        | 13 +++++++------
>  4 files changed, 57 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 77a5904756c5..b9e3bedad878 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2782,7 +2782,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
>  }
>  
>  static int unpin_extent_range(struct btrfs_fs_info *fs_info,
> -			      u64 start, u64 end,
> +			      u64 start, u64 end, u32 fsc_flags,
>  			      const bool return_free_space)
>  {
>  	struct btrfs_block_group_cache *cache = NULL;
> @@ -2816,7 +2816,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  		if (start < cache->last_byte_to_unpin) {
>  			len = min(len, cache->last_byte_to_unpin - start);
>  			if (return_free_space)
> -				btrfs_add_free_space(cache, start, len);
> +				__btrfs_add_free_space(fs_info,
> +						       cache->free_space_ctl,
> +						       start, len, fsc_flags);
>  		}
>  
>  		start += len;
> @@ -2894,6 +2896,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  
>  	while (!trans->aborted) {
>  		struct extent_state *cached_state = NULL;
> +		u32 fsc_flags = 0;
>  
>  		mutex_lock(&fs_info->unused_bg_unpin_mutex);
>  		ret = find_first_extent_bit(unpin, 0, &start, &end,
> @@ -2903,12 +2906,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  			break;
>  		}
>  
> -		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> +		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
>  			ret = btrfs_discard_extent(fs_info, start,
>  						   end + 1 - start, NULL);
> +			fsc_flags |= BTRFS_FSC_TRIMMED;
> +		}
>  
>  		clear_extent_dirty(unpin, start, end, &cached_state);
> -		unpin_extent_range(fs_info, start, end, true);
> +		unpin_extent_range(fs_info, start, end, fsc_flags, true);
>  		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>  		free_extent_state(cached_state);
>  		cond_resched();
> @@ -5512,7 +5517,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
>  int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
>  				   u64 start, u64 end)
>  {
> -	return unpin_extent_range(fs_info, start, end, false);
> +	return unpin_extent_range(fs_info, start, end, 0, false);
>  }
>  
>  /*
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d54dcd0ab230..f119895292b8 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -747,6 +747,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
>  			goto free_cache;
>  		}
>  
> +		/*
> +		 * Sync discard ensures that the free space cache is always
> +		 * trimmed.  So when reading this in, the state should reflect
> +		 * that.
> +		 */
> +		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> +			e->flags |= BTRFS_FSC_TRIMMED;
> +
>  		if (!e->bytes) {
>  			kmem_cache_free(btrfs_free_space_cachep, e);
>  			goto free_cache;
> @@ -2165,6 +2173,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
>  	bool merged = false;
>  	u64 offset = info->offset;
>  	u64 bytes = info->bytes;
> +	bool is_trimmed = btrfs_free_space_trimmed(info);
>  
>  	/*
>  	 * first we want to see if there is free space adjacent to the range we
> @@ -2178,7 +2187,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
>  	else
>  		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
>  
> -	if (right_info && !right_info->bitmap) {
> +	if (right_info && !right_info->bitmap &&
> +	    (!is_trimmed || btrfs_free_space_trimmed(right_info))) {
>  		if (update_stat)
>  			unlink_free_space(ctl, right_info);
>  		else
> @@ -2189,7 +2199,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
>  	}
>  
>  	if (left_info && !left_info->bitmap &&
> -	    left_info->offset + left_info->bytes == offset) {
> +	    left_info->offset + left_info->bytes == offset &&
> +	    (!is_trimmed || btrfs_free_space_trimmed(left_info))) {

So we allow merging if we haven't trimmed this entry, or if the adjacent entry
is already trimmed?  This means we'll merge if we trimmed the new entry
regardless of the adjacent entries status, or if the new entry is drity.  Why is
that?  Thanks,

Josef
