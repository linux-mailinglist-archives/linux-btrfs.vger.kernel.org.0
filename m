Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FBF37B52C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 06:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhELEys (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 00:54:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41768 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhELEyr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 00:54:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620795219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQ9sG9/iUi8v0LFHAd9GMUbijpPdROS9v+T6hcIZxPU=;
        b=KU9TeLkP32nh76NHGGbaSYmq2Yo5QEe6LJt81X1d9kB5cJYZwitKHz4Pr1mMJE6Apa+415
        q/gzYwOSpOCCJMYpvywUF4F+n+ZLgycnxabWX8XyifnXCr2EJA/XH6WbaN3x/wmcHUdMZX
        Yy7zsDxPxpWtISmbapWOjBetJOhyHtM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B077AE8D
        for <linux-btrfs@vger.kernel.org>; Wed, 12 May 2021 04:53:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 3/3] btrfs: remove io_failure_record::in_validation
Date:   Wed, 12 May 2021 12:53:30 +0800
Message-Id: <20210512045330.40329-4-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512045330.40329-1-wqu@suse.com>
References: <20210512045330.40329-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The io_failure_record::in_validation was introduced to handle failed bio
which cross several sectors.
In such case, we still need to verify which sectors are corrupted.

But since we're changed the way how we handle corrupted sectors, by only
submitting repair for each corrupted sector, there is no need for extra
validation any more.

This patch will cleanup all io_failure_record::in_validation related
code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 131 +++++++------------------------------------
 fs/btrfs/extent_io.h |   3 +-
 2 files changed, 20 insertions(+), 114 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 85719947fa31..ec4ca91861d8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2426,13 +2426,6 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 
 	BUG_ON(!failrec->this_mirror);
 
-	if (failrec->in_validation) {
-		/* there was no real error, just free the record */
-		btrfs_debug(fs_info,
-			"clean_io_failure: freeing dummy error at %llu",
-			failrec->start);
-		goto out;
-	}
 	if (sb_rdonly(fs_info->sb))
 		goto out;
 
@@ -2509,9 +2502,8 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	failrec = get_state_failrec(failure_tree, start);
 	if (!IS_ERR(failrec)) {
 		btrfs_debug(fs_info,
-			"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu, validation=%d",
-			failrec->logical, failrec->start, failrec->len,
-			failrec->in_validation);
+	"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu",
+			failrec->logical, failrec->start, failrec->len);
 		/*
 		 * when data can be on disk more than twice, add to failrec here
 		 * (e.g. with a list for failed_mirror) to make
@@ -2529,7 +2521,6 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	failrec->len = sectorsize;
 	failrec->this_mirror = 0;
 	failrec->bio_flags = 0;
-	failrec->in_validation = 0;
 
 	read_lock(&em_tree->lock);
 	em = lookup_extent_mapping(em_tree, start, failrec->len);
@@ -2580,7 +2571,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	return failrec;
 }
 
-static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
+static bool btrfs_check_repairable(struct inode *inode,
 				   struct io_failure_record *failrec,
 				   int failed_mirror)
 {
@@ -2600,39 +2591,22 @@ static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
 		return false;
 	}
 
+	/* The failure record should only contain one sector */
+	ASSERT(failrec->len == fs_info->sectorsize);
+
 	/*
-	 * there are two premises:
-	 *	a) deliver good data to the caller
-	 *	b) correct the bad sectors on disk
+	 * There are two premises:
+	 * a) deliver good data to the caller
+	 * b) correct the bad sectors on disk
+	 *
+	 * Since we're only doing repair for one sector, we only need to get
+	 * a good copy of the failed sector and if we succeed, we have setup
+	 * everything for repair_io_failure to do the rest for us.
 	 */
