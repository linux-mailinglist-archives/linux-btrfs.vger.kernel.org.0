Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997393D5943
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhGZLhY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58000 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZLhX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D95901FE75;
        Mon, 26 Jul 2021 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=65ZmFVYF0w6fVxoEaL/GqHIJx7BD/VazCDUYwgFa/ew=;
        b=iewtgPd76Bo8HBNFPY2EDQjAY3P8+xTtwvgc3G2maypz05D+OsuU4v8guoYc/TFcDxH4LM
        /h2MUA6y7mIvHc1AjiwiJpCd5vJyb7shPJ+8yWAn4E8uOMZkiP2VkbaybZ3QoQJR0etMME
        ifXuaQYaFHDjslTpTgt5Cvqjz0tyLkU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D3174A3BDF;
        Mon, 26 Jul 2021 12:17:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 335B1DA8D8; Mon, 26 Jul 2021 14:15:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/10] btrfs: switch uptodate to bool in btrfs_writepage_endio_finish_ordered
Date:   Mon, 26 Jul 2021 14:15:08 +0200
Message-Id: <ea500ab6911d708d8c70fe5f7aa1556b4283b188.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The uptodate parameter should be bool, change the type.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h     | 2 +-
 fs/btrfs/extent_io.c | 8 ++++----
 fs/btrfs/inode.c     | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4a69aa604ac5..a822404eeaee 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3195,7 +3195,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
-					  u64 end, int uptodate);
+					  u64 end, bool uptodate);
 extern const struct dentry_operations btrfs_dentry_operations;
 extern const struct iomap_ops btrfs_dio_iomap_ops;
 extern const struct iomap_dio_ops btrfs_dio_ops;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1f947e24091a..f7e58c304fc9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2779,7 +2779,7 @@ static blk_status_t submit_read_repair(struct inode *inode,
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end)
 {
 	struct btrfs_inode *inode;
-	int uptodate = (err == 0);
+	const bool uptodate = (err == 0);
 	int ret = 0;
 
 	ASSERT(page && page->mapping);
@@ -3864,7 +3864,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		if (cur >= i_size) {
 			btrfs_writepage_endio_finish_ordered(inode, page, cur,
-							     end, 1);
+							     end, true);
 			break;
 		}
 
@@ -3914,7 +3914,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 				nr++;
 			else
 				btrfs_writepage_endio_finish_ordered(inode,
-						page, cur, cur + iosize - 1, 1);
+						page, cur, cur + iosize - 1, true);
 			cur += iosize;
 			continue;
 		}
@@ -4983,7 +4983,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			ret = __extent_writepage(page, &wbc_writepages, &epd);
 		else {
 			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
-					page, start, start + PAGE_SIZE - 1, 1);
+					page, start, start + PAGE_SIZE - 1, true);
 			unlock_page(page);
 		}
 		put_page(page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6089c5e7763c..43b1393eec67 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -972,7 +972,7 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 
 			p->mapping = inode->vfs_inode.i_mapping;
 			btrfs_writepage_endio_finish_ordered(inode, p, start,
-							     end, 0);
+							     end, false);
 
 			p->mapping = NULL;
 			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
@@ -3170,7 +3170,7 @@ static void finish_ordered_fn(struct btrfs_work *work)
 
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
-					  u64 end, int uptodate)
+					  u64 end, bool uptodate)
 {
 	trace_btrfs_writepage_end_io_hook(inode, start, end, uptodate);
 
-- 
2.31.1

