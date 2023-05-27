Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A27D7136F0
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 May 2023 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjE0WCd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 27 May 2023 18:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE0WCc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 27 May 2023 18:02:32 -0400
Received: from out28-41.mail.aliyun.com (out28-41.mail.aliyun.com [115.124.28.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10F5D9
        for <linux-btrfs@vger.kernel.org>; Sat, 27 May 2023 15:02:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09327763|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00870056-0.000287083-0.991012;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.TEHcCYJ_1685224946;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.TEHcCYJ_1685224946)
          by smtp.aliyun-inc.com;
          Sun, 28 May 2023 06:02:26 +0800
Date:   Sun, 28 May 2023 06:02:28 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: please fold some fix into misc-next(btrfs: print assertion failure report and stack trace from the same line)
Message-Id: <20230528060227.AF10.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

please fold some fix into misc-next(btrfs: print assertion failure report and stack trace from the same line).

Because 'btrfs_assertfail' become macro(inline), we should drop it from objtools.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f937be1afe65..060032cfb046 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -170,7 +170,6 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"__reiserfs_panic",
 		"__stack_chk_fail",
 		"__ubsan_handle_builtin_unreachable",
-		"btrfs_assertfail",
 		"cpu_bringup_and_idle",
 		"cpu_startup_entry",
 		"do_exit",

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2023/05/28


