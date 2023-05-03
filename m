Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A696F5AFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjECPZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjECPZC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D646A63
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z2Cz181nsjifhTLDyhPeOdK9X9Biw4Ryugid0CD5ZCI=; b=1OytYSgUKpgOYVJekfh9F1LIL+
        c8tWK2fvTZbLSX1U+4/pjq5Q23vvViL7MPPL++J0PGVBpr+MrCKUDQmQBfkcuk2n2itBggf/nyP6H
        XiHdthqx4QwrWlo12iz6cErHBAKjOBDUkYl2ZUHpzCMdU5BNHRVEjAW26f96uvtgQJnueY8/FQ79g
        xL2Q75DrMzUwAOji/WVu8d7FLkZFWPirpOfBwXMT1KJ9Jk5OGLOjGkLyXEfgcbuoMbli3Tvcg+83c
        7+Cs4ukkiXm1a20+YHQrszzkAmZbprFaOU/M7MNihMvFiYEdzJwOIYUonQtab/peIYM7+d6k13DuN
        48Fmw0Fg==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELi-004xeF-0t;
        Wed, 03 May 2023 15:24:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 05/21] btrfs: always read the entire extent_buffer
Date:   Wed,  3 May 2023 17:24:25 +0200
Message-Id: <20230503152441.1141019-6-hch@lst.de>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 07ce8199960b6a..c2c36afb41955e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4315,7 +4315,6 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 	int locked_pages = 0;
 	int all_uptodate = 1;
 	int num_pages;
-	unsigned long num_reads = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_READ,
 		.mirror_num = mirror_num,
@@ -4361,10 +4360,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
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
@@ -4374,7 +4371,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, num_reads);
+	atomic_set(&eb->io_pages, num_pages);
 	/*
 	 * It is possible for release_folio to clear the TREE_REF bit before we
 	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
@@ -4384,13 +4381,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
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

