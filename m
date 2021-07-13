Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5280C3C6A59
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhGMGSg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbhGMGSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:36 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DDDB7221FB
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=431ulKoX7au0qj6KEAIP6jl3XJ9ihZfRfnwgKBE3Ou8=;
        b=sBDxxERX/F+Z6EM0CFVa1pKzdi6cSBx8NK+99WH4P26gOk2HCqJWBoDQlqnKF+LsvQrjLQ
        7extM1YN9CO8nIYMmwjkFpmMDzXqADenWXDCFkp4d7h20s9df7hCCII8FjTgAj2SoxukEH
        PNOnm1d4tgr0s4kaoFOQQZ4/P/aAeXw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2700D139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id wJqRNpAv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:44 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 21/27] btrfs: extract uncompressed async extent submission code into a new helper
Date:   Tue, 13 Jul 2021 14:15:10 +0800
Message-Id: <20210713061516.163318-22-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210713061516.163318-1-wqu@suse.com>
References: <20210713061516.163318-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, submit_uncompressed_range(), for async cow cases
where we fallback to cow.

There are some new modification introduced to the helper:

- Proper locked_page detection
  It's possible that the async_extent range doesn't cover the locked
  page.
  In that case we shouldn't unlock the locked page.

  In the new helper, we will ensure that we only unlock the locked page
  when:

  * The locked page covers part of the async_extent range
  * The locked page is not unlocked by cow_file_range() nor
    extent_write_locked_range()

  This also means extra comments are added focusing on the page locking.

- Add extra comment on some rare parameter used.
  We use @unlock_page = 0 for cow_file_range(), where only two call
  sites doing the same thing, including the new helper.

  It's definitely worthy some comments.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 76 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3e6ff2b2dded..1432e268c13e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -838,6 +838,43 @@ static void free_async_extent_pages(struct async_extent *async_extent)
 	async_extent->pages = NULL;
 }
 
+static int submit_uncompressed_range(struct btrfs_inode *inode,
+				     struct async_extent *async_extent,
+				     struct page *locked_page)
+{
+	u64 start = async_extent->start;
+	u64 end = async_extent->start + async_extent->ram_size - 1;
+	unsigned long nr_written = 0;
+	int page_started = 0;
+	int ret;
+
+	/*
+	 * Call cow_file_range() to run the delalloc range directly,
+	 * since we won't go to nocow or async path again.
+	 *
+	 * Also we call cow_file_range() with @unlock_page == 0, so that we
+	 * can directly submit them without interruption.
+	 */
+	ret = cow_file_range(inode, locked_page, start, end, &page_started,
+			     &nr_written, 0);
+	/* Inline extent inserted, page get unlocked and everything is done */
+	if (ret > 0) {
+		ret = 0;
+		goto out;
+	}
+	if (ret < 0) {
+		if (locked_page)
+			unlock_page(locked_page);
+		goto out;
+	}
+
+	ret = extent_write_locked_range(&inode->vfs_inode, start, end);
+	/* All pages will be unlocked, including @locked_page */
+out:
+	kfree(async_extent);
+	return ret;
+}
+
 static int submit_one_async_extent(struct btrfs_inode *inode,
 				   struct async_chunk *async_chunk,
 				   struct async_extent *async_extent,
@@ -847,38 +884,29 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key ins;
+	struct page *locked_page = NULL;
 	struct extent_map *em;
 	int ret = 0;
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
+	/*
+	 * If async_chunk->locked_page is in the async_extent range, we
+	 * need to handle it.
+	 */
+	if (async_chunk->locked_page) {
+		u64 locked_page_start = page_offset(async_chunk->locked_page);
+		u64 locked_page_end = locked_page_start + PAGE_SIZE - 1;
+
+		if (!(start >= locked_page_end || end <= locked_page_start))
+			locked_page = async_chunk->locked_page;
+	}
 	lock_extent(io_tree, start, end);
 
 	/* We have fall back to uncompressed write */
-	if (!async_extent->pages) {
-		int page_started = 0;
-		unsigned long nr_written = 0;
-
-		/*
-		 * Call cow_file_range() to run the delalloc range directly,
-		 * since we won't go to nocow or async path again.
-		 */
-		ret = cow_file_range(inode, async_chunk->locked_page,
-				     start, end, &page_started, &nr_written, 0);
-		/*
-		 * If @page_started, cow_file_range() inserted an
-		 * inline extent and took care of all the unlocking
-		 * and IO for us.  Otherwise, we need to submit
-		 * all those pages down to the drive.
-		 */
-		if (!page_started && !ret)
-			extent_write_locked_range(&inode->vfs_inode, start,
-						  end);
-		else if (ret && async_chunk->locked_page)
-			unlock_page(async_chunk->locked_page);
-		kfree(async_extent);
-		return ret;
-	}
+	if (!async_extent->pages)
+		return submit_uncompressed_range(inode, async_extent,
+						 locked_page);
 
 	ret = btrfs_reserve_extent(root, async_extent->ram_size,
 				   async_extent->compressed_size,
-- 
2.32.0

