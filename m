Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD419C48
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfEJLPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:50510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbfEJLPx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C11FAF81
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 02/17] btrfs: resurrect btrfs_crc32c()
Date:   Fri, 10 May 2019 13:15:32 +0200
Message-Id: <20190510111547.15310-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 9678c54388b6 ("btrfs: Remove custom crc32c init code") removed the
btrfs_crc32c() function, because it was a duplicate of the crc32c() library
function we already have in the kernel.

Resurrect it as a shim wrapper over crc32c() to make following
transformations of the checksumming code in btrfs easier.

Also provide a btrfs_crc32_final() to ease following transformations.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.h       | 12 ++++++++++++
 fs/btrfs/extent-tree.c |  6 +++---
 fs/btrfs/send.c        |  2 +-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b81c331b28fa..d85541f13f65 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -19,6 +19,7 @@
 #include <linux/kobject.h>
 #include <trace/events/btrfs.h>
 #include <asm/kmap_types.h>
+#include <asm/unaligned.h>
 #include <linux/pagemap.h>
 #include <linux/btrfs.h>
 #include <linux/btrfs_tree.h>
@@ -2642,6 +2643,17 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
 	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
 	btrfs_item_offset_nr(leaf, slot)))
 
+
+static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
+{
+	return crc32c(crc, address, length);
+}
+
+static inline void btrfs_crc32c_final(u32 crc, u8 *result)
+{
+	put_unaligned_le32(~crc, result);
+}
+
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
        return crc32c((u32)~1, name, len);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f79e477a378e..06a30f2cd2e0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1119,11 +1119,11 @@ static u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
 	__le64 lenum;
 
 	lenum = cpu_to_le64(root_objectid);
-	high_crc = crc32c(high_crc, &lenum, sizeof(lenum));
+	high_crc = btrfs_crc32c(high_crc, &lenum, sizeof(lenum));
 	lenum = cpu_to_le64(owner);
-	low_crc = crc32c(low_crc, &lenum, sizeof(lenum));
+	low_crc = btrfs_crc32c(low_crc, &lenum, sizeof(lenum));
 	lenum = cpu_to_le64(offset);
-	low_crc = crc32c(low_crc, &lenum, sizeof(lenum));
+	low_crc = btrfs_crc32c(low_crc, &lenum, sizeof(lenum));
 
 	return ((u64)high_crc << 31) ^ (u64)low_crc;
 }
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index dd38dfe174df..c029ca6d5eba 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -686,7 +686,7 @@ static int send_cmd(struct send_ctx *sctx)
 	hdr->len = cpu_to_le32(sctx->send_size - sizeof(*hdr));
 	hdr->crc = 0;
 
-	crc = crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
+	crc = btrfs_crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
 	hdr->crc = cpu_to_le32(crc);
 
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
-- 
2.16.4

