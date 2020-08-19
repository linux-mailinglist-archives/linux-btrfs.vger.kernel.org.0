Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3424950D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 08:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHSGgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 02:36:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59282 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbgHSGgF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 02:36:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3851B137;
        Wed, 19 Aug 2020 06:36:29 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 3/4] btrfs: extent-tree: kill the BUG_ON() in insert_inline_extent_backref()
Date:   Wed, 19 Aug 2020 14:35:49 +0800
Message-Id: <20200819063550.62832-4-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819063550.62832-1-wqu@suse.com>
References: <20200819063550.62832-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With crafted image, btrfs can panic at insert_inline_extent_backref():
  kernel BUG at fs/btrfs/extent-tree.c:1857!
  invalid opcode: 0000 [#1] SMP PTI
  CPU: 0 PID: 1117 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
  RIP: 0010:insert_inline_extent_backref+0xcc/0xe0
  Code: 45 20 49 8b 7e 50 49 89 d8 4c 8b 4d 10 48 8b 55 c8 4c 89 e1 41 57 4c 89 ee 50 ff 75 18 e8 cc bf ff ff 31 c0 48 83 c4 18 eb b2 <0f> 0b e8 9d df bd ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66
  RSP: 0018:ffffac4dc1287be8 EFLAGS: 00010293
  RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000001
  RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffac4dc1287c28 R08: ffffac4dc1287ab8 R09: ffffac4dc1287ac0
  R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  R13: ffff8febef88a540 R14: ffff8febeaa7bc30 R15: 0000000000000000
  FS: 0000000000000000(0000) GS:ffff8febf7a00000(0000) knlGS:0000000000000000
  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f663ace94c0 CR3: 0000000235698006 CR4: 00000000000206f0
  Call Trace:
  ? _cond_resched+0x1a/0x50
  __btrfs_inc_extent_ref.isra.64+0x7e/0x240
  ? btrfs_merge_delayed_refs+0xa5/0x330
  __btrfs_run_delayed_refs+0x653/0x1120
  btrfs_run_delayed_refs+0xdb/0x1b0
  btrfs_commit_transaction+0x52/0x950
  ? start_transaction+0x94/0x450
  transaction_kthread+0x163/0x190
  kthread+0x105/0x140
  ? btrfs_cleanup_transaction+0x560/0x560
  ? kthread_destroy_worker+0x50/0x50
  ret_from_fork+0x35/0x40
  Modules linked in:
  ---[ end trace 2ad8b3de903cf825 ]---

[CAUSE]
Due to extent tree corruption (still valid by itself, but bad cross ref),
we can allocate an extent which is still in extent tree.
The offending tree block of that case is from csum tree.
The newly allocated tree block is also for csum tree.

Then we will try to insert an tree block ref for the existing tree block
ref.

For btrfs tree extent item, a tree block can never be shared directly by
the same tree twice.
We have such BUG_ON() to prevent such problem, but BUG_ON() is
definitely not good enough.

[FIX]
Replace that BUG_ON() with proper error message and leaf dump for debug
build.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=202829
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 94803e51e9d0..078b57fb3d43 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1177,7 +1177,22 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 					   num_bytes, parent, root_objectid,
 					   owner, offset, 1);
 	if (ret == 0) {
-		BUG_ON(owner < BTRFS_FIRST_FREE_OBJECTID);
+		/*
+		 * We're adding refs to an tree block we already own, this
+		 * should not happen at all.
+		 */
+		if (owner < BTRFS_FIRST_FREE_OBJECTID) {
+			btrfs_crit(trans->fs_info,
+"invalid operation, adding refs to an existing tree ref, bytenr=%llu num_bytes=%llu root_objectid=%llu",
+				   bytenr, num_bytes, root_objectid);
+			if (IS_ENABLED(CONFIG_BTRFS_DEBUG)) {
+				WARN_ON(1);
+				btrfs_crit(trans->fs_info,
+			"path->slots[0]=%d path->nodes[0]:", path->slots[0]);
+				btrfs_print_leaf(path->nodes[0]);
+			}
+			return -EUCLEAN;
+		}
 		update_inline_extent_backref(path, iref, refs_to_add,
 					     extent_op, NULL);
 	} else if (ret == -ENOENT) {
@@ -1397,6 +1412,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 /*
  * __btrfs_inc_extent_ref - insert backreference for a given extent
  *
+ * The work is opposite as __btrfs_free_extent().
+ * For more info about how it works or examples, refer to __btrfs_free_extent().
+ *
  * @trans:	    Handle of transaction
  *
  * @node:	    The delayed ref node used to get the bytenr/length for
-- 
2.28.0

