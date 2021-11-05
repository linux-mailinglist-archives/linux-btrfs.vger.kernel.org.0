Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020A84469D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhKEUnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbhKEUnd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:33 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FC9C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:40:53 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id az8so9883952qkb.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=csAKOwrGhO/qzscAF9xMFLHlyD6eOKXg6fyFvdHydhI=;
        b=3tc6pd5JkAgfE8O06ETTBkRkoz1oPLQMbr4iKW5gD94sPHid5EQHRcmURC4GYunJPv
         5lZxw269GhihtaFEF6UXaH4KsK3WwwbwTjl2QBx9nT+xgimqvVFl9qmJunN6ILvS+ecM
         f97WI+Zn0b8TsHYb73Ra5zjrYq/MUwt2myl4yWmoL7NIlRpcNv3EOwea1TY3vgIM+QdC
         R6VXguvTveRtYVGsf9ROSvLiSiZon8hVj8T15qTPmiN67iVK2MeH7m96etymiAXXUI+6
         8RBG/xsw3LMiOgldDGxtf2MREpKAHti4hL11KhgQcHBI3YMV94aLz6FSitzxXBq7qAuY
         H5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csAKOwrGhO/qzscAF9xMFLHlyD6eOKXg6fyFvdHydhI=;
        b=4e3/Ef3BXsmkVVUVdLHMWXNFSfN4hK2GzIc5NBDt5Y1pfVOBKbnUTl0Q4DYrouVPcA
         jRNDfjdioLagRRVE9Q2Nstn8S9/ZVoUgXTjSwBC2R8WXFSD801fRyuXoq0XbxPQTFK8H
         hOwBeDmt4hYsjXUQ26XX80LWneMcrRihgHKGyFaHmUn31CP21DAwOPHBbv0fiXIzrD0b
         WHJkhzbj8c8sYEEAG8D33L5Uj+oZ4azGYHv79ljukl7Y2NSWYGVJXgakcXNXVxnbputC
         wbUWIJw33jKcPHRjruMECnet0UD+PBbxWCMA6qFGyoupX0QMpjcdpluEA8QUbpk+P6T7
         TL9w==
X-Gm-Message-State: AOAM531uf+Js84WovKvM4MMmPZRqlFGC/AVWQX/R3plbRTzd4n9Jk1cH
        Tw1xUCg8lyLUNYVFNf7SLVEu7MClcnh9UA==
X-Google-Smtp-Source: ABdhPJySCYnIx9uccGgLEjemcyhsJL00oEm5tTasHmJ2aX5K9SL6tyoqpfyfg8LiUF8GO1anDmUGyg==
X-Received: by 2002:a05:620a:2101:: with SMTP id l1mr5607906qkl.358.1636144852104;
        Fri, 05 Nov 2021 13:40:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d11sm7037761qtx.81.2021.11.05.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:40:51 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/22] btrfs-progs: add definitions for the block group tree
Date:   Fri,  5 Nov 2021 16:40:28 -0400
Message-Id: <d41f8a711c1976f1017d9b4c6e1b251ec44169e9.1636144275.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the on disk definitions for the block group tree.  This will be part
of the super block so we need to add the appropriate helpers to the
super block, as well as adding it to the backup roots.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/inspect-dump-tree.c   |  7 ++++++-
 kernel-shared/ctree.h      | 29 ++++++++++++++++++++++++++++-
 kernel-shared/disk-io.c    | 14 ++++++++++++++
 kernel-shared/print-tree.c |  3 +++
 libbtrfsutil/btrfs_tree.h  |  3 +++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index e1c90be7..6332b46d 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -155,7 +155,8 @@ static u64 treeid_from_string(const char *str, const char **end)
 		{ "TREE_LOG_FIXUP", BTRFS_TREE_LOG_FIXUP_OBJECTID },
 		{ "TREE_LOG", BTRFS_TREE_LOG_OBJECTID },
 		{ "TREE_RELOC", BTRFS_TREE_RELOC_OBJECTID },
