Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE622A467D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgKCNbe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:44344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgKCNbe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06di7rCzkk0epVAhGb/Pa2gzvBm7s4XDPultbMkFD/E=;
        b=lDnVavnFvUiDGeYH1GYLL5QT4PzEeffJ3XJyHrcbIQMSAQ7RWBWYB84/KfVhRLhgFdLzqy
        VKijSLoUvforkFhsifzZpQsAFrwyCvmFfB+DCBTif9DO5SBloHfMiychxcEUEVZehBWtH1
        yQ8UYUkrwsrO5ORcNyd5RP3DlDTsBrY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC952ACC0;
        Tue,  3 Nov 2020 13:31:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/32] btrfs: extent_io: calculate inline extent buffer page size based on page size
Date:   Tue,  3 Nov 2020 21:30:42 +0800
Message-Id: <20201103133108.148112-7-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs only support 64K as max node size, thus for 4K page system, we
would have at most 16 pages for one extent buffer.

For a system using 64K page size, we would really have just one
single page.

While we always use 16 pages for extent_buffer::pages[], this means for
systems using 64K pages, we are wasting memory for the 15 pages which
will never be utilized.

So this patch will change how the extent_buffer::pages[] array size is
calclulated, now it will be calculated using
BTRFS_MAX_METADATA_BLOCKSIZE and PAGE_SIZE.

For systems using 4K page size, it will stay 16 pages.
For systems using 64K page size, it will be just 1 page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac396d8937b9..092d9f69abb2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4990,9 +4990,9 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	/*
 	 * Sanity checks, currently the maximum is 64k covered by 16x 4k pages
 	 */
-	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
-		> MAX_INLINE_EXTENT_BUFFER_SIZE);
-	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
+	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE >
+		     INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE);
+	BUG_ON(len > BTRFS_MAX_METADATA_BLOCKSIZE);
 
 	return eb;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5403354de0e1..123c3947be49 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -73,9 +73,11 @@ typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 
 typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
 		struct bio *bio, u64 bio_offset);
-
-#define INLINE_EXTENT_BUFFER_PAGES 16
-#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
+/*
+ * The SZ_64K is BTRFS_MAX_METADATA_BLOCKSIZE, here just to avoid circle
+ * including "ctree.h".
+ */
+#define INLINE_EXTENT_BUFFER_PAGES (SZ_64K / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
 	unsigned long len;
-- 
2.29.2

