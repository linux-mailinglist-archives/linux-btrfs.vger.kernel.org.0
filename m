Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277CF529FB9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbiEQKsA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344652AbiEQKrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 06:47:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F303FBEA
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 03:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2619AB81803
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 10:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625C5C34113
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652784455;
        bh=oCpBUN/kXXIEBa4acvsidnBZ6ffgjardAGo5u7gFNyE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O82LS9WckcMcWQc8IhIbNl0dEWMpDSUf86cq1fZB6nPkFuZkQaVGQIlaNIBMBLEw+
         LvPoLj6qy+VLutbsOFxKNEfuvA+SHyXqGeBYl91Ix/0wvuXmNM5JznuYy036EzNvjH
         dxwFwEzurUZ9vPS9/eh1AHiy7xKn/cPlcUjZfG5yXsJyP0jDKUKPRVKJx67gq2x62B
         oNEAu+r9S+DN/QGOFL78M5H9N3y6IECedYJmkpydipnxruH1LYcLX+t9Lt+L4Q+uIp
         bGj0VawvK6v2OrFepfhMkgYhOQmzXZYvXV0MDVuMUjhV+BG9S0d7WxSDwwWusWd27k
         nCf30A/0D0ziA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: send: avoid trashing the page cache
Date:   Tue, 17 May 2022 11:47:30 +0100
Message-Id: <2bab1466c746d6162a24cd8f31adb6b6fe954787.1652784088.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652784088.git.fdmanana@suse.com>
References: <cover.1652784088.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

A send operation reads extent data using the buffered IO path for getting
extent data to send in write commands and this is both because it's simple
and to make use of the generic readahead infrastructure, which results in
a massive speedup.

However this fills the page cache with data that, most of the time, is
really only used by the send operation - once the write commands are sent,
it's not useful to have the data in the page cache anymore. For large
snapshots, bringing all data into the page cache eventually leads to the
need to evict other data from the page cache that may be more useful for
applications (and kernel susbsystems).

