Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD62BEC0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 08:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403780AbfIZGfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 02:35:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48612 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388934AbfIZGfu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 02:35:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FA83ADAA
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2019 06:35:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: relocation: Hunt down BUG_ON() in merge_reloc_roots()
Date:   Thu, 26 Sep 2019 14:35:45 +0800
Message-Id: <20190926063545.20403-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is one BUG_ON() report where a transaction is aborted during
balance, then kernel BUG_ON() in merge_reloc_roots():

  void merge_reloc_roots(struct reloc_control *rc)
  {
	...
	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)); <<<
  }

[CAUSE]
It's still uncertain why we can get to such situation.
As all __add_reloc_root() calls will also link that reloc root to
rc->reloc_roots, and in merge_reloc_roots() we cleanup rc->reloc_roots.

So the root cause is still uncertain.

[FIX]
But we can still hunt down all the BUG_ON() in merge_reloc_roots().

There are 3 BUG_ON()s in it:
- BUG_ON() for read_fs_root() result
- BUG_ON() for root->reloc_root != reloc_root case
- BUG_ON() for the non-empty reloc_root_tree

For the first two, just grab the return value and goto out tag for
cleanup.

For the last one, make it more graceful by:
- grab the lock before doing read/write
- warn instead of panic
- cleanup the nodes in rc->reloc_root_tree

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
The root cause to leak nodes in reloc_root_tree is still unknown.
---
 fs/btrfs/relocation.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 655f1d5a8c27..d562b5c52a40 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2484,11 +2484,26 @@ void merge_reloc_roots(struct reloc_control *rc)
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
 			root = read_fs_root(fs_info,
 					    reloc_root->root_key.offset);
-			BUG_ON(IS_ERR(root));
-			BUG_ON(root->reloc_root != reloc_root);
+			if (IS_ERR(root)) {
+				ret = PTR_ERR(root);
+				btrfs_err(fs_info,
+					  "failed to read root %llu: %d",
+					  reloc_root->root_key.offset, ret);
+				goto out;
+			}
+			if (root->reloc_root != reloc_root) {
+				btrfs_err(fs_info,
+					"reloc root mismatch for root %llu",
+					root->root_key.objectid);
+				ret = -EINVAL;
+				goto out;
+			}
 
 			ret = merge_reloc_root(rc, root);
 			if (ret) {
+				btrfs_err(fs_info,
+			"failed to merge reloc tree for root %llu: %d",
+					  root->root_key.objectid, ret);
 				if (list_empty(&reloc_root->root_list))
 					list_add_tail(&reloc_root->root_list,
 						      &reloc_roots);
@@ -2520,7 +2535,25 @@ void merge_reloc_roots(struct reloc_control *rc)
 			free_reloc_roots(&reloc_roots);
 	}
 
-	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));
+	spin_lock(&rc->reloc_root_tree.lock);
+	/* Cleanup dirty reloc tree nodes */
+	if (!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)) {
+		struct mapping_node *node;
+		struct mapping_node *next;
+
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		rbtree_postorder_for_each_entry_safe(node, next,
+				&rc->reloc_root_tree.rb_root, rb_node) {
+			struct btrfs_root *root = node->data;
+
+			if (root)
+				btrfs_debug(fs_info,
+				"root %llu still in rc->reloc_root_tree",
+					    root->root_key.offset);
+			kfree(node);
+		}
+	}
+	spin_unlock(&rc->reloc_root_tree.lock);
 }
 
 static void free_block_list(struct rb_root *blocks)
-- 
2.23.0

