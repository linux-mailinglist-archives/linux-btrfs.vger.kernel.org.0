Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CB81F12EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgFHGjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cBPK086919;
        Mon, 8 Jun 2020 06:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Pn8UQzqWfQJYer+kfgYgYmNRgH7FpXUo+Zlk3X1IatA=;
 b=IUSGw2RF/mf8lxbq/L1v4tXkjxaKbQKRtoiR6ROPdk0h7AcI2jxdvelbWtJ3N1uP0Ati
 b2rPpVvYUBMA56LG4s6Wr5oPKQbWNsoCu0Ela3IOjID5qNbiVB+YgJzzVud2CcXS6vDS
 GXXn3D+pgPm32hUV6uuAM3khEWqr4yeGXlS5Syxuq5zzDrTfflm/fYarryiNsFMGt+gt
 n3kjv7EzsJO03oVqG0DEYZUZu/j+MZaX0fYP/UNeYiogWmIOMeNDYfzRism0vhW71Nnd
 J38jHm04dwB+Ab8rG9f1b7ELjg2UJ48e//7QI7HYyOLT7ZsGTFMS92NUFEsDW419Dsfk Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31g2jqw516-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586XlNq094225;
        Mon, 8 Jun 2020 06:39:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31gmqkt8bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586dAi7006230;
        Mon, 8 Jun 2020 06:39:10 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 4/8] btrfs-progs: balance start: add quiet option
Date:   Mon,  8 Jun 2020 14:38:47 +0800
Message-Id: <20200608063851.8874-5-anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080049
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) balance start command.
Does the job quietly. For example:
	btrfs -q balance start --full-balance <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index b35d90dc362a..154f54c3e3a6 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -470,9 +470,10 @@ static int do_balance(const char *path, struct btrfs_ioctl_balance_args *args,
 	} else if (ret > 0) {
 		error("balance: %s", btrfs_err_str(ret));
 	} else {
-		printf("Done, had to relocate %llu out of %llu chunks\n",
-		       (unsigned long long)args->stat.completed,
-		       (unsigned long long)args->stat.considered);
+		pr_verbose(-1,
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

