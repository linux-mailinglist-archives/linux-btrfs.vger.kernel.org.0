Return-Path: <linux-btrfs+bounces-4373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A88A8614
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12645283C00
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6014290A;
	Wed, 17 Apr 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IoncvJNJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B031428F3
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364588; cv=none; b=u6m9jaCoLkzRYBOA/lSYE2NFtYx95S3qoUeZwSUJV7RDwIG7HYPqq81OezIUEi/ro/sNT00hQkDl5R+AOT6mRmg5pyTKOZFpQ0SJfxS/Mxdw9jWjHyoL4H2csMTshZTyBpO7RKUZPfko8mCQkY/RAAICc3YiKAyFJjlzVB8u8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364588; c=relaxed/simple;
	bh=KyZvOu16ZqWs/702Es+YMpkmRwVArNyAohDZlUTzrjM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QurJDLddITGph2QpbjJsuziX/nZyGeefOuYHTQy+3RaUNtXhIU+os8/kTKNuLyMDA1fxZjgRGCw04eS167NDti6cW2Q17gmZf4qFqtnYNjyONGS9kguuE4JPJ88+csapKfWHiMMMPxEzSOBMT2KWG/96DnL1sc6LowHAUYxV4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IoncvJNJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-436ee76c3b8so26997951cf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364586; x=1713969386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4u0YJ37MSHkIvUt2B4ttfLT6tgeoVpo4/XTY5Z/Ue6Q=;
        b=IoncvJNJmTQ1isyRvZmIrcnP798GtIJuviOWYl5L6PGubEz/qhigsgI0CiQoro0Kv8
         O4JDf1y/wvItLYNOARZJ3w2JSb3cMLVq+pAmtqrbGz+3sWA+z3+8UreENTKuddy6CqOK
         WDjSNWNPxSkWeoZWlORA3q3+IiQx6FJCV2xTiP24VTSV47D4zpHOy361pNyf90LpUI04
         aIrIV8rEz4g4ImsFiR9JywHO0Pc3DsTcffZ0W30wTLJX98PdBS/LNkpE9gjGngW/U2YG
         53cGXvLkLtG4nurEd4q04FI810ahaaaxCXM/WYS4BPxlo2LcEh5x0RdY4Iwpk/FaslMm
         C9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364586; x=1713969386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4u0YJ37MSHkIvUt2B4ttfLT6tgeoVpo4/XTY5Z/Ue6Q=;
        b=dAybvnDyvIda20VCf6IwBGrY/BtASJfpsaJybKCtPrKWHGD3IJ/CdgQWiYw8RF9s/1
         kFZ2ikogn79k6rzfJP4gZ1507KnYATRtgNPPBVfGhTkDK0nEa3v7gUefHRi8Vn4DpLUo
         nezWqdiqHX778/RqNgpNymZU7SP41/s8avbhOZE2Q8IfA1M1fbidz1rK7kBN1OQLiKGi
         lW407gSmeK5ovn1l/lG4qPvGVNSQQVpJ3FXt8mbyhzGdCz6lkB8mrJCbmeZ+Bi7bctIw
         UJNCoBb5737kI9TokS3SzsJY0sdRTMZlfkdPueBWfYjyPjV/dtp+MhugVuHpzzb+30jy
         QMSw==
X-Gm-Message-State: AOJu0YxVcoTZx7eLVmMbBx1jUcaR08Gmb3A5MnG/DxLtM9r/1hWgu3/m
	PoT4iZqmak6P1kXBtMdxNcXBeYFtfBw9uPE3xAqRdLr4uuqnP96TjDxanZrVtoai/dVe2ojs6tD
	R
X-Google-Smtp-Source: AGHT+IH4iD+JkFUn3LRQ+wjVlMxa9OGSGGJJEVM0kV2LgxTK9EXcylH6/vIZocWY9Wb1kyXA9wU7og==
X-Received: by 2002:a05:622a:254:b0:437:45b1:a3b0 with SMTP id c20-20020a05622a025400b0043745b1a3b0mr5140216qtx.66.1713364586315;
        Wed, 17 Apr 2024 07:36:26 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id f16-20020ac86ed0000000b004348d54a873sm8138648qtv.57.2024.04.17.07.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 16/17] btrfs: push extent lock down in submit_one_async_extent
Date: Wed, 17 Apr 2024 10:36:00 -0400
Message-ID: <24251ec51aaea6cd39b22e3969d4e8e2a878808d.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to include the time we spend in the allocator under our
extent lock protection, move it after the allocator and make sure we
lock the extent in the error case to ensure we're not clearing these
bits without the extent lock held.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3cd092fab31d..a96f68f61495 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1179,7 +1179,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		goto done;
 	}
 
-	lock_extent(io_tree, start, end, NULL);
 	ret = btrfs_reserve_extent(root, async_extent->ram_size,
 				   async_extent->compressed_size,
 				   async_extent->compressed_size,
@@ -1195,6 +1194,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 		goto done;
 	}
 
+	lock_extent(io_tree, start, end, NULL);
+
 	/* Here we're doing allocation and writeback of the compressed pages */
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
-- 
2.43.0


