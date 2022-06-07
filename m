Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4B5402B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245544AbiFGPrC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242318AbiFGPrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 11:47:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642AF1376
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 08:46:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 786B21F916;
        Tue,  7 Jun 2022 15:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654616818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=g6sfHKIIGNtzzdXFcdTIdDRZa3plWQGLUhH9OxL0f+I=;
        b=Evvg3MjnfoojPmlNEaXet3r4TLt8ZBveBPDM2HJ3TWvQdF7vMavZQI1NqQt7ySb+nGED05
        pLAyzIixuBLZ0EJPGDKWcGan2klhfcdLyeHLaMur6UOzFGDhAvKc2pyD2VwtTkJcTe+rC7
        OeZS6eC/iJTDESfoTZC2xHKvX7yGBpE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6FF892C141;
        Tue,  7 Jun 2022 15:46:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6F432DA8EA; Tue,  7 Jun 2022 17:42:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use preallocated page for super block write
Date:   Tue,  7 Jun 2022 17:42:29 +0200
Message-Id: <20220607154229.9164-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the super block page is from the mapping of the block device,
this is result of direct conversion from the previous buffer_head to bio
conversion.  We don't use the page cache or the mapping anywhere else,
the page is a temporary space for the associated bio.

Allocate the page at device allocation time, also to avoid any later
allocation problems when writing the super block. This simplifies the
page reference tracking, but the page lock is still used as waiting
mechanism for the write and write error is tracked in the page.

This was inspired by Matthew's question
https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 42 +++++++++++-------------------------------
 fs/btrfs/volumes.c |  6 ++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0f926d18e6ca..d10ad62ba54d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3873,7 +3873,6 @@ static void btrfs_end_super_write(struct bio *bio)
 			SetPageUptodate(page);
 		}
 
-		put_page(page);
 		unlock_page(page);
 	}
 
@@ -3960,7 +3959,6 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3975,7 +3973,6 @@ static int write_dev_supers(struct btrfs_device *device,
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
 		struct bio *bio;
-		struct btrfs_super_block *disk_super;
 
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
@@ -3998,21 +3995,17 @@ static int write_dev_supers(struct btrfs_device *device,
 				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
 				    sb->csum);
 
-		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
-					   GFP_NOFS);
-		if (!page) {
-			btrfs_err(device->fs_info,
-			    "couldn't get super block page for bytenr %llu",
-			    bytenr);
-			errors++;
-			continue;
-		}
-
-		/* Bump the refcount for wait_dev_supers() */
-		get_page(page);
+		/*
+		 * Super block is copied to a temporary page, which is locked
+		 * and submitted for write. Page is unlocked after IO finishes.
+		 * No page references are needed, write error is returned as
+		 * page Error bit.
+		 */
+		page = device->sb_write_page;
+		ClearPageError(page);
+		lock_page(page);
 
-		disk_super = page_address(page);
-		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
+		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
 		 * Directly use bios here instead of relying on the page cache
@@ -4079,14 +4072,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		    device->commit_total_bytes)
 			break;
 
-		page = find_get_page(device->bdev->bd_inode->i_mapping,
-				     bytenr >> PAGE_SHIFT);
-		if (!page) {
-			errors++;
-			if (i == 0)
-				primary_failed = true;
-			continue;
-		}
+		page = device->sb_write_page;
 		/* Page is submitted locked and unlocked once the IO completes */
 		wait_on_page_locked(page);
 		if (PageError(page)) {
@@ -4094,12 +4080,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 			if (i == 0)
 				primary_failed = true;
 		}
-
-		/* Drop our reference */
-		put_page(page);
-
-		/* Drop the reference from the writing run */
-		put_page(page);
 	}
 
 	/* log error, force error return */
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7513e45c0c42..a9588c52c1f3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -394,6 +394,7 @@ void btrfs_free_device(struct btrfs_device *device)
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
+	__free_page(device->sb_write_page);
 	kfree(device);
 }
 
@@ -6910,6 +6911,11 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
+	dev->sb_write_page = alloc_page(GFP_KERNEL);
+	if (!dev->sb_write_page) {
+		kfree(dev);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	INIT_LIST_HEAD(&dev->dev_list);
 	INIT_LIST_HEAD(&dev->dev_alloc_list);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a3c3a0d716bd..4a6c4a5f6fe6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -158,6 +158,8 @@ struct btrfs_device {
 	/* Bio used for flushing device barriers */
 	struct bio flush_bio;
 	struct completion flush_wait;
+	/* Temporary page for writing the superblock */
+	struct page *sb_write_page;
 
 	/* per-device scrub information */
 	struct scrub_ctx *scrub_ctx;
-- 
2.36.1

