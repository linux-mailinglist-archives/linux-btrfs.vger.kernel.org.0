Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAEC55095D
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jun 2022 10:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiFSI2m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jun 2022 04:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbiFSI2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jun 2022 04:28:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2310FCA
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jun 2022 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=X5Y2/ag/6VzwtjHd4mGgYpE1yqlgAzUu4OcR8WW7Ulk=; b=iLHsuDgNHMb65tY+hQ8TbQJ0E1
        08ZM6Lg4PFA3W/kYxi45Z56JAohorIIo0T8Z78FpXgvYVYII3dCrs0F5L3cqHI8zyTZPmTGMB4C18
        yvrSvl3ZE0A1nU2zf2txWNB28HL90rtn9UN8gKSCBKtIFSkNh1rYRV8+xZiQlXho2hJ4buP+j1UVu
        jvOV4w3OmQnf3xqb9DqMnohcht5mekqiNzTM+BLqisaJgh3nmMrOsPW1gZXNF7WLooSRzI4rnczC0
        4pcIVeMV6V/cjeyuCtGJYVdzUgnKzNabw6SHu5/8So36n4fkoIko0/vknPThTbbMve/8C2CFBcJQP
        xnMOFkew==;
Received: from [2001:4bb8:189:7251:513c:d533:c6f1:1e56] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2qID-00DbPZ-8M; Sun, 19 Jun 2022 08:28:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: repair all bad mirrors
Date:   Sun, 19 Jun 2022 10:28:21 +0200
Message-Id: <20220619082821.2151052-1-hch@lst.de>
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

Restructure btrfs_repair_one_sector so that it records the original bad
bad mirror, and the number of copies, and then repair all bad copies
until we reach the original bad copy in clean_io_failure.  Note that
this also means the read repair reads will always start from the next
bad mirror and not mirror 0.

This fixes btrfs/265 in xfstests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 127 +++++++++++++++++++++----------------------
 fs/btrfs/extent_io.h |   3 +-
 2 files changed, 63 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 854999c2e139b..9775ac5d28a9e 100644
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
+	} while (mirror != failrec->orig_mirror);
 
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
+	failrec->orig_mirror = failrec->this_mirror = failed_mirror;
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
+	if (failrec->this_mirror == failrec->orig_mirror) {
+		btrfs_debug(fs_info,
+			"Check Repairable: (fail) num_copies=%d, this_mirror %d, orig_mirror %d",
+			failrec->num_copies,
+			failrec->this_mirror,
+			failrec->orig_mirror);
 		free_io_failure(failure_tree, tree, failrec);
 		return -EIO;
 	}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c0f1fb63eeae7..5bd23bb239dae 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -262,8 +262,9 @@ struct io_failure_record {
 	u64 len;
 	u64 logical;
 	enum btrfs_compression_type compress_type;
+	int orig_mirror;
 	int this_mirror;
-	int failed_mirror;
+	int num_copies;
 };
 
 int btrfs_repair_one_sector(struct inode *inode,
-- 
2.30.2

