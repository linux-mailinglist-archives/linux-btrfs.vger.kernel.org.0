Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02B360179
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhDOFGh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:06:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhDOFGg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:06:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618463173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7uIMNkqMw/flLsGeWYOaIxUfeN8/xEOp8HksKT+Yf0=;
        b=tAkK+QQzMRIvGZvOvOtRS/Q9ueBvO1WXxKc0ltQ8dvLIwz3VoKX2IQauf2J9oc5AaCO4IO
        rq9qR7TpRnaCOWlaAeQq6bwA5bP5WCze9JzufmAgEcz9fXerx/eGiC/5+XKj+4XzKUG8mg
        Ohz9DojnX7q5oJFbM7M9cHHhKl1fxaA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 356EBAF03
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:06:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 42/42] btrfs: allow read-write for 4K sectorsize on 64K page size systems
Date:   Thu, 15 Apr 2021 13:04:48 +0800
Message-Id: <20210415050448.267306-43-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415050448.267306-1-wqu@suse.com>
References: <20210415050448.267306-1-wqu@suse.com>
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
index 0a1182694f48..6db6c231ecc4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3386,15 +3386,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 077c0aa4f846..cd36182aa653 100644
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
index 37c92a9fa2e3..be174dc9bcd0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3149,6 +3149,13 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
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
index f7a4ad86adee..f892ddf2e9f1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2027,13 +2027,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
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
index a99d1f415a7f..648e23c30e9e 100644
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

