Return-Path: <linux-btrfs+bounces-15436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D456B0141C
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 09:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165DF1CA05FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 07:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFF11E51E1;
	Fri, 11 Jul 2025 07:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rLJcFKU0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9B1E32D3
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217910; cv=none; b=VazU6KwH9oJw+wjSjClN2WIUhc5AXBClRy5QYKNR1/+e8+2bI48IFhXaml4F7/PEPCnghpzfau+Vx4uPtuhu5FqqxVr8SrxFYhn6HXtVB1Tqi5dXblWSgjCGFbb7tDgZ788AmgQH0KriWUoczpoujoBRnxMqZvn1VOlgCXgtI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217910; c=relaxed/simple;
	bh=xqLKIwlNNQiYR8eh6kf2euZAkfl2iyOOcXRy90b6Ols=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INPGaeWNwy5ki6qm9vulz29IVaFbkOOp2klpxAM7AP3FITOuzy3NYcTdBuXJynTxl3RXZJRi6furfGOOe2qLCBpPxmgHfyvSgyazZBlNS73zjMR8RBVqRA9np+RDTxwuf9gYPanFVWSw2OR+fuq+Z3LjJr6sVNGowYh9vBttllg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rLJcFKU0; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752217909; x=1783753909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xqLKIwlNNQiYR8eh6kf2euZAkfl2iyOOcXRy90b6Ols=;
  b=rLJcFKU0uKUCyWJMOFO1ZD4Do0t/7yXrH1H2OlzvdAShFwmq5zQN3qAp
   sBsvrTJd67C1ZeIGFRWjCmCF+ersCsyz5hFgy5wfWquXwo00dpXpYYAXQ
   aTpwZ+4BTTMS5ylLOI3KIjC5Kx9IZJ5wgZoBsb97pTA9+7qpWhlHJpuY0
   moVLFjAvxdftP6D++C9uTkUVKEFSxY1J7RRSopaa35WA+RbxORXp7l76s
   URN5XYLu68INK0TAKRCaTi//z6iqlSu6Wo4i8jKOBzucjK8z1spuY/g19
   d8TzW4KTnidwvsdR9zFlfwA6QQ9UTdgo1N5mTZOaqBcJxLNtNKyPD46RZ
   Q==;
X-CSE-ConnectionGUID: iOzKlKNBQxyaoKzx70a6qg==
X-CSE-MsgGUID: ZI9RyoHwQBuc5ZYNvPAsiw==
X-IronPort-AV: E=Sophos;i="6.16,302,1744041600"; 
   d="scan'208";a="87606670"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jul 2025 15:11:42 +0800
IronPort-SDR: 6870aa94_t6hyagcGfeiG0Y3QQ1oDj57Jb5hHD1RPJjCrO1e/k7OTq6T
 BwT6TBxozBUuoMyUJgbED3bu853GIWYZ4PVBwFw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 23:09:24 -0700
WDCIronportException: Internal
Received: from 5cg2012qjk.ad.shared (HELO naota-xeon) ([10.224.163.136])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2025 00:11:41 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/2] btrfs: zoned: fix removing of unwritten non-data block group
Date: Fri, 11 Jul 2025 16:11:18 +0900
Message-ID: <cover.1752217584.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some reports of "unable to find chunk map for logical 2147483648
length 16384" error message appears in the dmesg. This means some IOs are
occurring after a block group is removed.

The IOs are coming from unused dirty tree nodes. When a metadata tree
node is cleaned on the zoned setup, we keep that node still dirty and
write it out not to create a write hole. When user operation e.g,
fsync() is fast enough, we can have a block group full of "unused dirty"
tree nodes. Such block group has its used count == 0, making it "unused"
block group and candidate for removal.

Removing the block group keeps the dirty nodes unsent until next sync or
umount operation. At that time, such nodes will cause the "unable to
find chunk map" failures.

This sympton can happen relatively easy on SMR, whose zone size ==
256MB, but it is hidden coincidently hitting a check in
do_zone_finish(). Hitting the check remove the block group from the
unused list and let it never reclaimed, which itself is a problem.

Fix them adding an extra check in the BG removal process and put a block
group in the retry list when btrfs_zone_finish() returns -EAGAIN.

Changes:
- v2
 - Refine has_unwritten_metadata() structure.
 - Add message when hitting the WARN_ON.

Naohiro Aota (2):
  btrfs: zoned: do not remove unwritten non-data block group
  btrfs: zoned: requeue to unused block group list if zone finish failed

 fs/btrfs/block-group.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

-- 
2.50.0


