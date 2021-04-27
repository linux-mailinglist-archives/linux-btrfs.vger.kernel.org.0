Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B71B36CF31
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239211AbhD0XFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:37416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239462AbhD0XFu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lVoLPqh9YwCDlgVPtz6O4BFk+9ts5xRusDy+q7zsCrQ=;
        b=VD/oStMU1afJvpHH8BsPb6g3xxML+IrUyqI3sZTH4N1fJJNZKSm3AFaSoRf2HlAjGPMrFd
        KHY1TfyG2NNGSHjU5Vy3TS13zWEXZ4S9T1HSuig8VrJwdU6+LoaZstpqMovCaZqONeJekj
        dliPWTF2MfIW4brDezWPo2gdiXeCVZg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED597AC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:05:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 32/42] btrfs: don't clear page extent mapped if we're not invalidating the full page
Date:   Wed, 28 Apr 2021 07:03:39 +0800
Message-Id: <20210427230349.369603-33-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
index b8cf9709b225..fd648f2c0242 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8330,7 +8330,19 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
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

