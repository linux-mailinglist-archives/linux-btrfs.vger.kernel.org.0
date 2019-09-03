Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F398A63C6
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 10:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfICIYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 04:24:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:53132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726452AbfICIYP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 04:24:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88281B63F
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2019 08:24:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: check/common: Make repair_imode_common() to handle inodes in subvolume trees
Date:   Tue,  3 Sep 2019 16:24:04 +0800
Message-Id: <20190903082407.13927-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190903082407.13927-1-wqu@suse.com>
References: <20190903082407.13927-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, repair_imode_common() can only handle two types of
inodes:
- Free space cache inodes
- ROOT DIR inodes

For inodes in subvolume trees, the problem is how to determine the
correct imode, thus it was not implemented.

However there are more reports of incorrect imode in subvolume trees, we
need to support such fix.

So this patch adds a new function, detect_imode(), to detect (or call it
educated guess) imode for inodes in subvolume trees.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 96 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 195b6efaa7aa..807d7daf98a6 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -836,6 +836,80 @@ int reset_imode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return ret;
 }
 
+static int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
+			u32 *imode_ret)
+{
+	struct btrfs_key key;
+	struct btrfs_inode_item *iitem;
+	const u32 priv = 0700;
+	u64 ino;
+	u32 imode = S_IFREG;
+	int ret = 0;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ino = key.objectid;
+	iitem = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			       struct btrfs_inode_item);
+
+	/*
+	 * Both CHR and BLK uses rdev, no way to distinguish them, so fall back
+	 * to BLK.
+	 */
+	if (btrfs_inode_rdev(path->nodes[0], iitem) != 0) {
+		imode = S_IFBLK;
+		goto out;
+	}
+
+	/* root inode */
+	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
+		imode = S_IFDIR;
+		goto out;
+	}
+
+	while (1) {
+		ret = btrfs_next_item(root, path);
+		if (ret > 0) {
+			/* No determining result found, falls back to REG */
+			ret = 0;
+			goto out;
+		}
+		if (ret < 0)
+			goto out;
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		if (key.objectid != ino)
+			goto out;
+
+		/*
+		 * We ignore some types to make life easier:
+		 * - INODE_REF
+		 *   We need to do a full tree search, which can fail for
+		 *   corrupted fs, but not worthy compared to other easier
+		 *   to determine types.
+		 * - XATTR
+		 *   Both REG and DIR can have xattr, so not useful
+		 */
+		switch (key.type) {
+		case BTRFS_DIR_ITEM_KEY:
+		case BTRFS_DIR_INDEX_KEY:
+			imode = S_IFDIR;
+			goto out;
+		case BTRFS_EXTENT_DATA_KEY:
+			/*
+			 * Both REG and LINK could have EXTENT_DATA.
+			 * We just fall back to REG as user can inspect the
+			 * content.
+			 */
+			imode = S_IFREG;
+			goto out;
+		}
+	}
+
+out:
+	/* Set default value even when something wrong happened */
+	*imode_ret = (imode | priv);
+	return ret;
+}
+
 /*
  * Reset the inode mode of the inode specified by @path.
  *
@@ -852,22 +926,18 @@ int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path)
 	u32 imode;
 	int ret;
 
-	if (root->root_key.objectid != BTRFS_ROOT_TREE_OBJECTID) {
-		error(
-		"repair inode mode outside of root tree is not supported yet");
-		return -ENOTTY;
-	}
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 	ASSERT(key.type == BTRFS_INODE_ITEM_KEY);
-	if (key.objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
-	    !is_fstree(key.objectid)) {
-		error("unsupported ino %llu", key.objectid);
-		return -ENOTTY;
+	if (root->objectid == BTRFS_ROOT_TREE_OBJECTID) {
+		/* In root tree we only have two possible imode */
+		if (key.objectid == BTRFS_ROOT_TREE_OBJECTID)
+			imode = S_IFDIR | 0755;
+		else
+			imode = S_IFREG | 0600;
+	} else {
+		detect_imode(root, path, &imode);
+		/* Ignore error returned, just use the default value returned */
 	}
-	if (key.objectid == BTRFS_ROOT_TREE_DIR_OBJECTID)
-		imode = 040755;
-	else
-		imode = 0100600;
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
-- 
2.23.0

