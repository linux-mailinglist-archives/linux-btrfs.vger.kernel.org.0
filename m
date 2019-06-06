Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8AE37278
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfFFLHH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:34946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFLHH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:07:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6E3B2AE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:07:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs-progs: image: Rework how we search chunk tree blocks
Date:   Thu,  6 Jun 2019 19:06:11 +0800
Message-Id: <20190606110611.27176-10-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
References: <20190606110611.27176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, we were using a very inefficient way to search
chunks:

We iterate through all clusters to find the chunk root tree block first,
then re-iterate all clusters again to find every child tree blocks.

Every time we need to iterate all clusters just to find a chunk tree
block.
This is obviously inefficient, specially when chunk tree get larger.
So the original author leaves a comment on it:
  /* If you have to ask you aren't worthy */
  static int search_for_chunk_blocks()

This patch will change the behavior so that we will only iterate all
clusters once.

The idea behind the optimization is, since we have the superblock
restored first, we could use the CHUNK_ITEMs in
super_block::sys_chunk_array to build a SYSTEM chunk mapping.

Then when we start to iterate through all items, we can easily skip
unrelated items at different level:
- At cluster level
  If a cluster starts beyond last system chunk map, it must not contain
  any chunk tree blocks (as chunk tree blocks only lives inside system
  chunks)

- At item level
  If one item has no intersection with any system chunk map, then it
  must not contain any tree blocks.

By this, we can iterate through all clusters just once, and find out all
CHUNK_ITEMs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 213 +++++++++++++++++++++++++++------------------------
 1 file changed, 113 insertions(+), 100 deletions(-)

diff --git a/image/main.c b/image/main.c
index dc677409..8cecb228 100644
--- a/image/main.c
+++ b/image/main.c
@@ -142,8 +142,6 @@ struct mdrestore_struct {
 	struct btrfs_fs_info *info;
 };
 
-static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
-				   u64 search, u64 cluster_bytenr);
 static struct extent_buffer *alloc_dummy_eb(u64 bytenr, u32 size);
 
 static void csum_block(u8 *buf, size_t len)
@@ -1828,67 +1826,17 @@ static bool is_in_sys_chunks(struct mdrestore_struct *mdres, u64 start,
 	return false;
 }
 
