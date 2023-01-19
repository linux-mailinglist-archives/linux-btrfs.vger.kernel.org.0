Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF83067316E
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 06:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjASF5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 00:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjASF5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 00:57:20 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0558010B;
        Wed, 18 Jan 2023 21:57:18 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NyBjS4srnz4xVnD;
        Thu, 19 Jan 2023 13:57:16 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
        by mse-fl1.zte.com.cn with SMTP id 30J5vBpv048128;
        Thu, 19 Jan 2023 13:57:11 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 19 Jan 2023 13:57:13 +0800 (CST)
Date:   Thu, 19 Jan 2023 13:57:13 +0800 (CST)
X-Zmail-TransId: 2af963c8dbb9ffffffffd31ce984
X-Mailer: Zmail v1.0
Message-ID: <202301191357131455025@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <clm@fb.com>
Cc:     <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBidHJmczogc2NydWI6IFJlbW92ZSBjb21waWxhdGlvbiBlcnJvcnMgd2hlbsKgLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVk?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30J5vBpv048128
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.138.novalocal with ID 63C8DBBC.000 by FangMail milter!
X-FangMail-Envelope: 1674107836/4NyBjS4srnz4xVnD/63C8DBBC.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63C8DBBC.000/4NyBjS4srnz4xVnD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

fs/btrfs/scrub.c: In function
'scrub_raid56_data_stripe_for_parity.isa.0':
fs/btrfs/scrub.c:3297:9 error: 'ret' may be used uninitialized in this
function [-Werror=maybe-uninitialized]

fs/btrfs/scrub.c: In function
'scrub_simple_mirror':
fs/btrfs/scrub.c:3530:9 error: 'ret' may be used uninitialized in this
function [-Werror=maybe-uninitialized]

Initialize 'ret' to aviod compilation errors.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a5d026041be4..d0ddf930cb79 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3198,7 +3198,7 @@ static int scrub_raid56_data_stripe_for_parity(struct scrub_ctx *sctx,
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, logical);
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
 	u64 cur_logical = logical;
-	int ret;
+	int ret = 0;

 	ASSERT(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK);

@@ -3424,7 +3424,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	const u32 max_length = SZ_64K;
 	struct btrfs_path path = { 0 };
 	u64 cur_logical = logical_start;
-	int ret;
+	int ret = 0;

 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
-- 
2.25.1
