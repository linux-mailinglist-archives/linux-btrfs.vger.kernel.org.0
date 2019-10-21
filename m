Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0733DE8F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfJUKB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42118 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbfJUKB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xN34023825
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=qASuGQU5lXv4NXPYcDaufu8UqbtFHox32ldx3wlxKv0=;
 b=LZcp6dwX7YpJV3RBrSO4OV66a2h6F+YOb2IMqKLOlVgevL0M9AGPScU7wIpZSMJ+iGbe
 11ACM0pj7rD1nsC4zXJXtqLKlDxoRNUrbBT5SxfZf/zN//MWJWka28ltVfkPQ1/w2+Vf
 WZNqNoZkz5FRCVXgVuN5ZPWUqqJB48qCzzF5Hr8XKyqRStne8sR7/CyN8o2zXc/t7PSO
 Av23pS3bO4Z+VmE4CFvqASkivgOrndFrYjJF36nC2/zkzmhW/JFTgudxklQxrzC2YT/O
 6XAW+1er1R/oWj1lVXQ1tsY+RfnDEdWhw0dYoqxsnxSQTczbb5Oj6F7ZBYBh7Cz0RBSU cQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vqswt6pms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wVrE089552
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vrbyycv4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1snl013556
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:54 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:54 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 14/14] btrfs-progs: enable verbose for btrfs device scan
Date:   Mon, 21 Oct 2019 18:01:22 +0800
Message-Id: <1571652082-25982-15-git-send-email-anand.jain@oracle.com>
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

Enable verbose output for the device scan only through the global
verbose option.

For example:
./btrfs --verbose device scan
Scanning for Btrfs filesystems
registered: /dev/sda1
registered: /dev/sda2
registered: /dev/sda3
registered: /dev/sda5
registered: /dev/sda6

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index b429a169cd5d..b38bf78a798e 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -354,7 +354,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 			}
 		} else {
 			printf("Scanning for Btrfs filesystems\n");
-			ret = btrfs_scan_devices(false);
+			ret = btrfs_scan_devices(true);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
 			error_on(ret,
-- 
1.8.3.1

