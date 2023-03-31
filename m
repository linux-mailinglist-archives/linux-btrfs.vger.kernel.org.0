Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918556D14E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Mar 2023 03:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCaBUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCaBUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 21:20:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9584CDFD
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 18:20:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 895521FE35;
        Fri, 31 Mar 2023 01:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680225636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hrk36/oz57F8SHz/NUGlyf3+iTatsSN7XtUduPNctCQ=;
        b=Y83dDMrE9xxOyxw3dMyDfk/uZas5OWF9fbT2qdN6oDwWXd5v1SHibc933ym4Sy5oreVmEf
        uKHL2kOM8cV2Crw9PP/f1mTze2KmH52eQFnqjoq0FH+8ZAiai8BFN2uuz1jbV+3Hiddv3E
        O4OV688E6vfFEHv+kwO/wPcOfNGB+QI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC8D213451;
        Fri, 31 Mar 2023 01:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gD+WImM1JmSKWAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 31 Mar 2023 01:20:35 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v8 03/12] btrfs: introduce a new helper to submit write bio for repair
Date:   Fri, 31 Mar 2023 09:20:06 +0800
Message-Id: <819f09deb98ecda08057cb74b33e1083bf4568a8.1680225140.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680225140.git.wqu@suse.com>
References: <cover.1680225140.git.wqu@suse.com>
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

Both scrub and read-repair is utilizing a special repair writes that:

- Only writes back to a single device
  Even for read-repair on RAID56, we only update the corrupted data
  stripe itself, not triggering the full RMW path.

- Requires a valid @mirror_num
  For RAID56 case, only @mirror_num == 1 is valid.
  For non-RAID56 cases, we need @mirror_num to locate our stripe.

- No data csum generation needed

Those two call sites still have some difference though:

- Read-repair goes plain bio
  It doesn't need a full btrfs_bio, and goes submit_bio_wait().

- New scrub repair would go btrfs_bio
  To simplify both read and write path.

So here this patch would:

- Introduce a common helper, btrfs_map_repair_block()
  Due to the single device nature, we can use an on-stack
  btrfs_io_stripe to pass device and its physical bytenr.

- Introduce a new interface, btrfs_submit_repair_bio(), for later scrub
  code
  This is for the incoming scrub code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c     | 96 +++++++++++++++++++++++++---------------------
 fs/btrfs/bio.h     |  2 +
 fs/btrfs/raid56.h  |  5 +++
 fs/btrfs/volumes.c | 73 +++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  3 ++
 5 files changed, 135 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index fb87f1c35e22..430acf7142ef 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -717,12 +717,9 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num)
 {
-	struct btrfs_device *dev;
+	struct btrfs_io_stripe smap = { 0 };
 	struct bio_vec bvec;
 	struct bio bio;
-	u64 map_length = 0;
-	u64 sector;
-	struct btrfs_io_context *bioc = NULL;
 	int ret = 0;
 
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
@@ -731,68 +728,38 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
-	map_length = length;
-
 	/*
 	 * Avoid races with device replace and make sure our bioc has devices
 	 * associated to its stripes that don't go away while we are doing the
 	 * read repair operation.
 	 */
 	btrfs_bio_counter_inc_blocked(fs_info);
-	if (btrfs_is_parity_mirror(fs_info, logical, length)) {
-		/*
-		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
-		 * to update all raid stripes, but here we just want to correct
-		 * bad stripe, thus BTRFS_MAP_READ is abused to only get the bad
-		 * stripe's dev and sector.
-		 */
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-				      &map_length, &bioc, 0);
-		if (ret)
-			goto out_counter_dec;
-		ASSERT(bioc->mirror_num == 1);
-	} else {
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
-				      &map_length, &bioc, mirror_num);
-		if (ret)
-			goto out_counter_dec;
-		/*
-		 * This happens when dev-replace is also running, and the
-		 * mirror_num indicates the dev-replace target.
-		 *
-		 * In this case, we don't need to do anything, as the read
-		 * error just means the replace progress hasn't reached our
-		 * read range, and later replace routine would handle it well.
-		 */
-		if (mirror_num != bioc->mirror_num)
-			goto out_counter_dec;
-	}
+	ret = btrfs_map_repair_block(fs_info, &smap, logical, length, mirror_num);
+	if (ret < 0)
+		goto out_counter_dec;
 
-	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-	dev = bioc->stripes[bioc->mirror_num - 1].dev;
-	btrfs_put_bioc(bioc);
-
-	if (!dev || !dev->bdev ||
-	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
+	if (!smap.dev->bdev ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &smap.dev->dev_state)) {
 		ret = -EIO;
 		goto out_counter_dec;
 	}
 
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = sector;
+	bio_init(&bio, smap.dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
+	bio.bi_iter.bi_sector = smap.physical >> SECTOR_SHIFT;
 	__bio_add_page(&bio, page, length, pg_offset);
 
 	btrfsic_check_bio(&bio);
 	ret = submit_bio_wait(&bio);
 	if (ret) {
 		/* try to remap that extent elsewhere? */
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+		btrfs_dev_stat_inc_and_print(smap.dev, BTRFS_DEV_STAT_WRITE_ERRS);
 		goto out_bio_uninit;
 	}
 
 	btrfs_info_rl_in_rcu(fs_info,
 		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-			     ino, start, btrfs_dev_name(dev), sector);
+			     ino, start, btrfs_dev_name(smap.dev),
+			     smap.physical >> SECTOR_SHIFT);
 	ret = 0;
 
 out_bio_uninit:
