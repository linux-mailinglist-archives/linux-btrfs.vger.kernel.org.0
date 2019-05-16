Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6213F201A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 10:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfEPIs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 04:48:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:33062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbfEPIsI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 04:48:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB982AF96;
        Thu, 16 May 2019 08:48:05 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 13/13] btrfs: add sha256 as another checksum algorithm
Date:   Thu, 16 May 2019 10:48:03 +0200
Message-Id: <20190516084803.9774-14-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190516084803.9774-1-jthumshirn@suse.de>
References: <20190516084803.9774-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we everything in place, we can add SHA-256 as another checksum
algorithm.

SHA-256 was taken as it was the cryptographically strongest algorithm that
can fit into the 32 Bytes we have left.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v1:
- Select SHA-256 in KConfig
- Minimalize switch() in btrfs_supported_super_csum() (Nikolay)
- Use enum for new on-disk checksum type (Nikolay/David)
- Format SHA256 using sprintf()'s hexdump mode
---
 fs/btrfs/Kconfig                | 1 +
 fs/btrfs/btrfs_inode.h          | 3 +++
 fs/btrfs/ctree.h                | 4 ++--
 fs/btrfs/disk-io.c              | 1 +
 include/uapi/linux/btrfs_tree.h | 6 ++++--
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 8f48c3be709e..64f793bb7530 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -3,6 +3,7 @@
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
 	select CRYPTO_CRC32C
+	select CRYPTO_SHA256
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select LZO_COMPRESS
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e79fd9129075..125bc7f3b871 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -346,6 +346,9 @@ static inline void btrfs_csum_format(struct btrfs_super_block *sb,
 	case BTRFS_CSUM_TYPE_CRC32:
 		snprintf(cbuf, size, "0x%08x", *(u32 *)csum);
 		break;
+	case BTRFS_CSUM_TYPE_SHA256:
+		snprintf(cbuf, size, "%*phN", (int)size / 8, csum);
+		break;
 	default: /* can't happen -  csum type is validated at mount time */
 		break;
 	}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0624057423d4..83d4cb2c9426 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -72,8 +72,8 @@ struct btrfs_ref;
 #define BTRFS_LINK_MAX 65535U
 
 /* four bytes for CRC32 */
-static const int btrfs_csum_sizes[] = { 4 };
-static char *btrfs_csum_names[] = { "crc32c" };
+static const int btrfs_csum_sizes[] = { 4, 32 };
+static char *btrfs_csum_names[] = { "crc32c", "sha256" };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7368a6ea5852..8d3ba8f811c8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -357,6 +357,7 @@ static bool btrfs_supported_super_csum(struct btrfs_super_block *sb)
 {
 	switch (btrfs_super_csum_type(sb)) {
 	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_SHA256:
 		return true;
 	default:
 		return false;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 421239b98db2..8edb624410cb 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -300,8 +300,10 @@
 #define BTRFS_CSUM_SIZE 32
 
 /* csum types */
-#define BTRFS_CSUM_TYPE_CRC32	0
-
+enum {
+	BTRFS_CSUM_TYPE_CRC32	= 0,
+	BTRFS_CSUM_TYPE_SHA256	= 1,
+};
 /*
  * flags definitions for directory entry item type
  *
-- 
2.16.4

