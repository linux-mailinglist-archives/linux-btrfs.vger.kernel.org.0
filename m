Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA7F48E1C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiANAvp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:51:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51586 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiANAvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24B721F384
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642121504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NnoAsqpy5B/KDvYpRTzQdvFi4Cqd5dULWYlVhAgpEJE=;
        b=CJuKEKbycO7Fk6H4Tsf2zgJ2tjMJqtSkuP/SN+eso8LEX0QegjBDHq2RVFTfl7736Geazu
        Sm4K1KekiHaHFfdziGjpB/QooGeFx2/IUXjVLD9vuXNQW8cMaWc7oc+PPfl6ts2IAoU4CT
        +zG64xzHSc0Ho+AJ3g1zvgf9WQDSVcQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 606421344A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJLQCR/J4GFWZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/5] btrfs-progs: check: move csum tree population into mode-common.[ch]
Date:   Fri, 14 Jan 2022 08:51:20 +0800
Message-Id: <20220114005123.19426-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114005123.19426-1-wqu@suse.com>
References: <20220114005123.19426-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This part has no mode specific operations, just move them into
mode-common.[ch].

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        | 244 --------------------------------------------
 check/mode-common.c | 244 ++++++++++++++++++++++++++++++++++++++++++++
 check/mode-common.h |   1 +
 3 files changed, 245 insertions(+), 244 deletions(-)

diff --git a/check/main.c b/check/main.c
index 540130b8e223..ea2f2d7b16b8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9557,250 +9557,6 @@ static int zero_log_tree(struct btrfs_root *root)
 	return ret;
 }
 
