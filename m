Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1491B108BE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKYKj7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37908 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfKYKj7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6b5021407
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Cu9uaPY2wk7F5jNUOhmh8q86aHfO3WsS4vU5O3Rtsjo=;
 b=Ot42vX7ydVrbY7TedEfNu0ePLhVmHcrfsAAb8jT0COPnmLoKa6E2xtYrZzzjy/lKBWjm
 IVNeJ6J/6nqMfVyjB5Zxzg4q0T6t5xNcdDIVsbpJ7sfRGRudgK+fwaw1Xkj6r19//Ruf
 CmiaaYry3vLj9kMn6raQCG5wlPnJH7BTmZQdZqt2QMY8ag50pDXK32VZlcPyTsdNRvCW
 ThE6AAJRVEFFCQAMl8EIKp/cDm00NDSnzbUC+PAeIFzPiHdRUF1Q4QcesiWJCXuw/UDi
 R4bnAQSnmAxojzDpahojxLDbTmQf/QS0dmPgmYEeCPmuV95fwtTvvPLM8l1Lq4bTL3tD Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wevqpxry6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAX3Ws169585
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wfewa7asw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAduwW001809
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:56 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:55 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/16] btrfs-progs: device scan: add quiet option
Date:   Mon, 25 Nov 2019 18:39:17 +0800
Message-Id: <1574678357-22222-17-git-send-email-anand.jain@oracle.com>
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

Enable the quiet option to the btrfs(8) device scan command.
Does the job quietly. For example:
 btrfs --quiet device scan

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index 2feb1acd031d..2c34defd8249 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -305,6 +305,7 @@ static const char * const cmd_device_scan_usage[] = {
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
 	HELPINFO_INSERT_GLOBALS,
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

