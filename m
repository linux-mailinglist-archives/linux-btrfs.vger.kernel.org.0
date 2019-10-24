Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3918E36F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409738AbfJXPpB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 11:45:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:50002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409737AbfJXPpA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 11:45:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75088B36E;
        Thu, 24 Oct 2019 15:44:58 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/2] btrfs: provide an estimated number of inodes for statfs
Date:   Thu, 24 Oct 2019 17:44:55 +0200
Message-Id: <20191024154455.19370-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191024154455.19370-1-jthumshirn@suse.de>
References: <20191024154455.19370-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On the BeeGFS Mailing list there is a report claiming BTRFS is not usable
with BeeGFS, as BeeGFS is using statfs output to determine the number of
total and free inodes. BeeGFS needs the number of free inodes as it stores
its meta-data either in extended attributes of the underlying file-system
or directly in an inline inode. According to the BeeGFS Server Tuning
Guide:

"""
BeeGFS metadata is stored as extended attributes (EAs) on the underlying
file system to optimal performance. One metadata file will be created for
each file that a user creates. About extended attributes usage: BeeGFS
Metadata files have a size of 0 bytes (i.e. no normal file contents).

Access to extended attributes is possible with the getfattr tool.

If the inodes of the underlying file system are sufficiently large, EAs
can be inlined into the inode of the underlying file system.  Additional
data blocks are then not required anymore and metadata disk usage will be
reduced.  With EAs inlined into the inode, access latencies are reduced as
seeking to an extra data block is not required anymore.
"""

Provide some estimated numbers of total and free inodes in statfs by
dividing the number of blocks by the size of an inode-item for the total
number of possible inodes and for the number of free inodes divide the
number of free blocks by the size of an inode-item, similar to what other
file-systems without a fixed number of inodes do.

This of is just an estimation and should not be relied upon.

Without the patch applied:
rapido1:/# df -hTi /mnt/test
Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
/mnt/test      btrfs         0     0     0     - /mnt/test

With the patch applied on an empty fs:
rapido1:/# df -hTi /mnt/test
Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
/dev/zram0     btrfs      1.6K     0  1.6K    0% /mnt/test

With the patch applied on a dirty fs:
rapido1:/# df -hTi /mnt/test
Filesystem     Type     Inodes IUsed IFree IUse% Mounted on
/dev/zram0     btrfs      1.6K  1.5K   197   88% /mnt/test

Link: https://groups.google.com/forum/#!msg/fhgfs-user/IJqGS5o1UD0/8ftDdUI3AQAJ
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b818f764c1c9..6f6f6a70eb1e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2068,6 +2068,8 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_blocks = div_u64(btrfs_super_total_bytes(disk_super), factor);
 	buf->f_blocks >>= bits;
 	buf->f_bfree = buf->f_blocks - (div_u64(total_used, factor) >> bits);
+	buf->f_files = div_u64(buf->f_blocks, sizeof(struct btrfs_inode_item));
+	buf->f_ffree = div_u64(buf->f_bfree, sizeof(struct btrfs_inode_item));
 
 	/* Account global block reserve as used, it's in logical size already */
 	spin_lock(&block_rsv->lock);
-- 
2.16.4

