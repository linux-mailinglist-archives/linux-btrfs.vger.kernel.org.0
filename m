Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE2573447
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiGMKah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 06:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiGMKaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 06:30:35 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC36FB8FD
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 03:30:34 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id E59C780025;
        Wed, 13 Jul 2022 06:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1657708234; bh=m5CcoZNkpurW6kdU2fMVc2AJQxvalyUaUOixOrowN6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L5lZwnOoMh6gNQUXQkhHchIgUZkFDlyedBEKPR2xaiSW91zC82++1rYb9hOJDdGLW
         7yicBd1s1nbV0EXa+KISbv5dRDrOPazR+RUatM9yWT2p3NG8c63QMXjpRiY7j9jT5m
         PB74xMI2RdUHXfONfweVRM3R7a/rmb5BtjWB2FoEWtpARRc1V5MHf3rUddYKrzVyPQ
         3PnCw80psb0fvsEkJ/azzznfigIFs2yEYMJgb1edVKso+fMZR7JM4e5DzLoHSxZzCF
         ISOOdwtrvtYEN0MO7NJP66wMZk4XzJg+iyXUojfAZ8WVmpw6XpFvyxTE22u8ZUuRqz
         vGZt+d4Tdo0lQ==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [RFC ONLY 02/23] btrfs: rename dir_item's dir_type field to dir_flags
Date:   Wed, 13 Jul 2022 06:29:35 -0400
Message-Id: <932c0b60f3a243d869636cc5782f18d1bf39f267.1657707686.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1657707686.git.sweettea-kernel@dorminy.me>
References: <cover.1657707686.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

The encryption status of the directory is orthogonal to the existing
directory types, and there is no room in other fields. Therefore,
rename the dir_type field to dir_flags to reflect its new usage.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/ctree.h                | 10 ++++++++--
 fs/btrfs/delayed-inode.c        |  6 +++---
 fs/btrfs/delayed-inode.h        |  2 +-
 fs/btrfs/dir-item.c             |  4 ++--
 fs/btrfs/inode.c                | 15 +++++++++------
 fs/btrfs/print-tree.c           |  4 ++--
 fs/btrfs/send.c                 |  2 +-
 fs/btrfs/tree-checker.c         |  2 +-
 fs/btrfs/tree-log.c             | 18 +++++++++---------
 include/uapi/linux/btrfs_tree.h |  5 +++++
 10 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4c351b96115b..538a1f357e59 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2105,10 +2105,10 @@ BTRFS_SETGET_FUNCS(root_ref_name_len, struct btrfs_root_ref, name_len, 16);
 
 /* struct btrfs_dir_item */
 BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
-BTRFS_SETGET_FUNCS(dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_FUNCS(dir_flags, struct btrfs_dir_item, type, 8);
 BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
 BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_flags, struct btrfs_dir_item, type, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item,
 			 data_len, 16);
 BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item,
@@ -2116,6 +2116,12 @@ BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item,
 BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item,
 			 transid, 64);
 
+static inline u8 btrfs_dir_ftype(const struct extent_buffer *eb,
+				 const struct btrfs_dir_item *item)
+{
+	return btrfs_dir_flags_to_ftype(btrfs_dir_flags(eb, item));
+}
+
 static inline void btrfs_dir_item_key(const struct extent_buffer *eb,
 				      const struct btrfs_dir_item *item,
 				      struct btrfs_disk_key *key)
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index ad4fa8c173fa..ef4655c6a92a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1403,7 +1403,7 @@ void btrfs_balance_delayed_items(struct btrfs_fs_info *fs_info)
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
 				   struct btrfs_inode *dir,
-				   struct btrfs_disk_key *disk_key, u8 type,
+				   struct btrfs_disk_key *disk_key, u8 flags,
 				   u64 index)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -1435,7 +1435,7 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_dir_transid(dir_item, trans->transid);
 	btrfs_set_stack_dir_data_len(dir_item, 0);
 	btrfs_set_stack_dir_name_len(dir_item, name_len);
-	btrfs_set_stack_dir_type(dir_item, type);
+	btrfs_set_stack_dir_flags(dir_item, flags);
 	memcpy((char *)(dir_item + 1), name, name_len);
 
 	data_len = delayed_item->data_len + sizeof(struct btrfs_item);