-static int populate_csum(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *csum_root, char *buf, u64 start,
-			 u64 len)
-{
-	u64 offset = 0;
-	u64 sectorsize;
-	int ret = 0;
-
-	while (offset < len) {
-		sectorsize = gfs_info->sectorsize;
-		ret = read_extent_data(gfs_info, buf, start + offset,
-				       &sectorsize, 0);
-		if (ret)
-			break;
-		ret = btrfs_csum_file_block(trans, start + len, start + offset,
-					    buf, sectorsize);
-		if (ret)
-			break;
-		offset += sectorsize;
-	}
-	return ret;
-}
-
-static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
-					   struct btrfs_root *cur_root)
-{
-	struct btrfs_root *csum_root;
-	struct btrfs_path path;
-	struct btrfs_key key;
-	struct extent_buffer *node;
-	struct btrfs_file_extent_item *fi;
-	char *buf = NULL;
-	u64 start = 0;
-	u64 len = 0;
-	int slot = 0;
-	int ret = 0;
-
-	buf = malloc(gfs_info->sectorsize);
-	if (!buf)
-		return -ENOMEM;
-
-	btrfs_init_path(&path);
-	key.objectid = 0;
-	key.offset = 0;
-	key.type = 0;
-	ret = btrfs_search_slot(NULL, cur_root, &key, &path, 0, 0);
-	if (ret < 0)
-		goto out;
-	/* Iterate all regular file extents and fill its csum */
-	while (1) {
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-
-		if (key.type != BTRFS_EXTENT_DATA_KEY)
-			goto next;
-		node = path.nodes[0];
-		slot = path.slots[0];
-		fi = btrfs_item_ptr(node, slot, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(node, fi) != BTRFS_FILE_EXTENT_REG)
-			goto next;
-		start = btrfs_file_extent_disk_bytenr(node, fi);
-		len = btrfs_file_extent_disk_num_bytes(node, fi);
-
-		csum_root = btrfs_csum_root(gfs_info, start);
-		ret = populate_csum(trans, csum_root, buf, start, len);
-		if (ret == -EEXIST)
-			ret = 0;
-		if (ret < 0)
-			goto out;
-next:
-		/*
-		 * TODO: if next leaf is corrupted, jump to nearest next valid
-		 * leaf.
-		 */
-		ret = btrfs_next_item(cur_root, &path);
-		if (ret < 0)
-			goto out;
-		if (ret > 0) {
-			ret = 0;
-			goto out;
-		}
-	}
-
-out:
-	btrfs_release_path(&path);
-	free(buf);
-	return ret;
-}
-
-static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_path path;
-	struct btrfs_root *tree_root = gfs_info->tree_root;
-	struct btrfs_root *cur_root;
-	struct extent_buffer *node;
-	struct btrfs_key key;
-	int slot = 0;
-	int ret = 0;
-
-	btrfs_init_path(&path);
-	key.objectid = BTRFS_FS_TREE_OBJECTID;
-	key.offset = 0;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-	ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
-	if (ret < 0)
-		goto out;
-	if (ret > 0) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	while (1) {
-		node = path.nodes[0];
-		slot = path.slots[0];
-		btrfs_item_key_to_cpu(node, &key, slot);
-		if (key.objectid > BTRFS_LAST_FREE_OBJECTID)
-			goto out;
-		if (key.type != BTRFS_ROOT_ITEM_KEY)
-			goto next;
-		if (!is_fstree(key.objectid))
-			goto next;
-		key.offset = (u64)-1;
-
-		cur_root = btrfs_read_fs_root(gfs_info, &key);
-		if (IS_ERR(cur_root) || !cur_root) {
-			fprintf(stderr, "Fail to read fs/subvol tree: %lld\n",
-				key.objectid);
-			goto out;
-		}
-		ret = fill_csum_tree_from_one_fs_root(trans, cur_root);
-		if (ret < 0)
-			goto out;
-next:
-		ret = btrfs_next_item(tree_root, &path);
-		if (ret > 0) {
-			ret = 0;
-			goto out;
-		}
-		if (ret < 0)
-			goto out;
-	}
-
-out:
-	btrfs_release_path(&path);
-	return ret;
-}
-
-static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
-				      struct btrfs_root *extent_root)
-{
-	struct btrfs_root *csum_root;
-	struct btrfs_path path;
-	struct btrfs_extent_item *ei;
-	struct extent_buffer *leaf;
-	char *buf;
-	struct btrfs_key key;
-	int ret;
-
-	btrfs_init_path(&path);
-	key.objectid = 0;
-	key.type = BTRFS_EXTENT_ITEM_KEY;
-	key.offset = 0;
-	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
-	if (ret < 0) {
-		btrfs_release_path(&path);
-		return ret;
-	}
-
-	buf = malloc(gfs_info->sectorsize);
-	if (!buf) {
-		btrfs_release_path(&path);
-		return -ENOMEM;
-	}
-
-	while (1) {
-		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-			ret = btrfs_next_leaf(extent_root, &path);
-			if (ret < 0)
-				break;
-			if (ret) {
-				ret = 0;
-				break;
-			}
-		}
-		leaf = path.nodes[0];
-
-		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
-		if (key.type != BTRFS_EXTENT_ITEM_KEY) {
-			path.slots[0]++;
-			continue;
-		}
-
-		ei = btrfs_item_ptr(leaf, path.slots[0],
-				    struct btrfs_extent_item);
-		if (!(btrfs_extent_flags(leaf, ei) &
-		      BTRFS_EXTENT_FLAG_DATA)) {
-			path.slots[0]++;
-			continue;
-		}
-
-		csum_root = btrfs_csum_root(gfs_info, key.objectid);
-		ret = populate_csum(trans, csum_root, buf, key.objectid,
-				    key.offset);
-		if (ret)
-			break;
-		path.slots[0]++;
-	}
-
-	btrfs_release_path(&path);
-	free(buf);
-	return ret;
-}
-
-/*
- * Recalculate the csum and put it into the csum tree.
- *
- * Extent tree init will wipe out all the extent info, so in that case, we
- * can't depend on extent tree, but use fs tree.  If search_fs_tree is set, we
- * will use fs/subvol trees to init the csum tree.
- */
-static int fill_csum_tree(struct btrfs_trans_handle *trans,
-			  int search_fs_tree)
-{
-	struct btrfs_root *root;
-	struct rb_node *n;
-	int ret;
-
-	if (search_fs_tree)
-		return fill_csum_tree_from_fs(trans);
-
-	root = btrfs_extent_root(gfs_info, 0);
-	while (1) {
-		ret = fill_csum_tree_from_extent(trans, root);
-		if (ret)
-			break;
-		n = rb_next(&root->rb_node);
-		if (!n)
-			break;
-		root = rb_entry(n, struct btrfs_root, rb_node);
-		if (root->root_key.objectid != BTRFS_EXTENT_TREE_OBJECTID)
-			break;
-	}
-	return ret;
-}
-
 static void free_roots_info_cache(void)
 {
 	if (!roots_info_cache)
diff --git a/check/mode-common.c b/check/mode-common.c
index 62a9837bde5e..1608dbdafa4c 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1191,3 +1191,247 @@ error:
 	btrfs_abort_transaction(trans, ret);
 	return ret;
 }
