Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71B4294834
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440766AbgJUG0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731630AbgJUG0w (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cawPiZZ87qrJlrJzuQaVsonurC0ql6oGPeNQMYAhc00=;
        b=jz7KyUosSAdVVY0vnYpsodIZVqk29wIj4HtXwZtdl52JQMCoKdVesJmyRvdY/LCfNX+vIX
        t/Opsdja1GDcUxQwe4i/HQ0+CTjtsYDFyfQ9ba1PkXPzTrA1O4SEJ046wSH3oUfMiNGAMr
        piqJyac3+uOGrfrRtn1PQPwy6wCzMUQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45188AC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 24/68] btrfs: disk-io: extract the extent buffer verification from btree_readpage_end_io_hook()
Date:   Wed, 21 Oct 2020 14:25:10 +0800
Message-Id: <20201021062554.68132-25-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btree_readpage_end_io_hook() only needs to handle one extent
buffer as currently one page only maps to one extent buffer.

But for incoming subpage support, one page can be mapped to multiple
extent buffers, thus we can no longer use current code.

This refactor would allow us to call btrfs_check_extent_buffer() on
all involved extent buffers at btree_readpage_end_io_hook() and other
locations.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 78 ++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 55bb4f2def3c..ee2a6d480a7d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -574,60 +574,37 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 	return ret;
 }
 
-static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
-				      u64 phy_offset, struct page *page,
-				      u64 start, u64 end, int mirror)
+/* Do basic extent buffer check at read time */
+static int btrfs_check_extent_buffer(struct extent_buffer *eb)
 {
-	u64 found_start;
-	int found_level;
-	struct extent_buffer *eb;
-	struct btrfs_fs_info *fs_info;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u16 csum_size;
-	int ret = 0;
+	u64 found_start;
+	u8 found_level;
 	u8 result[BTRFS_CSUM_SIZE];
-	int reads_done;
-
-	if (!page->private)
-		goto out;
+	int ret = 0;
 
-	eb = (struct extent_buffer *)page->private;
-	fs_info = eb->fs_info;
 	csum_size = btrfs_super_csum_size(fs_info->super_copy);
 
-	/* the pending IO might have been the only thing that kept this buffer
-	 * in memory.  Make sure we have a ref for all this other checks
-	 */
-	atomic_inc(&eb->refs);
-
-	reads_done = atomic_dec_and_test(&eb->io_pages);
-	if (!reads_done)
-		goto err;
-
-	eb->read_mirror = mirror;
-	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
-		ret = -EIO;
-		goto err;
-	}
-
 	found_start = btrfs_header_bytenr(eb);
 	if (found_start != eb->start) {
 		btrfs_err_rl(fs_info, "bad tree block start, want %llu have %llu",
 			     eb->start, found_start);
 		ret = -EIO;
-		goto err;
+		goto out;
 	}
 	if (check_tree_block_fsid(eb)) {
 		btrfs_err_rl(fs_info, "bad fsid on block %llu",
 			     eb->start);
 		ret = -EIO;
-		goto err;
+		goto out;
 	}
 	found_level = btrfs_header_level(eb);
 	if (found_level >= BTRFS_MAX_LEVEL) {
 		btrfs_err(fs_info, "bad tree block level %d on %llu",
 			  (int)btrfs_header_level(eb), eb->start);
 		ret = -EIO;
-		goto err;
+		goto out;
 	}
 
 	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb),
@@ -647,7 +624,7 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 			      fs_info->sb->s_id, eb->start,
 			      val, found, btrfs_header_level(eb));
 		ret = -EUCLEAN;
-		goto err;
+		goto out;
 	}
 
 	/*
@@ -669,6 +646,40 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 		btrfs_err(fs_info,
 			  "block=%llu read time tree block corruption detected",
 			  eb->start);
+out:
+	return ret;
+}
+
+static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
+				      u64 phy_offset, struct page *page,
+				      u64 start, u64 end, int mirror)
+{
+	struct extent_buffer *eb;
+	int ret = 0;
+	bool reads_done;
+
+	/* Metadata pages that goes through IO should all have private set */
+	ASSERT(PagePrivate(page) && page->private);
+	eb = (struct extent_buffer *)page->private;
+
+	/*
+	 * The pending IO might have been the only thing that kept this buffer
+	 * in memory.  Make sure we have a ref for all this other checks
+	 */
+	atomic_inc(&eb->refs);
+
+	reads_done = atomic_dec_and_test(&eb->io_pages);
+	if (!reads_done)
+		goto err;
+
+	eb->read_mirror = mirror;
+	if (test_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags)) {
+		ret = -EIO;
+		goto err;
+	}
+
+	ret = btrfs_check_extent_buffer(eb);
+
 err:
 	if (reads_done &&
 	    test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
@@ -684,7 +695,6 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 		clear_extent_buffer_uptodate(eb);
 	}
 	free_extent_buffer(eb);
-out:
 	return ret;
 }
 
-- 
2.28.0