@@ -802,6 +769,47 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	return ret;
 }
 
+/*
+ * Submit a btrfs_bio based repair write.
+ *
+ * If @dev_replace is true, the write would be submitted to dev-replace target.
+ */
+void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num,
+			       bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	u64 logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 length = bbio->bio.bi_iter.bi_size;
+	struct btrfs_io_stripe smap = { 0 };
+	int ret;
+
+	ASSERT(fs_info);
+	ASSERT(mirror_num > 0);
+	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
+	ASSERT(!bbio->inode);
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = btrfs_map_repair_block(fs_info, &smap, logical, length, mirror_num);
+	if (ret < 0)
+		goto fail;
+
+	if (dev_replace) {
+		if (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE &&
+		    btrfs_is_zoned(fs_info)) {
+			bbio->bio.bi_opf &= ~REQ_OP_WRITE;
+			bbio->bio.bi_opf |= REQ_OP_ZONE_APPEND;
+		}
+		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
+		smap.dev = fs_info->dev_replace.tgtdev;
+	}
+	__btrfs_submit_bio(&bbio->bio, NULL, &smap, mirror_num);
+	return;
+
+fail:
+	btrfs_bio_counter_dec(fs_info);
+	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
+}
+
 int __init btrfs_bioset_init(void)
 {
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index e54eaee81f8f..b158c920cc58 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -95,6 +95,8 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 #define REQ_BTRFS_ONE_ORDERED			REQ_DRV
 
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num,
+			       bool dev_replace);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index df0e0abdeb1f..6583c225b1bd 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -170,6 +170,11 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 	return map->num_stripes - btrfs_nr_parity_stripes(map->type);
 }
 
+static inline int nr_bioc_data_stripes(const struct btrfs_io_context *bioc)
+{
+	return bioc->num_stripes - btrfs_nr_parity_stripes(bioc->map_type);
+}
+
 #define RAID5_P_STRIPE ((u64)-2)
 #define RAID6_Q_STRIPE ((u64)-1)
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 93bc45001e68..54bee59c1ce8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8004,3 +8004,76 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 
 	return true;
 }
+
+static void map_raid56_repair_block(struct btrfs_io_context *bioc,
+				    struct btrfs_io_stripe *smap,
+				    u64 logical)
+{
+	int data_stripes = nr_bioc_data_stripes(bioc);
+	int i;
+
+	for (i = 0; i < data_stripes; i++) {
+		u64 stripe_start = bioc->full_stripe_logical +
+				   (i << BTRFS_STRIPE_LEN_SHIFT);
+
+		if (logical >= stripe_start &&
+		    logical < stripe_start + BTRFS_STRIPE_LEN)
+			break;
+	}
+	ASSERT(i < data_stripes);
+	smap->dev = bioc->stripes[i].dev;
+	smap->physical = bioc->stripes[i].physical +
+			((logical - bioc->full_stripe_logical) &
+			 BTRFS_STRIPE_LEN_MASK);
+}
+
+/*
+ * Map a repair write into a single device.
+ *
+ * A repair write is triggered by read time repair or scrub, which would only
+ * update the contents of a single device.
+ * Not update any other mirrors nor go through RMW path.
+ *
+ * Callers should ensure:
+ * - Call btrfs_bio_counter_inc_blocked() first
+ * - The range does not cross stripe boundary
+ * - Has a valid @mirror_num passed in.
+ */
+int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
+			   struct btrfs_io_stripe *smap, u64 logical,
+			   u32 length, int mirror_num)
+{
+	struct btrfs_io_context *bioc = NULL;
+	u64 map_length = length;
+	int ret;
+	int mirror_ret = mirror_num;
+
+	ASSERT(mirror_num > 0);
+
+	ret = __btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical, &map_length,
+				&bioc, smap, &mirror_ret, true);
+	if (ret < 0)
+		return ret;
+
+	/* The map range should not cross stripe boundary. */
+	ASSERT(map_length >= length);
+
+	/* Already mapped to single stripe. */
+	if (!bioc)
+		goto out;
+
+	/* Map the RAID56 multi-stripe writes to a single one. */
+	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		map_raid56_repair_block(bioc, smap, logical);
+		goto out;
+	}
+
+	ASSERT(mirror_num <= bioc->num_stripes);
+	smap->dev = bioc->stripes[mirror_num - 1].dev;
+	smap->physical = bioc->stripes[mirror_num - 1].physical;
+out:
+	btrfs_put_bioc(bioc);
+	ASSERT(smap->dev);
+	return 0;
+}
+
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 650e131d079e..bf47a1a70813 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -587,6 +587,9 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		      struct btrfs_io_context **bioc_ret,
 		      struct btrfs_io_stripe *smap, int *mirror_num_ret,
 		      int need_raid_map);
+int btrfs_map_repair_block(struct btrfs_fs_info *fs_info,
+			   struct btrfs_io_stripe *smap, u64 logical,
+			   u32 length, int mirror_num);
 struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 					       u64 logical, u64 *length_ret,
 					       u32 *num_stripes);
-- 
2.39.2

