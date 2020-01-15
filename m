Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7487013B83D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 04:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAODle (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 22:41:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:59286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgAODle (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 22:41:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBA72AFB0
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 03:41:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: statfs: Don't reset f_bavail if we're over committing metadata space
Date:   Wed, 15 Jan 2020 11:41:28 +0800
Message-Id: <20200115034128.32889-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When there are a lot of metadata space reserved, e.g. after balancing a
data block with many extents, vanilla df would report 0 available space.

[CAUSE]
btrfs_statfs() would report 0 available space if its metadata space is
exhausted.
And the calculation is based on currently reserved space vs on-disk
available space, with a small headroom as buffer.
When there is not enough headroom, btrfs_statfs() will report 0
available space.

The problem is, since commit ef1317a1b9a3 ("btrfs: do not allow
reservations if we have pending tickets"), we allow btrfs to over commit
metadata space, as long as we have enough space to allocate new metadata
chunks.

This makes old calculation unreliable and report false 0 available space.

[FIX]
Don't do such naive check anymore for btrfs_statfs().
Also remove the comment about "0 available space when metadata is
exhausted".

Please note that, this is a just a quick fix. There are still a lot of
things to be improved.

Fixes: ef1317a1b9a3 ("btrfs: do not allow reservations if we have pending tickets")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..ca1a26b3e884 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2018,8 +2018,6 @@ static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
  * algorithm that respects the device sizes and order of allocations.  This is
  * a close approximation of the actual use but there are other factors that may
  * change the result (like a new metadata chunk).
- *
- * If metadata is exhausted, f_bavail will be 0.
  */
 static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
@@ -2034,7 +2032,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	int ret;
-	u64 thresh = 0;
 	int mixed = 0;
 
 	rcu_read_lock();
@@ -2089,24 +2086,6 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_bavail += div_u64(total_free_data, factor);
 	buf->f_bavail = buf->f_bavail >> bits;
 
-	/*
-	 * We calculate the remaining metadata space minus global reserve. If
-	 * this is (supposedly) smaller than zero, there's no space. But this
-	 * does not hold in practice, the exhausted state happens where's still
-	 * some positive delta. So we apply some guesswork and compare the
-	 * delta to a 4M threshold.  (Practically observed delta was ~2M.)
-	 *
-	 * We probably cannot calculate the exact threshold value because this
-	 * depends on the internal reservations requested by various
-	 * operations, so some operations that consume a few metadata will
-	 * succeed even if the Avail is zero. But this is better than the other
-	 * way around.
-	 */
-	thresh = SZ_4M;
-
-	if (!mixed && total_free_meta - thresh < block_rsv->size)
-		buf->f_bavail = 0;
-
 	buf->f_type = BTRFS_SUPER_MAGIC;
 	buf->f_bsize = dentry->d_sb->s_blocksize;
 	buf->f_namelen = BTRFS_NAME_LEN;
-- 
2.24.1

