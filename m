Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097549660F
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfHTQRA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:17:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:57532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbfHTQQ7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:16:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EE4EEAD2B
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:16:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 594EFDA7DA; Tue, 20 Aug 2019 18:17:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/2] btrfs: define compression levels statically
Date:   Tue, 20 Aug 2019 18:17:25 +0200
Message-Id: <d4972ff57eb3ef57c616f5f7545f92d0cab7e12e.1566313756.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566313756.git.dsterba@suse.com>
References: <cover.1566313756.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The maximum and default levels do not change and can be defined
directly. The set_level callback was a temporary solution and will be
removed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.h | 4 ++++
 fs/btrfs/lzo.c         | 2 ++
 fs/btrfs/zlib.c        | 2 ++
 fs/btrfs/zstd.c        | 2 ++
 4 files changed, 10 insertions(+)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 2035b8eb1290..cffd689adb6e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -162,6 +162,10 @@ struct btrfs_compress_op {
 	 * if the level is out of bounds or the default if 0 is passed in.
 	 */
 	unsigned int (*set_level)(unsigned int level);
+
+	/* Maximum level supported by the compression algorithm */
+	unsigned int max_level;
+	unsigned int default_level;
 };
 
 /* The heuristic workspaces are managed via the 0th workspace manager */
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 579d53ae256f..adac6cb30d65 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -523,4 +523,6 @@ const struct btrfs_compress_op btrfs_lzo_compress = {
 	.decompress_bio		= lzo_decompress_bio,
 	.decompress		= lzo_decompress,
 	.set_level		= lzo_set_level,
+	.max_level		= 1,
+	.default_level		= 1,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index b86b7ad6b900..03d6c3683bd9 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -437,4 +437,6 @@ const struct btrfs_compress_op btrfs_zlib_compress = {
 	.decompress_bio		= zlib_decompress_bio,
 	.decompress		= zlib_decompress,
 	.set_level              = zlib_set_level,
+	.max_level		= 9,
+	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
 };
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 3837ca180d52..b2b23a6a497d 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -729,4 +729,6 @@ const struct btrfs_compress_op btrfs_zstd_compress = {
 	.decompress_bio = zstd_decompress_bio,
 	.decompress = zstd_decompress,
 	.set_level = zstd_set_level,
+	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
+	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
 };
-- 
2.22.0

