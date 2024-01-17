Return-Path: <linux-btrfs+bounces-1513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C5C8303A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 11:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F801C246AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC801DA4C;
	Wed, 17 Jan 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lzJQidbM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B4154A6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487454; cv=none; b=RZQv64MU2GETxDJQbOAVat3QZF86s/c0tcNWoEiLPBcnhAJRYl9JjDOGhs+0kgS6alXgF7CnMAdyFkyEvranYoaez9Rv/xlX9Qz4Gu6gv/g6lhyCey41Kr5CasDSPge1iV3IwBik5gS0t5f4mw6G/JNmkydsQwol1ahzgsj5rWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487454; c=relaxed/simple;
	bh=qQCDLpvaOZNVn0XwF7XUDCWit2gGz/fWau6voCqw53M=;
	h=DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 Received:IronPort-SDR:Received:IronPort-SDR:WDCIronportException:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=SZuEp2YNqu+mcOaWQrPr17zvt32xP+pSGg7L1Xg//LgYgzswkWj/WdQ/Fy6+KoH2H1JJlk/DHU6aIuStU4E7/j1q0jX+N+Fo/Uh5eggJeq9o6wpmqLK1XHH3qKQ93t+ZnmNfoRErGyTb7vN8nOh3Gw/4do3IpiiCWYAQxp35keA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lzJQidbM; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705487452; x=1737023452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qQCDLpvaOZNVn0XwF7XUDCWit2gGz/fWau6voCqw53M=;
  b=lzJQidbMUZvWFsXUv75fjQifbWxZnbpGGi4OX2Vbgfn6LuT/mNusO6Ua
   A+g3iHtZB5JAClrLf8Z0v7ZJrgyUSk96EMYQxgYLNB5CGzJB9nAI318fc
   16X4cx6oYorZj4JtyqMYdcr8IP3vDaLvhp9KFnyPr3Ym63TqtDPsE6PX8
   wDCkdPHNzLxhEULClBfycUlxX135j0Qunrv/D/9WVDek5FwrCnE0V/ehQ
   REf/VaTJ9lETUCw05QCTRBdpkbh8UvelXJh2jB6oZXfF3C0ku2YWMCVW0
   BqUXRyaGBuIakDCEunyTFpVBHx/Kj2JE6upPjUzji4gSW1s2vv8GsFC8t
   Q==;
X-CSE-ConnectionGUID: 1+kjtFVaRsW5HqjwsWnQZw==
X-CSE-MsgGUID: RVrTQdPJQBmeeVCq7cqVyg==
X-IronPort-AV: E=Sophos;i="6.05,200,1701100800"; 
   d="scan'208";a="7557026"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2024 18:30:46 +0800
IronPort-SDR: Q8uw/Vrz0+hMoQEVApKTqx9/GGYgwQvPYLGg2c7fAeTBD+rl3Ci8Pr1G6WSseJ5TJjWVQJ9EF6
 lblVkfhXqe6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2024 01:40:55 -0800
IronPort-SDR: vGLQXqTiKAGef0tPHeuYuMSi9HAqL/Q3pctSSAXqqbfUaFBDacFzpl8vFTgBK2TTQHbXTRIfWc
 ysmJ14PDGHlw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2024 02:30:46 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: remove duplicate recording of physical address
Date: Wed, 17 Jan 2024 02:30:13 -0800
Message-ID: <022e1767f333e36d22e0c6f859334ae9433e42a4.1705487315.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the duplicate physical recording of the original write physical
address in case of a single device write.

This duplicated code is most likely present due to a rebase error.

Fixes: 02c372e1f016e ("btrfs: add support for inserting raid stripe extents")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 928f512cdb4a..2d20215548db 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -509,8 +509,6 @@ static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
-		if (bio_op(bio) != REQ_OP_READ)
-			btrfs_bio(bio)->orig_physical = smap->physical;
 		bio->bi_iter.bi_sector = smap->physical >> SECTOR_SHIFT;
 		if (bio_op(bio) != REQ_OP_READ)
 			btrfs_bio(bio)->orig_physical = smap->physical;
-- 
2.43.0


