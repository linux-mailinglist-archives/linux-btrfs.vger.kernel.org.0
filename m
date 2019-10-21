Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E11DFDF372
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfJUQpE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:45:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:52904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726847AbfJUQpE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6EE9AF9F;
        Mon, 21 Oct 2019 16:45:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2BB0CDA733; Mon, 21 Oct 2019 18:45:16 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: add member for a specific checksum driver
Date:   Mon, 21 Oct 2019 18:45:16 +0200
Message-Id: <90765e7b2ab6a42e88884f1ae2a2f50305264c80.1571674940.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571674940.git.dsterba@suse.com>
References: <cover.1571674940.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently all the checksum algorithms generate a fixed size digest size
and we use it.  The on-disk format can hold up to BTRFS_CSUM_SIZE bytes
and BLAKE2b produces digest of 512 bits by default. We can't do that and
will use the blake2b-256, this needs to be passed to the crypto API.

Separate that from the base algorithm name and add a member to request
specific driver, in this case with the digest size.

The only place that uses the driver name is the crypto API setup.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c   | 12 ++++++++++++
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c |  6 +++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c1561097e5a3..c211216b4524 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -32,6 +32,7 @@ static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
 static const struct btrfs_csums {
 	u16		size;
 	const char	*name;
+	const char	*driver;
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
@@ -53,6 +54,17 @@ const char *btrfs_super_csum_name(u16 csum_type)
 	return btrfs_csums[csum_type].name;
 }
 
+/*
+ * Return driver name if defined, otherwise the name that's also a valid driver
+ * name
+ */
+const char *btrfs_super_csum_driver(u16 csum_type)
+{
+	/* csum type is validated at mount time */
+	return btrfs_csums[csum_type].driver ?:
+		btrfs_csums[csum_type].name;
+}
+
 size_t __const btrfs_get_num_csums(void)
 {
 	return ARRAY_SIZE(btrfs_csums);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b17944995e09..4a842c0fa062 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2163,6 +2163,7 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
+const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __const btrfs_get_num_csums(void);
 
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 21fab336f8ca..948ed5ac0794 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2219,13 +2219,13 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 {
 	struct crypto_shash *csum_shash;
-	const char *csum_name = btrfs_super_csum_name(csum_type);
+	const char *csum_driver = btrfs_super_csum_driver(csum_type);
 
-	csum_shash = crypto_alloc_shash(csum_name, 0, 0);
+	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
 
 	if (IS_ERR(csum_shash)) {
 		btrfs_err(fs_info, "error allocating %s hash for checksum",
-			  csum_name);
+			  csum_driver);
 		return PTR_ERR(csum_shash);
 	}
 
-- 
2.23.0

