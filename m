Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF716A9C6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2019 09:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfIEH6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Sep 2019 03:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:48020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731732AbfIEH6Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Sep 2019 03:58:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD9D7AD6B
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2019 07:58:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/6] btrfs-progs: check/common: Make repair_imode_common() to handle inodes in subvolume trees
Date:   Thu,  5 Sep 2019 15:57:57 +0800
Message-Id: <20190905075800.1633-4-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190905075800.1633-1-wqu@suse.com>
References: <20190905075800.1633-1-wqu@suse.com>
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

For inodes in subvolume trees, the core complexity is how to determine the
correct imode, thus it was not implemented.

However there are more reports of incorrect imode in subvolume trees, we
need to support such fix.

So this patch adds a new function, detect_imode(), to detect imode for
inodes in subvolume trees.

That function will determine imode by:
- Search for INODE_REF
  If we have INODE_REF, we will then try to find DIR_ITEM/DIR_INDEX.
  As long as one valid DIR_ITEM or DIR_INDEX can be found, we convert
  the BTRFS_FT_* to imode, then call it a day.
  This should be the most accurate way.

- Search for DIR_INDEX/DIR_ITEM
  If above search fails, we falls back to locate the DIR_INDEX/DIR_ITEM
  just after the INODE_ITEM.
  If any can be found, it's definitely a directory.

- Search for EXTENT_DATA
  If EXTENT_DATA can be found, it's either REG or LNK.
  For this case, we default to REG, as user can inspect the file to
  determine if it's a file or just a path.

- Use rdev to detect BLK/CHR
  If all above fails, but INODE_ITEM has non-zero rdev, then it's either
  a BLK or CHR file. Then we default to BLK.

- Fail out if none of above methods succeeded
  No educated guess to make things worse.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 130 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 13 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index c0ddc50a1dd0..abea2ceda4c4 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -935,6 +935,113 @@ out:
 	return ret;
 }
 
+static int detect_imode(struct btrfs_root *root, struct btrfs_path *path,
+			u32 *imode_ret)
+{
+	struct btrfs_key key;
+	struct btrfs_inode_item iitem;
+	const u32 priv = 0700;
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
+	if (found)
+		*imode_ret = (imode | priv);
+	else
+		ret = -ENOENT;
+	return ret;
+}
+
 /*
  * Reset the inode mode of the inode specified by @path.
  *
@@ -951,22 +1058,19 @@ int repair_imode_common(struct btrfs_root *root, struct btrfs_path *path)
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

