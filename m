Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F38294847
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440821AbgJUG1g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436568AbgJUG1g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IuY4S+2EtACZ9worVlRYr7BkM7HczHMSuuFSkUtGpco=;
        b=shlu450yWXVMiWGvwvbEgxC+gj2qJkUU/fT5ARkJpX1fHX+6VQeUIga/esvLCIUnQ6nE4G
        gP1VUUyVA+rmbCyFVa3wqWDSfCCMg68y8Qeo1u5oQNhJ3ibhy0m2gFC3TBIKzVcbvR7r2n
        eiZ3B4333d1rA8DzPzy3gIg6k1tLY4c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AD87AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 43/68] btrfs: disk-io: allow btree_set_page_dirty() to do more sanity check on subpage metadata
Date:   Wed, 21 Oct 2020 14:25:29 +0800
Message-Id: <20201021062554.68132-44-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
index 5254a4ce2598..278154d405ea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2809,9 +2809,9 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
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
@@ -6553,7 +6553,7 @@ static int try_release_subpage_eb(struct page *page)
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

