Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30C1BBC06
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgD1LLh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 07:11:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34306 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgD1LLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 07:11:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id j1so24171463wrt.1
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 04:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1IfCw/m1lX4/nXIY8wTgWUiPYxdsi4jk1GZskZ0cXQ=;
        b=X8wE4cEQv4IPAIZdeniPoMFFv8AIEqg/RmroxeMmNrJF2HFZudSAQb5QXxr/i4hnzt
         DUXEjP1COmqiJYUo0PmzD24NP72yeAMsPn91/WNGQUvdEjEccYMJXemH1edRZefwvni4
         J72fRIwXKTGYVb8Fb1n1NmYlyTn+63r4fFJKdDR5WEUbMpmf2W0Q/j1DDSsb9V2HNwNM
         Y30D4bJwCBw22yqCejubmwO4yRP14NKg+L5I3A7OaVOBkRU1hcqPHZnekhebnOPKJyp3
         deKPnzufq3y5wGb0qHAZb1CXzSusjIBSidDVsjFiSJHE6cr1eqt0+L22lyNhU72RUswF
         ixFQ==
X-Gm-Message-State: AGi0PuYsSYvRAme1Dbioi6VOfgSxKwLxj+Ol+WGoLoo/wMEknazW8d62
        n3tQammq4FDjzzUKbJqaZCg=
X-Google-Smtp-Source: APiQypLeaFZSn0oI3mqufm/wox//+DZqpbEM5P4wkF4zl3lwywLStx5BRSvSb++03aTbTmkmWIYANQ==
X-Received: by 2002:adf:f8c7:: with SMTP id f7mr31928762wrq.125.1588072293188;
        Tue, 28 Apr 2020 04:11:33 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id b191sm3126291wmd.39.2020.04.28.04.11.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:11:32 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/5] btrfs-progs: add auth_key argument to open_ctree_fs_info
Date:   Tue, 28 Apr 2020 13:11:05 +0200
Message-Id: <20200428111109.5687-3-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200428111109.5687-1-jth@kernel.org>
References: <20200428111109.5687-1-jth@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

Add auth_key argument to open_ctree_fs_info() so we have the key once we
create a new fs_info.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-find-root.c           |  2 +-
 check/main.c                |  2 +-
 cmds/filesystem.c           |  2 +-
 cmds/inspect-dump-tree.c    |  2 +-
 cmds/rescue-chunk-recover.c |  2 +-
 cmds/rescue.c               |  2 +-
 cmds/restore.c              |  2 +-
 disk-io.c                   | 16 +++++++++-------
 disk-io.h                   |  5 +++--
 image/main.c                |  5 +++--
 mkfs/main.c                 |  3 ++-
 11 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/btrfs-find-root.c b/btrfs-find-root.c
index 741eb9a9..4cde76d8 100644
--- a/btrfs-find-root.c
+++ b/btrfs-find-root.c
@@ -202,7 +202,7 @@ int main(int argc, char **argv)
 
 	fs_info = open_ctree_fs_info(argv[optind], 0, 0, 0,
 			OPEN_CTREE_CHUNK_ROOT_ONLY |
-			OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
+			OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR, NULL);
 	if (!fs_info) {
 		error("open ctree failed");
 		return 1;
diff --git a/check/main.c b/check/main.c
index 06f32933..21b37e66 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10162,7 +10162,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		ctree_flags |= OPEN_CTREE_PARTIAL;
 
 	info = open_ctree_fs_info(argv[optind], bytenr, tree_root_bytenr,
-				  chunk_root_bytenr, ctree_flags);
+				  chunk_root_bytenr, ctree_flags, NULL);
 	if (!info) {
 		error("cannot open file system");
 		ret = -EIO;
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index c4bb13dd..f9a3a456 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -586,7 +586,7 @@ static int map_seed_devices(struct list_head *all_uuids)
 		 * open_ctree_* detects seed/sprout mapping
 		 */
 		fs_info = open_ctree_fs_info(device->name, 0, 0, 0,
-						OPEN_CTREE_PARTIAL);
+						OPEN_CTREE_PARTIAL, NULL);
 		if (!fs_info)
 			continue;
 
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 1fdbb9a6..662c7a85 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -459,7 +459,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 
 	printf("%s\n", PACKAGE_STRING);
 
-	info = open_ctree_fs_info(argv[optind], 0, 0, 0, open_ctree_flags);
+	info = open_ctree_fs_info(argv[optind], 0, 0, 0, open_ctree_flags, NULL);
 	if (!info) {
 		error("unable to open %s", argv[optind]);
 		goto out;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 1f26425b..668f00b6 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1439,7 +1439,7 @@ open_ctree_with_broken_chunk(struct recover_control *rc)
 	u64 features;
 	int ret;
 
-	fs_info = btrfs_new_fs_info(1, BTRFS_SUPER_INFO_OFFSET);
+	fs_info = btrfs_new_fs_info(1, BTRFS_SUPER_INFO_OFFSET, NULL);
 	if (!fs_info) {
 		fprintf(stderr, "Failed to allocate memory for fs_info\n");
 		return ERR_PTR(-ENOMEM);
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 087c33be..1bff279a 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -242,7 +242,7 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 	}
 
 	fs_info = open_ctree_fs_info(devname, 0, 0, 0, OPEN_CTREE_WRITES |
-				     OPEN_CTREE_PARTIAL);
+				     OPEN_CTREE_PARTIAL, NULL);
 	if (!fs_info) {
 		error("could not open btrfs");
 		ret = -EIO;
diff --git a/cmds/restore.c b/cmds/restore.c
index 08f5b7e7..5821dc9b 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1280,7 +1280,7 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 		 */
 		fs_info = open_ctree_fs_info(dev, bytenr, root_location, 0,
 					     OPEN_CTREE_PARTIAL |
-					     OPEN_CTREE_NO_BLOCK_GROUPS);
+					     OPEN_CTREE_NO_BLOCK_GROUPS, NULL);
 		if (fs_info)
 			break;
 		fprintf(stderr, "Could not open root, trying backup super\n");
