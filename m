Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8485B2B1B62
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKMMwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:46818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKMMwY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6+RDFSTbusZ93E3/Gy4cLLAHDT7LskRK0DtGeuDMyc=;
        b=J2sph9yeGWwcpi+c2cFG8CpeifTftqGjQGY32kP8KhZeo0/xyGAdESAKrN/YaX+OiPjPtb
        +kdaHY9+biAriLXBBWroDX6mPhqqdVGL5bLUwSoT0L/KuiPh9MsUhoWBhcxnP+jqWq4I1K
        +uE/hXhgf1qV0rqktT5v6ovY2uFFOC4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A0A3ABD6;
        Fri, 13 Nov 2020 12:52:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2 09/24] btrfs: extent_io: calculate inline extent buffer page size based on page size
Date:   Fri, 13 Nov 2020 20:51:34 +0800
Message-Id: <20201113125149.140836-10-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 7 +------
 fs/btrfs/extent_io.h | 8 +++++---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 37dd103213f9..ca3eb095a298 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5042,12 +5042,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	atomic_set(&eb->refs, 1);
 	atomic_set(&eb->io_pages, 0);
 
-	/*
-	 * Sanity checks, currently the maximum is 64k covered by 16x 4k pages
-	 */
-	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
-		> MAX_INLINE_EXTENT_BUFFER_SIZE);
-	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
+	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
 
 	return eb;
 }
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index c76697fc3120..dfdef9c5c379 100644
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

