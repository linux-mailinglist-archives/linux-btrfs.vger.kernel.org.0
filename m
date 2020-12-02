Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A792CB545
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 07:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgLBGtv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 01:49:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:53472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgLBGtv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Dec 2020 01:49:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606891713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+jAOG+tWlNV6MVdEr6707WrftUMSOW1PqCzDxCVrHY=;
        b=FzaFcK11Pv7BeSPi50SJuus+V+oeetVKzJwzvR1Ib1kQPpUlf5vdiEragepP76b//rtLHR
        JrgkxwG65+R0a0gra9TDEH3wMlzhpQjbMN9RYntRK8WIQ0qaslshwAAAvs7vRhwnKdSnP0
        YMCO0YdiSkhqFt3oFYxtANwmJLp26nU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30DACAEC1;
        Wed,  2 Dec 2020 06:48:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 05/15] btrfs: extent_io: calculate inline extent buffer page size based on page size
Date:   Wed,  2 Dec 2020 14:48:01 +0800
Message-Id: <20201202064811.100688-6-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202064811.100688-1-wqu@suse.com>
References: <20201202064811.100688-1-wqu@suse.com>
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

Since we're here, also move the definition of
BTRFS_MAX_METADATA_BLOCKSIZE to btrfs_tree.h, to avoid circle including
of ctree.h.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h                | 6 ------
 fs/btrfs/extent_io.c            | 7 +------
 fs/btrfs/extent_io.h            | 4 ++--
 include/uapi/linux/btrfs_tree.h | 4 ++++
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 112c9a2ae47b..c5ef29078954 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -67,12 +67,6 @@ struct btrfs_ref;
 
 #define BTRFS_OLDEST_GENERATION	0ULL
 
-/*
- * the max metadata block size.  This limit is somewhat artificial,
- * but the memmove costs go through the roof for larger blocks.
- */
-#define BTRFS_MAX_METADATA_BLOCKSIZE 65536
-
 /*
  * we can actually store much bigger names, but lets not confuse the rest
  * of linux
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b72c824064c..2bab66b42395 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5053,12 +5053,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
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
index db95468801c7..02b4786478b6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include <linux/refcount.h>
 #include <linux/fiemap.h>
+#include <linux/btrfs_tree.h>
 #include "ulist.h"
 
 /*
@@ -74,8 +75,7 @@ typedef blk_status_t (submit_bio_hook_t)(struct inode *inode, struct bio *bio,
 typedef blk_status_t (extent_submit_bio_start_t)(struct inode *inode,
 		struct bio *bio, u64 opt_file_offset);
 
-#define INLINE_EXTENT_BUFFER_PAGES 16
-#define MAX_INLINE_EXTENT_BUFFER_SIZE (INLINE_EXTENT_BUFFER_PAGES * PAGE_SIZE)
+#define INLINE_EXTENT_BUFFER_PAGES (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
 struct extent_buffer {
 	u64 start;
 	unsigned long len;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 6b885982ece6..44e22f935b8c 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -4,6 +4,7 @@
 
 #include <linux/btrfs.h>
 #include <linux/types.h>
+#include <linux/sizes.h>
 #ifdef __KERNEL__
 #include <linux/stddef.h>
 #else
@@ -990,4 +991,7 @@ struct btrfs_qgroup_limit_item {
 	__le64 rsv_excl;
 } __attribute__ ((__packed__));
 
+/* Maximum metadata block size (nodesize) */
+#define BTRFS_MAX_METADATA_BLOCKSIZE	SZ_64K
+
 #endif /* _BTRFS_CTREE_H_ */
-- 
2.29.2

