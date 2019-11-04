Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50DED913
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfKDGev (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:51 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbfKDGeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YXOM187170
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=+OkZPxPEjMihCVtSNjuWAGUG0rOqJJRaFcHb/5+WI54=;
 b=VuRbN+8ResjvKYwzto5zzLiMQluyS42YKpc1O3495aV0kH2XLR1MvY3MrMFjVl7JbbzN
 +urn/x/VJGI/eq/ic7LtS6jBXJiYv67MWZIfXpTuxKsayAyAX9/8nCeoQmLTQ6/UeEbW
 KXeU3G9e3CMkeNUqwcDwUygFQIi5ocoyzmEvtWXoZ47K9/K408Xp4+VDGiHXcYYhdxZt
 9OR3b8BuqCjetjTaVQ9PWFIS/k/U8aBmrTdZroiHzxySvXu6aW6kQfLf2QqIcaHyyULh
 0tJkpo0E64OoyYtX81515Xec+9NH2dzP+tOSsx0jYVJ6Fidyiv9DjOB0E8ufRHTrCHJc ww== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YiIR066381
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2w1k8u69gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:44 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46XUc2004085
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:30 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 02/18] btrfs-progs: balance status: fix usage show long verbose
Date:   Mon,  4 Nov 2019 14:33:00 +0800
Message-Id: <1572849196-21775-3-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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

btrfs balance status supports both short and long option -v|--verbose
but usage failed to show it in its --help. This patch fixes the --help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 32830002f3a0..b236fabbe236 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -822,7 +822,7 @@ static const char * const cmd_balance_status_usage[] = {
 	"btrfs balance status [-v] <path>",
 	"Show status of running or paused balance",
 	"",
-	"-v     be verbose",
+	"-v|--verbose     be verbose",
 	NULL
 };
 
-- 
1.8.3.1

