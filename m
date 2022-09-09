Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27165B41D9
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIIVyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbiIIVyn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED79564D9
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r20so1646086qtn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=R6sSghnkFEtwnvrI7PXxc4RCmgEq1lnqxgHI5XM24Zk=;
        b=wrgw1oEowKgJdOsqUBlL/YGqan0tO/yxepaHisWxfcoF6AhDPqlTsBPSJalmIvze3r
         1Q1Tz5o5VD6CEID4U7J38jAC6wjCUEizltb7syO8RBzSGlsSW4oC/4D4yJ+JIiApCdG2
         t10kRcRTtPKkiLHmyjv1QHRKE+ImCSPOrZfjlfOIizv5Jt939mIGiIgjr5oi0fwg3SZM
         y3jcisBWec5JtqGiwdDSwSsVAnaK+RCAZd9L5qpimX2yL8amck7a8fX8g9XUDsFP2TXC
         FNEvQ/3LFXeuuTTYBbdGDB3hj8oTTZsSBJb+HQCmliroWEvZJyRfpBd+VymPhVOJACRF
         IZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=R6sSghnkFEtwnvrI7PXxc4RCmgEq1lnqxgHI5XM24Zk=;
        b=xjfsUdRMGrAEJSELL1QzC59MiSJ9bGjgjwsT5E5KbSwMpFtBjQiafCEitvITNA/DUq
         wfsZrb6VR70PXYnkpdNXmXGTrajjnMs0Hgb1jsmQ/Winr7so68y/ZrhtjBwBodA6ErLs
         YCGj7THo4J0/nBNuGEAgp9fRkhTlm0vqezumUV7m74ZG99fC3uhgfDiYmfstQI9wMcMD
         drKzGD4p9U2MALrmkssBKNskDUKlYPsXhU2idn1bdaMHuFadhLMYDro384wVMZ9b6mjO
         H8PFAFcZh7jLqaEjnZW9010nDcRsI6DW/t84gMH4MCUEhUdQjzlnzpxRBYJ/fTv3i/h5
         uJEw==
X-Gm-Message-State: ACgBeo01YW5dTKpZSdk58hBToQsR3AOUTcvbCOBvBWtLNH8zE434bjgt
        WDRGcoNLbyKL1D4wIuEthJ9TSAM59OOSLQ==
X-Google-Smtp-Source: AA6agR5AHnPnwKJm1lr7ZaDSO5Jzmp+/DuqpGBizlqrRodyELTNULcOzAI45SifgOWZSbXParsJFqg==
X-Received: by 2002:ac8:5a11:0:b0:35b:a2ec:2b73 with SMTP id n17-20020ac85a11000000b0035ba2ec2b73mr3539979qta.364.1662760482298;
        Fri, 09 Sep 2022 14:54:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b006b5e50057basm1502671qkp.95.2022.09.09.14.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 35/36] btrfs: don't init io tree with private data for non inodes
Date:   Fri,  9 Sep 2022 17:53:48 -0400
Message-Id: <f4f1e82ca38975398ba348fbab6eb50a9597aa34.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only use this for normal inodes, so don't set it if we're not a
normal inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c     | 2 +-
 fs/btrfs/inode.c       | 2 +-
 fs/btrfs/transaction.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index eedb39d89be5..db8212cc1d2e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2231,7 +2231,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
-			    IO_TREE_BTREE_INODE_IO, inode);
+			    IO_TREE_BTREE_INODE_IO, NULL);
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39f00b68b3a8..6fde13f62c1d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8800,7 +8800,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_map_tree_init(&ei->extent_tree);
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
-			    IO_TREE_INODE_FILE_EXTENT, inode);
+			    IO_TREE_INODE_FILE_EXTENT, NULL);
 	ei->io_failure_tree = RB_ROOT;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index d9d770a9b1a3..d1f1da6820fb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -365,7 +365,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&cur_trans->releasing_ebs_lock);
 	list_add_tail(&cur_trans->list, &fs_info->trans_list);
 	extent_io_tree_init(fs_info, &cur_trans->dirty_pages,
-			IO_TREE_TRANS_DIRTY_PAGES, fs_info->btree_inode);
+			IO_TREE_TRANS_DIRTY_PAGES, NULL);
 	extent_io_tree_init(fs_info, &cur_trans->pinned_extents,
 			IO_TREE_FS_PINNED_EXTENTS, NULL);
 	fs_info->generation++;
-- 
2.26.3

