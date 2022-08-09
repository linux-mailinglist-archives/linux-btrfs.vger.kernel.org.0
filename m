Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849958D30C
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Aug 2022 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiHIFCo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Aug 2022 01:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiHIFCn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Aug 2022 01:02:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D11E3DC
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 22:02:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 591B8347A8
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 05:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660021359; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HsZ+U0g1T542CvJj6UuZgcnhqRK1YPoKAAfOr5/gtHQ=;
        b=sNunws0wMpG01VUDJxAhjsFKG3LCq49RWMoFlfH02ZitOMFxkQ4/qeslP6sdHeRVVp6Jpe
        5udrFqAbDjf0GPhgXZ5DMQZM2KvlkmmAf+5EYZOYXgUvGvy6kY9v/vYFjQ+HinX5MHGJHH
        pNYzI1ADhqBwR0L/iHuc6N462uQzc+4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C41C113A9D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Aug 2022 05:02:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDQBJW7q8WKaPwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Aug 2022 05:02:38 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/3] btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2
Date:   Tue,  9 Aug 2022 13:02:18 +0800
Message-Id: <5c396cb280e441bf37df48e05f406424859a03d3.1660021230.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1660021230.git.wqu@suse.com>
References: <cover.1660021230.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The problem of long mount time caused by block group item search is
already known for over 7 years, and the solution of block group tree is
proposed at least for 5 years.

There is really no need to bound this feature into extent tree v2, just
introduce compat RO flag, BLOCK_GROUP_TREE, to correctly solve the
problem.

All the code handling block group root is already in the upstream
kernel, thus this patch really only needs to introduce the new compat RO
flag.

This patch introduces one extra artificial limitation on block group
tree feature, that free space cache v2 and no-holes feature must be
enabled to use this new compat RO feature.

This artificial requirement is mostly to reduce the test combinations,
and can be a guideline for future features, to mostly rely on the latest
default features.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h           |  3 ++-
 fs/btrfs/disk-io.c         | 23 +++++++++++------------
 fs/btrfs/disk-io.h         |  2 +-
 fs/btrfs/sysfs.c           |  2 ++
 include/uapi/linux/btrfs.h |  6 ++++++
 5 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index bdcf0e24882f..46fcbd355ccd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -302,7 +302,8 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 #define BTRFS_FEATURE_COMPAT_RO_SUPP			\
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID | \
-	 BTRFS_FEATURE_COMPAT_RO_VERITY)
+	 BTRFS_FEATURE_COMPAT_RO_VERITY |		\
+	 BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE)
 
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_SET	0ULL
 #define BTRFS_FEATURE_COMPAT_RO_SAFE_CLEAR	0ULL
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e280f84cb15..64ec3e519f6c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1985,7 +1985,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	if (!btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
+	if (!btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
@@ -2530,7 +2530,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	location.type = BTRFS_ROOT_ITEM_KEY;
 	location.offset = 0;
 
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE)) {
 		location.objectid = BTRFS_BLOCK_GROUP_TREE_OBJECTID;
 		root = btrfs_read_tree_root(tree_root, &location);
 		if (IS_ERR(root)) {
@@ -2715,6 +2715,15 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
+	/* Artificial requirement for block group tree to use newer features. */
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE) &&
+	    (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID) ||
+	     !btrfs_fs_incompat(fs_info, NO_HOLES))) {
+		btrfs_err(fs_info,
+"block-group-tree feature requires space cache v2 and no-holes features");
+		ret = -EINVAL;
+	}
+
 	if (memcmp(fs_info->fs_devices->metadata_uuid, sb->dev_item.fsid,
 		   BTRFS_FSID_SIZE) != 0) {
 		btrfs_err(fs_info,
@@ -2884,16 +2893,6 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	int i;
 
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
-		struct btrfs_root *root;
-
-		root = btrfs_alloc_root(fs_info, BTRFS_BLOCK_GROUP_TREE_OBJECTID,
-					GFP_KERNEL);
-		if (!root)
-			return -ENOMEM;
-		fs_info->block_group_root = root;
-	}
-
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		if (handle_error) {
 			if (!IS_ERR(tree_root->node))
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 47ad8e0a2d33..66fd20cd4009 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -103,7 +103,7 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 
 static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
 {
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+	if (btrfs_fs_compat_ro(fs_info, BLOCK_GROUP_TREE))
 		return fs_info->block_group_root;
 	return btrfs_extent_root(fs_info, 0);
 }
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 43d45a0cfcda..aa4d6e226d72 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -286,6 +286,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(skinny_metadata, SKINNY_METADATA);
 BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
+BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
@@ -316,6 +317,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(no_holes),
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
+	BTRFS_FEAT_ATTR_PTR(block_group_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f54dc91e4025..5f79610e1c72 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -290,6 +290,12 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID	(1ULL << 1)
 #define BTRFS_FEATURE_COMPAT_RO_VERITY			(1ULL << 2)
 
+/*
+ * Put all block group items into a dedicate block group tree, greatly
+ * reduce mount time for large fs.
+ */
+#define BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE	(1ULL << 5)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
-- 
2.37.0

