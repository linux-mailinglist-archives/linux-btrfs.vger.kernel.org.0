Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF60511248
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358728AbiD0HWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358726AbiD0HWj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F81606D6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 059C51F746
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGzlRoxbVOYqGp3DFYeyzg11Tc3r85tZiZ3yqNB2D88=;
        b=LOIoePGE1pBSPmGU77gau+tr7LpN6vUfk5juJbLAyQIp9wh8Jo1z7jTq5qFpldKDuT1HL7
        bqbdRsbKc+x9BSVAo765xBKpTf9cyIlDcsky9i4+W6EWxQdaonKz8HkNDlXuRKUJLvSzny
        5kYmgQH4cRdxV0nOrfduOWjfxcLyMTA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AA2713A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IAdcBH/uaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 10/12] btrfs: cleanup btrfs_repair_one_sector()
Date:   Wed, 27 Apr 2022 15:18:56 +0800
Message-Id: <b3aaa77d32dbed374a6a3aa0375077333bb3fba7.1651043618.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
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

The function and its dependencies are no longer used any more, we can
clean them up.

Please note that, btrfs_repair_one_sector() is the only caller of
set_state_failrec() with a non-NULL pointer.

Although this patch leaves the other failure record related
infrastructures untouched, it's mostly for patch split.

This is the first step towards removing btrfs_inode::io_failure_tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 195 -------------------------------------------
 fs/btrfs/extent_io.h |   6 --
 2 files changed, 201 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 515de39e70f7..6f2faa77523d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2509,201 +2509,6 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 	spin_unlock(&failure_tree->lock);
 }
 
