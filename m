Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB4159F9B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 14:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbiHXMUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbiHXMUb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 08:20:31 -0400
Received: from out20-217.mail.aliyun.com (out20-217.mail.aliyun.com [115.124.20.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057872716A
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 05:20:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1334502|-1;BR=01201311R171S12rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.130341-2.12849e-05-0.869638;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.P-tC7iH_1661343626;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P-tC7iH_1661343626)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 20:20:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: mkfs.btrfs use same stripe/chunk size as kernel when fs > 50G
Date:   Wed, 24 Aug 2022 20:20:26 +0800
Message-Id: <20220824122026.26273-1-wangyugui@e16-tech.com>
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

When mkfs.btrfs a 1TB device, the allocated chunks are
  Data:             single            8.00MiB
  Metadata:         DUP               1.00GiB
  System:           DUP               8.00MiB
After 'btrfs balance start -f', the allocated chunks are
  Data:             single            1.00GiB
  Metadata:         DUP               1.00GiB
  System:           DUP               32.00MiB

So here we sync stripe/chunk size with kernel for the most common case that
fs size > 50G, although there are still some cases to sync.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 kernel-shared/volumes.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 40032a4b..a17c0e85 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1189,6 +1189,11 @@ error:
 static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
 						struct alloc_chunk_ctl *ctl)
 {
+	/*
+	 * kernel: calc_chunk_size() init_alloc_chunk_ctl_policy_regular()
+	 * sync stripe/chunk size with kernel when fs size > 50G
+	 * and keep min btrfs file system size unchanged.
+	 */
 	u64 type = ctl->type;
 	u64 percent_max;
 
@@ -1204,19 +1209,30 @@ static void init_alloc_chunk_ctl_policy_regular(struct btrfs_fs_info *info,
 			ctl->min_stripe_size = SZ_64M;
 			ctl->max_stripes = BTRFS_MAX_DEVS(info);
 		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
-			/* For larger filesystems, use larger metadata chunks */
-			if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
-				ctl->max_chunk_size = SZ_1G;
-			else
-				ctl->max_chunk_size = SZ_256M;
+			ctl->max_chunk_size = SZ_256M;
 			ctl->stripe_size = ctl->max_chunk_size;
 			ctl->min_stripe_size = SZ_32M;
 			ctl->max_stripes = BTRFS_MAX_DEVS(info);
 		}
 	}
 
+	/* sync stripe/chunk size with kernel when fs size > 50G */
+	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G){
+		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
+			ctl->stripe_size = SZ_32M;
+			ctl->max_chunk_size = ctl->stripe_size * 2;
+		} else if (type & BTRFS_BLOCK_GROUP_DATA) {
+			ctl->stripe_size = SZ_1G;
+			ctl->max_chunk_size = 10 * ctl->stripe_size;
+		} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
+			ctl->max_chunk_size = SZ_1G;
+			ctl->stripe_size = ctl->max_chunk_size;
+		}
+	}
+
 	/* We don't want a chunk larger than 10% of the FS */
-	percent_max = div_factor(btrfs_super_total_bytes(info->super_copy), 1);
+	ASSERT(btrfs_super_total_bytes(info->super_copy) == info->fs_devices->total_rw_bytes);
+	percent_max = div_factor(info->fs_devices->total_rw_bytes, 1);
 	ctl->max_chunk_size = min(percent_max, ctl->max_chunk_size);
 }
 
-- 
2.36.2

