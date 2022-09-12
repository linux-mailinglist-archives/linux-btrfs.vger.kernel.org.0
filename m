Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FD55B5BF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiILOLn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 10:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiILOLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 10:11:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8A205C5
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3YuN9n/r3gptLyFrIEYwfBRDvBiK0/Kd2t4fzNJhyDU=; b=MEmLFUQ4kzPn9bOeMCAlWz7yT/
        7wBNgNA+X+GoW8RwTFOZAhAtH5a7oa5tmhshjQhFvSecZydVVEhjZswCT4c4uXZlt3PUhHsiHlZA7
        Can8puljHZZuZ9rdujruRqWbnayaO/N0mLjDR41TjINJSUC8gZRTDFaxY4eLyOBuNE3PIyu9Od3rW
        Hpw1eLHJn7X8q0CCnGgTGxJvHgzL1t5EZZY03hPK2tg1F9gc7vO/HMlpSD4k6A643f5O1ilSbRQij
        QY5WkgFwXvmTtzfjXa5OtnWJ2+8Qu6u39XaQNIj2yX/BxtByQVRGsSCsF+2l33MKAA97A5odezosL
        +sxSecvg==;
Received: from [2001:4bb8:198:a30e:bb46:613c:209e:f1ad] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oXk9w-00AWRz-Q2; Mon, 12 Sep 2022 14:11:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: move repair_io_failure to bio.c
Date:   Mon, 12 Sep 2022 16:11:21 +0200
Message-Id: <20220912141121.3744931-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912141121.3744931-1-hch@lst.de>
References: <20220912141121.3744931-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

repair_io_failure ties directly into all the glory low-level details of
mapping a bio with a logic address to the actual physical location.
Move it right below btrfs_submit_bio to keep all the related logic
together.

Also move btrfs_repair_eb_io_failure to its caller in disk-io.c now that
repair_io_failure is available in a header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c       |  91 +++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.c   |  24 +++++++++
 fs/btrfs/extent_io.c | 118 +------------------------------------------
 fs/btrfs/extent_io.h |   1 -
 4 files changed, 117 insertions(+), 117 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2bf17274caf75..440c022b29039 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -275,6 +275,97 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 	}
 }
 
+/*
+ * Submit a repair write.
+ *
+ * This bypasses btrfs_submit_bio deliberately, as that writes all copies in a
+ * RAID setup.  Here we only want to write the one bad copy, so we do the
+ * mapping ourselves and submit the bio directly.
+ *
+ * The I/O is issued sychronously to block the repair read completion from
+ * freeing the bio.
+ */
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num)
+{
+	struct btrfs_device *dev;
+	struct bio_vec bvec;
+	struct bio bio;
+	u64 map_length = 0;
+	u64 sector;
+	struct btrfs_io_context *bioc = NULL;
+	int ret = 0;
+
+	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
+	BUG_ON(!mirror_num);
+
+	if (btrfs_repair_one_zone(fs_info, logical))
+		return 0;
+
+	map_length = length;
+
+	/*
+	 * Avoid races with device replace and make sure our bioc has devices
+	 * associated to its stripes that don't go away while we are doing the
+	 * read repair operation.
+	 */
+	btrfs_bio_counter_inc_blocked(fs_info);
+	if (btrfs_is_parity_mirror(fs_info, logical, length)) {
+		/*
+		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
+		 * to update all raid stripes, but here we just want to correct
+		 * bad stripe, thus BTRFS_MAP_READ is abused to only get the bad
+		 * stripe's dev and sector.
+		 */
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
+				      &map_length, &bioc, 0);
+		if (ret)
+			goto out_counter_dec;
+		ASSERT(bioc->mirror_num == 1);
+	} else {
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
+				      &map_length, &bioc, mirror_num);
+		if (ret)
+			goto out_counter_dec;
+		BUG_ON(mirror_num != bioc->mirror_num);
+	}
+
+	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
+	dev = bioc->stripes[bioc->mirror_num - 1].dev;
+	btrfs_put_bioc(bioc);
+
+	if (!dev || !dev->bdev ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
+		ret = -EIO;
+		goto out_counter_dec;
+	}
+
+	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
+	bio.bi_iter.bi_sector = sector;
+	__bio_add_page(&bio, page, length, pg_offset);
+
+	btrfsic_check_bio(&bio);
+	ret = submit_bio_wait(&bio);
+	if (ret) {
+		/* try to remap that extent elsewhere? */
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+		goto out_bio_uninit;
+	}
+
+	btrfs_info_rl_in_rcu(fs_info,
+		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
+				  ino, start,
+				  rcu_str_deref(dev->name), sector);
+	ret = 0;
+
+out_bio_uninit:
+	bio_uninit(&bio);
+out_counter_dec:
+	btrfs_bio_counter_dec(fs_info);
+	return ret;
+}
+
 int __init btrfs_bioset_init(void)
 {
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e3419d2d32295..17b34213e7fe1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -249,6 +249,30 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 	return ret;
 }
 
