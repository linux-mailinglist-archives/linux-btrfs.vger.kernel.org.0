Return-Path: <linux-btrfs+bounces-103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9217EA22C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FD51C209CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE02B23758;
	Mon, 13 Nov 2023 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bWFV7bmG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4131123743;
	Mon, 13 Nov 2023 17:37:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB7E19B1;
	Mon, 13 Nov 2023 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897066; x=1731433066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DtA/Z1IbwRhdE1Z9R1wqv+Q2gww15OYcKaj1wGIz64g=;
  b=bWFV7bmG9JKWOR3kJ0McR6JRmxGOGdAlTetpaSpqMZMZGrEcZ9Z8EInh
   W9dHTckVwQMZvIA2WwlJ9lReOHHNKB/xthjnyc4BdxxC+AG8KfFR8Hujb
   ZuWq0vJXhuBzjkNXbM6X6ZUGzM4PQ5it/KrvZlg2SsZm9Izig8LB6pc28
   1BNhn8ILe3yGKol0ND3bwzhI4RrVPHsc1T/LU2P4fu3v8X0YFBTy53EsN
   BWvhTQNP6hEVfOslZmq8YHmLIoWyacVLv9QWl8kjHPZu1cemzYxIT4BS7
   t1ewvpLTGbWqkwXCJyAq4vBLXm5FD4Hsiri/XytmoiSOXKxgiWhVliT3p
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671606"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812704"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812704"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:42 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v3 07/11] btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
Date: Mon, 13 Nov 2023 18:37:13 +0100
Message-ID: <20231113173717.927056-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113173717.927056-1-aleksander.lobakin@intel.com>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
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
index 6f93c9a2c3e3..8f4949f0b5e2 100644
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
2.41.0


