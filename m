Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D619157F90B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiGYFia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiGYFi3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49AFD27
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A850E1FE42
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XoDEVj5yGl9lYI+NjVC4mOHAJKr700Ed8jt0hAYCmFU=;
        b=IyyzwVGJWDyuiVY0d7Nmc+ES088DlxxiPj9P5sNw8Ujvoi2jZvzPxQFLQRiU2sDRFzc6QX
        t4RxlbSf4iS8X7rAGfnQE0F272A7HsZJpruMuv676tfsVhg4BMebW38z7yHLvdsZac0Sjr
        i5sc28nvG0TlqG+IsZU8OtwGPDyvUT8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B52813A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SLI3N1Es3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/14] btrfs: write-intent: introduce an internal helper to clear bits for a range.
Date:   Mon, 25 Jul 2022 13:37:55 +0800
Message-Id: <ec95f4af1b3a7cd43f49213d8f5f44f161fbc7f5.1658726692.git.wqu@suse.com>
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

This new helper. write_intent_clear_bits(), is much simpler than the set
bits counter part.

As if we can not find a entry for our target range, then it must be
something wrong, and we only need to warn and skip to next entry.

Although there has one extra thing to do, if we have emptied one entry,
we have to delete that empty entry.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/write-intent.c | 172 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/write-intent.h |   4 +-
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index eaf6d010462e..8a69bf39a994 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -283,6 +283,36 @@ static void set_bits_in_one_entry(struct write_intent_ctrl *ctrl,
 	wie_set_bitmap(entry, bitmaps);
 }
 
