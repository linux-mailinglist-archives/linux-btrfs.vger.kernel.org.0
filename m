Return-Path: <linux-btrfs+bounces-19394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 168AFC92438
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 527DE4E966B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Nov 2025 14:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7932ED26;
	Fri, 28 Nov 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MORK2k3Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706932E723;
	Fri, 28 Nov 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339283; cv=none; b=YOR7mpPMtqbAU4d/YaoC6VNat2ikDNSE3ooEHslnBkkN3mNeThsImyoaI1C/UvNZ7v/xR50KkuoLDon0SiboQ/VQFdXrACtBi0aPaL9rCPvVAJl6wljyxggJObR8dJ4I6UxfpTEf4ZmkrxeWUL+iBQNyTyebZkbFKv+Wy3S3wGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339283; c=relaxed/simple;
	bh=iF0kjRiRNkl2w4BXPKOD8k2pUNwIR0jJnr7xj5tk05E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPWf+MDhZpR5YALzefEzF6zl4wm1k8pXw0sAx5OlkxvxwGBwhw2HY9LfdvovLGXSizvzExUOIsK2gHH9H0fGf2YNrEENViJZrWUK+bEc8Wj+dDILqmF3GrIgqMt0538MpfYY1W1FbBRoRhINlRyre1p0wucjMb/ScXyOTJ4jURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MORK2k3Z; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764339282; x=1795875282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iF0kjRiRNkl2w4BXPKOD8k2pUNwIR0jJnr7xj5tk05E=;
  b=MORK2k3ZSQkLnYJyUcts/wccvOw1PG1OML7Qu/tgHgKuDY15NjE7arXg
   YeVbp27eASGb8QRZoDz4ih7mQoR7eRpXl01mdBiDRANDpgxrz7vPRQsBW
   CWGl3E+HHYuoWvqzo0wSHItmiYmeCZ2l7eDow9msY5ZjqRW5WlNIqsN4X
   EVErm/5fE5JaBaLBDYGrO64JbYBwKBvZHgMK58rmCOMV6D7OJxGNHHLBv
   0t2EDBZtXDpY3Jbg6LDsJhOku8hT8z9H95Y8qH9kiL2r3/X0MIuoh3LKG
   cbDPLnKZw5n9iuMBldiXOioxJbSUc+Cf3hxJr68Cek9TQVZn9qpGJhcrw
   w==;
X-CSE-ConnectionGUID: 3U+1hx1sTKqUwpNCAPGsTw==
X-CSE-MsgGUID: RvWX/qjKRfCWHtEh8ok6Aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66409410"
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="66409410"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 06:14:42 -0800
X-CSE-ConnectionGUID: 6ml1mIxGR9OBDytSrlZCpQ==
X-CSE-MsgGUID: D0d5870NRIW/J4UVh/OVPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,234,1758610800"; 
   d="scan'208";a="216822978"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by fmviesa002.fm.intel.com with ESMTP; 28 Nov 2025 06:14:39 -0800
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
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Subject: [RFC PATCH 01/16] crypto: zstd - fix double-free in per-CPU stream cleanup
Date: Fri, 28 Nov 2025 19:04:49 +0000
Message-ID: <20251128191531.1703018-2-giovanni.cabiddu@intel.com>
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

The crypto/zstd module has a double-free bug that occurs when multiple
tfms are allocated and freed.

The issue happens because zstd_streams (per-CPU contexts) are freed in
zstd_exit() during every tfm destruction, rather than being managed at
the module level.  When multiple tfms exist, each tfm exit attempts to
free the same shared per-CPU streams, resulting in a double-free.

This leads to a stack trace similar to:

  BUG: Bad page state in process kworker/u16:1  pfn:106fd93
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x106fd93
  flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
  page_type: 0xffffffff()
  raw: 0017ffffc0000000 dead000000000100 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: nonzero entire_mapcount
  Modules linked in: ...
  CPU: 3 UID: 0 PID: 2506 Comm: kworker/u16:1 Kdump: loaded Tainted: G    B
  Hardware name: ...
  Workqueue: btrfs-delalloc btrfs_work_helper
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   bad_page+0x71/0xd0
   free_unref_page_prepare+0x24e/0x490
   free_unref_page+0x60/0x170
   crypto_acomp_free_streams+0x5d/0xc0
   crypto_acomp_exit_tfm+0x23/0x50
   crypto_destroy_tfm+0x60/0xc0
   ...

Change the lifecycle management of zstd_streams to free the streams only
once during module cleanup.

Fixes: f5ad93ffb541 ("crypto: zstd - convert to acomp")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
---
 crypto/zstd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/crypto/zstd.c b/crypto/zstd.c
index dc5b36141ff8..cbbd0413751a 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -75,11 +75,6 @@ static int zstd_init(struct crypto_acomp *acomp_tfm)
 	return ret;
 }
 
-static void zstd_exit(struct crypto_acomp *acomp_tfm)
-{
-	crypto_acomp_free_streams(&zstd_streams);
-}
-
 static int zstd_compress_one(struct acomp_req *req, struct zstd_ctx *ctx,
 			     const void *src, void *dst, unsigned int *dlen)
 {
@@ -297,7 +292,6 @@ static struct acomp_alg zstd_acomp = {
 		.cra_module = THIS_MODULE,
 	},
 	.init = zstd_init,
-	.exit = zstd_exit,
 	.compress = zstd_compress,
 	.decompress = zstd_decompress,
 };
@@ -310,6 +304,7 @@ static int __init zstd_mod_init(void)
 static void __exit zstd_mod_fini(void)
 {
 	crypto_unregister_acomp(&zstd_acomp);
+	crypto_acomp_free_streams(&zstd_streams);
 }
 
 module_init(zstd_mod_init);
-- 
2.51.1


