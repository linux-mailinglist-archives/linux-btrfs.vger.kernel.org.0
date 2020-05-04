Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F3E1C4ACA
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgEDX6o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 19:58:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728490AbgEDX6n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 May 2020 19:58:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32BAAAEB9
        for <linux-btrfs@vger.kernel.org>; Mon,  4 May 2020 23:58:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 7/7] btrfs: tree-checker: Introduce checks for skinny block group item
Date:   Tue,  5 May 2020 07:58:25 +0800
Message-Id: <20200504235825.4199-8-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504235825.4199-1-wqu@suse.com>
References: <20200504235825.4199-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The check is pretty simple, just two checks:
- Tree owner check
  Skinny block group item should only exist in block group tree.

- Used num bytes (key->offset)
  To avoid possible later chunk size change, here we use super large
  value (64T) as threshold to reduce false alert.

- Duplicated skinny block group items
  There shouldn't be duplicated items for the same block group.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 56 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 517b44300a05..f5eb91b4139f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -621,11 +621,18 @@ static void block_group_err(const struct extent_buffer *eb, int slot,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	btrfs_crit(fs_info,
-	"corrupt %s: root=%llu block=%llu slot=%d bg_start=%llu bg_len=%llu, %pV",
-		btrfs_header_level(eb) == 0 ? "leaf" : "node",
-		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
-		key.objectid, key.offset, &vaf);
+	if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY)
+		btrfs_crit(fs_info,
+"corrupt %s: root=%llu block=%llu slot=%d bg_start=%llu bg_len=%llu, %pV",
+			btrfs_header_level(eb) == 0 ? "leaf" : "node",
+			btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+			key.objectid, key.offset, &vaf);
+	else
+		btrfs_crit(fs_info,
+"corrupt %s: root=%llu block=%llu slot=%d bg_start=%llu, %pV",
+			btrfs_header_level(eb) == 0 ? "leaf" : "node",
+			btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
+			key.objectid, &vaf);
 	va_end(args);
 }
 
@@ -698,6 +705,42 @@ static int check_block_group_item(struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_skinny_block_group_item(struct extent_buffer *leaf,
+					 struct btrfs_key *key,
+					 struct btrfs_key *prev_key, int slot)
+{
+	if (btrfs_header_owner(leaf) != BTRFS_BLOCK_GROUP_TREE_OBJECTID) {
+		block_group_err(leaf, slot,
+	"bad tree owner for skinny block group item, have %llu expect %llu",
+				btrfs_header_owner(leaf),
+				BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	/*
+	 * We can't do direct key->offset check, but at least we shouldn't
+	 * have anything larger than max chunk size.
+	 * Here we use something way larger than that to ensure we only catch
+	 * obviouly wrong result.
+	 */
+	if (key->offset >= SZ_64T) {
+		block_group_err(leaf, slot,
+			"too large used num bytes, have %llu expect [0, %llu)",
+				key->offset, BTRFS_MAX_DATA_CHUNK_SIZE);
+		return -EUCLEAN;
+	}
+
+	/*
+	 * There shouldn't be any duplicated skinny bg items
+	 * (same objectid but different offset)
+	 */
+	if (slot > 0 && prev_key->objectid == key->objectid) {
+		block_group_err(leaf, slot,
+			"duplicated skinny block group items found");
+		return -EUCLEAN;
+	}
+	return 0;
+}
+
 __printf(4, 5)
 __cold
 static void chunk_err(const struct extent_buffer *leaf,
@@ -1511,6 +1554,9 @@ static int check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_BLOCK_GROUP_ITEM_KEY:
 		ret = check_block_group_item(leaf, key, slot);
 		break;
+	case BTRFS_SKINNY_BLOCK_GROUP_ITEM_KEY:
+		ret = check_skinny_block_group_item(leaf, key, prev_key, slot);
+		break;
 	case BTRFS_CHUNK_ITEM_KEY:
 		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
 		ret = check_leaf_chunk_item(leaf, chunk, key, slot);
-- 
2.26.2

