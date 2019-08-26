Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4289CABD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfHZHks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 03:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728220AbfHZHkr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 03:40:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C8A54B05C
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 07:40:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: tree-checker: Try to detect missing INODE_ITEM
Date:   Mon, 26 Aug 2019 15:40:38 +0800
Message-Id: <20190826074039.28517-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190826074039.28517-1-wqu@suse.com>
References: <20190826074039.28517-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the following items, key->objectid is inode number:
- DIR_ITEM
- DIR_INDEX
- XATTR_ITEM
- EXTENT_DATA
- INODE_REF

So in btrfs btree, such items must have its previous item shares the
same objectid, e.g.:
 (257 INODE_ITEM 0)
 (257 DIR_INDEX xxx)
 (257 DIR_ITEM xxx)
 (258 INODE_ITEM 0)
 (258 INODE_REF 0)
 (258 XATTR_ITEM 0)
 (258 EXTENT_DATA 0)

But if we have the following sequence, then there is definitely
something wrong, normally some INODE_ITEM is missing, like:
 (257 INODE_ITEM 0)
 (257 DIR_INDEX xxx)
 (257 DIR_ITEM xxx)
 (258 XATTR_ITEM 0)  <<< objecitd suddenly changed to 258
 (258 EXTENT_DATA 0)

So just by checking the previous key for above inode based key types, we
can detect missing inode item.

For INODE_REF key type, the check will be added along with INODE_REF
checker.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ccd5706199d7..636ce1b4566e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -141,6 +141,19 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
+	/*
+	 * Previous key must have the same key->objectid (ino).
+	 * It can be XATTR_ITEM, INODE_ITEM or just another EXTENT_DATA.
+	 * But if objectids mismatch, it means we have a missing
+	 * INODE_ITEM.
+	 */
+	if (slot > 0 && prev_key->objectid != key->objectid) {
+		file_extent_err(leaf, slot,
+		"invalid previous key objectid, have %llu expect %llu",
+				prev_key->objectid, key->objectid);
+		return -EUCLEAN;
+	}
+
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
 	if (btrfs_file_extent_type(leaf, fi) > BTRFS_FILE_EXTENT_TYPES) {
@@ -299,13 +312,21 @@ static void dir_item_err(const struct extent_buffer *eb, int slot,
 }
 
 static int check_dir_item(struct extent_buffer *leaf,
-			  struct btrfs_key *key, int slot)
+			  struct btrfs_key *key, struct btrfs_key *prev_key,
+			  int slot)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_dir_item *di;
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
 	u32 cur = 0;
 
+	/* Same check as in check_extent_data_item() */
+	if (slot > 0 && prev_key->objectid != key->objectid) {
+		dir_item_err(leaf, slot,
+		"invalid previous key objectid, have %llu expect %llu",
+			     prev_key->objectid, key->objectid);
+		return -EUCLEAN;
+	}
 	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 	while (cur < item_size) {
 		u32 name_len;
@@ -841,7 +862,7 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_DIR_ITEM_KEY:
 	case BTRFS_DIR_INDEX_KEY:
 	case BTRFS_XATTR_ITEM_KEY:
-		ret = check_dir_item(leaf, key, slot);
+		ret = check_dir_item(leaf, key, prev_key, slot);
 		break;
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		ret = check_block_group_item(leaf, key, slot);
-- 
2.23.0

