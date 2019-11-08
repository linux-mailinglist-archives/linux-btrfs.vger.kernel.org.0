Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54A5DF5702
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 21:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732780AbfKHTPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 14:15:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32979 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390172AbfKHTFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Nov 2019 14:05:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so6270474qkl.0
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Nov 2019 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zON0XpBkxxitGae8YcTPCkVn6INhID2JSAvz1Uc0qL0=;
        b=LrrN/ADLjeNkqsJ/yaS/pq4DpJFdVYPgF9Woo+LWsueLkuSlileybeZZQPq+xdd1sG
         QBIJsCr+IW7iPvKMQazYCl8Z/8QDPAnRztou2ocjf3QGy22bzNLpIdB080Y8YcGMJ/9z
         1Nkym5HbQ9yIOlJPT6mL1TQuGd/OPslkdKWzOS2p1Dt1dD/0cA3mCNLuQ0Yr0oNIoGaw
         3fccdqFWTo7ZCPw4ODh1S5WBlTsTPzxoHdqKf+UKLbgc8uj6bLeR61f3hb92Qa+A+8VO
         AYxXFISs2F3hX+33pcyYAl+J1Fzh1Y6JkVuoPaeeLh8WoJfTLOrsZi02efA/IePWJvrm
         biKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zON0XpBkxxitGae8YcTPCkVn6INhID2JSAvz1Uc0qL0=;
        b=teD8FzWdB+SOAzcP7lDwtjykN/q8bPV/0+VFKu3lla4AbMj5N18tuDs3lZzOgzxnEf
         FcpXX84X7HdlqdhRJ8n10HI8h7dQdyupBfw9o3wQibQ1gvOiYsgWOX1tFjeW7/X0+Y0L
         m9bfou3vBklwtnvv0LYpuZMB5VGgFZyyULfnhUm+kE/o+OLvYHBiwtXZ8oj4Oj9PfhWx
         wMUCIH9OD5+YZGZ2ceFdpx6vdg+Bis36OsQ0JDS72BlgnRQ4phI45rzH5Y+j6lScdini
         DTl74P5+YoK+u7rNaqD2ofarxe6oNSCTuYaWigXlUzddZxOmlzTAZ5ozGyzA7AeU2SOU
         01Cg==
X-Gm-Message-State: APjAAAWzi9xxnwb3J14Bmiz1lf5jzJgIqTnzbBQ8ZZ85ZTaGzWTEt1Nz
        BwKo3CZo6XVqOxO8HyMfbD0viA==
X-Google-Smtp-Source: APXvYqxjRRb21I7ZAZ+PpgYz2bqNazzgTmvjBW/jCYSErzqXA39tLstzpK9RTHvJwTrXJ+hg6xUoVA==
X-Received: by 2002:a37:4bd7:: with SMTP id y206mr10730778qka.18.1573239905443;
        Fri, 08 Nov 2019 11:05:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1852])
        by smtp.gmail.com with ESMTPSA id w30sm4094385qtc.47.2019.11.08.11.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 11:05:04 -0800 (PST)
Date:   Fri, 8 Nov 2019 14:05:03 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/22] btrfs: keep track of which extents have been
 discarded
Message-ID: <20191108190502.yutl2muwbgdjdqbt@macbook-pro-91.dhcp.thefacebook.com>
References: <cover.1571865774.git.dennis@kernel.org>
 <63a78fbbd4d742ab13484d0cdad2264173ca7411.1571865774.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a78fbbd4d742ab13484d0cdad2264173ca7411.1571865774.git.dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:52:57PM -0400, Dennis Zhou wrote:
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
>  fs/btrfs/extent-tree.c      | 15 +++++++---
>  fs/btrfs/free-space-cache.c | 60 ++++++++++++++++++++++++++++++++-----
>  fs/btrfs/free-space-cache.h | 17 ++++++++++-
>  fs/btrfs/inode-map.c        | 13 ++++----
>  4 files changed, 87 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 77a5904756c5..6a40bba3cb19 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2783,6 +2783,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
>  
>  static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  			      u64 start, u64 end,
> +			      enum btrfs_trim_state trim_state,
>  			      const bool return_free_space)
>  {
>  	struct btrfs_block_group_cache *cache = NULL;
> @@ -2816,7 +2817,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
>  		if (start < cache->last_byte_to_unpin) {
>  			len = min(len, cache->last_byte_to_unpin - start);
>  			if (return_free_space)
> -				btrfs_add_free_space(cache, start, len);
> +				__btrfs_add_free_space(fs_info,
> +						       cache->free_space_ctl,
> +						       start, len, trim_state);
>  		}
>  
>  		start += len;
> @@ -2894,6 +2897,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  
>  	while (!trans->aborted) {
>  		struct extent_state *cached_state = NULL;
> +		enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
>  
>  		mutex_lock(&fs_info->unused_bg_unpin_mutex);
>  		ret = find_first_extent_bit(unpin, 0, &start, &end,
> @@ -2903,12 +2907,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  			break;
>  		}
>  
> -		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
> +		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
>  			ret = btrfs_discard_extent(fs_info, start,
>  						   end + 1 - start, NULL);
> +			trim_state = BTRFS_TRIM_STATE_TRIMMED;
> +		}
>  
>  		clear_extent_dirty(unpin, start, end, &cached_state);
> -		unpin_extent_range(fs_info, start, end, true);
> +		unpin_extent_range(fs_info, start, end, trim_state, true);
>  		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>  		free_extent_state(cached_state);
>  		cond_resched();
> @@ -5512,7 +5518,8 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
>  int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
>  				   u64 start, u64 end)
>  {
> -	return unpin_extent_range(fs_info, start, end, false);
> +	return unpin_extent_range(fs_info, start, end,
> +				  BTRFS_TRIM_STATE_UNTRIMMED, false);
>  }
>  
>  /*
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d54dcd0ab230..d7f0cb961496 100644
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
> +			e->trim_state = BTRFS_TRIM_STATE_TRIMMED;
> +

BTRFS_TRIM_STATE_TRIMMED == 0, so if we don't have DISCARD_SYNC set, we'll still
end up with TRIMMED.  Which means we'll end up with weirdness later because
unpinned extents will come back as UNTRIMMED in the !DISCARD_SYNC case.  I'm
thinking about spinning rust here where we'll never have discard, so we should
either always treat the free space as trimmed, or always treat it as untrimmed,
so we don't end up with different allocator behavior for the undiscardable
devices.  Thanks,

Josef
