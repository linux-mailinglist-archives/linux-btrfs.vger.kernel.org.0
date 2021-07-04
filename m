Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF9B3BB3C1
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 01:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhGDXS4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 19:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234136AbhGDXOz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 4 Jul 2021 19:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3B2E6195B;
        Sun,  4 Jul 2021 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440280;
        bh=7fSbhU9mpJ0yzDKgtnC6XStzEKHdFyjdlDk/hVvDwmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9IfalN7CVwwUvdKRRetckCH4kL1a/0+28ttFL9GE2MdeXMsxlFY/KkE0lIrSzL0f
         NjydewTJxa7V3p77iKbaJ0tXnONF1sHPySImLYMzJVYqBzTjbxLMus+ewq6pXRnGkb
         bgzUMo8IjVZHSgVogS+GyxiqBxGv2W1UPwTJXXOk6xE+Zdis5MlXM+tXAHpdwPeZjj
         71AYXdZSv8jZWQLrOlBj7GOAGGZ0FegsFtdR7M5pOpCcIOISm2k72QwBIVVENt95iI
         ObnbRmq0uCMyXN9yGO0jC2jN63RWFFL31ErVnN9WbfG72RXng4ItBPShq60xOJ0pPo
         1Cz8h6/0N5NDA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Ritesh Harjani <riteshh@linux.ibm.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/31] btrfs: fix the filemap_range_has_page() call in btrfs_punch_hole_lock_range()
Date:   Sun,  4 Jul 2021 19:10:41 -0400
Message-Id: <20210704231043.1491209-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704231043.1491209-1-sashal@kernel.org>
References: <20210704231043.1491209-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 0528476b6ac7832f31e2ed740a57ae31316b124e ]

[BUG]
With current subpage RW support, the following script can hang the fs
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

In this case, although the range crosses 2 pages,
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

Tested-by: Ritesh Harjani <riteshh@linux.ibm.com> # [ppc64]
Tested-by: Anand Jain <anand.jain@oracle.com> # [aarch64]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 41ad37f8062a..cfbe2961bd1d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2444,6 +2444,17 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
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
+	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
+	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE) - 1;
+
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 		int ret;
@@ -2463,7 +2474,7 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 		    (ordered->file_offset + ordered->len <= lockstart ||
 		     ordered->file_offset > lockend)) &&
 		     !filemap_range_has_page(inode->i_mapping,
-					     lockstart, lockend)) {
+					     page_lockstart, page_lockend)) {
 			if (ordered)
 				btrfs_put_ordered_extent(ordered);
 			break;
-- 
2.30.2

