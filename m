Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E8636016F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhDOFGR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:38270 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhDOFGQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QBwbLoB+hjoE03XyY0Y8CbQunWyvkpEUrx+wx2Q32GI=;
        b=m9hS4Bbx28Uv9MIUIrf2PEheBMYchEomgqE7oSxTP7swLoFvEoEtM5TCziVRblR1KZTOoY
        T62WPmrPsHGZdFzCre9u46e3W5fL+XsNTp8ZQpWemP3hSJzSeAYsAU2wDnBrvIdY1v9/pB
        9WUQ0S0qWEPoQUzdiTf9NPdrQSswIek=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1B0FAF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:05:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 32/42] btrfs: fix the filemap_range_has_page() call in btrfs_punch_hole_lock_range()
Date:   Thu, 15 Apr 2021 13:04:38 +0800
Message-Id: <20210415050448.267306-33-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
With current subpage RW support, the following script can hang the fs on
with 64K page size.

 # mkfs.btrfs -f -s 4k $dev
 # mount $dev -o nospace_cache $mnt
 # fsstress -w -n 50 -p 1 -s 1607749395 -d $mnt

The kernel will do an infinite loop in btrfs_punch_hole_lock_range().

[CAUSE]
In btrfs_punch_hole_lock_range() we:
- Truncate page cache range
- Lock extent io tree
- Wait any ordered extents in the range.

We exit the loop until we meet all the following conditions:
- No ordered extent in the lock range
- No page is in the lock range

The latter condition has a pitfall, it only works for sector size ==
PAGE_SIZE case.

While can't handle the following subpage case:

  0       32K     64K     96K     128K
  |       |///////||//////|       ||

lockstart=32K
lockend=96K - 1

In this case, although the range cross 2 pages,
truncate_pagecache_range() will invalidate no page at all, but only zero
the [32K, 96K) range of the two pages.

Thus filemap_range_has_page(32K, 96K-1) will always return true, thus we
will never meet the loop exit condition.

[FIX]
Fix the problem by doing page alignment for the lock range.

Function filemap_range_has_page() has already handled lend < lstart
case, we only need to round up @lockstart, and round_down @lockend for
truncate_pagecache_range().

This modification should not change any thing for sector size ==
PAGE_SIZE case, as in that case our range is already page aligned.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8f71699fdd18..45ec3f5ef839 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2471,6 +2471,16 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 				       const u64 lockend,
 				       struct extent_state **cached_state)
 {
+	/*
+	 * For subpage case, if the range is not at page boundary, we could
+	 * have pages at the leading/tailing part of the range.
+	 * This could lead to dead loop since filemap_range_has_page()
+	 * will always return true.
+	 * So here we need to do extra page alignment for
+	 * filemap_range_has_page().
+	 */
+	u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
+	u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 		int ret;
@@ -2491,7 +2501,7 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 		    (ordered->file_offset + ordered->num_bytes <= lockstart ||
 		     ordered->file_offset > lockend)) &&
 		     !filemap_range_has_page(inode->i_mapping,
-					     lockstart, lockend)) {
+					     page_lockstart, page_lockend)) {
 			if (ordered)
 				btrfs_put_ordered_extent(ordered);
 			break;
-- 
2.31.1

