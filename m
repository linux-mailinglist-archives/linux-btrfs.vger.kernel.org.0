Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE629483F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440801AbgJUG1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440798AbgJUG1Q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntl2tibyHsHwynEGHyQmLvgX3LrTBVLXGip2iIzJ3FI=;
        b=SMH8JlHh+nw13nBtkuURuqUsZyDZKrEbyBIkW7FheUAewFWFkOiJ/0QvyVcnGFCnJmP2dW
        v4D2BLwj9al+8HdbQK6fs3h8q8yGcZxDnRcPHZB5hyluN/eDZT9IuDkKBSef4IcKFSaMV+
        i5q2546zePX/x6kKclEQxjlY6vUHu5M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1630AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 35/68] btrfs: extent_io: make set/clear_extent_buffer_uptodate() to support subpage size
Date:   Wed, 21 Oct 2020 14:25:21 +0800
Message-Id: <20201021062554.68132-36-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index d899a75db977..1e959e6e8ce8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5631,10 +5631,18 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
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
@@ -5646,10 +5654,26 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
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

