Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C08C2A4693
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgKCNcQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:45158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbgKCNcP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdGlFzzmGiRUNyLXqZHNFRYt6BtGGuysE+jzZGWlzLs=;
        b=nrnRzhgx4yBrBKd8XGwfSEXI5viWBx7DU1jq8T4OqFZkzdmuh2I4gGCX8lj5wsFeMH/sf3
        w1m7ca4yFTIbwDd+7y7MQ1tKUAC4DXfZC8GA6ou7gUuNPNqLRifsSOLcYzEWu/A9kKRv81
        2W6yRlVPYETTAU5BMHhSRqMudj+NpaY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BC14ABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/32] btrfs: disk-io: only clear EXTENT_LOCK bit for extent_invalidatepage()
Date:   Tue,  3 Nov 2020 21:30:56 +0800
Message-Id: <20201103133108.148112-21-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In extent_invalidatepage() it will try to clear all possible bits since
it's calling clear_extent_bit() with delete == 1.
That would try to clear all existing bits.

This is currently fine, since for btree io tree, it only utilizes
EXTENT_LOCK bit.
But this could be a problem for later subpage support, which will
utilize extra io tree bit to represent extra info.

This patch will just convert that clear_extent_bit() to
unlock_extent_cached().

For current code since only EXTENT_LOCKED bit is utilized, this doesn't
change the behavior, but provides a much cleaner basis for incoming
subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c7adcd99451a..b770ac039b96 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4459,14 +4459,22 @@ int extent_invalidatepage(struct extent_io_tree *tree,
 	u64 end = start + PAGE_SIZE - 1;
 	size_t blocksize = page->mapping->host->i_sb->s_blocksize;
 
+	/* This function is only called for btree */
+	ASSERT(tree->owner == IO_TREE_BTREE_INODE_IO);
+
 	start += ALIGN(offset, blocksize);
 	if (start > end)
 		return 0;
 
 	lock_extent_bits(tree, start, end, &cached_state);
 	wait_on_page_writeback(page);
-	clear_extent_bit(tree, start, end, EXTENT_LOCKED | EXTENT_DELALLOC |
-			 EXTENT_DO_ACCOUNTING, 1, 1, &cached_state);
+
+	/*
+	 * Currently for btree io tree, only EXTENT_LOCKED is utilized,
+	 * so here we only need to unlock the extent range to free any
+	 * existing extent state.
+	 */
+	unlock_extent_cached(tree, start, end, &cached_state);
 	return 0;
 }
 
-- 
2.29.2

