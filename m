Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B9A628F00
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 02:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiKOBPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 20:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKOBPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 20:15:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511F11C30;
        Mon, 14 Nov 2022 17:15:20 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NB7X635n1z1DDP;
        Tue, 15 Nov 2022 09:15:18 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4NB7X25synz9vSp6;
        Tue, 15 Nov 2022 09:15:14 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4NB7Wz3TRSz9tyD6;
        Tue, 15 Nov 2022 09:15:11 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NB7Wv6x4zz8RV7J;
        Tue, 15 Nov 2022 09:15:07 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2AF1Etol097501;
        Tue, 15 Nov 2022 09:14:55 +0800 (+08)
        (envelope-from guo.ziliang@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid32;
        Tue, 15 Nov 2022 09:14:56 +0800 (CST)
Date:   Tue, 15 Nov 2022 09:14:56 +0800 (CST)
X-Zmail-TransId: 2afb6372e810ffffffffb7f1a3c7
X-Mailer: Zmail v1.0
Message-ID: <202211150914564821972@zte.com.cn>
Mime-Version: 1.0
From:   <guo.ziliang@zte.com.cn>
To:     <clm@fb.com>, <josef@toxicpanda.com>
Cc:     <dsterba@suse.com>, <linux-btrfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <guo.ziliang@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGJ0cmZzOiByZW1vdmUgcmVkdW5kYW50IHJldCB2YXJpYWJsZSBpbiBkZWxldGVfdjFfc3BhY2VfY2FjaGU=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2AF1Etol097501
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID 6372E825.001 by FangMail milter!
X-FangMail-Envelope: 1668474918/4NB7X635n1z1DDP/6372E825.001/10.35.20.121/[10.35.20.121]/mxde.zte.com.cn/<guo.ziliang@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6372E825.001/4NB7X635n1z1DDP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: guo ziliang <guo.ziliang@zte.com.cn>
Return value from delete_block_group_cache() directly instead of taking
this in another redundant variable.

Signed-off-by: guo ziliang <guo.ziliang@zte.com.cn>
---
 fs/btrfs/relocation.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 56c8afa..d7f76cf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3374,7 +3374,6 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
        struct btrfs_key key;
        bool found = false;
        int i;
-       int ret;

        if (btrfs_header_owner(leaf) != BTRFS_ROOT_TREE_OBJECTID)
                return 0;
@@ -3398,9 +3397,8 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
        }
        if (!found)
                return -ENOENT;
-       ret = delete_block_group_cache(leaf->fs_info, block_group, NULL,
+       return delete_block_group_cache(leaf->fs_info, block_group, NULL,
                                        space_cache_ino);
-       return ret;
 }

 /*
--
1.8.3.1
