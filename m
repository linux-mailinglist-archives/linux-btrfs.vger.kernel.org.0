Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0A14DC57
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 14:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgA3Nxw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 08:53:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3Nxv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 08:53:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16734AC69;
        Thu, 30 Jan 2020 13:53:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 17261DA84C; Thu, 30 Jan 2020 14:53:31 +0100 (CET)
Date:   Thu, 30 Jan 2020 14:53:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/11] btrfs: Mark pinned log extents as excluded
Message-ID: <20200130135330.GR3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-10-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120140918.15647-10-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 04:09:16PM +0200, Nikolay Borisov wrote:
> In preparation to making pinned extents per-transaction ensure that
> log such extents are always excluded from caching. To achieve this in
> addition to marking them via btrfs_pin_extent_for_log_replay they also
> need to be marked with btrfs_add_excluded_extent to prevent log tree
> extent buffer being loaded by the free space caching thread. That's
> required since log treeblocks are not recorded in the extent tree, hence
> they always look free.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 8 ++++++++
>  fs/btrfs/tree-log.c    | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 7dcf9217a622..d680f2ac336b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2634,6 +2634,8 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
>  	struct btrfs_block_group *cache;
>  	int ret;
>  
> +	btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);

Again lack of error handling, I thought that untangling and cleaning up
the extent pinning was motivated to actually handle the errors.

> +
>  	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
>  	if (!cache)
>  		return -EINVAL;
> @@ -2920,6 +2922,12 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>  			break;
>  		}
> +		if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> +			clear_extent_bits(&fs_info->freed_extents[0], start,
> +					  end, EXTENT_UPTODATE);
> +			clear_extent_bits(&fs_info->freed_extents[1], start,
> +					  end, EXTENT_UPTODATE);
> +		}
>  
>  		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>  			ret = btrfs_discard_extent(fs_info, start,
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index b535d409a728..f89de24838d5 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2994,7 +2994,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
>  	mutex_unlock(&root->log_mutex);
>  }
>  
> -/* 
> +/*
>   * Invoked in log mutex context, or be sure there is no other task which
>   * can access the list.
>   */
> -- 
> 2.17.1