-static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
-			    u64 bytenr, u64 item_bytenr, u32 bufsize,
-			    u64 cluster_bytenr)
+static int read_chunk_tree_block(struct mdrestore_struct *mdres,
+				 struct extent_buffer *eb)
 {
-	struct extent_buffer *eb;
-	int ret = 0;
 	int i;
 
-	eb = alloc_dummy_eb(bytenr, mdres->nodesize);
-	if (!eb) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	while (item_bytenr != bytenr) {
-		buffer += mdres->nodesize;
-		item_bytenr += mdres->nodesize;
-	}
-
-	memcpy(eb->data, buffer, mdres->nodesize);
-	if (btrfs_header_bytenr(eb) != bytenr) {
-		error("eb bytenr does not match found bytenr: %llu != %llu",
-				(unsigned long long)btrfs_header_bytenr(eb),
-				(unsigned long long)bytenr);
-		ret = -EIO;
-		goto out;
-	}
-
-	if (memcmp(mdres->fsid, eb->data + offsetof(struct btrfs_header, fsid),
-		   BTRFS_FSID_SIZE)) {
-		error("filesystem metadata UUID of eb %llu does not match",
-				(unsigned long long)bytenr);
-		ret = -EIO;
-		goto out;
-	}
-
-	if (btrfs_header_owner(eb) != BTRFS_CHUNK_TREE_OBJECTID) {
-		error("wrong eb %llu owner %llu",
-				(unsigned long long)bytenr,
-				(unsigned long long)btrfs_header_owner(eb));
-		ret = -EIO;
-		goto out;
-	}
-
 	for (i = 0; i < btrfs_header_nritems(eb); i++) {
 		struct btrfs_chunk *chunk;
 		struct fs_chunk *fs_chunk;
 		struct btrfs_key key;
 		u64 type;
 
-		if (btrfs_header_level(eb)) {
-			u64 blockptr = btrfs_node_blockptr(eb, i);
-
-			ret = search_for_chunk_blocks(mdres, blockptr,
-						      cluster_bytenr);
-			if (ret)
-				break;
-			continue;
-		}
-
-		/* Yay a leaf!  We loves leafs! */
 		btrfs_item_key_to_cpu(eb, &key, i);
 		if (key.type != BTRFS_CHUNK_ITEM_KEY)
 			continue;
@@ -1896,8 +1844,7 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 		fs_chunk = malloc(sizeof(struct fs_chunk));
 		if (!fs_chunk) {
 			error("not enough memory to allocate chunk");
-			ret = -ENOMEM;
-			break;
+			return -ENOMEM;
 		}
 		memset(fs_chunk, 0, sizeof(*fs_chunk));
 		chunk = btrfs_item_ptr(eb, i, struct btrfs_chunk);
@@ -1906,19 +1853,18 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 		fs_chunk->physical = btrfs_stripe_offset_nr(eb, chunk, 0);
 		fs_chunk->bytes = btrfs_chunk_length(eb, chunk);
 		INIT_LIST_HEAD(&fs_chunk->list);
+
 		if (tree_search(&mdres->physical_tree, &fs_chunk->p,
 				physical_cmp, 1) != NULL)
 			list_add(&fs_chunk->list, &mdres->overlapping_chunks);
 		else
 			tree_insert(&mdres->physical_tree, &fs_chunk->p,
 				    physical_cmp);
-
 		type = btrfs_chunk_type(eb, chunk);
 		if (type & BTRFS_BLOCK_GROUP_DUP) {
 			fs_chunk->physical_dup =
 					btrfs_stripe_offset_nr(eb, chunk, 1);
 		}
-
 		if (fs_chunk->physical_dup + fs_chunk->bytes >
 		    mdres->last_physical_offset)
 			mdres->last_physical_offset = fs_chunk->physical_dup +
@@ -1933,19 +1879,80 @@ static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 			mdres->alloced_chunks += fs_chunk->bytes;
 		tree_insert(&mdres->chunk_tree, &fs_chunk->l, chunk_cmp);
 	}
-out:
+	return 0;
+}
+
+static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
+			    u64 item_bytenr, u32 bufsize,
+			    u64 cluster_bytenr)
+{
+	struct extent_buffer *eb;
+	u32 nodesize = mdres->nodesize;
+	u64 bytenr;
+	size_t cur_offset;
+	int ret = 0;
+
+	eb = alloc_dummy_eb(0, mdres->nodesize);
+	if (!eb)
+		return -ENOMEM;
+
+	for (cur_offset = 0; cur_offset < bufsize; cur_offset += nodesize) {
+		bytenr = item_bytenr + cur_offset;
+		if (!is_in_sys_chunks(mdres, bytenr, nodesize))
+			continue;
+		memcpy(eb->data, buffer + cur_offset, nodesize);
+		if (btrfs_header_bytenr(eb) != bytenr) {
+			error(
+			"eb bytenr does not match found bytenr: %llu != %llu",
+				(unsigned long long)btrfs_header_bytenr(eb),
+				(unsigned long long)bytenr);
+			ret = -EUCLEAN;
+			break;
+		}
+		if (memcmp(mdres->fsid, eb->data +
+			   offsetof(struct btrfs_header, fsid),
+		    BTRFS_FSID_SIZE)) {
+			error(
+			"filesystem metadata UUID of eb %llu does not match",
+				bytenr);
+			ret = -EUCLEAN;
+			break;
+		}
+		if (btrfs_header_owner(eb) != BTRFS_CHUNK_TREE_OBJECTID) {
+			error("wrong eb %llu owner %llu",
+				(unsigned long long)bytenr,
+				(unsigned long long)btrfs_header_owner(eb));
+			ret = -EUCLEAN;
+			break;
+		}
+		/*
+		 * No need to search node, as we will iterate all tree blocks
+		 * in chunk tree, only need to bother leaves.
+		 */
+		if (btrfs_header_level(eb))
+			continue;
+		ret = read_chunk_tree_block(mdres, eb);
+		if (ret < 0)
+			break;
+	}
 	free(eb);
 	return ret;
 }
 
-/* If you have to ask you aren't worthy */
-static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
-				   u64 search, u64 cluster_bytenr)
+/*
+ * This function will try to find all chunk items in the dump image.
+ *
+ * This function will iterate all clusters, and find any item inside
+ * system chunk ranges.
+ * For such item, it will try to read them as tree blocks, and find
+ * CHUNK_ITEMs, add them to @mdres.
+ */
+static int search_for_chunk_blocks(struct mdrestore_struct *mdres)
 {
 	struct meta_cluster *cluster;
 	struct meta_cluster_header *header;
 	struct meta_cluster_item *item;
-	u64 current_cluster = cluster_bytenr, bytenr;
+	u64 current_cluster = 0, bytenr;
 	u64 item_bytenr;
 	u32 bufsize, nritems, i;
 	u32 max_size = current_version->max_pending_size * 2;
@@ -1976,43 +1983,45 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 	}
 
 	bytenr = current_cluster;
