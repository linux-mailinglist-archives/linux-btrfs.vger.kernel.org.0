Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7E44CA5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbhKJUR4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhKJURz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:17:55 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBBBC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:07 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id i9so3704180qki.3
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h1NeF227byL+FeSrIu8FVFd3clBfFlMtGbhud9NMqlA=;
        b=7h44IQJpCXCOISIYxQvxtngAGSq9tU4nkq0F9sZzc8W1+IZDBDbhDx9BjjtbaWmGrI
         J9Vs/aVTjV3rqwpo88WxeXkwSGIWdjDrCkoz+NOikn7+3P2Y5D4rb4+VuYImMWxtZJUw
         P3ZJRkW9eS5PV+WF3LaN1c/grbQ6VsdFBAbNz3MEESEPWvbu/v3oo1PiUQqoZ3LyNthG
         z81595MKBmdzIuY0dTrOeZ5WIOL6iwWThptfGUL1wvSOYZFNwa6KHcGFHFzo8uT0qsre
         7mXXJyO4nPc/cdaNi5Wn9djvY3rTtaDlityCKUpadpIbGhGqFPJyKaN+NCl/0cKaYngg
         iG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1NeF227byL+FeSrIu8FVFd3clBfFlMtGbhud9NMqlA=;
        b=VXxe/YaeMf122EhKFOSEa9mMcReUQ726uvl/jX0YDGoYn1nhjm+pDTdt3cCBT1401T
         mUY2nxPe03rgqUMdB1I8u2sCxy4vp2MW+/AE2gqrs2bdV5Rrfmv0KA4HI6yb+lPL888s
         G169lXrrr94uY93cKpkT0K3Tz5QRM2CyUkYvaZ8EllfqZZ7uqkw/3DbDfKWzGJj6WHw0
         unArA5VBde4G3deMbRDIP5U99QXv+HwTV95h/VhEJFVyjmZ+5dd7sC3CEYjaK2N7xlvD
         l57hrdZLKq3pp6rq4MErN9sUlTultyHKkpyMmdfw+wC/P8TcQS9p7FmBDTJy/m8KI2Pt
         1V1g==
X-Gm-Message-State: AOAM533ukV9uswnRdsS1uEDuyqmnDpmgbupCRKivO5qUdJ4KOzU5l5EC
        Oeq7lSXl2hl8irXpKt7Al5dmFqXfWslNVg==
X-Google-Smtp-Source: ABdhPJwK90j3FdzX7P0PpFiSw9wEopWTtwvoA7NYdMAHp4TURD/vX1wphosS3N6806Pj2yVnB73nkw==
X-Received: by 2002:a37:2e87:: with SMTP id u129mr1780200qkh.208.1636575306135;
        Wed, 10 Nov 2021 12:15:06 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8sm469101qtb.1.2021.11.10.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:05 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 13/30] btrfs-progs: add print support for the block group tree
Date:   Wed, 10 Nov 2021 15:14:25 -0500
Message-Id: <11756f4bca3b45d0f231f287a78ec1c699a85a05.1636575146.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the appropriate support to the print tree and dump tree code to spit
out the block group tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/inspect-dump-tree.c   | 30 +++++++++++++++++++++++++++++-
 kernel-shared/print-tree.c | 23 +++++++++++++++++++----
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 6332b46d..daa7f925 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -83,8 +83,14 @@ out:
 
 static void print_old_roots(struct btrfs_super_block *super)
 {
+	const char *extent_tree_str = "extent root";
 	struct btrfs_root_backup *backup;
 	int i;
+	bool extent_tree_v2 = (btrfs_super_incompat_flags(super) &
+		BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
+
+	if (extent_tree_v2)
+		extent_tree_str = "block group root";
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		backup = super->super_roots + i;
@@ -93,7 +99,7 @@ static void print_old_roots(struct btrfs_super_block *super)
 		       (unsigned long long)btrfs_backup_tree_root_gen(backup),
 		       (unsigned long long)btrfs_backup_tree_root(backup));
 
-		printf("\t\textent root gen %llu block %llu\n",
+		printf("\t\t%s gen %llu block %llu\n", extent_tree_str,
 		       (unsigned long long)btrfs_backup_extent_root_gen(backup),
 		       (unsigned long long)btrfs_backup_extent_root(backup));
 
@@ -510,6 +516,11 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 				       info->log_root_tree->node->start,
 					btrfs_header_level(
 						info->log_root_tree->node));
+			if (info->block_group_root)
+				printf("block group tree: %llu level %d\n",
+				       info->block_group_root->node->start,
+					btrfs_header_level(
+						info->block_group_root->node));
 		} else {
 			if (info->tree_root->node) {
 				printf("root tree\n");
@@ -528,6 +539,12 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 				btrfs_print_tree(info->log_root_tree->node,
 					BTRFS_PRINT_TREE_FOLLOW | print_mode);
 			}
+
+			if (info->block_group_root) {
+				printf("block group tree\n");
+				btrfs_print_tree(info->block_group_root->node,
+					BTRFS_PRINT_TREE_FOLLOW | print_mode);
+			}
 		}
 	}
 	tree_root_scan = info->tree_root;
