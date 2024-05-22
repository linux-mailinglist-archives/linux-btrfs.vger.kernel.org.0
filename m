Return-Path: <linux-btrfs+bounces-5191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C68CBAEE
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65FA1F225E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2C78C9A;
	Wed, 22 May 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IsGRBS0f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B378C83
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357833; cv=none; b=r7dKApXZmQJtbFnnawIEjHJeWxZTVsdipMaJDGRQMQk2U/geNN5O8893irNxDx1zLaLVrSPKLWWtQyjoUc9A+R5xDFh6IvM2/KSlcZTLwrfQ9IenoA+fqpt6jgrhzY3YXBwSJbGA5h+o4R9s5bKuEBssy3eFEEM52UVt1ckVun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357833; c=relaxed/simple;
	bh=n+5xSJcL+VuS5aRFWqkQXOLHbXD/Z38/eAHI0/C0xJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CBH3UcorjVWyef3gRp53yS4PVYLl4Ogq6nW0tr7LZscm5eDjFd8KmcI8D6no+3F5oUbasTeiUU6ULb6bLSL+tt0Dhm9zHGDoCoIMpqGNIiYXlndMAsDeQEg1ONtngBA5NDKz+IU6v3iwsXp1lNUEmszricFJ6TiFLJ72wZHB7YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IsGRBS0f; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357831; x=1747893831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n+5xSJcL+VuS5aRFWqkQXOLHbXD/Z38/eAHI0/C0xJs=;
  b=IsGRBS0fGvPAo0zE+a49gQASg81bkXdf+ePazHsi/vxpM/5jdrrkVYOj
   ocbZ5QpkVVIe4myDPfvR7wY9IFVIXYHyP0BQCg3g/yjVDCzBmsWiqpBC+
   day6eu99e7Iz5zYofKXi2slEx3A+ZXY0msBHXS0hHm90ohZ5ZlXXJ7zC3
   G1Obj/SdlBLlgwr6mAri9CFWiFhyk93h1v2luMO2MeE0R6Vpvc+iaqIIi
   lE9Ldah+adyrXD0G9GdMkeLFRy9Sodagk/6JvZzZv4CBTE8Rfi6U0zvUR
   Q7R5ZqlOOkfI4MRpecuqXCUcCLkVE4CRQ6l45GDomSpyJ1ysWsz1WPCsk
   g==;
X-CSE-ConnectionGUID: Ovuvk8htQpWhKgj6Bxj53A==
X-CSE-MsgGUID: wbZgPC8HRp6uMjYcSX1Emg==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17170967"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:42 +0800
IronPort-SDR: 664d7d1f_1/e5l3AgLdXghWm1HUAs1K+uJtB6boRfhfA2ERg1MZr37fw
 4mOZ/bzfAxinGqrVhYe9SFY5iK7WCFq6++NIlSw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:35 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:39 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 01/10] btrfs-progs: rename block_count to byte_count
Date: Wed, 22 May 2024 15:02:23 +0900
Message-ID: <20240522060232.3569226-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

block_count and dev_block_count are counting the size in bytes. And,
comparing them with e.g, "min_dev_size" is confusing. Rename them to
represent the unit better.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 28 +++++++++++-----------
 mkfs/main.c           | 56 +++++++++++++++++++++----------------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index d086e9ea2564..86942e0c7041 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -222,11 +222,11 @@ out:
  * - reset zones
  * - delete end of the device
  */
-int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
-		u64 max_block_count, unsigned opflags)
+int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
+		u64 max_byte_count, unsigned opflags)
 {
 	struct btrfs_zoned_device_info *zinfo = NULL;
-	u64 block_count;
+	u64 byte_count;
 	struct stat st;
 	int i, ret;
 
@@ -236,13 +236,13 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		return 1;
 	}
 
