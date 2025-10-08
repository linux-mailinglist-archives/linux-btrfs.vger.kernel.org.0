Return-Path: <linux-btrfs+bounces-17524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3CBC3B69
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 09:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BC6F3524B0
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0812F25F4;
	Wed,  8 Oct 2025 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="NsnHWvnw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899F165F16;
	Wed,  8 Oct 2025 07:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759909264; cv=none; b=njB0uy05WeRVSOTEXUt+DbC/ZLdsS0QE/zg7cVbGXmf+36vczjzpeasdUUrUsecxxwrF9mjq+nOjfBCTqpl6XPa1RxJEJm32u8ZR3qdKzBk7VxiUPLMgiez0dxSrAGtTt79blCXYRIU++4GaCX6e//FcX+098sQIhBE5Ugp95SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759909264; c=relaxed/simple;
	bh=3aZog2HRojKqhnqjdTM+UPp/n3bXgH/F5RV+rJtlmRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PxTcTd8tZAb3Gn39FTOIXlL8i9QvYX5XXXd4Lxjd73PVNufSzNs9Z3MW9T+Age4qPz2ZckoNuTwibH1SeMNhBBrq0Ru/wp0LWHa7ZxWB2049cjMxaEuYzsZBuQAJFMLKK0IaPYnOfgJVJ0ob+UoqU3hjbDBTXy55Zmzmji+0ZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=NsnHWvnw; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4chQ0l6j2Vz9svB;
	Wed,  8 Oct 2025 09:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759909256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1CtZM5VHDvSyhkfZPj6PX2AxUIJ9QSPr02oZG+8Z4IM=;
	b=NsnHWvnwvjrnDI6Xi9Y7m6ScvrwMOBYeYF5nMCSeweYsSGBZDGxNTb69pVBkPJ+3PPoncS
	j7dBAzs1iPMoN4eZpfC7Zt1mVZ7/jhvUa2vHtdoV3YSxm1vylboGZKb19H7dXc7sJ/7SGk
	JL3d4jvSIm37NaN5dot0D1Nn7Dzwd5rNIg1ruhOvnTu/3Ym8OGwRg+eXOez1EfFUmJPTfC
	K2VTMjSJLZhiDJfKSB9snBGLOt1iVLdI/p9ZburFaKR/PrbOZlgBF1R6dEpxmC3Zrkkgcs
	+EGo6fQTapPs8tfVVa/QJd6e9KrcSXj0UocXd/CWm9LM9KrSqn2i4HimtViyQQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::1 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	naohiro.aota@wdc.com,
	boris@bur.io,
	johannes.thumshirn@wdc.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2] btrfs: fix memory leaks when rejecting a non SINGLE data profile without an RST
Date: Wed,  8 Oct 2025 09:40:31 +0200
Message-ID: <20251008074031.17830-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4chQ0l6j2Vz9svB

At the end of btrfs_load_block_group_zone_info() the first thing we do
is to ensure that if the mapping type is not a SINGLE one and there is
no RAID stripe tree, then we return early with an error.

Doing that, though, prevents the code from running the last calls from
this function which are about freeing memory allocated during its
run. Hence, in this case, instead of returning early, we set the ret
value and fall through the rest of the cleanup code.

Fixes: 5906333cc4af ("btrfs: zoned: don't skip block group profile checks on conventional zones")
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/zoned.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3341a84f4ab..8f767a6cd49b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1753,7 +1753,11 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	    !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
 			  btrfs_bg_type_to_raid_name(map->type));
-		return -EINVAL;
+		/*
+		 * Note that this might be overwritten by later if statements,
+		 * but the error will be at least printed by the line above.
+		 */
+		ret = -EINVAL;
 	}
 
 	if (unlikely(cache->alloc_offset > cache->zone_capacity)) {
@@ -1785,6 +1789,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		btrfs_free_chunk_map(cache->physical_map);
 		cache->physical_map = NULL;
 	}
+
 	bitmap_free(active);
 	kfree(zone_info);
 
-- 
2.51.0


