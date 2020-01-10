Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA61366F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2020 06:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgAJFxr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jan 2020 00:53:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgAJFxr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jan 2020 00:53:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A5rV6F061680;
        Fri, 10 Jan 2020 05:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=MkjSvIHjLv3UNiv06QmAbTx3jAhnOrgrWpp0oQIOsbY=;
 b=n3dkZ6FZ4COe/jO5ecgjKy0f324NMNkN6tLnLtuAN9W9lC+uP0cqunD1mgrsi/elkPoh
 SYXMlS2/2Lqmlvsc803vS3Q+KbJzE+5zMUkOx79ykhX+2hmPDtfvWUVa3QmxJEJm5OQ3
 YxU9jq3rlvNQdcMD1dOmcBABBny+FHmaE6RTPTQT19USPR6rNfYn3ZTkT+/mQ+y0snUT
 pzJh/g59CQYPCyDFvgkXGxeB7IbLDfH5jpYeP2Q1sedPUeQc+dV5UQanT3+IF/5hu96G
 8PGORynQfMohUMPVDWSWotwwa/a/8nBrnseIyWsPbstoFYJd5iWkcFlb4DRwtlPahIvT 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xakbr7qwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 05:53:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A5nGnk023059;
        Fri, 10 Jan 2020 05:51:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xeh8yycd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 05:51:38 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00A5paTj028737;
        Fri, 10 Jan 2020 05:51:37 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jan 2020 21:51:36 -0800
Date:   Fri, 10 Jan 2020 08:51:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Mason <clm@fb.com>, Dennis Zhou <dennis@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] btrfs: Fix error code in btrfs_sysfs_add_mounted()
Message-ID: <20200110055126.4rhhfsotll6puma7@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100050
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The error code wasn't set on this error path.

Fixes: e12ebce8a4a8 ("btrfs: sysfs: make UUID/debug have its own kobject")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/btrfs/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 58486229be95..55e4ed1af29c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1288,8 +1288,10 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 
 #ifdef CONFIG_BTRFS_DEBUG
 	fs_info->debug_kobj = kobject_create_and_add("debug", fsid_kobj);
-	if (!fs_info->debug_kobj)
+	if (!fs_info->debug_kobj) {
+		error = -ENOMEM;
 		goto failure;
+	}
 
 	error = sysfs_create_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
 	if (error)
-- 
2.11.0

