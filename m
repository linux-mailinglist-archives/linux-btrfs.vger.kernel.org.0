Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED8E14BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbfJWIvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 04:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390394AbfJWIvA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 04:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8737FB1D64
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 08:50:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: extent-tree: Ensure we trim ranges across block group boundary
Date:   Wed, 23 Oct 2019 16:50:37 +0800
Message-Id: <20191023085037.14838-3-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023085037.14838-1-wqu@suse.com>
References: <20191023085037.14838-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When deleting large files (which cross block group boundary) with discard
mount option, we find some btrfs_discard_extent() calls only trimmed part
of its space, not the whole range:

  btrfs_discard_extent: type=0x1 start=19626196992 len=2144530432 trimmed=1073741824 ratio=50%

type:		bbio->map_type, in above case, it's SINGLE DATA.
start:		Logical address of this trim
len:		Logical length of this trim
trimmed:	Physically trimmed bytes
ratio:		trimmed / len

Thus leading some unused space not discarded.

[CAUSE]
When discard mount option is specified, after a transaction is fully
committed (super block written to disk), we begin to cleanup pinned
extents in the following call chain:
btrfs_commit_transaction()
|- write_all_supers()
|- btrfs_finish_extent_commit()
   |- find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY);
   |- btrfs_discard_extent()

However pinned extents are recorded in an extent_io_tree, which can
merge same extent states.

When a large file get deleted and it has adjacent file extents across
block group boundary, we will get a large merged range.

Then when we pass the large range into btrfs_discard_extent(),
btrfs_discard_extent() will just trim the first part, without trimming
the remaining part.

Furthermore, this bug is not that reliably observed, as if the whole
block group is empty, there will be another trim for that block group.

So the most obvious way to find this missing trim needs to delete large
extents at block group boundary without empting involved block groups.

[FIX]
Fix this bug by calling btrfs_map_block() in a loop, until we reach the
end location.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 49cb26fa7c63..45df45fa775b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1306,8 +1306,10 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes)
 {
-	int ret;
+	int ret = 0;
 	u64 discarded_bytes = 0;
+	u64 end = bytenr + num_bytes;
+	u64 cur = bytenr;
 	struct btrfs_bio *bbio = NULL;
 
 
@@ -1316,15 +1318,22 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 	 * associated to its stripes that don't go away while we are discarding.
 	 */
 	btrfs_bio_counter_inc_blocked(fs_info);
-	/* Tell the block device(s) that the sectors can be discarded */
-	ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, bytenr, &num_bytes,
-			      &bbio, 0);
-	/* Error condition is -ENOMEM */
-	if (!ret) {
-		struct btrfs_bio_stripe *stripe = bbio->stripes;
+	while (cur < end) {
+		struct btrfs_bio_stripe *stripe;
 		int i;
 
+		/* Tell the block device(s) that the sectors can be discarded */
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_DISCARD, cur,
+				      &num_bytes, &bbio, 0);
+		/*
+		 * Error can be -ENOMEM, -ENOENT (no such chunk mapping) or
+		 * -EOPNOTSUPP. For any such error, @num_bytes is not updated,
+		 * thus we can't continue anyway.
+		 */
+		if (ret < 0)
+			goto out;
 
+		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
 			u64 bytes;
 			struct request_queue *req_q;
@@ -1341,10 +1350,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 						  stripe->physical,
 						  stripe->length,
 						  &bytes);
-			if (!ret)
+			if (!ret) {
 				discarded_bytes += bytes;
-			else if (ret != -EOPNOTSUPP)
-				break; /* Logic errors or -ENOMEM, or -EIO but I don't know how that could happen JDM */
+			} else if (ret != -EOPNOTSUPP) {
+				/*
+				 * Logic errors or -ENOMEM, or -EIO but I don't
+				 * know how that could happen JDM
+				 *
+				 * Ans since there are two loops, explicitly
+				 * goto out to avoid confusion.
+				 */
+				btrfs_put_bbio(bbio);
+				goto out;
+			}
 
 			/*
 			 * Just in case we get back EOPNOTSUPP for some reason,
@@ -1354,7 +1372,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			ret = 0;
 		}
 		btrfs_put_bbio(bbio);
+		cur += num_bytes;
 	}
+out:
 	btrfs_bio_counter_dec(fs_info);
 
 	if (actual_bytes)
-- 
2.23.0

