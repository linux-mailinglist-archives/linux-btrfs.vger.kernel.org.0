Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745AA6F5B0B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjECPZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjECPZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3991730
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5JV8CQ5goCf6iq0aYZUqb/Dtb78n3KfcvTQ/2LUN+Kk=; b=ugq7uWxxLKU8pDQ9JdIXHLhmqk
        JMDyzOTN1hMKUEfARWM1Kz1wimPZNROSY/pHe6Gebaj3jDfuFvYr3JNWBZ0bZ84W3d8/wqzJ5oLFT
        TqSfRLTnUiNjv3AGGBydjJdRyFUFajP731zf/STuRHeo/QT3TZhoU76z50wDi59sP0lOgtkxdNEeK
        Vj/e/5p9gZ/tL3X31H4poqtgG1BYS6XxPJ+m/7waQS2otjpIQVxeCJGnK5yHdK9bpceZWf+qA2gRC
        dp2QWspe7bqRFJQg9F2OXMQb9tsuHYEsRSZssntvzx5TjjsXPYG8r3RQtkYOEGBvXdy1ETtwXlLYs
        mUaZ5HWA==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puEMG-004xpv-0V;
        Wed, 03 May 2023 15:25:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 18/21] btrfs: don't check for uptodate pages in read_extent_buffer_pages
Date:   Wed,  3 May 2023 17:24:38 +0200
Message-Id: <20230503152441.1141019-19-hch@lst.de>
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

The only place that reads in pages and thus marks them uptodate for
the btree inode is read_extent_buffer_pages.  Which means that either
pages are already uptodate from an old buffer when creating a new
one in alloc_extent_buffer, or they will be updated by ca call
to read_extent_buffer_pages.  This means the checks for uptodate
pages in read_extent_buffer_pages and read_extent_buffer_subpage are
superfluous and can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6a71e67766980c..7556323e650cd4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4132,10 +4132,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 			return ret;
 	}
 
-	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags) ||
-	    PageUptodate(page) ||
-	    btrfs_subpage_test_uptodate(fs_info, page, eb->start, eb->len)) {
-		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags)) {
 		unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
 			      &cached_state);
 		return 0;
@@ -4162,7 +4159,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int i;
 	struct page *page;
 	int locked_pages = 0;
-	int all_uptodate = 1;
 	int num_pages;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
@@ -4197,21 +4193,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 		}
 		locked_pages++;
 	}
-	/*
-	 * We need to firstly lock all pages to make sure that
-	 * the uptodate bit of our pages won't be affected by
-	 * clear_extent_buffer_uptodate().
-	 */
-	for (i = 0; i < num_pages; i++) {
-		page = eb->pages[i];
-		if (!PageUptodate(page))
-			all_uptodate = 0;
-	}
-
-	if (all_uptodate) {
-		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-		goto unlock_exit;
-	}
 
 	__read_extent_buffer_pages(eb, mirror_num, check);
 
-- 
2.39.2