+	/* Main loop, iterating all clusters */
 	while (1) {
 		if (fseek(mdres->in, current_cluster, SEEK_SET)) {
 			error("seek failed: %m");
 			ret = -EIO;
-			break;
+			goto out;
 		}
 
 		ret = fread(cluster, BLOCK_SIZE, 1, mdres->in);
 		if (ret == 0) {
-			if (cluster_bytenr != 0) {
-				cluster_bytenr = 0;
-				current_cluster = 0;
-				bytenr = 0;
-				continue;
-			}
+			if (feof(mdres->in))
+				goto out;
 			error(
 	"unknown state after reading cluster at %llu, probably corrupted data",
-					cluster_bytenr);
+					current_cluster);
 			ret = -EIO;
-			break;
+			goto out;
 		} else if (ret < 0) {
 			error("unable to read image at %llu: %m",
-					(unsigned long long)cluster_bytenr);
-			break;
+					current_cluster);
+			goto out;
 		}
-		ret = 0;
 
 		header = &cluster->header;
 		if (le64_to_cpu(header->magic) != current_version->magic_cpu ||
 		    le64_to_cpu(header->bytenr) != current_cluster) {
 			error("bad header in metadump image");
 			ret = -EIO;
-			break;
+			goto out;
 		}
 
+		/* We're already over the system chunk end, no need to search*/
+		if (current_cluster > mdres->sys_chunk_end)
+			goto out;
+
 		bytenr += BLOCK_SIZE;
 		nritems = le32_to_cpu(header->nritems);
+
+		/* Search items for tree blocks in sys chunks */
 		for (i = 0; i < nritems; i++) {
 			size_t size;
 
@@ -2020,11 +2029,21 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 			bufsize = le32_to_cpu(item->size);
 			item_bytenr = le64_to_cpu(item->bytenr);
 
-			if (bufsize > max_size) {
-				error("item %u too big: %u > %u", i, bufsize,
-						max_size);
-				ret = -EIO;
-				break;
+			/*
+			 * Only data extent/free space cache can be that big,
+			 * adjacent tree blocks won't be able to be merged
+			 * beyond max_size.
+			 */
+			if (bufsize > max_size ||
+			    !is_in_sys_chunks(mdres, item_bytenr, bufsize)) {
+				ret = fseek(mdres->in, bufsize, SEEK_CUR);
+				if (ret < 0) {
+					error("failed to seek: %m");
+					ret = -errno;
+					goto out;
+				}
+				bytenr += bufsize;
+				continue;
 			}
 
 			if (mdres->compress_method == COMPRESS_ZLIB) {
@@ -2032,7 +2051,7 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 				if (ret != 1) {
 					error("read error: %m");
 					ret = -EIO;
-					break;
+					goto out;
 				}
 
 				size = max_size;
@@ -2043,40 +2062,36 @@ static int search_for_chunk_blocks(struct mdrestore_struct *mdres,
 					error("decompression failed with %d",
 							ret);
 					ret = -EIO;
-					break;
+					goto out;
 				}
 			} else {
 				ret = fread(buffer, bufsize, 1, mdres->in);
 				if (ret != 1) {
 					error("read error: %m");
 					ret = -EIO;
-					break;
+					goto out;
 				}
 				size = bufsize;
 			}
 			ret = 0;
 
-			if (item_bytenr <= search &&
-			    item_bytenr + size > search) {
-				ret = read_chunk_block(mdres, buffer, search,
-						       item_bytenr, size,
-						       current_cluster);
-				if (!ret)
-					ret = 1;
-				break;
+			ret = read_chunk_block(mdres, buffer,
+					       item_bytenr, size,
+					       current_cluster);
+			if (ret < 0) {
+				error(
+	"failed to search tree blocks in item bytenr %llu size %lu",
+					item_bytenr, size);
+				goto out;
 			}
 			bytenr += bufsize;
 		}
-		if (ret) {
-			if (ret > 0)
-				ret = 0;
-			break;
-		}
 		if (bytenr & BLOCK_MASK)
 			bytenr += BLOCK_SIZE - (bytenr & BLOCK_MASK);
 		current_cluster = bytenr;
 	}
 
+out:
 	free(tmp);
 	free(buffer);
 	free(cluster);
@@ -2175,7 +2190,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	struct btrfs_super_block *super;
 	struct meta_cluster_header *header;
 	struct meta_cluster_item *item = NULL;
-	u64 chunk_root_bytenr = 0;
 	u32 i, nritems;
 	u64 bytenr = 0;
 	u8 *buffer;
@@ -2268,7 +2282,6 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 		pthread_mutex_unlock(&mdres->mutex);
 		return ret;
 	}
-	chunk_root_bytenr = btrfs_super_chunk_root(super);
 	mdres->nodesize = btrfs_super_nodesize(super);
 	if (btrfs_super_incompat_flags(super) &
 	    BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
@@ -2281,7 +2294,7 @@ static int build_chunk_tree(struct mdrestore_struct *mdres,
 	free(buffer);
 	pthread_mutex_unlock(&mdres->mutex);
 
-	return search_for_chunk_blocks(mdres, chunk_root_bytenr, 0);
+	return search_for_chunk_blocks(mdres);
 }
 
 static int range_contains_super(u64 physical, u64 bytes)
-- 
2.21.0

