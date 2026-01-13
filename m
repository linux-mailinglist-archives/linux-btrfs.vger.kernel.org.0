Return-Path: <linux-btrfs+bounces-20434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8CED16D43
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 07:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8337300EBB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 06:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293C369213;
	Tue, 13 Jan 2026 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaRgUPNh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5187F36920C
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285520; cv=none; b=NvucluU7TUsX+Ad9vti2zN+ATfYhFmS+wjORnRw6/BUv9cSb3OJ7zQCSTA5gVYzAGaOfrIYS/5/eupJ6mwAQeDxseJsrpW4wSYsbBL5Yoq6Kxb1UnaF8kxXfLqPtavaa09zdw8gG51oM4LGXLq2DgWwTMLdsAHLwLsot9azWbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285520; c=relaxed/simple;
	bh=EitCuwBZRjAx7BYTF1ket2mcM8CCvpc4hsQp5gL93rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ0wvDQzmmF6hJ5pvc7IAs/psGufCjJbnzsGQvdIafUFV+iKxGZOT5xTfofe6bojo9xESVxn4D4Kgf8R88cbQ4tARQ6bQy/m4cXYZ5eLtr6UXbn7QFe4cZb4nNzeeGL75W1FOG3kLd/E5WSeXU5f90IqLFtLJEQZM9jeIbAIy/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaRgUPNh; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-34f634a01e1so529335a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 22:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768285519; x=1768890319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDxgHqTSmpKdgjy1BjTvFSDrkAUs4gxvLcTcBcXDW50=;
        b=kaRgUPNhga93sN0xUtlB/yjJxudppmOTL1TAnyujGWXvVGgRpSWHQj2JDYWiD54wW3
         W2bogHIZFYaIUWp21l/ZCO8y6peAZFTakNKf8wT/WiklFm0/Ff91ncYYrku8Iahh2E8d
         sRK3nKA4E/+AZo9xciGAmNjKPcx7d1RScKm7G3ko7NmDgm/ArUEzre7i7OwVZwcuufFN
         yy9+34d2K4vTLePF7XS6I26OeEdD8PA/9AUyn9Ac90Nn+VstQSJwP3pxkIK+Styif5a+
         xXIaFObuLrlJLU7xa0cyOsJplofHjz+Xxl6I2ZfU/1vIOXmma9dMJx7Emy9fdM9brGzH
         9yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285519; x=1768890319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDxgHqTSmpKdgjy1BjTvFSDrkAUs4gxvLcTcBcXDW50=;
        b=NcmMxoRlYHyfX8YqHzoxjfsE4plWwqFDXMZExE9OB6+ppZq79u2qoF1Nx8WmN8Lgz1
         ZCHNx5Xcx1QRNDoaGHx8lGiisRweZbRbNlM9bHGZxCsMmoy7HZjejWLTsS3Wp7cCwyZT
         WDpajy0OJJkIPSmpMkDARx4OU9WD0mJ8wMbIbPxLCdo6JI7lldetiqfgRktu0wdfLASw
         XesssySJ9W9aaZ9NDbCkKTY+TLxqpjloa0XCarBq5LGfQRz46DuVJu5z+tpiKjbTlx/V
         O9nBieaU/GFQddsCebz8psshMKgdtamRONPkrRUru4N+kT5/6goWF1LmyEmGgPN06b/K
         EYkg==
X-Gm-Message-State: AOJu0YxdXmySIi2DM8ToqS3dZ84ZiCKmCr7AD7QsE4m/VK0X1ezQQoDz
	4awzMPV9quht3Kx73EjK215VCztGIoVkP0OdRDI06uIQpJZaMmoybwe8DO/TtuaaQLjhBQ==
X-Gm-Gg: AY/fxX4Z71fV4yoDSSCCojoTj8WgdxcDT31qhCeYEe0Eh/TeRcdJOQbSNyEFh4moFVn
	IhSaQra5Pu0vIiWz58J3/f8PakL8V1OeAlOJLtHmGFLNnh0OybRl1AeOwyEzRW6jUgHFYF3dKcl
	/HlobM+c/zyqQCqemMujFVF+7JR68FnMbiKZ+x9SALP+nX8WHtq5uI6il6nuyEn+9gVMQO58DgT
	EMXadAZMq4DCEGcV/CIqlNrxdYVi1UsupI6qqPcebijfyPnr/9UZqQ1bMUwD6ggQpROOSmTXz5v
	9nPLmhDM+iRFHafkH/n42sjCe3WGsMjznxEbVCGz/R2NGfdvY2NuecR4Vh7cAGnR51NXBjFz76v
	uofJ6xTb2m0393BJ/bYQRFzUvCAaFdvZNgzRpbqfz0hyq+9sjFutssYZO9RbJcQt0pitoXgyRJ0
	O2hOKQd3kRu93g8gOBAprwxnviuK84l+s=
X-Google-Smtp-Source: AGHT+IFk0CNVUkKgP+WmBWeAast0UROd6LV7DRDAEGsHsE920v4e6j29wPxOhGPlOsoW0qBMeWi7+A==
X-Received: by 2002:a17:90b:560b:b0:341:a9c7:8fa0 with SMTP id 98e67ed59e1d1-34f68bdb6efmr14373494a91.4.1768285518653;
        Mon, 12 Jan 2026 22:25:18 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fed231fcsm419971a91.5.2026.01.12.22.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 22:25:18 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v3 2/2] btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
Date: Tue, 13 Jan 2026 12:07:05 +0800
Message-ID: <20260113060935.21814-4-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113060935.21814-2-sunk67188@gmail.com>
References: <20260113060935.21814-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the filesystem state validation from btrfs_reclaim_bgs_work() into
btrfs_should_reclaim() to centralize the reclaim eligibility logic.
Since it is the only caller of btrfs_should_reclaim(), there's no
functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f0945a799aed..9ca4db7eebfb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1804,6 +1804,12 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 
 static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return false;
+
+	if (btrfs_fs_closing(fs_info))
+		return false;
+
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_zoned_should_reclaim(fs_info);
 	return true;
@@ -1838,12 +1844,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(retry_list);
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
-		return;
-
-	if (btrfs_fs_closing(fs_info))
-		return;
-
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-- 
2.52.0


