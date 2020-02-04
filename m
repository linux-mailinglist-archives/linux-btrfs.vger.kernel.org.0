Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F97151E26
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgBDQUM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:12 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46180 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbgBDQUM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:12 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so18440920qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=52t6rOpwsnqVyrMH/LAsYQfVFFu70ONfY9OAbr2AQNk=;
        b=BFMnaNvEdyncz6NkK0b6bUReiIz/IsFlvc9ki4IYT3y0gYC3GImjIolkb9Mkt7N13M
         pScQxhMEM2BuEMBGgP8ChVUum9/h64trhj6TPL9y9ti0v6MRxiQ5bK1oUMgOlH6emKeJ
         azSEFg8RcmQSfkD6Yi4xNKtaAvomeLPQeQPxVdRdnPbUh6yny0wg0fcLvZ1WLkfb5sA5
         Ve9h+7YZALq/+35j5ILFSObDJDCbHBhzK7T1DuVAXKYC8+CfW8cyoVkF+8o0oxDtBKVP
         YwvCsy+hkgBiAbcslNVzlIkC5v7n99UWGAv6FmDccKjaXt8H2q1jxbcccoQ4iFXAihrN
         uQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=52t6rOpwsnqVyrMH/LAsYQfVFFu70ONfY9OAbr2AQNk=;
        b=FmiTxpzr4fZoeYOvZF8n1jICsMm6CVckwXk/YzH9v1SGrJeuEvK50ZTI20Qg3tI9Fa
         dVkMWhYCCUa4XAmjlWetKUhx7ZGiT2XFvu2aqK8JyVb7OuLOP+CB28BbNYgdL37MU6Gh
         MPW3R1FNMj63gJYwZBXweWkSP834+cZYFdYM/Lla2yB4Gub2IwYWc3juOA2q/7+q+BF7
         q96p4e55+2LDuAogUpmLkFac+kdFZkQQjs9jXB3ODLu3lSi1iNbIKzdqwcsJg9IFwZHT
         rc16d3+7eDlaXSYI4w52s96gA1JBGlFQ99CDmWHytGfBnqEU9h15kIUecwuYxTgIJ2SE
         YIug==
X-Gm-Message-State: APjAAAXmzpdIun/zSjCE/ku2py4wY3ZS2Sm4PWW0owHS83rZhx5rwtf2
        jDRJKvT9jDT8bVnPV8n9SHoXTCDIVcYrgQ==
X-Google-Smtp-Source: APXvYqydS4mm/VJnLmDW81iWUgjWn61yry2irRVT/jYvYJPtWzJ6cPqPILAcY84xXSYB29RF0nivmQ==
X-Received: by 2002:a37:3ce:: with SMTP id 197mr29847439qkd.454.1580833210892;
        Tue, 04 Feb 2020 08:20:10 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z5sm5546215qta.7.2020.02.04.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/23] btrfs: use btrfs_start_delalloc_roots in shrink_delalloc
Date:   Tue,  4 Feb 2020 11:19:38 -0500
Message-Id: <20200204161951.764935-11-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The original iteration of flushing had us flushing delalloc and then
checking to see if we could make our reservation, thus we were very
careful about how many pages we would flush at once.

But now that everything is async and we satisfy tickets as the space
becomes available we don't have to keep track of any of this, simply try
and flush the number of dirty inodes we may have in order to reclaim
space to make our reservation.  This cleans up our delalloc flushing
significantly.

The async_pages stuff is dropped because btrfs_start_delalloc_roots()
handles the case that we generate async extents for us, so we no longer
require this extra logic.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 55 +------------------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5a92851af2b3..a69e3d9057ff 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -309,28 +309,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 	up_read(&info->groups_sem);
 }
 
-static void btrfs_writeback_inodes_sb_nr(struct btrfs_fs_info *fs_info,
-					 unsigned long nr_pages, u64 nr_items)
-{
-	struct super_block *sb = fs_info->sb;
-
-	if (down_read_trylock(&sb->s_umount)) {
-		writeback_inodes_sb_nr(sb, nr_pages, WB_REASON_FS_FREE_SPACE);
-		up_read(&sb->s_umount);
-	} else {
-		/*
-		 * We needn't worry the filesystem going from r/w to r/o though
-		 * we don't acquire ->s_umount mutex, because the filesystem
-		 * should guarantee the delalloc inodes list be empty after
-		 * the filesystem is readonly(all dirty pages are written to
-		 * the disk).
-		 */
-		btrfs_start_delalloc_roots(fs_info, nr_items);
-		if (!current->journal_info)
-			btrfs_wait_ordered_roots(fs_info, nr_items, 0, (u64)-1);
-	}
-}
-
 static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 					u64 to_reclaim)
 {
@@ -356,10 +334,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
-	u64 async_pages;
 	u64 items;
 	long time_left;
-	unsigned long nr_pages;
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
@@ -400,37 +376,8 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
 
 	loops = 0;
 	while ((delalloc_bytes || dio_bytes) && loops < 3) {
-		nr_pages = min(delalloc_bytes, to_reclaim) >> PAGE_SHIFT;
-
-		/*
-		 * Triggers inode writeback for up to nr_pages. This will invoke
-		 * ->writepages callback and trigger delalloc filling
-		 *  (btrfs_run_delalloc_range()).
-		 */
-		btrfs_writeback_inodes_sb_nr(fs_info, nr_pages, items);
-
-		/*
-		 * We need to wait for the compressed pages to start before
-		 * we continue.
-		 */
-		async_pages = atomic_read(&fs_info->async_delalloc_pages);
-		if (!async_pages)
-			goto skip_async;
-
-		/*
-		 * Calculate how many compressed pages we want to be written
-		 * before we continue. I.e if there are more async pages than we
-		 * require wait_event will wait until nr_pages are written.
-		 */
-		if (async_pages <= nr_pages)
-			async_pages = 0;
-		else
-			async_pages -= nr_pages;
+		btrfs_start_delalloc_roots(fs_info, items);
 
-		wait_event(fs_info->async_submit_wait,
-			   atomic_read(&fs_info->async_delalloc_pages) <=
-			   (int)async_pages);
-skip_async:
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets) &&
 		    list_empty(&space_info->priority_tickets)) {
-- 
2.24.1

