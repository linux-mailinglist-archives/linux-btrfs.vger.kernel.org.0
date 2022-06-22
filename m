Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B655444D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jun 2022 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354112AbiFVHuN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jun 2022 03:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354486AbiFVHty (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jun 2022 03:49:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F237A9A
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jun 2022 00:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dowDrErVvg3O+z6WSGPgZJ6PtObm0JBthWjkPtjntOk=; b=YZWcS+AACQrZijVgCy9yWYQTTH
        q2sC5P05EawWoniSah1Rj0Zos3pEeCjHguGBiMfQmoi7dxyW/rKIpLl2x3zsqkqVN4M9wwjrF0iQX
        09x3bbezsBBdqoza66MYh3YLkmA/rBHBPyN0Hsp3dgkBSzAjAne3UNhiOluyDqQQUb8rlgQn/nZ84
        /5jwlOoU6NhhgH7jcZ2eW/KcFym1jeIOwEvnrZDn0O/LCTizXcCpZzhMTcoSgzpPVfCnRwa0dtGVQ
        8UsZNXXyLpsJi8Z94plRfn3OTIfZBxEfkirMDTiRYRUDLhlApoxIXWMWAnsRwRncLZfHIWZHJrXH6
        pkJdafvQ==;
Received: from [2001:4bb8:189:7251:42c6:7c8:8ccc:6d9b] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3v7P-0097I3-7L; Wed, 22 Jun 2022 07:49:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: repair all known bad mirrors
Date:   Wed, 22 Jun 2022 09:49:39 +0200
Message-Id: <20220622074939.3287300-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When there is more than a single level of redundancy there can also be
mutiple bad mirrors, and the current read repair code only repairs the
last bad one.

Restructure btrfs_repair_one_sector so that it records the originally
failed mirror and the number of copies, and then repair all known bad
copies until we reach the originally failed copy in clean_io_failure.
Note that this also means the read repair reads will always start from
the next bad mirror and not mirror 0.

This fixes btrfs/265 in xfstests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - rename orig_mirror back to failed_mirror
 - update the commit log to replace all bad mirrors with all known bad
   mirrors

 fs/btrfs/extent_io.c | 127 +++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h |   1 +
 2 files changed, 62 insertions(+), 66 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 854999c2e139b..1b67c32812b78 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2432,6 +2432,20 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	return ret;
 }
 
+static int next_mirror(struct io_failure_record *failrec, int cur_mirror)
+{
+	if (cur_mirror == failrec->num_copies)
+		return cur_mirror + 1 - failrec->num_copies;
+	return cur_mirror + 1;
+}
+
+static int prev_mirror(struct io_failure_record *failrec, int cur_mirror)
+{
+	if (cur_mirror == 1)
+		return failrec->num_copies;
+	return cur_mirror - 1;
+}
+
 /*
  * each time an IO finishes, we do a fast check in the IO failure tree
  * to see if we need to process or clean up an io_failure_record
@@ -2444,7 +2458,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 	u64 private;
 	struct io_failure_record *failrec;
 	struct extent_state *state;
-	int num_copies;
+	int mirror;
 	int ret;
 
 	private = 0;
@@ -2468,20 +2482,19 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 					    EXTENT_LOCKED);
 	spin_unlock(&io_tree->lock);
 
-	if (state && state->start <= failrec->start &&
-	    state->end >= failrec->start + failrec->len - 1) {
-		num_copies = btrfs_num_copies(fs_info, failrec->logical,
-					      failrec->len);
-		if (num_copies > 1)  {
-			repair_io_failure(fs_info, ino, start, failrec->len,
-					  failrec->logical, page, pg_offset,
-					  failrec->failed_mirror);
-		}
-	}
+	if (!state || state->start > failrec->start ||
+	    state->end < failrec->start + failrec->len - 1)
+		goto out;
+
+	mirror = failrec->this_mirror;
+	do {
+		mirror = prev_mirror(failrec, mirror);
+		repair_io_failure(fs_info, ino, start, failrec->len,
+				  failrec->logical, page, pg_offset, mirror);
+	} while (mirror != failrec->failed_mirror);
 
 out:
 	free_io_failure(failure_tree, io_tree, failrec);
-
 	return 0;
 }
 
@@ -2520,7 +2533,8 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 }
 
 static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode,
-							     u64 start)
+							     u64 start,
+							     int failed_mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct io_failure_record *failrec;
@@ -2542,7 +2556,8 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 		 * (e.g. with a list for failed_mirror) to make
 		 * clean_io_failure() clean all those errors at once.
 		 */
