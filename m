Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD389ED918
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfKDGhE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:37:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDGhE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:37:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46Yhgf187318
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=6Bxxc80R2Tnj5bTq6xsLqBSPFk2oaH9l5y6uNrTzykc=;
 b=f/WYY3v2wKM6ZBwKHXFgdu1AOP1+wAYIToJeq+ZYvgazSF5W85ZMh0zJvQX6svpbpHpt
 GecKL1mbft3k+g2uhUaYCC9jKspDyodfFKtFtzdUQwAuyJLQIxInyNy44XmxkE1MW+De
 Qo41POt/hGka0DVrWlOnRCPL9c+UKasLeOOakJAhjlAScSS/UBHSqEmradU5+G1Ednck
 4gDO3R8UPdnHvx6nkD3lbfGHUP9JjBnSZnKkp3R+rJeDz9Un4ZKo+y/4rAmlTaRprkdu
 jnIZAgv1Msd9Y2s3+rqfwvzdvO8nufZDbOhm5zeFXkG7ejh2TOvyAYf9+h5JYX+SjYCX 1Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2w11rpn62q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:37:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46ZmMe134326
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:37:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2w1kxcnfa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:37:00 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46Xq3S023645
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:52 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:52 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 17/18] btrfs-progs: device scan: add verbose option
Date:   Mon,  4 Nov 2019 14:33:15 +0800
Message-Id: <1572849196-21775-18-git-send-email-anand.jain@oracle.com>
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

Enable verbose output for the device scanned, this uses the global
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
 cmds/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index f96d71e0477a..d268fb2de126 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -303,6 +303,8 @@ static const char * const cmd_device_scan_usage[] = {
 	" -d|--all-devices            enumerate and register all devices, use as a fallback",
 	"                             if blkid is not available",
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -354,7 +356,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 			}
 		} else {
 			printf("Scanning for Btrfs filesystems\n");
-			ret = btrfs_scan_devices(0);
+			ret = btrfs_scan_devices(1);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
 			error_on(ret,
-- 
1.8.3.1

