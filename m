Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC93184DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 06:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhBKF0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 00:26:44 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57808 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBKF0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:31 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5OUt1032544;
        Thu, 11 Feb 2021 05:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=L9bW0YA0vUbkq6UHLgm/i1FjTeBMGWcflwqqE5oLFWc=;
 b=h15CswaDbBteF9svsmIeL8tJi/IVzW2BqC5C0ldsqeS1hB9Xu9/nxfGHcRGozNwsqLtW
 7n5QeTp/0T2+iW2uup8tXzp7lodS0zXYHhX+NmiwLdgsWZPY8VqY4wTod1lWQ729HHWr
 4vUVpV/JL1GQ0rGjlYmZPgEzxxjj6RqZ4bWp/CZK4CncPfJezm9OUdSg7vjWkGXfiAM4
 pZBBNGFRK/W0Svt3Mws/qLhzREbqNsZ4dPPPgcvw+Ufpd86TPlyHD5bek0G9pxGdsRb9
 08IVNrt7Q94FDl5WwO/96WXpFX6aN6CHOWSezS5qB+kQGKKqUfYcuCnvmgTVOWolCMoM 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmap6mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5K2P3103300;
        Thu, 11 Feb 2021 05:25:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 36j4pr1u14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:35 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11B5PZQ3023673;
        Thu, 11 Feb 2021 05:25:35 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 21:25:35 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 2/5] btrfs: btrfs_extent_readonly() change return type to bool
Date:   Wed, 10 Feb 2021 21:25:16 -0800
Message-Id: <3c0e3bc3fa0577bded592b37d281e8fd27a8f779.1613019838.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613019838.git.anand.jain@oracle.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110044
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_extent_readonly() checks if the bg is readonly, the bool return type
will suffice its need.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2ed7d736e39a..ebb2b8e3a71c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7256,14 +7256,14 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	return em;
 }
 
-static int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
+static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 {
 	struct btrfs_block_group *block_group;
-	int readonly = 0;
+	bool readonly = false;
 
 	block_group = btrfs_lookup_block_group(fs_info, bytenr);
 	if (!block_group || block_group->ro)
-		readonly = 1;
+		readonly = true;
 	if (block_group)
 		btrfs_put_block_group(block_group);
 	return readonly;
-- 
2.27.0

