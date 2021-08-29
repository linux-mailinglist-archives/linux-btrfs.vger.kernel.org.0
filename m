Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730C63FA943
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhH2F0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45764 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhH2F0A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:00 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EAE5120017
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZboN9dxztyRIWEML5NyVrokmLlFdMXae9wWIfi1stM=;
        b=CZZ04gaDd7O0v5s3gisb1Pe7e1dOudeoUYkIPvRyS585in41K9knBsi6zy0UWxuWIx9ERf
        F3HoLr9K9wF8KMOu1vXygJtVtJH6E610cmjN8yyy5cOd61jRtoOJv/yxtx6VEymN2Kxuiw
        aprJS+ZuwElSIYEvpzyRDNWJuYKc8CM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3247113964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id QHiqODIaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/26] btrfs: make add_ra_bio_pages() to be subpage compatible
Date:   Sun, 29 Aug 2021 13:24:37 +0800
Message-Id: <20210829052458.15454-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
If we remove the subpage limitation in add_ra_bio_pages(), then read a
compressed extent which has part of its range in next page, like the
following inode layout:

	0	32K	64K	96K	128K
	|<--------------|-------------->|

Btrfs will trigger ASSERT() in endio function:

 assertion failed: atomic_read(&subpage->readers) >= nbits
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/ctree.h:3431!
 Internal error: Oops - BUG: 0 [#1] SMP
 Workqueue: btrfs-endio btrfs_work_helper [btrfs]
 Call trace:
  assertfail.constprop.0+0x28/0x2c [btrfs]
  btrfs_subpage_end_reader+0x148/0x14c [btrfs]
  end_page_read+0x8c/0x100 [btrfs]
  end_bio_extent_readpage+0x320/0x6b0 [btrfs]
  bio_endio+0x15c/0x1dc
  end_workqueue_fn+0x44/0x64 [btrfs]
  btrfs_work_helper+0x74/0x250 [btrfs]
  process_one_work+0x1d4/0x47c
  worker_thread+0x180/0x400
  kthread+0x11c/0x120
  ret_from_fork+0x10/0x30
 ---[ end trace c8b7b552d3bb408c ]---

[CAUSE]
When we read the page range [0, 64K), we find it's a compressed extent,
and we will try to add extra pages in add_ra_bio_pages() to avoid
reading the same compressed extent.

But when we add such page into the read bio, it doesn't follow the
behavior of btrfs_do_readpage() to properly set subpage::readers.

This means, for page [64K, 128K), its subpage::readers is still 0.

And when endio is executed on both pages, since page [64K, 128K) has 0
subpage::readers, it triggers above ASSERT()

[FIX]
Function add_ra_bio_pages() is far from subpage compatible, it always
assume PAGE_SIZE == sectorsize, thus when it skip to next range it
always just skip PAGE_SIZE.

Make it subpage compatible by:

- Skip to next page properly when needed
  If we find there is already a page cache, we need to skip to next
  page.
  For that case, we shouldn't just skip PAGE_SIZE bytes, but use
  @pg_index to calculate the next bytenr and continue.

- Only add the page range covered by current extent map
  We need to calculate which range is covered by current extent map and
  only add that part into the read bio.

- Update subpage::readers before submitting the bio

- Use proper cursor other than confusing @last_offset

- Calculate the missed threshold based on sector size
  It's no longer using missed pages, as for 64K page size, we have at
  most 3 pages to skip. (If aligned only 2 pages)

- Add ASSERT() to make sure our bytenr is always aligned

- Add comment for the function
  Add an especial note for subpage case, as the function won't really
  work well for subpage cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 89 +++++++++++++++++++++++++++---------------
 fs/btrfs/extent_io.c   |  1 +
 2 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a26ce27ad005..09171e557ba8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -539,13 +539,24 @@ static u64 bio_end_offset(struct bio *bio)
 	return page_offset(last->bv_page) + last->bv_len + last->bv_offset;
 }
 
+/*
+ * Add extra pages in the same compressed file extent so that we don't
+ * need to re-read the same extent again and again.
+ *
+ * NOTE: this won't work well for subpage, as for subpage read, we lock the
+ * full page then submit bio for each compressed/regular extents.
+ *
+ * This means, if we have several sectors in the same page points to the same
+ * on-disk compressed data, we will re-read the same extent many times and
+ * this function can only help for the next page.
+ */
 static noinline int add_ra_bio_pages(struct inode *inode,
 				     u64 compressed_end,
 				     struct compressed_bio *cb)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long end_index;
