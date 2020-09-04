Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA825E0EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgIDRfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgIDRfa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HZENH141114;
        Fri, 4 Sep 2020 17:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=gOPfpp8kuPXjUXEDTtk45FWq3awR+9dhynrvJP9qzr0=;
 b=Am/IM10BePgJexRHcbEqtX0SZwVJbV2G4cdBeY8XOBuu6BgEoDp1qZF9U/SVZ9T6cHMS
 G4TJkaU5Ss6ArMx9g/RFJPjt9VK1wjSzIBzDEJAyp+K5WlbQ8zr2Q5Tc/9Smukr39Ul+
 QLQwL4to6KvuhSUoWfTjmAdES3LMwso85yWf1XNP2BLgwcoHull+GOHWUBaUnrqXIlul
 dIWhoWkBwq9o7sMeNVMJhqqcuh9uKjV1B4iW/p+mrQzdN/ZXry4WZKGgXVzi1SKFiFQX
 bvVjzB9tZM87tfcnTVD+WXe5FAzkpd7CgAszMGIfoZ83g9hpdEt4MBNqiu0GvUx/TAf9 yw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eerfrab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HVDeT171395;
        Fri, 4 Sep 2020 17:35:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33bhs4tcef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZNfV009035;
        Fri, 4 Sep 2020 17:35:23 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 15/16] btrfs: cleanup unnecessary goto in open_seed_device
Date:   Sat,  5 Sep 2020 01:34:35 +0800
Message-Id: <683ff62a8dde35ac2cccb7e407d12d3c21169f98.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=3 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_seed_devices() does goto to just return. So drop goto and just return
instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f2ade4af33fd..385fbd2b2d76 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6750,19 +6750,17 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	ret = open_fs_devices(fs_devices, FMODE_READ, fs_info->bdev_holder);
 	if (ret) {
 		free_fs_devices(fs_devices);
-		fs_devices = ERR_PTR(ret);
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	if (!fs_devices->seeding) {
 		close_fs_devices(fs_devices);
 		free_fs_devices(fs_devices);
-		fs_devices = ERR_PTR(-EINVAL);
-		goto out;
+		return ERR_PTR(-EINVAL);
 	}
 
 	list_add_tail(&fs_devices->seed_list, &fs_info->fs_devices->seed_list);
-out:
+
 	return fs_devices;
 }
 
-- 
2.25.1

