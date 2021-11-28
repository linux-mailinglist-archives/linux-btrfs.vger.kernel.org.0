Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0B74604D7
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352409AbhK1GAn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 01:00:43 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhK1F6m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:58:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2DEF1FCA1;
        Sun, 28 Nov 2021 05:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLucbzsCxyRVu0nLz48aeNMN8EZoET87ZEzYBa+Em3A=;
        b=ubOl6sspNw4Tqq+6q9ujI2DpJ2OU/HgSZ+45jF5agOrB33/xe/VVTS2qshY75Tvy4tivMz
        Crl8nw4LHviw7YQ5VaOurEFtYUwY/sHSb4T8rBd4ClZ/RCNKpZdag9SmGeDoTkKGetyky1
        QOMGxbyYL48Cod8S31v/HGE53/L9IPg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABE8D13446;
        Sun, 28 Nov 2021 05:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHW2HlsZo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 10/11] btrfs: remove btrfs_bio_ctrl::len_to_stripe_boundary
Date:   Sun, 28 Nov 2021 13:52:58 +0800
Message-Id: <20211128055259.39249-11-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128055259.39249-1-wqu@suse.com>
References: <20211128055259.39249-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we can split bio at btrfs_map_bio() time, there is no need to do
bio split for stripe boundaries at submit_extent_page() time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 23 ++---------------------
 fs/btrfs/extent_io.h |  1 -
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 91013c1dce25..9c845b2c50f8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3295,7 +3295,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
-	ASSERT(bio_ctrl->len_to_oe_boundary && bio_ctrl->len_to_stripe_boundary);
+	ASSERT(bio_ctrl->len_to_oe_boundary);
 	if (bio_ctrl->bio_flags != bio_flags)
 		return 0;
 
@@ -3306,9 +3306,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	if (!contig)
 		return 0;
 
-	real_size = min(bio_ctrl->len_to_oe_boundary,
-			bio_ctrl->len_to_stripe_boundary) - bio_size;
-	real_size = min(real_size, size);
+	real_size = min(bio_ctrl->len_to_oe_boundary - bio_size, size);
 
 	/*
 	 * If real_size is 0, never call bio_add_*_page(), as even size is 0,
@@ -3329,11 +3327,8 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 			       struct btrfs_inode *inode, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_io_geometry geom;
 	struct btrfs_ordered_extent *ordered;
-	struct extent_map *em;
 	u64 logical = (bio_ctrl->bio->bi_iter.bi_sector << SECTOR_SHIFT);
-	int ret;
 
 	/*
 	 * Pages for compressed extent are never submitted to disk directly,
@@ -3344,22 +3339,8 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
 	 */
 	if (bio_ctrl->bio_flags & EXTENT_BIO_COMPRESSED) {
 		bio_ctrl->len_to_oe_boundary = U32_MAX;
-		bio_ctrl->len_to_stripe_boundary = U32_MAX;
 		return 0;
 	}
-	em = btrfs_get_chunk_map(fs_info, logical, fs_info->sectorsize);
-	if (IS_ERR(em))
-		return PTR_ERR(em);
-	ret = btrfs_get_io_geometry(fs_info, em, btrfs_op(bio_ctrl->bio),
-				    logical, &geom);
-	free_extent_map(em);
-	if (ret < 0) {
-		return ret;
-	}
-	if (geom.len > U32_MAX)
-		bio_ctrl->len_to_stripe_boundary = U32_MAX;
-	else
-		bio_ctrl->len_to_stripe_boundary = (u32)geom.len;
 
 	if (!btrfs_is_zoned(fs_info) ||
 	    bio_op(bio_ctrl->bio) != REQ_OP_ZONE_APPEND) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index cb727b77ecda..b4897597b445 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -109,7 +109,6 @@ struct extent_buffer {
 struct btrfs_bio_ctrl {
 	struct bio *bio;
 	unsigned long bio_flags;
-	u32 len_to_stripe_boundary;
 	u32 len_to_oe_boundary;
 };
 
-- 
2.34.0

