Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD11412F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgAQV1S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:27:18 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35490 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgAQV1R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:17 -0500
Received: by mail-qv1-f67.google.com with SMTP id u10so11385010qvi.2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xxIhevQYNDMNUwoMF6u3/EBg/Gh1IsymXYdN6NwTtvc=;
        b=v3MrxNz2N5dHcEnoKY9SEM5amO1W3RJ+hfsAgvL+JGExuyxEVy2OyIMkhKrWazipQj
         T92zWSS1l7IAqgo4XIioLmFdyvIiGDv2CLl8NbRXbwlirDTa6pSsD4uq38iyTWSXGNqJ
         4e9bBMlRDI4xbW0TQvA1+OMr7E6ZwYBbtBvj/4vFCWIYWEGQbC7r+00lkiwAhNPFt2kU
         11NmIaIjbYbibq4sJVw4kLCMsYXOMUFGccUd27z4pvtW6wHd/2BOGj96vrvDxsTdRSIt
         f0qGokBTRqhWOW1bDxgKnSmTFtebqzr5uPGsqvX4SKClXLyKFDVgYJMoNcxWWqEQpnt6
         q/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxIhevQYNDMNUwoMF6u3/EBg/Gh1IsymXYdN6NwTtvc=;
        b=nxXDW+ydORkckmmC904bF6FFZncuSBNVgzSQ3fItcnJdc2hj+bd1tuZkuHvrXMjqAv
         pigrpcwT48zEtqgKmA71mQoet+xfvJQiaKbqYsvGxUFkDuHLjJe1GslMt58MAQuW3AwK
         jKYA60OAkIitOWS3IxW6bakWOV7NAcG75Hy7f7z+di3/4bbmPz/BiN26n47owvig3yN/
         kzW4mCNGDkKWyuYZNBIvsh3GbMHN/TlTCpVlYtFf9G8LecR55dis/vycCy/1+vsB2z5f
         R9W4GE2Tfb+gAvXwaLnfB+9qYXIr2tik8v4D/qggyi4cX84eiZIyuwS6CIHJA4KZBKYa
         cMxQ==
X-Gm-Message-State: APjAAAVTrNs0E7Khh7/bqovRXTlT8qMfGLRDPeOg08Fd96wCq7z98NF+
        fcEO+C8rwkdmOQ5lp7s9U6GM02H/9RZfIQ==
X-Google-Smtp-Source: APXvYqxZmUAwoTFyy6F2Wo6YWfKELULM/DopzUrE3zVKFcCMryS7u/5V+JSCjzfbZmHNB8er2Bgb6w==
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr9791119qvt.54.1579296436166;
        Fri, 17 Jan 2020 13:27:16 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 124sm12266823qko.11.2020.01.17.13.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 41/43] btrfs: make the init of static elements in fs_info separate
Date:   Fri, 17 Jan 2020 16:26:00 -0500
Message-Id: <20200117212602.6737-42-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
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
 fs/btrfs/tests/btrfs-tests.c | 28 ++++------------------------
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b7e4313bdc6f..87bad959b1a5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2649,10 +2649,8 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
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
@@ -2696,7 +2694,6 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	atomic_set(&fs_info->reada_works_cnt, 0);
 	atomic_set(&fs_info->nr_delayed_iputs, 0);
 	atomic64_set(&fs_info->tree_mod_seq, 0);
-	fs_info->sb = sb;
 	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
 	fs_info->metadata_ratio = 0;
 	fs_info->defrag_inodes = RB_ROOT;
@@ -2722,9 +2719,6 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(&fs_info->async_reclaim_work);
 
-	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
-	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
-
 	spin_lock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->first_logical_byte = (u64)-1;
@@ -2769,6 +2763,15 @@ static int init_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
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
@@ -2833,7 +2836,7 @@ int __cold open_ctree(struct super_block *sb,
 	int clear_free_space_tree = 0;
 	int level;
 
-	ret = init_fs_info(fs_info, sb);
+	ret = init_mount_fs_info(fs_info, sb);
 	if (ret) {
 		err = ret;
 		goto fail;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 97e7ac474a52..2414d572bc9a 100644
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
index 8ce292a47634..8d5bb8dfed0d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1531,6 +1531,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		error = -ENOMEM;
 		goto error_sec_opts;
 	}
+	btrfs_init_fs_info(fs_info);
 
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
 	fs_info->super_for_commit = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 27f5b662d2cb..683381a692bc 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -120,6 +120,8 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 		kfree(fs_info);
 		return NULL;
 	}
+	INIT_LIST_HEAD(&fs_info->fs_devices->devices);
+
 	fs_info->super_copy = kzalloc(sizeof(struct btrfs_super_block),
 				      GFP_KERNEL);
 	if (!fs_info->super_copy) {
@@ -128,6 +130,8 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 		return NULL;
 	}
 
+	btrfs_init_fs_info(fs_info);
+
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
 
@@ -138,30 +142,6 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
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
-	INIT_LIST_HEAD(&fs_info->fs_devices->devices);
-	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
-	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[0],
-			    IO_TREE_FS_INFO_FREED_EXTENTS0, NULL);
-	extent_io_tree_init(fs_info, &fs_info->freed_extents[1],
-			    IO_TREE_FS_INFO_FREED_EXTENTS1, NULL);
-	extent_map_tree_init(&fs_info->mapping_tree);
-	fs_info->pinned_extents = &fs_info->freed_extents[0];
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 
 	test_mnt->mnt_sb->s_fs_info = fs_info;
-- 
2.24.1

