Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90AC116B83
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 11:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLIKym (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 05:54:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:40212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfLIKym (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 05:54:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FB73AD6C
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2019 10:54:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: tree-checker: Clean up fs_info parameter from error message wrapper
Date:   Mon,  9 Dec 2019 18:54:32 +0800
Message-Id: <20191209105435.36041-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The @fs_info parameter can be extracted from extent_buffer structure,
and there are already some wrappers getting rid of the @fs_info
parameter.

This patch will finish the cleanup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 493d4d9e0f79..6cb49c75c5e1 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -787,7 +787,7 @@ static int check_dev_item(struct extent_buffer *leaf,
 }
 
 /* Inode item error output has the same format as dir_item_err() */
-#define inode_item_err(fs_info, eb, slot, fmt, ...)			\
+#define inode_item_err(eb, slot, fmt, ...)			\
 	dir_item_err(eb, slot, fmt, __VA_ARGS__)
 
 static int check_inode_item(struct extent_buffer *leaf,
@@ -812,7 +812,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	if (key->offset != 0) {
-		inode_item_err(fs_info, leaf, slot,
+		inode_item_err(leaf, slot,
 			"invalid key offset: has %llu expect 0",
 			key->offset);
 		return -EUCLEAN;
@@ -821,7 +821,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 
 	/* Here we use super block generation + 1 to handle log tree */
 	if (btrfs_inode_generation(leaf, iitem) > super_gen + 1) {
-		inode_item_err(fs_info, leaf, slot,
+		inode_item_err(leaf, slot,
 			"invalid inode generation: has %llu expect (0, %llu]",
 			       btrfs_inode_generation(leaf, iitem),
 			       super_gen + 1);
@@ -829,7 +829,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 	}
 	/* Note for ROOT_TREE_DIR_ITEM, mkfs could set its transid 0 */
 	if (btrfs_inode_transid(leaf, iitem) > super_gen + 1) {
-		inode_item_err(fs_info, leaf, slot,
+		inode_item_err(leaf, slot,
 			"invalid inode generation: has %llu expect [0, %llu]",
 			       btrfs_inode_transid(leaf, iitem), super_gen + 1);
 		return -EUCLEAN;
@@ -842,7 +842,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 	 */
 	mode = btrfs_inode_mode(leaf, iitem);
 	if (mode & ~valid_mask) {
-		inode_item_err(fs_info, leaf, slot,
+		inode_item_err(leaf, slot,
 			       "unknown mode bit detected: 0x%x",
 			       mode & ~valid_mask);
 		return -EUCLEAN;
@@ -855,20 +855,20 @@ static int check_inode_item(struct extent_buffer *leaf,
 	 */
 	if (!has_single_bit_set(mode & S_IFMT)) {
 		if (!S_ISLNK(mode) && !S_ISBLK(mode) && !S_ISSOCK(mode)) {
-			inode_item_err(fs_info, leaf, slot,
+			inode_item_err(leaf, slot,
 			"invalid mode: has 0%o expect valid S_IF* bit(s)",
 				       mode & S_IFMT);
 			return -EUCLEAN;
 		}
 	}
 	if (S_ISDIR(mode) && btrfs_inode_nlink(leaf, iitem) > 1) {
-		inode_item_err(fs_info, leaf, slot,
+		inode_item_err(leaf, slot,
 		       "invalid nlink: has %u expect no more than 1 for dir",
 			btrfs_inode_nlink(leaf, iitem));
 		return -EUCLEAN;
 	}
 	if (btrfs_inode_flags(leaf, iitem) & ~BTRFS_INODE_FLAG_MASK) {
-		inode_item_err(fs_info, leaf, slot,
+		inode_item_err(leaf, slot,
 			       "unknown flags detected: 0x%llx",
 			       btrfs_inode_flags(leaf, iitem) &
 			       ~BTRFS_INODE_FLAG_MASK);
@@ -1288,8 +1288,8 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 	return 0;
 }
 
-#define inode_ref_err(fs_info, eb, slot, fmt, args...)			\
-	inode_item_err(fs_info, eb, slot, fmt, ##args)
+#define inode_ref_err(eb, slot, fmt, args...)			\
+	inode_item_err(eb, slot, fmt, ##args)
 static int check_inode_ref(struct extent_buffer *leaf,
 			   struct btrfs_key *key, struct btrfs_key *prev_key,
 			   int slot)
@@ -1302,7 +1302,7 @@ static int check_inode_ref(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	/* namelen can't be 0, so item_size == sizeof() is also invalid */
 	if (btrfs_item_size_nr(leaf, slot) <= sizeof(*iref)) {
-		inode_ref_err(fs_info, leaf, slot,
+		inode_ref_err(leaf, slot,
 			"invalid item size, have %u expect (%zu, %u)",
 			btrfs_item_size_nr(leaf, slot),
 			sizeof(*iref), BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
@@ -1315,7 +1315,7 @@ static int check_inode_ref(struct extent_buffer *leaf,
 		u16 namelen;
 
 		if (ptr + sizeof(iref) > end) {
-			inode_ref_err(fs_info, leaf, slot,
+			inode_ref_err(leaf, slot,
 			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
 				ptr, end, sizeof(iref));
 			return -EUCLEAN;
@@ -1324,7 +1324,7 @@ static int check_inode_ref(struct extent_buffer *leaf,
 		iref = (struct btrfs_inode_ref *)ptr;
 		namelen = btrfs_inode_ref_name_len(leaf, iref);
 		if (ptr + sizeof(*iref) + namelen > end) {
-			inode_ref_err(fs_info, leaf, slot,
+			inode_ref_err(leaf, slot,
 				"inode ref overflow, ptr %lu end %lu namelen %u",
 				ptr, end, namelen);
 			return -EUCLEAN;
-- 
2.24.0

