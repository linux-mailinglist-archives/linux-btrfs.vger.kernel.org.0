Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B063057F905
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiGYFi2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiGYFi1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D01FD27
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CAD6F34981
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=40wwGoJFE4Tv3XtiNjrhpyNfuQj4PEI9QzD/YFgTIC4=;
        b=GrjFyfQuVmItyKx9wbJ3IMKOhcJmIUevFaO3+UB/mgrlbvcN8huS1+FyQF6rK8BjR5Zz16
        94YNQ3XfLxUpmYLAMzM/84kECUUNJpEYlMZetUMHa4Tvqt+KdaLF+rj/V17U/6RazltsoC
        8VK3+s+fBVWiFtTA/2f/6akWGAq6wQE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3EB9B13A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oDNfBFAs3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/14] btrfs: write-intent: write the newly created bitmaps to all disks
Date:   Mon, 25 Jul 2022 13:37:53 +0800
Message-Id: <1cadd3f851857bd9a76095acac3f770e8f74f27e.1658726692.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
References: <cover.1658726692.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/write-intent.c | 154 ++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/write-intent.h |   6 ++
 2 files changed, 155 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index a7ed21182525..d1c5e8e206ba 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -1,8 +1,140 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <crypto/hash.h>
+#include <linux/bio.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "write-intent.h"
+#include "rcu-string.h"
+
+struct bitmap_writeback_contrl {
+	atomic_t pending_bios;
+	atomic_t errors;
+	wait_queue_head_t wait;
+};
+
+static void write_intent_end_write(struct bio *bio)
+{
+	struct bitmap_writeback_contrl *wb_ctrl = bio->bi_private;
+
+	if (bio->bi_status)
+		atomic_inc(&wb_ctrl->errors);
+	atomic_dec(&wb_ctrl->pending_bios);
+	wake_up(&wb_ctrl->wait);
+
+	bio_put(bio);
+}
+
+static int submit_one_device(struct btrfs_device *dev,
+			     struct bitmap_writeback_contrl *wb_ctrl)
+{
+	struct btrfs_fs_info *fs_info = dev->fs_info;
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct bio *bio;
+
+	if (!dev->bdev)
+		return -EIO;
+
+	if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state))
+		return 0;
+
+	atomic_inc(&wb_ctrl->pending_bios);
+	bio = bio_alloc(dev->bdev, 1, REQ_OP_WRITE | REQ_SYNC |
+			REQ_META | REQ_PRIO | REQ_FUA, GFP_NOFS);
+	bio->bi_iter.bi_sector = BTRFS_DEVICE_RANGE_RESERVED >> SECTOR_SHIFT;
+	bio->bi_private = wb_ctrl;
+	bio->bi_end_io = write_intent_end_write;
+	__bio_add_page(bio, ctrl->commit_page, WRITE_INTENT_BITMAPS_SIZE,
+			offset_in_page(BTRFS_DEVICE_RANGE_RESERVED));
+	submit_bio(bio);
+	return 0;
+}
+
+/* Write back the bitmaps page to all devices. */
+static int write_intent_writeback(struct btrfs_fs_info *fs_info)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct write_intent_super *wis;
+	struct btrfs_device *dev;
+	struct btrfs_device **found_devs;
+	struct bitmap_writeback_contrl wb_ctrl = {0};
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	const int nr_devs_max = fs_info->fs_devices->open_devices + 4;
+	int nr_devs = 0;
+	int total_errors = 0;
+	int ret;
+	int i;
+
+	ASSERT(ctrl);
+
+	found_devs = kcalloc(nr_devs_max, sizeof(struct btrfs_device *),
+			     GFP_NOFS);
+	if (!found_devs)
+		return -ENOMEM;
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
+	init_waitqueue_head(&wb_ctrl.wait);
+	atomic_set(&wb_ctrl.pending_bios, 0);
+	atomic_set(&wb_ctrl.errors, 0);
+
+	rcu_read_lock();
+	/*
+	 * Record all the writeable devices into found_devs[].
+	 *
+	 * We have to do this to keep a consistent view of writeable devices,
+	 * without holding device_list_mutex.
+	 * As dev-replace/dev-removal will all hold that mutex and wait for
+	 * submitted bios to finish.
+	 * If we try to hold device_list_mutex at bio submission path, we will
+	 * deadlock with above dev-replace/dev-removal
+	 *
+	 * So here we just grab a local list of devices, and since we're at
+	 * bio submission path, the device will never disapper before the bio
+	 * finished.
+	 */
+	list_for_each_entry_rcu(dev, &fs_info->fs_devices->devices, dev_list) {
+		found_devs[nr_devs] = dev;
+		nr_devs++;
+
+		if (unlikely(nr_devs >= nr_devs_max))
+			break;
+	}
+	rcu_read_unlock();
+
+	/* Go through all the recorded devices, and submit the commit_page. */
+	for (i = 0; i < nr_devs; i++) {
+		ret = submit_one_device(found_devs[i], &wb_ctrl);
+		if (ret < 0)
+			total_errors++;
+	}
+	wait_event(wb_ctrl.wait, atomic_read(&wb_ctrl.pending_bios) == 0);
+
+	if (total_errors + atomic_read(&wb_ctrl.errors) >
+	    btrfs_super_num_devices(fs_info->super_copy) - 1) {
+		btrfs_err(fs_info, "failed to writeback write-intent bitmaps");
+		ret = -EIO;
+	}
+	kfree(found_devs);
+	return ret;
+}
 
 /*
  * Return 0 if a valid write intent bitmap can be found.
@@ -53,10 +185,11 @@ static int write_intent_load(struct btrfs_device *device, struct page *dst)
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
@@ -75,7 +208,12 @@ static void write_intent_init(struct btrfs_fs_info *fs_info)
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
@@ -95,11 +233,14 @@ int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
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
@@ -149,12 +290,15 @@ int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
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
2.37.0

