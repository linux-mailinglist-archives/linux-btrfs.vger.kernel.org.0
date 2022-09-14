Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B25C5B8125
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 07:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiINF6x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 01:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiINF6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 01:58:51 -0400
Received: from out20-135.mail.aliyun.com (out20-135.mail.aliyun.com [115.124.20.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780C5E33B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Sep 2022 22:58:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0487|-1;BR=01201311R451S57rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.000332677-0.000259552-0.999408;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PF99VO._1663135127;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PF99VO._1663135127)
          by smtp.aliyun-inc.com;
          Wed, 14 Sep 2022 13:58:47 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: balance: fix some cases wrongly parsed as old syntax
Date:   Wed, 14 Sep 2022 13:58:46 +0800
Message-Id: <20220914055846.52008-1-wangyugui@e16-tech.com>
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

Some cases of 'btrfs balance' are wrongly parsed as old syntax.

an example:
$ btrfs balance status
ERROR: cannot access 'status': No such file or directory

currently, only 'start' is successfully excluded in the check of old syntax.
fix it by adding others in the check of old syntax.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 cmds/balance.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index c5e10f92..bafd1714 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -852,8 +852,23 @@ static const struct cmd_group balance_cmd_group = {
 
 static int cmd_balance(const struct cmd_struct *cmd, int argc, char **argv)
 {
-	if (argc == 2 && strcmp("start", argv[1]) != 0) {
-		/* old 'btrfs filesystem balance <path>' syntax */
+	bool old_syntax = true; /* old 'btrfs balance <path>' syntax */
+	if (argc >= 2)
+	{
+		int i;
+		for (i = 0; balance_cmd_group.commands[i] != NULL; i++)
+		{
+			if (strcmp(argv[1], balance_cmd_group.commands[i]->token) == 0)
+			{
+				old_syntax = false;
+				break;
+			}
+		}
+	} else {
+		old_syntax = false;
+	}
+	if (old_syntax)
+	{
 		struct btrfs_ioctl_balance_args args;
 
 		memset(&args, 0, sizeof(args));
-- 
2.36.2

