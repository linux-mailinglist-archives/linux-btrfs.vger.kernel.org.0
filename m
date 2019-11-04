Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56851ED908
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfKDGeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41546 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfKDGeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YYYu003905
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=PaAjF7GRFumvlNG/l2clzB9ISb6v8Sg2hpLQj4gRlMo=;
 b=Ij5xUkTb1G4xDZtaeqH58g8OmUNeskurzD9f1sxW1/61XmKSPP0f59miv1hc/lte2dV/
 /v5u3hFBkNPm476ZfqyPFbtKoXn5T5jl+U5qZEy4HDjebIccIfvbR41tVqIbKrj3CZNe
 CiPUy+AiiR+y4Q2gzycncIRePCcYd3LmD9eV0YzvtY7eJoUyzhTK9pmpXIzArNk/BiM9
 wj+acIt5wODaPV59zoBRigajVK5lE0Zd/m7iG2/sDyrRx2W/cnCFg40RNF5NnifdLi6d
 HKV2kgsy3EqG3CT7CXm3W9D/EooJsPXf+uzmhnW6zHFd7Z6UpJUkJldraYsltWgnArme Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w117tn75x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YWP1046608
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2w1ka9qsgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:34 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XWXE000396
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:32 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:31 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 03/18] btrfs-progs: balance start: fix usage add long verbose
Date:   Mon,  4 Nov 2019 14:33:01 +0800
Message-Id: <1572849196-21775-4-git-send-email-anand.jain@oracle.com>
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

btrfs balance start supports both short and long option -v|--verbose
however usage failed to show the long option. This patch fixes the --help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index b236fabbe236..a98cd8d6200f 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -490,7 +490,7 @@ static const char * const cmd_balance_start_usage[] = {
 	"-d[filters]    act on data chunks",
 	"-m[filters]    act on metadata chunks",
 	"-s[filters]    act on system chunks (only under -f)",
-	"-v             be verbose",
+	"-v|--verbose   be verbose",
 	"-f             force a reduction of metadata integrity",
 	"--full-balance do not print warning and do not delay start",
 	"--background|--bg",
-- 
1.8.3.1

