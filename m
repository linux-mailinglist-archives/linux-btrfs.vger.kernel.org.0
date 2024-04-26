Return-Path: <linux-btrfs+bounces-4557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E48B365D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 13:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 828D7B231D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Apr 2024 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91328145B12;
	Fri, 26 Apr 2024 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8Zk3wO5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE9144D2E;
	Fri, 26 Apr 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714129816; cv=none; b=CyI/88PM5KBcR5hZWq/hLuOqKsUfdPvnqzQo5cKxevNgcPm+LuLTTzjI2YF+QQJ5Mv2bLkSK8jzGfimzLATZ5fwtPlg4WpfBbASDzhuwiIaRIEqNUnpd2z3gwhrG69a7On4qhL9FMq3fPbJz2+ipyP+hNCSbGhwFISz/FCfu/hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714129816; c=relaxed/simple;
	bh=E3lsNuPY2s3Q+h3/lR91Vlx3BxKcj68xT1Zz7FHBTtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ0wag+rQ4vWazg0KIpb2RaIkTkJlZ0cFqGC4rRkmue+2JKzWEvKvRP1DTyU4cgpzJafD2Z29lwcNWlNTd/D+x6oiqwKS0sF+eAFCg03wqIHs+hZHUNbBGIFcg8vAwEP9Sc8J9H/wsu1hIHClI0nsRPxcpkHNODys4d3z37Ruqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8Zk3wO5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714129815; x=1745665815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E3lsNuPY2s3Q+h3/lR91Vlx3BxKcj68xT1Zz7FHBTtU=;
  b=a8Zk3wO5B/VXm5RQgqOyffddDfFv2kUZdwPDoK71wtz9UcvQaYGug5Bf
   4UYF5n2SxbB8V3UtGWYpJsuUpeYlPyASK//GD28EsfS/zHI0HUz0cDyXO
   brtQGonU9mHctC5MIxyNEAfjm+QX7Hy8+MXB9hz74yjc40BqDtz4vPRq/
   6dL/XHonotCZr7P+a5BEwcY+11qTbPvd6w9B6af1V3ZQKzILyAjw+A9cc
   WH0ONwhmp9RzfjTPto8yxTYObQLeRpryChPnO5OPxf5GzGz/bRwK2fEco
   irsiwGrRz7OFuX2f6xyAMIm8FcfUhihvP1rKe7RK1JVTeH5I3suNVDlN1
   Q==;
X-CSE-ConnectionGUID: tXmwf2fERiyCjh/kAEyv8g==
X-CSE-MsgGUID: 6757YmJURFmYXMF5juMurQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="20474090"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="20474090"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 04:10:15 -0700
X-CSE-ConnectionGUID: sdKP7++bTUSW5ohpdhqj2Q==
X-CSE-MsgGUID: lK7pFLwlSvyr4TJS5CEU1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="30030940"
Received: from unknown (HELO silpixa00400314.ger.corp.intel.com) ([10.237.222.216])
  by fmviesa004.fm.intel.com with ESMTP; 26 Apr 2024 04:10:12 -0700
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
Subject: [RFC PATCH 4/6] Revert "crypto: qat - remove unused macros in qat_comp_alg.c"
Date: Fri, 26 Apr 2024 11:54:27 +0100
Message-ID: <20240426110941.5456-5-giovanni.cabiddu@intel.com>
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

This reverts commit b4bf8295892924fca60d0704ac7cbc3b5897d233.
---
 drivers/crypto/intel/qat/qat_common/qat_comp_algs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
index 79de04cfa012..b533984906ec 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_comp_algs.c
@@ -13,6 +13,15 @@
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
2.44.0


