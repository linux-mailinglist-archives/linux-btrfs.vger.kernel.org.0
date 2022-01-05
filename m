Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF140484C79
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 03:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbiAEC2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Jan 2022 21:28:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49286 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiAEC2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Jan 2022 21:28:34 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C7F2921107
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 02:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641349712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bFGgzc1ARnxUISVlbeJ8YchjVXaI1yLdNksOUHZxyM=;
        b=TLDHOoTmnJP5+9Sa15oeyZPyu27AVUFH44sUcIQYbw+/CG/4/dvxL7pGYCkzXWHZiR/tsc
        E9Z7P0+wjnhjqcHVDJ4xbB9U+qosT+RrcwTYVYF1+VJLRQeB5YA8QMvtEyVJwy4wwQXM6n
        27xG1Ln17HHOI6/FXONOeyXF+gm+WGs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EB3C13B71
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 02:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPmvME8C1WHLKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Jan 2022 02:28:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make nodesize >= PAGE_SIZE case to reuse the non-subpage routine
Date:   Wed,  5 Jan 2022 10:28:11 +0800
Message-Id: <20220105022812.45698-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220105022812.45698-1-wqu@suse.com>
References: <20220105022812.45698-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The reason why we only support 64K page size for subpage is, for 64K
page size we can ensure no matter what the nodesize is, we can fit it
into one page.

When other page size comes, especially like 16K, the limitation is a bit
blockage.

To remove such limitation, we allow nodesize >= PAGE_SIZE case to go
the non-subpage routine.
By this, we can allow 4K sectorsize on 16K page size.

Although this introduces another smaller limitation, the metadata can
not cross page boundary, which is already met by most recent mkfs.

Another small improvement is, we can avoid the overhead for metadata if
nodesize >= PAGE_SIZE.
For 4K sector size and 64K page size/node size, or 4K sector size and
16K page size/node size, we don't need to allocate extra memory for the
metadata pages.

Please note that, this patch will not yet enable other page size support
yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  4 +--
 fs/btrfs/extent_io.c | 80 ++++++++++++++++++++++++++------------------
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/subpage.c   | 30 ++++++++---------
 fs/btrfs/subpage.h   | 25 ++++++++++++++
 5 files changed, 91 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87a5addbedf6..884e0b543136 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -505,7 +505,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec
 	u64 found_start;
 	struct extent_buffer *eb;
 
-	if (fs_info->sectorsize < PAGE_SIZE)
+	if (fs_info->nodesize < PAGE_SIZE)
 		return csum_dirty_subpage_buffers(fs_info, bvec);
 
 	eb = (struct extent_buffer *)page->private;
@@ -690,7 +690,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 
 	ASSERT(page->private);
 
-	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
 		return validate_subpage_buffer(page, start, end, mirror);
 
 	eb = (struct extent_buffer *)page->private;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d6d48ecf823c..f43a23bb67eb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2710,7 +2710,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 		btrfs_page_set_error(fs_info, page, start, len);
 	}
 
-	if (fs_info->sectorsize == PAGE_SIZE)
+	if (!btrfs_is_subpage(fs_info, page))
 		unlock_page(page);
 	else
 		btrfs_subpage_end_reader(fs_info, page, start, len);
