Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3CB6A475
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2019 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfGPJAy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jul 2019 05:00:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:59066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbfGPJAx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jul 2019 05:00:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D76A1B0BF
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2019 09:00:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: delayed-inode: Kill the BUG_ON() in btrfs_delete_delayed_dir_index()
Date:   Tue, 16 Jul 2019 17:00:32 +0800
Message-Id: <20190716090034.11641-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716090034.11641-1-wqu@suse.com>
References: <20190716090034.11641-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is one report of fuzzed image which leads to BUG_ON() in
btrfs_delete_delayed_dir_index().

Although that fuzzed image can already be addressed by enhanced
extent-tree error handler, it's still better to hunt down more BUG_ON().

This patch will hunt down two BUG_ON()s in
btrfs_delete_delayed_dir_index():
- One for error from btrfs_delayed_item_reserve_metadata()
  Instead of BUG_ON(), we output an error message and free the item.
  And return the error.
  All callers of this function handles the error by aborting current
  trasaction.

- One for possible EEXIST from __btrfs_add_delayed_deletion_item()
  That function can return -EEXIST.
  We already have a good enough error message for that, only need to
  clean up the reserved metadata space and allocated item.

To help above cleanup, also modifiy __btrfs_remove_delayed_item() called
in btrfs_release_delayed_item(), to skip unassociated item.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203253
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delayed-inode.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 43fdb2992956..c4946d58f49b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -474,6 +474,9 @@ static void __btrfs_remove_delayed_item(struct btrfs_delayed_item *delayed_item)
 	struct rb_root_cached *root;
 	struct btrfs_delayed_root *delayed_root;
 
+	/* Not associated with any delayed_node */
+	if (!delayed_item->delayed_node)
+		return;
 	delayed_root = delayed_item->delayed_node->root->fs_info->delayed_root;
 
 	BUG_ON(!delayed_root);
@@ -1525,7 +1528,13 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 	 * we have reserved enough space when we start a new transaction,
 	 * so reserving metadata failure is impossible.
 	 */
-	BUG_ON(ret);
+	if (ret < 0) {
+		btrfs_err(trans->fs_info,
+"metadata reserve fail at %s, should have already reserved space, ret=%d",
+			  __func__, ret);
+		btrfs_release_delayed_item(item);
+		goto end;
+	}
 
 	mutex_lock(&node->mutex);
 	ret = __btrfs_add_delayed_deletion_item(node, item);
@@ -1534,7 +1543,8 @@ int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
 			  "err add delayed dir index item(index: %llu) into the deletion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
 			  index, node->root->root_key.objectid,
 			  node->inode_id, ret);
-		BUG();
+		btrfs_delayed_item_release_metadata(dir->root, item);
+		btrfs_release_delayed_item(item);
 	}
 	mutex_unlock(&node->mutex);
 end:
-- 
2.22.0

