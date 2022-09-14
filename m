Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D05B90C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiINXFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiINXFJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:09 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F353D15
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:07 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id d1so12960064qvs.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=LczUm8qKTKLmPFseBTPdZnhgQ3Aq3my6qTDiSm79yvg=;
        b=8MYlr2c8vzMzXFUhL/JyVWjGU+v7N1q95sqndjWRwVWfGjEkYL2p3LDF3vZmULIQLC
         0tfgeAk7FeVLEE8jB5hjGrId15NBzus3BoG9+g2tno9x0UopF8wS5vPElEcUxOWl/B0Y
         dj5g3O2zhFRXu4Krp0XVindKokEyORfMkSeOG5SYRJfrSxUFcJHA31RzNcGMZlXtyJSz
         3vYcF9pigei8nRIN/mJipupQPY/LSyYZuxY+BFpAJxN7M+Jzx6MVwItQ1OZN0zMPLyE0
         xSCXOM8sMtez1NNs+31fM2EEp6L3sTXbDCJBqrkuQwSWndQpOA6aY9widqbdeCPnZ8CJ
         edtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LczUm8qKTKLmPFseBTPdZnhgQ3Aq3my6qTDiSm79yvg=;
        b=KLSfMYHWq3bAym6aFCHNY5M+aGMcb+yPTbv38N+tOKhxYjSPUORK67DqVdQ1GwhPAr
         dscWuml3TbeNHBVcQ0kvDegQ2SW6f375k7sSeCjkiuVxL5niFZ9mTfzUYK80ThJkRVTI
         ONKFnhZvXWH/ZTdb0gp3fqIKrK4P6VbbVdcF0u7KR6BMBZV/UXP05IqXbeWCm6Z+uHP9
         7QWoiEdLPdNoVpraOL/yzH94elXQjAIGOaQzSeO2hQ7FGbU2ysPjyH5EhPCYvN4xEWgx
         VjcbpX/CmCF3cjLv+BDhv9zkotwiXCTAQwzDAZcVT0IHi3VnSYluYcDc3hQc+rGnG+Uk
         3SCA==
X-Gm-Message-State: ACgBeo2NdzIrrQAkoHLmyOKFBB/q0SGYcvcYQhC4yF+7y6cSI3PMC36n
        wIojGLzHvsSjDTay3pluMf1UlMc3e8mPiw==
X-Google-Smtp-Source: AA6agR7zTvIzPy36eDaUswx3ohxDCpax9+2sMbGbSkwlpEgbizmLPi/qvbXNXPWr00C/8cDQxLhJ3g==
X-Received: by 2002:a0c:8dc9:0:b0:473:14fe:7c4e with SMTP id u9-20020a0c8dc9000000b0047314fe7c4emr33092189qvb.44.1663196706976;
        Wed, 14 Sep 2022 16:05:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bi17-20020a05620a319100b006b999c1030bsm2759435qkb.52.2022.09.14.16.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:05:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/15] btrfs: move the fs_info related helpers closer to fs_info in ctree.h
Date:   Wed, 14 Sep 2022 19:04:46 -0400
Message-Id: <40ff0ebb4b409b881b7e4cd2e051b07acb05ff40.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is purely cosmetic, to make it straightforward to copy and paste
the definition and helpers from ctree.h into fs.h.  These are helpers
that act directly on the fs_info, and were scattered throughout ctree.h.
Move them directly below the fs_info definition to make it easier to
move them later.  This includes the exclop prototypes, which shares an
enum that's used in struct btrfs_fs_info as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 187 ++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 93 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0da52e8b78e9..57d53ec3cdd0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -126,8 +126,7 @@ struct btrfs_path {
 	 */
 	unsigned int search_for_extension:1;
 };
