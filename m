Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9C05ABDCA
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiICIUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiICIUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:20:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05219326E0
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:20:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF490336D9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKcYskMmq6cOw1OZ7yu/EPOje8CnSygaLDmUiKF0kG4=;
        b=HJTHtMyLwSd2gVtOAbt+EH0Vda4xqFKi1bAnWizKwsyMFwFhEpXbGAgHETE983kkwyHen2
        1skZPmVC4W/XyYraLXJw+1EW76z7w7OML3/9wOYnzyiwDFhzvcLEI6GEni3Ck/fzWw3fpx
        BB4lAOYDGfBdAnWoLDUH41/TZpxloho=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A2A5139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uPYVMS0OE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:19:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 7/9] btrfs: scrub: implement metadata verification code for scrub_fs
Date:   Sat,  3 Sep 2022 16:19:27 +0800
Message-Id: <1b48b161aa6cd64378cdb83178deea49ef0625ce.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch introduces the following functions:

- scrub_fs_verify_one_stripe()
  The entrance for all verification code.

  Which will iterate every sector in the same vertical stripe.

- scrub_fs_verify_meta()
  The helper to verify metadata in one vertical stripe.
  (Since no RAID56 support, one vertical stripe just contains
   all the same data from different mirrors)

- scrub_fs_verify_one_meta()
  This is the real work, the checks includes:

  * Basic metadata header checks (bytenr, fsid, level)
    For this part, we refactor those checks from
    validate_extent_buffer() into btrfs_validate_eb_basic(),
    allowing us to suppress the error messages.

  * Checksum verification
    For this part, we refactor this one check from
    validate_extent_buffer() into btrfs_validate_eb_csum(),
    allowing us to suppress the error message.

  * Tree check verification (NEW)
    This is the new one, the old scrub code never fully utilize the
    whole extent buffer related facilities, thus only very basic checks.
    Now scrub_fs has (almost) the same checks as tree block read
    routine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  83 ++++++++++++++++-------
 fs/btrfs/disk-io.h |   2 +
 fs/btrfs/scrub.c   | 164 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 222 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e67614afcf4f..6eda9e615ae7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -457,55 +457,87 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 	return 1;
 }
 
-/* Do basic extent buffer checks at read time */
-static int validate_extent_buffer(struct extent_buffer *eb)
+/*
+ * The very basic extent buffer checks, including:
+ *
+ * - Bytenr check
+ * - FSID check
+ * - Level check
+ *
+ * If @error_message is true, it will output error message (rate limited).
+ */
+int btrfs_validate_eb_basic(struct extent_buffer *eb, bool error_message)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 found_start;
-	const u32 csum_size = fs_info->csum_size;
 	u8 found_level;
-	u8 result[BTRFS_CSUM_SIZE];
-	const u8 *header_csum;
 	int ret = 0;
 
 	found_start = btrfs_header_bytenr(eb);
 	if (found_start != eb->start) {
-		btrfs_err_rl(fs_info,
+		if (error_message)
+			btrfs_err_rl(fs_info,
 			"bad tree block start, mirror %u want %llu have %llu",
-			     eb->read_mirror, eb->start, found_start);
-		ret = -EIO;
-		goto out;
+				     eb->read_mirror, eb->start, found_start);
+		return -EIO;
 	}
 	if (check_tree_block_fsid(eb)) {
-		btrfs_err_rl(fs_info, "bad fsid on logical %llu mirror %u",
-			     eb->start, eb->read_mirror);
-		ret = -EIO;
-		goto out;
+		if (error_message)
+			btrfs_err_rl(fs_info, "bad fsid on logical %llu mirror %u",
+				     eb->start, eb->read_mirror);
+		return -EIO;
 	}
 	found_level = btrfs_header_level(eb);
 	if (found_level >= BTRFS_MAX_LEVEL) {
-		btrfs_err(fs_info,
-			"bad tree block level, mirror %u level %d on logical %llu",
-			eb->read_mirror, btrfs_header_level(eb), eb->start);
-		ret = -EIO;
-		goto out;
+		if (error_message)
+			btrfs_err(fs_info,
+				"bad tree block level, mirror %u level %d on logical %llu",
+				eb->read_mirror, btrfs_header_level(eb), eb->start);
+		return -EIO;
 	}
