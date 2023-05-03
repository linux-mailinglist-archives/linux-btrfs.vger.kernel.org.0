Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5F6F5B0A
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjECPZe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjECPZd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039556A61
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CmaUQNxEw6xnVhCs+6Flgo62XEAVpkAQ0iRiKSWskzE=; b=pDcYkPWK32ulK8hiOp8UCzKSwl
        qnrFAPccZuIekGUWoF21R1ULmX+MXZSDfcY3W8h0oy15nZhQMDJI0hLfEMfCxvFQTEsEL2PY1oead
        i+YX/CE29TElvIN5ZvC+j2u6yzMrNKNujPcR510opOjQZWMeUjD0VYTaFObpzKEqmkWzfEmXVH0Cp
        Rynx61I+fXsHYmT9IQ06I6I+6RBWJovmnpdq9a1vqLrha3cpJGFoBri0fX50nTj3/3OHgVS68OC39
        a/1JHbbFZqeI5TuhXQ9q2PLQnep+1W5+CxNbxcavpi8nhvaLb1VcppnqWFOl3BLUliWVr79F6ImUV
        XA0cYvGQ==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEMD-004xog-1c;
        Wed, 03 May 2023 15:25:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 17/21] btrfs: stop using PageError for extent_buffers
Date:   Wed,  3 May 2023 17:24:37 +0200
Message-Id: <20230503152441.1141019-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 83e8d71e2c4d44..6a71e67766980c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1767,10 +1767,8 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 		struct page *page = bvec->bv_page;
 		u32 len = bvec->bv_len;
 				                
-		if (!uptodate) {
+		if (!uptodate)
 			btrfs_page_clear_uptodate(fs_info, page, start, len);
-			btrfs_page_set_error(fs_info, page, start, len);
-		}
 		btrfs_page_clear_writeback(fs_info, page, start, len);
 		bio_offset += len;
 	}
@@ -3945,7 +3943,6 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			continue;
 		lock_page(page);
 		btree_clear_page_dirty(page);
-		ClearPageError(page);
 		unlock_page(page);
 	}
 	WARN_ON(atomic_read(&eb->refs) == 0);
@@ -4103,10 +4100,8 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
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
@@ -4146,7 +4141,6 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		return 0;
 	}
 
-	btrfs_subpage_clear_error(fs_info, page, eb->start, eb->len);
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 
 	__read_extent_buffer_pages(eb, mirror_num, check);
@@ -4388,18 +4382,16 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
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

