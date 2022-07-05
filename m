Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436D6566437
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiGEHjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiGEHjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27CFA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7728B1F9BF
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9B5UKG6ho3ltkjK9oKvM/YTpOk/9Oew0ie6Y3xzNTM=;
        b=r0t66CLxu3eFDV2hgRlVDpwjiy6tJkNWxokkf6ngTRFhH1Z+tsSsQFMIwGb95LyFpOOIvL
        QT4R78fl3LNHQq5ri9tL7LFSCZ+DZz2cbSS3Xr66l3Ui4GIf6W8XpyNykT5AWMnfp1kX8i
        aUyGu4Xx3sFpjPVdqgx9Fz62OGhzoUY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C98981339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4O5/JL3qw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 09/11] btrfs: update and writeback the write-intent bitmap for RAID56 write.
Date:   Tue,  5 Jul 2022 15:39:11 +0800
Message-Id: <84f344a15865e1d23fddad281fedcdf251f461ea.1657004556.git.wqu@suse.com>
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

This allows us to mark the write-intent bitmaps dirty for later recovery
usage.

For now, we only mark the bitmaps dirty but without really clearing
them, this is going to cause problems (hang the fs if the bitmap is
full), but this also allows us to debug the bitmap with the new
dump-write-intent tool:

  csum_type		0 (crc32c)
  csum			0xad622029 [match]
  magic			_wIbSb_Q [match]
  fsid			46bcd711-6c9b-400f-aaba-bf99aa3dd321
  flags			0x7
  			( TARGET_RAID56 |
  			  INTERNAL |
  			  BYTENR_LOGICAL )
  events			10
  size			4096
  blocksize		65536
  nr_entries		1
  entry 0, bytenr 385875968, bitmap 0x000000000003fffc

This is doing 1MiB write for logical 388104192, which matches the above
output bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c       |  8 +++++++
 fs/btrfs/write-intent.c | 46 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/write-intent.h |  9 ++++++++
 3 files changed, 63 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 7b2d2b6c8c61..9f18d6f6f4dc 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1185,6 +1185,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	bool has_qstripe;
 	struct bio_list bio_list;
 	struct bio *bio;
+	u64 event;
 	int ret;
 
 	bio_list_init(&bio_list);
@@ -1338,6 +1339,13 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	atomic_set(&rbio->stripes_pending, bio_list_size(&bio_list));
 	BUG_ON(atomic_read(&rbio->stripes_pending) == 0);
 
+	/* Update the write intent bitmap before we start submitting bios. */
+	btrfs_write_intent_mark_dirty(bioc->fs_info, rbio->bioc->raid_map[0],
+				     rbio->nr_data * BTRFS_STRIPE_LEN, &event);
+	ret = btrfs_write_intent_writeback(bioc->fs_info, event);
+
+	if (ret < 0)
+		goto cleanup;
 	while ((bio = bio_list_pop(&bio_list))) {
 		bio->bi_end_io = raid_write_end_io;
 
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index dc8a4b46ca9e..08384ace432b 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -432,6 +432,9 @@ static void delete_one_entry(struct write_intent_ctrl *ctrl, int nr)
 	memset(write_intent_entry_nr(ctrl, cur_nr_entries - 1), 0,
 	       sizeof(struct write_intent_entry));
 	wi_set_super_nr_entries(wis, cur_nr_entries - 1);
+
+	/* We freed one entry, wake up who are waiting for the extra space. */
+	wake_up(&ctrl->overflow_wait);
 }
 
 /*
@@ -699,6 +702,49 @@ static void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
 	}
 }
 
+void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
+				   u32 len, u64 *event_ret)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct write_intent_super *wis;
+	u32 entry_len;
+	int nr_entries;
+
+	if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP))
+		return;
+
+	ASSERT(ctrl);
+	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
+
+again:
+	spin_lock(&ctrl->lock);
+	entry_len = ctrl->blocksize * WRITE_INTENT_BITS_PER_ENTRY;
+	nr_entries = (round_up(logical + len, entry_len) -
+		      round_down(logical, entry_len)) / entry_len;
+	wis = page_address(ctrl->page);
+
+	/*
+	 * May not have enough space left. This calculation is definitely
+	 * overkilled, but will ensure we have enough space for it.
+	 */
+	if (unlikely(wi_super_nr_entries(wis) + nr_entries) >=
+		     WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES) {
+		DEFINE_WAIT(__wait);
+
+		prepare_to_wait_event(&ctrl->overflow_wait, &__wait,
+				      TASK_UNINTERRUPTIBLE);
+		spin_unlock(&ctrl->lock);
+		schedule();
+		finish_wait(&ctrl->write_wait, &__wait);
+		goto again;
+	}
+
+	/* Update the bitmap. */
+	write_intent_set_bits(ctrl, logical, len);
+	*event_ret = atomic64_read(&ctrl->event);
+	spin_unlock(&ctrl->lock);
+}
+
 int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 1a6cd9c723d2..385f65047707 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -258,4 +258,13 @@ void btrfs_write_intent_free(struct btrfs_fs_info *fs_info);
  */
 int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event);
 
+/*
+ * Mark the range dirty in write intent bitmaps.
+ *
+ * May (but unlikely) sleep if there is not enough free entries.
+ * In that case, we will wait for enough free entries to be released.
+ */
+void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
+				   u32 len, u64 *event_ret);
+
 #endif
-- 
2.36.1

