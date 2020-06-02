Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3851EB915
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgFBKGU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 06:06:20 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65304 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgFBKGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 06:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591092378; x=1622628378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+G4hck7pggCHnnCWwM2KH5bU56FwbyHNxegkWWZrIY=;
  b=cGn6cAhunCSqGRaPLamP4vs97tbOAJjy9DdDg0Spdl3EWGSU+z+euvgs
   v1EZdrImY5XnBQnyrcnIZKo+703K4kOMbW+a7XpPh6Ef+RqZLcWZE8YnW
   kkT2al5SRfI9LpLa4meJbwwfrAZnBx8tJ6y/fFEsb6iBsz2MAw9rGVvJA
   ILU/+AUvIUUwJyX+F80Atoo+lmkD0Z457H7Gt0ptZ3AUnF34acOf/z6zJ
   MUnLR4Keh5J4Lr3ToNC4vjzeOn177wqaaio9hclH188V1jnWWNw/mX+YV
   Q8XVJNg+UhFJFo3+NQGpYlKFvFluGoQ1tyrOvu0fdm8sTbOI9tME97em7
   w==;
IronPort-SDR: 0SV/J8Rncsi5p7McDDHmFqKqh7OQyUQV7IK2bHpD/uer/7FKarS8G8KHdSOf0Fusa3pP8j82+/
 KBK7gif1wxUNmwTz6bKn+GIsr1F7MSBFVhX28+k7Skuu1B/t2eE8vn0w4inJY7ocQLjhTB7I4b
 6IH+Nsw3h7obxljJXoLn4BRv91+v9w0nzH+f4EYrpfAsI8PvuTeC1l/dWQuGdx15htbkHZzSWy
 zpnO5+6FM8QhJGhfw8U4eNei7HMTh+HEnZ/wJU2WvpaN39b2CSQwUgK+SM570Hn98V1A38dRJ9
 DIY=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="248104355"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 18:06:04 +0800
IronPort-SDR: UOnWZJ3ILiynNDEC/THbbjKIfBlFxs9PtlrIk6cC1GHACpjKsKoG05BK+MQTSDBvw/gCR6dLvF
 DuBbgdHUdiDPCTtNoWNBClABlHAllq7l8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:55:11 -0700
IronPort-SDR: zOoc/F5jIX1ejIHLLTeqQiy31oKv620lJMbaBP+3+X8HVSJmOk6P7+NGLma7rderJpYtU/4LG9
 wPSx3+IUwpDQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Jun 2020 03:06:04 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] btrfs: factor out reading of bg from find_frist_block_group
Date:   Tue,  2 Jun 2020 19:05:57 +0900
Message-Id: <20200602100557.6938-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
References: <20200602100557.6938-1-johannes.thumshirn@wdc.com>
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

While we're at it, we can also just return early in
find_first_block_group(), if the tree slot isn't found.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
 fs/btrfs/block-group.c | 102 ++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e5641b6a3097..95b9b170b460 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1522,21 +1522,70 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
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
 {
 	struct btrfs_root *root = fs_info->extent_root;
-	int ret = 0;
+	int ret;
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
-	struct btrfs_block_group_item bg;
-	u64 flags;
 	int slot;
 
 	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	while (1) {
 		slot = path->slots[0];
@@ -1553,49 +1602,10 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 
 		if (found_key.objectid >= key->objectid &&
 		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
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
-			goto out;
+			ret = read_bg_from_eb(fs_info, &found_key, path);
+			break;
 		}
+
 		path->slots[0]++;
 	}
 out:
-- 
2.26.2

