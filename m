Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09765ED7EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiI1IgZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiI1IgR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168629DB5C
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B07F921DB5
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNdal+AsoCfNvw/+gkFogUmFeApT9oGJ8ibErbSLnhM=;
        b=SXvN5KKxIqgzpFpkkx5mDKD6X51CQYeI2R9XViXw1ccA87KenSTUH5JwIeNgd8VRl4tLtJ
        mbUWMkWuspec65n/qhYIjE9kkaeQaBi7fCnrRDG4e2HqKiIxMuwbYKCpI3FFt4vWfvd8Zx
        hcG2iIyu1BKn/OnDOKFU7WGrCOYbr2I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F00D413A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gLQCLX4HNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 08/10] btrfs: scrub: implement data verification code for scrub_fs
Date:   Wed, 28 Sep 2022 16:35:45 +0800
Message-Id: <e699b31bdc9a4e56c6afbd308e77240944111ca4.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
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

For data verification it's much simpler, only need to do csum
verification and we already have very handy helper for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a693e35d172d..efe49a04dceb 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -5117,6 +5117,41 @@ static void scrub_fs_verify_meta(struct scrub_fs_endio_ctrl *endio_ctrl,
 	}
 }
 
+static void scrub_fs_verify_data(struct scrub_fs_endio_ctrl *endio_ctrl,
+				 int sector_nr, int mirror_nr)
+{
+	struct scrub_fs_ctx *sfctx = endio_ctrl->sfctx;
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	struct scrub_fs_sector *sector =
+		scrub_fs_get_sector(sfctx, sector_nr, mirror_nr);
+	u8 csum_result[BTRFS_CSUM_SIZE] = {0};
+	u8 *csum_expected = sector->csum;
+	unsigned int set_flag;
+	int ret;
+
+	scrub_fs_check_sector_mirror_nr(sfctx, sector_nr, mirror_nr);
+
+	/*
+	 * No checksum case, we can not determine if it's preallocate or real
+	 * NODATASUM. Just mark it good unconditionally.
+	 */
+	if (!csum_expected) {
+		set_flag = SCRUB_FS_SECTOR_FLAG_GOOD;
+		goto out;
+	}
+
+	ret = btrfs_check_sector_csum(fs_info,
+			scrub_fs_get_page(sfctx, sector_nr, mirror_nr),
+			scrub_fs_get_page_offset(sfctx, sector_nr, mirror_nr),
+			csum_result, csum_expected);
+	if (ret < 0)
+		set_flag = SCRUB_FS_SECTOR_FLAG_BAD_CSUM;
+	else
+		set_flag = SCRUB_FS_SECTOR_FLAG_GOOD;
+out:
+	sector->flags |= set_flag;
+}
+
 static void scrub_fs_read_endio(struct bio *bio)
 {
 	struct scrub_fs_endio_ctrl *endio_ctrl = bio->bi_private;
@@ -5163,9 +5198,10 @@ static void scrub_fs_read_endio(struct bio *bio)
 		    !(sector->flags & SCRUB_FS_SECTOR_FLAG_IO_DONE))
 			continue;
 
-		/* Place holder for data verification. */
-		if (sector->flags & SCRUB_FS_SECTOR_FLAG_DATA)
+		if (sector->flags & SCRUB_FS_SECTOR_FLAG_DATA) {
+			scrub_fs_verify_data(endio_ctrl, i, mirror_nr);
 			continue;
+		}
 
 		/* We must be at a metadata sector. */
 		ASSERT(sector->flags & SCRUB_FS_SECTOR_FLAG_META);
-- 
2.37.3

