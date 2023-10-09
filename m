Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85987BE5E6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 18:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376985AbjJIQI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377709AbjJIQI4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 12:08:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D891
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696867732; x=1728403732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sohYJTlLUIagJnil5eTYEqcF53eW4Az67dyejwYcU0U=;
  b=H32ZfnbgmNsXHADnb484KieUJMAwemyLI6NSFsirUskgAWjJqGi8AkZF
   A48giC47K43krvNhkNJsjth1ATkfstMmdaMbsfkxZoGfgyMjy2tmenqCc
   w70x7xjZ9GnPqCEFI9Y1i/x9fls9tbeaA/pqzT3rmvtM/xSsBXftFfMRk
   EofU9+ZSznLxfqeEoa0AR8aVlgw1pXQW/tWX6G6dGJy4DN0NzMSGdCzFt
   idxmA4/MoOUyqXEgllKB6wKQlneArUujJx9DZtaHBifzHHq7pCE57GMvA
   MPbMxn0b1yJBYE9rcVe0N+mi8nnTeMCIl8oCALqHr0a/XHAOy81zpEbT4
   g==;
X-CSE-ConnectionGUID: VQvFBf3eRue2PDm7wIK9hg==
X-CSE-MsgGUID: Azf5wqj7RVONERpYrFDaIQ==
X-IronPort-AV: E=Sophos;i="6.03,210,1694707200"; 
   d="scan'208";a="246083169"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2023 00:00:29 +0800
IronPort-SDR: gXl8BcBtLmTbnWaKl6/HFskSMYfbh69gtoMSLjtsLiactmQq76vjA0CKmuQS/yCEswTpoVEI/u
 bvOOVlS+YI0YfAM3pE22oYftAGGoLRI+a/7CVq8yWnl2REIj171sQ4B4eKwVaJpvUrG66Tub9I
 Qb9S6zZy1cCoG5Fkag/B0+exiakbCDxqy8GbtJ1pEa/XY9Kn0DvfeBxivxhxUinY9x2ui057rY
 bjbnrcusH5fXFNOLuNc9wzNYWVYuP9Aps7ZCFWok/OLdDTsHv2ZP/T0CKAuKFCu19CV0BtyW2l
 yMA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 08:12:40 -0700
IronPort-SDR: u5eyCUk4aDzFOSpPGewps3iRAVP9S2GGkAn0lNJbbpa8gdmmCXqVT9/M/rHp075uNw1KQ3ynDz
 MZxqnba2YVHrWwnf2UhQ/XMltD0TEEPCKuH0NKdK98RIxBpZbYXf9PrDcdNl2HguijmomasmPb
 1V+3srHwb6Oejtf9INrSIRh0lMBCTRAMPG75GhUzp1dHKt3na6ECTIhz6YcRe4YRNlCZZ6TQ5O
 jfS+9z0gVw0F33xF/fpkx8h3mdouvhZer/u733I1q/fJ4QzrHTuV+7BuXj257VmZgDmG1ancd/
 NM0=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2023 09:00:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Qu Wenru <wqu@suse.com>
Subject: [PATCH] btrfs: perform stripe tree lookup for scrub
Date:   Mon,  9 Oct 2023 09:00:13 -0700
Message-ID: <4895772fd73872ee2cc23d152e50db28a5ca5bbc.1696867165.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In case we're scrubbing a filesystem which uses the RAID stripe tree for
multi-device logical to physical address translation, perform an extra
block mapping step to get the real on0disk stripe length from the stripe
tree when scrubbing the sectors.

This prevents a double completion of the btrfs_bio caused by splitting the
underlying bio and ultimately a use-after-free.

Cc: Qu Wenru <wqu@suse.com>
Fixes: 0708614f9c28 ("btrfs: scrub: implement raid stripe tree support")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c477a14f1281..2ac574bde350 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1640,6 +1640,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	struct btrfs_bio *bbio = NULL;
+	u64 stripe_len = BTRFS_STRIPE_LEN;
 	int mirror = stripe->mirror_num;
 	int i;
 
@@ -1651,8 +1652,9 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 
 		/* The current sector cannot be merged, submit the bio. */
 		if (bbio &&
-		    ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
-		     bbio->bio.bi_iter.bi_size >= BTRFS_STRIPE_LEN)) {
+		    ((i > 0 &&
+		      !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
+		     bbio->bio.bi_iter.bi_size >= stripe_len)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
 			atomic_inc(&stripe->pending_io);
 			btrfs_submit_bio(bbio, mirror);
@@ -1660,10 +1662,26 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 		}
 
 		if (!bbio) {
+			struct btrfs_io_stripe io_stripe = {};
+			struct btrfs_io_context *bioc = NULL;
+			const u64 logical = stripe->logical +
+					    (i << fs_info->sectorsize_bits);
+			int err;
+
 			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
 					       fs_info, scrub_read_endio, stripe);
-			bbio->bio.bi_iter.bi_sector = (stripe->logical +
-				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
+			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
+
+			io_stripe.is_scrub = true;
+			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
+					      &stripe_len, &bioc, &io_stripe,
+					      &mirror);
+			btrfs_put_bioc(bioc);
+			if (err) {
+				btrfs_bio_end_io(bbio,
+						 errno_to_blk_status(err));
+				return;
+			}
 		}
 
 		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
-- 
2.41.0

