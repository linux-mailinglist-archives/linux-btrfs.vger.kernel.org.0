Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05AC414FDA8
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 15:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgBBOvQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 09:51:16 -0500
Received: from voltaic.bi-co.net ([134.119.3.22]:57006 "EHLO voltaic.bi-co.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726679AbgBBOvQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 2 Feb 2020 09:51:16 -0500
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Sun, 02 Feb 2020 09:51:16 EST
Received: from bevan-thinkpad.fritz.box (aftr-95-222-27-110.unity-media.net [95.222.27.110])
        by voltaic.bi-co.net (Postfix) with ESMTPSA id D3FA4202F9;
        Sun,  2 Feb 2020 15:45:59 +0100 (CET)
From:   Michael Lass <bevan@bi-co.net>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael Lass <bevan@bi-co.net>
Subject: [PATCH] btrfs-progs: qgroup: allow passing options to qgroup remove
Date:   Sun,  2 Feb 2020 15:45:42 +0100
Message-Id: <20200202144542.98625-1-bevan@bi-co.net>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

According to the documentation, btrfs qgroup remove takes the same
options as qgroup assign, i.e., --rescan and --no-rescan. However,
currently no options are accepted. Activate option handling also for
qgroup remove, so that automatic rescan can be disabled by the user.

Signed-off-by: Michael Lass <bevan@bi-co.net>
---
 cmds/qgroup.c | 55 +++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 6bfb4949..fef3374d 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -45,34 +45,30 @@ static int _cmd_qgroup_assign(const struct cmd_struct *cmd, int assign,
 	struct btrfs_ioctl_qgroup_assign_args args;
 	DIR *dirstream = NULL;
 
-	if (assign) {
-		optind = 0;
-		while (1) {
-			enum { GETOPT_VAL_RESCAN = 256, GETOPT_VAL_NO_RESCAN };
-			static const struct option long_options[] = {
-				{ "rescan", no_argument, NULL,
-					GETOPT_VAL_RESCAN },
-				{ "no-rescan", no_argument, NULL,
-					GETOPT_VAL_NO_RESCAN },
-				{ NULL, 0, NULL, 0 }
-			};
-			int c = getopt_long(argc, argv, "", long_options, NULL);
-
-			if (c < 0)
-				break;
-			switch (c) {
-			case GETOPT_VAL_RESCAN:
-				rescan = true;
-				break;
-			case GETOPT_VAL_NO_RESCAN:
-				rescan = false;
-				break;
-			default:
-				usage_unknown_option(cmd, argv);
-			}
+	optind = 0;
+	while (1) {
+		enum { GETOPT_VAL_RESCAN = 256, GETOPT_VAL_NO_RESCAN };
+		static const struct option long_options[] = {
+			{ "rescan", no_argument, NULL,
+				GETOPT_VAL_RESCAN },
+			{ "no-rescan", no_argument, NULL,
+				GETOPT_VAL_NO_RESCAN },
+			{ NULL, 0, NULL, 0 }
+		};
+		int c = getopt_long(argc, argv, "", long_options, NULL);
+
+		if (c < 0)
+			break;
+		switch (c) {
+		case GETOPT_VAL_RESCAN:
+			rescan = true;
+			break;
+		case GETOPT_VAL_NO_RESCAN:
+			rescan = false;
+			break;
+		default:
+			usage_unknown_option(cmd, argv);
 		}
-	} else {
-		clean_args_no_options(cmd, argc, argv);
 	}
 
 	if (check_argc_exact(argc - optind, 3))
@@ -180,8 +176,11 @@ static int cmd_qgroup_assign(const struct cmd_struct *cmd,
 static DEFINE_SIMPLE_COMMAND(qgroup_assign, "assign");
 
 static const char * const cmd_qgroup_remove_usage[] = {
-	"btrfs qgroup remove <src> <dst> <path>",
+	"btrfs qgroup remove [options] <src> <dst> <path>",
 	"Remove a child qgroup SRC from DST.",
+	"",
+	"--rescan       schedule qutoa rescan if needed",
+	"--no-rescan    don't schedule quota rescan",
 	NULL
 };
 
-- 
2.25.0

