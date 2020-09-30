Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0731A27DE1A
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgI3B44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbgI3B4z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OJbPtFjlYngo9brT9t/2Ci+mNTwxpkoETnmOgFwfpnw=;
        b=tDv3QbH2AAK64pqnG6R4lei7hzv1PMCmUUmMSRUiL0ZS8V5e0ZIPI9NskvFglOGjuUvdZI
        RDFmAhbQDsdNG2PVWEsgqLHGWLjLDVX+GalsdptprK+GUPlADNMhRlNE1JZE5v3Xd9R8j3
        Rt8/TjlW3Eu8Yqhrn3dv0FNP6mA+WT4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22ECEAF95
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:56:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 33/49] btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support subpage size
Date:   Wed, 30 Sep 2020 09:55:23 +0800
Message-Id: <20200930015539.48867-34-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For those two functions, to support subpage size they just need the
follow work:
- set/clear the EXTENT_UPTODATE bits for io_tree
- set page Uptodate if the full range of the page is uptodate

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dbc0b79c4ce..c9bbb91c6155 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5602,10 +5602,18 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	int i;
-	struct page *page;
+	struct page *page = eb->pages[0];
 	int num_pages;
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+
+	if (btrfs_is_subpage(eb->fs_info) && page->mapping) {
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+
+		clear_extent_uptodate(io_tree, eb->start,
+				      eb->start + eb->len - 1, NULL);
+	}
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
@@ -5617,10 +5625,26 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 void set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	int i;
-	struct page *page;
+	struct page *page = eb->pages[0];
 	int num_pages;
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+
+	if (btrfs_is_subpage(eb->fs_info) && page->mapping) {
+		struct extent_state *cached = NULL;
+		struct extent_io_tree *io_tree =
+			info_to_btree_io_tree(eb->fs_info);
+		u64 page_start = page_offset(page);
+		u64 page_end = page_offset(page) + PAGE_SIZE - 1;
+
+		set_extent_uptodate(io_tree, eb->start, eb->start + eb->len - 1,
+				    &cached, GFP_NOFS);
+		if (test_range_bit(io_tree, page_start, page_end,
+				   EXTENT_UPTODATE, 1, cached))
+			SetPageUptodate(page);
+		free_extent_state(cached);
+		return;
+	}
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-- 
2.28.0

