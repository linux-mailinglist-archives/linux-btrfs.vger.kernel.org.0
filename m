Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E1C61AA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 08:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfGHG2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 02:28:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:43312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfGHG2I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 02:28:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7729CAF33;
        Mon,  8 Jul 2019 06:28:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?Klemens=20Sch=C3=B6lhorn?= <klemens@schoelhorn.eu>
Subject: [PATCH] btrfs-progs: Run delayed refs to prevent uncommitted extent tree update
Date:   Mon,  8 Jul 2019 14:28:02 +0800
Message-Id: <20190708062802.2254-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Btrfs-progs sometimes fails to find certain extent backref when
commiting transaction.
The most reliable way to reproduce it is fsck-test/013 on 64K page sized
system:
  [...]
  adding new data backref on 315859712 root 287 owner 292 offset 0 found 1
  btrfs unable to find ref byte nr 31850496 parent 0 root 2  owner 0 offset 0
  Failed to find [30867456, 168, 65536]

Also there are some github bug reports related to this problem.

[CAUSE]
Commit 909357e86799 ("btrfs-progs: Wire up delayed refs") introduced
delayed refs in btrfs-progs.

However in that commit, delayed refs are not run at correct timing.
That commit calls btrfs_run_delayed_refs() before
btrfs_write_dirty_block_groups(), which needs to update
BLOCK_GROUP_ITEMs in extent tree, thus could cause new delayed refs.

This means each time we commit a transaction, we may screw up the extent
tree by dropping some pending delayed refs, like:

Transaction 711:
btrfs_commit_transaction()
|- btrfs_run_delayed_refs()
|  Now all delayed refs are written to extent tree
|
|- btrfs_write_dirty_block_groups()
|  Needs to update extent tree root
|  ADD_DELAYED_REF to 315859712.
|  Delayed refs are attached to current trans handle.
|
|- __commit_transaction()
|- write_ctree_super()
|- btrfs_finish_extent_commit()
|- kfree(trans)
   Now delayed ref for 315859712 are lost

Transaction 712:
Tree block 315859712 get dropped
btrfs_commit_transaction()
|- btrfs_run_delayed_refs()
   |- run_one_delayed_ref()
      |- __free_extent()
         As previous ADD_DELAYED_REF to 315859712 is lost, extent tree
         doesn't has any backref for 315859712, causing the bug

In fact, commit c31edf610cbe ("btrfs-progs: Fix false ENOSPC alert by
tracking used space correctly") detects the tree block leakage, but in
the reproducer we have too many noise, thus nobody notices the leakage
warning.

[FIX]
Call btrfs_run_delayed_refs() just before __commit_transaction(), which
doesn't generate new tree blocks but only flush existing tree blocks to
disk.

Also, to prevent such problem from happening again (and not to debug
such problem again), add extra check on delayed refs before freeing the
trans handle.

Reported-by: Klemens Schölhorn <klemens@schoelhorn.eu>
Issue: 187
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 transaction.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/transaction.c b/transaction.c
index 551fb24e674d..4d676d4b4ea0 100644
--- a/transaction.c
+++ b/transaction.c
@@ -193,17 +193,27 @@ commit_tree:
 	ret = commit_tree_roots(trans, fs_info);
 	if (ret < 0)
 		goto error;
+	btrfs_write_dirty_block_groups(trans);
 	/*
 	 * Ensure that all committed roots are properly accounted in the
 	 * extent tree
+	 *
+	 * This must happen after all tree updates, including above
+	 * btrfs_write_dirty_block_groups(), which will update extent tree.
+	 * Or we will lose some delayed refs.
 	 */
 	ret = btrfs_run_delayed_refs(trans, -1);
 	if (ret < 0)
 		goto error;
-	btrfs_write_dirty_block_groups(trans);
 	__commit_transaction(trans, root);
 	if (ret < 0)
 		goto error;
+
+	/* There should be no pending delayed refs now */
+	if (!RB_EMPTY_ROOT(&trans->delayed_refs.href_root)) {
+		error("Uncommitted delayed refs detected");
+		goto error;
+	}
 	ret = write_ctree_super(trans);
 	btrfs_finish_extent_commit(trans);
 	kfree(trans);
-- 
2.22.0

