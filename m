Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595D85B41D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiIIVyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiIIVyi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:38 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72DDF09
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:37 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g16so2201418qkl.11
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=RTkD+qbae4uFlT0kEygAF/P6qE9mHsq/YnBnP/cR3tA=;
        b=k5cZayDbY2FINcOpKIteE2+wjOjO7HWGoatzWL44XiLwFZLUAWZgUMyA5UOWPrhUWd
         zt4g9vlZtCXt+heqDn1bi9NspZvOU8C4HpVpLnqEoShrsdc0roxbpUx2H4EaltGXt/dD
         OtWNC5eOM4Ds263WbUF/hbIHG7B4s7DnPwfi7C9cuUiSxWT/4N+sv2Imeq32vKwjyl33
         Stv0Mru8RAUGfW96BFbnctSbG9ffAB/YRL2iLzGFssIZ1tV0kX5IhX2hx1kgXgpVwKdD
         STZh1pSWXr3L7cbqZTQf/lwC2RJh4IKRplO4gRD/vlbwh9gpXIrEERsaUnL+OW8wG0ie
         361w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RTkD+qbae4uFlT0kEygAF/P6qE9mHsq/YnBnP/cR3tA=;
        b=Q04XafilH4t2TxczL90a+Ivk28QCx/eaKGX+WKeLqReHmdZVy7ARBMTQn+M2EIBbFZ
         afsDWRZyve1ik/ZG3+NFm4DP74zxep3n85BA7x9nbkuxZmxrWe8QnBilUH8ry1uJCs6X
         VCXJA+88fAgdOSaz7959qRBnsjtMLNNXUZnVhTK0AfTKFEDFWCICzQ9FYVayCWAqN+nd
         GFpfu+kJrFJNAyXSWO4iqtV0bT/KPHCbzT/4w5cfkCQO6FUBZE84UHtaStMy/fO4ATKe
         GKuUIdfmjEPhGQ35SvtwbpgWrtYrhn99nveKmmOZibVt/GSOVH4La7+MGEaQgs9y+vNW
         51ow==
X-Gm-Message-State: ACgBeo3VF7mFIFJXjCX/wl7bb/q4Jz7KXY+tMRaglPXDf0BaxmLOP7xl
        KN5Z5McDKJTUxi0u3A8t+D9UCVMqx0Bf9g==
X-Google-Smtp-Source: AA6agR4E67YIKDszHP4iqX3kr2QNS64OrsLJz5JChNuAYOE1y98gIzMj4rt4Kr7eSreKX525wwARog==
X-Received: by 2002:a05:620a:2685:b0:6bc:374a:8f44 with SMTP id c5-20020a05620a268500b006bc374a8f44mr11734592qkp.165.1662760476606;
        Fri, 09 Sep 2022 14:54:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w28-20020a05622a191c00b0034454aff529sm1127005qtc.80.2022.09.09.14.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 31/36] btrfs: remove extent_io_tree::track_uptodate
Date:   Fri,  9 Sep 2022 17:53:44 -0400
Message-Id: <3d4ea0d498f6389292fb435d5d461f4120579e84.1662760286.git.josef@toxicpanda.com>
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

Since

btrfs: remove unnecessary EXTENT_UPTODATE state in buffered I/O path

we no longer check ->track_uptodate, remove it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c        | 1 -
 fs/btrfs/extent-io-tree.h | 1 -
 fs/btrfs/inode.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0bb0c496a023..eedb39d89be5 100644
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
index 7519233b922f..c417bbc29986 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8805,7 +8805,6 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT, inode);
 	ei->io_failure_tree = RB_ROOT;
-	ei->io_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
-- 
2.26.3

