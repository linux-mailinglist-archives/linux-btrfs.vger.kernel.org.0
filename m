Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DA1F6C42
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFKQg6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 12:36:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35380 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKQg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 12:36:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGWMhQ067382;
        Thu, 11 Jun 2020 16:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=GK+Hw8zzfVjEc9KvJTv/staKn6hXxfU5jIuGqOmB5UQ=;
 b=sBPawlbDMnafYAoZ39NiRf+B/wu5qLyctxv6v5EDS6mcJxISVahYicBc3ho6/It7Tjmn
 F26Hi8L6sf3SyIFciv2h+1yfcme6q6R3k1YZvbcVkByxYrJ//aR08rvgYBAcQSIxuEGR
 apiWTt+OG0e1YjwLefne/pZbMXUhz71t1ovooex4IFi6c9B8ISHaBYXBpQxtmwcW0qvn
 hIfDzExTc4QSwQfdzvDSAJ1O5jNtsqiencOwjAIyznRAg5NaAKQplkEu9sut6EccYUqF
 NIzrYufp1R2sdM4t9PELwUeyO+1PAzQJiaCj7hgmEJo4BMIBFum2eGfJCAfnt1OD1AKP Rw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jrgx99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 16:36:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGWYZR024035;
        Thu, 11 Jun 2020 16:36:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31gmwvp6n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 16:36:53 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BGaq5L008303;
        Thu, 11 Jun 2020 16:36:52 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 09:36:46 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 02/16] btrfs-progs: add global verbose and quiet options and helper functions
Date:   Fri, 12 Jun 2020 00:36:19 +0800
Message-Id: <20200611163619.35721-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110130
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
v3:
  Add define MUST_LOG
  Add comment about the argument %level in the function pr_verbose()
v2:
  Add missing -q along with --quiet.
  Create and use bconf_be_verbose() and bconf_be_quiet().
  Change help wordings for verbose and quiet.
  Define and use BTRFS_BCONF_UNSET and BTRFS_BCONF_QUIET.
  Use HELPINFO_INSERT_GLOBALS.

 btrfs.c           | 20 ++++++++++++++++++--
 common/help.h     |  5 +++++
 common/messages.c | 30 ++++++++++++++++++++++++++++++
 common/messages.h |  4 ++++
 common/utils.c    | 14 ++++++++++++++
 common/utils.h    | 11 +++++++++++
 6 files changed, 82 insertions(+), 2 deletions(-)

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
index 0e5694ecd467..43ababe77519 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include "common/messages.h"
+#include "common/utils.h"
 
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_warning(const char *fmt, ...)
@@ -75,3 +76,32 @@ int __btrfs_error_on(int condition, const char *fmt, ...)
 
 	return 1;
 }
+
+/*
+ * Print verbose helper function
+ * level: Minimum verbose level at which the message has to be printed.
+ *
+ * Values for argument level:
+ * MUST_LOG - Will log the message unless a quiet option is set.
+ *            Used where messages have to be printed for backward compatibility.
+ * > 0        Prints the message at the corresponding level.
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
index 596047948fef..288b32a77c10 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -96,3 +96,7 @@ __attribute__ ((format (printf, 2, 3)))
 int __btrfs_error_on(int condition, const char *fmt, ...);
 
 #endif
+
+#define	MUST_LOG	-1
+__attribute__ ((format (printf, 2, 3)))
+void pr_verbose(int level, const char *fmt, ...);
diff --git a/common/utils.c b/common/utils.c
index ebc50de2c143..0301efb0a348 100644
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
index 1172618b8bb1..c650819644e5 100644
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
2.25.1

