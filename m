Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F65ABDC6
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiICIUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiICIT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:19:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7E8326E0
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:19:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 667DC1F95E
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KE4VyGDpwHE7RS1MONo5fXTxy8zomZTyTV/igIWTp80=;
        b=UYAHWzQ4HvmhZCBOB2xPGaMExAOjYlmOMPwWdwSIBwCx8fyquNIL1lkrQRJ+cKHjr14gTq
        Ejfvt67j6OG/DCfOp3KNsrUo+hYXOMGtOLw/Q03GsytdsaonmZP0kSmCnlThPBqe5KBs60
        RjpielIQxyWWS3eU9M9LVypUwdVFEaA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B57F4139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Og9HyoOE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:19:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 4/9] btrfs: scrub: introduce place holder helper scrub_fs_block_group()
Date:   Sat,  3 Sep 2022 16:19:24 +0800
Message-Id: <ccd8ba4f67e3631ee9d6b707c1fc1de1558ecba8.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com>
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

The main place holder helper scrub_fs_block_group() will:

- Initialize various needed members inside scrub_fs_ctx
  This includes:
  * Calculate the nr_copies for non-RAID56 profiles, or grab nr_stripes
    for RAID56 profiles.
  * Allocate memory for sectors/pages array, and csum_buf if it's data
    bg.
  * Initialize all sectors to type UNUSED.

  All these above memory will stay for each stripe we run, thus we only
  need to allocate these memories once-per-bg.

- Iterate stripes containing any used sector
  This is the code to be implemented.

- Cleanup above memories before we finish the block group.

The real work of scrubbing a stripe is not yet implemented.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 233 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index cf4dc384427e..46885f966bb3 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -198,6 +198,45 @@ struct scrub_ctx {
 	refcount_t              refs;
 };
 
