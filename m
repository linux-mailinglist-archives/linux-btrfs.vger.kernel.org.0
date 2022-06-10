Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33045545C19
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 08:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiFJGJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiFJGJq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 02:09:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D350E21D3E2
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 23:09:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9267221F9B
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 06:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654841382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=w6WSTmu4qkQ/odDBUHqxCD4yUyWRFGJl37Uf9nK/i+o=;
        b=NSQL1+O30E4iQ8oQfhEO499bn2VOzE8Gok/0jSq6bz0YFfNHy8mfhQMj3jWFwFGsORPqhz
        qr2x3f2mTitNIwCAzsKE5Q5382OixYo6o6dLRy1CEIJqdAj4iyFSacVxXai9k3nz5kYy0r
        deSqFofiPO+rm7yqhc93YNBT8aVIrXM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2A4413941
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 06:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vYujLyXgomI0GQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 06:09:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: properly record errors for super block writeback
Date:   Fri, 10 Jun 2022 14:09:22 +0800
Message-Id: <6726644169a9f4affbb6894a8a560c96072be9cf.1654841347.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although function write_dev_supers() will report error, it only report
things like failed to grab the page, all those errors before we submit
the bio.

But if our bio really failed, due to real IO error, we just set the page
error, output an error message, and call it a day.

This makes btrfs to completely ignore super block writeback error.

Thankfully, this is not that a big deal, as normally we should got error
when flushing the device before we reached super block writeback.

Anyway we should make write_dev_supers() to include the IO errors.

This patch will enhance the error reporting by:

- Introduce a new on-stack structure to record all errors including IO
  errors
  The new strucuture, super_block_io_status, will have a wait queue and
  accounting for flying bios along with errors we hit so far.

- Output a human readable error message
  Instead of something like:

   lost page write due to IO error on dm-1 (-5)

  Now we will have:

   failed to write super block at 65536 on dm-1 (-5)

- Wait for all super block IO finished before returning
  write_dev_supers()
  So now write_dev_supers() will wait for all flying bios to finish, and
  use real number of errors to determine if the write failed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 54 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68e..9ed88a921465 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3864,9 +3864,21 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 }
 ALLOW_ERROR_INJECTION(open_ctree, ERRNO);
 
+struct super_block_io_status {
+	struct btrfs_device *device;
+	wait_queue_head_t wait;
+
+	/* Pending sb bios. */
+	atomic_t pending;
+
+	/* Total errors, including both primary and backup sb writeback errors. */
+	atomic_t errors;
+};
+
 static void btrfs_end_super_write(struct bio *bio)
 {
-	struct btrfs_device *device = bio->bi_private;
+	struct super_block_io_status *sbios = bio->bi_private;
+	struct btrfs_device *device = sbios->device;
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
 	struct page *page;
@@ -3875,21 +3887,29 @@ static void btrfs_end_super_write(struct bio *bio)
 		page = bvec->bv_page;
 
 		if (bio->bi_status) {
+			struct btrfs_super_block *sb;
+			void *addr;
+			u64 bytenr;
+
+			addr = kmap_local_page(page) + bvec->bv_offset;
+			sb = addr;
+			bytenr = btrfs_super_bytenr(sb);
+			kunmap_local(addr);
+
+
+			atomic_inc(&sbios->errors);
 			btrfs_warn_rl_in_rcu(device->fs_info,
-				"lost page write due to IO error on %s (%d)",
-				rcu_str_deref(device->name),
+				"failed to write super block at %llu on %s (%d)",
+				bytenr, rcu_str_deref(device->name),
 				blk_status_to_errno(bio->bi_status));
-			ClearPageUptodate(page);
-			SetPageError(page);
 			btrfs_dev_stat_inc_and_print(device,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
-		} else {
-			SetPageUptodate(page);
 		}
-
 		put_page(page);
 		unlock_page(page);
 	}
+	atomic_dec(&sbios->pending);
+	wake_up(&sbios->wait);
 
 	bio_put(bio);
 }
@@ -3975,9 +3995,9 @@ static int write_dev_supers(struct btrfs_device *device,
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
+	struct super_block_io_status sbios = {.device = device};
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
-	int errors = 0;
 	int ret;
 	u64 bytenr, bytenr_orig;
 
@@ -3986,6 +4006,10 @@ static int write_dev_supers(struct btrfs_device *device,
 
 	shash->tfm = fs_info->csum_shash;
 
+	atomic_set(&sbios.pending, 0);
+	atomic_set(&sbios.errors, 0);
+	init_waitqueue_head(&sbios.wait);
+
 	for (i = 0; i < max_mirrors; i++) {
 		struct page *page;
 		struct bio *bio;
@@ -3999,7 +4023,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			btrfs_err(device->fs_info,
 				"couldn't get super block location for mirror %d",
 				i);
-			errors++;
+			atomic_inc(&sbios.errors);
 			continue;
 		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
@@ -4018,7 +4042,7 @@ static int write_dev_supers(struct btrfs_device *device,
 			btrfs_err(device->fs_info,
 			    "couldn't get super block page for bytenr %llu",
 			    bytenr);
-			errors++;
+			atomic_inc(&sbios.errors);
 			continue;
 		}
 
@@ -4028,6 +4052,7 @@ static int write_dev_supers(struct btrfs_device *device,
 		disk_super = page_address(page);
 		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
 
+		atomic_inc(&sbios.pending);
 		/*
 		 * Directly use bios here instead of relying on the page cache
 		 * to do I/O, so we don't lose the ability to do integrity
@@ -4037,7 +4062,7 @@ static int write_dev_supers(struct btrfs_device *device,
 				REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO,
 				GFP_NOFS);
 		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
-		bio->bi_private = device;
+		bio->bi_private = &sbios;
 		bio->bi_end_io = btrfs_end_super_write;
 		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
 			       offset_in_page(bytenr));
@@ -4054,9 +4079,10 @@ static int write_dev_supers(struct btrfs_device *device,
 		submit_bio(bio);
 
 		if (btrfs_advance_sb_log(device, i))
-			errors++;
+			atomic_inc(&sbios.errors);
 	}
-	return errors < i ? 0 : -1;
+	wait_event(sbios.wait, atomic_read(&sbios.pending) == 0);
+	return atomic_read(&sbios.errors) < i ? 0 : -EIO;
 }
 
 /*
-- 
2.36.1