@@ -1753,7 +1753,7 @@ int btrfs_readdir_delayed_dir_index(struct dir_context *ctx,
 		name = (char *)(di + 1);
 		name_len = btrfs_stack_dir_name_len(di);
 
-		d_type = fs_ftype_to_dtype(di->type);
+		d_type = fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di->type));
 		btrfs_disk_key_to_cpu(&location, &di->location);
 
 		over = !dir_emit(ctx, name, name_len,
diff --git a/fs/btrfs/delayed-inode.h b/fs/btrfs/delayed-inode.h
index 9795dc295a18..c565f15e7af5 100644
--- a/fs/btrfs/delayed-inode.h
+++ b/fs/btrfs/delayed-inode.h
@@ -99,7 +99,7 @@ static inline void btrfs_init_delayed_root(
 int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 				   const char *name, int name_len,
 				   struct btrfs_inode *dir,
-				   struct btrfs_disk_key *disk_key, u8 type,
+				   struct btrfs_disk_key *disk_key, u8 flags,
 				   u64 index);
 
 int btrfs_delete_delayed_dir_index(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 72fb2c518a2b..e37b075afa96 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -81,7 +81,7 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, &location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, BTRFS_FT_XATTR);
+	btrfs_set_dir_flags(leaf, dir_item, BTRFS_FT_XATTR);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
 	btrfs_set_dir_data_len(leaf, dir_item, data_len);
@@ -140,7 +140,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	leaf = path->nodes[0];
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, type);
+	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	btrfs_set_dir_transid(leaf, dir_item, trans->transid);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2a9e6675c77e..057744b8815c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5571,7 +5571,7 @@ static int btrfs_inode_by_name(struct inode *dir, struct dentry *dentry,
 			   location->objectid, location->type, location->offset);
 	}
 	if (!ret)
-		*type = btrfs_dir_type(path->nodes[0], di);
+		*type = btrfs_dir_ftype(path->nodes[0], di);
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -6009,6 +6009,7 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 	btrfs_for_each_slot(root, &key, &found_key, path, ret) {
 		struct dir_entry *entry;
 		struct extent_buffer *leaf = path->nodes[0];
+		u8 di_flags;
 
 		if (found_key.objectid != key.objectid)
 			break;
@@ -6032,13 +6033,15 @@ static int btrfs_real_readdir(struct file *file, struct dir_context *ctx)
 			goto again;
 		}
 
+		di_flags = btrfs_dir_flags(leaf, di);
 		entry = addr;
-		put_unaligned(name_len, &entry->name_len);
 		name_ptr = (char *)(entry + 1);
-		read_extent_buffer(leaf, name_ptr, (unsigned long)(di + 1),
-				   name_len);
-		put_unaligned(fs_ftype_to_dtype(btrfs_dir_type(leaf, di)),
-				&entry->type);
+		read_extent_buffer(leaf, name_ptr,
+				   (unsigned long)(di + 1), name_len);
+		put_unaligned(name_len, &entry->name_len);
+		put_unaligned(
+			fs_ftype_to_dtype(btrfs_dir_flags_to_ftype(di_flags)),
+			&entry->type);
 		btrfs_dir_item_key_to_cpu(leaf, di, &location);
 		put_unaligned(location.objectid, &entry->ino);
 		put_unaligned(found_key.offset, &entry->offset);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index dd8777872143..6d9d99bf3536 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -240,9 +240,9 @@ void btrfs_print_leaf(struct extent_buffer *l)
 		case BTRFS_DIR_ITEM_KEY:
 			di = btrfs_item_ptr(l, i, struct btrfs_dir_item);
 			btrfs_dir_item_key_to_cpu(l, di, &found_key);
-			pr_info("\t\tdir oid %llu type %u\n",
+			pr_info("\t\tdir oid %llu flags %u\n",
 				found_key.objectid,
-				btrfs_dir_type(l, di));
+				btrfs_dir_flags(l, di));
 			break;
 		case BTRFS_ROOT_ITEM_KEY:
 			ri = btrfs_item_ptr(l, i, struct btrfs_root_item);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7def51462f6b..21e25c445fc9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1075,7 +1075,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
 		data_len = btrfs_dir_data_len(eb, di);
 		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
 
