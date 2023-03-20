Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344876C08D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Mar 2023 03:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCTCNY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Mar 2023 22:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCTCNX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Mar 2023 22:13:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4948F5FD1
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Mar 2023 19:13:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E75CF1F37F
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679278400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QNTD9vhpj3i/VReb/quDJUYkdMhZjIdCpG6bLSugHk=;
        b=bgoJ05LEmpbp2r3OMxAIwwEpo2auhhsrxnqiqTxtW6xtTOKFBCvoyCPweYEDp1FuwW0dfX
        NMeZIDELwRT/fGyRjA39xZWWCA2BJr9cLcdO0hKwgHn6Y1pgUGQc/yJxAmK9fbAzHYdxNI
        AqQfme2K9Epye6p9cvQyibZCc9KE7bI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D587313416
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6K3EJz/BF2QLPQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Mar 2023 02:13:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 02/12] btrfs: introduce a new helper to submit bio for scrub
Date:   Mon, 20 Mar 2023 10:12:48 +0800
Message-Id: <b61263cba690fd894e21d75442556ae2f150f095.1679278088.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679278088.git.wqu@suse.com>
References: <cover.1679278088.git.wqu@suse.com>
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
---
 fs/btrfs/bio.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++----
 fs/btrfs/bio.h | 17 ++++++++++++++++-
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edb..b96f40160b08 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -39,6 +39,8 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
 	bbio->end_io = end_io;
 	bbio->private = private;
 	atomic_set(&bbio->pending_ios, 1);
+	if (inode)
+		bbio->fs_info = inode->root->fs_info;
 }
 
 /*
@@ -308,8 +310,8 @@ static void btrfs_end_bio_work(struct work_struct *work)
 {
 	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
 
-	/* Metadata reads are checked and repaired by the submitter. */
-	if (bbio->bio.bi_opf & REQ_META)
+	/* Metadata or scrub reads are checked and repaired by the submitter. */
+	if (bbio->bio.bi_opf & REQ_META || !bbio->inode)
 		bbio->end_io(bbio);
 	else
 		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
@@ -319,7 +321,8 @@ static void btrfs_simple_end_io(struct bio *bio)
 {
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_device *dev = bio->bi_private;
-	struct btrfs_fs_info *fs_info = bbio->inode->root->fs_info;
+	struct btrfs_fs_info *fs_info = bbio->inode ?
+		bbio->inode->root->fs_info : bbio->fs_info;
 
 	btrfs_bio_counter_dec(fs_info);
 
@@ -343,7 +346,8 @@ static void btrfs_raid56_end_io(struct bio *bio)
 
 	btrfs_bio_counter_dec(bioc->fs_info);
 	bbio->mirror_num = bioc->mirror_num;
-	if (bio_op(bio) == REQ_OP_READ && !(bbio->bio.bi_opf & REQ_META))
+	if (bio_op(bio) == REQ_OP_READ && bbio->inode &&
+	    !(bbio->bio.bi_opf & REQ_META))
 		btrfs_check_read_bio(bbio, NULL);
 	else
 		btrfs_orig_bbio_end_io(bbio);
@@ -689,6 +693,46 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
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
+void btrfs_submit_scrub_read(struct btrfs_fs_info *fs_info,
+			     struct btrfs_bio *bbio, int mirror_num)
+{
+	struct btrfs_bio *orig_bbio = bbio;
+	u64 logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 length = bbio->bio.bi_iter.bi_size;
+	u64 map_length = length;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_io_stripe smap;
+	int ret;
+
+	ASSERT(mirror_num > 0);
+	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_READ);
+	ASSERT(!bbio->inode);
+
+	bbio->fs_info = fs_info;
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
+	btrfs_bio_end_io(orig_bbio, ret);
+}
+
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
 {
 	while (!btrfs_submit_chunk(bbio, mirror_num))
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index dbf125f6fa33..073df13365e4 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -30,7 +30,13 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  * passed to btrfs_submit_bio for mapping to the physical devices.
  */
 struct btrfs_bio {
-	/* Inode and offset into it that this I/O operates on. */
+	/*
+	 * Inode and offset into it that this I/O operates on.
+	 *
+	 * @inode can be NULL for callers who don't want any advanced features
+	 * like read-time repair.
+	 * In that case, @fs_info must be properly initialized.
+	 */
 	struct btrfs_inode *inode;
 	u64 file_offset;
 
@@ -58,6 +64,13 @@ struct btrfs_bio {
 	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
+	/*
+	 * For cases where callers only want to read/write from a logical
+	 * bytenr, in that case @inode can be NULL, and we need such
+	 * @fs_info pointer to grab the corresponding fs_info.
+	 */
+	struct btrfs_fs_info *fs_info;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
@@ -89,6 +102,8 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 #define REQ_BTRFS_ONE_ORDERED			REQ_DRV
 
 void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_scrub_read(struct btrfs_fs_info *fs_info,
+			     struct btrfs_bio *bbio, int mirror_num);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct page *page,
 			    unsigned int pg_offset, int mirror_num);
-- 
2.39.2

