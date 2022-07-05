Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BEC566433
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiGEHjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiGEHjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE8913CD7
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC4FE1F9FA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysBpqBFvuAljTK28sBZMfbprzbkndSFM4CLQZBfC630=;
        b=kWaAPoeg7DjwUKxZXF8xbDj1hJLuwJ0FoqHrgDbRuzzSzcUpwvexIZgZZodeLQXYi6MFnQ
        so/Ga9ZWIlsg/kkSUuDi5tW7PKHIevGPZLC00/ie1gG7xuwGOFDG6P/bMUPFhGXkrZSbWk
        htK5JLR9ARiXnWQfBH7f9+mKGyVkpJ4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A4471339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YAZfNbjqw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 05/11] btrfs: write-intent: write the newly created bitmaps to all disks
Date:   Tue,  5 Jul 2022 15:39:07 +0800
Message-Id: <a7bb3fe77e92e4fccfb6776b98753f8421223aba.1657004556.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657004556.git.wqu@suse.com>
References: <cover.1657004556.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This write back will happen even for RO mounts.

This will ensure we always have write-intent bitmaps for fses with that
compat RO flags set.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/write-intent.c | 197 +++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/write-intent.h |   6 ++
 2 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index a7ed21182525..a43c6d94f8cd 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -1,8 +1,183 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <crypto/hash.h>
