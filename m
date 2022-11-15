Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC5F629E90
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbiKOQMm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiKOQMi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:12:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B2264AE;
        Tue, 15 Nov 2022 08:12:36 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBWMp0BVszJnlH;
        Wed, 16 Nov 2022 00:09:26 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 00:12:33 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 00:12:32 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <yanaijie@huawei.com>, <quwenruo.btrfs@gmx.com>, <wqu@suse.com>
Subject: [PATCH v4 3/3] btrfs: qgroup: fix sleep from invalid context bug in update_qgroup_limit_item()
Date:   Wed, 16 Nov 2022 01:17:09 +0800
Message-ID: <20221115171709.3774614-4-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
References: <20221115171709.3774614-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Fix this by delaying the limit item updates until unlock the spin lock.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/qgroup.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ca609a70d067..f84507ca3b99 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2867,6 +2867,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
+	bool update_limit = false;
+	int err;
 
 	/*
 	 * There are only two callers of this function.
@@ -2957,10 +2959,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = inherit->lim.max_excl;
 		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
 		dstgroup->rsv_excl = inherit->lim.rsv_excl;
-
-		ret = btrfs_update_quoto_limit(trans, dstgroup, fs_info);
-		if (ret)
-			goto unlock;
+		update_limit = true;
 	}
 
 	if (srcid) {
@@ -2987,6 +2986,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->max_excl = srcgroup->max_excl;
 		dstgroup->rsv_rfer = srcgroup->rsv_rfer;
 		dstgroup->rsv_excl = srcgroup->rsv_excl;
+		update_limit = false;
 
 		qgroup_dirty(fs_info, dstgroup);
 		qgroup_dirty(fs_info, srcgroup);
@@ -3055,6 +3055,11 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 unlock:
 	spin_unlock(&fs_info->qgroup_lock);
+	if (update_limit) {
+		err = btrfs_update_quoto_limit(trans, dstgroup, fs_info);
+		if (err)
+			ret = err;
+	}
 	if (!ret)
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, dstgroup);
 out:
-- 
2.31.1

