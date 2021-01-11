Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937992F227B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 23:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbhAKWMX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 17:12:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:37368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbhAKWMW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 17:12:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6948AB3E;
        Mon, 11 Jan 2021 22:11:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC762DA701; Mon, 11 Jan 2021 23:09:48 +0100 (CET)
Date:   Mon, 11 Jan 2021 23:09:48 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 04/13] btrfs: splice remaining dirty_bg's onto the
 transaction dirty bg list
Message-ID: <20210111220948.GJ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>
References: <cover.1608135557.git.josef@toxicpanda.com>
 <92c0de2de1f65b71393307dba17d2cc48f183992.1608135557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c0de2de1f65b71393307dba17d2cc48f183992.1608135557.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:22:08AM -0500, Josef Bacik wrote:
> While doing error injection testing with my relocation patches I hit the
> following ASSERT()
> 
> assertion failed: list_empty(&block_group->dirty_list), in fs/btrfs/block-group.c:3356
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/ctree.h:3357!
> invalid opcode: 0000 [#1] SMP NOPTI
> CPU: 0 PID: 24351 Comm: umount Tainted: G        W         5.10.0-rc3+ #193
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> RIP: 0010:assertfail.constprop.0+0x18/0x1a
> RSP: 0018:ffffa09b019c7e00 EFLAGS: 00010282
> RAX: 0000000000000056 RBX: ffff8f6492c18000 RCX: 0000000000000000
> RDX: ffff8f64fbc27c60 RSI: ffff8f64fbc19050 RDI: ffff8f64fbc19050
> RBP: ffff8f6483bbdc00 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffa09b019c7c38 R11: ffffffff85d70928 R12: ffff8f6492c18100
> R13: ffff8f6492c18148 R14: ffff8f6483bbdd70 R15: dead000000000100
> FS:  00007fbfda4cdc40(0000) GS:ffff8f64fbc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbfda666fd0 CR3: 000000013cf66002 CR4: 0000000000370ef0
> Call Trace:
>  btrfs_free_block_groups.cold+0x55/0x55
>  close_ctree+0x2c5/0x306
>  ? fsnotify_destroy_marks+0x14/0x100
>  generic_shutdown_super+0x6c/0x100
>  kill_anon_super+0x14/0x30
>  btrfs_kill_super+0x12/0x20
>  deactivate_locked_super+0x36/0xa0
>  cleanup_mnt+0x12d/0x190
>  task_work_run+0x5c/0xa0
>  exit_to_user_mode_prepare+0x1b1/0x1d0
>  syscall_exit_to_user_mode+0x54/0x280
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> This happened because I injected an error in btrfs_cow_block() while
> running the dirty block groups.  When we run the dirty block groups, we
> splice the list onto a local list to process.  However if an error
> occurs, we only cleanup the transactions dirty block group list, not any
> pending block groups we have on our locally spliced list.  Fix this by
> splicing the list back onto the transactions dirty block group list, so
> any remaining block groups are cleaned up.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/block-group.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 52f2198d44c9..69f8a306d70d 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2684,6 +2684,9 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
>  		}
>  		spin_unlock(&cur_trans->dirty_bgs_lock);
>  	} else if (ret < 0) {
> +		spin_lock(&cur_trans->dirty_bgs_lock);
> +		list_splice_init(&dirty, &cur_trans->dirty_bgs);
> +		spin_unlock(&cur_trans->dirty_bgs_lock);
>  		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
>  	}

There seem to be another error path that should un-splice the remaining
block groups:

2554         spin_lock(&cur_trans->dirty_bgs_lock);
2555         if (list_empty(&cur_trans->dirty_bgs)) {
2556                 spin_unlock(&cur_trans->dirty_bgs_lock);
2557                 return 0;
2558         }
2559         list_splice_init(&cur_trans->dirty_bgs, &dirty);
2560         spin_unlock(&cur_trans->dirty_bgs_lock);
2561
2562 again:
2563         /* Make sure all the block groups on our dirty list actually exist */
2564         btrfs_create_pending_block_groups(trans);
2565
2566         if (!path) {
2567                 path = btrfs_alloc_path();
2568                 if (!path)
2569                         return -ENOMEM;
2570         }

Initially the splice happens on line 2559. First error is on the !path
condition on line 2568, so that would need to be un-spliced.

On the 2nd iteration (looop == 1) we can't hit the error as path was
initialized before and it's only reused.
