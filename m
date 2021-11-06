Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26374446CBA
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Nov 2021 07:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhKFGhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Nov 2021 02:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhKFGhb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Nov 2021 02:37:31 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A20C061570
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 23:34:50 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b13so12452561plg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFJ8oEmEky2LWens0h0Q6g5/A1Ebq0lbhpDF9KBBA/I=;
        b=iDgwrEKDWFniB3ldPutmWLRrcTtIkd4MsFU4oeAQZzkzibL4bpAPK4nj7CZiiIE01O
         qs3v3X/CraxWeR+kse4OT7YRGGBUhvw5+S71MnhQgGtaaQl7gnrWRzDyNioqJ9HXAxv0
         RaJgLtbK0fn0dHcD28bAn6iQ7feJdU1Q3B4UkpITppRnFX0auPtGYTdQ7O0G89UH7okw
         ant+ZImtahhAprI062TZSa8wOSoJgYc7NIWms768dyZEqHZPB7Y+oaaUiQVY89vTJOnY
         KmSKx9hF751SUWgtwmva0T05Hc3ZOt3rPQa+Xsui0qXT87vgSTWiWw6i0+bvkYx8DVHs
         7fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IFJ8oEmEky2LWens0h0Q6g5/A1Ebq0lbhpDF9KBBA/I=;
        b=ekvvHMsPvNIdASp7R8OrETMVBYDtMmgaAtSFTmWBJ9t7ghBx/OW1/+5fDDeXR5mkPj
         4dSwOSwcbq7xJqZZe07n++e4KudssUq3x7/e59OnVtPtsPN2RIZC53hGKscIk+rmnREg
         LmpkiyVIROQkSP9cRgPsgV9RU5a6KOC1fy//uyQAH2pONlKhlaDoDmuUiSSy+JSroNv9
         3rl2h+yuUaOGZdXOnANCMTUwvczWRkqgRaMrIvKTVG3HUrXnGaW3ClwBhlzmi0/IJite
         Y2lDenbIroV83UUzyB/FPiPhbDxbSMjBZTh8uFsigNGa0/s1P5dDrmFNajCv5WvYcxz8
         DmWQ==
X-Gm-Message-State: AOAM531dVkX6SNHoil8+6Y2gCRyPybH42KbZgiGCw1JFh5ZYrlT1uuaD
        QH24xVKA3ZKAC2rDJZaPFbvR8MZPMP7i7Q==
X-Google-Smtp-Source: ABdhPJwOVNVi4rWnB6Ec09PRVcWeKoDxra2i1r0r0XN22NbnHKZ4FkwnJLz9mBWikZH6kAGGzzIhDA==
X-Received: by 2002:a17:90b:4a47:: with SMTP id lb7mr30367208pjb.243.1636180489043;
        Fri, 05 Nov 2021 23:34:49 -0700 (PDT)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id c3sm9630245pji.0.2021.11.05.23.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 23:34:48 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: balance: print warn msg in background
Date:   Sat,  6 Nov 2021 06:34:40 +0000
Message-Id: <20211106063440.116987-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The commit 099157d8 has problem that when it executes in background, it
would not print warning message. Because before printing it makes
background process that can't print anymore. This patch fixes this
problem by making background process after printing message. For that,
this patch adds background flags for do_balance().

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 cmds/balance.c | 100 +++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 49 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 2e903b5c..1e1db468 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -300,7 +300,8 @@ static int do_balance_v1(int fd)
 
 enum {
 	BALANCE_START_FILTERS = 1 << 0,
-	BALANCE_START_NOWARN  = 1 << 1
+	BALANCE_START_NOWARN  = 1 << 1,
+	BALANCE_START_BACKGROUND = 1 << 2
 };
 
 static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
@@ -310,18 +311,6 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	int ret;
 	DIR *dirstream = NULL;
 
-	fd = btrfs_open_dir(path, &dirstream, 1);
-	if (fd < 0)
-		return 1;
-
-	ret = check_running_fs_exclop(fd, BTRFS_EXCLOP_BALANCE, enqueue);
-	if (ret != 0) {
-		if (ret < 0)
-			error("unable to check status of exclusive operation: %m");
-		close_file_or_dir(fd, dirstream);
-		return 1;
-	}
-
 	if (!(flags & BALANCE_START_FILTERS) && !(flags & BALANCE_START_NOWARN)) {
 		int delay = 10;
 
@@ -340,6 +329,54 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 		printf("\nStarting balance without any filters.\n");
 	}
 
+	if (flags & BALANCE_START_BACKGROUND) {
+		switch (fork()) {
+		case (-1):
+			error("unable to fork to run balance in background");
+			return 1;
+		case (0):
+			setsid();
+			switch(fork()) {
+			case (-1):
+				error(
+				"unable to fork to run balance in background");
+				exit(1);
+			case (0):
+				/*
+				 * Read the return value to silence compiler
+				 * warning. Change to / should succeed and
+				 * we're not in a security-sensitive context.
+				 */
+				ret = chdir("/");
+				close(0);
+				close(1);
+				close(2);
+				open("/dev/null", O_RDONLY);
+				open("/dev/null", O_WRONLY);
+				open("/dev/null", O_WRONLY);
+				break;
+			default:
+				exit(0);
+			}
+			break;
+		default:
+			exit(0);
+		}
+	}
+
+	fd = btrfs_open_dir(path, &dirstream, 1);
+	if (fd < 0)
+		return 1;
+
+	ret = check_running_fs_exclop(fd, BTRFS_EXCLOP_BALANCE, enqueue);
+	if (ret != 0) {
+		if (ret < 0)
+			error("unable to check status of exclusive operation: %m");
+		close_file_or_dir(fd, dirstream);
+		return 1;
+	}
+
+
 	ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, args);
 	if (ret < 0) {
 		/*
@@ -415,7 +452,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	struct btrfs_balance_args *ptrs[] = { &args.data, &args.sys,
 						&args.meta, NULL };
 	int force = 0;
-	int background = 0;
 	bool enqueue = false;
 	unsigned start_flags = 0;
 	bool raid56_warned = false;
@@ -479,7 +515,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 			start_flags |= BALANCE_START_NOWARN;
 			break;
 		case GETOPT_VAL_BACKGROUND:
-			background = 1;
+			start_flags |= BALANCE_START_BACKGROUND;
 			break;
 		case GETOPT_VAL_ENQUEUE:
 			enqueue = true;
@@ -569,40 +605,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 		args.flags |= BTRFS_BALANCE_FORCE;
 	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		dump_ioctl_balance_args(&args);
-	if (background) {
-		switch (fork()) {
-		case (-1):
-			error("unable to fork to run balance in background");
-			return 1;
-		case (0):
-			setsid();
-			switch(fork()) {
-			case (-1):
-				error(
-				"unable to fork to run balance in background");
-				exit(1);
-			case (0):
-				/*
-				 * Read the return value to silence compiler
-				 * warning. Change to / should succeed and
-				 * we're not in a security-sensitive context.
-				 */
-				i = chdir("/");
-				close(0);
-				close(1);
-				close(2);
-				open("/dev/null", O_RDONLY);
-				open("/dev/null", O_WRONLY);
-				open("/dev/null", O_WRONLY);
-				break;
-			default:
-				exit(0);
-			}
-			break;
-		default:
-			exit(0);
-		}
-	}
 
 	return do_balance(argv[optind], &args, start_flags, enqueue);
 }
-- 
2.25.1

