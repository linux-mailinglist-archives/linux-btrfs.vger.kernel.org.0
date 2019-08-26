Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC4F9CE7E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730727AbfHZLsk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39102 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727901AbfHZLsj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EB9FAFD2
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:38 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 3/4] btrfs: use xxhash64 for checksumming
Date:   Mon, 26 Aug 2019 13:48:33 +0200
Message-Id: <20190826114834.14789-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114834.14789-1-jthumshirn@suse.de>
References: <20190826114834.14789-1-jthumshirn@suse.de>
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
index 139354d02dfa..c62729d5aa6e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -87,6 +87,7 @@ static const struct btrfs_csums {
 	const char	*name;
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
+	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 99dfd889b9f7..ac039a4d23ff 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -352,6 +352,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 {
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_XXHASH:
 		return true;
 	default:
 		return false;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1b151af25772..60116d0410e5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2456,3 +2456,4 @@ module_exit(exit_btrfs_fs)
 
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32c");
+MODULE_SOFTDEP("pre: xxhash64");
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b65c7ee75bc7..ba2f125a3a1c 100644
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

