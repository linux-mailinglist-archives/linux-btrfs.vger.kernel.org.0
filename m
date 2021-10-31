Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB04A440C86
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Oct 2021 03:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhJaCYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Oct 2021 22:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhJaCYa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Oct 2021 22:24:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B83C061570
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 19:21:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id i5so9368632pla.5
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Oct 2021 19:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tEvWJvLYbj9uEmFedGufIKvd5CfgeFov6N8yZGTwz58=;
        b=eN4KqPkufVSm0FSxF4davgi8zgIiOdTNfcHOAVe7mEQY9oY+c9ADhth4GGiBG4NvmB
         ZOP55KsFbU8DLdsM9xHrXZZv0+s56sjmBSLPrvNKvmtw31a1L/CGQujygeHSbIp+C2Kq
         XRxIYXUD5uAcuMdBbMinBoNihRi7Gq6T7Aqnz5CxFKo2GVxH3F6graOsKV/GO7afJSj2
         VcBhUMDMJO5oIdjRQ9hzdpD/ngycq3qfcWxgY3GOjg1QE+P2tvrIOmGUFMXVTFI7E7rH
         W+AVO6AJgIr8ErUfazLupzwkEY6op424YfPUpHxvKfRZkGHfPmgtzcIbfkRtoIv828id
         BWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tEvWJvLYbj9uEmFedGufIKvd5CfgeFov6N8yZGTwz58=;
        b=UjdSmWTfTmRfF4Y8EErdY0k9UEGABhH3pm43S6hV3qhl5sSTjiIF4dFILgkg5qU6Uo
         B43oJsdPeZiKOwgFb11u6N1T1BlL5P5IAU2A7C1uzbKiEXaLDpaCMcU7C6oYy59KSeZP
         PetZyPEpmUD/tXJRRt7ggzKMuem5V5FXAFwqQ4jJi8A8jOPB1yUWMCBXdvtXJItobyU+
         wTnpwvkQJEez+moxTEa/6Cg2Rt/HWbFFnot9zNCIko727YFLLmd6Aps4qNT8ab55Us1k
         nkTiXS6V6LA5NAp+xqmomjv0eV01HlRPTP5Pra+iBhP0pOdbJRy4RUn7kO/qbIXIpACU
         l+hQ==
X-Gm-Message-State: AOAM530qzl9uagn9yEnAsaCCZ5JC/vxnf1xSpj8qz45Dz6LOmY5L5naZ
        NGo8RpMZTALadx76EM7RrjDter4nhSdvTw==
X-Google-Smtp-Source: ABdhPJx9oD1UbFmjUcOODcXEHSsEZVbTyU4fF0FdZ5p4W5RxYzhvCjk/044x7uFvWzos1VNxBBu8rQ==
X-Received: by 2002:a17:90a:4fa1:: with SMTP id q30mr20836894pjh.12.1635646919241;
        Sat, 30 Oct 2021 19:21:59 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id v12sm9653515pjs.0.2021.10.30.19.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 19:21:59 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: balance: print warn mesg in old command
Date:   Sun, 31 Oct 2021 02:21:52 +0000
Message-Id: <20211031022152.41730-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch makes old balance command to print warn mesg same as in start
command. It makes a function that print warn mesg and commands use that
function.

Issue: #411

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/balance.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 7abc69d9..8d8db8a2 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -303,6 +303,25 @@ enum {
 	BALANCE_START_NOWARN  = 1 << 1
 };
 
+static void print_start_warn_mesg()
+{
+	int delay = 10;
+
+	printf("WARNING:\n\n");
+	printf("\tFull balance without filters requested. This operation is very\n");
+	printf("\tintense and takes potentially very long. It is recommended to\n");
+	printf("\tuse the balance filters to narrow down the scope of balance.\n");
+	printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
+	printf("\twarning. The operation will start in %d seconds.\n", delay);
+	printf("\tUse Ctrl-C to stop it.\n");
+	while (delay) {
+		printf("%2d", delay--);
+		fflush(stdout);
+		sleep(1);
+	}
+	printf("\nStarting balance without any filters.\n");
+}
+
 static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 		      unsigned flags, bool enqueue)
 {
@@ -548,21 +567,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	}
 
 	if (!(start_flags & BALANCE_START_FILTERS) && !(start_flags & BALANCE_START_NOWARN)) {
-		int delay = 10;
-
-		printf("WARNING:\n\n");
-		printf("\tFull balance without filters requested. This operation is very\n");
-		printf("\tintense and takes potentially very long. It is recommended to\n");
-		printf("\tuse the balance filters to narrow down the scope of balance.\n");
-		printf("\tUse 'btrfs balance start --full-balance' option to skip this\n");
-		printf("\twarning. The operation will start in %d seconds.\n", delay);
-		printf("\tUse Ctrl-C to stop it.\n");
-		while (delay) {
-			printf("%2d", delay--);
-			fflush(stdout);
-			sleep(1);
-		}
-		printf("\nStarting balance without any filters.\n");
+		print_start_warn_mesg();
 	}
 
 	if (force)
@@ -886,6 +891,8 @@ static int cmd_balance(const struct cmd_struct *cmd, int argc, char **argv)
 		memset(&args, 0, sizeof(args));
 		args.flags |= BTRFS_BALANCE_TYPE_MASK;
 
+		print_start_warn_mesg();
+
 		/* No enqueueing supported for the obsolete syntax */
 		return do_balance(argv[1], &args, 0, false);
 	}
-- 
2.25.1

