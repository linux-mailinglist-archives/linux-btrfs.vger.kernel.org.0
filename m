Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB72EB75D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 02:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbhAFBDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jan 2021 20:03:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbhAFBDj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 20:03:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609894935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QspT6/PdQkfmpUkgZiQ9/syrhdKXN5Tk+piRLLSbStE=;
        b=Lm/Q3Ky2iKXitDu84LwC67f3rT0MrSllvocPZKD9wjGcUuE9weC8VIc1tVeUeqJGdLM/am
        jwkTxpl46k0AvoxI8/ZOQ4GoH0xKKnXx9ErtDAPxEOrRc2WNSNN9Ris71tRztCwExFgdkR
        FzTSqS6zGX/6i114htNDRtrpO1TUEys=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B010AF30
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 01:02:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 05/22] btrfs: extent_io: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK into PAGE_START_WRITEBACK
Date:   Wed,  6 Jan 2021 09:01:44 +0800
Message-Id: <20210106010201.37864-6-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106010201.37864-1-wqu@suse.com>
References: <20210106010201.37864-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK are two macros used in
__process_pages_contig(), to inform the function to clear page dirty and
then set page writeback.

However page write back and dirty are two conflict status (at least for
sector size == PAGE_SIZE case), this means those two macros are always
called together.

This means we can merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK, into
one macro, PAGE_START_WRITEBACK.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  4 ++--
 fs/btrfs/extent_io.h | 12 ++++++------
 fs/btrfs/inode.c     | 28 ++++++++++------------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 098c68583ebb..a2a9c2148e91 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1970,10 +1970,10 @@ static int __process_pages_contig(struct address_space *mapping,
 			if (page_ops & PAGE_SET_PRIVATE2)
 				SetPagePrivate2(pages[i]);
 
-			if (page_ops & PAGE_CLEAR_DIRTY)
+			if (page_ops & PAGE_START_WRITEBACK) {
 				clear_page_dirty_for_io(pages[i]);
-			if (page_ops & PAGE_SET_WRITEBACK)
 				set_page_writeback(pages[i]);
+			}
 			if (page_ops & PAGE_SET_ERROR)
 				SetPageError(pages[i]);
 			if (page_ops & PAGE_END_WRITEBACK)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 19221095c635..bedf761a0300 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -35,12 +35,12 @@ enum {
 
 /* these are flags for __process_pages_contig */
 #define PAGE_UNLOCK		(1 << 0)
-#define PAGE_CLEAR_DIRTY	(1 << 1)
-#define PAGE_SET_WRITEBACK	(1 << 2)
-#define PAGE_END_WRITEBACK	(1 << 3)
-#define PAGE_SET_PRIVATE2	(1 << 4)
-#define PAGE_SET_ERROR		(1 << 5)
-#define PAGE_LOCK		(1 << 6)
+/* This one will clera page dirty and then set paeg writeback */
+#define PAGE_START_WRITEBACK	(1 << 1)
+#define PAGE_END_WRITEBACK	(1 << 2)
+#define PAGE_SET_PRIVATE2	(1 << 3)
+#define PAGE_SET_ERROR		(1 << 4)
+#define PAGE_LOCK		(1 << 5)
 
 /*
  * page->private values.  Every page that is controlled by the extent
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9c2800fa80c6..ecc1f1f60b48 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -692,8 +692,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 						     NULL,
 						     clear_flags,
 						     PAGE_UNLOCK |
-						     PAGE_CLEAR_DIRTY |
-						     PAGE_SET_WRITEBACK |
+						     PAGE_START_WRITEBACK |
 						     page_error_op |
 						     PAGE_END_WRITEBACK);
 
@@ -934,8 +933,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				async_extent->start +
 				async_extent->ram_size - 1,
 				NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
-				PAGE_UNLOCK | PAGE_CLEAR_DIRTY |
-				PAGE_SET_WRITEBACK);
+				PAGE_UNLOCK | PAGE_START_WRITEBACK);
 		if (btrfs_submit_compressed_write(inode, async_extent->start,
 				    async_extent->ram_size,
 				    ins.objectid,
@@ -971,9 +969,8 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW |
 				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
-				     PAGE_UNLOCK | PAGE_CLEAR_DIRTY |
-				     PAGE_SET_WRITEBACK | PAGE_END_WRITEBACK |
-				     PAGE_SET_ERROR);
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK | PAGE_SET_ERROR);
 	free_async_extent_pages(async_extent);
 	kfree(async_extent);
 	goto again;
@@ -1071,8 +1068,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 				     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
-				     PAGE_CLEAR_DIRTY | PAGE_SET_WRITEBACK |
-				     PAGE_END_WRITEBACK);
+				     PAGE_START_WRITEBACK | PAGE_END_WRITEBACK);
 			*nr_written = *nr_written +
 			     (end - start + PAGE_SIZE) / PAGE_SIZE;
 			*page_started = 1;
@@ -1194,8 +1190,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 out_unlock:
 	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
-	page_ops = PAGE_UNLOCK | PAGE_CLEAR_DIRTY | PAGE_SET_WRITEBACK |
-		PAGE_END_WRITEBACK;
+	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 	/*
 	 * If we reserved an extent for our delalloc range (or a subrange) and
 	 * failed to create the respective ordered extent, then it means that
@@ -1320,9 +1315,8 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		unsigned clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC |
 			EXTENT_DELALLOC_NEW | EXTENT_DEFRAG |
 			EXTENT_DO_ACCOUNTING;
-		unsigned long page_ops = PAGE_UNLOCK | PAGE_CLEAR_DIRTY |
-			PAGE_SET_WRITEBACK | PAGE_END_WRITEBACK |
-			PAGE_SET_ERROR;
+		unsigned long page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK |
+			PAGE_END_WRITEBACK | PAGE_SET_ERROR;
 
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     clear_bits, page_ops);
@@ -1519,8 +1513,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     EXTENT_LOCKED | EXTENT_DELALLOC |
 					     EXTENT_DO_ACCOUNTING |
 					     EXTENT_DEFRAG, PAGE_UNLOCK |
-					     PAGE_CLEAR_DIRTY |
-					     PAGE_SET_WRITEBACK |
+					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
 		return -ENOMEM;
 	}
@@ -1842,8 +1835,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					     locked_page, EXTENT_LOCKED |
 					     EXTENT_DELALLOC | EXTENT_DEFRAG |
 					     EXTENT_DO_ACCOUNTING, PAGE_UNLOCK |
-					     PAGE_CLEAR_DIRTY |
-					     PAGE_SET_WRITEBACK |
+					     PAGE_START_WRITEBACK |
 					     PAGE_END_WRITEBACK);
 	btrfs_free_path(path);
 	return ret;
-- 
2.29.2

