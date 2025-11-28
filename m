Return-Path: <linux-btrfs+bounces-19403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00DC9241C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F85C350321
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF0630E0CC;
	Fri, 28 Nov 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3/QMz4H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0B32FA16;
	Fri, 28 Nov 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339306; cv=none; b=UxHzzT2/Mfpqn6v1gXq7Spa+gaoaGua8ScmZnXlEZb34/RrdPWAr3j0ZyxOE3GDLfvJYVTA7VlzvzeSy/hsxV6V08wts5EoOIu0NNprlKzzblF7z07IjOvC1OTegx0XD87xUnDDhAFKHN3+4llydEo7lzGNMugpNzIFgLsPM2Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339306; c=relaxed/simple;
	bh=k8wB5+U4i+8/u8ugtnFauCCmnoiZiEySavdKK5tdEIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAWANSImHKbNF100C+RHK4ilMYT5O38s88NCZlvhmPMx4fmL62uJw7fvz626h5H69IpNe4NsgNy7HlnA+jOOVX7aG9OMm7+M3tFH9COW3be+UY0ODK1WbM8fu8q69LjdMmpKgq5DJIHKNLf4WCyAPthssBBMYsWmnle6Px4oAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3/QMz4H; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339305; x=1795875305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8wB5+U4i+8/u8ugtnFauCCmnoiZiEySavdKK5tdEIM=;
  b=M3/QMz4Hb2gpO61a8wE5YIIxuzk8mxVpceLGsEuZig9JdcIjnQRiET+l
   wd4n2RPk57zYWbvziuiGosZchoHeYOALkPj92s1lXAoncDcMm53BaR2K7
   snVlDvZ1vdoCdoWgS9fwOpQ8Qpk49jqOvlBAMGefsbMqjkNxICIK8VyHn
   ihXi9Qs5ZijK7lmEMzpofVNIM906gmQXc5UFeT8qobMQmblL7oc1UmN3Y
   6XZjG+PJdA5n0/VJaUS0WlQzNg6SEqt+Qj70vn7nBAXCjwc+R4RnjBuG8
   5zd5aFKbalh1lcEGcdH6VdQQC/4CH+v2KIyrSkmIA8+awgumQoVgLmh6s
   g==;
X-CSE-ConnectionGUID: Fibf1uOCQciQjpN1gHAaGA==
X-CSE-MsgGUID: u4p7s8AvRVahTjkvs+/rAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409516"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409516"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:15:04 -0800
X-CSE-ConnectionGUID: GTV3Xtx9RB6ab2K97K/W3A==
X-CSE-MsgGUID: foxxR7iDTM6sQ1eqw9kEpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216823084"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:15:01 -0800
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
Subject: [RFC PATCH 10/16] crypto: acomp - add NUMA-aware stream allocation
Date: Fri, 28 Nov 2025 19:04:58 +0000
Message-ID: <20251128191531.1703018-11-giovanni.cabiddu@intel.com>
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

Add NUMA node awareness to compression stream allocation to improve
performance on multi-socket systems by allocating memory local to the
CPU that will use it.

Add `int node` parameter to alloc_ctx() in the structure
crypto_acomp_stream and update crypto_acomp_alloc_streams() and
acomp_stream_workfn() to pass the node id to allocators.

Update all compression implementations to accept and use the new node
parameter.

Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 crypto/842.c                        |  4 ++--
 crypto/acompress.c                  | 11 ++++++++---
 crypto/deflate.c                    |  4 ++--
 crypto/lz4.c                        |  4 ++--
 crypto/lz4hc.c                      |  4 ++--
 crypto/lzo-rle.c                    |  4 ++--
 crypto/lzo.c                        |  4 ++--
 crypto/zstd.c                       |  4 ++--
 include/crypto/internal/acompress.h |  2 +-
 9 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/crypto/842.c b/crypto/842.c
index 4007e87bed80..b2d786efcd99 100644
--- a/crypto/842.c
+++ b/crypto/842.c
@@ -23,11 +23,11 @@
 #include <linux/module.h>
 #include <linux/sw842.h>
 
