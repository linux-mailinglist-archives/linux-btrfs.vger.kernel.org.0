Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82348566435
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiGEHjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiGEHjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948D0FA
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 574672249A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=32kkV2b9UJYF/+hS/a3si09xjSXjodQbLEoVgveK+0M=;
        b=S3FLSx5Luk2RsJWraEQwWzAEU788RR1xT3nefCwxQP203UHtWKJRddGKIUzhkWrDv6oiYE
        fjI6VbN8GjX7OSjK5CLTE/5fwuKXIuyuDTwiKhSdZBvDWzT5wEa9tGbKcz5H4xcL0ey97X
        XeiQ7xVHxxgzkPAJjphv+8qYowFWDBQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7CC71339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aCbPAbvqw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 07/11] btrfs: write-intent: introduce an internal helper to clear bits for a range.
Date:   Tue,  5 Jul 2022 15:39:09 +0800
Message-Id: <98eb4725a05c047ac6b44b398c59da1e6705f005.1657004556.git.wqu@suse.com>
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

This new helper. write_intent_clear_bits(), is much simpler than the set
bits counter part.

As if we can not find a entry for our target range, then it must be
something wrong, and we only need to warn and skip to next entry.

Although there has one extra thing to do, if we have emptied one entry,
we have to delete that empty entry.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/write-intent.c | 175 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index 0650f168db79..6b99e7c70908 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -326,6 +326,36 @@ static void set_bits_in_one_entry(struct write_intent_ctrl *ctrl,
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
@@ -371,6 +401,25 @@ static void insert_new_entries(struct write_intent_ctrl *ctrl, int nr,
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
@@ -510,6 +559,132 @@ static void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
 	}
 }
 
+/* This should be only called with wi_ctrl->lock hold. */
+static void write_intent_clear_bits(struct write_intent_ctrl *ctrl, u64 bytenr,
+				    u32 len)
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
+			cur_bytenr = max(bytenr + len, entry_start);
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
+		 */
+		if (i < wi_super_nr_entries(wis) - 1) {
+			struct write_intent_entry *next =
+				write_intent_entry_nr(ctrl, i + 1);
+			u64 next_start = wi_entry_bytenr(next);
+
+			/* Case (A) and (B), insert the new entries. */
+			if (cur_bytenr >= entry_end && cur_bytenr < next_start) {
+				/*
+				 * This should not happen, as we should always
+				 * have dirty bits in range.
+				 * Just warn and skip to next entry.
+				 */
+				cur_bytenr = next_start;
+				WARN_ON_ONCE(1);
+				continue;
+			}
+
+			/* Case (C), just skip to next item */
+			continue;
+		}
+
+		/*
+		 * The remaining case is, @entry is already the last one.
+		 *
+		 * |<-- entry -->|
+		 *		   |<-- bytenr/len -->|
+		 *
+		 * Another impossible case, just warn and continue.
+		 */
+		WARN_ON_ONCE(1);
+	}
+}
+
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_device *highest_dev = NULL;
-- 
2.36.1

