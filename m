Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B3219C9D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jul 2020 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgGIJyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jul 2020 05:54:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgGIJyf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jul 2020 05:54:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B241AC50;
        Thu,  9 Jul 2020 09:54:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E8D8DDAB7F; Thu,  9 Jul 2020 11:54:13 +0200 (CEST)
Date:   Thu, 9 Jul 2020 11:54:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: relocation: review the call sites which
 can be interruped by signal
Message-ID: <20200709095413.GF28832@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200709083333.137927-1-wqu@suse.com>
 <20200709083333.137927-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709083333.137927-2-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 09, 2020 at 04:33:33PM +0800, Qu Wenruo wrote:
> Since most metadata reservation calls can return -EINTR when get
> interruped by fatal signal, we need to review the all the metadata
> reservation call sites.
> 
> In relocation code, the metadata reservation happens in the following
> sites:
> - btrfs_block_rsv_refill() in merge_reloc_root()
>   merge_reloc_root() is a pretty critial section, we don't want get
>   interrupted by signal, so change the flush status to
>   BTRFS_RESERVE_FLUSH_LIMIT, so it won't get interrupted by signal.
>   Since such change can be ENPSPC-prone, also shrink the amount of
>   metadata to reserve a little to avoid deadly ENOSPC there.
> 
> - btrfs_block_rsv_refill() in reserve_metadata_space()
>   It calls with BTRFS_RESERVE_FLUSH_LIMIT, which won't get interrupred
>   by signal.

This semantics of BTRFS_RESERVE_FLUSH_LIMIT regarding signals should be
documented, right now there's a comment but says something about avoidig
deadlocks.

> - btrfs_block_rsv_refill() in prepare_to_relocate()
> - btrfs_block_rsv_add() in prepare_to_relocate()
> - btrfs_block_rsv_refill() in relocate_block_group()
> - btrfs_delalloc_reserve_metadata() in relocate_file_extent_cluster()
> - btrfs_start_transaction() in relocate_block_group()
> - btrfs_start_transaction() in create_reloc_inode()
>   Can be interruped by fatal signal and we can handle it easily.
>   For these call sites, just catch the -EINTR value in btrfs_balance()
>   and count them as canceled.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/relocation.c | 13 +++++++++++--
>  fs/btrfs/volumes.c    |  2 +-
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 2b869fb2e62c..23914edd4710 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1686,12 +1686,21 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
>  		btrfs_unlock_up_safe(path, 0);
>  	}
>  
> -	min_reserved = fs_info->nodesize * (BTRFS_MAX_LEVEL - 1) * 2;
> +	/*
> +	 * In merge_reloc_root(), we modify the upper level pointer to swap
> +	 * the tree blocks between reloc tree and subvolume tree.
> +	 * Thus for tree block COW, we COW at most from level 1 to root level
> +	 * for each tree.
> +	 *
> +	 * Thus the needed metadata space is at most root_level * nodesize,
> +	 * and * 2 since we have two trees to COW.
> +	 */
> +	min_reserved = fs_info->nodesize * btrfs_root_level(root_item) * 2;
>  	memset(&next_key, 0, sizeof(next_key));
>  
>  	while (1) {
>  		ret = btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
> -					     BTRFS_RESERVE_FLUSH_ALL);
> +					     BTRFS_RESERVE_FLUSH_LIMIT);
>  		if (ret) {
>  			err = ret;
>  			goto out;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index aabc6c922e04..d60df30bdc47 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4135,7 +4135,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
>  	mutex_lock(&fs_info->balance_mutex);
>  	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
>  		btrfs_info(fs_info, "balance: paused");
> -	else if (ret == -ECANCELED && atomic_read(&fs_info->balance_cancel_req))
> +	else if (ret == -ECANCELED  || ret == -EINTR)

Why do you remove atomic_read(&fs_info->balance_cancel_req) ?

>  		btrfs_info(fs_info, "balance: canceled");

I'm not sure if it would be useful to print the reason, like

- 'canceled: user request'
- 'canceled: interrupted'

>  	else
>  		btrfs_info(fs_info, "balance: ended with status: %d", ret);
> -- 
> 2.27.0
