Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1393F5BA518
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 05:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIPDVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 23:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPDVJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 23:21:09 -0400
X-Greylist: delayed 362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 20:21:06 PDT
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E00181B24;
        Thu, 15 Sep 2022 20:21:04 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1])
        by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea6323e97f584-61dad;
        Fri, 16 Sep 2022 11:12:00 +0800 (CST)
X-RM-TRANSID: 2eea6323e97f584-61dad
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16323e9764d3-ab849;
        Fri, 16 Sep 2022 11:12:00 +0800 (CST)
X-RM-TRANSID: 2ee16323e9764d3-ab849
From:   liujing <liujing@cmss.chinamobile.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] btrfs: fixed an incorrect variable assignment
Date:   Thu, 15 Sep 2022 23:11:49 -0400
Message-Id: <20220916031149.6140-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the btrfs_reclaim_bgs_work function, 
there is an assignment of int ret =0, 
but this assignment is not used in the following code, 
so it can be defined as int ret.

Signed-off-by: liujing <liujing@cmss.chinamobile.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c52b6e245b9a..a4c7fb423244 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1571,7 +1571,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
 	while (!list_empty(&fs_info->reclaim_bgs)) {
 		u64 zone_unusable;
-		int ret = 0;
+		int ret;
 
 		bg = list_first_entry(&fs_info->reclaim_bgs,
 				      struct btrfs_block_group,
-- 
2.18.2



