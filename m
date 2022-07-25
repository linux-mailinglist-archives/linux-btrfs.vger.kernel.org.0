Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4183357F90F
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGYFig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiGYFic (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB0EFD34
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 635DC34C64
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYDoAoz71a7/a9NCef+z2IRWoyfLnYQzdBSfnllryfY=;
        b=nU8Yp92PutH02TNshmztaHCAd32qw6ibsEB5TSUHSYv3DwmnmCR0ibf/PH0o5Te5kBFsBm
        1KSmGaPZfD61HhwBAdzilZsGFv9qrJuG1lgKJTVgLpmcv81PYrK4BYq9y1jbmR26rB5bDp
        PadTrAZRaqCJ4oIteNWkFdn74cPjVC8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8D1813A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8NTsJVUs3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/14] btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
Date:   Mon, 25 Jul 2022 13:37:59 +0800
Message-Id: <47cddbde147ebb034f05a226aa3f7a28a923296d.1658726692.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
References: <cover.1658726692.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c       |  7 +++++++
 fs/btrfs/write-intent.c | 45 +++++++++++++++++++++++++++++------------
 fs/btrfs/write-intent.h |  8 ++++++++
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1b9a9f40df29..0a0a2a1e96c3 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -817,6 +817,13 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 
 	if (rbio->generic_bio_cnt)
 		btrfs_bio_counter_sub(rbio->bioc->fs_info, rbio->generic_bio_cnt);
+
+	/* Clear the write-intent bitmap range for write operation. */
+	if (rbio->operation == BTRFS_RBIO_WRITE)
+		btrfs_write_intent_clear_dirty(rbio->bioc->fs_info,
+				       rbio->bioc->raid_map[0],
+				       rbio->nr_data * BTRFS_STRIPE_LEN);
+
 	/*
 	 * Clear the data bitmap, as the rbio may be cached for later usage.
 	 * do this before before unlock_stripe() so there will be no new bio
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index 8520105d0d84..40d579574f3d 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -61,6 +61,7 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	struct bitmap_writeback_contrl wb_ctrl = {0};
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	const int nr_devs_max = fs_info->fs_devices->open_devices + 4;
+	unsigned long flags;
 	int nr_devs = 0;
 	int total_errors = 0;
 	int ret;
@@ -75,13 +76,13 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 
 	shash->tfm = fs_info->csum_shash;
 
-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
 	/* No update on the bitmap, just skip this writeback. */
 	if (!memcmp(page_address(ctrl->page), page_address(ctrl->commit_page),
 		    WRITE_INTENT_BITMAPS_SIZE)) {
 		ctrl->writing_event = 0;
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		wake_up(&ctrl->write_wait);
 		return 0;
 	}
@@ -98,7 +99,7 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	atomic64_inc(&ctrl->event);
 	memcpy_page(ctrl->commit_page, 0, ctrl->page, 0,
 		    WRITE_INTENT_BITMAPS_SIZE);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	init_waitqueue_head(&wb_ctrl.wait);
 	atomic_set(&wb_ctrl.pending_bios, 0);
@@ -136,11 +137,11 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	}
 	wait_event(wb_ctrl.wait, atomic_read(&wb_ctrl.pending_bios) == 0);
 
-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->writing_event > ctrl->committed_event)
 		ctrl->committed_event = ctrl->writing_event;
 	ctrl->writing_event = 0;
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 	wake_up(&ctrl->write_wait);
 
 	if (total_errors + atomic_read(&wb_ctrl.errors) >
@@ -648,6 +649,7 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
 	struct write_intent_super *wis;
+	unsigned long flags;
 	u32 entry_len;
 	int nr_entries;
 
@@ -658,7 +660,7 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
 
 again:
-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	entry_len = ctrl->blocksize * WRITE_INTENT_BITS_PER_ENTRY;
 	nr_entries = (round_up(logical + len, entry_len) -
 		      round_down(logical, entry_len)) / entry_len;
@@ -674,7 +676,7 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 
 		prepare_to_wait_event(&ctrl->overflow_wait, &__wait,
 				      TASK_UNINTERRUPTIBLE);
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		schedule();
 		finish_wait(&ctrl->write_wait, &__wait);
 		goto again;
@@ -683,12 +685,29 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 	/* Update the bitmap. */
 	write_intent_set_bits(ctrl, logical, len);
 	*event_ret = atomic64_read(&ctrl->event);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+}
+
+void btrfs_write_intent_clear_dirty(struct btrfs_fs_info *fs_info, u64 logical,
+				    u32 len)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	unsigned long flags;
+
+	if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP))
+		return;
+	ASSERT(ctrl);
+	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	write_intent_clear_bits(ctrl, logical, len);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
 int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	unsigned long flags;
 
 	if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP))
 		return 0;
@@ -696,14 +715,14 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 	ASSERT(ctrl);
 
 again:
-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 
 	/*
 	 * The bitmap has already been written to disk at least once. Our update
 	 * has already reached disk.
 	 */
 	if (event && ctrl->committed_event > event) {
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		return 0;
 	}
 
@@ -713,7 +732,7 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 
 		prepare_to_wait_event(&ctrl->write_wait, &__wait,
 				      TASK_UNINTERRUPTIBLE);
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		schedule();
 		finish_wait(&ctrl->write_wait, &__wait);
 		goto again;
@@ -726,7 +745,7 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 		ASSERT(ctrl->writing_event > event);
 		prepare_to_wait_event(&ctrl->write_wait, &__wait,
 				      TASK_UNINTERRUPTIBLE);
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		schedule();
 		finish_wait(&ctrl->write_wait, &__wait);
 		return 0;
@@ -737,7 +756,7 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 	 * all the other caller will just wait for us.
 	 */
 	ctrl->writing_event = atomic64_read(&ctrl->event) + 1;
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	/* Slow path, do the submission and wait. */
 	return write_intent_writeback(fs_info);
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index e1e3a16f8929..872a707ef67d 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -284,4 +284,12 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event);
 void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 				   u32 len, u64 *event_ret);
 
+/*
+ * Clear the range dirty in write intent bitmaps.
+ *
+ * This function should not sleep, and no need to wait for the bitmap to be
+ * flushed.
+ */
+void btrfs_write_intent_clear_dirty(struct btrfs_fs_info *fs_info, u64 logical,
+				    u32 len);
 #endif
-- 
2.37.0