+	return ret;
+}
+
+int btrfs_validate_eb_csum(struct extent_buffer *eb, bool error_message)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u8 result[BTRFS_CSUM_SIZE];
+	const u8 *header_csum;
+	const u32 csum_size = fs_info->csum_size;
 
 	csum_tree_block(eb, result);
 	header_csum = page_address(eb->pages[0]) +
 		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
-		btrfs_warn_rl(fs_info,
+		if (error_message)
+			btrfs_warn_rl(fs_info,
 "checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
-			      eb->start, eb->read_mirror,
-			      CSUM_FMT_VALUE(csum_size, header_csum),
-			      CSUM_FMT_VALUE(csum_size, result),
-			      btrfs_header_level(eb));
-		ret = -EUCLEAN;
-		goto out;
+				      eb->start, eb->read_mirror,
+				      CSUM_FMT_VALUE(csum_size, header_csum),
+				      CSUM_FMT_VALUE(csum_size, result),
+				      btrfs_header_level(eb));
+		return -EUCLEAN;
 	}
+	return 0;
+}
+
+/* Do basic extent buffer checks at read time */
+static inline int validate_extent_buffer(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u8 found_level;
+	int ret = 0;
+
+	ret = btrfs_validate_eb_basic(eb, true);
+	if (ret < 0)
+		return ret;
 
+	ret = btrfs_validate_eb_csum(eb, true);
+	if (ret < 0)
+		return ret;
+
+	found_level = btrfs_header_level(eb);
 	/*
 	 * If this is a leaf block and it is corrupt, set the corrupt bit so
 	 * that we don't try and read the other copies of this block, just
@@ -525,7 +557,6 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 		btrfs_err(fs_info,
 		"read time tree block corruption detected on logical %llu mirror %u",
 			  eb->start, eb->read_mirror);
-out:
 	return ret;
 }
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 47ad8e0a2d33..3d154873d4e5 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -80,6 +80,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
+int btrfs_validate_eb_basic(struct extent_buffer *eb, bool error_message);
+int btrfs_validate_eb_csum(struct extent_buffer *eb, bool error_message);
 void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 70a54c6d8888..f587d0373517 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -20,6 +20,7 @@
 #include "rcu-string.h"
 #include "raid56.h"
 #include "block-group.h"
+#include "tree-checker.h"
 #include "zoned.h"
 
 /*
@@ -208,6 +209,9 @@ struct scrub_ctx {
 #define SCRUB_FS_SECTOR_FLAG_IO_ERROR		(1 << 5)
 #define SCRUB_FS_SECTOR_FLAG_IO_DONE		(1 << 6)
 
+/* This marks if the sector is a good one (aka, passed all checks). */
+#define SCRUB_FS_SECTOR_FLAG_GOOD		(1 << 7)
+
 /*
  * Represent a sector.
  *
@@ -311,6 +315,11 @@ struct scrub_fs_ctx {
 	 */
 	u8				*csum_buf;
 
+	/*
+	 * This is for METADATA block group verification, we use this dummy eb
+	 * to utilize all the accessors for extent buffers.
+	 */
+	struct extent_buffer		*dummy_eb;
 	wait_queue_head_t		wait;
 };
 
@@ -4599,6 +4608,10 @@ static void scrub_fs_cleanup_for_bg(struct scrub_fs_ctx *sfctx)
 	kfree(sfctx->csum_buf);
 	sfctx->csum_buf = NULL;
 
