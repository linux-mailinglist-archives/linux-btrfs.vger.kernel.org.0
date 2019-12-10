Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB50119F08
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 00:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLJXCZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 18:02:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726801AbfLJXCX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 18:02:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AAECAE2D;
        Tue, 10 Dec 2019 23:02:20 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz, jthumshirn@suse.de,
        linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/8] btrfs: Wait for extent bits to release page
Date:   Tue, 10 Dec 2019 17:01:53 -0600
Message-Id: <20191210230155.22688-7-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210230155.22688-1-rgoldwyn@suse.de>
References: <20191210230155.22688-1-rgoldwyn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While trying to release a page, the extent containing the page may be locked
which would stop the page from being released. Wait for the
extent lock to be cleared, if blocking is allowed and then clear
the bits.

While we are at it, clean the code of try_release_extent_state() to make
it simpler.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++---------------------
 fs/btrfs/extent_io.h |  2 +-
 fs/btrfs/inode.c     |  4 ++--
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eb8bd0258360..193785981183 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4360,33 +4360,28 @@ int extent_invalidatepage(struct extent_io_tree *tree,
  * are locked or under IO and drops the related state bits if it is safe
  * to drop the page.
  */
-static int try_release_extent_state(struct extent_io_tree *tree,
+static bool try_release_extent_state(struct extent_io_tree *tree,
 				    struct page *page, gfp_t mask)
 {
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	int ret = 1;
 
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
-		ret = 0;
-	} else {
-		/*
-		 * at this point we can safely clear everything except the
-		 * locked bit and the nodatasum bit
-		 */
-		ret = __clear_extent_bit(tree, start, end,
-				 ~(EXTENT_LOCKED | EXTENT_NODATASUM),
-				 0, 0, NULL, mask, NULL);
-
-		/* if clear_extent_bit failed for enomem reasons,
-		 * we can't allow the release to continue.
-		 */
-		if (ret < 0)
-			ret = 0;
-		else
-			ret = 1;
+		if (!gfpflags_allow_blocking(mask))
+			return false;
+		wait_extent_bit(tree, start, end, EXTENT_LOCKED);
 	}
-	return ret;
+	/*
+	 * At this point we can safely clear everything except the locked and
+	 * nodatasum bits. If clear_extent_bit failed due to -ENOMEM,
+	 * don't allow release.
+	 */
+	if (__clear_extent_bit(tree, start, end,
+				~(EXTENT_LOCKED | EXTENT_NODATASUM), 0, 0,
+				NULL, mask, NULL) < 0)
+		return false;
+
+	return true;
 }
 
 /*
@@ -4394,7 +4389,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
  * in the range corresponding to the page, both state records and extent
  * map records are removed
  */
-int try_release_extent_mapping(struct page *page, gfp_t mask)
+bool try_release_extent_mapping(struct page *page, gfp_t mask)
 {
 	struct extent_map *em;
 	u64 start = page_offset(page);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a8551a1f56e2..89cc0cf8a7fd 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -188,7 +188,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 					  u64 start, u64 len,
 					  int create);
 
-int try_release_extent_mapping(struct page *page, gfp_t mask);
+bool try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
 int extent_read_full_page(struct extent_io_tree *tree, struct page *page,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 86730f2f2bf6..88f2a7229459 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8811,8 +8811,8 @@ btrfs_readpages(struct file *file, struct address_space *mapping,
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 {
-	int ret = try_release_extent_mapping(page, gfp_flags);
-	if (ret == 1) {
+	bool ret = try_release_extent_mapping(page, gfp_flags);
+	if (ret) {
 		ClearPagePrivate(page);
 		set_page_private(page, 0);
 		put_page(page);
-- 
2.16.4

