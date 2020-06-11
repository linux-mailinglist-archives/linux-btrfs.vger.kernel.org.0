Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9121F6CEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgFKRmK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35614 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgFKRmI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHauUC165050
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=57ytmNLudbkREKiYRYo6rCO3T7oIaU05uXpX2ksHwPY=;
 b=ftmFBPtXRiMOn4zSW3CjslLlPfVhWUY7sXzsfNA4RiNaeRlJDAc02gqcrES8h98Ict/D
 15QQtCROzwnaZKqzUNH8ocYGObVIXu46alyWJg200+v4DAZD3pen4oSnoLj5CC/r/Orz
 gNL9jlChzOYTrxwFxi6OTSnJW+KtafKsDxGV2TuAevyDa9VAnMzFPfZvxrw/AZkoXVVM
 QDMhgb7rnm+6e1cshVlGvmzsiAf4DZJG2Uba4tNQSA0N7cC1Bmq30uD1PrPGS7eUU2Q1
 AUR3mN/kYHTpKK8xhSClgtWYLOGuh8K1Tb2pGNghl0V1zLP3ya2LGbTKLJvT0KWKJfwB zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31jepp32fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHbnk8065919
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31gn326fq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:05 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BHg56Z004858
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:05 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:42:04 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/8] btrfs-progs: balance start: add quiet option
Date:   Fri, 12 Jun 2020 01:41:19 +0800
Message-Id: <20200611174123.38382-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611174123.38382-1-anand.jain@oracle.com>
References: <20200611174123.38382-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=1
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

Enable the quiet option to the btrfs(8) balance start command.
Does the job quietly. For example:
	btrfs -q balance start --full-balance <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use MUST_LOG

 cmds/balance.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index b35d90dc362a..13ad64ade4c4 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -470,9 +470,10 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	} else if (ret > 0) {
 		error("balance: %s", btrfs_err_str(ret));
 	} else {
-		printf("Done, had to relocate %llu out of %llu chunks\n",
-		       (unsigned long long)args->stat.completed,
-		       (unsigned long long)args->stat.considered);
+		pr_verbose(MUST_LOG,
+			   "Done, had to relocate %llu out of %llu chunks\n",
+			   (unsigned long long)args->stat.completed,
+			   (unsigned long long)args->stat.considered);
 	}
 
 out:
@@ -501,6 +502,7 @@ static const char * const cmd_balance_start_usage[] = {
 	"               run the balance as a background process",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
-- 
2.25.1

