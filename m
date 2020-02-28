Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02D2173267
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2020 09:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1IEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Feb 2020 03:04:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgB1IEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Feb 2020 03:04:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S83lxu005831
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 08:04:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=Jcmzr6H3k+oVg9bxZH2wRjQ6OsaVKO2giwppa10XJUw=;
 b=XbvxOHcOSSCYTZS6wc6rnVjNF5kjfvaxc5IMRurIjpixgFj3hHN+60tVxDeOuV2e7ce4
 PYzSlf45tH4iHbnLCgDIkA4luHcjriNMdUiudscEhiXKbx1vMP23cvvkWzs0ZdHTLMw6
 1XhA359qHW3nozs/8f6Bxc+vyQHgg6RmGMS/hl8+62lEA3ICPMGEVIS7k+CeCWdbQVal
 BcheP0ZPkzWHmvUHv6lA9WWcOYcGlihd7QTzxspcfdsydRSAH4ng9rzSk2iU/r3dIMEv
 YxHKizruc0BFGKCPvBzSg1UmOx7JUOXRqte/9cRcVj08c/4MH9zBZbZ2o36vkbVkmOcb Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yehxrvrep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 08:04:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S82AV2094318
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 08:04:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2ydj4q27x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 08:04:11 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01S84AX1010681
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 08:04:10 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 00:04:10 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert, warn if converting a fs which won't mount
Date:   Fri, 28 Feb 2020 16:03:46 +0800
Message-Id: <1582877026-5487-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=1
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=1 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280068
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On aarch64 with pagesize 64k, btrfs-convert of ext4 is successful,
but it won't mount because we don't yet support subpage blocksize/
sectorsize.

 BTRFS error (device vda): sectorsize 4096 not supported yet, only support 65536

So in this case during convert provide a warning and a 10s delay to
terminate the command.

For example:

WARNING: Blocksize 4096 is not equal to the pagesize 65536,
         converted filesystem won't mount on this system.
         The operation will start in 10 seconds. Use Ctrl-c to stop it.
10 9 8 7 6 5 4^C

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 convert/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/convert/main.c b/convert/main.c
index a04ec7a36abf..f936ec37d30a 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1140,6 +1140,21 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		error("block size is too small: %u < 4096", blocksize);
 		goto fail;
 	}
+	if (blocksize != getpagesize()) {
+		int delay = 10;
+
+		warning("Blocksize %u is not equal to the pagesize %u,\n\
+         converted filesystem won't mount on this system.\n\
+         The operation will start in %d seconds. Use Ctrl-C to stop it.",
+			blocksize, getpagesize(), delay);
+
+		while (delay) {
+			printf("%2d", delay--);
+			fflush(stdout);
+			sleep(1);
+		}
+	}
+
 	if (btrfs_check_nodesize(nodesize, blocksize, features))
 		goto fail;
 	fd = open(devname, O_RDWR);
-- 
1.8.3.1

