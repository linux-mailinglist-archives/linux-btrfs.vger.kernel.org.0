Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71B4EE488F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438877AbfJYKZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 06:25:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39646 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438821AbfJYKZ7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 06:25:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PAPL3m193223
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=XWtNMC2lQcgw5+HMKzaFiicVTxvwxTnMQfMsMTX/k/o=;
 b=ESN0j8COryWYhkyLj49+sBHIcXWOUGWojMPxiMxoSI1VoX4QpPvTz/HECI5qsuMoEkvc
 26Y2s7yCn/HvGDdSUTyCkrpTlFXNlC09rXTnvGB0wqI+/apvVPKLcFQJXg5XCbdb9uSy
 4hnLlvs+VAOF/MfWNo5Qspxvf/hWPdeZnXs54Kh8DpRPsZDOUP22pIK93dvdGsIYJKKN
 Bc1IxXfZi3kiB3UkW4nc5jI82gO1z1rw3Lh5oQSEENVpnIpBxhtiub4tRu7HXP9GY1BU
 luSu1Aw6znEZ1aqm7GjdzhIDgz7WgVv6grwycqDMlS0MN+WNjBbWpim6ixlLLN8Dq9nC rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vqteqa34y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:25:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9PAPbVR005221
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:25:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vug0dy7qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:25:48 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9PAPOFV006424
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 10:25:24 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Oct 2019 03:25:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: receive: make option quiet work
Date:   Fri, 25 Oct 2019 18:25:20 +0800
Message-Id: <20191025102520.41170-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910250098
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
This is how I checked if fstests/btrfs-progs-tests is using receive -q option.
   find  ./xfstests-devel -type f -exec grep --color -i -I "receive" {} \; \
	-print | grep "\-q"
   find  ./btrfs-progs/tests -type f -exec grep --color -i -I "receive" {} \; \
	-print | grep "\-q"

 they aren't using it. So its fine.

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

