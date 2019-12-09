Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C53116B85
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfLIKyo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 05:54:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727283AbfLIKyn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 05:54:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E798AD79
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2019 10:54:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: tree-checker: Refactor inode key check into seperate function
Date:   Mon,  9 Dec 2019 18:54:33 +0800
Message-Id: <20191209105435.36041-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209105435.36041-1-wqu@suse.com>
References: <20191209105435.36041-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inode key check is not as easy as several lines, and it will be called
in more than one location (INODE_ITEM check and
DIR_ITEM/DIR_INDEX/XATTR_ITEM location key check).

So here refactor such check into check_inode_key().

And add extra checks for XATTR_ITEM.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 77 +++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6cb49c75c5e1..68dad9ec38dd 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -359,6 +359,60 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	return 0;
 }
 
+/* Inode item error output has the same format as dir_item_err() */
+#define inode_item_err(eb, slot, fmt, ...)			\
+	dir_item_err(eb, slot, fmt, __VA_ARGS__)
+
+static int check_inode_key(struct extent_buffer *leaf, struct btrfs_key *key,
+			   int slot)
+{
+	struct btrfs_key item_key;
+	bool is_inode_item;
+
+	btrfs_item_key_to_cpu(leaf, &item_key, slot);
+	is_inode_item = (item_key.type == BTRFS_INODE_ITEM_KEY);
+
+	/* For XATTR_ITEM, location key should be all 0 */
+	if (item_key.type == BTRFS_XATTR_ITEM_KEY) {
+		if (key->type != 0 || key->objectid != 0 || key->offset != 0)
+			return -EUCLEAN;
+		return 0;
+	}
+
+	if ((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
+	     key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
+	    key->objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
+	    key->objectid != BTRFS_FREE_INO_OBJECTID) {
+		if (is_inode_item)
+			generic_err(leaf, slot,
+	"invalid key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
+				key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
+				BTRFS_FIRST_FREE_OBJECTID,
+				BTRFS_LAST_FREE_OBJECTID,
+				BTRFS_FREE_INO_OBJECTID);
+		else
+			dir_item_err(leaf, slot,
+"invalid location key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
+				key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
+				BTRFS_FIRST_FREE_OBJECTID,
+				BTRFS_LAST_FREE_OBJECTID,
+				BTRFS_FREE_INO_OBJECTID);
+		return -EUCLEAN;
+	}
+	if (key->offset != 0) {
+		if (is_inode_item)
+			inode_item_err(leaf, slot,
+				       "invalid key offset: has %llu expect 0",
+				       key->offset);
+		else
+			dir_item_err(leaf, slot,
+				"invalid location key offset:has %llu expect 0",
+				key->offset);
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 static int check_dir_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, struct btrfs_key *prev_key,
 			  int slot)
@@ -798,25 +852,12 @@ static int check_inode_item(struct extent_buffer *leaf,
 	u64 super_gen = btrfs_super_generation(fs_info->super_copy);
 	u32 valid_mask = (S_IFMT | S_ISUID | S_ISGID | S_ISVTX | 0777);
 	u32 mode;
+	int ret;
+
+	ret = check_inode_key(leaf, key, slot);
+	if (ret < 0)
+		return ret;
 
-	if ((key->objectid < BTRFS_FIRST_FREE_OBJECTID ||
-	     key->objectid > BTRFS_LAST_FREE_OBJECTID) &&
-	    key->objectid != BTRFS_ROOT_TREE_DIR_OBJECTID &&
-	    key->objectid != BTRFS_FREE_INO_OBJECTID) {
-		generic_err(leaf, slot,
-	"invalid key objectid: has %llu expect %llu or [%llu, %llu] or %llu",
-			    key->objectid, BTRFS_ROOT_TREE_DIR_OBJECTID,
-			    BTRFS_FIRST_FREE_OBJECTID,
-			    BTRFS_LAST_FREE_OBJECTID,
-			    BTRFS_FREE_INO_OBJECTID);
-		return -EUCLEAN;
-	}
-	if (key->offset != 0) {
-		inode_item_err(leaf, slot,
-			"invalid key offset: has %llu expect 0",
-			key->offset);
-		return -EUCLEAN;
-	}
 	iitem = btrfs_item_ptr(leaf, slot, struct btrfs_inode_item);
 
 	/* Here we use super block generation + 1 to handle log tree */
-- 
2.24.0

