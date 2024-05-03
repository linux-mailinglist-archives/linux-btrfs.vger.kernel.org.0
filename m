Return-Path: <linux-btrfs+bounces-4699-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622578BA6AA
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 07:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB332830DC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90421139CE1;
	Fri,  3 May 2024 05:35:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81F139591
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714714511; cv=none; b=KSbjJKnWxcLedx7kDrdJ5VzZERlRwlVTyxKzVWYtknLKjDJFLAgBY0mm5M1/5/3O87tpZnC7G3OdNNgEVY2jdhh5HoP6osb2zk4tjA3/4TvkCftwLXqrdf9RpLCY+j4RAJLQvqHr4dFmOA7OiAkWPJxlWOFV7hNRJ/7UOWp5w60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714714511; c=relaxed/simple;
	bh=IxfLcYEGu2vZhozhLf2zzY2UEHrUL6vCIwQBoRntHZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aT8WPqG3Hqqgs4B+6+YfcSQJTloyxYYgl7RKd8+OCRgGzNMJz2fTpQ0LCNf+rFXUs5TMTYN10sWdZqhfEPQBDM5Q2OqNy81++ucRlJa3GRa4Sl5QgQU+TJAcv3RXKe2t1lNNMB/UTi2IrpeK7b8MUSgWPH5ZIQbnIrLWaVzDLSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a55911bff66so1162179666b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 22:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714714508; x=1715319308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CnIzRxAKWsNwqdlccr13lXN81lXKA5W9Ab3dXAmZcTw=;
        b=Hq4yIouqxztU7axYI2+GkU4BFyvXF+L0FsRv3xa2rSTOtUkSOx6a9eyPACbjweUD0Q
         p+6bWPKYBILHHexhZQ4sZjmtv1GwjtMP/qLYQcn3I0jS46F9SaJG4AZ+j4mxBJXPjQVO
         a+RfGbfomQ7ZGqaK5kxgqNd7ES1k8cMkatEw159aL1SNKLu6OjxNUaEbyI3Pf81Akudt
         B3KXA+UD5QwBjxnhAp4kyN2gl8S0O9ureR3UCT9Oz7lViuEMaFseUNk0e5WjjNpzbLkL
         4bX8L9hCDQze5XHhxn3LUr7PAFgh9zJN5Tokh55zZrG/6V8pj33od1zqzyJnTQvzn55b
         itsw==
X-Gm-Message-State: AOJu0YwiZZV6VkefpOfWGJLbykGanG01ST6+SxaFQCW3+8pBmpKcQVtF
	ZQ4VcPsTqdx2Cxo+Zp+3ERKx0+AQxrhnAPubhSh9bpBP8Ps5ArwRKqnnba3g
X-Google-Smtp-Source: AGHT+IFabRDRUU0p/Ht59TX4TojOYBX2YR7LPmfNDvyjHAUKpqjQ5vgfbuIc+eEawglv4uYrnx4fgQ==
X-Received: by 2002:a17:906:114a:b0:a58:ca91:7855 with SMTP id i10-20020a170906114a00b00a58ca917855mr982310eja.0.1714714507630;
        Thu, 02 May 2024 22:35:07 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709061cc200b00a598a32f21bsm534275ejh.102.2024.05.02.22.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 22:35:07 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH RFC] btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
Date: Fri,  3 May 2024 07:34:57 +0200
Message-Id: <2454cd4eb1694d37056e492af32b23743c63202b.1714663442.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().

It is only needed to protect
a) calls to find_live_mirror() and
b) calling into handle_ops_on_dev_replace().

But there is no need to hold the rwsem for any kind of set_io_stripe()
calls.

So relax taking the dev_replace rwsem to only protect both cases and check
if the device replace status has changed in the meantime, for which we have
to re-do the find_live_mirror() calls.

This fixes a deadlock on raid-stripe-tree where device replace performs a
scrub operation, which in turn calls into btrfs_map_block() to find the
physical location of the block.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a3dc88e420d1..3a842b9960b2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6649,14 +6649,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
+again:
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
-	/*
-	 * Hold the semaphore for read during the whole operation, write is
-	 * requested at commit time but must wait.
-	 */
-	if (!dev_replace_is_ongoing)
-		up_read(&dev_replace->rwsem);
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -6689,6 +6684,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_single(map, &io_geom);
 		break;
 	}
+
+	up_read(&dev_replace->rwsem);
+
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
@@ -6784,10 +6782,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (op != BTRFS_MAP_READ)
 		io_geom.max_errors = btrfs_chunk_max_errors(map);
 
+	/*
+	 * Check if something changed the dev_replace state since
+	 * we've checked it for the last time and if redo the whole
+	 * mapping operation.
+	 */
+	down_read(&dev_replace->rwsem);
+	if (!dev_replace_is_ongoing &&
+	    btrfs_dev_replace_is_ongoing(dev_replace)) {
+		up_read(&dev_replace->rwsem);
+		goto again;
+	}
+	up_read(&dev_replace->rwsem);
+
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    op != BTRFS_MAP_READ) {
+		down_read(&dev_replace->rwsem);
 		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
 					  &io_geom.num_stripes, &io_geom.max_errors);
+		up_read(&dev_replace->rwsem);
 	}
 
 	*bioc_ret = bioc;
@@ -6796,11 +6809,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
-		lockdep_assert_held(&dev_replace->rwsem);
-		/* Unlock and let waiting writers proceed */
-		up_read(&dev_replace->rwsem);
-	}
 	btrfs_free_chunk_map(map);
 	return ret;
 }
-- 
2.35.3