-	block_count = device_get_partition_size_fd_stat(fd, &st);
-	if (block_count == 0) {
+	byte_count = device_get_partition_size_fd_stat(fd, &st);
+	if (byte_count == 0) {
 		error("unable to determine size of %s", file);
 		return 1;
 	}
-	if (max_block_count)
-		block_count = min(block_count, max_block_count);
+	if (max_byte_count)
+		byte_count = min(byte_count, max_byte_count);
 
 	if (opflags & PREP_DEVICE_ZONED) {
 		ret = btrfs_get_zone_info(fd, file, &zinfo);
@@ -276,18 +276,18 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		if (discard_supported(file)) {
 			if (opflags & PREP_DEVICE_VERBOSE)
 				printf("Performing full device TRIM %s (%s) ...\n",
-						file, pretty_size(block_count));
-			device_discard_blocks(fd, 0, block_count);
+						file, pretty_size(byte_count));
+			device_discard_blocks(fd, 0, byte_count);
 		}
 	}
 
-	ret = zero_dev_clamped(fd, zinfo, 0, ZERO_DEV_BYTES, block_count);
+	ret = zero_dev_clamped(fd, zinfo, 0, ZERO_DEV_BYTES, byte_count);
 	for (i = 0 ; !ret && i < BTRFS_SUPER_MIRROR_MAX; i++)
 		ret = zero_dev_clamped(fd, zinfo, btrfs_sb_offset(i),
-				       BTRFS_SUPER_INFO_SIZE, block_count);
+				       BTRFS_SUPER_INFO_SIZE, byte_count);
 	if (!ret && (opflags & PREP_DEVICE_ZERO_END))
-		ret = zero_dev_clamped(fd, zinfo, block_count - ZERO_DEV_BYTES,
-				       ZERO_DEV_BYTES, block_count);
+		ret = zero_dev_clamped(fd, zinfo, byte_count - ZERO_DEV_BYTES,
+				       ZERO_DEV_BYTES, byte_count);
 
 	if (ret < 0) {
 		errno = -ret;
@@ -302,7 +302,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	}
 
 	free(zinfo);
-	*block_count_ret = block_count;
+	*byte_count_ret = byte_count;
 	return 0;
 
 err:
diff --git a/mkfs/main.c b/mkfs/main.c
index a467795d4428..950f76101058 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -80,8 +80,8 @@ static int opt_oflags = O_RDWR;
 struct prepare_device_progress {
 	int fd;
 	char *file;
-	u64 dev_block_count;
-	u64 block_count;
+	u64 dev_byte_count;
+	u64 byte_count;
 	int ret;
 };
 
@@ -1159,8 +1159,8 @@ static void *prepare_one_device(void *ctx)
 	}
 	prepare_ctx->ret = btrfs_prepare_device(prepare_ctx->fd,
 				prepare_ctx->file,
-				&prepare_ctx->dev_block_count,
-				prepare_ctx->block_count,
+				&prepare_ctx->dev_byte_count,
+				prepare_ctx->byte_count,
 				(bconf.verbose ? PREP_DEVICE_VERBOSE : 0) |
 				(opt_zero_end ? PREP_DEVICE_ZERO_END : 0) |
 				(opt_discard ? PREP_DEVICE_DISCARD : 0) |
@@ -1204,8 +1204,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	bool metadata_profile_set = false;
 	u64 data_profile = 0;
 	bool data_profile_set = false;
-	u64 block_count = 0;
-	u64 dev_block_count = 0;
+	u64 byte_count = 0;
+	u64 dev_byte_count = 0;
 	bool mixed = false;
 	char *label = NULL;
 	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
@@ -1347,7 +1347,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				sectorsize = arg_strtou64_with_suffix(optarg);
 				break;
 			case 'b':
-				block_count = arg_strtou64_with_suffix(optarg);
+				byte_count = arg_strtou64_with_suffix(optarg);
 				opt_zero_end = false;
 				break;
 			case 'v':
@@ -1623,34 +1623,34 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		 * Block_count not specified, use file/device size first.
 		 * Or we will always use source_dir_size calculated for mkfs.
 		 */
-		if (!block_count)
-			block_count = device_get_partition_size_fd_stat(fd, &statbuf);
+		if (!byte_count)
+			byte_count = device_get_partition_size_fd_stat(fd, &statbuf);
 		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
 				min_dev_size, metadata_profile, data_profile);
