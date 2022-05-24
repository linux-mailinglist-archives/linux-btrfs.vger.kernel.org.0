Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403295322EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 May 2022 08:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiEXGOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 May 2022 02:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiEXGOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 May 2022 02:14:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1DE6B033
        for <linux-btrfs@vger.kernel.org>; Mon, 23 May 2022 23:14:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE19221A14
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 06:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653372845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3IKrk2pgRLiY4X9PP/AjdoBaC5adAjsfBsS4vHLFs1Q=;
        b=rbj6dIOhf4iMTLfhW04C0stdby6kPtRzADbeeeXrdlOjQl+q//tD2KkTum+FuJztoeE/LK
        JdxDLImS/6g/4AxJSDjnhqr/Ki0T3wlNNpf3/fX0VMoh0/DYsvT5zR+xZWpMkuKgc5bWZF
        P/AAPHP/PnxLj+4WfaTUfPBwxjswaec=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21C4C13AE3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 06:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eGaHN6x3jGLMKgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 May 2022 06:14:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Date:   Tue, 24 May 2022 14:13:47 +0800
Message-Id: <f6679e0b681f9b1a74dfccbe05dcb5b6eb0878f6.1653372729.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

This is the draft version of the on-disk format for RAID56J journal.

The overall idea is, we have the following elements:

1) A fixed header
   Recording things like if the journal is clean or dirty, and how many
   entries it has.

2) One or at most 127 entries
   Each entry will point to a range of data in the per-device reserved
   range.

3) Data in the remaining reserved space

The write time and recovery workflow is embedded into the on-disk
format.

Unfortunately we will not have any optimization for the RAID56J, every
write will be journaled, no exception.

Furthermore due to current write behavior of RAID56, we always submit a
full 64K stripe no matter what, we have every limited size for the data
part (at most 15 64K stripe).

So far, I don't believe we will have a fast RAID56J at all.

There are still some behaivor needs extra comments, like if we really
need to do extensive flush for converting DIRTY log to CLEAN.

Any feedback is welcomed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/uapi/linux/btrfs_tree.h | 142 ++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 46991a27013b..17dace961695 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1042,4 +1042,146 @@ struct btrfs_verity_descriptor_item {
 	__u8 encryption;
 } __attribute__ ((__packed__));
 
