Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A4D14D405
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 00:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA2Xuo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jan 2020 18:50:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46235 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA2Xuo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jan 2020 18:50:44 -0500
Received: by mail-qt1-f194.google.com with SMTP id e25so972376qtr.13
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2020 15:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4DYPxp7Hw6x33KKjCGXPpbnm3Zr8YP9L3ygx5HfFjjk=;
        b=OL77LzEGbj8Lp3F9kwDCCjhwZKYnx86OSSSMqEYHgs1B47RJwY+rMUGtTz9NdAU64y
         qrEKuv6qe05lyXbAGwOtvbi26Hk/VGGzfSq8QDfvr4v8rOyI4z4tm/G5XHodijTW9S+7
         UxjvgeE11yK2xZ87AAloFOA19uuzu6fDlD0IwZDjmDFcs1CuprSGEpntcucRgBVSfVm1
         FqXBceVuMML5Sm6Sspj2gxTbtKdop+MIQGSE+Gb7ptn9kXynGnZcc+UODa2Ci2kHVhIk
         eePbgFTIhH8qad88ZWDyoOUMXTg6++YF+SwFII57NN7t8nVfNzaEN1z4giDpsQTSpeFd
         jbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DYPxp7Hw6x33KKjCGXPpbnm3Zr8YP9L3ygx5HfFjjk=;
        b=MV1GD1ubXlsqcW8E7hWkSHBJ7zGRfjeoMXX1ThqvFO3hX8t11LaV2S3S5UlC5Bz8EW
         Q71QHZwMROqIk0bYJSI5Tt9LryrUsZW5o14y+p7V6SQ8WxVtddPUYuaN3H5tthyRFoP2
         c4Se1WIupXpG1/ltjk6mNM3ki7BX6n70n+kWA3D52tkWJFYngb3wVolzs0W6gpNce15H
         Yu32CJ3WeWYdDVzKjhC9mj7YKTASAfnLBK18Dmei1UZRnsHj8dmeGWUOtInufsTndc7h
         d3u+tgMiiFFasRF/APDnvKBKUflSsYxrmt74DySXmWqdNoFg5IOZG7YkmOWZ6UINrMTP
         Ztdw==
X-Gm-Message-State: APjAAAWVMyIF1BAJiz8+9m/5CUrZ0H/vpD/Cm8Re7q7BojPcYTNjveE0
        ZijGCYbbe/ujAnh8P/EDYpv9lpIErttPPQ==
X-Google-Smtp-Source: APXvYqwJz7RMpkpxCxMV5qAJoXQvBrVucq22rCyEivTsc4mRh8IrSU7znnnf9zlP3SuqPAkcGeGuyw==
X-Received: by 2002:aed:234a:: with SMTP id i10mr1949891qtc.155.1580341842714;
        Wed, 29 Jan 2020 15:50:42 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id p16sm1803413qkk.12.2020.01.29.15.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 15:50:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/20] btrfs: use the btrfs_space_info_free_bytes_may_use helper for delalloc
Date:   Wed, 29 Jan 2020 18:50:13 -0500
Message-Id: <20200129235024.24774-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129235024.24774-1-josef@toxicpanda.com>
References: <20200129235024.24774-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to use the ticket infrastructure for data, so use the
btrfs_space_info_free_bytes_may_use() helper in
btrfs_free_reserved_data_space_noquota() so we get the
try_granting_tickets call when we free our reservation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delalloc-space.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 4cdac4d834f5..08cfef49f88b 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -179,9 +179,7 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 	start = round_down(start, fs_info->sectorsize);
 
 	data_sinfo = fs_info->data_sinfo;
-	spin_lock(&data_sinfo->lock);
-	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	spin_unlock(&data_sinfo->lock);
+	btrfs_space_info_free_bytes_may_use(fs_info, data_sinfo, len);
 }
 
 /*
-- 
2.24.1

