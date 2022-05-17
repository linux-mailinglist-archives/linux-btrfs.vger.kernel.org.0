Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B252A54A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbiEQOvb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbiEQOvJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF9212770
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AtvXKYWl6XABw5K/9ZTlupqE4tGvelFvIeVNSS1GMbo=; b=ZkskA1l78ZRDtMjqkUMgGdW0Iv
        ed8t+A7JzB7nxMxkAr3MIzpsPmyUcz3Vpbr+fSz6VI76zM5SMwGUvp3vREZY1x814LQESFgn+NQqm
        Z/gafaAMTuQc1u+8QVHnzwP+Hhd501DN+/HRZDbQcXl7pUufcrYVLSIAVdQpqxCQiDp5uQYjTojlL
        20DFnIanWOPRwdXET8I3r6Thzco/zy+gPgWap3ld/hDktzQcTjABd4SuWGd7OMe9IzMlnlpaeXNN7
        l5aT0IQWwY5Iy9Jp7GmCJ5vjoQ6GjHdYmkcqJ2aPJNBqxVnOH6BYBzb2oiLCOPHAvND/bCL0Yztqp
        ++iULQjw==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXP-00EXCp-Gb; Tue, 17 May 2022 14:51:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 06/15] btrfs: make repair_io_failure available outside of extent_io.c
Date:   Tue, 17 May 2022 16:50:30 +0200
Message-Id: <20220517145039.3202184-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

Remove the static so that the function can be used by the new read
repair code, and give it a btrfs_ prefix.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 fs/btrfs/extent_io.h |  3 +++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cee205d8d4bac..75466747a252c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2326,9 +2326,9 @@ int free_io_failure(struct extent_io_tree *failure_tree,
  * currently, there can be no more than two copies of every data bit. thus,
  * exactly one rewrite is required.
  */
-static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			     u64 length, u64 logical, struct page *page,
-			     unsigned int pg_offset, int mirror_num)
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num)
 {
 	struct btrfs_device *dev;
 	struct bio_vec bvec;
@@ -2420,8 +2420,9 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
-		ret = repair_io_failure(fs_info, 0, start, PAGE_SIZE, start, p,
-					start - page_offset(p), mirror_num);
+		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
+					      start, p, start - page_offset(p),
+					      mirror_num);
 		if (ret)
 			break;
 		start += PAGE_SIZE;
@@ -2471,9 +2472,9 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 		num_copies = btrfs_num_copies(fs_info, failrec->logical,
 					      failrec->len);
 		if (num_copies > 1)  {
-			repair_io_failure(fs_info, ino, start, failrec->len,
-					  failrec->logical, page, pg_offset,
-					  failrec->failed_mirror);
+			btrfs_repair_io_failure(fs_info, ino, start,
+					failrec->len, failrec->logical,
+					page, pg_offset, failrec->failed_mirror);
 		}
 	}
 
@@ -2631,7 +2632,7 @@ static bool btrfs_check_repairable(struct inode *inode,
 	 *
 	 * Since we're only doing repair for one sector, we only need to get
 	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for repair_io_failure to do the rest for us.
+	 * everything for btrfs_repair_io_failure() to do the rest for us.
 	 */
 	ASSERT(failed_mirror);
 	failrec->failed_mirror = failed_mirror;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 956fa434df435..6cdcea1551a66 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -276,6 +276,9 @@ int btrfs_repair_one_sector(struct inode *inode,
 			    struct page *page, unsigned int pgoff,
 			    u64 start, int failed_mirror,
 			    submit_bio_hook_t *submit_bio_hook);
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-- 
2.30.2

