Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8806566452
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiGEHjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiGEHjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656613D2C
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 843A51F9FA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pE1I4T99SlSC2wNiySsTJV7tru8JfGZWi/wn+X1BQX0=;
        b=f/DFSpqfNGiA4WfSz7eH45ggwo82Q4HAKwIPylghmfcZRzxY1VGvnneAhIDWg0YkWLg7/6
        6m580J+7856rf9rdGcoS9mFzmBvH10wz3qenSCtg2eQgQKvxPU4wU4anA7kmmMwqxlxBJ4
        V8+3j6MGBj4ZdsSN7AJ3UJMH+CGaN+E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8F7F1339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4LhwKL7qw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 10/11] btrfs: raid56: clear write-intent bimaps when a full stripe finishes.
Date:   Tue,  5 Jul 2022 15:39:12 +0800
Message-Id: <a35f1a03a43d544608b885f6e85495755dd294cd.1657004556.git.wqu@suse.com>
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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c       |  7 +++++++
 fs/btrfs/write-intent.c | 45 +++++++++++++++++++++++++++++------------
 fs/btrfs/write-intent.h |  8 ++++++++
 3 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 9f18d6f6f4dc..f2b0ea2315c5 100644
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
index 08384ace432b..c8bee0f89fc9 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -125,6 +125,7 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	struct write_intent_super *wis;
 	struct btrfs_device *dev;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	unsigned long flags;
 	int total_errors = 0;
 	int ret;
 
@@ -132,13 +133,13 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 
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
@@ -155,7 +156,7 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 	atomic64_inc(&ctrl->event);
 	memcpy_page(ctrl->commit_page, 0, ctrl->page, 0,
 		    WRITE_INTENT_BITMAPS_SIZE);
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	/*
 	 * Go through all the writeable devices, copy the bitmap page into the
@@ -179,11 +180,11 @@ static int write_intent_writeback(struct btrfs_fs_info *fs_info)
 			total_errors++;
 	}
 
-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->writing_event > ctrl->committed_event)
 		ctrl->committed_event = ctrl->writing_event;
 	ctrl->writing_event = 0;
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 	wake_up(&ctrl->write_wait);
 
 	if (total_errors > btrfs_super_num_devices(fs_info->super_copy) - 1) {
@@ -707,6 +708,7 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
 	struct write_intent_super *wis;
+	unsigned long flags;
 	u32 entry_len;
 	int nr_entries;
 
@@ -717,7 +719,7 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
 
 again:
-	spin_lock(&ctrl->lock);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	entry_len = ctrl->blocksize * WRITE_INTENT_BITS_PER_ENTRY;
 	nr_entries = (round_up(logical + len, entry_len) -
 		      round_down(logical, entry_len)) / entry_len;
@@ -733,7 +735,7 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 
 		prepare_to_wait_event(&ctrl->overflow_wait, &__wait,
 				      TASK_UNINTERRUPTIBLE);
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		schedule();
 		finish_wait(&ctrl->write_wait, &__wait);
 		goto again;
@@ -742,12 +744,29 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
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
@@ -755,14 +774,14 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
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
 
@@ -772,7 +791,7 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 
 		prepare_to_wait_event(&ctrl->write_wait, &__wait,
 				      TASK_UNINTERRUPTIBLE);
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		schedule();
 		finish_wait(&ctrl->write_wait, &__wait);
 		goto again;
@@ -785,7 +804,7 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 		ASSERT(ctrl->writing_event > event);
 		prepare_to_wait_event(&ctrl->write_wait, &__wait,
 				      TASK_UNINTERRUPTIBLE);
-		spin_unlock(&ctrl->lock);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 		schedule();
 		finish_wait(&ctrl->write_wait, &__wait);
 		return 0;
@@ -796,7 +815,7 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 	 * all the other caller will just wait for us.
 	 */
 	ctrl->writing_event = atomic64_read(&ctrl->event) + 1;
-	spin_unlock(&ctrl->lock);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	/* Slow path, do the submission and wait. */
 	return write_intent_writeback(fs_info);
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 385f65047707..7c0ea3545e89 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -267,4 +267,12 @@ int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event);
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
2.36.1