+
+static int populate_csum(struct btrfs_trans_handle *trans,
+			 struct btrfs_root *csum_root, char *buf, u64 start,
+			 u64 len)
+{
+	u64 offset = 0;
+	u64 sectorsize;
+	int ret = 0;
+
+	while (offset < len) {
+		sectorsize = gfs_info->sectorsize;
+		ret = read_extent_data(gfs_info, buf, start + offset,
+				       &sectorsize, 0);
+		if (ret)
+			break;
+		ret = btrfs_csum_file_block(trans, start + len, start + offset,
+					    buf, sectorsize);
+		if (ret)
+			break;
+		offset += sectorsize;
+	}
+	return ret;
+}
+
+static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
+					   struct btrfs_root *cur_root)
+{
+	struct btrfs_root *csum_root;
+	struct btrfs_path path;
+	struct btrfs_key key;
+	struct extent_buffer *node;
+	struct btrfs_file_extent_item *fi;
+	char *buf = NULL;
+	u64 start = 0;
+	u64 len = 0;
+	int slot = 0;
+	int ret = 0;
+
+	buf = malloc(gfs_info->sectorsize);
+	if (!buf)
+		return -ENOMEM;
+
+	btrfs_init_path(&path);
+	key.objectid = 0;
+	key.offset = 0;
+	key.type = 0;
+	ret = btrfs_search_slot(NULL, cur_root, &key, &path, 0, 0);
+	if (ret < 0)
+		goto out;
+	/* Iterate all regular file extents and fill its csum */
+	while (1) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+
+		if (key.type != BTRFS_EXTENT_DATA_KEY)
+			goto next;
+		node = path.nodes[0];
+		slot = path.slots[0];
+		fi = btrfs_item_ptr(node, slot, struct btrfs_file_extent_item);
+		if (btrfs_file_extent_type(node, fi) != BTRFS_FILE_EXTENT_REG)
+			goto next;
+		start = btrfs_file_extent_disk_bytenr(node, fi);
+		len = btrfs_file_extent_disk_num_bytes(node, fi);
+
+		csum_root = btrfs_csum_root(gfs_info, start);
+		ret = populate_csum(trans, csum_root, buf, start, len);
+		if (ret == -EEXIST)
+			ret = 0;
+		if (ret < 0)
+			goto out;
+next:
+		/*
+		 * TODO: if next leaf is corrupted, jump to nearest next valid
+		 * leaf.
+		 */
+		ret = btrfs_next_item(cur_root, &path);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
+
+out:
+	btrfs_release_path(&path);
+	free(buf);
+	return ret;
+}
+
+static int fill_csum_tree_from_fs(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_path path;
+	struct btrfs_root *tree_root = gfs_info->tree_root;
+	struct btrfs_root *cur_root;
+	struct extent_buffer *node;
+	struct btrfs_key key;
+	int slot = 0;
+	int ret = 0;
+
+	btrfs_init_path(&path);
+	key.objectid = BTRFS_FS_TREE_OBJECTID;
+	key.offset = 0;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	while (1) {
+		node = path.nodes[0];
+		slot = path.slots[0];
+		btrfs_item_key_to_cpu(node, &key, slot);
+		if (key.objectid > BTRFS_LAST_FREE_OBJECTID)
+			goto out;
+		if (key.type != BTRFS_ROOT_ITEM_KEY)
+			goto next;
+		if (!is_fstree(key.objectid))
+			goto next;
+		key.offset = (u64)-1;
+
+		cur_root = btrfs_read_fs_root(gfs_info, &key);
+		if (IS_ERR(cur_root) || !cur_root) {
+			fprintf(stderr, "Fail to read fs/subvol tree: %lld\n",
+				key.objectid);
+			goto out;
+		}
+		ret = fill_csum_tree_from_one_fs_root(trans, cur_root);
+		if (ret < 0)
+			goto out;
+next:
+		ret = btrfs_next_item(tree_root, &path);
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
+				      struct btrfs_root *extent_root)
+{
+	struct btrfs_root *csum_root;
+	struct btrfs_path path;
+	struct btrfs_extent_item *ei;
+	struct extent_buffer *leaf;
+	char *buf;
+	struct btrfs_key key;
+	int ret;
+
+	btrfs_init_path(&path);
+	key.objectid = 0;
+	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		btrfs_release_path(&path);
+		return ret;
+	}
+
+	buf = malloc(gfs_info->sectorsize);
+	if (!buf) {
+		btrfs_release_path(&path);
+		return -ENOMEM;
+	}
+
+	while (1) {
+		if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
+			ret = btrfs_next_leaf(extent_root, &path);
+			if (ret < 0)
+				break;
+			if (ret) {
+				ret = 0;
+				break;
+			}
+		}
+		leaf = path.nodes[0];
+
+		btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
+		if (key.type != BTRFS_EXTENT_ITEM_KEY) {
+			path.slots[0]++;
+			continue;
+		}
+
+		ei = btrfs_item_ptr(leaf, path.slots[0],
+				    struct btrfs_extent_item);
+		if (!(btrfs_extent_flags(leaf, ei) &
+		      BTRFS_EXTENT_FLAG_DATA)) {
+			path.slots[0]++;
+			continue;
+		}
+
+		csum_root = btrfs_csum_root(gfs_info, key.objectid);
+		ret = populate_csum(trans, csum_root, buf, key.objectid,
+				    key.offset);
+		if (ret)
+			break;
+		path.slots[0]++;
+	}
+
+	btrfs_release_path(&path);
+	free(buf);
+	return ret;
+}
+
+/*
+ * Recalculate the csum and put it into the csum tree.
+ *
+ * @search_fs_tree:	How to get the data extent item.
+ *			If true, iterate all fs roots to get all
+ *			extent data (which can be slow).
+ *			Otherwise, search extent tree for extent data.
+ */
+int fill_csum_tree(struct btrfs_trans_handle *trans, bool search_fs_tree)
+{
+	struct btrfs_root *root;
+	struct rb_node *n;
+	int ret;
+
+	if (search_fs_tree)
+		return fill_csum_tree_from_fs(trans);
+
+	root = btrfs_extent_root(gfs_info, 0);
+	while (1) {
+		ret = fill_csum_tree_from_extent(trans, root);
+		if (ret)
+			break;
+		n = rb_next(&root->rb_node);
+		if (!n)
+			break;
+		root = rb_entry(n, struct btrfs_root, rb_node);
+		if (root->root_key.objectid != BTRFS_EXTENT_TREE_OBJECTID)
+			break;
+	}
+	return ret;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index 8cd135b9bfc2..b894c2be4f97 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -199,4 +199,5 @@ static inline void btrfs_check_subpage_eb_alignment(struct btrfs_fs_info *info,
 int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
 			       u64 devid, u64 bytes_used_expected);
 
+int fill_csum_tree(struct btrfs_trans_handle *trans, bool search_fs_tree);
 #endif
-- 
2.34.1

