Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18CA59721C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiHQO6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiHQO6P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:58:15 -0400
Received: from out20-193.mail.aliyun.com (out20-193.mail.aliyun.com [115.124.20.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F241D9C2DC
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:58:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.05329251|-1;BR=01201311R201S10rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.038773-2.09112e-05-0.961206;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Ovar2Eo_1660748280;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ovar2Eo_1660748280)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 22:58:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v3]btrfs: round down stripe size and chunk size to pow of 2
Date:   Wed, 17 Aug 2022 22:58:00 +0800
Message-Id: <20220817145800.36175-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
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
it is better to free-then-reuse the free space if stripe size is kept or
changed to 1/2. so stripe size of pow of 2 will be more friendly. Although
roundup_pow_of_two() match better with orig round_up(), but
rounddown_pow_of_two() is better to make sure <=ctl->max_chunk_size here.

In another rare case that file system is quite small, we calc max chunk size
in pow of 2 too, so that max chunk size / chunk size /stripe size are same or
match easy in some case.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
changes since v2:
	restore to rounddown_pow_of_two() from roundup_pow_of_two()
changes since v1:
 - change rounddown_pow_of_two() to roundup_pow_of_two() to match better with
   orig roundup().

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
+		 * Reduce stripe_size, round it down to pow of 2 boundary again and
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

