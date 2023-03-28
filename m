Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA26CB9D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjC1Ix0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjC1IxY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 04:53:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6CA5242
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 01:53:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4552219E7;
        Tue, 28 Mar 2023 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679993601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3hDhA1OAUBCPqkckwbhAHMXbwGmw1yfG7CYkhPEYt3k=;
        b=FAZZ3qpZfi4qUElZPVes7Nf/qsU4nsVb+mHJd5/vkNxbBuISs3JGh4kCGBifhwbvEt0g0W
        5DDSNRtZxN6t01JFAfkd/SGd3kRDgyoi65ufvohH3OKjTA73TGf7bV62HXukaqZnYoaN/D
        0/wdCxMO9evBuZqpWO2iPEM2AgfWsVg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D92921390B;
        Tue, 28 Mar 2023 08:53:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sORkKQCrImRBMwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Mar 2023 08:53:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v6 06/13] btrfs: scrub: introduce a helper to find and fill the sector info for a scrub_stripe
Date:   Tue, 28 Mar 2023 16:52:50 +0800
Message-Id: <a7106b1d1e41e77c6f7fbb9b9173f3f79b012b18.1679993368.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679993368.git.wqu@suse.com>
References: <cover.1679993368.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper will search the extent tree to find the first extent of a
logical range, then fill the sectors array by two loops:

- Loop 1 to fill common bits and metadata generation

- Loop 2 to fill csum data (only for data bgs)
  This loop will use the new btrfs_lookup_csums_bitmap() to fill
  the full csum buffer, and set scrub_sector_verification::csum.

With all the needed info fulfilled by this function, later we only need
to submit and verify the stripe.

Here we temporarily export the helper to avoid wanring on unused static
function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file-item.c |   9 ++-
 fs/btrfs/file-item.h |   3 +-
 fs/btrfs/raid56.c    |   2 +-
 fs/btrfs/scrub.c     | 148 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h     |   4 ++
 5 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1ce306cea690..018c711a0bc8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -597,7 +597,8 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
  * in is large enough to contain all csums.
  */
 int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
-			      u8 *csum_buf, unsigned long *csum_bitmap)
+			      u8 *csum_buf, unsigned long *csum_bitmap,
+			      bool search_commit)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
@@ -614,6 +615,12 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
 	if (!path)
 		return -ENOMEM;
 
+	if (search_commit) {
+		path->skip_locking = 1;
+		path->reada = READA_FORWARD;
+		path->search_commit_root = 1;
+	}
+
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	key.type = BTRFS_EXTENT_CSUM_KEY;
 	key.offset = start;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index cd7f2ae515c0..6be8725cd574 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -57,7 +57,8 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 			    struct list_head *list, int search_commit,
 			    bool nowait);
 int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
-			      u8 *csum_buf, unsigned long *csum_bitmap);
+			      u8 *csum_buf, unsigned long *csum_bitmap,
+			      bool search_commit);
 void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				     const struct btrfs_path *path,
 				     struct btrfs_file_extent_item *fi,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6cbbaa6c06ca..a64b40000d12 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2113,7 +2113,7 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 	}
 
 	ret = btrfs_lookup_csums_bitmap(csum_root, start, start + len - 1,
-					rbio->csum_buf, rbio->csum_bitmap);
+					rbio->csum_buf, rbio->csum_bitmap, false);
 	if (ret < 0)
 		goto error;
 	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->sectorsize_bits))
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 05ecd1e5c513..ed55a7363b8a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3642,6 +3642,154 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	return ret;
 }
 