+	if (sfctx->dummy_eb) {
+		free_extent_buffer_stale(sfctx->dummy_eb);
+		sfctx->dummy_eb = NULL;
+	}
 	/* NOTE: block group will only be put inside scrub_fs_iterate_bgs(). */
 	sfctx->cur_bg = NULL;
 }
@@ -4626,6 +4639,7 @@ static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
 	ASSERT(!sfctx->pages);
 	ASSERT(!sfctx->sectors);
 	ASSERT(!sfctx->csum_buf);
+	ASSERT(!sfctx->dummy_eb);
 
 	read_lock(&map_tree->lock);
 	em = lookup_extent_mapping(map_tree, bg->start, bg->length);
@@ -4683,6 +4697,12 @@ static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
 		if (!sfctx->csum_buf)
 			goto enomem;
 	}
+	if (bg->flags & (BTRFS_BLOCK_GROUP_METADATA |
+			 BTRFS_BLOCK_GROUP_SYSTEM)) {
+		sfctx->dummy_eb = alloc_dummy_extent_buffer(fs_info, 0);
+		if (!sfctx->dummy_eb)
+			goto enomem;
+	}
 	sfctx->cur_bg = bg;
 	sfctx->cur_logical = bg->start;
 	return 0;
@@ -5101,6 +5121,148 @@ static void submit_stripe_read_bio(struct scrub_fs_ctx *sfctx,
 	submit_bio(bio);
 }
 
