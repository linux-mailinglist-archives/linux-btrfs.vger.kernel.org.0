Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD3E984F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfJ3Ilg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfJ3Ilg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cc6M036433;
        Wed, 30 Oct 2019 08:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=q9zJLQ/0OkxTOMvOBjv/tPOE/ipYtsGRv1XTI13kUFw=;
 b=Xqb6oqF5lIPdZPXR8103mNkIxgyaLEKteChAipdomKWaGGG9nhuOIOypL9piyRivN7jv
 kgo4cm2WzzXqjnJRdFJzSe7kvVgxflCkrADgwpNzJGOQQQZ8z3h8KZ6QtZ8z8okTzBgn
 enTNFX7YLYb4DLe8FGQ40TUhWaaiEzWJaRJr4Ee9Rb6E99Nc4+7Y97bmk/tFeVZnAUuC
 SzcfN4+bpjvEWOsT4r/VKLk0e1JDb57rZ9wbdR6vVJy89TNc0waILBDUJIZVMl41eP0Y
 pa2DyrJWOpm3zKnLcTg8ucxnWk9XmWzrItaclvAKdCaxVTFCDHfHnWOU7ev3jo4hn6IG ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vxwhfafe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8bvwk113575;
        Wed, 30 Oct 2019 08:41:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vxwj9ja66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:34 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fXX4008020;
        Wed, 30 Oct 2019 08:41:33 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:33 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 04/18] btrfs-progs: add global verbose and quiet options and helper functions
Date:   Wed, 30 Oct 2019 16:41:08 +0800
Message-Id: <20191030084122.29745-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
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
 btrfs.c           | 20 ++++++++++++++++++--
 common/help.h     | 11 +++++++++++
 common/messages.c | 18 ++++++++++++++++++
 common/messages.h |  5 +++++
 common/utils.c    |  1 +
 common/utils.h    |  3 +++
 6 files changed, 56 insertions(+), 2 deletions(-)

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
index 01dfc68a7c8d..c983734eff95 100644
--- a/common/help.h
+++ b/common/help.h
@@ -52,6 +52,17 @@
 	"-g|--gbytes        show sizes in GiB, or GB with --si",		\
 	"-t|--tbytes        show sizes in TiB, or TB with --si"
 
+/*
+ * Global verbose option for the sub-commands
+ */
+#define HELPINFO_GLOBAL_OPTIONS_HEADER						\
+	"",									\
+	"Global options:"
+#define HELPINFO_INSERT_VERBOSE							\
+	"-v|--verbose       show verbose output"
+#define HELPINFO_INSERT_QUITE							\
+	"-q|--quiet         run the command quietly"
+
 /*
  * Special marker in the help strings that will preemptively insert the global
  * options and then continue with the following text that possibly follows
diff --git a/common/messages.c b/common/messages.c
index 0e5694ecd467..01ae431406e8 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -16,7 +16,9 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include "common/messages.h"
+#include "common/utils.h"
 
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_warning(const char *fmt, ...)
@@ -75,3 +77,19 @@ int __btrfs_error_on(int condition, const char *fmt, ...)
 
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
index 596047948fef..7724cd97c6cf 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -14,6 +14,8 @@
  * Boston, MA 021110-1307, USA.
  */
 
+#include <stdbool.h>
+
 #ifndef __BTRFS_MESSAGES_H__
 #define __BTRFS_MESSAGES_H__
 
@@ -96,3 +98,6 @@ __attribute__ ((format (printf, 2, 3)))
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
2.23.0