+static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
+				 struct scrub_stripe *stripe,
+				 u64 extent_start, u64 extent_len,
+				 u64 extent_flags, u64 extent_gen)
+{
+	u64 cur_logical;
+
+	for (cur_logical = max(stripe->logical, extent_start);
+	     cur_logical < min(stripe->logical + BTRFS_STRIPE_LEN,
+			       extent_start + extent_len);
+	     cur_logical += fs_info->sectorsize) {
+		const int nr_sector = (cur_logical - stripe->logical) >>
+				      fs_info->sectorsize_bits;
+		struct scrub_sector_verification *sector =
+			&stripe->sectors[nr_sector];
+
+		set_bit(nr_sector, &stripe->extent_sector_bitmap);
+		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+			sector->is_metadata = true;
+			sector->generation = extent_gen;
+		}
+	}
+}
+
+static void scrub_stripe_reset_bitmaps(struct scrub_stripe *stripe)
+{
+	stripe->init_error_bitmap = 0;
+	stripe->error_bitmap = 0;
+	stripe->io_error_bitmap = 0;
+	stripe->csum_error_bitmap = 0;
+	stripe->meta_error_bitmap = 0;
+}
+
+/*
+ * Locate one stripe which has at least one extent in its range.
+ *
+ * Return 0 if found such stripe, and store its info into @stripe.
+ * Return >0 if there is no such stripe in the specified range.
+ * Return <0 for error.
+ */
+int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
+				 struct btrfs_device *dev, u64 physical,
+				 int mirror_num, u64 logical_start,
+				 u32 logical_len, struct scrub_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bg->start);
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bg->start);
+	const u64 logical_end = logical_start + logical_len;
+	struct btrfs_path path = { 0 };
+	u64 cur_logical = logical_start;
+	u64 stripe_end;
+	u64 extent_start;
+	u64 extent_len;
+	u64 extent_flags;
+	u64 extent_gen;
+	int ret;
+
+	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
+				   stripe->nr_sectors);
+	scrub_stripe_reset_bitmaps(stripe);
+
+	/* The range must be inside the bg */
+	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
+
+	path.search_commit_root = 1;
+	path.skip_locking = 1;
+
+	ret = find_first_extent_item(extent_root, &path, logical_start,
+				     logical_len);
+	/* Either error or not found. */
+	if (ret)
+		goto out;
+	get_extent_info(&path, &extent_start, &extent_len,
+			&extent_flags, &extent_gen);
+	cur_logical = max(extent_start, cur_logical);
+
+	/*
+	 * Round down to stripe boundary.
+	 *
+	 * The extra calculation against bg->start is to handle block groups
+	 * whose logical bytenr is not BTRFS_STRIPE_LEN aligned.
+	 */
+	stripe->logical = round_down(cur_logical - bg->start, BTRFS_STRIPE_LEN) +
+			  bg->start;
+	stripe->physical = physical + stripe->logical - logical_start;
+	stripe->dev = dev;
+	stripe->bg = bg;
+	stripe->mirror_num = mirror_num;
+	stripe_end = stripe->logical + BTRFS_STRIPE_LEN - 1;
+
+	/* Fill the first extent info into stripe->sectors[] array. */
+	fill_one_extent_info(fs_info, stripe, extent_start, extent_len,
+			     extent_flags, extent_gen);
+	cur_logical = extent_start + extent_len;
+
+	/* Fill the extent info for the remaining sectors. */
+	while (cur_logical <= stripe_end) {
+		ret = find_first_extent_item(extent_root, &path, cur_logical,
+					     stripe_end - cur_logical + 1);
+		if (ret < 0)
+			goto out;
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		get_extent_info(&path, &extent_start, &extent_len,
+				&extent_flags, &extent_gen);
+		fill_one_extent_info(fs_info, stripe, extent_start, extent_len,
+				     extent_flags, extent_gen);
+		cur_logical = extent_start + extent_len;
+	}
+
+	/* Now fill the data csum. */
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
+		int sector_nr;
+		unsigned long csum_bitmap = 0;
+
+		/* Csum space should have already been allocated. */
+		ASSERT(stripe->csums);
+
+		/*
+		 * Our csum bitmap should be large enough, as BTRFS_STRIPE_LEN
+		 * should contain at most 16 sectors.
+		 */
+		ASSERT(BITS_PER_LONG >=
+		       BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits);
+
+		ret = btrfs_lookup_csums_bitmap(csum_root, stripe->logical,
+						stripe_end, stripe->csums,
+						&csum_bitmap, true);
+		if (ret < 0)
+			goto out;
+		if (ret > 0)
+			ret = 0;
+
+		for_each_set_bit(sector_nr, &csum_bitmap, stripe->nr_sectors) {
+			stripe->sectors[sector_nr].csum = stripe->csums +
+				sector_nr * fs_info->csum_size;
+		}
+	}
+	set_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state);
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index e04764f8bb7e..27019d86b539 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -20,5 +20,9 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 struct scrub_stripe;
 int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe);
 void wait_scrub_stripe_io(struct scrub_stripe *stripe);
+int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
+				 struct btrfs_device *dev, u64 physical,
+				 int mirror_num, u64 logical_start,
+				 u32 logical_len, struct scrub_stripe *stripe);
 
 #endif
-- 
2.39.2

