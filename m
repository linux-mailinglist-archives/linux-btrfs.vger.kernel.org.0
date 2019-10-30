Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9EE9855
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJ3Ilt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60826 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJ3Ils (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cenU054064;
        Wed, 30 Oct 2019 08:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=/tEtnG+NIBcTs35GfqWRlRBwcvtmNeaR1X34tsh75oY=;
 b=J1/QI4wbi6dfhIjWvwEGwd6Q8U+JpWhrDQd+v1CwGfk1w91cMu4GawHazEDPvkUXDkG6
 a/1qxDZppY7cGYWZxAxusUrTIlUUSydNjrqb4AzaqzFXc5Zz7C1KYIRH8P0encwv2Rgv
 xkngc14JCjVmGf37i3oUORKHZkwYuzAqpYORQiDP5ELqbFTfjOzwXV9zmedukqhAKztN
 4Tvs0Pr+Y6VTUfmCcvstsOd6bkTy/zZdsIyZSkCGjFwR6gOplrVSuTLqphY6mIvMmNF1
 KNsOi96xYxv4EGnWhnlHSNONxh7JjcgMttZNBgJB09DxgEqfn4ue46bQL47mn31AUhew /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vxwhfje3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8csEF071085;
        Wed, 30 Oct 2019 08:41:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vxwj8uub6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:46 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8fkQg018712;
        Wed, 30 Oct 2019 08:41:46 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:45 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 11/18] btrfs-progs: rescue chunk-recover: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:15 +0800
Message-Id: <20191030084122.29745-12-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs rescue chunk-recover
sub-command.

For example: Both global and local verbose options are now supported.
 btrfs -v|--verbose rescue chunk-recover
 btrfs rescue chunk-recover -v

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/rescue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index e8eab6808bc3..649f612aa051 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -40,6 +40,8 @@ static const char * const cmd_rescue_chunk_recover_usage[] = {
 	"-y	Assume an answer of `yes' to all questions",
 	"-v	Verbose mode",
 	"-h	Help",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -49,7 +51,10 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 	int ret = 0;
 	char *file;
 	int yes = 0;
-	int verbose = 0;
+
+	/* If verbose is unset, set it to 0 */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
 
 	optind = 0;
 	while (1) {
@@ -61,7 +66,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 			yes = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -83,7 +88,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	ret = btrfs_recover_chunk_tree(file, verbose, yes);
+	ret = btrfs_recover_chunk_tree(file, bconf.verbose, yes);
 	if (!ret) {
 		fprintf(stdout, "Chunk tree recovered successfully\n");
 	} else if (ret > 0) {
-- 
2.23.0

