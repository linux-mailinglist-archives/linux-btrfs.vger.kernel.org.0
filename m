Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0E1504C8
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 12:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgBCLAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 06:00:25 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50932 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBCLAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 06:00:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013ArsZ2018023;
        Mon, 3 Feb 2020 11:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=8r9ONH+cvqJkISB6j5xTjK+HCEM/Kf0vNke7MZe4eho=;
 b=L/6Ar669xVsgKMyy9NpWprsSpGv+T48fTXYzxBn0a/2YU+TiznZOgK5jKthAbNYJVdiH
 tOvKu3rF6KNRBdmFT7hzP2YXc2itzyY5tczHUBRw55Qi6cgLHn0ysnxmtxFog8jipnh7
 QZepGdnM2bNH3vf0SRRSagX5G/QnlOYvtwScnicHT8aMkpJt/AQFBHGd9hPzaaC3gjgB
 cQRZH1vvNUIPTXMrWQ6Nz/qqizTO1qRpcX0t6MaJiJsaf86C7BWlBohNkQKDM4yG69zE
 ewwkCLeB5SuCJ+0EaziiLWuha4O7aqVoe+iad8BsvDgc5V2Nk5qGxeHc5VRBYdFRgpf/ /w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xw0rty2b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 013ArkFO023906;
        Mon, 3 Feb 2020 11:00:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2xwkg8h69h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Feb 2020 11:00:19 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 013B0JIe006998;
        Mon, 3 Feb 2020 11:00:19 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Feb 2020 03:00:18 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH resend 1/4] btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
Date:   Mon,  3 Feb 2020 19:00:09 +0800
Message-Id: <20200203110012.5954-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200203110012.5954-1-anand.jain@oracle.com>
References: <20200203110012.5954-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002030083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9519 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002030083
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have one simple function btrfs_sysfs_remove_fsid() to cleanup
kobjects added by btrfs_sysfs_add_fsid() and calls kobject_put() and
kobject_delete() only if the kobject is initialized or not null.
So use this function while retreating in the function
btrfs_sysfs_add_fsid().

One difference though, earlier we did not call kobject_del() during
retreat in btrfs_sysfs_add_fsid() and I did experiment to figureout
if that's an error or warning, however I didn't notice any such issues
with or without kobject_del() not being called.

So this patch is just for cleanup.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 55e4ed1af29c..8def038dc2bd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1256,7 +1256,7 @@ int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs)
 	if (!fs_devs->devices_kobj) {
 		btrfs_err(fs_devs->fs_info,
 			  "failed to init sysfs device interface");
-		kobject_put(&fs_devs->fsid_kobj);
+		btrfs_sysfs_remove_fsid(fs_devs);
 		return -ENOMEM;
 	}
 
-- 
2.23.0

