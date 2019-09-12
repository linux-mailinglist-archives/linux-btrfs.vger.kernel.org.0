Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06CB0D98
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 13:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfILLK5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 07:10:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54836 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730268AbfILLK5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 07:10:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 436A2B02C;
        Thu, 12 Sep 2019 11:10:53 +0000 (UTC)
Subject: Re: [PATCH] Btrfs: fix assertion failure during fsync and use of
 stale transaction
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190910142649.19808-1-fdmanana@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b171e10f-6f1f-4711-4fa6-67e2ffbe8378@suse.com>
Date:   Thu, 12 Sep 2019 14:10:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910142649.19808-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.19 г. 17:26 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Sometimes when fsync'ing a file we need to log that other inodes exist and
> when we need to do that we acquire a reference on the inodes and then drop
> that reference using iput() after logging them.
> 
> That generally is not a problem except if we end up doing the final iput()
> (dropping the last reference) on the inode and that inode has a link count
> of 0, which can happen in a very short time window if the logging path
> gets a reference on the inode while it's being unlinked.
> 
> In that case we end up getting the eviction callback, btrfs_evict_inode(),
> invoked through the iput() call chain which needs to drop all of the
> inode's items from its subvolume btree, and in order to do that, it needs
> to join a transaction at the helper function evict_refill_and_join().
> However because the task previously started a transaction at the fsync
> handler, btrfs_sync_file(), it has current->journal_info already pointing
> to a transaction handle and therefore evict_refill_and_join() will get
> that transaction handle from btrfs_join_transaction(). From this point on,
> two different problems can happen:
> 
> 1) evict_refill_and_join() will often change the transaction handle's
>    block reserve (->block_rsv) and set its ->bytes_reserved field to a
>    value greater than 0. If evict_refill_and_join() never commits the
>    transaction, the eviction handler ends up decreasing the reference
>    count (->use_count) of the transaction handle through the call to
>    btrfs_end_transaction(), and after that point we have a transaction
>    handle with a NULL ->block_rsv (which is the value prior to the
>    transaction join from evict_refill_and_join()) and a ->bytes_reserved
>    value greater than 0. If after the eviction/iput completes the inode
>    logging path hits an error or it decides that it must fallback to a
>    transaction commit, the btrfs fsync handle, btrfs_sync_file(), gets a
>    non-zero value from btrfs_log_dentry_safe(), and because of that
>    non-zero value it tries to commit the transaction using a handle with
>    a NULL ->block_rsv and a non-zero ->bytes_reserved value. This makes
>    the transaction commit hit an assertion failure at
>    btrfs_trans_release_metadata() because ->bytes_reserved is not zero but
>    the ->block_rsv is NULL. The produced stack trace for that is like the
>    following:
> 
>    [192922.917158] assertion failed: !trans->bytes_reserved, file: fs/btrfs/transaction.c, line: 816
>    [192922.917553] ------------[ cut here ]------------
>    [192922.917922] kernel BUG at fs/btrfs/ctree.h:3532!
>    [192922.918310] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>    [192922.918666] CPU: 2 PID: 883 Comm: fsstress Tainted: G        W         5.1.4-btrfs-next-47 #1
>    [192922.919035] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.2-0-gf9626ccb91-prebuilt.qemu-project.org 04/01/2014
>    [192922.919801] RIP: 0010:assfail.constprop.25+0x18/0x1a [btrfs]
>    (...)
>    [192922.920925] RSP: 0018:ffffaebdc8a27da8 EFLAGS: 00010286
>    [192922.921315] RAX: 0000000000000051 RBX: ffff95c9c16a41c0 RCX: 0000000000000000
>    [192922.921692] RDX: 0000000000000000 RSI: ffff95cab6b16838 RDI: ffff95cab6b16838
>    [192922.922066] RBP: ffff95c9c16a41c0 R08: 0000000000000000 R09: 0000000000000000
>    [192922.922442] R10: ffffaebdc8a27e70 R11: 0000000000000000 R12: ffff95ca731a0980
>    [192922.922820] R13: 0000000000000000 R14: ffff95ca84c73338 R15: ffff95ca731a0ea8
>    [192922.923200] FS:  00007f337eda4e80(0000) GS:ffff95cab6b00000(0000) knlGS:0000000000000000
>    [192922.923579] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    [192922.923948] CR2: 00007f337edad000 CR3: 00000001e00f6002 CR4: 00000000003606e0
>    [192922.924329] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>    [192922.924711] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>    [192922.925105] Call Trace:
>    [192922.925505]  btrfs_trans_release_metadata+0x10c/0x170 [btrfs]
>    [192922.925911]  btrfs_commit_transaction+0x3e/0xaf0 [btrfs]
>    [192922.926324]  btrfs_sync_file+0x44c/0x490 [btrfs]
>    [192922.926731]  do_fsync+0x38/0x60
>    [192922.927138]  __x64_sys_fdatasync+0x13/0x20
>    [192922.927543]  do_syscall_64+0x60/0x1c0
>    [192922.927939]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>    (...)
>    [192922.934077] ---[ end trace f00808b12068168f ]---
> 
> 2) If evict_refill_and_join() decides to commit the transaction, it will
evict_refill_and_join only ever calls btrfs_join_transaction so it
cannot ever commit the transaction. Let's look into its sole caller,
btrfs_evict_inode, I see 3 cases where transactions handle is involved
in that function:

