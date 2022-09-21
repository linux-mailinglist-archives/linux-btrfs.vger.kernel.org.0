Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C3D5C01C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Sep 2022 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiIUPjF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiIUPio (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 11:38:44 -0400
Received: from out20-194.mail.aliyun.com (out20-194.mail.aliyun.com [115.124.20.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125BAF75
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 08:34:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04814807|-1;BR=01201311R201S00rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.000481968-9.22835e-05-0.999426;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PL24rt-_1663774456;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PL24rt-_1663774456)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 23:34:17 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: balance: deprecate old syntax
Date:   Wed, 21 Sep 2022 23:34:16 +0800
Message-Id: <20220921153416.53863-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20220914055846.52008-1-wangyugui@e16-tech.com>
References: <20220914055846.52008-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

deprecate btrfs blanace old syntax since new syntax is already introduced in
2012.

we will remove the old syntax completely in a few releases.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 cmds/balance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index d1e66d42..3cb6334a 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -37,7 +37,7 @@
 
 static const char * const balance_cmd_group_usage[] = {
 	"btrfs balance <command> [options] <path>",
-	"btrfs balance <path>",
+	"btrfs balance <path>        deprecated by 'btrfs balance replace'",
 	NULL
 };
 
@@ -882,6 +882,8 @@ static int cmd_balance(const struct cmd_struct *cmd, int argc, char **argv)
 		/* old 'btrfs filesystem balance <path>' syntax */
 		struct btrfs_ioctl_balance_args args;
 
+		warning("deprecated by 'btrfs balance replace'");
+
 		memset(&args, 0, sizeof(args));
 		args.flags |= BTRFS_BALANCE_TYPE_MASK;
 
-- 
2.36.2

