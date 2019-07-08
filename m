Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892EC61D30
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbfGHKoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 06:44:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:44474 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730166AbfGHKoh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 06:44:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C4205AE1B;
        Mon,  8 Jul 2019 10:44:35 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] btrfs-progs: Exhaust delayed refs and dirty block
 groups to prevent delayed refs lost
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Klemens_Sch=c3=b6lhorn?= <klemens@schoelhorn.eu>
References: <20190708073352.6095-1-wqu@suse.com>
 <20190708073352.6095-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6846c7ad-a5da-abdb-92f7-ebf619acf2e8@suse.com>
Date:   Mon, 8 Jul 2019 13:44:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190708073352.6095-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 8.07.19 г. 10:33 ч., Qu Wenruo wrote:
> [BUG]
> Btrfs-progs sometimes fails to find certain extent backref when
> committing transaction.
> The most reliable way to reproduce it is fsck-test/013 on 64K page sized
> system:
>   [...]
>   adding new data backref on 315859712 root 287 owner 292 offset 0 found 1
>   btrfs unable to find ref byte nr 31850496 parent 0 root 2  owner 0 offset 0
>   Failed to find [30867456, 168, 65536]
> 
> Also there are some github bug reports related to this problem.
> 
> [CAUSE]
> Commit 909357e86799 ("btrfs-progs: Wire up delayed refs") introduced
> delayed refs in btrfs-progs.
> 
> However in that commit, delayed refs are not run at correct timing.
> That commit calls btrfs_run_delayed_refs() before
> btrfs_write_dirty_block_groups(), which needs to update
> BLOCK_GROUP_ITEMs in extent tree, thus could cause new delayed refs.
> 
> This means each time we commit a transaction, we may screw up the extent
> tree by dropping some pending delayed refs, like:
> 
> Transaction 711:
> btrfs_commit_transaction()
> |- btrfs_run_delayed_refs()
> |  Now all delayed refs are written to extent tree
> |
> |- btrfs_write_dirty_block_groups()
> |  Needs to update extent tree root
> |  ADD_DELAYED_REF to 315859712.
> |  Delayed refs are attached to current trans handle.
> |
> |- __commit_transaction()
> |- write_ctree_super()
> |- btrfs_finish_extent_commit()
> |- kfree(trans)
>    Now delayed ref for 315859712 are lost
> 
> Transaction 712:
> Tree block 315859712 get dropped
> btrfs_commit_transaction()
> |- btrfs_run_delayed_refs()
>    |- run_one_delayed_ref()
>       |- __free_extent()
>          As previous ADD_DELAYED_REF to 315859712 is lost, extent tree
>          doesn't has any backref for 315859712, causing the bug
> 
> In fact, commit c31edf610cbe ("btrfs-progs: Fix false ENOSPC alert by
> tracking used space correctly") detects the tree block leakage, but in
> the reproducer we have too many noise, thus nobody notices the leakage
> warning.
> 
> [FIX]
> We can't just move btrfs_run_delayed_refs() after
> btrfs_write_dirty_block_groups(), as during btrfs_run_delayed_refs(), we
> can re-dirty block groups.
> Thus we need to exhaust both delayed refs and dirty blocks.
> 
> This patch will call btrfs_write_dirty_block_groups() and
> btrfs_run_delayed_refs() in a loop until both delayed refs and dirty
> blocks are exhausted. Much like what we do in commit_cowonly_roots() in
> kernel.
> 
> Also, to prevent such problem from happening again (and not to debug
> such problem again), add extra check on delayed refs before freeing the
> trans handle.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> 
> Reported-by: Klemens Schölhorn <klemens@schoelhorn.eu>
> Issue: 187
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  transaction.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/transaction.c b/transaction.c
> index 551fb24e674d..3b0a428db76e 100644
> --- a/transaction.c
> +++ b/transaction.c
> @@ -193,17 +193,32 @@ commit_tree:
>  	ret = commit_tree_roots(trans, fs_info);
>  	if (ret < 0)
>  		goto error;
> +
>  	/*
> -	 * Ensure that all committed roots are properly accounted in the
> -	 * extent tree
> +	 * btrfs_write_dirty_block_groups() can cause CoW thus new delayed
> +	 * tree refs, while run such delayed tree refs can dirty block groups
> +	 * again, we need to exhause both dirty blocks and delayed refs
>  	 */
> -	ret = btrfs_run_delayed_refs(trans, -1);
> -	if (ret < 0)
> -		goto error;
> -	btrfs_write_dirty_block_groups(trans);
> +	while (!RB_EMPTY_ROOT(&trans->delayed_refs.href_root) ||
> +		test_range_bit(&fs_info->block_group_cache, 0, (u64)-1,
> +			       BLOCK_GROUP_DIRTY, 0))
> +	{
> +		ret = btrfs_write_dirty_block_groups(trans);
> +		if (ret < 0)
> +			goto error;
> +		ret = btrfs_run_delayed_refs(trans, -1);
> +		if (ret < 0)
> +			goto error;
> +	}
>  	__commit_transaction(trans, root);
>  	if (ret < 0)
>  		goto error;
> +
> +	/* There should be no pending delayed refs now */
> +	if (!RB_EMPTY_ROOT(&trans->delayed_refs.href_root)) {
> +		error("Uncommitted delayed refs detected");
> +		goto error;
> +	}
>  	ret = write_ctree_super(trans);
>  	btrfs_finish_extent_commit(trans);
>  	kfree(trans);
> 
