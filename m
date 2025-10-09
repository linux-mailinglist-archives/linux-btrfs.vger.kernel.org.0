Return-Path: <linux-btrfs+bounces-17575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F60BC8D0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 413BB4FA9EA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 11:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333352E172B;
	Thu,  9 Oct 2025 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="Ow1KjafA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (unknown [62.3.69.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601BA2E093A
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.3.69.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009301; cv=none; b=CCPcZHDmCaB3zxy4NU+Fnxm2xt4ixKhJD/Vjn2/V9Jc/5l94SAx3oNWOpxQUQZQkCwnYMSUTrHRA7cKak+L6QKFLgcNs7qk0QrFlswmGzU2p87zaVnY/Gbhj7INpsbVzQuZm77SRgqLwe5IOWgwE2f2lcxlOcn0i3/4+HUGi++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009301; c=relaxed/simple;
	bh=28ehZ/BiDIDB98JBmiR77cbQWNDelfXDJOFCxDHQFiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=oDQHZ0LUsu3ierNq2whhXPNVpHEdUT0hxDvgpxrng0YR5Dx3qDEYTBmaL8q/0mqEqjCzmgolyJ8R1BdWPJHqvjXuXIPWTiPpLNDSTWbiUwmdLdkQuzNBKy/YFvd1FHn0itQjuIdccIVuL4szF0BE05Xym/L6t7Mo2XX738fTgaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=fail smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=Ow1KjafA; arc=none smtp.client-ip=62.3.69.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 9FD4A2C5656;
	Thu,  9 Oct 2025 12:28:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1760009288;
	bh=PaVT8cgYsrTSRNquQRTt8b2COzc2xdkW7NiavZul5wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ow1KjafAgLHI3sKVn4BEaN+zHr2KJNOAFB+DPslDu1l/d9TcCquUyZNpsr4if7/bo
	 G8NU1eYII03A+CJk2sZ8DxxGuGpTFxjlADfRqOcVV5Oz/HWPx58et/JmZr5gi/VtQ3
	 L9PcogwO4ziLVTufMcjRsoBAkT8UTw0coAIrtBEI=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v3 09/17] btrfs: release BG lock before calling btrfs_link_bg_list()
Date: Thu,  9 Oct 2025 12:28:04 +0100
Message-ID: <20251009112814.13942-10-mark@harmstone.com>
In-Reply-To: <20251009112814.13942-1-mark@harmstone.com>
References: <20251009112814.13942-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Release block_group->lock before calling btrfs_link_bg_list() in
btrfs_delete_unused_bgs(), as this was causing lockdep issues.

This lock isn't held in any other place that we call btrfs_link_bg_list(), as
the block group lists are manipulated while holding fs_info->unused_bgs_lock.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
Fixes: 0497dfba98c0 ("btrfs: codify pattern for adding block_group to bg_list")
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d3433a5b169f..a3c984f905fc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if ((space_info->total_bytes - block_group->length < used &&
 		     block_group->zone_unusable < block_group->length) ||
 		    has_unwritten_metadata(block_group)) {
+			spin_unlock(&block_group->lock);
+
 			/*
 			 * Add a reference for the list, compensate for the ref
 			 * drop under the "next" label for the
@@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			btrfs_link_bg_list(block_group, &retry_list);
 
 			trace_btrfs_skip_unused_block_group(block_group);
-			spin_unlock(&block_group->lock);
 			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
-- 
2.49.1


