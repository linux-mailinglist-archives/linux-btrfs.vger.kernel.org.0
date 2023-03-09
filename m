Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50976B1F66
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCIJH5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCIJHU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:07:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E38D6153B
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CnjgSwxVi4O3S/ReZy+kfRMLAQxITw3k0zcWRTtuYZI=; b=ERiB5fFuw9Y+0GqRgH3ako0ERT
        AYKpR8NmX8tyIlOqGdHv0uakxL9qDWRgCp9w+L48yS1atQo8geJkgol/9ow2MTtRvvfeQM5s3NGZq
        2SUFvjc52e70Akt3hFexG8/svEa8sokq1NNEx9OzqCj6p50IcLBVLxof4w6f5z+G6bMKOgzZcwrsZ
        sZr0kPg3ZndzDsGDNZQ8cJqcX/xehsuSmy9oEKLBXLOjTnkkRKO2/J/8ZYQ3z/9JFTQaL2+yL+5Uo
        UOKDToF7Rw60+oH1CpBXxt1s2Hxsj8PVpIcmFXnn0HrXQQfMtBQmMNJJNtH38nXwja69cc8Or/AC6
        7ku83SpQ==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCEf-008hz6-CT; Thu, 09 Mar 2023 09:06:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/20] btrfs: remove the io_pages field in struct extent_buffer
Date:   Thu,  9 Mar 2023 10:05:21 +0100
Message-Id: <20230309090526.332550-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No need to track the number of pages under I/O now that each
extent_buffer is read and written using a single bio.  For the
read side we need to grab an extra reference for the duration of
the I/O to prevent eviction, though.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 17 +++++------------
 fs/btrfs/extent_io.h |  1 -
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 16522bcf5d4a10..24df1247d81d88 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1770,8 +1770,6 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
 		struct page *page = bvec->bv_page;
 
-		atomic_dec(&eb->io_pages);
-
 		if (!uptodate) {
 			ClearPageUptodate(page);
 			btrfs_page_set_error(fs_info, page, eb->start, eb->len);
@@ -1796,7 +1794,6 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	unsigned long end;
 
 	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
-	atomic_set(&eb->io_pages, num_extent_pages(eb));
 
 	/* Set btree blocks beyond nritems with 0 to avoid stale content */
 	nritems = btrfs_header_nritems(eb);
@@ -3236,8 +3233,7 @@ static void __free_extent_buffer(struct extent_buffer *eb)
 
 static int extent_buffer_under_io(const struct extent_buffer *eb)
 {
-	return (atomic_read(&eb->io_pages) ||
-		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
+	return (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
 		test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
 }
 
@@ -3374,7 +3370,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
-	atomic_set(&eb->io_pages, 0);
 
 	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
 
@@ -3491,9 +3486,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 	 * adequately protected by the refcount, but the TREE_REF bit and
 	 * its corresponding reference are not. To protect against this
 	 * class of races, we call check_buffer_tree_ref from the codepaths
-	 * which trigger io after they set eb->io_pages. Note that once io is
-	 * initiated, TREE_REF can no longer be cleared, so that is the
-	 * moment at which any such race is best fixed.
+	 * which trigger io. Note that once io is initiated, TREE_REF can no
+	 * longer be cleared, so that is the moment at which any such race is
+	 * best fixed.
 	 */
 	refs = atomic_read(&eb->refs);
 	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
@@ -4063,7 +4058,6 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 	struct bio_vec *bvec;
 	u32 bio_offset = 0;
 
-	atomic_inc(&eb->refs);
 	eb->read_mirror = bbio->mirror_num;
 
 	if (uptodate &&
@@ -4078,7 +4072,6 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 	}
 
 	bio_for_each_segment_all(bvec, &bbio->bio, iter_all) {
-		atomic_dec(&eb->io_pages);
 		end_page_read(bvec->bv_page, uptodate, eb->start + bio_offset,
 			      bvec->bv_len);
 		bio_offset += bvec->bv_len;
@@ -4101,8 +4094,8 @@ static void __read_extent_buffer_pages(struct extent_buffer *eb, int mirror_num,
 
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
-	atomic_set(&eb->io_pages, num_pages);
 	check_buffer_tree_ref(eb);
+	atomic_inc(&eb->refs);
 
 	bbio = btrfs_bio_alloc(INLINE_EXTENT_BUFFER_PAGES,
 			       REQ_OP_READ | REQ_META,
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 342412d37a7b4b..12854a2b48f060 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -79,7 +79,6 @@ struct extent_buffer {
 	struct btrfs_fs_info *fs_info;
 	spinlock_t refs_lock;
 	atomic_t refs;
-	atomic_t io_pages;
 	int read_mirror;
 	struct rcu_head rcu_head;
 	pid_t lock_owner;
-- 
2.39.2

