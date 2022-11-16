Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C0062BD39
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 13:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiKPMJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 07:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiKPMJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 07:09:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E992EF76;
        Wed, 16 Nov 2022 04:02:45 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NC1r46bqdzHvwH;
        Wed, 16 Nov 2022 20:02:12 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:02:43 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 20:02:42 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <yanaijie@huawei.com>, <quwenruo.btrfs@gmx.com>, <wqu@suse.com>
Subject: [PATCH v5 2/2] btrfs: qgroup: fix sleep from invalid context bug in update_qgroup_limit_item()
Date:   Wed, 16 Nov 2022 21:07:16 +0800
Message-ID: <20221116130716.991901-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116130716.991901-1-chenxiaosong2@huawei.com>
References: <20221116130716.991901-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Syzkaller reported BUG as follows:

  BUG: sleeping function called from invalid context at
       include/linux/sched/mm.h:274
  Call Trace:
   <TASK>
   dump_stack_lvl+0xcd/0x134
   __might_resched.cold+0x222/0x26b
   kmem_cache_alloc+0x2e7/0x3c0
   update_qgroup_limit_item+0xe1/0x390
   btrfs_qgroup_inherit+0x147b/0x1ee0
   create_subvol+0x4eb/0x1710
   btrfs_mksubvol+0xfe5/0x13f0
   __btrfs_ioctl_snap_create+0x2b0/0x430
   btrfs_ioctl_snap_create_v2+0x25a/0x520
   btrfs_ioctl+0x2a1c/0x5ce0
   __x64_sys_ioctl+0x193/0x200
   do_syscall_64+0x35/0x80

Fix this by calling qgroup_dirty() on @dstqgroup, and update limit item in
btrfs_run_qgroups() later.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/qgroup.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9334c3157c22..8f5c52e24430 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2860,6 +2860,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
+	bool dirty_dstgrp = false;
 
 	/*
 	 * There are only two callers of this function.
@@ -2941,7 +2942,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	dstgroup = add_qgroup_rb(fs_info, objectid);
 	if (IS_ERR(dstgroup)) {
 		ret = PTR_ERR(dstgroup);
-		goto unlock;
+		goto dirty;
 	}
 
 	if (inherit && inherit->flags & BTRFS_QGROUP_INHERIT_SET_LIMITS) {
@@ -2950,21 +2951,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = inherit->lim.max_excl;
 		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
 		dstgroup->rsv_excl = inherit->lim.rsv_excl;
-
-		ret = update_qgroup_limit_item(trans, dstgroup);
-		if (ret) {
-			qgroup_mark_inconsistent(fs_info);
-			btrfs_info(fs_info,
-				   "unable to update quota limit for %llu",
-				   dstgroup->qgroupid);
-			goto unlock;
-		}
+		dirty_dstgrp = true;
 	}
 
 	if (srcid) {
 		srcgroup = find_qgroup_rb(fs_info, srcid);
 		if (!srcgroup)
-			goto unlock;
+			goto dirty;
 
 		/*
 		 * We call inherit after we clone the root in order to make sure
@@ -2985,20 +2978,20 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = srcgroup->max_excl;
 		dstgroup->rsv_rfer = srcgroup->rsv_rfer;
 		dstgroup->rsv_excl = srcgroup->rsv_excl;
+		dirty_dstgrp = true;
 
-		qgroup_dirty(fs_info, dstgroup);
 		qgroup_dirty(fs_info, srcgroup);
 	}
 
 	if (!inherit)
-		goto unlock;
+		goto dirty;
 
 	i_qgroups = (u64 *)(inherit + 1);
 	for (i = 0; i < inherit->num_qgroups; ++i) {
 		if (*i_qgroups) {
 			ret = add_relation_rb(fs_info, objectid, *i_qgroups);
 			if (ret)
-				goto unlock;
+				goto dirty;
 		}
 		++i_qgroups;
 
@@ -3022,7 +3015,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		if (!src || !dst) {
 			ret = -EINVAL;
-			goto unlock;
+			goto dirty;
 		}
 
 		dst->rfer = src->rfer - level_size;
@@ -3043,15 +3036,17 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		if (!src || !dst) {
 			ret = -EINVAL;
-			goto unlock;
+			goto dirty;
 		}
 
 		dst->excl = src->excl + level_size;
 		dst->excl_cmpr = src->excl_cmpr + level_size;
 		need_rescan = true;
 	}
+dirty:
+	if (dirty_dstgrp)
+		qgroup_dirty(fs_info, dstgroup);
 
-unlock:
 	spin_unlock(&fs_info->qgroup_lock);
 	if (!ret)
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
-- 
2.31.1

