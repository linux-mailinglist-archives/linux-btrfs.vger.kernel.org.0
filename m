Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB9E1F6C4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgFKQlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 12:41:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51360 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgFKQlz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 12:41:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGXVKQ051875;
        Thu, 11 Jun 2020 16:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=tUGNBZJ/fphCHMC308Cc7e10Zg+CVeqWAMLNslRdAg4=;
 b=EXIMmiCWpK1t3z4VfuD2Hm0afuNiwHijRoHwCk5nM9sg8jKiFrTCc2BacKK2vBJ8SKAb
 2WPF55zl/dMFsKZu9m95v822/+cY++4Sr5JoWXphGyz4kY3UySV9ZA3/C7kGBXuDuOfk
 YqYuZCyzLJkJaEWiCwgyw04fpzH4bQc929wzv8lA0V7nep+AlLG7mQy9iHjkV6Qu5mTo
 ag0YE9+k5gLHrqrritjmwBhCvNzWbjS71PVX/G3pHui1kwtcTAA4STCFW0IFuapvSW1C
 dttBltHU1iuKwtyXbq3ziAKYw4XtkmWuSgbjh/3OBOmoB9HL5EeVfEViuos6gOQcxTRe FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31jepp2spw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 16:41:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGcV6N043345;
        Thu, 11 Jun 2020 16:41:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31gmwvpdj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 16:41:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BGfnEp024484;
        Thu, 11 Jun 2020 16:41:50 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 09:41:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v2 16/16] btrfs-progs: device scan: add quiet option
Date:   Fri, 12 Jun 2020 00:41:04 +0800
Message-Id: <20200611164104.35948-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110130
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Enable the quiet option to the btrfs(8) device scan command.
Does the job quietly. For example:
 btrfs --quiet device scan

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: use MUST_LOG

 cmds/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index a2c16ecb3034..26ac6d70b427 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -307,6 +307,7 @@ static const char * const cmd_device_scan_usage[] = {
 	" -u|--forget [<device>...]   unregister a given device or all stale devices if no path ",
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -357,7 +358,8 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 				error("cannot unregister devices: %m");
 			}
 		} else {
-			printf("Scanning for Btrfs filesystems\n");
+			pr_verbose(MUST_LOG,
+				   "Scanning for Btrfs filesystems\n");
 			ret = btrfs_scan_devices(1);
 			error_on(ret, "error %d while scanning", ret);
 			ret = btrfs_register_all_devices();
-- 
2.25.1

