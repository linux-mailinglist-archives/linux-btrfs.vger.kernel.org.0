Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983B544CA58
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhKJURu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhKJURu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:50 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E060C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:02 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l8so3299323qtk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ukiHwVRSTF97BrpJRCvegP8HUEp6Hx3PHsedxexcM84=;
        b=7S+R6cLa+iGBd5+oHlaMn+3ZWgCElnt9cx5PQpFsN2f0gaYHG1xYHjpdBvjbRySqTK
         zdBS0uBN0CYZ6bE2UkQL3iQQF44arlyRv9x2dctS3rO4lRMx40PxsBB9T1PchP+ZhCIQ
         nGtyaFgUPG4Fja+bORr1g6id8XIgfYNhVdhZLM9LTnoWlVR/5FVIH416YyhXIqUTbmA1
         9D9narlu23zao267hOhxYMFi3NGpWfa3+Xaw7Kr6LtJFWweI5xYp+bAIQ4DlfRSrKpRY
         z9nQLObccDpGHONQCowSbuIJExDDpJhAs8RJIq9xeQohSu7hg6YT0gTs9OfHp28r0JCH
         NnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukiHwVRSTF97BrpJRCvegP8HUEp6Hx3PHsedxexcM84=;
        b=MKP0kiTZnE3zB20Tjk4mBKdc6yToai9V3ChFcLjYbMbLk0QznwNnCdZS0iIBRIOj3c
         LGWKlRDokZwmmxoQFi3/PNVOuM38Yebc9HQ6fDz4Mm12o/4vHk8D+kEQUP/44zp5vI9+
         7WwS4V50m1QSY+Zsl4MqzKkd8z6efaeYGafsy7N47nhfS8z5ebuaP04B9SFJZ1NO1DS5
         Krdfr1P/Ia9TA4n4EnPX7cZah5OomVsiHUyU94xVPM7/XzTu/IanRKhdPfmc3MyQv7Ks
         fC+/++vA8tNVGxEbN+70jr2JcL0L0fWLmzH8RzrL6o36Te/pQWdNMl+CfIGM6S8Toueh
         zl1A==
X-Gm-Message-State: AOAM533cuCmME1S6X/ClklGbKkrzKDffQYtzAM4/n8Q9dkRxknhlyinG
        7chJvmx157u7BYCn2rsSEPYFTOY5u4OILg==
X-Google-Smtp-Source: ABdhPJx+XDRbRGLyrC23XQBszheiV7yKj/RjqhpmUDKX3cpOhDuU/c0w9QGqwDQfpMkd+CKMBieCHQ==
X-Received: by 2002:ac8:5711:: with SMTP id 17mr1959318qtw.138.1636575301384;
        Wed, 10 Nov 2021 12:15:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s13sm526715qtw.33.2021.11.10.12.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:00 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/30] btrfs-progs: add definitions for the block group tree
Date:   Wed, 10 Nov 2021 15:14:22 -0500
Message-Id: <dddfc18279c7f335218302b65918ed6a803934f3.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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
index a1866d9f..3242bf68 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1721,6 +1721,20 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
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

