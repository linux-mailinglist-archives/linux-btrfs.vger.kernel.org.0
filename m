Return-Path: <linux-btrfs+bounces-19538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0693CA65AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 08:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62C0B3084CD2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3B2F3C3E;
	Fri,  5 Dec 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDIc5b3I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C832F5483;
	Fri,  5 Dec 2025 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918522; cv=none; b=Az3X1u7jjPDDlX1zZW2cKpUZa6UTv5P7imPQgEzIuHup+waddSEB3gMwdoqVvDe/8MYJt7lUtJrYNjKf7hP9zFKim1yvers20WuHl7wmhAeaimZwgpER8nNqXha5p2nybM/ETX6pOT6rqFhtcQXtz7HMEfwhLc4krQ30Dt3rJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918522; c=relaxed/simple;
	bh=wcKtzuNQstQtm7xjejYVUb6CkqP/umvDjH3sGgYob7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3BE072HTqGm2Km9uWd5xp+Q0oj/Pve4Dsely9xNiKpBiQCmLUp/9qV5shvGsDQQgAUk/U2KERqUuKj3HJH1eJBuzyi/l0VqL3H87cTwhpabTzGdcEoz6BuxBTcaluu5YUZvTT743kBZ0FaTAB8cbJUnAQ6/oLGKhhUTj8G8x98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDIc5b3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED89FC4CEF1;
	Fri,  5 Dec 2025 07:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764918522;
	bh=wcKtzuNQstQtm7xjejYVUb6CkqP/umvDjH3sGgYob7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=gDIc5b3IemU+09aEaIoMmZGVCIoPF2+TsCBlC2E/TgG1JvOQoCLPZC6kXp6lPkVmx
	 vPJQHoQqDoqSllOOX2xJWVAWrrVqz5YP7lLDzxqggD8EXVsHLkCMJGsgsPg9AsQZK5
	 AnJCUaJe21hnFc9kS7ppLljn7tZb0fO0nNuyFIIUtkVQH/W32aKQkB2fDsIRCMDgas
	 wEDViHRUZbieJRFYt8NkSdxKhAaR1YA5jGT2XcjP+q5mMrp5i/wE9iRS6Hz+NIIsXe
	 Hoq+2fCfr2IvWm+YRWLiWATgdPFAflrv2wKKvcKYwD622YK2rj3WMUJjLaWPLqzClZ
	 JvWLVWfg2MPrw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] btrfs: switch to library APIs for checksums
Date: Thu,  4 Dec 2025 23:04:54 -0800
Message-ID: <20251205070454.118592-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make btrfs use the library APIs instead of crypto_shash, for all
checksum computations.  This has many benefits:

- Allows future checksum types, e.g. XXH3 or CRC64, to be more easily
  supported.  Only a library API will be needed, not crypto_shash too.

- Eliminates the overhead of the generic crypto layer, including an
  indirect call for every function call and other API overhead.  A
  microbenchmark of btrfs_check_read_bio() with crc32c checksums shows a
  speedup from 658 cycles to 608 cycles per 4096-byte block.

- Decreases the stack usage of btrfs by reducing the size of checksum
  contexts from 384 bytes to 240 bytes, and by eliminating the need for
  some functions to declare a checksum context at all.

- Increases reliability.  The library functions always succeed and
  return void.  In contrast, crypto_shash can fail and return errors.
  Also, the library functions are guaranteed to be available when btrfs
  is loaded; there's no longer any need to use module softdeps to try to
  work around the crypto modules sometimes not being loaded.

- Fixes a bug where blake2b checksums didn't work on kernels booted with
  fips=1.  Since btrfs checksums are for integrity only, it's fine for
  them to use non-FIPS-approved algorithms.

Note that with having to handle 4 algorithms instead of just 1-2, this
commit does result in a slightly positive diffstat.  That being said,
this wouldn't have been the case if btrfs had actually checked for
errors from crypto_shash, which technically it should have been doing.

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

