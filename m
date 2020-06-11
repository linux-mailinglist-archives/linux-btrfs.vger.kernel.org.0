Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9A1F6CF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgFKRn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:43:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54486 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgFKRn4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:43:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHSl7A164475
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=lDBL/EhEy/CLk2OzvkuwkekYm1vyvhw/fzOHdqRvOes=;
 b=YRm2WOa32cclVuB4j+0olsR/QjGvYFwp9LiD/5Ykak+MPH3zKUgWSw1lj83ySLBUqRos
 MMb/UijR0WEth7H6EAsMQ3j1dtQGlKWvJlFMtt8LUYdZ6elI1W6cwqNKJ4/fhuulSSF2
 0TTDBHdoN3B3uobxIfDngOwOv/56NP7M2BNqmmKcnC1CXLxNUJ3dIJdEao0BN6ruKpWy
 wW/u3KcAV/ruWNQnkfL6apzRY+ajM0mZdIqyf8zKD9BQIUUM222n4xSpyL9QNxyJ8LTB
 5+FLF/qvcdGDC4PuE8e0u2ZtIsc2P3U8rZn0cDeUR4UZ9xymRj1rTKUJS+dOQQc5pVrU jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31g2jrh8cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:43:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHc8CG048315
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31gmqsg0q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:54 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BHfsu1004828
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:41:54 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:41:51 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/8] btrfs-progs: quota rescan: add quiet option
Date:   Fri, 12 Jun 2020 01:41:16 +0800
Message-Id: <20200611174123.38382-2-anand.jain@oracle.com>
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

Enable the quiet option to the btrfs(8) quota rescan command.
Does the job quietly. For example:
  btrfs --quiet quota rescan

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use MUST_LOG

 cmds/quota.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/quota.c b/cmds/quota.c
index 075fc79816ad..d84c8ad327d3 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -108,6 +108,8 @@ static const char * const cmd_quota_rescan_usage[] = {
 	"",
 	"-s   show status of a running rescan operation",
 	"-w   wait for rescan operation to finish (can be already in progress)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -172,7 +174,7 @@ static int cmd_quota_rescan(const struct cmd_struct *cmd, int argc, char **argv)
 	}
 
 	if (ret == 0) {
-		printf("quota rescan started\n");
+		pr_verbose(MUST_LOG, "quota rescan started\n");
 		fflush(stdout);
 	} else if (ret < 0 && (!wait_for_completion || e != EINPROGRESS)) {
 		error("quota rescan failed: %m");
-- 
2.25.1

