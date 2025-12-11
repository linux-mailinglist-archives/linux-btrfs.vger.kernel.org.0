Return-Path: <linux-btrfs+bounces-19651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C415CCB51AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 09:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7814E300161B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 08:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FC2D73A1;
	Thu, 11 Dec 2025 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fBcDJweW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA1283FFB
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441786; cv=none; b=Htj5A2aDc4LiFYF+7ca9s9LhJqgZS/VrlcyK9pFTJbVSSdhHJZZLBdvZuOBw8KZAp5fULj09XL87IS/VkWGh8XtsQwm4fLS/coYTZDE6nEQb79/PguNfAWF9kIKwJkhOqcckIyZhgj+uDXfuyIH7798MTIV+klSsu7NkvxIpWgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441786; c=relaxed/simple;
	bh=AwEZT31prwSXxRAAkeP4rinPF/6Su8sdfo8aCVpr9Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezpQP4mZpAjfeuvGhFVVNxo1f6m31+WBRh8RVpACSpCf0SQz9Jt+HGrwPK05NUvDHGwxnJTc83qdl+DaFOaleYwm7gLcgGPoRuVrMm2QmOfx8yj61CVzbyiJRxE2doM2kGe7fzR7Xbsbe53KHSeNwdATBG2NEjGtxVWCEVd+7yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fBcDJweW; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765441783; x=1796977783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AwEZT31prwSXxRAAkeP4rinPF/6Su8sdfo8aCVpr9Xk=;
  b=fBcDJweWJiSdYi7x7LNNEsRZr/u209bsKIqphMlbsC+xGpLMldIAJKU/
   iZvk9TLZ0Itm7tDD8YqxN+V8eo1CJgiAT78r9tRdQ8muziadOOeuf5tfm
   SkSno3hPayuc2i7JvxE40caH+g/WEzMA9XaBhHdXWok/YgGNYwk8WqbQm
   8zF9YR2yqKmMKde3n26DCDIHuf5dsLYevYJvp9oqOU8wjZb76dx5gQ1nj
   cPkdX9sMvOC4ENG8hmAlzEOWmFRlY2oTyO2VaeZQVmjuqFKNWvwmwJCKM
   vRVMQfItY+n3yNMbNrubJcm5zCYP9NRzZUnKYM9wfyL6ToEufHuMeVaH3
   g==;
X-CSE-ConnectionGUID: EWSjDUkEQq6VRjAhNQGctw==
X-CSE-MsgGUID: ryvtjiULRi6dPrUbd1V2wQ==
X-IronPort-AV: E=Sophos;i="6.20,265,1758556800"; 
   d="scan'208";a="136312465"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2025 16:29:43 +0800
IronPort-SDR: 693a80f8_8sTfiY05uy7WGSLZQ0LRizfU0y62irVBnok6c71S89lXJSQ
 pjEwDw7vVjFjHcfWZCC/JifNuTOEgmfZYR3jUDg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2025 00:29:44 -0800
WDCIronportException: Internal
Received: from 5cg0214bv2.ad.shared (HELO neo.wdc.com) ([10.224.28.116])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Dec 2025 00:29:41 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] btrfs: print block-group type for zoned statistics
Date: Thu, 11 Dec 2025 09:29:26 +0100
Message-ID: <20251211082926.36989-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211082926.36989-1-johannes.thumshirn@wdc.com>
References: <20251211082926.36989-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing the zoned statistics, also include the block-group type in
the block-group listing output.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7f00e4babbc1..e2c6c1e6ff2c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1229,9 +1229,10 @@ static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
 	ret += sysfs_emit_at(buf, ret, "active zones:\n");
 	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
 		ret += sysfs_emit_at(buf, ret,
-				     "\tstart: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+				     "\tstart: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
 				     bg->start, bg->alloc_offset, bg->used,
-				     bg->reserved, bg->zone_unusable);
+				     bg->reserved, bg->zone_unusable,
+				     btrfs_bg_type_to_str(bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK));
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 	return ret;
-- 
2.52.0


