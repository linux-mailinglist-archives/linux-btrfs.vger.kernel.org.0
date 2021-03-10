Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8133385A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 10:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbhCJJJW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 04:09:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:34734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232505AbhCJJIw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 04:08:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615367331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzxMqy+Nei7VlaAFJir8fQ5kLHr2zpyf64TMva+gS5E=;
        b=X/8SlzcmIB7czenC4YKk13Nq9H4U+Ga8heaZdQrYDLSMmT/q107hKbyzihEb0UfNil05l6
        M54W1/RKpFeJUV3vrYfsi9ehvY2kZCw0IqbfhLfhzNhPd7zhhGMpasXXqvI7O3rv56TNAG
        MJybZgE8/o+SOpDy+RBf4cXTvQA22Aw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD372AD74
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Mar 2021 09:08:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/15] btrfs: allow btree_set_page_dirty() to do more sanity check on subpage metadata
Date:   Wed, 10 Mar 2021 17:08:24 +0800
Message-Id: <20210310090833.105015-7-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210310090833.105015-1-wqu@suse.com>
References: <20210310090833.105015-1-wqu@suse.com>
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
index 41b718cfea40..d53df276923e 100644
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
+	int cur_bit = 0;
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
2.30.1

