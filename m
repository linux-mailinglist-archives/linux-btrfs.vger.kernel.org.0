Return-Path: <linux-btrfs+bounces-4507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C318B0245
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 08:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F13BB21592
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Apr 2024 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDA15821E;
	Wed, 24 Apr 2024 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V6LWYDRS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2440157A46
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Apr 2024 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940728; cv=none; b=jDGO2qI97t9+yMghZ7Jwmjf4D4PTITxhf2EvR+EWekHGPNlDME5pmKb0t7pBgYkX0yAP+bM0YaBjMIa85aVi7JUNi7KiK2oYJAAWGae2mSwN+G8ov7LZ6XarY++btOStK+ARiBbQf4vTwtesPQqeQH2EO6uooyljX4GE9nfIss4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940728; c=relaxed/simple;
	bh=ez5jnWuYGR2IkLBcxt9vunjlow3y64RVVBCGLJthXOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hro357qIlZK/5CzFu5Ztk6sokpgw5qthDsZjx7yqmrgEXNdOcXiCEKL35pjjpedPKnoW8zkKEecY+9qrlv7xP0CCtT27GVYbPHxZmZztvAA9YqQvzabLd6QVs5z0eRiPeRC8R6EotEEFd3VhVFMHF6hK4Y8fVunIWmvZfGnwF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V6LWYDRS; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713940726; x=1745476726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ez5jnWuYGR2IkLBcxt9vunjlow3y64RVVBCGLJthXOM=;
  b=V6LWYDRSbLsRn9IhElKwPDF/AGh3NVPuT/g/qYN39NhiHLhnIl1Mdm2A
   abKOTetvFgSo6cPsKKZ8oMxaLqHXKbZIEBajMHnobnP11j4LsHG2l4yVG
   SHGJf27/OSpeN0oxX0PtUCCGWjUuKpgui/JcSVnn636T+M8hKb/ZsIDpR
   gul0o96+UUvudOYY6MDd7zmkAA/2+swkAC/9ZgiX4/HY0XvxEs88tw/2R
   dYmsgf0g6k2kthogGpklzvonEjVo7Me9K+vwHj9oidkLMh8/7WZDRYg0z
   Ew3TW0LdXkaCKit3O+4gXF0Vsw7reO3BfySLWLpi0sq+OAcL/lMkJy8b7
   g==;
X-CSE-ConnectionGUID: H9MhcRxUTXua8x0Ve+h1og==
X-CSE-MsgGUID: serTu/cNQeu9WNRUhykAHw==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14981063"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 14:38:39 +0800
IronPort-SDR: 9ad+QSi0kFGA7CfU6uitQcshkm0lgYRg9zIZGLLpP7FEqTFDmOpuJvp5PuJ/9E5DOjxIX+7Nud
 ygXir8QbLgyoiL7K4+LhrS7eIxorZs7DPC5jhQvrzeLGgBKl0loYFvmFDFqRnXHVtEGdInVyiQ
 1TiZmgEeE570sJaDDrLiPHYaHw5yvOjLCr6Mr0ICN60KuxS4pZGi+9c3e/cx/sIUYwcYigIF6j
 k7Vkx6z0Wc1uHWO3Tcw+7sUBaW13Jfb2RRM3zx3NkgTHoQECZTSN754YhNAriWFUFeBDw+IYUW
 ggE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 22:46:49 -0700
IronPort-SDR: zGIpqfuvQBH/I2O2YkJWrkKWfwbK/0jSRVVq6nvSXPH2kJ+iu02iej8IcELXs3liGwAsypU9zN
 O2q2AzJAXVL607YerTGB3q9NxROTfd3Qe9UKulczSdwIwjcxGT7EfXMM9ZYSlqejcopHp7bF9F
 L9ld83vNJr+7pt6PbJhbNR5/uBw1vaMZWCaYQ/4xVJvtBEA9Z/PYj7nTa5Yxp3D/sJZv7S10ig
 g0QoTxoGJ6jyGFifeIn8b1R0kTYOM/ckG+f4QZ6/8ErzmNvYu+6M6GmokY++0CDL3XbckKmc5Y
 S7Y=
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Apr 2024 23:38:38 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: drop unused argument of calcu_metadata_size()
Date: Wed, 24 Apr 2024 08:38:35 +0200
Message-ID: <ff912bc5410aeb9f71a5b7ef5fd9376065dfeaf0.1713940243.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calcu_metadata_size() has a "reserve" argument, but the only caller always
set it to "1". The other usage (reserve = 0) is dropped by a commit
0647bf564f1e ("Btrfs: improve forever loop when doing balance relocation"),
which is more than 10 years ago. Drop the argument and simplify the code.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index bd573a0ec270..22086e840801 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2281,8 +2281,7 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 }
 
 static noinline_for_stack
-u64 calcu_metadata_size(struct reloc_control *rc,
-			struct btrfs_backref_node *node, int reserve)
+u64 calcu_metadata_size(struct reloc_control *rc, struct btrfs_backref_node *node)
 {
 	struct btrfs_fs_info *fs_info = rc->extent_root->fs_info;
 	struct btrfs_backref_node *next = node;
@@ -2291,12 +2290,12 @@ u64 calcu_metadata_size(struct reloc_control *rc,
 	u64 num_bytes = 0;
 	int index = 0;
 
-	BUG_ON(reserve && node->processed);
+	BUG_ON(node->processed);
 
 	while (next) {
 		cond_resched();
 		while (1) {
-			if (next->processed && (reserve || next != node))
+			if (next->processed)
 				break;
 
 			num_bytes += fs_info->nodesize;
@@ -2324,7 +2323,7 @@ static int reserve_metadata_space(struct btrfs_trans_handle *trans,
 	int ret;
 	u64 tmp;
 
-	num_bytes = calcu_metadata_size(rc, node, 1) * 2;
+	num_bytes = calcu_metadata_size(rc, node) * 2;
 
 	trans->block_rsv = rc->block_rsv;
 	rc->reserved_bytes += num_bytes;
-- 
2.44.0


