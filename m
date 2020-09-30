Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2850C27DE20
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgI3B5I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:57:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729951AbgI3B5H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:57:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601431025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKkd+KETE8Sz7Lnxy1dsr2hi1Yf9mWbl/e0tAEn4UW4=;
        b=ev9DbcwnICRrDetgFI3/ig3pGSjXA+f33qJxbdFUZINL4RKHwPcukYotEeKJarNLumjFtu
        sYezR3F2nc+iiSD36zBAMJytu30QV9/0dUNes38CKneNdiw7tV+xhGSGIJ0Pu1GUvgXkyY
        0vf2aiTKhPJBOdy76BfCfHM6FgZDZys=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6DA18AFAB
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 01:57:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 39/49] btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check on subpage metadata
Date:   Wed, 30 Sep 2020 09:55:29 +0800
Message-Id: <20200930015539.48867-40-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btree_set_page_dirty(), we should also check the extent buffer
sanity for subpage support.

Unlike the regular sector size case, since one page can contain multile
extent buffers, and page::private no longer contains the pointer to
extent buffer.

So this patch will iterate through the extent_io_tree to find out any
EXTENT_HAS_TREE_BLOCK bit, and check if any extent buffers in the page
range has EXTENT_BUFFER_DIRTY and proper refs.

Also, since we need to find subpage extent outside of extent_io.c,
export find_first_subpage_eb() as btrfs_find_first_subpage_eb().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 36 ++++++++++++++++++++++++++++++------
 fs/btrfs/extent_io.c |  8 ++++----
 fs/btrfs/extent_io.h |  4 ++++
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e0dc7b92411e..d31999978821 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1110,14 +1110,38 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 static int btree_set_page_dirty(struct page *page)
 {
 #ifdef DEBUG
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
 	struct extent_buffer *eb;
 
-	BUG_ON(!PagePrivate(page));
-	eb = (struct extent_buffer *)page->private;
-	BUG_ON(!eb);
-	BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-	BUG_ON(!atomic_read(&eb->refs));
-	btrfs_assert_tree_locked(eb);
+	if (fs_info->sectorsize == PAGE_SIZE) {
+		BUG_ON(!PagePrivate(page));
+		eb = (struct extent_buffer *)page->private;
+		BUG_ON(!eb);
+		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
+		BUG_ON(!atomic_read(&eb->refs));
+		btrfs_assert_tree_locked(eb);
+	} else {
+		u64 page_start = page_offset(page);
+		u64 page_end = page_start + PAGE_SIZE - 1;
+		u64 cur = page_start;
+		bool found_dirty_eb = false;
+		int ret;
+
+		ASSERT(btrfs_is_subpage(fs_info));
+		while (cur <= page_end) {
+			ret = btrfs_find_first_subpage_eb(fs_info, &eb, cur,
+							  page_end, 0);
+			if (ret > 0)
+				break;
+			cur = eb->start + eb->len;
+			if (test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
+				found_dirty_eb = true;
+				ASSERT(atomic_read(&eb->refs));
+				btrfs_assert_tree_locked(eb);
+			}
+		}
+		BUG_ON(!found_dirty_eb);
+	}
 #endif
 	return __set_page_dirty_nobuffers(page);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6aa25681aea4..5750a3b92777 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2754,9 +2754,9 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
  * Return 0 if we found one extent buffer and record it in @eb_ret.
  * Return 1 if there is no extent buffer in the range.
  */
-static int find_first_subpage_eb(struct btrfs_fs_info *fs_info,
-				 struct extent_buffer **eb_ret, u64 start,
-				 u64 end, u32 extra_bits)
+int btrfs_find_first_subpage_eb(struct btrfs_fs_info *fs_info,
+				struct extent_buffer **eb_ret, u64 start,
+				u64 end, u32 extra_bits)
 {
 	struct extent_io_tree *io_tree = info_to_btree_io_tree(fs_info);
 	u64 found_start;
@@ -6427,7 +6427,7 @@ static int try_release_subpage_eb(struct page *page)
 	while (cur <= end) {
 		struct extent_buffer *eb;
 
-		ret = find_first_subpage_eb(fs_info, &eb, cur, end, 0);
+		ret = btrfs_find_first_subpage_eb(fs_info, &eb, cur, end, 0);
 		if (ret > 0)
 			break;
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 602d6568c8ea..f527b6fa258d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -298,6 +298,10 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, int offset, int size);
 struct btrfs_fs_info;
 struct btrfs_inode;
 
+int btrfs_find_first_subpage_eb(struct btrfs_fs_info *fs_info,
+				struct extent_buffer **eb_ret, u64 start,
+				u64 end, unsigned int extra_bits);
+
 int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
 		      unsigned int pg_offset, int mirror_num);
-- 
2.28.0

