Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0933D145D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbfJIQoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 12:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbfJIQoC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 12:44:02 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6CD206BB
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2019 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570639441;
        bh=7yDuSgFw56bj5l3Ep2A4zgGcqqGgBxVs1K4XpTHzQBQ=;
        h=From:To:Subject:Date:From;
        b=edIMQkokAkklU25mQLljxLiMDExgXcJ3mEqFBIjK0JbXTZWPXqinPsBp3Z8Bg+B2K
         l/QHgivfbSDpfqPnlq05p00eo7fNN8DkhWMhyAHMIfeOcEk99lncriuItW7ey86Sc6
         HkwGWDqGkGSYxExGs1hNwuJEYLUrmI9PGA8d1HvA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix metadata space leak on fixup worker failure to set range as delalloc
Date:   Wed,  9 Oct 2019 17:43:59 +0100
Message-Id: <20191009164359.29642-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In the fixup worker, if we fail to mark the range as delalloc in the io
tree, we must release the previously reserved metadata, as well as update
the outstanding extents counter for the inode, otherwise we leak metadata
space.

In pratice we can't return an error from btrfs_set_extent_delalloc(),
which is just a wrapper around __set_extent_bit(), as for most errors
__set_extent_bit() does a BUG_ON() (or panics which hits a BUG_ON() as
well) and returning an -EEXIST error doesn't happen in this case since
the exclusive bits parameter always has a value of 0 through this code
path. Nevertheless, just fix the error handling in the fixup worker,
in case one day __set_extent_bit() can return an error to this code
path.

Fixes: f3038ee3a3f101 ("btrfs: Handle btrfs_set_extent_delalloc failure in fixup worker")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f2754eaa05b..f23b14ec743a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2201,12 +2201,16 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 		mapping_set_error(page->mapping, ret);
 		end_extent_writepage(page, ret, page_start, page_end);
 		ClearPageChecked(page);
-		goto out;
+		goto out_reserved;
 	}
 
 	ClearPageChecked(page);
 	set_page_dirty(page);
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, false);
+out_reserved:
+	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, ret != 0);
+	if (ret)
+		btrfs_delalloc_release_space(inode, data_reserved, page_start,
+					     PAGE_SIZE, true);
 out:
 	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
 			     &cached_state);
-- 
2.11.0

