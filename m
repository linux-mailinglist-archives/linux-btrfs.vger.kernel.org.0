Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF94108BEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbfKYKj6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50588 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfKYKj5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:57 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6LM026837
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=LjdZ3W7TVIE158suKJMxd7kkgh4bmy8khLAMOk9Hj8M=;
 b=r91tZPmAA5a7Zs/MB0lshjS8XD5iuuVtXdLU6R3S6c6sTp4PcPPplPbt4CnPT8twWD+S
 drGAtHwBvZvc3aWqeYmodgZIagmj7pxXfaFROzn1Ggs+SkkLwMlDqxR35k1xeOCe3yAs
 0yToQvyJFP1CdKP5ZwaFcmelL6jMSMg0ECl7bAVMptChYGwiOcZ6RZf6nrkEYthzth9l
 7APy8d532K7q9Js0XBIBEfm73SVOYijp3HWciUGwNvr8qyMCoOYVHpAY5q1iAXXBliLo
 V8VB/FeuBCQBX3WUzxpBF4ybxeNDVmv6d28P9lcFMrI4tK6huAtAEIBhQHmfHGQ7zFfh WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wev6txruc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAX39s169664
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:55 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wfewa7ar5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:55 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAds3f017025
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:54 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:54 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/16] btrfs-progs: device scan: add verbose option
Date:   Mon, 25 Nov 2019 18:39:16 +0800
Message-Id: <1574678357-22222-16-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
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
v2: Use new define HELPINFO_INSERT_GLOBALS

 cmds/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index f96d71e0477a..2feb1acd031d 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -303,6 +303,8 @@ static const char * const cmd_device_scan_usage[] = {
 	" -d|--all-devices            enumerate and register all devices, use as a fallback",
 	"                             if blkid is not available",
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
+	HELPINFO_INSERT_GLOBALS,
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

