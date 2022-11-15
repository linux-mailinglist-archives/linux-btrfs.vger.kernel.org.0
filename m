Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3134E629E92
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbiKOQMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiKOQMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:12:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31301D65A;
        Tue, 15 Nov 2022 08:12:34 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBWM20HbjzqSMt;
        Wed, 16 Nov 2022 00:08:46 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH v4 2/3] btrfs: qgroup: introduce btrfs_update_quoto_limit() helper
Date:   Wed, 16 Nov 2022 01:17:08 +0800
Message-ID: <20221115171709.3774614-3-chenxiaosong2@huawei.com>
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

No functional changed. Just simplify the code.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/qgroup.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d0480b9c6c86..ca609a70d067 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1677,6 +1677,19 @@ int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
+static int btrfs_update_quoto_limit(struct btrfs_trans_handle *trans,
+				    struct btrfs_qgroup *qgroup,
+				    struct btrfs_fs_info *fs_info)
+{
+	int ret = update_qgroup_limit_item(trans, qgroup);
+	if (ret) {
+		qgroup_mark_inconsistent(fs_info);
+		btrfs_info(fs_info, "unable to update quota limit for %llu",
+			   qgroup->qgroupid);
+	}
+	return ret;
+}
+
 int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 		       struct btrfs_qgroup_limit *limit)
 {
@@ -1742,13 +1755,7 @@ int btrfs_limit_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid,
 
 	spin_unlock(&fs_info->qgroup_lock);
 
-	ret = update_qgroup_limit_item(trans, qgroup);
-	if (ret) {
-		qgroup_mark_inconsistent(fs_info);
-		btrfs_info(fs_info, "unable to update quota limit for %llu",
-		       qgroupid);
-	}
-
+	ret = btrfs_update_quoto_limit(trans, qgroup, fs_info);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	return ret;
@@ -2824,9 +2831,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		ret = update_qgroup_info_item(trans, qgroup);
 		if (ret)
 			qgroup_mark_inconsistent(fs_info);
-		ret = update_qgroup_limit_item(trans, qgroup);
-		if (ret)
-			qgroup_mark_inconsistent(fs_info);
+		ret = btrfs_update_quoto_limit(trans, qgroup, fs_info);
 		spin_lock(&fs_info->qgroup_lock);
 	}
 	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
@@ -2953,14 +2958,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		dstgroup->rsv_rfer = inherit->lim.rsv_rfer;
 		dstgroup->rsv_excl = inherit->lim.rsv_excl;
 
-		ret = update_qgroup_limit_item(trans, dstgroup);
-		if (ret) {
-			qgroup_mark_inconsistent(fs_info);
-			btrfs_info(fs_info,
-				   "unable to update quota limit for %llu",
-				   dstgroup->qgroupid);
+		ret = btrfs_update_quoto_limit(trans, dstgroup, fs_info);
+		if (ret)
 			goto unlock;
-		}
 	}
 
 	if (srcid) {
-- 
2.31.1

