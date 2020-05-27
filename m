Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8C1E3B5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgE0IMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 04:12:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:15290 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387790AbgE0IMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 04:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590567154; x=1622103154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hz2nZDN3LgZDhZ28NuCnPUE00f5eAx3qaEFSJFPCpyo=;
  b=dF0UQQ4TW75zuQwQFCA+gMtV/q5KvenRiWyGJFOBQHHfJYKIL5jNY11T
   h7cQHmYgxrMGCnoEN4TH92+YX50WigSv7rJwEgKs24TgXMsXpI+qbQab+
   TtKBqvUDAzy+/gOaj+Ugcr1NcjtvLhEqjFJZFwOOUTkCIMddkyMU7PW4M
   ZQ1TJvQfh8SAubF96Q4XwZ0M7DG6IxJv1aIiBT/oK44qlMc8dN2ziJCUA
   2UTsN8rM4s3OI3B5CuFmFw2z3CBngx28rOLy7U8kwawleS3JBtu15Ezla
   rHvvofLPQV0wMaPpXjcWykj4LjRfjaA5I7pC0tTjl/wHQYq0nJf7j9xqv
   w==;
IronPort-SDR: d5xGExDrURMDaqmYQqR68s7n/P3KiJCwoICckmTFBCxpv85WXT+z4TW4blaeluJ7Bu6dgTd9MW
 M850jHOC7wpdknUyDkVPcIR/hw3Nzt/+5weo4NSMmL4/wzdM9YBdm4PKZkwmNRPbpX0ysDhYmK
 a2tXfzq728vpYps+fuAYrH62STPvMaFgIzDIA5rbNGzn3ACQjt7y6YLWfPUik54rXSaqfDsYgn
 yh2rDP/euzSOdtHAvkwLZ1LjGe3bHuS0oNKa3L1GMrkJkRtT4pl2TCIq4zlR1G0q+amkYZGKwY
 Iow=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; 
   d="scan'208";a="247648701"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 16:12:33 +0800
IronPort-SDR: 2UdEehNSbGXg6FG8YDyLqf1MVT2fc9CeaUK+RfuwpMlZEf/N/3nqUC9jkL13odVTGOYncgoJJw
 NNuJ/II9EZAL7fOXaMf1OWOvX5mJ+nvvs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 01:02:24 -0700
IronPort-SDR: lmgpyJi0nudcBOYzeTqzwxhTCcygrc3T4nNKNaV1xxs8YosKQyjU0gsoZADpzY+fsoXBSo6Liw
 eFlHc9K8V4Fw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 May 2020 01:12:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/3] btrfs: factor out reading of bg from find_frist_block_group
Date:   Wed, 27 May 2020 17:12:27 +0900
Message-Id: <20200527081227.3408-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
References: <20200527081227.3408-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 100 ++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c4462e4c8413..c2cbdbca4d47 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,6 +1522,57 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
+static int read_bg_from_eb(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
+			   struct btrfs_path *path)
+{
+	struct extent_map_tree *em_tree;
+	struct extent_map *em;
+	struct btrfs_block_group_item bg;
+	struct extent_buffer *leaf;
+	int slot;
+	u64 flags;
+	int ret = 0;
+
+	slot = path->slots[0];
+	leaf = path->nodes[0];
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
@@ -1530,8 +1581,6 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 	int ret;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_item bg;
-	u64 flags;
 	int slot;
 
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
@@ -1552,50 +1601,9 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
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
+			return read_bg_from_eb(fs_info, &found_key, path);
+
 		path->slots[0]++;
 	}
 
-- 
2.24.1

