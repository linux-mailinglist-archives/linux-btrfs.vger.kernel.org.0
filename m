Return-Path: <linux-btrfs+bounces-4556-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFF08B365B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59291F2260F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A9145B08;
	Fri, 26 Apr 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmU3sH+F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95714532D;
	Fri, 26 Apr 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129813; cv=none; b=W+sCvAlRZoVmg/fbeya7ne1wni7cZjg8o7Tuj4SNI3jvIiwIIMjKE1bRnMbILRkJp83gr/50G9Wk8OwSwdzIkBjHt+dLICrnlbffVonQM8Kj439URjevnpkVtLL7oTJ+dKH5QUciUzTROQB8Rkxa6K/z61sg6gBBN+oRplu1Owg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129813; c=relaxed/simple;
	bh=uC7DwOk0O0Wkj3or1UnUhWcE9A9EC56hI7kWvDqjUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niooT3Y09G6pKlkQy0KqcpUbmShDLRuDxEUeOZtqL4SubS6Rmc1oHMFFX6+YUCHWK5Jbu8KqfUO63X96n+cKC7WLibo5m6dYXvhgaBUThqXFhTz3oqJHrJ2KvZVeD9rhK5H3liXTZ+PnTDVHWLkQ4z3QVC2X6Rdl9ciRAdDnu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmU3sH+F; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129812; x=1745665812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uC7DwOk0O0Wkj3or1UnUhWcE9A9EC56hI7kWvDqjUX4=;
  b=gmU3sH+Fjca3CTt9nTEQR4jZRIauezYqvjtj0l+NrTg6s2ercjzyM3g6
   b9f1wF9pOt4Qw2G8gKuwy/pf+MpNMLHtZmEEcD+Rd7GHyTtF2chy3IxaQ
   W2CWt8oEX9G1qU2+NkTmZ1q5Y5MDeyNZORpbsrPP7WRMt1hjrUltYaE/5
   8J7Ha36oqeTULeGAPtUXbcG+y1mNZ91SbzzVqwUMPKPDYyVTCbEB145eU
   AWCgTJPgKdJkUBjePw/78j6kQPs3Vg03MvZyz4q18Wvt5uHdRZQTHSXZK
   870KwHn+fWLO3LX+l1zmvk1ZKFLjnaiNgMAHW5aL7A+Q+mn1TgQ9+bAVc
   A==;
X-CSE-ConnectionGUID: XyMB650WSkeqTcLz02Dc0A==
X-CSE-MsgGUID: H4uoVPscRqmYBjfpWXII6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474079"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474079"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:12 -0700
X-CSE-ConnectionGUID: GCNkBu6hST2zJcj3NidSfQ==
X-CSE-MsgGUID: eOtKe1wYQ8qntGRdaGXlLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030918"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:10:08 -0700
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
	weigang.li@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: [RFC PATCH 3/6] Revert "crypto: qat - Remove zlib-deflate"
Date: Fri, 26 Apr 2024 11:54:26 +0100
Message-ID: <20240426110941.5456-4-giovanni.cabiddu@intel.com>
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

This reverts commit e9dd20e0e5f62d01d9404db2cf9824d1faebcf71.
---
 .../intel/qat/qat_common/qat_comp_algs.c      | 129 +++++++++++++++++-
 1 file changed, 128 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 2ba4aa22e092..79de04cfa012 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -100,6 +100,69 @@ static void qat_comp_resubmit(struct work_struct *work)
 	acomp_request_complete(areq, ret);
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
@@ -221,6 +284,18 @@ static void qat_comp_alg_exit_tfm(struct crypto_acomp *acomp_tfm)
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
@@ -316,6 +391,43 @@ static int qat_comp_alg_decompress(struct acomp_req *req)
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
@@ -331,7 +443,22 @@ static struct acomp_alg qat_acomp[] = { {
 	.decompress = qat_comp_alg_decompress,
 	.dst_free = sgl_free,
 	.reqsize = sizeof(struct qat_compression_req),
-}};
+}, {
+	.base = {
+		.cra_name = "zlib-deflate",
+		.cra_driver_name = "qat_zlib_deflate",
+		.cra_priority = 4001,
+		.cra_flags = CRYPTO_ALG_ASYNC,
+		.cra_ctxsize = sizeof(struct qat_compression_ctx),
+		.cra_module = THIS_MODULE,
+	},
+	.init = qat_comp_alg_rfc1950_init_tfm,
+	.exit = qat_comp_alg_exit_tfm,
+	.compress = qat_comp_alg_rfc1950_compress,
+	.decompress = qat_comp_alg_rfc1950_decompress,
+	.dst_free = sgl_free,
+	.reqsize = sizeof(struct qat_compression_req),
+} };
 
 int qat_comp_algs_register(void)
 {
-- 
2.44.0


