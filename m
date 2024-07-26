Return-Path: <linux-btrfs+bounces-6772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3195E93D920
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639011C23127
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CC14F9E6;
	Fri, 26 Jul 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Bc4qF75F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C717143C7B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022632; cv=none; b=bvDa+MkYftBJSO7feaKdv/CukGbKZU8XkB4TZf2+Yt/zX1ElbsRBruqqqgt/sST4tOk9jGE2fey19W0n2DfI4y+QW49TK+hkXTR9DgZLEET3Usk0KmL14IwKtAwfuA6V2DxRc2k5NBc6aIH1WqT0pbtjrwXazwqKsSfR2nN7SUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022632; c=relaxed/simple;
	bh=FH9PJwcRIRQEaTwtlF7DaFwjKmxj9BeI7Fhe/e5iFQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3vaUURLqrkqqeqWSFpwfrvCD4g2jJM2lMJnlWXfLIMPseLRnTmiUL5Y3pAtz7V14XuAsO/Wo35yZb71ietKvQn3d1XW4+GOBcMgDZlgwWaRk5qwrrBpZlBCibMC+804lKQhgzdj+sJ076jT7bm7FS0CLnoaCeokKX+pK/DNEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Bc4qF75F; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6687f2f0986so609297b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022630; x=1722627430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JYKSZjjub4MjUvTL+RGon1mBcuNGAyS/ZL6rxZXNbA=;
        b=Bc4qF75FsxoY4PYgtwnD4N5MWlQfEUzB19uSlL9v7lJzQZrmjRxYPyTCcwvsRZLqlT
         zAkAB77OeOhy9dOJ7/JG66FTz3H7OU7kHBAcjCWVoTGRgtMDUWzvG577bI2g38Oa9Z1L
         NdCPa/4T1YDig2bVWaqcxS6NqVMprtzkwIU9xmGgXPurPMez3dzFWXNEHMWuMuDFPMiV
         fDFmg7vuIKWRngMUd6G5xJVq8jPjh0hve5DEpxFPF+d2TQ0otaW/yJgeAkhdhe0JeKiW
         m5m7508NkVCOQ0zvAZ9cCs2WkFT0ay3P45AQN0GCrbJ2ML5A1lwwEl9F0P4mJXvcR4XG
         a6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022630; x=1722627430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JYKSZjjub4MjUvTL+RGon1mBcuNGAyS/ZL6rxZXNbA=;
        b=vkziMbKDSKmfhDKUHX8T4xNwYp6S43amunC/2TghUfb9mHcA7CfXAnhikoPXx9Cpwj
         Wp+RQ6mYijginNBOJzaZ+ZGqNnT/YcDwkL7mJqWkMC4aBO140ldfboxFk2NflZF6xG/N
         wPRmT1bUpme4WijA4ywLiJ1oSLNg0jsVAjqS5CsUNISXHcu2wB71iXAEe2k429L6sNap
         uNPEcT/DTssCgTCWUffpivbebSdrCmQ1XuI0fRnlV/fzkjTD4t/ZoIUTCK8ocaoewBlN
         11jpw/HRBZGSOrmGK+y9W3othMCZisK0W+EPXRPnNSHV1LHhVlcmsCtLgDX9O/NVAtxG
         IPwA==
X-Gm-Message-State: AOJu0Ywxy7qBYr2jB0VGFr0wsyejGWFJ/BLyaKjhtFWNwiTuC6GO/V5b
	+JQL4qrahkvBs1fTQjdhowf54RGCm67sUW3Fu+rHgK93VS/wTsvS+8FU23bVUdfSuBY3AfbUx65
	G
X-Google-Smtp-Source: AGHT+IEhhZGTcYx3aX7T5rtBEvVGtw0YLn5+MfZqceSWDfUELZ2pbvPH8m5czdj5fj+0zbCVxJb1+A==
X-Received: by 2002:a0d:d101:0:b0:64b:a3f0:5eee with SMTP id 00721157ae682-67a071c27d3mr9099987b3.17.1722022630270;
        Fri, 26 Jul 2024 12:37:10 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8e4bsm10000497b3.19.2024.07.26.12.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:09 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 31/46] btrfs: convert run_delalloc_compressed to take a folio
Date: Fri, 26 Jul 2024 15:36:18 -0400
Message-ID: <01064d0e836a8545787ffc747c650626f38ea258.1722022377.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722022376.git.josef@toxicpanda.com>
References: <cover.1722022376.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just passes the page into the compressed machinery to keep track of
the locked page.  Update this to take a folio and convert it to a page
where appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 76fa9b1e0f11..23ab3000c5fd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1653,7 +1653,7 @@ static noinline void submit_compressed_extents(struct btrfs_work *work, bool do_
 }
 
 static bool run_delalloc_compressed(struct btrfs_inode *inode,
-				    struct page *locked_page, u64 start,
+				    struct folio *locked_folio, u64 start,
 				    u64 end, struct writeback_control *wbc)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -1693,15 +1693,16 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 		INIT_LIST_HEAD(&async_chunk[i].extents);
 
 		/*
-		 * The locked_page comes all the way from writepage and its
-		 * the original page we were actually given.  As we spread
+		 * The locked_folio comes all the way from writepage and its
+		 * the original folio we were actually given.  As we spread
 		 * this large delalloc region across multiple async_chunk
-		 * structs, only the first struct needs a pointer to locked_page
+		 * structs, only the first struct needs a pointer to
+		 * locked_folio.
 		 *
 		 * This way we don't need racey decisions about who is supposed
 		 * to unlock it.
 		 */
-		if (locked_page) {
+		if (locked_folio) {
 			/*
 			 * Depending on the compressibility, the pages might or
 			 * might not go through async.  We want all of them to
@@ -1711,10 +1712,10 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 			 * need full accuracy.  Just account the whole thing
 			 * against the first page.
 			 */
-			wbc_account_cgroup_owner(wbc, locked_page,
+			wbc_account_cgroup_owner(wbc, &locked_folio->page,
 						 cur_end - start);
-			async_chunk[i].locked_page = locked_page;
-			locked_page = NULL;
+			async_chunk[i].locked_page = &locked_folio->page;
+			locked_folio = NULL;
 		} else {
 			async_chunk[i].locked_page = NULL;
 		}
@@ -2307,7 +2308,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
-	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
+	    run_delalloc_compressed(inode, page_folio(locked_page), start, end,
+				    wbc))
 		return 1;
 
 	if (zoned)
-- 
2.43.0


