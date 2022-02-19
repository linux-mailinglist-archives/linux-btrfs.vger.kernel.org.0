Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6ED4BC707
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Feb 2022 10:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbiBSJBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 19 Feb 2022 04:01:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiBSJBw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 19 Feb 2022 04:01:52 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0283C25F
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 01:01:33 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s16so9849133pgs.13
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Feb 2022 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CxAqFgU6N+8zriBmgSNVCi2Tl/+seHJZodrv8Pm6Q2U=;
        b=qF7JPmIfwzRxt2Mw8zFw7/ezjN1sMFIFORtsa3FW//7cFa4R88ZYQ5iFmLr5ElGHaI
         FZ8QxUqCIqF89vzacvBMNnJ8miD2ZROBcgIZfgLigrGBrb3U/kt/4HF43ekwmhZpniGH
         Q8Mw+0n/Jxj26tFgNy67W7pXjP7j7IDk0LR8xVAeT1fQHhs5FXxdtrTXnd9Ub6QEl88f
         mk67jBRMomWJAXQMaC01pQL3YFk7R1LnhIKBoqTQNKOYZQw4QEry6ebrQ7NB80c3/f7C
         EQIbbJAC736qhIw8GtBlv6uR7SKV4R/R/On/XGEqOA3uc3fpGs0e2D1mIIB3q2B/DE7t
         6ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CxAqFgU6N+8zriBmgSNVCi2Tl/+seHJZodrv8Pm6Q2U=;
        b=VLiAasugzL5BU2cspLVsTI+G0VZVa920hRTQlCOtyVUG88SoSSbQ38mRBgvX2syCzf
         5rEt3Seo0D0bgomACmtLQrPplke/SZ71FZu3lIullVxIFyjNCO80KTf6vcnwPPIViy26
         +wKxzlu2o98OxI60y4PZPJGbHuMAjfUWDp2xJWQWmG2xW5AIamh3ksRmJ38Ixq7i4DjD
         85yozaTcWyoUFAmXOBTmnJTKbhTEfTzwIYjIza5cuLJQK86owNCx/InRZpk+6OEBTrLT
         1yLxgHACz50ilcxsPjTEurayFjcBrbjVYRE4RUydrF01+QLBN0Vn4THgmn5DCslaPGLD
         zlRA==
X-Gm-Message-State: AOAM532fRoTU6fzZrikTRMOBSbut+bKiwbSybHcU/6bp/kM/G4qSM4B4
        n1NGz3a4RsrCbAc7YngzwSt05H9YxCo=
X-Google-Smtp-Source: ABdhPJx+r+lo0Jwsu1Rerg7RrzyL4yI3biCNoXkGWgGSiNficteB2BTM5hkwGcMHkI46Jrr4N2K1kQ==
X-Received: by 2002:a63:451e:0:b0:373:6a1d:2ad9 with SMTP id s30-20020a63451e000000b003736a1d2ad9mr9434157pga.114.1645261292070;
        Sat, 19 Feb 2022 01:01:32 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id z27sm12786026pgk.78.2022.02.19.01.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 01:01:31 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: cmds: subvolume: add -p option on creating subvol
Date:   Sat, 19 Feb 2022 09:01:23 +0000
Message-Id: <20220219090123.51185-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch resolves github issue #429. This patch adds an option that
create parent directories when it creates subvolumes on nonexisting
parents. This option tokenizes dstdir and checks each paths whether
it's existing directory and make directory for creating subvolume.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/subvolume.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index fbf56566..1070c74a 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -88,6 +88,7 @@ static const char * const cmd_subvol_create_usage[] = {
 	"",
 	"-i <qgroupid>  add the newly created subvolume to a qgroup. This",
 	"               option can be given multiple times.",
+	"-p             make any missing parent directories for each argument",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_QUIET,
 	NULL
@@ -105,10 +106,11 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 	char	*dst;
 	struct btrfs_qgroup_inherit *inherit = NULL;
 	DIR	*dirstream = NULL;
+	bool create_parents = false;
 
 	optind = 0;
 	while (1) {
-		int c = getopt(argc, argv, "c:i:");
+		int c = getopt(argc, argv, "c:i:p");
 		if (c < 0)
 			break;
 
@@ -127,6 +129,9 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 				goto out;
 			}
 			break;
+		case 'p':
+			create_parents = true;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -167,6 +172,30 @@ static int cmd_subvol_create(const struct cmd_struct *cmd,
 		goto out;
 	}
 
+	if (create_parents) {
+		char p[PATH_MAX];
+		char dstdir_real[PATH_MAX];
+		char *token;
+
+		realpath(dstdir, dstdir_real);
+		token = strtok(dstdir_real, "/");
+		while(token) {
+			strcat(p, "/");
+			strcat(p, token);
+			res = path_is_dir(p);
+			if (res == -ENOENT) {
+				if (mkdir(p, 0755)) {
+					error("failed to make dir: %s", p);
+					goto out;
+				}
+			} else if (res <= 0) {
+				error("failed to check dir: %s", p);				
+				goto out;
+			}
+			token = strtok(NULL, "/");
+		}
+	}
+
 	fddst = btrfs_open_dir(dstdir, &dirstream, 1);
 	if (fddst < 0)
 		goto out;
-- 
2.25.1

