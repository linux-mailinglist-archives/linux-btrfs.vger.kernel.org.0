Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0462A1F6CF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgFKRmU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFKRmT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHSR6p164176
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=MZ/5zHVK3j1b6M2p0M+LoSmnbKkj29SqKiQyQNS6tw8=;
 b=M4233tPgc9nIZZmc7bgaRwAA4n/z3kEuvcIxsTMhLAP6XRz6MPmAWHDcVAPSE5hYEpzI
 CCJs8FBS1/oiK1alEvD7GOoSk5ZGSccdxcyo8Yn+MZ7Pzh+RS/Bi38A3svATo24H4RET
 yN48zq0YL96qZsARJqZOxPnC9xsGPM0MxfLcs4L1sEwgt4yAg91+0K+s6Q01wkoYNVxU
 AjXsARqmmG49cAtHv272L+PwCyranL3COO1iykbFwoPCT9kSZuiArjnIv+Xj6rn1OqvJ
 tk5bbPYWivphmYTRJA+J/ilHBVB4n/ppGrrJhf8mXoQV7utyBR7++7d1ubs7Ca96P5xH kw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jrh85g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHcVZ8121605
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31gmwvsk08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:18 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BHgHdC004930
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:17 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:42:16 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/8] btrfs-progs: subvolume snapshot: add quiet option
Date:   Fri, 12 Jun 2020 01:41:21 +0800
Message-Id: <20200611174123.38382-7-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110138
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) subvolume snapshot command.
Does the job quietly. For example:
	btrfs -q subvolume snapshot <src> <dest>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use MUST_LOG

 cmds/subvolume.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 642cd822670e..2a73c752ef77 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -669,6 +669,8 @@ static const char * const cmd_subvol_snapshot_usage[] = {
 	"-r             create a readonly snapshot",
 	"-i <qgroupid>  add the newly created snapshot to a qgroup. This",
 	"               option can be given multiple times.",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -783,11 +785,13 @@ static int cmd_subvol_snapshot(const struct cmd_struct *cmd,
 
 	if (readonly) {
 		args.flags |= BTRFS_SUBVOL_RDONLY;
-		printf("Create a readonly snapshot of '%s' in '%s/%s'\n",
-		       subvol, dstdir, newname);
+		pr_verbose(MUST_LOG,
+			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
 	} else {
-		printf("Create a snapshot of '%s' in '%s/%s'\n",
-		       subvol, dstdir, newname);
+		pr_verbose(MUST_LOG,
+			   "Create a snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
 	}
 
 	args.fd = fd;
-- 
2.25.1

