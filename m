Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814F325F47
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfEVITV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:19:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728674AbfEVITU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:19:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC892AF4C;
        Wed, 22 May 2019 08:19:18 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH v3 13/13] btrfs: add sha256 as another checksum algorithm
Date:   Wed, 22 May 2019 10:19:10 +0200
Message-Id: <20190522081910.7689-14-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190522081910.7689-1-jthumshirn@suse.de>
References: <20190522081910.7689-1-jthumshirn@suse.de>
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
changes to v2:
- Add pre dependency on sha256
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
 fs/btrfs/super.c                | 1 +
 include/uapi/linux/btrfs_tree.h | 6 ++++--
 6 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 212b4a854f2c..2521a24f74be 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -4,6 +4,7 @@ config BTRFS_FS
 	tristate "Btrfs filesystem support"
 	select CRYPTO
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
index 8b635ca370f5..f2246aa2596a 100644
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
index 68cdee36b470..0c7ea5c7f0db 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -357,6 +357,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 {
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_SHA256:
 		return true;
 	default:
 		return false;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f40516ca5963..5d3687354fc7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2466,3 +2466,4 @@ module_exit(exit_btrfs_fs)
 
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32c");
+MODULE_SOFTDEP("pre: sha256");
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

