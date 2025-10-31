Return-Path: <linux-btrfs+bounces-18449-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C35C239E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 08:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78CEA4EEEE0
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6093532861E;
	Fri, 31 Oct 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYwss/d/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020BC2D7D2E;
	Fri, 31 Oct 2025 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897314; cv=none; b=FwqOc/iTpSfrPl4niRlOJDjOjWHfhdSOTziDUHQ1xOWp7FsySCRFaOjJ4PRtCTSvvXoJhiD5UjdgSOwqyDSO4f2gRRcvFYdiA7AF9TfD2axG1elnj8Kk7v+cSgds5Ni0K3sZXu8wIfEt3JgTXSQGSY+oIx4wuOwS5ZMsP0Do+OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897314; c=relaxed/simple;
	bh=/LdxHFxB9biPuzmXKzZj/U1LjDScGIgLG7T5Or72Fdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ViDQ21XlZl8HjmViOVmY3SErj1xB0ApzLeMtR3WkrMPZFYVCmWNawLlZmXoJ7Z/nlQhJgov7lqLcXLH1+QixiFMKdYAJ6ragAeMD0BnDc8NyK3mxILgrTYFfi/Qf149EDtx0pXOs4M7MJu6t21kKqMpp23kS2kZpqe8WLQ9sOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYwss/d/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761897313; x=1793433313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/LdxHFxB9biPuzmXKzZj/U1LjDScGIgLG7T5Or72Fdo=;
  b=jYwss/d/Iw4ZWfpIEXiuoBx6t3Z+unL87s9TrCY3JcBPsxdkPLJ7D2eb
   gzOdDYMjAWRyDL0CT1/pWYqgMIZwuimTxfkDqZYUYuL12yfhpX4XPXLam
   NejFa0RSB+QIyaePoxo52EdeMjqWSM4Or0z49Fu6tfSNjiUQcFS7n71p6
   vOAfVLNWQdpQhENHuROkgs06C04NY2Hk/sZi1+MhITm6xb/i06E4GhQ5L
   TQc1ErP2x3DN2lDCbxxy4MfQzm5eMUanIeBRHOOL7FKFsPFFB3vwyMIYE
   yMxz2g5V/hCWJ9QjEaBsVJSWOZeZlHuzdK8ARtps+8siFAeyq3HFg4Ogn
   Q==;
X-CSE-ConnectionGUID: TlMdyBxdRw+LmN5Zkzuhqw==
X-CSE-MsgGUID: yE3NB7DKR6+wNwAAJNTLvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="75401290"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="75401290"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 00:55:12 -0700
X-CSE-ConnectionGUID: YGkk/TC2TmOxS8brpvmrdw==
X-CSE-MsgGUID: ThopRhHhTkG3MXb/SdtR9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="185859203"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 31 Oct 2025 00:55:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6972895; Fri, 31 Oct 2025 08:55:10 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chris Mason <clm@fb.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] btrfs: Replace const_ilog2() with ilog2()
Date: Fri, 31 Oct 2025 08:55:09 +0100
Message-ID: <20251031075509.3969206-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

const_ilog2() was a workaround of some sparse issue, which was
never appeared in the C functions. Replace it with ilog2().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/btrfs/volumes.h | 5 ++---
 fs/btrfs/zoned.c   | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index adbd9e6c09ff..34b854c1a303 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -45,7 +45,7 @@ extern struct mutex uuid_mutex;
 #define BTRFS_STRIPE_LEN_SHIFT		(16)
 #define BTRFS_STRIPE_LEN_MASK		(BTRFS_STRIPE_LEN - 1)
 
-static_assert(const_ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
+static_assert(ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
 
 /* Used by sanity check for btrfs_raid_types. */
 #define const_ffs(n) (__builtin_ctzll(n) + 1)
@@ -58,8 +58,7 @@ static_assert(const_ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
  */
 static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
 	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAID0));
-static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
-	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
+static_assert(ilog2(BTRFS_BLOCK_GROUP_RAID0) > ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
 
 /* ilog2() can handle both constants and variables */
 #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2e3145c1a102..5e8b0eeeef27 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -37,8 +37,8 @@
 #define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
 #define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
 
-#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
-#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
+#define BTRFS_SB_LOG_FIRST_SHIFT	ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
+#define BTRFS_SB_LOG_SECOND_SHIFT	ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
 
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
-- 
2.50.1


