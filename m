Return-Path: <linux-btrfs+bounces-11349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 354A2A2D483
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2025 08:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2EE8188D5AB
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Feb 2025 07:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6548D1A3BA1;
	Sat,  8 Feb 2025 07:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPZzGdsH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274B23C8DA;
	Sat,  8 Feb 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739000321; cv=none; b=a9ahV2zIr9Avhm4vEmW7FNHeoMVon1AoyCx5MICevCBMC/6+kYG0TSBtUuUVg4fA4MlVJDtGkxgpQ0y5XKVaa8/yOsftVVIhepbG++H3yzuHHuZEMkT1bX+hYke0G2MECpQAcvZlF9PeojnQe29ZhS/lcdKigARsJMxhoSGpk58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739000321; c=relaxed/simple;
	bh=gJwHQ301n54yDLIUCwOZAzB5Xz3YPPzzFr+9JQJ1TAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=huTn3VRGp1lWI9X9fjwIFMDzhcUdVISJDkvKlxQtGptO54Mhl22YaoTa9twKooRqYQx5kYnnwltfdyPTBHY4/PVFkD1T8yM7ChLfG0claaKXTNP/mjRIC7wxtRiR3/ppLqKz+IGFIYz/VFpm3dbfGdalSvfPc92pQZ4p236hgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPZzGdsH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f74c4e586so1270145ad.0;
        Fri, 07 Feb 2025 23:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739000319; x=1739605119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z54dLS16FfQUBcnzyVaUR4t6WdUrnvHtbPjH8Gr7x9s=;
        b=gPZzGdsH2YfvPCiwmbcQZ8YqzukbKFmVil+voSVU0u8uuGH3g7ZYkQKzhTbsFgY703
         Tb4iXcDVRumb+V1LdsLv7S3dpZyZCJHULLRzpn1FJt4f6GKbKdsJaKkQunDFICFNA9tH
         YtvXTfhCOhR1NM+h10lyn2Z1E6ujurMqmlJO6TbSHfnZtlzLhUn+tKSdX/tMa3h07usF
         IVuSOu1YMOL4WBiL+mY/jS1bEl/2uMX8ld8MCIAIwBr5/LrykONivESD8UPExvgj58Ob
         DI7zAZN7kCiyo0IyQbsnKOWiGiFx3KflpaZJK6tRK/PnwIzMi8SPnsaWS4KMtEZTfpr9
         46Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739000319; x=1739605119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z54dLS16FfQUBcnzyVaUR4t6WdUrnvHtbPjH8Gr7x9s=;
        b=e8Z9zzVoIfDQCyn2FM2W4Ww0BvCmjcDclrLTmDH1C+qufIYFnSRZSkAXxQIKXyTu8G
         kUWliZYkebkQAEKhT/53f2GK44j+/FEMg1ykN4emdML2FfjXG1oxOlUoeiYNtwii3JrA
         Q3EcvigWkfRwafd8z5DqkfzXRLC8hf51CZ/hbV2RPHey78EwuFuaiIKLeSBDqvXGDln3
         OZAu1XeDSXr8wc/l99KJmtKcWGMQyV5zHZaDeiEYbgHmbxXAxbhbModssCbbptltLyLj
         QA1lI+rFQsO81Cm9s50FNGFAsZnugI2thM5XqRfe0/jh3h+eVatCpdmCaNFCcu9E0dfO
         s3RA==
X-Forwarded-Encrypted: i=1; AJvYcCXNbcZZKLKppKWsWSu/fRuNZHgW4Aaph/pDsW2Qc/bRos5GLlQq9mt68gEJ/c3R0J8lb1WbJdmzePSW7A==@vger.kernel.org, AJvYcCXg+0VAB83JWjxCIFIjX4OgK20GIpqHVxjcgd+qTqo8lRFOD0O2twWM0CpG8DrWzVBHy/YuPkIw9Uvw2+ux@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQV2G87MEfzbc53VrPUhTIYh1UqlWXXROxUUjYVa3bnQzycEp
	rXrVKXurO0pDfMiZ+j8Q15Y25GsOT+6MemFf9QpnX+KUNDKqGIeO
