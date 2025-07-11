Return-Path: <linux-btrfs+bounces-15441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E280B0147B
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C03B5543
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D71EF387;
	Fri, 11 Jul 2025 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c4TYRAJ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A91E98EF
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218646; cv=none; b=hDO6L5cmYWHwfMyQ7HcC24jBj6i/+r2GozT4TgSXjRZBvhpK5eniwLYA+4GsdU0vxxuU08mSzXDQQisLTymzdL172+v//k5WcMMl+cToOQkmV5tW+A9C+T1mBs5/bI9vmlee7G6XVbjUfqPsLzQyQXNbuQc+amM7yFlF5b4tAfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218646; c=relaxed/simple;
	bh=MzfJCg+tQ9HTRkDdyq8HLbtXqGpzEfm3uS7bpinhWeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVmWRAAkak8VmRw4EH3X0i7LeaJlVQlJO+57z8P5J2+WAOMmdBPiJeWjl4r4n/ai9FbBC+rEryiH6M0zGvgmStIwfrzOBKquD8e+wVSEOLAosREwUq6tJPZd8cThSZY4XhgGtpaAUR7HpNRzdIn7SMx3j54XqR2V+fsRPrWtdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c4TYRAJ+; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752218645; x=1783754645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzfJCg+tQ9HTRkDdyq8HLbtXqGpzEfm3uS7bpinhWeA=;
  b=c4TYRAJ+xa+AFerVrEF7Ua8tJJiGdprv4rTa+TIfq2YEGIAEHtyfg0Wr
   5iKZ5sEzCekgJnML54LlMlr2S7rIe098i3kwPiezj55/Z4m+JDY5ne5Os
   5zB2+Wc9pSs3iws6np2tu+GbWwVU+k0cEDop/o42cSOVqIoYjNud4QoxQ
   bh8s5tTuuAyBCtKbw0jWETP4tQBlcEyjjjz27VbqJJM3OVrBMf5N4Cx1o
   BznDW4a5+RiINaNWiLX2bS85VDH0yzELMa7LLMOb8N5RTq+XZxARln0eS
   UFAa/3PKhV79a+vPVXlMg20tGDC1nkQS4QPqYqaykSUES7alLGyLr+0Fi
   A==;
X-CSE-ConnectionGUID: bT1VJpPlS7Krhqgq41p1zA==
X-CSE-MsgGUID: neFe1T2ATq+DdcqcRXxITg==
X-IronPort-AV: E=Sophos;i="6.16,303,1744041600"; 
   d="scan'208";a="87607285"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:24:04 +0800
IronPort-SDR: 6870ad7a_vskAwsxN4BlHIhxZ0zb81tYIPn2VWGP772biJ2odgBtqJg1
 NbTBsduwH5OKQL7rslKBVP/cIVvEKWR5Oil6wKw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:21:47 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:24:03 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/3] btrfs: zoned: fix write time activation failure for metadata block group
Date: Fri, 11 Jul 2025 16:23:39 +0900
Message-ID: <aefabcddbc2038246813704a1c8bb29a60eb1e9c.1752218199.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752218199.git.naohiro.aota@wdc.com>
References: <cover.1752218199.git.naohiro.aota@wdc.com>
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
index db11b5b5f0e6..14d959cf5a4c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2168,10 +2168,15 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
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
2.50.0


