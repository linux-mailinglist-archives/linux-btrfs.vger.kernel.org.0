Return-Path: <linux-btrfs+bounces-4829-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0388BFC54
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474691C20FF7
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C8824A6;
	Wed,  8 May 2024 11:40:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FE81AD0
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168432; cv=none; b=Np/5yzkSVGuIIM9jdvtpG0/Ozg5EqLOM71FtNeAyO59ow+/5T2jzeOADYWviEh9lKWNMhJQn7vC7U/K+55lhzigIo9M2kvD3cn9wShimd0ysG1IsB0iR9+H3Og24vJ9o/miWiPXl7agFfuBAy3wnVNKkiAu7ulu11xAKHLB+9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168432; c=relaxed/simple;
	bh=yFvFJRuBedcGVLMsgH2ZbWl8S1anR+TFj06hgNbBHjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vz3JlRZ7MHlH/dusCREn/5MmwGu23zRReSHCKQlIQgEXQwcfWL3fpDXdnIOqYJxDcVF9+I/9UVUMyLLmHt0CWXq7fjCgl4+8SeCk+SYI6j9RflUWn3ZKMSoJfzvP7YSyBjzOcprmocV6VbvXCELUivOIXiG13qMetgHV9n7que4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso5455093e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 May 2024 04:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168429; x=1715773229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpSrJR5f8iCBiRtHdPw9oPa8aiY/z0HBivJHz0pUbOo=;
        b=ufH2Z/qjSVSEH4t10/rVErJH+X9D6P5y8AyWhXylzj+gCfxYK6xjVrh0ff9BjOSbaX
         HguF5okjb7/GoxMDU+RMMUmVtaTohxyvyY0RIkKU8gHVqoxgXSRdHxijw38DB5QR0bEU
         qhyRvptwKumb2G1GrxUO5LIZ0udEqzl8ofDo+7NfAAYC4UmraDjGLLzpI+Kjfcj9svKH
         AFcJwbdgB8r7y8uw/sSCrLiK6lHWsK7qA3dW4maxs4lg3FCh/2UCgVs86BNMPvvul1AN
         nuykGXr3n79lGBo5lwcKtEtRJ/TwszVa8hXdJQjrN0QGyTEn5nYMQo5X5KUCFDLRrsJZ
         2L7A==
X-Gm-Message-State: AOJu0Yyd9nqAGiHRFa/rqgBkOuDsztj7nRDDuBarXf4NgJf4aXNvNJ+x
	+cl0yCdJs1XTxqW+V3smKPWFb/GgK3z3SN8Cu9fwXGIM3aIMzOJP8S8l4g==
X-Google-Smtp-Source: AGHT+IE7aC6yGgeTFtW4nBHH+LrVk0Tx2ANUwS4CZUX7P3Rm+QN/YUHmW1lTutR7MKQY3zFcEDkBvw==
X-Received: by 2002:a05:6512:ea1:b0:518:dae6:d0ec with SMTP id 2adb3069b0e04-5217c2782bamr1928640e87.4.1715168428795;
        Wed, 08 May 2024 04:40:28 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id x2-20020a056402414200b00572cf08369asm6710380eda.23.2024.05.08.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:40:28 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
Date: Wed,  8 May 2024 13:40:15 +0200
Message-Id: <20240508114016.18119-2-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508114016.18119-1-jth@kernel.org>
References: <20240508114016.18119-1-jth@kernel.org>
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
 fs/btrfs/volumes.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b6a701011fb0..5eb41f50ee0c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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
@@ -6690,6 +6685,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		map_blocks_single(map, &io_geom);
 		break;
 	}
+
+	up_read(&dev_replace->rwsem);
+
 	if (io_geom.stripe_index >= map->num_stripes) {
 		btrfs_crit(fs_info,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
@@ -6785,11 +6783,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	if (op != BTRFS_MAP_READ)
 		io_geom.max_errors = btrfs_chunk_max_errors(map);
 
+	/*
+	 * Check if something changed the dev_replace state since
+	 * we've checked it for the last time and if redo the whole
+	 * mapping operation.
+	 */
+	down_read(&dev_replace->rwsem);
+	if (dev_replace_is_ongoing !=
+	    btrfs_dev_replace_is_ongoing(dev_replace)) {
+		up_read(&dev_replace->rwsem);
+		goto again;
+	}
+
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
-	    op != BTRFS_MAP_READ) {
+	    op != BTRFS_MAP_READ)
 		handle_ops_on_dev_replace(op, bioc, dev_replace, logical,
 					  &io_geom.num_stripes, &io_geom.max_errors);
-	}
+
+	up_read(&dev_replace->rwsem);
+
 
 	*bioc_ret = bioc;
 	bioc->num_stripes = io_geom.num_stripes;
@@ -6797,11 +6809,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
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


