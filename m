Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAA557F90A
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiGYFi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiGYFi2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B11AFD38
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8FE31F992
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwx9nQwmogRqZEZE8y+y0UmOqutTcItcTJ5jFlRZkNY=;
        b=FXgjHjd8mCkVpRm7vVQiasngWnnfThMBhNgFLzD3cqD2mUslAZY8PGKDreo/4SQKc+Z46C
        FGoWyhnp+Azk/3VCTf/Wt3izYvI90lPvmLHAitWGMZWAJoobogj0FpPYksUjeJZ8/Ej+O1
        bdq0dogXDWio391y91tvwTSgki3ylhE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C9DC13A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WDtjO1As3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/14] btrfs: write-intent: introduce an internal helper to set bits for a range.
Date:   Mon, 25 Jul 2022 13:37:54 +0800
Message-Id: <03bf60b3f8e7a36469768a2c55753558b99d3db1.1658726692.git.wqu@suse.com>
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
 fs/btrfs/write-intent.c | 246 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/write-intent.h |  19 ++++
 2 files changed, 265 insertions(+)

diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index d1c5e8e206ba..eaf6d010462e 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -216,6 +216,252 @@ static int write_intent_init(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static struct write_intent_entry *write_intent_entry_nr(
+				struct write_intent_ctrl *ctrl, int nr)
+{
+
+	ASSERT(nr < WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
+	return (page_address(ctrl->page) +
+		sizeof(struct write_intent_super) +
+		nr * sizeof(struct write_intent_entry));
+}
+
+/*
+ * Return <0 if the bytenr is before the given entry.
+ * Return 0 if the bytenr is inside the given entry.
+ * Return >0 if the bytenr is after the given entry.
+ */
+static int compare_bytenr_to_range(u64 bytenr, u64 start, u32 len)
+{
+	if (bytenr < start)
+		return -1;
+	if (start <= bytenr && bytenr < start + len)
+		return 0;
+	return 1;
+}
+
+/*
+ * Move all non-empty entries starting from @nr, to the right, and make room
+ * for @nr_new entries.
+ * Those new entries will be all zero filled.
+ *
+ * Caller should ensure we have enough room for @nr_new new entries.
+ */
+static void move_entries_right(struct write_intent_ctrl *ctrl, int nr,
+			       int nr_new)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+	int move_size;
+
+	ASSERT(nr_new > 0);
+	ASSERT(wi_super_nr_entries(wis) + nr_new <=
+	       WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
+
+	move_size = (wi_super_nr_entries(wis) - nr) *
+		     sizeof(struct write_intent_entry);
+
+	memmove(write_intent_entry_nr(ctrl, nr + nr_new),
+		write_intent_entry_nr(ctrl, nr), move_size);
+	memset(write_intent_entry_nr(ctrl, nr), 0,
+	       nr_new * sizeof(struct write_intent_entry));
+	wi_set_super_nr_entries(wis, wi_super_nr_entries(wis) + nr_new);
+}
+
+static void set_bits_in_one_entry(struct write_intent_ctrl *ctrl,
+				  struct write_intent_entry *entry,
+				  u64 bytenr, u32 len)
+{
+	const u64 entry_start = wi_entry_bytenr(entry);
+	const u32 entry_len = write_intent_entry_size(ctrl);
+	unsigned long bitmaps[WRITE_INTENT_BITS_PER_ENTRY / BITS_PER_LONG];
+
+	wie_get_bitmap(entry, bitmaps);
+
+	ASSERT(entry_start <= bytenr && bytenr + len <= entry_start + entry_len);
+	bitmap_set(bitmaps, (bytenr - entry_start) / ctrl->blocksize,
+		   len / ctrl->blocksize);
+	wie_set_bitmap(entry, bitmaps);
+}
+
+/*
+ * Insert new entries for the range [@bytenr, @bytenr + @len) at slot @nr
+ * and fill the new entries with proper bytenr and bitmaps.
+ */
+static void insert_new_entries(struct write_intent_ctrl *ctrl, int nr,
+			       u64 bytenr, u32 len)
+{
+	const u32 entry_size = write_intent_entry_size(ctrl);
+	u64 entry_start;
+	u64 new_start = round_down(bytenr, entry_size);
+	u64 new_end;
+	int nr_new_entries;
+	u64 cur;
+
+	if (nr >= wi_super_nr_entries(page_address(ctrl->page)) ||
+	    nr >= WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES)
+		entry_start = U64_MAX;
+	else
+		entry_start = wi_entry_bytenr(write_intent_entry_nr(ctrl, nr));
+
+	ASSERT(bytenr < entry_start);
+
+	new_end = min(entry_start, round_up(bytenr + len, entry_size));
+	nr_new_entries = (new_end - new_start) / entry_size;
+
+	if (nr_new_entries == 0)
+		return;
+
+	move_entries_right(ctrl, nr, nr_new_entries);
+
+	for (cur = new_start; cur < new_end; cur += entry_size, nr++) {
+		struct write_intent_entry *entry =
+			write_intent_entry_nr(ctrl, nr);
+		u64 range_start = max(cur, bytenr);
+		u64 range_len = min(cur + entry_size, bytenr + len) -
+				range_start;
+
+		/* Fill the bytenr into the new empty entries.*/
+		wi_set_entry_bytenr(entry, cur);
+
+		/* And set the bitmap. */
+		set_bits_in_one_entry(ctrl, entry, range_start, range_len);
+	}
+}
+
+/*
+ * This should be only called when we have enough room in the bitmaps, and hold
+ * the wi_ctrl->lock.
+ *
+ * This function is only exported for selftests, which doesn't need to hold any
+ * lock.
+ */
+void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 bytenr, u32 len)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+	const u32 entry_size = write_intent_entry_size(ctrl);
+	int i;
+	u64 nr_entries = wi_super_nr_entries(wis);
+	u64 cur_bytenr;
+
+	/*
+	 * Currently we only accept full stripe length, which should be
+	 * aligned to 64KiB.
+	 */
+	ASSERT(IS_ALIGNED(len, BTRFS_STRIPE_LEN));
+
+	/*
+	 * We should have room to contain the worst case scenario, in which we
+	 * need to create one or more new entry.
+	 */
+	ASSERT(nr_entries + bytes_to_entries(bytenr, len, BTRFS_STRIPE_LEN) <=
+	       WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES);
+
+	/*
+	 * Iterate through the existing entries to insert new entries or set
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
+		 * We need to insert one or more new entries for the range not
+		 * covered by the existing entry.
+		 */
+		if (compare_bytenr_to_range(cur_bytenr, entry_start,
+					    entry_size) < 0) {
+			u64 new_range_end;
+
+			new_range_end = min(entry_start, bytenr + len);
+			insert_new_entries(ctrl, i, cur_bytenr,
+					   new_range_end - cur_bytenr);
+
+			cur_bytenr = new_range_end;
+			continue;
+		}
+		/*
+		 * |<-- entry -->|
+		 *	|<-- bytenr/len -->|
+		 *
+		 * Or
+		 *
+		 * |<-------- entry ------->|
+		 *	|<- bytenr/len ->|
+		 *
+		 * In this case, we just set the bitmap in the current entry, and
+		 * advance @cur_bytenr to the end of the existing entry.
+		 * By this, we either go check the range against the next entry,
+		 * or we finish our current range.
+		 */
+		if (compare_bytenr_to_range(cur_bytenr, entry_start,
+					    entry_size) == 0) {
+			u64 range_end = min(entry_end, bytenr + len);
+
+			set_bits_in_one_entry(ctrl, entry, cur_bytenr,
+					      range_end - cur_bytenr);
+			cur_bytenr = range_end;
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
+		 * For case (A) and (B), we will insert new entries before
+		 * the next one at the next loop.
+		 *
+		 * For case (C), we just do the regular set bits.
+		 * Thus case (A) ~ (C) are all handled properly.
+		 *
+		 * For case (D), we will handle it after the loop.
+		 */
+	}
+
+	/*
+	 * We still have some range not handled after the existing entries,
+	 * just insert new entries.
+	 */
+	if (cur_bytenr < bytenr + len)
+		insert_new_entries(ctrl, i, cur_bytenr,
+				   bytenr + len - cur_bytenr);
+}
+
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_device *highest_dev = NULL;
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 797e57aef0e1..707ccf73e13a 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -106,6 +106,15 @@ struct write_intent_entry {
 /* The number of bits we can have in one entry. */
 #define WRITE_INTENT_BITS_PER_ENTRY		(64)
 
+static inline u32 bytes_to_entries(u64 start, u32 length, u32 blocksize)
+{
+	u32 entry_len = blocksize * WRITE_INTENT_BITS_PER_ENTRY;
+	u64 entry_start = round_down(start, entry_len);
+	u64 entry_end = round_up(start + length, entry_len);
+
+	return DIV_ROUND_UP((u32)(entry_end - entry_start), entry_len);
+}
+
 /* In-memory write-intent control structure. */
 struct write_intent_ctrl {
 	/* For the write_intent super and entries. */
@@ -189,6 +198,13 @@ WRITE_INTENT_SETGET_FUNCS(super_csum_type, struct write_intent_super,
 			  csum_type, 16);
 WRITE_INTENT_SETGET_FUNCS(entry_bytenr, struct write_intent_entry, bytenr, 64);
 
+static inline u32 write_intent_entry_size(struct write_intent_ctrl *ctrl)
+{
+	struct write_intent_super *wis = page_address(ctrl->page);
+
+	return wi_super_blocksize(wis) * WRITE_INTENT_BITS_PER_ENTRY;
+}
+
 static inline void wie_get_bitmap(struct write_intent_entry *entry,
 				  unsigned long *bitmap)
 {
@@ -214,6 +230,9 @@ static inline void wie_set_bitmap(struct write_intent_entry *entry,
 #endif
 }
 
+/* This function is only exported for selftests. */
+void write_intent_set_bits(struct write_intent_ctrl *ctrl, u64 bytenr, u32 len);
+
 int btrfs_write_intent_init(struct btrfs_fs_info *fs_info);
 void btrfs_write_intent_free(struct btrfs_fs_info *fs_info);
 
-- 
2.37.0

