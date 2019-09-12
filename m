Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64EB0716
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfILDLt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:11:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729277AbfILDLs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:11:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05ABAAFA8
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 03:11:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/6] btrfs-progs: check/original: Fix inode mode in subvolume trees
Date:   Thu, 12 Sep 2019 11:11:34 +0800
Message-Id: <20190912031135.79696-6-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912031135.79696-1-wqu@suse.com>
References: <20190912031135.79696-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To make original mode to repair imode error in subvolume trees, this
patch will do:
- Remove the show-stopper checks for root->objectid.
  Now repair_imode_original() will accept inodes in subvolume trees.

- Export detect_imode() for original mode
  Due to the call requirement, original mode must use an existing trans
  handler to do the repair, thus we need to re-implement most of the
  work done in repair_imode_common().

- Make repair_imode_original() to use detect_imode().

- Free the path after reset_imode()
  reset_imode() keeps the path, as lowmem mode uses path to locate its
  current check position.
  But for original mode, the unreleased path can cause later repair to
  report warning, so we need to manually release the path.

- Update rec->imode after imode reset
  So later repair depending on rec->imode can get correct value.

- Move the repair before repair_inode_nlinks()
  repair_inode_nlinks() needs correct imode to add DIR_INDEX/DIR_ITEM.
  So moving the repair before repair_inode_nlinks() makes the latter
  repair happier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        | 41 ++++++++++++++++++++++++++++++-----------
 check/mode-common.c |  2 +-
 check/mode-common.h |  2 ++
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/check/main.c b/check/main.c
index 902279740589..8bdc9c69fa46 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2756,22 +2756,40 @@ static int repair_imode_original(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 struct inode_record *rec)
 {
+	struct btrfs_key key;
 	int ret;
 	u32 imode;
 
-	if (root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID)
-		return -ENOTTY;
-	if (rec->ino != BTRFS_ROOT_TREE_DIR_OBJECTID || !is_fstree(rec->ino))
-		return -ENOTTY;
+	key.objectid = rec->ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
 
-	if (rec->ino == BTRFS_ROOT_TREE_DIR_OBJECTID)
-		imode = 040755;
-	else
-		imode = 0100600;
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		return ret;
+
+	if (root->objectid == BTRFS_ROOT_TREE_OBJECTID) {
+		/* In root tree we only have two possible imode */
+		if (rec->ino == BTRFS_ROOT_TREE_OBJECTID)
+			imode = S_IFDIR | 0755;
+		else
+			imode = S_IFREG | 0600;
+	} else {
+		ret = detect_imode(root, path, &imode);
+		if (ret < 0) {
+			btrfs_release_path(path);
+			return ret;
+		}
+	}
+	btrfs_release_path(path);
 	ret = reset_imode(trans, root, path, rec->ino, imode);
+	btrfs_release_path(path);
 	if (ret < 0)
 		return ret;
 	rec->errors &= ~I_ERR_INVALID_IMODE;
+	rec->imode = imode;
 	return ret;
 }
 
@@ -2795,7 +2813,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 			     I_ERR_FILE_NBYTES_WRONG |
 			     I_ERR_INLINE_RAM_BYTES_WRONG |
 			     I_ERR_MISMATCH_DIR_HASH |
-			     I_ERR_UNALIGNED_EXTENT_REC)))
+			     I_ERR_UNALIGNED_EXTENT_REC |
+			     I_ERR_INVALID_IMODE)))
 		return rec->errors;
 
 	/*
@@ -2812,6 +2831,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 	btrfs_init_path(&path);
 	if (!ret && rec->errors & I_ERR_MISMATCH_DIR_HASH)
 		ret = repair_mismatch_dir_hash(trans, root, rec);
+	if (!ret && rec->errors & I_ERR_INVALID_IMODE)
+		ret = repair_imode_original(trans, root, &path, rec);
 	if (rec->errors & I_ERR_NO_INODE_ITEM)
 		ret = repair_inode_no_item(trans, root, &path, rec);
 	if (!ret && rec->errors & I_ERR_FILE_EXTENT_DISCOUNT)
@@ -2828,8 +2849,6 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 		ret = repair_inline_ram_bytes(trans, root, &path, rec);
 	if (!ret && rec->errors & I_ERR_UNALIGNED_EXTENT_REC)
 		ret = repair_unaligned_extent_recs(trans, root, &path, rec);
-	if (!ret && rec->errors & I_ERR_INVALID_IMODE)
-		ret = repair_imode_original(trans, root, &path, rec);
 	btrfs_commit_transaction(trans, root);
 	btrfs_release_path(&path);
 	return ret;
diff --git a/check/mode-common.c b/check/mode-common.c
index bc566e4aa03e..10ad6d228a03 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -965,7 +965,7 @@ static int find_file_type(struct btrfs_root *root, u64 ino, u64 dirid,
 				       imode_ret);
 }
 
-static int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
+int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
 			u32 *imode_ret)
 {
 	struct btrfs_key key;
diff --git a/check/mode-common.h b/check/mode-common.h
index 6c8d6d7578a6..edf9257edaf0 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -126,6 +126,8 @@ int delete_corrupted_dir_item(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root,
 			      struct btrfs_key *di_key, char *namebuf,
 			      u32 namelen);
+int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
+		 u32 *imode_ret);
 int reset_imode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		struct btrfs_path *path, u64 ino, u32 mode);
 int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path);
-- 
2.23.0

