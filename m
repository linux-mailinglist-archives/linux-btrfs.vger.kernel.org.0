Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87DC57077DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 04:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjERCLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 22:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjERCLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 22:11:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050630F5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 19:11:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32201226B2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684375865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kj10L6DXTY8zk0e7VQnJgHuxkoMEZL2sXdchSamom+E=;
        b=pfXn3ukL56bzS2zDLi0NM4YFSf885ZtKr/bma73cTM2RUb3EZAonazE6uJLPuPQ3pJHLkI
        VWgkHUB5ig9dOToFTPd71txv08ofoOfSvyu5UmVS6RRxwjPYFN0LgXIPujxeSTTbndx7Ud
        NpgPGhY0jQzsyJj/fdaoCxsVjRCmrAU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 508561332D
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OFbUBjiJZWRVJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/7] btrfs-progs: tune: rework the main idea of csum change
Date:   Thu, 18 May 2023 10:10:39 +0800
Message-Id: <800ec0b5107b26309517bd9890275b61a9d15bb1.1684375729.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684375729.git.wqu@suse.com>
References: <cover.1684375729.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The existing attempt for changing csum types is as the following:

- Create a new temporary csum root
- Generate new data csums into the temporary csum root
- Drop the old csum tree and make the temporary one as csum root
- Change the checksums for metadata in-place

Unfortunately after some experiments, the csum root switch method has a
big pitfall, the backref items in extent tree.

Those backref items still point back to the old tree, meaning without a
lot of extra tricks, the extent tree would be corrupted.

Thus we have to go a new single tree variant:

- Generate new data csums into the csum root
  The new data csums would have a different objectid to distinguish
  them.
- Drop the old data csum items
- Change the key objectids of the new csums
- Change the checksums for metadata in-place

This means unfortunately we have to revert most of the old code, and
update the temporary item format.

The new temporary item would only record the target csum type.
At every stage we have a method to determine the progress, thus no need
for an item, but in the future it's still open for change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c           |   3 -
 kernel-shared/ctree.h           |  19 +-
 kernel-shared/disk-io.c         |   8 -
 kernel-shared/file-item.c       |  12 -
 kernel-shared/print-tree.c      |  11 +-
 kernel-shared/uapi/btrfs_tree.h |   1 +
 tune/change-csum.c              | 518 ++------------------------------
 tune/main.c                     |   2 +-
 tune/tune.h                     |   3 +-
 9 files changed, 34 insertions(+), 543 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 782bc6cc80c1..bcf16271d864 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -403,9 +403,6 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 		fs_info->block_group_root = new_root;
 		break;
 
-	case BTRFS_CSUM_TREE_TMP_OBJECTID:
-		fs_info->csum_tree_tmp = new_root;
-		break;
 	/*
 	 * Essential trees can't be created by this function, yet.
 	 * As we expect such skeleton exists, or a lot of functions like
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 3b7d98bff469..5d3392ae82a6 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -56,9 +56,8 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 		sizeof(struct btrfs_stripe) * (num_stripes - 1);
 }
 
-/* Temporary flag not on-disk for blocks that have changed csum already */
-#define BTRFS_HEADER_FLAG_CSUM_NEW		(1ULL << 16)
-#define BTRFS_SUPER_FLAG_CHANGING_CSUM		(1ULL << 37)
+#define BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM	(1ULL << 36)
+#define BTRFS_SUPER_FLAG_CHANGING_META_CSUM	(1ULL << 37)
 
 /*
  * The fs is undergoing block group tree feature change.
@@ -306,9 +305,6 @@ struct btrfs_fs_info {
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
-	/* When switching csums */
-	struct btrfs_root *csum_tree_tmp;
-
 	struct cache_tree extent_cache;
 	u64 max_cache_size;
 	u64 cache_size;
