Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0545D1A22C3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgDHNPO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 09:15:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54787 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHNPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Apr 2020 09:15:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2so5093710wmb.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Apr 2020 06:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eGB+z88QBKI4z7bpY2ndD948lGvPF1y9bISTrgy54ew=;
        b=DSJN+D3Y447gnDbuY7RghbK3npUbF4cU3PgwQo+aGJaSal+R05BgBIN01PL7hcat9b
         Y8T7NI13ILHviHvdwEl3MVSsi6Th6mCRUaH/QI7ppx1CyUolIKsQLBHmKynEpQvs3Pr3
         bv9cGhYITjqxASprljvZWetk/u3/x2Gn377EvhrcwsX+Wm4w93gE9Yb8O5h9Dq9XQi4Y
         d1GoV2u3lXfLMHS7Rn6gcK8A5vFLRsGZ4XXBS/lkoyB5Zap60OP/o6wz3E9KADI+WkoK
         gAjC02/sgFvz/+Aifp4xZ+2UF4vud0Q/CbwqdAYvhmRpi7VU4Ab1IxXA3+j0JUmOMZXe
         Yjpw==
X-Gm-Message-State: AGi0Pubw0iSugG3S3IIKk6wBqmiN1B/okVYQt6Pgvi8e5Ec4eKUN312I
        6i0W7q5Wv5mSTA51anG208BLCPLc
X-Google-Smtp-Source: APiQypJYGGvUOwMZh871wS89FB0yYFs4GikOYOzfTEcC20rSFI7mrMMAgJt4PEV5TiBlZslZAe8r1g==
X-Received: by 2002:a1c:9a87:: with SMTP id c129mr4365173wme.149.1586351711373;
        Wed, 08 Apr 2020 06:15:11 -0700 (PDT)
Received: from jkm (79-98-75-217.sys-data.com. [79.98.75.217])
        by smtp.gmail.com with ESMTPSA id n6sm6926941wmn.10.2020.04.08.06.15.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:15:10 -0700 (PDT)
Date:   Wed, 8 Apr 2020 15:15:09 +0200
From:   Petr Janecek <janecek@ucw.cz>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 1/3] btrfs-progs: move '--background' fork()s to
 do_balance()
Message-ID: <20200408131508.GB19101@jkm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the '--background' forking to happen after btrfs_open_dir(),
so that the possible 'wrong path' error message can be seen the user.
---
 cmds/balance.c | 78 ++++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 5392a604..fada2ab3 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -426,8 +426,9 @@ static int do_balance_v1(int fd)
 }
 
 enum {
-	BALANCE_START_FILTERS = 1 << 0,
-	BALANCE_START_NOWARN  = 1 << 1
+	BALANCE_START_FILTERS    = 1 << 0,
+	BALANCE_START_NOWARN     = 1 << 1,
+	BALANCE_START_BACKGROUND = 1 << 2
 };
 
 static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
@@ -436,11 +437,47 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	int fd;
 	int ret;
 	DIR *dirstream = NULL;
+	int i __attribute__((unused));
 
 	fd = btrfs_open_dir(path, &dirstream, 1);
 	if (fd < 0)
 		return 1;
 
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
+				i = chdir("/");
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
 	ret = ioctl(fd, BTRFS_IOC_BALANCE_V2, args);
 	if (ret < 0) {
 		/*
@@ -510,7 +547,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 						&args.meta, NULL };
 	int force = 0;
 	int verbose = 0;
-	int background = 0;
 	unsigned start_flags = 0;
 	int i;
 
@@ -570,7 +606,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 			start_flags |= BALANCE_START_NOWARN;
 			break;
 		case GETOPT_VAL_BACKGROUND:
-			background = 1;
+			start_flags |= BALANCE_START_BACKGROUND;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -642,40 +678,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 		args.flags |= BTRFS_BALANCE_FORCE;
 	if (verbose)
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
 
 	return do_balance(argv[optind], &args, start_flags);
 }
-- 
2.26.0

