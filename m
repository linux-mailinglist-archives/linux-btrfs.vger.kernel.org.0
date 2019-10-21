Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62394DE8E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfJUKBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56038 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJUKBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xH3Y004698
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=gVpT2JgIyPE42ar4/HyfMEPSrrddLUzjqjrCRDpdLw0=;
 b=D7Y3cudqiSStY1am+Aho73cHZg9eBzgVuWkkZkspNJYYEWcq+bg1i2ROpniwxiNbVgIg
 2Pjl3NHfTHZoZMfrxMQlrzfpG7Joxes6r8eEhyYpVND0QwOfkGvsg+NZGf2mldoFKYlF
 nn8yoCvMkaEF76JN/0Hl1UOmTmg+AWKVNAPKU2+5dNzCBTz6ECfiBtS0poeScGP7B7+X
 IwQ9A4XGxGUkDCYHsekYu9uta7yJEb+RtA3ySJt5gpIur4JSzHkm8trOEuz3VCaW1us8
 WLRjPHWgE0Mzme8llzHqcvGkiBMOTi32Bg9okUEY3VMQHvEjeGsFSVH8kw4X0pfGEQaP DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qedwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9w7Yf081526
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vrcn9wbyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:34 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1XUw023722
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:33 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:33 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 01/14] btrfs-progs: add global verbose helper functions
Date:   Mon, 21 Oct 2019 18:01:09 +0800
Message-Id: <1571652082-25982-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The idea is to use the global --verbose command option to show
verbose output from the sub-commands. This patch adds a global
bool variable, %global_verbose, to transpire the verbose requisites
to the sub-command level. And provides pr_verbose() helper
function to log the verbose messages.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 btrfs.c           | 12 ++++++++++--
 common/help.h     |  8 ++++++++
 common/messages.c | 19 +++++++++++++++++++
 common/messages.h |  5 +++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/btrfs.c b/btrfs.c
index 72dad6fb3983..ac10d8110495 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -26,8 +26,10 @@
 #include "common/help.h"
 #include "common/box.h"
 
+extern bool global_verbose;
+
 static const char * const btrfs_cmd_group_usage[] = {
-	"btrfs [--help] [--version] [--format <format>] <group> [<group>...] <command> [<args>]",
+	"btrfs [--help] [--version] [--format <format>] [--verbose] <group> [<group>...] <command> [<args>]",
 	NULL
 };
 
@@ -242,12 +244,13 @@ static void handle_output_format(const char *format)
  */
 static int handle_global_options(int argc, char **argv)
 {
-	enum { OPT_HELP = 256, OPT_VERSION, OPT_FULL, OPT_FORMAT };
+	enum { OPT_HELP = 256, OPT_VERSION, OPT_FULL, OPT_FORMAT, OPT_VERBOSE };
 	static const struct option long_options[] = {
 		{ "help", no_argument, NULL, OPT_HELP },
 		{ "version", no_argument, NULL, OPT_VERSION },
 		{ "format", required_argument, NULL, OPT_FORMAT },
 		{ "full", no_argument, NULL, OPT_FULL },
+		{ "verbose", no_argument, NULL, OPT_VERBOSE },
 		{ NULL, 0, NULL, 0}
 	};
 	int shift;
@@ -270,6 +273,7 @@ static int handle_global_options(int argc, char **argv)
 		case OPT_FORMAT:
 			handle_output_format(optarg);
 			break;
+		case OPT_VERBOSE: break;
 		default:
 			fprintf(stderr, "Unknown global option: %s\n",
 					argv[optind - 1]);
@@ -310,6 +314,10 @@ static void handle_special_globals(int shift, int argc, char **argv)
 			cmd_execute(&cmd_struct_version, argc, argv);
 			exit(0);
 		}
+
+	for (i = 0; i < shift; i++)
+		if (strcmp(argv[i], "--verbose") == 0)
+			global_verbose = true;
 }
 
 static const struct cmd_group btrfs_cmd_group = {
diff --git a/common/help.h b/common/help.h
index 01dfc68a7c8d..7bb3074b0be6 100644
--- a/common/help.h
+++ b/common/help.h
@@ -53,6 +53,14 @@
 	"-t|--tbytes        show sizes in TiB, or TB with --si"
 
 /*
+ * Global verbose option for the sub-commands
+ */
+#define HELPINFO_INSERT_VERBOSE							\
+	"-v|--verbose       show verbose output"
+#define HELPINFO_INSERT_VERBOSE_SHORT						\
+	"-v                 show verbose output"
+
+/*
  * Special marker in the help strings that will preemptively insert the global
  * options and then continue with the following text that possibly follows
  * after the regular options
diff --git a/common/messages.c b/common/messages.c
index 0e5694ecd467..e14c112ebbbf 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -16,6 +16,7 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include "common/messages.h"
 
 __attribute__ ((format (printf, 1, 2)))
@@ -75,3 +76,21 @@ int __btrfs_error_on(int condition, const char *fmt, ...)
 
 	return 1;
 }
+
+bool global_verbose = false;
+
+__attribute__ ((format (printf, 2, 3)))
+void pr_verbose(bool condition, const char *fmt, ...)
+{
+	va_list args;
+
+	if (condition == false)
+		return;
+
+	if (global_verbose == false)
+		return;
+
+	va_start(args, fmt);
+	vfprintf(stdout, fmt, args);
+	va_end(args);
+}
diff --git a/common/messages.h b/common/messages.h
index 596047948fef..a14e2d62f3a0 100644
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
+void pr_verbose(bool condition, const char *fmt, ...);
-- 
1.8.3.1

