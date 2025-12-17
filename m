Return-Path: <linux-btrfs+bounces-19828-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88A8CC7447
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 12:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8822300463A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D478342C8C;
	Wed, 17 Dec 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fdUol7cu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BA338914
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970059; cv=none; b=EtakuAKX2IelDl9vmad/JOxIH7mW7XIg7/lJzOn/GftJ2YWmoBqDVkiaw23hq8juH6eXRpas0GwFWdiIubF1HNGlovWE/eIPGMS1e5YSg30eQgS3XoLkjsAqstQ4izWjd8eQH94091IWZuHl5ZbPWTZwSa9V0uNbLXQO+vh6JYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970059; c=relaxed/simple;
	bh=z+Sdu4ao0/SWq+O2s8Wn/O9Xg7SZYiCKkt6MJLKU8vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFEksmUfFhggjN65dd2tFf0smu5T2VILrAiMNUS8SYHE7hWA/4uE1SaKzgezkPrC4vLZJskzV+iKCKydd/WefDSUdnVgrsv+mRRMZZt7gb1PpTQMpAmOtWUZHb70+BeyFXp2U2dHkji/d7T68f6xEj4T/+Na+GWoTCLkcgV21w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fdUol7cu; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765970056; x=1797506056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z+Sdu4ao0/SWq+O2s8Wn/O9Xg7SZYiCKkt6MJLKU8vQ=;
  b=fdUol7cukLLaGN5blZhum0yAQbcNOrnHcJlZHOcOpwk7/oH+isCzt8hn
   XtpewBrvEhHvzEFLsQcGD0QIa5Y1CKi//YvVWlzaHONx+O1QuXuhJQ5IO
   tzS3ow0Z1Ozuzd0gmixR9q6Ey0CMJph0DB3g+0wJkuPb3IkBJFOBRqMrp
   /XRd9dvlt+Ud0mYKKqtUTCAOLiVDBrXRgKXkjjTARZesfhVqkA2gdwmvu
   AdQZm+4ptOcOexomfoCYJGqsl4AAa7+CK176q2kSmZIj43DMYz/Opfu9D
   ylvsICykL9C3sKMdVyaXq4TRgWesBh1pOgOhxAQDuMrkrnx2NpFzfqmO3
   A==;
X-CSE-ConnectionGUID: t5EWB6RwRrm7YdZ8Ae+upg==
X-CSE-MsgGUID: Mi6g8/HDSRiLlSOLPsxNVA==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="138052321"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 19:14:15 +0800
IronPort-SDR: 69429088_MSNib8vqULTFvHE47V7ykBTWppXShS1DJd4WtiUcJo9I6oc
 vyh6EKu+0zDEarCy/MkoK7XJ2zsvouY/Wa4lqSw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 03:14:17 -0800
WDCIronportException: Internal
Received: from h4pm2h9w6j.ad.shared (HELO naota-xeon.wdc.com) ([10.224.105.5])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Dec 2025 03:14:16 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2] btrfs: zoned: fixup last alloc pointer after extent removal for RAID1
Date: Wed, 17 Dec 2025 20:14:04 +0900
Message-ID: <20251217111404.670866-1-naohiro.aota@wdc.com>
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
 fs/btrfs/zoned.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 359a98e6de85..f27ba6e9b47d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1490,6 +1490,21 @@ static int btrfs_load_block_group_raid1(struct btrfs_block_group *bg,
 	/* In case a device is missing we have a cap of 0, so don't use it. */
 	bg->zone_capacity = min_not_zero(zone_info[0].capacity, zone_info[1].capacity);
 
+	/*
+	 * When the last extent is removed, last_alloc can be smaller than the other write
+	 * pointer. In that case, last_alloc should be moved to the corresponding write
+	 * pointer position.
+	 */
+	for (i = 0; i < map->num_stripes; i++) {
+		if (zone_info[i].alloc_offset == WP_MISSING_DEV ||
+		    zone_info[i].alloc_offset == WP_CONVENTIONAL)
+			continue;
+		if (last_alloc <= zone_info[i].alloc_offset) {
+			last_alloc = zone_info[i].alloc_offset;
+			break;
+		}
+	}
+
 	for (i = 0; i < map->num_stripes; i++) {
 		if (zone_info[i].alloc_offset == WP_MISSING_DEV)
 			continue;
-- 
2.52.0


