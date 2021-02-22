Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C9F3210E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 07:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhBVGfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 01:35:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:48820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBVGfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 01:35:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613975670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TRWV6dtPSTUWKuuRZBYdjtXv/QFwGW80DdxKdvkotUw=;
        b=JmO04Tb1gOiowPOzpMRdLXhQsULqfOmMK3+YVAk5QU8/8yYgS29I84v+wmX5jgUgIaLKTE
        hfKb+TUiJo8AqrrM5g0ZTXsd9iw7eLNNkHnTDiHOZYTzG8i0lQZanrZR9iFvEwPR0DAP4f
        GwSx1d5KtUM1IOAhJa9H6SlgxkAK0+4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF2ABB126
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Feb 2021 06:34:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: extent_io: introduce end_bio_subpage_eb_writepage() function
Date:   Mon, 22 Feb 2021 14:33:54 +0800
Message-Id: <20210222063357.92930-10-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210222063357.92930-1-wqu@suse.com>
References: <20210222063357.92930-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new function, end_bio_subpage_eb_writepage(), will handle the
metadata writeback endio.

The major difference involved is:
- How to grab extent buffer
  Now page::private is a pointer to btrfs_subpage, we can no longer grab
  extent buffer directly.
  Thus we need to use the bv_offset to locate the extent buffer manually
  and iterate through the whole range.

- Use btrfs_subpage_end_writeback() caller
  This helper will handle the subpage writeback for us.

Since this function is executed under endio context, when grabbing
extent buffers it can't grab eb->refs_lock as that lock is not designed
to be grabbed under hardirq context.

So here introduce a helper, find_extent_buffer_nospinlock(), for such
situation, and convert find_extent_buffer() to use that helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 135 +++++++++++++++++++++++++++++++++----------
 1 file changed, 106 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 96ac72d3f3a0..d0afff0eb252 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4040,13 +4040,97 @@ static void set_btree_ioerr(struct page *page, struct extent_buffer *eb)
 	}
 }
 
