Return-Path: <linux-btrfs+bounces-8533-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D174B98FCDC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 06:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F21251C224EF
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 04:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A524DA00;
	Fri,  4 Oct 2024 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kYFU9iRX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6A328DB
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 04:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728017689; cv=none; b=IX4HwoHrycoSjK9UurNywKcinYwZxGmeyd5BIQX3aplZsbgQx07jTMLgfYwrmMTm5wsD6LLhwFgmkd5iBPUZylW033Gd0NqxOuEPA0b/e6nXwYeA+QL9XllM90C6L0z/B6HuSO70JTW0xqJYT3iCuAL2s9LcnMHxQvt2bMTR0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728017689; c=relaxed/simple;
	bh=oppL/8jjCzNAO/fI2t9AzkBppI5oYBBcZlEIOfzSaqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LMwjtt5CHy3N2Dqh4Ub7yQI6X9P7q9jKO87lAaqicg6dHWp1RIHc80XDJTTqTOtP2Cuaw344CjtsLc+ywk02Dog2M1fXpbs4oUXJDyC/lqQF9Ysmh3MyYMTcXmAvO4V0RbXfcTXtYtGCJofgQL+r7q+H5OAYhnFifMyq7mGJx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kYFU9iRX; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728017687; x=1759553687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oppL/8jjCzNAO/fI2t9AzkBppI5oYBBcZlEIOfzSaqg=;
  b=kYFU9iRX6WANI9bwvVBIS8gsP2p7XI5sf1FCl3Y68PvIN1pmBysJVRzA
   0Jl93LkOH6uH5PoyBlvGl2RMn3aAiKLfTMpQJ2XsFRD3N/TuweKk1bJwH
   otIQsDfVtcxGygHnUHT+S52zriCKYaFnoNgXypN/i2Akfzpjwk7/udQU7
   bDII5IIuPvUNY7OunQRrKpivXKvW/Ufb84Ehj/1xptMjeb13AEpP0naOt
   TfVhDMk0b2ojV6XK6veUiiLtP9Nmd7XUuHPChqnQVvH1jnQhblMWP9ndY
   JWoixGlwto4ZfA3ciK6FV6uHNNnMMflCyRqKZWq6eLCii0Upxg8GQRm9N
   Q==;
X-CSE-ConnectionGUID: QVmtWewzQXWTdcCNGtaOCQ==
X-CSE-MsgGUID: NXECxROtSt+mYMd1/eBXBg==
X-IronPort-AV: E=Sophos;i="6.11,176,1725292800"; 
   d="scan'208";a="29122234"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2024 12:53:37 +0800
IronPort-SDR: 66ff6690_FUrrUwoyag8pvw9TF04g+//P3KieONkWUFxPmN/ml3XhWyk
 8ZG5mts1ilbCULDAA0XJ8noZLeFUXGoCLFJ6yPg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2024 20:52:48 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.8])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Oct 2024 21:53:38 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: fix clear_dirty and writeback ordering
Date: Fri,  4 Oct 2024 13:53:35 +0900
Message-ID: <e329dec3e85540e13dac7aefab1d554134214ebe.1728017511.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is a replay of commit 6252690f7e1b ("btrfs: fix invalid mapping
of extent xarray state"). We need to call btrfs_folio_clear_dirty() before
btrfs_set_range_writeback(), so that xarray DIRTY tag is cleared. With a
refactoring commit 8189197425e7 ("btrfs: refactor __extent_writepage_io()
to do sector-by-sector submission"), it screwed up and the order is
reversed and causing the same hang. Fix the ordering now in
submit_one_sector().

Fixes: 8189197425e7 ("btrfs: refactor __extent_writepage_io() to do sector-by-sector submission")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cb0a39370d30..9fbc83c76b94 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1352,6 +1352,13 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	free_extent_map(em);
 	em = NULL;
 
+	/*
+	 * Although the PageDirty bit is cleared before entering this
+	 * function, subpage dirty bit is not cleared.
+	 * So clear subpage dirty bit here so next time we won't submit
+	 * a folio for a range already written to disk.
+	 */
+	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
 	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
 	/*
 	 * Above call should set the whole folio with writeback flag, even
@@ -1361,13 +1368,6 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	 */
 	ASSERT(folio_test_writeback(folio));
 
-	/*
-	 * Although the PageDirty bit is cleared before entering this
-	 * function, subpage dirty bit is not cleared.
-	 * So clear subpage dirty bit here so next time we won't submit
-	 * folio for range already written to disk.
-	 */
-	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
 	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
 			    sectorsize, filepos - folio_pos(folio));
 	return 0;
-- 
2.46.2


