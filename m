Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF2465518
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352231AbhLASUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbhLASUn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:20:43 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C5C061756
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:21 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id u16so22542054qvk.4
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HUqDivCvEZHNPDSFN5CTZt8XmRbPAPkLoUSfQ6dlVW4=;
        b=HybOCUQJZNxZY2NzDe/VjrTWhnICEZniKN0vuBB+wkJW0VATRgDZkk6uNLeIKwtjq0
         b8snxJuvHen7IXNYVIuwMM7xuORNq3vqYWYYLpeOa29p5NZl6zd/dA8ctGI/xmHe3WOe
         A1Wjdzcgab0s/TOuvAe8WDTYa7J28kzAEgDzAC+bkW0TsBx0Ee4XoWrTr21+M71PDw/O
         4tYZ9P6TEeXqsPPXQkM1PbkeV+d31gfLiz4tThy3ZfHEHBhIL+qG1H53Z1xCbDXaTcGr
         VqZKAJot5vPM2fdLAbz5MQkBwI8iTihVK2iNieNJLlw/jwJH/Wwbb+mtL+Ibg+5mqNyl
         H90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUqDivCvEZHNPDSFN5CTZt8XmRbPAPkLoUSfQ6dlVW4=;
        b=IqvWqvhezgdmK/Dt/h8XJIfCU+YeCJoyCSUbjV/rzbp7x3udakEBQ/COXB6UlbdCXI
         4LhZZCVuvsY+9V7w9iqLLoeBS2w+P+ZOLAek4Kix4dl18+lA2VOonnhiG4SRWzvabAOF
         OHSGmw2cIaH1denXSmCjS8xKsX8FvbiQfiUD9/nmG2347HSpFjHUMHhFK2uQ7P8+ZeEB
         +a/iyyST7bCP7fTNwsaaUY9QLtV2bfsl1EW94Qw6gD12Nj9hSJT4v3FtM03yV9+w2eE7
         a63Ka0cDdIKFU+a4F8xF1VYJvVggaoIpBs3clxLDyG1MJ1QBs2S0oy2Cf0RDLia0eEI/
         RVmQ==
X-Gm-Message-State: AOAM533kCBLoTibWhuLklgNMAlbg+PF58FD6OIbBuzJf3j+GYyblWQWn
        S5X4yJODkMVPTa0d9MuicrxLetmS4cLUcA==
X-Google-Smtp-Source: ABdhPJyagBEI3X07A1RuHJFyEBVCqv8u886t33/uJ+QU20MrduDznMhANbwKarZfvGOa0MkuRW3yZQ==
X-Received: by 2002:a05:6214:4107:: with SMTP id kc7mr7844379qvb.12.1638382640525;
        Wed, 01 Dec 2021 10:17:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v12sm272512qkl.50.2021.12.01.10.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/22] btrfs-progs: add definitions for the block group tree
Date:   Wed,  1 Dec 2021 13:16:56 -0500
Message-Id: <65497cc771a88eae9639977aaf3d17149ead560a.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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
index 9f7ccd38..eb815b2d 100644
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
 
@@ -459,8 +462,14 @@ struct btrfs_super_block {
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
 	/* Padded to 4096 bytes */
@@ -2289,6 +2298,17 @@ BTRFS_SETGET_STACK_FUNCS(backup_bytes_used, struct btrfs_root_backup,
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
@@ -2339,6 +2359,13 @@ BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
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
index 8100748a..364a0bd8 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1723,6 +1723,20 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
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
index c7748f15..73f969c3 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -784,6 +784,9 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
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

