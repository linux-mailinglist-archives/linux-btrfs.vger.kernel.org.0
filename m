Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E985C256EBE
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgH3OnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:43:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58732 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgH3Olp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEYmf0032358;
        Sun, 30 Aug 2020 14:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=H3EOkwNFm9oFkNO+nNZ75CSKNMMZzmAIjZWaT3m23nQ=;
 b=esB+i0YgaWwnEzRy6rLwX5LJ9jpv32UGbyiZF3h61CZbKcxcyJjNqaYDdGoPoW+KY3Ez
 0fweTLjlP+Gg6DdaexkBsnpQ3KNDbPTeppzrNJs3QLj5Fh9bmhuS7BR0yCKrEAOOmpre
 RZVLd7iO+lVJCNAhMT0elw8lRaf6+1WjWjAZMcaUfgbxTSAYIR+jOvg+Ox++QuDdckXw
 YkYO+yA6c9dcfNmxpReEVGwqOSGzfgw479wzVRh0qznWqVUpgWSjH/v3bVxHuVg4JJ3d
 IsSCvpkaLaf6MWPpNnWdvMku6+Awbk01WBk0rQ+upfX1Airq0YK0fBmjaK2zko5l86BJ fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eeqk0rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEaTf2161198;
        Sun, 30 Aug 2020 14:41:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3380wwrxp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:39 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfbND030256;
        Sun, 30 Aug 2020 14:41:38 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:37 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 09/11] btrfs: cleanup unnecessary goto in open_seed_device
Date:   Sun, 30 Aug 2020 22:41:04 +0800
Message-Id: <01f5b4aff8196b929bf00a81f5b8c27001d7f056.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=3 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

open_seed_devices() does goto to just return. So drop goto and just return
instead.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c8b0d9eb4468..dc81646b13c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6741,19 +6741,17 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
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

