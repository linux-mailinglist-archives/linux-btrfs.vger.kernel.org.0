Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4096C9F8E
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2019 15:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfJCNgS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Oct 2019 09:36:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58680 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbfJCNgS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Oct 2019 09:36:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93DXSHc192104
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Oct 2019 13:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=hqlbOe43Gdm2v0CPnw00u8FcfQxrWp+zd+PeZpUT3W4=;
 b=gcv9GDl/XrhjCUwpncSZ7ieQd9yTq5ud2i43d9KWYE65EleF+TdsMkSmuPuOdFDNTMXx
 eqUL2z0tYrDTRk/q7EZokAHJHGcEh6GXbXHqQFmLdUkhWTL5rk5BBxF+dUMmPRn7qK0v
 RBHGz6rUTL0g3rk3ZNPXC4fqbfCf0Y7TzZ1VcAwWGy5ny0dCDv5usVetyJuue5qlPCpM
 Y1reFw5YJ2np6uRgkDrrEPgH6oX5lSkKAwTPjvNAWaKvdOWOMWSxhfOXIbLI8a4dlEWE
 +QxV45P95F89jvQKfXsTLM+kpf8wfEAVGArI4Mx8MLr2fkPiGaHAtgh7mq9/7v8CCxIz Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2v9yfqm3na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2019 13:36:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x93DXVdB177469
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Oct 2019 13:36:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vckyqsqdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2019 13:36:16 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x93DaFB3006348
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Oct 2019 13:36:15 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Oct 2019 06:36:14 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: add device scanned-by process name in the scan message
Date:   Thu,  3 Oct 2019 21:36:11 +0800
Message-Id: <20191003133611.2900-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910030128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9398 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910030128
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Its very helpful if we had logged the device scanner process name
to debug the race condition between the systemd-udevd scan and the
user initiated device forget command.

This patch adds scanned-by process name to the scan message.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: add pid as well

 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 79e66db2c1a7..3fe0c422f75f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1005,11 +1005,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		*new_device_added = true;
 
 		if (disk_super->label[0])
-			pr_info("BTRFS: device label %s devid %llu transid %llu %s\n",
-				disk_super->label, devid, found_transid, path);
+pr_info("BTRFS: device label %s devid %llu transid %llu %s scanned-by %s(%d)\n",
+				disk_super->label, devid, found_transid, path,
+				current->comm, task_pid_nr(current));
 		else
-			pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s\n",
-				disk_super->fsid, devid, found_transid, path);
+pr_info("BTRFS: device fsid %pU devid %llu transid %llu %s scanned-by %s(%d)\n",
+				disk_super->fsid, devid, found_transid, path,
+				current->comm, task_pid_nr(current));
 
 	} else if (!device->name || strcmp(device->name->str, path)) {
 		/*
-- 
1.8.3.1

