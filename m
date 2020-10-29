Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64F29EB38
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 13:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJ2MDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 08:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:32950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJ2MDJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 08:03:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603972988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vy1afNHYzsWVOwPNdYim5rFX7YEHsvkTE6ylcFoJU5A=;
        b=DohWMUB8ei/F/pXqpk5DEOvs4q8/U2Eisx6RgQLy0/LIQJw7ozlHQb2TBK2x+np31kOAI7
        QAx2jw2wNqfHvv+xYUEStr5XceWJkSqNkkGB3XdSItRC7ltSG3v8UZHRsrmEXQU1X7CE6l
        Qv2oOfXeLJJyWSieGEPLf/A3Tk20iSA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E87EEACF1;
        Thu, 29 Oct 2020 12:03:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F3AEADA7E9; Thu, 29 Oct 2020 13:01:32 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/8] btrfs: add set/get accessors for root_item::drop_level
Date:   Thu, 29 Oct 2020 13:01:32 +0100
Message-Id: <143a392c136f642f1f556a92e39c8caaf3eb58ca.1603972767.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603972767.git.dsterba@suse.com>
References: <cover.1603972767.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The drop_level member is used directly unlike all the other int types in
root_item. Add the definition and use it everywhere. The type is u8 so
there's no conversion necessary and the helpers are properly inlined,
this is for consistency.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h        |  1 +
 fs/btrfs/disk-io.c      |  2 +-
 fs/btrfs/extent-tree.c  |  6 +++---
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/relocation.c   | 10 +++++-----
 fs/btrfs/tree-checker.c |  4 ++--
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8a83bce3225c..09013ab8d4dc 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2085,6 +2085,7 @@ BTRFS_SETGET_FUNCS(disk_root_level, struct btrfs_root_item, level, 8);
 BTRFS_SETGET_STACK_FUNCS(root_generation, struct btrfs_root_item,
 			 generation, 64);
 BTRFS_SETGET_STACK_FUNCS(root_bytenr, struct btrfs_root_item, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(root_drop_level, struct btrfs_root_item, drop_level, 8);
 BTRFS_SETGET_STACK_FUNCS(root_level, struct btrfs_root_item, level, 8);
 BTRFS_SETGET_STACK_FUNCS(root_dirid, struct btrfs_root_item, root_dirid, 64);
 BTRFS_SETGET_STACK_FUNCS(root_refs, struct btrfs_root_item, refs, 32);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21f7034945a0..fd92326980bd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1179,7 +1179,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 		generate_random_guid(root->root_item.uuid);
 	else
 		export_guid(root->root_item.uuid, &guid_null);
-	root->root_item.drop_level = 0;
+	btrfs_set_root_drop_level(&root->root_item, 0);
 
 	key.objectid = objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5fd60b13f4f8..bac1eb17e498 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5496,7 +5496,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		memcpy(&wc->update_progress, &key,
 		       sizeof(wc->update_progress));
 
-		level = root_item->drop_level;
+		level = btrfs_root_drop_level(root_item);
 		BUG_ON(level == 0);
 		path->lowest_level = level;
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
@@ -5529,7 +5529,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 			}
 			BUG_ON(wc->refs[level] == 0);
 
-			if (level == root_item->drop_level)
+			if (level == btrfs_root_drop_level(root_item))
 				break;
 
 			btrfs_tree_unlock(path->nodes[level]);
@@ -5574,7 +5574,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		}
 		btrfs_cpu_key_to_disk(&root_item->drop_progress,
 				      &wc->drop_progress);
-		root_item->drop_level = wc->drop_level;
+		btrfs_set_root_drop_level(root_item, wc->drop_level);
 
 		BUG_ON(wc->level == 0);
 		if (btrfs_should_end_transaction(trans) ||
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1dcccd212809..1e444703afaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4003,7 +4003,7 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
 
 	memset(&dest->root_item.drop_progress, 0,
 		sizeof(dest->root_item.drop_progress));
-	dest->root_item.drop_level = 0;
+	btrfs_set_root_drop_level(&dest->root_item, 0);
 	btrfs_set_root_refs(&dest->root_item, 0);
 
 	if (!test_and_set_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &dest->state)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3602806d71bd..d4d31525cfa9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -783,7 +783,7 @@ static struct btrfs_root *create_reloc_root(struct btrfs_trans_handle *trans,
 		btrfs_set_root_refs(root_item, 0);
 		memset(&root_item->drop_progress, 0,
 		       sizeof(struct btrfs_disk_key));
-		root_item->drop_level = 0;
+		btrfs_set_root_drop_level(root_item, 0);
 	}
 
 	btrfs_tree_unlock(eb);
@@ -1575,7 +1575,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 	reloc_root_item = &reloc_root->root_item;
 	memset(&reloc_root_item->drop_progress, 0,
 		sizeof(reloc_root_item->drop_progress));
-	reloc_root_item->drop_level = 0;
+	btrfs_set_root_drop_level(reloc_root_item, 0);
 	btrfs_set_root_refs(reloc_root_item, 0);
 	btrfs_update_reloc_root(trans, root);
 
@@ -1671,7 +1671,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 	} else {
 		btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
 
-		level = root_item->drop_level;
+		level = btrfs_root_drop_level(root_item);
 		BUG_ON(level == 0);
 		path->lowest_level = level;
 		ret = btrfs_search_slot(NULL, reloc_root, &key, path, 0, 0);
@@ -1767,7 +1767,7 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		 */
 		btrfs_node_key(path->nodes[level], &root_item->drop_progress,
 			       path->slots[level]);
-		root_item->drop_level = level;
+		btrfs_set_root_drop_level(root_item, level);
 
 		btrfs_end_transaction_throttle(trans);
 		trans = NULL;
@@ -3692,7 +3692,7 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 
 	memset(&root->root_item.drop_progress, 0,
 		sizeof(root->root_item.drop_progress));
-	root->root_item.drop_level = 0;
+	btrfs_set_root_drop_level(&root->root_item, 0);
 	btrfs_set_root_refs(&root->root_item, 0);
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 8784b74f5232..47f9502caf9f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1117,10 +1117,10 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			    btrfs_root_level(&ri), BTRFS_MAX_LEVEL - 1);
 		return -EUCLEAN;
 	}
-	if (ri.drop_level >= BTRFS_MAX_LEVEL) {
+	if (btrfs_root_drop_level(&ri) >= BTRFS_MAX_LEVEL) {
 		generic_err(leaf, slot,
 			    "invalid root level, have %u expect [0, %u]",
-			    ri.drop_level, BTRFS_MAX_LEVEL - 1);
+			    btrfs_root_drop_level(&ri), BTRFS_MAX_LEVEL - 1);
 		return -EUCLEAN;
 	}
 
-- 
2.25.0

