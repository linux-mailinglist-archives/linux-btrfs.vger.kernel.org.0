Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B185D1000AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfKRIr0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:26 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfKRIrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:25 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i8JT105412
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=CC5pMmhR3fLlSBHBHMRSzLwSOcojt0hvET6EKsUN6a8=;
 b=O7MZmSkxyHH5FIB5HmgsVAFFL2KjqOm+Bi/bMJSyj4kOXM+H83CHw1ebp90ee1RKKOtl
 6a+7LMDRYwYtM2p2b1E7NrqOSXK71kovD5t4vkzbWBNY1YvfGSaYgkb0nhBjUtbf2xHM
 iZLcM9T3bnDpXR9QtnITF7GI1W+uCGJ6bpzMBVEHcdf0kzq9XJqLhJzhPut/ieJob7Cg
 NCkFIi0UjfmukqEVrFXzCv6GECIWdvQ7FoUDP0N7ujE2/WMhZ0MQYg0L+5/4fXdQFPQY
 JelfCTqFGFEjihLVlWM4pk7LcRsVW68HbGOrfyjEwQ/RM9PGaM8zVq/KB+qJ+LkZmfAz /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wa8htenru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8iME5091066
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2watjx33wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:23 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAI8lNKW018899
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:23 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:22 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/15] btrfs: volume, btrfs_free_stale_devices() cleanup unreachable code
Date:   Mon, 18 Nov 2019 16:46:51 +0800
Message-Id: <20191118084656.3089-11-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118084656.3089-1-anand.jain@oracle.com>
References: <20191118084656.3089-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs_devices::num_devices can be zero only in unmounted context, and we
don't have any fsid specific kobjects in the unmoutend context. So no
need to call btrfs_sysfs_remove_fsid() in btrfs_free_stale_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
We implemented this in preparation to provide the fsid/device attributes
for the devices in unmoutned context as was proposed here [1].

[1] [PATCH] btrfs: Introduce device pool sysfs attributes

 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 40d77b5846dc..fe135b5a8a03 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -585,7 +585,7 @@ static int btrfs_free_stale_devices(const char *path,
 		mutex_unlock(&fs_devices->device_list_mutex);
 
 		if (fs_devices->num_devices == 0) {
-			btrfs_sysfs_remove_fsid(fs_devices);
+			/* If its here fsid is unmounted */
 			list_del(&fs_devices->fs_list);
 			free_fs_devices(fs_devices);
 		}
-- 
2.23.0

