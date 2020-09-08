Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E89260C6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIHHwt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:52:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:50930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgIHHws (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:52:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 635C3AE24
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:52:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/17] btrfs: calculate inline extent buffer page size based on page size
Date:   Tue,  8 Sep 2020 15:52:15 +0800
Message-Id: <20200908075230.86856-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs only support 64K as max node size, thus for 4K page system, we
would have at most 16 pages for one extent buffer.

But for 64K system, we only need and always need one page for extent
buffer.
This stays true even for future subpage sized sector size support (as
long as extent buffer doesn't cross 64K boundary).

So this patch will change how INLINE_EXTENT_BUFFER_PAGES is calculated.

Instead of using fixed 16 pages, use (64K / PAGE_SIZE) as the result.
This should save some bytes for extent buffer structure for 64K
systems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 00a88f2eb5ab..e16c5449ba48 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -86,8 +86,8 @@ struct extent_io_ops {
 };
 
 
-#define INLINE_EXTENT_BUFFER_PAGES 16
-#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
+#define MAX_INLINE_EXTENT_BUFFER_SIZE 	SZ_64K
+#define INLINE_EXTENT_BUFFER_PAGES 	(MAX_INLINE_EXTENT_BUFFER_SIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
 	unsigned long len;
@@ -227,8 +227,15 @@ void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
 
 static inline int num_extent_pages(const struct extent_buffer *eb)
 {
-	return (round_up(eb->start + eb->len, PAGE_SIZE) >> PAGE_SHIFT) -
-	       (eb->start >> PAGE_SHIFT);
+	/*
+	 * For sectorsize == PAGE_SIZE case, since eb is always aligned to
+	 * sectorsize, it's just (eb->len / PAGE_SIZE) >> PAGE_SHIFT.
+	 *
+	 * For sectorsize < PAGE_SIZE case, we only want to support 64K
+	 * PAGE_SIZE, and ensured all tree blocks won't cross page boundary.
+	 * So in that case we always got 1 page.
+	 */
+	return (round_up(eb->len, PAGE_SIZE) >> PAGE_SHIFT);
 }
 
 static inline int extent_buffer_uptodate(const struct extent_buffer *eb)
-- 
2.28.0

