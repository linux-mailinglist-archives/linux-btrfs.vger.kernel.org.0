Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 735DDCB75E
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfJDJbl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 05:31:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:39464 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729093AbfJDJbl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 05:31:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 091F5B0A5
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2019 09:31:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: tree-checker: Refactor prev_key check for ino into a function
Date:   Fri,  4 Oct 2019 17:31:32 +0800
Message-Id: <20191004093133.83582-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004093133.83582-1-wqu@suse.com>
References: <20191004093133.83582-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor the check for prev_key->objectid of the following key types
into one function, check_prev_ino():
- EXTENT_DATA
- INODE_REF
- DIR_INDEX
- DIR_ITEM
- XATTR_ITEM

Despite the refactor, also add the check of prev_key for INODE_REF.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 113 +++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 5e34cd5e3e2e..73678393340a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -125,6 +125,74 @@ static u64 file_extent_end(struct extent_buffer *leaf,
 	return end;
 }
 
+/*
+ * Customized reported for dir_item, only important new info is key->objectid,
+ * which represents inode number
+ */
+__printf(3, 4)
+__cold
+static void dir_item_err(const struct extent_buffer *eb, int slot,
+			 const char *fmt, ...)
+{
+	const struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_key key;
+	struct va_format vaf;
+	va_list args;
+
+	btrfs_item_key_to_cpu(eb, &key, slot);
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	btrfs_crit(fs_info,
+	"corrupt %s: root=%llu block=%llu slot=%d ino=%llu, %pV",
+		btrfs_header_level(eb) == 0 ? "leaf" : "node",
+		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+		key.objectid, &vaf);
+	va_end(args);
+}
+
+/*
+ * This functions checks prev_key->objectid, to ensure current key and prev_key
+ * shares the same objectid as ino.
+ *
+ * This is to detect missing INODE_ITEM in subvolume trees.
+ *
+ * Return true if everything is OK or we don't need to check.
+ * Return false if anything is wrong.
+ */
+static bool check_prev_ino(struct extent_buffer *leaf,
+			   struct btrfs_key *key, int slot,
+			   struct btrfs_key *prev_key)
+{
+	/* No prev key, skip check */
+	if (slot == 0)
+		return true;
+
+	/* Only these key->types needs to be checked */
+	ASSERT(key->type == BTRFS_XATTR_ITEM_KEY ||
+	       key->type == BTRFS_INODE_REF_KEY ||
+	       key->type == BTRFS_DIR_INDEX_KEY ||
+	       key->type == BTRFS_DIR_ITEM_KEY ||
+	       key->type == BTRFS_EXTENT_DATA_KEY);
+
+	/*
+	 * Only subvolume trees along with their reloc trees needs this check.
+	 * Things like log tree doesn't follow this ino requirement.
+	 */
+	if (!is_fstree(btrfs_header_owner(leaf)))
+		return true;
+
+	if (key->objectid == prev_key->objectid)
+		return true;
+
+	/* Error found */
+	dir_item_err(leaf, slot,
+		"invalid previous key objectid, have %llu expect %llu",
+		prev_key->objectid, key->objectid);
+	return false;
+}
 static int check_extent_data_item(struct extent_buffer *leaf,
 				  struct btrfs_key *key, int slot,
 				  struct btrfs_key *prev_key)
@@ -148,13 +216,8 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * But if objectids mismatch, it means we have a missing
 	 * INODE_ITEM.
 	 */
-	if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
-	    prev_key->objectid != key->objectid) {
-		file_extent_err(leaf, slot,
-		"invalid previous key objectid, have %llu expect %llu",
-				prev_key->objectid, key->objectid);
+	if (!check_prev_ino(leaf, key, slot, prev_key))
 		return -EUCLEAN;
-	}
 
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
@@ -285,34 +348,6 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	return 0;
 }
 
-/*
- * Customized reported for dir_item, only important new info is key->objectid,
- * which represents inode number
- */
-__printf(3, 4)
-__cold
-static void dir_item_err(const struct extent_buffer *eb, int slot,
-			 const char *fmt, ...)
-{
-	const struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct btrfs_key key;
-	struct va_format vaf;
-	va_list args;
-
-	btrfs_item_key_to_cpu(eb, &key, slot);
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	btrfs_crit(fs_info,
-	"corrupt %s: root=%llu block=%llu slot=%d ino=%llu, %pV",
-		btrfs_header_level(eb) == 0 ? "leaf" : "node",
-		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
-		key.objectid, &vaf);
-	va_end(args);
-}
-
 static int check_dir_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, struct btrfs_key *prev_key,
 			  int slot)
@@ -322,14 +357,8 @@ static int check_dir_item(struct extent_buffer *leaf,
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
 	u32 cur = 0;
 
-	/* Same check as in check_extent_data_item() */
-	if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
-	    prev_key->objectid != key->objectid) {
-		dir_item_err(leaf, slot,
-		"invalid previous key objectid, have %llu expect %llu",
-			     prev_key->objectid, key->objectid);
+	if (!check_prev_ino(leaf, key, slot, prev_key))
 		return -EUCLEAN;
-	}
 	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 	while (cur < item_size) {
 		u32 name_len;
@@ -1266,6 +1295,8 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	unsigned long ptr;
 	unsigned long end;
 
+	if (!check_prev_ino(leaf, key, slot, prev_key))
+		return -EUCLEAN;
 	/* namelen can't be 0, so item_size == sizeof() is also invalid */
 	if (btrfs_item_size_nr(leaf, slot) <= sizeof(*iref)) {
 		inode_ref_err(fs_info, leaf, slot,
-- 
2.23.0

