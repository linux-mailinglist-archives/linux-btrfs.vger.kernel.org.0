Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA56B8B0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCNGRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCNGRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2048B77E11
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ouQi74ztiIsf1g9BY5UKzOb5A3asYmZ5/EMg4AbvHgQ=; b=kwwZFK9yGri+ZPsDAPhcaY8VXw
        l08YKhu2vhaIy8+Odn5b8vHWSRABhevKrMv+o7vHRfipbwK5RI93S9DcY9mBPkfEkUpXynmSxMEDk
        y3dGbu4yVA1YP1F+VegtTRSv7VY321AsPecxrr9m4m1F+aGAG21NPmOej40F3xu/qyk6toy3jvFFB
        Y8YYMCaTriSHIyzakLp80rh7VJpwSRPGEJ+NHO+Dozy5pQ702FiobFxGOQClN28AQz5Ivg+noNsxh
        ahgKlozmOlSyQDI+4wGCa0JdtMV9QQlZ3D8EmCO1691JVLZ4+cDmcJOQllmMUqZmhjvc16TSRks9F
        ar1iil+g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyD-009Ai8-7F; Tue, 14 Mar 2023 06:17:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 05/21] btrfs: always read the entire extent_buffer
Date:   Tue, 14 Mar 2023 07:16:39 +0100
Message-Id: <20230314061655.245340-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently read_extent_buffer_pages skips pages that are already uptodate
when reading in an extent_buffer.  While this reduces the amount of data
read, it increases the number of I/O operations as we now need to do
multiple I/Os when reading an extent buffer with one or more uptodate
pages in the middle of it.  On any modern storage device, be that hard
drives or SSDs this actually decreases I/O performance.  Fortunately
this case is pretty rare as the pages are always initially read together
and then aged the same way.  Besides simplifying the code a bit as-is
this will allow for major simplifications to the I/O completion handler
later on.

Note that the case where all pages are uptodate is still handled by an
optimized fast path that does not read any data from disk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2bc141b3f3bc4b..e7a0ef6d70bfe1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4314,7 +4314,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int locked_pages = 0;
 	int all_uptodate = 1;
 	int num_pages;
-	unsigned long num_reads = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_READ,
 		.mirror_num = mirror_num,
@@ -4360,10 +4359,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	 */
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-		if (!PageUptodate(page)) {
-			num_reads++;
+		if (!PageUptodate(page))
 			all_uptodate = 0;
-		}
 	}
 
 	if (all_uptodate) {
@@ -4373,7 +4370,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, num_reads);
+	atomic_set(&eb->io_pages, num_pages);
 	/*
 	 * It is possible for release_folio to clear the TREE_REF bit before we
 	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
@@ -4383,13 +4380,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 
-		if (!PageUptodate(page)) {
-			ClearPageError(page);
-			submit_extent_page(&bio_ctrl, page_offset(page), page,
-					   PAGE_SIZE, 0);
-		} else {
-			unlock_page(page);
-		}
+		ClearPageError(page);
+		submit_extent_page(&bio_ctrl, page_offset(page), page,
+				   PAGE_SIZE, 0);
 	}
 
 	submit_one_bio(&bio_ctrl);
-- 
2.39.2

