Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673FB96611
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfHTQRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:17:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:57556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfHTQRD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:17:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 540F5AE91
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:17:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A453DDA7DA; Tue, 20 Aug 2019 18:17:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/2] btrfs: compression: replace set_level callbacks by a common helper
Date:   Tue, 20 Aug 2019 18:17:27 +0200
Message-Id: <779b3811b04d18b861f14166b2f67ac402df7a88.1566313756.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566313756.git.dsterba@suse.com>
References: <cover.1566313756.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The set_level callbacks do not do anything special and can be replaced
by a helper that uses the levels defined in the tables.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 20 ++++++++++++++++++--
 fs/btrfs/compression.h |  9 ++-------
 fs/btrfs/lzo.c         |  6 ------
 fs/btrfs/zlib.c        |  9 ---------
 fs/btrfs/zstd.c        |  9 ---------
 5 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 60c47b417a4b..53376c640f61 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1039,7 +1039,7 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 	struct list_head *workspace;
 	int ret;
 
-	level = btrfs_compress_op[type]->set_level(level);
+	level = btrfs_compress_set_level(type, level);
 	workspace = get_workspace(type, level);
 	ret = btrfs_compress_op[type]->compress_pages(workspace, mapping,
 						      start, pages,
@@ -1611,7 +1611,23 @@ unsigned int btrfs_compress_str2level(unsigned int type, const char *str)
 			level = 0;
 	}
 
-	level = btrfs_compress_op[type]->set_level(level);
+	level = btrfs_compress_set_level(type, level);
+
+	return level;
+}
+
+/*
+ * Adjust @level according to the limits of the compression algorithm or
+ * fallback to default
+ */
+unsigned int btrfs_compress_get_level(int type, unsigned level)
+{
+	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
+
+	if (level == 0)
+		level = ops->default_level;
+	else
+		level = min(level, ops->max_level);
 
 	return level;
 }
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index cffd689adb6e..4cb8be9ff88b 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -156,13 +156,6 @@ struct btrfs_compress_op {
 			  unsigned long start_byte,
 			  size_t srclen, size_t destlen);
 
-	/*
-	 * This bounds the level set by the user to be within range of a
-	 * particular compression type.  It returns the level that will be used
-	 * if the level is out of bounds or the default if 0 is passed in.
-	 */
-	unsigned int (*set_level)(unsigned int level);
-
 	/* Maximum level supported by the compression algorithm */
 	unsigned int max_level;
 	unsigned int default_level;
@@ -179,6 +172,8 @@ extern const struct btrfs_compress_op btrfs_zstd_compress;
 const char* btrfs_compress_type2str(enum btrfs_compression_type type);
 bool btrfs_compress_is_valid_type(const char *str, size_t len);
 
+unsigned int btrfs_compress_set_level(int type, unsigned level);
+
 int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
 
 #endif
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index adac6cb30d65..acad4174f68d 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -507,11 +507,6 @@ static int lzo_decompress(struct list_head *ws, unsigned char *data_in,
 	return ret;
 }
 
-static unsigned int lzo_set_level(unsigned int level)
-{
-	return 0;
-}
-
 const struct btrfs_compress_op btrfs_lzo_compress = {
 	.init_workspace_manager	= lzo_init_workspace_manager,
 	.cleanup_workspace_manager = lzo_cleanup_workspace_manager,
@@ -522,7 +517,6 @@ const struct btrfs_compress_op btrfs_lzo_compress = {
 	.compress_pages		= lzo_compress_pages,
 	.decompress_bio		= lzo_decompress_bio,
 	.decompress		= lzo_decompress,
-	.set_level		= lzo_set_level,
 	.max_level		= 1,
 	.default_level		= 1,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 03d6c3683bd9..df1aace5df50 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -418,14 +418,6 @@ static int zlib_decompress(struct list_head *ws, unsigned char *data_in,
 	return ret;
 }
 
-static unsigned int zlib_set_level(unsigned int level)
-{
-	if (!level)
-		return BTRFS_ZLIB_DEFAULT_LEVEL;
-
-	return min_t(unsigned int, level, 9);
-}
-
 const struct btrfs_compress_op btrfs_zlib_compress = {
 	.init_workspace_manager	= zlib_init_workspace_manager,
 	.cleanup_workspace_manager = zlib_cleanup_workspace_manager,
@@ -436,7 +428,6 @@ const struct btrfs_compress_op btrfs_zlib_compress = {
 	.compress_pages		= zlib_compress_pages,
 	.decompress_bio		= zlib_decompress_bio,
 	.decompress		= zlib_decompress,
-	.set_level              = zlib_set_level,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
 };
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index b2b23a6a497d..0af4a5cd4313 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -710,14 +710,6 @@ static int zstd_decompress(struct list_head *ws, unsigned char *data_in,
 	return ret;
 }
 
-static unsigned int zstd_set_level(unsigned int level)
-{
-	if (!level)
-		return ZSTD_BTRFS_DEFAULT_LEVEL;
-
-	return min_t(unsigned int, level, ZSTD_BTRFS_MAX_LEVEL);
-}
-
 const struct btrfs_compress_op btrfs_zstd_compress = {
 	.init_workspace_manager = zstd_init_workspace_manager,
 	.cleanup_workspace_manager = zstd_cleanup_workspace_manager,
@@ -728,7 +720,6 @@ const struct btrfs_compress_op btrfs_zstd_compress = {
 	.compress_pages = zstd_compress_pages,
 	.decompress_bio = zstd_decompress_bio,
 	.decompress = zstd_decompress,
-	.set_level = zstd_set_level,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
 };
-- 
2.22.0

