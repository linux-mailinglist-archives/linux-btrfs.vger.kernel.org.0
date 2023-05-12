Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3306FFFFB
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 May 2023 07:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjELFpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 May 2023 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239720AbjELFpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 May 2023 01:45:18 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C57A1731;
        Thu, 11 May 2023 22:45:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ViNqtb._1683870298;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0ViNqtb._1683870298)
          by smtp.aliyun-inc.com;
          Fri, 12 May 2023 13:45:14 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: scrub: Remove some unused functions
Date:   Fri, 12 May 2023 13:44:57 +0800
Message-Id: <20230512054457.43501-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These functions are defined in the scrub.c file, but not called
elsewhere, so delete these unused functions.

fs/btrfs/scrub.c:553:20: warning: unused function 'scrub_stripe_index_and_offset'.
fs/btrfs/scrub.c:543:19: warning: unused function 'scrub_nr_raid_mirrors'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4937
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/scrub.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 836725a19661..6fd90c8fd64a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -540,48 +540,6 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 	btrfs_free_path(path);
 }
 
-static inline int scrub_nr_raid_mirrors(struct btrfs_io_context *bioc)
-{
-	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
-		return 2;
-	else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID6)
-		return 3;
-	else
-		return (int)bioc->num_stripes;
-}
-
-static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
-						 u64 full_stripe_logical,
-						 int nstripes, int mirror,
-						 int *stripe_index,
-						 u64 *stripe_offset)
-{
-	int i;
-
-	if (map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
-		const int nr_data_stripes = (map_type & BTRFS_BLOCK_GROUP_RAID5) ?
-					    nstripes - 1 : nstripes - 2;
-
-		/* RAID5/6 */
-		for (i = 0; i < nr_data_stripes; i++) {
-			const u64 data_stripe_start = full_stripe_logical +
-						(i * BTRFS_STRIPE_LEN);
-
-			if (logical >= data_stripe_start &&
-			    logical < data_stripe_start + BTRFS_STRIPE_LEN)
-				break;
-		}
-
-		*stripe_index = i;
-		*stripe_offset = (logical - full_stripe_logical) &
-				 BTRFS_STRIPE_LEN_MASK;
-	} else {
-		/* The other RAID type */
-		*stripe_index = mirror;
-		*stripe_offset = 0;
-	}
-}
-
 static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 {
 	int ret = 0;
-- 
2.20.1.7.g153144c

