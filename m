Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03ACF645A2
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 13:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfGJLMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 07:12:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47270 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbfGJLMX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 07:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 974B6AD0B
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2019 11:12:20 +0000 (UTC)
Subject: Re: [PATCH 4/5] btrfs: extent-tree: Kill the BUG_ON() in
 insert_inline_extent_backref()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190710080243.15988-1-wqu@suse.com>
 <20190710080243.15988-5-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3c5b0478-8409-d6f0-6adb-3d0a9c0f4520@suse.com>
Date:   Wed, 10 Jul 2019 14:12:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710080243.15988-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.07.19 г. 11:02 ч., Qu Wenruo wrote:
> [BUG]
> With crafted image, btrfs can panic at insert_inline_extent_backref():
>   kernel BUG at fs/btrfs/extent-tree.c:1857!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 0 PID: 1117 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>   RIP: 0010:insert_inline_extent_backref+0xcc/0xe0
>   Code: 45 20 49 8b 7e 50 49 89 d8 4c 8b 4d 10 48 8b 55 c8 4c 89 e1 41 57 4c 89 ee 50 ff 75 18 e8 cc bf ff ff 31 c0 48 83 c4 18 eb b2 <0f> 0b e8 9d df bd ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66
>   RSP: 0018:ffffac4dc1287be8 EFLAGS: 00010293
>   RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000001
>   RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: ffffac4dc1287c28 R08: ffffac4dc1287ab8 R09: ffffac4dc1287ac0
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   R13: ffff8febef88a540 R14: ffff8febeaa7bc30 R15: 0000000000000000
>   FS: 0000000000000000(0000) GS:ffff8febf7a00000(0000) knlGS:0000000000000000
>   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f663ace94c0 CR3: 0000000235698006 CR4: 00000000000206f0
>   Call Trace:
>   ? _cond_resched+0x1a/0x50
>   __btrfs_inc_extent_ref.isra.64+0x7e/0x240
>   ? btrfs_merge_delayed_refs+0xa5/0x330
>   __btrfs_run_delayed_refs+0x653/0x1120
>   btrfs_run_delayed_refs+0xdb/0x1b0
>   btrfs_commit_transaction+0x52/0x950
>   ? start_transaction+0x94/0x450
>   transaction_kthread+0x163/0x190
>   kthread+0x105/0x140
>   ? btrfs_cleanup_transaction+0x560/0x560
>   ? kthread_destroy_worker+0x50/0x50
>   ret_from_fork+0x35/0x40
>   Modules linked in:
>   ---[ end trace 2ad8b3de903cf825 ]---
> 
> [CAUSE]
> Due to extent tree corruption (still valid by itself, but bad cross ref),
> we can allocate an extent which is still in extent tree.
> 
> Then we will try to insert/update inlined extent backref line for the
> existing tree block, and triggering the BUG_ON() where we don't expect
> to increase refs on non-subvolume tree block.
> 
> [FIX]
> Replace that BUG_ON() with proper error message and leaf dump for debug
> build.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202829
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent-tree.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 199e4eed8f2d..72868d9ac58e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1856,7 +1856,24 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
>  					   num_bytes, parent, root_objectid,
>  					   owner, offset, 1);
>  	if (ret == 0) {
> -		BUG_ON(owner < BTRFS_FIRST_FREE_OBJECTID);
> +		/*
> +		 * We're adding ref to an existing tree block, only happens
> +		 * when creating snapshots, not possible to other trees.
> +		 */
> +		if (owner < BTRFS_FIRST_FREE_OBJECTID) {
> +			WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG), KERN_ERR
> +			"invalid operation for non-subvolume tree block");

Again, the text of the warn doesn't bring any value, make it plain
WARN_ON(IS_ENABLED())

> +
> +			btrfs_crit(trans->fs_info,
> +"invalid operation, adding refs to a non-subvolume tree block, bytenr=%llu num_bytes=%llu root_objectid=%llu",
> +				   bytenr, num_bytes, root_objectid);
> +			if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
> +				btrfs_crit(trans->fs_info,
> +			"path->slots[0]=%d path->nodes[0]:", path->slots[0]);
> +				btrfs_print_leaf(path->nodes[0]);
> +			}
> +			return -EUCLEAN;
> +		}
>  		update_inline_extent_backref(path, iref, refs_to_add,
>  					     extent_op, NULL);
>  	} else if (ret == -ENOENT) {
> @@ -2073,6 +2090,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>  /*
>   * __btrfs_inc_extent_ref - insert backreference for a given extent
>   *
> + * The work is opposite as __btrfs_free_extent().
> + * For more info about how it works or examples, refer to __btrfs_free_extent().
> + *
>   * @trans:	    Handle of transaction
>   *
>   * @node:	    The delayed ref node used to get the bytenr/length for
> @@ -2153,9 +2173,9 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>  	/* now insert the actual backref */
>  	ret = insert_extent_backref(trans, path, bytenr, parent, root_objectid,
>  				    owner, offset, refs_to_add);
> +out:
>  	if (ret)
>  		btrfs_abort_transaction(trans, ret);
> -out:

I think this silently fixes a bug if insert_inline_extent_backref fails.
If that's the case then it should be in a dedicated patch with an
explicit rationale

>  	btrfs_free_path(path);
>  	return ret;
>  }
> 