+static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
+				      int mirror_num)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	u64 start = eb->start;
+	int i, num_pages = num_extent_pages(eb);
+	int ret = 0;
+
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	for (i = 0; i < num_pages; i++) {
+		struct page *p = eb->pages[i];
+
+		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
+				start, p, start - page_offset(p), mirror_num);
+		if (ret)
+			break;
+		start += PAGE_SIZE;
+	}
+
+	return ret;
+}
+
 /*
  * helper to read a given tree block, doing retries as required when
  * the checksums don't match and we have alternate mirrors to try.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a16442eadb02c..b6e4d07bbaf33 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2299,120 +2299,6 @@ int free_io_failure(struct extent_io_tree *failure_tree,
 	return err;
 }
 
-/*
- * this bypasses the standard btrfs submit functions deliberately, as
- * the standard behavior is to write all copies in a raid setup. here we only
- * want to write the one bad copy. so we do the mapping for ourselves and issue
- * submit_bio directly.
- * to avoid any synchronization issues, wait for the data after writing, which
- * actually prevents the read that triggered the error from finishing.
- * currently, there can be no more than two copies of every data bit. thus,
- * exactly one rewrite is required.
- */
-static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			     u64 length, u64 logical, struct page *page,
-			     unsigned int pg_offset, int mirror_num)
-{
-	struct btrfs_device *dev;
-	struct bio_vec bvec;
-	struct bio bio;
-	u64 map_length = 0;
-	u64 sector;
-	struct btrfs_io_context *bioc = NULL;
-	int ret = 0;
-
-	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
-	BUG_ON(!mirror_num);
-
-	if (btrfs_repair_one_zone(fs_info, logical))
-		return 0;
-
-	map_length = length;
-
-	/*
-	 * Avoid races with device replace and make sure our bioc has devices
-	 * associated to its stripes that don't go away while we are doing the
-	 * read repair operation.
-	 */
-	btrfs_bio_counter_inc_blocked(fs_info);
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
-		BUG_ON(mirror_num != bioc->mirror_num);
-	}
-
-	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-	dev = bioc->stripes[bioc->mirror_num - 1].dev;
-	btrfs_put_bioc(bioc);
-
-	if (!dev || !dev->bdev ||
-	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
-		ret = -EIO;
-		goto out_counter_dec;
-	}
-
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = sector;
-	__bio_add_page(&bio, page, length, pg_offset);
-
-	btrfsic_check_bio(&bio);
-	ret = submit_bio_wait(&bio);
-	if (ret) {
-		/* try to remap that extent elsewhere? */
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
-		goto out_bio_uninit;
-	}
-
-	btrfs_info_rl_in_rcu(fs_info,
-		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-				  ino, start,
-				  rcu_str_deref(dev->name), sector);
-	ret = 0;
-
-out_bio_uninit:
-	bio_uninit(&bio);
-out_counter_dec:
-	btrfs_bio_counter_dec(fs_info);
-	return ret;
-}
-
-int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	u64 start = eb->start;
-	int i, num_pages = num_extent_pages(eb);
-	int ret = 0;
-
-	if (sb_rdonly(fs_info->sb))
-		return -EROFS;
-
-	for (i = 0; i < num_pages; i++) {
-		struct page *p = eb->pages[i];
-
-		ret = repair_io_failure(fs_info, 0, start, PAGE_SIZE, start, p,
-					start - page_offset(p), mirror_num);
-		if (ret)
-			break;
-		start += PAGE_SIZE;
-	}
-
-	return ret;
-}
-
 static int next_mirror(const struct io_failure_record *failrec, int cur_mirror)
 {
 	if (cur_mirror == failrec->num_copies)
@@ -2470,7 +2356,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 	mirror = failrec->this_mirror;
 	do {
 		mirror = prev_mirror(failrec, mirror);
-		repair_io_failure(fs_info, ino, start, failrec->len,
+		btrfs_repair_io_failure(fs_info, ino, start, failrec->len,
 				  failrec->logical, page, pg_offset, mirror);
 	} while (mirror != failrec->failed_mirror);
 
@@ -2614,7 +2500,7 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 	 *
 	 * Since we're only doing repair for one sector, we only need to get
 	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for repair_io_failure to do the rest for us.
+	 * everything for btrfs_repair_io_failure to do the rest for us.
 	 */
 	failrec->this_mirror = next_mirror(failrec, failrec->this_mirror);
 	if (failrec->this_mirror == failrec->failed_mirror) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 69a86ae6fd508..e653e64598bf7 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -243,7 +243,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
-int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
 
 /*
  * When IO fails, either with EIO or csum verification fails, we
-- 
2.30.2

