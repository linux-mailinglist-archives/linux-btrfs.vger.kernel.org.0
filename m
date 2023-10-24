Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632DE7D4558
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Oct 2023 04:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJXCLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Oct 2023 22:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJXCLj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Oct 2023 22:11:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C036D7B
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Oct 2023 19:11:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A6A0218F6
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 02:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698113492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9dq7dkJYFrXLjT4KHYSEersto2PZDYxFOyJ4UjHG0E0=;
        b=n8Ps0SKOa6E6Y4JBx2qxjrDn/pzuPhg6dufFBgJRDxWojbcoT+wKxzSfFbnfdOtd8OVc7Y
        svmdsAHMiUcrDxFkG4fTFNmaAQmpmB2y1EMj31cGhNyW0JhX+jsRfsNc9Pym2Fpt5uJ0Q1
        xLF5Au32KSh0G1B8dG4PJlbzT7t9KrE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB5F41391C
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 02:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CG2ZGdInN2W5MwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Oct 2023 02:11:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: add type and sequence check for inline backrefs
Date:   Tue, 24 Oct 2023 12:41:11 +1030
Message-ID: <23fbab97bd9dbce7869e858cb59d96a7238db57e.1698105469.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that ntfs2btrfs had a bug that it can lead to
transaction abort and the filesystem flips to read-only.

[CAUSE]
For inline backref items, kernel has a strict requirement for their
ordered, they must follow the following rules:

- All btrfs_extent_inline_ref::type should be in an ascending order

- Within the same type, the items should follow a descending order by
  their sequence number

  For EXTENT_DATA_REF type, the sequence number is result from
  hash_extent_data_ref().
  For other types, their sequence numbers are
  btrfs_extent_inline_ref::offset.

Thus if there is any code not following above rules, the resulted
inline backrefs can prevent the kernel to locate the needed inline
backref and lead to transaction abort.

[FIX]
Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
ability to detect such problems.

For kernel, let's be more noisy and be more specific about the order, so
that the next time kernel hits such problem we would reject it in the
first place, without leading to transaction abort.

Link: https://github.com/kdave/btrfs-progs/pull/622
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a416cbea75d1..981ad301d29d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -31,6 +31,7 @@
 #include "inode-item.h"
 #include "dir-item.h"
 #include "raid-stripe-tree.h"
+#include "extent-tree.h"
 
 /*
  * Error message should follow the following format:
@@ -1276,6 +1277,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 	unsigned long ptr;	/* Current pointer inside inline refs */
 	unsigned long end;	/* Extent item end */
 	const u32 item_size = btrfs_item_size(leaf, slot);
+	u8 last_type = 0;
+	u64 last_seq = U64_MAX;
 	u64 flags;
 	u64 generation;
 	u64 total_refs;		/* Total refs in btrfs_extent_item */
@@ -1322,6 +1325,17 @@ static int check_extent_item(struct extent_buffer *leaf,
 	 *    2.2) Ref type specific data
 	 *         Either using btrfs_extent_inline_ref::offset, or specific
 	 *         data structure.
+	 *    All above inline items should follow the order:
+	 *
+	 *    - All btrfs_extent_inline_ref::type should be in an ascending
+	 *      order
+	 *
+	 *    - Within the same type, the items should follow a descending
+	 *      order by their sequence number
+	 *      The sequence number is determined by:
+	 *      * btrfs_extent_inline_ref::offset for all types  other than
+	 *        EXTENT_DATA_REF
+	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
 	 */
 	if (unlikely(item_size < sizeof(*ei))) {
 		extent_err(leaf, slot,
@@ -1403,6 +1417,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		struct btrfs_extent_inline_ref *iref;
 		struct btrfs_extent_data_ref *dref;
 		struct btrfs_shared_data_ref *sref;
+		u64 seq;
 		u64 dref_offset;
 		u64 inline_offset;
 		u8 inline_type;
@@ -1416,6 +1431,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
 		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
+		seq = inline_offset;
 		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
@@ -1446,6 +1462,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
 			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
+			seq = hash_extent_data_ref(
+					btrfs_extent_data_ref_root(leaf, dref),
+					btrfs_extent_data_ref_objectid(leaf, dref),
+					btrfs_extent_data_ref_offset(leaf, dref));
 			if (unlikely(!IS_ALIGNED(dref_offset,
 						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
@@ -1475,6 +1495,24 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   inline_type);
 			return -EUCLEAN;
 		}
+		if (inline_type < last_type) {
+			extent_err(leaf, slot,
+				   "inline ref out-of-order: has type %u, prev type %u",
+				   inline_type, last_type);
+			return -EUCLEAN;
+		}
+		/* Type changed, allow the sequence starts from U64_MAX again. */
+		if (inline_type > last_type)
+			last_seq = U64_MAX;
+		if (seq > last_seq) {
+			extent_err(leaf, slot,
+"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev type %u seq 0x%llx",
+				   inline_type, inline_offset, seq,
+				   last_type, last_seq);
+			return -EUCLEAN;
+		}
+		last_type = inline_type;
+		last_seq = seq;
 		ptr += btrfs_extent_inline_ref_size(inline_type);
 	}
 	/* No padding is allowed */
-- 
2.42.0

