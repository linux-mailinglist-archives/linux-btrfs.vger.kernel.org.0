Return-Path: <linux-btrfs+bounces-20752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F6D3C2C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2686A6066C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CA93D7D84;
	Tue, 20 Jan 2026 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RpXBTUqY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357D3D669F
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897200; cv=none; b=ies0vPP+YlpOVHNsF1Z4UaKWj7rgNhk0oTBijV7d3iLw6+E2uEreNqAJGJVNS7RrVNF+2tbV7si780PQwvjhLHBiYrXVAOLum9mFaQ26r32uFDanTgS3alqzzZAekWaVBqQR4KONKAn+DczxYfghGhhpkEaXSng7JqE9NwZpt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897200; c=relaxed/simple;
	bh=XklmxPoUnZ9qstU8faF/rgo4gJotmAau+QidqGnyWvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsixxEBz5/K/uT/V8MbXjS15UpreCX00jP0oADtr6dxgAcO7wcU9EvadlXGWIwmjjsP97nMh1Ey0L4hoB7VgM8OV94BY/tbI9oAwpFiEcnm11Effdm3E6vzrK0ub+sLnt3kMvE7jvOvQG9zRKQgoTEJyoAR6QrYC4zEYxS4EU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RpXBTUqY; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768897198; x=1800433198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XklmxPoUnZ9qstU8faF/rgo4gJotmAau+QidqGnyWvg=;
  b=RpXBTUqYsrstqCux3Sl+1AqTpSwgalw39Oay9SCuxbsJBtvl0KCyBzCd
   Nill6MABKwJCbDBLYNRZ1tiFmy2cVQs50NZ4HNeJ8hcxCtX93vuPIEIMN
   LtdLfANJUbzt4YU0xDOclbeskQ6LpzqVvngC0A34mYvm5Ikfs2sxxG11U
   3o0ntlP5pMXiI/76QlUZeVlnP77T6p8UW0vcE46CKlLh55Dp1LpZWABkC
   YZoI/s4C1Pp/SsmC3UjucZSNXLoYDhEhiR0fdnC2sIUFe1ntniAqarO3G
   pmknC+deZ7DsoYEehq8lmAdvYVhYVGy8F5U6ZuIJIJQCi1LIobhcc3rRe
   w==;
X-CSE-ConnectionGUID: jnHDwx1fS4+gu93uv2KAmw==
X-CSE-MsgGUID: VUHQBau0SjCHWyMOnJFAkw==
X-IronPort-AV: E=Sophos;i="6.21,240,1763395200"; 
   d="scan'208";a="138866207"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2026 16:19:51 +0800
IronPort-SDR: 696f3aa8_wfnGJisAJ/GoMlxBLobr/FpLxrzbDv1Mrmtpo1ZDxzchKor
 RmA1SQbMw43wJg1yiVyOFCCZsq4F9r0V7FKrJTg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2026 00:19:53 -0800
WDCIronportException: Internal
Received: from wdap-ospyco2xgl.ad.shared (HELO neo.fritz.box) ([10.224.28.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Jan 2026 00:19:51 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: don't pass io_ctl to __btrfs_write_out_cache
Date: Tue, 20 Jan 2026 09:19:46 +0100
Message-ID: <20260120081946.139598-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to pass both the block_group and block_group::io_ctl to
__btrfs_write_out_cache().

Remove passing io_ctl to __btrfs_write_out_cache() and dereference it
inside __btrfs_write_out_cache().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 20aa9ebe8a6c..adb972c6c728 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1371,9 +1371,9 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
 static int __btrfs_write_out_cache(struct inode *inode,
 				   struct btrfs_free_space_ctl *ctl,
 				   struct btrfs_block_group *block_group,
-				   struct btrfs_io_ctl *io_ctl,
 				   struct btrfs_trans_handle *trans)
 {
+	struct btrfs_io_ctl *io_ctl = &block_group->io_ctl;
 	struct extent_state *cached_state = NULL;
 	LIST_HEAD(bitmap_list);
 	int entries = 0;
@@ -1533,8 +1533,7 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 	if (IS_ERR(inode))
 		return 0;
 
-	ret = __btrfs_write_out_cache(inode, ctl, block_group,
-				      &block_group->io_ctl, trans);
+	ret = __btrfs_write_out_cache(inode, ctl, block_group, trans);
 	if (ret) {
 		btrfs_debug(fs_info,
 	  "failed to write free space cache for block group %llu error %d",
-- 
2.52.0


