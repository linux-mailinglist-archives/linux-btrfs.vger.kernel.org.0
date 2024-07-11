Return-Path: <linux-btrfs+bounces-6387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1127C92EB41
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC931C2140B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 15:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83559168C26;
	Thu, 11 Jul 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SGsaW04r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85F1E531
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710337; cv=none; b=T0Eo2aqVxM8TtK5hEDqa1wtk9NoigONvFrFgTy7MXoyN6zPD7ipkvBYREaU0ebEamcWSTHNsgBkkbntvpdTRWMWBRNkSnRoyP1/1cJ58SgASDvaUwUuZ5OrlRWGBnHEF3UVdi1X78pTzD14R0SFIOlj4txuubdQ4WG0jx3Tg0qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710337; c=relaxed/simple;
	bh=EUpyrdghpUbD6gZQRdxIOPwEPHhBB94BXDkmmtFu0Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tf8wv5QA83S276Vej2u3I6xn5L3IjIEV1JRE9q5sWJG1WuAuEKhRSxTzNcTC0ILXfs5jvV46Jd1JCe0x8VkO0WJ+vM/uwPU9Pw/Wq2adCCQFNHj8v5TobMZGdqRAvYyPTCcHEch/3MT9NkASRnv5Pp4UWddsQQdH0Vp8cnIYnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SGsaW04r; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720710337; x=1752246337;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUpyrdghpUbD6gZQRdxIOPwEPHhBB94BXDkmmtFu0Hc=;
  b=SGsaW04rxzIzX6IFVnH6GRWkdPkBGQUeU4YjzMSSf37h0XKPL7dXhYXx
   IqkuRHxVblFNEWzKy836iZEGetZ2sLYssl1AxEVPfY5OV6QbdNvvaQAun
   Gr/DveaNP36voVlEO0XxdmHsSdIJgRk/KNdjnDLI89ui0Na5eF2GeARvP
   zogJfWtv5Otzway7i5rFuxhlnP/xxYL/he64bcIZ5pDCDQysSH8DTKGye
   BxIeredkke++fyV0odtEBTEdNSjZHa6eYTOJnJtb0p/HonJJdi85irtvW
   bn9+LRL4KneCAlvLA1PA4QpAWM/R+Wv2ScUM2UATYGYhRz/czS7MWQbfJ
   A==;
X-CSE-ConnectionGUID: u/ubPP/CSLWwnXA/YPVBgA==
X-CSE-MsgGUID: OkkRorRYRf6JYJ77f7qz8A==
X-IronPort-AV: E=Sophos;i="6.09,200,1716220800"; 
   d="scan'208";a="21129831"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2024 23:05:36 +0800
IronPort-SDR: 668fe6e5_7HkMqGI4GsAEYIYIEVsvpsoD1dOAlzTMd2JbEM1/wn5ml1d
 F3RGBtwathNC8viksjsjV/y8MpvP8rhAdGjtZ7g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jul 2024 07:06:29 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.106])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jul 2024 08:05:35 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: do not subtract delalloc from avail bytes
Date: Fri, 12 Jul 2024 00:05:32 +0900
Message-ID: <5075b1ac071c767c182ddc87b228df6147ef7bc4.1720710227.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The block group's avail bytes printed when dumping a space info subtract
the delalloc_bytes. However, as shown in btrfs_add_reserved_bytes() and
btrfs_free_reserved_bytes(), it is added or subtracted along with
"reserved" for the delalloc case, which means the "delalloc_bytes" is a
part of the "reserved" bytes. So, excluding it to calculate the avail space
counts delalloc_bytes twice, which can lead to an invalid result.

Fixes: e50b122b832b ("btrfs: print available space for a block group when dumping a space info")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9ac94d3119e8..c1d9d3664400 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -583,8 +583,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 
 		spin_lock(&cache->lock);
 		avail = cache->length - cache->used - cache->pinned -
-			cache->reserved - cache->delalloc_bytes -
-			cache->bytes_super - cache->zone_unusable;
+			cache->reserved - cache->bytes_super - cache->zone_unusable;
 		btrfs_info(fs_info,
 "block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
 			   cache->start, cache->length, cache->used, cache->pinned,
-- 
2.45.2


