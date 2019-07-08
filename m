Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334EA61B4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2019 09:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfGHHd7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jul 2019 03:33:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbfGHHd6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jul 2019 03:33:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D361EACA8
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2019 07:33:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: Avoid unnecessary block group item COW if the content hasn't changed
Date:   Mon,  8 Jul 2019 15:33:52 +0800
Message-Id: <20190708073352.6095-3-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708073352.6095-1-wqu@suse.com>
References: <20190708073352.6095-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In write_one_cache_group() we always do COW to update BLOCK_GROUP_ITEM.
However under a lot of cases, the cache->item is not changed at all.

E.g:
Transaction 123, block group [1M, 1M + 16M)

tree block 1M + 0 get freed
tree block 1M + 16K get allocated.

Transaction 123 get committed.

In this case, used space of block group [1M, 1M + 16M) doesn't changed
at all, thus we don't need to do COW to update block group item.

This patch will make write_one_cache_group() to do a read-only search
first, then do COW if we really need to update block group item.

This should reduce the btrfs_write_dirty_block_groups() and
btrfs_run_delayed_refs() loop introduced in previous commit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/extent-tree.c b/extent-tree.c
index 932af2c644bd..24d3a1ab3f25 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -1533,10 +1533,34 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	unsigned long bi;
 	struct extent_buffer *leaf;
 
+	/* Do a read only check to see if we need to update BLOCK_GROUP_ITEM */
+	ret = btrfs_search_slot(NULL, extent_root, &cache->key, path, 0, 0);
+	if (ret < 0)
+		goto fail;
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("failed to find block group %llu in extent tree",
+			cache->key.objectid);
+		goto fail;
+	}
+	leaf = path->nodes[0];
+	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
+	ret = memcmp_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
+	btrfs_release_path(path);
+	/* No need to update */
+	if (ret == 0)
+		return ret;
+
+	/* Do the COW to update BLOCK_GROUP_ITEM */
 	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
 	if (ret < 0)
 		goto fail;
-	BUG_ON(ret);
+	if (ret > 0) {
+		ret = -ENOENT;
+		error("failed to find block group %llu in extent tree",
+			cache->key.objectid);
+		goto fail;
+	}
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-- 
2.22.0

