Return-Path: <linux-btrfs+bounces-4559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E88B3661
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EFA1C213FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CA145321;
	Fri, 26 Apr 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcahVx8/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AEC14532C;
	Fri, 26 Apr 2024 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129826; cv=none; b=m7FaFkp8WI4/P8xFNBWeCasLFQjZHmt0KcR3HeVSC2Ug5YDeqs1dbg4EeA8QUmJWcj5EGEffHP9RlqKRykrd3AGAsynfIrtdEMFCPfFrWyNQkUvMRRLBPz7GT1CK0OK9tHGsHuro12U20agOUesiy/pbrW4JJ/AdGsrlSdqPrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129826; c=relaxed/simple;
	bh=obllucfMKr7nP8Fd7tINm6E+qy6THCOcZXqtxMe2J5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjuN8a25M9G+vJYlJYkmfDev8gi5+hcPGtq1pJw5t/8o2twxRYut58mHo2Om/FE3/f4z2GM64MuOXStKLhmYtgfXYc9OThAH3YpQ9wzWERIfe0ISW2ktYppdeq+71sM1i25y8oGUb6UAubU1RnqTDxD8geV5ushiT1ZY57urS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcahVx8/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129823; x=1745665823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obllucfMKr7nP8Fd7tINm6E+qy6THCOcZXqtxMe2J5I=;
  b=jcahVx8/hktfITFWa6/bF2NoCNNwCDAr6O1i36/lfhf8drk+jXxSWEGW
   gl011mUmBtNkfhb1ckt26RipCNCOSqfy8wCHDJ02J0tZl0+Ttnniuzo2Q
   G2xMtdTPYgl5K/3b+GReUj1CTB+u2OD2sCSvTQ3vP2hDFPw/TeQGF2+J4
   DQRxU1ETa6mMDxm9qlxcv3hD9AFwZIhzE5WIT0AUmf8LCO+4bPuPRcEmj
   /lYPrMDeR/ngv3BHW+y82iLFLY/UoMa9enFzLTODMPZT74uDiMRDc3Zkn
   YI2aDdY6nCbq6WxTY1WkZChd2uruCOFfwtpdyHrpNwVaLNvXx13bg9G26
   A==;
X-CSE-ConnectionGUID: hWiw4rQlTS2LFIAEkyyaHw==
X-CSE-MsgGUID: ekqB5eVoQ8mVdvhI18ggkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474105"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474105"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:23 -0700
X-CSE-ConnectionGUID: 2PZwnv6LTKWjyfCBCT0sNA==
X-CSE-MsgGUID: Ey0Zd8xXSn64+/eWW6R/uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030970"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:10:20 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	herbert@gondor.apana.org.au
Cc: linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	embg@meta.com,
	cyan@meta.com,
	brian.will@intel.com,
	weigang.li@intel.com
Subject: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate through acomp
Date: Fri, 26 Apr 2024 11:54:29 +0100
Message-ID: <20240426110941.5456-7-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit

From: Weigang Li <weigang.li@intel.com>

Add support for zlib compression and decompression through the acomp
APIs.
Input pages are added to an sg-list and sent to acomp in one request.
Since acomp is asynchronous, the thread is put to sleep and then the CPU
is freed up. Once compression is done, the acomp callback is triggered
and the thread is woke up.

This patch doesn't change the BTRFS disk format, this means that files
compressed by hardware engines can be de-compressed by the zlib software
library, and vice versa.

Limitations:
  * The implementation tries always to use an acomp even if only
    zlib-deflate-scomp is present
  * Acomp does not provide a way to support compression levels
  * Acomp is an asynchronous API but used here synchronously

Signed-off-by: Weigang Li <weigang.li@intel.com>
---
 fs/btrfs/zlib.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index e5b3f2003896..b5bbb8c97244 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -18,6 +18,8 @@
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/refcount.h>
+#include <crypto/acompress.h>
+#include <linux/scatterlist.h>
 #include "compression.h"
 
 /* workspace buffer size for s390 zlib hardware support */
