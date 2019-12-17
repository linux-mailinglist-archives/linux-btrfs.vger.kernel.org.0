Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94ED8122953
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 11:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLQK6h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 05:58:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:38772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfLQK6g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 05:58:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7177AF79
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 10:58:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: Check leaf chunk item size
Date:   Tue, 17 Dec 2019 18:58:20 +0800
Message-Id: <20191217105820.20884-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inspired by btrfs-progs github issue #208, where chunk item in chunk
tree has invalid num_stripes (0).

Although that can already be catched by current btrfs_check_chunk_valid(),
that function doesn't really check item size as it needs to handle chunk
item in super block sys_chunk_array().

This patch will just add two extra checks for chunk items in chunk tree:
- Basic chunk item size
  If the item is smaller than btrfs_chunk (which already contains one
  stripe), exit right now as reading num_stripes may even go beyond
  eb boundary.

- Item size check against num_stripes
  If item size doesn't match with calculated chunk size, then either the
  item size or the num_stripes is corrupted. Error out anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 493d4d9e0f79..821a0af71b56 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -724,6 +724,44 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 	return 0;
 }
 
+/*
+ * Enhanced version of chunk item checker.
+ *
+ * The common btrfs_check_chunk_valid() doesn't check item size since it needs
+ * to work on super block sys_chunk_array which doesn't have full item ptr.
+ */
+static int check_leaf_chunk_item(struct extent_buffer *leaf,
+				 struct btrfs_chunk *chunk,
+				 struct btrfs_key *key, int slot)
+{
+	int num_stripes;
+
+	if (btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk)) {
+		chunk_err(leaf, chunk, key->offset,
+			"invalid chunk item size: have %u expect [%zu, %u)",
+			btrfs_item_size_nr(leaf, slot),
+			sizeof(struct btrfs_chunk),
+			BTRFS_LEAF_DATA_SIZE(leaf->fs_info));
+		return -EUCLEAN;
+	}
+
+	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+	/* Let btrfs_check_chunk_valid() handle this error type */
+	if (num_stripes == 0)
+		goto out;
+
+	if (btrfs_chunk_item_size(num_stripes) !=
+	    btrfs_item_size_nr(leaf, slot)) {
+		chunk_err(leaf, chunk, key->offset,
+			"invalid chunk item size: have %u expect %lu",
+			btrfs_item_size_nr(leaf, slot),
+			btrfs_chunk_item_size(num_stripes));
+		return -EUCLEAN;
+	}
+out:
+	return btrfs_check_chunk_valid(leaf, chunk, key->offset);
+}
+
 __printf(3, 4)
 __cold
 static void dev_item_err(const struct extent_buffer *eb, int slot,
@@ -1370,7 +1408,7 @@ static int check_leaf_item(struct extent_buffer *leaf,
 		break;
 	case BTRFS_CHUNK_ITEM_KEY:
 		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
-		ret = btrfs_check_chunk_valid(leaf, chunk, key->offset);
+		ret = check_leaf_chunk_item(leaf, chunk, key, slot);
 		break;
 	case BTRFS_DEV_ITEM_KEY:
 		ret = check_dev_item(leaf, key, slot);
-- 
2.24.1

