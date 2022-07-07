Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA205699E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiGGFdL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiGGFdJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FE931345
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C709221F08
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657171986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GzjKHXwZrxhu5vz/p/18q8oKYd23ypFK+Gn2fOAhUxI=;
        b=ZScvjZoJWpo/4F0T8v8+WxD7969tsOD8gXPtCTZFmsrMUBTZtCSbx0nXKGqz+Ebyfoos9x
        K0ZS4unisV5FdVEGviSXrxqWGGDnIHK8+IaetJdSPBiOZb9vhNBzBKaswj3fEMib330S7E
        pyZXoc3mHUUT6XCwiHBK30XQholGvQM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2AB0313488
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eALEORFwxmKcLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jul 2022 05:33:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: write back write intent bitmap after barrier_all_devices()
Date:   Thu,  7 Jul 2022 13:32:34 +0800
Message-Id: <3cda79498dbdb3218a06dab469d8548b63b9694e.1657171615.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657171615.git.wqu@suse.com>
References: <cover.1657171615.git.wqu@suse.com>
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

The new function, btrfs_write_intent_writeback(), will also accept a u64
parameter, @event, to do extra fastpath check to avoid unnecessary
writeback.

For now we just pass 0 to write the current bitmap to disk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c                          |  9 +++
 fs/btrfs/tests/write-intent-bitmaps-tests.c |  2 +
 fs/btrfs/write-intent.c                     | 79 ++++++++++++++++++++-
 fs/btrfs/write-intent.h                     | 25 +++++++
 4 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index edbb21706bda..bd30decd38e4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4357,6 +4357,15 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 		}
 	}
 
+	ret = btrfs_write_intent_writeback(fs_info, 0);
+	if (ret < 0) {
+		mutex_unlock(
+			&fs_info->fs_devices->device_list_mutex);
+		btrfs_handle_fs_error(fs_info, ret,
+			"errors while writing back write intent bitmaps.");
+		return ret;
+	}
+
 	list_for_each_entry(dev, head, dev_list) {
 		if (!dev->bdev) {
 			total_errors++;
diff --git a/fs/btrfs/tests/write-intent-bitmaps-tests.c b/fs/btrfs/tests/write-intent-bitmaps-tests.c
index c956acaea1c7..1b81720f21d1 100644
--- a/fs/btrfs/tests/write-intent-bitmaps-tests.c
+++ b/fs/btrfs/tests/write-intent-bitmaps-tests.c
@@ -25,6 +25,8 @@ static struct write_intent_ctrl *alloc_dummy_ctrl(void)
 	ctrl->blocksize = BTRFS_STRIPE_LEN;
 	atomic64_set(&ctrl->event, 1);
 	spin_lock_init(&ctrl->lock);
+	init_waitqueue_head(&ctrl->overflow_wait);
+	init_waitqueue_head(&ctrl->write_wait);
 	memzero_page(ctrl->page, 0, WRITE_INTENT_BITMAPS_SIZE);
 	wis = page_address(ctrl->page);
 	wi_set_super_magic(wis, WRITE_INTENT_SUPER_MAGIC);
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index b4a205cb0c88..5e26813a06e0 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -76,8 +76,17 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	shash->tfm = fs_info->csum_shash;
 
 	spin_lock(&ctrl->lock);
-	wis = page_address(ctrl->page);
 
+	/* No update on the bitmap, just skip this writeback. */
+	if (!memcmp(page_address(ctrl->page), page_address(ctrl->commit_page),
+		    WRITE_INTENT_BITMAPS_SIZE)) {
+		ctrl->writing_event = 0;
+		spin_unlock(&ctrl->lock);
+		wake_up(&ctrl->write_wait);
+		return 0;
+	}
+
+	wis = page_address(ctrl->page);
 	/*
 	 * Bump up the event counter each time this bitmap is going to be
 	 * written.
@@ -127,6 +136,13 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	}
 	wait_event(wb_ctrl.wait, atomic_read(&wb_ctrl.pending_bios) == 0);
 
+	spin_lock(&ctrl->lock);
+	if (ctrl->writing_event > ctrl->committed_event)
+		ctrl->committed_event = ctrl->writing_event;
+	ctrl->writing_event = 0;
+	spin_unlock(&ctrl->lock);
+	wake_up(&ctrl->write_wait);
+
 	if (total_errors + atomic_read(&wb_ctrl.errors) >
 	    btrfs_super_num_devices(fs_info->super_copy) - 1) {
 		btrfs_err(fs_info, "failed to writeback write-intent bitmaps");
@@ -624,6 +640,63 @@ void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
 		WARN_ON_ONCE(1);
 }
 
+int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+
+	if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP))
+		return 0;
+
+	ASSERT(ctrl);
+
+again:
+	spin_lock(&ctrl->lock);
+
+	/*
+	 * The bitmap has already been written to disk at least once. Our update
+	 * has already reached disk.
+	 */
+	if (event && ctrl->committed_event > event) {
+		spin_unlock(&ctrl->lock);
+		return 0;
+	}
+
+	/* Previous writing hasn't finished, wait for it and retry. */
+	if (ctrl->writing_event && ctrl->writing_event <= event) {
+		DEFINE_WAIT(__wait);
+
+		prepare_to_wait_event(&ctrl->write_wait, &__wait,
+				      TASK_UNINTERRUPTIBLE);
+		spin_unlock(&ctrl->lock);
+		schedule();
+		finish_wait(&ctrl->write_wait, &__wait);
+		goto again;
+	}
+
+	/* Someone is already writing back the bitmap. */
+	if (ctrl->writing_event) {
+		DEFINE_WAIT(__wait);
+
+		ASSERT(ctrl->writing_event > event);
+		prepare_to_wait_event(&ctrl->write_wait, &__wait,
+				      TASK_UNINTERRUPTIBLE);
+		spin_unlock(&ctrl->lock);
+		schedule();
+		finish_wait(&ctrl->write_wait, &__wait);
+		return 0;
+	}
+
+	/*
+	 * We're the one to write back the bitmap, update @writing_event so
+	 * all the other caller will just wait for us.
+	 */
+	ctrl->writing_event = atomic64_read(&ctrl->event) + 1;
+	spin_unlock(&ctrl->lock);
+
+	/* Slow path, do the submission and wait. */
+	return write_intent_writeback(fs_info);
+}
+
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_device *highest_dev = NULL;
@@ -648,6 +721,8 @@ int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 	}
 
 	spin_lock_init(&fs_info->wi_ctrl->lock);
