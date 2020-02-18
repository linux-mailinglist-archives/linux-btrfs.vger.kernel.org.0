Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94421628EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 15:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRO4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 09:56:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:48206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgBRO4N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 09:56:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FBDEC130;
        Tue, 18 Feb 2020 14:56:11 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Call btrfs_check_uuid_tree_entry directly in btrfs_uuid_tree_iterate
Date:   Tue, 18 Feb 2020 16:56:07 +0200
Message-Id: <20200218145609.13427-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218145609.13427-1-nborisov@suse.com>
References: <20200218145609.13427-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_uuid_tree_iterate is called from only once place and its 2nd
argument is always btrfs_check_uuid_tree_entry. Simplify
btrfs_uuid_tree_iterate's signature by removing its 2nd argument and
directly calling btrfs_check_uuid_tree_entry. Also move the latter
into uuid-tree.h. No functional changes.
---
 fs/btrfs/ctree.h     |  4 +---
 fs/btrfs/uuid-tree.c | 50 ++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/volumes.c   | 47 +----------------------------------------
 3 files changed, 48 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bb237d577725..ad275d06e95f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2738,9 +2738,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
-int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
-			    int (*check_func)(struct btrfs_fs_info *, u8 *, u8,
-					      u64));
+int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
 /* dir-item.c */
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 76b84f2397b1..e25776359fad 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -245,10 +245,51 @@ static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 out:
 	return ret;
 }
+/*
+ * returns:
+ * 0	check succeeded, the entry is not outdated.
+ * < 0	if an error occurred.
+ * > 0	if the check failed, which means the caller shall remove the entry.
+ */
+static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
+				       u8 *uuid, u8 type, u64 subid)
+{
+	struct btrfs_key key;
+	int ret = 0;
+	struct btrfs_root *subvol_root;
+
+	if (type != BTRFS_UUID_KEY_SUBVOL &&
+	    type != BTRFS_UUID_KEY_RECEIVED_SUBVOL)
+		goto out;
+
+	key.objectid = subid;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	subvol_root = btrfs_get_fs_root(fs_info, &key, true);
+	if (IS_ERR(subvol_root)) {
+		ret = PTR_ERR(subvol_root);
+		if (ret == -ENOENT)
+			ret = 1;
+		goto out;
+	}
+
+	switch (type) {
+	case BTRFS_UUID_KEY_SUBVOL:
+		if (memcmp(uuid, subvol_root->root_item.uuid, BTRFS_UUID_SIZE))
+			ret = 1;
+		break;
+	case BTRFS_UUID_KEY_RECEIVED_SUBVOL:
+		if (memcmp(uuid, subvol_root->root_item.received_uuid,
+			   BTRFS_UUID_SIZE))
+			ret = 1;
+		break;
+	}
+	btrfs_put_root(subvol_root);
+out:
+	return ret;
+}
 
-int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
-			    int (*check_func)(struct btrfs_fs_info *, u8 *, u8,
-					      u64))
+int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->uuid_root;
 	struct btrfs_key key;
@@ -305,7 +346,8 @@ int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info,
 			read_extent_buffer(leaf, &subid_le, offset,
 					   sizeof(subid_le));
 			subid_cpu = le64_to_cpu(subid_le);
-			ret = check_func(fs_info, uuid, key.type, subid_cpu);
+			ret = btrfs_check_uuid_tree_entry(fs_info, uuid,
+							  key.type, subid_cpu);
 			if (ret < 0)
 				goto out;
 			if (ret > 0) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 387f80656476..fdc0e52542dd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4403,51 +4403,6 @@ static int btrfs_uuid_scan_kthread(void *data)
 	return 0;
 }
 
-/*
- * Callback for btrfs_uuid_tree_iterate().
- * returns:
- * 0	check succeeded, the entry is not outdated.
- * < 0	if an error occurred.
- * > 0	if the check failed, which means the caller shall remove the entry.
- */
-static int btrfs_check_uuid_tree_entry(struct btrfs_fs_info *fs_info,
-				       u8 *uuid, u8 type, u64 subid)
-{
-	struct btrfs_key key;
-	int ret = 0;
-	struct btrfs_root *subvol_root;
-
-	if (type != BTRFS_UUID_KEY_SUBVOL &&
-	    type != BTRFS_UUID_KEY_RECEIVED_SUBVOL)
-		goto out;
-
-	key.objectid = subid;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	key.offset = (u64)-1;
-	subvol_root = btrfs_get_fs_root(fs_info, &key, true);
-	if (IS_ERR(subvol_root)) {
-		ret = PTR_ERR(subvol_root);
-		if (ret == -ENOENT)
-			ret = 1;
-		goto out;
-	}
-
-	switch (type) {
-	case BTRFS_UUID_KEY_SUBVOL:
-		if (memcmp(uuid, subvol_root->root_item.uuid, BTRFS_UUID_SIZE))
-			ret = 1;
-		break;
-	case BTRFS_UUID_KEY_RECEIVED_SUBVOL:
-		if (memcmp(uuid, subvol_root->root_item.received_uuid,
-			   BTRFS_UUID_SIZE))
-			ret = 1;
-		break;
-	}
-	btrfs_put_root(subvol_root);
-out:
-	return ret;
-}
-
 static int btrfs_uuid_rescan_kthread(void *data)
 {
 	struct btrfs_fs_info *fs_info = (struct btrfs_fs_info *)data;
@@ -4458,7 +4413,7 @@ static int btrfs_uuid_rescan_kthread(void *data)
 	 * to delete all entries that contain outdated data.
 	 * 2nd step is to add all missing entries to the UUID tree.
 	 */
-	ret = btrfs_uuid_tree_iterate(fs_info, btrfs_check_uuid_tree_entry);
+	ret = btrfs_uuid_tree_iterate(fs_info);
 	if (ret < 0) {
 		btrfs_warn(fs_info, "iterating uuid_tree failed %d", ret);
 		up(&fs_info->uuid_tree_rescan_sem);
-- 
2.17.1

