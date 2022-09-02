Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8E05AB958
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIBURa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiIBURZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:25 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78E7D275F
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id j17so2334402qtp.12
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=wZ6OuK2NAfOCeUPYTZ/OlS83L37BSn6t4Gct7rDvXrs=;
        b=W+84fnggCxY8RQEeAvhBpXlAQcoDM1VnZUAxHfS8emxY6DifxdsvsPOJYelhEuJLtN
         FhkUjfZ5wnLWfGmPlFQJNzXy53D9r7VyZLQfwyrqKfbGp2VvVf0ae6csgsbVy+XekCgH
         VBcrGRmUXA7KJx89o+HP32k7rTSeFfprGADOG1ZFT4/sRya+SiVCDpPUbLZ9Yd42B6+i
         eoOmj/UjUO7T+M7Nc5lEdIISU4G19BioEh42zfDvMiMgYSKCvEq7y1zqGRFflvLHT31B
         dbBNaYgj0xz1SREXQrf9f4M67/d9WY+Nv+f3HSX1BSNpQjZrAcPOv20kAvVIexpLabAD
         vb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wZ6OuK2NAfOCeUPYTZ/OlS83L37BSn6t4Gct7rDvXrs=;
        b=J58em2ckq0e6nnV57bwjGZ3+GjO2rjH9lVVAgLwTQO1uB4du05jM9azDZ3Y+MzEp2h
         eBPkNOZhBpRZwqEzIrL0GwATTLGBP2vnYv1yHuNNAFu/DfL5/YTK6/qg1ERlWw64Kd7M
         l6DlhEL8ZSg6qWbEUwvl8RDiwSOts35zWbLWVrR/xRLJJuDk3vR99OfPgK9ypyCkdQ8G
         a+GzTTcWTziOhH+LcrK+Fu9yVj7mq/rSbd3ObSQBeMSnc8QrK49E2htn/JSfGZyKywmu
         qDOwIqilNWn3XSw3NAXBJaKV+BYM00/LhCXgDL8v7Di6RkKpJ3Wl8BtGFCrl7jjZ4hhR
         ZUGQ==
X-Gm-Message-State: ACgBeo2yWQqmOi4lFKd6Tm3w8BSDOGnYQDgbj+pPqW0Whbs4PIlqi1fU
        EKbs8tkxM8RRF7VZbfaX3cIKf5BVWn/L9w==
X-Google-Smtp-Source: AA6agR79pNTirA+30f7F6Mx58AbE9d0l1NHXX56vZsDqTRd3nrnKMz+x0eNcIcyYoWO3akTKnad9yw==
X-Received: by 2002:a05:622a:14d1:b0:344:b14a:b22a with SMTP id u17-20020a05622a14d100b00344b14ab22amr28989471qtx.203.1662149843975;
        Fri, 02 Sep 2022 13:17:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a248b00b006bb29d932e1sm2193407qkn.105.2022.09.02.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 26/31] btrfs: get rid of track_uptodate
Date:   Fri,  2 Sep 2022 16:16:31 -0400
Message-Id: <e6f0ab425f44e63a22cb1c469b754292a91bf160.1662149276.git.josef@toxicpanda.com>
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

This is no longer used anymore, remove it from the extent_io_tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c        | 1 -
 fs/btrfs/extent-io-tree.h | 1 -
 fs/btrfs/inode.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6ec87bed8194..af073af8131e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2232,7 +2232,6 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
 	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
 			    IO_TREE_BTREE_INODE_IO, inode);
-	BTRFS_I(inode)->io_tree.track_uptodate = false;
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index aa0314f6802c..37543fb713bd 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -70,7 +70,6 @@ struct extent_io_tree {
 	struct btrfs_fs_info *fs_info;
 	void *private_data;
 	u64 dirty_bytes;
-	bool track_uptodate;
 
 	/* Who owns this io tree, should be one of IO_TREE_* */
 	u8 owner;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 39230a6435c7..b21387ea5e97 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8914,7 +8914,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT, inode);
 	ei->io_failure_tree = RB_ROOT;
-	ei->io_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
-- 
2.26.3