+static bool is_entry_empty(struct write_intent_ctrl *ctrl,
+			   struct write_intent_entry *entry)
+{
+	unsigned long bitmaps[2];
+
+	wie_get_bitmap(entry, bitmaps);
+
+	return bitmap_empty(bitmaps, WRITE_INTENT_BITS_PER_ENTRY);
+}
+
+/*
+ * NOTE: This function may clear all bits of an entry, caller must check if
+ * that's the case, and delete the empty entry if needed.
+ */
+static void clear_bits_in_one_entry(struct write_intent_ctrl *ctrl,
+				    struct write_intent_entry *entry,
+				    u64 bytenr, u32 len)
+{
+	const u64 entry_start = wi_entry_bytenr(entry);
+	const u32 entry_len = write_intent_entry_size(ctrl);
+	unsigned long bitmaps[WRITE_INTENT_BITS_PER_ENTRY / BITS_PER_LONG];
+
+	wie_get_bitmap(entry, bitmaps);
+
+	ASSERT(entry_start <= bytenr && bytenr + len <= entry_start + entry_len);
+	bitmap_clear(bitmaps, (bytenr - entry_start) / ctrl->blocksize,
+		   len / ctrl->blocksize);
+	wie_set_bitmap(entry, bitmaps);
+}
+
 /*
  * Insert new entries for the range [@bytenr, @bytenr + @len) at slot @nr
  * and fill the new entries with proper bytenr and bitmaps.
@@ -328,6 +358,25 @@ static void insert_new_entries(struct write_intent_ctrl *ctrl, int nr,
 	}
 }
 
+static void delete_one_entry(struct write_intent_ctrl *ctrl, int nr)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+	int cur_nr_entries = wi_super_nr_entries(wis);
+
+	ASSERT(is_entry_empty(ctrl, write_intent_entry_nr(ctrl, nr)));
+	ASSERT(nr < cur_nr_entries);
+
+	/* Move all the entries after slot @nr by one slot. */
+	memmove(write_intent_entry_nr(ctrl, nr),
+		write_intent_entry_nr(ctrl, nr + 1),
+		(cur_nr_entries - nr - 1) * sizeof(struct write_intent_entry));
+
+	/* Memzero the right most entry. */
+	memset(write_intent_entry_nr(ctrl, cur_nr_entries - 1), 0,
+	       sizeof(struct write_intent_entry));
+	wi_set_super_nr_entries(wis, cur_nr_entries - 1);
+}
+
 /*
  * This should be only called when we have enough room in the bitmaps, and hold
  * the wi_ctrl->lock.
@@ -462,6 +511,129 @@ void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 bytenr, u32 len)
 				   bytenr + len - cur_bytenr);
 }
 
+/* This should be only called with wi_ctrl->lock hold, except for selftests. */
+void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
+			     u32 len)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+	const u32 entry_size = write_intent_entry_size(ctrl);
+	int i;
+	u64 cur_bytenr;
+
+	/*
+	 * Currently we only accept full stripe length, which should be
+	 * aligned to 64KiB.
+	 */
+	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
+
+	/*
+	 * Iterate through the existing entries to delete entries or clear
+	 * bits in the existing ones.
+	 */
+	for (i = 0, cur_bytenr = bytenr;
+	     i < wi_super_nr_entries(wis) && cur_bytenr < bytenr + len; i++) {
+		struct write_intent_entry *entry = write_intent_entry_nr(ctrl, i);
+		u64 entry_start = wi_entry_bytenr(entry);
+		u64 entry_end = entry_start + entry_size;
+
+		/*
+		 *			|<-- entry -->|
+		 * |<-- bytenr/len -->|
+		 *
+		 * Or
+		 *
+		 *		|<-- entry -->|
+		 * |<-- bytenr/len -->|
+		 *
+		 * Or
+		 *
+		 *	|<-- entry -->|
+		 * |<-- bytenr/len -->|
+		 *
+		 * This case should not happen, it means we have some logged
+		 * dirty range, but it's no longer there.
+		 * Just warn and skip to the next covered range.
+		 */
+		if (compare_bytenr_to_range(cur_bytenr, entry_start, entry_size) < 0) {
+			WARN_ON_ONCE(1);
+			cur_bytenr = min(bytenr + len, entry_start);
+			continue;
+		}
+
+		/*
+		 * |<-- entry -->|
+		 *	|<-- bytenr/len -->|
+		 *
+		 * Or
+		 *
+		 * |<-------- entry ------->|
+		 *	|<- bytenr/len ->|
+		 *
+		 * In this case, we just clear the bitmap in current entry, and
+		 * advance @cur_bytenr.
+		 * By this, we either go check the range against the next entry,
+		 * or we finish our current range.
+		 */
+		if (compare_bytenr_to_range(cur_bytenr, entry_start, entry_size) == 0) {
+			u64 range_end = min(entry_end, bytenr + len);
+
+			clear_bits_in_one_entry(ctrl, entry, cur_bytenr,
+						range_end - cur_bytenr);
+			cur_bytenr = range_end;
+			/*
+			 * If the current entry is empty, we need to delete the
+			 * entry and decrease @nr.
+			 */
+			if (is_entry_empty(ctrl, entry)) {
+				delete_one_entry(ctrl, i);
+				i--;
+			}
+			continue;
+		}
+
+		/*
+		 * (A)
+		 * |<-- entry -->|			|<--- next -->|
+		 *		   |<-- bytenr/len -->|
+		 *
+		 * OR
+		 *
+		 * (B)
+		 * |<-- entry -->|		|<--- next -->|
+		 *		   |<-- bytenr/len -->|
+		 *
+		 * OR
+		 *
+		 * (C)
+		 * |<-- entry -->|<--- next -->|
+		 *		   |<-- bytenr/len -->|
+		 *
+		 * OR
+		 *
+		 * (D)
+		 * |<-- entry -->|
+		 *		   |<-- bytenr/len -->|
+		 *
+		 * For all above cases, we just skip to the next entry.
+		 *
+		 * For case (A) and (B), we will trigger wanring as we
+		 * don't have expected entries to clear.
+		 *
+		 * For case (C), we just do the regular clear bits.
+		 * Thus case (A) ~ (C) are all handled properly.
+		 *
+		 * For case (D), we will handle it after the loop.
+		 */
+	}
+	/*
+	 * There is some range not handled, and there is no more entries,
+	 * another unexpected case.
+	 * Just do warning.
+	 */
+	if (cur_bytenr < bytenr + len)
+		WARN_ON_ONCE(1);
+}
+
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_device *highest_dev = NULL;
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 707ccf73e13a..0da1b7421590 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -230,8 +230,10 @@ static inline void wie_set_bitmap(struct write_intent_entry *entry,
 #endif
 }
 
-/* This function is only exported for selftests. */
+/* These two functions are only exported for selftests. */
 void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 bytenr, u32 len);
+void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
+			     u32 len);
 
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info);
 void btrfs_write_intent_free(struct btrfs_fs_info *fs_info);
-- 
2.37.0

