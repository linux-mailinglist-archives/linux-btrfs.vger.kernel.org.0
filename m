Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35445ED7E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiI1IgX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiI1IgR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CDD9C7EB
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 854321F891
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mNeaiymCr0ig8mY+5nCss/Oe4k/S5vtVwqi/Gs/5t/c=;
        b=JnA/xx13q2Ja3GuCCwbzmdWv105u2xg74E76iIepYo8cAh/dvbIO8x9LJrvs2vg3XsdfPe
        D4TXfBQl+WWVJ2wreAUGyHy3A6kq9w3xEZbNnUXzfmj/48inXD7AKJ7jNuAtZ7dCmINiVI
        aLaP4aKCWKQW9ytjrv+aQ9zCXOGAY9s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE73313A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0KcrJX0HNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 07/10] btrfs: scrub: implement metadata verification code for scrub_fs
Date:   Wed, 28 Sep 2022 16:35:44 +0800
Message-Id: <562d762edfbb09d8cf0fd92c35d38de10710a005.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/disk-io.c |  83 +++++++++++++++++++----------
 fs/btrfs/disk-io.h |   2 +
 fs/btrfs/scrub.c   | 127 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c10d368aed7b..1ee05c72b210 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -456,55 +456,87 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
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
@@ -524,7 +556,6 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 		btrfs_err(fs_info,
 		"read time tree block corruption detected on logical %llu mirror %u",
 			  eb->start, eb->read_mirror);
-out:
 	return ret;
 }
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index c67c15d4d20b..65110e8e0c8e 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -83,6 +83,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
+int btrfs_validate_eb_basic(struct extent_buffer *eb, bool error_message);
+int btrfs_validate_eb_csum(struct extent_buffer *eb, bool error_message);
 void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cb0973e7ffd2..a693e35d172d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -20,6 +20,7 @@
 #include "rcu-string.h"
 #include "raid56.h"
 #include "block-group.h"
+#include "tree-checker.h"
 #include "zoned.h"
 
 /*
@@ -208,6 +209,18 @@ struct scrub_ctx {
 #define SCRUB_FS_SECTOR_FLAG_IO_ERROR		(1 << 5)
 #define SCRUB_FS_SECTOR_FLAG_IO_DONE		(1 << 6)
 
+/* This marks if the sector is a good one (aka, passed all checks). */
+#define SCRUB_FS_SECTOR_FLAG_GOOD		(1 << 7)
+
+/* For both metadata and data. */
+#define SCRUB_FS_SECTOR_FLAG_BAD_CSUM		(1 << 8)
+
+/* Only for metadata, indicating some invalid values. */
+#define SCRUB_FS_SECTOR_FLAG_INVALID		(1 << 9)
+
+/* Only for metadata, transid mismatch. */
+#define SCRUB_FS_SECTOR_FLAG_TRANSID_MISMATCH	(1 << 10)
+
 /*
  * Represent a sector.
  *
@@ -248,6 +261,12 @@ struct scrub_fs_endio_ctrl {
 
 	/* To locate the real sectors of the stripe. */
 	int				mirror_nr;
+
+	/*
+	 * Dummy extent buffer for metadata verification, so that we can
+	 * utlize all eb related accessors.
+	 */
+	struct extent_buffer		*dummy_eb;
 };
 
 /* This structure should only has a lifespan inside btrfs_scrub_fs(). */
@@ -4599,6 +4618,11 @@ static void scrub_fs_cleanup_for_bg(struct scrub_fs_ctx *sfctx)
 	int i;
 	const int nr_pages = sfctx->nr_copies * (BTRFS_STRIPE_LEN >> PAGE_SHIFT);
 
+	if (sfctx->endio_ctrls) {
+		ASSERT(sfctx->nr_copies);
+		for (i = 0; i < sfctx->nr_copies; i++)
+			free_extent_buffer(sfctx->endio_ctrls[i].dummy_eb);
+	}
 	kfree(sfctx->endio_ctrls);
 	sfctx->endio_ctrls = NULL;
 
@@ -4688,6 +4712,13 @@ static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
 	for (i = 0; i < sfctx->nr_copies; i++) {
 		sfctx->endio_ctrls[i].sfctx = sfctx;
 		sfctx->endio_ctrls[i].mirror_nr = i;
+		if (bg->flags & (BTRFS_BLOCK_GROUP_METADATA |
+				 BTRFS_BLOCK_GROUP_SYSTEM)) {
+			sfctx->endio_ctrls[i].dummy_eb =
+				alloc_dummy_extent_buffer(fs_info, 0);
+			if (!sfctx->endio_ctrls[i].dummy_eb)
+				goto enomem;
+		}
 	}
 
 	sfctx->pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
