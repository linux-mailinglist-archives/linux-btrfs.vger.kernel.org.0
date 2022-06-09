Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D88454525E
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jun 2022 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344942AbiFIQvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiFIQvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 12:51:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EFE10D302
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 09:51:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9CB1B21FDA;
        Thu,  9 Jun 2022 16:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654793460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=c/sBHe4vXjNln8lEs74cGwdNZ33sJqIHdtgdYztetcQ=;
        b=OPjym6QsCYY7CyHu0Mb0/9v+mnaK/EKdCAkQzdY4gH7zUSah99f49f0f66DlJ1OxTMdtaI
        ocYLnlMRJlK9U3mJnegCUNOVsvN7RUsImB760sFH9P1koP6W5NQWLqRl23TMPbA8HRr4aO
        920OSm+spX5XCs9UTwtVrSEDFrJTfZA=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 924442C141;
        Thu,  9 Jun 2022 16:51:00 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28E73DA883; Thu,  9 Jun 2022 18:46:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org, nborisov@suse.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: use preallocated pages for super block write
Date:   Thu,  9 Jun 2022 18:46:29 +0200
Message-Id: <20220609164629.30316-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the super block page is from the mapping of the block device,
this is result of direct conversion from the previous buffer_head to bio
API.  We don't use the page cache or the mapping anywhere else, the page
is a temporary space for the associated bio.

Allocate pages for all super block copies at device allocation time,
also to avoid any later allocation problems when writing the super
block. This simplifies the page reference tracking, but the page lock is
still used as waiting mechanism for the write and write error is tracked
in the page.

As there is a separate page for each super block copy all can be
submitted in parallel, as before.

This was inspired by Matthew's question
https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/

Signed-off-by: David Sterba <dsterba@suse.com>
---

v2:

- allocate 3 pages per device to keep parallelism, otherwise the
  submission would be serialized on the page lock

fs/btrfs/disk-io.c | 42 +++++++++++-------------------------------
 fs/btrfs/volumes.c | 12 ++++++++++++
 fs/btrfs/volumes.h |  3 +++
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68e..8a9c7a868727 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3887,7 +3887,6 @@ static void btrfs_end_super_write(struct bio *bio)
 			SetPageUptodate(page);
 		}
 
-		put_page(page);
 		unlock_page(page);
 	}
 
@@ -3974,7 +3973,6 @@ static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int errors = 0;
@@ -3989,7 +3987,6 @@ static int write_dev_supers(struct btrfs_device *device,
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
 		struct bio *bio;
-		struct btrfs_super_block *disk_super;
 
 		bytenr_orig = btrfs_sb_offset(i);
 		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
@@ -4012,21 +4009,17 @@ static int write_dev_supers(struct btrfs_device *device,
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
+		page = device->sb_write_page[i];
+		ClearPageError(page);
+		lock_page(page);
 
-		disk_super = page_address(page);
-		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
+		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
 
 		/*
 		 * Directly use bios here instead of relying on the page cache
@@ -4093,14 +4086,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
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
+		page = device->sb_write_page[i];
 		/* Page is submitted locked and unlocked once the IO completes */
 		wait_on_page_locked(page);
 		if (PageError(page)) {
@@ -4108,12 +4094,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
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
index 12a6150ee19d..a00546d2c7ea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -394,6 +394,8 @@ void btrfs_free_device(struct btrfs_device *device)
 	rcu_string_free(device->name);
 	extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
+	for (int i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++)
+		__free_page(device->sb_write_page[i]);
 	kfree(device);
 }
 
@@ -6898,6 +6900,16 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	for (int i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		dev->sb_write_page[i] = alloc_page(GFP_KERNEL);
+		if (!dev->sb_write_page[i]) {
+			while (--i >= 0)
+				__free_page(dev->sb_write_page[i]);
+			kfree(dev);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
 	INIT_LIST_HEAD(&dev->dev_list);
 	INIT_LIST_HEAD(&dev->dev_alloc_list);
 	INIT_LIST_HEAD(&dev->post_commit_list);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 588367c76c46..516709e1d9f8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -10,6 +10,7 @@
 #include <linux/sort.h>
 #include <linux/btrfs.h>
 #include "async-thread.h"
+#include "disk-io.h"
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
 
@@ -158,6 +159,8 @@ struct btrfs_device {
 	/* Bio used for flushing device barriers */
 	struct bio flush_bio;
 	struct completion flush_wait;
+	/* Temporary pages for writing the super block copies */
+	struct page *sb_write_page[BTRFS_SUPER_MIRROR_MAX];
 
 	/* per-device scrub information */
 	struct scrub_ctx *scrub_ctx;
-- 
2.36.1

