Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86F62BF3D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiKPNTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 08:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiKPNTg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 08:19:36 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC172126B;
        Wed, 16 Nov 2022 05:19:35 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NC3Xv1Dpfz15MjQ;
        Wed, 16 Nov 2022 21:19:11 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 21:19:32 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 21:19:31 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <yanaijie@huawei.com>, <quwenruo.btrfs@gmx.com>, <wqu@suse.com>
Subject: [PATCH v6 1/2] btrfs: add might_sleep() to some places in update_qgroup_limit_item()
Date:   Wed, 16 Nov 2022 22:23:53 +0800
Message-ID: <20221116142354.1228954-2-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116142354.1228954-1-chenxiaosong2@huawei.com>
References: <20221116142354.1228954-1-chenxiaosong2@huawei.com>
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

At least 3 places might sleep in update_qgroup_limit_item(), as shown below:

  update_qgroup_limit_item
    btrfs_alloc_path
      /* allocate memory non-atomically, might sleep */
      kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS)
    btrfs_search_slot
      setup_nodes_for_search
        reada_for_balance
          btrfs_readahead_node_child
            btrfs_readahead_tree_block
              btrfs_find_create_tree_block
                alloc_extent_buffer
                  kmem_cache_zalloc
                    /* allocate memory non-atomically, might sleep */
                    kmem_cache_alloc(GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO)
              read_extent_buffer_pages
                submit_extent_page
                  /* disk IO, might sleep */
                  submit_one_bio

As the potential sleeping under spin lock is hard to spot, we should add
might_sleep() to btrfs_alloc_path() and btrfs_search_slot().

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/btrfs/ctree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a9543f01184c..1cd0d00ef328 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -78,6 +78,8 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
 
 struct btrfs_path *btrfs_alloc_path(void)
 {
+	might_sleep();
+
 	return kmem_cache_zalloc(btrfs_path_cachep, GFP_NOFS);
 }
 
@@ -1934,6 +1936,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	int min_write_lock_level;
 	int prev_cmp;
 
+	might_sleep();
+
 	lowest_level = p->lowest_level;
 	WARN_ON(lowest_level && ins_len > 0);
 	WARN_ON(p->nodes[0] != NULL);
-- 
2.31.1

