Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FFC1F12F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgFHGjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56322 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586asL4034803;
        Mon, 8 Jun 2020 06:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cpybnt1w5HtrgDdaVFph3LQY7I7tWfx0C8r74lbgIFw=;
 b=tJ3YmfXYoiHU+5fFw+/zrgksDCrvK6ydiLGtGLNRz+um4n9goPJo0t/eqjlCZH4IpFWl
 TkBT+Hck8t8RUtlNDeXpn+qeljWPL4pd5SlkLkP5f4aFJT8amjo5MI+su+k4A56IFIYE
 Bzgp89NCFbqQNbWUkSqimAVH3QH7Iytviy6QbQgOlDnLIt+Yaps2mDqgYI7sJHC20WPN
 jgBHpIlnYCnIodJiCDXA2cOfBWiwGR8v3ojmbhDwgZlAzYN5MeVsib6VbQvKwTSwli8Q
 CEIExjEDM3n2+x0wKAGR+hhOx+gMA2kWXrC8V6Kup5zW23MUfFTDrw+4RCP3IFDAsT6k /g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31g33kw3xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586YGhl059295;
        Mon, 8 Jun 2020 06:39:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31gn21qprh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:16 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586dFmi030424;
        Mon, 8 Jun 2020 06:39:15 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:15 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 7/8] btrfs-progs: scrub start|resume: use global quiet option
Date:   Mon,  8 Jun 2020 14:38:50 +0800
Message-Id: <20200608063851.8874-8-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608063851.8874-1-anand.jain@oracle.com>
References: <20200608063851.8874-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --quiet option down to the btrfs scrub start|resume
sub-command.

Now either/both of the following quiet options work.
	btrfs -q scrub start <path>
and
	btrfs scrub start -q <path>

	btrfs -q scrub resume <path>
and
	btrfs scrub resume -q <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/scrub.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 9fe598222f0f..e3b6427b47ae 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -1141,7 +1141,7 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	int do_background = 1;
 	int do_wait = 0;
 	int do_print = 0;
-	int do_quiet = 0;
+	int do_quiet = !bconf.verbose; /*Read the global quiet option if set*/
 	int do_record = 1;
 	int readonly = 0;
 	int do_stats_per_dev = 0;
@@ -1184,7 +1184,8 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 			do_stats_per_dev = 1;
 			break;
 		case 'q':
-			do_quiet = 1;
+			bconf_be_quiet();
+			do_quiet = !bconf.verbose;
 			break;
 		case 'r':
 			readonly = 1;
@@ -1330,9 +1331,8 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	}
 
 	if (!n_start && !n_resume) {
-		if (!do_quiet)
-			printf("scrub: nothing to resume for %s, fsid %s\n",
-			       path, fsid);
+		pr_verbose(-1, "scrub: nothing to resume for %s, fsid %s\n",
+			   path, fsid);
 		nothing_to_resume = 1;
 		goto out;
 	}
@@ -1403,10 +1403,9 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		if (pid) {
 			int stat;
 			scrub_handle_sigint_parent();
-			if (!do_quiet)
-				printf("scrub %s on %s, fsid %s (pid=%d)\n",
-				       n_start ? "started" : "resumed",
-				       path, fsid, pid);
+			pr_verbose(-1, "scrub %s on %s, fsid %s (pid=%d)\n",
+				   n_start ? "started" : "resumed",
+				   path, fsid, pid);
 			if (!do_wait) {
 				err = 0;
 				goto out;
@@ -1611,6 +1610,8 @@ static const char * const cmd_scrub_start_usage[] = {
 	"-n     set ioprio classdata (see ionice(1) manpage)",
 	"-f     force starting new scrub even if a scrub is already running",
 	"       this is useful when scrub stats record file is damaged",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -1678,6 +1679,8 @@ static const char * const cmd_scrub_resume_usage[] = {
 	"-R     raw print mode, print full data instead of summary",
 	"-c     set ioprio class (see ionice(1) manpage)",
 	"-n     set ioprio classdata (see ionice(1) manpage)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
-- 
2.25.1

