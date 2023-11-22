Return-Path: <linux-btrfs+bounces-294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D635A7F4E14
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F6228159D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A458AA9;
	Wed, 22 Nov 2023 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VJ0v0Rjz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F061A4
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:06 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5ca11922cedso40668237b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673486; x=1701278286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8iItkIGfxUBmyKnZ9x2I90RbdJJn+uCFaRLMIxu4xY=;
        b=VJ0v0Rjz4x9WU0PlbzSZz4WRvdbqyi+BZgQyK7pM8UN84idDwzE93krVeVNR/A5BX8
         CwMoLcMc/FjyNVmif0mN/egO098sgfKcm0H5b1ycY9OBvuiyMBHkJKr7sbrAMyIdo9tP
         AM41w95vEzmxkg2qHoqZUVKoppLkfVnl4LSEuvHVz0FpJTBrkGBcJFqBx46z07tGS6zN
         QPHovDIZsuNWZq99xUIMuEdGjwWyb8+aRn+K+8lEalqfw9R6yCS5bHt/0FXikVG+JGJy
         EJPELZgRs8L4ZT12ex8h0uwAmuI5uhQ5Bnh8lt2PPH3QvCHgCI6WbFprX617le7kYpEb
         rbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673486; x=1701278286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8iItkIGfxUBmyKnZ9x2I90RbdJJn+uCFaRLMIxu4xY=;
        b=DfQb1KI6ufV2v1aCG5Dtanhy+/ykKRNHZKeAbz1eu2ZBlAPZxbb1MwkFzu3Zv/AVXv
         1E7jX7GrA0qb1y/Zr1V7YzBV9OLaGZpabNnKd3/2sjatNB/bUOsYHj/abpGvn2OJ6bLL
         DF5uVqoUyUH2s8Z7ealr6Dw+9toR8mZsjk9k4zez6N43cj6dOM8LZz55YxMMI9Ogdm+Z
         BS55YllrThATQN2qEIqleVu4niNPy3jiTwKpdnxGLkK78oRKzsK6YbBaJsk8B/i9gk54
         AF7RKhivi5OTmzYvoV/xGEiyy51pJobG4Lo4rYnp0BjfY4YkS65FE3fevQKOMAss+SKD
         PpVg==
X-Gm-Message-State: AOJu0YzmCCj1i19FksuXNJrU6pMCv3Ms/QxSFEppVB0fau5dSD5vQnZR
	pX5GGv4V7QnHs5t0ENyIEeAZ3D2FJP3I/mWv2Ulu9FAD
X-Google-Smtp-Source: AGHT+IEgyp1v00kQ7Oo22YPR27kTP9J08NYKAwJhM75B/7z1zTyVBEYmyKjCoM8YaePppjMcvcfjiQ==
X-Received: by 2002:a0d:d982:0:b0:5ca:c101:b222 with SMTP id b124-20020a0dd982000000b005cac101b222mr3146652ywe.42.1700673485850;
        Wed, 22 Nov 2023 09:18:05 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a190-20020a0dd8c7000000b005a8d713a91esm3813087ywe.15.2023.11.22.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:05 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 03/19] btrfs: set default compress type at btrfs_init_fs_info time
Date: Wed, 22 Nov 2023 12:17:39 -0500
Message-ID: <7d94f10916f221daea6257896545a7488bf8f67e.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new mount API we'll be setting our compression well before we
call open_ctree.  We don't want to overwrite our settings, so set the
default in btrfs_init_fs_info instead of open_ctree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 84a5dc0d984a..347a89f51bfc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2799,6 +2799,9 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
 
+	/* Default compress algorithm when user does -o compress */
+	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
+
 	fs_info->max_extent_size = BTRFS_MAX_EXTENT_SIZE;
 
 	spin_lock_init(&fs_info->swapfile_pins_lock);
@@ -3281,13 +3284,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_ERROR)
 		WRITE_ONCE(fs_info->fs_error, -EUCLEAN);
 
-	/*
-	 * In the long term, we'll store the compression type in the super
-	 * block, and it'll be used for per file compression control.
-	 */
-	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
-
-
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
 	sectorsize = btrfs_super_sectorsize(disk_super);
-- 
2.41.0


