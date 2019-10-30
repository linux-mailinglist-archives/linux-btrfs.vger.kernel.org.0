Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F2BE985D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJ3ImC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:42:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfJ3ImB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:42:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8d2TJ037066;
        Wed, 30 Oct 2019 08:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=k1imgJ3WfTgzRKRTI4DHXkF5WiukNnZGFIUGrOX/pD4=;
 b=QO9rNvQ30wShmByOe1sGWkFGlPQvfSLyWORSPW8ckR/f2ClkAAjTQRHP65pd6kLdeLUi
 USao63qJlJbFVJm/l/rT1LqU4S41GVfYkgvxICeUzTkB368yVKC1x87/uniRIBJnZvZD
 wsK6GR1j7HOhSHGCIV/8v4eBjuB/3YH8zxgsl/YR3yRiHOCfNVVjMtnZl0+jg+LhtiAC
 g1j46UCg1ThjDPt/eWf7ulDa5gVf4McXNd8/XrL933MWDQOBP6CP8LJCwmtp+dZ5R4/o
 Zrbq5y9Efpgeis9utHma/8if7rddMQi36S7ej+1xnqfh/R98I4qyPE/lCCLLKuurq8Ti ZQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vxwhfafk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cYh3073894;
        Wed, 30 Oct 2019 08:41:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vxwj63nuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8fwC0018756;
        Wed, 30 Oct 2019 08:41:58 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:58 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 18/18] btrfs-progs: device scan: add quiet option
Date:   Wed, 30 Oct 2019 16:41:22 +0800
Message-Id: <20191030084122.29745-19-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
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
index d268fb2de126..5a0c253ce3eb 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -305,6 +305,7 @@ static const char * const cmd_device_scan_usage[] = {
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
 	HELPINFO_GLOBAL_OPTIONS_HEADER,
 	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUITE,
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
2.23.0

