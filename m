Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC733ED907
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfKDGeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41604 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfKDGeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YZ5R174130
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=/JRh1t1buWb+FVIu6WVRdp5fR+nOZt0E3L0AB0MDoyw=;
 b=K07pjvPQ5Y7adRW1YWoXYtppSRsB37SezdNn5B0VyGX8BMTkmMDH0jFz3tIXbljokv1U
 TnUXUXc5K0GpuA4tThcnrqsvQ5bB99fp9XWLm4I7V/F6pBDJDWbt5lW4KbtWAEu+Dmsp
 ZhbQCCxo+WORxzwose/FG9Lynq6gjO3RjCdGh7gOvePkE7TMXoaFdDY57kX/z6NmibVx
 TfC3wo9GJTPtmb4+vQjCD/ZouNDYEBL3cEGy2+gOYxeMyueVkcUSTUCv0uGZh+8DFlVm
 esIClWOaQD5CWzm6IU7iqPisj75aNF8dDGUODx/n4HRGqMhx7Ij861Q8hi8f/2biNHNk MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2w12eqw0wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YW3A046578
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2w1ka9qsfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:32 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46XTlF023473
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:29 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 01/18] btrfs-progs: receive: fix option quiet
Date:   Mon,  4 Nov 2019 14:32:59 +0800
Message-Id: <1572849196-21775-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040063
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
1.8.3.1

