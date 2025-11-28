Return-Path: <linux-btrfs+bounces-19409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07717C9243E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C6E7F35140A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5062737F8;
	Fri, 28 Nov 2025 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4sIV8Jd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A068260580;
	Fri, 28 Nov 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339322; cv=none; b=LZQzECABurCRfwrn0P5tHGoC7cGQuuq6MmIc2PxHkch7u3elpokfuIuM0V20vVZM+MLvu8zAPIgnf8Zr7CUSx4SriI2jsaJplmzbRdjdSnJGLb9JF8rjnnhCZsJCLb+wH2PgyaEo8IjUgdZxuMJgSkhpgl4fX87No5L7HBRFgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339322; c=relaxed/simple;
	bh=ruj5zM5qASld8SX1NDCud/BfQxCfcav3Zti/HDOC92c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKkraUQCUJGvyrSXfode8wFebwVl8W0cLBCrJxE/iTh4bdxRecv5J1PXnute9Qhw6QVy45HU20S8l+A0/rMAJ20wv+La0DQlA4aY9tW1B2kyAcH9vOyklmC/k74WxYqFFATryvnGAcmKFZJGVOuE7RD1FW3Y3EA8vFl03Rl8dmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4sIV8Jd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339320; x=1795875320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ruj5zM5qASld8SX1NDCud/BfQxCfcav3Zti/HDOC92c=;
  b=f4sIV8Jd+E0KsQPH4EzYoncgHrgrBUXHqfbm9lPIC2UZ2/tcu8wDGysT
   FflFsMkgMFpCaEGDgCdLDm55iJO5MR025VroJx650lbqvoivIRdZqf7sV
   oEye7N5/NI5RVZbA+DpyOAIQWghVwZ3hJk5U9oDhUdeRtAbpKjlD8Ycqe
   NMIEu+tqOBEMxyJ1D2V+Xf5QnNkdymEe7r/gZtLcZv3XM615bD/Jvc0Fs
   refloQJq7wvvK7KUVhK/mYamgHFZZcOhfFjDMb+3gKCrr8BjcQvEONNvh
   HOH4gba/PMQ7ndFVON3gFcVRR9qziH2M2McWnpCqWvt4QbPTQecgcaUrY
   A==;
X-CSE-ConnectionGUID: OTMcEE8JTo+0kVZCxTEd4A==
X-CSE-MsgGUID: h5U10aFOQzGmRd5m2t9mrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409578"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409578"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:20 -0800
X-CSE-ConnectionGUID: Eec99ZQHSVa3hTRVjyL96w==
X-CSE-MsgGUID: lc4bWinJRXiaPh6D80KOLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823149"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:17 -0800
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: clm@fb.comi,
	dsterba@suse.com,
	terrelln@fb.com,
	herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	cyan@meta.com,
	brian.will@intel.com,
	weigang.li@intel.com,
	senozhatsky@chromium.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Date: Fri, 28 Nov 2025 19:05:04 +0000
Message-ID: <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

Add support for hardware-accelerated compression using the acomp API in
the crypto framework, enabling offload of zlib and zstd compression to
hardware accelerators. Hardware offload reduces CPU load during
compression, improving performance.

The implementation follows a generic design that works with any acomp
implementation, though this enablement targets Intel QAT devices
(similarly to what done in EROFS).

Input folios are organized into a scatter-gather list and submitted to
the accelerator in a single asynchronous request. The calling thread
sleeps while the hardware performs compression, freeing the CPU for
other tasks.  Upon completion, the acomp callback wakes the thread to
continue processing.

Offload is supported for:
  - zlib: compression and decompression
  - zstd: compression only

Offload is only attempted when the data size exceeds a minimum threshold,
ensuring that small operations remain efficient by avoiding hardware setup
overhead. All required buffers are pre-allocated in the workspace to
eliminate allocations in the data path.

This feature maintains full compatibility with the existing BTRFS disk
format. Files compressed by hardware can be decompressed by software
implementations and vice versa.

The feature is wrapped in CONFIG_BTRFS_EXPERIMENTAL and can be enabled
at runtime via the sysfs parameter /sys/fs/btrfs/<UUID>/offload_compress.
Enabling this parameter succeeds only if a compatible acomp
implementation (e.g., QAT driver) is available. The runtime control
allows unloading the hardware driver when needed. Without it, the driver
would remain permanently in use and could not be removed.

