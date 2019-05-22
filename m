Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA325F4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfEVITb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:19:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:60488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728600AbfEVITR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:19:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 66C84AF85;
        Wed, 22 May 2019 08:19:16 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 07/13] btrfs: add common checksum type validation
Date:   Wed, 22 May 2019 10:19:04 +0200
Message-Id: <20190522081910.7689-8-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190522081910.7689-1-jthumshirn@suse.de>
References: <20190522081910.7689-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs is only supporting CRC32C as checksumming algorithm. As
this is about to change provide a function to validate the checksum type in
the superblock against all possible algorithms.

This makes adding new algorithms easier as there are fewer places to adjust
when adding new algorithms.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>

---
Changes to v2:
- Only pass csum_type into btrfs_supported_csum() (David)
- Directly return in btrfs_check_super_csum() (David)
---
 fs/btrfs/disk-io.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 663efce22d98..594583273782 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -356,6 +356,16 @@ static int verify_parent_transid(struct extent_io_tree *io_tree,
 	return ret;
 }
 
+static bool btrfs_supported_super_csum(u16 csum_type)
+{
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Return 0 if the superblock checksum type matches the checksum value of that
  * algorithm. Pass the raw disk superblock data.
@@ -366,7 +376,12 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	struct btrfs_super_block *disk_sb =
 		(struct btrfs_super_block *)raw_disk_sb;
 	u16 csum_type = btrfs_super_csum_type(disk_sb);
-	int ret = 0;
+
+	if (!btrfs_supported_super_csum(csum_type)) {
+		btrfs_err(fs_info, "unsupported checksum algorithm %u",
+			  csum_type);
+		return 1;
+	}
 
 	if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
 		u32 crc = ~(u32)0;
@@ -382,16 +397,10 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 		btrfs_csum_final(crc, result);
 
 		if (memcmp(raw_disk_sb, result, sizeof(result)))
-			ret = 1;
+			return 1;
 	}
 
-	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
-		btrfs_err(fs_info, "unsupported checksum algorithm %u",
-				csum_type);
-		ret = 1;
-	}
-
-	return ret;
+	return 0;
 }
 
 int btrfs_verify_level_key(struct extent_buffer *eb, int level,
@@ -2577,7 +2586,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	ret = validate_super(fs_info, sb, -1);
 	if (ret < 0)
 		goto out;
-	if (btrfs_super_csum_type(sb) != BTRFS_CSUM_TYPE_CRC32) {
+	if (!btrfs_supported_super_csum(sb)) {
 		ret = -EUCLEAN;
 		btrfs_err(fs_info, "invalid csum type, has %u want %u",
 			  btrfs_super_csum_type(sb), BTRFS_CSUM_TYPE_CRC32);
-- 
2.16.4

