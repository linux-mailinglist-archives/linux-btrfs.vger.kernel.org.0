Return-Path: <linux-btrfs+bounces-19402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7815EC92462
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880844E6B53
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7B32E6B8;
	Fri, 28 Nov 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5mMYv3m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585E032F740;
	Fri, 28 Nov 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339302; cv=none; b=UJgN6+h/88d/Lc5aEzNKwiQDXQrAfG+IEZ0lO7PBESdiZU3EpVeNKGtX7IA8fLIIR41PRE5ZIWCaP8chV/1NcbNacN/liYN6Y6j18nnrBsTYMHSRJMQ7PiN/Ay2yRmAhmrfs6ndSpTmlc9++47lmio2d3Y3UnlB40OyQAcYELsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339302; c=relaxed/simple;
	bh=hpZ4/l0c1WD3QDMRB2B5f3RSQoBkdnTIJ3jWIU+XXUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rspiSG4ofIDz63LVwXWqkxJkngq7PQi7Kc07We5YS+aRzYjNCN017QH7xjQcpkH4DfL8uFwpN4CYwOvdjV5NOQWYGF2vpwqPKCZmuxUyukiBE2zCmyX0LiMTnTv+s/vTrNSpejyFe8+bIYS+XIA7tzNhe0i6zdx1hrw5OJtEpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5mMYv3m; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339301; x=1795875301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hpZ4/l0c1WD3QDMRB2B5f3RSQoBkdnTIJ3jWIU+XXUg=;
  b=D5mMYv3mY41faWR6zqsAxHvFCRsNmaEO7PKG13OXXKGtrPu1WeRNMnNt
   bSQabVNkKUF3CzgZI19gVMJYNSeEg3ejObKex24N1bsH/8lJdmJREJGSC
   vfuKFYIXtKZevR3HrG68AUqcGb6c0/gMUmWvbiG+j6JK1UEs45zCed7xQ
   UJD0DY12gZ8OvwJWiyrdr2jc4AAzUDIAqY5S5KbiFFOiItiVXfNBgbu8i
   JDhld/z2/PNd/wTFnBy1diDU16DKXXOsMf3leyt8vD/jqGW3UHoBVT94q
   bUUYrGPO45j/B9HXWCVutB3IrPjg0riEbFXSSLsjFTPIQBW+iYfCoWkFW
   Q==;
X-CSE-ConnectionGUID: KtrJuwqsRj+Xk9jttgWBKw==
X-CSE-MsgGUID: YjxQ/8IaTEm3nWGyqxilWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409501"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409501"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:01 -0800
X-CSE-ConnectionGUID: 7EMSUrkVQgexruzBJEGhew==
X-CSE-MsgGUID: Nvb3VzYQSfW0dXhqQVu2sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823063"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:59 -0800
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
Subject: [RFC PATCH 09/16] crypto: acomp - Add comp_params helpers
Date: Fri, 28 Nov 2025 19:04:57 +0000
Message-ID: <20251128191531.1703018-10-giovanni.cabiddu@intel.com>
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

From: Herbert Xu <herbert@gondor.apana.org.au>

Add helpers to get compression parameters, including the level
and an optional dictionary.

Note that algorithms do not have to use these helpers and could
come up with its own set of parameters.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/acompress.c                  | 49 +++++++++++++++++++++++++++++
 include/crypto/acompress.h          |  9 ++++++
 include/crypto/internal/acompress.h | 10 ++++++
 3 files changed, 68 insertions(+)

diff --git a/crypto/acompress.c b/crypto/acompress.c
index 12bae6ee5925..a9d77056bd43 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/percpu.h>
+#include <linux/rtnetlink.h>
 #include <linux/scatterlist.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
@@ -651,5 +652,53 @@ struct acomp_req *acomp_request_clone(struct acomp_req *req,
 }
 EXPORT_SYMBOL_GPL(acomp_request_clone);
 
+int crypto_acomp_getparams(struct crypto_acomp_params *params, const u8 *raw,
+			   unsigned int len)
+{
+	struct rtattr *rta = (struct rtattr *)raw;
+	void *dict;
+
+	crypto_acomp_putparams(params);
+	params->level = CRYPTO_COMP_NO_LEVEL;
+
+	for (;; rta = RTA_NEXT(rta, len)) {
+		if (!RTA_OK(rta, len))
+			return -EINVAL;
+
+		if (rta->rta_type == CRYPTO_COMP_PARAM_LAST)
+			break;
+
+		switch (rta->rta_type) {
+		case CRYPTO_COMP_PARAM_LEVEL:
+			if (RTA_PAYLOAD(rta) != 4)
+				return -EINVAL;
+			memcpy(&params->level, RTA_DATA(rta), 4);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	dict = RTA_NEXT(rta, len);
+	if (!len)
+		return 0;
+
+	params->dict = kvmemdup(dict, len, GFP_KERNEL);
+	if (!params->dict)
+		return -ENOMEM;
+	params->dict_sz = len;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(crypto_acomp_getparams);
+
+void crypto_acomp_putparams(struct crypto_acomp_params *params)
+{
+	kvfree(params->dict);
+	params->dict = NULL;
+	params->dict_sz = 0;
+}
+EXPORT_SYMBOL_GPL(crypto_acomp_putparams);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Asynchronous compression type");
diff --git a/include/crypto/acompress.h b/include/crypto/acompress.h
index 3e735171271e..98a1fd5ed0f8 100644
--- a/include/crypto/acompress.h
+++ b/include/crypto/acompress.h
@@ -15,6 +15,7 @@
 #include <linux/container_of.h>
 #include <linux/crypto.h>
 #include <linux/err.h>
+#include <linux/limits.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/spinlock_types.h>
@@ -69,6 +70,14 @@ struct acomp_req_chain {
 	u32 flags;
 };
 
+#define CRYPTO_COMP_NO_LEVEL		INT_MIN
+
+enum {
+	CRYPTO_COMP_PARAM_UNSPEC,
+	CRYPTO_COMP_PARAM_LEVEL,
+	CRYPTO_COMP_PARAM_LAST,
+};
+
 /**
  * struct acomp_req - asynchronous (de)compression request
  *
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index 4cdc98a64418..89f742190091 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -104,6 +104,12 @@ struct acomp_walk {
 	int flags;
 };
 
+struct crypto_acomp_params {
+	int level;
+	unsigned int dict_sz;
+	void *dict;
+};
+
 /*
  * Transform internal helpers.
  */
@@ -244,4 +250,8 @@ static inline struct acomp_req *acomp_fbreq_on_stack_init(
 	return req;
 }
 
+int crypto_acomp_getparams(struct crypto_acomp_params *params, const u8 *raw,
+			   unsigned int len);
+void crypto_acomp_putparams(struct crypto_acomp_params *params);
+
 #endif
-- 
2.51.1


