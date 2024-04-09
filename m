Return-Path: <linux-btrfs+bounces-4059-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476B89DC0E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1441F23CDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6191304A5;
	Tue,  9 Apr 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aO5+wYCc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D69C12FB0B
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672347; cv=none; b=BgtCKb3EOWEuY0rg27IkGTbLcM05HH212ahF68h0x9DrxI2FI29WqbcOOlmAs5NBx0pPvc58SgdRFdoCb1OFLDjoKjfGnmIAdX96EHobDJ7CS4sjq53wrlH73b1P7BiI8i1WKxVLWldZK5QYpjU2bSAiwNhTYAIBRZKdWesrK0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672347; c=relaxed/simple;
	bh=m4h/LbbC39lU4SNP0l4vbJNDrYYuGbW+NRggHY2sAFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCYym9fm8HxpzXX41D1mv6i77MWiDInFUFAY0ow36JE+uuyD8TX0JNXPq1Jka78h4D1GD3i2+vEecHA/YjiLsspGMZ7qeRoykqLSa60cQzNac/cKg2rLT7vS0Q/+LgdPrKE31QZqXBk+FmE6szDyADXWS5n17joRQrYdoZmFOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aO5+wYCc; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712672345; x=1744208345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4h/LbbC39lU4SNP0l4vbJNDrYYuGbW+NRggHY2sAFM=;
  b=aO5+wYCcsmsxqWct5Yq7PELNpOqpFrdHs6MDDxuGR0pyq2XcBdld3UOv
   I8HfhFL0+fm8oIfFJ67NjrdtQbsnAXZTzx4UWlMZh8UFE4gEP0Dg/Uzsx
   e3v+/pd25rF2DRg8VQTHCE0GQ1XzwtTdsLEzSo2NGCV+e8GLHTTDDxZnE
   fA+TDalVPLDo+0ZaBwiFNCM2pAVOAPPnK2ZuNqurLGVEaZsc4Z8Rz9UoQ
   JRsuyAqEhQOwMO7heo1KxPbhWBF4Spb6/1QV1iDigTEmJ4EToOCXioRDw
   vDq4bBWGPbVN8ZWvExtHMpRH575eiBvIUrndcLCO1/6ZJM6f4Ns9SPqIf
   g==;
X-CSE-ConnectionGUID: p0VHX6J2Sg2xAz17h/UU5g==
X-CSE-MsgGUID: 6n1PUaVhSji5HYobKxtROQ==
X-IronPort-AV: E=Sophos;i="6.07,189,1708358400"; 
   d="scan'208";a="13071040"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2024 22:18:58 +0800
IronPort-SDR: rfVkcao0hKUca/fBse1MEmQnMzYzrdOxmN82lCV2sOpHOoPhisN+PmgmFW/mNL2gm0fd8HHJ0g
 cZNO8ZV0Prrw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2024 06:27:27 -0700
IronPort-SDR: DLx0dMO+b0jWdJ29NiB4U4dRSJTQNbx8Jf+tfmMcxF/ys78oLtr8WF26AM7jq9hE4cj+gYmezv
 fVzxlUnWrs3A==
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.107])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2024 07:18:57 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: wqu@suse.com,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: scrub: run relocation repair when/only needed
Date: Tue,  9 Apr 2024 23:18:52 +0900
Message-ID: <4f457478390d84f5ecdc3818e239cdb652654ea0.1712672186.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs scrub finds an error, it reads mirrors to find correct data. If
all the errors are fixed, sctx->error_bitmap is cleared for the stripe
range. However, in the zoned mode, it runs relocation to repair scrub
errors when the bitmap is *not* empty, which is a flipped condition.

Also, it runs the relocation even if the scrub is read-only. This is missed
by a fix in commit 1f2030ff6e49 ("btrfs: scrub: respect the read-only flag
during repair").

The repair is only necessary when there is a repaired sector and should be
done on read-write scrub. So, tweak the condition for both regular and
zoned case.

Fixes: 54765392a1b9 ("btrfs: scrub: introduce helper to queue a stripe for scrub")
Fixes: 1f2030ff6e49 ("btrfs: scrub: respect the read-only flag during repair")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fa25004ab04e..4b22cfe9a98c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1012,6 +1012,7 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	int num_copies = btrfs_num_copies(fs_info, stripe->bg->start,
 					  stripe->bg->length);
+	unsigned long repaired;
 	int mirror;
 	int i;
 
@@ -1078,16 +1079,15 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 	 * Submit the repaired sectors.  For zoned case, we cannot do repair
 	 * in-place, but queue the bg to be relocated.
 	 */
-	if (btrfs_is_zoned(fs_info)) {
-		if (!bitmap_empty(&stripe->error_bitmap, stripe->nr_sectors))
+	bitmap_andnot(&repaired, &stripe->init_error_bitmap, &stripe->error_bitmap,
+		      stripe->nr_sectors);
+	if (!sctx->readonly && !bitmap_empty(&repaired, stripe->nr_sectors)) {
+		if (btrfs_is_zoned(fs_info)) {
 			btrfs_repair_one_zone(fs_info, sctx->stripes[0].bg->start);
-	} else if (!sctx->readonly) {
-		unsigned long repaired;
-
-		bitmap_andnot(&repaired, &stripe->init_error_bitmap,
-			      &stripe->error_bitmap, stripe->nr_sectors);
-		scrub_write_sectors(sctx, stripe, repaired, false);
-		wait_scrub_stripe_io(stripe);
+		} else {
+			scrub_write_sectors(sctx, stripe, repaired, false);
+			wait_scrub_stripe_io(stripe);
+		}
 	}
 
 	scrub_stripe_report_errors(sctx, stripe);
-- 
2.44.0


