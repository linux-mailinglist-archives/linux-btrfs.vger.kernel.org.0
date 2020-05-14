Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5474A1D2B87
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgENJfE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 05:35:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34275 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENJfD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 05:35:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id g14so13869827wme.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 02:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyyRSKMAVKxfsi0NoQ3Ox1JxNZIma3IVgvw1k3xlgIQ=;
        b=ALsRoWKr/OZAIZawvndjJGC8ZfstT60WmQsQOaIleWMBZdg63H1Nx7QwWxTNMIkP2h
         F2cwPKPps2cOdf0ibtA4SWthsqyPUlRmGti8mhLHxwjTriNOZhoThuPKdxmRk1Cx6cDM
         r2geuoC71o87X2ZQ/jP2uN/ZI4GYzpZ1ELm03oSRKty0U8AhrimlRy/ihvoWYznDanUm
         sSqMVu0LDiYDxFuz/t3n9FsyfVS6hOpdlVTvTR/4/RwohiTkvh1TogHyxLrHpEmxeNu0
         U9BDojU5zkhMeJQAZTiVFP9UYkKVRdTeM/T8KGuDAAh0EYRhP/0816XaqSSzc+9A+uhy
         yHkA==
X-Gm-Message-State: AGi0PuaKEIqnO6QZWc2mAA6qpYRIfYCMUG5LnjyL4ni9R/V/e0pjjy3f
        1+OzCo1xyOq3Sk+d7Y5itcIW10/9bwotMQ==
X-Google-Smtp-Source: APiQypLoAcMtT+Twe9T5onFcJ1MXYXg/VL3CQgt8kaQTsmNLByw2vXdgJVFNN0x0S8x01ohBTLV5Sg==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr50500368wmb.56.1589448900129;
        Thu, 14 May 2020 02:35:00 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id l12sm3522750wrh.20.2020.05.14.02.34.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:34:59 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 2/5] btrfs-progs: add auth_key argument to open_ctree_fs_info
Date:   Thu, 14 May 2020 11:34:30 +0200
Message-Id: <20200514093433.6818-3-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200514093433.6818-1-jth@kernel.org>
References: <20200514093433.6818-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

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
2.26.1

