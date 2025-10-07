Return-Path: <linux-btrfs+bounces-17498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DDBC043B
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 07:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A58134E71D8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 05:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B76221FA8;
	Tue,  7 Oct 2025 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="xQcunmoE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A0813B58B;
	Tue,  7 Oct 2025 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759816525; cv=none; b=Szq3hFikeYfmz9CI7veqQwWlTuUvOFvkv4q3EbrkhbIewgmKg6jW47e/bTTt14bDnVyNNWbzC4b1knp96jEg23Sy9hM68DlaDpUY1x1f75COFWhXF+a9k5nORMujXJnVQKDQJyvtJirg3nLL62KAail42kiv/Bdv2DOJMdjyqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759816525; c=relaxed/simple;
	bh=VyI1knQQT4PYdAhMssT7LrkIhDkGF85VdrmFBYteHLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UdODVEkl2F1/sE5qNsnq0NENHlrlR8pPPr2ViaFWvbQl0IDsA7pPr8uzwthq9OnREZUt+0ttqy2dH4AeDIwM1tOLq9qnXmFykHs11G3UYT+fumQZwnd8yGopfM9thITAWt2Z2WyZv+DeySMUDl7BpX8PxLztHw9Tt7Zp+vxwRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=xQcunmoE; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cgljD1mhdz9xxF;
	Tue,  7 Oct 2025 07:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759816512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JfRY/ZlFx5gH/42pV4Wn1ZJtQvHdS7TgX5Ggai6C4VY=;
	b=xQcunmoES0myy0i+iUUyJU9tNGusIIc/8rSQWnjtsUStUJLR23BDkd18go9AI0KkOKjq9Z
	momhwDKUw4ps+KDA7c2S0ebfo2vKOVVWa/b1lRTBnmlafWETBFZTv2U/A+/oweYaMY8mk8
	Nrwnc8EjiSxncal+o7hF5YK5/WzJMXunCp+D2i6LRq0vqzKYqYgNkR0D58omFXeK3m4yQU
	M130Mds+wY2NgyRHQ21IxuSIcdxhINVWX4GqjL0kY9/f1z8eJROnxTuy5ySEcRMDT4Vspm
	ubOz2ZfI0ICD6f0x7Sw/bkp2/Kx+lFMq2USYUWdUwa1wQFGT8+HbtSug5Lf2DA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] btrfs: fix memory leak when rejecting a non SINGLE data profile without an RST
Date: Tue,  7 Oct 2025 07:54:53 +0200
Message-ID: <20251007055453.343450-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

At the end of btrfs_load_block_group_zone_info() the first thing we do
is to ensure that if the mapping type is not a SINGLE one and there is
no RAID stripe tree, then we return early with an error.

Doing that, though, prevents the code from running the last calls from
this function which are about freeing memory allocated during its
run. Hence, in this case, instead of returning early go to the freeing
section of this function and leave then.

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/btrfs/zoned.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3341a84f4ab..b0f5d61dbfd2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1753,7 +1753,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	    !fs_info->stripe_root) {
 		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
 			  btrfs_bg_type_to_raid_name(map->type));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_free;
 	}
 
 	if (unlikely(cache->alloc_offset > cache->zone_capacity)) {
@@ -1785,6 +1786,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		btrfs_free_chunk_map(cache->physical_map);
 		cache->physical_map = NULL;
 	}
+
+out_free:
 	bitmap_free(active);
 	kfree(zone_info);
 
-- 
2.51.0


