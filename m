Return-Path: <linux-btrfs+bounces-6743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0893D903
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E41B21BBC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928BE433B9;
	Fri, 26 Jul 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KbjEhwQl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF464963A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022601; cv=none; b=A6fvzt+zcOFMvcW72knvdgNmrh3xZhlzfAxgVh7YRlzUaWI+n4WHEvbwrxH6FX3hLCnfL0I5UVcBGrZf6r4PkwBHFlrTUrFaqYsZ7ofIid2LpVBLAQVWNFhkhVJkxhn9bka4/qA3ePT+hymJT3vFGF7kWEUaoZth+tvHnz7QByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022601; c=relaxed/simple;
	bh=jR9CdxMLglNBbgTYGpuW+z8E933gcmwRxR/8Zvv09+k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOjmkn68JvZ4I+x+FMtP5/yhHnRzBwlar78c3MoB7f+cvYrLrDXZbkohUe4qhBIxD00koG1xKZ+oCwhfsU8L0gEkxz6HxCJjnK0YaUq9p3pcwDlmuHLkcQCf2mTIhr83fUHjw+ssizNoIKvJsFGyKp+gb/RYTZJMV+VtYCllPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KbjEhwQl; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66498fd4f91so316357b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022599; x=1722627399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+sqz5QT4aooITXeocirdSf2pAg4CcNcX0Bi3JXLztg=;
        b=KbjEhwQlBJ8vEUQLjJW41APVpA59c92fNTcPAmxJoOcb1V+DEw1cQA37oBAZw/miQQ
         W9v4moWfp6zsVax65maWeNhkd77e3WgX9pR38tidLiDL1bJt33ujNJsyICiXTA764VQq
         uO7YnkL5WPBjR2KJCKFTlBD36pmeZwO8LbEseWP3BVp+9R8H1/qCi+4bPDVLYXZtNk1l
         IPiBAxSg5xxs0JSrG1xEwLyPYkpCRGmv/My7IY3DC5LcPl0QQGSwnhPSdxuZu2C7tpIx
         4lM4Uj3jW4H+QEJuOVaPoXCD+cJfQ1CT4JagYOelhLFQzEkOpxBnP3QN2XMyvnkbNU0N
         GTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022599; x=1722627399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+sqz5QT4aooITXeocirdSf2pAg4CcNcX0Bi3JXLztg=;
        b=sLjKsxncZML2CB3T6HxQTScsRoKPfFiZ3rU4fc9cvl1g3zj1Yzj+qCy6hyzpec1mNP
         iLg/ZrLDHYav2FEJNC/B9/+0572F7fdzoVig5FF33YxvxPDX2XGHUIyIIo5WP3xuwpa8
         LozzjwDwv5SD0xq/CdovxiOM6F9Wg0nRQPGyEMNcMGABLqUyzeTEdHRM7oOevTGfhd9a
         Q47KlW2uszgcw7Cu3lyZQp9fiBQXQ2sird3Saw7DpKv5YGoKcuNUQ1z2xP5VqehEfiP7
         XfVgRnceSfCiAnlBLMOd/ErgiJZj6AlgsczftPmwL5/atOW4RelahkZ1ViS2ziL4eQ3u
         gZHg==
X-Gm-Message-State: AOJu0Yyl1aPpjXG6IOttQRubli7jycw41NKy/aK8tc14l+jvtS/pjNtt
	ei82B54Z96669RQgRgi/p7dr+3mk8E98LmV2I/i2/7ez6SplK4Kf8IRwsZSvih50urb9k/cjjne
	G
X-Google-Smtp-Source: AGHT+IHS2tlzUlfGDZ26zGlzWEkjnbT7D2RIRzvV577R+XZ7kLqwCIqm4U7a+kYJSDw8zITzlAxVog==
X-Received: by 2002:a0d:f707:0:b0:62f:cb31:1be with SMTP id 00721157ae682-67a051e8493mr9172377b3.8.1722022599186;
        Fri, 26 Jul 2024 12:36:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e987sm9924277b3.39.2024.07.26.12.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 02/46] btrfs: convert btrfs_read_folio to only use a folio
Date: Fri, 26 Jul 2024 15:35:49 -0400
Message-ID: <dde6538255586c54cdb0e2b3391284e04369765c.1722022376.git.josef@toxicpanda.com>
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

Currently we're using the page for everything here.  Convert this to use
the folio helpers instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a4d5f8d00f04..4b7d1881d023 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1155,17 +1155,16 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 
 int btrfs_read_folio(struct file *file, struct folio *folio)
 {
-	struct page *page = &folio->page;
-	struct btrfs_inode *inode = page_to_inode(page);
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
+	struct btrfs_inode *inode = folio_to_inode(folio);
+	u64 start = folio_pos(folio);
+	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
 	struct extent_map *em_cached = NULL;
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-	ret = btrfs_do_readpage(page, &em_cached, &bio_ctrl, NULL);
+	ret = btrfs_do_readpage(&folio->page, &em_cached, &bio_ctrl, NULL);
 	free_extent_map(em_cached);
 
 	/*
-- 
2.43.0