-static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     u64 start)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct io_failure_record *failrec;
-	struct extent_map *em;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
-	const u32 sectorsize = fs_info->sectorsize;
-	int ret;
-	u64 logical;
-
-	failrec = get_state_failrec(failure_tree, start);
-	if (!IS_ERR(failrec)) {
-		btrfs_debug(fs_info,
-	"Get IO Failure Record: (found) logical=%llu, start=%llu, len=%llu",
-			failrec->logical, failrec->start, failrec->len);
-		/*
-		 * when data can be on disk more than twice, add to failrec here
-		 * (e.g. with a list for failed_mirror) to make
-		 * clean_io_failure() clean all those errors at once.
-		 */
-
-		return failrec;
-	}
-
-	failrec = kzalloc(sizeof(*failrec), GFP_NOFS);
-	if (!failrec)
-		return ERR_PTR(-ENOMEM);
-
-	failrec->start = start;
-	failrec->len = sectorsize;
-	failrec->this_mirror = 0;
-	failrec->bio_flags = 0;
-
-	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, failrec->len);
-	if (!em) {
-		read_unlock(&em_tree->lock);
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	if (em->start > start || em->start + em->len <= start) {
-		free_extent_map(em);
-		em = NULL;
-	}
-	read_unlock(&em_tree->lock);
-	if (!em) {
-		kfree(failrec);
-		return ERR_PTR(-EIO);
-	}
-
-	logical = start - em->start;
-	logical = em->block_start + logical;
-	if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-		logical = em->block_start;
-		failrec->bio_flags = EXTENT_BIO_COMPRESSED;
-		extent_set_compress_type(&failrec->bio_flags, em->compress_type);
-	}
-
-	btrfs_debug(fs_info,
-		    "Get IO Failure Record: (new) logical=%llu, start=%llu, len=%llu",
-		    logical, start, failrec->len);
-
-	failrec->logical = logical;
-	free_extent_map(em);
-
-	/* Set the bits in the private failure tree */
-	ret = set_extent_bits(failure_tree, start, start + sectorsize - 1,
-			      EXTENT_LOCKED | EXTENT_DIRTY);
-	if (ret >= 0) {
-		ret = set_state_failrec(failure_tree, start, failrec);
-		/* Set the bits in the inode's tree */
-		ret = set_extent_bits(tree, start, start + sectorsize - 1,
-				      EXTENT_DAMAGED);
-	} else if (ret < 0) {
-		kfree(failrec);
-		return ERR_PTR(ret);
-	}
-
-	return failrec;
-}
-
-static bool btrfs_check_repairable(struct inode *inode,
-				   struct io_failure_record *failrec,
-				   int failed_mirror)
-{
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int num_copies;
-
-	num_copies = btrfs_num_copies(fs_info, failrec->logical, failrec->len);
-	if (num_copies == 1) {
-		/*
-		 * we only have a single copy of the data, so don't bother with
-		 * all the retry and error correction code that follows. no
-		 * matter what the error is, it is very likely to persist.
-		 */
-		btrfs_debug(fs_info,
-			"Check Repairable: cannot repair, num_copies=%d, next_mirror %d, failed_mirror %d",
-			num_copies, failrec->this_mirror, failed_mirror);
-		return false;
-	}
-
-	/* The failure record should only contain one sector */
-	ASSERT(failrec->len == fs_info->sectorsize);
-
-	/*
-	 * There are two premises:
-	 * a) deliver good data to the caller
-	 * b) correct the bad sectors on disk
-	 *
-	 * Since we're only doing repair for one sector, we only need to get
-	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for repair_io_failure to do the rest for us.
-	 */
-	ASSERT(failed_mirror);
-	failrec->failed_mirror = failed_mirror;
-	failrec->this_mirror++;
-	if (failrec->this_mirror == failed_mirror)
-		failrec->this_mirror++;
-
-	if (failrec->this_mirror > num_copies) {
-		btrfs_debug(fs_info,
-			"Check Repairable: (fail) num_copies=%d, next_mirror %d, failed_mirror %d",
-			num_copies, failrec->this_mirror, failed_mirror);
-		return false;
-	}
-
-	return true;
-}
-
-int btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook)
-{
-	struct io_failure_record *failrec;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
-	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
-	struct btrfs_bio *failed_bbio = btrfs_bio(failed_bio);
-	const int icsum = bio_offset >> fs_info->sectorsize_bits;
-	struct bio *repair_bio;
-	struct btrfs_bio *repair_bbio;
-
-	btrfs_debug(fs_info,
-		   "repair read error: read error at %llu", start);
-
-	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
-
-	failrec = btrfs_get_io_failure_record(inode, start);
-	if (IS_ERR(failrec))
-		return PTR_ERR(failrec);
-
-
-	if (!btrfs_check_repairable(inode, failrec, failed_mirror)) {
-		free_io_failure(failure_tree, tree, failrec);
-		return -EIO;
-	}
-
-	repair_bio = btrfs_bio_alloc(1);
-	repair_bbio = btrfs_bio(repair_bio);
-	repair_bbio->file_offset = start;
-	repair_bio->bi_opf = REQ_OP_READ;
-	repair_bio->bi_end_io = failed_bio->bi_end_io;
-	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
-	repair_bio->bi_private = failed_bio->bi_private;
-
-	if (failed_bbio->csum) {
-		const u32 csum_size = fs_info->csum_size;
-
-		repair_bbio->csum = repair_bbio->csum_inline;
-		memcpy(repair_bbio->csum,
-		       failed_bbio->csum + csum_size * icsum, csum_size);
-	}
-
-	bio_add_page(repair_bio, page, failrec->len, pgoff);
-	repair_bbio->iter = repair_bio->bi_iter;
-
-	btrfs_debug(btrfs_sb(inode->i_sb),
-		    "repair read error: submitting new read to mirror %d",
-		    failrec->this_mirror);
-
-	/*
-	 * At this point we have a bio, so any errors from submit_bio_hook()
-	 * will be handled by the endio on the repair_bio, so we can't return an
-	 * error here.
-	 */
-	submit_bio_hook(inode, repair_bio, failrec->this_mirror, failrec->bio_flags);
-	return BLK_STS_OK;
-}
-
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f829e6899fad..5e76df4a832b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -353,12 +353,6 @@ struct io_failure_record {
 	int failed_mirror;
 };
 
-int btrfs_repair_one_sector(struct inode *inode,
-			    struct bio *failed_bio, u32 bio_offset,
-			    struct page *page, unsigned int pgoff,
-			    u64 start, int failed_mirror,
-			    submit_bio_hook_t *submit_bio_hook);
-
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
-- 
2.36.0

