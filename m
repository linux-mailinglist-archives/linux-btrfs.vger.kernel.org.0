Return-Path: <linux-btrfs+bounces-14170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D5ABF126
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 12:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EF61BA7EBD
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCBF25C6EB;
	Wed, 21 May 2025 10:14:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A49253F3A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822458; cv=none; b=jeEBU/crWuOX8PTGgYRhZpeqj2tROplEGzRoC+PmR0hValBzQfeFoHsU2Kggnn2SKuETBvgzpv+87jkDupu5thXY+om/rN8rE64msX9JNr9pPLCpg8MtrTg1nbAB49XiSakfTMhuux/n8aS3NyWCJAe5wEHMKhWt4dkn1/SbnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822458; c=relaxed/simple;
	bh=if7vrJmg7RJQwsbrehOE2HiMrB4fw/kxJ7nU3G1l31s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpWvC20k2g6C/f16jEtZS81zqEUINfJEM1WifwuxSgsFi7SQC4GrPKrZxbaIyicdGDjYDlyUKNDb4AP4VbdT6B7cQrumNE7ZuIxp9U9Pq8WgldBigNAd6Ahb1K4EWamP/ah78mlFsQ870dBXCa1KXkPNcLI2+peZbpKu2UM0Sqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so74285995e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 03:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822454; x=1748427254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pdh1/rMS33X7wYBwz7Yd2o6SNUL5w1N7TwVmrKtLFGI=;
        b=j9qVaft8Pj7sTjgB33jSt2449wcRnup0iWD3R8NoktDEYPlCMvVSvD2dv+MEN0sFwG
         q3jUCXa5La5P8rRIhM+iBYvNqnsC4Ihhg/lOFigI6/TlMqz80QiuEDZftI1+Qr0iBvmZ
         jccB8BkZaEzKJ20LopwynikI0mV9LIWvfjgclihgdaSkgOOKT7YfKhurJJgG0povxe22
         hw/HSu0a07b64i9AHU2bsMSMVXLeaQh075o2+Vk9W7rJSNbXVnBYfCkLrU/DvshuXhTw
         f+CDvIvDE1/CI4J6NpAo9W5K08WV1Q6Bn4ksLDxL9mWJUzkNR7vDqW+UZe72QJE6hl5x
         AzrA==
X-Gm-Message-State: AOJu0Yzj0YB4PiHskxBA2o6Wcn21N2vQDIBUEw8G9kiI4JC2xm0HBTyI
	8bYwg3d7pGfCTiXsRD3o1QbsXuOIkpD/y3kegkMt5ApKkDa4rVG6ckbrwOLPn7as
X-Gm-Gg: ASbGncus5Dlc4rqbMZH9K2J17uKfw5/aHU4axrcM9xwQerCE5JjtlBrnljJ56FGpX0u
	NOxUmJa6iVTTKlu6NNeFpIQ6u/OWuLBCLrnTe6OF/OhWszFizH3LCmzE7qgDbDO715e/U9ro/e0
	CJ9LynMmfxdStK2HXqBe2uW2OrnNQoiGv2uDUOPpgDJMAcwthOIxv3AovPQ5l13OeDVsWNwrEMC
	E1EQNVAsKmc+7ivgL7dOsOKsqbw1pf1JY8jfWT5NV8b9OrkK8ofV8KO7Kq7axzGMpE/Z2e2mTMi
	Mu5DLgfPDp9/ZB6+0pEGb79VaSoYwOMp23dypRYVqM9vRjODw2L2UrWN6Aego15EnvbEfB/LnZW
	oP8ffIURm5eOytWoUfPgeRJb9sd8kCjkAjQ==
X-Google-Smtp-Source: AGHT+IHtOOLcL0pb1gPFxvKm5PKycJBR0i8ApHGq58dqEZK6aCOPAMYDLeuBVXCEQX5GCmr9Ic+X3w==
X-Received: by 2002:a05:600c:3e0e:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-442fd60a57cmr194498715e9.7.1747822454226;
        Wed, 21 May 2025 03:14:14 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7057400fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f705:7400:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-448ba3d8facsm40069565e9.6.2025.05.21.03.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:14:13 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: make btrfs_should_periodic_reclaim static
Date: Wed, 21 May 2025 12:14:05 +0200
Message-ID: <68089488d00605df41b859b5fdadbcf8f2fa6edf.1747822425.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

btrfs_should_periodic_reclaim() is not used outside of space-info.c so
make it static and remove the prototype from space-info.h.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 2 +-
 fs/btrfs/space-info.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d9087aa81b21..23685d6e8cbc 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2139,7 +2139,7 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool
 	}
 }
 
-bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
+static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info)
 {
 	bool ret;
 
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 92b7f5e2b850..7de31541ab45 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -306,7 +306,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
 void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
 void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
-bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
 int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
-- 
2.43.0


