Return-Path: <linux-btrfs+bounces-19396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC4C9244D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19A214E9D66
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891232ED43;
	Fri, 28 Nov 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IglViBi5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6332ED38;
	Fri, 28 Nov 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339288; cv=none; b=pwjk7j6Ehy1u/tYUow2gC0U2RTGCODidfi95zI/ZsdktMzf4foE9L+UDuUMFAm74AqzM/HMtI1S+spNwyFjZscTz+t5wPbPkhYmWm+5531NVryCTzDFLz/cyAKLwkON1CL2ZJQS9vc5FxH/2r/j1IHixK4+jUKVf/wOXooq0X/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339288; c=relaxed/simple;
	bh=7l7/AGZrFPngqEa/UyCjzkyXoSUgfB6Kj5Wr3xA991A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZRCRJ7iXzj7VIVzXIyOUe10iaHNP6Mn961jy6KqrX29pmsLVtY0+P4QW62MQuEQ8Pt6fr9vJwCQHFX2glScbHAFWyI/lB4UNVNBxlfCRsl3gWdXoKVSKrFqRWcmYjAhO2ABe17agaueXGeYaRgvxP3q1qb598ThumjndzfgIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IglViBi5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339287; x=1795875287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7l7/AGZrFPngqEa/UyCjzkyXoSUgfB6Kj5Wr3xA991A=;
  b=IglViBi5Yc1lijAzXEcfRn5S5GhuwN6J6WriABqLX5CfHSKvirsC2JTo
   Z7LIX9/BWQa2U5tNEvUz2ZFwyxsqaGTKy4I4GSBEsJkkG4OQfLAs5gHb3
   24ITy8kxtjN6nQ5e8Jd8zYlBBPJ0g8ILCGq2yMwNi5soAwVlvKlmoxaFK
   uJM1uiJQswEx0YCxadwFF/HdkXuhlbA0r1XM52AGLMCebkKtgk8rAEgdw
   /mk78GUBP6xGKxQj3SfPmgHZEekqqa0CmgKnZIrUSQOYYI9DgDldrSWpW
   2J2BNovIKoXyLuEeqiRqslcYqCVb5w0ycNWC+WbFBzD1dyY7C1+a6IXcN
   A==;
X-CSE-ConnectionGUID: s54C9KePRn6Fn53ewpa7dQ==
X-CSE-MsgGUID: XcAVidC/RVWgaO25Qgo5vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409430"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409430"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:46 -0800
X-CSE-ConnectionGUID: sf4HjdiZRXC67/EP4sDw0w==
X-CSE-MsgGUID: DkV5rEdpSnOtK5Yuhiu7hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823002"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:44 -0800
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
Subject: [RFC PATCH 03/16] Revert "crypto: qat - Remove zlib-deflate"
Date: Fri, 28 Nov 2025 19:04:51 +0000
Message-ID: <20251128191531.1703018-4-giovanni.cabiddu@intel.com>
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

Reintroduce the zlib-deflate implementation in the QAT driver through
the acomp api. This allows to enable the offload of the deflate
compression algorithm to QAT devices from the BTRFS filesystem.

This reverts commit e9dd20e0e5f62d01d9404db2cf9824d1faebcf71.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 .../intel/qat/qat_common/qat_comp_algs.c      | 128 +++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index a13f5fcf6bb7..26eb8dcd2e53 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -63,6 +63,69 @@ static int qat_alg_send_dc_message(struct qat_compression_req *qat_req,
 	return qat_alg_send_message(alg_req);
 }
 
