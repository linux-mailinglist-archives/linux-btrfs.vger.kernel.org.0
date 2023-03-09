Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217FC6B1F64
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCIJH7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCIJHf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:07:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168E12846
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=L/w03f9aBT95zvii3UAzQawRX/9d2qa1ChCd+PMOxrI=; b=S9XFJto+PcWSE3d8yoWXObk1cW
        17A8+mhleiVJ8vbEXro93JHggtb0CoUdyNryCxUJtv6Oq0iNxb+HUT7zG8Lfv2PQ3aMENfT42Kupo
        KVX67aXEGDvi5yyeDYAyrD3ItB5jdG3WOP8w0lhOJdOMiQJUka49Drg27nhWlNGWItwAm3/VcsEU7
        7qShsZsmEDeHtA0iUwQAAKAr+y4eNt7EBExrxmyKxtYKZRa4VQRIzCNQrM9odHmoA2pd5tdwtgg+x
        hiUKEdTxgxZAAGfeZNjSbHhgJ3cD4J1zi5zGDOQRsaNdEncseGEnwYkaFuaskgA2s0h68zmTh6SLk
        LeEFO8ag==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEp-008i4h-Uq; Thu, 09 Mar 2023 09:07:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/20] btrfs: don't check for uptodate pages in read_extent_buffer_pages
Date:   Thu,  9 Mar 2023 10:05:23 +0100
Message-Id: <20230309090526.332550-18-hch@lst.de>
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

The only place that reads in pages and thus marks them uptodate for
the btree inode is read_extent_buffer_pages.  Which means that either
pages are already uptodate from an old buffer when creating a new
one in alloc_extent_buffer, or they will be updated by ca call
to read_extent_buffer_pages.  This means the checks for uptodate
pages in read_extent_buffer_pages and read_extent_buffer_subpage are
superflous and can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 88a941c64fc73f..73ea618282d466 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4138,10 +4138,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
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
@@ -4168,7 +4165,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int i;
 	struct page *page;
 	int locked_pages = 0;
-	int all_uptodate = 1;
 	int num_pages;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
@@ -4203,21 +4199,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
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

