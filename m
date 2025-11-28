Return-Path: <linux-btrfs+bounces-19395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB59C92444
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F1FE4E9A22
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF47331207;
	Fri, 28 Nov 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoTXAQNu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03182330D2F;
	Fri, 28 Nov 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339285; cv=none; b=O3TM/PNHYRjMZDcNwGkd3s4jhUOIW01C2B+i00rAAdc04J+fVLuEr7uqU+dxiNnqglEEjLn91g/hJ1c/axfV6oe3Xenhz4npwFmluVCv088spfNbXYiGkBudl0q2G1f1T9BS7bPbNSaaAX8MzjEXvHhRBWT9tnKDp/8HoLCOVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339285; c=relaxed/simple;
	bh=+od//CDgnCFyFwWywtPowmtxHr4YdalI/QsEAoT0lQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAlpTmhE10ovnAYZVpj6vurjaAGkuwlKKkQSqir7eFU0GVB8QRdD9kC2Ypwb2ljDKHqE3p6J6DDQ9rfARWvM9NHBZyWb4EhXuZCKiW1c5oqCmUHCVxXFYvUcuCnpAwxYwJmE2QYoxa0XPrh4fY5CUkZx0c+A9W0cH3jRU9/3UqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoTXAQNu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339284; x=1795875284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+od//CDgnCFyFwWywtPowmtxHr4YdalI/QsEAoT0lQ4=;
  b=OoTXAQNuZiyIXtUD6gMhhN61x4X+/YoQ/krXYxjqKTuTfolH7+h1Yytw
   LJVfI95P+/iLYBAOdOwJz2T85ZgDKjfrC+FFByr9EYphJmAsPpqD+SWNe
   RmR8gEJAyuQbPIMc2JU0k0e6zdRSPGbttizuGjHG0KoYFQONKBuO6Dq4o
   neSHQ00y6KWbjjokzUUAdFEAnxA51yyPWjNKkZ1UIThpK4vrwbUc+aiSc
   ayt3ajch9LIZLEuIiXtmmi+xd6YNZLqUB78jEZlNHcKSFyF1WSo7shXp6
   IwoVwajn1wNP44uw/QJ/F2Ych/ZL9sEtgCR0SNtsn3MiRIPAdYhjdvTLF
   w==;
X-CSE-ConnectionGUID: 0zxJHjgDRlyW6YJwY8tNEg==
X-CSE-MsgGUID: Qc/2iRyMTRuAKBuBkSjkpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409420"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409420"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:44 -0800
X-CSE-ConnectionGUID: s+p3yKrITp+qaHkcylNL6A==
X-CSE-MsgGUID: 4MHavjWyQtywM6MS8IoRyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216822988"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:41 -0800
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
Subject: [RFC PATCH 02/16] Revert "crypto: qat - remove unused macros in qat_comp_alg.c"
Date: Fri, 28 Nov 2025 19:04:50 +0000
Message-ID: <20251128191531.1703018-3-giovanni.cabiddu@intel.com>
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

Reintroduce macros related to zlib-deflate in the QAT driver.

This is in preparation for the reintroduction of rfc1950 (zlib) in the
QAT driver.

This reverts commit dfff0e35fa5dd84ae75052ba129b0219d83e46dc.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_common/qat_comp_algs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 8b123472b71c..a13f5fcf6bb7 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -14,6 +14,15 @@
 #include "qat_compression.h"
 #include "qat_algs_send.h"
 
+#define QAT_RFC_1950_HDR_SIZE 2
+#define QAT_RFC_1950_FOOTER_SIZE 4
+#define QAT_RFC_1950_CM_DEFLATE 8
+#define QAT_RFC_1950_CM_DEFLATE_CINFO_32K 7
+#define QAT_RFC_1950_CM_MASK 0x0f
+#define QAT_RFC_1950_CM_OFFSET 4
+#define QAT_RFC_1950_DICT_MASK 0x20
+#define QAT_RFC_1950_COMP_HDR 0x785e
+
 static DEFINE_MUTEX(algs_lock);
 static unsigned int active_devs;
 
-- 
2.51.1


