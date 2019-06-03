Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB48332F2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfFCO7M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 10:59:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:32770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729362AbfFCO7E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB150AFB2;
        Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 09/13] btrfs: Simplify btrfs_check_super_csum() and get rid of size assumptions
Date:   Mon,  3 Jun 2019 16:58:55 +0200
Message-Id: <20190603145859.7176-10-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
References: <20190603145859.7176-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have already checked for a valid checksum type before calling
btrfs_check_super_csum(), it can be simplified even further.

While at it get rid of the implicit size assumption of the resulting
checksum as well.

This is a preparation for changing all checksum functionality to use the
crypto layer later.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>

---
Changes to v1:
- Check for disk_sb->csum instead of raw buffer (Nikolay)
---
 fs/btrfs/disk-io.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b11091612074..a2b29b875ea4 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -375,30 +375,20 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_super_block *disk_sb =
 		(struct btrfs_super_block *)raw_disk_sb;
-	u16 csum_type = btrfs_super_csum_type(disk_sb);
-
-	if (!btrfs_supported_super_csum(csum_type)) {
-		btrfs_err(fs_info, "unsupported checksum algorithm %u",
-			  csum_type);
-		return 1;
-	}
-
-	if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
-		u32 crc = ~(u32)0;
-		char result[sizeof(crc)];
+	u32 crc = ~(u32)0;
+	char result[BTRFS_CSUM_SIZE];
 
-		/*
-		 * The super_block structure does not span the whole
-		 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space
-		 * is filled with zeros and is included in the checksum.
-		 */
-		crc = btrfs_csum_data(raw_disk_sb + BTRFS_CSUM_SIZE,
-				crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(crc, result);
+	/*
+	 * The super_block structure does not span the whole
+	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space
+	 * is filled with zeros and is included in the checksum.
+	 */
+	crc = btrfs_csum_data(raw_disk_sb + BTRFS_CSUM_SIZE,
+			      crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+	btrfs_csum_final(crc, result);
 
-		if (memcmp(raw_disk_sb, result, sizeof(result)))
-			return 1;
-	}
+	if (memcmp(disk_sb->csum, result, btrfs_super_csum_size(disk_sb)))
+		return 1;
 
 	return 0;
 }
@@ -2616,6 +2606,7 @@ int open_ctree(struct super_block *sb,
 	u32 stripesize;
 	u64 generation;
 	u64 features;
+	u16 csum_type;
 	struct btrfs_key location;
 	struct buffer_head *bh;
 	struct btrfs_super_block *disk_super;
@@ -2821,11 +2812,11 @@ int open_ctree(struct super_block *sb,
 		goto fail_alloc;
 	}
 
-	if (!btrfs_supported_super_csum(btrfs_super_csum_type(
-				 (struct btrfs_super_block *) bh->b_data))) {
+	csum_type = btrfs_super_csum_type((struct btrfs_super_block *)
+					  bh->b_data);
+	if (!btrfs_supported_super_csum(csum_type)) {
 		btrfs_err(fs_info, "unsupported checksum algorithm: %u",
-			  btrfs_super_csum_type((struct btrfs_super_block *)
-						bh->b_data));
+			  csum_type);
 		err = -EINVAL;
 		brelse(bh);
 		goto fail_alloc;
-- 
2.16.4

