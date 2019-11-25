Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67907108BD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfKYKjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37516 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfKYKje (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6lJ021400
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=KfEJa1XhEvAQD7TxvhbAosbIgAExiOimLGz2+BILXos=;
 b=sC1BLllZfIaCMXWJs3yMxNcwQdwQkbieJPCiYjIhhGIZ6dM104TiUjZfOokjMrzuteGw
 7XI6h857lDo3ROXviHfY9X6GlnHq/7PAm/oE7y/HjsU94oV5UaGhy2WwoJ99IODCApev
 asoz9/+gLAgh0mHQZNgYWB9VLyOEfmak1mj1onrxwlcLnOfDgJUP8Ghl4p6TZ9O4InAd
 QY689JpGYJXvqArVyU6zwC2BMYyZAfcOWUjhu3uRpIj3w4tOimARrjegqZS6mhG+42qH
 xK832eFtUp0ylPF0KRT1Fju7YWX34c4RQ+yaOOtEdAgkPcsMo+YuY+KwDYf7BwPF9W00 EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2wevqpxrwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY4Pt090839
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2wfe7yr5wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:31 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdV2P016854
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:31 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:30 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs-progs: split global help HELPINFO_INSERT_GLOBALS
Date:   Mon, 25 Nov 2019 18:39:02 +0800
Message-Id: <1574678357-22222-2-git-send-email-anand.jain@oracle.com>
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

As of now the define HELPINFO_INSERT_GLOBALS if used as in the example
as below (as of now its not been used anywhere) will print the help
texts as shown below

#diff --git a/cmds/filesystem.c b/cmds/filesystem.c
#index 4f22089abeaa..564dc40cc99a 100644
#--- a/cmds/filesystem.c
#+++ b/cmds/filesystem.c
#@@ -631,6 +631,7 @@ static const char * const
#cmd_filesystem_show_usage[] = {
#        "-m|--mounted       show only mounted btrfs",
#        HELPINFO_UNITS_LONG,
#        "If no argument is given, structure of all present filesystems
#is shown.",
#+       HELPINFO_INSERT_GLOBALS,
#        NULL
# };
#
$ ./btrfs fi show --help

 <snip>

    Global options:
    --format TYPE      where TYPE is: text

$

So in preparation to add --verbose and --quiet global options, and
apparently --format is not being used yet, this patch splits the global
options into two defines.

                                       "Global options:"

So that the currently added global options --verbose and --quiet can use
the define HELPINFO_INSERT_GLOBALS header as shown below.

(For example:)
$ ./btrfs fi show --help
<snip>

    Global options:

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/help.c | 4 +---
 common/help.h | 4 +++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/help.c b/common/help.c
index 189a1d3545c2..78f6ee99597c 100644
--- a/common/help.c
+++ b/common/help.c
@@ -209,15 +209,13 @@ static int do_usage_one_command(const char * const *usagestr,
 	fputc('\n', outf);
 
 	while (*usagestr) {
-		if (strcmp(*usagestr, HELPINFO_INSERT_GLOBALS) == 0) {
+		if (strcmp(*usagestr, HELPINFO_INSERT_FORMAT) == 0) {
 			int i;
 
-			fputc('\n', outf);
 			/*
 			 * We always support text, that's on by default for all
 			 * commands
 			 */
-			fprintf(outf, "%*sGlobal options:\n", pad, "");
 			fprintf(outf, "%*s--format TYPE      where TYPE is: %s",
 					pad, "", output_formats[0].name);
 			for (i = 1; i < ARRAY_SIZE(output_formats); i++) {
diff --git a/common/help.h b/common/help.h
index 01dfc68a7c8d..91874abfe207 100644
--- a/common/help.h
+++ b/common/help.h
@@ -57,7 +57,9 @@
  * options and then continue with the following text that possibly follows
  * after the regular options
  */
-#define HELPINFO_INSERT_GLOBALS		"INSERT_GLOBALS"
+#define HELPINFO_INSERT_GLOBALS		"",					\
+					"Global options:"
+#define HELPINFO_INSERT_FORMAT		"--foramt TYPE"
 
 struct cmd_struct;
 struct cmd_group;
-- 
1.8.3.1

