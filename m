Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A4F29485E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440870AbgJUG23 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440869AbgJUG22 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgqFXSV+EQG9z7Dz/N0MFyo/ikf3WEwRtGSfAt4G7i8=;
        b=Yhbhhq/rueRU/OkVcO80MvCMlHuV953eHjeI6Vjbet33J8bYznJMIFYhNBxtSL1nioWfPW
        Po/JlgnURTlnSktzC2f/PKveDvsEYrc64QpP4xLQp8OYnyZnVHGCvtq9ZxxncdlKYtq6Ge
        D9nN8Ct5jJbYqi4ae/ArOe18ULcFsCU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C3EFAC8C
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 66/68] btrfs: inode: only do NOCOW write for page aligned extent
Date:   Wed, 21 Oct 2020 14:25:52 +0800
Message-Id: <20201021062554.68132-67-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Another workaround for the inability to submit real subpage sized write bio.

For NOCOW, if a range ends at sector boundary but no page boundary, we
can't submit a subpage NOCOW write bio.
To workaround this, we skip any extent which is not page aligned, and
fall back to COW.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 625950258c87..c3d32f4858d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1451,6 +1451,12 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
  *
  * If no cow copies or snapshots exist, we write directly to the existing
  * blocks on disk
+ * the full page. Or we fall back to COW, as we don't yet support subpage
+ * write.
+ *
+ * For subpage case, since we can't submit subpage data write yet, we have
+ * more restrict condition for NOCOW (the extent must contain the full page).
+ * Or we fall back to COW the full page.
  */
 static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				       struct page *locked_page,
@@ -1592,6 +1598,20 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			    btrfs_file_extent_encryption(leaf, fi) ||
 			    btrfs_file_extent_other_encoding(leaf, fi))
 				goto out_check;
+			/*
+			 * If the file offset/extent offset/extent end is not
+			 * page aligned, we skip it and fallback to COW.
+			 * This is mostly overkilled, but to make subpage NOCOW
+			 * write easier, we only allow write into page aligned
+			 * extent.
+			 *
+			 * TODO: Remove this when full subpage write is
+			 * supported.
+			 */
+			if (!IS_ALIGNED(found_key.offset, PAGE_SIZE) ||
+			    !IS_ALIGNED(extent_end, PAGE_SIZE) ||
+			    !IS_ALIGNED(extent_offset, PAGE_SIZE))
+				goto out_check;
 			/*
 			 * If extent is created before the last volume's snapshot
 			 * this implies the extent is shared, hence we can't do
@@ -1676,8 +1696,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 */
 		if (!nocow) {
 			if (cow_start == (u64)-1)
-				cow_start = cur_offset;
-			cur_offset = extent_end;
+				cow_start = round_down(cur_offset, PAGE_SIZE);
+			cur_offset = round_up(extent_end, PAGE_SIZE);
 			if (cur_offset > end)
 				break;
 			path->slots[0]++;
@@ -1692,6 +1712,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		 * NOCOW, following one which needs to be COW'ed
 		 */
 		if (cow_start != (u64)-1) {
+			ASSERT(IS_ALIGNED(cow_start, PAGE_SIZE));
 			ret = fallback_to_cow(inode, locked_page,
 					      cow_start, found_key.offset - 1,
 					      page_started, nr_written);
@@ -1700,6 +1721,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			cow_start = (u64)-1;
 		}
 
+		ASSERT(IS_ALIGNED(cur_offset, PAGE_SIZE) &&
+		       IS_ALIGNED(num_bytes, PAGE_SIZE) &&
+		       IS_ALIGNED(found_key.offset, PAGE_SIZE));
 		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
 			u64 orig_start = found_key.offset - extent_offset;
 			struct extent_map *em;
@@ -1774,7 +1798,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		cow_start = cur_offset;
 
 	if (cow_start != (u64)-1) {
-		cur_offset = end;
+		cur_offset = round_up(end, PAGE_SIZE) - 1;
 		ret = fallback_to_cow(inode, locked_page, cow_start, end,
 				      page_started, nr_written);
 		if (ret)
-- 
2.28.0

