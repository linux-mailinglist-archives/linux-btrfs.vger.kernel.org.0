Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42B57F913
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiGYFij (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiGYFig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E7DE85
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B8AC34981
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qab6Zr+2BklCp7ESame87V2UpftY1218JcwrYT4M1+g=;
        b=UXUpp0ppU1jdx7Q73XBo9bqv4GbIGO1zxVRL046qVrSxb1kEqYakb/gHXXcjIuiXEWQr9N
        nx28gWQtXqnA++hcAkQ5PjiJfU4EvcjTLpdEnRhIAR2blfFCQlhGz57HwSQfYSReUUI9qh
        PduLCkj4a04VyLzaCASTCYGtMGcGLVo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93ACC13A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kJMJGVgs3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/14] btrfs: scrub the full stripe which had sub-stripe write at mount time
Date:   Mon, 25 Jul 2022 13:38:02 +0800
Message-Id: <f46945e41b572e3642d2398a2f873503563e7aed.1658726692.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
References: <cover.1658726692.git.wqu@suse.com>
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

Since we have write-intent bitmaps, we know exactly which full stripes
were dirty before last unclean shutdown.

As long as there is no missing device, we can just scrub all the data
stripes, then scrub the P/Q stripes.

This patch will implement the code for mount time recovery, by:

- Grab the full stripe
- Scrub the data stripes first
- Scrub the P/Q stripes
  This is not the optimal way to check, as previous scrub on data
  stripes has ensured all the data are correct, we can just
  re-generate the P/Q.

  But unfortunately we don't have a good way to re-use the sectors from
  previous scrub.
  So here we still go scrub_raid56_parity(), which would re-check the
  data stripes.

And since btrfs_write_intent_recover() needs block groups to be
initialized, and has to be called before balance, this patch also moves
the timing of btrfs_write_intent_recover() and btrfs_recover_balance()
after btrfs_read_block_groups().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h        |   2 +
 fs/btrfs/disk-io.c      |  24 +++---
 fs/btrfs/scrub.c        | 177 +++++++++++++++++++++++++++++++++++++---
 fs/btrfs/write-intent.c |  30 +++++--
 4 files changed, 206 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ade76ba98c68..7b22dd04fd4f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -4003,6 +4003,8 @@ int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
+int btrfs_scrub_raid56_full_stripe(struct btrfs_fs_info *fs_info, u64 logical,
+				   u32 *full_stripe_ret);
 static inline void btrfs_init_full_stripe_locks_tree(
 			struct btrfs_full_stripe_locks_tree *locks_root)
 {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d29fad12d459..b1f8c17906ea 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3730,18 +3730,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_block_groups;
 	}
 
