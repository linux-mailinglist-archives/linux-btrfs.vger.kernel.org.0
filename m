Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9A6CB257
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjC0Xb3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjC0Xb1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:31:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39041A6
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:31:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E55BB219F4;
        Mon, 27 Mar 2023 23:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679959884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XTObH/dduPMr91OEB1jp+0xWb7GSKMJRZZ2xxvFY/A=;
        b=CpY3IM3RbnXH2eVtNxMsra1p8qWmj5fnwq6wOaYKduCQ787zllr5xru5stAJnfKf8k8wuG
        4+Zod9wrk5btWqqUV/rZ6EqjWsfw5jvmq52+2g5XCJKr9lRvqyO/qVcwZdJC3Dnc7gYPqL
        2QxvffbI7zTZbFzh7X3mQ7vVUX1PehY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 253BB13482;
        Mon, 27 Mar 2023 23:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4NQvOUsnImTaaAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 27 Mar 2023 23:31:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v5 03/13] btrfs: introduce a new helper to submit read bio for scrub
Date:   Tue, 28 Mar 2023 07:30:53 +0800
Message-Id: <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679959770.git.wqu@suse.com>
References: <cover.1679959770.git.wqu@suse.com>
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

The new helper, btrfs_submit_scrub_read(), would be mostly a subset of
btrfs_submit_bio(), with the following limitations:

- Only supports read
- @mirror_num must be > 0
- No read-time repair nor checksum verification
- The @bbio must not cross stripe boundary

This would provide the basis for unified read repair for scrub, as we no
longer needs to handle RAID56 recovery all by scrub, and RAID56 data
stripes scrub can share the same code of read and repair.

The repair part would be the same as non-RAID56, as we only need to try
the next mirror.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/bio.h |  1 +
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index c1edadc17260..bdef346c542c 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -333,8 +333,8 @@ static void btrfs_end_bio_work(struct work_struct *work)
 {
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
-	/* Metadata reads are checked and repaired by the submitter. */
-	if (bbio->bio.bi_opf & REQ_META)
+	/* Metadata or scrub reads are checked and repaired by the submitter. */
+	if (bbio->bio.bi_opf & REQ_META || !bbio->inode)
 		bbio->end_io(bbio);
 	else
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
@@ -344,7 +344,7 @@ static void btrfs_simple_end_io(struct bio *bio)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_device *dev = bio->bi_private;
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 	btrfs_bio_counter_dec(fs_info);
 
@@ -368,7 +368,8 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
+	if (bio_op(bio) == REQ_OP_READ && bbio->inode &&
+	    !(bbio->bio.bi_opf & REQ_META))
 		btrfs_check_read_bio(bbio, NULL);
 	else
 		btrfs_orig_bbio_end_io(bbio);
@@ -714,6 +715,45 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	return true;
 }
 
+/*
+ * Scrub read special version, with extra limits:
+ *
+ * - Only support read for scrub usage
+ * - @mirror_num must be >0
+ * - No read-time repair nor checksum verification.
+ * - The @bbio must not cross stripe boundary.
+ */
+void btrfs_submit_scrub_read(struct btrfs_bio *bbio, int mirror_num)
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
+	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_READ);
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
index 3b97ce54140a..afbcf318fdda 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -106,6 +106,7 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 #define REQ_BTRFS_ONE_ORDERED			REQ_DRV
 
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_scrub_read(struct btrfs_bio *bbio, int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
-- 
2.39.2

