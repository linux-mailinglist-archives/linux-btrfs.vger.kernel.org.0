Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93299EA7D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfJ3Xeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 19:34:50 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42348 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJ3Xet (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 19:34:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id m4so4839205qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 16:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnvQKr00lcp7W3rou9u91KKXF7CowzuhIEK3agkqeyw=;
        b=itd8Ng3Eo1LrOA7ymTai8lBdKDCRqaOSB+2P0KLpZX61R4BnoBGOlEZdjrrJS++8d/
         l96rsBxo3Ek7Vg3laoAM5vYtbIb7p2GUWWWfABSsurmOD662t/m2qcv+SAktALUAUpiI
         Z5EDHUsgOf4E99QKw/K/vO7FR3F8ul4q+FluEhud66yrjAetu6w16LYXADIu6tjpJzNH
         z21upoevVLToZ+mcW7YJr3vKS8DUt6qUtAwFPoqoa0yUNhdK0ZVOI1y+lCfMrcLr2Cti
         xHy8r8+qhoMKOcFCAMT0yE/+RbXs4p/HDmZfU/RQuJlSgj5nc3GW00VjjWpmfIESpoys
         3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnvQKr00lcp7W3rou9u91KKXF7CowzuhIEK3agkqeyw=;
        b=ZHQzPgcmteL31KFc76INmYsM1xIdOoC3NpT6hhLDDDO3d4daRHTJjN/dq8yP/jDMoA
         HEFvxko6iRyVjoFvNLgX55AH1UxWUh8/vmErZxgBVYt6SJflSajA4cHboOu7qBqro5ah
         GUC0VrDV4YEA05xw85Q0tndrLncqcqa2jPQ7dCq4oRT43W6fXVSywVvYyB6Mx2PvD165
         eOshE/sL3OhFFCHJURf9p9lMWX7PXo6FJ8ZAw/0KCeUO4setqRqURZA0Awfuc7qXLSNr
         CnBQks6lCDS7UyJgYnodWFBYo/UND69qTmGXSz29QhgJSDadfD46cO7wN0nPU6gWnuAJ
         5FUg==
X-Gm-Message-State: APjAAAUfaTdEqtca0AiyZpNbnjpbaeD6YQerl0SVA5DwnyPX0aRErXGI
        lQqxucEaJyjPUdvwqAIZzxg=
X-Google-Smtp-Source: APXvYqyc436/DO/LbnehqZ0ba2XbbAOMNTZLO0ZpKB/zJ5MYZQrey//hKiIaUzKlxAwM/HG/empf9Q==
X-Received: by 2002:a37:9d96:: with SMTP id g144mr2602578qke.93.1572478488685;
        Wed, 30 Oct 2019 16:34:48 -0700 (PDT)
Received: from localhost.localdomain (179.187.204.103.dynamic.adsl.gvt.net.br. [179.187.204.103])
        by smtp.gmail.com with ESMTPSA id c185sm820317qkf.122.2019.10.30.16.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 16:34:48 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org, mpdesouza@suse.com,
        anand.jain@oracle.com
Subject: [PATCH btrfs-progs 2/2] btrfs-progs: balance: Verify EINPROGRESS on background balance
Date:   Wed, 30 Oct 2019 20:36:41 -0300
Message-Id: <20191030233641.30123-3-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030233641.30123-1-marcos.souza.org@gmail.com>
References: <20191030233641.30123-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Introduce a sleep of 3 seconds after triggering balance to check if
isn't there another balance already being executed.

Fix: #167

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/balance.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index f0394a2e..2accc102 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <fcntl.h>
 #include <errno.h>
 
@@ -507,6 +508,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	int force = 0;
 	int verbose = 0;
 	int background = 0;
+	pid_t child;
 	unsigned start_flags = 0;
 	int i;
 
@@ -639,13 +641,13 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	if (verbose)
 		dump_ioctl_balance_args(&args);
 	if (background) {
-		switch (fork()) {
+		switch (child = fork()) {
 		case (-1):
 			error("unable to fork to run balance in background");
 			return 1;
 		case (0):
 			setsid();
-			switch(fork()) {
+			switch(child = fork()) {
 			case (-1):
 				error(
 				"unable to fork to run balance in background");
@@ -663,10 +665,21 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 				open("/dev/null", O_WRONLY);
 				break;
 			default:
+				/* wait up to three seconds to check if balance
+				 * isn't already running */
+				i = 0;
+				while (waitpid(child, NULL, WNOHANG) == 0 && i++ < 3)
+					sleep(1);
+
+				/* ensure that any error message from
+				 * do_balance is flushed */
+				fflush(stderr);
 				exit(0);
 			}
 			break;
 		default:
+			/* Wait for the first child to return */
+			waitpid(child, NULL, 0);
 			exit(0);
 		}
 	}
-- 
2.23.0