-static void *crypto842_alloc_ctx(void)
+static void *crypto842_alloc_ctx(int node)
 {
 	void *ctx;
 
-	ctx = kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);
+	ctx = kmalloc_node(SW842_MEM_COMPRESS, GFP_KERNEL, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/crypto/acompress.c b/crypto/acompress.c
index a9d77056bd43..394ce1a266e7 100644
--- a/crypto/acompress.c
+++ b/crypto/acompress.c
@@ -438,12 +438,14 @@ static void acomp_stream_workfn(struct work_struct *work)
 	for_each_cpu(cpu, &s->stream_want) {
 		struct crypto_acomp_stream *ps;
 		void *ctx;
+		int node;
 
 		ps = per_cpu_ptr(streams, cpu);
 		if (ps->ctx)
 			continue;
 
-		ctx = s->alloc_ctx();
+		node = cpu_to_node(cpu);
+		ctx = s->alloc_ctx(node);
 		if (IS_ERR(ctx))
 			break;
 
@@ -487,6 +489,7 @@ int crypto_acomp_alloc_streams(struct crypto_acomp_streams *s)
 	struct crypto_acomp_stream *ps;
 	unsigned int i;
 	void *ctx;
+	int node;
 
 	if (s->streams)
 		return 0;
@@ -495,13 +498,15 @@ int crypto_acomp_alloc_streams(struct crypto_acomp_streams *s)
 	if (!streams)
 		return -ENOMEM;
 
-	ctx = s->alloc_ctx();
+	i = cpumask_first(cpu_possible_mask);
+	node = cpu_to_node(i);
+
+	ctx = s->alloc_ctx(node);
 	if (IS_ERR(ctx)) {
 		free_percpu(streams);
 		return PTR_ERR(ctx);
 	}
 
-	i = cpumask_first(cpu_possible_mask);
 	ps = per_cpu_ptr(streams, i);
 	ps->ctx = ctx;
 
diff --git a/crypto/deflate.c b/crypto/deflate.c
index 26b4617f6196..d75c2951dfa9 100644
--- a/crypto/deflate.c
+++ b/crypto/deflate.c
@@ -33,14 +33,14 @@ struct deflate_stream {
 
 static DEFINE_MUTEX(deflate_stream_lock);
 
-static void *deflate_alloc_stream(void)
+static void *deflate_alloc_stream(int node)
 {
 	size_t size = max(zlib_inflate_workspacesize(),
 			  zlib_deflate_workspacesize(MAX_WBITS,
 						     DEFLATE_DEF_MEMLEVEL));
 	struct deflate_stream *ctx;
 
-	ctx = kvmalloc(struct_size(ctx, workspace, size), GFP_KERNEL);
+	ctx = kvmalloc_node(struct_size(ctx, workspace, size), GFP_KERNEL, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/crypto/lz4.c b/crypto/lz4.c
index 57b713516aef..ce125ecf889d 100644
--- a/crypto/lz4.c
+++ b/crypto/lz4.c
@@ -12,11 +12,11 @@
 #include <linux/lz4.h>
 #include <crypto/internal/scompress.h>
 
-static void *lz4_alloc_ctx(void)
+static void *lz4_alloc_ctx(int node)
 {
 	void *ctx;
 
-	ctx = vmalloc(LZ4_MEM_COMPRESS);
+	ctx = vmalloc_node(LZ4_MEM_COMPRESS, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/crypto/lz4hc.c b/crypto/lz4hc.c
index bb84f8a68cb5..c815ce2e0b67 100644
--- a/crypto/lz4hc.c
+++ b/crypto/lz4hc.c
@@ -10,11 +10,11 @@
 #include <linux/vmalloc.h>
 #include <linux/lz4.h>
 
-static void *lz4hc_alloc_ctx(void)
+static void *lz4hc_alloc_ctx(int node)
 {
 	void *ctx;
 
-	ctx = vmalloc(LZ4HC_MEM_COMPRESS);
+	ctx = vmalloc_node(LZ4HC_MEM_COMPRESS, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/crypto/lzo-rle.c b/crypto/lzo-rle.c
index 794e7ec49536..13144cc9c501 100644
--- a/crypto/lzo-rle.c
+++ b/crypto/lzo-rle.c
@@ -9,11 +9,11 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-static void *lzorle_alloc_ctx(void)
+static void *lzorle_alloc_ctx(int node)
 {
 	void *ctx;
 
-	ctx = kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	ctx = kvmalloc_node(LZO1X_MEM_COMPRESS, GFP_KERNEL, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/crypto/lzo.c b/crypto/lzo.c
index d43242b24b4e..ffae9a09599d 100644
--- a/crypto/lzo.c
+++ b/crypto/lzo.c
@@ -9,11 +9,11 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-static void *lzo_alloc_ctx(void)
+static void *lzo_alloc_ctx(int node)
 {
 	void *ctx;
 
-	ctx = kvmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);
+	ctx = kvmalloc_node(LZO1X_MEM_COMPRESS, GFP_KERNEL, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/crypto/zstd.c b/crypto/zstd.c
index cbbd0413751a..fd240130ad4c 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -31,7 +31,7 @@ struct zstd_ctx {
 
 static DEFINE_MUTEX(zstd_stream_lock);
 
-static void *zstd_alloc_stream(void)
+static void *zstd_alloc_stream(int node)
 {
 	zstd_parameters params;
 	struct zstd_ctx *ctx;
@@ -44,7 +44,7 @@ static void *zstd_alloc_stream(void)
 	if (!wksp_size)
 		return ERR_PTR(-EINVAL);
 
-	ctx = kvmalloc(struct_size(ctx, wksp, wksp_size), GFP_KERNEL);
+	ctx = kvmalloc_node(struct_size(ctx, wksp, wksp_size), GFP_KERNEL, node);
 	if (!ctx)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/include/crypto/internal/acompress.h b/include/crypto/internal/acompress.h
index 89f742190091..11f11a78360d 100644
--- a/include/crypto/internal/acompress.h
+++ b/include/crypto/internal/acompress.h
@@ -65,7 +65,7 @@ struct crypto_acomp_stream {
 
 struct crypto_acomp_streams {
 	/* These must come first because of struct scomp_alg. */
-	void *(*alloc_ctx)(void);
+	void *(*alloc_ctx)(int node);
 	void (*free_ctx)(void *);
 
 	struct crypto_acomp_stream __percpu *streams;
-- 
2.51.1