X-Gm-Gg: ASbGncuUVlJ69wHzCE/faQcTs7N2ddujEOCmacf/ghctcZ1AdcEEOm9AQqFwkxloPCC
	vDQay82jBKeiax/R3L+GvBANFDObdBRWNFNu/P2XM7pMCkTdvkO37mJsu/eXjoDn7vh+tvovnBL
	Q6DDhifDRngcoikgDaiauPVvh4YBz9CYioujBFNi2odM7IwcFUqE61N9vRzExTDoJzm7vxX8aQy
	lk1ZysoI94cFJDAiH19MMWwjdSFrt2QAlZSVGwtHd3DoPRn0oBVsNKyHUhcFS4wKIdKLJxv0/rK
	K22emhXBQU+/Sf97Y9ao
X-Google-Smtp-Source: AGHT+IFea8Qp3ADaO0op//WS9gpLy5ge0G1SmFnomVBxwldU/I/LVQjgkVNEAP78TLLvMrEcaMWiGA==
X-Received: by 2002:a17:902:d589:b0:215:9894:5670 with SMTP id d9443c01a7336-21f4e6b2660mr114185755ad.16.1739000319256;
        Fri, 07 Feb 2025 23:38:39 -0800 (PST)
Received: from localhost ([124.127.236.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c17csm42017115ad.183.2025.02.07.23.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 23:38:38 -0800 (PST)
From: Hao-ran Zheng <zhenghaoran154@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: baijiaju1990@gmail.com,
	zhenghaoran154@gmail.com,
	21371365@buaa.edu.cn
Subject: [PATCH] btrfs: fix data race when accessing the block_group's used field
Date: Sat,  8 Feb 2025 15:38:29 +0800
Message-Id: <20250208073829.1176287-1-zhenghaoran154@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data race may occur when the function `btrfs_discard_queue_work()`
and the function `btrfs_update_block_group()` is executed concurrently.
Specifically, when the `btrfs_update_block_group()` function is executed
to lines `cache->used = old_val;`, and `btrfs_discard_queue_work()`
is accessing `if(block_group->used == 0)` will appear with data race,
which may cause block_group to be placed unexpectedly in discard_list or
discard_unused_list. The specific function call stack is as follows:

============DATA_RACE============
 btrfs_discard_queue_work+0x245/0x500 [btrfs]
 __btrfs_add_free_space+0x3066/0x32f0 [btrfs]
 btrfs_add_free_space+0x19a/0x200 [btrfs]
 unpin_extent_range+0x847/0x2120 [btrfs]
 btrfs_finish_extent_commit+0x9a3/0x1840 [btrfs]
 btrfs_commit_transaction+0x5f65/0xc0f0 [btrfs]
 transaction_kthread+0x764/0xc20 [btrfs]
 kthread+0x292/0x330
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
============OTHER_INFO============
 btrfs_update_block_group+0xa9d/0x2430 [btrfs]
 __btrfs_free_extent+0x4f69/0x9920 [btrfs]
 __btrfs_run_delayed_refs+0x290e/0xd7d0 [btrfs]
 btrfs_run_delayed_refs+0x317/0x770 [btrfs]
 flush_space+0x388/0x1440 [btrfs]
 btrfs_preempt_reclaim_metadata_space+0xd65/0x14c0 [btrfs]
 process_scheduled_works+0x716/0xf10
 worker_thread+0xb6a/0x1190
 kthread+0x292/0x330
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
=================================

Although the `block_group->used` was checked again in the use of the
`peek_discard_list` function, considering that `block_group->used` is
a 64-bit variable, we still think that the data race here is an
unexpected behavior. It is recommended to add `READ_ONCE` and
`WRITE_ONCE` to read and write.

Signed-off-by: Hao-ran Zheng <zhenghaoran154@gmail.com>
---
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/discard.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0a8f7d92acc..c681b97f6835 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3678,7 +3678,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	old_val = cache->used;
 	if (alloc) {
 		old_val += num_bytes;
-		cache->used = old_val;
+		WRITE_ONCE(cache->used, old_val);
 		cache->reserved -= num_bytes;
 		cache->reclaim_mark = 0;
 		space_info->bytes_reserved -= num_bytes;
@@ -3690,7 +3690,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		spin_unlock(&space_info->lock);
 	} else {
 		old_val -= num_bytes;
-		cache->used = old_val;
+		WRITE_ONCE(cache->used, old_val);
 		cache->pinned += num_bytes;
 		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
 		space_info->bytes_used -= num_bytes;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index e815d165cccc..71c57b571d50 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -363,7 +363,7 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	if (!block_group || !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	if (block_group->used == 0)
+	if (READ_ONCE(block_group->used) == 0)
 		add_to_discard_unused_list(discard_ctl, block_group);
 	else
 		add_to_discard_list(discard_ctl, block_group);
-- 
2.34.1


