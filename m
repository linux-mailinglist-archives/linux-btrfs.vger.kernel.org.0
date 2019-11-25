Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCFE108BD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKYKjg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfKYKjf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY7fg021484
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Dm1+i1mfY42kNjKbXmhcDhOD/lhZyyWyNsAGlMRVVs4=;
 b=Mowx2ftkueOt2gZ7z6sUQepbCqHbSR+ijS/8mDUdszJQ3jt64CLKu8h7+TFD/pJzSX01
 EYn94K6TWwRPT1cdZ+v04x+F6hShu/IljtPXSSBNcjmMgvdne+astqpOAfpFa0w99vQz
 9iBvXGHG7bH6BxWhAfn7t6V8si3APjQ7bqxCPC7ebzznbxKQM1kBiyGBgjhfgErgHt87
 x3ed+CHSQ+ZLzmO9mVwjr0POXg+BqRdMLE4zBjEOiIgh3DJP0Zg+LYwJoAsIEI2AiRgU
 I7jLc4O/G9bmr5hFd9149TryLg/MOn463t0Fr4Mg9N1WRPcKFho47anoZwU1SAgHA9wv QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wevqpxrwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY4oJ090833
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wfe7yr5x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:33 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdWMh017333
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:32 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:32 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/16] btrfs-progs: add global verbose and quiet options and helper functions
Date:   Mon, 25 Nov 2019 18:39:03 +0800
Message-Id: <1574678357-22222-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
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
v2:
  Add missing -q along with --quiet.
  Create and use bconf_be_verbose() and bconf_be_quiet().
  Change help wordings for verbose and quiet.
  Define and use BTRFS_BCONF_UNSET and BTRFS_BCONF_QUIET.
  Use HELPINFO_INSERT_GLOBALS.

 btrfs.c           | 20 ++++++++++++++++++--
 common/help.h     |  5 +++++
 common/messages.c | 25 +++++++++++++++++++++++++
 common/messages.h |  3 +++
 common/utils.c    | 14 ++++++++++++++
 common/utils.h    | 11 +++++++++++
 6 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/btrfs.c b/btrfs.c
index 72dad6fb3983..eb3b6183eb21 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -27,7 +27,7 @@
 #include "common/box.h"
 
 static const char * const btrfs_cmd_group_usage[] = {
-	"btrfs [--help] [--version] [--format <format>] <group> [<group>...] <command> [<args>]",
+	"btrfs [--help] [--version] [--format <format>] [-v|--verbose] [-q|--quiet] <group> [<group>...] <command> [<args>]",
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
+			bconf_be_verbose();
+			break;
+		case 'q':
+			bconf_be_quiet();
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
+			bconf_be_verbose();
+
+	for (i = 0; i < shift; i++)
+		if (strcmp(argv[i], "--quiet") == 0)
+			bconf_be_quiet();
 }
 
 static const struct cmd_group btrfs_cmd_group = {
diff --git a/common/help.h b/common/help.h
index 91874abfe207..dbc5259d2277 100644
--- a/common/help.h
+++ b/common/help.h
@@ -60,6 +60,11 @@
 #define HELPINFO_INSERT_GLOBALS		"",					\
 					"Global options:"
 #define HELPINFO_INSERT_FORMAT		"--foramt TYPE"
+/*
+ * Global verbose option for the sub-commands
+ */
+#define HELPINFO_INSERT_VERBOSE	"-v|--verbose       increase output verbosity"
+#define HELPINFO_INSERT_QUIET	"-q|--quiet         print only errors"
 
 struct cmd_struct;
 struct cmd_group;
diff --git a/common/messages.c b/common/messages.c
index 0e5694ecd467..95e705dbe754 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include "common/messages.h"
+#include "common/utils.h"
 
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_warning(const char *fmt, ...)
@@ -75,3 +76,27 @@ int __btrfs_error_on(int condition, const char *fmt, ...)
 
 	return 1;
 }
+
+/*
+ * Print verbose helper function
+ * level: Minimum verbose level at which the message has to be printed.
+ */
+__attribute__ ((format (printf, 2, 3)))
+void pr_verbose(int level, const char *fmt, ...)
+{
+	va_list args;
+
+	if (bconf.verbose == BTRFS_BCONF_QUIET || level == BTRFS_BCONF_QUIET)
+		return;
+
+	/*
+	 * level is set by the threads requesting to print only if the command
+	 * verbose option is higher than the level.
+	 */
+	if (bconf.verbose < level)
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
index 4ce3683640d2..4b5d40b2bc56 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1679,6 +1679,20 @@ u8 rand_u8(void)
 void btrfs_config_init(void)
 {
 	bconf.output_format = CMD_FORMAT_TEXT;
+	bconf.verbose = BTRFS_BCONF_UNSET;
+}
+
+void bconf_be_verbose(void)
+{
+	if (bconf.verbose == BTRFS_BCONF_UNSET)
+		bconf.verbose = 1;
+	else
+		bconf.verbose++;
+}
+
+void bconf_be_quiet(void)
+{
+	bconf.verbose = BTRFS_BCONF_QUIET;
 }
 
 /* Returns total size of main memory in bytes, -1UL if error. */
diff --git a/common/utils.h b/common/utils.h
index c31da330efa7..cecad6cfc7f9 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -117,16 +117,27 @@ unsigned long total_memory(void);
 void print_device_info(struct btrfs_device *device, char *prefix);
 void print_all_devices(struct list_head *devices);
 
+#define BTRFS_BCONF_UNSET	-1
+#define BTRFS_BCONF_QUIET	 0
 /*
  * Global program state, configurable by command line and available to
  * functions without extra context passing.
  */
 struct btrfs_config {
 	unsigned int output_format;
+
+	/* values
+	 *   BTRFS_BCONF_QUIET
+	 *   BTRFS_BCONF_UNSET
+	 *   > 0: Verbose level
+	 */
+	int verbose;
 };
 extern struct btrfs_config bconf;
 
 void btrfs_config_init(void);
+void bconf_be_verbose(void);
+void bconf_be_quiet(void);
 
 /* Pseudo random number generator wrappers */
 int rand_int(void);
-- 
1.8.3.1

