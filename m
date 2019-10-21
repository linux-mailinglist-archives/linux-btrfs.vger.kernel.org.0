Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FACBDE8E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfJUKBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56130 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJUKBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xH3Z004698
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=BA47W8UkSL0FQOb1RFbKH7NZw4VsbpXTRvfuybeD188=;
 b=Nm4GX2tW4qFkbwKJmuwyjj+If9DXG7HEurI0LlKwwbiWY62EWnJCxg9Gc6obm2F3wZ49
 0lzdvv6Oh78/EWAAqUcpunC+z4jZ+li7N1WhFxA8ULt2qf9wW4Slu1yzpP5BkLMPXqfK
 QT3dssHzERaj27j/v45ryYQGWEvSMpAGxZYp2Rvu7mh4mwyxJ6N0i5Qa6pD3gD1WxgEE
 qtqQ/8wmyTQpa47mlyEBnJBMP9Aw5C6DbUtWbuBJ3zM2JbdHq4PFz81Lzu+RwWho6Gh6
 U95fwxGgR9RuqBFr9fzyai22JvVO39vK7z13Wf0LBjTMo7Eflsol5+kXPTo3jk/aJvCy zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qedx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wBDK055711
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vrcmmqfme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1ea1023900
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:41 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:40 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 05/14] btrfs-progs: migrate balance status to global verbose
Date:   Mon, 21 Oct 2019 18:01:13 +0800
Message-Id: <1571652082-25982-6-git-send-email-anand.jain@oracle.com>
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

Make sure top level verbose option can enable the blalance status
subcommand's verbose option.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 7e84efd6a80d..d4916c5fb34e 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -822,7 +822,7 @@ static const char * const cmd_balance_status_usage[] = {
 	"btrfs balance status [-v] <path>",
 	"Show status of running or paused balance",
 	"",
-	"-v     be verbose",
+	HELPINFO_INSERT_VERBOSE_SHORT,
 	NULL
 };
 
@@ -839,7 +839,6 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	const char *path;
 	DIR *dirstream = NULL;
 	int fd;
-	int verbose = 0;
 	int ret;
 
 	optind = 0;
@@ -856,7 +855,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 
 		switch (opt) {
 		case 'v':
-			verbose = 1;
+			global_verbose = true;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -902,7 +901,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	       (unsigned long long)args.stat.considered,
 	       100 * (1 - (float)args.stat.completed/args.stat.expected));
 
-	if (verbose)
+	if (global_verbose)
 		dump_ioctl_balance_args(&args);
 
 	ret = 1;
-- 
1.8.3.1