v2: rebased onto latest mainline, now that both the crypto library and
    btrfs pull requests for 6.19 have been merged

 fs/btrfs/Kconfig       |  8 ++--
 fs/btrfs/compression.c |  1 -
 fs/btrfs/disk-io.c     | 68 ++++++++----------------------
 fs/btrfs/file-item.c   |  4 --
 fs/btrfs/fs.c          | 96 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/fs.h          | 23 +++++++---
 fs/btrfs/inode.c       | 10 ++---
 fs/btrfs/scrub.c       | 16 +++----
 fs/btrfs/super.c       |  4 --
 fs/btrfs/sysfs.c       |  6 +--
 10 files changed, 133 insertions(+), 103 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 4438637c8900..bf7feff2fe44 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -2,24 +2,22 @@
 
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
 	select BLK_CGROUP_PUNT_BIO
 	select CRC32
-	select CRYPTO
-	select CRYPTO_CRC32C
-	select CRYPTO_XXHASH
-	select CRYPTO_SHA256
-	select CRYPTO_BLAKE2B
+	select CRYPTO_LIB_BLAKE2B
+	select CRYPTO_LIB_SHA256
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
 	select FS_IOMAP
 	select RAID6_PQ
 	select XOR_BLOCKS
+	select XXHASH
 	depends on PAGE_SIZE_LESS_THAN_256KB
 
 	help
 	  Btrfs is a general purpose copy-on-write filesystem with extents,
 	  writable snapshotting, support for multiple devices and many more
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7dda6cc68379..a3878e79f6df 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -19,11 +19,10 @@
 #include <linux/psi.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/log2.h>
 #include <linux/shrinker.h>
-#include <crypto/hash.h>
 #include "misc.h"
 #include "ctree.h"
 #include "fs.h"
 #include "btrfs_inode.h"
 #include "bio.h"
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 89149fac804c..401ede9da21e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -16,11 +16,10 @@
 #include <linux/semaphore.h>
 #include <linux/error-injection.h>
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
 #include <linux/unaligned.h>
-#include <crypto/hash.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
 #include "bio.h"
@@ -60,30 +59,23 @@
 				 BTRFS_SUPER_FLAG_METADUMP_V2)
 
 static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info);
 static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info);
 
-static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
-{
-	if (fs_info->csum_shash)
-		crypto_free_shash(fs_info->csum_shash);
-}
-
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  */
 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	int num_pages;
 	u32 first_page_part;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct btrfs_csum_ctx csum;
 	char *kaddr;
 	int i;
 
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
+	btrfs_csum_init(&csum, fs_info->csum_type);
 
 	if (buf->addr) {
 		/* Pages are contiguous, handle them as a big one. */
 		kaddr = buf->addr;
 		first_page_part = fs_info->nodesize;
@@ -92,25 +84,25 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 		kaddr = folio_address(buf->folios[0]);
 		first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
 		num_pages = num_extent_pages(buf);
 	}
 
-	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    first_page_part - BTRFS_CSUM_SIZE);
+	btrfs_csum_update(&csum, kaddr + BTRFS_CSUM_SIZE,
+			  first_page_part - BTRFS_CSUM_SIZE);
 
 	/*
 	 * Multiple single-page folios case would reach here.
 	 *
 	 * nodesize <= PAGE_SIZE and large folio all handled by above
-	 * crypto_shash_update() already.
+	 * btrfs_csum_update() already.
 	 */
 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
 		kaddr = folio_address(buf->folios[i]);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		btrfs_csum_update(&csum, kaddr, PAGE_SIZE);
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
-	crypto_shash_final(shash, result);
+	btrfs_csum_final(&csum, result);
 }
 
 /*
  * we can't consider a given block up to date unless the transid of the
  * block matches the transid in the parent node's pointer.  This is how we
@@ -158,22 +150,19 @@ static bool btrfs_supported_super_csum(u16 csum_type)
  * algorithm. Pass the raw disk superblock data.
  */
 int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 			   const struct btrfs_super_block *disk_sb)
 {
-	char result[BTRFS_CSUM_SIZE];
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-
-	shash->tfm = fs_info->csum_shash;
+	u8 result[BTRFS_CSUM_SIZE];
 
 	/*
 	 * The super_block structure does not span the whole
 	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space is
 	 * filled with zeros and is included in the checksum.
 	 */
-	crypto_shash_digest(shash, (const u8 *)disk_sb + BTRFS_CSUM_SIZE,
-			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
+	btrfs_csum(fs_info->csum_type, (const u8 *)disk_sb + BTRFS_CSUM_SIZE,
+		   BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, result);
 
 	if (memcmp(disk_sb->csum, result, fs_info->csum_size))
 		return 1;
 
 	return 0;
@@ -1249,11 +1238,10 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	percpu_counter_destroy(&fs_info->ordered_bytes);
 	if (percpu_counter_initialized(em_counter))
 		ASSERT(percpu_counter_sum_positive(em_counter) == 0);
 	percpu_counter_destroy(em_counter);
 	percpu_counter_destroy(&fs_info->dev_replace.bio_counter);
-	btrfs_free_csum_hash(fs_info);
 	btrfs_free_stripe_hash_table(fs_info);
 	btrfs_free_ref_cache(fs_info);
 	kfree(fs_info->balance_ctl);
 	kfree(fs_info->delayed_root);
 	free_global_roots(fs_info);
@@ -2003,25 +1991,12 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	}
 
 	return 0;
 }
 