-
+		ASSERT(failrec->this_mirror == failed_mirror);
+		ASSERT(failrec->len == fs_info->sectorsize);
 		return failrec;
 	}
 
@@ -2552,7 +2567,7 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 
 	failrec->start = start;
 	failrec->len = sectorsize;
-	failrec->this_mirror = 0;
+	failrec->failed_mirror = failrec->this_mirror = failed_mirror;
 	failrec->compress_type = BTRFS_COMPRESS_NONE;
 
 	read_lock(&em_tree->lock);
@@ -2587,6 +2602,20 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	failrec->logical = logical;
 	free_extent_map(em);
 
+	failrec->num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	if (failrec->num_copies == 1) {
+		/*
+		 * we only have a single copy of the data, so don't bother with
+		 * all the retry and error correction code that follows. no
+		 * matter what the error is, it is very likely to persist.
+		 */
+		btrfs_debug(fs_info,
+			"Check Repairable: cannot repair, num_copies=%d",
+			failrec->num_copies);
+		kfree(failrec);
+		return ERR_PTR(-EIO);
+	}
+
 	/* Set the bits in the private failure tree */
 	ret = set_extent_bits(failure_tree, start, start + sectorsize - 1,
 			      EXTENT_LOCKED | EXTENT_DIRTY);
@@ -2603,54 +2632,6 @@ static struct io_failure_record *btrfs_get_io_failure_record(struct inode *inode
 	return failrec;
 }
 
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
 int btrfs_repair_one_sector(struct inode *inode,
 			    struct bio *failed_bio, u32 bio_offset,
 			    struct page *page, unsigned int pgoff,
@@ -2671,12 +2652,26 @@ int btrfs_repair_one_sector(struct inode *inode,
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
-	failrec = btrfs_get_io_failure_record(inode, start);
+	failrec = btrfs_get_io_failure_record(inode, start, failed_mirror);
 	if (IS_ERR(failrec))
 		return PTR_ERR(failrec);
 
-
-	if (!btrfs_check_repairable(inode, failrec, failed_mirror)) {
+	/*
+	 * There are two premises:
+	 * a) deliver good data to the caller
+	 * b) correct the bad sectors on disk
+	 *
+	 * Since we're only doing repair for one sector, we only need to get
+	 * a good copy of the failed sector and if we succeed, we have setup
+	 * everything for repair_io_failure to do the rest for us.
+	 */
+	failrec->this_mirror = next_mirror(failrec, failrec->this_mirror);
+	if (failrec->this_mirror == failrec->failed_mirror) {
+		btrfs_debug(fs_info,
+			"Check Repairable: (fail) num_copies=%d, this_mirror %d, failed_mirror %d",
+			failrec->num_copies,
+			failrec->this_mirror,
+			failrec->failed_mirror);
 		free_io_failure(failure_tree, tree, failrec);
 		return -EIO;
 	}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c0f1fb63eeae7..c61728204d1d2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -264,6 +264,7 @@ struct io_failure_record {
 	enum btrfs_compression_type compress_type;
 	int this_mirror;
 	int failed_mirror;
+	int num_copies;
 };
 
 int btrfs_repair_one_sector(struct inode *inode,
-- 
2.30.2