@@ -33,6 +35,201 @@ struct workspace {
 
 static struct workspace_manager wsm;
 
+static int acomp_comp_pages(struct address_space *mapping, u64 start,
+			    unsigned long len, struct page **pages,
+			    unsigned long *out_pages,
+			    unsigned long *total_in,
+			    unsigned long *total_out)
+{
+	unsigned int nr_src_pages = 0, nr_dst_pages = 0, nr_pages = 0;
+	struct sg_table in_sg = { 0 }, out_sg = { 0 };
+	struct page *in_page, *out_page, **in_pages;
+	struct crypto_acomp *tfm = NULL;
+	struct acomp_req *req = NULL;
+	struct crypto_wait wait;
+	int ret, i;
+
+	nr_src_pages = (len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	in_pages = kcalloc(nr_src_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!in_pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < nr_src_pages; i++) {
+		in_page = find_get_page(mapping, start >> PAGE_SHIFT);
+		out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		if (!in_page || !out_page) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		in_pages[i] = in_page;
+		pages[i] = out_page;
+		nr_dst_pages += 1;
+		start += PAGE_SIZE;
+	}
+
+	ret = sg_alloc_table_from_pages(&in_sg, in_pages, nr_src_pages, 0,
+					nr_src_pages << PAGE_SHIFT, GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	ret = sg_alloc_table_from_pages(&out_sg, pages, nr_dst_pages, 0,
+					nr_dst_pages << PAGE_SHIFT, GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	crypto_init_wait(&wait);
+	tfm = crypto_alloc_acomp("zlib-deflate", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out;
+	}
+
+	req = acomp_request_alloc(tfm);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acomp_request_set_params(req, in_sg.sgl, out_sg.sgl, len,
+				 nr_dst_pages << PAGE_SHIFT);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_acomp_compress(req), &wait);
+	if (ret)
+		goto out;
+
+	*total_in = len;
+	*total_out = req->dlen;
+	nr_pages = (*total_out + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+out:
+	sg_free_table(&in_sg);
+	sg_free_table(&out_sg);
+
+	if (in_pages) {
+		for (i = 0; i < nr_src_pages; i++)
+			put_page(in_pages[i]);
+		kfree(in_pages);
+	}
+
+	/* free un-used out pages */
+	for (i = nr_pages; i < nr_dst_pages; i++)
+		put_page(pages[i]);
+
+	if (req)
+		acomp_request_free(req);
+
+	if (tfm)
+		crypto_free_acomp(tfm);
+
+	*out_pages = nr_pages;
+
+	return ret;
+}
+
+static int acomp_zlib_decomp_bio(struct page **in_pages,
+				 struct compressed_bio *cb, size_t srclen,
+				 unsigned long total_pages_in)
+{
+	unsigned int nr_dst_pages = BTRFS_MAX_COMPRESSED_PAGES;
+	struct sg_table in_sg = { 0 }, out_sg = { 0 };
+	struct bio *orig_bio = &cb->orig_bbio->bio;
+	char *data_out = NULL, *bv_buf = NULL;
+	int copy_len = 0, bytes_left = 0;
+	struct crypto_acomp *tfm = NULL;
+	struct page **out_pages = NULL;
+	struct acomp_req *req = NULL;
+	struct crypto_wait wait;
+	struct bio_vec bvec;
+	int ret, i = 0;
+
+	ret = sg_alloc_table_from_pages(&in_sg, in_pages, total_pages_in,
+					0, srclen, GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	out_pages = kcalloc(nr_dst_pages, sizeof(struct page *), GFP_KERNEL);
+	if (!out_pages) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < nr_dst_pages; i++) {
+		out_pages[i] = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		if (!out_pages[i]) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	ret = sg_alloc_table_from_pages(&out_sg, out_pages, nr_dst_pages, 0,
+					nr_dst_pages << PAGE_SHIFT, GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	crypto_init_wait(&wait);
+	tfm = crypto_alloc_acomp("zlib-deflate", 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out;
+	}
+
+	req = acomp_request_alloc(tfm);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acomp_request_set_params(req, in_sg.sgl, out_sg.sgl, srclen,
+				 nr_dst_pages << PAGE_SHIFT);
+	acomp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_acomp_decompress(req), &wait);
+	if (ret)
+		goto out;
+
+	/* Copy decompressed buffer to bio pages */
+	bytes_left = req->dlen;
+	for (i = 0; i < nr_dst_pages; i++) {
+		copy_len = bytes_left > PAGE_SIZE ? PAGE_SIZE : bytes_left;
+		data_out = kmap_local_page(out_pages[i]);
+
+		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
+		bv_buf = kmap_local_page(bvec.bv_page);
+		memcpy(bv_buf, data_out, copy_len);
+		kunmap_local(bv_buf);
+
+		bio_advance(orig_bio, copy_len);
+		if (!orig_bio->bi_iter.bi_size)
+			break;
+		bytes_left -= copy_len;
+		if (bytes_left <= 0)
+			break;
+	}
+out:
+	sg_free_table(&in_sg);
+	sg_free_table(&out_sg);
+
+	if (out_pages) {
+		for (i = 0; i < nr_dst_pages; i++) {
+			if (out_pages[i])
+				put_page(out_pages[i]);
+		}
+		kfree(out_pages);
+	}
+
+	if (req)
+		acomp_request_free(req);
+	if (tfm)
+		crypto_free_acomp(tfm);
+
+	return ret;
+}
+
 struct list_head *zlib_get_workspace(unsigned int level)
 {
 	struct list_head *ws = btrfs_get_workspace(BTRFS_COMPRESS_ZLIB, level);
@@ -108,6 +305,15 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	unsigned long nr_dest_pages = *out_pages;
 	const unsigned long max_out = nr_dest_pages * PAGE_SIZE;
 
+	if (crypto_has_acomp("zlib-deflate", 0, 0)) {
+		ret = acomp_comp_pages(mapping, start, len, pages, out_pages,
+				       total_in, total_out);
+		if (!ret)
+			return ret;
+
+		pr_warn("BTRFS: acomp compression failed: ret = %d\n", ret);
+		/* Fallback to SW implementation if HW compression failed */
+	}
 	*out_pages = 0;
 	*total_out = 0;
 	*total_in = 0;
@@ -281,6 +487,16 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	unsigned long buf_start;
 	struct page **pages_in = cb->compressed_pages;
 
+	if (crypto_has_acomp("zlib-deflate", 0, 0)) {
+		ret = acomp_zlib_decomp_bio(pages_in, cb, srclen,
+					    total_pages_in);
+		if (!ret)
+			return ret;
+
+		pr_warn("BTRFS: acomp decompression failed, ret=%d\n", ret);
+		/* Fallback to SW implementation if HW decompression failed */
+	}
+
 	data_in = kmap_local_page(pages_in[page_in_index]);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, PAGE_SIZE);
-- 
2.44.0


