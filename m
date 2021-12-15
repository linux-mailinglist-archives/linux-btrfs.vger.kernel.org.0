Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A7476386
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhLOUk0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbhLOUkZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:25 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D28EC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:25 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id p4so21326282qkm.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3IZ5GwuhKVYoc4IE9WPlzXj4PhIOz+svPAoI4OdcRXQ=;
        b=IHyTwZcDfO2a4JYF+7NmoGooe4roCOzVV3DQIzg+eDaOgzxrwPH3rG5jZv8ySODV8V
         Fv9cxnD2MIX/peFWdD/36MYDChU8KZS38pkGkh/11SOn58HK2aD6qg6TBDB9sRb8YRwH
         E51aNnode2t8jleMGOQj2csN/4kPzh6fVEp4CMV1ZrOZljbGS/v/ZUduJP34Y173J/Ez
         RJqtFQLI0zHdNukRhtnY8ttfYl+o9EgP99VWSU5MxpBA9B0l9P8OMmK2pIy8kQc419fv
         60ac7d2/G8WD9AnMTK8wVCajbs3rnW1gAGbTvSHdg6QmkN6tSAFrcbHyyAWlJ/Ai65/b
         8fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IZ5GwuhKVYoc4IE9WPlzXj4PhIOz+svPAoI4OdcRXQ=;
        b=kaWk+8GmFifyV+3EQcQAr9KCe+y+pYrJBLeTqkJ86x5iYE4c+D8hkIiSNjWaKm4Z5H
         9+8wgIKd1kam+yQZeIlVjGSpl8RhBnELC6UJ4J/Gi3LkSE8PQXN19bw0Swgh1fn29sIP
         uQ++5UKvQ7ckTmlscRccS2/YgSNM+gUmo87tLu/iri+mPp6qjI1HA9wH39XC6KuCxcsX
         IzIrpzCUfnUlDgbOSHNKe0CRVLzH3zw0behnbrC7u7z6GVae3F3FbfNAazpnhgT8cFzb
         zvPBaLY5YALwrDvgKFwbUsgG8RQsu3mcjPTic7fXb7xWUsfIVO3L7Gmd/BTyE1VvTEIH
         mCNw==
X-Gm-Message-State: AOAM531wSCFLYx8d8gxl/v7WjgS0ix9VoABJopefekfIs5XWRG0j1DQQ
        nji/qR4irmaB5NlBcPy2OCeF2qwmRfq6UQ==
X-Google-Smtp-Source: ABdhPJzz4sh2OBp5DNVvZu4M5/IVP/9O1yAvAx7w/pfi6vmjS6KEFSzoXGugC1rFTSce/TMoXzKmUA==
X-Received: by 2002:a05:620a:94d:: with SMTP id w13mr10340389qkw.419.1639600823955;
        Wed, 15 Dec 2021 12:40:23 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p10sm2269091qtw.97.2021.12.15.12.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:40:23 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/11] btrfs: add code to support the block group root
Date:   Wed, 15 Dec 2021 15:40:07 -0500
Message-Id: <6989c644d619aa6c829310bb9f508e12a36ea8af.1639600719.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600719.git.josef@toxicpanda.com>
References: <cover.1639600719.git.josef@toxicpanda.com>
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
index f70b6772b3ad..40c1e5869cef 100644
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
@@ -2336,6 +2342,17 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
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
 
@@ -2470,6 +2487,13 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
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
index ddc3b9fcbabc..b31f20a9da2f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1734,6 +1734,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->uuid_root);
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
+	btrfs_put_root(fs_info->block_group_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -2094,7 +2095,6 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 {
 	const int next_backup = info->backup_root_index;
 	struct btrfs_root_backup *root_backup;
-	struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 	struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
 	root_backup = info->super_for_commit->super_roots + next_backup;
@@ -2120,11 +2120,23 @@ static void backup_super_roots(struct btrfs_fs_info *info)
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
@@ -2269,6 +2281,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->uuid_root);
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
+	free_root_extent_buffers(info->block_group_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2969,8 +2982,20 @@ static int load_important_roots(struct btrfs_fs_info *fs_info)
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
 
@@ -2983,6 +3008,16 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
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
index 5e8bef4b7563..2e10514ecda8 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -111,6 +111,8 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
 
 static inline struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info)
 {
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return fs_info->block_group_root;
 	return btrfs_extent_root(fs_info, 0);
 }
 
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 0775ae9f4419..524fdb0ddd74 100644
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
index 5416f1f1a77a..854df92520a1 100644
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

