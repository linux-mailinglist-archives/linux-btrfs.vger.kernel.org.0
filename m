Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4C566456
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiGEHiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGEHiR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A113D43
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A1AE224BC
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCQNmQREo0+KLbtI50JFq+4YCt1T7IZqA4IEznD4rmM=;
        b=dsQGhQRC1qiPmc9zibgR4fbTIlGMto1WrFPXeopapspgQnVqYoAlMSNyob9KVdW/qRl+fi
        gDQwdpYl3VuLUvAMKWsIpIjKQsxetskevSFRtjaP5cEpXi6JphSjCCkwcj1VXnI3BmSBLY
        2hlLpWf99dvuEO/uwMwyclqwr/9y2vM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 661BC1339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8O3sDGbqw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs-progs: introduce the on-disk format of btrfs write intent bitmaps
Date:   Tue,  5 Jul 2022 15:37:46 +0800
Message-Id: <fd8de01599d9c83e77d0d5c8b3f801d7b85710a3.1657006141.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657006141.git.wqu@suse.com>
References: <cover.1657006141.git.wqu@suse.com>
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
 kernel-shared/write-intent.h | 177 +++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 kernel-shared/write-intent.h

diff --git a/kernel-shared/write-intent.h b/kernel-shared/write-intent.h
new file mode 100644
index 000000000000..a208e5cafb68
--- /dev/null
+++ b/kernel-shared/write-intent.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Btrfs specific write-intent bitmaps. */
+
+#ifndef BTRFS_WRITE_INTENT_H
+#define BTRFS_WRITE_INTENT_H
+
+#include "kerncompat.h"
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
+/*
+ * For now, 4KiB is enough, as using 64KiB blocksize we can save bitmaps
+ * for 896MiB (224 entries, each entri can cache 64KiB * 64) sized logical
+ * range.
+ */
+#define WRITE_INTENT_BITMAPS_SIZE		(SZ_4K)
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
+	__le32 bitmaps[2];
+};
+
+/*
+ * ON-DISK FORMAT
+ * ==============
+ *
+ * [ super ][ entry 1 ][ entry 2 ] ... [entry N]
+ * |<------------  super::size --------------->|
+ *
+ * Normally it's 4KiB in size.
+ *
+ * Currently the write-intent bitmaps is only for RAID56 writes, thus its
+ * blocksize is always 64KiB.
+ * Thus one entry can represent 4MiB (64 * 64 KiB) of logical range.
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
+static inline u32 wie_get_bitmap0(struct write_intent_entry *entry)
+{
+	return le32_to_cpu(entry->bitmaps[0]);
+}
+static inline u32 wie_get_bitmap1(struct write_intent_entry *entry)
+{
+	return le32_to_cpu(entry->bitmaps[1]);
+}
+
+#endif
-- 
2.36.1

