Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421E962BD37
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 13:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiKPMJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbiKPMJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 07:09:00 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D2730F46;
        Wed, 16 Nov 2022 04:02:43 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NC1rD3GWXz15Mjl;
        Wed, 16 Nov 2022 20:02:20 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 20:02:42 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 20:02:41 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <yanaijie@huawei.com>, <quwenruo.btrfs@gmx.com>, <wqu@suse.com>
Subject: [PATCH v5 0/2] btrfs: fix sleep from invalid context bug in update_qgroup_limit_item()
Date:   Wed, 16 Nov 2022 21:07:14 +0800
Message-ID: <20221116130716.991901-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Fix this by calling qgroup_dirty() on @dstqgroup, and update limit item in
btrfs_run_qgroups() later.

By the way, add might_sleep() to btrfs_search_slot().

ChenXiaoSong (2):
  btrfs: add might_sleep() to btrfs_search_slot()
  btrfs: qgroup: fix sleep from invalid context bug in
    update_qgroup_limit_item()

 fs/btrfs/ctree.c  |  2 ++
 fs/btrfs/qgroup.c | 29 ++++++++++++-----------------
 2 files changed, 14 insertions(+), 17 deletions(-)

-- 
2.31.1

