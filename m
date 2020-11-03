Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39C42A4687
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgKCNbz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:44748 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgKCNby (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E55vpWvLD/cUX0Q3r76Dq0AMCYLDovDQ2TcxfVHuIAY=;
        b=VRJFYisM8jZS1qOtZFCjOyesk3B5l5+y7I5eVe5xxgWLu3CGIjj+ixZ1Irbn2IWTuCGiBo
        sXdg9SWQZZEj2XwkprBOQx2GnZd8cDeeC/Uqg0jVLZjdRyaSwWU3IqGCWjxlEugKw+aJwu
        G4ZB045dV9odYJCuqR5o4LL4yPfyNNM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90C72AFA7
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:31:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/32] btrfs: disk-io: extract the extent buffer verification from btrfs_validate_metadata_buffer()
Date:   Tue,  3 Nov 2020 21:30:48 +0800
Message-Id: <20201103133108.148112-13-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_validate_metadata_buffer() only needs to handle one extent
buffer as currently one page only maps to one extent buffer.

But for incoming subpage support, one page can be mapped to multiple
extent buffers, thus we can no longer use current code.

This refactor would allow us to call validate_extent_buffer() on
all involved extent buffers at btrfs_validate_metadata_buffer() and other
locations.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 78 +++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9a72cb5ef31e..de9132564f10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -524,60 +524,35 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 	return 1;
 }
 
-int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
-				   struct page *page, u64 start, u64 end,
-				   int mirror)
+/* Do basic extent buffer check at read time */
+static int validate_extent_buffer(struct extent_buffer *eb)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 found_start;
-	int found_level;
-	struct extent_buffer *eb;
-	struct btrfs_fs_info *fs_info;
-	u16 csum_size;
-	int ret = 0;
+	u32 csum_size = fs_info->csum_size;
+	u8 found_level;
 	u8 result[BTRFS_CSUM_SIZE];
-	int reads_done;
-
-	if (!page->private)
-		goto out;
-
-	eb = (struct extent_buffer *)page->private;
-	fs_info = eb->fs_info;
-	csum_size = fs_info->csum_size;
-
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
+	int ret = 0;
 
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
@@ -596,7 +571,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
 			      CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb));
 		ret = -EUCLEAN;
-		goto err;
+		goto out;
 	}
 
 	/*
@@ -618,6 +593,39 @@ int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		btrfs_err(fs_info,
 			  "block=%llu read time tree block corruption detected",
 			  eb->start);
+out:
+	return ret;
+}
+
+int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
+				   struct page *page, u64 start, u64 end,
+				   int mirror)
+{
+	struct extent_buffer *eb;
+	int ret = 0;
+	int reads_done;
+
+	if (!page->private)
+		goto out;
+
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
+	ret = validate_extent_buffer(eb);
 err:
 	if (reads_done &&
 	    test_and_clear_bit(EXTENT_BUFFER_READAHEAD, &eb->bflags))
-- 
2.29.2

