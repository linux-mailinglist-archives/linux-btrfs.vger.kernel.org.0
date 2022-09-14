Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5535B8103
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 07:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiINFdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 01:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiINFdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 01:33:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0270D6BCFF
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 22:33:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BBDE34304
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663133591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f/2OqV/IIz7AHdoFSh7lbztsraIm1rHS9N212ecImQU=;
        b=Ok7HR6IQ3IrCHBmo3UkCfKvkdUBhFT3iWWCrR0lUEVU4GkViVsfJkWYY9WDCtBKcu0h9JR
        lSvooRG7kEZ8lwfTEOkhueXBaUwM69G/kGNGigh3FRhEM8z/FBqLQ48T0bhBvn5Upyo1eR
        yavOJarAKgXle+rRjWO5oxv9BJaDRMY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E37D813486
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +BU6K5ZnIWO6RQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 05:33:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move tree block parentness check into validate_extent_buffer()
Date:   Wed, 14 Sep 2022 13:32:51 +0800
Message-Id: <9b5f51d5b24faec0d2385f49552ed6220ee8d81c.1663133223.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663133223.git.wqu@suse.com>
References: <cover.1663133223.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
Although both btrfs metadata and data has their read time verification
done at endio time (btrfs_validate_metadata_buffer() and
btrfs_verify_data_csum()), metadata has extra verification, mostly
parentness check including first key/transid/owner_root/level, done at
read_tree_block() and btrfs_read_extent_buffer().

On the other hand, all data verification is done at endio context.

[ENHANCEMENT]
This patch will make a new union in btrfs_bio, taking the space of the
old data checksums, thus it will not increase the memory usage.

With that extra btrfs_tree_parent_check inside btrfs_bio, we can just
pass the check parameter into read_extent_buffer_pages(), and before
submitting the bio, we can copy the check structure into btrfs_bio.

And finally at endio time, we can grab btrfs_bio::parent_check and pass
it to validate_extent_buffer(), to move the remaining checks into it.

This brings the following benefits:

- Much simpler btrfs_read_extent_buffer()
  Now it only needs to iterate through all mirrors.

- Simpler read-time transid check
  Previously we go verify_parent_transid() after reading out the extent
  buffer.
  Now the transid check is done inside the endio function, no other
  code can modify the content.
  Thus no need to use the extent lock anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 76 ++++++++++++++++++++++++++++++++------------
 fs/btrfs/extent_io.c | 18 ++++++++---
 fs/btrfs/extent_io.h |  5 +--
 fs/btrfs/volumes.h   | 25 +++++++++++++--
 4 files changed, 95 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 80aa0ba4ac55..0b7d297f9367 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -260,7 +260,6 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 			     struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct extent_io_tree *io_tree;
 	int failed = 0;
 	int ret;
 	int num_copies = 0;
@@ -269,22 +268,12 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
 
 	ASSERT(check);
 
-	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 	while (1) {
 		clear_bit(EXTENT_BUFFER_CORRUPT, &eb->bflags);
-		ret = read_extent_buffer_pages(eb, WAIT_COMPLETE, mirror_num);
-		if (!ret) {
-			if (verify_parent_transid(io_tree, eb,
-						  check->transid, 0))
-				ret = -EIO;
-			else if (btrfs_verify_level_key(eb, check->level,
-						check->has_first_key ?
-						&check->first_key : NULL,
-						check->transid))
-				ret = -EUCLEAN;
-			else
-				break;
-		}
+		ret = read_extent_buffer_pages(eb, WAIT_COMPLETE, mirror_num,
+					       check);
+		if (!ret)
+			break;
 
 		num_copies = btrfs_num_copies(fs_info,
 					      eb->start, eb->len);
@@ -460,7 +449,8 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 }
 
 /* Do basic extent buffer checks at read time */
