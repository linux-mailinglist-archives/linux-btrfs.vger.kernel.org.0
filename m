Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16C3798283
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 08:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjIHGmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjIHGmn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 02:42:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CFF1BD9
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 23:42:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 610BC218E9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694155356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ruJbHMtqIaqJJBNiKfOhBCmwMrkUgB3TjHV4ncf6DE=;
        b=rCNXLkMYqBgjG4kwrVoIgDGwYHT7wIa+sH6Z6nPfEue62fgRJaoK6JgzPRSBKPfmtQbFd/
        4M4PrzDX+t+aZ6lYf3eaPT5+lpyPc/BeVZkaj4NUTAFXETkYuymk11tqg6guh5pJvzeQGK
        Bs1tdfMzox1WKqXvzyXECBpV24zZ260=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97102131FD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 06:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sN7FGVvC+mQZeQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 06:42:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: remove btrfsic_check_bio() function
Date:   Fri,  8 Sep 2023 14:42:14 +0800
Message-ID: <84e3f7940c33f3890c3b36f0985f65aaa048532a.1694154699.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1694154699.git.wqu@suse.com>
References: <cover.1694154699.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfsic_check_bio() is part of the deprecated
check-integrity functionality.

Now let's remove the main entrance of check-integrity, and thankfully
most of the check-integrity code is self-contained inside
check-integrity.c, we can safely remove the function without huge
changes to btrfs code base.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c             |   4 -
 fs/btrfs/check-integrity.c | 894 -------------------------------------
 fs/btrfs/check-integrity.h |   6 -
 fs/btrfs/disk-io.c         |   4 -
 4 files changed, 908 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 12b12443efaa..f2486fb5f404 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -463,8 +463,6 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 		(unsigned long)dev->bdev->bd_dev, btrfs_dev_name(dev),
 		dev->devid, bio->bi_iter.bi_size);
 
-	btrfsic_check_bio(bio);
-
 	if (bio->bi_opf & REQ_BTRFS_CGROUP_PUNT)
 		blkcg_punt_bio_submit(bio);
 	else
