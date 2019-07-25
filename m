Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA0749F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbfGYJeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:34:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:52314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390579AbfGYJeK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1557DAE1C
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 09:34:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 3/4] btrfs: use xxhash64 for checksumming
Date:   Thu, 25 Jul 2019 11:33:50 +0200
Message-Id: <4ac3332af1fa5ba7ecb92181329151382b800f3d.1564046812.git.jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/Kconfig                | 1 +
 fs/btrfs/ctree.h                | 1 +
 fs/btrfs/disk-io.c              | 1 +
 fs/btrfs/super.c                | 1 +
 include/uapi/linux/btrfs_tree.h | 1 +
 5 files changed, 5 insertions(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 38651fae7f21..6d5a01c57da3 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -5,6 +5,7 @@ config BTRFS_FS
 	select CRYPTO
 	select CRYPTO_CRC32C
 	select LIBCRC32C
+	select CRYPTO_XXHASH
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select LZO_COMPRESS
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 099401f5dd47..b34f22e55304 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -90,6 +90,7 @@ static const struct btrfs_csums {
 	const char	*name;
 } btrfs_csums[] = {
 	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_CRC32, 4, "crc32c"),
+	BTRFS_CHECKSUM_TYPE(BTRFS_CSUM_TYPE_XXHASH, 8, "xxhash64"),
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5f7ee70b3d1a..54a8ef489850 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -351,6 +351,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 {
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_XXHASH:
 		return true;
 	default:
 		return false;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 78de9d5d80c6..7312f675d702 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2464,3 +2464,4 @@ module_exit(exit_btrfs_fs)
 
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32c");
+MODULE_SOFTDEP("pre: xxhash64");
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index babef98181a2..af4f5dec10b7 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -302,6 +302,7 @@
 /* csum types */
 enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32	= 0,
+	BTRFS_CSUM_TYPE_XXHASH	= 1,
 };
 
 /*
-- 
2.16.4

