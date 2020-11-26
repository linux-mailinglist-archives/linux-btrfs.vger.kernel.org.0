Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D492C550B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 14:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbgKZNKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 08:10:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:58882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389873AbgKZNKm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 08:10:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606396241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TdqPEKAs48KIPkBDBPAFIhx4lA1+x1ZTnkkvmeDkHp0=;
        b=kvXafWKiATYFO1xzPTyc4SnYZmmBJDZeiual3AUuv2pSBOSXAus7wmIYrpvxcSOeIsW/Qc
        duxbmxUt9tURV0xYmlLEf8ktN4rqbUMtru6f2GDclGc/ebpnxKb9C3zEhZC7KpjhrWDPmW
        gLceoqQaNsToBv8RLbukQXgU8w3u3EU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D11CAD79;
        Thu, 26 Nov 2020 13:10:41 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Move btrfs_find_highest_objectid/btrfs_find_free_objectid to disk-io.c
Date:   Thu, 26 Nov 2020 15:10:37 +0200
Message-Id: <20201126131039.3441290-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126131039.3441290-1-nborisov@suse.com>
References: <20201126131039.3441290-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Those functions are going to be used even after inode cache is removed
so moved them to a more appropriate place.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h   |  2 ++
 fs/btrfs/inode-map.c | 55 --------------------------------------------
 fs/btrfs/inode-map.h |  2 --
 4 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4940c93c3c93..f97ed0dc179d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4698,3 +4698,58 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 
 	return 0;
 }
+
+int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid)
+{
+	struct btrfs_path *path;
+	int ret;
+	struct extent_buffer *l;
+	struct btrfs_key search_key;
+	struct btrfs_key found_key;
+	int slot;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	search_key.objectid = BTRFS_LAST_FREE_OBJECTID;
+	search_key.type = -1;
+	search_key.offset = (u64)-1;
+	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
+	if (ret < 0)
+		goto error;
+	BUG_ON(ret == 0); /* Corruption */
+	if (path->slots[0] > 0) {
+		slot = path->slots[0] - 1;
+		l = path->nodes[0];
+		btrfs_item_key_to_cpu(l, &found_key, slot);
+		*objectid = max_t(u64, found_key.objectid,
+				  BTRFS_FIRST_FREE_OBJECTID - 1);
+	} else {
+		*objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
+	}
+	ret = 0;
+error:
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid)
+{
+	int ret;
+	mutex_lock(&root->objectid_mutex);
+
+	if (unlikely(root->highest_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
+		btrfs_warn(root->fs_info,
+			   "the objectid of root %llu reaches its highest value",
+			   root->root_key.objectid);
+		ret = -ENOSPC;
+		goto out;
+	}
+
+	*objectid = ++root->highest_objectid;
+	ret = 0;
+out:
+	mutex_unlock(&root->objectid_mutex);
+	return ret;
+}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 40e81d6e481e..984410144a97 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -131,6 +131,8 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
 int btree_lock_page_hook(struct page *page, void *data,
 				void (*flush_fn)(void *));
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
+int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
+int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
 
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 8cf39402b227..2bc342fc5d7e 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -525,58 +525,3 @@ int btrfs_save_ino_cache(struct btrfs_root *root,
 	extent_changeset_free(data_reserved);
 	return ret;
 }
-
-int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid)
-{
-	struct btrfs_path *path;
-	int ret;
-	struct extent_buffer *l;
-	struct btrfs_key search_key;
-	struct btrfs_key found_key;
-	int slot;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	search_key.objectid = BTRFS_LAST_FREE_OBJECTID;
-	search_key.type = -1;
-	search_key.offset = (u64)-1;
-	ret = btrfs_search_slot(NULL, root, &search_key, path, 0, 0);
-	if (ret < 0)
-		goto error;
-	BUG_ON(ret == 0); /* Corruption */
-	if (path->slots[0] > 0) {
-		slot = path->slots[0] - 1;
-		l = path->nodes[0];
-		btrfs_item_key_to_cpu(l, &found_key, slot);
-		*objectid = max_t(u64, found_key.objectid,
-				  BTRFS_FIRST_FREE_OBJECTID - 1);
-	} else {
-		*objectid = BTRFS_FIRST_FREE_OBJECTID - 1;
-	}
-	ret = 0;
-error:
-	btrfs_free_path(path);
-	return ret;
-}
-
-int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid)
-{
-	int ret;
-	mutex_lock(&root->objectid_mutex);
-
-	if (unlikely(root->highest_objectid >= BTRFS_LAST_FREE_OBJECTID)) {
-		btrfs_warn(root->fs_info,
-			   "the objectid of root %llu reaches its highest value",
-			   root->root_key.objectid);
-		ret = -ENOSPC;
-		goto out;
-	}
-
-	*objectid = ++root->highest_objectid;
-	ret = 0;
-out:
-	mutex_unlock(&root->objectid_mutex);
-	return ret;
-}
diff --git a/fs/btrfs/inode-map.h b/fs/btrfs/inode-map.h
index 7a962811dffe..5f6d8b3c65c2 100644
--- a/fs/btrfs/inode-map.h
+++ b/fs/btrfs/inode-map.h
@@ -10,7 +10,5 @@ int btrfs_find_free_ino(struct btrfs_root *root, u64 *objectid);
 int btrfs_save_ino_cache(struct btrfs_root *root,
 			 struct btrfs_trans_handle *trans);
 
-int btrfs_find_free_objectid(struct btrfs_root *root, u64 *objectid);
-int btrfs_find_highest_objectid(struct btrfs_root *root, u64 *objectid);
 
 #endif
-- 
2.25.1