@@ -779,8 +777,6 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	bio_init(&bio, smap.dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
 	bio.bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
 	__bio_add_page(&bio, page, length, pg_offset);
-
-	btrfsic_check_bio(&bio);
 	ret = submit_bio_wait(&bio);
 	if (ret) {
 		/* try to remap that extent elsewhere? */
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 3caf339c4bb3..b7cecc7a70c9 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -272,17 +272,6 @@ static int btrfsic_map_block(struct btrfsic_state *state, u64 bytenr, u32 len,
 static void btrfsic_release_block_ctx(struct btrfsic_block_data_ctx *block_ctx);
 static int btrfsic_read_block(struct btrfsic_state *state,
 			      struct btrfsic_block_data_ctx *block_ctx);
-static int btrfsic_process_written_superblock(
-		struct btrfsic_state *state,
-		struct btrfsic_block *const block,
-		struct btrfs_super_block *const super_hdr);
-static void btrfsic_bio_end_io(struct bio *bp);
-static int btrfsic_is_block_ref_by_superblock(const struct btrfsic_state *state,
-					      const struct btrfsic_block *block,
-					      int recursion_level);
-static int btrfsic_check_all_ref_blocks(struct btrfsic_state *state,
-					struct btrfsic_block *const block,
-					int recursion_level);
 static void btrfsic_print_add_link(const struct btrfsic_state *state,
 				   const struct btrfsic_block_link *l);
 static void btrfsic_print_rem_link(const struct btrfsic_state *state,
@@ -316,10 +305,6 @@ static int btrfsic_process_superblock_dev_mirror(
 		struct btrfsic_dev_state **selected_dev_state,
 		struct btrfs_super_block *selected_super);
 static struct btrfsic_dev_state *btrfsic_dev_state_lookup(dev_t dev);
-static void btrfsic_cmp_log_and_dev_bytenr(struct btrfsic_state *state,
-					   u64 bytenr,
-					   struct btrfsic_dev_state *dev_state,
-					   u64 dev_bytenr);
 
 static struct mutex btrfsic_mutex;
 static int btrfsic_is_initialized;
@@ -447,11 +432,6 @@ static void btrfsic_block_hashtable_add(struct btrfsic_block *b,
 	list_add(&b->collision_resolving_node, h->table + hashval);
 }
 
-static void btrfsic_block_hashtable_remove(struct btrfsic_block *b)
-{
-	list_del(&b->collision_resolving_node);
-}
-
 static struct btrfsic_block *btrfsic_block_hashtable_lookup(
 		struct block_device *bdev,
 		u64 dev_bytenr,
@@ -496,11 +476,6 @@ static void btrfsic_block_link_hashtable_add(
 	list_add(&l->collision_resolving_node, h->table + hashval);
 }
 
-static void btrfsic_block_link_hashtable_remove(struct btrfsic_block_link *l)
-{
-	list_del(&l->collision_resolving_node);
-}
-
 static struct btrfsic_block_link *btrfsic_block_link_hashtable_lookup(
 		struct block_device *bdev_ref_to,
 		u64 dev_bytenr_ref_to,
@@ -1645,736 +1620,6 @@ static void btrfsic_dump_database(struct btrfsic_state *state)
 	}
 }
 
-/*
- * Test whether the disk block contains a tree block (leaf or node)
- * (note that this test fails for the super block)
- */
-static noinline_for_stack int btrfsic_test_for_metadata(
-		struct btrfsic_state *state,
-		char **datav, unsigned int num_pages)
-{
-	struct btrfs_fs_info *fs_info = state->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	struct btrfs_header *h;
-	u8 csum[BTRFS_CSUM_SIZE];
-	unsigned int i;
-
-	if (num_pages * PAGE_SIZE < state->metablock_size)
-		return 1; /* not metadata */
-	num_pages = state->metablock_size >> PAGE_SHIFT;
-	h = (struct btrfs_header *)datav[0];
-
-	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE))
-		return 1;
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-
-	for (i = 0; i < num_pages; i++) {
-		u8 *data = i ? datav[i] : (datav[i] + BTRFS_CSUM_SIZE);
-		size_t sublen = i ? PAGE_SIZE :
-				    (PAGE_SIZE - BTRFS_CSUM_SIZE);
-
-		crypto_shash_update(shash, data, sublen);
-	}
-	crypto_shash_final(shash, csum);
-	if (memcmp(csum, h->csum, fs_info->csum_size))
-		return 1;
-
-	return 0; /* is metadata */
-}
-
-static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
-					  u64 dev_bytenr, char **mapped_datav,
-					  unsigned int num_pages,
-					  struct bio *bio, int *bio_is_patched,
-					  blk_opf_t submit_bio_bh_rw)
-{
-	int is_metadata;
-	struct btrfsic_block *block;
-	struct btrfsic_block_data_ctx block_ctx;
-	int ret;
-	struct btrfsic_state *state = dev_state->state;
-	struct block_device *bdev = dev_state->bdev;
-	unsigned int processed_len;
-
-	if (NULL != bio_is_patched)
-		*bio_is_patched = 0;
-
-again:
-	if (num_pages == 0)
-		return;
-
-	processed_len = 0;
-	is_metadata = (0 == btrfsic_test_for_metadata(state, mapped_datav,
-						      num_pages));
-
-	block = btrfsic_block_hashtable_lookup(bdev, dev_bytenr,
-					       &state->block_hashtable);
-	if (NULL != block) {
-		u64 bytenr = 0;
-		struct btrfsic_block_link *l, *tmp;
-
-		if (block->is_superblock) {
-			bytenr = btrfs_super_bytenr((struct btrfs_super_block *)
-						    mapped_datav[0]);
-			if (num_pages * PAGE_SIZE <
-			    BTRFS_SUPER_INFO_SIZE) {
-				pr_info("btrfsic: cannot work with too short bios!\n");
-				return;
-			}
-			is_metadata = 1;
-			BUG_ON(!PAGE_ALIGNED(BTRFS_SUPER_INFO_SIZE));
-			processed_len = BTRFS_SUPER_INFO_SIZE;
-			if (state->print_mask &
-			    BTRFSIC_PRINT_MASK_TREE_BEFORE_SB_WRITE) {
-				pr_info("[before new superblock is written]:\n");
-				btrfsic_dump_tree_sub(state, block, 0);
-			}
-		}
-		if (is_metadata) {
-			if (!block->is_superblock) {
-				if (num_pages * PAGE_SIZE <
-				    state->metablock_size) {
-					pr_info("btrfsic: cannot work with too short bios!\n");
-					return;
-				}
-				processed_len = state->metablock_size;
-				bytenr = btrfs_stack_header_bytenr(
-						(struct btrfs_header *)
-						mapped_datav[0]);
-				btrfsic_cmp_log_and_dev_bytenr(state, bytenr,
-							       dev_state,
-							       dev_bytenr);
-			}
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE) {
-				if (block->logical_bytenr != bytenr &&
-				    !(!block->is_metadata &&
-				      block->logical_bytenr == 0))
-					pr_info(
-"written block @%llu (%pg/%llu/%d) found in hash table, %c, bytenr mismatch (!= stored %llu)\n",
-					       bytenr, dev_state->bdev,
-					       dev_bytenr,
-					       block->mirror_num,
-					       btrfsic_get_block_type(state,
-								      block),
-					       block->logical_bytenr);
-				else
-					pr_info(
-		"written block @%llu (%pg/%llu/%d) found in hash table, %c\n",
-					       bytenr, dev_state->bdev,
-					       dev_bytenr, block->mirror_num,
-					       btrfsic_get_block_type(state,
-								      block));
-			}
-			block->logical_bytenr = bytenr;
-		} else {
-			if (num_pages * PAGE_SIZE <
-			    state->datablock_size) {
-				pr_info("btrfsic: cannot work with too short bios!\n");
-				return;
-			}
-			processed_len = state->datablock_size;
-			bytenr = block->logical_bytenr;
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info(
-		"written block @%llu (%pg/%llu/%d) found in hash table, %c\n",
-				       bytenr, dev_state->bdev, dev_bytenr,
-				       block->mirror_num,
-				       btrfsic_get_block_type(state, block));
-		}
-
-		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("ref_to_list: %cE, ref_from_list: %cE\n",
-			       list_empty(&block->ref_to_list) ? ' ' : '!',
-			       list_empty(&block->ref_from_list) ? ' ' : '!');
-		if (btrfsic_is_block_ref_by_superblock(state, block, 0)) {
-			pr_info(
-"btrfs: attempt to overwrite %c-block @%llu (%pg/%llu/%d), old(gen=%llu, objectid=%llu, type=%d, offset=%llu), new(gen=%llu), which is referenced by most recent superblock (superblockgen=%llu)!\n",
-			       btrfsic_get_block_type(state, block), bytenr,
-			       dev_state->bdev, dev_bytenr, block->mirror_num,
-			       block->generation,
-			       btrfs_disk_key_objectid(&block->disk_key),
-			       block->disk_key.type,
-			       btrfs_disk_key_offset(&block->disk_key),
-			       btrfs_stack_header_generation(
-				       (struct btrfs_header *) mapped_datav[0]),
-			       state->max_superblock_generation);
-			btrfsic_dump_tree(state);
-		}
-
-		if (!block->is_iodone && !block->never_written) {
-			pr_info(
-"btrfs: attempt to overwrite %c-block @%llu (%pg/%llu/%d), oldgen=%llu, newgen=%llu, which is not yet iodone!\n",
-			       btrfsic_get_block_type(state, block), bytenr,
-			       dev_state->bdev, dev_bytenr, block->mirror_num,
-			       block->generation,
-			       btrfs_stack_header_generation(
-				       (struct btrfs_header *)
-				       mapped_datav[0]));
-			/* it would not be safe to go on */
-			btrfsic_dump_tree(state);
-			goto continue_loop;
-		}
-
-		/*
-		 * Clear all references of this block. Do not free
-		 * the block itself even if is not referenced anymore
-		 * because it still carries valuable information
-		 * like whether it was ever written and IO completed.
-		 */
-		list_for_each_entry_safe(l, tmp, &block->ref_to_list,
-					 node_ref_to) {
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				btrfsic_print_rem_link(state, l);
-			l->ref_cnt--;
-			if (0 == l->ref_cnt) {
-				list_del(&l->node_ref_to);
-				list_del(&l->node_ref_from);
-				btrfsic_block_link_hashtable_remove(l);
-				btrfsic_block_link_free(l);
-			}
-		}
-
-		block_ctx.dev = dev_state;
-		block_ctx.dev_bytenr = dev_bytenr;
-		block_ctx.start = bytenr;
-		block_ctx.len = processed_len;
-		block_ctx.pagev = NULL;
-		block_ctx.mem_to_free = NULL;
-		block_ctx.datav = mapped_datav;
-
-		if (is_metadata || state->include_extent_data) {
-			block->never_written = 0;
-			block->iodone_w_error = 0;
-			if (NULL != bio) {
-				block->is_iodone = 0;
-				BUG_ON(NULL == bio_is_patched);
-				if (!*bio_is_patched) {
-					block->orig_bio_private =
-					    bio->bi_private;
-					block->orig_bio_end_io =
-					    bio->bi_end_io;
-					block->next_in_same_bio = NULL;
-					bio->bi_private = block;
-					bio->bi_end_io = btrfsic_bio_end_io;
-					*bio_is_patched = 1;
-				} else {
-					struct btrfsic_block *chained_block =
-					    (struct btrfsic_block *)
-					    bio->bi_private;
-
-					BUG_ON(NULL == chained_block);
-					block->orig_bio_private =
-					    chained_block->orig_bio_private;
-					block->orig_bio_end_io =
-					    chained_block->orig_bio_end_io;
-					block->next_in_same_bio = chained_block;
-					bio->bi_private = block;
-				}
-			} else {
-				block->is_iodone = 1;
-				block->orig_bio_private = NULL;
-				block->orig_bio_end_io = NULL;
-				block->next_in_same_bio = NULL;
-			}
-		}
-
-		block->flush_gen = dev_state->last_flush_gen + 1;
-		block->submit_bio_bh_rw = submit_bio_bh_rw;
-		if (is_metadata) {
-			block->logical_bytenr = bytenr;
-			block->is_metadata = 1;
-			if (block->is_superblock) {
-				BUG_ON(PAGE_SIZE !=
-				       BTRFS_SUPER_INFO_SIZE);
-				ret = btrfsic_process_written_superblock(
-						state,
-						block,
-						(struct btrfs_super_block *)
-						mapped_datav[0]);
-				if (state->print_mask &
-				    BTRFSIC_PRINT_MASK_TREE_AFTER_SB_WRITE) {
-					pr_info("[after new superblock is written]:\n");
-					btrfsic_dump_tree_sub(state, block, 0);
-				}
-			} else {
-				block->mirror_num = 0;	/* unknown */
-				ret = btrfsic_process_metablock(
-						state,
-						block,
-						&block_ctx,
-						0, 0);
-			}
-			if (ret)
-				pr_info("btrfsic: btrfsic_process_metablock(root @%llu) failed!\n",
-				       dev_bytenr);
-		} else {
-			block->is_metadata = 0;
-			block->mirror_num = 0;	/* unknown */
-			block->generation = BTRFSIC_GENERATION_UNKNOWN;
-			if (!state->include_extent_data
-			    && list_empty(&block->ref_from_list)) {
-				/*
-				 * disk block is overwritten with extent
-				 * data (not meta data) and we are configured
-				 * to not include extent data: take the
-				 * chance and free the block's memory
-				 */
-				btrfsic_block_hashtable_remove(block);
-				list_del(&block->all_blocks_node);
-				btrfsic_block_free(block);
-			}
-		}
-		btrfsic_release_block_ctx(&block_ctx);
-	} else {
-		/* block has not been found in hash table */
-		u64 bytenr;
-
-		if (!is_metadata) {
-			processed_len = state->datablock_size;
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info(
-			"written block (%pg/%llu/?) !found in hash table, D\n",
-				       dev_state->bdev, dev_bytenr);
-			if (!state->include_extent_data) {
-				/* ignore that written D block */
-				goto continue_loop;
-			}
-
-			/* this is getting ugly for the
-			 * include_extent_data case... */
-			bytenr = 0;	/* unknown */
-		} else {
-			processed_len = state->metablock_size;
-			bytenr = btrfs_stack_header_bytenr(
-					(struct btrfs_header *)
-					mapped_datav[0]);
-			btrfsic_cmp_log_and_dev_bytenr(state, bytenr, dev_state,
-						       dev_bytenr);
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info(
-			"written block @%llu (%pg/%llu/?) !found in hash table, M\n",
-				       bytenr, dev_state->bdev, dev_bytenr);
-		}
-
-		block_ctx.dev = dev_state;
-		block_ctx.dev_bytenr = dev_bytenr;
-		block_ctx.start = bytenr;
-		block_ctx.len = processed_len;
-		block_ctx.pagev = NULL;
-		block_ctx.mem_to_free = NULL;
-		block_ctx.datav = mapped_datav;
-
-		block = btrfsic_block_alloc();
-		if (NULL == block) {
-			btrfsic_release_block_ctx(&block_ctx);
-			goto continue_loop;
-		}
-		block->dev_state = dev_state;
-		block->dev_bytenr = dev_bytenr;
-		block->logical_bytenr = bytenr;
-		block->is_metadata = is_metadata;
-		block->never_written = 0;
-		block->iodone_w_error = 0;
-		block->mirror_num = 0;	/* unknown */
-		block->flush_gen = dev_state->last_flush_gen + 1;
-		block->submit_bio_bh_rw = submit_bio_bh_rw;
-		if (NULL != bio) {
-			block->is_iodone = 0;
-			BUG_ON(NULL == bio_is_patched);
-			if (!*bio_is_patched) {
-				block->orig_bio_private = bio->bi_private;
-				block->orig_bio_end_io = bio->bi_end_io;
-				block->next_in_same_bio = NULL;
-				bio->bi_private = block;
-				bio->bi_end_io = btrfsic_bio_end_io;
-				*bio_is_patched = 1;
-			} else {
-				struct btrfsic_block *chained_block =
-				    (struct btrfsic_block *)
-				    bio->bi_private;
-
-				BUG_ON(NULL == chained_block);
-				block->orig_bio_private =
-				    chained_block->orig_bio_private;
-				block->orig_bio_end_io =
-				    chained_block->orig_bio_end_io;
-				block->next_in_same_bio = chained_block;
-				bio->bi_private = block;
-			}
-		} else {
-			block->is_iodone = 1;
-			block->orig_bio_private = NULL;
-			block->orig_bio_end_io = NULL;
-			block->next_in_same_bio = NULL;
-		}
-		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("new written %c-block @%llu (%pg/%llu/%d)\n",
-			       is_metadata ? 'M' : 'D',
-			       block->logical_bytenr, block->dev_state->bdev,
-			       block->dev_bytenr, block->mirror_num);
-		list_add(&block->all_blocks_node, &state->all_blocks_list);
-		btrfsic_block_hashtable_add(block, &state->block_hashtable);
-
-		if (is_metadata) {
-			ret = btrfsic_process_metablock(state, block,
-							&block_ctx, 0, 0);
-			if (ret)
-				pr_info("btrfsic: process_metablock(root @%llu) failed!\n",
-				       dev_bytenr);
-		}
-		btrfsic_release_block_ctx(&block_ctx);
-	}
-
-continue_loop:
-	BUG_ON(!processed_len);
-	dev_bytenr += processed_len;
-	mapped_datav += processed_len >> PAGE_SHIFT;
-	num_pages -= processed_len >> PAGE_SHIFT;
-	goto again;
-}
-
-static void btrfsic_bio_end_io(struct bio *bp)
-{
-	struct btrfsic_block *block = bp->bi_private;
-	int iodone_w_error;
-
-	/* mutex is not held! This is not save if IO is not yet completed
-	 * on umount */
-	iodone_w_error = 0;
-	if (bp->bi_status)
-		iodone_w_error = 1;
-
-	BUG_ON(NULL == block);
-	bp->bi_private = block->orig_bio_private;
-	bp->bi_end_io = block->orig_bio_end_io;
-
-	do {
-		struct btrfsic_block *next_block;
-		struct btrfsic_dev_state *const dev_state = block->dev_state;
-
-		if ((dev_state->state->print_mask &
-		     BTRFSIC_PRINT_MASK_END_IO_BIO_BH))
-			pr_info("bio_end_io(err=%d) for %c @%llu (%pg/%llu/%d)\n",
-			       bp->bi_status,
-			       btrfsic_get_block_type(dev_state->state, block),
-			       block->logical_bytenr, dev_state->bdev,
-			       block->dev_bytenr, block->mirror_num);
-		next_block = block->next_in_same_bio;
-		block->iodone_w_error = iodone_w_error;
-		if (block->submit_bio_bh_rw & REQ_PREFLUSH) {
-			dev_state->last_flush_gen++;
-			if ((dev_state->state->print_mask &
-			     BTRFSIC_PRINT_MASK_END_IO_BIO_BH))
-				pr_info("bio_end_io() new %pg flush_gen=%llu\n",
-				       dev_state->bdev,
-				       dev_state->last_flush_gen);
-		}
-		if (block->submit_bio_bh_rw & REQ_FUA)
-			block->flush_gen = 0; /* FUA completed means block is
-					       * on disk */
-		block->is_iodone = 1; /* for FLUSH, this releases the block */
-		block = next_block;
-	} while (NULL != block);
-
-	bp->bi_end_io(bp);
-}
-
-static int btrfsic_process_written_superblock(
-		struct btrfsic_state *state,
-		struct btrfsic_block *const superblock,
-		struct btrfs_super_block *const super_hdr)
-{
-	struct btrfs_fs_info *fs_info = state->fs_info;
-	int pass;
-
-	superblock->generation = btrfs_super_generation(super_hdr);
-	if (!(superblock->generation > state->max_superblock_generation ||
-	      0 == state->max_superblock_generation)) {
-		if (state->print_mask & BTRFSIC_PRINT_MASK_SUPERBLOCK_WRITE)
-			pr_info(
-	"btrfsic: superblock @%llu (%pg/%llu/%d) with old gen %llu <= %llu\n",
-			       superblock->logical_bytenr,
-			       superblock->dev_state->bdev,
-			       superblock->dev_bytenr, superblock->mirror_num,
-			       btrfs_super_generation(super_hdr),
-			       state->max_superblock_generation);
-	} else {
-		if (state->print_mask & BTRFSIC_PRINT_MASK_SUPERBLOCK_WRITE)
-			pr_info(
-	"btrfsic: got new superblock @%llu (%pg/%llu/%d) with new gen %llu > %llu\n",
-			       superblock->logical_bytenr,
-			       superblock->dev_state->bdev,
-			       superblock->dev_bytenr, superblock->mirror_num,
-			       btrfs_super_generation(super_hdr),
-			       state->max_superblock_generation);
-
-		state->max_superblock_generation =
-		    btrfs_super_generation(super_hdr);
-		state->latest_superblock = superblock;
-	}
-
-	for (pass = 0; pass < 3; pass++) {
-		int ret;
-		u64 next_bytenr;
-		struct btrfsic_block *next_block;
-		struct btrfsic_block_data_ctx tmp_next_block_ctx;
-		struct btrfsic_block_link *l;
-		int num_copies;
-		int mirror_num;
-		const char *additional_string = NULL;
-		struct btrfs_disk_key tmp_disk_key = {0};
-
-		btrfs_set_disk_key_objectid(&tmp_disk_key,
-					    BTRFS_ROOT_ITEM_KEY);
-		btrfs_set_disk_key_objectid(&tmp_disk_key, 0);
-
-		switch (pass) {
-		case 0:
-			btrfs_set_disk_key_objectid(&tmp_disk_key,
-						    BTRFS_ROOT_TREE_OBJECTID);
-			additional_string = "root ";
-			next_bytenr = btrfs_super_root(super_hdr);
-			if (state->print_mask &
-			    BTRFSIC_PRINT_MASK_ROOT_CHUNK_LOG_TREE_LOCATION)
-				pr_info("root@%llu\n", next_bytenr);
-			break;
-		case 1:
-			btrfs_set_disk_key_objectid(&tmp_disk_key,
-						    BTRFS_CHUNK_TREE_OBJECTID);
-			additional_string = "chunk ";
-			next_bytenr = btrfs_super_chunk_root(super_hdr);
-			if (state->print_mask &
-			    BTRFSIC_PRINT_MASK_ROOT_CHUNK_LOG_TREE_LOCATION)
-				pr_info("chunk@%llu\n", next_bytenr);
-			break;
-		case 2:
-			btrfs_set_disk_key_objectid(&tmp_disk_key,
-						    BTRFS_TREE_LOG_OBJECTID);
-			additional_string = "log ";
-			next_bytenr = btrfs_super_log_root(super_hdr);
-			if (0 == next_bytenr)
-				continue;
-			if (state->print_mask &
-			    BTRFSIC_PRINT_MASK_ROOT_CHUNK_LOG_TREE_LOCATION)
-				pr_info("log@%llu\n", next_bytenr);
-			break;
-		}
-
-		num_copies = btrfs_num_copies(fs_info, next_bytenr,
-					      BTRFS_SUPER_INFO_SIZE);
-		if (state->print_mask & BTRFSIC_PRINT_MASK_NUM_COPIES)
-			pr_info("num_copies(log_bytenr=%llu) = %d\n",
-			       next_bytenr, num_copies);
-		for (mirror_num = 1; mirror_num <= num_copies; mirror_num++) {
-			int was_created;
-
-			if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-				pr_info("btrfsic_process_written_superblock(mirror_num=%d)\n", mirror_num);
-			ret = btrfsic_map_block(state, next_bytenr,
-						BTRFS_SUPER_INFO_SIZE,
-						&tmp_next_block_ctx,
-						mirror_num);
-			if (ret) {
-				pr_info("btrfsic: btrfsic_map_block(@%llu, mirror=%d) failed!\n",
-				       next_bytenr, mirror_num);
-				return -1;
-			}
-
-			next_block = btrfsic_block_lookup_or_add(
-					state,
-					&tmp_next_block_ctx,
-					additional_string,
-					1, 0, 1,
-					mirror_num,
-					&was_created);
-			if (NULL == next_block) {
-				btrfsic_release_block_ctx(&tmp_next_block_ctx);
-				return -1;
-			}
-
-			next_block->disk_key = tmp_disk_key;
-			if (was_created)
-				next_block->generation =
-				    BTRFSIC_GENERATION_UNKNOWN;
-			l = btrfsic_block_link_lookup_or_add(
-					state,
-					&tmp_next_block_ctx,
-					next_block,
-					superblock,
-					BTRFSIC_GENERATION_UNKNOWN);
-			btrfsic_release_block_ctx(&tmp_next_block_ctx);
-			if (NULL == l)
-				return -1;
-		}
-	}
-
-	if (WARN_ON(-1 == btrfsic_check_all_ref_blocks(state, superblock, 0)))
-		btrfsic_dump_tree(state);
-
-	return 0;
-}
-
-static int btrfsic_check_all_ref_blocks(struct btrfsic_state *state,
-					struct btrfsic_block *const block,
-					int recursion_level)
-{
-	const struct btrfsic_block_link *l;
-	int ret = 0;
-
-	if (recursion_level >= 3 + BTRFS_MAX_LEVEL) {
-		/*
-		 * Note that this situation can happen and does not
-		 * indicate an error in regular cases. It happens
-		 * when disk blocks are freed and later reused.
-		 * The check-integrity module is not aware of any
-		 * block free operations, it just recognizes block
-		 * write operations. Therefore it keeps the linkage
-		 * information for a block until a block is
-		 * rewritten. This can temporarily cause incorrect
-		 * and even circular linkage information. This
-		 * causes no harm unless such blocks are referenced
-		 * by the most recent super block.
-		 */
-		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("btrfsic: abort cyclic linkage (case 1).\n");
-
-		return ret;
-	}
-
-	/*
-	 * This algorithm is recursive because the amount of used stack
-	 * space is very small and the max recursion depth is limited.
-	 */
-	list_for_each_entry(l, &block->ref_to_list, node_ref_to) {
-		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info(
-		"rl=%d, %c @%llu (%pg/%llu/%d) %u* refers to %c @%llu (%pg/%llu/%d)\n",
-			       recursion_level,
-			       btrfsic_get_block_type(state, block),
-			       block->logical_bytenr, block->dev_state->bdev,
-			       block->dev_bytenr, block->mirror_num,
-			       l->ref_cnt,
-			       btrfsic_get_block_type(state, l->block_ref_to),
-			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->bdev,
-			       l->block_ref_to->dev_bytenr,
-			       l->block_ref_to->mirror_num);
-		if (l->block_ref_to->never_written) {
-			pr_info(
-"btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which is never written!\n",
-			       btrfsic_get_block_type(state, l->block_ref_to),
-			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->bdev,
-			       l->block_ref_to->dev_bytenr,
-			       l->block_ref_to->mirror_num);
-			ret = -1;
-		} else if (!l->block_ref_to->is_iodone) {
-			pr_info(
-"btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which is not yet iodone!\n",
-			       btrfsic_get_block_type(state, l->block_ref_to),
-			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->bdev,
-			       l->block_ref_to->dev_bytenr,
-			       l->block_ref_to->mirror_num);
-			ret = -1;
-		} else if (l->block_ref_to->iodone_w_error) {
-			pr_info(
-"btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which has write error!\n",
-			       btrfsic_get_block_type(state, l->block_ref_to),
-			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->bdev,
-			       l->block_ref_to->dev_bytenr,
-			       l->block_ref_to->mirror_num);
-			ret = -1;
-		} else if (l->parent_generation !=
-			   l->block_ref_to->generation &&
-			   BTRFSIC_GENERATION_UNKNOWN !=
-			   l->parent_generation &&
-			   BTRFSIC_GENERATION_UNKNOWN !=
-			   l->block_ref_to->generation) {
-			pr_info(
-"btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) with generation %llu != parent generation %llu!\n",
-			       btrfsic_get_block_type(state, l->block_ref_to),
-			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->bdev,
-			       l->block_ref_to->dev_bytenr,
-			       l->block_ref_to->mirror_num,
-			       l->block_ref_to->generation,
-			       l->parent_generation);
-			ret = -1;
-		} else if (l->block_ref_to->flush_gen >
-			   l->block_ref_to->dev_state->last_flush_gen) {
-			pr_info(
-"btrfs: attempt to write superblock which references block %c @%llu (%pg/%llu/%d) which is not flushed out of disk's write cache (block flush_gen=%llu, dev->flush_gen=%llu)!\n",
-			       btrfsic_get_block_type(state, l->block_ref_to),
-			       l->block_ref_to->logical_bytenr,
-			       l->block_ref_to->dev_state->bdev,
-			       l->block_ref_to->dev_bytenr,
-			       l->block_ref_to->mirror_num, block->flush_gen,
-			       l->block_ref_to->dev_state->last_flush_gen);
-			ret = -1;
-		} else if (-1 == btrfsic_check_all_ref_blocks(state,
-							      l->block_ref_to,
-							      recursion_level +
-							      1)) {
-			ret = -1;
-		}
-	}
-
-	return ret;
-}
-
-static int btrfsic_is_block_ref_by_superblock(
-		const struct btrfsic_state *state,
-		const struct btrfsic_block *block,
-		int recursion_level)
-{
-	const struct btrfsic_block_link *l;
-
-	if (recursion_level >= 3 + BTRFS_MAX_LEVEL) {
-		/* refer to comment at "abort cyclic linkage (case 1)" */
-		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info("btrfsic: abort cyclic linkage (case 2).\n");
-
-		return 0;
-	}
-
-	/*
-	 * This algorithm is recursive because the amount of used stack space
-	 * is very small and the max recursion depth is limited.
-	 */
-	list_for_each_entry(l, &block->ref_from_list, node_ref_from) {
-		if (state->print_mask & BTRFSIC_PRINT_MASK_VERBOSE)
-			pr_info(
-	"rl=%d, %c @%llu (%pg/%llu/%d) is ref %u* from %c @%llu (%pg/%llu/%d)\n",
-			       recursion_level,
-			       btrfsic_get_block_type(state, block),
-			       block->logical_bytenr, block->dev_state->bdev,
-			       block->dev_bytenr, block->mirror_num,
-			       l->ref_cnt,
-			       btrfsic_get_block_type(state, l->block_ref_from),
-			       l->block_ref_from->logical_bytenr,
-			       l->block_ref_from->dev_state->bdev,
-			       l->block_ref_from->dev_bytenr,
-			       l->block_ref_from->mirror_num);
-		if (l->block_ref_from->is_superblock &&
-		    state->latest_superblock->dev_bytenr ==
-		    l->block_ref_from->dev_bytenr &&
-		    state->latest_superblock->dev_state->bdev ==
-		    l->block_ref_from->dev_state->bdev)
-			return 1;
-		else if (btrfsic_is_block_ref_by_superblock(state,
-							    l->block_ref_from,
-							    recursion_level +
-							    1))
-			return 1;
-	}
-
-	return 0;
-}
-
 static void btrfsic_print_add_link(const struct btrfsic_state *state,
 				   const struct btrfsic_block_link *l)
 {
@@ -2583,151 +1828,12 @@ static struct btrfsic_block *btrfsic_block_lookup_or_add(
 	return block;
 }
 
-static void btrfsic_cmp_log_and_dev_bytenr(struct btrfsic_state *state,
-					   u64 bytenr,
-					   struct btrfsic_dev_state *dev_state,
-					   u64 dev_bytenr)
-{
-	struct btrfs_fs_info *fs_info = state->fs_info;
-	struct btrfsic_block_data_ctx block_ctx;
-	int num_copies;
-	int mirror_num;
-	int match = 0;
-	int ret;
-
-	num_copies = btrfs_num_copies(fs_info, bytenr, state->metablock_size);
-
-	for (mirror_num = 1; mirror_num <= num_copies; mirror_num++) {
-		ret = btrfsic_map_block(state, bytenr, state->metablock_size,
-					&block_ctx, mirror_num);
-		if (ret) {
-			pr_info("btrfsic: btrfsic_map_block(logical @%llu, mirror %d) failed!\n",
-			       bytenr, mirror_num);
-			continue;
-		}
-
-		if (dev_state->bdev == block_ctx.dev->bdev &&
-		    dev_bytenr == block_ctx.dev_bytenr) {
-			match++;
-			btrfsic_release_block_ctx(&block_ctx);
-			break;
-		}
-		btrfsic_release_block_ctx(&block_ctx);
-	}
-
-	if (WARN_ON(!match)) {
-		pr_info(
-"btrfs: attempt to write M-block which contains logical bytenr that doesn't map to dev+physical bytenr of submit_bio, buffer->log_bytenr=%llu, submit_bio(bdev=%pg, phys_bytenr=%llu)!\n",
-		       bytenr, dev_state->bdev, dev_bytenr);
-		for (mirror_num = 1; mirror_num <= num_copies; mirror_num++) {
-			ret = btrfsic_map_block(state, bytenr,
-						state->metablock_size,
-						&block_ctx, mirror_num);
-			if (ret)
-				continue;
-
-			pr_info("read logical bytenr @%llu maps to (%pg/%llu/%d)\n",
-			       bytenr, block_ctx.dev->bdev,
-			       block_ctx.dev_bytenr, mirror_num);
-		}
-	}
-}
-
 static struct btrfsic_dev_state *btrfsic_dev_state_lookup(dev_t dev)
 {
 	return btrfsic_dev_state_hashtable_lookup(dev,
 						  &btrfsic_dev_state_hashtable);
 }
 
-static void btrfsic_check_write_bio(struct bio *bio, struct btrfsic_dev_state *dev_state)
-{
-	unsigned int segs = bio_segments(bio);
-	u64 dev_bytenr = 512 * bio->bi_iter.bi_sector;
-	u64 cur_bytenr = dev_bytenr;
-	struct bvec_iter iter;
-	struct bio_vec bvec;
-	char **mapped_datav;
-	int bio_is_patched = 0;
-	int i = 0;
-
-	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-		pr_info(
-"submit_bio(rw=%d,0x%x, bi_vcnt=%u, bi_sector=%llu (bytenr %llu), bi_bdev=%p)\n",
-		       bio_op(bio), bio->bi_opf, segs,
-		       bio->bi_iter.bi_sector, dev_bytenr, bio->bi_bdev);
-
-	mapped_datav = kmalloc_array(segs, sizeof(*mapped_datav), GFP_NOFS);
-	if (!mapped_datav)
-		return;
-
-	bio_for_each_segment(bvec, bio, iter) {
-		BUG_ON(bvec.bv_len != PAGE_SIZE);
-		mapped_datav[i] = page_address(bvec.bv_page);
-		i++;
-
-		if (dev_state->state->print_mask &
-		    BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH_VERBOSE)
-			pr_info("#%u: bytenr=%llu, len=%u, offset=%u\n",
-			       i, cur_bytenr, bvec.bv_len, bvec.bv_offset);
-		cur_bytenr += bvec.bv_len;
-	}
-
-	btrfsic_process_written_block(dev_state, dev_bytenr, mapped_datav, segs,
-				      bio, &bio_is_patched, bio->bi_opf);
-	kfree(mapped_datav);
-}
-
-static void btrfsic_check_flush_bio(struct bio *bio, struct btrfsic_dev_state *dev_state)
-{
-	if (dev_state->state->print_mask & BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH)
-		pr_info("submit_bio(rw=%d,0x%x FLUSH, bdev=%p)\n",
-		       bio_op(bio), bio->bi_opf, bio->bi_bdev);
-
-	if (dev_state->dummy_block_for_bio_bh_flush.is_iodone) {
-		struct btrfsic_block *const block =
-			&dev_state->dummy_block_for_bio_bh_flush;
-
-		block->is_iodone = 0;
-		block->never_written = 0;
-		block->iodone_w_error = 0;
-		block->flush_gen = dev_state->last_flush_gen + 1;
-		block->submit_bio_bh_rw = bio->bi_opf;
-		block->orig_bio_private = bio->bi_private;
-		block->orig_bio_end_io = bio->bi_end_io;
-		block->next_in_same_bio = NULL;
-		bio->bi_private = block;
-		bio->bi_end_io = btrfsic_bio_end_io;
-	} else if ((dev_state->state->print_mask &
-		   (BTRFSIC_PRINT_MASK_SUBMIT_BIO_BH |
-		    BTRFSIC_PRINT_MASK_VERBOSE))) {
-		pr_info(
-"btrfsic_submit_bio(%pg) with FLUSH but dummy block already in use (ignored)!\n",
-		       dev_state->bdev);
-	}
-}
-
-void btrfsic_check_bio(struct bio *bio)
-{
-	struct btrfsic_dev_state *dev_state;
-
-	if (!btrfsic_is_initialized)
-		return;
-
-	/*
-	 * We can be called before btrfsic_mount, so there might not be a
-	 * dev_state.
-	 */
-	dev_state = btrfsic_dev_state_lookup(bio->bi_bdev->bd_dev);
-	mutex_lock(&btrfsic_mutex);
-	if (dev_state) {
-		if (bio_op(bio) == REQ_OP_WRITE && bio_has_data(bio))
-			btrfsic_check_write_bio(bio, dev_state);
-		else if (bio->bi_opf & REQ_PREFLUSH)
-			btrfsic_check_flush_bio(bio, dev_state);
-	}
-	mutex_unlock(&btrfsic_mutex);
-}
-
 int btrfsic_mount(struct btrfs_fs_info *fs_info,
 		  struct btrfs_fs_devices *fs_devices,
 		  int including_extent_data, u32 print_mask)
diff --git a/fs/btrfs/check-integrity.h b/fs/btrfs/check-integrity.h
index e4c8aed7996f..40289f1db471 100644
--- a/fs/btrfs/check-integrity.h
+++ b/fs/btrfs/check-integrity.h
@@ -6,12 +6,6 @@
 #ifndef BTRFS_CHECK_INTEGRITY_H
 #define BTRFS_CHECK_INTEGRITY_H
 
-#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
-void btrfsic_check_bio(struct bio *bio);
-#else
-static inline void btrfsic_check_bio(struct bio *bio) { }
-#endif
-
 int btrfsic_mount(struct btrfs_fs_info *fs_info,
 		  struct btrfs_fs_devices *fs_devices,
 		  int including_extent_data, u32 print_mask);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6404b17a5bdc..bad2447e86b5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3821,8 +3821,6 @@ static int write_dev_supers(struct btrfs_device *device,
 		 */
 		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
 			bio->bi_opf |= REQ_FUA;
-
-		btrfsic_check_bio(bio);
 		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
@@ -3938,8 +3936,6 @@ static void write_dev_flush(struct btrfs_device *device)
 	bio->bi_end_io = btrfs_end_empty_barrier;
 	init_completion(&device->flush_wait);
 	bio->bi_private = &device->flush_wait;
-
-	btrfsic_check_bio(bio);
 	submit_bio(bio);
 	set_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
 }
-- 
2.42.0