-static int validate_extent_buffer(struct extent_buffer *eb)
+static int validate_extent_buffer(struct extent_buffer *eb,
+				  struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 found_start;
@@ -470,6 +460,8 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 	const u8 *header_csum;
 	int ret = 0;
 
+	ASSERT(check);
+
 	found_start = btrfs_header_bytenr(eb);
 	if (found_start != eb->start) {
 		btrfs_err_rl(fs_info,
@@ -508,6 +500,45 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 		goto out;
 	}
 
+	if (found_level != check->level) {
+		ret = -EIO;
+		goto out;
+	}
+	if (check->transid && btrfs_header_generation(eb) != check->transid) {
+		btrfs_err_rl(eb->fs_info,
+"parent transid verify failed on logical %llu mirror %u wanted %llu found %llu",
+				eb->start, eb->read_mirror,
+				check->transid,
+				btrfs_header_generation(eb));
+		ret = -EIO;
+		goto out;
+	}
+	if (check->has_first_key) {
+		struct btrfs_key *expect_key = &check->first_key;
+		struct btrfs_key found_key;
+
+		if (found_level)
+			btrfs_node_key_to_cpu(eb, &found_key, 0);
+		else
+			btrfs_item_key_to_cpu(eb, &found_key, 0);
+		if (btrfs_comp_cpu_keys(expect_key, &found_key)) {
+			btrfs_err(fs_info,
+"tree first key mismatch detected, bytenr=%llu parent_transid=%llu key expected=(%llu,%u,%llu) has=(%llu,%u,%llu)",
+				  eb->start, check->transid,
+				  expect_key->objectid,
+				  expect_key->type, expect_key->offset,
+				  found_key.objectid, found_key.type,
+				  found_key.offset);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+	if (check->owner_root) {
+		ret = btrfs_check_eb_owner(eb, check->owner_root);
+		if (ret < 0)
+			goto out;
+	}
+
 	/*
 	 * If this is a leaf block and it is corrupt, set the corrupt bit so
 	 * that we don't try and read the other copies of this block, just
@@ -532,13 +563,16 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 }
 
 static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
-				   int mirror)
+				   int mirror,
+				   struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	struct extent_buffer *eb;
 	bool reads_done;
 	int ret = 0;
 
+	ASSERT(check);
+
 	/*
 	 * We don't allow bio merge for subpage metadata read, so we should
 	 * only get one eb for each endio hook.
@@ -562,7 +596,7 @@ static int validate_subpage_buffer(struct page *page, u64 start, u64 end,
 		ret = -EIO;
 		goto err;
 	}
-	ret = validate_extent_buffer(eb);
+	ret = validate_extent_buffer(eb, check);
 	if (ret < 0)
 		goto err;
 
@@ -592,7 +626,8 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 	ASSERT(page->private);
 
 	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
-		return validate_subpage_buffer(page, start, end, mirror);
+		return validate_subpage_buffer(page, start, end, mirror,
+					       &bbio->parent_check);
 
 	eb = (struct extent_buffer *)page->private;
 
@@ -611,7 +646,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 		ret = -EIO;
 		goto err;
 	}
-	ret = validate_extent_buffer(eb);
+	ret = validate_extent_buffer(eb, &bbio->parent_check);
 err:
 	if (ret) {
 		/*
@@ -761,6 +796,7 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	blk_status_t ret;
 
 	bio->bi_opf |= REQ_META;
+	bbio->is_metadata = 1;
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
 		btrfs_submit_bio(fs_info, bio, mirror_num);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2499a01f7638..abd8dbd80065 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6749,7 +6749,8 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 }
 
 static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
-				      int mirror_num)
+				      int mirror_num,
+				      struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
@@ -6761,6 +6762,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
 	ASSERT(PagePrivate(page));
+	ASSERT(check);
 	io_tree = &BTRFS_I(fs_info->btree_inode)->io_tree;
 
 	if (wait == WAIT_NONE) {
@@ -6801,6 +6803,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		 */
 		atomic_dec(&eb->io_pages);
 	}
+	memcpy(&btrfs_bio(bio_ctrl.bio)->parent_check, check, sizeof(*check));
 	submit_one_bio(&bio_ctrl);
 	if (ret || wait != WAIT_COMPLETE)
 		return ret;
@@ -6811,7 +6814,8 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	return ret;
 }
 
-int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
+int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
+			     struct btrfs_tree_parent_check *check)
 {
 	int i;
 	struct page *page;
@@ -6837,7 +6841,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 		return -EIO;
 
 	if (eb->fs_info->nodesize < PAGE_SIZE)
-		return read_extent_buffer_subpage(eb, wait, mirror_num);
+		return read_extent_buffer_subpage(eb, wait, mirror_num, check);
 
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
@@ -6914,6 +6918,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 		}
 	}
 
