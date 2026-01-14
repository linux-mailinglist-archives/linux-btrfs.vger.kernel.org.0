Return-Path: <linux-btrfs+bounces-20478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E66D1BEF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 02:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA740301F8EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 01:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E429D267;
	Wed, 14 Jan 2026 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="C/zLAtCD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1917BA2
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354118; cv=none; b=J9Hr5iU0XEKP3rzG+3gI/DWo5SoCEwGuOriHY5mafQttFU0F+MFj650rztgLIdPLEltstdhHPosYhBt4gLaWFAXdX1W+eIEF5plF+44ZE1d3XBjRIEZSFygrj0SoVTSYDJWF5jF0P4k+s4Ms5X+c3H/bqRv2+IuQYO4anweloeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354118; c=relaxed/simple;
	bh=XI8JRuPWt9q7DPMPPt0SRi1XenbOl8jEsoTF7QA4dTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mw3sU2JB+544cRl2GGFUojyJsYjFA5T2qF4/dEow/HXQOGJph0jV+5iGP69dP1LiaFm3U72mlD4fEgmVEFkDDlYz9NnCbtaIBOQ32B1M3zXCUJBtxZXMq63iqdbyeSbv+l8RBA/bHOiHTJZZTgPdueEGI2dlt46vHZRDmPXNODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=C/zLAtCD; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-jinbaohong.. (unknown [10.17.211.178])
	by mail.synology.com (Postfix) with ESMTPA id 4drStx4xkSzFwrQsq;
	Wed, 14 Jan 2026 09:19:05 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1768353545; bh=XI8JRuPWt9q7DPMPPt0SRi1XenbOl8jEsoTF7QA4dTg=;
	h=From:To:Cc:Subject:Date;
	b=C/zLAtCDlY/PAeKqZTFg45jx/tmBH3JUhJdUs3Q/oCaY9QL1ibj0i4GJrvrrkB/xp
	 sm8CPG/he4PABkV8eL8+GRPEndYQtpsVVlE8PV6GX66L1iTaYRd4bR5QIsl3iKcxZ0
	 EMFASQBYiSivhqHZp6pVTxMv3pdWxA7AUvkTh3aQ=
From: jinbaohong <jinbaohong@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com,
	jinbaohong@synology.com,
	robbieko <robbieko@synology.com>
Subject: [PATCH] btrfs: use READA_FORWARD_ALWAYS for device extent verification
Date: Wed, 14 Jan 2026 01:18:15 +0000
Message-Id: <20260114011815.327601-1-jinbaohong@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
Content-Type: text/plain

btrfs_verify_dev_extents() iterates through the entire device tree
during mount to verify dev extents against chunks. Since this function
scans the whole tree, READA_FORWARD_ALWAYS is more appropriate than
READA_FORWARD.

While the device tree is typically small (a few hundred KB even for
multi-TB filesystems), using the correct readahead mode for full-tree
iteration is more consistent with the intended usage.

Signed-off-by: robbieko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
---
 fs/btrfs/volumes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 908a89eaeabf..6bde24292aeb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8025,7 +8025,7 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	if (!path)
 		return -ENOMEM;
 
-	path->reada = READA_FORWARD;
+	path->reada = READA_FORWARD_ALWAYS;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

