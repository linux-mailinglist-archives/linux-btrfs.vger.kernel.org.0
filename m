Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7126B1F65
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCIJH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCIJHV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:07:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA48868F
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=isSx30pNhOwIRTEnAzfaBfa68aYPAcbNDJ4dXYGwgLg=; b=R5bgXVqK9kl6jhkHimrYRWtS1n
        IE3RTVhyrplg3L5SZGAypU7h91cpc9aeRqAUgSTA/AiST0408WRguKNZW4jt8MyNA+uCTaHUvCeWY
        bVzm6Tc1qRyEpt7mNMV7CJK2Zfgu9X1NRo3RqEe/fMcooSMnv84/ck2UULtj5WdONA4ZyKDImIZk3
        g4Q2QzxsuI6393nVeuOhM9iAk7tQOLpTT3Qhd1ZzAqTSeAXunlmauyb6NzHV+GiDhOhfDwUlbUB54
        rtS7U+Mq0Xf42HcHciHv1I0MHTiNHrKgBqNKbVhGfuiqIhB18bBPPpGrIGX4H1UpLmg/zptdhaYk7
        +HHjT4cg==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEl-008i1a-RR; Thu, 09 Mar 2023 09:07:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/20] btrfs: stop using PageError for extent_buffers
Date:   Thu,  9 Mar 2023 10:05:22 +0100
Message-Id: <20230309090526.332550-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PageError is only used to limit the uptodate check in
assert_eb_page_uptodate.  But we have a much more useful flag indicating
the exact condition we are about with the EXTENT_BUFFER_WRITE_ERR flag,
so use that instead and help the kernel torward eventually removing
PageError.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 24df1247d81d88..88a941c64fc73f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1770,10 +1770,8 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
 		struct page *page = bvec->bv_page;
 
-		if (!uptodate) {
+		if (!uptodate)
 			ClearPageUptodate(page);
-			btrfs_page_set_error(fs_info, page, eb->start, eb->len);
-		}
 
 		if (fs_info->nodesize < PAGE_SIZE)
 			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
@@ -4108,10 +4106,8 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 		__bio_add_page(&bbio->bio, eb->pages[0], eb->len,
 			       eb->start - page_offset(eb->pages[0]));
 	} else {
-		for (i = 0; i < num_pages; i++) {
-			ClearPageError(eb->pages[i]);
+		for (i = 0; i < num_pages; i++)
 			__bio_add_page(&bbio->bio, eb->pages[i], PAGE_SIZE, 0);
-		}
 	}
 	btrfs_submit_bio(bbio, mirror_num);
 }
@@ -4151,7 +4147,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		return 0;
 	}
 
-	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 
 	__read_extent_buffer_pages(eb, mirror_num, check);
@@ -4393,18 +4388,16 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 	 * looked up.  We don't want to complain in this case, as the page was
 	 * valid before, we just didn't write it out.  Instead we want to catch
 	 * the case where we didn't actually read the block properly, which
-	 * would have !PageUptodate && !PageError, as we clear PageError before
-	 * reading.
+	 * would have !PageUptodate && !EXTENT_BUFFER_WRITE_ERR.
 	 */
-	if (fs_info->nodesize < PAGE_SIZE) {
-		bool uptodate, error;
+	if (test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
+		return;
 
-		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
-						       eb->start, eb->len);
-		error = btrfs_subpage_test_error(fs_info, page, eb->start, eb->len);
-		WARN_ON(!uptodate && !error);
+	if (fs_info->nodesize < PAGE_SIZE) {
+		WARN_ON(!btrfs_subpage_test_uptodate(fs_info, page,
+						     eb->start, eb->len));
 	} else {
-		WARN_ON(!PageUptodate(page) && !PageError(page));
+		WARN_ON(!PageUptodate(page));
 	}
 }
 
-- 
2.39.2

