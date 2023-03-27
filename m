Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19CF6CB259
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjC0Xb2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC0Xb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:31:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1942AC4
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:31:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CABA2219EE
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 23:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679959883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vtQbI5So0pRBdifHXaDi6PDwlzR/FPZmEdvhSmpzdc=;
        b=pDy1Pq5hODzfB1XqkB7V53h/cXVMv7vPQH2HQx52/FBH513TnN4NO3DdBS+g3k74d7agCE
        RRSR1LyHvovUkb32YlLkXhJsHPx5Z7pJfki8qK2r62swMHcnURYC2b+1I1+EwoVPHamc3/
        3jUGinoRziDPxkbwULqxZ0qnPh6OnCs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CACA13482
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 23:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2HcQO0onImTaaAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 23:31:22 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 02/13] btrfs: introduce a new allocator for scrub specific btrfs_bio
Date:   Tue, 28 Mar 2023 07:30:52 +0800
Message-Id: <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1679959770.git.wqu@suse.com>
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

Currently we're doing a lot of work for btrfs_bio:

- Checksum verification for data read bios
- Bio splits if it crosses stripe boundary
- Read repair for data read bios

However for the incoming scrub patches, we don't want those extra
functionality at all, just pure logical + mirror -> physical mapping
ability.

Thus here we introduce:

- btrfs_bio::fs_info
  This is for the new scrub specific btrfs_bio, which would not
  populate btrfs_bio::inode.
  Thus we need such new member to grab a fs_info

  This new member would always be populated.

- btrfs_scrub_bio_alloc() helper
  The main differences between this and btrfs_bio_alloc() are:
  * No need for nr_vecs
    As we know scrub bio should not cross stripe boundary.

  * Use @fs_info to replace @inode parameter

- An extra ASSERT() to make sure btrfs_bio::fs_info is populated

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 25 +++++++++++++++++++++++++
 fs/btrfs/bio.h | 19 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edb..c1edadc17260 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -36,6 +36,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
 {
 	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
 	bbio->inode = inode;
+	bbio->fs_info = inode->root->fs_info;
 	bbio->end_io = end_io;
 	bbio->private = private;
 	atomic_set(&bbio->pending_ios, 1);
@@ -61,6 +62,30 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
+/*
+ * Allocate a scrub specific btrfs_bio structure.
+ *
+ * This btrfs_bio would not go through any the btrfs special handling like
+ * checksum verification nor read-repair.
+ */
+struct btrfs_bio *btrfs_scrub_bio_alloc(blk_opf_t opf,
+					struct btrfs_fs_info *fs_info,
+					btrfs_bio_end_io_t end_io, void *private)
+{
+	struct btrfs_bio *bbio;
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(NULL, BTRFS_STRIPE_LEN >> fs_info->sectorsize_bits,
+			       opf, GFP_NOFS, &btrfs_bioset);
+	bbio = btrfs_bio(bio);
+	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->fs_info = fs_info;
+	bbio->end_io = end_io;
+	bbio->private = private;
+	atomic_set(&bbio->pending_ios, 1);
+	return bbio;
+}
+
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length, bool use_append)
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index dbf125f6fa33..3b97ce54140a 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -30,7 +30,12 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
  * passed to btrfs_submit_bio for mapping to the physical devices.
  */
 struct btrfs_bio {
-	/* Inode and offset into it that this I/O operates on. */
+	/*
+	 * Inode and offset into it that this I/O operates on.
+	 *
+	 * @inode can be NULL for callers who don't want any advanced features
+	 * like read-time repair.
+	 */
 	struct btrfs_inode *inode;
 	u64 file_offset;
 
@@ -58,6 +63,15 @@ struct btrfs_bio {
 	atomic_t pending_ios;
 	struct work_struct end_io_work;
 
+	/*
+	 * For cases where callers only want to read/write from a logical
+	 * bytenr, in that case @inode can be NULL, and we need such
+	 * @fs_info pointer to grab the corresponding fs_info.
+	 *
+	 * Should always be populated.
+	 */
+	struct btrfs_fs_info *fs_info;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
@@ -78,6 +92,9 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
 struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 				  struct btrfs_inode *inode,
 				  btrfs_bio_end_io_t end_io, void *private);
+struct btrfs_bio *btrfs_scrub_bio_alloc(blk_opf_t opf,
+					struct btrfs_fs_info *fs_info,
+					btrfs_bio_end_io_t end_io, void *private);
 
 static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
-- 
2.39.2

