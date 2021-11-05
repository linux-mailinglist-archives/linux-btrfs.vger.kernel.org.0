Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C771D446A27
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhKEUwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhKEUwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:38 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A5C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:58 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u16so8076057qvk.4
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XyFlNQn5uGrd/km4nDWG6x3TOWpliNum7kGjOkX63cw=;
        b=m/+O2BbfhuiBtla+3dGbkcABnABCRUF/TeOhjzjYaCjHqT48WVZ3FAXsDEf9Ggnilw
         CnMF7p2li3GVTg8QWwITONF4mcsKYSw9xK2EJ1YB4alqHRQShYUI3aTKpL7TDHnfzDo5
         czM1hkBBfrn4eufiCeafIRd3C6MXU0XhPHmAqU3XnOFYXv/wXjv6Lt75wHc1D/ZKAYZn
         R9mNsMHpgtVpM3HwfOJB9+YM++bV1xaxEUisrYCml46mLBfVzEke0lYL0nY1j70g3BFI
         lZNmvhSlNr/skeGGd2oyiuRvv3HdAGcNRWf9+5neKZB78jvMkOz8BibHpJ70N3v/UV5q
         qcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyFlNQn5uGrd/km4nDWG6x3TOWpliNum7kGjOkX63cw=;
        b=cannVy8gEPVh/HR4TQlEw9FRPge+8qE00GZtXqyOUY/2unFLrNznoCdPbkbGLX9Gr6
         IoQT2fFBKWOZQOycvj/aZmjcrd3EngAXswnOBlCG+fD9QTpezSQIIU3SLfUje+/p6DEl
         /v4A9YScdokLNae4urcovjKpZSmCKR1gCCARe00/qIMzEFr3umw8GUIL5VZkpadx4BMB
         EJFjkaWNrYaVB1UZ4UYhrHsDXPcE/avtaGadAJJ/XQbWDSt8HqeHpmbva3yDSfp/Ommy
         zS7aPyzJArX9UEClEXWmiPqupi++CbK8BNjuTZ+gvLauuvLGPBQljaAOJyus/p2LBKiE
         SWow==
X-Gm-Message-State: AOAM533xNVXxtOyo4MNrcV+qLd9mSq8UswyS5CJNkj8tQNH+zpjT2PwJ
        FvzKvL9YEW7hY5WiD7fp3b5Wffoyjd/mCg==
X-Google-Smtp-Source: ABdhPJyfkkstNPHb+GwYUQjDxcRhqQup+H0y1m7SszgMCIO9+2xbzNbNlBXLkyrl6fbgYaElvwmnyg==
X-Received: by 2002:a05:6214:c6f:: with SMTP id t15mr12038692qvj.49.1636145396962;
        Fri, 05 Nov 2021 13:49:56 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm7106363qtk.6.2021.11.05.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: add code to support the block group root
Date:   Fri,  5 Nov 2021 16:49:44 -0400
Message-Id: <6e96419001ae2d477a84483dee0f9731f78b25bd.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This code adds the on disk structures for the block group root, which
will hold the block group items for extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h                | 26 ++++++++++++++++-
 fs/btrfs/disk-io.c              | 49 ++++++++++++++++++++++++++++-----
 fs/btrfs/disk-io.h              |  2 ++
 fs/btrfs/print-tree.c           |  1 +
 include/trace/events/btrfs.h    |  1 +
 include/uapi/linux/btrfs_tree.h |  3 ++
 6 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8ec2f068a1c2..b57367141b95 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -271,8 +271,13 @@ struct btrfs_super_block {
 	/* the UUID written into btree blocks */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
+	__le64 block_group_root;
+	__le64 block_group_root_generation;
+	u8 block_group_root_level;
+
 	/* future expansion */
-	__le64 reserved[28];
+	u8 reserved8[7];
+	__le64 reserved[25];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 
@@ -648,6 +653,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *quota_root;
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
+	struct btrfs_root *block_group_root;
 
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
@@ -2326,6 +2332,17 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
 BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
 		   num_devices, 64);
 
+/*
+ * for extent tree v2 we overload the extent root with the block group root, as
+ * we will have multiple extent roots.
+ */
+BTRFS_SETGET_STACK_FUNCS(backup_block_group_root, struct btrfs_root_backup,
+			 extent_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_gen, struct btrfs_root_backup,
+			 extent_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_level,
+			 struct btrfs_root_backup, extent_root_level, 8);
+
 /* struct btrfs_balance_item */
 BTRFS_SETGET_FUNCS(balance_flags, struct btrfs_balance_item, flags, 64);
 
