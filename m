Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAAC476268
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhLOT74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 14:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhLOT7z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 14:59:55 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F6FC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:55 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id n15so23120391qta.0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 11:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HUqDivCvEZHNPDSFN5CTZt8XmRbPAPkLoUSfQ6dlVW4=;
        b=aYeusTF7vEohIuaZ323nDdbW1ZvDoTsGsZ/AyNm1zMc9+UZgPi7KfVpZwaYRXzS+PH
         45bO0MQ8kZcT8WIqcJnC7dleyNxrW8+qSmlLqGL1yEP1mQDlvVrbUvWKSu9d7aMqaozS
         wHZEVESyUCKykpV7m/ZRAO2QRv9suXSSI0Bw0xja2x31cq2LHF9e1MEmq1pXhJZgsi5E
         L4vMfbE0oMMxoFW7fh+2fCRUJiTFYI08oQVSGxsKxUoAn5mwfvDkocHso5dOgTWsygku
         rqLRpU+WfZUhHkMspvdIuoNJy97Zr9p5SunSrAuGqBIiQheHCg5WmzIHNlQCFO6PqY/q
         zTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUqDivCvEZHNPDSFN5CTZt8XmRbPAPkLoUSfQ6dlVW4=;
        b=bAlFN5ds8d34wjVCoxqBKpdK/dhtd10bYxycoHTWmfmsv3n8Yt3Bn0eEBFVeiXVRGx
         DVKouQqRVLC/91eWjWssidEyE2BcKhLIPDbUzQkBK+/DN3hfI7Fk/SsQroihzrlGWgxA
         xcOvDIL6aSyKANSHd5UQXuzW0fpQGmoPeOlHKxvkeP7soWnPrrZ802oBQ200NzKKob27
         fVMZWvPtijFe3ADW1UwJAE4oxMNku6EyI3Rm8Df+JVxQVBsDGDFUTSUH9ulf0Qt4YNIH
         ImEY58cxDjKqZ1dRYBlAVco1JCr8jhgMn7F0jzQRsN2/CxMKAhIDXdesJXeinsZNV7nO
         X2vg==
X-Gm-Message-State: AOAM533i7W6g8Pvvu3fRMIG9zhr1JbZT3UANUkAFbDVM7Wg5D6/Dzi7N
        2M/zm3vcFcgTt3B2xA0dhQo0hu30qPcs5g==
X-Google-Smtp-Source: ABdhPJyXN6QYKnniTOsE/Qu/hSSucx10KdgXXCseazNZzmCt5pznSY5QBeIny+RaoUXydutB9WThug==
X-Received: by 2002:ac8:5bca:: with SMTP id b10mr13907973qtb.170.1639598393964;
        Wed, 15 Dec 2021 11:59:53 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y21sm2275794qtw.10.2021.12.15.11.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:59:53 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 02/22] btrfs-progs: add definitions for the block group tree
Date:   Wed, 15 Dec 2021 14:59:28 -0500
Message-Id: <045b7578809fa4fef7c2febd6c0602164b1af2eb.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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

