Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2BCDE01
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfJGJLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:38378 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727461AbfJGJLJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 05:11:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 617CCB1A2;
        Mon,  7 Oct 2019 09:11:07 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 2/4] btrfs: add sha256 to checksumming algorithms
Date:   Mon,  7 Oct 2019 11:11:02 +0200
Message-Id: <20191007091104.18095-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191007091104.18095-1-jthumshirn@suse.de>
References: <20191007091104.18095-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add sha256 to the list of possible checksumming algorithms used by BTRFS.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/Kconfig                | 1 +
 fs/btrfs/ctree.c                | 1 +
 fs/btrfs/disk-io.c              | 1 +
 fs/btrfs/super.c                | 1 +
 include/uapi/linux/btrfs_tree.h | 1 +
 5 files changed, 5 insertions(+)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 6d5a01c57da3..75b6d10c9845 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -6,6 +6,7 @@ config BTRFS_FS
 	select CRYPTO_CRC32C
 	select LIBCRC32C
 	select CRYPTO_XXHASH
+	select CRYPTO_SHA256
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select LZO_COMPRESS
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a1b317cf193b..b66509ee62eb 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -35,6 +35,7 @@ static const struct btrfs_csums {
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
+	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
 };
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b0a6904b6139..99feff25bbef 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -353,6 +353,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
 	case BTRFS_CSUM_TYPE_XXHASH:
+	case BTRFS_CSUM_TYPE_SHA256:
 		return true;
 	default:
 		return false;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c91cdf123cd8..36440336c08b 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2463,3 +2463,4 @@ module_exit(exit_btrfs_fs)
 MODULE_LICENSE("GPL");
 MODULE_SOFTDEP("pre: crc32c");
 MODULE_SOFTDEP("pre: xxhash64");
+MODULE_SOFTDEP("pre: sha256");
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index ba2f125a3a1c..838cfd0af5c3 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -303,6 +303,7 @@
 enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32	= 0,
 	BTRFS_CSUM_TYPE_XXHASH	= 1,
+	BTRFS_CSUM_TYPE_SHA256	= 2,
 };
 
 /*
-- 
2.16.4