-		if (btrfs_dir_type(eb, di) == BTRFS_FT_XATTR) {
+		if (btrfs_dir_ftype(eb, di) == BTRFS_FT_XATTR) {
 			if (name_len > XATTR_NAME_MAX) {
 				ret = -ENAMETOOLONG;
 				goto out;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9e0e0ae2288c..dd3218c2ca51 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -528,7 +528,7 @@ static int check_dir_item(struct extent_buffer *leaf,
 		}
 
 		/* dir type check */
-		dir_type = btrfs_dir_type(leaf, di);
+		dir_type = btrfs_dir_ftype(leaf, di);
 		if (unlikely(dir_type >= BTRFS_FT_MAX)) {
 			dir_item_err(leaf, slot,
 			"invalid dir item type, have %u expect [0, %u)",
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fa923a9e79c4..87a4438b90da 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1947,7 +1947,7 @@ static int delete_conflicting_dir_entry(struct btrfs_trans_handle *trans,
 					struct btrfs_path *path,
 					struct btrfs_dir_item *dst_di,
 					const struct btrfs_key *log_key,
-					u8 log_type,
+					u8 log_flags,
 					bool exists)
 {
 	struct btrfs_key found_key;
@@ -1957,7 +1957,7 @@ static int delete_conflicting_dir_entry(struct btrfs_trans_handle *trans,
 	if (found_key.objectid == log_key->objectid &&
 	    found_key.type == log_key->type &&
 	    found_key.offset == log_key->offset &&
-	    btrfs_dir_type(path->nodes[0], dst_di) == log_type)
+	    btrfs_dir_flags(path->nodes[0], dst_di) == log_flags)
 		return 1;
 
 	/*
@@ -2002,7 +2002,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	struct btrfs_key log_key;
 	struct btrfs_key search_key;
 	struct inode *dir;
-	u8 log_type;
+	u8 log_flags;
 	bool exists;
 	int ret;
 	bool update_size = true;
@@ -2019,7 +2019,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	log_type = btrfs_dir_type(eb, di);
+	log_flags = btrfs_dir_flags(eb, di);
 	read_extent_buffer(eb, name, (unsigned long)(di + 1),
 		   name_len);
 
@@ -2038,8 +2038,8 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 		goto out;
 	} else if (dir_dst_di) {
 		ret = delete_conflicting_dir_entry(trans, BTRFS_I(dir), path,
-						   dir_dst_di, &log_key, log_type,
-						   exists);
+						   dir_dst_di, &log_key,
+						   log_flags, exists);
 		if (ret < 0)
 			goto out;
 		dir_dst_matches = (ret == 1);
@@ -2056,7 +2056,7 @@ static noinline int replay_one_name(struct btrfs_trans_handle *trans,
 	} else if (index_dst_di) {
 		ret = delete_conflicting_dir_entry(trans, BTRFS_I(dir), path,
 						   index_dst_di, &log_key,
-						   log_type, exists);
+						   log_flags, exists);
 		if (ret < 0)
 			goto out;
 		index_dst_matches = (ret == 1);
@@ -2166,7 +2166,7 @@ static noinline int replay_one_dir_item(struct btrfs_trans_handle *trans,
 	 * to ever delete the parent directory has it would result in stale
 	 * dentries that can never be deleted.
 	 */
-	if (ret == 1 && btrfs_dir_type(eb, di) != BTRFS_FT_DIR) {
+	if (ret == 1 && btrfs_dir_ftype(eb, di) != BTRFS_FT_DIR) {
 		struct btrfs_path *fixup_path;
 		struct btrfs_key di_key;
 
@@ -6181,7 +6181,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 				goto next_dir_inode;
 
 			di = btrfs_item_ptr(leaf, i, struct btrfs_dir_item);
-			type = btrfs_dir_type(leaf, di);
+			type = btrfs_dir_ftype(leaf, di);
 			if (btrfs_dir_transid(leaf, di) < trans->transid)
 				continue;
 			btrfs_dir_item_key_to_cpu(leaf, di, &di_key);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d4117152d907..15b3f2d43f6c 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -360,6 +360,11 @@ enum btrfs_csum_type {
 #define BTRFS_FT_XATTR		8
 #define BTRFS_FT_MAX		9
 
+static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
+{
+	return flags;
+}
+
 /*
  * The key defines the order in the tree, and so it also defines (optimal)
  * block layout.
-- 
2.35.1