-		{ "DATA_RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID }
+		{ "DATA_RELOC", BTRFS_DATA_RELOC_TREE_OBJECTID },
+		{ "BLOCK_GROUP_TREE", BTRFS_BLOCK_GROUP_TREE_OBJECTID },
 	};
 
 	if (strncasecmp("BTRFS_", str, strlen("BTRFS_")) == 0)
@@ -695,6 +696,10 @@ again:
 					printf("multiple");
 				}
 				break;
+			case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+				if (!skip)
+					printf("block group");
+				break;
 			default:
 				if (!skip) {
 					printf("file");
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 8a46306e..17216053 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -85,6 +85,9 @@ struct btrfs_free_space_ctl;
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* hold the block group items. */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
@@ -456,8 +459,14 @@ struct btrfs_super_block {
 	__le64 uuid_tree_generation;
 
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
+
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
 } __attribute__ ((__packed__));
@@ -2281,6 +2290,17 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
 BTRFS_SETGET_STACK_FUNCS(backup_num_devices, struct btrfs_root_backup,
 		   num_devices, 64);
 
+/*
+ * Extent tree v2 doesn't have a global csum or extent root, so we use the
+ * extent root slot for the block group root.
+ */
+BTRFS_SETGET_STACK_FUNCS(backup_block_group_root, struct btrfs_root_backup,
+		   extent_root, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_gen, struct btrfs_root_backup,
+		   extent_root_gen, 64);
+BTRFS_SETGET_STACK_FUNCS(backup_block_group_root_level, struct btrfs_root_backup,
+		   extent_root_level, 8);
+
 /* struct btrfs_super_block */
 
 BTRFS_SETGET_STACK_FUNCS(super_bytenr, struct btrfs_super_block, bytenr, 64);
@@ -2331,6 +2351,13 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
 BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root, struct btrfs_super_block,
+			 block_group_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
+			 struct btrfs_super_block,
+			 block_group_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level,
+			 struct btrfs_super_block, block_group_root_level, 8);
 
 static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
 {
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 981ac4f8..bea42556 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1704,6 +1704,20 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		goto error_out;
 	}
 
+	if (btrfs_super_incompat_flags(sb) & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+		if (btrfs_super_block_group_root_level(sb) >= BTRFS_MAX_LEVEL) {
+			error("block_group_root level too big: %d >= %d",
+			      btrfs_super_block_group_root_level(sb),
+			      BTRFS_MAX_LEVEL);
+			goto error_out;
+		}
+		if (!IS_ALIGNED(btrfs_super_block_group_root(sb), 4096)) {
+			error("block_group_root block unaligned: %llu",
+			      btrfs_super_block_group_root(sb));
+			goto error_out;
+		}
+	}
+
 	if (btrfs_super_incompat_flags(sb) & BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
 		metadata_uuid = sb->metadata_uuid;
 	else
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 39655590..6748c33f 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -787,6 +787,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	case BTRFS_MULTIPLE_OBJECTIDS:
 		fprintf(stream, "MULTIPLE");
 		break;
+	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+		fprintf(stream, "BLOCK_GROUP_TREE");
+		break;
 	case (u64)-1:
 		fprintf(stream, "-1");
 		break;
diff --git a/libbtrfsutil/btrfs_tree.h b/libbtrfsutil/btrfs_tree.h
index d3b752ee..1df9efd6 100644
--- a/libbtrfsutil/btrfs_tree.h
+++ b/libbtrfsutil/btrfs_tree.h
@@ -48,6 +48,9 @@
 /* tracks free space in block groups. */
 #define BTRFS_FREE_SPACE_TREE_OBJECTID 10ULL
 
+/* hold the block group items. */
+#define BTRFS_BLOCK_GROUP_TREE_OBJECTID 11ULL
+
 /* device stats in the device tree */
 #define BTRFS_DEV_STATS_OBJECTID 0ULL
 
-- 
2.26.3

