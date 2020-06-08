Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730BA1F12F8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgFHGlH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:41:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45258 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGlH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:41:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cY9Y087180;
        Mon, 8 Jun 2020 06:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/cY1k/sQeJwfZqdh7loRNjunYMKq1I1eMFSgm7FuN2s=;
 b=KAaZ/1iCJBhr851vxiaMw4xAa6QYghZXvj5DeoY8G/RPRExRqaSxzr+c3O9ryTDxxaaZ
 Amm/1PMtc+JlPIYxEVG5us9qz7PkYiEIUJqIVENVadvFD/pOMa4WQKjhEOxH41ZAGgr8
 i+Wma92mbBSubtCJiNhhwQ7SCTVgsdMSKjHIFHWS4sTRlyZrYYoKF0n3nXGaYbhW3viD
 lvNYBugJcOvXBnsfbP+PwPpzAEkPdWT+188fXStW3D21ofBAGiEjOKf+gC5e55YC0ucu
 /UUdrGHKGhu+Raji+dDohL0OhQGjs7pdQsDzei0IaSrWlJ6oMjHJugMprdGXY9DYOikv 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jqw567-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:41:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586YGav059253;
        Mon, 8 Jun 2020 06:39:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31gn21qp56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:03 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586d22Q006174;
        Mon, 8 Jun 2020 06:39:02 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:02 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 1/8] btrfs-progs: quota rescan: add quiet option
Date:   Mon,  8 Jun 2020 14:38:44 +0800
Message-Id: <20200608063851.8874-2-anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) quota rescan command.
Does the job quietly. For example:
  btrfs --quiet quota rescan

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/quota.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/quota.c b/cmds/quota.c
index 075fc79816ad..4a68f9db081b 100644
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
+		pr_verbose(-1, "quota rescan started\n");
 		fflush(stdout);
 	} else if (ret < 0 && (!wait_for_completion || e != EINPROGRESS)) {
 		error("quota rescan failed: %m");
-- 
2.25.1

