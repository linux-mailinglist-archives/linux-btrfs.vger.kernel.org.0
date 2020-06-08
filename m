Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3DF1F12F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFHGjT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60328 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGjS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cXGu142532;
        Mon, 8 Jun 2020 06:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=5WzCdDquAU9c9GEdE4m1gp/O0a4WdakhaLjXkiCX5CM=;
 b=WloJJyLlz70XuMW4zJ+JACke5J3osBtvWMYVoR8H3JbxUUcwhYP8yrgUAD77DkmPeRef
 YOJhnjn4PHkJzRKvu/GxwAg0nZDlEcPc45zd7rg+RxefOcjjK7fQ9CB0lZEuTttYudIr
 uxzu5e9qHJ2rdNhnG8u7HmUYnanEgCdyGRClb568jVy+gYG/BkcuiDFg6BDzdE/w7+Iz
 5OKqDtCgriDH07gONd8WPh8lS3cGTT+sB6rWlM4BdJkRqwTdFBKley5hACiv2tfdw+xP
 kTpx6ZgsSJ0J6IwvxuY1lefFrw+UOPdQpn0glUpD/tpF+2QxWbHIm0Q7zoFWy5ggEsf/ jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31g3smn19s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586Xkde094035;
        Mon, 8 Jun 2020 06:39:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31gmqkt8cn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:14 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586dD8i006237;
        Mon, 8 Jun 2020 06:39:13 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:13 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 6/8] btrfs-progs: subvolume snapshot: add quiet option
Date:   Mon,  8 Jun 2020 14:38:49 +0800
Message-Id: <20200608063851.8874-7-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608063851.8874-1-anand.jain@oracle.com>
References: <20200608063851.8874-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) subvolume snapshot command.
Does the job quietly. For example:
	btrfs -q subvolume snapshot <src> <dest>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/subvolume.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 9c8fe35a2aae..dbfa40d1549a 100644
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
+		pr_verbose(-1,
+			   "Create a readonly snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
 	} else {
-		printf("Create a snapshot of '%s' in '%s/%s'\n",
-		       subvol, dstdir, newname);
+		pr_verbose(-1,
+			   "Create a snapshot of '%s' in '%s/%s'\n",
+			   subvol, dstdir, newname);
 	}
 
 	args.fd = fd;
-- 
2.25.1

