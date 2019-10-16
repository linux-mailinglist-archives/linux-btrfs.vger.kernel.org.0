Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FFDD8B84
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 10:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391809AbfJPImG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 04:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404144AbfJPImE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 04:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E718AD7B
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 08:42:01 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 2/4] btrfs-progs: add auth_key argument to open_ctree_fs_info
Date:   Wed, 16 Oct 2019 10:41:56 +0200
Message-Id: <20191016084158.7573-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191016084158.7573-1-jthumshirn@suse.de>
References: <20191016084158.7573-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add auth_key argument to open_ctree_fs_info() so we have the key once we
create a new fs_info.

XXX: Remove as much auth_key = NULL callers as possible.

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
index 741eb9a95ac5..4cde76d82bde 100644
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
index d009f33e9657..65af60cac7f2 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10021,7 +10021,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		ctree_flags |= OPEN_CTREE_PARTIAL;
 
 	info = open_ctree_fs_info(argv[optind], bytenr, tree_root_bytenr,
-				  chunk_root_bytenr, ctree_flags);
+				  chunk_root_bytenr, ctree_flags, NULL);
 	if (!info) {
 		error("cannot open file system");
 		ret = -EIO;
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089abeaa..e9b7a287424f 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -585,7 +585,7 @@ static int map_seed_devices(struct list_head *all_uuids)
 		 * open_ctree_* detects seed/sprout mapping
 		 */
 		fs_info = open_ctree_fs_info(device->name, 0, 0, 0,
-						OPEN_CTREE_PARTIAL);
+						OPEN_CTREE_PARTIAL, NULL);
 		if (!fs_info)
 			continue;
 
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index e5efe2470111..56a85625e2c1 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -454,7 +454,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 
 	printf("%s\n", PACKAGE_STRING);
 
-	info = open_ctree_fs_info(argv[optind], 0, 0, 0, open_ctree_flags);
+	info = open_ctree_fs_info(argv[optind], 0, 0, 0, open_ctree_flags, NULL);
 	if (!info) {
 		error("unable to open %s", argv[optind]);
 		goto out;
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 0896cea674ab..720881d9b93a 100644
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
index e8eab6808bc3..90a7efa4f196 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -241,7 +241,7 @@ static int cmd_rescue_fix_device_size(const struct cmd_struct *cmd,
 	}
 
 	fs_info = open_ctree_fs_info(devname, 0, 0, 0, OPEN_CTREE_WRITES |
-				     OPEN_CTREE_PARTIAL);
+				     OPEN_CTREE_PARTIAL, NULL);
 	if (!fs_info) {
 		error("could not open btrfs");
 		ret = -EIO;
diff --git a/cmds/restore.c b/cmds/restore.c
index c104b01aef69..d7f011c6d352 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -1290,7 +1290,7 @@ static struct btrfs_root *open_fs(const char *dev, u64 root_location,
 		 */
 		fs_info = open_ctree_fs_info(dev, bytenr, root_location, 0,
 					     OPEN_CTREE_PARTIAL |
-					     OPEN_CTREE_NO_BLOCK_GROUPS);
+					     OPEN_CTREE_NO_BLOCK_GROUPS, NULL);
 		if (fs_info)
 			break;
 		fprintf(stderr, "Could not open root, trying backup super\n");
diff --git a/disk-io.c b/disk-io.c
index e68f28e72077..5de6daf1563a 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -769,7 +769,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	free(fs_info);
 }
 
-struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
+struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr,
+					char *auth_key)
 {
 	struct btrfs_fs_info *fs_info;
 
@@ -1165,7 +1166,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 					     u64 sb_bytenr,
 					     u64 root_tree_bytenr,
 					     u64 chunk_root_bytenr,
-					     unsigned flags)
+					     unsigned flags, char *auth_key)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_super_block *disk_super;
@@ -1182,7 +1183,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
 	if (posix_fadvise(fp, 0, 0, POSIX_FADV_DONTNEED))
 		fprintf(stderr, "Warning, could not drop caches\n");
 
