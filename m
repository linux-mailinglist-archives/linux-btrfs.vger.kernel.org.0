Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A595A23A260
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgHCJ6u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 05:58:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgHCJ6u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 05:58:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5E99AABE9;
        Mon,  3 Aug 2020 09:59:03 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Remove err variable from btrfs_get_extent
Date:   Mon,  3 Aug 2020 12:58:46 +0300
Message-Id: <20200803095846.3623-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's no practical reason too use 'err' as a variable to convey
errors. In fact it's value is either set explicitly in the beginning of
the function or it simply takes the value of 'ret'. Not conforming to
the usual pattern of having ret be the only variable used to convey
errors makes the code more error prone to bugs. In fact one such bug
was introduced by 6bf9e4bd6a27 ("btrfs: inode: Verify inode mode toi
avoid NULL pointer dereference") by assigning the error value to 'ret'
and not 'err'.

Let's fix that issue and make the function less tricky by leaving only
ret to convey error values.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
David, I'm not sure what's the best way forward - merge Pavel's patch and CC it
for stable and then apply this one just to upstream or use this one for both
upstream + stable ?


 fs/btrfs/inode.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0df881e39f57..670acf4115a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6528,8 +6528,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	int ret;
-	int err = 0;
+	int ret = 0;
 	u64 extent_start = 0;
 	u64 extent_end = 0;
 	u64 objectid = btrfs_ino(inode);
@@ -6557,7 +6556,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 	em = alloc_extent_map();
 	if (!em) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 	em->start = EXTENT_MAP_HOLE;
@@ -6567,7 +6566,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,

 	path = btrfs_alloc_path();
 	if (!path) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}

@@ -6582,7 +6581,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,

 	ret = btrfs_lookup_file_extent(NULL, root, path, objectid, start, 0);
 	if (ret < 0) {
-		err = ret;
 		goto out;
 	} else if (ret > 0) {
 		if (path->slots[0] == 0)
@@ -6635,12 +6633,11 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		path->slots[0]++;
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
-			if (ret < 0) {
-				err = ret;
+			if (ret < 0)
 				goto out;
-			} else if (ret > 0) {
+			else if (ret > 0)
 				goto not_found;
-			}
+
 			leaf = path->nodes[0];
 		}
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
@@ -6691,10 +6688,8 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 			    BTRFS_COMPRESS_NONE) {
 				ret = uncompress_inline(path, page, pg_offset,
 							extent_offset, item);
-				if (ret) {
-					err = ret;
+				if (ret)
 					goto out;
-				}
 			} else {
 				map = kmap(page);
 				read_extent_buffer(leaf, map + pg_offset, ptr,
@@ -6713,32 +6708,33 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto insert;
 	}
 not_found:
+	ret = 0;
 	em->start = start;
 	em->orig_start = start;
 	em->len = len;
 	em->block_start = EXTENT_MAP_HOLE;
 insert:
+	ret = 0;
 	btrfs_release_path(path);
 	if (em->start > start || extent_map_end(em) <= start) {
 		btrfs_err(fs_info,
 			  "bad extent! em: [%llu %llu] passed [%llu %llu]",
 			  em->start, em->len, start, len);
-		err = -EIO;
+		ret = -EIO;
 		goto out;
 	}

-	err = 0;
 	write_lock(&em_tree->lock);
-	err = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
+	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
 	write_unlock(&em_tree->lock);
 out:
 	btrfs_free_path(path);

 	trace_btrfs_get_extent(root, inode, em);

-	if (err) {
+	if (ret) {
 		free_extent_map(em);
-		return ERR_PTR(err);
+		return ERR_PTR(ret);
 	}
 	return em;
 }
--
2.17.1

