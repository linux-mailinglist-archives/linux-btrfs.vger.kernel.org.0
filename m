Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4491938BFD1
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhEUGof (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233126AbhEUGoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wgfYSTk2/YHgwwGTP2QulYQgNhi2O01PKfNWXU3VuTI=;
        b=B4em99QITkqjI8n07zspsgotVuiKZu8btSScdy7r7EyRrWdpkLagzUpZSpJ1IFf2lxzY5n
        QrLm1I+8y55tmAVJzYd/GtpWEyfUpmNZfelPPDUrZNuSzM/fajAnUKtmwLz9g8iIX6sKaX
        PUWmueavTKa8QcKRHxL+5O5U5UZg7Hc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8F00AE22
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:41:26 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 18/31] btrfs: fix the filemap_range_has_page() call in btrfs_punch_hole_lock_range()
Date:   Fri, 21 May 2021 14:40:37 +0800
Message-Id: <20210521064050.191164-19-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
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
index 4a89697ae3a7..6ef44afa939c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2486,6 +2486,16 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
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
@@ -2506,7 +2516,7 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
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

