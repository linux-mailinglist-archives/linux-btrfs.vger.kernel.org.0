Return-Path: <linux-btrfs+bounces-16002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62DB218CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 01:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72482428175
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48C2153C1;
	Mon, 11 Aug 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pC2N883g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7384720298E
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754953223; cv=none; b=njVRlZ7gLWnX9EojtlD73LZ8ybNjoo2l53NPLVQ9bNpmwuMKpk7F8FKr6FBzCuOr9qTutxb4gdyq2pixbsc+d75cD1EXGRUf8UT+25cH9curOYl9R6B90WtkRUx5/qF7Y5sJHf2VZutpzVHmO3OWKy141K5laS+lRG+5mX7bqIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754953223; c=relaxed/simple;
	bh=Y9v1AbTTekv5+HQsqZ6YdgoCJbzQBatEjjahgU5Bb1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZvX/gFqv7FHLoATuFqgOz8E+KGvnnfAh/plnI/aqFjinF211JipTtYBTIvbZ3aoW0/4YC6AKzLfAd3bpEuNWX6EMh8n2r4yi5CaVLudQCi/5yb30GmszextqMLvgqF1OvZYLaviOotq7DxiDUDd8FjhbmR3J23eodKKVuk7Q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pC2N883g; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1754953221; x=1786489221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y9v1AbTTekv5+HQsqZ6YdgoCJbzQBatEjjahgU5Bb1U=;
  b=pC2N883g6UjFM4jpG7Olp2zo+JalIwMrY3SgOi6J0BUJe32njS067lra
   GbBAXv1wAe0SQ6uHQPjoBs61Eaw8oxzWCGmLjtukhd2hSpUaF4+X9b4v2
   nvchQ8smMQRmvWPGpZtUt+1XHTB0D6LzPByOn/ZLYWAsmK7uy+GqqL6eW
   KxD1BDiw+9aZtyF0tqasBUhy0H+cfmxlpFXp9U5myqkBjvBgRifREAu1H
   BKpGiY4IDhhYX5WqkH1PKSL1ZS77JEfvbZGCTrfxqeJudkvPNLU0/dpIk
   CLGi2JkBFtVdA7F1VwNyZrTj04FcIQiQq2eoFuR12h8DyLXUpJjdz8F9F
   A==;
X-CSE-ConnectionGUID: /CmAaJrUTMK6RW9t27kTAg==
X-CSE-MsgGUID: ICHlPEgiTvu1zEhKpnT7xA==
X-IronPort-AV: E=Sophos;i="6.17,284,1747670400"; 
   d="scan'208";a="105656700"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2025 06:59:11 +0800
IronPort-SDR: 2ROclWrvClhXU97n6uYiv1WYDcwxhTqDKdVkUcqHkWdC4NP0jP96Kccfi49jLv0pUpNOziQdYR
 tS289nUwF4d99K6QPEjicXPoC4Z31/a/ti5aUmo5H+nymofmLJW7vMUxLExvmSTAc5RxKnBzMr
 OcaQ4zv/qpzl37/j8BSKrrNvPnnoDH0S4MUJmerJsGhQsWWp/wBsjzXeXbfXEJ3ZTvk4S0MiMY
 vcblXq6vDxEM7Xs9LGqQRRWng35Annt898FYl9oeZYspfRiakGbJv6bD1uCAYRR370hY7/rTYr
 /wo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2025 14:55:06 -0700
WDCIronportException: Internal
Received: from 5cg217418l.ad.shared (HELO naota-xeon) ([10.224.173.181])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Aug 2025 15:59:06 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: dlemoal@kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix buffer index in wait_eb_writebacks()
Date: Tue, 12 Aug 2025 07:58:40 +0900
Message-ID: <20250811225840.501895-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit f2cb97ee964a ("btrfs: index buffer_tree using node size")
changed the index of buffer_tree from "start >> sectorsize_bits" to "start
>> nodesize_bits". However, the change is not applied for
wait_eb_writebacks() and caused IO failures by writing in a full zone. Use
the index properly.

Fixes: f2cb97ee964a ("btrfs: index buffer_tree using node size")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9b26a48cb48..e264310b8d6b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2260,7 +2260,7 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	const u64 end = block_group->start + block_group->length;
 	struct extent_buffer *eb;
-	unsigned long index, start = (block_group->start >> fs_info->sectorsize_bits);
+	unsigned long index, start = (block_group->start >> fs_info->nodesize_bits);
 
 	rcu_read_lock();
 	xa_for_each_start(&fs_info->buffer_tree, index, eb, start) {
-- 
2.50.1


