Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE8DED90A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfKDGej (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41662 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfKDGei (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46Ybvi174163
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=hj2mJB0JJGerxGosnAb6r1CGNuOXbrnKUJOsknHcdzY=;
 b=PXWZ8iU6hDVTfj6WyuLEy33vAKExpoNSwpVY6oinLQIS/J4xtOScVSNbdM6rhkXVidvU
 cxhN7P/rfqhsjZyQFoo6Yb/rsqNJfqrqBtjBHXa0CHRpncIynMqe86zWmXruvUo4gyV1
 LLv9V6TbQbfkF4cZyW+FUcpt2sYgqJA4rL7ArrP+Vk4CBE0aePte6YJ29/YzvKo1ZRQu
 x4Msc2VR0ruN7XGEL7k2+RvKc0eb1cgH9I1OccIOo3zD7m+chDObzqIUyb2b4D5cS2eL
 C3EpEj5OlYFOmiXc4Pjg3xjtJ1RwOmaFdRPTszTvCX6JDA6tNkgOvwzdJJ3QysdNynES bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w12eqw0x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YWc4187512
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt9cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:34 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46Xs5t004200
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:54 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 18/18] btrfs-progs: device scan: add quiet option
Date:   Mon,  4 Nov 2019 14:33:16 +0800
Message-Id: <1572849196-21775-19-git-send-email-anand.jain@oracle.com>
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

Enable the quiet option to the btrfs(8) device scan command.
Does the job quietly. For example:
 btrfs --quiet device scan

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1.1: fix typo in HELPINFO_INSERT_QUIET

 cmds/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index d268fb2de126..8fef0695990e 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -305,6 +305,7 @@ static const char * const cmd_device_scan_usage[] = {
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
 	HELPINFO_GLOBAL_OPTIONS_HEADER,
 	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -355,7 +356,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 				error("cannot unregister devices: %m");
 			}
 		} else {
-			printf("Scanning for Btrfs filesystems\n");
+			pr_verbose(-1, "Scanning for Btrfs filesystems\n");
 			ret = btrfs_scan_devices(1);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
-- 
1.8.3.1

