Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593C7643E72
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbiLFIYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiLFIYA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:24:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD61B13E0C
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:23:59 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BCF71FE6D
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Tpu3fLHEDGKy4nbwhMA33gmqSGODVVVXdf+BsOfmdw=;
        b=HXjz6sR4KnGxPdSD1e49L5YtFZaA8eU2cFWFxrLU7zwIoDFuKZ5o4JCmWoQmaTztem8+rk
        NfFje2vjpolASMjc/8tGudQ+tI08TsQ9BzHskODtZ6iCF8xgqdG3yCYH8WvfpJ0WdccbdF
        mw0uCyam0JaH4lYJXOljzj11SFX+G7I=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DE142132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iMzuKh38jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:23:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 02/11] btrfs: scrub: introduce a helper to find and fill the sector info for a scrub2_stripe
Date:   Tue,  6 Dec 2022 16:23:29 +0800
Message-Id: <9060f52ffb145f99f0bcb22cff62be7fb8aca580.1670314744.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670314744.git.wqu@suse.com>
References: <cover.1670314744.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
  the full csum buffer, and set scrub2_sector::has_csum.

With all the needed info fulfilled by this function, later we only need
to submit and verify the stripe.

Here we temporarily export the helper to avoid wanring on unused static
function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c |   8 ++-
 fs/btrfs/file-item.h |   3 +-
 fs/btrfs/raid56.c    |   2 +-
 fs/btrfs/scrub.c     | 131 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h     |   7 +++
 5 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5de73466b2ca..67a0fc54c95e 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -671,7 +671,8 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
  * in is large enough to contain all csums.
  */
 int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
-			      u8 *csum_buf, unsigned long *csum_bitmap)
+			      u8 *csum_buf, unsigned long *csum_bitmap,
+			      bool search_commit)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
@@ -687,6 +688,11 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, u64 start, u64 end,
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
+	if (search_commit) {
+		path->skip_locking = 1;
+		path->reada = READA_FORWARD;
+		path->search_commit_root = 1;
+	}
 
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	key.type = BTRFS_EXTENT_CSUM_KEY;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 031225668434..64f4e5ca394a 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -55,7 +55,8 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
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
index 2d90a6b5eb00..cea448f4eda3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2171,7 +2171,7 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 	}
 
 	ret = btrfs_lookup_csums_bitmap(csum_root, start, start + len - 1,
-					rbio->csum_buf, rbio->csum_bitmap);
+					rbio->csum_buf, rbio->csum_bitmap, false);
 	if (ret < 0)
 		goto error;
 	if (bitmap_empty(rbio->csum_bitmap, len >> fs_info->sectorsize_bits))
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 286bdcb8b7ad..f4632fca5e67 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3526,6 +3526,137 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	return ret;
 }
 
+static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
+				 struct scrub2_stripe *stripe,
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
+		struct scrub2_sector *sector = &stripe->sectors[nr_sector];
+
+		set_bit(nr_sector, &stripe->used_sector_bitmap);
+		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
+			sector->is_metadata = true;
+			sector->generation = extent_gen;
+		}
+	}
+}
+
+/*
+ * Locate one stripe which has at least one extent in its range.
+ *
+ * Return 0 if found such stripe, and store its info into @stripe.
+ * Return >0 if there is no such stripe in the specified range.
+ * Return <0 for error.
+ */
+int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
+				  struct btrfs_root *csum_root,
+				  struct btrfs_block_group *bg,
+				  u64 logical_start, u64 logical_len,
+				  struct scrub2_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = extent_root->fs_info;
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
+	memset(stripe->sectors, 0, sizeof(struct scrub2_sector) * stripe->nr_sectors);
+	bitmap_zero(&stripe->init_error_bitmap, stripe->nr_sectors);
+	bitmap_zero(&stripe->current_error_bitmap, stripe->nr_sectors);
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
+out:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 /*
  * Scrub one range which can only has simple mirror based profile.
  * (Including all range in SINGLE/DUP/RAID1/RAID1C*, and each stripe in
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index d278c0f43007..0b2a89f7a2e0 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -17,6 +17,13 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
  * The following functions are temporary exports to avoid warning on unused
  * static functions.
  */
+struct scrub2_stripe;
 struct scrub2_stripe *alloc_scrub2_stripe(struct btrfs_fs_info *fs_info,
 					  struct btrfs_block_group *bg);
+int scrub2_find_fill_first_stripe(struct btrfs_root *extent_root,
+				  struct btrfs_root *csum_root,
+				  struct btrfs_block_group *bg,
+				  u64 logical_start, u64 logical_len,
+				  struct scrub2_stripe *stripe);
+
 #endif
-- 
2.38.1