@@ -5016,10 +5047,81 @@ static unsigned int scrub_fs_get_page_offset(struct scrub_fs_ctx *sfctx,
 	return offset_in_page(index << sfctx->fs_info->sectorsize_bits);
 }
 
+static void scrub_fs_verify_meta(struct scrub_fs_endio_ctrl *endio_ctrl,
+				 int sector_nr, int mirror_nr)
+{
+	struct scrub_fs_ctx *sfctx = endio_ctrl->sfctx;
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct extent_buffer *eb = endio_ctrl->dummy_eb;
+	struct scrub_fs_sector *sector =
+		scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+	const u64 logical = sector->eb_logical;
+	const u64 expected_gen = sector->eb_generation;
+	unsigned int set_flag;
+	int ret;
+	int i;
+
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, mirror_nr);
+	ASSERT(eb);
+
+	eb->start = logical;
+
+	/* Copy all the metadata sectors into the dummy eb. */
+	for (i = 0; i < fs_info->nodesize >> fs_info->sectorsize_bits; i++) {
+		struct page *page = scrub_fs_get_page(sfctx, sector_nr + i,
+						      mirror_nr);
+		int page_off = scrub_fs_get_page_offset(sfctx, sector_nr + i,
+							mirror_nr);
+		int off_in_eb = i << fs_info->sectorsize_bits;
+
+		write_extent_buffer(eb, page_address(page) + page_off,
+				    off_in_eb, fs_info->sectorsize);
+	}
+	/* Basic extent buffer checks. */
+	ret = btrfs_validate_eb_basic(eb, false);
+	if (ret < 0) {
+		set_flag = SCRUB_FS_SECTOR_FLAG_INVALID;
+		goto out;
+	}
+	/* Csum checks. */
+	ret = btrfs_validate_eb_csum(eb, false);
+	if (ret < 0) {
+		set_flag = SCRUB_FS_SECTOR_FLAG_BAD_CSUM;
+		goto out;
+	}
+
+	/* Full tree-check checks. */
+	if (btrfs_header_level(eb) > 0)
+		ret = btrfs_check_node(eb);
+	else
+		ret = btrfs_check_leaf_full(eb);
+	if (ret < 0) {
+		set_flag = SCRUB_FS_SECTOR_FLAG_INVALID;
+		goto out;
+	}
+
+	/* Transid check */
+	if (btrfs_header_generation(eb) != expected_gen) {
+		set_flag = SCRUB_FS_SECTOR_FLAG_TRANSID_MISMATCH;
+		goto out;
+	}
+
+	/* All check passed. */
+	set_flag = SCRUB_FS_SECTOR_FLAG_GOOD;
+out:
+	for (i = 0; i < fs_info->nodesize >> fs_info->sectorsize_bits; i++) {
+		struct scrub_fs_sector *sector = scrub_fs_get_sector(sfctx,
+				sector_nr + i, mirror_nr);
+
+		sector->flags |= set_flag;
+	}
+}
+
 static void scrub_fs_read_endio(struct bio *bio)
 {
 	struct scrub_fs_endio_ctrl *endio_ctrl = bio->bi_private;
 	struct scrub_fs_ctx *sfctx = endio_ctrl->sfctx;
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 	int bio_size = 0;
@@ -5034,6 +5136,7 @@ static void scrub_fs_read_endio(struct bio *bio)
 	/* We always submit a bio for a stripe length. */
 	ASSERT(bio_size == BTRFS_STRIPE_LEN);
 
+	/* First loop to update IO_DONE flags. */
 	for (i = 0; i < sfctx->sectors_per_stripe; i++) {
 		struct scrub_fs_sector *sector =
 			scrub_fs_get_sector(sfctx, i, mirror_nr);
@@ -5048,6 +5151,30 @@ static void scrub_fs_read_endio(struct bio *bio)
 		}
 		sector->flags |= SCRUB_FS_SECTOR_FLAG_IO_DONE;
 	}
+	if (error)
+		goto out;
+
+	/* Second loop to do the verification. */
+	for (i = 0; i < sfctx->sectors_per_stripe; i++) {
+		struct scrub_fs_sector *sector =
+			scrub_fs_get_sector(sfctx, i, mirror_nr);
+
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_UNUSED ||
+		    !(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
+			continue;
+
+		/* Place holder for data verification. */
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_DATA)
+			continue;
+
+		/* We must be at a metadata sector. */
+		ASSERT(sector->flags & SCRUB_FS_SECTOR_FLAG_META);
+		scrub_fs_verify_meta(endio_ctrl, i, mirror_nr);
+		/* Skip to the end of the tree block. */
+		i += (fs_info->nodesize >> fs_info->sectorsize_bits) - 1;
+	}
+
+out:
 	atomic_dec(&sfctx->bios_under_io);
 	wake_up(&sfctx->wait);
 	bio_put(bio);
-- 
2.37.3