+	init_waitqueue_head(&fs_info->wi_ctrl->overflow_wait);
+	init_waitqueue_head(&fs_info->wi_ctrl->write_wait);
 
 	/*
 	 * Go through every writeable device to find the highest event.
@@ -688,6 +763,8 @@ int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 				  dev->devid, ret);
 			goto cleanup;
 		}
+		memcpy_page(fs_info->wi_ctrl->commit_page, 0,
+			    fs_info->wi_ctrl->page, 0, WRITE_INTENT_BITMAPS_SIZE);
 		wis = page_address(fs_info->wi_ctrl->page);
 		atomic64_set(&fs_info->wi_ctrl->event, wi_super_events(wis));
 		fs_info->wi_ctrl->blocksize = wi_super_blocksize(wis);
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 00eb116e4c38..bf84737e0706 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -123,12 +123,30 @@ struct write_intent_ctrl {
 	/* A copy for writeback. */
 	struct page *commit_page;
 
+	/*
+	 * For callers who has updated their bitmap, wait for the bitmap to be
+	 * flushed to disk.
+	 */
+	wait_queue_head_t write_wait;
+
+	/*
+	 * For callers whose bits can not be updated as no enough space left
+	 * int the bitmap.
+	 */
+	wait_queue_head_t overflow_wait;
+
 	/* Cached event counter.*/
 	atomic64_t event;
 
 	/* Lock for reading/writing above @page. */
 	spinlock_t lock;
 
+	/* Event number for the bitmap being written. */
+	u64 writing_event;
+
+	/* Event number for the last committed bitmap. */
+	u64 committed_event;
+
 	/* Cached blocksize from write intent super. */
 	u32 blocksize;
 };
@@ -250,4 +268,11 @@ void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info);
 void btrfs_write_intent_free(struct btrfs_fs_info *fs_info);
 
+/*
+ * Ensure the bitmap for @event is already written to disk.
+ *
+ * If @event is 0, it means to write current bitmap to disk.
+ */
+int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event);
+
 #endif
-- 
2.36.1

