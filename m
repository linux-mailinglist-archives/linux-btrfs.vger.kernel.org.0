Return-Path: <linux-btrfs+bounces-6750-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AED93D90A
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2642284D62
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AD148833;
	Fri, 26 Jul 2024 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jMYdK48X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7807145A0B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022609; cv=none; b=eOGp8qsDgAiuUgvwWxKABVO6T7zNBwskPJDjQrDxUdNguG4roF5FXZTthT1YnQUfzIw+IGtjKs0HW97b3OVHS6pP6mRKlRGUsJATnDD+pmKNYjjb2J0rggG5+jfXqg8pIYYjCwRFt8tpHJlkep/mc3jfUhw5T3ZkHi9jc16H5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022609; c=relaxed/simple;
	bh=RHMou5NJiO55eFD4jOnffqywkq/ozNpV2heuO7MUYis=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKWjdg4aF10jwKfULFeJJ1KJJuYQjQzpT9MDKoI1rFLKZmDI44rIi+Prky8IU6AxjZ6pVo/ZHHcJYlASTwrNxXYImOh7Ly4l+ttwwgO1DHPGCuSr9/lDJeNMpVx1ucxDPHOuzFuM5XgZmfV4aW5QL3WFIg+yYp8FjF4VVGBfJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jMYdK48X; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-66a1842b452so241357b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022607; x=1722627407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1Qm9mvhcCU978341Wg7EEf+4K0yvkNVlGaIoPUcIAM=;
        b=jMYdK48XjL3M2wHPIU5FKwiSARMO10LYGZGe4o9bSVUQBdXlSMBHA73BjyRvtxZTQh
         wkpd/w4lWFMSjg6+rUKNS54OfDOA85tshmxiCWhRDtySv/jBztJzAJqfrf7tRJgXNoxs
         u8EdUo1t7hv0/ESsq0vWOr7oVlTeZvIw7Drzzqh1Fk6h2NXr8PQict1EzBuJpetk8MnF
         2FKXoSzWyNf7eb2Csvu9xMGvFpna8p30bXVcBRpy5Dsbjw2pQlYvdxblJfiXa1qs0c0H
         V68hOnXZ79VmYSjQZHcfnHVGMjyvliGYJt/R9/kVnvZUXLyOYYR/j5TTdwDDwPC78awh
         /B6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022607; x=1722627407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1Qm9mvhcCU978341Wg7EEf+4K0yvkNVlGaIoPUcIAM=;
        b=NE/lov6vm5exvs4IpspN8VDUr8bbg/IwTjvFIJXc2v9XJupEaFm3XLYRwcuzW4x4qY
         lfX1toVAl+Kzsc2p1rGNJ8YAZfQcpoGY6iv/qzdZY8iyaEN7tKN9JRHiWpqLN+Dkxmz5
         4PLxxtKLQbj8SDpGL4VTMGKEJv99/wbJVKaVLElP6G+Vrpy3ruQIwkPWpCk4TgmKNcr/
         4T3bsUttFZxM30V8RDeLKqG/1HxVF3yWCYhp8xrFkKQQvlBL5K1OB/LnxIWu7b7lbxvG
         omKaVtTZauabfdm/dxFWhBByDd7IrQDJCSF0waYxVc/QnSwYScdykHJjebUXd15mrK66
         wsrw==
X-Gm-Message-State: AOJu0YwoAHzdKgTQvqph6gCY9Fm1vBF1ZVujJK9+pdTppIFAfsUICMD/
	UEF0R+FbEL8hyuW+526tjlA5ea4J+2sC55gRjEd5mrpALRRuK7akS+Xd4xeuQbMXmCyBVYaIUOt
	I
X-Google-Smtp-Source: AGHT+IH77liTOi8yS+dTaGT2pvL0QcgsOoc6klwNTeMEUEmXMEM8cdG1S2bp05RDMKiF1xucxursTQ==
X-Received: by 2002:a05:690c:698c:b0:64a:5ff5:73ef with SMTP id 00721157ae682-679fffd70eamr13229507b3.0.1722022606721;
        Fri, 26 Jul 2024 12:36:46 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd90f2sm10019897b3.11.2024.07.26.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 09/46] btrfs: convert extent_write_locked_range to use folios
Date: Fri, 26 Jul 2024 15:35:56 -0400
Message-ID: <10ac7f2cbef3070ec1134f4472c967d00ca74603.1722022376.git.josef@toxicpanda.com>
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

Instead of using pages for everything, find a folio and use that.  This
makes things a bit cleaner as a lot of the functions calls here all take
folios.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 63ec7efd307f..a04fc920b0e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2300,37 +2300,47 @@ void extent_write_locked_range(struct inode *inode, const struct page *locked_pa
 	while (cur <= end) {
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		u32 cur_len = cur_end + 1 - cur;
-		struct page *page;
+		struct folio *folio;
 		int nr = 0;
 
-		page = find_get_page(mapping, cur >> PAGE_SHIFT);
-		ASSERT(PageLocked(page));
-		if (pages_dirty && page != locked_page)
-			ASSERT(PageDirty(page));
+		folio = __filemap_get_folio(mapping, cur >> PAGE_SHIFT, 0, 0);
 
-		ret = __extent_writepage_io(BTRFS_I(inode), page_folio(page), cur, cur_len,
+		/*
+		 * This shouldn't happen, the pages are pinned and locked, this
+		 * code is just in case, but shouldn't actually be run.
+		 */
+		if (IS_ERR(folio)) {
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
+						       cur, cur_len, false);
+			mapping_set_error(mapping, PTR_ERR(folio));
+			cur = cur_end + 1;
+			continue;
+		}
+
+		ASSERT(folio_test_locked(folio));
+		if (pages_dirty && &folio->page != locked_page)
+			ASSERT(folio_test_dirty(folio));
+
+		ret = __extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
 					    &bio_ctrl, i_size, &nr);
 		if (ret == 1)
 			goto next_page;
 
 		/* Make sure the mapping tag for page dirty gets cleared. */
 		if (nr == 0) {
-			struct folio *folio;
-
-			folio = page_folio(page);
 			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
 			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
 		}
 		if (ret) {
-			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
+			btrfs_mark_ordered_io_finished(BTRFS_I(inode), &folio->page,
 						       cur, cur_len, !ret);
-			mapping_set_error(page->mapping, ret);
+			mapping_set_error(mapping, ret);
 		}
-		btrfs_folio_unlock_writer(fs_info, page_folio(page), cur, cur_len);
+		btrfs_folio_unlock_writer(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
-		put_page(page);
+		folio_put(folio);
 		cur = cur_end + 1;
 	}
 
-- 
2.43.0


