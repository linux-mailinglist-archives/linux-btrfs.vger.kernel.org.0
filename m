Return-Path: <linux-btrfs+bounces-15274-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0CAFA9C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 04:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5EDB7AC058
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3691D88A6;
	Mon,  7 Jul 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UqLhdfgm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC41CBA02
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 02:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751856352; cv=none; b=pmH43eGgmOsvVD/smz5jBAmM+J4adCAg+orwhzWa5EzBd6yxKlYbXF5tVkNjc/1f80S2+jhcBsrI4hm2HCXgr0YOFuK8Xjrh4lh5hu4YD+HPyoxb6QbPCwA0YuGl9zzW73gnQoaS0S157lVnj0k/kn8A5Ifj3s1STGEpYYxqibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751856352; c=relaxed/simple;
	bh=ltX6DI4lg1ozoCs8eDvzWdnnCw8bmJ7SjGi8w3ty9j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otC1XeCwWx2vOBR9Ml0kUIaCiOo8bC/RJujo3w/lBEK0nZoFVhA6Ohnc7d+fvBK0tx1cR/NinFYVe5tpkV0Gh0AOSjKz820KlJyhEP5P1AIYkUa2ZPDS8y/V95ouw7yufV5QrgdF5XPJaAkIOva7ChGi9cTokQjOkf1t4lQfO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UqLhdfgm; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751856350; x=1783392350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ltX6DI4lg1ozoCs8eDvzWdnnCw8bmJ7SjGi8w3ty9j4=;
  b=UqLhdfgmG644/iyAvtJpLnyuK+l2YmXwm/hAIcOP+tg2bhtm1bKmwFoX
   hjMT0PHCbAxYOZHFl9rSchabTzKsJ4qhvDU2LfTH+EHmyFh/D03zLFQXg
   XQnLYjEBCi4VvI+83DzzayOuchhY7QcDPJLjG/MOz2kHMbT+Ibkq+bhQf
   tihzV5nkJg1BM0dfTdjakM2ktRPEwr0NSFoQd+f1ooxK5L7Db50ry5bTS
   J0hKFwX39oCjgCwrecdpIGZF+igeKe6JuWrBpy1E1sCMQy5aF6yivM4BE
   eNrcS4qL3hn6KgHOH9r2VZF8OUo6nRpigHqQtIFXWl1rHtSb4fsOdQI3f
   g==;
X-CSE-ConnectionGUID: 8iwCDcPVTwiQ1dAOTteWRg==
X-CSE-MsgGUID: CSDAEIidSTO+HXoz/PM0Hg==
X-IronPort-AV: E=Sophos;i="6.16,293,1744041600"; 
   d="scan'208";a="85911273"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2025 10:44:39 +0800
IronPort-SDR: 686b2605_5lkNbwwSVEZiKq04j/MZjHZiPKWt70SB6azokDxkNWVWzvC
 bfTxcznsOWTNtBLc+h+K1kdCNhvd+k0ZiMHx3iQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2025 18:42:29 -0700
WDCIronportException: Internal
Received: from 5cg217427s.ad.shared (HELO naota-xeon) ([10.224.173.231])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2025 19:44:40 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] btrfs: zoned: fix write time activation failure for metadata block group
Date: Mon,  7 Jul 2025 11:44:11 +0900
Message-ID: <bb200206ae65453c68c2f3e316378838797e2502.1751611657.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751611657.git.naohiro.aota@wdc.com>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 13bb483d32ab ("btrfs: zoned: activate metadata block group on
write time"), we activate a metadata block group on the write time. If the
zone capacity is small enough, we can allocate the entire region before the
first write. Then, we hit the btrfs_zoned_bg_is_full() in
btrfs_zone_activate() and the activation fails.

For a data block group, we already check the fullness condition in the
caller side. And, the fullness check is not necessary for metadata's
write-time activation. Replace it with a proper WARN.

Fixes: 13bb483d32ab ("btrfs: zoned: activate metadata block group on write time")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 6fb4d95412d6..9c354e84ab07 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2169,10 +2169,13 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		goto out_unlock;
 	}
 
-	/* No space left */
-	if (btrfs_zoned_bg_is_full(block_group)) {
-		ret = false;
-		goto out_unlock;
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
+		if (WARN_ON_ONCE(btrfs_zoned_bg_is_full(block_group))) {
+			ret = false;
+			goto out_unlock;
+		}
+	} else {
+		WARN_ON_ONCE(block_group->meta_write_pointer != block_group->start);
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
-- 
2.50.0


