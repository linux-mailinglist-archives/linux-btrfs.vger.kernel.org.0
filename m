Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EE530535F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 07:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhA0GlX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 01:41:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:60438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232708AbhA0Gjn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 01:39:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611729532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tirEh04tRpabIhedEe8PFoMCQgQ63/JdEXRlq1nZMmc=;
        b=qZBukx5U8FGBvMQw43C3YROMFqlQAlUzE5zuDGXtI7Cc3T2hVgdizfE6e4b7G7BH8YKxad
        nQ4Ifbf9PthTldm8zxMVqfeHjrQn4vPZcnoHTjv5umyjldYDVwIzB/hpJTSr/L/oGWfBw9
        pOangCAqd9wazYlam1lk4EOLGnHy90A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 182F1ABD6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 06:38:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix a bug that btrfs_invalidapge() can double account ordered extent for subpage
Date:   Wed, 27 Jan 2021 14:38:48 +0800
Message-Id: <20210127063848.72528-1-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit dbfdb6d1b369 ("Btrfs: Search for all ordered extents that could
span across a page") make btrfs_invalidapage() to search all ordered
extents.

The offending code looks like this:

again:
	start = page_start;
	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
	if (ordred) {
		end = min(page_end,
			  ordered->file_offset + ordered->num_bytes - 1);

		/* Do the cleanup */

		start = end + 1;
		if (start < page_end)
			goto again;
	}

The behavior is indeed necessary for the incoming subpage support, but
when it iterate through all the ordered extents, it also resets the
search range @start.

This means, for the following cases, we can double account the ordered
extents, causing its bytes_left underflow:

	Page offset
	0		16K		32K
	|<--- OE 1  --->|<--- OE 2 ---->|

As the first iteration will find OE 1, which doesn't cover the full
page, thus after cleanup code, we need to retry again.
But again label will reset start to page_start, and we got OE 1 again,
which causes double account on OE1, and cause OE1's byte_left to
underflow.

The only good news is, this problem can only happen for subpage case, as
for regular sectorsize == PAGE_SIZE case, we will always find a OE ends
at or after page end, thus no way to trigger the problem.

This patch will move the again label after start = page_start, to fix
the bug.
This is just a quick fix, which is easy to backport.

There will be more comprehensive rework to convert the open coded loop to
a proper while loop.

Fixes: dbfdb6d1b369 ("Btrfs: Search for all ordered extents that could span across a page")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ef6cb7b620d0..2eea7d22405a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8184,8 +8184,9 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
 
 	if (!inode_evicting)
 		lock_extent_bits(tree, page_start, page_end, &cached_state);
-again:
+
 	start = page_start;
+again:
 	ordered = btrfs_lookup_ordered_range(inode, start, page_end - start + 1);
 	if (ordered) {
 		found_ordered = true;
-- 
2.30.0

