Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017272DCBCD
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 05:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLQE6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 23:58:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:56190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgLQE6l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 23:58:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608181075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ia5PXlqVLU5AyUVvJGpdAyYrWbkI4eRL8RjRhrTE+xw=;
        b=HL0TA7i+f2Yxy+ZvEr5Hu31CHmSf4V5P4Kt4Fraqziuq4pIsfZO5BdmisZO2/jwadAHtEW
        u/ph/dm3HfWWMHVkLlVVgoQyuj3fUJQyuNF5c182xY21V7s4wfT9lR+s1zuSc2oO/S8Vis
        y/hHQ06YjQY1phD0kPASxLUqg6oRRug=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F551ACF9
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 04:57:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: inode: move the timing of TestClearPagePrivate() in btrfs_invalidatepage()
Date:   Thu, 17 Dec 2020 12:57:36 +0800
Message-Id: <20201217045737.48100-4-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217045737.48100-1-wqu@suse.com>
References: <20201217045737.48100-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For current sectorsize == PAGE_ZIE case, there will only be at most one
ordered extent for one page.

But for subpage case, one page can contain several ordered extents, thus
current TestClearPagePrivate2() call will only finish ordered IO for the
first ordered extent, the remaining ones will be skipped, and cause
never-end ordered io.

This patch will move the TestClearPagePrivate2 before the loop, and save
the result, so that we can finish all ordered extents.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4d36d138008..eb493fbb65f9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8178,6 +8178,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	u64 start;
 	u64 end;
 	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	bool cleared_private2;
 	bool found_ordered = false;
 	bool completed_ordered = false;
 
@@ -8197,6 +8198,8 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 
 	if (!inode_evicting)
 		lock_extent_bits(tree, page_start, page_end, &cached_state);
+
+	cleared_private2 = TestClearPagePrivate2(page);
 again:
 	start = page_start;
 	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
@@ -8214,11 +8217,12 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 					 EXTENT_DELALLOC |
 					 EXTENT_LOCKED | EXTENT_DO_ACCOUNTING |
 					 EXTENT_DEFRAG, 1, 0, &cached_state);
+
 		/*
 		 * whoever cleared the private bit is responsible
 		 * for the finish_ordered_io
 		 */
-		if (TestClearPagePrivate2(page)) {
+		if (cleared_private2) {
 			spin_lock_irq(&ordered_tree->lock);
 			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
 			ordered->truncated_len = min(ordered->truncated_len,
@@ -8233,6 +8237,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 				completed_ordered = true;
 			}
 		}
+
 		btrfs_put_ordered_extent(ordered);
 		if (!inode_evicting) {
 			cached_state = NULL;
-- 
2.29.2

