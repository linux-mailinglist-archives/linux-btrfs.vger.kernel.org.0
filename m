Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A2629E8D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiKOQMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiKOQMf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 11:12:35 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6951B1DF3E;
        Tue, 15 Nov 2022 08:12:34 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBWR15ZtrzRpGL;
        Wed, 16 Nov 2022 00:12:13 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 00:12:32 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 00:12:30 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <yanaijie@huawei.com>, <quwenruo.btrfs@gmx.com>, <wqu@suse.com>
Subject: [PATCH v4 1/3] btrfs: add might_sleep() to some places in update_qgroup_limit_item()
Date:   Wed, 16 Nov 2022 01:17:07 +0800
Message-ID: <20221115171709.3774614-2-chenxiaosong2@huawei.com>
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

As the potential sleeping under spin lock is hard to spot, we should add
might_sleep() to some places.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/ctree.c  | 2 ++
 fs/btrfs/qgroup.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a9543f01184c..809053e9cfde 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1934,6 +1934,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	int min_write_lock_level;
 	int prev_cmp;
 
+	might_sleep();
+
 	lowest_level = p->lowest_level;
 	WARN_ON(lowest_level && ins_len > 0);
 	WARN_ON(p->nodes[0] != NULL);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9334c3157c22..d0480b9c6c86 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -779,6 +779,8 @@ static int update_qgroup_limit_item(struct btrfs_trans_handle *trans,
 	int ret;
 	int slot;
 
+	might_sleep();
+
 	key.objectid = 0;
 	key.type = BTRFS_QGROUP_LIMIT_KEY;
 	key.offset = qgroup->qgroupid;
-- 
2.31.1

