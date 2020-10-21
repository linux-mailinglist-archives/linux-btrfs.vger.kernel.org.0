Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AE129482E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440749AbgJUG0i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408709AbgJUG0h (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2vdyEZwJ7LfD4eWqr8u00vys8zxlpS2fn0cgrxYhVFs=;
        b=F5uO7Ge6k7XsFmhjLIFxDOPnXxVHBomhqFN0Z4HulkJAy07+/OmrcCxbEchzYH2T/ykPmq
        gOnKIQMX3/9jbNvS1g/vs2QlVVjN0b0FbR2zopgGwS8kVDNt7vlpekCMxG5qmhC3pw6/BY
        7J6UZwyY4pYWtkEcbr7me4D8alSYlmQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E94A0AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 18/68] btrfs: extent_io: calculate inline extent buffer page size based on page size
Date:   Wed, 21 Oct 2020 14:25:04 +0800
Message-Id: <20201021062554.68132-19-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
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
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0d5d0581af06..6e33fa1645c3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5020,9 +5020,9 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	/*
 	 * Sanity checks, currently the maximum is 64k covered by 16x 4k pages
 	 */
-	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE
-		> MAX_INLINE_EXTENT_BUFFER_SIZE);
-	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
+	BUILD_BUG_ON(BTRFS_MAX_METADATA_BLOCKSIZE >
+		     INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE);
+	BUG_ON(len > BTRFS_MAX_METADATA_BLOCKSIZE);
 
 #ifdef CONFIG_BTRFS_DEBUG
 	eb->spinning_writers = 0;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 3c9252b429e0..e588b3100ede 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -85,9 +85,11 @@ struct extent_io_ops {
 				    int mirror);
 };
 
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
2.28.0

