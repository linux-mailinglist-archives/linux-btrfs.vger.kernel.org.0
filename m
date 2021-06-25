Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878CD3B3D0E
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYHPt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 03:15:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59676 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFYHPt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 03:15:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1FC0921BF2;
        Fri, 25 Jun 2021 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624605208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHglpmv6d1WVXZYukx+Xy7quzvIt/WvuHeDXJ3M/ZcE=;
        b=tHd9sOObFNJUzmXpEQCfa6r1fNSMZ/ggOYgfMG9ticMK9TttmiK65KYTUfbg2YmVRp3lb4
        xnQ2ehW/giVcxqohk8kI97hpEfWumH94bOBgji0rHHABNItko1LIfDACLi5kN8pOKyzVOw
        f0YWlMSz6dYEao0aaH905Nkuvh5ixmo=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id B2CF6A3BF1;
        Fri, 25 Jun 2021 07:13:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: add the ability to detect and repair orphan subvolume trees which doesn't have orphan item
Date:   Fri, 25 Jun 2021 15:13:20 +0800
Message-Id: <20210625071322.221780-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625071322.221780-1-wqu@suse.com>
References: <20210625071322.221780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report from the mail list that, after certain
btrfs-zero-log operation, the filesystem has inaccessible subvolumes,
and there is no way to delete them.

Such subvolumes have no ROOT_REF/ROOT_BACKREF, and their root_refs is 0.
Without an orphan item, kernel won't detect them as orphan, thus no
cleanup will happen.

Btrfs check won't report this as a problem either.

Such ghost subvolumes will just waste disk space, and can be pretty hard
to detect without proper btrfs check support.

For the repair part, we just add orphan item so later kernel can handle
it.

Since the check for orphan item and repair can be reused between
original and lowmem mode, move those functions to mode-common.[ch].

Reported-by: Zhenyu Wu <wuzy001@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 check/mode-common.h |  3 +++
 check/mode-lowmem.c | 42 +++++++++++++++++++---------------
 3 files changed, 82 insertions(+), 19 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index cb22f3233c00..d8c18f6603bf 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1243,3 +1243,59 @@ out:
 	btrfs_release_path(&path);
 	return ret;
 }
+
+/*
+ * Check if we have orphan item for @objectid.
+ *
+ * Note: if something wrong happened during search, we consider it as no orphan
+ * item.
+ */
+bool btrfs_has_orphan_item(struct btrfs_root *root, u64 objectid)
+{
+	struct btrfs_path path;
+	struct btrfs_key key;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = BTRFS_ORPHAN_OBJECTID;
+	key.type = BTRFS_ORPHAN_ITEM_KEY;
+	key.offset = objectid;
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
+	btrfs_release_path(&path);
+	if (ret == 0)
+		return true;
+	return false;
+}
+
+int repair_root_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid)
+{
+	struct btrfs_path path;
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	btrfs_init_path(&path);
+
+	trans = btrfs_start_transaction(fs_info->tree_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %m");
+		return ret;
+	}
+	ret = btrfs_add_orphan_item(trans, fs_info->tree_root, &path, rootid);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to insert orphan item: %m");
+		goto error;
+	}
+	btrfs_release_path(&path);
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0)
+		goto error;
+	printf("Inserted orphan root item for root %llu\n", rootid);
+	return ret;
+error:
+	btrfs_release_path(&path);
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index 3ba29ecab6cd..c44815a171ac 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -192,4 +192,7 @@ static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
 			start, start + len);
 }
 
+bool btrfs_has_orphan_item(struct btrfs_root *root, u64 objectid);
+int repair_root_orphan_item(struct btrfs_fs_info *fs_info, u64 rootid);
+
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2f736712bc7f..1ef781ad20bc 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2500,24 +2500,6 @@ out:
 	return ret;
 }
 
-static bool has_orphan_item(struct btrfs_root *root, u64 ino)
-{
-	struct btrfs_path path;
-	struct btrfs_key key;
-	int ret;
-
-	btrfs_init_path(&path);
-	key.objectid = BTRFS_ORPHAN_OBJECTID;
-	key.type = BTRFS_ORPHAN_ITEM_KEY;
-	key.offset = ino;
-
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	btrfs_release_path(&path);
-	if (ret == 0)
-		return true;
-	return false;
-}
-
 static int repair_inode_gen_lowmem(struct btrfs_root *root,
 				   struct btrfs_path *path)
 {
@@ -2622,7 +2604,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 		return err;
 	}
 
-	is_orphan = has_orphan_item(root, inode_id);
+	is_orphan = btrfs_has_orphan_item(root, inode_id);
 	ii = btrfs_item_ptr(node, slot, struct btrfs_inode_item);
 	isize = btrfs_inode_size(node, ii);
 	nbytes = btrfs_inode_nbytes(node, ii);
@@ -5209,6 +5191,28 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 			}
 		}
 	}
+
+	/* Make sure orphan subvolume tree has proper orphan item for it */
+	if (btrfs_root_refs(root_item) == 0 &&
+	    is_fstree(root->root_key.objectid)) {
+		bool is_orphan;
+		is_orphan = btrfs_has_orphan_item(root->fs_info->tree_root,
+						  root->root_key.objectid);
+
+		if (!is_orphan) {
+			error("orphan root %llu doesn't have orphan item",
+			      root->root_key.objectid);
+			if (repair) {
+				ret = repair_root_orphan_item(root->fs_info,
+						root->root_key.objectid);
+				if (!ret)
+					is_orphan = true;
+			}
+			if (!is_orphan)
+				err |= ORPHAN_ITEM;
+		}
+	}
+
 	if (btrfs_root_refs(root_item) > 0 ||
 	    btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		path.nodes[level] = root->node;
-- 
2.32.0

