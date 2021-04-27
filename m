Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65A436CF3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbhD0XGS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:06:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:37626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239506AbhD0XGM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kQMWF4DvqB68b3+SRGPqRjo9OxV+9iF7STuL0CvQvk=;
        b=HGQYmVWqcs8sMb5YhlMxmYRuiWNhKsaVfzmfv+1qY2kii00cZ1nc6Byadq3wNpN7gnQfvI
        xmDrDO2OHW8qahZiadERoIPaBAuNZxZ0H3KlJzzdZSqDSx+MLdnU4RuAcamKY2up/DtDvc
        e11ub0d95PxbZXfZMp07yxiyoTB+RPw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93270AC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:05:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 42/42] btrfs: allow read-write for 4K sectorsize on 64K page size systems
Date:   Wed, 28 Apr 2021 07:03:49 +0800
Message-Id: <20210427230349.369603-43-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since now we support data and metadata read-write for subpage, remove
the RO requirement for subpage mount.

There are some extra limits though:
- For now, subpage RW mount is still considered experimental
  Thus that mount warning will still be there.

- No compression support
  There are still quite some PAGE_SIZE hard coded and quite some call
  sites use extent_clear_unlock_delalloc() to unlock locked_page.
  This will screw up subpage helpers

  Now for subpage RW mount, no matter whatever mount option or inode
  attr is set, all write will not be compressed.
  Although reading compressed data has no problem.

- No sectorsize defrag
  The problem here is, defrag is still done in full page size (64K).
  This means, if a page only has 4K data while the remaining 60K is all
  hole, after defrag it will be full 64K.

  This should not cause any kernel warning/hang nor data corruption, but
  it's still a behavior difference.

- No inline extent will be created
  This is mostly due to the fact that filemap_fdatawrite_range() will
  trigger more write than the range specified.
  In fallocate calls, this behavior can make us to writeback which can
  be inlined, before we enlarge the isize.

  This is a very special corner case, and even current btrfs check won't
  report error on such inline extent + regular extent.
  But considering how much effort has been put to prevent such inline +
  regular, I'd prefer to cut off inline extent completely until we have
  a good solution.

- Read-time data repair is in bvec size
  This is different from original sector size repair.
  Bvec size is a floating number between 4K to 64K (page size).
  If the extent is only 4K sized then we can do the repair in 4K size.
  But if the extent is larger, our repair unit grows follows the
  extent size, until it reaches PAGE_SIZE.

  This is mostly due to the design of the repair code, it can be
  enhanced later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 13 ++++---------
 fs/btrfs/inode.c   |  3 +++
 fs/btrfs/ioctl.c   |  7 +++++++
 fs/btrfs/super.c   |  7 -------
 fs/btrfs/sysfs.c   |  5 +++++
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e6b941932a2b..390e9048e1a9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3397,15 +3397,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
-	/* For 4K sector size support, it's only read-only */
-	if (PAGE_SIZE == SZ_64K && sectorsize == SZ_4K) {
-		if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)) {
-			btrfs_err(fs_info,
-	"subpage sectorsize %u only supported read-only for page size %lu",
-				sectorsize, PAGE_SIZE);
-			err = -EINVAL;
-			goto fail_alloc;
-		}
+	if (sectorsize != PAGE_SIZE) {
+		btrfs_warn(fs_info,
+	"read-write for sector size %u with page size %lu is experimental",
+			   sectorsize, PAGE_SIZE);
 	}
 	if (sectorsize != PAGE_SIZE) {
 		if (btrfs_super_incompat_flags(fs_info->super_copy) &
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2ac8d6eeba5..294d8d98280d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -466,6 +466,9 @@ static noinline int add_async_extent(struct async_chunk *cow,
  */
 static inline bool inode_can_compress(struct btrfs_inode *inode)
 {
+	/* Subpage doesn't support compress yet */
+	if (inode->root->fs_info->sectorsize < PAGE_SIZE)
+		return false;
 	if (inode->flags & BTRFS_INODE_NODATACOW ||
 	    inode->flags & BTRFS_INODE_NODATASUM)
 		return false;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b1328f17607e..dc6f402ea259 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3161,6 +3161,13 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 	struct btrfs_ioctl_defrag_range_args *range;
 	int ret;
 
+	/*
+	 * Subpage defrag support is not really sector perfect yet.
+	 * Disable defrag fro subpage case for now.
+	 */
+	if (root->fs_info->sectorsize < PAGE_SIZE)
+		return -ENOTTY;
+
 	ret = mnt_want_write_file(file);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 4a396c1147f1..b18d268abfbb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2053,13 +2053,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			ret = -EINVAL;
 			goto restore;
 		}
-		if (fs_info->sectorsize < PAGE_SIZE) {
-			btrfs_warn(fs_info,
-	"read-write mount is not yet allowed for sectorsize %u page size %lu",
-				   fs_info->sectorsize, PAGE_SIZE);
-			ret = -EINVAL;
-			goto restore;
-		}
 
 		/*
 		 * NOTE: when remounting with a change that does writes, don't
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 436ac7b4b334..752461a79364 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -366,6 +366,11 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 {
 	ssize_t ret = 0;
 
+	/* 4K sector size is also support with 64K page size */
+	if (PAGE_SIZE == SZ_64K)
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u ",
+				 SZ_4K);
+
 	/* Only sectorsize == PAGE_SIZE is now supported */
 	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
 
-- 
2.31.1

