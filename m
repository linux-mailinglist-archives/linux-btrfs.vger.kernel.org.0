Return-Path: <linux-btrfs+bounces-15635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6739B0E0B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 17:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987AA1C81F4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BE3279354;
	Tue, 22 Jul 2025 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksMhCPJX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3BC25C833
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198735; cv=none; b=ERz3FQ6wQrRbi0zoamFUvOS6xYciXLgWDQYB4pF4Aw2rcuX4qdrMYwhp3tAuocjT+V69xfj4d819z/V9qwMnLctD5vPPCagZRokddMvYqYzJ1p0OoRzIr2Ep/Zg6/jm906x7LSl7jogWi+pe0NVpCuR5ZbD7XVFCNJx7uMJb+G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198735; c=relaxed/simple;
	bh=cQvmm20PL4WU7eYi3Lpn75hnwIVGWs2/T5ly1yGg2oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UNh6Ku+22iIY0xr9uBYltzV7MAfRnw5G6moV650p9ROxdrmKIt57bUIStaA4YWXssx3I38GQKrmXS2J3gTtHeCI1DVbfwnaO/Z9NQ6mm+MnAB/ih4DUe/YGTf86Na3hoPTK66dv/2icJCDEcagDzQ3ktYvbQynD79gcBpurIcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksMhCPJX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9ea8d08so48465415ad.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753198732; x=1753803532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8ChYR9/cHdi3idH7sdst8iKBJxntPR7hXkywT/NShk=;
        b=ksMhCPJXPTbtk0Zn2hjND08hLc5KgqlH+1zY4OrpRz3jtm+74KylVbOsHXl6d1nuRF
         S/bNpwKNdwyanQD5X1SvHxIEXogCCvz48OMGvKfvtc0Nk6GTnbDXpFh9YLaZKi+bbBrw
         AfEyMtDHGjdn/yDpYxvW3SjrvG79gio+KDzQwgbTJ/QFS5+sV5OiH0k8K7T/k0rnybXy
         2NBw0OwiCBhyHyxL4evmc0hW/CQ9umlajXuLzEawUMrbsW0CyslI2Jsp8WuR9gyxhDZ/
         rK5/Os5aQUgb9upJBsLwSE/ePH9IAYEKT/V70rBi68iUASgNzPc15X9GdG2d3n2E9WS3
         LMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753198732; x=1753803532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8ChYR9/cHdi3idH7sdst8iKBJxntPR7hXkywT/NShk=;
        b=FiPnzQkpPPuIHGm3gZPvn0d15c2ZelPDv3rQQx7Paa6rrqblJIpynFgc9wZ8REB5Tc
         PBR5whHHTV5h5AIl4BDilU6IYlyvK91e9Swid4UwoJeTmwWh4OrDrZGuFlU+k8GpL67V
         rNmvz1bjaLlPLBgkBtcZHC1QnMFPc+OFl9THq4MqlKwW/Zl5GDrM54mEqYrekFe7KgpT
         frFg+ThjrRVqP3ZGFLjHa/PyzTI32UAqx0J4mebecyDqJAf/EXExVIl+TQVmyX3ZYhz/
         xDU6QmO6trdq1ZZZn4BqLzoSC6K2O9ux4HPWKQ20kKfRwTfyP1kHz5Oz5ertzehT9a2X
         BmmA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Gz8Cap0oXgvMbWrMk3paAusBFlPQ1f5JwcTilxbrDqlaZ/c3rByr0UWByj/rcVbLZFj3BLDGgvT5vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb46Ae0mKSOklO6SrlsuDkavdfpcW7zeWZn9zHzGOT0JSBqthK
	Jv54SVJii5c1rOgNv9k29NDXrIRsgtUAFHWCo5u3WtbuMCZ2JeWteJ0E
X-Gm-Gg: ASbGncvqEcO42LKTP49mADxUtDnbNFE1Jgsa+6iEwepWdjfPacMHXhawh71w9beZiDY
	GoA3jECrhS/rxpXSnsVMcK4trbvXZT4OeKn39nhMpGO+FYq49vtVxl2kMzslvETYnGLgsWbE4/5
	zECwVz7fgVvHPrSe9o8C2rsHaiHqD+xPRFi7aMwLo43wm7xkU4zTZpmHaK0PxLGg6gooMHu0Zgd
	qJhFA22qGgUf029qiGlYRZt6CQKh59iC+R6BpK9Ercji/LQMbWIkIhqplN2C4Tn/w+c7uBnaMbk
	4eU0k22B/cfZeHHKVBDN/oH3aXHyUK44K06Sn83YuOYSjISJC/PilxQUjQBmu7WczK+AEjh8vau
	rpizMnBhlyh6wav3XvrAConoFnMZtqB7ESv2K6gi3YLb+CSAcj40=
X-Google-Smtp-Source: AGHT+IFPZXCGvUeF/BerA3S0YTCxYhB0+B0STXh8/+9Sif/uB5jm+SoZHrR6a/P5gHDd5FVO3Gjz3g==
X-Received: by 2002:a17:902:d603:b0:234:d292:be7f with SMTP id d9443c01a7336-23e24f4a936mr359873055ad.31.1753198732116;
        Tue, 22 Jul 2025 08:38:52 -0700 (PDT)
Received: from fedora (120-51-71-230.tokyo.ap.gmo-isp.jp. [120.51.71.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3c7esm79149575ad.45.2025.07.22.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:38:51 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	johannes.thumshirn@wdc.com,
	brauner@kernel.org
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2] [v2] btrfs: Fix incorrect log message related barrier
Date: Wed, 23 Jul 2025 00:38:37 +0900
Message-ID: <20250722153840.5620-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

Fix a wrong log message that appears when the "nobarrier" mount
option is unset.
When "nobarrier" is unset, barrier is actually enabled. However,
the log incorrectly stated "turning off barriers".

Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a0c65adce1ab..51b910e2774e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1453,7 +1453,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
 	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allocation scheme");
-	btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
+	btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
 	btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
 	btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space caching");
 	btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space tree");
-- 
2.49.0


