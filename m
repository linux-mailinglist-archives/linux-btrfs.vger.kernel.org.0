Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6656C1F6CEF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFKRmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53388 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFKRmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHSNWQ164164
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=+bK35USbUoCygN17/o0ytQEOxfCQsnHWwvyloLkavnc=;
 b=RJ3hdUvyozYgE0faH5DtkdWo7ezNvyVLLHpBbw1CzAtRgYzMcxxvNXfXrQYlkn7fA5cY
 gv1Ff2PReZjZncuFhkvrwFUCx5Omt9LNYi0sns8SNAX68AJb6Y3g862360o3CK8jOIzx
 Gu/awxnUr42gpjd9xJ3YvI7HpRZABGw8TypXchAI24UYNcbwnGkPlNxbBIK33LNxSr43
 jO14btkcTVodIUP7bPVcQI+MmO/yqmEMOxTGO7zFjZxT3bFq1UG5ZNSfKf4zv1MP+XYn
 uBqRe38q2VfwFgh/P/MMdXEeoGSspfT9vuWZ9BBPkrpT29lWYvmzBnOMa36fxam+tJC0 dA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31g2jrh85b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHc83q048281
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31gmqsg1ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:12 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BHgCwn020005
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:12 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:42:12 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/8] btrfs-progs: balance resume: add quiet option
Date:   Fri, 12 Jun 2020 01:41:20 +0800
Message-Id: <20200611174123.38382-6-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=1 malwarescore=0
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

Enable the quiet option to the btrfs(8) balance resume command.
Does the job quietly. For example:
	btrfs -q balance resume <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use MUST_LOG

 cmds/balance.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 13ad64ade4c4..0d6ca5f5ba92 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -769,6 +769,8 @@ static DEFINE_SIMPLE_COMMAND(balance_cancel, "cancel");
 static const char * const cmd_balance_resume_usage[] = {
 	"btrfs balance resume <path>",
 	"Resume interrupted balance",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -817,9 +819,10 @@ static int cmd_balance_resume(const struct cmd_struct *cmd,
 			ret = 1;
 		}
 	} else {
-		printf("Done, had to relocate %llu out of %llu chunks\n",
-		       (unsigned long long)args.stat.completed,
-		       (unsigned long long)args.stat.considered);
+		pr_verbose(MUST_LOG,
+			   "Done, had to relocate %llu out of %llu chunks\n",
+			   (unsigned long long)args.stat.completed,
+			   (unsigned long long)args.stat.considered);
 	}
 
 	close_file_or_dir(fd, dirstream);
-- 
2.25.1

