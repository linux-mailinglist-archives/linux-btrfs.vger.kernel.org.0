Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156FF46466C
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346729AbhLAFV5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37882 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346739AbhLAFVz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EF18C1FD2F;
        Wed,  1 Dec 2021 05:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGoATI8QhpJQFUqpKLovdoPmLhCegyDIShiT0EoICN4=;
        b=HBk8iT1VcldRuyrVjDbwSVrmVOzKIq67TvNOSoVD8IKy2iMJIMDQ9UiZdDnS44OJn9/WmL
        Um9JqtEzAOi6GoMM7FYJ16WKNKm/Fv1un9IZfnoumjfxN9ZaC+ft5YW/kRp085qD3QWasY
        DQIDxVuJSMPLKLsf52bSIpRuFntVzIA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2D0513425;
        Wed,  1 Dec 2021 05:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4HzNL6gFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 14/17] btrfs: remove buffered IO stripe boundary calculation
Date:   Wed,  1 Dec 2021 13:17:53 +0800
Message-Id: <20211201051756.53742-15-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will remove btrfs_bio_ctrl::len_to_stripe_boundary, so that buffer
IO will no longer limits its bio size according to stripe length.

This will move the bio split to btrfs_map_bio() for all buffered IO.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8f5a1059a296..7fabf46312dd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3301,7 +3301,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 
 	ASSERT(bio);
 	/* The limit should be calculated when bio_ctrl->bio is allocated */
-	ASSERT(bio_ctrl->len_to_oe_boundary && bio_ctrl->len_to_stripe_boundary);
+	ASSERT(bio_ctrl->len_to_oe_boundary);
 	if (bio_ctrl->bio_flags != bio_flags)
 		return 0;
 
@@ -3312,9 +3312,7 @@ static int btrfs_bio_add_page(struct btrfs_bio_ctrl *bio_ctrl,
 	if (!contig)
 		return 0;
 
-	real_size = min(bio_ctrl->len_to_oe_boundary,
-			bio_ctrl->len_to_stripe_boundary) - bio_size;
-	real_size = min(real_size, size);
+	real_size = min(bio_ctrl->len_to_oe_boundary - bio_size, size);
 
 	/*
 	 * If real_size is 0, never call bio_add_*_page(), as even size is 0,
@@ -3335,11 +3333,8 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
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
@@ -3350,22 +3345,8 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
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
-- 
2.34.1

