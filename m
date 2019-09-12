Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 288AFB0715
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 05:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfILDLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 23:11:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729242AbfILDLr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 23:11:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97C2CB00E
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 03:11:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/6] btrfs-progs: check/common: Make repair_imode_common() to handle inodes in subvolume trees
Date:   Thu, 12 Sep 2019 11:11:32 +0800
Message-Id: <20190912031135.79696-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190912031135.79696-1-wqu@suse.com>
References: <20190912031135.79696-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[[PROBLEM]]
Before this patch, repair_imode_common() can only handle two types of
inodes:
- Free space cache inodes
- ROOT DIR inodes

For inodes in subvolume trees, the core complexity is how to determine the
correct imode, thus it was not implemented.

However there are more reports of incorrect imode in subvolume trees, we
need to support such fix.

[[ENHANCEMENT]]
So this patch adds a new function, detect_imode(), to detect imode for
inodes in subvolume trees.
The policy here is, try our best to find a valid imode to recovery.
If no convicing info can be found, fail out.

That function will determine imode by:
1) Search for INODE_REF of the inode
   If we have INODE_REF, we will then try to find DIR_ITEM/DIR_INDEX.
   As long as one valid DIR_ITEM or DIR_INDEX can be found, we convert
   the BTRFS_FT_* to imode, then call it a day.
   This should be the most accurate way.

2) Search for DIR_INDEX/DIR_ITEM belongs to this inode
   If above search fails, we falls back to locate the DIR_INDEX/DIR_ITEM
   just after the INODE_ITEM.
   Thus this only works for non-empty directory.
   If any can be found, it's definitely a directory.

3) Search for EXTENT_DATA belongs to this inode
   If EXTENT_DATA can be found, it's either REG or LNK.
   Thus this only works for non-empty file or soft link.
   For this case, we default to REG, as user can inspect the file to
   determine if it's a file or just a path.

4) Use rdev to detect BLK/CHR
   If all above fails, but INODE_ITEM has non-zero rdev, then it's either
   a BLK or CHR file. Then we default to BLK.

5) Fail out if none of above methods succeeded
   No educated guess to make things worse.

[[SHORTCOMING]]
The above search is not perfect, there are cases where we can't repair:
E.g. orphan empty regular inode.
Since it's already orphan, it has no INODE_REF. And it's regular empty
file, it has no DIR_INDEX nor EXTENT_DATA nor rdev. Thus we can't recover.
Although for this case, it really doesn't matter as it's already orphan
and will be deleted anyway.

Furthermore, due to the DIR_ITEM/DIR_INDEX/INODE_REF repair code which
can happen before imode repair, it's possible that DIR_ITEM search code
may not be executed.
If there is only DIR_ITEM remaining, repair code will remove the
DIR_ITEM completely and move the inode to lost+found, leaving us no
info to rebuild imode.
If there is DIR_INDEX missing, repair code will re-insert the DIR_INDEX,
then imode repair code will go DIR_INDEX directly.

But overall, the repair code should handle the invalid imode caused by
older kernels without problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 133 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 120 insertions(+), 13 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 9ccde5cdc2e5..bc566e4aa03e 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -965,6 +965,116 @@ static int find_file_type(struct btrfs_root *root, u64 ino, u64 dirid,
 				       imode_ret);
 }
 
+static int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
+			u32 *imode_ret)
+{
+	struct btrfs_key key;
+	struct btrfs_inode_item iitem;
+	bool found = false;
+	u64 ino;
+	u32 imode;
+	int ret = 0;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	ino = key.objectid;
+	read_extent_buffer(path->nodes[0], &iitem,
+			btrfs_item_ptr_offset(path->nodes[0], path->slots[0]),
+			sizeof(iitem));
+	/* root inode */
+	if (ino == BTRFS_FIRST_FREE_OBJECTID) {
+		imode = S_IFDIR;
+		found = true;
+		goto out;
+	}
+
+	while (1) {
+		struct btrfs_inode_ref *iref;
+		struct extent_buffer *leaf;
+		unsigned long cur;
+		unsigned long end;
+		char namebuf[BTRFS_NAME_LEN] = {0};
+		u64 index;
+		u32 namelen;
+		int slot;
+
+		ret = btrfs_next_item(root, path);
+		if (ret > 0) {
+			/* falls back to rdev check */
+			ret = 0;
+			goto out;
+		}
+		if (ret < 0)
+			goto out;
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+		btrfs_item_key_to_cpu(leaf, &key, slot);
+		if (key.objectid != ino)
+			goto out;
+
+		/*
+		 * We ignore some types to make life easier:
+		 * - XATTR
+		 *   Both REG and DIR can have xattr, so not useful
+		 */
+		switch (key.type) {
+		case BTRFS_INODE_REF_KEY:
+			/* The most accurate way to determine filetype */
+			cur = btrfs_item_ptr_offset(leaf, slot);
+			end = cur + btrfs_item_size_nr(leaf, slot);
+			while (cur < end) {
+				iref = (struct btrfs_inode_ref *)cur;
+				namelen = min_t(u32, end - cur - sizeof(&iref),
+					btrfs_inode_ref_name_len(leaf, iref));
+				index = btrfs_inode_ref_index(leaf, iref);
+				read_extent_buffer(leaf, namebuf,
+					(unsigned long)(iref + 1), namelen);
+				ret = find_file_type(root, ino, key.offset,
+						index, namebuf, namelen,
+						&imode);
+				if (ret == 0) {
+					found = true;
+					goto out;
+				}
+				cur += sizeof(*iref) + namelen;
+			}
+			break;
+		case BTRFS_DIR_ITEM_KEY:
+		case BTRFS_DIR_INDEX_KEY:
+			imode = S_IFDIR;
+			found = true;
+			goto out;
+		case BTRFS_EXTENT_DATA_KEY:
+			/*
+			 * Both REG and LINK could have EXTENT_DATA.
+			 * We just fall back to REG as user can inspect the
+			 * content.
+			 */
+			imode = S_IFREG;
+			found = true;
+			goto out;
+		}
+	}
+
+out:
+	/*
+	 * Both CHR and BLK uses rdev, no way to distinguish them, so fall back
+	 * to BLK. But either way it doesn't really matter, as CHR/BLK on btrfs
+	 * should be pretty rare, and no real data will be lost.
+	 */
+	if (!found && btrfs_stack_inode_rdev(&iitem) != 0) {
+		imode = S_IFBLK;
+		found = true;
+	}
+
+	if (found) {
+		ret = 0;
+		*imode_ret = (imode | 0700);
+	} else {
+		ret = -ENOENT;
+	}
+	return ret;
+}
+
 /*
  * Reset the inode mode of the inode specified by @path.
  *
@@ -981,22 +1091,19 @@ int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path)
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
+		ret = detect_imode(root, path, &imode);
+		if (ret < 0)
+			return ret;
 	}
-	if (key.objectid == BTRFS_ROOT_TREE_DIR_OBJECTID)
-		imode = 040755;
-	else
-		imode = 0100600;
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans)) {
-- 
2.23.0

