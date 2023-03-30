Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A486CFB9A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjC3Gbo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC3Gbn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2665240
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ix9SazV3GqXRW4nSmg6a1NKhf+/6VN2YsGmTiTD5fuE=; b=iTpX89HiRF5mJ06NhKVyUpj+qQ
        xiHS/l0YWfEDz5tvMrpztsEuo8uSOWJuY+wieAj8uoXcIbdFDDju0XcseaFgiRXPWauii7u4RLH0S
        6EIWAv/6jqtgvy7HX6okRMq/dE3vGUObEorW7xobjoLHhdG4cRXiIWYdX6tC/XHZU5o/lvrPRcWvR
        bXQgLpPQDdZPrYfp77D84SvepY9MbRcWJ4Pe3MkXinka/EB29EZoWqGb6x9YduYx5DTYosrlNSyJt
        s7UZgexRsJKCvPu+I2L1e8xZM1F1Dg9EBN6nLwqlu3DhqSSZwYandgYGFO/1yWvf2Ug94byAecXrD
        SZgl0uhg==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloy-002liE-38;
        Thu, 30 Mar 2023 06:31:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 18/21] btrfs: don't check for uptodate pages in read_extent_buffer_pages
Date:   Thu, 30 Mar 2023 15:30:56 +0900
Message-Id: <20230330063059.1574380-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 642e954ac99259..587ae974c39dd9 100644
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

