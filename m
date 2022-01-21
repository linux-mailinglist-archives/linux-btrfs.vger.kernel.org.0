Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55F2495E83
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 12:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380206AbiAULms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 06:42:48 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:17890 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350181AbiAULmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 06:42:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2RfJw4_1642765347;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V2RfJw4_1642765347)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 19:42:32 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: scrub: Remove redundant initialization of increment
Date:   Fri, 21 Jan 2022 19:42:24 +0800
Message-Id: <20220121114224.92247-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

increment is being initialized to map->stripe_len but this is never
read as increment is overwritten later on. Remove the redundant
initialization.

Cleans up the following clang-analyzer warning:

fs/btrfs/scrub.c:3193:6: warning: Value stored to 'increment' during its
initialization is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/scrub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2e9a322773f2..38f5666eff14 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3209,7 +3209,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	offset = 0;
 	nstripes = div64_u64(dev_extent_len, map->stripe_len);
 	mirror_num = 1;
-	increment = map->stripe_len;
 	if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
 		offset = map->stripe_len * stripe_index;
 		increment = map->stripe_len * map->num_stripes;
-- 
2.20.1.7.g153144c

