Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5057F910
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiGYFig (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiGYFic (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B49FD38
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7311534981
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=un0h/aKiDSzVHii73axg+WVRrUmg5AZOZya8W0f2I/U=;
        b=eGY/ieo+Ds4HQpjE1ZLeA6KcMWDuUDFIgQCMq46KdeFb+Q5UMtObH9Eobdo1KChh9SY4+h
        AxKQc/hNePGTCLU3ZKcjxp1v+Bkzgz6wI9uePZKLHcJH1dR4EA7Sdq9/loLA0NQTP/zwKY
        pOoM3vXAwtq7WbZmL5gylBj93cLk678=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA1C713A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sPIyKlQs3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/14] btrfs: update and writeback the write-intent bitmap for RAID56 write.
Date:   Mon, 25 Jul 2022 13:37:58 +0800
Message-Id: <1fbfae9e37bb8778cda446267e029b88e1d28650.1658726692.git.wqu@suse.com>
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
index 9b79a212fd6a..1b9a9f40df29 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1183,6 +1183,7 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
 	bool has_qstripe;
 	struct bio_list bio_list;
 	struct bio *bio;
+	u64 event;
 	int ret;
 
 	bio_list_init(&bio_list);
@@ -1334,6 +1335,13 @@ static noinline void finish_rmw(struct btrfs_raid_bio *rbio)
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
index 5e26813a06e0..8520105d0d84 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -381,6 +381,9 @@ static void delete_one_entry(struct write_intent_ctrl *ctrl, int nr)
 	memset(write_intent_entry_nr(ctrl, cur_nr_entries - 1), 0,
 	       sizeof(struct write_intent_entry));
 	wi_set_super_nr_entries(wis, cur_nr_entries - 1);
+
+	/* We freed one entry, wake up who are waiting for the extra space. */
+	wake_up(&ctrl->overflow_wait);
 }
 
 /*
@@ -640,6 +643,49 @@ void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
 		WARN_ON_ONCE(1);
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
index bf84737e0706..e1e3a16f8929 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -275,4 +275,13 @@ void btrfs_write_intent_free(struct btrfs_fs_info *fs_info);
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
2.37.0