@@ -2460,6 +2477,13 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_block,
+			 block_group_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
+			 struct btrfs_super_block,
+			 block_group_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_super_block,
+			 block_group_root_level, 8);
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index db8e4856364e..45b2bde43150 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1733,6 +1733,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->uuid_root);
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
+	btrfs_put_root(fs_info->block_group_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2093,7 +2094,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
-	struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
@@ -2119,11 +2119,23 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	btrfs_set_backup_extent_root(root_backup, extent_root->node->start);
-	btrfs_set_backup_extent_root_gen(root_backup,
-			       btrfs_header_generation(extent_root->node));
-	btrfs_set_backup_extent_root_level(root_backup,
-			       btrfs_header_level(extent_root->node));
+	if (btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
+		btrfs_set_backup_block_group_root(root_backup,
+					info->block_group_root->node->start);
+		btrfs_set_backup_block_group_root_gen(root_backup,
+			btrfs_header_generation(info->block_group_root->node));
+		btrfs_set_backup_block_group_root_level(root_backup,
+			btrfs_header_level(info->block_group_root->node));
+	} else {
+		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
+
+		btrfs_set_backup_extent_root(root_backup,
+					     extent_root->node->start);
+		btrfs_set_backup_extent_root_gen(root_backup,
+				btrfs_header_generation(extent_root->node));
+		btrfs_set_backup_extent_root_level(root_backup,
+					btrfs_header_level(extent_root->node));
+	}
 
 	/*
 	 * we might commit during log recovery, which happens before we set
@@ -2268,6 +2280,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->uuid_root);
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
+	free_root_extent_buffers(info->block_group_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2970,8 +2983,20 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
 	gen = btrfs_super_generation(sb);
 	level = btrfs_super_root_level(sb);
 	ret = load_super_root(fs_info->tree_root, bytenr, gen, level);
-	if (ret)
+	if (ret) {
 		btrfs_warn(fs_info, "couldn't read tree root");
+		return ret;
+	}
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return 0;
+
+	bytenr = btrfs_super_block_group_root(sb);
+	gen = btrfs_super_block_group_root_generation(sb);
+	level = btrfs_super_block_group_root_level(sb);
+	ret = load_super_root(fs_info->block_group_root, bytenr, gen, level);
+	if (ret)
+		btrfs_warn(fs_info, "couldn't read block group root");
 	return ret;
 }
 
@@ -2984,6 +3009,16 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 	int i;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		struct btrfs_root *root;
+		root = btrfs_alloc_root(fs_info,
+					BTRFS_BLOCK_GROUP_TREE_OBJECTID,
+					GFP_KERNEL);
+		if (!root)
+			return -ENOMEM;
+		fs_info->block_group_root = root;
+	}
+
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		if (handle_error) {
 			if (!IS_ERR(tree_root->node))
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 80b45fcac72a..fe2e16e75a3b 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -113,6 +113,8 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 
 static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
 {
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return fs_info->block_group_root;
 	return btrfs_extent_root(fs_info, 0);
 }
 
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index aae1027bd76a..5d89c230af94 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -23,6 +23,7 @@ static const struct root_name_map root_map[] = {
 	{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
 	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
 	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
+	{ BTRFS_BLOCK_GROUP_TREE_OBJECTID,	"BLOCK_GROUP_TREE"	},
 	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
 };
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0d729664b4b4..f068ff30d654 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -53,6 +53,7 @@ struct btrfs_space_info;
 		{ BTRFS_TREE_RELOC_OBJECTID,	"TREE_RELOC"	},	\
 		{ BTRFS_UUID_TREE_OBJECTID,	"UUID_TREE"	},	\
 		{ BTRFS_FREE_SPACE_TREE_OBJECTID, "FREE_SPACE_TREE" },	\
+		{ BTRFS_BLOCK_GROUP_TREE_OBJECTID, "BLOCK_GROUP_TREE" },\
 		{ BTRFS_DATA_RELOC_TREE_OBJECTID, "DATA_RELOC_TREE" })
 
 #define show_root_type(obj)						\
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index e1c4c732aaba..75c76b685972 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -53,6 +53,9 @@
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* holds the block group items for extent tree v2. */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
-- 
2.26.3

