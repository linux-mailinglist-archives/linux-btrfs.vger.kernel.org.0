Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A9360162
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhDOFFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:05:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbhDOFFv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:05:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLFZnQmKvx2zdlrRfBQsVZYM5Sic18ZSxonVq3dfiE0=;
        b=aENjzdrwfifBEbEZtKZJuwJ0n7N9BmZsYmi0e5PEToQZ6wnEbawMHe6WwVJSbIdKSdmhE+
        UQDXHXqOLMkN6bLTw6ROH4O2jEZ6gcOiMSEprXRzkVkIzgbWHVXa/Fe6PHxlqU3e/yPBID
        MLfDgW6YixPVrR0qtsgI1xUYH92FI8A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1EC0AF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/42] btrfs: make __process_pages_contig() to handle subpage dirty/error/writeback status
Date:   Thu, 15 Apr 2021 13:04:25 +0800
Message-Id: <20210415050448.267306-20-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For __process_pages_contig() and process_one_page(), to handle subpage
we only need to pass bytenr in and call subpage helpers to handle
dirty/error/writeback status.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 94f8b3ffe6a7..f40e229960d7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1813,10 +1813,16 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
  * Return -EGAIN if the we need to try again.
  * (For PAGE_LOCK case but got dirty page or page not belong to mapping)
  */
-static int process_one_page(struct address_space *mapping,
+static int process_one_page(struct btrfs_fs_info *fs_info,
+			    struct address_space *mapping,
 			    struct page *page, struct page *locked_page,
-			    unsigned long page_ops)
+			    unsigned long page_ops, u64 start, u64 end)
 {
+	u32 len;
+
+	ASSERT(end + 1 - start != 0 && end + 1 - start < U32_MAX);
+	len = end + 1 - start;
+
 	if (page_ops & PAGE_SET_ORDERED)
 		SetPageOrdered(page);
 
@@ -1824,13 +1830,13 @@ static int process_one_page(struct address_space *mapping,
 		return 1;
 
 	if (page_ops & PAGE_SET_ERROR)
-		SetPageError(page);
+		btrfs_page_clamp_set_error(fs_info, page, start, len);
 	if (page_ops & PAGE_START_WRITEBACK) {
-		clear_page_dirty_for_io(page);
-		set_page_writeback(page);
+		btrfs_page_clamp_clear_dirty(fs_info, page, start, len);
+		btrfs_page_clamp_set_writeback(fs_info, page, start, len);
 	}
 	if (page_ops & PAGE_END_WRITEBACK)
-		end_page_writeback(page);
+		btrfs_page_clamp_clear_writeback(fs_info, page, start, len);
 	if (page_ops & PAGE_LOCK) {
 		lock_page(page);
 		if (!PageDirty(page) || page->mapping != mapping) {
@@ -1848,6 +1854,7 @@ static int __process_pages_contig(struct address_space *mapping,
 				  u64 start, u64 end, unsigned long page_ops,
 				  u64 *processed_end)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
@@ -1884,8 +1891,9 @@ static int __process_pages_contig(struct address_space *mapping,
 		for (i = 0; i < found_pages; i++) {
 			int process_ret;
 
-			process_ret = process_one_page(mapping, pages[i],
-					locked_page, page_ops);
+			process_ret = process_one_page(fs_info, mapping,
+					pages[i], locked_page, page_ops,
+					start, end);
 			if (process_ret < 0) {
 				for (; i < found_pages; i++)
 					put_page(pages[i]);
-- 
2.31.1

