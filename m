Return-Path: <linux-btrfs+bounces-19406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF10AC92474
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 448174E8F49
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B01B230274;
	Fri, 28 Nov 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwjSCC9T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1AF33030A;
	Fri, 28 Nov 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339313; cv=none; b=UcgMjtxq0x3OL3SEozHcf3b9aYPH0oosSuHmYd6JTs/pxZTq55aWkhWaGwsKGqH66z7x66OC8HoyZI9vLTCymdXS3RZzl/h4R/FsiaaEk3ZGkuDqfcnKlfokSKsPzx8siiHazAJ3gIRMfM0KAu67IZPaL54aEhvvPG+5d4TphW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339313; c=relaxed/simple;
	bh=arvj1Tzez3h2mLPDFmyteEayWRHknUj2OzO98HG2YNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axZyBk3GdiYxhxABh5q0Ptsd+IkzOs78ODD2VveIAQHkamjTW+RSI9T/GFBJvbcA7u2SumdDFUpKDqIAcMEwsSL8euByoHabQSX5MswXxQ6WWG7z5BlqLEWPvZpz/ThfMPLTomplxF6pVMrN+3IcSF8i+uokgu6muQEHKX1Qu7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwjSCC9T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339312; x=1795875312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=arvj1Tzez3h2mLPDFmyteEayWRHknUj2OzO98HG2YNc=;
  b=SwjSCC9TeYjkYdKkLO6p0gFCrSXnWrBxBOuEjhkqow/T7cTVamzrlELD
   MyEdL0dB/iYoQFp4NhanQhsw33fZh0YL3yXwzJ3E8zXNQul4WWRv7TfzG
   Yf2asQ/MB4RtIAlLzHs9pmvaSootMv+YeFwUp08dIqe1i9gZzCQgKebB+
   ff2IM+ozCroA11LlI1/r9O47AZtvbtdU6eVqg2fRl/cL9FMBGWIG8hRdQ
   ch1wG5VILdWSonQAaURleE1YtowVOqRYaBwDCpXJ1DkvMCMJGzrZU7WuN
   lx7lqMVCNA3P+iJ7m3I6BaUrE3KgQEsijsbwK42KsVRE22ud5rG/ED9aO
   w==;
X-CSE-ConnectionGUID: tHQlbt4yTBSiLPnTVAguRg==
X-CSE-MsgGUID: BQXG63tqQzCtM7CVH3dzGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409547"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409547"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:12 -0800
X-CSE-ConnectionGUID: Q4yNfeFLSVOr5UHny7kGlg==
X-CSE-MsgGUID: 8UEYMinSTs6hXFwkjZWMvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823117"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:09 -0800
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
Subject: [RFC PATCH 13/16] crypto: qat - increase number of preallocated sgl descriptors
Date: Fri, 28 Nov 2025 19:05:01 +0000
Message-ID: <20251128191531.1703018-14-giovanni.cabiddu@intel.com>
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

Increase the number of pre-allocated descriptors from 4 to 32 to avoid
allocations in the worst case in the btrfs usecase, i.e. 128KB sent as
individual 4KB pages.

This increases the size of a request from 752 to 1648 bytes.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_common/qat_bl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_bl.h b/drivers/crypto/intel/qat/qat_common/qat_bl.h
index 2827d5055d3c..b3c2167a8d3b 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_bl.h
+++ b/drivers/crypto/intel/qat/qat_common/qat_bl.h
@@ -6,7 +6,7 @@
 #include <linux/scatterlist.h>
 #include <linux/types.h>
 
-#define QAT_MAX_BUFF_DESC	4
+#define QAT_MAX_BUFF_DESC	32
 
 struct qat_alg_buf {
 	u32 len;
-- 
2.51.1