+static int parse_zlib_header(u16 zlib_h)
+{
+	int ret = -EINVAL;
+	__be16 header;
+	u8 *header_p;
+	u8 cmf, flg;
+
+	header = cpu_to_be16(zlib_h);
+	header_p = (u8 *)&header;
+
+	flg = header_p[0];
+	cmf = header_p[1];
+
+	if (cmf >> QAT_RFC_1950_CM_OFFSET > QAT_RFC_1950_CM_DEFLATE_CINFO_32K)
+		return ret;
+
+	if ((cmf & QAT_RFC_1950_CM_MASK) != QAT_RFC_1950_CM_DEFLATE)
+		return ret;
+
+	if (flg & QAT_RFC_1950_DICT_MASK)
+		return ret;
+
+	return 0;
+}
+
+static int qat_comp_rfc1950_callback(struct qat_compression_req *qat_req,
+				     void *resp)
+{
+	struct acomp_req *areq = qat_req->acompress_req;
+	enum direction dir = qat_req->dir;
+	__be32 qat_produced_adler;
+
+	qat_produced_adler = cpu_to_be32(qat_comp_get_produced_adler32(resp));
+
+	if (dir == COMPRESSION) {
+		__be16 zlib_header;
+
+		zlib_header = cpu_to_be16(QAT_RFC_1950_COMP_HDR);
+		scatterwalk_map_and_copy(&zlib_header, areq->dst, 0, QAT_RFC_1950_HDR_SIZE, 1);
+		areq->dlen += QAT_RFC_1950_HDR_SIZE;
+
+		scatterwalk_map_and_copy(&qat_produced_adler, areq->dst, areq->dlen,
+					 QAT_RFC_1950_FOOTER_SIZE, 1);
+		areq->dlen += QAT_RFC_1950_FOOTER_SIZE;
+	} else {
+		__be32 decomp_adler;
+		int footer_offset;
+		int consumed;
+
+		consumed = qat_comp_get_consumed_ctr(resp);
+		footer_offset = consumed + QAT_RFC_1950_HDR_SIZE;
+		if (footer_offset + QAT_RFC_1950_FOOTER_SIZE > areq->slen)
+			return -EBADMSG;
+
+		scatterwalk_map_and_copy(&decomp_adler, areq->src, footer_offset,
+					 QAT_RFC_1950_FOOTER_SIZE, 0);
+
+		if (qat_produced_adler != decomp_adler)
+			return -EBADMSG;
+	}
+	return 0;
+}
+
 static void qat_comp_generic_callback(struct qat_compression_req *qat_req,
 				      void *resp)
 {
@@ -167,6 +230,18 @@ static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
 	memset(ctx, 0, sizeof(*ctx));
 }
 
+static int qat_comp_alg_rfc1950_init_tfm(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	int ret;
+
+	ret = qat_comp_alg_init_tfm(acomp_tfm);
+	ctx->qat_comp_callback = &qat_comp_rfc1950_callback;
+
+	return ret;
+}
+
 static int qat_comp_alg_compress_decompress(struct acomp_req *areq, enum direction dir,
 					    unsigned int shdr, unsigned int sftr,
 					    unsigned int dhdr, unsigned int dftr)
@@ -242,6 +317,43 @@ static int qat_comp_alg_decompress(struct acomp_req *req)
 	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, 0, 0, 0, 0);
 }
 
+static int qat_comp_alg_rfc1950_compress(struct acomp_req *req)
+{
+	if (!req->dst && req->dlen != 0)
+		return -EINVAL;
+
+	if (req->dst && req->dlen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
+		return -EINVAL;
+
+	return qat_comp_alg_compress_decompress(req, COMPRESSION, 0, 0,
+						QAT_RFC_1950_HDR_SIZE,
+						QAT_RFC_1950_FOOTER_SIZE);
+}
+
+static int qat_comp_alg_rfc1950_decompress(struct acomp_req *req)
+{
+	struct crypto_acomp *acomp_tfm = crypto_acomp_reqtfm(req);
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct qat_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct adf_accel_dev *accel_dev = ctx->inst->accel_dev;
+	u16 zlib_header;
+	int ret;
+
+	if (req->slen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
+		return -EBADMSG;
+
+	scatterwalk_map_and_copy(&zlib_header, req->src, 0, QAT_RFC_1950_HDR_SIZE, 0);
+
+	ret = parse_zlib_header(zlib_header);
+	if (ret) {
+		dev_dbg(&GET_DEV(accel_dev), "Error parsing zlib header\n");
+		return ret;
+	}
+
+	return qat_comp_alg_compress_decompress(req, DECOMPRESSION, QAT_RFC_1950_HDR_SIZE,
+						QAT_RFC_1950_FOOTER_SIZE, 0, 0);
+}
+
 static struct acomp_alg qat_acomp[] = { {
 	.base = {
 		.cra_name = "deflate",
@@ -256,7 +368,21 @@ static struct acomp_alg qat_acomp[] = { {
 	.exit = qat_comp_alg_exit_tfm,
 	.compress = qat_comp_alg_compress,
 	.decompress = qat_comp_alg_decompress,
-}};
+}, {
+	.base = {
+		.cra_name = "zlib-deflate",
+		.cra_driver_name = "qat_zlib_deflate",
+		.cra_priority = 4001,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct qat_compression_ctx),
+		.cra_reqsize = sizeof(struct qat_compression_req),
+		.cra_module = THIS_MODULE,
+	},
+	.init = qat_comp_alg_rfc1950_init_tfm,
+	.exit = qat_comp_alg_exit_tfm,
+	.compress = qat_comp_alg_rfc1950_compress,
+	.decompress = qat_comp_alg_rfc1950_decompress,
+} };
 
 int qat_comp_algs_register(void)
 {
-- 
2.51.1