+/*
+ * This is the endio specific version which won't touch any unsafe spinlock
+ * in endio context.
+ */
+static struct extent_buffer *find_extent_buffer_nospinlock(
+		struct btrfs_fs_info *fs_info, u64 start)
+{
+	struct extent_buffer *eb;
+
+	rcu_read_lock();
+	eb = radix_tree_lookup(&fs_info->buffer_radix,
+			       start >> fs_info->sectorsize_bits);
+	if (eb && atomic_inc_not_zero(&eb->refs)) {
+		rcu_read_unlock();
+		return eb;
+	}
+	rcu_read_unlock();
+	return NULL;
+}
+/*
+ * The endio function for subpage extent buffer write.
+ *
+ * Unlike end_bio_extent_buffer_writepage(), we only call end_page_writeback()
+ * after all extent buffers in the page has finished their writeback.
+ */
+static void end_bio_subpage_eb_writepage(struct btrfs_fs_info *fs_info,
+					 struct bio *bio)
+{
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	ASSERT(!bio_flagged(bio, BIO_CLONED));
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		struct page *page = bvec->bv_page;
+		u64 bvec_start = page_offset(page) + bvec->bv_offset;
+		u64 bvec_end = bvec_start + bvec->bv_len - 1;
+		u64 cur_bytenr = bvec_start;
+
+		ASSERT(IS_ALIGNED(bvec->bv_len, fs_info->nodesize));
+
+		/* Iterate through all extent buffers in the range */
+		while (cur_bytenr <= bvec_end) {
+			struct extent_buffer *eb;
+			int done;
+
+			/*
+			 * Here we can't use find_extent_buffer(), as it may
+			 * try to lock eb->refs_lock, which is not safe in endio 
+			 * context.
+			 */
+			eb = find_extent_buffer_nospinlock(fs_info, cur_bytenr);
+			ASSERT(eb);
+
+			cur_bytenr = eb->start + eb->len;
+
+			ASSERT(test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags));
+			done = atomic_dec_and_test(&eb->io_pages);
+			ASSERT(done);
+
+			if (bio->bi_status ||
+			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
+				ClearPageUptodate(page);
+				set_btree_ioerr(page, eb);
+			}
+
+			btrfs_subpage_clear_writeback(fs_info, page, eb->start,
+						      eb->len);
+			end_extent_buffer_writeback(eb);
+			/*
+			 * free_extent_buffer() will grab spinlock which is not
+			 * safe in endio context. Thus here we manually dec
+			 * the ref.
+			 */
+			atomic_dec(&eb->refs);
+		}
+	}
+	bio_put(bio);
+}
+
 static void end_bio_extent_buffer_writepage(struct bio *bio)
 {
+	struct btrfs_fs_info *fs_info;
 	struct bio_vec *bvec;
 	struct extent_buffer *eb;
 	int done;
 	struct bvec_iter_all iter_all;
 
+	fs_info = btrfs_sb(bio_first_page_all(bio)->mapping->host->i_sb);
+	if (fs_info->sectorsize < PAGE_SIZE)
+		return end_bio_subpage_eb_writepage(fs_info, bio);
+
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		struct page *page = bvec->bv_page;
@@ -5427,36 +5511,29 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 {
 	struct extent_buffer *eb;
 
-	rcu_read_lock();
-	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> fs_info->sectorsize_bits);
-	if (eb && atomic_inc_not_zero(&eb->refs)) {
-		rcu_read_unlock();
-		/*
-		 * Lock our eb's refs_lock to avoid races with
-		 * free_extent_buffer. When we get our eb it might be flagged
-		 * with EXTENT_BUFFER_STALE and another task running
-		 * free_extent_buffer might have seen that flag set,
-		 * eb->refs == 2, that the buffer isn't under IO (dirty and
-		 * writeback flags not set) and it's still in the tree (flag
-		 * EXTENT_BUFFER_TREE_REF set), therefore being in the process
-		 * of decrementing the extent buffer's reference count twice.
-		 * So here we could race and increment the eb's reference count,
-		 * clear its stale flag, mark it as dirty and drop our reference
-		 * before the other task finishes executing free_extent_buffer,
-		 * which would later result in an attempt to free an extent
-		 * buffer that is dirty.
-		 */
-		if (test_bit(EXTENT_BUFFER_STALE, &eb->bflags)) {
-			spin_lock(&eb->refs_lock);
-			spin_unlock(&eb->refs_lock);
-		}
-		mark_extent_buffer_accessed(eb, NULL);
-		return eb;
+	eb = find_extent_buffer_nospinlock(fs_info, start);
+	if (!eb)
+		return NULL;
+	/*
+	 * Lock our eb's refs_lock to avoid races with free_extent_buffer().
+	 * When we get our eb it might be flagged with EXTENT_BUFFER_STALE and
+	 * another task running free_extent_buffer() might have seen that flag
+	 * set, eb->refs == 2, that the buffer isn't under IO (dirty and
+	 * writeback flags not set) and it's still in the tree (flag
+	 * EXTENT_BUFFER_TREE_REF set), therefore being in the process
+	 * of decrementing the extent buffer's reference count twice.
+	 * So here we could race and increment the eb's reference count,
+	 * clear its stale flag, mark it as dirty and drop our reference
+	 * before the other task finishes executing free_extent_buffer,
+	 * which would later result in an attempt to free an extent
+	 * buffer that is dirty.
+	 */
+	if (test_bit(EXTENT_BUFFER_STALE, &eb->bflags)) {
+		spin_lock(&eb->refs_lock);
+		spin_unlock(&eb->refs_lock);
 	}
-	rcu_read_unlock();
-
-	return NULL;
+	mark_extent_buffer_accessed(eb, NULL);
+	return eb;
 }
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.30.0

