Return-Path: <linux-btrfs+bounces-15520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C288B06FC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28A4A1AA0449
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 08:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0B291C00;
	Wed, 16 Jul 2025 08:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pyKh8gWw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01701B394F
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652819; cv=none; b=YDDJDHHqdv1w7PE9DiuFtfBQQt3pPVWGfy4fU0X8GaWUdRUTiKMf4RLu3l2R/44c5MoZPWUkyjXfbpJt0LiUObElVQ2LZATHqpOdF0WVOcoWC4DkoE/oS4LAq9WSPGBQk3HWDOYLBCFE/2fQtZRuouOxKoDPmB1B1danymtQyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652819; c=relaxed/simple;
	bh=8lSP1tbeIFDAemvNdBcIHO/igl9+A0dLLsKlk6/ls/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9ZhgtAla8BrO77Pg80lDhuBmq1jiG1dwpCiDcWFKIF9vVf38utzo44YXDm/pevlM7eMzkLjQg0susNCvDYO+J79HRhLOLwSG0YhUNzb0KK9JxIv3nQXM+avhmHfMvrzSMay4ij+z51LYUf7iLg9r+hF7Tczd5NyEyOa/EFykg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pyKh8gWw; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752652817; x=1784188817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8lSP1tbeIFDAemvNdBcIHO/igl9+A0dLLsKlk6/ls/0=;
  b=pyKh8gWwK9KEAv3s7ritG7sdBNzghwrsdNeUK++aqKv5rtar2v9fl8Pm
   83uZaPvot4vbUGvGuaXpw9xYnRoc/vjwO7HAtHi2Mw6mYWFjFhhe6YnG6
   R0WoKdPW3rb3u3+ucGGVo967gW8Yr5UWbDZDMk6RA3TwRn239RD7VKWM1
   hUKn3kBiJVNvCjXfNkQcLNyLeDMeUoAQOhVzRsqoWjU2L3ftu6L9Nh7eK
   gr+n+ftjg+dNT3UKN8COh0Ig0lklw70bKJNV7eCH2AmC1hx4Wt7no8YeC
   b5Vfz8x/lD09piuLkMCmhECN1Vw7HofAuf8CA5RhOsEX8XMkHh2sUXHOl
   A==;
X-CSE-ConnectionGUID: JM3fa7rCQxWZu3RHM0SY8w==
X-CSE-MsgGUID: hXVrIeA5SG6hwx5r9v3N3g==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="94432933"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 16:00:17 +0800
IronPort-SDR: 68774d6f_n9hwLdrhiMm6dE023ukpl5cPocW/o8vSht2VtVB1OAq8W7g
 zXOdKtYyXcU/zO1o+XkeLUleBKyAY+V6OMgoqbg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 23:57:51 -0700
WDCIronportException: Internal
Received: from wdap-0lwmw3epm9.ad.shared (HELO naota-xeon) ([10.224.173.10])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2025 01:00:16 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/4] btrfs: zoned: do not select metadata BG as finish target
Date: Wed, 16 Jul 2025 16:59:52 +0900
Message-ID: <c927992dc7a67129faf0eadd8fe6640a7e823efa.1752652539.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752652539.git.naohiro.aota@wdc.com>
References: <cover.1752652539.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We call btrfs_zone_finish_one_bg() to zone finish one block group and make
room to activate another block group. Currently, we can choose a metadata
block group as a target. But, as we reserve an active metadata block group,
we no longer want to select a metadata block group. So, skip it in the
loop.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 245e813ecd78..db11b5b5f0e6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2650,7 +2650,7 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
-		    (block_group->flags & BTRFS_BLOCK_GROUP_SYSTEM) ||
+		    !(block_group->flags & BTRFS_BLOCK_GROUP_DATA) ||
 		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			continue;
-- 
2.50.1