-#define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
-					sizeof(struct btrfs_item))
+
 struct btrfs_dev_replace {
 	u64 replace_state;	/* see #define above */
 	time64_t time_started;	/* seconds since 1-Jan-1970 */
@@ -705,6 +704,99 @@ static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+/*
+ * Take the number of bytes to be checksummed and figure out how many leaves
+ * it would require to store the csums for that many bytes.
+ */
+static inline u64 btrfs_csum_bytes_to_leaves(
+			const struct btrfs_fs_info *fs_info, u64 csum_bytes)
+{
+	const u64 num_csums = csum_bytes >> fs_info->sectorsize_bits;
+
+	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
+}
+
+/*
+ * Use this if we would be adding new items, as we could split nodes as we cow
+ * down the tree.
+ */
+static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
+						  unsigned num_items)
+{
+	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
+}
+
+/*
+ * Doing a truncate or a modification won't result in new nodes or leaves, just
+ * what we need for COW.
+ */
+static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
+						 unsigned num_items)
+{
+	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
+}
+
+static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
+{
+	return info->nodesize - sizeof(struct btrfs_header);
+}
+
+static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
+}
+
+static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
+{
+	return BTRFS_LEAF_DATA_SIZE(info) / sizeof(struct btrfs_key_ptr);
+}
+
+#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
+		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
+static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) -
+	       BTRFS_FILE_EXTENT_INLINE_DATA_START;
+}
+
+static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
+{
+	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
+}
+
+#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
+				((bytes) >> (fs_info)->sectorsize_bits)
+
+#define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
+					sizeof(struct btrfs_item))
+
+static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
+{
+	return fs_info->zone_size > 0;
+}
+
+/*
+ * Count how many fs_info->max_extent_size cover the @size
+ */
+static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
+{
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
+	if (!fs_info)
+		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
+#endif
+
+	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_size);
+}
+
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
+			enum btrfs_exclusive_operation type);
+bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
+				 enum btrfs_exclusive_operation type);
+void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
+void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
+			  enum btrfs_exclusive_operation op);
+
 /*
  * The state of btrfs root
  */
@@ -1097,39 +1189,6 @@ struct btrfs_file_private {
 	void *filldir_buf;
 };
 
-
-static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *info)
-{
-
-	return info->nodesize - sizeof(struct btrfs_header);
-}
-
-static inline u32 BTRFS_MAX_ITEM_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_LEAF_DATA_SIZE(info) - sizeof(struct btrfs_item);
-}
-
-static inline u32 BTRFS_NODEPTRS_PER_BLOCK(const struct btrfs_fs_info *info)
-{
-	return BTRFS_LEAF_DATA_SIZE(info) / sizeof(struct btrfs_key_ptr);
-}
-
-#define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
-		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
-static inline u32 BTRFS_MAX_INLINE_DATA_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_MAX_ITEM_SIZE(info) -
-	       BTRFS_FILE_EXTENT_INLINE_DATA_START;
-}
-
-static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
-{
-	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
-}
-
-#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
-				((bytes) >> (fs_info)->sectorsize_bits)
-
 static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
 {
 	return crc32c(crc, address, length);
@@ -1173,37 +1232,6 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
-/*
- * Take the number of bytes to be checksummed and figure out how many leaves
- * it would require to store the csums for that many bytes.
- */
-static inline u64 btrfs_csum_bytes_to_leaves(
-			const struct btrfs_fs_info *fs_info, u64 csum_bytes)
-{
-	const u64 num_csums = csum_bytes >> fs_info->sectorsize_bits;
-
-	return DIV_ROUND_UP_ULL(num_csums, fs_info->csums_per_leaf);
-}
-
-/*
- * Use this if we would be adding new items, as we could split nodes as we cow
- * down the tree.
- */
-static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
-						  unsigned num_items)
-{
-	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
-}
-
-/*
- * Doing a truncate or a modification won't result in new nodes or leaves, just
- * what we need for COW.
- */
-static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
-						 unsigned num_items)
-{
-	return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
-}
 
 int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes);
@@ -1737,15 +1765,6 @@ void btrfs_get_block_group_info(struct list_head *groups_list,
 				struct btrfs_ioctl_space_info *space);
 void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
-bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
-			enum btrfs_exclusive_operation type);
-bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
-				 enum btrfs_exclusive_operation type);
-void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
-void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
-void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
-			  enum btrfs_exclusive_operation op);
-
 
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
@@ -1943,24 +1962,6 @@ static inline int btrfs_get_verity_descriptor(struct inode *inode, void *buf,
 void btrfs_test_destroy_inode(struct inode *inode);
 #endif
 
-static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
-{
-	return fs_info->zone_size > 0;
-}
-
-/*
- * Count how many fs_info->max_extent_size cover the @size
- */
-static inline u32 count_max_extents(struct btrfs_fs_info *fs_info, u64 size)
-{
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-	if (!fs_info)
-		return div_u64(size + BTRFS_MAX_EXTENT_SIZE - 1, BTRFS_MAX_EXTENT_SIZE);
-#endif
-
-	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_size);
-}
-
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 {
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
-- 
2.26.3

