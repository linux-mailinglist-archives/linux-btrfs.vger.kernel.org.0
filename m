Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82438BFDA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhEUGoz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233651AbhEUGoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFDZa95E5N4vSGBOtLPmqCESeN/Vw++PjBgEYXF2Jms=;
        b=seP1kXam/MAR7KCna2IISsaNt775Dm1+c7Xv87y2qsAbrcF5SXeQvgkNQygw3j1HgKVxEZ
        sKeo0wJKg17yzMQeXp7Dl3nZZJ7oAAvZH+xpk6RQeJ99xSAGE6Qli/oXnG7iVWWgedFoM5
        jSKljhLOLMcRqyZi5lDliBwJn/Ld9IA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D723AE4B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:41:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 19/31] btrfs: don't clear page extent mapped if we're not invalidating the full page
Date:   Fri, 21 May 2021 14:40:38 +0800
Message-Id: <20210521064050.191164-20-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With current btrfs subpage rw support, the following script can lead to
fs hang:

  mkfs.btrfs -f -s 4k $dev
  mount $dev -o nospace_cache $mnt

  fsstress -w -n 100 -p 1 -s 1608140256 -v -d $mnt

The fs will hang at btrfs_start_ordered_extent().

[CAUSE]
In above test case, btrfs_invalidate() will be called with the following
parameters:
  offset = 0 length = 53248 page dirty = 1 subpage dirty bitmap = 0x2000

Since @offset is 0, btrfs_invalidate() will try to invalidate the full
page, and finally call clear_page_extent_mapped() which will detach
btrfs subpage structure from the page.

And since the page no longer has btrfs subpage structure, the subpage
dirty bitmap will be cleared, preventing the dirty range from
written back, thus no way to wake up the ordered extent.

[FIX]
Just follow other fses, only to invalidate the page if the range covers
the full page.

There are cases like truncate_setsize() which can call
btrfs_invalidatepage() with offset == 0 and length != 0 for the last
page of an inode.

Although the old code will still try to invalidate the full page, we are
still safe to just wait for ordered extent to finish.
So it shouldn't cause extra problems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39049a614b7c..f82055ba09c8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8351,7 +8351,19 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 	 */
 	wait_on_page_writeback(page);
 
-	if (offset) {
+	/*
+	 * For subpage case, we have call sites like
+	 * btrfs_punch_hole_lock_range() which passes range not aligned to
+	 * sectorsize.
+	 * If the range doesn't cover the full page, we don't need to and
+	 * shouldn't clear page extent mapped, as page->private can still
+	 * record subpage dirty bits for other part of the range.
+	 *
+	 * For cases where can invalidate the full even the range doesn't
+	 * cover the full page, like invalidating the last page, we're
+	 * still safe to wait for ordered extent to finish.
+	 */
+	if (!(offset == 0 && length == PAGE_SIZE)) {
 		btrfs_releasepage(page, GFP_NOFS);
 		return;
 	}
-- 
2.31.1

