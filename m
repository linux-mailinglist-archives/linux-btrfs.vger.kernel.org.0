Return-Path: <linux-btrfs+bounces-20462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2FCD1ADD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 19:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA27B3036C77
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6F34E776;
	Tue, 13 Jan 2026 18:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="EB50I3TT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6042116F6
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329498; cv=none; b=nq0i0DxE09jRK1jbIlWfJssabwaj8+eIJa4zYIrWMTlNbkAYIU9FB049A0MWMoEKPmvZpjlqfQFbdYcs8HreC+lv9AHC+lpoXaDVs2BbILqNM1OGL/LbHO48ChVlT08H4yC7CI51jSbWflkAHbcKcSvdA7ulvbUglOy05Kue9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329498; c=relaxed/simple;
	bh=UBYOshbh3VyhOwmqzzFFkGBglHudsM+vYNWhjv7FOTA=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=B9udk62oR9dh1QxRWe8+FhPO0ifziGdwekUpJbKIDlo9tSu5f0PsznoFbcJOYgQ2+Awfy2RXCX2sXc9pSF5YAHSfyYcWgEkyvYIqKQq+idVy5L9ezx+dp+pLYwLr1XYS5f1mhUkmY4rDDYjJjipKX42o75r8soqDgs68OmIqQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=EB50I3TT; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from beren (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 0EB6C2F3EFD;
	Tue, 13 Jan 2026 18:38:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1768329486;
	bh=tdLiLB06OWV4nlM2JZViNakNBNlA/16EtbQVrqtF44M=;
	h=From:To:Cc:Subject:Date;
	b=EB50I3TTXQ9F2PrqRJXGSKIbCC43UHg3lXHSkQqWP2LJiG82VBXA9cNgH9ioZMANB
	 W63+hXU9QAQNY6dQbFVwUltYZVBRnp0yf0wqAd/7kAe35u8QxrfYSGt8zD9S1aS7+K
	 rLL3VVxC8czluDEPi65HFDP4zlBaLoW6Tw6PwVlw=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	wqu@suse.com
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH] btrfs: fix missing fields in superblock backup with BLOCK_GROUP_TREE
Date: Tue, 13 Jan 2026 18:37:56 +0000
Message-ID: <20260113183802.17640-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

When the BLOCK_GROUP_TREE compat_ro flag is set, the extent root and
csum root fields are getting missed.

This is because EXTENT_TREE_V2 treated these differently, and when
they were split off this special-casing was mistakenly assigned to
BGT rather than the rump EXTENT_TREE_V2. There's no reason why the
existence of the block group tree should mean that we don't record the
details of the last commit's extent root and csum root.

Fix the code in backup_super_roots() so that the correct check gets
made.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: 1c56ab991903 ("btrfs: separate BLOCK_GROUP_TREE compat RO flag from EXTENT_TREE_V2")
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0491b799148f..54c4496c30d7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1650,7 +1650,7 @@ static void backup_super_roots(struct btrfs_fs_info *info)
 	btrfs_set_backup_chunk_root_level(root_backup,
 			       btrfs_header_level(info->chunk_root->node));
 
-	if (!btrfs_fs_compat_ro(info, BLOCK_GROUP_TREE)) {
+	if (!btrfs_fs_incompat(info, EXTENT_TREE_V2)) {
 		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
 		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
 
-- 
2.51.2


