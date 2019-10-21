Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98076DE8E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfJUKBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfJUKBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xKkq023807
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=QLM+hUyWnCVVldGwiic2TMuBrMO7w2GhjM7l/QLiKFs=;
 b=pLFcRWOO6ocvZolKSnedpVxYJoB5PMZD1XMOmttqaDzbNbcblh8Y5iVlwALnPw8p8+Pr
 iZoWOYJ7l1+PR+StHogva7U/CY7ntuMCZJtp3rEQI9qYnOGLNHoxgIrRMwm+gsWO0TQS
 2721fscRk2yAEtQI3KreGJtmsYgLeDoV2MnnpFpuH1w8KJQPPQye0voSkE/ulJg+nxlm
 5BnPbOdvblp0+TI74PJxz18WZywm4+YKF58dlgRaEfkS6hjUNoqBc/mEj4JqyXAdUj5S
 WDa1oLXVTxOku4MTWMarKlXSV3lbCDpXeUUX9umlJxypEODbbVWaa7b3Q/n1GbMBa672 Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vqswt6pks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9w95I006485
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vrbxsvmhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1gUx023906
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:42 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:41 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 06/14] btrfs-progs: fix help, show long option in balance start and status
Date:   Mon, 21 Oct 2019 18:01:14 +0800
Message-Id: <1571652082-25982-7-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs balance start|status support both short and long option
-v|--verbose however failed to show it in its --help. This patch fixes
the --help.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index d4916c5fb34e..06bab9f7f96f 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -492,7 +492,7 @@ static const char * const cmd_balance_start_usage[] = {
 	"-d[filters]        act on data chunks",
 	"-m[filters]        act on metadata chunks",
 	"-s[filters]        act on system chunks (only under -f)",
-	HELPINFO_INSERT_VERBOSE_SHORT,
+	HELPINFO_INSERT_VERBOSE,
 	"-f                 force a reduction of metadata integrity",
 	"--full-balance     do not print warning and do not delay start",
 	"--background|--bg  run the balance as a background process",
@@ -822,7 +822,7 @@ static const char * const cmd_balance_status_usage[] = {
 	"btrfs balance status [-v] <path>",
 	"Show status of running or paused balance",
 	"",
-	HELPINFO_INSERT_VERBOSE_SHORT,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
-- 
1.8.3.1

