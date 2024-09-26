Return-Path: <linux-btrfs+bounces-8237-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8F986E33
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB0E1F249DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036881A3A97;
	Thu, 26 Sep 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAwNF9G3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32161422D4;
	Thu, 26 Sep 2024 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337048; cv=none; b=GfoUwMWzrYx7YIEh3PzLcoVH1VpFiFpH5CaHLf02cnGL4skyNouVharzbpuYSbqa4k2H8nUsvdSNXIq++fYIcDLhEbXB6Q1kVJeYm3t9w0Su4D9tEnNlk6d0Uw6L5TESR1VwpDANA1SCkD2yQEUz6dXrMHOzQpbHeIONkCmfUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337048; c=relaxed/simple;
	bh=iZmqX7cYZa5BDpJwqyTtwvsYmacCypWtpX0oana+mck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouiI5ZPTEpIMHhKlEcAbGTvQhQUi8q147ow2KLLOi4zJnwJZMBAy6ZTG+AOeJ3cQZT5sCaypeDhE2Avl0lpwRRPfBFKZCqCGA8WN+TNy3oCbhY1ABgwiDizeYwz80ReD575n28gklnv2wMqqiSBGpTDfVR366PCo9PnnqpBqKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAwNF9G3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so329639a91.0;
        Thu, 26 Sep 2024 00:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727337045; x=1727941845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0qzff08z3q5a8E7EP1BIypHJUEty88aRUrntwACuH0=;
        b=AAwNF9G3aI1YUHedmfRNaAV3uN031detsxO8p1kqqoCunozXMkaNlpMJ/89iILire7
         kVzTIatlafl5hpLMKiqV8bkXpevJuMTuYcLy9Kp+6b60m4s9gAfsat+j7FZ2+2dOyKBO
         Guu90Nr2M7p/6CgLq4AkxdNovfiviN93ycmWllkYyK1wykHKLqAh52g74Wp53r2A8Ue+
         xXkh4D7+/cMpHyiY5DnXXxigh8d9yh3zyn5qdZObhg9krufgxcoX5AUqiidyT9bCUe5Y
         ndVzxYCZ+2eXrmTp+y7YOHIZd3CEohp+bmTkPhEqO0Aw2Dt3DtBVKyCKUef2gWrPVIWY
         xPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337045; x=1727941845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0qzff08z3q5a8E7EP1BIypHJUEty88aRUrntwACuH0=;
        b=jaRACxUQMDLAHAjLztzSQvRN5RNup9w3Grkm7uDqsnLxZ15GzCcs5HKqVwDFefRXMh
         bsHf5p/aBOm6NvZTRIcUCbC711SU5f88vHTr6YmNWVLQZjODTUhvrG/S83JcVZe+f2Ym
         p8KvS/KvML8mEHIbUORBaS1NVU+1FptIl4dRxCOMxS7Ti9piWwvrb/efLzfEuY+//qug
         aobG+umo6S4uxOlBTXEGVqkgm23jwBwKsJxitSLJSd5asJwDG4bOFLwhrfnn3TJ4QQzy
         jhQm9t/Dj/XBiDUx4tXLqoA5IAwqEhkmqGjzOPqh6r6U1XJ6MENTyKKLV7Ier3cjpUfa
         g9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4uVxWYYa0ahdjNtRpvQigkskWONkDN8EJgKku9Tfg9uz1eryZw/fu47xhkeARIA/wcwT5F1Ic4LmSeHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUFYx0vxNA8OTlMAz1QZ3sJjIMxpf1wY/S63jl3u9NWsoyubc
	3it2TIhker49WRhiUJzYy+FXq5XMLMmri+YkYSRIGt1wvK0AkksS
X-Google-Smtp-Source: AGHT+IHh02LZbLC1YokYpQ8+bTGsaA4JedI4hRFAoFSG4HVpWGLVoaOphOY2Epf+jOJQbqx18AzStw==
X-Received: by 2002:a17:90b:205:b0:2e0:9168:2b43 with SMTP id 98e67ed59e1d1-2e091682d01mr2652063a91.16.1727337045019;
        Thu, 26 Sep 2024 00:50:45 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1bb004sm2761784a91.19.2024.09.26.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:50:44 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] btrfs: remove redundant stop_loop variable in scrub_stripe()
Date: Thu, 26 Sep 2024 13:20:34 +0530
Message-ID: <20240926075034.39475-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable stop_loop was originally introduced in commit
625f1c8dc66d7 (Btrfs: improve the loop of scrub_stripe). It was initialized
to 0 in commit 3b080b2564287 (Btrfs: scrub raid56 stripes in the right way).
However, in a later commit 18d30ab961497 (btrfs: scrub: use scrub_simple_mirror()
to handle RAID56 data stripe scrub), the code that modified stop_loop was removed,
making the variable redundant.

Currently, stop_loop is only initialized with 0 and is never used or modified
within the scrub_stripe() function. As a result, this patch removes the
stop_loop variable to clean up the code and eliminate unnecessary redundancy.

This change has no impact on functionality, as stop_loop was never utilized
in any meaningful way in the final version of the code.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
Compile tested only

 fs/btrfs/scrub.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3a3427428074..43431065d981 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2256,7 +2256,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	/* Offset inside the chunk */
 	u64 offset;
 	u64 stripe_logical;
-	int stop_loop = 0;
 
 	/* Extent_path should be released by now. */
 	ASSERT(sctx->extent_path.nodes[0] == NULL);
@@ -2370,14 +2369,8 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 		logical += increment;
 		physical += BTRFS_STRIPE_LEN;
 		spin_lock(&sctx->stat_lock);
-		if (stop_loop)
-			sctx->stat.last_physical =
-				map->stripes[stripe_index].physical + dev_stripe_len;
-		else
-			sctx->stat.last_physical = physical;
+		sctx->stat.last_physical = physical;
 		spin_unlock(&sctx->stat_lock);
-		if (stop_loop)
-			break;
 	}
 out:
 	ret2 = flush_scrub_stripes(sctx);
-- 
2.46.1


