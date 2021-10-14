Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217E842D5A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 11:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhJNJIB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 05:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNJIB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 05:08:01 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141EC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=obcELISvMhz62V9SQDBUVOv9rSLA3gpUp1+a/b79Rw0=; b=z+L7g/eud9pYsowCXgzQ1JVJwL
        iQxypGZz4nZGNgAiOezMyZjWioLdbSSzVQ6FTpIiYLlvUTP2v7xglsWgcSidfKa05FTBlznMoxs/x
        RRv3uUoScW+J4FlZaskjrUPmDakCBH/Y+0fSIPM1UblK3dsJheTFRGoMTNKaeAqDajUKHnFxaQXCg
        EWwdYmyiZHYcPOFGyilx82arP8hiIyRUu58rABaNUQ04DHP4TtmerlwHZ/C+T47LrZpZkcxJvHnzY
        axLxUR3mUZZqETOni8UNp+FZkhoiquaZhh4MrtrN4tJktSMJKgeJM+6WY9ANet86OZUuOOAbsGCu6
        rc4BltbA==;
Received: from [2001:4bb8:199:73c5:549a:b77d:f864:e8b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mawgU-002Isl-RM; Thu, 14 Oct 2021 09:05:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: stop storing the block device name in btrfsic_dev_state
Date:   Thu, 14 Oct 2021 11:05:50 +0200
Message-Id: <20211014090550.1231755-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just use the %pg format specifier in all the debug printks previously
using it.  Note that both bdevname and the %pg specifier never print
a pathname, so the kbasename call wasn't needed to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/check-integrity.c | 175 ++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 91 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 86816088927f1..22135d4f6eebc 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -186,7 +186,6 @@ struct btrfsic_dev_state {
 	struct list_head collision_resolving_node;	/* list node */
 	struct btrfsic_block dummy_block_for_bio_bh_flush;
 	u64 last_flush_gen;
-	char name[BDEVNAME_SIZE];
 };
 
 struct btrfsic_block_hashtable {
@@ -403,7 +402,6 @@ static void btrfsic_dev_state_init(struct btrfsic_dev_state *ds)
 	ds->magic_num = BTRFSIC_DEV2STATE_MAGIC_NUMBER;
 	ds->bdev = NULL;
 	ds->state = NULL;
-	ds->name[0] = '\0';
 	INIT_LIST_HEAD(&ds->collision_resolving_node);
 	ds->last_flush_gen = 0;
 	btrfsic_block_init(&ds->dummy_block_for_bio_bh_flush);
@@ -756,10 +754,10 @@ static int btrfsic_process_superblock_dev_mirror(
 		superblock_tmp->mirror_num = 1 + superblock_mirror_num;
 		if (state->print_mask & BTRFSIC_PRINT_MASK_SUPERBLOCK_WRITE)
 			btrfs_info_in_rcu(fs_info,
-				"new initial S-block (bdev %p, %s) @%llu (%s/%llu/%d)",
+				"new initial S-block (bdev %p, %s) @%llu (%pg/%llu/%d)",
 				     superblock_bdev,
 				     rcu_str_deref(device->name), dev_bytenr,
-				     dev_state->name, dev_bytenr,
+				     dev_state->bdev, dev_bytenr,
 				     superblock_mirror_num);
 		list_add(&superblock_tmp->all_blocks_node,
 			 &state->all_blocks_list);
@@ -938,9 +936,9 @@ static noinline_for_stack int btrfsic_process_metablock(
 			if (disk_item_offset + sizeof(struct btrfs_item) >
 			    sf->block_ctx->len) {
 leaf_item_out_of_bounce_error:
-				pr_info("btrfsic: leaf item out of bounce at logical %llu, dev %s\n",
+				pr_info("btrfsic: leaf item out of bounce at logical %llu, dev %pg\n",
 				       sf->block_ctx->start,
-				       sf->block_ctx->dev->name);
+				       sf->block_ctx->dev->bdev);
 				goto one_stack_frame_backwards;
 			}
 			btrfsic_read_from_block_data(sf->block_ctx,
@@ -1058,9 +1056,9 @@ static noinline_for_stack int btrfsic_process_metablock(
 					  (uintptr_t)nodehdr;
 			if (key_ptr_offset + sizeof(struct btrfs_key_ptr) >
 			    sf->block_ctx->len) {
-				pr_info("btrfsic: node item out of bounce at logical %llu, dev %s\n",
+				pr_info("btrfsic: node item out of bounce at logical %llu, dev %pg\n",
 				       sf->block_ctx->start,
-				       sf->block_ctx->dev->name);
+				       sf->block_ctx->dev->bdev);
 				goto one_stack_frame_backwards;
 			}
 			btrfsic_read_from_block_data(
@@ -1228,15 +1226,15 @@ static int btrfsic_create_link_to_next_block(
 			if (next_block->logical_bytenr != next_bytenr &&
 			    !(!next_block->is_metadata &&
 			      0 == next_block->logical_bytenr))
-				pr_info("Referenced block @%llu (%s/%llu/%d) found in hash table, %c, bytenr mismatch (!= stored %llu).\n",
-				       next_bytenr, next_block_ctx->dev->name,
+				pr_info("Referenced block @%llu (%pg/%llu/%d) found in hash table, %c, bytenr mismatch (!= stored %llu).\n",
+				       next_bytenr, next_block_ctx->dev->bdev,
 				       next_block_ctx->dev_bytenr, *mirror_nump,
 				       btrfsic_get_block_type(state,
 							      next_block),
 				       next_block->logical_bytenr);
 			else
-				pr_info("Referenced block @%llu (%s/%llu/%d) found in hash table, %c.\n",
-				       next_bytenr, next_block_ctx->dev->name,
+				pr_info("Referenced block @%llu (%pg/%llu/%d) found in hash table, %c.\n",
+				       next_bytenr, next_block_ctx->dev->bdev,
 				       next_block_ctx->dev_bytenr, *mirror_nump,
 				       btrfsic_get_block_type(state,
 							      next_block));
@@ -1324,8 +1322,8 @@ static int btrfsic_handle_extent_data(
 	if (file_extent_item_offset +
 	    offsetof(struct btrfs_file_extent_item, disk_num_bytes) >
 	    block_ctx->len) {
-		pr_info("btrfsic: file item out of bounce at logical %llu, dev %s\n",
-		       block_ctx->start, block_ctx->dev->name);
+		pr_info("btrfsic: file item out of bounce at logical %llu, dev %pg\n",
+		       block_ctx->start, block_ctx->dev->bdev);
 		return -1;
 	}
 
@@ -1344,8 +1342,8 @@ static int btrfsic_handle_extent_data(
 
 	if (file_extent_item_offset + sizeof(struct btrfs_file_extent_item) >
 	    block_ctx->len) {
-		pr_info("btrfsic: file item out of bounce at logical %llu, dev %s\n",
-		       block_ctx->start, block_ctx->dev->name);
+		pr_info("btrfsic: file item out of bounce at logical %llu, dev %pg\n",
+		       block_ctx->start, block_ctx->dev->bdev);
 		return -1;
 	}
 	btrfsic_read_from_block_data(block_ctx, &file_extent_item,
@@ -1421,9 +1419,9 @@ static int btrfsic_handle_extent_data(
 				    next_block->logical_bytenr != next_bytenr &&
 				    !(!next_block->is_metadata &&
 				      0 == next_block->logical_bytenr)) {
-					pr_info("Referenced block @%llu (%s/%llu/%d) found in hash table, D, bytenr mismatch (!= stored %llu).\n",
+					pr_info("Referenced block @%llu (%pg/%llu/%d) found in hash table, D, bytenr mismatch (!= stored %llu).\n",
 					       next_bytenr,
-					       next_block_ctx.dev->name,
+					       next_block_ctx.dev->bdev,
 					       next_block_ctx.dev_bytenr,
 					       mirror_num,
 					       next_block->logical_bytenr);
@@ -1577,8 +1575,8 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 			return -1;
 		}
 		if (submit_bio_wait(bio)) {
-			pr_info("btrfsic: read error at logical %llu dev %s!\n",
-			       block_ctx->start, block_ctx->dev->name);
+			pr_info("btrfsic: read error at logical %llu dev %pg!\n",
+			       block_ctx->start, block_ctx->dev->bdev);
 			bio_put(bio);
 			return -1;
 		}
@@ -1602,33 +1600,33 @@ static void btrfsic_dump_database(struct btrfsic_state *state)
 	list_for_each_entry(b_all, &state->all_blocks_list, all_blocks_node) {
 		const struct btrfsic_block_link *l;
 
-		pr_info("%c-block @%llu (%s/%llu/%d)\n",
+		pr_info("%c-block @%llu (%pg/%llu/%d)\n",
 		       btrfsic_get_block_type(state, b_all),
-		       b_all->logical_bytenr, b_all->dev_state->name,
+		       b_all->logical_bytenr, b_all->dev_state->bdev,
 		       b_all->dev_bytenr, b_all->mirror_num);
 
 		list_for_each_entry(l, &b_all->ref_to_list, node_ref_to) {
-			pr_info(" %c @%llu (%s/%llu/%d) refers %u* to %c @%llu (%s/%llu/%d)\n",
+			pr_info(" %c @%llu (%pg/%llu/%d) refers %u* to %c @%llu (%pg/%llu/%d)\n",
 			       btrfsic_get_block_type(state, b_all),
-			       b_all->logical_bytenr, b_all->dev_state->name,
+			       b_all->logical_bytenr, b_all->dev_state->bdev,
 			       b_all->dev_bytenr, b_all->mirror_num,
 			       l->ref_cnt,
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num);
 		}
 
 		list_for_each_entry(l, &b_all->ref_from_list, node_ref_from) {
-			pr_info(" %c @%llu (%s/%llu/%d) is ref %u* from %c @%llu (%s/%llu/%d)\n",
+			pr_info(" %c @%llu (%pg/%llu/%d) is ref %u* from %c @%llu (%pg/%llu/%d)\n",
 			       btrfsic_get_block_type(state, b_all),
-			       b_all->logical_bytenr, b_all->dev_state->name,
+			       b_all->logical_bytenr, b_all->dev_state->bdev,
 			       b_all->dev_bytenr, b_all->mirror_num,
 			       l->ref_cnt,
 			       btrfsic_get_block_type(state, l->block_ref_from),
 			       l->block_ref_from->logical_bytenr,
-			       l->block_ref_from->dev_state->name,
+			       l->block_ref_from->dev_state->bdev,
 			       l->block_ref_from->dev_bytenr,
 			       l->block_ref_from->mirror_num);
 		}
@@ -1743,16 +1741,16 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 				if (block->logical_bytenr != bytenr &&
 				    !(!block->is_metadata &&
 				      block->logical_bytenr == 0))
-					pr_info("Written block @%llu (%s/%llu/%d) found in hash table, %c, bytenr mismatch (!= stored %llu).\n",
-					       bytenr, dev_state->name,
+					pr_info("Written block @%llu (%pg/%llu/%d) found in hash table, %c, bytenr mismatch (!= stored %llu).\n",
+					       bytenr, dev_state->bdev,
 					       dev_bytenr,
 					       block->mirror_num,
 					       btrfsic_get_block_type(state,
 								      block),
 					       block->logical_bytenr);
 				else
-					pr_info("Written block @%llu (%s/%llu/%d) found in hash table, %c.\n",
-					       bytenr, dev_state->name,
+					pr_info("Written block @%llu (%pg/%llu/%d) found in hash table, %c.\n",
+					       bytenr, dev_state->bdev,
 					       dev_bytenr, block->mirror_num,
 					       btrfsic_get_block_type(state,
 								      block));
@@ -1767,8 +1765,8 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 			processed_len = state->datablock_size;
 			bytenr = block->logical_bytenr;
 			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info("Written block @%llu (%s/%llu/%d) found in hash table, %c.\n",
-				       bytenr, dev_state->name, dev_bytenr,
+				pr_info("Written block @%llu (%pg/%llu/%d) found in hash table, %c.\n",
+				       bytenr, dev_state->bdev, dev_bytenr,
 				       block->mirror_num,
 				       btrfsic_get_block_type(state, block));
 		}
@@ -1778,9 +1776,9 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 			       list_empty(&block->ref_to_list) ? ' ' : '!',
 			       list_empty(&block->ref_from_list) ? ' ' : '!');
 		if (btrfsic_is_block_ref_by_superblock(state, block, 0)) {
-			pr_info("btrfs: attempt to overwrite %c-block @%llu (%s/%llu/%d), old(gen=%llu, objectid=%llu, type=%d, offset=%llu), new(gen=%llu), which is referenced by most recent superblock (superblockgen=%llu)!\n",
+			pr_info("btrfs: attempt to overwrite %c-block @%llu (%pg/%llu/%d), old(gen=%llu, objectid=%llu, type=%d, offset=%llu), new(gen=%llu), which is referenced by most recent superblock (superblockgen=%llu)!\n",
 			       btrfsic_get_block_type(state, block), bytenr,
-			       dev_state->name, dev_bytenr, block->mirror_num,
+			       dev_state->bdev, dev_bytenr, block->mirror_num,
 			       block->generation,
 			       btrfs_disk_key_objectid(&block->disk_key),
 			       block->disk_key.type,
@@ -1792,9 +1790,9 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 		}
 
 		if (!block->is_iodone && !block->never_written) {
-			pr_info("btrfs: attempt to overwrite %c-block @%llu (%s/%llu/%d), oldgen=%llu, newgen=%llu, which is not yet iodone!\n",
+			pr_info("btrfs: attempt to overwrite %c-block @%llu (%pg/%llu/%d), oldgen=%llu, newgen=%llu, which is not yet iodone!\n",
 			       btrfsic_get_block_type(state, block), bytenr,
-			       dev_state->name, dev_bytenr, block->mirror_num,
+			       dev_state->bdev, dev_bytenr, block->mirror_num,
 			       block->generation,
 			       btrfs_stack_header_generation(
 				       (struct btrfs_header *)
@@ -1921,8 +1919,8 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 		if (!is_metadata) {
 			processed_len = state->datablock_size;
 			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info("Written block (%s/%llu/?) !found in hash table, D.\n",
-				       dev_state->name, dev_bytenr);
+				pr_info("Written block (%pg/%llu/?) !found in hash table, D.\n",
+				       dev_state->bdev, dev_bytenr);
 			if (!state->include_extent_data) {
 				/* ignore that written D block */
 				goto continue_loop;
@@ -1939,8 +1937,8 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 			btrfsic_cmp_log_and_dev_bytenr(state, bytenr, dev_state,
 						       dev_bytenr);
 			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info("Written block @%llu (%s/%llu/?) !found in hash table, M.\n",
-				       bytenr, dev_state->name, dev_bytenr);
+				pr_info("Written block @%llu (%pg/%llu/?) !found in hash table, M.\n",
+				       bytenr, dev_state->bdev, dev_bytenr);
 		}
 
 		block_ctx.dev = dev_state;
@@ -1995,9 +1993,9 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 			block->next_in_same_bio = NULL;
 		}
 		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("New written %c-block @%llu (%s/%llu/%d)\n",
+			pr_info("New written %c-block @%llu (%pg/%llu/%d)\n",
 			       is_metadata ? 'M' : 'D',
-			       block->logical_bytenr, block->dev_state->name,
+			       block->logical_bytenr, block->dev_state->bdev,
 			       block->dev_bytenr, block->mirror_num);
 		list_add(&block->all_blocks_node, &state->all_blocks_list);
 		btrfsic_block_hashtable_add(block, &state->block_hashtable);
@@ -2041,10 +2039,10 @@ static void btrfsic_bio_end_io(struct bio *bp)
 
 		if ((dev_state->state->print_mask &
 		     BTRFSIC_PRINT_MASK_END_IO_BIO_BH))
-			pr_info("bio_end_io(err=%d) for %c @%llu (%s/%llu/%d)\n",
+			pr_info("bio_end_io(err=%d) for %c @%llu (%pg/%llu/%d)\n",
 			       bp->bi_status,
 			       btrfsic_get_block_type(dev_state->state, block),
-			       block->logical_bytenr, dev_state->name,
+			       block->logical_bytenr, dev_state->bdev,
 			       block->dev_bytenr, block->mirror_num);
 		next_block = block->next_in_same_bio;
 		block->iodone_w_error = iodone_w_error;
@@ -2052,8 +2050,8 @@ static void btrfsic_bio_end_io(struct bio *bp)
 			dev_state->last_flush_gen++;
 			if ((dev_state->state->print_mask &
 			     BTRFSIC_PRINT_MASK_END_IO_BIO_BH))
-				pr_info("bio_end_io() new %s flush_gen=%llu\n",
-				       dev_state->name,
+				pr_info("bio_end_io() new %pg flush_gen=%llu\n",
+				       dev_state->bdev,
 				       dev_state->last_flush_gen);
 		}
 		if (block->submit_bio_bh_rw & REQ_FUA)
@@ -2078,17 +2076,17 @@ static int btrfsic_process_written_superblock(
 	if (!(superblock->generation > state->max_superblock_generation ||
 	      0 == state->max_superblock_generation)) {
 		if (state->print_mask & BTRFSIC_PRINT_MASK_SUPERBLOCK_WRITE)
-			pr_info("btrfsic: superblock @%llu (%s/%llu/%d) with old gen %llu <= %llu\n",
+			pr_info("btrfsic: superblock @%llu (%pg/%llu/%d) with old gen %llu <= %llu\n",
 			       superblock->logical_bytenr,
-			       superblock->dev_state->name,
+			       superblock->dev_state->bdev,
 			       superblock->dev_bytenr, superblock->mirror_num,
 			       btrfs_super_generation(super_hdr),
 			       state->max_superblock_generation);
 	} else {
 		if (state->print_mask & BTRFSIC_PRINT_MASK_SUPERBLOCK_WRITE)
-			pr_info("btrfsic: got new superblock @%llu (%s/%llu/%d) with new gen %llu > %llu\n",
+			pr_info("btrfsic: got new superblock @%llu (%pg/%llu/%d) with new gen %llu > %llu\n",
 			       superblock->logical_bytenr,
-			       superblock->dev_state->name,
+			       superblock->dev_state->bdev,
 			       superblock->dev_bytenr, superblock->mirror_num,
 			       btrfs_super_generation(super_hdr),
 			       state->max_superblock_generation);
@@ -2232,38 +2230,38 @@ static int btrfsic_check_all_ref_blocks(struct btrfsic_state *state,
 	 */
 	list_for_each_entry(l, &block->ref_to_list, node_ref_to) {
 		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("rl=%d, %c @%llu (%s/%llu/%d) %u* refers to %c @%llu (%s/%llu/%d)\n",
+			pr_info("rl=%d, %c @%llu (%pg/%llu/%d) %u* refers to %c @%llu (%pg/%llu/%d)\n",
 			       recursion_level,
 			       btrfsic_get_block_type(state, block),
-			       block->logical_bytenr, block->dev_state->name,
+			       block->logical_bytenr, block->dev_state->bdev,
 			       block->dev_bytenr, block->mirror_num,
 			       l->ref_cnt,
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num);
 		if (l->block_ref_to->never_written) {
-			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%s/%llu/%d) which is never written!\n",
+			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which is never written!\n",
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num);
 			ret = -1;
 		} else if (!l->block_ref_to->is_iodone) {
-			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%s/%llu/%d) which is not yet iodone!\n",
+			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which is not yet iodone!\n",
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num);
 			ret = -1;
 		} else if (l->block_ref_to->iodone_w_error) {
-			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%s/%llu/%d) which has write error!\n",
+			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which has write error!\n",
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num);
 			ret = -1;
@@ -2273,10 +2271,10 @@ static int btrfsic_check_all_ref_blocks(struct btrfsic_state *state,
 			   l->parent_generation &&
 			   BTRFSIC_GENERATION_UNKNOWN !=
 			   l->block_ref_to->generation) {
-			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%s/%llu/%d) with generation %llu != parent generation %llu!\n",
+			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) with generation %llu != parent generation %llu!\n",
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num,
 			       l->block_ref_to->generation,
@@ -2284,10 +2282,10 @@ static int btrfsic_check_all_ref_blocks(struct btrfsic_state *state,
 			ret = -1;
 		} else if (l->block_ref_to->flush_gen >
 			   l->block_ref_to->dev_state->last_flush_gen) {
-			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%s/%llu/%d) which is not flushed out of disk's write cache (block flush_gen=%llu, dev->flush_gen=%llu)!\n",
+			pr_info("btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which is not flushed out of disk's write cache (block flush_gen=%llu, dev->flush_gen=%llu)!\n",
 			       btrfsic_get_block_type(state, l->block_ref_to),
 			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->name,
+			       l->block_ref_to->dev_state->bdev,
 			       l->block_ref_to->dev_bytenr,
 			       l->block_ref_to->mirror_num, block->flush_gen,
 			       l->block_ref_to->dev_state->last_flush_gen);
@@ -2324,15 +2322,15 @@ static int btrfsic_is_block_ref_by_superblock(
 	 */
 	list_for_each_entry(l, &block->ref_from_list, node_ref_from) {
 		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("rl=%d, %c @%llu (%s/%llu/%d) is ref %u* from %c @%llu (%s/%llu/%d)\n",
+			pr_info("rl=%d, %c @%llu (%pg/%llu/%d) is ref %u* from %c @%llu (%pg/%llu/%d)\n",
 			       recursion_level,
 			       btrfsic_get_block_type(state, block),
-			       block->logical_bytenr, block->dev_state->name,
+			       block->logical_bytenr, block->dev_state->bdev,
 			       block->dev_bytenr, block->mirror_num,
 			       l->ref_cnt,
 			       btrfsic_get_block_type(state, l->block_ref_from),
 			       l->block_ref_from->logical_bytenr,
-			       l->block_ref_from->dev_state->name,
+			       l->block_ref_from->dev_state->bdev,
 			       l->block_ref_from->dev_bytenr,
 			       l->block_ref_from->mirror_num);
 		if (l->block_ref_from->is_superblock &&
@@ -2354,30 +2352,30 @@ static int btrfsic_is_block_ref_by_superblock(
 static void btrfsic_print_add_link(const struct btrfsic_state *state,
 				   const struct btrfsic_block_link *l)
 {
-	pr_info("Add %u* link from %c @%llu (%s/%llu/%d) to %c @%llu (%s/%llu/%d).\n",
+	pr_info("Add %u* link from %c @%llu (%pg/%llu/%d) to %c @%llu (%pg/%llu/%d).\n",
 	       l->ref_cnt,
 	       btrfsic_get_block_type(state, l->block_ref_from),
 	       l->block_ref_from->logical_bytenr,
-	       l->block_ref_from->dev_state->name,
+	       l->block_ref_from->dev_state->bdev,
 	       l->block_ref_from->dev_bytenr, l->block_ref_from->mirror_num,
 	       btrfsic_get_block_type(state, l->block_ref_to),
 	       l->block_ref_to->logical_bytenr,
-	       l->block_ref_to->dev_state->name, l->block_ref_to->dev_bytenr,
+	       l->block_ref_to->dev_state->bdev, l->block_ref_to->dev_bytenr,
 	       l->block_ref_to->mirror_num);
 }
 
 static void btrfsic_print_rem_link(const struct btrfsic_state *state,
 				   const struct btrfsic_block_link *l)
 {
-	pr_info("Rem %u* link from %c @%llu (%s/%llu/%d) to %c @%llu (%s/%llu/%d).\n",
+	pr_info("Rem %u* link from %c @%llu (%pg/%llu/%d) to %c @%llu (%pg/%llu/%d).\n",
 	       l->ref_cnt,
 	       btrfsic_get_block_type(state, l->block_ref_from),
 	       l->block_ref_from->logical_bytenr,
-	       l->block_ref_from->dev_state->name,
+	       l->block_ref_from->dev_state->bdev,
 	       l->block_ref_from->dev_bytenr, l->block_ref_from->mirror_num,
 	       btrfsic_get_block_type(state, l->block_ref_to),
 	       l->block_ref_to->logical_bytenr,
-	       l->block_ref_to->dev_state->name, l->block_ref_to->dev_bytenr,
+	       l->block_ref_to->dev_state->bdev, l->block_ref_to->dev_bytenr,
 	       l->block_ref_to->mirror_num);
 }
 
@@ -2419,9 +2417,9 @@ static void btrfsic_dump_tree_sub(const struct btrfsic_state *state,
 	 * This algorithm is recursive because the amount of used stack space
 	 * is very small and the max recursion depth is limited.
 	 */
-	indent_add = sprintf(buf, "%c-%llu(%s/%llu/%u)",
+	indent_add = sprintf(buf, "%c-%llu(%pg/%llu/%u)",
 			     btrfsic_get_block_type(state, block),
-			     block->logical_bytenr, block->dev_state->name,
+			     block->logical_bytenr, block->dev_state->bdev,
 			     block->dev_bytenr, block->mirror_num);
 	if (indent_level + indent_add > BTRFSIC_TREE_DUMP_MAX_INDENT_LEVEL) {
 		printk("[...]\n");
@@ -2542,10 +2540,10 @@ static struct btrfsic_block *btrfsic_block_lookup_or_add(
 		block->never_written = never_written;
 		block->mirror_num = mirror_num;
 		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("New %s%c-block @%llu (%s/%llu/%d)\n",
+			pr_info("New %s%c-block @%llu (%pg/%llu/%d)\n",
 			       additional_string,
 			       btrfsic_get_block_type(state, block),
-			       block->logical_bytenr, dev_state->name,
+			       block->logical_bytenr, dev_state->bdev,
 			       block->dev_bytenr, mirror_num);
 		list_add(&block->all_blocks_node, &state->all_blocks_list);
 		btrfsic_block_hashtable_add(block, &state->block_hashtable);
@@ -2592,8 +2590,8 @@ static void btrfsic_cmp_log_and_dev_bytenr(struct btrfsic_state *state,
 	}
 
 	if (WARN_ON(!match)) {
-		pr_info("btrfs: attempt to write M-block which contains logical bytenr that doesn't map to dev+physical bytenr of submit_bio, buffer->log_bytenr=%llu, submit_bio(bdev=%s, phys_bytenr=%llu)!\n",
-		       bytenr, dev_state->name, dev_bytenr);
+		pr_info("btrfs: attempt to write M-block which contains logical bytenr that doesn't map to dev+physical bytenr of submit_bio, buffer->log_bytenr=%llu, submit_bio(bdev=%pg, phys_bytenr=%llu)!\n",
+		       bytenr, dev_state->bdev, dev_bytenr);
 		for (mirror_num = 1; mirror_num <= num_copies; mirror_num++) {
 			ret = btrfsic_map_block(state, bytenr,
 						state->metablock_size,
@@ -2601,8 +2599,8 @@ static void btrfsic_cmp_log_and_dev_bytenr(struct btrfsic_state *state,
 			if (ret)
 				continue;
 
-			pr_info("Read logical bytenr @%llu maps to (%s/%llu/%d)\n",
-			       bytenr, block_ctx.dev->name,
+			pr_info("Read logical bytenr @%llu maps to (%pg/%llu/%d)\n",
+			       bytenr, block_ctx.dev->bdev,
 			       block_ctx.dev_bytenr, mirror_num);
 		}
 	}
@@ -2675,8 +2673,8 @@ static void __btrfsic_submit_bio(struct bio *bio)
 			if ((dev_state->state->print_mask &
 			     (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
 			      BTRFSIC_PRINT_MASK_VERBOSE)))
-				pr_info("btrfsic_submit_bio(%s) with FLUSH but dummy block already in use (ignored)!\n",
-				       dev_state->name);
+				pr_info("btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ignored)!\n",
+				       dev_state->bdev);
 		} else {
 			struct btrfsic_block *const block =
 				&dev_state->dummy_block_for_bio_bh_flush;
@@ -2751,7 +2749,6 @@ int btrfsic_mount(struct btrfs_fs_info *fs_info,
 
 	list_for_each_entry(device, dev_head, dev_list) {
 		struct btrfsic_dev_state *ds;
-		const char *p;
 
 		if (!device->bdev || !device->name)
 			continue;
@@ -2763,10 +2760,6 @@ int btrfsic_mount(struct btrfs_fs_info *fs_info,
 		}
 		ds->bdev = device->bdev;
 		ds->state = state;
-		bdevname(ds->bdev, ds->name);
-		ds->name[BDEVNAME_SIZE - 1] = '\0';
-		p = kbasename(ds->name);
-		strlcpy(ds->name, p, sizeof(ds->name));
 		btrfsic_dev_state_hashtable_add(ds,
 						&btrfsic_dev_state_hashtable);
 	}
@@ -2844,9 +2837,9 @@ void btrfsic_unmount(struct btrfs_fs_devices *fs_devices)
 		if (b_all->is_iodone || b_all->never_written)
 			btrfsic_block_free(b_all);
 		else
-			pr_info("btrfs: attempt to free %c-block @%llu (%s/%llu/%d) on umount which is not yet iodone!\n",
+			pr_info("btrfs: attempt to free %c-block @%llu (%pg/%llu/%d) on umount which is not yet iodone!\n",
 			       btrfsic_get_block_type(state, b_all),
-			       b_all->logical_bytenr, b_all->dev_state->name,
+			       b_all->logical_bytenr, b_all->dev_state->bdev,
 			       b_all->dev_bytenr, b_all->mirror_num);
 	}
 
-- 
2.30.2