Even if extents are shared with the subvolume on which a snapshot is based
on and the data is currently on the page cache due to being read through
the subvolume, attempting to read the data through the snapshot will
always result in bringing a new copy of the data into another location in
the page cache (there's currently no shared memory for shared extents).

So make send evict the data it has read before if when it first opened
the inode, its mapping had no pages currently loaded: when
inode->i_mapping->nr_pages has a value of 0. Do this instead of deciding
based on the return value of filemap_range_has_page() before reading an
extent because the generic readahead mechanism may read pages beyond the
range we request (and it very often does it), which means a call to
filemap_range_has_page() will return true due to the readahead that was
triggered when processing a previous extent - we don't have a simple way
to distinguish this case from the case where the data was brought into
the page cache through someone else. So checking for the mapping number
of pages being 0 when we first open the inode is simple, cheap and it
generally accomplishes the goal of not trashing the page cache - the
only exception is if part of data was previously loaded into the page
cache through the snapshot by some other process, in that case we end
up not evicting any data send brings into the page cache, just like
before this change - but that however is not the common case.

Example scenario, on a box with 32G of RAM:

  $ btrfs subvolume create /mnt/sv1
  $ xfs_io -f -c "pwrite 0 4G" /mnt/sv1/file1

  $ btrfs subvolume snapshot -r /mnt/sv1 /mnt/snap1

  $ free -m
                 total        used        free      shared  buff/cache   available
  Mem:           31937         186       26866           0        4883       31297
  Swap:           8188           0        8188

  # After this we get less 4G of free memory.
  $ btrfs send /mnt/snap1 >/dev/null

  $ free -m
                 total        used        free      shared  buff/cache   available
  Mem:           31937         186       22814           0        8935       31297
  Swap:           8188           0        8188

The same, obviously, applies to an incremental send.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 55275ba90cb4..5a05beabf0c3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -137,6 +137,8 @@ struct send_ctx {
 	 */
 	struct inode *cur_inode;
 	struct file_ra_state ra;
+	u64 page_cache_clear_start;
+	bool clean_page_cache;
 
 	/*
 	 * We process inodes by their increasing order, so if before an
@@ -5139,6 +5141,7 @@ static int send_extent_data(struct send_ctx *sctx,
 			    const u64 offset,
 			    const u64 len)
 {
+	const u64 end = offset + len;
 	u64 read_size = max_send_read_size(sctx);
 	u64 sent = 0;
 
@@ -5157,6 +5160,28 @@ static int send_extent_data(struct send_ctx *sctx,
 		}
 		memset(&sctx->ra, 0, sizeof(struct file_ra_state));
 		file_ra_state_init(&sctx->ra, sctx->cur_inode->i_mapping);
+
+		/*
+		 * It's very likely there are no pages from this inode in the page
+		 * cache, so after reading extents and sending their data, we clean
+		 * the page cache to avoid trashing the page cache (adding pressure
+		 * to the page cache and forcing eviction of other data more useful
+		 * for applications).
+		 *
+		 * We decide if we should clean the page cache simply by checking
+		 * if the inode's mapping nrpages is 0 when we first open it, and
+		 * not by using something like filemap_range_has_page() before
+		 * reading an extent because when we ask the readahead code to
+		 * read a given file range, it may (and almost always does) read
+		 * pages from beyond that range (see the documentation for
+		 * page_cache_sync_readahead()), so it would not be reliable,
+		 * because after reading the first extent future calls to
+		 * filemap_range_has_page() would return true because the readahead
+		 * on the previous extent resulted in reading pages of the current
+		 * extent as well.
+		 */
+		sctx->clean_page_cache = (sctx->cur_inode->i_mapping->nrpages == 0);
+		sctx->page_cache_clear_start = round_down(offset, PAGE_SIZE);
 	}
 
 	while (sent < len) {
@@ -5168,6 +5193,37 @@ static int send_extent_data(struct send_ctx *sctx,
 			return ret;
 		sent += size;
 	}
+
+	if (sctx->clean_page_cache && IS_ALIGNED(end, PAGE_SIZE)) {
+		/*
+		 * Always operate only on ranges that are a multiple of the page
+		 * size. This is not only to prevent zeroing parts of a page in
+		 * the case of subpage sector size, but also to guarantee we evict
+		 * pages, as passing a range that is smaller than page size does
+		 * not evict the respective page (only zeroes part of its content).
+		 *
+		 * Always start from the end offset of the last range cleared.
+		 * This is because the readahead code may (and very often does)
+		 * reads pages beyond the range we request for readahead. So if
+		 * we have an extent layout like this:
+		 *
+		 *            [ extent A ] [ extent B ] [ extent C ]
+		 *
+		 * When we ask page_cache_sync_readahead() to read extent A, it
+		 * may also trigger reads for pages of extent B. If we are doing
+		 * an incremental send and extent B has not changed between the
+		 * parent and send snapshots, some or all of its pages may end
+		 * up being read and placed in the page cache. So when truncating
+		 * the page cache we always start from the end offset of the
+		 * previously processed extent up to the end of the current
+		 * extent.
+		 */
+		truncate_inode_pages_range(&sctx->cur_inode->i_data,
+					   sctx->page_cache_clear_start,
+					   end - 1);
+		sctx->page_cache_clear_start = end;
+	}
+
 	return 0;
 }
 
@@ -6172,6 +6228,30 @@ static int btrfs_unlink_all_paths(struct send_ctx *sctx)
 	return ret;
 }
 
+static void close_current_inode(struct send_ctx *sctx)
+{
+	u64 i_size;
+
+	if (sctx->cur_inode == NULL)
+		return;
+
+	i_size = i_size_read(sctx->cur_inode);
+
+	/*
+	 * If we are doing an incremental send, we may have extents between the
+	 * last processed extent and the i_size that have not been processed
+	 * because they haven't changed but we may have read some of their pages
+	 * through readahead, see the comments at send_extent_data().
+	 */
+	if (sctx->clean_page_cache && sctx->page_cache_clear_start < i_size)
+		truncate_inode_pages_range(&sctx->cur_inode->i_data,
+					   sctx->page_cache_clear_start,
+					   round_up(i_size, PAGE_SIZE) - 1);
+
+	iput(sctx->cur_inode);
+	sctx->cur_inode = NULL;
+}
+
 static int changed_inode(struct send_ctx *sctx,
 			 enum btrfs_compare_tree_result result)
 {
@@ -6182,8 +6262,7 @@ static int changed_inode(struct send_ctx *sctx,
 	u64 left_gen = 0;
 	u64 right_gen = 0;
 
-	iput(sctx->cur_inode);
-	sctx->cur_inode = NULL;
+	close_current_inode(sctx);
 
 	sctx->cur_ino = key->objectid;
 	sctx->cur_inode_new_gen = 0;
@@ -7671,7 +7750,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 		name_cache_free(sctx);
 
-		iput(sctx->cur_inode);
+		close_current_inode(sctx);
 
 		kfree(sctx);
 	}
-- 
2.35.1

