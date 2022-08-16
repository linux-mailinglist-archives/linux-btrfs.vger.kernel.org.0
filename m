Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86CD5952E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 08:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiHPGqm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 02:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiHPGqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 02:46:07 -0400
Received: from out20-135.mail.aliyun.com (out20-135.mail.aliyun.com [115.124.20.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44641F1B
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Aug 2022 18:46:06 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07495412|-1;BR=01201311R321S61rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0381165-2.06985e-05-0.961863;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OuGef1A_1660614363;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OuGef1A_1660614363)
          by smtp.aliyun-inc.com;
          Tue, 16 Aug 2022 09:46:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: round down stripe size and chunk size to pow of 2
Date:   Tue, 16 Aug 2022 09:46:03 +0800
Message-Id: <20220816014603.1247-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In decide_stripe_size_regular(), when new disk is added to RAID0/RAID10/RAID56,
it is better to alloc/reuse the free space if stripe size is kept or
changed to 1/2. so stripe size and chunk size of pow of 2 will be more
friendly.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 fs/btrfs/volumes.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6595755..fab9765 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5083,9 +5083,9 @@ static void init_alloc_chunk_ctl_policy_regular(
 	if (ctl->type & BTRFS_BLOCK_GROUP_SYSTEM)
 		ctl->devs_max = min_t(int, ctl->devs_max, BTRFS_MAX_DEVS_SYS_CHUNK);
 
-	/* We don't want a chunk larger than 10% of writable space */
-	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
-				  ctl->max_chunk_size);
+	/* We don't want a chunk larger than 1/8 of writable space */
+	ctl->max_chunk_size = min_t(u64, ctl->max_chunk_size,
+			rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
 	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
 }
 
@@ -5143,10 +5143,9 @@ static void init_alloc_chunk_ctl_policy_zoned(
 		BUG();
 	}
 
-	/* We don't want a chunk larger than 10% of writable space */
-	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
-			       zone_size),
-		    min_chunk_size);
+	/* We don't want a chunk larger than 1/8 of writable space */
+	limit = max_t(u64, min_chunk_size,
+		rounddown_pow_of_two(fs_devices->total_rw_bytes >> 3));
 	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
 	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
 }
@@ -5284,13 +5283,12 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 	 */
 	if (ctl->stripe_size * data_stripes > ctl->max_chunk_size) {
 		/*
-		 * Reduce stripe_size, round it up to a 16MB boundary again and
+		 * Reduce stripe_size, round down to pow of 2 boundary again and
 		 * then use it, unless it ends up being even bigger than the
 		 * previous value we had already.
 		 */
-		ctl->stripe_size = min(round_up(div_u64(ctl->max_chunk_size,
-							data_stripes), SZ_16M),
-				       ctl->stripe_size);
+		ctl->stripe_size = min_t(u64, ctl->stripe_size,
+			rounddown_pow_of_two(div_u64(ctl->max_chunk_size, data_stripes)));
 	}
 
 	/* Align to BTRFS_STRIPE_LEN */
-- 
2.36.2