diff --git a/disk-io.c b/disk-io.c
index 5e54a4b3..6221c3ce 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -789,7 +789,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	free(fs_info);
 }
 
-struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
+struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr,
+					char *auth_key)
 {
 	struct btrfs_fs_info *fs_info;
 
@@ -1189,7 +1190,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 					     u64 sb_bytenr,
 					     u64 root_tree_bytenr,
 					     u64 chunk_root_bytenr,
-					     unsigned flags)
+					     unsigned flags, char *auth_key)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_super_block *disk_super;
@@ -1206,7 +1207,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 	if (posix_fadvise(fp, 0, 0, POSIX_FADV_DONTNEED))
 		fprintf(stderr, "Warning, could not drop caches\n");
 
-	fs_info = btrfs_new_fs_info(flags & OPEN_CTREE_WRITES, sb_bytenr);
+	fs_info = btrfs_new_fs_info(flags & OPEN_CTREE_WRITES, sb_bytenr,
+				    auth_key);
 	if (!fs_info) {
 		fprintf(stderr, "Failed to allocate memory for fs_info\n");
 		return NULL;
@@ -1317,7 +1319,7 @@ out:
 struct btrfs_fs_info *open_ctree_fs_info(const char *filename,
 					 u64 sb_bytenr, u64 root_tree_bytenr,
 					 u64 chunk_root_bytenr,
-					 unsigned flags)
+					 unsigned flags, char *auth_key)
 {
 	int fp;
 	int ret;
@@ -1344,7 +1346,7 @@ struct btrfs_fs_info *open_ctree_fs_info(const char *filename,
 		return NULL;
 	}
 	info = __open_ctree_fd(fp, filename, sb_bytenr, root_tree_bytenr,
-			       chunk_root_bytenr, flags);
+			       chunk_root_bytenr, flags, auth_key);
 	close(fp);
 	return info;
 }
@@ -1356,7 +1358,7 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 
 	/* This flags may not return fs_info with any valid root */
 	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
-	info = open_ctree_fs_info(filename, sb_bytenr, 0, 0, flags);
+	info = open_ctree_fs_info(filename, sb_bytenr, 0, 0, flags, NULL);
 	if (!info)
 		return NULL;
 	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
@@ -1375,7 +1377,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				(unsigned long long)flags);
 		return NULL;
 	}
-	info = __open_ctree_fd(fp, path, sb_bytenr, 0, 0, flags);
+	info = __open_ctree_fd(fp, path, sb_bytenr, 0, 0, flags, NULL);
 	if (!info)
 		return NULL;
 	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
diff --git a/disk-io.h b/disk-io.h
index 630d4754..79a2cf73 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -143,7 +143,8 @@ void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 int clean_tree_block(struct extent_buffer *buf);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
-struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr);
+struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr,
+					char *auth_key);
 int btrfs_check_fs_compatibility(struct btrfs_super_block *sb,
 				 unsigned int flags);
 int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
@@ -163,7 +164,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 struct btrfs_fs_info *open_ctree_fs_info(const char *filename,
 					 u64 sb_bytenr, u64 root_tree_bytenr,
 					 u64 chunk_root_bytenr,
-					 unsigned flags);
+					 unsigned flags, char *auth_key);
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
 static inline int close_ctree(struct btrfs_root *root)
 {
diff --git a/image/main.c b/image/main.c
index 0d286b8f..39bca429 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2549,7 +2549,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		info = open_ctree_fs_info(target, 0, 0, 0,
 					  OPEN_CTREE_WRITES |
 					  OPEN_CTREE_RESTORE |
-					  OPEN_CTREE_PARTIAL);
+					  OPEN_CTREE_PARTIAL,
+					  NULL);
 		if (!info) {
 			error("open ctree failed");
 			ret = -EIO;
@@ -2913,7 +2914,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 
 		info = open_ctree_fs_info(target, 0, 0, 0,
 					  OPEN_CTREE_PARTIAL |
-					  OPEN_CTREE_RESTORE);
+					  OPEN_CTREE_RESTORE, NULL);
 		if (!info) {
 			error("open ctree failed at %s", target);
 			return 1;
diff --git a/mkfs/main.c b/mkfs/main.c
index 316ea82e..e830de4e 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1206,7 +1206,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	fs_info = open_ctree_fs_info(file, 0, 0, 0,
-			OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER);
+			OPEN_CTREE_WRITES | OPEN_CTREE_TEMPORARY_SUPER,
+			auth_key);
 	if (!fs_info) {
 		error("open ctree failed");
 		goto error;
-- 
2.16.4

