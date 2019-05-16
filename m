Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2B2064A
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 13:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfEPLtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 07:49:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbfEPLti (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 07:49:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A9CDAEF5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 11:49:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E3612DA86C; Thu, 16 May 2019 13:50:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: detect fast implementation of crc32c on all architectures
Date:   Thu, 16 May 2019 13:50:28 +0200
Message-Id: <20190516115028.13327-1-dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, there's only check for fast crc32c implementation on X86,
based on the CPU flags. This is used to decide if checksumming should be
offloaded to worker threads or can be calculated by the caller.

As there are more architectures that implement a faster version of
crc32c (ARM, SPARC, s390, MIPS, PowerPC), also there are specialized hw
cards.

The detection is based on driver name, all generic C implementations
contain 'generic', while the specialized versions do not. Alternatively
the priority could be used, but this is not currently provided by the
crypto API.

The flag is set per-filesystem at mount time and used for the offloading
decisions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h   |  6 ++++++
 fs/btrfs/disk-io.c | 13 ++++---------
 fs/btrfs/super.c   |  2 ++
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b81c331b28fa..d1489294aff0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -791,6 +791,12 @@ enum {
 
 	/* Indicate that the cleaner thread is awake and doing something. */
 	BTRFS_FS_CLEANER_RUNNING,
+
+	/*
+	 * The checksumming has an optimized version and is considered fast,
+	 * so we don't need to offload checksums to workqueues.
+	 */
+	BTRFS_FS_CSUM_IMPL_FAST,
 };
 
 struct btrfs_fs_info {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 663efce22d98..01f8bab351e2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -40,10 +40,6 @@
 #include "tree-checker.h"
 #include "ref-verify.h"
 
-#ifdef CONFIG_X86
-#include <asm/cpufeature.h>
-#endif
-
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
 				 BTRFS_SUPER_FLAG_ERROR |\
@@ -873,14 +869,13 @@ static blk_status_t btree_submit_bio_start(void *private_data, struct bio *bio,
 	return btree_csum_one_bio(bio);
 }
 
-static int check_async_write(struct btrfs_inode *bi)
+static int check_async_write(struct btrfs_fs_info *fs_info,
+			     struct btrfs_inode *bi)
 {
 	if (atomic_read(&bi->sync_writers))
 		return 0;
-#ifdef CONFIG_X86
-	if (static_cpu_has(X86_FEATURE_XMM4_2))
+	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
 		return 0;
-#endif
 	return 1;
 }
 
@@ -889,7 +884,7 @@ static blk_status_t btree_submit_bio_hook(struct inode *inode, struct bio *bio,
 					  unsigned long bio_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	int async = check_async_write(BTRFS_I(inode));
+	int async = check_async_write(fs_info, BTRFS_I(inode));
 	blk_status_t ret;
 
 	if (bio_op(bio) != REQ_OP_WRITE) {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2c66d9ea6a3b..ef974ba4edad 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1553,6 +1553,8 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
 		btrfs_sb(s)->bdev_holder = fs_type;
+		if (!strstr(crc32c_impl(), "generic"))
+			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
-- 
2.21.0

