Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C387819C56
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfEJLQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:16:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:50564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727254AbfEJLPy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B3ABAF93
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 08/17] btrfs: format checksums according to type for printing
Date:   Fri, 10 May 2019 13:15:38 +0200
Message-Id: <20190510111547.15310-9-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a small helper for btrfs_print_data_csum_error() which formats the
checksum according to it's type for pretty printing.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/btrfs_inode.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d5b438706b77..f0a757eb5744 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -337,22 +337,42 @@ static inline void btrfs_inode_resume_unlocked_dio(struct btrfs_inode *inode)
 	clear_bit(BTRFS_INODE_READDIO_NEED_LOCK, &inode->runtime_flags);
 }
 
+static inline void btrfs_csum_format(struct btrfs_super_block *sb,
+				     u32 csum, u8 *cbuf)
+{
+	size_t size = btrfs_super_csum_size(sb) * 8;
+
+	switch (btrfs_super_csum_type(sb)) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		snprintf(cbuf, size, "0x%08x", csum);
+		break;
+	default: /* can't happen -  csum type is validated at mount time */
+		break;
+	}
+}
+
 static inline void btrfs_print_data_csum_error(struct btrfs_inode *inode,
 		u64 logical_start, u32 csum, u32 csum_expected, int mirror_num)
 {
 	struct btrfs_root *root = inode->root;
+	struct btrfs_super_block *sb = root->fs_info->super_copy;
+	u8 cbuf[BTRFS_CSUM_SIZE];
+	u8 ecbuf[BTRFS_CSUM_SIZE];
+
+	btrfs_csum_format(sb, csum, cbuf);
+	btrfs_csum_format(sb, csum_expected, ecbuf);
 
 	/* Output minus objectid, which is more meaningful */
 	if (root->root_key.objectid >= BTRFS_LAST_FREE_OBJECTID)
 		btrfs_warn_rl(root->fs_info,
-	"csum failed root %lld ino %lld off %llu csum 0x%08x expected csum 0x%08x mirror %d",
+	"csum failed root %lld ino %lld off %llu csum %s expected csum %s mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
-			logical_start, csum, csum_expected, mirror_num);
+			logical_start, cbuf, ecbuf, mirror_num);
 	else
 		btrfs_warn_rl(root->fs_info,
-	"csum failed root %llu ino %llu off %llu csum 0x%08x expected csum 0x%08x mirror %d",
+	"csum failed root %llu ino %llu off %llu csum %s expected csum %s mirror %d",
 			root->root_key.objectid, btrfs_ino(inode),
-			logical_start, csum, csum_expected, mirror_num);
+			logical_start, cbuf, ecbuf, mirror_num);
 }
 
 #endif
-- 
2.16.4

