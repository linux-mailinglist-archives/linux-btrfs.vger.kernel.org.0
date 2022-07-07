Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D25699E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiGGFdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F031345
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 373991F8D3
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657171980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QCVTq+nLUTbwjNpOFA353mI3mKirIJBPM6fhcatjdWk=;
        b=ZvdZhZOnGRrbHTM/6sHf/ZDsgn4d+vMwGHiLAM3/0x/kEcEc+HjEN6PwGLhJFJo/rQaHdt
        WuY097MEQAskrTv/eW7EFz0+SCgyBP1rEX0NivoeY/1Sf8kMzZUunJCjwR3sfy7gFoMgSZ
        Kt5PRZ8NXhdWKtJaWZRCHq2zhalbmuM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 295DB13488
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CDPwBgpwxmKcLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jul 2022 05:32:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/12] btrfs: introduce the on-disk format of btrfs write intent bitmaps
Date:   Thu,  7 Jul 2022 13:32:28 +0800
Message-Id: <20e6fdb9e8fa3ba80a5b2c1988a377e7f5733abb.1657171615.git.wqu@suse.com>
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

With extra comments explaining the on-disk format and the basic
workflow.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c      |   4 +-
 fs/btrfs/raid56.c       |   1 +
 fs/btrfs/write-intent.h | 199 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/write-intent.h

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 967c020c380a..963a89cd4bfb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -42,6 +42,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "subpage.h"
+#include "write-intent.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
@@ -2844,7 +2845,8 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 		 * Extra check like the length check against the reserved space
 		 * will happen at bitmap load time.
 		 */
