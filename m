Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64D1F12ED
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 08:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgFHGjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 02:39:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56250 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgFHGjN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 02:39:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586ahpK034736;
        Mon, 8 Jun 2020 06:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=byOcYLZI/Na/6BLjy4AUxYUbRPPTuovBuZeXm/SvRLM=;
 b=QBkKxF2oCurNtjhRyXWeTcz7zdilMEcEYpmgmcyXD9rndNbtkxgk9/StYnF1/qMmr85Y
 Jm0g62Tm5isxlFbF+JVGA4OvuUbEptjGKPZM1NOUu7c6YWf6/yvHz0W27+zbCz2Vdfjf
 kNDQF+4Nb5F7wf3sichLdLRPRNAyPYlG1fB2BXWzaXXWGuIyrIKV/A3TT0YibVx0Gamu
 mUo82Z1hrTQ9Eu8psxc6ddW8KBy9k4R1wnc9W3R7vSoXG15Qk8nKIV2fuULn2rqU7RqL
 F6Z6phV/75edfezEA1zAZaJYqIyQBTCIwsYVSkzwUC63rozYVAylapKPQda5sGUOjgCj rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31g33kw3x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 06:39:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0586XbDI156365;
        Mon, 8 Jun 2020 06:39:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31gn2usf50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 06:39:09 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0586d8CS006208;
        Mon, 8 Jun 2020 06:39:08 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 07 Jun 2020 23:39:07 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 3/8] btrfs-progs: subvolume delete: add quiet option
Date:   Mon,  8 Jun 2020 14:38:46 +0800
Message-Id: <20200608063851.8874-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608063851.8874-1-anand.jain@oracle.com>
References: <20200608063851.8874-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9645 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080049
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
 cmds/subvolume.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index ed3a3ab48ec7..9c8fe35a2aae 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -359,14 +359,14 @@ again:
 		goto out;
 	}
 
-	printf("Delete subvolume (%s): ",
-		commit_mode == COMMIT_EACH || (commit_mode == COMMIT_AFTER && cnt + 1 == argc)
+	pr_verbose(-1, "Delete subvolume (%s): ",
+commit_mode == COMMIT_EACH || (commit_mode == COMMIT_AFTER && cnt + 1 == argc)
 		? "commit" : "no-commit");
 
 	if (subvolid == 0)
-		printf("'%s/%s'\n", dname, vname);
+		pr_verbose(-1, "'%s/%s'\n", dname, vname);
 	else
-		printf("'%s'\n", full_subvolpath);
+		pr_verbose(-1, "'%s'\n", full_subvolpath);
 
 	if (subvolid == 0)
 		err = btrfs_util_delete_subvolume_fd(fd, vname, 0);
-- 
2.25.1

