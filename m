Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC55E985B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJ3Il7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfJ3Il7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ctgH054336;
        Wed, 30 Oct 2019 08:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=78RP8FCTtF0do2rSTdRv0r8CLw88EmQsu+oiUeQp7KQ=;
 b=BnNPOfm1s2daS/q5klcdbykQX8DOqzOXE1Wlh1uw1KbZgimJ/JNU04ciXGNsTCwOCcug
 pVRR61yMUIXmXu9Ivqhw8u+aeaRXRH6XTVk1hWnXHs03aFWjnP1YyH41ZuaiT7hxSoBO
 mFsKPSRxi64PCPcNe/ycE/hpASuO2yjdAu21XAtIqIiB4wFV6a5xndzar7+5U7HIbXFa
 vF6hQXnVGihPhV9XAjB66zAbTn/42XWmM5ftwhLrm06BPgKfAJaIbDqvplY5ElU81SAq
 RBRStxABAGrpwJlawljqGUsaMXhb3Is48E+n1jeHAh+5dMG+/+amjw4PfIA4uzSCJ3Aq wA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2vxwhfje4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cqZ4150166;
        Wed, 30 Oct 2019 08:41:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2vxwhvmga7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:57 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9U8fue7018751;
        Wed, 30 Oct 2019 08:41:56 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:56 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 17/18] btrfs-progs: device scan: add verbose option
Date:   Wed, 30 Oct 2019 16:41:21 +0800
Message-Id: <20191030084122.29745-18-anand.jain@oracle.com>
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
2.23.0