@@ -573,6 +590,17 @@ again:
 		goto close_root;
 	}
 
+	if (tree_id && tree_id == BTRFS_BLOCK_GROUP_TREE_OBJECTID) {
+		if (!info->block_group_root) {
+			error("cannot print block group tree, invalid pointer");
+			goto close_root;
+		}
+		printf("block group tree\n");
+		btrfs_print_tree(info->block_group_root->node,
+					BTRFS_PRINT_TREE_FOLLOW | print_mode);
+		goto close_root;
+	}
+
 	key.offset = 0;
 	key.objectid = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 6748c33f..d2699e6c 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1860,8 +1860,14 @@ static int empty_backup(struct btrfs_root_backup *backup)
 	return 0;
 }
 
-static void print_root_backup(struct btrfs_root_backup *backup)
+static void print_root_backup(struct btrfs_root_backup *backup,
+			      bool extent_tree_v2)
 {
+	const char *extent_tree_str = "backup_extent_root";
+
+	if (extent_tree_v2)
+		extent_tree_str = "backup_block_group_root";
+
 	printf("\t\tbackup_tree_root:\t%llu\tgen: %llu\tlevel: %d\n",
 			btrfs_backup_tree_root(backup),
 			btrfs_backup_tree_root_gen(backup),
@@ -1870,7 +1876,8 @@ static void print_root_backup(struct btrfs_root_backup *backup)
 			btrfs_backup_chunk_root(backup),
 			btrfs_backup_chunk_root_gen(backup),
 			btrfs_backup_chunk_root_level(backup));
-	printf("\t\tbackup_extent_root:\t%llu\tgen: %llu\tlevel: %d\n",
+	printf("\t\t%s:\t%llu\tgen: %llu\tlevel: %d\n",
+			extent_tree_str,
 			btrfs_backup_extent_root(backup),
 			btrfs_backup_extent_root_gen(backup),
 			btrfs_backup_extent_root_level(backup));
@@ -1882,7 +1889,7 @@ static void print_root_backup(struct btrfs_root_backup *backup)
 			btrfs_backup_dev_root(backup),
 			btrfs_backup_dev_root_gen(backup),
 			btrfs_backup_dev_root_level(backup));
-	printf("\t\tbackup_csum_root:\t%llu\tgen: %llu\tlevel: %d\n",
+	printf("\t\tcsum_root:\t%llu\tgen: %llu\tlevel: %d\n",
 			btrfs_backup_csum_root(backup),
 			btrfs_backup_csum_root_gen(backup),
 			btrfs_backup_csum_root_level(backup));
@@ -1900,12 +1907,14 @@ static void print_backup_roots(struct btrfs_super_block *sb)
 {
 	struct btrfs_root_backup *backup;
 	int i;
+	bool extent_tree_v2 = (btrfs_super_incompat_flags(sb) &
+		BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
 	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; i++) {
 		backup = sb->super_roots + i;
 		if (!empty_backup(backup)) {
 			printf("\tbackup %d:\n", i);
-			print_root_backup(backup);
+			print_root_backup(backup, extent_tree_v2);
 		}
 	}
 }
@@ -2022,6 +2031,12 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	       (unsigned long long)btrfs_super_cache_generation(sb));
 	printf("uuid_tree_generation\t%llu\n",
 	       (unsigned long long)btrfs_super_uuid_tree_generation(sb));
+	printf("block_group_root\t%llu\n",
+	       (unsigned long long)btrfs_super_block_group_root(sb));
+	printf("block_group_root_generation\t%llu\n",
+	       (unsigned long long)btrfs_super_block_group_root_generation(sb));
+	printf("block_group_root_level\t%llu\n",
+	       (unsigned long long)btrfs_super_block_group_root_level(sb));
 
 	uuid_unparse(sb->dev_item.uuid, buf);
 	printf("dev_item.uuid\t\t%s\n", buf);
-- 
2.26.3

