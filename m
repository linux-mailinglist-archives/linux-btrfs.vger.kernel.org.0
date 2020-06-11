Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721B01F6CF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgFKRmW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFKRmV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHbP9E165235
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5QVj2P7GjaXeyonLu3Aa8JbGcABLql0ZWUqKLfbUqlo=;
 b=kMdJCFQP9bMvR9UaMKog7OC/XNd796WgK0I9OxcRPOOpx7cwJOyghgaYJyh0xeIMq0Ar
 zj2PAgAJINpaexdeqtIOylwHsBS4MFRrHu2sYAuGbmylND4ReVidxe4zMzlh6vAnA/wp
 jwYHcr7F5tHqRf4Gj0K3Ajk6k/nZADEMUIccU46uNk+BZxVfvIZzA05bGfbum7Wl+hKL
 IB4ryotivcr7YDW1HaGtpwKmkQd6QMvXviPdykWKU8+ANF3Agqsob/F2pVbr3xVkpCAh
 9dqeQ1Dh6MMa+JBNlfGH8vVf39zdaBLE2NcGwxj3kfQj1K2zSt6HsP0fzHPOUx5hyQTY UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31jepp32gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHcV3c067656
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 31gn2d1m1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BHgJoK023812
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:19 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:42:19 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/8] btrfs-progs: scrub start|resume: use global quiet option
Date:   Fri, 12 Jun 2020 01:41:22 +0800
Message-Id: <20200611174123.38382-8-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=1 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110139
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
v2: Use MUST_LOG

 cmds/scrub.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/cmds/scrub.c b/cmds/scrub.c
index 9fe598222f0f..809790266011 100644
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
@@ -1330,9 +1331,9 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 	}
 
 	if (!n_start && !n_resume) {
-		if (!do_quiet)
-			printf("scrub: nothing to resume for %s, fsid %s\n",
-			       path, fsid);
+		pr_verbose(MUST_LOG,
+			   "scrub: nothing to resume for %s, fsid %s\n",
+			   path, fsid);
 		nothing_to_resume = 1;
 		goto out;
 	}
@@ -1403,10 +1404,10 @@ static int scrub_start(const struct cmd_struct *cmd, int argc, char **argv,
 		if (pid) {
 			int stat;
 			scrub_handle_sigint_parent();
-			if (!do_quiet)
-				printf("scrub %s on %s, fsid %s (pid=%d)\n",
-				       n_start ? "started" : "resumed",
-				       path, fsid, pid);
+			pr_verbose(MUST_LOG,
+				   "scrub %s on %s, fsid %s (pid=%d)\n",
+				   n_start ? "started" : "resumed",
+				   path, fsid, pid);
 			if (!do_wait) {
 				err = 0;
 				goto out;
@@ -1611,6 +1612,8 @@ static const char * const cmd_scrub_start_usage[] = {
 	"-n     set ioprio classdata (see ionice(1) manpage)",
 	"-f     force starting new scrub even if a scrub is already running",
 	"       this is useful when scrub stats record file is damaged",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -1678,6 +1681,8 @@ static const char * const cmd_scrub_resume_usage[] = {
 	"-R     raw print mode, print full data instead of summary",
 	"-c     set ioprio class (see ionice(1) manpage)",
 	"-n     set ioprio classdata (see ionice(1) manpage)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
-- 
2.25.1

