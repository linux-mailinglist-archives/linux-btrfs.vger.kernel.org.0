Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76405AB950
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiIBURi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiIBURc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76A9D86D4
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a15so2615865qko.4
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=Rlh8wzxy9xEB0pARSrW1TZQUkqNBeT0gPM+yrEwJAvE=;
        b=0YRjCo96j0Tqx2jS8s6jfSmzbHVY3RXnNJTOaV6pyIKs+mrgvViwv4R+Wm1YoP/f0G
         aX5deHc9kxJbv85KpJidZbAoqOCPTBproC8K6KVBX5GFV45Ny+NTextxlCNTr5+AFgl5
         thTPUZYFw323WM07ZyreeSFzuIvi3JEvV4e4mHjUDQdAnkRfDRGaV1nSn4H/KdpDPjHf
         7mW4nrDJ6bImnc8z/bQoBGYura/40ncioEDqHsuo7Df7BcmXWzn0W6Ja2Lm7PAzRNnqs
         JLGNsprYTMq2a7UtP/lDEJjfhbFkpetd7k2ln+GPIRyfRRHulQ5cgknOnmuRNRTafAcZ
         khkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Rlh8wzxy9xEB0pARSrW1TZQUkqNBeT0gPM+yrEwJAvE=;
        b=NmAyuvBk6M2zyFY56lu43mFe5XvwYSchOioNRYB1hnsoigWpbnsZWjSVJvx8TCNurx
         8/pLnkiJuf+Q40l0wXPvv39jJ/zF4OpaH2/O4vPDDVKGePuqWU4tQKs8ERv+5yAnXD40
         Vk/pySDNoVioILuPNrnIX35njMQYdjGt+16+ctGKjRg3kY2SggYL46K/75VtcibSE89s
         lqjQ8vFnv8Zm2JWI3VqZxU3L5rXVLISZEwg4Cs3WfqVFsOdj+BvL4GseO8oZrMA1p+4Y
         bRiHzMXKQHBHRg2eN0mEesoxyml4S4UIzYFm+d27+cfW23qXHyqAYRpipRVN+9cAMHZ1
         t5qw==
X-Gm-Message-State: ACgBeo3s9myzy6k6oElfQusRPrJQQwjv6gggo8DxAU691tTqepcHrCOV
        vyQbyCSPadTr+UiVIT7q45yI+V/X9rHbRw==
X-Google-Smtp-Source: AA6agR4jo2uuhlK1heaR8wEQA62zDChJBz6xSvKHjMMV/yL8lyM36jbtr4wKwRQcI5B+07LX8BA8jw==
X-Received: by 2002:a05:620a:1786:b0:6bb:387c:4e2a with SMTP id ay6-20020a05620a178600b006bb387c4e2amr24906435qkb.194.1662149850599;
        Fri, 02 Sep 2022 13:17:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q65-20020ae9dc44000000b006bb5cdd4031sm1921975qkf.40.2022.09.02.13.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 30/31] btrfs: don't init io tree with private data for non inodes
Date:   Fri,  2 Sep 2022 16:16:35 -0400
Message-Id: <bfa817c1aee9e13e56c27a46c9d6bac833363078.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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
index af073af8131e..0e4de8ed8d81 100644
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
index a394c3efabcd..f5bf276b32a4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8909,7 +8909,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_map_tree_init(&ei->extent_tree);
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
-			    IO_TREE_INODE_FILE_EXTENT, inode);
+			    IO_TREE_INODE_FILE_EXTENT, NULL);
 	ei->io_failure_tree = RB_ROOT;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 681404a5cd36..faa9602733c7 100644
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

