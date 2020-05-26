Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A0D1E23FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 May 2020 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEZOVj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 May 2020 10:21:39 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15676 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEZOVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 May 2020 10:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590502897; x=1622038897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VR1ItsBlp1d05PqxlMrWHBw9Qt8at6uO9u44E7ZZksE=;
  b=KGwZaRvXmnxLe04+FZdEm5X3feSPPp4jnFghouT9kFxo0rCyghWClUHh
   5P8eZWd4aEdLv03uoiuhg0zNM89D8V6EH7btrnwbyH1XRMDiZAdPz7TPR
   BQ0KwGZi0KrIoMFC2uX9D1aX3Lr4QYcdXudIn1sd2hCnvFTs32S8XnZwI
   7CPx3jPvLcIMeJwkEtKDah0k6gyQnIMzXoK64Oj9HT7QS7s/K4J9BiFBZ
   NxiR5DKjbGdemXO1PAFmErbocUhmjTAaS8x/lSMeiHYLSqBeiC2IuKxeM
   aYopGEr4nsY5WytNmlvsxgjXAsiWF3/J9h4TYGOcycx38F89gKf2Aia/n
   g==;
IronPort-SDR: IzzDVf/46vGeUmDqDoMIlqYG3UJSyKoZYem/OZQC94+bAHH6dJO+KIWrcIuG0OBuquZEg7pMGE
 FZFhAWsfZ2V61lMZ26PBuS9AG50NIei1WvBnzcxykiEzVFemSu+iLooj7UbaBMUuTG50z0C7ek
 SewK58d4oKcd9THYIO005Xvzxap78XtlOa7IZx0P7dyuKbzk+GQI/23p50jXiYrxSU2Ohmet4u
 pJWPQ6HA8GR6BlJ1Cd6gzh5SpQrr+wFZZ0bK6d67ih3Rq5VcCHiDlHK+i5b/P7iOlrvj07mTAQ
 nEs=
X-IronPort-AV: E=Sophos;i="5.73,437,1583164800"; 
   d="scan'208";a="247571876"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2020 22:21:37 +0800
IronPort-SDR: qmTjDlv9qKrtd+yTnLmhkkYLPT3Na8tWpUbtjTNef3Di8akEktpApdkBSnr3iUYCOpfy7fMafB
 /Chr3Vuk4M3CJYqInh2GN8uXZISb9opu8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 07:10:56 -0700
IronPort-SDR: DVtlyO8dN91xZh+Hnz3p4r8Y9cCWIhTyrQamIDAMVUV4iYcjhweSasnQvYU18lHf1p5OmNmhOd
 Maczmawroj6A==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 May 2020 07:21:37 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] btrfs: factor out reading of bg from find_frist_block_group
Date:   Tue, 26 May 2020 23:21:24 +0900
Message-Id: <20200526142124.36202-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
References: <20200526142124.36202-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When find_first_block_group() finds a block group item in the extent-tree,
it does a lookup of the object in the extent mapping tree and does further
checks on the item.

Factor out this step from find_first_block_group() so we can further
simplify the code.

As a bonus we even get a slight decrease in size:
$ ./scripts/bloat-o-meter btrfs_old.ko btrfs.ko
add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-2503 (-2503)
Function                                     old     new   delta
btrfs_read_block_groups.cold                 462     337    -125
btrfs_read_block_groups                     4787    2409   -2378
Total: Before=2369371, After=2366868, chg -0.11%

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 95 ++++++++++++++++++++++--------------------
 1 file changed, 49 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c4462e4c8413..3d9e0ee1d1be 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,6 +1522,52 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
+static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
+			   struct extent_buffer *leaf, int slot)
+{
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct btrfs_block_group_item bg;
+	u64 flags;
+	int ret = 0;
+
+	em_tree = &fs_info->mapping_tree;
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, key->objectid, key->offset);
+	read_unlock(&em_tree->lock);
+	if (!em) {
+		btrfs_err(fs_info,
+			  "logical %llu len %llu found bg but no related chunk",
+			  key->objectid, key->offset);
+		return -ENOENT;
+	}
+
+	if (em->start != key->objectid || em->len != key->offset) {
+		btrfs_err(fs_info,
+			  "block group %llu len %llu mismatch with chunk %llu len %llu",
+			  key->objectid, key->offset, em->start, em->len);
+		ret = -EUCLEAN;
+		goto out_free_em;
+	}
+
+	read_extent_buffer(leaf, &bg, btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(bg));
+	flags = btrfs_stack_block_group_flags(&bg) &
+		BTRFS_BLOCK_GROUP_TYPE_MASK;
+
+	if (flags != (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+		btrfs_err(fs_info,
+			  "block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
+			  key->objectid, key->offset, flags,
+			  (BTRFS_BLOCK_GROUP_TYPE_MASK & em->map_lookup->type));
+		ret = -EUCLEAN;
+	}
+
+out_free_em:
+	free_extent_map(em);
+	return ret;
+}
+
 static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_path *path,
 				  struct btrfs_key *key)
@@ -1530,8 +1576,6 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_item bg;
-	u64 flags;
 	int slot;
 
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
@@ -1552,50 +1596,9 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 		btrfs_item_key_to_cpu(leaf, &found_key, slot);
 
 		if (found_key.objectid >= key->objectid &&
-		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			struct extent_map_tree *em_tree;
-			struct extent_map *em;
-
-			em_tree = &fs_info->mapping_tree;
-			read_lock(&em_tree->lock);
-			em = lookup_extent_mapping(em_tree, found_key.objectid,
-						   found_key.offset);
-			read_unlock(&em_tree->lock);
-			if (!em) {
-				btrfs_err(fs_info,
-			"logical %llu len %llu found bg but no related chunk",
-					  found_key.objectid, found_key.offset);
-				ret = -ENOENT;
-			} else if (em->start != found_key.objectid ||
-				   em->len != found_key.offset) {
-				btrfs_err(fs_info,
-		"block group %llu len %llu mismatch with chunk %llu len %llu",
-					  found_key.objectid, found_key.offset,
-					  em->start, em->len);
-				ret = -EUCLEAN;
-			} else {
-				read_extent_buffer(leaf, &bg,
-					btrfs_item_ptr_offset(leaf, slot),
-					sizeof(bg));
-				flags = btrfs_stack_block_group_flags(&bg) &
-					BTRFS_BLOCK_GROUP_TYPE_MASK;
-
-				if (flags != (em->map_lookup->type &
-					      BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-					btrfs_err(fs_info,
-"block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
-						found_key.objectid,
-						found_key.offset, flags,
-						(BTRFS_BLOCK_GROUP_TYPE_MASK &
-						 em->map_lookup->type));
-					ret = -EUCLEAN;
-				} else {
-					ret = 0;
-				}
-			}
-			free_extent_map(em);
-			return ret;
-		}
+		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY)
+			return read_bg_from_eb(fs_info, &found_key, leaf, slot);
+
 		path->slots[0]++;
 	}
 
-- 
2.24.1

