Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14A703DAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbjEOTYQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbjEOTXk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:23:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12711DA9
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hs1gUnlU18fPsbLjSnSMBCTQbCPL4u4RPh2nLcXhA6g=; b=wDDpx6h0/HKjk7IpvbbF8aSk5V
        fQ6JDf7KK4TDRcbd4S2jdcb35yOQlGWzOj4qJk8KK7z2+un4u7zBZ+V7XYnF1CfKDNokwc1wW8hf4
        M71QzhXhA33cIUB/ZNKxmgb3pZG/WCCxMpdfeQdBQ3hfoaLozZQtfepq32SPsy+TZAUZ4GvtDBFgF
        vs7yDx8zM3W/1Fuxxxgyyf1DwzRHQsakdo/6Q0tZmH/he2SfiuaqjmLV4626FeiY0wHYPgtkENKzW
        jzp7tj3spGYQvYVgGCQXQmo1hID+qwSIHwhOq7KgBFx7op/QJKalzj35NdD65166b638wLdwCqKNm
        kW8jIeRQ==;
Received: from [2001:4bb8:188:2249:ad42:acf3:6731:a041] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pydn8-003HIq-2f;
        Mon, 15 May 2023 19:23:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: bypass filemap_fdatawrite_range in btrfs_write_buffers
Date:   Mon, 15 May 2023 21:22:56 +0200
Message-Id: <20230515192256.29006-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515192256.29006-1-hch@lst.de>
References: <20230515192256.29006-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_write_buffers already has a pointer to each extent_buffer it needs
to write.  Instead of going through filemap_fdatawrite_range to look up
each page in the buffer, just to cycle back to the buffer for writing
it, just call write_one_eb directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_buffer.c | 17 +++++++++++++----
 fs/btrfs/extent_buffer.h |  3 +++
 fs/btrfs/extent_io.c     |  6 +++---
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_buffer.c b/fs/btrfs/extent_buffer.c
index 70a6a5f2e0e0a8..8d0802d2ab004e 100644
--- a/fs/btrfs/extent_buffer.c
+++ b/fs/btrfs/extent_buffer.c
@@ -8,6 +8,7 @@
 #include "extent_io.h"
 #include "fs.h"
 #include "transaction.h"
+#include "zoned.h"
 
 void btrfs_add_to_dirty_buffers_list(struct extent_buffer *eb,
 				     struct btrfs_transaction *trans,
@@ -44,20 +45,28 @@ static int extent_buffer_cmp(void *priv, const struct list_head *a,
 
 int btrfs_write_buffers(struct btrfs_fs_info *fs_info, struct list_head *list)
 {
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct dirty_buffer *db;
+	struct writeback_control wbc = {
+		.sync_mode	= WB_SYNC_ALL,
+		.nr_to_write	= LONG_MAX,
+	};
 	int werr = 0, err;
 
 	list_sort(NULL, list, extent_buffer_cmp);
 
+	btrfs_zoned_meta_io_lock(fs_info);
 	list_for_each_entry(db, list, wb_entry) {
-		err = filemap_fdatawrite_range(mapping, db->eb->start,
-					       db->eb->start + db->eb->len - 1);
-		if (err)
+		err = write_one_eb(db->eb, &wbc, NULL);
+		if (err < 0) {
 			werr = err;
+			break;
+		}
 		cond_resched();
 	}
+	btrfs_zoned_meta_io_unlock(fs_info);
 
+	if (!werr && BTRFS_FS_ERROR(fs_info))
+		return -EROFS;
 	return werr;
 }
 
diff --git a/fs/btrfs/extent_buffer.h b/fs/btrfs/extent_buffer.h
index 880b325d7b411a..c521685d7ca85c 100644
--- a/fs/btrfs/extent_buffer.h
+++ b/fs/btrfs/extent_buffer.h
@@ -7,6 +7,7 @@ struct btrfs_fs_info;
 struct btrfs_root;
 struct btrfs_transaction;
 struct list_head;
+struct writeback_control;
 
 struct dirty_buffer {
 	struct list_head wb_entry;
@@ -19,5 +20,7 @@ void btrfs_add_to_dirty_buffers_list(struct extent_buffer *eb,
 int btrfs_write_buffers(struct btrfs_fs_info *fs_info, struct list_head *list);
 int btrfs_wait_buffers(struct btrfs_fs_info *fs_info, struct list_head *list);
 void btrfs_release_buffers(struct list_head *list);
+int write_one_eb(struct extent_buffer *eb, struct writeback_control *wbc,
+		 struct extent_buffer **eb_context);
 
 #endif /* BTRFS_EXTENT_BUFFER_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c291fc728db047..28078dd4acd99a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -15,6 +15,7 @@
 #include <linux/prefetch.h>
 #include <linux/fsverity.h>
 #include "misc.h"
+#include "extent_buffer.h"
 #include "extent_io.h"
 #include "extent-io-tree.h"
 #include "extent_map.h"
@@ -1759,9 +1760,8 @@ static void prepare_eb_write(struct extent_buffer *eb)
 	}
 }
 
-static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
-					   struct writeback_control *wbc,
-					   struct extent_buffer **eb_context)
+int write_one_eb(struct extent_buffer *eb, struct writeback_control *wbc,
+		 struct extent_buffer **eb_context)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_block_group *zoned_bg = NULL;
-- 
2.39.2

