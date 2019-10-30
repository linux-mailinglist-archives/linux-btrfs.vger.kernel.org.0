Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB0EE9861
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfJ3Inx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:43:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfJ3Inx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:43:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8hVtJ032927;
        Wed, 30 Oct 2019 08:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=kqG3Bb0EjzxFB88FtDecY8B9DE5MyULkiP9fsfk8DWA=;
 b=cyKx91D7rJJrXZ1vU3B8z+kiSDMSE2pPdhybY2vrdbDoNUYMbqhuvbYRsaMX5nYOVlnO
 OEhWtZQCXqCUmOWgKrq23cWaD6nxfWoSonUtlZOovEKMIcVzsmz/d3VnCOi4KqRKbY5I
 0Fm1h8udr9w5N0At/DVzAaDFtENVDDN77+t+c8bqFpaT/Ooq7FesSIIEI15bn9vWMX04
 OgJqspJJFiNnD/EZsfSwNoUoUhA8R9/LgQrHb1+IiLL267Xl8NcjVKkem/ofM3IBPg9C
 X0qLPkL7l1xhw1SnQYdbrK2LYwD5wPtvs55aZcC9BpcItRblONZ0kZjlAYhWQ8NOWrgV yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vxwhfjfbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:43:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ctYX071185;
        Wed, 30 Oct 2019 08:41:48 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vxwj8uuc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:48 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8flV9018721;
        Wed, 30 Oct 2019 08:41:47 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:47 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 12/18] btrfs-progs: rescue super-recover: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:16 +0800
Message-Id: <20191030084122.29745-13-anand.jain@oracle.com>
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
 definitions=main-1910300087
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs rescue super-recover
sub-command.

For example: Both global and local verbose options are now supported.
btrfs -v|--verbose rescue super-recover
btrfs rescue super-recover -v

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/rescue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 649f612aa051..195536457f7b 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -107,6 +107,8 @@ static const char * const cmd_rescue_super_recover_usage[] = {
 	"",
 	"-y	Assume an answer of `yes' to all questions",
 	"-v	Verbose mode",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -122,10 +124,13 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 				    int argc, char **argv)
 {
 	int ret;
-	int verbose = 0;
 	int yes = 0;
 	char *dname;
 
+	/* Init global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int c = getopt(argc, argv, "vy");
@@ -133,7 +138,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 			break;
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		case 'y':
 			yes = 1;
@@ -155,7 +160,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 		error("the device is busy");
 		return 1;
 	}
-	ret = btrfs_recover_superblocks(dname, verbose, yes);
+	ret = btrfs_recover_superblocks(dname, bconf.verbose, yes);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(rescue_super_recover, "super-recover");
-- 
2.23.0