-static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
+static void btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 {
-	struct crypto_shash *csum_shash;
-	const char *csum_driver = btrfs_super_csum_driver(csum_type);
-
-	csum_shash = crypto_alloc_shash(csum_driver, 0, 0);
-
-	if (IS_ERR(csum_shash)) {
-		btrfs_err(fs_info, "error allocating %s hash for checksum",
-			  csum_driver);
-		return PTR_ERR(csum_shash);
-	}
-
-	fs_info->csum_shash = csum_shash;
-
 	/* Check if the checksum implementation is a fast accelerated one. */
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
 		if (crc32_optimizations() & CRC32C_OPTIMIZATION)
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
@@ -2031,14 +2006,12 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 		break;
 	default:
 		break;
 	}
 
-	btrfs_info(fs_info, "using %s (%s) checksum algorithm",
-			btrfs_super_csum_name(csum_type),
-			crypto_shash_driver_name(csum_shash));
-	return 0;
+	btrfs_info(fs_info, "using %s checksum algorithm",
+		   btrfs_super_csum_name(csum_type));
 }
 
 static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 			    struct btrfs_fs_devices *fs_devices)
 {
@@ -3312,16 +3285,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_release_disk_super(disk_super);
 		goto fail_alloc;
 	}
 
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
+	fs_info->csum_type = csum_type;
 
-	ret = btrfs_init_csum_hash(fs_info, csum_type);
-	if (ret) {
-		btrfs_release_disk_super(disk_super);
-		goto fail_alloc;
-	}
+	btrfs_init_csum_hash(fs_info, csum_type);
 
 	/*
 	 * We want to check superblock checksum, the type is stored inside.
 	 * Pass the whole disk block of size BTRFS_SUPER_INFO_SIZE (4k).
 	 */