+#define SCRUB_FS_SECTOR_FLAG_UNUSED		(1 << 0)
+#define SCRUB_FS_SECTOR_FLAG_DATA		(1 << 1)
+#define SCRUB_FS_SECTOR_FLAG_META		(1 << 2)
+#define SCRUB_FS_SECTOR_FLAG_PARITY		(1 << 3)
+
+/*
+ * Represent a sector.
+ *
+ * To access the content of a sector, the caller should have the index inside
+ * the scrub_fs_ctx->sectors[] array, and use that index to calculate the page
+ * and page offset innside scrub_fs_ctx->pages[] array.
+ *
+ * To get the logical/physical bytenr of the a sector, the caller should use
+ * scrub_fs_ctx->bioc and the sector index to calclulate the logical/physical
+ * bytenr.
+ */
+struct scrub_fs_sector {
+	unsigned int flags;
+	union {
+		/*
+		 * For SCRUB_FS_SECTOR_TYPE_DATA, either it points to some byte
+		 * inside scrub_fs_ctx->csum_buf, or it's NULL for NODATACSUM
+		 * case.
+		 */
+		u8 *csum;
+
+		/*
+		 * For SECRUB_FS_SECTOR_TYPE_META, this records the generation
+		 * and the logical bytenr of the tree block.
+		 * (So we can grab the first sector to calculate their inline
+		 * csum).
+		 */
+		struct {
+			u64 eb_logical;
+			u64 eb_generation;
+		};
+	};
+};
+
 /* This structure should only has a lifespan inside btrfs_scrub_fs(). */
 struct scrub_fs_ctx {
 	struct btrfs_fs_info		*fs_info;
@@ -208,12 +247,64 @@ struct scrub_fs_ctx {
 	/* Current logical bytenr being scrubbed. */
 	u64				cur_logical;
 
+
 	atomic_t			sectors_under_io;
 
 	bool				readonly;
 
 	/* There will and only be one thread touching @stat. */
 	struct btrfs_scrub_fs_progress	stat;
+
+	/*
+	 * How many sectors we read per stripe.
+	 *
+	 * For now, it's fixed to BTRFS_STRIPE_LEN / sectorsize.
+	 *
+	 * This can be enlarged to full stripe size / sectorsize
+	 * for later RAID0/10/5/6 code.
+	 */
+	int				sectors_per_stripe;
+	/*
+	 * For non-RAID56 profiles, we only care how many copies the block
+	 * group has.
+	 * For RAID56 profiles, we care how many stripes the block group
+	 * has (including data and parities).
+	 */
+	union {
+		int			nr_stripes;
+		int			nr_copies;
+	};
+
+	/*
+	 * The total number of sectors we scrub in one run (including
+	 * the extra mirrors/parities).
+	 *
+	 * For non-RAID56 profiles, it would be:
+	 *   nr_copie * (BTRFS_STRIPE_LEN / sectorsize).
+	 *
+	 * For RAID56 profiles, it would be:
+	 *   nr_stripes * (BTRFS_STRIPE_LEN / sectorsize).
+	 */
+	int				total_sectors;
+
+	/* Page array for above total_sectors. */
+	struct page			**pages;
+
+	/*
+	 * Sector array for above total_sectors. The page content will be
+	 * inside above pages array.
+	 *
+	 * Both array should be initialized when start to scrub a block group.
+	 */
+	struct scrub_fs_sector		*sectors;
+
+	/*
+	 * Csum buffer allocated for the stripe.
+	 *
+	 * All sectors in different mirrors for the same logical bytenr
+	 * would point to the same location inside the buffer.
+	 */
+	u8				*csum_buf;
 };
 
 struct scrub_warning {
@@ -4464,6 +4555,147 @@ static struct scrub_fs_ctx *scrub_fs_alloc_ctx(struct btrfs_fs_info *fs_info,
 	return ERR_PTR(ret);
 }
 
+/*
+ * Cleanup the memory allocation, mostly after finishing a bg, or for error
+ * path.
+ */
+static void scrub_fs_cleanup_for_bg(struct scrub_fs_ctx *sfctx)
+{
+	int i;
+	const int nr_pages = sfctx->nr_copies * (BTRFS_STRIPE_LEN >> PAGE_SHIFT);
+
+	if (sfctx->pages) {
+		for (i = 0; i < nr_pages; i++) {
+			if (sfctx->pages[i]) {
+				__free_page(sfctx->pages[i]);
+				sfctx->pages[i] = NULL;
+			}
+		}
+	}
+	kfree(sfctx->pages);
+	sfctx->pages = NULL;
+
+	kfree(sfctx->sectors);
+	sfctx->sectors = NULL;
+
+	kfree(sfctx->csum_buf);
+	sfctx->csum_buf = NULL;
+
+	/* NOTE: block group will only be put inside scrub_fs_iterate_bgs(). */
+	sfctx->cur_bg = NULL;
+}
+
+/* Do the block group specific initialization. */
+static int scrub_fs_init_for_bg(struct scrub_fs_ctx *sfctx,
+				struct btrfs_block_group *bg)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	bool is_raid56 = !!(bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK);
+	int ret = 0;
+	int nr_pages;
+	int i;
+
+	/*
+	 * One stripe should be page aligned, aka, PAGE_SIZE should not be
+	 * larger than 64K.
+	 */
+	ASSERT(IS_ALIGNED(BTRFS_STRIPE_LEN, PAGE_SIZE));
+
+	/* Last run should have cleanedup all the memories. */
+	ASSERT(!sfctx->cur_bg);
+	ASSERT(!sfctx->pages);
+	ASSERT(!sfctx->sectors);
+	ASSERT(!sfctx->csum_buf);
+
+	read_lock(&map_tree->lock);
+	em = lookup_extent_mapping(map_tree, bg->start, bg->length);
+	read_unlock(&map_tree->lock);
+
+	/*
+	 * Might have been an unused block group deleted by the cleaner
+	 * kthread or relocation.
+	 */
+	if (!em) {
+		spin_lock(&bg->lock);
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags))
+			ret = -EINVAL;
+		spin_unlock(&bg->lock);
+		return ret;
+	}
+	/*
+	 * Since we're ensured to be executed without any other
+	 * dev-replace/scrub running, the num_stripes should be the total
+	 * number of stripes, without the replace target device.
+	 */
+	if (is_raid56)
+		sfctx->nr_stripes = em->map_lookup->num_stripes;
+	free_extent_map(em);
+
+	if (!is_raid56)
+		sfctx->nr_copies = btrfs_num_copies(fs_info, bg->start,
+						    fs_info->sectorsize);
+	sfctx->sectors_per_stripe = BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits;
+	sfctx->total_sectors = sfctx->sectors_per_stripe * sfctx->nr_copies;
+
+	nr_pages = (BTRFS_STRIPE_LEN >> PAGE_SHIFT) * sfctx->nr_copies;
+
+	sfctx->pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!sfctx->pages)
+		goto enomem;
+
+	for (i = 0; i < nr_pages; i++) {
+		sfctx->pages[i] = alloc_page(GFP_KERNEL);
+		if (!sfctx->pages[i])
+			goto enomem;
+	}
+
+	sfctx->sectors = kcalloc(sfctx->total_sectors,
+				 sizeof(struct scrub_fs_sector), GFP_KERNEL);
+	if (!sfctx->sectors)
+		goto enomem;
+
+	for (i = 0; i < sfctx->total_sectors; i++)
+		sfctx->sectors[i].flags = SCRUB_FS_SECTOR_FLAG_UNUSED;
+
+	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
+		sfctx->csum_buf = kzalloc(fs_info->csum_size *
+					  sfctx->sectors_per_stripe, GFP_KERNEL);
+		if (!sfctx->csum_buf)
+			goto enomem;
+	}
+	sfctx->cur_bg = bg;
+	sfctx->cur_logical = bg->start;
+	return 0;
+
+enomem:
+	sfctx->stat.nr_fatal_errors++;
+	scrub_fs_cleanup_for_bg(sfctx);
+	return -ENOMEM;
+}
+
+
+static int scrub_fs_block_group(struct scrub_fs_ctx *sfctx,
+				struct btrfs_block_group *bg)
+{
+	int ret;
+
+	/* Not yet supported, just skip RAID56 bgs for now. */
+	if (bg->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return 0;
+
+	ret = scrub_fs_init_for_bg(sfctx, bg);
+	if (ret < 0)
+		return ret;
+
+	/* Place holder for the loop itearting the sectors. */
+	ret = 0;
+
+	scrub_fs_cleanup_for_bg(sfctx);
+	return ret;
+}
+
 static int scrub_fs_iterate_bgs(struct scrub_fs_ctx *sfctx, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = sfctx->fs_info;
@@ -4527,8 +4759,7 @@ static int scrub_fs_iterate_bgs(struct scrub_fs_ctx *sfctx, u64 start, u64 end)
 
 		scrub_pause_off(fs_info);
 
-		/* Place holder for the real chunk scrubbing code. */
-		ret = 0;
+		ret = scrub_fs_block_group(sfctx, bg);
 
 		if (ro_set)
 			btrfs_dec_block_group_ro(bg);
-- 
2.37.3

