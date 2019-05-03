Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357FD12582
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 02:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfECAbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 May 2019 20:31:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:34158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbfECAbA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 May 2019 20:31:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0F669AF0C
        for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2019 00:30:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: Check if the file extent end overflow
Date:   Fri,  3 May 2019 08:30:54 +0800
Message-Id: <20190503003054.9346-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Under certain condition, we could have strange file extent item in log
tree like:

  item 18 key (69599 108 397312) itemoff 15208 itemsize 53
	extent data disk bytenr 0 nr 0
	extent data offset 0 nr 18446744073709547520 ram 18446744073709547520

The num_bytes and ram_bytes part overflow.

For num_bytes part, we can detect such overflow along with file offset
(key->offset), as file_offset + num_bytes should never go beyond u64
max.

For ram_bytes part, it's about the decompressed size of the extent, not
directly related to the size.
In theory is OK to have super large value, and put extra
limitation on ram bytes may cause unexpected false alert.

So in tree-checker, we only check if the file offset and num bytes
overflow.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 4f4f5af6345a..795eb6c18456 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -112,6 +112,7 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	struct btrfs_file_extent_item *fi;
 	u32 sectorsize = fs_info->sectorsize;
 	u32 item_size = btrfs_item_size_nr(leaf, slot);
+	u64 extent_end;
 
 	if (!IS_ALIGNED(key->offset, sectorsize)) {
 		file_extent_err(leaf, slot,
@@ -186,6 +187,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	    CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
 	    CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize))
 		return -EUCLEAN;
+	/* Catch extent end overflow case */
+	if (check_add_overflow(btrfs_file_extent_num_bytes(leaf, fi),
+			       key->offset, &extent_end)) {
+		file_extent_err(leaf, slot,
+	"extent end overflow, have file offset %llu extent num bytes %llu",
+				key->offset,
+				btrfs_file_extent_num_bytes(leaf, fi));
+	}
 	return 0;
 }
 
-- 
2.21.0

