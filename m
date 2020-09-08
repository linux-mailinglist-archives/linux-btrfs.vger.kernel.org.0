Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327DC260C80
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgIHHx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbgIHHxU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63291AE24
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 07:53:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/17] btrfs: handle extent buffer verification proper for subpage size
Date:   Tue,  8 Sep 2020 15:52:29 +0800
Message-Id: <20200908075230.86856-17-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike regular PAGE_SIZE == sectorsize case, one btree inode page can
contain several tree blocks.

This makes the csum and other basic tree block verification very tricky,
as in btree_readpage_end_io_hook(), we can only check the extent buffer
who triggers this page read, not the remaining tree blocks in the same
page.

So this patch will change the timing of tree block verification to the
following timings:
- btree_readpage_end_io_hook()
  This is the old timing, but now we check all known extent buffers of
  the page.

- read_extent_buffer_pages()
  This is the new timing exclusive for subpage support.
  Now if an extent buffer finds all its page (only 1 for subpage) is
  already uptodate, it still needs to check if we have already checked
  the extent buffer.
  If not, then call btrfs_check_extent_buffer() to verify the extent
  buffer.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |   5 +-
 fs/btrfs/disk-io.h   |   1 +
 fs/btrfs/extent_io.c | 111 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h |   1 +
 4 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f6e562979682..5153c0420e7e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -575,7 +575,7 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 }
 
 /* Do basic extent buffer check at read time */
-static int btrfs_check_extent_buffer(struct extent_buffer *eb)
+int btrfs_check_extent_buffer(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u16 csum_size;
@@ -661,6 +661,9 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	if (!page->private)
 		goto out;
 
+	if (page_to_fs_info(page)->sectorsize < PAGE_SIZE)
+		return btrfs_verify_subpage_extent_buffers(page, mirror);
+
 	eb = (struct extent_buffer *)page->private;
 
 	/*
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 00dc39d47ed3..ac42b622f113 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -129,6 +129,7 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags);
 int __init btrfs_end_io_wq_init(void);
 void __cold btrfs_end_io_wq_exit(void);
+int btrfs_check_extent_buffer(struct extent_buffer *eb);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void btrfs_init_lockdep(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 87b3bb781532..8c5bb53265ab 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -46,6 +46,9 @@ struct subpage_eb_mapping {
 	 */
 	unsigned long bitmap;
 
+	/* Which range of ebs has been verified */
+	unsigned long verified;
+
 	/* We only support 64K PAGE_SIZE system to mount 4K sectorsize fs */
 	struct extent_buffer *buffers[SUBPAGE_NR_EXTENT_BUFFERS];
 };
@@ -5017,6 +5020,7 @@ static void detach_subpage_mapping(struct extent_buffer *eb, struct page *page)
 		if (test_bit(i, &mapping->bitmap) &&
 		    mapping->buffers[i] == eb) {
 			clear_bit(i, &mapping->bitmap);
+			clear_bit(i, &mapping->verified);
 			mapping->buffers[i] = NULL;
 		}
 	}
@@ -5696,6 +5700,38 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	}
 }
 
+/*
+ * For subpage, one btree page can already be uptodate (read by other tree
+ * blocks in the same page), but we haven't verified the csum of the tree
+ * block.
+ *
+ * So we need to do extra check for uptodate page of the extent buffer.
+ */
+static int check_uptodate_extent_buffer_page(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct subpage_eb_mapping *eb_mapping;
+	struct page *page = eb->pages[0];
+	int nr_bit;
+	int ret;
+
+	if (fs_info->sectorsize == PAGE_SIZE)
+		return 0;
+
+	nr_bit = (eb->start - page_offset(page)) / fs_info->sectorsize;
+	spin_lock(&page->mapping->private_lock);
+	eb_mapping = (struct subpage_eb_mapping *)page->private;
+	if (test_bit(nr_bit, &eb_mapping->verified)) {
+		spin_unlock(&page->mapping->private_lock);
+		return 0;
+	}
+	spin_unlock(&page->mapping->private_lock);
+	ret = btrfs_check_extent_buffer(eb);
+	if (!ret)
+		set_bit(nr_bit, &eb_mapping->verified);
+	return ret;
+}
+
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 {
 	int i;
@@ -5737,7 +5773,9 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	}
 
 	if (all_uptodate) {
-		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+		ret = check_uptodate_extent_buffer_page(eb);
+		if (!ret)
+			set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 		goto unlock_exit;
 	}
 
@@ -6396,3 +6434,74 @@ int try_release_extent_buffer(struct page *page)
 
 	return release_extent_buffer(eb);
 }
+
+/*
+ * Verify all referred extent buffers in one page for subpage support.
+ *
+ * This is called in btree_readpage_end_io_hook(), where we still have the
+ * page locked.
+ * Here we only check the extent buffer who triggers the page read, so it
+ * doesn't cover all extent buffers contained by this page.
+ *
+ * We still need to do the same check for read_extent_buffer_pages() where
+ * the page of the extent buffer is already uptodate.
+ */
+int btrfs_verify_subpage_extent_buffers(struct page *page, int mirror)
+{
+	struct btrfs_fs_info *fs_info = page_to_fs_info(page);
+	struct extent_buffer *eb;
+	struct subpage_eb_mapping *eb_mapping;
+	int nr_bits = (fs_info->nodesize / fs_info->sectorsize);
+	int i;
+	int ret = 0;
+
+	spin_lock(&page->mapping->private_lock);
+	eb_mapping = (struct subpage_eb_mapping *)page->private;
+	for (i = 0; i < SUBPAGE_NR_EXTENT_BUFFERS; i++) {
+		int reads_done;
+		int j;
+
+		if (!test_bit(i, &eb_mapping->bitmap))
+			continue;
+
+		eb = eb_mapping->buffers[i];
+		spin_unlock(&page->mapping->private_lock);
+
+		atomic_inc(&eb->refs);
+		reads_done = atomic_dec_and_test(&eb->io_pages);
+
+		/*
+		 * For subpage tree block, all tree read should be contained in
+		 * one page, thus the read should always be done.
+		 */
+		ASSERT(reads_done);
+
+		eb->read_mirror = mirror;
+		if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
+			ret = -EIO;
+			atomic_inc(&eb->io_pages);
+			clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+			free_extent_buffer(eb);
+			goto out;
+		}
+
+		ret = btrfs_check_extent_buffer(eb);
+		if (ret < 0) {
+			atomic_inc(&eb->io_pages);
+			clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+			free_extent_buffer(eb);
+			goto out;
+		}
+		for (j = i; j < i + nr_bits; j++)
+			set_bit(j, &eb_mapping->verified);
+
+		/* Go to next eb directly */
+		i += (nr_bits - 1);
+
+		free_extent_buffer(eb);
+		spin_lock(&page->mapping->private_lock);
+	}
+	spin_unlock(&page->mapping->private_lock);
+out:
+	return ret;
+}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6593b6883438..d714e05178b5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -330,6 +330,7 @@ blk_status_t btrfs_submit_read_repair(struct inode *inode,
 				      struct page *page, unsigned int pgoff,
 				      u64 start, u64 end, int failed_mirror,
 				      submit_bio_hook_t *submit_bio_hook);
+int btrfs_verify_subpage_extent_buffers(struct page *page, int mirror);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-- 
2.28.0

