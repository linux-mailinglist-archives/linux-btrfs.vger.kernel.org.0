Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7A45AB65D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiIBQRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 12:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiIBQQh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 12:16:37 -0400
Received: from out20-193.mail.aliyun.com (out20-193.mail.aliyun.com [115.124.20.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62FB99FD
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 09:13:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1655881|-1;BR=01201311R191S29rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.075437-0.000729577-0.923833;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.P6LozWK_1662135207;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.P6LozWK_1662135207)
          by smtp.aliyun-inc.com;
          Sat, 03 Sep 2022 00:13:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v2] btrfs-progs: receive: fix a segfault that free() an err value
Date:   Sat,  3 Sep 2022 00:13:27 +0800
Message-Id: <20220902161327.45283-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20220901083554.40166-1-wangyugui@e16-tech.com>
References: <20220901083554.40166-1-wangyugui@e16-tech.com>
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

I noticed a segfault of 'btrfs receive'.
$ gdb
 #0  process_clone (path=0x23829d0 "after.s1.txt", offset=0, len=2097152, clone_uuid=<optimized out>,
    clone_ctransid=<optimized out>, clone_path=0x2382920 "after.s1.txt", clone_offset=0, user=0x7ffe21985ba0)
    at cmds/receive.c:793
793                     free(si->path);
(gdb) p si
$1 = (struct subvol_info *) 0xfffffffffffffffe

'si' was an ERR value. so add the check of '!IS_ERR_OR_NULL()' before 'free()'
just similar to process_snapshot().

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
changes since v1:
 let the check similar to process_snapshot().

 cmds/receive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index aec32458..bf476387 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -811,7 +811,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 	}
 
 out:
-	if (si) {
+	if (!IS_ERR_OR_NULL(si)) {
 		free(si->path);
 		free(si);
 	}
-- 
2.36.2

