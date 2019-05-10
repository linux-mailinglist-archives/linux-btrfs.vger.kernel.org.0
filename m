Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F359619C4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfEJLPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727323AbfEJLPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88DE0AFBF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 17/17] btrfs: add sha256 as another checksum algorithm
Date:   Fri, 10 May 2019 13:15:47 +0200
Message-Id: <20190510111547.15310-18-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
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
 fs/btrfs/btrfs_inode.h          | 3 +++
 fs/btrfs/ctree.h                | 4 ++--
 fs/btrfs/disk-io.c              | 2 ++
 include/uapi/linux/btrfs_tree.h | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e79fd9129075..fccc372ef719 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -346,6 +346,9 @@ static inline void btrfs_csum_format(struct btrfs_super_block *sb,
 	case BTRFS_CSUM_TYPE_CRC32:
 		snprintf(cbuf, size, "0x%08x", *(u32 *)csum);
 		break;
+	case BTRFS_CSUM_TYPE_SHA256:
+		memcpy(cbuf, csum, size);
+		break;
 	default: /* can't happen -  csum type is validated at mount time */
 		break;
 	}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8733c55ed686..d60138208dd4 100644
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
index 2be8f05be1e6..bdcffa0d6b13 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -390,6 +390,8 @@ static bool btrfs_supported_super_csum(struct btrfs_super_block *sb)
 	switch (btrfs_super_csum_type(sb)) {
 	case BTRFS_CSUM_TYPE_CRC32:
 		return true;
+	case BTRFS_CSUM_TYPE_SHA256:
+		return true;
 	default:
 		return false;
 	}
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 421239b98db2..3667ab4bc215 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -301,6 +301,7 @@
 
 /* csum types */
 #define BTRFS_CSUM_TYPE_CRC32	0
+#define BTRFS_CSUM_TYPE_SHA256	1
 
 /*
  * flags definitions for directory entry item type
-- 
2.16.4

