Return-Path: <linux-btrfs+bounces-7904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6822972B47
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 09:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04EFE1C2416E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 07:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3C181B86;
	Tue, 10 Sep 2024 07:55:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C58180032;
	Tue, 10 Sep 2024 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954953; cv=none; b=CAa4tqlUsyVTtnNiynUVVB4OuaH6t+v3hm0OMeES96SHIkH/icHdUMFSWtdisDwJ2DKapU3gGPbjkOQsDG9lYrO9Aqr7m+R6R52ME937xDiO/8IBbGu8zvEQ/saqJkGRFldivjD8sTQ6pe0IGkcOVRM23ucTFaON5sjcwuQ6w+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954953; c=relaxed/simple;
	bh=NSfkCXmP8UOuYBRg13+Vub5tUvvwBF9eyr5oi3qcYsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmuKYiD9jsH+kw61x9MRCkJRsMtPvEdcdOU4n16iuCKgVHoocUWpq/LpMo44o412BCJtSi8cGeDK8yOz8y1SA7u7LXovMQI9TCry3xzcRxgpi6XykVrFrF9f9W5VCuUtVWmaA6Ejms3lxbwaxVsrIfoRApjxFsnzKexJUNXuzII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-536584f6c84so5053531e87.0;
        Tue, 10 Sep 2024 00:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725954950; x=1726559750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dw5YeTlm4zhPLP18WLBdD2dIrDxb0xf1POdjWouS1K0=;
        b=qhtPezVzwaXD2FmQPXSghkusHUYuD7qk/ZLFu1x67QowNAbwYhbmrhJr0dp+s/axb+
         veuDlGOgSqWQpk2KrIysbyEMscrUypl13ULZ7zkQSGqZcVt14wpHQoO5+pJCDbXSLVTt
         MAJUihLI54mI6cR6wvrCEIr1y8ceMq/+HB7vRkkrus53CfZwtyrgH3usDu2gsTtL/c6k
         jkSkpskiSBoO1CsYpIrR3wJQF5Mkg1ds6NgAdquZD5uzjC38BtIeBEjQcCbFCMA9b4Ji
         KpkHfRofoWImGFR4gLh97XuVK8bMaQqHjvduyRPKhCTBKUEC345kryyhNwYTFP2fK4n2
         mZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCV+Zp4LFdLeSVkjz3meRytvTFEscGYGtuIMqkPe/FAtnyTa1CNCPFtDZLovqV+ZyJW42/ANEhj1kl8jdQ==@vger.kernel.org, AJvYcCXw1Bc47FUV7upTtZq1Mgk6mN45mujHpfxDAuPO7fudckWDKOKc28eGHaZQjuJb4LUloeWUQoy/VMjWO4jp@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxwiYuZydxTQ8dPuzuNRgzp0u7+vqjfR+/FGoTOiVgRFmc+tO
	ZGiU/TFaQ4k9gHKWYFxl7fkZ/RLPOhbUb5Fubm6yiprNbmWwD4sA
X-Google-Smtp-Source: AGHT+IElSanQ2NlqBxxpMquRqdOdzFMzHXAbQJbqrZOea9u0J5aVMbrpBu7rzvmN2NpSz7waYGuOrg==
X-Received: by 2002:a05:6512:2388:b0:536:55ef:69e8 with SMTP id 2adb3069b0e04-5365856ca37mr9019415e87.0.1725954949171;
        Tue, 10 Sep 2024 00:55:49 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7178100fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f717:8100:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb323f4sm102005245e9.12.2024.09.10.00.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:55:48 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH v2] btrfs: don't take dev_replace rwsem on task already
Date: Tue, 10 Sep 2024 09:55:37 +0200
Message-ID: <20240910075538.15884-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dd0cb649510537a495bc64d91e09da5a8119d2e3.1725950283.git.jth@kernel.org>
References: <dd0cb649510537a495bc64d91e09da5a8119d2e3.1725950283.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to fold in if we decide to go by pid instead of a task_struct.

---
 fs/btrfs/dev-replace.c | 4 ++--
 fs/btrfs/fs.h          | 3 ++-
 fs/btrfs/volumes.c     | 8 +++++---
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 604399e59a3d..a1efb8de8170 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -641,7 +641,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		return ret;
 
 	down_write(&dev_replace->rwsem);
-	dev_replace->replace_task = current;
+	dev_replace->replace_task = current->pid;
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
@@ -995,7 +995,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
 	fs_devices->rw_devices++;
 
-	dev_replace->replace_task = NULL;
+	dev_replace->replace_task = 0;
 	up_write(&dev_replace->rwsem);
 	btrfs_rm_dev_replace_blocked(fs_info);
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index cbfb225858a5..a30978f29a59 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_FS_H
 #define BTRFS_FS_H
 
+#include "linux/types.h"
 #include <linux/blkdev.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
@@ -318,7 +319,7 @@ struct btrfs_dev_replace {
 	struct percpu_counter bio_counter;
 	wait_queue_head_t replace_wait;
 
-	struct task_struct *replace_task;
+	pid_t replace_task;
 };
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995b0647f538..c3f53a59cbf3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6480,7 +6480,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
-	if (dev_replace->replace_task != current)
+	if (dev_replace->replace_task != current->pid)
 		down_read(&dev_replace->rwsem);
 
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
@@ -6488,7 +6488,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	 * Hold the semaphore for read during the whole operation, write is
 	 * requested at commit time but must wait.
 	 */
-	if (!dev_replace_is_ongoing && dev_replace->replace_task != current)
+	if (!dev_replace_is_ongoing &&
+	    dev_replace->replace_task != current->pid)
 		up_read(&dev_replace->rwsem);
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -6628,7 +6629,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing && dev_replace->replace_task != current) {
+	if (dev_replace_is_ongoing &&
+	    dev_replace->replace_task != current->pid) {
 		lockdep_assert_held(&dev_replace->rwsem);
 		/* Unlock and let waiting writers proceed */
 		up_read(&dev_replace->rwsem);
-- 
2.43.0