-		if (btrfs_super_reserved_bytes(sb) < BTRFS_DEVICE_RANGE_RESERVED) {
+		if (btrfs_super_reserved_bytes(sb) <
+		    BTRFS_DEVICE_RANGE_RESERVED + WRITE_INTENT_BITMAPS_SIZE) {
 			btrfs_err(fs_info,
 			"not enough reserved space for write intent bitmap");
 			ret = -EINVAL;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c6411c849fea..7b2d2b6c8c61 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -19,6 +19,7 @@
 #include "volumes.h"
 #include "raid56.h"
 #include "async-thread.h"
+#include "write-intent.h"
 
 /* set when additional merges to this rbio are not allowed */
 #define RBIO_RMW_LOCKED_BIT	1
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
new file mode 100644
index 000000000000..b851917bb0b6
--- /dev/null
+++ b/fs/btrfs/write-intent.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Btrfs specific write-intent bitmaps. */
+
+#ifndef BTRFS_WRITE_INTENT_H
+#define BTRFS_WRITE_INTENT_H
+
+#include <linux/types.h>
+#include <linux/sizes.h>
+/* For BTRFS_STRIPE_LEN. */
+#include "volumes.h"
+
+#define WRITE_INTENT_SUPER_MAGIC 0x515F62536249775FULL /* ascii _wIbSb_Q */
+
+/* This write-intent bitmap records writes for RAID56 writes. */
+#define WRITE_INTENT_FLAGS_TARGET_RAID56	(1ULL << 0)
+
+/* This write-intent bitmap is internal, aka locates at 1MiB of each device. */
+#define WRITE_INTENT_FLAGS_INTERNAL		(1ULL << 1)
+
+/* This write-intent bitmap uses logical bytenr. */
+#define WRITE_INTENT_FLAGS_BYTENR_LOGICAL	(1ULL << 2)
+
+#define WRITE_INTENT_FLAGS_SUPPORTED			\
+	(WRITE_INTENT_FLAGS_TARGET_RAID56 |		\
+	 WRITE_INTENT_FLAGS_INTERNAL |			\
+	 WRITE_INTENT_FLAGS_BYTENR_LOGICAL)
+
+/*
+ * We use BTRFS_STRIPE_LEN as blocksize.
+ * This makes a RAID56 full stripe to @nr_data bits, and greatly
+ * enlarge how many bytes we can represent just using 4KiB.
+ */
+#define WRITE_INTENT_BLOCKSIZE			(BTRFS_STRIPE_LEN)
+
+/*
+ * For now, 4KiB is enough, as using 64KiB blocksize we can save bitmaps
+ * for 896MiB (224 entries, each entri can cache 64KiB * 64) sized logical
+ * range.
+ */
+#define WRITE_INTENT_BITMAPS_SIZE		(SZ_4K)
+
+
+/*
+ * The super block of write intent bitmaps, should be at physical offset 1MiB of
+ * every writeable device.
+ */
+struct write_intent_super {
+	/* Csum for the super block and all the internal entries. */
+	__u8 csum[BTRFS_CSUM_SIZE];
+	__u8 fsid[BTRFS_FSID_SIZE];
+
+	__le64 magic;
+
+	/* Important behavior flags would be set here. */
+	__le64 flags;
+
+	/*
+	 * Event counter for the bitmap, every time the bitmaps get written
+	 * this value increases.
+	 */
+	__le64 events;
+
+	/*
+	 * Total size of the bitmaps, including this super block and all the
+	 * entries.
+	 *
+	 * U32 should be enough for internal bitmaps, but just in case we want
+	 * to support external device as dedicated journal/bitmap device.
+	 */
+	__le64 size;
+
+	/* How many entries we have utilized. */
+	__le64 nr_entries;
+
+	/* How many bytes one bit represents. */
+	__le32 blocksize;
+	/*
+	 * This should be the same as btrfs_super_block::csum_type.
+	 * Cache csum type here so we read the write intent superblock without
+	 * a fully opened btrfs (for dump purpose).
+	 */
+	__le16 csum_type;
+
+	/* For future expansion, padding to 512 bytes. */
+	__u8 reserved1[418];
+} __attribute__ ((__packed__));
+
+static_assert(sizeof(struct write_intent_super) == 512);
+
+struct write_intent_entry {
+	/*
+	 * Bytenr 0 is special, means this entry is empty, and also means the
+	 * end of the bitmaps.
+	 */
+	__le64 bytenr;
+	__le64 bitmap;
+};
+
+/* How many entries we can have in the bitmaps. */
+#define WRITE_INTENT_INTERNAL_BITMAPS_MAX_ENTRIES		\
+	((WRITE_INTENT_BITMAPS_SIZE -				\
+	  sizeof(struct write_intent_super)) /			\
+	 sizeof(struct write_intent_entry))
+
+/* The number of bits we can have in one entry. */
+#define WRITE_INTENT_BITS_PER_ENTRY		(64)
+
+/*
+ * ON-DISK FORMAT
+ * ==============
+ *
+ * [ super ][ entry 1 ][ entry 2 ] ... [entry N]
+ * |<------------  super::size --------------->|
+ *
+ * Normally it's 4KiB in size for internal bitmap.
+ *
+ * Currently the write-intent bitmaps is only for RAID56 writes, thus its
+ * blocksize is always 64KiB.
+ * Thus one entry can represent at most 4MiB (64 * 64 KiB) of logical range.
+ *
+ * When one raid56 full stripe needs partial writeback, the full stripe logical
+ * bytenr range will be included into at least one entry.
+ *
+ * After the last used entry, the remaining entries will all be filled with 0.
+ *
+ * WORKFLOW
+ * ========
+ *
+ * 1) Write bio arrive
+ *    Every write meets the requirement (so far, only RAID56 partial write) will
+ *    have its bio delayed, until corresponding range are marked in the entry.
+ *
+ * 2) Update the write-intent bitmaps
+ *    The entries will be populated, and write back to all writeable devices,
+ *    with FUA flag set.
+ *    Will wait until the write reaches disks.
+ *
+ * 3) Allow the involved write bios to be submitted
+ *
+ * 4) Write bios finish
+ *    The corresponding range will be recorded to be freed at next flush.
+ *
+ * 5) All devices get flushed (caused by btrfs super block writeback or bitmaps
+ *    pressure)
+ *    The recorded ranges will be cleared. And if an entry is empty, it will be
+ *    freed.
+ *    Then update the write-intent bitmaps with its superblock (writeback with FUA
+ *    flag and wait for it).
+ */
+
+#define WRITE_INTENT_SETGET_FUNCS(name, type, member, bits)	\
+static inline u##bits wi_##name(const type *s)			\
+{								\
+	return le##bits##_to_cpu(s->member);			\
+}								\
+static inline void wi_set_##name(type *s, u##bits val)		\
+{								\
+	s->member = cpu_to_le##bits(val);			\
+}
+
+WRITE_INTENT_SETGET_FUNCS(super_magic, struct write_intent_super, magic, 64);
+WRITE_INTENT_SETGET_FUNCS(super_flags, struct write_intent_super, flags, 64);
+WRITE_INTENT_SETGET_FUNCS(super_events, struct write_intent_super, events, 64);
+WRITE_INTENT_SETGET_FUNCS(super_size, struct write_intent_super, size, 64);
+WRITE_INTENT_SETGET_FUNCS(super_nr_entries, struct write_intent_super,
+			  nr_entries, 64);
+WRITE_INTENT_SETGET_FUNCS(super_blocksize, struct write_intent_super,
+			  blocksize, 32);
+WRITE_INTENT_SETGET_FUNCS(super_csum_type, struct write_intent_super,
+			  csum_type, 16);
+WRITE_INTENT_SETGET_FUNCS(entry_bytenr, struct write_intent_entry, bytenr, 64);
+
+static inline void wie_get_bitmap(struct write_intent_entry *entry,
+				  unsigned long *bitmap)
+{
+#ifdef __LITTLE_ENDIAN
+	bitmap_from_arr64(bitmap, &entry->bitmap, WRITE_INTENT_BITS_PER_ENTRY);
+#else
+	u64 val = le64_to_cpu(entry->bitmap);
+
+	bitmap_from_arr64(bitmap, &val, WRITE_INTENT_BITS_PER_ENTRY);
+#endif
+}
+
+static inline void wie_set_bitmap(struct write_intent_entry *entry,
+				  unsigned long *bitmap)
+{
+#ifdef __LITTLE_ENDIAN
+	bitmap_to_arr64(&entry->bitmap, bitmap, WRITE_INTENT_BITS_PER_ENTRY);
+#else
+	u64 val;
+
+	bitmap_to_arr64(&val, bitmap, WRITE_INTENT_BITS_PER_ENTRY);
+	entry->bitmap = cpu_to_le64(val);
+#endif
+}
+
+#endif
-- 
2.36.1

