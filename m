Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA54E984D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfJ3Ilb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48678 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfJ3Ilb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ceuk027376;
        Wed, 30 Oct 2019 08:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=s/GhQdS6mAGey1Tb0uFSB7J5rwtVID4rEVOsUz3kE1A=;
 b=TpfUaI1yHP+f+88hQP/sCBDbf1q9c8ySDqoxJQQxkDwgYO01yykUOHDbIUQj0cANBkCP
 FjUfVSOEzJqMiVhdB4AOphDAJHPITH10cQrMeK8OYYso7q4u8AZZzZS5e8cU3yzmzaaB
 WoiHwPxt1QgB5GBloEb1c/QUz+0RjyRylsvydK6aHWc8Xqu7URwN8oqJcJuWjY6/G1Qf
 eueTbvChkzOJr+RINVnk0rHhCM0eQzCR76DU81gQdMVLIvQtlbZSBOBdFcWR1+vOFutq
 OT4wmzQM3IwQsLequ9jomDFbDTZrUoii0TX2yNabBWYiZJHoMJg2LU00t3cijoE59y3N 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhfjefg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ctUc150528;
        Wed, 30 Oct 2019 08:41:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxwhvmfkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:29 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8fSha001220;
        Wed, 30 Oct 2019 08:41:28 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:27 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 01/18] btrfs-progs: receive: fix option quiet
Date:   Wed, 30 Oct 2019 16:41:05 +0800
Message-Id: <20191030084122.29745-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Even when -q option specified, the receive sub-command is not quiet as
show below.

 btrfs receive -q -f /tmp/t /btrfs1
 At snapshot ss3

It must be quiet atlest when its been asked to be quiet.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/receive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 4b03938ea3eb..c4827c1dd999 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -269,7 +269,8 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 		goto out;
 	}
 
-	fprintf(stdout, "At snapshot %s\n", path);
+	if (g_verbose)
+		fprintf(stdout, "At snapshot %s\n", path);
 
 	memcpy(rctx->cur_subvol.received_uuid, uuid, BTRFS_UUID_SIZE);
 	rctx->cur_subvol.stransid = ctransid;
-- 
2.23.0

