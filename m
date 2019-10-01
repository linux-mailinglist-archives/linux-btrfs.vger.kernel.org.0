Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC716C3F27
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbfJAR5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 13:57:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:33228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731668AbfJAR5T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 13:57:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F180AF0B;
        Tue,  1 Oct 2019 17:57:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C53DDA88C; Tue,  1 Oct 2019 19:57:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: add __cold attribute to more functions
Date:   Tue,  1 Oct 2019 19:57:35 +0200
Message-Id: <244616cd0a823e44fcca051a569ff68e0c7dc29e.1569587835.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569587835.git.dsterba@suse.com>
References: <cover.1569587835.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The attribute can mark functions supposed to be called rarely if at all
and the text can be moved to sections far from the other code. The
attribute has been added to several functions already, this patch is
based on hints given by gcc -Wsuggest-attribute=cold.

The net effect of this patch is decrease of btrfs.ko by 1000-1300,
depending on the config options.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 4 ++--
 fs/btrfs/disk-io.h | 4 ++--
 fs/btrfs/super.c   | 2 +-
 fs/btrfs/volumes.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e335fa4c4d1d..04d86e11117b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2583,7 +2583,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int open_ctree(struct super_block *sb,
+int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options)
 {
@@ -3968,7 +3968,7 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 	return btrfs_commit_transaction(trans);
 }
 
-void close_ctree(struct btrfs_fs_info *fs_info)
+void __cold close_ctree(struct btrfs_fs_info *fs_info)
 {
 	int ret;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a6958103d87e..76f123ebb292 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -49,10 +49,10 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
-int open_ctree(struct super_block *sb,
+int __cold open_ctree(struct super_block *sb,
 	       struct btrfs_fs_devices *fs_devices,
 	       char *options);
-void close_ctree(struct btrfs_fs_info *fs_info);
+void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 843015b9a11e..3da35d8b21a3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -187,7 +187,7 @@ static struct ratelimit_state printk_limits[] = {
 	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
 };
 
-void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+void __cold btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 {
 	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
 	struct va_format vaf;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fed4c9fe2ea2..3fd89aee539d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2048,7 +2048,7 @@ static struct btrfs_device * btrfs_find_next_active_device(
  * where this function called, there should be always be another device (or
  * this_dev) which is active.
  */
-void btrfs_assign_next_active_device(struct btrfs_device *device,
+void __cold btrfs_assign_next_active_device(struct btrfs_device *device,
 				     struct btrfs_device *this_dev)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
-- 
2.23.0