-	fs_info = btrfs_new_fs_info(flags & OPEN_CTREE_WRITES, sb_bytenr);
+	fs_info = btrfs_new_fs_info(flags & OPEN_CTREE_WRITES, sb_bytenr,
+				    auth_key);
 	if (!fs_info) {
 		fprintf(stderr, "Failed to allocate memory for fs_info\n");
 		return NULL;
@@ -1292,7 +1294,7 @@ out:
 struct btrfs_fs_info *open_ctree_fs_info(const char *filename,
 					 u64 sb_bytenr, u64 root_tree_bytenr,
 					 u64 chunk_root_bytenr,
-					 unsigned flags)
+					 unsigned flags, char *auth_key)
 {
 	int fp;
 	int ret;
@@ -1319,7 +1321,7 @@ struct btrfs_fs_info *open_ctree_fs_info(const char *filename,
 		return NULL;
 	}
 	info = __open_ctree_fd(fp, filename, sb_bytenr, root_tree_bytenr,
-			       chunk_root_bytenr, flags);
+			       chunk_root_bytenr, flags, auth_key);
 	close(fp);
 	return info;
 }
@@ -1331,7 +1333,7 @@ struct btrfs_root *open_ctree(const char *filename, u64 sb_bytenr,
 
 	/* This flags may not return fs_info with any valid root */
 	BUG_ON(flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR);
-	info = open_ctree_fs_info(filename, sb_bytenr, 0, 0, flags);
+	info = open_ctree_fs_info(filename, sb_bytenr, 0, 0, flags, NULL);
 	if (!info)
 		return NULL;
 	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
@@ -1350,7 +1352,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 				(unsigned long long)flags);
 		return NULL;
 	}
-	info = __open_ctree_fd(fp, path, sb_bytenr, 0, 0, flags);
+	info = __open_ctree_fd(fp, path, sb_bytenr, 0, 0, flags, NULL);
 	if (!info)
 		return NULL;
 	if (flags & __OPEN_CTREE_RETURN_CHUNK_ROOT)
diff --git a/disk-io.h b/disk-io.h
index bb093ae69d57..237b8df28d47 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -140,7 +140,8 @@ void btrfs_setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 int clean_tree_block(struct extent_buffer *buf);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
-struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr);
+struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr,
+					char *auth_key);
 int btrfs_check_fs_compatibility(struct btrfs_super_block *sb,
 				 unsigned int flags);
 int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
@@ -160,7 +161,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 struct btrfs_fs_info *open_ctree_fs_info(const char *filename,
 					 u64 sb_bytenr, u64 root_tree_bytenr,
 					 u64 chunk_root_bytenr,
-					 unsigned flags);
+					 unsigned flags, char *auth_key);
 int close_ctree_fs_info(struct btrfs_fs_info *fs_info);
 static inline int close_ctree(struct btrfs_root *root)
 {
diff --git a/image/main.c b/image/main.c
index b87525412543..5663fe83ff0b 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2383,7 +2383,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 		info = open_ctree_fs_info(target, 0, 0, 0,
 					  OPEN_CTREE_WRITES |
 					  OPEN_CTREE_RESTORE |
-					  OPEN_CTREE_PARTIAL);
+					  OPEN_CTREE_PARTIAL,
+					  NULL);
 		if (!info) {
 			error("open ctree failed");
 			ret = -EIO;
@@ -2745,7 +2746,7 @@ int BOX_MAIN(image)(int argc, char *argv[])
 
 		info = open_ctree_fs_info(target, 0, 0, 0,
 					  OPEN_CTREE_PARTIAL |
-					  OPEN_CTREE_RESTORE);
+					  OPEN_CTREE_RESTORE, NULL);
 		if (!info) {
 			error("open ctree failed at %s", target);
 			return 1;
diff --git a/mkfs/main.c b/mkfs/main.c
index 1a4578412b41..aca104a4bd57 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1217,7 +1217,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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