-	ret = btrfs_write_intent_recover(fs_info);
-	if (ret < 0) {
-		btrfs_err(fs_info, "failed to recover write-intent bitmap: %d",
-			  ret);
-		goto fail_block_groups;
-	}
-	ret = btrfs_recover_balance(fs_info);
-	if (ret) {
-		btrfs_err(fs_info, "failed to recover balance: %d", ret);
-		goto fail_block_groups;
-	}
-
 	ret = btrfs_init_dev_stats(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to init dev_stats: %d", ret);
@@ -3786,6 +3774,18 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
+	ret = btrfs_write_intent_recover(fs_info);
+	if (ret < 0) {
+		btrfs_err(fs_info, "failed to recover write-intent bitmap: %d",
+			  ret);
+		goto fail_sysfs;
+	}
+	ret = btrfs_recover_balance(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to recover balance: %d", ret);
+		goto fail_sysfs;
+	}
+
 	btrfs_free_zone_cache(fs_info);
 
 	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3afe5fa50a63..4f6478072549 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4093,19 +4093,10 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
-		    u64 end, struct btrfs_scrub_progress *progress,
-		    int readonly, int is_dev_replace)
+static int check_scrub_requreiment(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_dev_lookup_args args = { .devid = devid };
-	struct scrub_ctx *sctx;
-	int ret;
-	struct btrfs_device *dev;
-	unsigned int nofs_flag;
-
 	if (btrfs_fs_closing(fs_info))
 		return -EAGAIN;
-
 	if (fs_info->nodesize > BTRFS_STRIPE_LEN) {
 		/*
 		 * in this case scrub is unable to calculate the checksum
@@ -4132,6 +4123,22 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		       fs_info->sectorsize, SCRUB_MAX_SECTORS_PER_BLOCK);
 		return -EINVAL;
 	}
+	return 0;
+}
+
+int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
+		    u64 end, struct btrfs_scrub_progress *progress,
+		    int readonly, int is_dev_replace)
+{
+	struct btrfs_dev_lookup_args args = { .devid = devid };
+	struct scrub_ctx *sctx;
+	int ret;
+	struct btrfs_device *dev;
+	unsigned int nofs_flag;
+
+	ret = check_scrub_requreiment(fs_info);
+	if (ret < 0)
+		return ret;
 
 	/* Allocate outside of device_list_mutex */
 	sctx = scrub_setup_ctx(fs_info, is_dev_replace);
@@ -4355,3 +4362,153 @@ static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
 	*extent_dev = bioc->stripes[0].dev;
 	btrfs_put_bioc(bioc);
 }
+
+/*
+ * This is for mount time write-intent recovery, to repair the full stripe
+ * which
+ */
+int btrfs_scrub_raid56_full_stripe(struct btrfs_fs_info *fs_info, u64 logical,
+				   u32 *full_stripe_ret)
+{
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
+	struct scrub_ctx *sctx;
+	struct btrfs_block_group *bg;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 map_length = BTRFS_STRIPE_LEN;
+	int nr_data;
+	int ret;
+	int i;
+
+	/*
+	 * Use STRIPE_LEN as default return length. Will be updated after we
+	 * got a bioc.
+	 */
+	*full_stripe_ret = BTRFS_STRIPE_LEN;
+
+	ret = check_scrub_requreiment(fs_info);
+	if (ret < 0)
+		return ret;
+
+	bg = btrfs_lookup_block_group(fs_info, logical);
+	if (!bg) {
+		btrfs_err(fs_info, "can not find block group for logical %llu",
+			  logical);
+		return -ENOENT;
+	}
+
+	read_lock(&fs_info->mapping_tree.lock);
+	em = lookup_extent_mapping(&fs_info->mapping_tree, logical,
+				   fs_info->sectorsize);
+	read_unlock(&fs_info->mapping_tree.lock);
+	if (!em) {
+		btrfs_err(fs_info, "can not find chunk for logical %llu",
+			  logical);
+		ret = -ENOENT;
+		goto out_put_bg;
+	}
+
+	map = em->map_lookup;
+	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
+		btrfs_warn(fs_info, "logical %llu is not inside a RAID56 chunk",
+			   logical);
+		ret = -EINVAL;
+		goto out_free_em;
+	}
+	/* We need to make sure the logical bytenr is aligned to STRIPE_LEN. */
+	if (!IS_ALIGNED(logical - em->start, BTRFS_STRIPE_LEN)) {
+		btrfs_err(fs_info, "logical %llu is not stripe aligned", logical);
+		ret = -EINVAL;
+		goto out_free_em;
+	}
+
+	/* Also logical should be at a full stripe start. */
+	if (div_u64(logical - em->start, BTRFS_STRIPE_LEN) % map->num_stripes) {
+		btrfs_err(fs_info, "logical %llu is not the start of a full stripe",
+			  logical);
+		ret = -EINVAL;
+		goto out_free_em;
+	}
+
+	sctx = scrub_setup_ctx(fs_info, false);
+	if (IS_ERR(sctx)) {
+		ret = PTR_ERR(sctx);
+		goto out_free_em;
+	}
+
+	ret = scrub_workers_get(fs_info, false);
+	if (ret)
+		goto out_free_ctx;
+
+	/* Grab the full stripe mapping. */
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			       &map_length, &bioc);
+	if (ret < 0)
+		goto out_free_ctx;
+
+	if (!(bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
+		btrfs_warn(fs_info, "logical %llu is not inside a RAID56 chunk",
+			   logical);
+		ret = -EOPNOTSUPP;
+		goto out_put_bioc;
+	}
+
+	nr_data = bioc->num_stripes - bioc->num_tgtdevs -
+		  btrfs_nr_parity_stripes(bioc->map_type);
+	*full_stripe_ret = nr_data * BTRFS_STRIPE_LEN;
+
+	/* Scrub the data stripes first. */
+	for (i = 0; i < nr_data; i++, logical += BTRFS_STRIPE_LEN) {
+		struct btrfs_device *dev = bioc->stripes[i].dev;
+
+		ret = scrub_simple_mirror(sctx, extent_root, csum_root, bg,
+					  map, logical, BTRFS_STRIPE_LEN, dev,
+					  bioc->stripes[i].physical, 1);
+		scrub_submit(sctx);
+		mutex_lock(&sctx->wr_lock);
+		scrub_wr_submit(sctx);
+		mutex_unlock(&sctx->wr_lock);
+		if (ret < 0)
+			goto out_put_bioc;
+	}
+
+	/* Then scrub the P/Q stripes. */
+	ret = scrub_raid56_parity(sctx, map, bioc->stripes[i].dev,
+				  bioc->raid_map[0],
+				  bioc->raid_map[0] + nr_data * BTRFS_STRIPE_LEN);
+	scrub_submit(sctx);
+	mutex_lock(&sctx->wr_lock);
+	scrub_wr_submit(sctx);
+	mutex_unlock(&sctx->wr_lock);
+	if (ret < 0)
+		goto out_put_bioc;
+	i++;
+
+	if (map->type & BTRFS_BLOCK_GROUP_RAID6) {
+		ret = scrub_raid56_parity(sctx, map, bioc->stripes[i].dev,
+					  bioc->raid_map[0],
+					  bioc->raid_map[0] + nr_data * BTRFS_STRIPE_LEN);
+		scrub_submit(sctx);
+		mutex_lock(&sctx->wr_lock);
+		scrub_wr_submit(sctx);
+		mutex_unlock(&sctx->wr_lock);
+		if (ret < 0)
+			goto out_put_bioc;
+	}
+	if (!ret)
+		btrfs_info(fs_info, "scrubbed full stripe at logical %llu",
+			   logical);
+
+out_put_bioc:
+	btrfs_put_bioc(bioc);
+out_free_ctx:
+	scrub_free_ctx(sctx);
+out_free_em:
+	free_extent_map(em);
+out_put_bg:
+	btrfs_put_block_group(bg);
+
+	return ret;
+}
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index 82228713e621..f8912de016c9 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -704,6 +704,29 @@ void btrfs_write_intent_clear_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
+static void check_one_entry(struct btrfs_fs_info *fs_info,
+			   struct write_intent_entry *entry)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	unsigned long bitmaps[WRITE_INTENT_BITS_PER_ENTRY / BITS_PER_LONG];
+	int bit;
+
+	wie_get_bitmap(entry, bitmaps);
+
+	for_each_set_bit(bit, bitmaps, WRITE_INTENT_BITS_PER_ENTRY) {
+		u64 bytenr = wi_entry_bytenr(entry) + bit * ctrl->blocksize;
+		u32 full_stripe_len;
+		int ret;
+
+		ret = btrfs_scrub_raid56_full_stripe(fs_info, bytenr,
+						     &full_stripe_len);
+		if (ret < 0)
+			btrfs_err(fs_info,
+			"failed to scrub full stripe at logical %llu", bytenr);
+		bit += full_stripe_len / BTRFS_STRIPE_LEN;
+	}
+}
+
 int btrfs_write_intent_recover(struct btrfs_fs_info *fs_info)
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
@@ -724,12 +747,9 @@ int btrfs_write_intent_recover(struct btrfs_fs_info *fs_info)
 			struct write_intent_entry *entry =
 				write_intent_entry_nr(ctrl, i);
 
-			btrfs_warn(fs_info,
-				"  entry=%u bytenr=%llu bitmap=0x%016llx\n", i,
-				   wi_entry_bytenr(entry),
-				   wi_entry_raw_bitmap(entry));
+			check_one_entry(fs_info, entry);
 		}
-		/* For now, we just clear the whole bitmap. */
+		/* All checked, clear the whole bitmap. */
 		memzero_page(ctrl->page, sizeof(struct write_intent_super),
 			     WRITE_INTENT_BITMAPS_SIZE -
 			     sizeof(struct write_intent_super));
-- 
2.37.0