+/*
+ * For checksum used in RAID56J, we don't really want to use the
+ * one used by the fs (can be CRC32, XXHASH, SHA256, BLAKE2), as
+ * most meta/data written has already has their own csum calculated.
+ *
+ * Furthermore, we don't have a good way just to reuse the csum.
+ * (metadata has csum inlined, data csum is passed through ordered extents)
+ *
+ * So here the csum for RAID56J is fixed to CRC32 to avoid unnecessary overhead.
+ */
+#define BTRFS_RAID56J_CSUM_SIZE		(4)
+
+#define BTRFS_RAID56J_STATUS_DIRTY	(1 << 0)
+#define BTRFS_RAID56J_STATUS_CLEAN	(1 << 0)
+
+/*
+ * ON-DISK FORMAT
+ * ==============
+ *
+ * This is the header part for RAID56 journal.
+ *
+ * Unlike all structures above, they are not stored in btrfs btree.
+ *
+ * The overall on-disk format looks like this:
+ *
+ * [ raid56j_header ][ raid56j_entry 1 ] .. [raid56j_entry N ]
+ * |------------------ At most in 4K size -------------------|
+ *
+ * One header can contain at most 127 entries.
+ * All entry should have corresponding data.
+ *
+ * Even for full stripe write, we must still journal all its content.
+ * As we can have cases like a full stripe full of dirty metadata.
+ * If we don't journal them, we can easily screw up all the metadata.
+ *
+ * Also we can not just discard the journal of a block group only,
+ * as other metadata write in other blocks can still be journaled, thus
+ * we have to discard all journal of all block groups, which is not
+ * really feasible here.
+ *
+ * So unfortunately we have no optimization for journal write at all.
+ *
+ * [ stripe data 1 ][ stripe data 2 ]   ...   [ stripe data N]
+ * |------- At most btrfs_chunk::per_dev_reserved - 4K ------|
+ *
+ * Normally we put the full 64K stripe into journal, and use 1M as default
+ * reservation for the journal.
+ * This means we can have at most 15 data stripes for now, and it would be
+ * the bottleneck.
+ *
+ * Later we can enhance RAID56 write to only write the modified veritical
+ * stripes, then we can have 255 data stripes.
+ *
+ * WRITE TIME WORKFLOW
+ * ===================
+ *
+ * And when writes are queued into a RAID56J block group, we will update the
+ * btrfs_raid56j_header, and put the pending bios for the device into a bio
+ * list. At this stage, we do not submit the real device bio yet.
+ *
+ * Under the following situations, we need to write the journal to disk:
+ * a) the 4KiB is full of entries
+ * b) the data space is full of data
+ * c) explicit flush/sync request
+ *
+ * When we need to write the journal, we will bump up the journal_generation,
+ * build a bio using the 4KiB memory and bios in the list, and submit it to
+ * the real device.
+ *
+ * If the device has write cache, we also need to flush the device.
+ *
+ * Then submit the invovled bios in the list, flush, then convert the journal
+ * back to CLEAN status, and flush again.
+ *
+ * XXX: Do we need the extra flush and set the CLEAN flags?
+ * The extensive flush will definitely hurt performance, while re-do the
+ * journal replay will not hurt anything except mount time.
+ *
+ * RECOVERY WORKFLOW
+ * =================
+ *
+ * At mount time, we load all block groups, and for RAID56J block groups we need
+ * to load their headers into the per-bg-per-dev memory.
+ * Not only for the status but also the journal_generation value.
+ *
+ * If the journal is dirty, we replay the journal, flush, then clean the DIRTY
+ * flag.
+ *
+ * Such journal replay will happen before any other write (even before log
+ * replay) at mount time.
+ */
+struct btrfs_raid56j_header {
+	/* Csum for the header only. */
+	__u8 csum[BTRFS_RAID56J_CSUM_SIZE];
+
+	/* The current status of the RAID56J chunk. */
+	__u32 status;
+
+	/* How many entries we have. */
+	__u32 nr_entries;
+	/*
+	 * Journal generation, we can not go with transid, as for data write
+	 * we have no reliable transid to utilize.
+	 *
+	 * Thus here we introduce a block group specific journal geneartion,
+	 * it get bumped each time a dirty RAID56J header got updated.
+	 * (AKA, just converting DIRTY header to CLEAN won't bumpup the
+	 *  journal geneartion).
+	 */
+	__u64 journal_generation;
+
+	/* Reserved space, and bump the header to 32 bytes. */
+	__u8 __reserved[12];
+} __attribute__ ((__packed__));
+
+/* Pointer for the real data. */
+struct btrfs_raid56j_entry {
+	/* Csum of the data. */
+	__u8 csum[BTRFS_RAID56J_CSUM_SIZE];
+
+	/* Where the journaled data should be written to. */
+	__u64 physical;
+
+	/* Logical bytenr of the data, can be (u64)-1 or (u64)-2 for P/Q. */
+	__u64 logical;
+
+	/*
+	 * Where the data is in the journal.
+	 * Starting from the btrfs_raid56j_header.
+	 *
+	 * Offset can be 0, this means this is a full stripe write, no need to
+	 * journal the write.
+	 * As the COW nature of btrfs ensures the write destination is not used
+	 * by anyone, thus no write hole.
+	 */
+	__u32 offset;
+	__u32 len;
+
+	/* Bump to 32 bytes. */
+	u8 __reserved[4];
+} __attribute__ ((__packed__));
+
 #endif /* _BTRFS_CTREE_H_ */
-- 
2.36.1

