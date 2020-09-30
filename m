Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BBB27DE91
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 04:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgI3Cqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 22:46:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgI3Cqc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 22:46:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U2kV8E130898
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 02:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=MU7XGYPCocMNfNNfwRbxqpFiERv046k22HCQCL1XmNY=;
 b=qvjnAHlWBsOyJh0shrKoY4mSAQrb5uHOeU5VLj+TIdYaRxmvYp8psLcegR7wVFJL9o/r
 n8gH4SwM+26ox5VEOKNwvp5N/eKKUKxKe9Jg+751tH1NQHCKq1rNgkexUqulhj0Jo0si
 gxIGvl0xlm07VZxAIxkVvWwvlXEbhJHPtIH8IukkcQ/fqQjh8S8CpZKNJ8q8AgW4VEHz
 dd0a7DKvFRgwP88P9gpdR/0Ny9dlwN2EprKtqZyxy1zW9g+JOkHT6WtEcntufFX0DFO9
 6QwWe6Pix+fZeQJv1CXWntfEYDNlxNcZ34y6oKn5bLhaz2Bxrp39Z3VrdSCnHf/qxLmL Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkkx777-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 02:46:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U2jlP5121714
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 02:46:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33tfjxu634-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 02:46:30 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08U2kT2b009555
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 02:46:29 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 19:46:29 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs-progs: fix return code for failed replace start
Date:   Wed, 30 Sep 2020 10:46:14 +0800
Message-Id: <48194115537d723d04bba0505411525b77f3e73b.1601402292.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300018
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When replace-starts with no-background and fails for the reason that
a BTRFS_FS_EXCL_OP is in progress, we still return the value 0 and also
leak the target device open, because in cmd_replace_start() we missed
the goto leave_with_error for this error.

So the test case btrfs/064 in its seqres.full output reports...

  Replacing /dev/sdf with /dev/sdc
  ERROR: /dev/sdc is mounted

instead of...

  Replacing /dev/sdc with /dev/sdf
  ERROR: ioctl(DEV_REPLACE_START) '/mnt/scratch': add/delete/balance/replace/resize operation in progress

for the failed replace attempts in the test case

Fix it by adding a goto leave_with_error for this error which also fixes
the device open leak.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
This patch has passed fstests -g replace.

 cmds/replace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 84fcb80ed495..f4e81574804e 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -297,9 +297,11 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 			goto leave_with_error;
 		}
 
-		if (ret > 0)
+		if (ret > 0) {
 			error("ioctl(DEV_REPLACE_START) '%s': %s", path,
 			      btrfs_err_str(ret));
+			goto leave_with_error;
+		}
 
 		if (start_args.result != BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT &&
 		    start_args.result != BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_ERROR) {
-- 
2.25.1

