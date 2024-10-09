Return-Path: <linux-btrfs+bounces-8676-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE45F995EA0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 06:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAC81C21FC3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D02868B;
	Wed,  9 Oct 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d1l2uSZO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B397913D297
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448229; cv=none; b=qkk7yoJrPYUzqt8AXd8oddXVUEFNCFP2mpreFei0RHi16/dxuoktXEP7nAuCnsi+bJGje/AJOu9z766CSlVvL+d2qL2/YsdQWZCCS2BZz10od8c0Ur3RJfUzt2sDkcnjDeR477vMh1sXAoh/FljiVD/byHDlRWQdSDHByJYd6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448229; c=relaxed/simple;
	bh=pfkTIAIBRceKezzBLVZiusJIFUgcr0F6VMr05Ztuvv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FlM8BDi3lRMGdaUdnSPARZeioS6tLTnvi+yzHoxuMV6rKQKSI8xna71Q1o6Z48xmmOhnWpDHYdkNmOJJ+KnlnJkkFokpmm8wp13pIOWir495IN/tlh3bFA8b6Nmvjh6Cm1acRNP2fpeib1hru57e08d+zoKuAcQ73cfi9o7X9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d1l2uSZO; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728448227; x=1759984227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pfkTIAIBRceKezzBLVZiusJIFUgcr0F6VMr05Ztuvv0=;
  b=d1l2uSZOKjQuOJBiQVdfmk/c1mJGSqdxmhh++50/I/9WjRhMUhkkTnzp
   YtVqU8o7eDDAmG5oTEYMzw9aI+8U+w1+dDWNofAGu6Q3gyxR6PDrHIdkY
   /Mqdh8G6NwfIJsfz8QGUjy7hIN+PNGbIGNPWuI0DfBHuF2n72aY2lphxj
   JXKogZbdQ1Mlqm2I++SMM4oy/DvJY6VwTR4oNq7esYc16FTk19DYYnEbf
   LGTzJBphbVOoHKBn/bB6vchJ/j/jFVLn5v55DX9Ink6hrWaYb8yimksLm
   FVZ+tXEg0vJbqxVz0bLStKXfVUxlRrzecvNjapOnwS5Lllv7vWKyIh+eX
   A==;
X-CSE-ConnectionGUID: qboxoZgWS5aXdj9kmz1aag==
X-CSE-MsgGUID: nzJTR31+SHqi5DKRHIw0Iw==
X-IronPort-AV: E=Sophos;i="6.11,189,1725292800"; 
   d="scan'208";a="27943874"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2024 12:30:21 +0800
IronPort-SDR: 6705f9d7_fW2uEWLFXcYIBLfE7fSa5HhU0MVkStZVfXIfnRXP38mErIC
 mkLimXMMapn1scljUWgSGukJsIPjxPpvN7EGd+g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Oct 2024 20:34:47 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.12])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Oct 2024 21:30:22 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix zone unusable accounting for freed reserved extent
Date: Wed,  9 Oct 2024 13:30:18 +0900
Message-ID: <4d5f6524a0c84e98383ea52dcced34544ff4ae42.1728448186.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs reserves an extent and does not use it (e.g, by an error), it
calls btrfs_free_reserved_extent() to free the reserved extent. In the
process, it calls btrfs_add_free_space() and then it accounts the region
bytes as block_group->zone_unusable.

However, it leaves the space_info->bytes_zone_unusable side not updated. As
a result, ENOSPC can happen while a space_info reservation succeeded. The
reservation is fine because the freed region is not added in
space_info->bytes_zone_unusable, leaving that space as "free". OTOH,
corresponding block group counts it as zone_unusable and its allocation
pointer is not rewound, we cannot allocate an extent from that block group.
That will also negate space_info's async/sync reclaim process, and cause an
ENOSPC error from the extent allocation process.

Fix that by returning the space to space_info->bytes_zone_unusable.
Ideally, since a bio is not submitted for this reserved region, we should
return the space to free space and rewind the allocation pointer. But, it
needs rework on extent allocation handling, so let it work in this way for
now.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5c5539eb82d3..4427c1b835e8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3819,6 +3819,8 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 	spin_lock(&cache->lock);
 	if (cache->ro)
 		space_info->bytes_readonly += num_bytes;
+	else if (btrfs_is_zoned(cache->fs_info))
+		space_info->bytes_zone_unusable += num_bytes;
 	cache->reserved -= num_bytes;
 	space_info->bytes_reserved -= num_bytes;
 	space_info->max_extent_size = 0;
-- 
2.46.2