@@ -365,7 +361,6 @@ struct btrfs_fs_info {
 	unsigned int skip_leaf_item_checks:1;
 
 	int transaction_aborted;
-	int force_csum_type;
 
 	int (*free_extent_hook)(u64 bytenr, u64 num_bytes, u64 parent,
 				u64 root_objectid, u64 owner, u64 offset,
@@ -670,17 +665,11 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  * - balance status item (objectid -4)
  *   (BTRFS_BALANCE_OBJECTID, BTRFS_TEMPORARY_ITEM_KEY, 0)
  *
- * - second csum tree for conversion (objecitd
+ * - second csum tree for conversion (objecitd -13)
+ *   (BTRFS_CSUM_CHANGE_OBJECTID, BTRFS_TEMPORARY_ITEM_KEY, <target csum type>)
  */
 #define BTRFS_TEMPORARY_ITEM_KEY	248
 
-/*
- * Temporary value
- *
- * root tree pointer of checksum tree with new checksum type
- */
-#define BTRFS_CSUM_TREE_TMP_OBJECTID	13ULL
-
 /*
  * Obsolete name, see BTRFS_PERSISTENT_ITEM_KEY
  */
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 5cbfcdd8452c..442d3af8bc01 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -215,12 +215,6 @@ static int csum_tree_block(struct btrfs_fs_info *fs_info,
 	u16 csum_size = fs_info->csum_size;
 	u16 csum_type = fs_info->csum_type;
 
-	if (fs_info->force_csum_type != -1) {
-		/* printf("CSUM TREE: offset %llu\n", buf->start); */
-		csum_type = fs_info->force_csum_type;
-		csum_size = btrfs_csum_type_size(csum_type);
-	}
-
 	if (verify && fs_info->suppress_check_block_errors)
 		return verify_tree_block_csum_silent(buf, csum_size, csum_type);
 	return csum_tree_block_size(buf, csum_size, verify, csum_type);
@@ -475,7 +469,6 @@ int write_tree_block(struct btrfs_trans_handle *trans,
 	if (trans && !btrfs_buffer_uptodate(eb, trans->transid, 0))
 		BUG();
 
-	btrfs_clear_header_flag(eb, BTRFS_HEADER_FLAG_CSUM_NEW);
 	btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
 	csum_tree_block(fs_info, eb, 0);
 
@@ -885,7 +878,6 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	fs_info->metadata_alloc_profile = (u64)-1;
 	fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
 	fs_info->nr_global_roots = 1;
-	fs_info->force_csum_type = -1;
 
 	return fs_info;
 
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index b372cc5eab54..9b59a4b7a9ae 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -142,7 +142,6 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 	struct btrfs_csum_item *item;
 	struct extent_buffer *leaf;
 	u64 csum_offset = 0;
-	u16 csum_type = root->fs_info->csum_type;
 	u16 csum_size = root->fs_info->csum_size;
 	int csums_in_item;
 
@@ -154,11 +153,6 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 		goto fail;
 	leaf = path->nodes[0];
 
-	if (leaf->fs_info->force_csum_type != -1) {
-		csum_type = root->fs_info->force_csum_type;
-		csum_size = btrfs_csum_type_size(csum_type);
-	}
-
 	if (ret > 0) {
 		ret = 1;
 		if (path->slots[0] == 0)
@@ -208,12 +202,6 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	u16 csum_size = root->fs_info->csum_size;
 	u16 csum_type = root->fs_info->csum_type;
 
-	if (root->fs_info->force_csum_type != -1) {
-		/* printf("CSUM DATA: offset %llu (%d -> %d)\n", bytenr, csum_type, root->fs_info->force_csum_type); */
-		csum_type = root->fs_info->force_csum_type;
-		csum_size = btrfs_csum_type_size(csum_type);
-	}
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 2cfd6b950ec5..aaaf58ae2e0f 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -790,6 +790,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
 		fprintf(stream, "BLOCK_GROUP_TREE");
 		break;
+	case BTRFS_CSUM_CHANGE_OBJECTID:
+		fprintf(stream, "CSUM_CHANGE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
@@ -1142,8 +1145,12 @@ static void print_temporary_item(struct extent_buffer *eb, void *ptr,
 	case BTRFS_BALANCE_OBJECTID:
 		print_balance_item(eb, ptr);
 		break;
-	case BTRFS_CSUM_TREE_TMP_OBJECTID:
-		printf("\t\tcsum tree tmp root %llu\n", offset);
+	case BTRFS_CSUM_CHANGE_OBJECTID:
+		if (offset < btrfs_get_num_csums())
+			printf("\t\ttarget csum type %s (%llu)\n",
+			       btrfs_super_csum_name(offset) ,offset);
+		else
+			printf("\t\tunknown csum type %llu\n", offset);
 		break;
 	default:
 		printf("\t\tunknown temporary item objectid %llu\n", objectid);
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index 5b9f71ab15de..ad555e7055ab 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -106,6 +106,7 @@
  */
 #define BTRFS_FREE_INO_OBJECTID -12ULL
 
+#define BTRFS_CSUM_CHANGE_OBJECTID -13ULL
 /* dummy objectid represents multiple objectids */
 #define BTRFS_MULTIPLE_OBJECTIDS -255ULL
 
diff --git a/tune/change-csum.c b/tune/change-csum.c
index 4531f2190f06..7a9f6351e7fe 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -26,510 +26,28 @@
 #include "common/internal.h"
 #include "tune/tune.h"
 
-static int change_tree_csum(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-			    int csum_type)
+int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_path path;
-	struct btrfs_key key = {0, 0, 0};
-	int ret = 0;
-	int level;
-
-	btrfs_init_path(&path);
-	/* No transaction, all in-place */
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		level = 1;
-		while (path.nodes[level]) {
-			/* Caching can make double writes */
-			if (!btrfs_header_flag(path.nodes[level], BTRFS_HEADER_FLAG_CSUM_NEW)) {
-				ret = write_tree_block(NULL, fs_info, path.nodes[level]);
-				if (ret < 0)
-					goto out;
-				btrfs_set_header_flag(path.nodes[level],
-						BTRFS_HEADER_FLAG_CSUM_NEW);
-			}
-			level++;
-		}
-		ret = write_tree_block(NULL, fs_info, path.nodes[0]);
-		if (ret < 0)
-			goto out;
-		ret = btrfs_next_leaf(root, &path);
-		if (ret < 0)
-			goto out;
-		if (ret > 0) {
-			ret = 0;
-			goto out;
-		}
-	}
-out:
-	btrfs_release_path(&path);
-	return ret;
-}
-
-static struct btrfs_csum_item *lookup_tmp_csum(struct btrfs_trans_handle *trans,
-		  struct btrfs_path *path, u64 bytenr, int cow)
-{
-	int ret;
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_root *csum_root = fs_info->csum_tree_tmp;
-	struct btrfs_key file_key;
-	struct btrfs_key found_key;
-	struct btrfs_csum_item *item;
-	struct extent_buffer *leaf;
-	u64 csum_offset = 0;
-	u16 csum_type = fs_info->csum_type;
-	u16 csum_size = fs_info->csum_size;
-	int csums_in_item;
-
-	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	file_key.offset = bytenr;
-	file_key.type = BTRFS_EXTENT_CSUM_KEY;
-	ret = btrfs_search_slot(trans, csum_root, &file_key, path, 0, cow);
-	if (ret < 0)
-		goto fail;
-	leaf = path->nodes[0];
-
-	if (leaf->fs_info->force_csum_type != -1) {
-		csum_type = fs_info->force_csum_type;
-		csum_size = btrfs_csum_type_size(csum_type);
-	}
-
-	if (ret > 0) {
-		ret = 1;
-		if (path->slots[0] == 0)
-			goto fail;
-		path->slots[0]--;
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-		if (found_key.type != BTRFS_EXTENT_CSUM_KEY)
-			goto fail;
-
-		csum_offset = (bytenr - found_key.offset) / fs_info->sectorsize;
-		csums_in_item = btrfs_item_size(leaf, path->slots[0]);
-		csums_in_item /= csum_size;
-
-		if (csum_offset >= csums_in_item) {
-			ret = -EFBIG;
-			goto fail;
-		}
-	}
-	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
-	item = (struct btrfs_csum_item *)((unsigned char *)item +
-					  csum_offset * csum_size);
-	return item;
-fail:
-	if (ret > 0)
-		ret = -ENOENT;
-	return ERR_PTR(ret);
-}
-
-#define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
-			       sizeof(struct btrfs_item) * 2) / \
-			       size) - 1))
-
-static int csum_file_block(struct btrfs_trans_handle *trans,
-			   struct btrfs_fs_info *fs_info,
-			   u64 alloc_end, u64 bytenr, char *data, size_t len)
-{
-	struct btrfs_root *csum_root = fs_info->csum_tree_tmp;
-	int ret = 0;
-	struct btrfs_key file_key;
-	struct btrfs_key found_key;
-	u64 next_offset = (u64)-1;
-	int found_next = 0;
-	struct btrfs_path *path;
-	struct btrfs_csum_item *item;
-	struct extent_buffer *leaf = NULL;
-	u64 csum_offset;
-	u8 csum_result[BTRFS_CSUM_SIZE];
-	u32 sectorsize = fs_info->sectorsize;
-	u32 nritems;
-	u32 ins_size;
-	u16 csum_size;
-	u16 csum_type;
-
-	if (fs_info->force_csum_type != -1)
-		return -EINVAL;
-
-	csum_type = fs_info->force_csum_type;
-	csum_size = btrfs_csum_type_size(csum_type);
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
-	file_key.type = BTRFS_EXTENT_CSUM_KEY;
-	file_key.offset = bytenr;
-
-	item = lookup_tmp_csum(trans, path, bytenr, 1);
-	if (!IS_ERR(item)) {
-		leaf = path->nodes[0];
-		ret = 0;
-		goto found;
-	}
-	ret = PTR_ERR(item);
-	if (ret == -EFBIG) {
-		u32 item_size;
-
-		/* We found one, but it isn't big enough yet */
-		leaf = path->nodes[0];
-		item_size = btrfs_item_size(leaf, path->slots[0]);
-		if ((item_size / csum_size) >= MAX_CSUM_ITEMS(csum_root, csum_size)) {
-			/* Already at max size, make a new one */
-			goto insert;
-		}
-	} else {
-		int slot = path->slots[0] + 1;
-
-		/* We didn't find a csum item, insert one */
-		nritems = btrfs_header_nritems(path->nodes[0]);
-		if (path->slots[0] >= nritems - 1) {
-			ret = btrfs_next_leaf(csum_root, path);
-			if (ret == 1)
-				found_next = 1;
-			if (ret != 0)
-				goto insert;
-			slot = 0;
-		}
-		btrfs_item_key_to_cpu(path->nodes[0], &found_key, slot);
-		if (found_key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
-		    found_key.type != BTRFS_EXTENT_CSUM_KEY) {
-			found_next = 1;
-			goto insert;
-		}
-		next_offset = found_key.offset;
-		found_next = 1;
-		goto insert;
-	}
+	/* Phase 0, check conflicting features. */
 
 	/*
-	 * At this point, we know the tree has an item, but it isn't big
-	 * enough yet to put our csum in.  Grow it.
+	 * Phase 1, generate new data csums.
+	 *
+	 * The new data csums would have a different key objectid, and there
+	 * will be a temporary item in root tree to indicate the new checksum
+	 * algo.
 	 */
-	btrfs_release_path(path);
-	ret = btrfs_search_slot(trans, csum_root, &file_key, path, csum_size, 1);
-	if (ret < 0)
-		goto fail;
-	if (ret == 0)
-		BUG();
-	if (path->slots[0] == 0)
-		goto insert;
-	path->slots[0]--;
-	leaf = path->nodes[0];
-	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-	csum_offset = (file_key.offset - found_key.offset) / sectorsize;
-	if (found_key.objectid != BTRFS_EXTENT_CSUM_OBJECTID ||
-	    found_key.type != BTRFS_EXTENT_CSUM_KEY ||
-	    csum_offset >= MAX_CSUM_ITEMS(csum_root, csum_size)) {
-		goto insert;
-	}
-	if (csum_offset >= btrfs_item_size(leaf, path->slots[0]) / csum_size) {
-		u32 diff = (csum_offset + 1) * csum_size;
 
-		diff = diff - btrfs_item_size(leaf, path->slots[0]);
-		if (diff != csum_size)
-			goto insert;
-		ret = btrfs_extend_item(csum_root, path, diff);
-		BUG_ON(ret);
-		goto csum;
-	}
+	/* Phase 2, delete the old data csums. */
 
-insert:
-	btrfs_release_path(path);
-	csum_offset = 0;
-	if (found_next) {
-		u64 tmp = min(alloc_end, next_offset);
-		tmp -= file_key.offset;
-		tmp /= sectorsize;
-		tmp = max((u64)1, tmp);
-		tmp = min(tmp, (u64)MAX_CSUM_ITEMS(csum_root, csum_size));
-		ins_size = csum_size * tmp;
-	} else {
-		ins_size = csum_size;
-	}
-	ret = btrfs_insert_empty_item(trans, csum_root, path, &file_key, ins_size);
-	if (ret < 0)
-		goto fail;
-	if (ret != 0) {
-		WARN_ON(1);
-		goto fail;
-	}
-csum:
-	leaf = path->nodes[0];
-	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
-	ret = 0;
-	item = (struct btrfs_csum_item *)((unsigned char *)item +
-					  csum_offset * csum_size);
-found:
-	btrfs_csum_data(fs_info, csum_type, (u8 *)data, csum_result, len);
-	write_extent_buffer(leaf, csum_result, (unsigned long)item, csum_size);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
-fail:
-	btrfs_free_path(path);
-	return ret;
-}
-
-static int populate_csum(struct btrfs_trans_handle *trans,
-			 struct btrfs_fs_info *fs_info, char *buf, u64 start,
-			 u64 len)
-{
-	u64 offset = 0;
-	u64 sectorsize;
-	int ret = 0;
-
-	while (offset < len) {
-		sectorsize = fs_info->sectorsize;
-		ret = read_data_from_disk(fs_info, buf, start + offset,
-					  &sectorsize, 0);
-		if (ret)
-			break;
-		ret = csum_file_block(trans, fs_info, start + len, start + offset,
-				      buf, sectorsize);
-		if (ret)
-			break;
-		offset += sectorsize;
-	}
-	return ret;
-}
-
-static int fill_csum_tree_from_extent(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
-	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
-	struct btrfs_extent_item *ei;
-	struct extent_buffer *leaf;
-	char *buf;
-	struct btrfs_key key;
-	int ret;
-
-	trans = btrfs_start_transaction(extent_root, 1);
-	if (trans == NULL) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		return -EINVAL;
-	}
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
-	buf = malloc(fs_info->sectorsize);
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
-		ei = btrfs_item_ptr(leaf, path.slots[0], struct btrfs_extent_item);
-		if (!(btrfs_extent_flags(leaf, ei) & BTRFS_EXTENT_FLAG_DATA)) {
-			path.slots[0]++;
-			continue;
-		}
-
-		ret = populate_csum(trans, fs_info, buf, key.objectid, key.offset);
-		if (ret)
-			break;
-		path.slots[0]++;
-	}
-
-	btrfs_release_path(&path);
-	free(buf);
-
-	/* dont' commit if thre's error */
-	ret = btrfs_commit_transaction(trans, extent_root);
-
-	return ret;
-}
-
-int rewrite_checksums(struct btrfs_fs_info *fs_info, int csum_type)
-{
-	struct btrfs_root *root;
-	struct btrfs_super_block *disk_super;
-	struct btrfs_trans_handle *trans;
-	struct btrfs_path path;
-	struct btrfs_key key;
-	u64 super_flags;
-	int ret;
-
-	disk_super = fs_info->super_copy;
-	super_flags = btrfs_super_flags(disk_super);
-
-	/* FIXME: Sanity checks */
-	if (0) {
-		error("UUID rewrite in progress, cannot change csum");
-		return 1;
-	}
-
-	pr_verbose(LOG_DEFAULT, "Change csum from %s to %s\n",
-			btrfs_super_csum_name(fs_info->csum_type),
-			btrfs_super_csum_name(csum_type));
-
-	fs_info->force_csum_type = csum_type;
-	root = fs_info->tree_root;
-
-	/* Step 1 sets the in progress flag, no other change to the sb */
-	pr_verbose(LOG_DEFAULT, "Set superblock flag CHANGING_CSUM\n");
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		return ret;
-	}
-
-	btrfs_init_path(&path);
-	key.objectid = BTRFS_CSUM_TREE_TMP_OBJECTID;
-	key.type = BTRFS_TEMPORARY_ITEM_KEY;
-	key.offset = 0;
-	ret = btrfs_search_slot(trans, root, &key, &path, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	if (ret == 1) {
-		struct item {
-			u64 offset;
-			u64 generation;
-			u16 csum_type;
-			/*
-			 * - generation when last synced
-			 * - must recheck the whole tree anyway in case the fs
-			 *   was mounted between and there are some extents missing
-			 */
-		} item[1];
-
-		ret = btrfs_create_root(trans, fs_info, BTRFS_CSUM_TREE_TMP_OBJECTID);
-		if (ret < 0) {
-			return ret;
-		} else {
-			item->offset = btrfs_header_bytenr(fs_info->csum_tree_tmp->node);
-			item->generation = btrfs_super_generation(fs_info->super_copy);
-			item->csum_type = csum_type;
-			ret = btrfs_insert_item(trans, fs_info->tree_root, &key, item,
-						sizeof(*item));
-			if (ret < 0)
-				return ret;
-		}
-	} else {
-		error("updating existing tmp csum root not implemented");
-		exit(1);
-	}
-
-	super_flags |= BTRFS_SUPER_FLAG_CHANGING_CSUM;
-	btrfs_set_super_flags(disk_super, super_flags);
-	/* Change csum type here */
-	btrfs_set_super_csum_type(disk_super, csum_type);
-	ret = btrfs_commit_transaction(trans, root);
-	if (ret < 0)
-		return ret;
-	btrfs_release_path(&path);
-
-	struct {
-		struct btrfs_root *root;
-		const char *name;
-		u64 objectid;
-		bool p;
-		bool g;
-	} trees[] = {
-		{ .p = true, .root = fs_info->tree_root, .name = "root tree" },
-		{ .p = true, .root = fs_info->chunk_root, .name = "chunk tree" },
-		{ .p = true, .root = fs_info->dev_root, .name = "dev tree" },
-		{ .p = true, .root = fs_info->uuid_root, .name = "uuid tree" },
-		{ .p = true, .root = fs_info->quota_root, .name = "quota tree" },
-		{ .p = true, .root = fs_info->block_group_root, .name = "block group tree" },
-		{ .g = true, .objectid = BTRFS_EXTENT_TREE_OBJECTID, .name = "extent tree" },
-		{ .g = true, .objectid = BTRFS_CSUM_TREE_OBJECTID, .name = "csum tree" },
-		{ .g = true, .objectid = BTRFS_FREE_SPACE_TREE_OBJECTID, .name = "free space tree" },
-		{ .p = true, .root = fs_info->csum_tree_tmp, .name = "csum tmp tree" },
-		{ .objectid = BTRFS_DATA_RELOC_TREE_OBJECTID, .name = "data reloc tree" },
-		{ .objectid = BTRFS_FS_TREE_OBJECTID, .name = "fs tree" },
-		/* TODO: iterate all fs trees */
-		/* TODO: crashes if trees not present */
-		/* { .objectid = BTRFS_TREE_LOG_OBJECTID, .name = "tree log tree" }, */
-		/* { .objectid = BTRFS_TREE_RELOC_OBJECTID, .name = "tree reloc tree" }, */
-		/* { .objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID, .name = "block group tree" }, */
-	};
-
-	for (int i = 0; i < ARRAY_SIZE(trees); i++) {
-		pr_verbose(LOG_DEFAULT, "Change csum in %s\n", trees[i].name);
-		if (trees[i].p) {
-			root = trees[i].root;
-			if (!root)
-				continue;
-		} else if (trees[i].g) {
-			key.objectid = trees[i].objectid;
-			key.type = BTRFS_ROOT_ITEM_KEY;
-			key.offset = 0;
-			root = btrfs_global_root(fs_info, &key);
-			if (!root)
-				continue;
-		} else {
-			key.objectid = trees[i].objectid;
-			key.type = BTRFS_ROOT_ITEM_KEY;
-			key.offset = (u64)-1;
-			root = btrfs_read_fs_root_no_cache(fs_info, &key);
-			if (!root)
-				continue;
-		}
-		ret = change_tree_csum(trans, root, csum_type);
-		if (ret < 0) {
-			error("failed to change csum of %s: %d", trees[i].name, ret);
-			goto out;
-		}
-	}
-
-	/* DATA */
-	pr_verbose(LOG_DEFAULT, "Change csum of data blocks\n");
-	ret = fill_csum_tree_from_extent(fs_info);
-	if (ret < 0)
-		goto out;
-
-	/* TODO: sync last status of old csum tree */
-	/* TODO: delete old csum tree */
-
-	/* Last, change csum in super */
-	ret = write_all_supers(fs_info);
-	if (ret < 0)
-		goto out;
-
-	/* All checksums done, drop the flag, super block csum will get updated */
-	pr_verbose(LOG_DEFAULT, "Clear superblock flag CHANGING_CSUM\n");
-	super_flags = btrfs_super_flags(fs_info->super_copy);
-	super_flags &= ~BTRFS_SUPER_FLAG_CHANGING_CSUM;
-	btrfs_set_super_flags(fs_info->super_copy, super_flags);
-	btrfs_set_super_csum_type(disk_super, csum_type);
-	ret = write_all_supers(fs_info);
-	pr_verbose(LOG_DEFAULT, "Checksum change finished\n");
-out:
-	/* check errors */
-
-	return ret;
+	/* Phase 3, change the new csum key objectid */
+
+	/*
+	 * Phase 4, change the csums for metadata.
+	 *
+	 * This has to be done in-place, as we don't have a good method
+	 * like relocation in progs.
+	 * Thus we have to support reading a tree block with either csum.
+	 */
+	return -EOPNOTSUPP;
 }
diff --git a/tune/main.c b/tune/main.c
index c3e18df5ed5c..e38c1f6d3729 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -373,7 +373,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	if (csum_type != -1) {
 		/* TODO: check conflicting flags */
 		pr_verbose(LOG_DEFAULT, "Proceed to switch checksums\n");
-		ret = rewrite_checksums(root->fs_info, csum_type);
+		ret = btrfs_change_csum_type(root->fs_info, csum_type);
 	}
 
 	if (change_metadata_uuid) {
diff --git a/tune/tune.h b/tune/tune.h
index 753dc95eb138..0ef249d89eee 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -32,6 +32,5 @@ int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string);
 int convert_to_bg_tree(struct btrfs_fs_info *fs_info);
 int convert_to_extent_tree(struct btrfs_fs_info *fs_info);
 
-int rewrite_checksums(struct btrfs_fs_info *fs_info, int csum_type);
-
+int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type);
 #endif
-- 
2.40.1

