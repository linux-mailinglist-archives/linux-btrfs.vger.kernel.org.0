Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F68ED906
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfKDGeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbfKDGeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YZpd187201
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=FtMz34karvNO8I9sxnHO/zTRBl1PMTGOHVDsUM9gj4E=;
 b=WTCVzJT39GXZZEkJigWZN3/ktVefRP2UA4+5SQ+nCpGbeWhjkzNzvRrN89bUQk0uNI5R
 oh3GGpFw+isbP3qPLlQPHFg5j/hNMp9SbW0RBwcwFmpwcM2H5Fn/AzT5fir9iC/5HczL
 FDWI2cYcuF7rr4BjICC10AcA4wKwXcK5CjpPDqzAW1U4p1MbQ4tQEE21xqI+Y/sJMjsE
 XFNRjwR+ZGKxmrxVFFOp6j+i1fGDgSiJBQM0z9AVIT4L31dEcFt2qvN/nY8Tz/7sEG0a
 w1bnz6dDTIGIU6LpZpDj19lj++aTZcymnLP1UqH3muLCdTGuAbwKZT9r0yf9s6byzysg 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5p7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YXpQ046684
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w1ka9qsjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XhtA000458
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:43 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 11/18] btrfs-progs: rescue chunk-recover: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:09 +0800
Message-Id: <1572849196-21775-12-git-send-email-anand.jain@oracle.com>
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
1.8.3.1