1. btrfs_commit_inode_delayed_inode - iot calls trans_join +
end_transaction => use_count = 2 -> no commit

2. btrfs_truncate_inode_items -> never calls end/commit transaction

3. btrfs_evict_inode itself only ever calls btrfs_end_transaction on a
handle that's obtained via btrfs_join_transaction, meaning that trans
handle's ->use_count will be 2. This in turn will hit:

 if (refcount_read(&trans->use_count) > 1) {
                  refcount_dec(&trans->use_count);

                  trans->block_rsv = trans->orig_rsv;

                  return 0;

}

in __btrfs_end_transaction. That code is in direct contradiction with
what you describe next? Am I missing something here? If my analysis is
correct this implies case 1) above also cannot happen because
trans->block_rsv is set to NULL in __btrfs_end_transaction only if
use_count == 1.

>    be able to do it, since the nested transaction join only increments the
>    transaction handle's ->use_count reference counter and it does not
>    prevent the transaction from getting committed. This means that after
>    eviction completes, the fsync logging path will be using a transaction
>    handle that refers to an already committed transaction. What happens
>    when using such a stale transaction can be unpredictable, we are at
>    least having a use-after-free on the transaction handle itself, since
>    the transaction commit will call kmem_cache_free() against the handle
>    regardless of its ->use_count value, or we can end up silently losing
>    all the updates to the log tree after that iput() in the logging path,
>    or using a transaction handle that in the meanwhile was allocated to
>    another task for a new transaction, etc, pretty much unpredictable
>    what can happen.
> 
> In order to fix both of them, instead of using iput() during logging, use
> btrfs_add_delayed_iput(), so that the logging path of fsync never drops
> the last reference on an inode, that step is offloaded to a safe context
> (usually the cleaner kthread).
> 
> The assertion failure issue was sporadically triggered by the test case
> generic/475 from fstests, which loads the dm error target while fsstress
> is running, which lead to fsync failing while logging inodes with -EIO
> errors and then trying later to commit the transaction, triggering the
> assertion failure.
> 
> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 6c8297bcfeb7..1bfd7e34f31e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -4985,7 +4985,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  						      BTRFS_I(inode),
>  						      LOG_OTHER_INODE_ALL,
>  						      0, LLONG_MAX, ctx);
> -					iput(inode);
> +					btrfs_add_delayed_iput(inode);
>  				}
>  			}
>  			continue;
> @@ -5000,7 +5000,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  		ret = btrfs_log_inode(trans, root, BTRFS_I(inode),
>  				      LOG_OTHER_INODE, 0, LLONG_MAX, ctx);
>  		if (ret) {
> -			iput(inode);
> +			btrfs_add_delayed_iput(inode);
>  			continue;
>  		}
>  
> @@ -5009,7 +5009,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  		key.offset = 0;
>  		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>  		if (ret < 0) {
> -			iput(inode);
> +			btrfs_add_delayed_iput(inode);
>  			continue;
>  		}
>  
> @@ -5056,7 +5056,7 @@ static int log_conflicting_inodes(struct btrfs_trans_handle *trans,
>  			}
>  			path->slots[0]++;
>  		}
> -		iput(inode);
> +		btrfs_add_delayed_iput(inode);
>  	}
>  
>  	return ret;
> @@ -5689,7 +5689,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
>  			}
>  
>  			if (btrfs_inode_in_log(BTRFS_I(di_inode), trans->transid)) {
> -				iput(di_inode);
> +				btrfs_add_delayed_iput(di_inode);
>  				break;
>  			}
>  
> @@ -5701,7 +5701,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
>  			if (!ret &&
>  			    btrfs_must_commit_transaction(trans, BTRFS_I(di_inode)))
>  				ret = 1;
> -			iput(di_inode);
> +			btrfs_add_delayed_iput(di_inode);
>  			if (ret)
>  				goto next_dir_inode;
>  			if (ctx->log_new_dentries) {
> @@ -5848,7 +5848,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
>  			if (!ret && ctx && ctx->log_new_dentries)
>  				ret = log_new_dir_dentries(trans, root,
>  						   BTRFS_I(dir_inode), ctx);
> -			iput(dir_inode);
> +			btrfs_add_delayed_iput(dir_inode);
>  			if (ret)
>  				goto out;
>  		}
> @@ -5891,7 +5891,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
>  			ret = btrfs_log_inode(trans, root, BTRFS_I(inode),
>  					      LOG_INODE_EXISTS,
>  					      0, LLONG_MAX, ctx);
> -		iput(inode);
> +		btrfs_add_delayed_iput(inode);
>  		if (ret)
>  			return ret;
>  
> 
