Return-Path: <linux-btrfs+bounces-17991-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A47CBEC7A1
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 06:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0C86E21B2
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Oct 2025 04:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4229D291;
	Sat, 18 Oct 2025 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgqIPCqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436AF29994B;
	Sat, 18 Oct 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760762185; cv=none; b=Nedg6ANLjDLSM8b8aF32YP2mDkv8j8UAX8vnR/OevnaKFtjKwN7LcipEOcb6drRvlOZZ/f7fudSPLA22dQBBQegu/nq6vOfQa/yd7qQTv6Jr6eGC+agmunbDdusufEtaGlKtXQtemcT7nuaNhp/xQCFdxqnfEzTHrSGzUOKsRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760762185; c=relaxed/simple;
	bh=vFvFkmsCdwR8L7IaJo5OBuHMMNgjBcy8QSOn4h1Dtzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcSjxvRYWuw7Vukt7YzVPoTpsOG5FRKfls1CixADBGgCCttJp7+cva3uWHbpBaow9relUkF8FlYgTspc030b3oBT9gdc7eT1Thcgj6r3LbRAy0Y8BFZxqJZZ/ryoCjr4Smo5/VxvUtXyYXEAY0UkDBBD5fS1u5QVDYwnhimqro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgqIPCqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF24C19421;
	Sat, 18 Oct 2025 04:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760762184;
	bh=vFvFkmsCdwR8L7IaJo5OBuHMMNgjBcy8QSOn4h1Dtzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgqIPCqfmKlOsc6LaducZZmFz94zAy1PQpy5CfRMvlJh/AMeIT1iYi74/rKFvCPz2
	 XghZwcTT66lYaQlFDJGIN3eA3C8sdHr3dGBhpnESlb2F+1izhwSqZL0gFovtVWVOJE
	 aDs0Wc8qwlu9exU+ioyPtS4XDMiZR9UEJQLUjkLkWS9egR9T+l1hDKVHOA41zzVuXU
	 yFI43CEozBC6+h5qHfyDewvI/XWmMHMR/XCnMoWuGKuTUyXgUlGhCNJTCJzsbBQU1U
	 HJSXk6gRW3PV4d0gvRV7HOLa/HkUF82bAGMQLGJBFEyjsHM5B70bOHliEnMnj11ZW0
	 LvfZePl/9DtSg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 10/10] btrfs: switch to library APIs for checksums
Date: Fri, 17 Oct 2025 21:31:06 -0700
Message-ID: <20251018043106.375964-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251018043106.375964-1-ebiggers@kernel.org>
References: <20251018043106.375964-1-ebiggers@kernel.org>
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

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig         |  2 -
 fs/btrfs/Kconfig       |  8 ++--
 fs/btrfs/compression.c |  1 -
 fs/btrfs/disk-io.c     | 68 ++++++++---------------------
 fs/btrfs/file-item.c   |  4 --
 fs/btrfs/fs.c          | 97 ++++++++++++++++++++++++++++++++++++------
 fs/btrfs/fs.h          | 23 +++++++---
 fs/btrfs/inode.c       | 13 +++---
 fs/btrfs/scrub.c       | 16 +++----
 fs/btrfs/super.c       |  4 --
 fs/btrfs/sysfs.c       |  6 +--
 11 files changed, 136 insertions(+), 106 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 0a7e74ac870b0..cb2a1325d6c0a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -892,12 +892,10 @@ config CRYPTO_BLAKE2B
 	  - blake2b-160
 	  - blake2b-256
 	  - blake2b-384
 	  - blake2b-512
 
-	  Used by the btrfs filesystem.
-
 	  See https://blake2.net for further information.
 
 config CRYPTO_CMAC
 	tristate "CMAC (Cipher-based MAC)"
 	select CRYPTO_HASH
diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 4438637c8900c..bf7feff2fe44d 100644
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
index bacad18357b33..12c41a3ce705f 100644
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
index 0aa7e5d1b05f6..fc02e5483071e 100644
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
@@ -59,30 +58,23 @@
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
@@ -91,25 +83,25 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
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
@@ -157,22 +149,19 @@ static bool btrfs_supported_super_csum(u16 csum_type)
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
@@ -1254,11 +1243,10 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
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
@@ -2013,25 +2001,12 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
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
@@ -2041,14 +2016,12 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
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
@@ -3328,16 +3301,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
@@ -3727,22 +3697,19 @@ static void btrfs_end_super_write(struct bio *bio)
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
@@ -3762,13 +3729,12 @@ static int write_dev_supers(struct btrfs_device *device,
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
index a42e6d54e7cd7..b886306721b3b 100644
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
@@ -770,11 +769,10 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 {
 	struct btrfs_ordered_extent *ordered = bbio->ordered;
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
 	struct bvec_iter iter = bio->bi_iter;
 	phys_addr_t paddr;
 	const u32 blocksize = fs_info->sectorsize;
@@ -793,12 +791,10 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	INIT_LIST_HEAD(&sums->list);
 
 	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	index = 0;
 
-	shash->tfm = fs_info->csum_shash;
-
 	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
 		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
 		index += fs_info->csum_size;
 	}
 
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index feb0a2faa8379..211ed50e96f33 100644
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
@@ -35,25 +34,95 @@ const char *btrfs_super_csum_name(u16 csum_type)
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
+
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
index 814bbc9417d2a..3fd9cb25379aa 100644
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
@@ -22,21 +24,21 @@
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
@@ -827,13 +829,14 @@ struct btrfs_fs_info {
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
@@ -841,12 +844,10 @@ struct btrfs_fs_info {
 
 	/* Block groups and devices containing active swapfiles. */
 	spinlock_t swapfile_pins_lock;
 	struct rb_root swapfile_pins;
 
-	struct crypto_shash *csum_shash;
-
 	/* Type of exclusive operation running, protected by super_lock */
 	enum btrfs_exclusive_operation exclusive_operation;
 
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
@@ -1034,12 +1035,24 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
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
index 3b1b3a0553eea..f2aee871d660a 100644
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
@@ -3333,33 +3332,33 @@ int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered)
 void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr,
 				u8 *dest)
 {
 	struct folio *folio = page_folio(phys_to_page(paddr));
 	const u32 blocksize = fs_info->sectorsize;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	struct btrfs_csum_ctx csum;
 
-	shash->tfm = fs_info->csum_shash;
 	/* The full block must be inside the folio. */
 	ASSERT(offset_in_folio(folio, paddr) + blocksize <= folio_size(folio));
 
 	if (folio_test_partial_kmap(folio)) {
 		size_t cur = paddr;
 
-		crypto_shash_init(shash);
+		btrfs_csum_init(&csum, fs_info->csum_type);
 		while (cur < paddr + blocksize) {
 			void *kaddr;
 			size_t len = min(paddr + blocksize - cur,
 					 PAGE_SIZE - offset_in_page(cur));
 
 			kaddr = kmap_local_folio(folio, offset_in_folio(folio, cur));
-			crypto_shash_update(shash, kaddr, len);
+			btrfs_csum_update(&csum, kaddr, len);
 			kunmap_local(kaddr);
 			cur += len;
 		}
-		crypto_shash_final(shash, dest);
+		btrfs_csum_final(&csum, dest);
 	} else {
-		crypto_shash_digest(shash, phys_to_virt(paddr), blocksize, dest);
+		btrfs_csum(fs_info->csum_type, phys_to_virt(paddr), blocksize,
+			   dest);
 	}
 }
 /*
  * Verify the checksum for a single sector without any extra action that depend
  * on the type of I/O.
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4691d0bdb2e86..38b2ee1c455aa 100644
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
@@ -718,11 +717,11 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
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
@@ -760,21 +759,20 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
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
 "scrub: tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d6e496436539d..e17b2f6b08a62 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2636,9 +2636,5 @@ static int __init init_btrfs_fs(void)
 late_initcall(init_btrfs_fs);
 module_exit(exit_btrfs_fs)
 
 MODULE_DESCRIPTION("B-Tree File System (BTRFS)");
 MODULE_LICENSE("GPL");
-MODULE_SOFTDEP("pre: crc32c");
-MODULE_SOFTDEP("pre: xxhash64");
-MODULE_SOFTDEP("pre: sha256");
-MODULE_SOFTDEP("pre: blake2b-256");
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 81f52c1f55ce5..6321c7836e4fe 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -8,11 +8,10 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/completion.h>
 #include <linux/bug.h>
 #include <linux/list.h>
-#include <crypto/hash.h>
 #include "messages.h"
 #include "ctree.h"
 #include "discard.h"
 #include "disk-io.h"
 #include "send.h"
@@ -1250,14 +1249,13 @@ BTRFS_ATTR(, metadata_uuid, btrfs_metadata_uuid_show);
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
-- 
2.51.1.dirty


