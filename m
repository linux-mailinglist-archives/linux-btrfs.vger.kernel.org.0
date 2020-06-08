Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3010F1F12EF
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFHGjR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44366 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgFHGjQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586cNHP086980;
        Mon, 8 Jun 2020 06:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=rlKh/4OJ6c4KabA8fC0j04uaiebLH69SAh5ngOuDFw0=;
 b=SlDXSeM59f6OnrBEupMcdTd+LZGgarmBhC/Woz44FqZc+wQM6SrYg3g+MYKUnaMqmpti
 eKV32J9iSFHqvpFdsbwalRiHPgOeyGf7J+v5PFA+2pxydxHxzO6nJgtY9CeVEd2Ryy1A
 0N3YZ6XrQIkGMYjdNz/Yy7x6z2ahh6OwlHETj+1yU02wxbqp5CTon+9uxC1TAw2o2h6S
 UKVmwo541HC1bRqMILDgDNjXVWMsXOe8wbqjUTgPJBoi4fBDMNZKEdiSkIx7E/NKsyIt
 ybRidtbu74IZUfCNBhRa4qxwLS+G/UYga1f0yYKQiPgx6UqjJiDpZtA1ySsE97T/8eKJ NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jqw51b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586WIBi122234;
        Mon, 8 Jun 2020 06:39:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31gmwpgh2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:13 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0586dCZa014001;
        Mon, 8 Jun 2020 06:39:12 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:11 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 5/8] btrfs-progs: balance resume: add quiet option
Date:   Mon,  8 Jun 2020 14:38:48 +0800
Message-Id: <20200608063851.8874-6-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608063851.8874-1-anand.jain@oracle.com>
References: <20200608063851.8874-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
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

Enable the quiet option to the btrfs(8) balance resume command.
Does the job quietly. For example:
	btrfs -q balance resume <path>

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 154f54c3e3a6..cf22aa13533b 100644
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
+		pr_verbose(-1,
+			   "Done, had to relocate %llu out of %llu chunks\n",
+			   (unsigned long long)args.stat.completed,
+			   (unsigned long long)args.stat.considered);
 	}
 
 	close_file_or_dir(fd, dirstream);
-- 
2.25.1

