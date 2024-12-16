Return-Path: <linux-btrfs+bounces-10398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166999F2B93
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 09:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFA1165E40
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE23E1FFC64;
	Mon, 16 Dec 2024 08:10:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD71FF7A2;
	Mon, 16 Dec 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734336652; cv=none; b=r9AsUc6niTokiu0sJeJ7HQh2YadRmRYbEVt1lDxclcrCZOWPLLl041cMp/3kdqqf9rqXjyLZ5Wr62eMLvBS7gFtfKeEqSZGXLp8NRVu/tl4+RBnBDIrCuPw6oXMwXRDEOKMadLJVtCApYjakP/lAVJKhlQ77URNM2IUNBv2El3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734336652; c=relaxed/simple;
	bh=rklkBZpycmpnbNdy0x0UtScNM9eIxtzUDg5s1Uh/ToU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G+1J7Bs0NwPSJkTlZJnq8zWPNtnbZniUQBKM2We24r7eV9v+mM4HsbMe95/dNsvoIPKM8H2maX3CHq+R30/x/6tj+y3KBM4zB10ibfDT2jDY/hTM3RR0OKXDNrabX1TEJoW335EaBQAkpKb+0O2RsxzWY6mqszcKj9NWF4eDSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so4878914a12.2;
        Mon, 16 Dec 2024 00:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734336649; x=1734941449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHZ6DN0fprXEFrfULeL6o6cv5cJ/mLMEVblPKgAwH20=;
        b=w7BqVIiHO2b60C5SABWGo1joYf5gQxHfbqoWLBcTtNFuoWU9FtEJ73YfC7sXuzLtzv
         bCiUZSqUIuPmT5oQQq6S0Y3XUp0n5ITiLWsptHi3QnC2S3HYn/P9Wm3nuwHm3g9Q7upA
         ODiolbTFPgmxVZB92XboK1SUM5TeYmdSr1bEACrqEAc9Z6UzncZnQU9npQZuwmpF3A//
         HV0AVBvb6xqpc2+VsqWOkG7oVrTOfhilVpE8TDs8lRJiEJdYrlg0eZ5zrmhFQ7uMUnAV
         Bo0t29H3qx6EipN/NoPtpNVEblNNRPI30UGpxRWfFDiSfy6vYUaJAKo+K68JuI/oVEvq
         qRYA==
X-Forwarded-Encrypted: i=1; AJvYcCWEvnpcf99n05bLk7ZWQVEewzNw1Ggi174bE2IsHgZuTV5dOqHyGdHKvpXdZZG79ykqHnyUgGJuX4ulvL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63PycvLBI04rD2yw9QOlgogXzm4uLIUhElmPYKdYTIhKupOmq
	kBhoNegjb7zER/C4zttr+N9kxk31tntHtELq3WwZ2QBstZTQVpnX
X-Gm-Gg: ASbGnctbpTf3Mj71BJheJz+a7JruHbtRmaUKq9iQdF/z1WT4PvhHxVu9yqIxese7GZ+
	DV46QQmJJFCUTPr6bg2zL5Q7IUMDKaOwQIUek+3fIc+WkkTbLY5WKxItEjeqldMCNaVJuFEylc6
	gdWmhWgctEfZ87ehZZw+3UxS7OM81oUwqdA1paTizKSL7Yw5Y/CawtKqnWCMC7xeY9UFjgat6hg
	bTj+UyidNhKdvowZTo4eurE0PDvgW/i+uHwwS6Mde529atpbXLj6Uc3ji9PBfAWJD9XCAxTBuiW
	BA7ZruVWAsKRCWgJJtn9//q3U6+D+oCbbDKd
X-Google-Smtp-Source: AGHT+IHDGowW9Oabh48yxmGwzjHGNLKdKpWrlHkOSDKCUVjCCQ1sRxzdeNkBJkbOvvRRpg7Mmrl+2g==
X-Received: by 2002:a05:6402:5415:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5d63c3dbc28mr26330019a12.23.1734336648483;
        Mon, 16 Dec 2024 00:10:48 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9635a000sm299013566b.113.2024.12.16.00.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:10:48 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 16 Dec 2024 09:10:39 +0100
Subject: [PATCH v2 1/3] btrfs: cache stripe tree usage in io_geometry
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-1-42b6d0274da7@kernel.org>
References: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
In-Reply-To: <20241216-btrfs_need_stripe_tree_update-cleanups-v2-0-42b6d0274da7@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thjumshirn@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=jth@kernel.org;
 h=from:subject:message-id; bh=/5D5piZXC5jz6vomUPd9zh50bn2AXLREKO3R42gB1yA=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTHP2jLvHqiLq4yeMIzy8POfIfqC6uumM2dP3u6WQjPT
 /9J7ex7OkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAima8Y/hmyvop5vqp7Vee1
 TLHamSm3PLz8qpPTfPY+VCwoCba6XM3IsH7DY46iEyIXJXPM27YKL9FsiXib31HIfc7YJmp69gl
 nVgA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Cache the return of btrfs_need_stripe_tree_update() in struct
btrfs_io_geometry.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d5d4029440c46a4a92c7d6541d474..fa190f7108545eacf82ef2b5f1f3838d56ca683e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -48,6 +48,7 @@ struct btrfs_io_geometry {
 	u64 raid56_full_stripe_start;
 	int max_errors;
 	enum btrfs_map_op op;
+	bool use_rst;
 };
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
@@ -6346,8 +6347,7 @@ static int set_io_stripe(struct btrfs_fs_info *fs_info, u64 logical,
 {
 	dst->dev = map->stripes[io_geom->stripe_index].dev;
 
-	if (io_geom->op == BTRFS_MAP_READ &&
-	    btrfs_need_stripe_tree_update(fs_info, map->type))
+	if (io_geom->op == BTRFS_MAP_READ && io_geom->use_rst)
 		return btrfs_get_raid_extent_offset(fs_info, logical, length,
 						    map->type,
 						    io_geom->stripe_index, dst);
@@ -6579,6 +6579,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	io_geom.raid56_full_stripe_start = (u64)-1;
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
+	io_geom.use_rst = btrfs_need_stripe_tree_update(fs_info, map->type);
 
 	if (dev_replace->replace_task != current)
 		down_read(&dev_replace->rwsem);

-- 
2.43.0


