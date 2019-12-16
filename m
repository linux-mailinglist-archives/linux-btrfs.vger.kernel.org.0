Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 816A411FE62
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 07:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfLPGMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 01:12:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfLPGMf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 01:12:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D48EAC4B;
        Mon, 16 Dec 2019 06:12:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Tomasz Chmielewski <mangoo@wpkg.org>,
        Martin Raiber <martin@urbackup.org>
Subject: [PATCH] btrfs: super: Make btrfs_statfs() work with metadata over-commiting
Date:   Mon, 16 Dec 2019 14:12:26 +0800
Message-Id: <20191216061226.40454-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are several reports about vanilla `df` reports no available space,
while `btrfs filesystem df` is still reporting tons of unallocated
space.

https://lore.kernel.org/linux-btrfs/CAJCQCtQEu_+nL_HByAWK2zKfg2Zhpm3Ezto+sA12wwV0iq8Ghg@mail.gmail.com/T/#t
https://lore.kernel.org/linux-btrfs/CAJCQCtSWW4ageK56PdHtSmgrFrDf_Qy0PbxZ5LSYYCbr3Z10ug@mail.gmail.com/T/#t

The example output from vanilla `df` would look like:
Filesystem  Size  Used Avail Use% Mounted on
/dev/loop0  7.4T  623G     0 100% /media/backup

[CAUSE]
There is a special check in btrfs_statfs(), which reset f_bavail:

	if (!mixed && total_free_meta - SZ_4M < block_rsv->size)
		buf->f_bavail = 0;

This old code from 2016 mostly assumes btrfs won't reserve too much
metadata space beyond free metadata space.

However since v5.4, we had a rework on metadata space reservation, now
we alloc metadata over-commit (reserve more space than we have, as long
as we can allocate enough metadata chunks) without really allocating
enough metadata chunks.

This means block_rsv->size can easily go beyond total_free_meta, which
is the unused metadata space, and results f_bavail becomes 0.

[FIX]
The perfect fix is to modify btrfs_calc_avail_data_space(), to calculate
the needed space for metadata chunks, then calculate how many bytes we
can allocate from the remaining unallocated space.

But that's too complex just for vanilla `df` command.

Here we take a shortcut, by excluding the over-committing metadata space
from calculated data space.

This is far from perfect, but should work good enough (TM).

Reported-by: Tomasz Chmielewski <mangoo@wpkg.org>
Reported-by: Martin Raiber <martin@urbackup.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f452a94abdc3..99ee370ba99d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2029,12 +2029,13 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 total_used = 0;
 	u64 total_free_data = 0;
 	u64 total_free_meta = 0;
+	u64 global_rsv_size;
 	int bits = dentry->d_sb->s_blocksize_bits;
 	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
 	unsigned factor = 1;
+	unsigned meta_factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	int ret;
-	u64 thresh = 0;
 	int mixed = 0;
 
 	rcu_read_lock();
@@ -2057,6 +2058,8 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		 * Metadata in mixed block goup profiles are accounted in data
 		 */
 		if (!mixed && found->flags & BTRFS_BLOCK_GROUP_METADATA) {
+			meta_factor = btrfs_bg_type_to_factor(
+					btrfs_metadata_alloc_profile(fs_info));
 			if (found->flags & BTRFS_BLOCK_GROUP_DATA)
 				mixed = 1;
 			else
@@ -2075,9 +2078,10 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	/* Account global block reserve as used, it's in logical size already */
 	spin_lock(&block_rsv->lock);
+	global_rsv_size = block_rsv->size;
 	/* Mixed block groups accounting is not byte-accurate, avoid overflow */
-	if (buf->f_bfree >= block_rsv->size >> bits)
-		buf->f_bfree -= block_rsv->size >> bits;
+	if (buf->f_bfree >= global_rsv_size >> bits)
+		buf->f_bfree -= global_rsv_size >> bits;
 	else
 		buf->f_bfree = 0;
 	spin_unlock(&block_rsv->lock);
@@ -2087,25 +2091,35 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	if (ret)
 		return ret;
 	buf->f_bavail += div_u64(total_free_data, factor);
-	buf->f_bavail = buf->f_bavail >> bits;
 
 	/*
-	 * We calculate the remaining metadata space minus global reserve. If
-	 * this is (supposedly) smaller than zero, there's no space. But this
-	 * does not hold in practice, the exhausted state happens where's still
-	 * some positive delta. So we apply some guesswork and compare the
-	 * delta to a 4M threshold.  (Practically observed delta was ~2M.)
+	 * Btrfs metadata can do over-commit, which means we can have way more
+	 * reserved metadata space as long as we can allocate enough meta
+	 * chunks.
+	 *
+	 * The most accurate way to calculate unallocated free data space would
+	 * involve calculating over-commit meta chunks, then calculate
+	 * how many data space we can allocate from the remaining space.
 	 *
-	 * We probably cannot calculate the exact threshold value because this
-	 * depends on the internal reservations requested by various
-	 * operations, so some operations that consume a few metadata will
-	 * succeed even if the Avail is zero. But this is better than the other
-	 * way around.
+	 * But that's too expensive, here we just go easy, excluding the over-
+	 * commiting metadata part from f_bavail.
 	 */
-	thresh = SZ_4M;
+	if (global_rsv_size > total_free_meta) {
+		u64 to_exclude =  global_rsv_size - total_free_meta;
+
+		/*
+		 * A quick dirty calculation using factor to handle different
+		 * meta/data factors. E.g. for -d SINGLE -m RAID1, we need to
+		 * exclude twice the space.
+		 */
+		to_exclude = to_exclude * meta_factor / factor;
 
-	if (!mixed && total_free_meta - thresh < block_rsv->size)
-		buf->f_bavail = 0;
+		if (buf->f_bavail > to_exclude)
+			buf->f_bavail -= to_exclude;
+		else
+			buf->f_bavail = 0;
+	}
+	buf->f_bavail = buf->f_bavail >> bits;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
 	buf->f_bsize = dentry->d_sb->s_blocksize;
-- 
2.24.1

