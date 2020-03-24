Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B551913C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 16:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgCXPAA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 11:00:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgCXO77 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 10:59:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A6A9AC22;
        Tue, 24 Mar 2020 14:59:58 +0000 (UTC)
Subject: Re: [PATCH] btrfs: drop logs when we've aborted a transaction
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20200324144752.9541-1-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <981050fa-a6b4-29af-4bd6-e3c3b929c359@suse.com>
Date:   Tue, 24 Mar 2020 16:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200324144752.9541-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.03.20 г. 16:47 ч., Josef Bacik wrote:
> Dave reported a problem where we were panicing with generic/475 with
> misc-5.7.  This is because we were doing IO after we had stopped all of

This doesn't seem correct. Before, the log tree would be freed in
btrfs_free_fs_roots which is called before btrfs_stop_all_workers and
only with transaction_kthread and cleaner_kthread stopped. I'd expect
that now btrfs_cleanup_transaction will be called from
btrfs_error_commit_super. Perhaps it's not "after we had stopped all of
the worker threads" but simply "We have stopped transaction/cleaner
kthreads" But then again I don't see how those 2 make any difference.

Could it be that this is not a full fix for the issue, and it can still
crash in case it's called from btrfs_error_commit_super ?

> the worker threads, because we do the log tree cleanup on roots at drop
> time.  Cleaning up the log tree may need to do reads if we happened to
> have evicted the blocks from memory.
> 
> Because of this simply add a helper to btrfs_cleanup_transaction() that
> will go through and drop all of the log roots.  This gets run before we
> do the close_ctree() work, and thus we are allowed to do any reads that
> we would need.  I ran this through many iterations of generic/475 with
> constrained memory and I did not see the issue.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> ---
>  fs/btrfs/disk-io.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a6cb5cbbdb9f..d10c7be10f3b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2036,9 +2036,6 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
>  		for (i = 0; i < ret; i++)
>  			btrfs_drop_and_free_fs_root(fs_info, gang[i]);
>  	}
> -
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
> -		btrfs_free_log_root_tree(NULL, fs_info);
>  }
>  
>  static void btrfs_init_scrub(struct btrfs_fs_info *fs_info)
> @@ -3888,7 +3885,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
>  	spin_unlock(&fs_info->fs_roots_radix_lock);
>  
>  	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> -		btrfs_free_log(NULL, root);
> +		ASSERT(root->log_root == NULL);
>  		if (root->reloc_root) {
>  			btrfs_put_root(root->reloc_root);
>  			root->reloc_root = NULL;
> @@ -4211,6 +4208,36 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
>  	up_write(&fs_info->cleanup_work_sem);
>  }
>  
> +static void btrfs_drop_all_logs(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *gang[8];
> +	u64 root_objectid = 0;
> +	int ret;
> +
> +	spin_lock(&fs_info->fs_roots_radix_lock);
> +	while ((ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +					     (void **)gang, root_objectid,
> +					     ARRAY_SIZE(gang))) != 0) {
> +		int i;
> +
> +		for (i = 0; i < ret; i++)
> +			gang[i] = btrfs_grab_root(gang[i]);
> +		spin_unlock(&fs_info->fs_roots_radix_lock);
> +
> +		for (i = 0; i < ret; i++) {
> +			if (!gang[i])
> +				continue;
> +			root_objectid = gang[i]->root_key.objectid;
> +			btrfs_free_log(NULL, gang[i]);
> +			btrfs_put_root(gang[i]);
> +		}
> +		root_objectid++;
> +		spin_lock(&fs_info->fs_roots_radix_lock);
> +	}
> +	spin_unlock(&fs_info->fs_roots_radix_lock);
> +	btrfs_free_log_root_tree(NULL, fs_info);
> +}
> +
>  static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
>  {
>  	struct btrfs_ordered_extent *ordered;
> @@ -4603,6 +4630,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
>  	btrfs_destroy_delayed_inodes(fs_info);
>  	btrfs_assert_delayed_root_empty(fs_info);
>  	btrfs_destroy_all_delalloc_inodes(fs_info);
> +	btrfs_drop_all_logs(fs_info);
>  	mutex_unlock(&fs_info->transaction_kthread_mutex);
>  
>  	return 0;
> 
