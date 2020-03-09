Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B65F17EA69
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 21:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgCIUsn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 16:48:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCIUsn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Mar 2020 16:48:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91B8DB2E9;
        Mon,  9 Mar 2020 20:48:40 +0000 (UTC)
Subject: Re: [PATCH 1/5] btrfs: Improve global reserve stealing logic
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200309202322.12327-1-josef@toxicpanda.com>
 <20200309202322.12327-2-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d2955ecf-4ed6-5931-65d3-eddde228b816@suse.com>
Date:   Mon, 9 Mar 2020 22:48:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309202322.12327-2-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.03.20 г. 22:23 ч., Josef Bacik wrote:
> For unlink transactions and block group removal
> btrfs_start_transaction_fallback_global_rsv will first try to start
> an ordinary transaction and if it fails it will fall back to reserving
> the required amount by stealing from the global reserve. This is sound
> in theory but current code doesn't perform any locking or throttling so
> if there are multiple concurrent unlink() callers they can deplete
> the global reservation which will result in ENOSPC.

Your introduction of the problem and proposed solution are better worded
in the introduction letter so I'd rather see some of that text copied
here, I guess David can also help.

> 
> Fix this behavior by introducing BTRFS_RESERVE_FLUSH_ALL_STEAL. It's
> used to mark unlink reservation. The flushing machinery is modified to
> steal from global reservation when it sees such reservation being on the
> brink of failure (in maybe_fail_all_tickets).>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c |  2 +-
>  fs/btrfs/ctree.h       |  1 +
>  fs/btrfs/inode.c       |  2 +-
>  fs/btrfs/space-info.c  | 38 +++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/space-info.h  |  1 +
>  fs/btrfs/transaction.c | 42 +++++-------------------------------------
>  fs/btrfs/transaction.h |  3 +--
>  7 files changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 60e9bb136f34..faa04093b6b5 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1171,7 +1171,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>  	free_extent_map(em);
>  
>  	return btrfs_start_transaction_fallback_global_rsv(fs_info->extent_root,
> -							   num_items, 1);
> +							   num_items);
>  }
>  
>  /*
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 2ccb2a090782..782c63f213e9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2528,6 +2528,7 @@ enum btrfs_reserve_flush_enum {
>  	BTRFS_RESERVE_FLUSH_DATA,
>  	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
>  	BTRFS_RESERVE_FLUSH_ALL,
> +	BTRFS_RESERVE_FLUSH_ALL_STEAL,
>  };
>  
>  enum btrfs_flush_state {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b8dabffac767..4e3b115ef1d7 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3617,7 +3617,7 @@ static struct btrfs_trans_handle *__unlink_start_trans(struct inode *dir)
>  	 * 1 for the inode ref
>  	 * 1 for the inode
>  	 */
> -	return btrfs_start_transaction_fallback_global_rsv(root, 5, 5);
> +	return btrfs_start_transaction_fallback_global_rsv(root, 5);
>  }
>  
>  static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 26e1c492b9b5..9c9a4933f72b 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -810,6 +810,35 @@ static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
>  		!test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state));
>  }
>  
> +static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
> +				  struct btrfs_space_info *space_info,
> +				  struct reserve_ticket *ticket)
> +{
> +	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
> +	u64 min_bytes;
> +
> +	if (global_rsv->space_info != space_info)
> +		return false;
> +
> +	spin_lock(&global_rsv->lock);
> +	min_bytes = div_factor(global_rsv->size, 1);

This is a subtle change that is not documented but it should: The old
code ensured we'd steel if at least 50% of the block reservation were
left after stealing, whereas now the code only leaves 10%.

This essentially allows to use up more of the global reservation. I
remember we discussed the fact that 10% on a 512m global reserve is
around 50mb which is "enough". I think this ought to be mentioned.
> +	if (global_rsv->reserved < min_bytes + ticket->bytes) {
> +		spin_unlock(&global_rsv->lock);
> +		return false;
> +	}
> +	global_rsv->reserved -= ticket->bytes;
> +	ticket->bytes = 0;
> +	trace_printk("Satisfied ticket from global rsv\n");
> +	list_del_init(&ticket->list);
> +	wake_up(&ticket->wait);
> +	space_info->tickets_id++;
> +	if (global_rsv->reserved < global_rsv->size)
> +		global_rsv->full = 0;
> +	spin_unlock(&global_rsv->lock);
> +
> +	return true;
> +}
> +

<snip>
