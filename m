Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B73210DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBVGfD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:48662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhBVGfC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7VG85PunvCabKM/ek4kInj6TnCxrgu8jwummNcZ23X4=;
        b=lHSjcFI4mbWn3xBVLh1KS/r6i/lBqbFqrcIYe5RYQPUZpIFe5ZSWC4720qtvAiI4QsYz1G
        r7lADpOeA54CcH6ZpagXMg+cGpyNqqNEyNEorVz7w/VnxO1ieDRikK8NFfqVTOFogGDwOr
        T/RuejZGsJY43UkYeVZLxsZB/J+zGKY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EA6E0B11E
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/12] btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check on subpage metadata
Date:   Mon, 22 Feb 2021 14:33:48 +0800
Message-Id: <20210222063357.92930-4-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btree_set_page_dirty(), we should also check the extent buffer
sanity for subpage support.

Unlike the regular sector size case, since one page can contain multiple
extent buffers, we need to make sure there is at least one dirty extent
buffer in the page.

So this patch will iterate through the btrfs_subpage::dirty_bitmap
to get the extent buffers, and check if any dirty extent buffer in the page
range has EXTENT_BUFFER_DIRTY and proper refs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 47 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2576c5fe62e..437e6b2163c7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -42,6 +42,7 @@
 #include "discard.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "subpage.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -992,14 +993,48 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 static int btree_set_page_dirty(struct page *page)
 {
 #ifdef DEBUG
+	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct btrfs_subpage *subpage;
 	struct extent_buffer *eb;
+	int cur_bit;
+	u64 page_start = page_offset(page);
+
+	if (fs_info->sectorsize == PAGE_SIZE) {
+		BUG_ON(!PagePrivate(page));
+		eb = (struct extent_buffer *)page->private;
+		BUG_ON(!eb);
+		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+		BUG_ON(!atomic_read(&eb->refs));
+		btrfs_assert_tree_locked(eb);
+		return __set_page_dirty_nobuffers(page);
+	}
+	ASSERT(PagePrivate(page) && page->private);
+	subpage = (struct btrfs_subpage *)page->private;
+
+	ASSERT(subpage->dirty_bitmap);
+	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
+		unsigned long flags;
+		u64 cur;
+		u16 tmp = (1 << cur_bit);
+
+		spin_lock_irqsave(&subpage->lock, flags);
+		if (!(tmp & subpage->dirty_bitmap)) {
+			spin_unlock_irqrestore(&subpage->lock, flags);
+			cur_bit++;
+			continue;
+		}
+		spin_unlock_irqrestore(&subpage->lock, flags);
+		cur = page_start + cur_bit * fs_info->sectorsize;
 
-	BUG_ON(!PagePrivate(page));
-	eb = (struct extent_buffer *)page->private;
-	BUG_ON(!eb);
-	BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-	BUG_ON(!atomic_read(&eb->refs));
-	btrfs_assert_tree_locked(eb);
+		eb = find_extent_buffer(fs_info, cur);
+		ASSERT(eb);
+		ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+		ASSERT(atomic_read(&eb->refs));
+		btrfs_assert_tree_locked(eb);
+		free_extent_buffer(eb);
+
+		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits);
+	}
 #endif
 	return __set_page_dirty_nobuffers(page);
 }
-- 
2.30.0