-		if (block_count < source_dir_size) {
+		if (byte_count < source_dir_size) {
 			if (S_ISREG(statbuf.st_mode)) {
-				block_count = source_dir_size;
+				byte_count = source_dir_size;
 			} else {
 				warning(
 "the target device %llu (%s) is smaller than the calculated source directory size %llu (%s), mkfs may fail",
-					block_count, pretty_size(block_count),
+					byte_count, pretty_size(byte_count),
 					source_dir_size, pretty_size(source_dir_size));
 			}
 		}
-		ret = zero_output_file(fd, block_count);
+		ret = zero_output_file(fd, byte_count);
 		if (ret) {
 			error("unable to zero the output file");
 			close(fd);
 			goto error;
 		}
 		/* our "device" is the new image file */
-		dev_block_count = block_count;
+		dev_byte_count = byte_count;
 		close(fd);
 	}
-	/* Check device/block_count after the nodesize is determined */
-	if (block_count && block_count < min_dev_size) {
+	/* Check device/byte_count after the nodesize is determined */
+	if (byte_count && byte_count < min_dev_size) {
 		error("size %llu is too small to make a usable filesystem",
-			block_count);
+			byte_count);
 		error("minimum size for btrfs filesystem is %llu",
 			min_dev_size);
 		goto error;
@@ -1661,9 +1661,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	 * 1 zone for a metadata block group
 	 * 1 zone for a data block group
 	 */
-	if (opt_zoned && block_count && block_count < 5 * zone_size(file)) {
+	if (opt_zoned && byte_count && byte_count < 5 * zone_size(file)) {
 		error("size %llu is too small to make a usable filesystem",
-			block_count);
+			byte_count);
 		error("minimum size for a zoned btrfs filesystem is %llu",
 			min_dev_size);
 		goto error;
@@ -1741,8 +1741,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	/* Start threads */
 	for (i = 0; i < device_count; i++) {
 		prepare_ctx[i].file = argv[optind + i - 1];
-		prepare_ctx[i].block_count = block_count;
-		prepare_ctx[i].dev_block_count = block_count;
+		prepare_ctx[i].byte_count = byte_count;
+		prepare_ctx[i].dev_byte_count = byte_count;
 		ret = pthread_create(&t_prepare[i], NULL, prepare_one_device,
 				     &prepare_ctx[i]);
 		if (ret) {
@@ -1763,16 +1763,16 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	dev_block_count = prepare_ctx[0].dev_block_count;
-	if (block_count && block_count > dev_block_count) {
+	dev_byte_count = prepare_ctx[0].dev_byte_count;
+	if (byte_count && byte_count > dev_byte_count) {
 		error("%s is smaller than requested size, expected %llu, found %llu",
-		      file, block_count, dev_block_count);
+		      file, byte_count, dev_byte_count);
 		goto error;
 	}
 
 	/* To create the first block group and chunk 0 in make_btrfs */
 	system_group_size = (opt_zoned ? zone_size(file) : BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	if (dev_block_count < system_group_size) {
+	if (dev_byte_count < system_group_size) {
 		error("device is too small to make filesystem, must be at least %llu",
 				system_group_size);
 		goto error;
@@ -1794,7 +1794,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.label = label;
 	memcpy(mkfs_cfg.fs_uuid, fs_uuid, sizeof(mkfs_cfg.fs_uuid));
 	memcpy(mkfs_cfg.dev_uuid, dev_uuid, sizeof(mkfs_cfg.dev_uuid));
-	mkfs_cfg.num_bytes = dev_block_count;
+	mkfs_cfg.num_bytes = dev_byte_count;
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
@@ -1889,7 +1889,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				file);
 			continue;
 		}
-		dev_block_count = prepare_ctx[i].dev_block_count;
+		dev_byte_count = prepare_ctx[i].dev_byte_count;
 
 		if (prepare_ctx[i].ret) {
 			errno = -prepare_ctx[i].ret;
@@ -1898,7 +1898,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 
 		ret = btrfs_add_to_fsid(trans, root, prepare_ctx[i].fd,
-					prepare_ctx[i].file, dev_block_count,
+					prepare_ctx[i].file, dev_byte_count,
 					sectorsize, sectorsize, sectorsize);
 		if (ret) {
 			error("unable to add %s to filesystem: %d",
-- 
2.45.1


