Return-Path: <linux-btrfs+bounces-19826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D75CC73A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 12:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A44303CCF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 11:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0123B75F3;
	Wed, 17 Dec 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ld5hlKTv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BA92773D8
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967704; cv=none; b=VtdQJiSyWp3BZ6jnVWWf9kzzfM2Cyx8UszaZxC5H95LIJo1f5HpKRhXR+l3I3+4YkcuIk9KfKLLX0z4PqV/q1DmakFXMWNBvvEWDHnKD1ny2ksiLIQbegCmasOHkgWRudQAfwMFCM2FnAiL1jM1rfDI6h58izRKVE+X280VUtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967704; c=relaxed/simple;
	bh=UsQpHlROSf/Xv9kuwHeP06xSm/Tg0pHm7KOS+y2H6VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u02174XKe27gls+yjsTv938q29JrPFp49h1IMpvqiUrIoK9oDDt8ypqBX9y54wpUYZxY1IL0ciVL4kvEQyXjKVdpiN0MknuU/yecRWNOMSzzVUIbFE2S9ewriBVCwfQxRA6zRg+0jAg4fygGM38q38iWtt0fQL0bx0L7VOajd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ld5hlKTv; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765967703; x=1797503703;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UsQpHlROSf/Xv9kuwHeP06xSm/Tg0pHm7KOS+y2H6VE=;
  b=Ld5hlKTvUgaqqbvyTX+Wcp3zqWDtFUb7qloTZ2rO8Xbt9M1wnxt8ByMF
   iVIGr5gs/IGFmap27mTgmYcslKyyxw7EIb8kD0T+ZR7aidJIXdbCFQsWc
   U1xSZ0PJHdFno+V48wnXcrwNnmPUf4jxqUQrRG+MyyhEMg2a2YZCSIv3h
   1Da++Oe5No/TkEORSlDDr2CSsgw6dnRO6Je7pA54vjcEFMYVYnXmqS4TT
   sjNYDCagWDVYnnUgSgBE5LP9/SgGgl9pWC5lx0sSyw75I/OTnaeEweTy0
   p6MdFa6gqRzdKV/8z4/nwm0lR3Q7DVURr8dfqtQ8HeX66IROXrQ+uLsfh
   w==;
X-CSE-ConnectionGUID: Teo7+L8TRBe/zVSDRZnbEw==
X-CSE-MsgGUID: ymcr3o+nSNu8kFOdWsCukg==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="138050844"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 18:35:02 +0800
IronPort-SDR: 69428756_eQIHmycCELnMmfTmc+VVBKzT3i3zDOc4xHECKCxdnGoJk9D
 3EaDyNPbCk0NLAq/tu0fXjAeswAIkKYYjRgo83w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 02:35:02 -0800
WDCIronportException: Internal
Received: from h4pm2h9w6j.ad.shared (HELO naota-xeon.wdc.com) ([10.224.105.5])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Dec 2025 02:35:02 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fixup last alloc pointer after extent removal for RAID1
Date: Wed, 17 Dec 2025 19:34:51 +0900
Message-ID: <20251217103451.646206-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a block group is composed of a sequential write zone and a conventional
zone, we recover the (pseudo) write pointer of the conventional zone using the
end of the last allocated position.

However, if the last extent in a block group is removed, the last extent
position will be smaller than the other real write pointer position. Then, that
will cause an error due to mismatch of the write pointers.

We can fixup this case by moving the alloc_offset to the corresponding write
pointer position.

Fixes: 568220fa9657 ("btrfs: zoned: support RAID0/1/10 on top of raid stripe tree")
CC: stable@vger.kernel.org # 6.12+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 359a98e6de85..17dde95eb3e7 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1490,6 +1490,23 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 	/* In case a device is missing we have a cap of 0, so don't use it. */
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
+	if (last_alloc) {
+		/*
+		 * When the last extent is removed, last_alloc can be smaller
+		 * than the other write pointer. In that case, last_alloc should
+		 * be moved to the corresponding write pointer position.
+		 */
+		for (i = 0; i < map->num_stripes; i++) {
+			if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+			    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+				continue;
+			if (last_alloc <= zone_info[i].alloc_offset) {
+				last_alloc = zone_info[i].alloc_offset;
+				break;
+			}
+		}
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
-- 
2.52.0


