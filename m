Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC0ACED915
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfKDGex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41952 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfKDGew (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YZOi003925
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=HVN7Ghbw1bYCzRqjiMfCU6wRN5bhRVK0yMOh1Bx5kP4=;
 b=dPpnxwlufW5WwFGihMhdWc/qDia73ybsucAWoD66gkQSrfyLx4+DP6qnbA/KVYbIRHqW
 ilXrcwXI+tRUHyBjK9/EKj15prdGB5fksfXF82t50y5sWmpH33mULcBUUH595IQBE3L8
 cBl3MELaJ5aFNpwbxMz5kk5AsbFf/O6IMPtR8InAjSZ1flGs7SB+cxyT2VVXrT/+IV2a
 MzUMoLiBhnYKtCBM1t6Akzj0MzbJMKejssMuz38XTudnCztwJ0vZudrVybyQo+lAnEdG
 Ip8SCZjAmMAq5yY9cGDCvr9ITOIT1dsCRADTo9VwnHn9Knr0te4WLPHut+8BAwwArKk6 jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2w117tn796-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46Yjqd066397
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w1k8u69hu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:46 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XXUe000405
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:33 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 04/18] btrfs-progs: add global verbose and quiet options and helper functions
Date:   Mon,  4 Nov 2019 14:33:02 +0800
Message-Id: <1572849196-21775-5-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add btrfs(8) global --verbose and --quiet command options to show
verbose or no output from the sub-commands.
By introducing global a %bconf::verbose memeber to transpire the same
down to the sub-command.
Further the added helper function pr_verbose() helps to logs the verbose
messages, based on the state of the %bconf::verbose. And further HELPINFO_
defines are provides for the usage.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1.1: Fix typo in HELPINFO_INSERT_QUIET
      Drop stale #include <stdbool.h> we don't need it because
      %bconf.verbose is now declared as int.

 btrfs.c           | 20 ++++++++++++++++++--
 common/help.h     | 11 +++++++++++
 common/messages.c | 17 +++++++++++++++++
 common/messages.h |  3 +++
 common/utils.c    |  1 +
 common/utils.h    |  3 +++
 6 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/btrfs.c b/btrfs.c
index 6c8aabe24dc8..a97bc1858390 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -27,7 +27,7 @@
 #include "common/box.h"
 
 static const char * const btrfs_cmd_group_usage[] = {
-	"btrfs [--help] [--version] [--format <format>] <group> [<group>...] <command> [<args>]",
+	"btrfs [--help] [--version] [--format <format>] [-v|--verbose] [--quiet] <group> [<group>...] <command> [<args>]",
 	NULL
 };
 
@@ -248,6 +248,8 @@ static int handle_global_options(int argc, char **argv)
 		{ "version", no_argument, NULL, OPT_VERSION },
 		{ "format", required_argument, NULL, OPT_FORMAT },
 		{ "full", no_argument, NULL, OPT_FULL },
+		{ "verbose", no_argument, NULL, 'v' },
+		{ "quiet", no_argument, NULL, 'q' },
 		{ NULL, 0, NULL, 0}
 	};
 	int shift;
@@ -259,7 +261,7 @@ static int handle_global_options(int argc, char **argv)
 	while (1) {
 		int c;
 
-		c = getopt_long(argc, argv, "+", long_options, NULL);
+		c = getopt_long(argc, argv, "+vq", long_options, NULL);
 		if (c < 0)
 			break;
 
@@ -270,6 +272,12 @@ static int handle_global_options(int argc, char **argv)
 		case OPT_FORMAT:
 			handle_output_format(optarg);
 			break;
+		case 'v':
+			bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;
+			break;
+		case 'q':
+			bconf.verbose = 0;
+			break;
 		default:
 			fprintf(stderr, "Unknown global option: %s\n",
 					argv[optind - 1]);
@@ -310,6 +318,14 @@ static void handle_special_globals(int shift, int argc, char **argv)
 			cmd_execute(&cmd_struct_version, argc, argv);
 			exit(0);
 		}
+
+	for (i = 0; i < shift; i++)
+		if (strcmp(argv[i], "--verbose") == 0)
+			bconf.verbose < 0 ? bconf.verbose = 1 : bconf.verbose++;
+
+	for (i = 0; i < shift; i++)
+		if (strcmp(argv[i], "--quiet") == 0)
+			bconf.verbose = 0;
 }
 
 static const struct cmd_group btrfs_cmd_group = {
diff --git a/common/help.h b/common/help.h
index 01dfc68a7c8d..2618f31de712 100644
--- a/common/help.h
+++ b/common/help.h
@@ -53,6 +53,17 @@
 	"-t|--tbytes        show sizes in TiB, or TB with --si"
 
 /*
+ * Global verbose option for the sub-commands
+ */
+#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
+	"",									\
+	"Global options:"
+#define HELPINFO_INSERT_VERBOSE							\
+	"-v|--verbose       show verbose output"
+#define HELPINFO_INSERT_QUIET							\
+	"-q|--quiet         run the command quietly"
+
+/*
  * Special marker in the help strings that will preemptively insert the global
  * options and then continue with the following text that possibly follows
  * after the regular options
diff --git a/common/messages.c b/common/messages.c
index 0e5694ecd467..410630ffdd6d 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include "common/messages.h"
+#include "common/utils.h"
 
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_warning(const char *fmt, ...)
@@ -75,3 +76,19 @@ int __btrfs_error_on(int condition, const char *fmt, ...)
 
 	return 1;
 }
+
+__attribute__ ((format (printf, 2, 3)))
+void pr_verbose(int level, const char *fmt, ...)
+{
+	va_list args;
+
+	if (level == 0 || bconf.verbose == 0)
+		return;
+
+	if (level > bconf.verbose)
+		return;
+
+	va_start(args, fmt);
+	vfprintf(stdout, fmt, args);
+	va_end(args);
+}
diff --git a/common/messages.h b/common/messages.h
index 596047948fef..f802a9413265 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -96,3 +96,6 @@ __attribute__ ((format (printf, 2, 3)))
 int __btrfs_error_on(int condition, const char *fmt, ...);
 
 #endif
+
+__attribute__ ((format (printf, 2, 3)))
+void pr_verbose(int level, const char *fmt, ...);
diff --git a/common/utils.c b/common/utils.c
index 2cf15c333f6b..c2c6d0af0efc 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1649,6 +1649,7 @@ u8 rand_u8(void)
 void btrfs_config_init(void)
 {
 	bconf.output_format = CMD_FORMAT_TEXT;
+	bconf.verbose = -1;
 }
 
 /* Returns total size of main memory in bytes, -1UL if error. */
diff --git a/common/utils.h b/common/utils.h
index 0ef1d6e89c2b..8774194f4e9d 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -122,6 +122,9 @@ void print_all_devices(struct list_head *devices);
  */
 struct btrfs_config {
 	unsigned int output_format;
+
+	/* -1:unset 0:quiet >0:verbose */
+	int verbose;
 };
 extern struct btrfs_config bconf;
 
-- 
1.8.3.1

