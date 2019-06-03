Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713A5332F0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfFCO7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 10:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:60992 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729356AbfFCO7E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE158AF50;
        Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 06/13] btrfs: format checksums according to type for printing
Date:   Mon,  3 Jun 2019 16:58:52 +0200
Message-Id: <20190603145859.7176-7-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
References: <20190603145859.7176-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a small helper for btrfs_print_data_csum_error() which formats the
checksum according to it's type for pretty printing.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>

---
Changes to v3:
- Change the helper function to macros
---
 fs/btrfs/btrfs_inode.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d5b438706b77..4543f4864b2d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -337,22 +337,31 @@ static inline void btrfs_inode_resume_unlocked_dio(struct btrfs_inode *inode)
 	clear_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);
 }
 
+#define CSUM_FORMAT "0x%*phN"
+#define CSUM_FORMAT_VALUE(size, bytes)  size, bytes
+
 static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
 		u64 logical_start, u32 csum, u32 csum_expected, int mirror_num)
 {
 	struct btrfs_root *root = inode->root;
+	struct btrfs_super_block *sb = root->fs_info->super_copy;
+	u16 csum_size = btrfs_super_csum_size(sb);
 
 	/* Output minus objectid, which is more meaningful */
 	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
 		btrfs_warn_rl(root->fs_info,
-	"csum failed root %lld ino %lld off %llu csum 0x%08x expected csum 0x%08x mirror %d",
+	"csum failed root %lld ino %lld off %llu csum " CSUM_FORMAT " expected csum " CSUM_FORMAT " mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
-			logical_start, csum, csum_expected, mirror_num);
+			logical_start, CSUM_FORMAT_VALUE(csum_size, &csum),
+			CSUM_FORMAT_VALUE(csum_size, &csum_expected),
+			mirror_num);
 	else
 		btrfs_warn_rl(root->fs_info,
-	"csum failed root %llu ino %llu off %llu csum 0x%08x expected csum 0x%08x mirror %d",
+	"csum failed root %llu ino %llu off %llu csum " CSUM_FORMAT " expected csum " CSUM_FORMAT " mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
-			logical_start, csum, csum_expected, mirror_num);
+			logical_start, CSUM_FORMAT_VALUE(csum_size, &csum),
+			CSUM_FORMAT_VALUE(csum_size, &csum_expected),
+			mirror_num);
 }
 
 #endif
-- 
2.16.4

