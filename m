Return-Path: <linux-btrfs+bounces-19397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68032C92456
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94D444EA083
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE42331221;
	Fri, 28 Nov 2025 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWTcdAUA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26732ED40;
	Fri, 28 Nov 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339290; cv=none; b=LfM3M9ibPD7FiZplOOST4xuicuI+c2aNOLByHeAC2dg4FuwScGqmCMVV5+sZWl+eobnfbbm7Jb0FEueMM3ZVwgiNkm5JDXtI4Y+Ych29iVNJBSGVmAlNkgKyk5DNLfKOfFC/DO0MLAlC+Yoha6dS4VtWM8MyqlDEHm8FZtcm0l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339290; c=relaxed/simple;
	bh=/zFq9cXuBcW9xR6cwGe0Hbz/g3IBOPnFfv9biH9ASsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1hQuTJcpNB39Ff3eaVKqEKPML/6EOJ2IPH9i+UyRVImqYEQsLKSro8v8EEasSKDsCPA5f+auZv5C4lphsl8ZfBzcPH9PQEy76PQdnN5Xt2ONoWmUa9getiTcYv6i826YGUetv8PlKCBkCKscPfTNRhXWSdItyOjP8Gk76le6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWTcdAUA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339289; x=1795875289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/zFq9cXuBcW9xR6cwGe0Hbz/g3IBOPnFfv9biH9ASsI=;
  b=NWTcdAUAbZMaGvIHtnyPc1+EGiZB4SjUPv6oyQQhrNf++4sjPKgUDqZP
   hRaSEjX6h28x2a2x/asEG4xWLWobLwSk5xWRO8ehWRrDI7nX4V1D3zTwg
   pq6at2ruFA2WJA4v1levHyvKVvU6YQW28eyeiwRhRBzP+wfvyyeO6bj+8
   zbcbpaff+K/d4gRHrP9oIoO33N3f/lvGSXHnSlLLwM4W3lcIN4W8Gyijw
   1SqDQS6yz4gHecLkXjUpVd0rSO2+jYXryNEDVC69rZX9MtV+Q/DNBln7Q
   EdjaKJJznw1fn7GcfBcdcFDFFxsGuh4Z9fMf0+SE9T3GkWbEjifg61vTR
   Q==;
X-CSE-ConnectionGUID: kJW1dM8bTImEVI0O52Z5Xg==
X-CSE-MsgGUID: to95KUy5Rg2S1UTYL5WmZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409441"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409441"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:49 -0800
X-CSE-ConnectionGUID: eE8uj7LvR/SReB7W2PFsCg==
X-CSE-MsgGUID: yabBKOZRSzuPFzD8OmCf+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823010"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:46 -0800
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
Subject: [RFC PATCH 04/16] crypto: qat - use memcpy_*_sglist() in zlib deflate
Date: Fri, 28 Nov 2025 19:04:52 +0000
Message-ID: <20251128191531.1703018-5-giovanni.cabiddu@intel.com>
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

Replace istances of scatterwalk_map_and_copy() with memcpy_to_sglist()
and memcpy_from_sglist() to increase readability.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_common/qat_comp_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 26eb8dcd2e53..23a1ed4f6b40 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -101,11 +101,11 @@ static int qat_comp_rfc1950_callback(struct qat_compression_req *qat_req,
 		__be16 zlib_header;
 
 		zlib_header = cpu_to_be16(QAT_RFC_1950_COMP_HDR);
-		scatterwalk_map_and_copy(&zlib_header, areq->dst, 0, QAT_RFC_1950_HDR_SIZE, 1);
+		memcpy_to_sglist(areq->dst, 0, &zlib_header, QAT_RFC_1950_HDR_SIZE);
 		areq->dlen += QAT_RFC_1950_HDR_SIZE;
 
-		scatterwalk_map_and_copy(&qat_produced_adler, areq->dst, areq->dlen,
-					 QAT_RFC_1950_FOOTER_SIZE, 1);
+		memcpy_to_sglist(areq->dst, areq->dlen, &qat_produced_adler,
+				 QAT_RFC_1950_FOOTER_SIZE);
 		areq->dlen += QAT_RFC_1950_FOOTER_SIZE;
 	} else {
 		__be32 decomp_adler;
@@ -117,8 +117,8 @@ static int qat_comp_rfc1950_callback(struct qat_compression_req *qat_req,
 		if (footer_offset + QAT_RFC_1950_FOOTER_SIZE > areq->slen)
 			return -EBADMSG;
 
-		scatterwalk_map_and_copy(&decomp_adler, areq->src, footer_offset,
-					 QAT_RFC_1950_FOOTER_SIZE, 0);
+		memcpy_from_sglist(&decomp_adler, areq->src, footer_offset,
+				   QAT_RFC_1950_FOOTER_SIZE);
 
 		if (qat_produced_adler != decomp_adler)
 			return -EBADMSG;
@@ -342,7 +342,7 @@ static int qat_comp_alg_rfc1950_decompress(struct acomp_req *req)
 	if (req->slen <= QAT_RFC_1950_HDR_SIZE + QAT_RFC_1950_FOOTER_SIZE)
 		return -EBADMSG;
 
-	scatterwalk_map_and_copy(&zlib_header, req->src, 0, QAT_RFC_1950_HDR_SIZE, 0);
+	memcpy_from_sglist(&zlib_header, req->src, 0, QAT_RFC_1950_HDR_SIZE);
 
 	ret = parse_zlib_header(zlib_header);
 	if (ret) {
-- 
2.51.1


