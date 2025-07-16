Return-Path: <linux-btrfs+bounces-15522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A176B06FCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 10:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67905175953
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A207292933;
	Wed, 16 Jul 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HwcI026X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42628FFE1
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652821; cv=none; b=eDOKOJFkPT5UJDHY1GbnLHCZz/82kF5JRBOc+w0JgnNQx2JRpEXBaE6jxnJYbIXq1vXhBLGrbaxqqfK5N+OpJcj2+FOKCRuLcEUN+mLqYE6KwoT+V6PMqQuuE4npy2cJqZB/ac4pbQ2SHUodIVY87IawPfInSk0IoBxx+9SV2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652821; c=relaxed/simple;
	bh=lVkSnyNMoe//Kyz5Oe2loIcp/d8cty6pvtw5UMsH6Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JE3xzM53BdNDqdKo7VmuozAMYsyG9VKMtgWMxAIs7AiNNFyGWBmVGTXPzpE0B14/BUvj0IIx3knyolzcZ97pcrf2cdDg1oZkxlUH1Gwr86HT68R/n3FQeLKquDaHD38cjebp52hvsG2iv1OE6/YVRPI6XsoIgMeCmLEIb0Gu4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HwcI026X; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752652819; x=1784188819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lVkSnyNMoe//Kyz5Oe2loIcp/d8cty6pvtw5UMsH6Fc=;
  b=HwcI026Xv7eZUwaKLhmvkJAgf65f11c+Kwcq13/czQgEwQuSUanJkbq/
   uQU5Xope44TWfrUhjwrkQHbJ/zXq+GeAE83yF2/gar1aJzx3hLP0ijnzb
   pdBrBGYOeSKIAb16QhJ1LB2wfEDB4GPbmb7dky3VoyJFm+PgFVLrsfy7p
   g9Edf+R0HOn22z09gEWTIht6HDV4I1nuwthc4Aix+FFkQy/UMHNkInA8m
   uzij2laAkc+SqK0FLsghc/r5hNMEC1m1u4p0oGpBWb9QBWv3Ju7SLmMD5
   np70adk3KgCIBnM0Ki02M/S8XOn5qHnRbC+FGVQHvW7w2syoGrUS3pvFo
   A==;
X-CSE-ConnectionGUID: ISDNAWDiT1aKvdh5y9z/2w==
X-CSE-MsgGUID: 0Gn/5wweRkOW4SirVxnMhQ==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="94432939"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 16:00:18 +0800
IronPort-SDR: 68774d71_HMtw1bWVd5P0TP7F/fqSdsXK6DPll6mzMkG1XX6Ovgui8RE
 xkhPhOmHl/Aatbi2z0nbSNozYxWfSDhJSLWzMcA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2025 23:57:53 -0700
WDCIronportException: Internal
Received: from wdap-0lwmw3epm9.ad.shared (HELO naota-xeon) ([10.224.173.10])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2025 01:00:18 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 3/4] btrfs: zoned: fix write time activation failure for metadata block group
Date: Wed, 16 Jul 2025 16:59:54 +0900
Message-ID: <b4cff446db8aa28f8ae713e0aa1974fed2258bf2.1752652539.git.naohiro.aota@wdc.com>
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

Since commit 13bb483d32ab ("btrfs: zoned: activate metadata block group on
write time"), we activate a metadata block group at the write time. If the
zone capacity is small enough, we can allocate the entire region before the
first write. Then, we hit the btrfs_zoned_bg_is_full() in
btrfs_zone_activate() and the activation fails.

For a data block group, we activate it at the allocation time and we should
check the fullness condition in the caller side. Add, a WARN to check the
fullness condition.

For a metadata block group, we don't need the fullness check because we
activate it at the write time. Instead, activating it once it is written
should be invalid. Catch that with a WARN too.

Fixes: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 77297928334e..edd70ac2446c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2169,10 +2169,15 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		goto out_unlock;
 	}
 
-	/* No space left */
-	if (btrfs_zoned_bg_is_full(block_group)) {
-		ret = false;
-		goto out_unlock;
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
+		/* The caller should check if the block group is full. */
+		if (WARN_ON_ONCE(btrfs_zoned_bg_is_full(block_group))) {
+			ret = false;
+			goto out_unlock;
+		}
+	} else {
+		/* Since it is already written, it should have been active. */
+		WARN_ON_ONCE(block_group->meta_write_pointer != block_group->start);
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-- 
2.50.1