+#include <linux/bio.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "write-intent.h"
+#include "rcu-string.h"
+
+static void write_intent_end_write(struct bio *bio)
+{
+	struct btrfs_device *device = bio->bi_private;
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+	struct page *page;
+
+	bio_for_each_segment_all(bvec, bio, iter_all) {
+		page = bvec->bv_page;
+
+		if (bio->bi_status) {
+			btrfs_warn_rl_in_rcu(device->fs_info,
+				"write-intent bitmap update failed on %s (%d)",
+				rcu_str_deref(device->name),
+				blk_status_to_errno(bio->bi_status));
+			ClearPageUptodate(page);
+			btrfs_dev_stat_inc_and_print(device,
+						     BTRFS_DEV_STAT_WRITE_ERRS);
+		} else {
+			SetPageUptodate(page);
+		}
+
+		unlock_page(page);
+		put_page(page);
+	}
+
+	bio_put(bio);
+}
+
+static int submit_one_device(struct btrfs_device *dev)
+{
+	struct btrfs_fs_info *fs_info = dev->fs_info;
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct address_space *mapping;
+	struct page *page;
+	struct bio *bio;
+
+	if (!dev->bdev)
+		return -EIO;
+
+	if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
+		return 0;
+
+	mapping = dev->bdev->bd_inode->i_mapping;
+
+	page = find_or_create_page(mapping,
+				   BTRFS_DEVICE_RANGE_RESERVED >> PAGE_SHIFT,
+				   GFP_NOFS);
+	if (!page) {
+		btrfs_err(fs_info,
+		"couldn't get write intent bitmap page for devid %llu",
+			  dev->devid);
+		return -EIO;
+	}
+
+	/* Bump the refcount for later wait on this page */
+	get_page(page);
+	memcpy_page(page, offset_in_page(BTRFS_DEVICE_RANGE_RESERVED),
+		    ctrl->commit_page, 0, WRITE_INTENT_BITMAPS_SIZE);
+	bio = bio_alloc(dev->bdev, 1, REQ_OP_WRITE | REQ_SYNC |
+			REQ_META | REQ_PRIO | REQ_FUA, GFP_NOFS);
+	bio->bi_iter.bi_sector = BTRFS_DEVICE_RANGE_RESERVED >> SECTOR_SHIFT;
+	bio->bi_private = dev;
+	bio->bi_end_io = write_intent_end_write;
+	__bio_add_page(bio, page, WRITE_INTENT_BITMAPS_SIZE,
+			offset_in_page(BTRFS_DEVICE_RANGE_RESERVED));
+	submit_bio(bio);
+	return 0;
+}
+
+static int wait_one_device(struct btrfs_device *dev)
+{
+	struct btrfs_fs_info *fs_info = dev->fs_info;
+	struct page *page;
+	int ret = 0;
+
+	/*
+	 * This missing device has already been accounted in
+	 * submit_one_device(), no need to report error again.
+	 */
+	if (!dev->bdev)
+		return 0;
+
+	if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
+		return 0;
+
+	page = find_get_page(dev->bdev->bd_inode->i_mapping,
+			     BTRFS_DEVICE_RANGE_RESERVED >> PAGE_SHIFT);
+	if (!page) {
+		btrfs_err(fs_info,
+		"couldn't wait write intent bitmap page for devid %llu",
+			  dev->devid);
+		return -EIO;
+	}
+
+	/* The endio will unlock the page. */
+	wait_on_page_locked(page);
+	if (!PageUptodate(page))
+		ret = -EIO;
+
+	/* Drop our reference */
+	put_page(page);
+
+	/* Drop the reference bumped by submit_one_device() */
+	put_page(page);
+
+	return ret;
+}
+
+/* Write back the page to all devices. */
+static int write_intent_writeback(struct btrfs_fs_info *fs_info)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct write_intent_super *wis;
+	struct btrfs_device *dev;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	int total_errors = 0;
+	int ret;
+
+	ASSERT(ctrl);
+
+	shash->tfm = fs_info->csum_shash;
+
+	spin_lock(&ctrl->lock);
+	wis = page_address(ctrl->page);
+
+	/*
+	 * Bump up the event counter each time this bitmap is going to be
+	 * written.
+	 */
+	wi_set_super_events(wis, wi_super_events(wis) + 1);
+	crypto_shash_digest(shash, (unsigned char *)wis + BTRFS_CSUM_SIZE,
+			    WRITE_INTENT_BITMAPS_SIZE - BTRFS_CSUM_SIZE,
+			    wis->csum);
+	atomic64_inc(&ctrl->event);
+	memcpy_page(ctrl->commit_page, 0, ctrl->page, 0,
+		    WRITE_INTENT_BITMAPS_SIZE);
+	spin_unlock(&ctrl->lock);
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	/*
+	 * Go through all the writeable devices, copy the bitmap page into the
+	 * page cache, and submit them (without waiting).
+	 *
+	 * We will later check the page status to make sure they reached disk.
+	 */
+	list_for_each_entry(dev, &fs_info->fs_devices->devices, dev_list) {
+		ret = submit_one_device(dev);
+		if (ret < 0)
+			total_errors++;
+	}
+	/*
+	 * Wait for the submitted page to finish on each device.
+	 * By this we can submit all write intent bitmaps in one go, without
+	 * waiting each one.
+	 */
+	list_for_each_entry(dev, &fs_info->fs_devices->devices, dev_list) {
+		ret = wait_one_device(dev);
+		if (ret < 0)
+			total_errors++;
+	}
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+
+	if (total_errors > btrfs_super_num_devices(fs_info->super_copy) - 1) {
+		btrfs_err(fs_info, "failed to writeback write-intent bitmaps");
+		return -EIO;
+	}
+	return 0;
+}
 
 /*
  * Return 0 if a valid write intent bitmap can be found.
@@ -53,10 +228,11 @@ static int write_intent_load(struct btrfs_device *device, struct page *dst)
 	return ret;
 }
 
-static void write_intent_init(struct btrfs_fs_info *fs_info)
+static int write_intent_init(struct btrfs_fs_info *fs_info)
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
 	struct write_intent_super *wis;
+	int ret;
 
 	ASSERT(ctrl);
 	ASSERT(ctrl->page);
@@ -75,7 +251,12 @@ static void write_intent_init(struct btrfs_fs_info *fs_info)
 	wi_set_super_size(wis, WRITE_INTENT_BITMAPS_SIZE);
 	wi_set_super_blocksize(wis, ctrl->blocksize);
 	wi_set_super_nr_entries(wis, 0);
-	btrfs_info(fs_info, "creating new write intent bitmaps");
+
+	ret = write_intent_writeback(fs_info);
+	if (ret < 0)
+		return ret;
+	btrfs_info(fs_info, "new write intent bitmaps created");
+	return 0;
 }
 
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
@@ -95,11 +276,14 @@ int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 
 	fs_info->wi_ctrl->page = alloc_page(GFP_NOFS);
-	if (!fs_info->wi_ctrl->page) {
+	fs_info->wi_ctrl->commit_page = alloc_page(GFP_NOFS);
+	if (!fs_info->wi_ctrl->page || !fs_info->wi_ctrl->commit_page) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
+	spin_lock_init(&fs_info->wi_ctrl->lock);
+
 	/*
 	 * Go through every writeable device to find the highest event.
 	 *
@@ -149,12 +333,15 @@ int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 	}
 
 	/* No valid bitmap found, create a new one. */
-	write_intent_init(fs_info);
-	return 0;
+	ret = write_intent_init(fs_info);
+
+	return ret;
 cleanup:
 	if (fs_info->wi_ctrl) {
 		if (fs_info->wi_ctrl->page)
 			__free_page(fs_info->wi_ctrl->page);
+		if (fs_info->wi_ctrl->commit_page)
+			__free_page(fs_info->wi_ctrl->commit_page);
 		kfree(fs_info->wi_ctrl);
 		fs_info->wi_ctrl = NULL;
 	}
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 2c5cd434e978..797e57aef0e1 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -111,9 +111,15 @@ struct write_intent_ctrl {
 	/* For the write_intent super and entries. */
 	struct page *page;
 
+	/* A copy for writeback. */
+	struct page *commit_page;
+
 	/* Cached event counter.*/
 	atomic64_t event;
 
+	/* Lock for reading/writing above @page. */
+	spinlock_t lock;
+
 	/* Cached blocksize from write intent super. */
 	u32 blocksize;
 };
-- 
2.36.1

