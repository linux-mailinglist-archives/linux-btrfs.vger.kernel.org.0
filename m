Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84092116B84
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLIKyo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 05:54:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:40238 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfLIKyn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 05:54:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5A33BAD2D
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Dec 2019 10:54:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: tree-checker: Refactor root key check into separate function
Date:   Mon,  9 Dec 2019 18:54:34 +0800
Message-Id: <20191209105435.36041-3-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209105435.36041-1-wqu@suse.com>
References: <20191209105435.36041-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ROOT_ITEM key check itself is not as simple as single line check, and
will be reused for both ROOT_ITEM and DIR_ITEM/DIR_INDEX location key
check, so refactor such check into check_root_key().

Also since we are here, fix a comment error about ROOT_ITEM offset,
which is transid of snapshot creation, not some "older kernel behavior".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 61 +++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 68dad9ec38dd..9a6743ee874a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -413,6 +413,48 @@ static int check_inode_key(struct extent_buffer *leaf, struct btrfs_key *key,
 	return 0;
 }
 
+static int check_root_key(struct extent_buffer *leaf, struct btrfs_key *key,
+			  int slot)
+{
+	struct btrfs_key item_key;
+	bool is_root_item;
+
+	btrfs_item_key_to_cpu(leaf, &item_key, slot);
+	is_root_item = (item_key.type == BTRFS_ROOT_ITEM_KEY);
+
+	/* No such tree id */
+	if (key->objectid == 0) {
+		if (is_root_item)
+			generic_err(leaf, slot, "invalid root id 0");
+		else
+			dir_item_err(leaf, slot,
+				     "invalid location key root id 0");
+		return -EUCLEAN;
+	}
+
+	/* DIR_ITEM/INDEX/INODE_REF is not allowed to point to non-fs trees */
+	if (!is_fstree(key->objectid) && !is_root_item) {
+		dir_item_err(leaf, slot,
+		"invalid location key objectid, have %llu expect [%llu, %llu]",
+				key->objectid, BTRFS_FIRST_FREE_OBJECTID,
+				BTRFS_LAST_FREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	/*
+	 * ROOT_ITEM with non-zero offset means, this is a snapshot, created at
+	 * @offset transid.
+	 * Furthermore, for location key in DIR_ITEM, its offset is always -1.
+	 *
+	 * So here we only check offset for reloc tree whose key->offset must
+	 * be a valid tree.
+	 */
+	if (key->objectid == BTRFS_TREE_RELOC_OBJECTID && key->offset == 0) {
+		generic_err(leaf, slot, "invalid root id 0 for reloc tree");
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 static int check_dir_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, struct btrfs_key *prev_key,
 			  int slot)
@@ -925,22 +967,11 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	struct btrfs_root_item ri;
 	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
 				     BTRFS_ROOT_SUBVOL_DEAD;
+	int ret;
 
-	/* No such tree id */
-	if (key->objectid == 0) {
-		generic_err(leaf, slot, "invalid root id 0");
-		return -EUCLEAN;
-	}
-
-	/*
-	 * Some older kernel may create ROOT_ITEM with non-zero offset, so here
-	 * we only check offset for reloc tree whose key->offset must be a
-	 * valid tree.
-	 */
-	if (key->objectid == BTRFS_TREE_RELOC_OBJECTID && key->offset == 0) {
-		generic_err(leaf, slot, "invalid root id 0 for reloc tree");
-		return -EUCLEAN;
-	}
+	ret = check_root_key(leaf, key, slot);
+	if (ret < 0)
+		return ret;
 
 	if (btrfs_item_size_nr(leaf, slot) != sizeof(ri)) {
 		generic_err(leaf, slot,
-- 
2.24.0