@@ -2943,7 +2943,7 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 {
 	ASSERT(PageLocked(page));
-	if (fs_info->sectorsize == PAGE_SIZE)
+	if (!btrfs_is_subpage(fs_info, page))
 		return;
 
 	ASSERT(PagePrivate(page));
@@ -2965,7 +2965,7 @@ static struct extent_buffer *find_extent_buffer_readpage(
 	 * For regular sectorsize, we can use page->private to grab extent
 	 * buffer
 	 */
-	if (fs_info->sectorsize == PAGE_SIZE) {
+	if (fs_info->nodesize >= PAGE_SIZE) {
 		ASSERT(PagePrivate(page) && page->private);
 		return (struct extent_buffer *)page->private;
 	}
@@ -3458,7 +3458,7 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
 	if (page->mapping)
 		lockdep_assert_held(&page->mapping->private_lock);
 
-	if (fs_info->sectorsize == PAGE_SIZE) {
+	if (fs_info->nodesize >= PAGE_SIZE) {
 		if (!PagePrivate(page))
 			attach_page_private(page, eb);
 		else
@@ -3493,7 +3493,7 @@ int set_page_extent_mapped(struct page *page)
 
 	fs_info = btrfs_sb(page->mapping->host->i_sb);
 
-	if (fs_info->sectorsize < PAGE_SIZE)
+	if (btrfs_is_subpage(fs_info, page))
 		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
 
 	attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
@@ -3510,7 +3510,7 @@ void clear_page_extent_mapped(struct page *page)
 		return;
 
 	fs_info = btrfs_sb(page->mapping->host->i_sb);
-	if (fs_info->sectorsize < PAGE_SIZE)
+	if (btrfs_is_subpage(fs_info, page))
 		return btrfs_detach_subpage(fs_info, page);
 
 	detach_page_private(page);
@@ -3868,7 +3868,7 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
 	 * For regular sector size == page size case, since one page only
 	 * contains one sector, we return the page offset directly.
 	 */
-	if (fs_info->sectorsize == PAGE_SIZE) {
+	if (!btrfs_is_subpage(fs_info, page)) {
 		*start = page_offset(page);
 		*end = page_offset(page) + PAGE_SIZE;
 		return;
@@ -4250,7 +4250,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 	 * Subpage metadata doesn't use page locking at all, so we can skip
 	 * the page locking.
 	 */
-	if (!ret || fs_info->sectorsize < PAGE_SIZE)
+	if (!ret || fs_info->nodesize < PAGE_SIZE)
 		return ret;
 
 	num_pages = num_extent_pages(eb);
@@ -4410,7 +4410,7 @@ static void end_bio_subpage_eb_writepage(struct bio *bio)
 	struct bvec_iter_all iter_all;
 
 	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
-	ASSERT(fs_info->sectorsize < PAGE_SIZE);
+	ASSERT(fs_info->nodesize < PAGE_SIZE);
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
@@ -4737,7 +4737,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!PagePrivate(page))
 		return 0;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
 		return submit_eb_subpage(page, wbc, epd);
 
 	spin_lock(&mapping->private_lock);
@@ -5793,7 +5793,7 @@ static void detach_extent_buffer_page(struct extent_buffer *eb, struct page *pag
 		return;
 	}
 
-	if (fs_info->sectorsize == PAGE_SIZE) {
+	if (fs_info->nodesize >= PAGE_SIZE) {
 		/*
 		 * We do this since we'll remove the pages after we've
 		 * removed the eb from the radix tree, so we could race
@@ -6113,7 +6113,7 @@ static struct extent_buffer *grab_extent_buffer(
 	 * don't try to insert two ebs for the same bytenr.  So here we always
 	 * return NULL and just continue.
 	 */
-	if (fs_info->sectorsize < PAGE_SIZE)
+	if (fs_info->nodesize < PAGE_SIZE)
 		return NULL;
 
 	/* Page not yet attached to an extent buffer */
@@ -6135,6 +6135,23 @@ static struct extent_buffer *grab_extent_buffer(
 	return NULL;
 }
 
+static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
+{
+	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
+		btrfs_err(fs_info, "bad tree block start %llu", start);
+		return -EINVAL;
+	}
+
+	if (fs_info->sectorsize < PAGE_SIZE &&
+	    offset_in_page(start) + fs_info->nodesize > PAGE_SIZE) {
+		btrfs_err(fs_info,
+		"tree block crosses page boundary, start %llu nodesize %u",
+			  start, fs_info->nodesize);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
@@ -6149,10 +6166,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	int uptodate = 1;
 	int ret;
 
-	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
-		btrfs_err(fs_info, "bad tree block start %llu", start);
+	if (check_eb_alignment(fs_info, start))
 		return ERR_PTR(-EINVAL);
-	}
 
 #if BITS_PER_LONG == 32
 	if (start >= MAX_LFS_FILESIZE) {
@@ -6165,14 +6180,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_warn_32bit_limit(fs_info);
 #endif
 
-	if (fs_info->sectorsize < PAGE_SIZE &&
-	    offset_in_page(start) + len > PAGE_SIZE) {
-		btrfs_err(fs_info,
-		"tree block crosses page boundary, start %llu nodesize %lu",
-			  start, len);
-		return ERR_PTR(-EINVAL);
-	}
-
 	eb = find_extent_buffer(fs_info, start);
 	if (eb)
 		return eb;
@@ -6202,7 +6209,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * page, but it may change in the future for 16K page size
 		 * support, so we still preallocate the memory in the loop.
 		 */
-		if (fs_info->sectorsize < PAGE_SIZE) {
+		if (fs_info->nodesize < PAGE_SIZE) {
 			prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
 			if (IS_ERR(prealloc)) {
 				ret = PTR_ERR(prealloc);
@@ -6421,7 +6428,7 @@ void clear_extent_buffer_dirty(const struct extent_buffer *eb)
 	int num_pages;
 	struct page *page;
 
-	if (eb->fs_info->sectorsize < PAGE_SIZE)
+	if (eb->fs_info->nodesize < PAGE_SIZE)
 		return clear_subpage_extent_buffer_dirty(eb);
 
 	num_pages = num_extent_pages(eb);
@@ -6453,7 +6460,7 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 
 	if (!was_dirty) {
-		bool subpage = eb->fs_info->sectorsize < PAGE_SIZE;
+		bool subpage = eb->fs_info->nodesize < PAGE_SIZE;
 
 		/*
 		 * For subpage case, we can have other extent buffers in the
@@ -6510,7 +6517,16 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 	num_pages = num_extent_pages(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
-		btrfs_page_set_uptodate(fs_info, page, eb->start, eb->len);
+
+		/*
+		 * This is special handling for metadata subpage, as regular
+		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
+		 */
+		if (fs_info->nodesize >= PAGE_SIZE)
+			SetPageUptodate(page);
+		else
+			btrfs_subpage_set_uptodate(fs_info, page, eb->start,
+						   eb->len);
 	}
 }
 
@@ -6605,7 +6621,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
 		return -EIO;
 
-	if (eb->fs_info->sectorsize < PAGE_SIZE)
+	if (eb->fs_info->nodesize < PAGE_SIZE)
 		return read_extent_buffer_subpage(eb, wait, mirror_num);
 
 	num_pages = num_extent_pages(eb);
@@ -6851,7 +6867,7 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 
-	if (fs_info->sectorsize < PAGE_SIZE) {
+	if (fs_info->nodesize < PAGE_SIZE) {
 		bool uptodate;
 
 		uptodate = btrfs_subpage_test_uptodate(fs_info, page,
@@ -6952,7 +6968,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 
 	ASSERT(dst->len == src->len);
 
-	if (dst->fs_info->sectorsize == PAGE_SIZE) {
+	if (dst->fs_info->nodesize >= PAGE_SIZE) {
 		num_pages = num_extent_pages(dst);
 		for (i = 0; i < num_pages; i++)
 			copy_page(page_address(dst->pages[i]),
@@ -6961,7 +6977,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 		size_t src_offset = get_eb_offset_in_page(src, 0);
 		size_t dst_offset = get_eb_offset_in_page(dst, 0);
 
-		ASSERT(src->fs_info->sectorsize < PAGE_SIZE);
+		ASSERT(src->fs_info->nodesize < PAGE_SIZE);
 		memcpy(page_address(dst->pages[0]) + dst_offset,
 		       page_address(src->pages[0]) + src_offset,
 		       src->len);
@@ -7354,7 +7370,7 @@ int try_release_extent_buffer(struct page *page)
 {
 	struct extent_buffer *eb;
 
-	if (btrfs_sb(page->mapping->host->i_sb)->sectorsize < PAGE_SIZE)
+	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
 		return try_release_subpage_extent_buffer(page);
 
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b2403b6127f..89e888409609 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8129,7 +8129,7 @@ static void wait_subpage_spinlock(struct page *page)
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
 	struct btrfs_subpage *subpage;
 
-	if (fs_info->sectorsize == PAGE_SIZE)
+	if (!btrfs_is_subpage(fs_info, page))
 		return;
 
 	ASSERT(PagePrivate(page) && page->private);
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 29bd8c7a7706..c7dea689da90 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -107,7 +107,7 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 		ASSERT(PageLocked(page));
 
 	/* Either not subpage, or the page already has private attached */
-	if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
+	if (!btrfs_is_subpage(fs_info, page) || PagePrivate(page))
 		return 0;
 
 	subpage = btrfs_alloc_subpage(fs_info, type);
@@ -124,7 +124,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage;
 
 	/* Either not subpage, or already detached */
-	if (fs_info->sectorsize == PAGE_SIZE || !PagePrivate(page))
+	if (!btrfs_is_subpage(fs_info, page) || !PagePrivate(page))
 		return;
 
 	subpage = (struct btrfs_subpage *)detach_page_private(page);
@@ -175,7 +175,7 @@ void btrfs_page_inc_eb_refs(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage;
 
-	if (fs_info->sectorsize == PAGE_SIZE)
+	if (!btrfs_is_subpage(fs_info, page))
 		return;
 
 	ASSERT(PagePrivate(page) && page->mapping);
@@ -190,7 +190,7 @@ void btrfs_page_dec_eb_refs(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage;
 
-	if (fs_info->sectorsize == PAGE_SIZE)
+	if (!btrfs_is_subpage(fs_info, page))
 		return;
 
 	ASSERT(PagePrivate(page) && page->mapping);
@@ -319,7 +319,7 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len)
 {
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {
 		lock_page(page);
 		return 0;
 	}
@@ -336,7 +336,7 @@ int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
 void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
 		struct page *page, u64 start, u32 len)
 {
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))
 		return unlock_page(page);
 	btrfs_subpage_clamp_range(page, &start, &len);
 	if (btrfs_subpage_end_and_test_writer(fs_info, page, start, len))
@@ -620,7 +620,7 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
 void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
 		set_page_func(page);					\
 		return;							\
 	}								\
@@ -629,7 +629,7 @@ void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
 void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
 		clear_page_func(page);					\
 		return;							\
 	}								\
@@ -638,14 +638,14 @@ void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
 bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))	\
 		return test_page_func(page);				\
 	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
 }									\
 void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
 		set_page_func(page);					\
 		return;							\
 	}								\
@@ -655,7 +655,7 @@ void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE) {	\
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page)) {	\
 		clear_page_func(page);					\
 		return;							\
 	}								\
@@ -665,7 +665,7 @@ void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
 bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct page *page, u64 start, u32 len)			\
 {									\
-	if (unlikely(!fs_info) || fs_info->sectorsize == PAGE_SIZE)	\
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page))	\
 		return test_page_func(page);				\
 	btrfs_subpage_clamp_range(page, &start, &len);			\
 	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
@@ -694,7 +694,7 @@ void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 		return;
 
 	ASSERT(!PageDirty(page));
-	if (fs_info->sectorsize == PAGE_SIZE)
+	if (!btrfs_is_subpage(fs_info, page))
 		return;
 
 	ASSERT(PagePrivate(page) && page->private);
@@ -722,8 +722,8 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
 	struct btrfs_subpage *subpage;
 
 	ASSERT(PageLocked(page));
-	/* For regular page size case, we just unlock the page */
-	if (fs_info->sectorsize == PAGE_SIZE)
+	/* For non-subpage case, we just unlock the page */
+	if (!btrfs_is_subpage(fs_info, page))
 		return unlock_page(page);
 
 	ASSERT(PagePrivate(page) && page->private);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 7accb5c40d33..a87e53e8c24c 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -4,6 +4,7 @@
 #define BTRFS_SUBPAGE_H
 
 #include <linux/spinlock.h>
+#include "btrfs_inode.h"
 
 /*
  * Extra info for subpapge bitmap.
@@ -74,6 +75,30 @@ enum btrfs_subpage_type {
 	BTRFS_SUBPAGE_DATA,
 };
 
+static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
+				    struct page *page)
+{
+	if (fs_info->sectorsize >= PAGE_SIZE)
+		return false;
+
+	/*
+	 * Only data pages (either through DIO or compression) can have no
+	 * mapping. And if page->mapping->host is data inode, it's subpage.
+	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
+	 */
+	if (!page->mapping || !page->mapping->host ||
+	    is_data_inode(page->mapping->host))
+		return true;
+
+	/*
+	 * Now the only remaining case is metadata, which we only go subpage
+	 * routine if nodesize < PAGE_SIZE.
+	 */
+	if (fs_info->nodesize < PAGE_SIZE)
+		return true;
+	return false;
+}
+
 void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct page *page, enum btrfs_subpage_type type);
-- 
2.34.1