+	memcpy(&btrfs_bio(bio_ctrl.bio)->parent_check, check, sizeof(*check));
 	submit_one_bio(&bio_ctrl);
 
 	if (ret || wait != WAIT_COMPLETE)
@@ -7646,9 +7651,14 @@ int try_release_extent_buffer(struct page *page)
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level)
 {
+	struct btrfs_tree_parent_check check = {0};
 	struct extent_buffer *eb;
 	int ret;
 
+	check.has_first_key = 0;
+	check.level = level;
+	check.transid = gen;
+
 	eb = btrfs_find_create_tree_block(fs_info, bytenr, owner_root, level);
 	if (IS_ERR(eb))
 		return;
@@ -7658,7 +7668,7 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	ret = read_extent_buffer_pages(eb, WAIT_NONE, 0);
+	ret = read_extent_buffer_pages(eb, WAIT_NONE, 0, &check);
 	if (ret < 0)
 		free_extent_buffer_stale(eb);
 	else
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 69a86ae6fd50..d4b4794595b5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -63,6 +63,7 @@ struct btrfs_inode;
 struct btrfs_fs_info;
 struct io_failure_record;
 struct extent_io_tree;
+struct btrfs_tree_parent_check;
 
 typedef void (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 					 int mirror_num,
@@ -171,8 +172,8 @@ void free_extent_buffer_stale(struct extent_buffer *eb);
 #define WAIT_NONE	0
 #define WAIT_COMPLETE	1
 #define WAIT_PAGE_LOCK	2
-int read_extent_buffer_pages(struct extent_buffer *eb, int wait,
-			     int mirror_num);
+int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
+			     struct btrfs_tree_parent_check *parent_check);
 void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f19a1cd1bfcf..6e0d9565b36d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/btrfs.h>
 #include "async-thread.h"
+#include "disk-io.h"
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
@@ -369,15 +370,31 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  * Mostly for btrfs specific features like csum and mirror_num.
  */
 struct btrfs_bio {
-	unsigned int mirror_num;
+	unsigned int mirror_num:7;
+
+	/*
+	 * Extra indicator for metadata bios.
+	 * For some btrfs bios they use pages without a mapping, thus
+	 * we can not rely on page->mapping->host to determine if
+	 * it's a metadata bio.
+	 */
+	unsigned int is_metadata:1;
 
 	/* for direct I/O */
 	u64 file_offset;
 
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
-	u8 *csum;
-	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+	union {
+		/* For data checksum verification. */
+		struct {
+			u8 *csum;
+			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+		};
+
+		/* For metadata parentness verification. */
+		struct btrfs_tree_parent_check parent_check;
+	};
 	struct bvec_iter iter;
 
 	/* End I/O information supplied to btrfs_bio_alloc */
@@ -415,6 +432,8 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 {
+	if (bbio->is_metadata)
+		return;
 	if (bbio->csum != bbio->csum_inline) {
 		kfree(bbio->csum);
 		bbio->csum = NULL;
-- 
2.37.3

