Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134963B138E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFWF6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:58:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41988 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhFWF6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:58:04 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A8BF21941
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zte+T6lWXLDCrBRpHBD3N+olXn7I2dy68NsLBa1clEo=;
        b=oQOyB720RilPFkDknRv03u4WfBuMeQJLAkVOtrn7HIRhR3AL1b8oyJVyJq5n90VP/6I9/W
        8EaPQ5JjMZsiQIKfARYxztjHHjCt3HXW7hol45/LDEHPEULFpoab9xMa8zrYWJg9s50Z4K
        D+vG2VBXXm8kbhdaqS/+O0U2xLaIlz4=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 4A2AAA3BB5
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:45 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 8/8] btrfs: only allow subpage compression if the range fully covers the first page
Date:   Wed, 23 Jun 2021 13:55:29 +0800
Message-Id: <20210623055529.166678-9-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs compressed write, we use a mechanism called async cow, which
unliek regular run_delalloc_cow() or cow_file_range(), it will also
unlock the first page.

This mechanism allows btrfs to continue handling next ranges, without
waiting for the time consuming compression.

But this has a problem for subpage case, as we could have the following
delalloc range for a page:

0		32K		64K
|	|///////|	|///////|
		\- A		\- B

In above case, if we pass both range to cow_file_range_async(), both
range A and range B will try to unlock the full page [0, 64K).

And which finishes later than the other range will try to do other page
operatioins like end_page_writeback() on a unlocked page, triggering VM
layer BUG_ON().

Currently I don't have any perfect solution to this, but two
workarounds:

- Only allow compression for fully page aligned range

  This is what I did in this patch.
  By this, the compressed range can exclusively lock the first page
  (and other pages), so they are completely safe to do whatever they
  want.
  The problem is, we will not compress a lot of small writes.
  This is especially problematic as our target page size is 64K, not
  a small size.

- Make cow_file_range_async() to behave like cow_file_range() for
  subpage

  This needs several behavier change, and are all subpage specific:
  * Skip the first page of the range when finished
    Just like cow_file_range()
  * Have a way to wait for the async_cow to finish before handling the
    next delalloc range

  The biggest problem here is the performance impact.
  Although by this we can compress all sector aligned ranges, we will
  waste time waiting for the async_cow to finish.
  This is completely denying the meaning of "async" part.
  Now to mention there are tons of code needs to be changed.

Thus I choose the current way to only compress ranges which is fully
page aligned.
The cost is we will skip a lot of small writes for 64K page size.

With this change, btrfs subpage can support compressed write now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 497c219758e0..be6d00d097d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -489,9 +489,6 @@ static noinline int add_async_extent(struct async_chunk *cow,
  */
 static inline bool inode_can_compress(struct btrfs_inode *inode)
 {
-	/* Subpage doesn't support compress yet */
-	if (inode->root->fs_info->sectorsize < PAGE_SIZE)
-		return false;
 	if (inode->flags & BTRFS_INODE_NODATACOW ||
 	    inode->flags & BTRFS_INODE_NODATASUM)
 		return false;
@@ -513,6 +510,29 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 			btrfs_ino(inode));
 		return 0;
 	}
+	/*
+	 * Special check for subpage.
+	 *
+	 * Due to page locking is still done in full page size for
+	 * btrfs_run_delalloc_range(), subpage compression can't allow two
+	 * delalloc range both start at the same page like the following case:
+	 *
+	 * 0		32K		64K
+	 * |	|///////|	|///////|
+	 * 		\- A		\- B
+	 *
+	 * In above case, both range A and range B will try to unlock the full
+	 * page [0, 64K), causing the one finished later will have page
+	 * unlocked already, triggering various page lock requirement BUG_ON()s.
+	 *
+	 * So here we add an artificial limit that subpage compression can only
+	 * happen if the range is fully page aligned.
+	 */
+	if (fs_info->sectorsize < PAGE_SIZE) {
+		if (!IS_ALIGNED(start, PAGE_SIZE) ||
+		    !IS_ALIGNED(end + 1, PAGE_SIZE))
+			return 0;
+	}
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
-- 
2.32.0

