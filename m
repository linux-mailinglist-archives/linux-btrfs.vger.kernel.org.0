Return-Path: <linux-btrfs+bounces-16056-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366C3B24C3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 16:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A35E1C20FFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Aug 2025 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BCC2FFDEC;
	Wed, 13 Aug 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="opyNQSJF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F6157493
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Aug 2025 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095728; cv=none; b=kQZI9lwMB0BFIW7MsyPovYfRpDVwpNaCZHh+OmptEGm5pPU0sz2XAKvoECN6K9txd6fxtngDLkuysY2/6LMl79tn8k9ouvTK4IVZoO9QEbx4Zzh8wUrGVbjFafgKw0BoKwx35K0t90ZdSYv9OM/eQbPuLYoWdoVXP1BjLujRWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095728; c=relaxed/simple;
	bh=TVJVM2X+gXsMbVWcAjrV6/uZOQ9ac3YsV/eHyJqXvdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version; b=uqlHReBQsAmQ7iFUi8byGDZPm/LnEq8rUD7QcDPWmWoIvcaAofmNCVWR5cZaFJvINLwKKN8d0Q6rn99M8zgQ3PlwQVGim+V1SFHMRrHQMeFledFb9ntSYf5DvIR4Sd4U1KC2chRcMWsVVos6qFBInTSdn9geHdzxX61nwnOxrmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=opyNQSJF; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id 5FA832A7598;
	Wed, 13 Aug 2025 15:35:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1755095713;
	bh=9juDSwgMKvLhKSrdcORqLSWuCH7RRRQbxOyiQpFZUGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=opyNQSJF+CbDs2KhwJgbpV3w4QyOtsapJa1bq7I+Pn+TJYMq0t0ezkrNaQ6F43PS8
	 gt2qAclEWg/8RWCldRURykjWTDVW6ZnzVp2tddJJj2A9/TprSh0i882ePtTzwEwFRX
	 g7chpOHno0xVve3/s4yh0k0CZyY31dh9hnYq+VHQ=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH v2 09/16] btrfs: release BG lock before calling btrfs_link_bg_list()
Date: Wed, 13 Aug 2025 15:34:51 +0100
Message-ID: <20250813143509.31073-10-mark@harmstone.com>
In-Reply-To: <20250813143509.31073-1-mark@harmstone.com>
References: <20250813143509.31073-1-mark@harmstone.com>
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
---
 fs/btrfs/block-group.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bed9c58b6cbc..8c28f829547e 100644
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


