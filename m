Return-Path: <linux-btrfs+bounces-6745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28893D905
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F2A28372E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95244C61;
	Fri, 26 Jul 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XOdWRjYw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7585132492
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022604; cv=none; b=jmscAqNfhX9I9tmGMOssQFtBk+31N03A86TR6+FfMeEOQX5pSty/Fa/cxRiB1ppz3AvKD4PUFCWmCOi8bGENJ3cHtEkQrkcMww+ppc2r6wIoczqgmsC1Cr1SJKlHJOt1qBMK0VV01rDHlPVeAl6kfn73ce0pbGeTlfCIWwF5gIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022604; c=relaxed/simple;
	bh=L0ZvvEpFAkvgp5F+ig4n9DgsEv64aYY2210IsqUG82w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrzWSjQvOKIgyalgb5Oh6gw2UpA4gxjrafp9+XleRmUhJXJqq8+xeqLbNMTUdETOFBm6wi/Hx65lBQjY/Qi58ffQV8lWaSWt82UJQnoTWThLYjsv5yEucTShdq0Kjf4BdL4rmf2RX1LBKsI4M5tS0mF0HEm5dmC4hCeo4DmmodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XOdWRjYw; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0b10e8b6b7so37730276.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022601; x=1722627401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fG++zUtbtJbYwCXNhQpDX/lMnFuNmR9EVcb6Bxk0CmM=;
        b=XOdWRjYwob/ogVIGcuBt+9qg3BAnx2eCUkcig0Q394LmRUm2PMTmle3rjSg+Ya4apM
         PY5oobx3DHuUR+JOcQAGjPyYo/o9Jkm1Q8BPO7N0Pt6lWL1cDywUE1RHzK/3Jl1fwmfN
         w7uVQ+bgv2fH1zbLjYgDzk1+OsGFin5zgq+p2CdnNkJZ3MCQ4SuH5Ym5qdViZT3mIrYs
         CPCyEFxpw7scR//gwinFEcFPWyx1T98IUYcueRVdhHjC6pwae+kgGA28tLYPtqO7ASgx
         8Q/YTfEhvtVNF166kvTs3T0TDsu7ilrWZsW51+j1b73gOYLk8P+wXZBbBJs6YfiVXc5Z
         teEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022601; x=1722627401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fG++zUtbtJbYwCXNhQpDX/lMnFuNmR9EVcb6Bxk0CmM=;
        b=rlYFIoFhLWZduQkfEQjK6B0FZ33AXp8n8+dY0HMvj9pcjtSbSnNyniJhOSrNmNinKJ
         09fFld1CQbA+PmbSwmgbu6MdDSy80YmgE7CERtTMxcYBgE4o1w8a130jW0MnfTsjerR9
         9wzAwZ77ncNnxU2XYMajXTEUkbZIqy+Pu7CQqH6JLcJXfrYQRkTEbp7CDFhRv9q33tHP
         Ep7vLN3xv3+ZPFHv3vkUXCHRhxdoVXybySXRf+FlksrFEzPKTiFxwLM/Qae+D2gwYaNq
         MsLgf0k6QstECzZsPropC69sldE8HOAEm+pR+7acZAiUOiBbXuCk6wU1dowdzlvscnPk
         e02g==
X-Gm-Message-State: AOJu0YwpXc01xG0rxd5W8ZLkFNFBdTPDs6haZDhtyt89ngDwB/92ic2N
	02vRDawdEWQ/3mnXqnA3lMYzIs928XduQD2BEwa6x4qFYC3bBdUjF7IV5QOdu73tgwcH+JuxCLb
	p
X-Google-Smtp-Source: AGHT+IFMDPGwEZPMumKFxcDNtbizNon8dZ+UTuPUNvtn49XjaNKHAcrE3FVfd5uxnPlw2PRHC/Y+/w==
X-Received: by 2002:a0d:f547:0:b0:64b:6f7f:bc29 with SMTP id 00721157ae682-67a06a0cd24mr9679447b3.16.1722022601465;
        Fri, 26 Jul 2024 12:36:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b303ec6sm9910347b3.81.2024.07.26.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 04/46] btrfs: convert begin_page_folio to take a folio instead
Date: Fri, 26 Jul 2024 15:35:51 -0400
Message-ID: <74d03e343fdfa27baa551fd70afd5252e4f1ee5c.1722022376.git.josef@toxicpanda.com>
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

This already uses a folio internally, change it to take a folio as an
argument instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d6b1bc74109..89938800f37a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -551,16 +551,14 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
 	processed->uptodate = uptodate;
 }
 
-static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
+static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	ASSERT(folio_test_locked(folio));
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_subpage_start_reader(fs_info, folio, page_offset(page), PAGE_SIZE);
+	btrfs_subpage_start_reader(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -1038,7 +1036,7 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		}
 	}
 	bio_ctrl->end_io_func = end_bbio_data_read;
-	begin_page_read(fs_info, page);
+	begin_folio_read(fs_info, page_folio(page));
 	while (cur <= end) {
 		enum btrfs_compression_type compress_type = BTRFS_COMPRESS_NONE;
 		bool force_bio_submit = false;
-- 
2.43.0


