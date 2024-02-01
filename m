Return-Path: <linux-btrfs+bounces-2005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A284579C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABB529655C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0AE5CDD0;
	Thu,  1 Feb 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By9L0e9J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07016086B;
	Thu,  1 Feb 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790265; cv=none; b=P2102AXeTulv7jXUxgHj9YtLn6DUzTzseHDPPDZhYrOySf2vCu4EJvzXEK7osVie6DcDPECzYz5wVXNX7GfhSTlyXQjo/PSqISWswAFWufucUNSwD5/5zkapow3l5Zhi8+8KoHiO0eqx//c8OKRH/1397QkesT5+4rWuyLtkdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790265; c=relaxed/simple;
	bh=e3PhzQpSUJrSBLo17HbDTH0gB03sLbkzrAZOLsNo208=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idRo/RIdblSW1Hll0y6LR/uL0r8apu2QRpcSB6/hn3O3i57jO7n0x3dphEFU7yBDA7jmg9ecwtG0WeW8h5qCG9DgfvUKyrMc/O3I0EAiJu/kKF4CW04xJmC/vc6h8GTtPX30EuUjualJbwRpGWcMgW6nhn89xGAA4WYIN5ltBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By9L0e9J; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790264; x=1738326264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3PhzQpSUJrSBLo17HbDTH0gB03sLbkzrAZOLsNo208=;
  b=By9L0e9JNyOBSz1OYirC3ozKnHwnle2dcIO9372qRnCcr5seLQhY8egU
   WJ290pJWUXjvaGz7Set5uFLFdCLD3V75iBOKhJS1GY5UQk7AUOyWIzMV0
   j3Try2X7c6PdNoNxCUDkMSn4F2rzmPpmR1jMY8f11EcHOV2oMBzzQQ4P1
   9bWBv8LN8IZDkWNBVRdy8ipo0uHMXLUdH4VXnK7CfZjEvpxg0+fmE2YBk
   54nO0SEaT+iDb99wMwYNoGalzRiW8ayL8BQCUJ2QtU3CaBt+6JbfIm7XO
   KJIVvmxSVg0sfedmdU+eSzrbH6ag/1y1RSCfogjffrcWEsT4vXZE1P5Db
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747070"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747070"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499119"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:18 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH net-next v5 10/21] btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
Date: Thu,  1 Feb 2024 13:22:05 +0100
Message-ID: <20240201122216.2634007-11-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_set_bits() does not start with the FS' prefix and may collide
with a new generic helper one day. It operates with the FS-specific
types, so there's no change those two could do the same thing.
Just add the prefix to exclude such possible conflict.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d372c7ce0e6b..47c979c3e67e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1913,9 +1913,9 @@ static inline void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		ctl->free_space -= bytes;
 }
 
-static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
-			    struct btrfs_free_space *info, u64 offset,
-			    u64 bytes)
+static void btrfs_bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
+				  struct btrfs_free_space *info, u64 offset,
+				  u64 bytes)
 {
 	unsigned long start, count, end;
 	int extent_delta = 1;
@@ -2251,7 +2251,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bytes_to_set = min(end - offset, bytes);
 
-	bitmap_set_bits(ctl, info, offset, bytes_to_set);
+	btrfs_bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
 	return bytes_to_set;
 
-- 
2.43.0