Co-developed-by: Weigang Li <weigang.li@intel.com>
Signed-off-by: Weigang Li <weigang.li@intel.com>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 fs/btrfs/Makefile          |   2 +-
 fs/btrfs/acomp.c           | 470 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/acomp_workspace.h |  61 +++++
 fs/btrfs/compression.c     |  66 ++++++
 fs/btrfs/compression.h     |  30 +++
 fs/btrfs/disk-io.c         |   6 +
 fs/btrfs/fs.h              |   8 +
 fs/btrfs/sysfs.c           |  29 +++
 fs/btrfs/zlib.c            |  81 +++++++
 fs/btrfs/zstd.c            |  64 +++++
 10 files changed, 816 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/acomp.c
 create mode 100644 fs/btrfs/acomp_workspace.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 743d7677b175..6f9959218de7 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -27,7 +27,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   transaction.o inode.o file.o defrag.o \
 	   extent_map.o sysfs.o accessors.o xattr.o ordered-data.o \
 	   extent_io.o volumes.o async-thread.o ioctl.o locking.o orphan.o \
-	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
+	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o acomp.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
diff --git a/fs/btrfs/acomp.c b/fs/btrfs/acomp.c
new file mode 100644
index 000000000000..403ae19d0c18
--- /dev/null
+++ b/fs/btrfs/acomp.c
@@ -0,0 +1,470 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BTRFS acomp layer
+ *
+ * Copyright (c) 2025, Intel Corporation
+ * Author: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
+ */
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+#include <crypto/acompress.h>
+#include <linux/bio.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/pagemap.h>
+#include <linux/rtnetlink.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "compression.h"
+#include "acomp_workspace.h"
+
+static int folios_to_scatterlist(struct folio **folios, unsigned int nr_folios,
+				 size_t size, struct scatterlist *sg,
+				 unsigned int first_folio_offset)
+{
+	size_t available, len;
+	unsigned int offset;
+	int i;
+
+	if (!folios || nr_folios == 0 || !sg)
+		return -EINVAL;
+
+	if (nr_folios > BTRFS_ACOMP_MAX_SGL_ENTRIES)
+		return -E2BIG;
+
+	sg_init_table(sg, nr_folios);
+
+	for (i = 0; i < nr_folios && size; i++) {
+		/* For the first folio, use the provided offset; for others, use 0 */
+		offset = (i == 0) ? first_folio_offset : 0;
+		available = folio_size(folios[i]) - offset;
+
+		len = min(size, available);
+		sg_set_folio(&sg[i], folios[i], len, offset);
+		size -= len;
+	}
+
+	return 0;
+}
+
+static int build_acomp_attr_buffer(u8 *buf, unsigned int *len, u32 level)
+{
+	unsigned int total_len;
+	struct rtattr *rta;
+	u8 *pos;
+
+	if (!buf || !len || *len == 0)
+		return -EINVAL;
+
+	total_len = RTA_SPACE(sizeof(u32)) + RTA_SPACE(0);
+	if (total_len > *len)
+		return -E2BIG;
+
+	pos = buf;
+
+	rta = (struct rtattr *)pos;
+	rta->rta_type = CRYPTO_COMP_PARAM_LEVEL;
+	rta->rta_len = RTA_LENGTH(sizeof(u32));
+	memcpy(RTA_DATA(rta), &level, sizeof(level));
+	pos += RTA_SPACE(sizeof(u32));
+
+	rta = (struct rtattr *)pos;
+	rta->rta_type = CRYPTO_COMP_PARAM_LAST;
+	rta->rta_len = RTA_LENGTH(0);
+	pos += RTA_SPACE(0);
+
+	*len = total_len;
+
+	return 0;
+}
+
+int acomp_comp_folios(struct btrfs_acomp_workspace *acomp_ws,
+		      struct btrfs_fs_info *fs_info,
+		      struct address_space *mapping, u64 start, unsigned long len,
+		      struct folio **folios, unsigned long *out_folios,
+		      unsigned long *total_in, unsigned long *total_out, int level)
+{
+	struct scatterlist *out_sgl = NULL;
+	struct scatterlist *in_sgl = NULL;
+	const u64 orig_end = start + len;
+	struct crypto_acomp *tfm = NULL;
+	struct folio **in_folios = NULL;
+	unsigned int first_folio_offset;
+	unsigned int nr_dst_folios = 0;
+	struct folio *out_folio = NULL;
+	unsigned int nr_src_folios = 0;
+	struct acomp_req *req = NULL;
+	unsigned int nr_folios = 0;
+	unsigned int dst_size = 0;
+	unsigned int raw_attr_len;
+	unsigned int bytes_left;
+	unsigned int nofs_flags;
+	struct crypto_wait wait;
+	struct folio *in_folio;
+	unsigned int cur_len;
+	unsigned int i;
+	u64 cur_start;
+	u8 *raw_attr;
+	int ret;
+
+	if (!acomp_ws)
+		return -EOPNOTSUPP;
+
+	/* Check if offload is enabled and acquire reference */
+	if (!atomic_read(&fs_info->compress_offload_enabled))
+		return -EOPNOTSUPP;
+
+	if (!atomic_inc_not_zero(&fs_info->compr_resource_refcnt))
+		return -EOPNOTSUPP;
+
+	/* Protect against GFP_KERNEL allocations in crypto subsystem */
+	nofs_flags = memalloc_nofs_save();
+
+	in_folios = btrfs_acomp_get_folios(acomp_ws);
+	if (!in_folios) {
+		btrfs_err(fs_info, "No input folios in workspace\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cur_start = start;
+	while (cur_start < orig_end && nr_src_folios < BTRFS_ACOMP_MAX_SGL_ENTRIES) {
+		ret = btrfs_compress_filemap_get_folio(mapping, cur_start, &in_folio);
+		if (ret) {
+			btrfs_err(fs_info, "Error %d getting folio at %llu\n", ret, cur_start);
+			goto out;
+		}
+
+		cur_len = btrfs_calc_input_length(in_folio, orig_end, cur_start);
+		cur_start += cur_len;
+
+		in_folios[nr_src_folios] = in_folio;
+		nr_src_folios++;
+	}
+
+	/* Check if we can allocate enough output folios */
+	if (nr_src_folios > *out_folios) {
+		btrfs_err(fs_info, "Not enough output folios: have %lu need %u\n",
+			  *out_folios, nr_src_folios);
+		ret = -E2BIG;
+		goto out;
+	}
+
+	do {
+		out_folio = btrfs_alloc_compr_folio(fs_info);
+		if (!out_folio) {
+			btrfs_err(fs_info, "Failed to allocate output folio %u\n",
+				  nr_dst_folios);
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		folios[nr_dst_folios] = out_folio;
+		nr_dst_folios++;
+		dst_size += folio_size(out_folio);
+	} while (dst_size < len && nr_dst_folios < BTRFS_ACOMP_MAX_SGL_ENTRIES);
+
+	in_sgl = btrfs_acomp_get_input_sgl(acomp_ws);
+	if (!in_sgl) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Calculate the offset within the first input folio */
+	first_folio_offset = offset_in_folio(in_folios[0], start);
+
+	ret = folios_to_scatterlist(in_folios, nr_src_folios, len, in_sgl, first_folio_offset);
+	if (ret) {
+		btrfs_err(fs_info, "Failed to build input scatterlist\n");
+		goto out;
+	}
+
+	out_sgl = btrfs_acomp_get_output_sgl(acomp_ws);
+	if (!out_sgl) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = folios_to_scatterlist(folios, nr_dst_folios, dst_size, out_sgl, 0);
+	if (ret) {
+		btrfs_err(fs_info, "Failed to build output scatterlist\n");
+		goto out;
+	}
+
+	crypto_init_wait(&wait);
+
+	/* Get pre-allocated tfm and request from workspace */
+	tfm = btrfs_acomp_get_tfm(acomp_ws);
+	req = btrfs_acomp_get_request(acomp_ws);
+	if (!tfm || !req) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	raw_attr = btrfs_acomp_get_attr_buffer(acomp_ws);
+	raw_attr_len = BTRFS_ACOMP_ATTR_BUF_SIZE;
+	ret = build_acomp_attr_buffer(raw_attr, &raw_attr_len, level);
+	if (ret) {
+		btrfs_err(fs_info, "Failed to build acomp attr buffer: %d\n", ret);
+		goto out;
+	}
+
+	ret = crypto_acomp_setparam(tfm, raw_attr, raw_attr_len);
+	if (ret) {
+		btrfs_err(fs_info, "Failed to set acomp params: %d\n", ret);
+		goto out;
+	}
+
+	acomp_request_set_params(req, in_sgl, out_sgl, len, dst_size);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG, crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+	if (ret)
+		goto out;
+
+	*total_in = len;
+	*total_out = req->dlen;
+
+	/* Calculate number of folios used based on total_out */
+	bytes_left = *total_out;
+	for (i = 0, nr_folios = 0; i < nr_dst_folios && bytes_left > 0; i++) {
+		bytes_left -= min_t(size_t, bytes_left, folio_size(folios[i]));
+		nr_folios++;
+	}
+
+out:
+	/* Free out un-used folios (or all on error since nr_folios = 0) */
+	for (i = nr_folios; i < nr_dst_folios; i++) {
+		if (folios[i]) {
+			btrfs_free_compr_folio(folios[i]);
+			folios[i] = NULL;
+		}
+	}
+
+	/* Free input folios */
+	for (i = 0; i < nr_src_folios; i++)
+		if (in_folios[i]) {
+			folio_put(in_folios[i]);
+			in_folios[i] = NULL;
+		}
+
+	*out_folios = nr_folios;
+
+	memalloc_nofs_restore(nofs_flags);
+
+	/* Release reference and wake up any waiters */
+	if (atomic_dec_and_test(&fs_info->compr_resource_refcnt))
+		wake_up(&fs_info->compr_wait_queue);
+
+	return ret;
+}
+
+int acomp_decomp_bio(struct btrfs_acomp_workspace *acomp_ws,
+		     struct btrfs_fs_info *fs_info,
+		     struct folio **in_folios,
+		     struct compressed_bio *cb, size_t srclen,
+		     unsigned long total_folios_in)
+{
+	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
+	unsigned int nr_dst_folios = BTRFS_MAX_COMPRESSED_PAGES;
+	struct scatterlist *out_sgl = NULL;
+	struct scatterlist *in_sgl = NULL;
+	struct folio **out_folios = NULL;
+	struct crypto_acomp *tfm = NULL;
+	struct acomp_req *req = NULL;
+	struct crypto_wait wait;
+	unsigned int nofs_flags;
+	unsigned int dst_size;
+	char *data_out = NULL;
+	int bytes_left = 0;
+	unsigned int i;
+	int ret, ret2;
+
+	if (!acomp_ws)
+		return -EOPNOTSUPP;
+
+	/* Check if offload is enabled and acquire reference */
+	if (!atomic_read(&fs_info->compress_offload_enabled))
+		return -EOPNOTSUPP;
+
+	if (!atomic_inc_not_zero(&fs_info->compr_resource_refcnt))
+		return -EOPNOTSUPP;
+
+	/* Protect against GFP_KERNEL allocations in crypto subsystem */
+	nofs_flags = memalloc_nofs_save();
+
+	in_sgl = btrfs_acomp_get_input_sgl(acomp_ws);
+	if (!in_sgl) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	out_sgl = btrfs_acomp_get_output_sgl(acomp_ws);
+	if (!out_sgl) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	out_folios = btrfs_acomp_get_folios(acomp_ws);
+	if (!out_folios) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = folios_to_scatterlist(in_folios, total_folios_in, srclen, in_sgl, 0);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < nr_dst_folios; i++) {
+		out_folios[i] = btrfs_alloc_compr_folio(fs_info);
+		if (!out_folios[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	dst_size = nr_dst_folios * min_folio_size;
+
+	ret = folios_to_scatterlist(out_folios, nr_dst_folios, dst_size, out_sgl, 0);
+	if (ret)
+		goto out;
+
+	crypto_init_wait(&wait);
+
+	/* Get pre-allocated tfm and request from workspace */
+	tfm = btrfs_acomp_get_tfm(acomp_ws);
+	req = btrfs_acomp_get_request(acomp_ws);
+	if (!tfm || !req) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	acomp_request_set_params(req, in_sgl, out_sgl, srclen, dst_size);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+	if (ret)
+		goto out;
+
+	bytes_left = req->dlen;
+	for (i = 0; i < nr_dst_folios && bytes_left > 0; i++) {
+		size_t folio_bytes = min_t(size_t, bytes_left, min_folio_size);
+		unsigned long buf_start = req->dlen - bytes_left;
+
+		data_out = kmap_local_folio(out_folios[i], 0);
+
+		ret2 = btrfs_decompress_buf2page(data_out, folio_bytes, cb, buf_start);
+		kunmap_local(data_out);
+
+		if (ret2 == 0) {
+			ret = 0;
+			goto out;
+		}
+
+		bytes_left -= folio_bytes;
+	}
+
+out:
+	if (out_folios) {
+		for (i = 0; i < nr_dst_folios; i++) {
+			if (out_folios[i]) {
+				folio_put(out_folios[i]);
+				out_folios[i] = NULL;
+			}
+		}
+	}
+
+	memalloc_nofs_restore(nofs_flags);
+
+	/* Release reference and wake up any waiters */
+	if (atomic_dec_and_test(&fs_info->compr_resource_refcnt))
+		wake_up(&fs_info->compr_wait_queue);
+
+	return ret;
+}
+
+static const char *zlib_acomp_alg_name = "qat_zlib_deflate";
+static const char *zstd_acomp_alg_name = "qat_zstd";
+
+bool acomp_has_zlib(void)
+{
+	return crypto_has_acomp(zlib_acomp_alg_name, 0, 0);
+}
+
+bool acomp_has_zstd(void)
+{
+	return crypto_has_acomp(zstd_acomp_alg_name, 0, 0);
+}
+
+static struct btrfs_acomp_workspace *acomp_workspace_alloc(struct btrfs_fs_info *fs_info,
+							   const char *alg_name)
+{
+	struct btrfs_acomp_workspace *acomp_ws;
+
+	if (!alg_name)
+		return NULL;
+
+	if (!crypto_has_acomp(alg_name, 0, 0))
+		return NULL;
+
+	/* Only allocate workspace if offload is enabled */
+	if (!fs_info || !atomic_read(&fs_info->compress_offload_enabled))
+		return NULL;
+
+	acomp_ws = kzalloc(sizeof(*acomp_ws), GFP_KERNEL);
+	if (!acomp_ws)
+		return NULL;
+
+	sg_init_table(acomp_ws->in_sgl, BTRFS_ACOMP_MAX_SGL_ENTRIES);
+	sg_init_table(acomp_ws->out_sgl, BTRFS_ACOMP_MAX_SGL_ENTRIES);
+
+	acomp_ws->alg_name = alg_name;
+	acomp_ws->attr_buf_len = BTRFS_ACOMP_ATTR_BUF_SIZE;
+
+	/* Allocate tfm and req */
+	acomp_ws->tfm = crypto_alloc_acomp(alg_name, 0, 0);
+	if (IS_ERR(acomp_ws->tfm)) {
+		btrfs_err(fs_info, "Failed to allocate acomp tfm for %s: %ld\n",
+			  alg_name, PTR_ERR(acomp_ws->tfm));
+		kfree(acomp_ws);
+		return NULL;
+	}
+
+	acomp_ws->req = acomp_request_alloc(acomp_ws->tfm);
+	if (!acomp_ws->req) {
+		btrfs_err(fs_info, "Failed to allocate acomp request for %s\n", alg_name);
+		crypto_free_acomp(acomp_ws->tfm);
+		kfree(acomp_ws);
+		return NULL;
+	}
+
+	return acomp_ws;
+}
+
+struct btrfs_acomp_workspace *acomp_zlib_workspace_alloc(struct btrfs_fs_info *fs_info)
+{
+	return acomp_workspace_alloc(fs_info, zlib_acomp_alg_name);
+}
+
+struct btrfs_acomp_workspace *acomp_zstd_workspace_alloc(struct btrfs_fs_info *fs_info)
+{
+	return acomp_workspace_alloc(fs_info, zstd_acomp_alg_name);
+}
+
+void acomp_workspace_free(struct btrfs_acomp_workspace *acomp_ws)
+{
+	if (acomp_ws) {
+		if (acomp_ws->req)
+			acomp_request_free(acomp_ws->req);
+		if (acomp_ws->tfm)
+			crypto_free_acomp(acomp_ws->tfm);
+	}
+	kfree(acomp_ws);
+}
+#endif /* CONFIG_BTRFS_EXPERIMENTAL */
diff --git a/fs/btrfs/acomp_workspace.h b/fs/btrfs/acomp_workspace.h
new file mode 100644
index 000000000000..e886ab5657b2
--- /dev/null
+++ b/fs/btrfs/acomp_workspace.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_ACOMP_WORKSPACE_H
+#define BTRFS_ACOMP_WORKSPACE_H
+
+#include <crypto/acompress.h>
+#include <linux/scatterlist.h>
+
+#include "compression.h"
+
+/*
+ * Maximum number of scatterlist entries needed for btrfs compression.
+ * Based on BTRFS_MAX_COMPRESSED_PAGES (32 pages max).
+ */
+#define BTRFS_ACOMP_MAX_SGL_ENTRIES	BTRFS_MAX_COMPRESSED_PAGES
+
+/* Maximum size needed for compression attribute buffer */
+#define BTRFS_ACOMP_ATTR_BUF_SIZE	64
+
+struct btrfs_acomp_workspace {
+	struct scatterlist in_sgl[BTRFS_ACOMP_MAX_SGL_ENTRIES];
+	struct scatterlist out_sgl[BTRFS_ACOMP_MAX_SGL_ENTRIES];
+	struct folio *folios[BTRFS_ACOMP_MAX_SGL_ENTRIES];
+	u8 attr_buffer[BTRFS_ACOMP_ATTR_BUF_SIZE];
+	unsigned int attr_buf_len;
+	const char *alg_name;
+	struct crypto_acomp *tfm;
+	struct acomp_req *req;
+};
+
+static inline struct scatterlist *btrfs_acomp_get_input_sgl(struct btrfs_acomp_workspace *acomp_ws)
+{
+	return acomp_ws ? acomp_ws->in_sgl : NULL;
+}
+
+static inline struct scatterlist *btrfs_acomp_get_output_sgl(struct btrfs_acomp_workspace *acomp_ws)
+{
+	return acomp_ws ? acomp_ws->out_sgl : NULL;
+}
+
+static inline struct folio **btrfs_acomp_get_folios(struct btrfs_acomp_workspace *acomp_ws)
+{
+	return acomp_ws ? acomp_ws->folios : NULL;
+}
+
+static inline u8 *btrfs_acomp_get_attr_buffer(struct btrfs_acomp_workspace *acomp_ws)
+{
+	return acomp_ws ? acomp_ws->attr_buffer : NULL;
+}
+
+static inline struct crypto_acomp *btrfs_acomp_get_tfm(struct btrfs_acomp_workspace *acomp_ws)
+{
+	return acomp_ws ? acomp_ws->tfm : NULL;
+}
+
+static inline struct acomp_req *btrfs_acomp_get_request(struct btrfs_acomp_workspace *acomp_ws)
+{
+	return acomp_ws ? acomp_ws->req : NULL;
+}
+
+#endif /* BTRFS_ACOMP_WORKSPACE_H */
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..7d6083e5958e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1695,3 +1695,69 @@ int btrfs_compress_str2level(unsigned int type, const char *str, int *level_ret)
 	*level_ret = btrfs_compress_set_level(type, level);
 	return 0;
 }
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int btrfs_set_compress_offload(struct btrfs_fs_info *fs_info, bool enable)
+{
+	int compress_type;
+	int ret = 0;
+
+	if (!fs_info)
+		return -EINVAL;
+
+	compress_type = fs_info->compress_type;
+	switch (compress_type) {
+	case BTRFS_COMPRESS_ZLIB:
+		if (!acomp_has_zlib()) {
+			btrfs_warn(fs_info, "Hardware does not support zlib compression offload");
+			return -EOPNOTSUPP;
+		}
+		break;
+	case BTRFS_COMPRESS_ZSTD:
+		if (!acomp_has_zstd()) {
+			btrfs_warn(fs_info, "Hardware does not support zstd compression offload");
+			return -EOPNOTSUPP;
+		}
+		break;
+	default:
+		btrfs_warn(fs_info, "Compression offload only supported for zlib and zstd (current: %d)",
+			   compress_type);
+		return -EOPNOTSUPP;
+	}
+
+	spin_lock(&fs_info->compress_offload_lock);
+
+	if (atomic_read(&fs_info->compress_offload_enabled) == (enable ? 1 : 0)) {
+		spin_unlock(&fs_info->compress_offload_lock);
+		btrfs_info(fs_info, "Compression hardware offload already %s",
+			   enable ? "enabled" : "disabled");
+		return 0;
+	}
+
+	atomic_set(&fs_info->compress_offload_enabled, enable ? 1 : 0);
+	atomic_dec(&fs_info->compr_resource_refcnt);
+	spin_unlock(&fs_info->compress_offload_lock);
+
+	wait_event(fs_info->compr_wait_queue,
+		   atomic_read(&fs_info->compr_resource_refcnt) == 0);
+
+	switch (compress_type) {
+	case BTRFS_COMPRESS_ZLIB:
+		ret = zlib_process_acomp_workspaces(fs_info, enable);
+		break;
+	case BTRFS_COMPRESS_ZSTD:
+		ret = zstd_process_acomp_workspaces(fs_info, enable);
+		break;
+	}
+
+	atomic_set(&fs_info->compr_resource_refcnt, 1);
+
+	if (ret == 0) {
+		btrfs_info(fs_info, "Compression hardware offload %s for %s",
+			   enable ? "enabled" : "disabled",
+			   compress_type == BTRFS_COMPRESS_ZLIB ? "zlib" : "zstd");
+	}
+
+	return ret;
+}
+#endif /* CONFIG_BTRFS_EXPERIMENTAL */
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index eba188a9e3bb..fa3e1e0c7d03 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -22,6 +22,7 @@ struct inode;
 struct btrfs_inode;
 struct btrfs_ordered_extent;
 struct btrfs_bio;
+struct btrfs_acomp_workspace;
 
 /*
  * We want to make sure that amount of RAM required to uncompress an extent is
@@ -162,6 +163,9 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned int level);
 void zlib_free_workspace(struct list_head *ws);
 struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int level);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int zlib_process_acomp_workspaces(struct btrfs_fs_info *fs_info, bool enable);
+#endif
 
 int lzo_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			u64 start, struct folio **folios, unsigned long *out_folios,
@@ -186,5 +190,31 @@ struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_get_workspace(struct btrfs_fs_info *fs_info, int level);
 void zstd_put_workspace(struct btrfs_fs_info *fs_info, struct list_head *ws);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int zstd_process_acomp_workspaces(struct btrfs_fs_info *fs_info, bool enable);
+#endif
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+bool acomp_has_zlib(void);
+bool acomp_has_zstd(void);
+struct btrfs_acomp_workspace;
+
+struct btrfs_acomp_workspace *acomp_zlib_workspace_alloc(struct btrfs_fs_info *fs_info);
+struct btrfs_acomp_workspace *acomp_zstd_workspace_alloc(struct btrfs_fs_info *fs_info);
+void acomp_workspace_free(struct btrfs_acomp_workspace *acomp_ws);
+int acomp_comp_folios(struct btrfs_acomp_workspace *acomp_ws,
+		      struct btrfs_fs_info *fs_info,
+		      struct address_space *mapping, u64 start, unsigned long len,
+		      struct folio **folios, unsigned long *out_folios,
+		      unsigned long *total_in, unsigned long *total_out, int level);
+int acomp_decomp_bio(struct btrfs_acomp_workspace *acomp_ws,
+		     struct btrfs_fs_info *fs_info, struct folio **in_folios,
+		     struct compressed_bio *cb, size_t srclen,
+		     unsigned long total_folios_in);
+int btrfs_set_compress_offload(struct btrfs_fs_info *fs_info, bool enable);
+#else
+static inline bool acomp_has_zlib(void) { return false; }
+static inline bool acomp_has_zstd(void) { return false; }
+#endif
 
 #endif
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..2f63f8221c95 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2778,6 +2778,12 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->relocation_bg_lock);
 	rwlock_init(&fs_info->tree_mod_log_lock);
 	rwlock_init(&fs_info->global_root_lock);
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	spin_lock_init(&fs_info->compress_offload_lock);
+	atomic_set(&fs_info->compress_offload_enabled, 0);
+	atomic_set(&fs_info->compr_resource_refcnt, 1);
+	init_waitqueue_head(&fs_info->compr_wait_queue);
+#endif
 	mutex_init(&fs_info->unused_bg_unpin_mutex);
 	mutex_init(&fs_info->reclaim_bgs_lock);
 	mutex_init(&fs_info->reloc_mutex);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 814bbc9417d2..c6ff901c557c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -525,6 +525,14 @@ struct btrfs_fs_info {
 
 	int compress_type;
 	int compress_level;
+
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	spinlock_t compress_offload_lock; /* protects the two fields below */
+	atomic_t compress_offload_enabled;
+	atomic_t compr_resource_refcnt;
+	wait_queue_head_t compr_wait_queue;
+#endif
+
 	u32 commit_interval;
 	/*
 	 * It is a suggestive number, the read side is safe even it gets a
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 81f52c1f55ce..73420373b62c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1578,6 +1578,34 @@ static ssize_t btrfs_offload_csum_store(struct kobject *kobj,
 	return len;
 }
 BTRFS_ATTR_RW(, offload_csum, btrfs_offload_csum_show, btrfs_offload_csum_store);
+
+static ssize_t offload_compress_show(struct kobject *kobj,
+				     struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+
+	return sysfs_emit(buf, "%d\n", atomic_read(&fs_info->compress_offload_enabled));
+}
+
+static ssize_t offload_compress_store(struct kobject *kobj,
+				      struct kobj_attribute *a, const char *buf,
+				      size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	ret = btrfs_set_compress_offload(fs_info, val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+BTRFS_ATTR_RW(, offload_compress, offload_compress_show, offload_compress_store);
 #endif
 
 /*
@@ -1601,6 +1629,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, temp_fsid),
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
+	BTRFS_ATTR_PTR(, offload_compress),
 #endif
 	NULL,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 6caba8be7c84..9adb1defaea3 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -18,6 +18,9 @@
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/refcount.h>
+#include <linux/scatterlist.h>
+#include <crypto/acompress.h>
+#include "acomp_workspace.h"
 #include "btrfs_inode.h"
 #include "compression.h"
 #include "fs.h"
@@ -32,6 +35,7 @@ struct workspace {
 	unsigned int buf_size;
 	struct list_head list;
 	int level;
+	struct btrfs_acomp_workspace *acomp_ws;
 };
 
 struct list_head *zlib_get_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
@@ -48,11 +52,50 @@ void zlib_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (workspace->acomp_ws)
+		acomp_workspace_free(workspace->acomp_ws);
+#endif
+
 	kvfree(workspace->strm.workspace);
 	kfree(workspace->buf);
 	kfree(workspace);
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int zlib_process_acomp_workspaces(struct btrfs_fs_info *fs_info, bool enable)
+{
+	struct workspace_manager *wsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZLIB];
+	struct list_head *ws, *tmp;
+
+	if (!wsm)
+		return 0;
+
+	spin_lock(&wsm->ws_lock);
+
+	list_for_each_safe(ws, tmp, &wsm->idle_ws) {
+		struct workspace *workspace = list_entry(ws, struct workspace, list);
+
+		if (enable) {
+			if (!workspace->acomp_ws) {
+				workspace->acomp_ws = acomp_zlib_workspace_alloc(fs_info);
+				if (!workspace->acomp_ws)
+					btrfs_warn(fs_info, "Failed to allocate zlib acomp workspace");
+			}
+		} else {
+			if (workspace->acomp_ws) {
+				acomp_workspace_free(workspace->acomp_ws);
+				workspace->acomp_ws = NULL;
+			}
+		}
+	}
+
+	spin_unlock(&wsm->ws_lock);
+
+	return 0;
+}
+#endif
+
 /*
  * For s390 hardware acceleration, the buffer size should be at least
  * ZLIB_DFLTCC_BUF_SIZE to achieve the best performance.
@@ -97,6 +140,14 @@ struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned i
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Try to allocate acomp workspace (will be NULL if offload disabled) */
+	workspace->acomp_ws = acomp_zlib_workspace_alloc(fs_info);
+	/* It's OK if this returns NULL when offload is disabled */
+#else
+	workspace->acomp_ws = NULL;
+#endif
+
 	INIT_LIST_HEAD(&workspace->list);
 
 	return &workspace->list;
@@ -165,6 +216,20 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	const u32 blocksize = fs_info->sectorsize;
 	const u64 orig_end = start + len;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (workspace->acomp_ws && len >= 1024) {
+		ret = acomp_comp_folios(workspace->acomp_ws, fs_info, mapping, start,
+					len, folios, out_folios, total_in,
+					total_out, workspace->level);
+		/*
+		 * If hardware offload succeeded, or if there is an expansion,
+		 * return. Otherwise, compress in software.
+		 */
+		if (ret == 0 || ret == -E2BIG)
+			return ret;
+	}
+#endif
+
 	*out_folios = 0;
 	*total_out = 0;
 	*total_in = 0;
@@ -348,6 +413,22 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	struct folio **folios_in = cb->compressed_folios;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (workspace->acomp_ws && srclen >= 1024) {
+		ret = acomp_decomp_bio(workspace->acomp_ws, fs_info, folios_in, cb,
+				       srclen, total_folios_in);
+		/* If hardware offload succeeded, return. */
+		if (ret == 0)
+			return 0;
+
+		/* Otherwise, decompress in software. This should not happen! */
+		if (ret)
+			btrfs_info(fs_info,
+				   "zlib hardware decompression offload failed, falling back to software ret=%d",
+				   ret);
+	}
+#endif
+
 	data_in = kmap_local_folio(folios_in[folio_in_index], 0);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, min_folio_size);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index c9cddcfa337b..530aa5b7efee 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -22,6 +22,7 @@
 #include "btrfs_inode.h"
 #include "compression.h"
 #include "super.h"
+#include "acomp_workspace.h"
 
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
 #define ZSTD_BTRFS_MAX_INPUT (1U << ZSTD_BTRFS_MAX_WINDOWLOG)
@@ -54,6 +55,7 @@ struct workspace {
 	zstd_in_buffer in_buf;
 	zstd_out_buffer out_buf;
 	zstd_parameters params;
+	struct btrfs_acomp_workspace *acomp_ws;
 };
 
 /*
@@ -363,11 +365,53 @@ void zstd_free_workspace(struct list_head *ws)
 {
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (workspace->acomp_ws)
+		acomp_workspace_free(workspace->acomp_ws);
+#endif
 	kvfree(workspace->mem);
 	kfree(workspace->buf);
 	kfree(workspace);
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+int zstd_process_acomp_workspaces(struct btrfs_fs_info *fs_info, bool enable)
+{
+	struct zstd_workspace_manager *zwsm = fs_info->compr_wsm[BTRFS_COMPRESS_ZSTD];
+	int i;
+
+	if (!zwsm)
+		return 0;
+
+	spin_lock_bh(&zwsm->lock);
+
+	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++) {
+		struct list_head *ws, *tmp;
+
+		list_for_each_safe(ws, tmp, &zwsm->idle_ws[i]) {
+			struct workspace *workspace = list_entry(ws, struct workspace, list);
+
+			if (enable) {
+				if (!workspace->acomp_ws) {
+					workspace->acomp_ws = acomp_zstd_workspace_alloc(fs_info);
+					if (!workspace->acomp_ws)
+						btrfs_warn(fs_info, "Failed to allocate zstd acomp workspace");
+				}
+			} else {
+				if (workspace->acomp_ws) {
+					acomp_workspace_free(workspace->acomp_ws);
+					workspace->acomp_ws = NULL;
+				}
+			}
+		}
+	}
+
+	spin_unlock_bh(&zwsm->lock);
+
+	return 0;
+}
+#endif
+
 struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 {
 	const u32 blocksize = fs_info->sectorsize;
@@ -387,6 +431,12 @@ struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
 	if (!workspace->mem || !workspace->buf)
 		goto fail;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	/* Try to allocate acomp workspace (will be NULL if offload disabled) */
+	workspace->acomp_ws = acomp_zstd_workspace_alloc(fs_info);
+	/* It's OK if this returns NULL when offload is disabled */
+#endif
+
 	INIT_LIST_HEAD(&workspace->list);
 	INIT_LIST_HEAD(&workspace->lru_list);
 
@@ -418,6 +468,20 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long max_out = nr_dest_folios * min_folio_size;
 	unsigned int cur_len;
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	if (workspace->acomp_ws && len >= 2048) {
+		ret = acomp_comp_folios(workspace->acomp_ws, fs_info, mapping, start,
+					len, folios, out_folios, total_in,
+					total_out, workspace->req_level);
+		/*
+		 * If hardware offload succeeded, or if there is an expansion,
+		 * return. Otherwise, compress in software.
+		 */
+		if (ret == 0 || ret == -E2BIG)
+			return ret;
+	}
+#endif
+
 	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
 	*out_folios = 0;
 	*total_out = 0;
-- 
2.51.1