-	unsigned long pg_index;
-	u64 last_offset;
+	u64 cur = bio_end_offset(cb->orig_bio);
 	u64 isize = i_size_read(inode);
 	int ret;
 	struct page *page;
@@ -553,10 +564,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_map_tree *em_tree;
 	struct extent_io_tree *tree;
-	u64 end;
-	int misses = 0;
+	int sectors_missed = 0;
 
-	last_offset = bio_end_offset(cb->orig_bio);
 	em_tree = &BTRFS_I(inode)->extent_tree;
 	tree = &BTRFS_I(inode)->io_tree;
 
@@ -575,18 +584,29 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 	end_index = (i_size_read(inode) - 1) >> PAGE_SHIFT;
 
-	while (last_offset < compressed_end) {
-		pg_index = last_offset >> PAGE_SHIFT;
+	while (cur < compressed_end) {
+		u64 page_end;
+		u64 pg_index = cur >> PAGE_SHIFT;
+		u32 add_size;
 
 		if (pg_index > end_index)
 			break;
 
 		page = xa_load(&mapping->i_pages, pg_index);
 		if (page && !xa_is_value(page)) {
-			misses++;
-			if (misses > 4)
+			sectors_missed += (PAGE_SIZE - offset_in_page(cur)) >>
+					  fs_info->sectorsize_bits;
+
+			/* Beyond threshold, no need to continue */
+			if (sectors_missed > 4)
 				break;
-			goto next;
+
+			/*
+			 * Jump to next page start as we already have page for
+			 * current offset.
+			 */
+			cur = (pg_index << PAGE_SHIFT) + PAGE_SIZE;
+			continue;
 		}
 
 		page = __page_cache_alloc(mapping_gfp_constraint(mapping,
@@ -596,14 +616,11 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 
 		if (add_to_page_cache_lru(page, mapping, pg_index, GFP_NOFS)) {
 			put_page(page);
-			goto next;
+			/* There is already a page, skip to page end */
+			cur = (pg_index << PAGE_SHIFT) + PAGE_SIZE;
+			continue;
 		}
 
-		/*
-		 * at this point, we have a locked page in the page cache
-		 * for these bytes in the file.  But, we have to make
-		 * sure they map to this compressed extent on disk.
-		 */
 		ret = set_page_extent_mapped(page);
 		if (ret < 0) {
 			unlock_page(page);
@@ -611,18 +628,22 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			break;
 		}
 
-		end = last_offset + PAGE_SIZE - 1;
-		lock_extent(tree, last_offset, end);
+		page_end = (pg_index << PAGE_SHIFT) + PAGE_SIZE - 1;
+		lock_extent(tree, cur, page_end);
 		read_lock(&em_tree->lock);
-		em = lookup_extent_mapping(em_tree, last_offset,
-					   PAGE_SIZE);
+		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
 
-		if (!em || last_offset < em->start ||
-		    (last_offset + PAGE_SIZE > extent_map_end(em)) ||
+		/*
+		 * At this point, we have a locked page in the page cache
+		 * for these bytes in the file.  But, we have to make
+		 * sure they map to this compressed extent on disk.
+		 */
+		if (!em || cur < em->start ||
+		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (em->block_start >> 9) != cb->orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
-			unlock_extent(tree, last_offset, end);
+			unlock_extent(tree, cur, page_end);
 			unlock_page(page);
 			put_page(page);
 			break;
@@ -640,19 +661,25 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			}
 		}
 
+		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(cb->orig_bio, page,
-				   PAGE_SIZE, 0);
-
-		if (ret == PAGE_SIZE) {
-			put_page(page);
-		} else {
-			unlock_extent(tree, last_offset, end);
+				   add_size, offset_in_page(cur));
+		if (ret != add_size) {
+			unlock_extent(tree, cur, page_end);
 			unlock_page(page);
 			put_page(page);
 			break;
 		}
-next:
-		last_offset += PAGE_SIZE;
+		/*
+		 * If it's subpage, we also need to increase its
+		 * subpage::readers numbre, as at endio we will
+		 * decrease subpage::readers and to unlock the page.
+		 */
+		if (fs_info->sectorsize < PAGE_SIZE)
+			btrfs_subpage_start_reader(fs_info, page,
+				cur, add_size);
+		put_page(page);
+		cur += add_size;
 	}
 	return 0;
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2806949c6243..3214ecb36cf3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3599,6 +3599,7 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
 
+		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
 			struct extent_state *cached = NULL;
 
-- 
2.32.0

