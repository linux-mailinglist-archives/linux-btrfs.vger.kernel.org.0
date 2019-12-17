Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B2912309D
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfLQPh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:57 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39497 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfLQPh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:57 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so7747793qtm.6
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r8rI8BNDVt3/Wqx6P7J8doYqgmZTOGmAzkX8CCpuHjU=;
        b=S9JymaUTpRFgEKanRcOdTYfkhMYknbGYqpsY3JPtYAK0dZ+v/uoGY2G/bxGGEkX5ag
         v9iWiMbzfKxpfKU9X+gZgDPlWIbQvXckIBGHV8hnM2tyjp65da1DO954sFVrNNslMW1J
         ia6bvQRPKYIwOsNXcPgI4IurJxPw9CRTnNf0+GUoTivLDKaXzSxAJydoVCTtQuInxewM
         KmywP19w55tjTdhJHqV4Bp20xena8FmES3BkDc0eUAzp5XCfy0N7SmjWX+WeFi4P1MLV
         zvD1MOqYU6xWUvn0y/Q4DuggSQj5Y4+XmctOhvda/Vk3jiivfUhxq6Uy31lps+7wrG6q
         R/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8rI8BNDVt3/Wqx6P7J8doYqgmZTOGmAzkX8CCpuHjU=;
        b=MDuv5WkbJXVBYUTEoNgo3O3yl1yBu3b+dnwAFuU7PuXj5EyST2qSF9jw71GJqG8GsM
         XHzT0bMBv6qaeEEtWpZqD1G8X6A5pmYipG6B03ZF+RQNkReEXIUBdCOkA/z/1zX2ZZhT
         PdIkxGA0u3kKmPRmVvRvlUs8j6ZqH+G+aUS08k8IDRHFMOh+dH4PxY6JbcTauH62+kN/
         UwQrFqcP8KxJaVjusUD9xR/Cqv34STS2qOvJggLwBCUOEFLd+NI6yTibH5y3cDWKSgB4
         nNJMJHUUFQKukZTsXpfemYswHDp6lgkIziC4dOdzndvyQsPwBbiT5MCPkQEejOEvMmnN
         TI9g==
X-Gm-Message-State: APjAAAW/FJt3mDXX5YCFGEQtc+if47qUJPRvuv/56V5WfPVT0SAuUOex
        NLQW1H21wNER41j+uuGrGIa2TEDSsUccaA==
X-Google-Smtp-Source: APXvYqx0MGSCRKKfLC7LZemW0CqWz96lVW0iJEA7RSuxIKWEhVnXN0ddttWlo94ah6O7eOkNHmxBHw==
X-Received: by 2002:aed:22c8:: with SMTP id q8mr5198362qtc.133.1576597075543;
        Tue, 17 Dec 2019 07:37:55 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id v5sm6637189qth.70.2019.12.17.07.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 43/45] btrfs: make the init of static elements in fs_info separate
Date:   Tue, 17 Dec 2019 10:36:33 -0500
Message-Id: <20191217153635.44733-44-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In adding things like eb leak checking and root leak checking there were
a lot of weird corner cases that come from the fact that

1) We do not init the fs_info until we get to open_ctree time in the
normal case and

2) The test infrastructure half-init's the fs_info for things that it
needs.

This makes it really annoying to make changes because you have to add
init in two different places, have special cases for testing fs_info's
that may not have certain things init'ed, and cases for fs_info's that
didn't make it to open_ctree and thus are not fully init'ed.

Fix this by extracting out the non-allocating init of the fs info into
it's own public function and use that to make sure we're all getting
consistent views of an allocated fs_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c           | 19 +++++++++++--------
 fs/btrfs/disk-io.h           |  1 +
 fs/btrfs/super.c             |  1 +
 fs/btrfs/tests/btrfs-tests.c | 24 ++----------------------
 4 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 90d4203818e5..991a6f518c0f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2646,10 +2646,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
-static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
+void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 {
-	int ret;
-
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
 	INIT_LIST_HEAD(&fs_info->trans_list);
@@ -2693,7 +2691,6 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	atomic_set(&fs_info->reada_works_cnt, 0);
 	atomic_set(&fs_info->nr_delayed_iputs, 0);
 	atomic64_set(&fs_info->tree_mod_seq, 0);
-	fs_info->sb = sb;
 	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
 	fs_info->metadata_ratio = 0;
 	fs_info->defrag_inodes = RB_ROOT;
@@ -2719,9 +2716,6 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(&fs_info->async_reclaim_work);
 
-	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
-	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
-
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->first_logical_byte = (u64)-1;
@@ -2765,6 +2759,15 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+}
+
+static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
+{
+	int ret;
+
+	fs_info->sb = sb;
+	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
+	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
 	ret = init_srcu_struct(&fs_info->subvol_srcu);
 	if (ret)
@@ -2829,7 +2832,7 @@ int __cold open_ctree(struct super_block *sb,
 	int clear_free_space_tree = 0;
 	int level;
 
-	err = init_fs_info(fs_info, sb);
+	err = init_mount_fs_info(fs_info, sb);
 	if (err)
 		goto fail;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 80a65a0d9d33..5467227f007d 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -39,6 +39,7 @@ static inline u64 btrfs_sb_offset(int mirror)
 struct btrfs_device;
 struct btrfs_fs_devices;
 
+void btrfs_init_fs_info(struct btrfs_fs_info *fs_info);
 int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 			   struct btrfs_key *first_key, u64 parent_transid);
 struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 80fea16cf34c..6681f3d99b14 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1510,6 +1510,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		error = -ENOMEM;
 		goto error_sec_opts;
 	}
+	btrfs_init_fs_info(fs_info);
 
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index e96321a20646..2bcef946d92a 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -107,6 +107,8 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 		return NULL;
 	}
 
+	btrfs_init_fs_info(fs_info);
+
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
 
@@ -117,28 +119,6 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 		return NULL;
 	}
 
-	spin_lock_init(&fs_info->buffer_lock);
-	spin_lock_init(&fs_info->qgroup_lock);
-	spin_lock_init(&fs_info->super_lock);
-	spin_lock_init(&fs_info->fs_roots_radix_lock);
-	spin_lock_init(&fs_info->tree_mod_seq_lock);
-	mutex_init(&fs_info->qgroup_ioctl_lock);
-	mutex_init(&fs_info->qgroup_rescan_lock);
-	rwlock_init(&fs_info->tree_mod_log_lock);
-	fs_info->running_transaction = NULL;
-	fs_info->qgroup_tree = RB_ROOT;
-	fs_info->qgroup_ulist = NULL;
-	atomic64_set(&fs_info->tree_mod_seq, 0);
-	INIT_LIST_HEAD(&fs_info->dirty_qgroups);
-	INIT_LIST_HEAD(&fs_info->dead_roots);
-	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
-	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
-	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[0],
-			    IO_TREE_FS_INFO_FREED_EXTENTS0, NULL);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[1],
-			    IO_TREE_FS_INFO_FREED_EXTENTS1, NULL);
-	fs_info->pinned_extents = &fs_info->freed_extents[0];
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 
 	test_mnt->mnt_sb->s_fs_info = fs_info;
-- 
2.23.0

