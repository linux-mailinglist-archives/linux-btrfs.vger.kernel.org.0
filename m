Return-Path: <linux-btrfs+bounces-11593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF33A3C1ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072FA16D9F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB021EDA3C;
	Wed, 19 Feb 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Iy8gBjDX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02651D5CFA;
	Wed, 19 Feb 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974760; cv=none; b=tAVXt5fyaYLFS4GjB5j9xwSxXsjznbpbX3uDLLGjxiv1WIoxHdMykptdLmz70gjxLr+oNU/kw5TiwvVQkmyASx0JIz9SkF0rh3LULIQmKL9PCjp3y0SlSUUXZW1MYTynRTUPBJcAZ/q+3wR5qjaHxcLrdUHBZy0PRk7jEddb04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974760; c=relaxed/simple;
	bh=xhOka5HrB/5l9DnPGh8I/d8vI/RjpFfgtquNt4qx9kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtbUXK1airPflb+BCP3ODWwLgbWTnnq4UqdJ9r1/BuR0s0kihMlBPrkfk0erGOdDKydnuxpZ2dUXUv5tACsS4Ie9mzRrvEG8U88rpB6eymZ5lAjGrHZanCgpDkyxFsyFYY0UnsDv9fadDwvWE/5lY4PgnhUu6DVr5pS2kADfiv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Iy8gBjDX; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id kkmNtlwWuP1lPkkmQtAPTZ; Wed, 19 Feb 2025 15:10:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739974227;
	bh=/3VqG2Ixu4D/b/fBjdxtIHmnWs32ARGjXTBEBsZkq2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Iy8gBjDXBxphsv6TAVjALjMVIWnok0wI4Cn6sv230TK+vh1OEefemFDGWNn93Q3dW
	 mi6c47I+n2eTCn+vM0WVmX0SRdFkR1mbig/p1d4gFvyZ0+l6M0fJHGwlCqE5ZmgKJ6
	 05lb5Beqs9gRPb9WW8e0Q6+v2f3v2XktqjQQH3DIFLLb5K5CMBpRsil+Aupeg2hsuH
	 +9wnWbiqgkK3yf0SoktRsrp8WYCnzZZuwaztUh8kmED9XgKDcMCyCr1ozmRj0kUH8l
	 tZpjHPXWUuFZxo/yydJ/XvXeiwDRCgNaIztMvQcAMWPgu8k4fMGEMS/Bc9fHFYoDGt
	 eeEiSBiqY2xBg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 Feb 2025 15:10:27 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: Remove some code duplication
Date: Wed, 19 Feb 2025 15:10:21 +0100
Message-ID: <74072f83285f96aba98add7d24c9f944d22a721b.1739974151.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code snippet is written twice in row, so remove one of them.

This was apparently added by accident in commit efe28fcf2e47 ("btrfs:
handle unexpected parent block offset in btrfs_alloc_tree_block()")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/btrfs/zoned.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b5b9d16664a8..6c4534316aad 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1663,15 +1663,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 out:
-	/* Reject non SINGLE data profiles without RST */
-	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
-	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
-	    !fs_info->stripe_root) {
-		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
-			  btrfs_bg_type_to_raid_name(map->type));
-		return -EINVAL;
-	}
-
 	/* Reject non SINGLE data profiles without RST. */
 	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
 	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
-- 
2.48.1


