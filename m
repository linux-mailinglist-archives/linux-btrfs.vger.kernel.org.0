Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCBF6CB9E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC1IxY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 04:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjC1IxW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 04:53:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68554C2D
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 01:53:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5AC6E210EB;
        Tue, 28 Mar 2023 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679993599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0QO/FNWFiB5WvJqDAWumA2xOHVaoqfhgJes4XEMQP3A=;
        b=iJ23TQMO7tzXxYdGuvTiXUN3Jym6lKnUHKhbk9pAkgA7OzCEKDhRIgEFd+YVGYpGRGSqOA
        ScNuV15spnYa/LoYSmWl5U8WigyMJ3ACOH49Y/M6kx2auyCsCwFDdi61e4gGbnwFQjfOlK
        C1SmTlyy8J5GruBYZXBkC4uJWy6QkWc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 903791390B;
        Tue, 28 Mar 2023 08:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cGzKF/6qImRBMwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Mar 2023 08:53:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v6 04/13] btrfs: introduce a new helper to submit write bio for scrub
Date:   Tue, 28 Mar 2023 16:52:48 +0800
Message-Id: <72f4fa26c35f2e649bc562a80a40955d745f1118.1679993368.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679993368.git.wqu@suse.com>
References: <cover.1679993368.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like the special scrub read, scrub write also has its extra niches:

- Only write back to single device
  Even for read-repair on RAID56, we only update the corrupted data
  stripe itself, not triggering the full RMW path.

  This makes scrub writeback a perfect match for the single stripe
  quick path.

- Requires a valid @mirror_num
  For RAID56 case, only @mirror_num == 1 is supported.
  For non-RAID56 cases, we need @mirror_num to locate our stripe.

- Need to manually specify if it's for dev-replace
  For scrub path we can write back to the original device (for
  read-repair) and to the target device (for replace) at the same
  time, but with different sectors (read-repair only writes repaired
  sectors, while dev-replace writes all good sectors).

  So here we need a bool to specify the case.

- No data csum generation

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/bio.h |  2 ++
 2 files changed, 94 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index bdef346c542c..34902d58bb4b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -754,6 +754,98 @@ void btrfs_submit_scrub_read(struct btrfs_bio *bbio, int mirror_num)
 	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
 }
 
+/*
+ * Scrub write special version. Some extra limits:
+ *
+ * - Only support write back for dev-replace and scrub read-repair.
+ *   This means, the write bio, even for RAID56, would only
+ *   be mapped to single device.
+ *
+ * - @mirror_num must be >0.
+ *   To indicate which mirror to be written.
+ *   If it's RAID56, it must be 1 (data stripes).
+ *
+ * - The @bbio must not cross stripe boundary.
+ *
+ * - If @dev_replace is true, the resulted stripe must be mapped to
+ *   replace source device.
+ *
+ * - No csum geneartion.
+ */
+void btrfs_submit_scrub_write(struct btrfs_bio *bbio, int mirror_num,
+			      bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
+	u64 logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 length = bbio->bio.bi_iter.bi_size;
+	u64 map_length = length;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_io_stripe smap;
+	int ret;
+
+	ASSERT(fs_info);
+	ASSERT(mirror_num > 0);
+	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
+	ASSERT(!bbio->inode);
+
+	btrfs_bio_counter_inc_blocked(fs_info);
+	ret = __btrfs_map_block(fs_info, btrfs_op(&bbio->bio), logical,
+				&map_length, &bioc, &smap, &mirror_num, 1);
+	if (ret)
+		goto fail;
+
+	/* Caller should ensure the @bbio doesn't cross stripe boundary. */
+	ASSERT(map_length >= length);
+	if (btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE && btrfs_is_zoned(fs_info)) {
+		bbio->bio.bi_opf &= ~REQ_OP_WRITE;
+		bbio->bio.bi_opf |= REQ_OP_ZONE_APPEND;
+	}
+
+	if (!bioc)
+		goto submit;
+
+	/* Map the RAID56 multi-stripe writes to a single one. */
+	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+		int data_stripes = (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5) ?
+				    bioc->num_stripes - 1 : bioc->num_stripes - 2;
+		int i;
+
+		/* This special write only works for data stripes. */
+		ASSERT(mirror_num == 1);
+		for (i = 0; i < data_stripes; i++) {
+			u64 stripe_start = bioc->full_stripe_logical +
+					   (i << BTRFS_STRIPE_LEN_SHIFT);
+
+			if (logical >= stripe_start &&
+			    logical < stripe_start + BTRFS_STRIPE_LEN)
+				break;
+		}
+		ASSERT(i < data_stripes);
+		smap.dev = bioc->stripes[i].dev;
+		smap.physical = bioc->stripes[i].physical +
+				((logical - bioc->full_stripe_logical) &
+				 BTRFS_STRIPE_LEN_MASK);
+		goto submit;
+	}
+	ASSERT(mirror_num <= bioc->num_stripes);
+	smap.dev = bioc->stripes[mirror_num - 1].dev;
+	smap.physical = bioc->stripes[mirror_num - 1].physical;
+submit:
+	ASSERT(smap.dev);
+	btrfs_put_bioc(bioc);
+	bioc = NULL;
+	if (dev_replace) {
+		ASSERT(smap.dev == fs_info->dev_replace.srcdev);
+		smap.dev = fs_info->dev_replace.tgtdev;
+	}
+	__btrfs_submit_bio(&bbio->bio, bioc, &smap, mirror_num);
+	return;
+
+fail:
+	btrfs_bio_counter_dec(fs_info);
+	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
+}
+
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
 {
 	while (!btrfs_submit_chunk(bbio, mirror_num))
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index afbcf318fdda..ad5a6a558662 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -107,6 +107,8 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
 void btrfs_submit_scrub_read(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_scrub_write(struct btrfs_bio *bbio, int mirror_num,
+			      bool dev_replace);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
-- 
2.39.2

