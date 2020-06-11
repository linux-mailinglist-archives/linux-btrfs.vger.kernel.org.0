Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6F1F6CED
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgFKRmC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 13:42:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53274 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKRmC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 13:42:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHSYRY164237
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=TTB//Ff71UpaX4UKirjak+knoUU4WUAv3GkdRHsPJ8o=;
 b=t7EWBlN7PnfMYF6q3pXE6E5+b5p7SocWAyv972A78ESsstM16SN2JSY/iv8Enh5V+htI
 zdu+EH6mEMZ/ELrrEm8SmI7qkkUMHlKiFXq/miV2E6iYxkFQJa4X9cl1LG8FJDffLnCs
 QrRd3a7ozMwp60Ne6ndq0/fj3t1A1MPkqVgDL16MjXZ1vkOFnFEbtB9t9lgazWWcj8Lp
 AJwKB0YkrsC4eYVtf6xH4hixwq1jDd55xzxfoqvRpYn6HyuYk839O5TX/lQHGQDAZZlX
 9BmjluaWJW2W7KzS9ottBuGffOHtmlbnjvO0tcAPhmzv6GuswLc/KXEKS7FF5ALC20os eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 31g2jrh84e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BHcVuH121620
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 31gmwvsjm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05BHg0CW009602
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jun 2020 17:42:00 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 10:41:59 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/8] btrfs-progs: subvolume delete: add quiet option
Date:   Fri, 12 Jun 2020 01:41:18 +0800
Message-Id: <20200611174123.38382-4-anand.jain@oracle.com>
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

Enable the quiet option to the btrfs(8) subvolume delete command.
Does the job quietly. For example:
	btrfs --quiet subvolume delete <path>

Also, fix a line with over 80 char with proper indentation.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: add missed usage for global quiet
    Use MUST_LOG

 cmds/subvolume.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 459661a93e31..38fc26461342 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -241,6 +241,7 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"-v|--verbose           verbose output of operations",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -359,14 +360,14 @@ again:
 		goto out;
 	}
 
-	printf("Delete subvolume (%s): ",
-		commit_mode == COMMIT_EACH || (commit_mode == COMMIT_AFTER && cnt + 1 == argc)
+	pr_verbose(MUST_LOG, "Delete subvolume (%s): ",
+commit_mode == COMMIT_EACH || (commit_mode == COMMIT_AFTER && cnt + 1 == argc)
 		? "commit" : "no-commit");
 
 	if (subvolid == 0)
-		printf("'%s/%s'\n", dname, vname);
+		pr_verbose(MUST_LOG, "'%s/%s'\n", dname, vname);
 	else
-		printf("'%s'\n", full_subvolpath);
+		pr_verbose(MUST_LOG, "'%s'\n", full_subvolpath);
 
 	if (subvolid == 0)
 		err = btrfs_util_delete_subvolume_fd(fd, vname, 0);
-- 
2.25.1

