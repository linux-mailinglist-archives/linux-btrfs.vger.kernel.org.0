Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B88321D43
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 17:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhBVQmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 11:42:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:45970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231421AbhBVQlh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 11:41:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614012049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFdBiK5sUdhKXkPTCUiaPTG0G9IkWuZnHXGDGYRZFSo=;
        b=CbB0+OyXcM+kGnu6gV407/nuzlAlIfQ5wn43WI1PW7XrD7s/bd3iTT5ksB01lCWaQDQh9N
        lVArFr73j3OlYhxGgdWiRJBfWMfV+jBMxAnQcmOzVE7v73L/ASOVgqMilovrsxKeEEHfye
        6znDXrQUfJ6ThE2bY3J+JGmHj/KXXP0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C902CB02B;
        Mon, 22 Feb 2021 16:40:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/6] btrfs: Don't flush from btrfs_delayed_inode_reserve_metadata
Date:   Mon, 22 Feb 2021 18:40:44 +0200
Message-Id: <20210222164047.978768-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222164047.978768-1-nborisov@suse.com>
References: <20210222164047.978768-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Calling btrfs_qgroup_reserve_meta_prealloc from
btrfs_delayed_inode_reserve_metadata can result in flushing delalloc
while holding a transaction and delayed node locks. This is is dead-lock
prone. In the past multiple commits:

 * ae5e070eaca9 ("btrfs: qgroup: don't try to wait flushing if we're
already holding a transaction")

 * 6f23277a49e6 ("btrfs: qgroup: don't commit transaction when we already
 hold the handle")

Tried to solve various aspects of this but this was always a
whack-a-mole game. Unfortunately those 2 fixes don't solve a deadlock
scenario involving btrfs_delayed_node::mutex. Namely, one thread
can call btrfs_dirty_inode as a result of reading a file and modifying
its atime:

> PID: 6963   TASK: ffff8c7f3f94c000  CPU: 2   COMMAND: "http-0.0.0.0-62"
>  #0 [ffffaedd02a67a00] __schedule at ffffffffa529e07d
> #1 [ffffaedd02a67a90] schedule at ffffffffa529e4ff
> #2 [ffffaedd02a67aa0] schedule_timeout at ffffffffa52a1bdd
> #3 [ffffaedd02a67b18] wait_for_completion at ffffffffa529eeea <-- sleeps with delayed node mutex held
> #4 [ffffaedd02a67b68] start_delalloc_inodes at ffffffffc0380db5 [btrfs]
> #5 [ffffaedd02a67be8] btrfs_start_delalloc_snapshot at ffffffffc0393836 [btrfs]
> #6 [ffffaedd02a67bf0] try_flush_qgroup at ffffffffc03f04b2 [btrfs]
> #7 [ffffaedd02a67c40] __btrfs_qgroup_reserve_meta at ffffffffc03f5bb6 [btrfs] <-- tries to reserve space and starts delalloc inodes.
> #8 [ffffaedd02a67c68] btrfs_delayed_update_inode at ffffffffc03e31aa [btrfs] <-- Acquires delayed node mutex
> #9 [ffffaedd02a67cc0] btrfs_update_inode at ffffffffc0385ba8 [btrfs]
> #10 [ffffaedd02a67ce8] btrfs_dirty_inode at ffffffffc038627b [btrfs] <-- TRANSACTIION OPENED
> #11 [ffffaedd02a67d18] touch_atime at ffffffffa4cf0000
> #12 [ffffaedd02a67d58] generic_file_read_iter at ffffffffa4c1f123
> #13 [ffffaedd02a67e40] new_sync_read at ffffffffa4ccdc8a
> #14 [ffffaedd02a67ec8] vfs_read at ffffffffa4cd0849
> #15 [ffffaedd02a67ef8] ksys_read at ffffffffa4cd0bd1
> #16 [ffffaedd02a67f38] do_syscall_64 at ffffffffa4a052eb
> #17 [ffffaedd02a67f50] entry_SYSCALL_64_after_hwframe at ffffffffa540008c

This will cause an asynchronous work to flush the delalloc inodes to
happen which can try to acquire the same delayed_node mutex:

> PID: 455    TASK: ffff8c8085fa4000  CPU: 5   COMMAND: "kworker/u16:30"
> #0 [ffffaedd009f77b0] __schedule at ffffffffa529e07d
> #1 [ffffaedd009f7840] schedule at ffffffffa529e4ff
> #2 [ffffaedd009f7850] schedule_preempt_disabled at ffffffffa529e80a
> #3 [ffffaedd009f7858] __mutex_lock at ffffffffa529fdcb <--- goes to sleep, never wakes up.
> #4 [ffffaedd009f78f8] btrfs_delayed_update_inode at ffffffffc03e3143 [btrfs] <-- tries to acquire the mutex
> #5 [ffffaedd009f7950] btrfs_update_inode at ffffffffc0385ba8 [btrfs]   <-- This is the same inode that pid 6963 is holding
> #6 [ffffaedd009f7978] cow_file_range_inline.constprop.78 at ffffffffc0386be7 [btrfs]
> #7 [ffffaedd009f7a30] cow_file_range at ffffffffc03879c1 [btrfs]
> #8 [ffffaedd009f7ab8] btrfs_run_delalloc_range at ffffffffc038894c [btrfs]
> #9 [ffffaedd009f7b40] writepage_delalloc at ffffffffc03a3c8f [btrfs]
> #10 [ffffaedd009f7ba0] __extent_writepage at ffffffffc03a4c01 [btrfs]
> #11 [ffffaedd009f7c08] extent_write_cache_pages at ffffffffc03a500b [btrfs]
> #12 [ffffaedd009f7d08] extent_writepages at ffffffffc03a6de2 [btrfs]
> #13 [ffffaedd009f7d38] do_writepages at ffffffffa4c277eb
> #14 [ffffaedd009f7db8] __filemap_fdatawrite_range at ffffffffa4c1e5bb
> #15 [ffffaedd009f7e40] btrfs_run_delalloc_work at ffffffffc0380987 [btrfs] <-- starts running delayed nodes
> #16 [ffffaedd009f7e58] normal_work_helper at ffffffffc03b706c [btrfs]
> #17 [ffffaedd009f7e98] process_one_work at ffffffffa4aba4e4
> #18 [ffffaedd009f7ed8] worker_thread at ffffffffa4aba6fd
> #19 [ffffaedd009f7f10] kthread at ffffffffa4ac0a3d
> #20 [ffffaedd009f7f50] ret_from_fork at ffffffffa54001ff

To fully address those cases the complete fix is to never issue any
flushing while holding the transaction or the delayed node lock. This
patch achieves it by calling qgroup_reserve_meta directly which will
either succeed without flushing or will fail and return -EDQUOT. In the
latter case that return value is going to be propagated to
btrfs_dirty_inode which will fallback to start a new transaction. That's
fine as the majority of time we expect the inode will have
BTRFS_DELAYED_NODE_INODE_DIRTY flag set which will result in directly
copying the in-memory state.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-inode.c | 3 ++-
 fs/btrfs/inode.c         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ac9966e76a2f..6dcf2cd1b39e 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -627,7 +627,8 @@ static int btrfs_delayed_inode_reserve_metadata(
 	 */
 	if (!src_rsv || (!trans->bytes_reserved &&
 			 src_rsv->type != BTRFS_BLOCK_RSV_DELALLOC)) {
-		ret = btrfs_qgroup_reserve_meta_prealloc(root, num_bytes, true);
+		ret = qgroup_reserve_meta(root, num_bytes,
+					  BTRFS_QGROUP_RSV_META_PREALLOC, true);
 		if (ret < 0)
 			return ret;
 		ret = btrfs_block_rsv_add(root, dst_rsv, num_bytes,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 547d6c1287d5..bf2d0d3ae7c5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6081,7 +6081,7 @@ static int btrfs_dirty_inode(struct inode *inode)
 		return PTR_ERR(trans);
 
 	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-	if (ret && ret == -ENOSPC) {
+	if (ret && (ret == -ENOSPC || ret == -EDQUOT)) {
 		/* whoops, lets try again with the full transaction */
 		btrfs_end_transaction(trans);
 		trans = btrfs_start_transaction(root, 1);
-- 
2.25.1

