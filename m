Return-Path: <linux-btrfs+bounces-6742-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33793D902
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A74621C2302E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302626F2F8;
	Fri, 26 Jul 2024 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Mghzl9Io"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADC433B9
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022601; cv=none; b=HydB41W+av7ddJeYmyxkhInmXM5M+fxvA3/C/Hiwo7q0X0j47kIo+TKSXHcUZFRasGbC+cz2R3w0Xl+PzFrWCigNJGlRE+NS+nOpKy50DpExAU7GzWwIouQGBkluoJV1bn2lFb0zfT4cayJoWP4nk5IAEXZX+bhRErY5lUh+QuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022601; c=relaxed/simple;
	bh=xyi88THPFX2gWr+re7GLpuJAPdkz/QaVjqnB+A6McAw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjOlxz0K8HuDXv8pwuBkKliyiTmPyPvBpy/jLkqZA105TiLX/f/icESTxBlI1Sd/+QEDgyWVllwop6qfhEi9+tUXQwWnEr7rQvDheBcXjuLA310ScOPpdyjhXvhlbSD5NfmfJp8J75VjY2nL5xkGfG7NXEGP0viGlwMghYTj+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Mghzl9Io; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-664ccd158b0so356687b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022598; x=1722627398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RS0TTQT2jStvTHFxGnRtX4MrtHswBW12/WYDHf9I5sQ=;
        b=Mghzl9Io08MENhWPLaWl64HR97lcJdOjWb7t/00V+lfkLci/oTiz44Qu8VxSLTCVUg
         davSfAQODBGIPLhP3h+KS5GQR1s3CsJvvkD6yD319daAG4iGd27EXYl4JFqJVN3fcpvE
         h3ia0Q/cct7t0FXSXQ7s1SKjAOpBJc4iwsjj3ViwiuD2MsZLga+yCIi2Dy/YOq8CIgmA
         Fx7xNrLGf3Me4MwaJTgL2s2AY/J9WgO1NjZZjSeRcc0BnDTfZZS84/HlDhZG2sheEAWx
         256TfkLiq/P6uBf2MA83dtwqzkpgWqLkrxy2ZXqaYWxVT6BGswyp0HBjmD6FNDGjq8ps
         Ol5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022598; x=1722627398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS0TTQT2jStvTHFxGnRtX4MrtHswBW12/WYDHf9I5sQ=;
        b=w7LpSTmKjrFg75FdTdFHBp4YF23N3IX2VusLriaQxxkSk07/+Cewtp13VQF+OQCcod
         KZnD5gDWmQGMEiEk6fnrwPh06KaeVi3n3g1hz9z+n4wT4XBm0rBEFNBv+eTjOWvyazHj
         SATfYdDTZFlau5xahh0D95MrMjjti74TuXBBRrzeNCuwhvYAgQQuxrAPYh2ioATiPSz8
         Pv2ihw+PQMM4qvXOpEkY3b+7QESiSUPxiMJ9rSWRttwHlyH2uvcdFklTX1sJUX1fiG4U
         VeiPK59EdJDmxuyrthMpVMYIWutfr29GPaX5VK07ZiqxZBfimsnk8wzITCf4eQu28A5y
         Lhnw==
X-Gm-Message-State: AOJu0YxmnwtMARMSbfBjNTcUoaxoQCBx2anQYL2LKS7PGINlQn8yJFjs
	tM6IpA8O+4eviOWjpW1E5vdUkQ5Yzk6oqLP0RD41qYGtA/lj0oEvSchWoz4Di33zYJ7FahoAcew
	9
X-Google-Smtp-Source: AGHT+IFjEWGZAukGYNMB6pDAB87OWI1Zi4A1qtjOMPwIEq4+Z4i93Zq2O2YOAZQ0VOCu2NgfcRrN/A==
X-Received: by 2002:a0d:ee42:0:b0:643:aef1:fb9d with SMTP id 00721157ae682-67a053e118cmr10055257b3.4.1722022598157;
        Fri, 26 Jul 2024 12:36:38 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e7desm10014517b3.47.2024.07.26.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 01/46] btrfs: convert btrfs_readahead to only use folio
Date: Fri, 26 Jul 2024 15:35:48 -0400
Message-ID: <ec5ed3738204b750680e0b13de6ebb9578b2fc98.1722022376.git.josef@toxicpanda.com>
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

We're the only user of readahead_page_batch().  Convert btrfs_readahead
to use the folio based helpers to do readahead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..a4d5f8d00f04 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1176,26 +1176,6 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	return ret;
 }
 
-static inline void contiguous_readpages(struct page *pages[], int nr_pages,
-					u64 start, u64 end,
-					struct extent_map **em_cached,
-					struct btrfs_bio_ctrl *bio_ctrl,
-					u64 *prev_em_start)
-{
-	struct btrfs_inode *inode = page_to_inode(pages[0]);
-	int index;
-
-	ASSERT(em_cached);
-
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
-	for (index = 0; index < nr_pages; index++) {
-		btrfs_do_readpage(pages[index], em_cached, bio_ctrl,
-				  prev_em_start);
-		put_page(pages[index]);
-	}
-}
-
 /*
  * helper for __extent_writepage, doing all of the delayed allocation setup.
  *
@@ -2379,18 +2359,18 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
-	struct page *pagepool[16];
+	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
+	struct folio *folio;
+	u64 start = readahead_pos(rac);
+	u64 end = start + readahead_length(rac) - 1;
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
-	int nr;
 
-	while ((nr = readahead_page_batch(rac, pagepool))) {
-		u64 contig_start = readahead_pos(rac);
-		u64 contig_end = contig_start + readahead_batch_length(rac) - 1;
+	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
-		contiguous_readpages(pagepool, nr, contig_start, contig_end,
-				&em_cached, &bio_ctrl, &prev_em_start);
-	}
+	while ((folio = readahead_folio(rac)) != NULL)
+		btrfs_do_readpage(&folio->page, &em_cached, &bio_ctrl,
+				  &prev_em_start);
 
 	if (em_cached)
 		free_extent_map(em_cached);
-- 
2.43.0


