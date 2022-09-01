Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FB55A9227
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiIAIgM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiIAIgK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 04:36:10 -0400
Received: from out20-159.mail.aliyun.com (out20-159.mail.aliyun.com [115.124.20.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28AF12690B
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 01:36:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1877843|-1;BR=01201311R751S64rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.175463-0.00308505-0.821452;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.P58s3eL_1662021354;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P58s3eL_1662021354)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 16:35:55 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: receive: fix a segfault that free() an err value
Date:   Thu,  1 Sep 2022 16:35:54 +0800
Message-Id: <20220901083554.40166-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed a segfault of 'btrfs receive'.
$ gdb
 #0  process_clone (path=0x23829d0 "after.s1.txt", offset=0, len=2097152, clone_uuid=<optimized out>,
    clone_ctransid=<optimized out>, clone_path=0x2382920 "after.s1.txt", clone_offset=0, user=0x7ffe21985ba0)
    at cmds/receive.c:793
793                     free(si->path);
(gdb) p si
$1 = (struct subvol_info *) 0xfffffffffffffffe

'si' was a ERR value here. so add the check of 'IS_ERR()' before 'free()'.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 cmds/receive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index d106e554..cada6343 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -789,8 +789,8 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	}
 
 out:
-	if (si) {
-		free(si->path);
+	if (si && !IS_ERR(si)) {
+		if(si->path) free(si->path);
 		free(si);
 	}
 	if (clone_fd != -1)
-- 
2.36.2