-	if (needs_validation) {
-		/*
-		 * to fulfill b), we need to know the exact failing sectors, as
-		 * we don't want to rewrite any more than the failed ones. thus,
-		 * we need separate read requests for the failed bio
-		 *
-		 * if the following BUG_ON triggers, our validation request got
-		 * merged. we need separate requests for our algorithm to work.
-		 */
-		BUG_ON(failrec->in_validation);
-		failrec->in_validation = 1;
-		failrec->this_mirror = failed_mirror;
-	} else {
-		/*
-		 * we're ready to fulfill a) and b) alongside. get a good copy
-		 * of the failed sector and if we succeed, we have setup
-		 * everything for repair_io_failure to do the rest for us.
-		 */
-		if (failrec->in_validation) {
-			BUG_ON(failrec->this_mirror != failed_mirror);
-			failrec->in_validation = 0;
-			failrec->this_mirror = 0;
-		}
-		failrec->failed_mirror = failed_mirror;
+	failrec->failed_mirror = failed_mirror;
+	failrec->this_mirror++;
+	if (failrec->this_mirror == failed_mirror)
 		failrec->this_mirror++;
-		if (failrec->this_mirror == failed_mirror)
-			failrec->this_mirror++;
-	}
 
 	if (failrec->this_mirror > num_copies) {
 		btrfs_debug(fs_info,
@@ -2644,61 +2618,6 @@ static bool btrfs_check_repairable(struct inode *inode, bool needs_validation,
 	return true;
 }
 
-static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
-{
-	u64 len = 0;
-	const u32 blocksize = inode->i_sb->s_blocksize;
-
-	/*
-	 * If bi_status is BLK_STS_OK, then this was a checksum error, not an
-	 * I/O error. In this case, we already know exactly which sector was
-	 * bad, so we don't need to validate.
-	 */
-	if (bio->bi_status == BLK_STS_OK)
-		return false;
-
-	/*
-	 * For subpage case, read bio are always submitted as multiple-sector
-	 * bio if the range is in the same page.
-	 * For now, let's just skip the validation, and do page sized repair.
-	 *
-	 * This reduce the granularity for repair, meaning if we have two
-	 * copies with different csum mismatch at different location, we're
-	 * unable to repair in subpage case.
-	 *
-	 * TODO: Make validation code to be fully subpage compatible
-	 */
-	if (blocksize < PAGE_SIZE)
-		return false;
-	/*
-	 * We need to validate each sector individually if the failed I/O was
-	 * for multiple sectors.
-	 *
-	 * There are a few possible bios that can end up here:
-	 * 1. A buffered read bio, which is not cloned.
-	 * 2. A direct I/O read bio, which is cloned.
-	 * 3. A (buffered or direct) repair bio, which is not cloned.
-	 *
-	 * For cloned bios (case 2), we can get the size from
-	 * btrfs_io_bio->iter; for non-cloned bios (cases 1 and 3), we can get
-	 * it from the bvecs.
-	 */
-	if (bio_flagged(bio, BIO_CLONED)) {
-		if (btrfs_io_bio(bio)->iter.bi_size > blocksize)
-			return true;
-	} else {
-		struct bio_vec *bvec;
-		int i;
-
-		bio_for_each_bvec_all(bvec, bio, i) {
-			len += bvec->bv_len;
-			if (len > blocksize)
-				return true;
-		}
-	}
-	return false;
-}
-
 int btrfs_repair_one_sector(struct inode *inode,
 			    struct bio *failed_bio, u32 bio_offset,
 			    struct page *page, unsigned int pgoff,
@@ -2711,7 +2630,6 @@ int btrfs_repair_one_sector(struct inode *inode,
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
 	struct btrfs_io_bio *failed_io_bio = btrfs_io_bio(failed_bio);
 	const int icsum = bio_offset >> fs_info->sectorsize_bits;
-	bool need_validation;
 	struct bio *repair_bio;
 	struct btrfs_io_bio *repair_io_bio;
 	blk_status_t status;
@@ -2725,16 +2643,7 @@ int btrfs_repair_one_sector(struct inode *inode,
 	if (IS_ERR(failrec))
 		return PTR_ERR(failrec);
 
-	/*
-	 * We will only submit repair for one sector, thus we don't need
-	 * extra validation anymore.
-	 *
-	 * TODO: All those extra validation related code will be cleaned up
-	 * later.
-	 */
-	need_validation = false;
-	if (!btrfs_check_repairable(inode, need_validation, failrec,
-				    failed_mirror)) {
+	if (!btrfs_check_repairable(inode, failrec, failed_mirror)) {
 		free_io_failure(failure_tree, tree, failrec);
 		return -EIO;
 	}
@@ -2742,8 +2651,6 @@ int btrfs_repair_one_sector(struct inode *inode,
 	repair_bio = btrfs_io_bio_alloc(1);
 	repair_io_bio = btrfs_io_bio(repair_bio);
 	repair_bio->bi_opf = REQ_OP_READ;
-	if (need_validation)
-		repair_bio->bi_opf |= REQ_FAILFAST_DEV;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
@@ -2761,8 +2668,8 @@ int btrfs_repair_one_sector(struct inode *inode,
 	repair_io_bio->iter = repair_bio->bi_iter;
 
 	btrfs_debug(btrfs_sb(inode->i_sb),
-"repair read error: submitting new read to mirror %d, in_validation=%d",
-		    failrec->this_mirror, failrec->in_validation);
+		    "repair read error: submitting new read to mirror %d",
+		    failrec->this_mirror);
 
 	status = submit_bio_hook(inode, repair_bio, failrec->this_mirror,
 				 failrec->bio_flags);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c49ce96c8b5d..d5c324a7a3d8 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -292,7 +292,7 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
  * When IO fails, either with EIO or csum verification fails, we
  * try other mirrors that might have a good copy of the data.  This
  * io_failure_record is used to record state as we go through all the
- * mirrors.  If another mirror has good data, the page is set up to date
+ * mirrors.  If another mirror has good data, the sector is set up to date
  * and things continue.  If a good mirror can't be found, the original
  * bio end_io callback is called to indicate things have failed.
  */
@@ -304,7 +304,6 @@ struct io_failure_record {
 	unsigned long bio_flags;
 	int this_mirror;
 	int failed_mirror;
-	int in_validation;
 };
 
 
-- 
2.31.1