@@ -3711,22 +3681,19 @@ static void btrfs_end_super_write(struct bio *bio)
 static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct address_space *mapping = device->bdev->bd_mapping;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	int i;
 	int ret;
 	u64 bytenr, bytenr_orig;
 
 	atomic_set(&device->sb_write_errors, 0);
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
-	shash->tfm = fs_info->csum_shash;
-
 	for (i = 0; i < max_mirrors; i++) {
 		struct folio *folio;
 		struct bio *bio;
 		struct btrfs_super_block *disk_super;
 		size_t offset;
@@ -3746,13 +3713,12 @@ static int write_dev_supers(struct btrfs_device *device,
 		    device->commit_total_bytes)
 			break;
 
 		btrfs_set_super_bytenr(sb, bytenr_orig);
 
-		crypto_shash_digest(shash, (const char *)sb + BTRFS_CSUM_SIZE,
-				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
-				    sb->csum);
+		btrfs_csum(fs_info->csum_type, (const u8 *)sb + BTRFS_CSUM_SIZE,
+			   BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, sb->csum);
 
 		folio = __filemap_get_folio(mapping, bytenr >> PAGE_SHIFT,
 					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 					    GFP_NOFS);
 		if (IS_ERR(folio)) {
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 14e5257f0f04..568f0e0ebdf6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -6,11 +6,10 @@
 #include <linux/bio.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/sched/mm.h>
-#include <crypto/hash.h>
 #include "messages.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "bio.h"
@@ -767,11 +766,10 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 
 static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums = bbio->sums;
 	struct bvec_iter iter = *src;
 	phys_addr_t paddr;
 	const u32 blocksize = fs_info->sectorsize;
@@ -779,12 +777,10 @@ static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
 	const u32 nr_steps = blocksize / step;
 	phys_addr_t paddrs[BTRFS_MAX_BLOCKSIZE / PAGE_SIZE];
 	u32 offset = 0;
 	int index = 0;
 
-	shash->tfm = fs_info->csum_shash;
-
 	btrfs_bio_for_each_block(paddr, bio, &iter, step) {
 		paddrs[(offset / step) % nr_steps] = paddr;
 		offset += step;
 
 		if (IS_ALIGNED(offset, blocksize)) {
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index feb0a2faa837..fe0502751397 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -1,22 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/crc32.h>
 #include "messages.h"
 #include "fs.h"
 #include "accessors.h"
 #include "volumes.h"
 
 static const struct btrfs_csums {
 	u16		size;
 	const char	name[10];
-	const char	driver[12];
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
 	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
-	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
-				     .driver = "blake2b-256" },
+	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b" },
 };
 
 /* This exists for btrfs-progs usages. */
 u16 btrfs_csum_type_size(u16 type)
 {
@@ -35,25 +34,94 @@ const char *btrfs_super_csum_name(u16 csum_type)
 {
 	/* csum type is validated at mount time. */
 	return btrfs_csums[csum_type].name;
 }
 
-/*
- * Return driver name if defined, otherwise the name that's also a valid driver
- * name.
- */
-const char *btrfs_super_csum_driver(u16 csum_type)
+size_t __attribute_const__ btrfs_get_num_csums(void)
 {
-	/* csum type is validated at mount time */
-	return btrfs_csums[csum_type].driver[0] ?
-		btrfs_csums[csum_type].driver :
-		btrfs_csums[csum_type].name;
+	return ARRAY_SIZE(btrfs_csums);
 }
 
-size_t __attribute_const__ btrfs_get_num_csums(void)
+void btrfs_csum(u16 csum_type, const u8 *data, size_t len, u8 *out)
 {
-	return ARRAY_SIZE(btrfs_csums);
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		put_unaligned_le32(~crc32c(~0, data, len), out);
+		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		put_unaligned_le64(xxh64(data, len, 0), out);
+		break;
+	case BTRFS_CSUM_TYPE_SHA256:
+		sha256(data, len, out);
+		break;
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		blake2b(NULL, 0, data, len, out, 32);
+		break;
+	default:
+		BUG(); /* csum type is validated at mount time. */
+	}
+}
+
+void btrfs_csum_init(struct btrfs_csum_ctx *ctx, u16 csum_type)
+{
+	ctx->csum_type = csum_type;
+	switch (ctx->csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		ctx->crc32 = ~0;
+		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		xxh64_reset(&ctx->xxh64, 0);
+		break;
+	case BTRFS_CSUM_TYPE_SHA256:
+		sha256_init(&ctx->sha256);
+		break;
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		blake2b_init(&ctx->blake2b, 32);
+		break;
+	default:
+		BUG(); /* csum type is validated at mount time. */
+	}
+}
+
+void btrfs_csum_update(struct btrfs_csum_ctx *ctx, const u8 *data, size_t len)
+{
+	switch (ctx->csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		ctx->crc32 = crc32c(ctx->crc32, data, len);
+		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		xxh64_update(&ctx->xxh64, data, len);
+		break;
+	case BTRFS_CSUM_TYPE_SHA256:
+		sha256_update(&ctx->sha256, data, len);
+		break;
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		blake2b_update(&ctx->blake2b, data, len);
+		break;
+	default:
+		BUG(); /* csum type is validated at mount time. */
+	}
+}
+
+void btrfs_csum_final(struct btrfs_csum_ctx *ctx, u8 *out)
+{
+	switch (ctx->csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		put_unaligned_le32(~ctx->crc32, out);
+		break;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		put_unaligned_le64(xxh64_digest(&ctx->xxh64), out);
+		break;
+	case BTRFS_CSUM_TYPE_SHA256:
+		sha256_final(&ctx->sha256, out);
+		break;
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		blake2b_final(&ctx->blake2b, out);
+		break;
+	default:
+		BUG(); /* csum type is validated at mount time. */
+	}
 }
 
 /*
  * We support the following block sizes for all systems:
  *
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0f7e1ef27891..6e67057bd30f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include <crypto/blake2b.h>
+#include <crypto/sha2.h>
 #include <linux/blkdev.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
 #include <linux/compiler.h>
 #include <linux/math.h>
@@ -22,10 +24,11 @@
 #include <linux/workqueue.h>
 #include <linux/wait.h>
 #include <linux/wait_bit.h>
 #include <linux/sched.h>
 #include <linux/rbtree.h>
+#include <linux/xxhash.h>
 #include <uapi/linux/btrfs.h>
 #include <uapi/linux/btrfs_tree.h>
 #include "extent-io-tree.h"
 #include "async-thread.h"
 #include "block-rsv.h"
@@ -33,11 +36,10 @@
 
 struct inode;
 struct super_block;
 struct kobject;
 struct reloc_control;
-struct crypto_shash;
 struct ulist;
 struct btrfs_device;
 struct btrfs_block_group;
 struct btrfs_root;
 struct btrfs_fs_devices;
@@ -840,13 +842,14 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	/* ilog2 of sectorsize, use to avoid 64bit division */
 	u32 sectorsize_bits;
 	u32 block_min_order;
 	u32 block_max_order;
+	u32 stripesize;
 	u32 csum_size;
 	u32 csums_per_leaf;
-	u32 stripesize;
+	u16 csum_type;
 
 	/*
 	 * Maximum size of an extent. BTRFS_MAX_EXTENT_SIZE on regular
 	 * filesystem, on zoned it depends on the device constraints.
 	 */
@@ -854,12 +857,10 @@ struct btrfs_fs_info {
 
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
 
-	struct crypto_shash *csum_shash;
-
 	/* Type of exclusive operation running, protected by super_lock */
 	enum btrfs_exclusive_operation exclusive_operation;
 
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
@@ -1047,12 +1048,24 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args *vol_args);
 
 u16 btrfs_csum_type_size(u16 type);
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
-const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
+struct btrfs_csum_ctx {
+	u16 csum_type;
+	union {
+		u32 crc32;
+		struct xxh64_state xxh64;
+		struct sha256_ctx sha256;
+		struct blake2b_ctx blake2b;
+	};
+};
+void btrfs_csum(u16 csum_type, const u8 *data, size_t len, u8 *out);
+void btrfs_csum_init(struct btrfs_csum_ctx *ctx, u16 csum_type);
+void btrfs_csum_update(struct btrfs_csum_ctx *ctx, const u8 *data, size_t len);
+void btrfs_csum_final(struct btrfs_csum_ctx *ctx, u8 *out);
 
 static inline bool btrfs_is_empty_uuid(const u8 *uuid)
 {
 	return uuid_is_null((const uuid_t *)uuid);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4bee47829ed..873851a1a354 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Oracle.  All rights reserved.
  */
 
-#include <crypto/hash.h>
 #include <linux/kernel.h>
 #include <linux/bio.h>
 #include <linux/blk-cgroup.h>
 #include <linux/file.h>
 #include <linux/fs.h>
@@ -3392,24 +3391,23 @@ void btrfs_calculate_block_csum_pages(struct btrfs_fs_info *fs_info,
 				      const phys_addr_t paddrs[], u8 *dest)
 {
 	const u32 blocksize = fs_info->sectorsize;
 	const u32 step = min(blocksize, PAGE_SIZE);
 	const u32 nr_steps = blocksize / step;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct btrfs_csum_ctx csum;
 
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
+	btrfs_csum_init(&csum, fs_info->csum_type);
 	for (int i = 0; i < nr_steps; i++) {
 		const phys_addr_t paddr = paddrs[i];
 		void *kaddr;
 
 		ASSERT(offset_in_page(paddr) + step <= PAGE_SIZE);
 		kaddr = kmap_local_page(phys_to_page(paddr)) + offset_in_page(paddr);
-		crypto_shash_update(shash, kaddr, step);
+		btrfs_csum_update(&csum, kaddr, step);
 		kunmap_local(kaddr);
 	}
-	crypto_shash_final(shash, dest);
+	btrfs_csum_final(&csum, dest);
 }
 
 /*
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a40ee41f42c6..1a60e631d801 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4,11 +4,10 @@
  */
 
 #include <linux/blkdev.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/mm.h>
-#include <crypto/hash.h>
 #include "ctree.h"
 #include "discard.h"
 #include "volumes.h"
 #include "disk-io.h"
 #include "ordered-data.h"
@@ -716,11 +715,11 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
 	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
 	void *first_kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
 	struct btrfs_header *header = first_kaddr;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct btrfs_csum_ctx csum;
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 
 	/*
 	 * Here we don't have a good way to attach the pages (and subpages)
@@ -758,21 +757,20 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 			      header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
 		return;
 	}
 
 	/* Now check tree block csum. */
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-	crypto_shash_update(shash, first_kaddr + BTRFS_CSUM_SIZE,
-			    fs_info->sectorsize - BTRFS_CSUM_SIZE);
+	btrfs_csum_init(&csum, fs_info->csum_type);
+	btrfs_csum_update(&csum, first_kaddr + BTRFS_CSUM_SIZE,
+			  fs_info->sectorsize - BTRFS_CSUM_SIZE);
 
 	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
-		crypto_shash_update(shash, scrub_stripe_get_kaddr(stripe, i),
-				    fs_info->sectorsize);
+		btrfs_csum_update(&csum, scrub_stripe_get_kaddr(stripe, i),
+				  fs_info->sectorsize);
 	}
 
-	crypto_shash_final(shash, calculated_csum);
+	btrfs_csum_final(&csum, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, fs_info->csum_size) != 0) {
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
 "scrub: tree block %llu mirror %u has bad csum, has " BTRFS_CSUM_FMT " want " BTRFS_CSUM_FMT,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1999533b52be..a37b71091014 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2700,9 +2700,5 @@ static int __init init_btrfs_fs(void)
 late_initcall(init_btrfs_fs);
 module_exit(exit_btrfs_fs)
 
 MODULE_DESCRIPTION("B-Tree File System (BTRFS)");
 MODULE_LICENSE("GPL");
-MODULE_SOFTDEP("pre: crc32c");
-MODULE_SOFTDEP("pre: xxhash64");
-MODULE_SOFTDEP("pre: sha256");
-MODULE_SOFTDEP("pre: blake2b-256");
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 1f64c132b387..7f00e4babbc1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -9,11 +9,10 @@
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/string_choices.h>
-#include <crypto/hash.h>
 #include "messages.h"
 #include "ctree.h"
 #include "discard.h"
 #include "disk-io.h"
 #include "send.h"
@@ -1302,14 +1301,13 @@ BTRFS_ATTR(, metadata_uuid, btrfs_metadata_uuid_show);
 static ssize_t btrfs_checksum_show(struct kobject *kobj,
 				   struct kobj_attribute *a, char *buf)
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+	const char *csum_name = btrfs_super_csum_name(csum_type);
 
-	return sysfs_emit(buf, "%s (%s)\n",
-			  btrfs_super_csum_name(csum_type),
-			  crypto_shash_driver_name(fs_info->csum_shash));
+	return sysfs_emit(buf, "%s (%s-lib)\n", csum_name, csum_name);
 }
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
 
 static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,

base-commit: 43dfc13ca972988e620a6edb72956981b75ab6b0
-- 
2.52.0


