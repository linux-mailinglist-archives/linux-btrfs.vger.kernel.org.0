Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402323184DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 06:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBKF0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 00:26:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56440 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhBKF0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 00:26:31 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5PbPF174986;
        Thu, 11 Feb 2021 05:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=VFHEl0eVVe/SOuqIIYCFFsDLTlodFjUEXb8kQsFj2wA=;
 b=RYqK4resWP8WGYc4YJJjvDlWYQwn3mllmErzzrzrgNRNv0sizFWjs0ZSvzOeSzMDidmV
 3pXRoDqtKIZXU1gP6kN38mEeFQ01PhxaJDBHWoFT52eoocxSkX5JBB6ZrGD1/C3qDsja
 AJ46YuvUzxd3SCuotJfOXkw18efbx6ZH71w1BF8/T28EGBDljUxC2JrV8GAnZkm3RqNi
 BPB87alNX5zCDuO4VxuGBf+xTqtneVJIN2asevoaPBKh0Dj4o11Zgz6JQdl8APt+PzSl
 zd9PpmHoVWU128/IQUBWLBs+Rq54e79pm5XlmikjrsubJqTXyllXZX1hIVUws9tnukQO 3g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 36m4upvkg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11B5Ojas183273;
        Thu, 11 Feb 2021 05:25:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 36j4vtqjnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 05:25:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11B5PZen002069;
        Thu, 11 Feb 2021 05:25:35 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 21:25:34 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH 1/5] btrfs: make btrfs_extent_readonly() static
Date:   Wed, 10 Feb 2021 21:25:15 -0800
Message-Id: <91acc559ac0f1deee28410bb379b2a248c2b5204.1613019838.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1613019838.git.anand.jain@oracle.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110045
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_extent_readonly() is used by can_nocow_extent() in inode.c. So move
btrfs_extent_readonly() from extent-tree.c to inode.c and declare it as
static.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ctree.h       |  1 -
 fs/btrfs/extent-tree.c | 13 -------------
 fs/btrfs/inode.c       | 13 +++++++++++++
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 40ec3393d2a1..df9dfb322ab4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2691,7 +2691,6 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
-int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
 /*
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 78ad31a59e59..5e228d6ad63f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2490,19 +2490,6 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	return __btrfs_mod_ref(trans, root, buf, full_backref, 0);
 }
 
-int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct btrfs_block_group *block_group;
-	int readonly = 0;
-
-	block_group = btrfs_lookup_block_group(fs_info, bytenr);
-	if (!block_group || block_group->ro)
-		readonly = 1;
-	if (block_group)
-		btrfs_put_block_group(block_group);
-	return readonly;
-}
-
 static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6303034a7e7b..2ed7d736e39a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7256,6 +7256,19 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	return em;
 }
 
+static int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group *block_group;
+	int readonly = 0;
+
+	block_group = btrfs_lookup_block_group(fs_info, bytenr);
+	if (!block_group || block_group->ro)
+		readonly = 1;
+	if (block_group)
+		btrfs_put_block_group(block_group);
+	return readonly;
+}
+
 /*
  * Check if we can do nocow write into the range [@offset, @offset + @len)
  *
-- 
2.27.0