+static void scrub_fs_verify_one_meta(struct scrub_fs_ctx *sfctx, int sector_nr,
+				     int mirror_nr)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct extent_buffer *eb = sfctx->dummy_eb;
+	const int sectors_per_mirror = BTRFS_STRIPE_LEN >>
+				       fs_info->sectorsize_bits;
+	const u64 logical = sfctx->cur_logical + (sector_nr <<
+						  fs_info->sectorsize_bits);
+	const u64 expected_gen = sfctx->sectors[sector_nr].eb_generation;
+	int ret;
+	int i;
+
+	sfctx->stat.meta_scrubbed += fs_info->nodesize;
+
+	/* No IO is done for the sectors. Just update the accounting and exit. */
+	if (sfctx->sectors[sector_nr + mirror_nr * sectors_per_mirror].flags &
+	    (SCRUB_FS_SECTOR_FLAG_DEV_MISSING | SCRUB_FS_SECTOR_FLAG_IO_ERROR)) {
+		sfctx->stat.meta_io_fail += fs_info->nodesize;
+		return;
+	}
+
+	/* Sector_nr should always be the sector number in the first mirror. */
+	ASSERT(sector_nr >= 0 && sector_nr < sectors_per_mirror);
+	ASSERT(eb);
+
+	eb->start = logical;
+
+	/* Copy all the metadata sectors into the dummy eb. */
+	for (i = sector_nr + mirror_nr * sectors_per_mirror;
+	     i < sector_nr + mirror_nr * sectors_per_mirror +
+	     (fs_info->nodesize >> fs_info->sectorsize_bits); i++) {
+		struct page *page = scrub_fs_get_page(sfctx, i);
+		int page_off = scrub_fs_get_page_offset(sfctx, i);
+		int off_in_eb = (i - mirror_nr * sectors_per_mirror -
+				 sector_nr) << fs_info->sectorsize_bits;
+
+		write_extent_buffer(eb, page_address(page) + page_off,
+				    off_in_eb, fs_info->sectorsize);
+	}
+
+	/* Basic extent buffer checks. */
+	ret = btrfs_validate_eb_basic(eb, false);
+	if (ret < 0) {
+		sfctx->stat.meta_invalid += fs_info->nodesize;
+		return;
+	}
+	/* Csum checks. */
+	ret = btrfs_validate_eb_csum(eb, false);
+	if (ret < 0) {
+		sfctx->stat.meta_bad_csum += fs_info->nodesize;
+		return;
+	}
+	/* Full tree-check checks. */
+	if (btrfs_header_level(eb) > 0)
+		ret = btrfs_check_node(eb);
+	else
+		ret = btrfs_check_leaf_full(eb);
+	if (ret < 0) {
+		sfctx->stat.meta_invalid += fs_info->nodesize;
+		return;
+	}
+
+	/* Transid check */
+	if (btrfs_header_generation(eb) != expected_gen) {
+		sfctx->stat.meta_bad_transid += fs_info->nodesize;
+		return;
+	}
+
+	/*
+	 * All good, set involved sectors with GOOD_COPY flag so later we can
+	 * know if the veritical stripe has any good copy, thus if corrupted
+	 * sectors can be recoverable.
+	 */
+	for (i = sector_nr + mirror_nr * sectors_per_mirror;
+	     i < sector_nr + mirror_nr * sectors_per_mirror +
+	     (fs_info->nodesize >> fs_info->sectorsize_bits); i++)
+		sfctx->sectors[i].flags |= SCRUB_FS_SECTOR_FLAG_GOOD;
+}
+
+static void scrub_fs_verify_meta(struct scrub_fs_ctx *sfctx, int sector_nr)
+{
+	struct extent_buffer *eb = sfctx->dummy_eb;
+	int i;
+
+	/*
+	 * This should be allocated when we enter the metadata block group.
+	 * If not allocated, this means the block group flags is unreliable.
+	 *
+	 * Anyway we can only exit with invalid metadata errors increased.
+	 */
+	if (!eb) {
+		btrfs_err_rl(sfctx->fs_info,
+	"block group %llu flag 0x%llx should not have metadata at %llu",
+			     sfctx->cur_bg->start, sfctx->cur_bg->flags,
+			     sfctx->cur_logical +
+			     (sector_nr << sfctx->fs_info->sectorsize_bits));
+		sfctx->stat.meta_invalid += sfctx->fs_info->nodesize;
+		return;
+	}
+
+	for (i = 0; i < sfctx->nr_copies; i++)
+		scrub_fs_verify_one_meta(sfctx, sector_nr, i);
+}
+
+static void scrub_fs_verify_one_stripe(struct scrub_fs_ctx *sfctx)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	const int sectors_per_stripe = BTRFS_STRIPE_LEN >>
+				       fs_info->sectorsize_bits;
+	int sector_nr;
+
+	for (sector_nr = 0; sector_nr < sectors_per_stripe; sector_nr++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, sector_nr, 0);
+
+		/*
+		 * All sectors in the same veritical stripe should share
+		 * the same UNUSED/DATA/META flags, thus checking the UNUSED
+		 * flag of mirror 0 is enough to determine if this
+		 * vertical stripe needs verification.
+		 */
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_UNUSED)
+			continue;
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_META) {
+			scrub_fs_verify_meta(sfctx, sector_nr);
+			/*
+			 * For metadata, we need to skip to the end of the tree
+			 * block, and don't forget @sector_nr will get
+			 * increased by 1 from the for loop.
+			 */
+			sector_nr += (fs_info->nodesize >>
+				      fs_info->sectorsize_bits) - 1;
+			continue;
+		}
+
+		/* Place holder for data verification. */
+	}
+	/* Place holder for recoverable checks. */
+}
+
 static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
 {
 	struct btrfs_fs_info *fs_info = sfctx->fs_info;
@@ -5144,7 +5306,7 @@ static int scrub_fs_one_stripe(struct scrub_fs_ctx *sfctx)
 		submit_stripe_read_bio(sfctx, bioc, i);
 	wait_event(sfctx->wait, atomic_read(&sfctx->sectors_under_io) == 0);
 
-	/* Place holder to verify the read data. */
+	scrub_fs_verify_one_stripe(sfctx);
 out:
 	btrfs_put_bioc(bioc);
 	btrfs_bio_counter_dec(fs_info);
-- 
2.37.3

