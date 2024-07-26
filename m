Return-Path: <linux-btrfs+bounces-6786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A793D92F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DD5B20E9F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB8A155329;
	Fri, 26 Jul 2024 19:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="N5m6nC9P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD515530B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022648; cv=none; b=QD2pqw1iSdXSdcpuOXJsG1fx/c6PxL0TLuKGPGbpcPlbiqLiaQbs35ZoVqcxFe7kJexsCIEiGQEteZ4tqRx2UokYyijV76HiTEmqztwaFupuntSRwkTh5T/0IJ2Q5ivEXIOARayY33udrM0wgncpJ3lFit8fFzS5UMNTcdD9KuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022648; c=relaxed/simple;
	bh=Inb0aqEP/SP7FGHHn8cWmY934wEXDaZxEhT4K//JPlA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eccAEst/UPEEGAcOJw17KFW63ljMj3XoUTXhr3C0cZDQMMk6DNLDAwuKVac+yk3SMO00R7TxR4k6+IyTwNjL6nZKXJUVlfkByGMGzgn6YtW9EWPa1Zha/CUTGEu7/GVqWUOBoXj2oB3J7a1/OOp8KNuyIVH7/0CfoNdQl2RXL5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=N5m6nC9P; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b417e1511so235387b3.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022646; x=1722627446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RB4ZcR9rQuKZdUzsoI+3qZXPRxW935rVZwMLYS2Gde0=;
        b=N5m6nC9PS6RgeFDXWqmQCn3i3PrRA585V8QewVT1DL6jTPFK9x6QLbFoHSLPBP/A8+
         9/qv6PqD8YVEUPbaBkoWkxAeuq5tFQm8Lzc0lEaUpm2UD9vETa7roLVzJReoD0FiS5vQ
         dxQLQRWQ/FrhxsiElFhIirSNBw/oLCGqyYTFsB2FECL7aOaBZ8K3/V2vYhh5du4+MuoV
         3XxxaAqbmKDwyIuYKUO/s8m+dh8kHNvkoky/LTtQuHxCNQM4jJtFLrpWfGoQjo6c0hh9
         SuCQOIaEy2waQCVt3ILJd74tx9bOe14lC3FjOvddaziM6r6TQELZdc9X8grOODwsgOw7
         Rccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022646; x=1722627446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB4ZcR9rQuKZdUzsoI+3qZXPRxW935rVZwMLYS2Gde0=;
        b=X9g18RdOOe8PvVZFTG4g9L2EPTT4Q7gEihjIgwkQco8RlnSohIbP6n7X8GCNvIVprI
         0ioY9nHw4cF+e38C0tQ6AvqjiYsgYjUEv26PAy6OuVd/VrXvYGmC0YUtegdSTXyudlJs
         alHJo6auMBeJpoDcmO31NAPiP7vYf5ybT3aVaFrV9SAl6Do89YS8YY9jkwC5noZ/jodW
         sKrFRr53b5Jsd9U+c805sNri1VRfhaWsm3sXydvO/OxJ2XnVt1whAMHPkY/h+44R/nW9
         qeeo93mHhWuxVKP2EJnAnw6N05QrnMz5Uok1df92lNjgce/QcqnLo8WMohulacJqwESB
         d8YQ==
X-Gm-Message-State: AOJu0YymEGDyVjFCw97NqqO2z8Gr9U1+xMA9v/QCwcDDArY6M8eB9CZI
	xK+btLem5Xdyizn1u9jd+VjC+Yo68hshG0n4WjSBrYGoCWlKg8cKdZapupRrnUG+AgnKUbxx24H
	W
X-Google-Smtp-Source: AGHT+IFAGdRdwD5ZG1Su/X2ftLx6SRYvoiPftpDuvkkR7y0NSF2w1nCWuR8ZPEC58QlkTPlK2l9GRQ==
X-Received: by 2002:a0d:d007:0:b0:673:1ac6:4be0 with SMTP id 00721157ae682-67a0a3231d1mr9188067b3.44.1722022645909;
        Fri, 26 Jul 2024 12:37:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd8f25sm9793087b3.29.2024.07.26.12.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 46/46] btrfs: convert extent_range_clear_dirty_for_io to use a folio
Date: Fri, 26 Jul 2024 15:36:33 -0400
Message-ID: <991405b7951dd3730058041c65aafd88ca023add.1722022377.git.josef@toxicpanda.com>
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

Instead of getting a page and using that to clear dirty for io, use the
folio helper and use the appropriate folio functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c019beb7d9ef..79888ae8d883 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -877,19 +877,19 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
 	unsigned long end_index = end >> PAGE_SHIFT;
-	struct page *page;
+	struct folio *folio;
 	int ret = 0;
 
 	for (unsigned long index = start >> PAGE_SHIFT;
 	     index <= end_index; index++) {
-		page = find_get_page(inode->i_mapping, index);
-		if (unlikely(!page)) {
+		folio = __filemap_get_folio(inode->i_mapping, index, 0, 0);
+		if (unlikely(IS_ERR(folio))) {
 			if (!ret)
-				ret = -ENOENT;
+				ret = PTR_ERR(folio);
 			continue;
 		}
-		clear_page_dirty_for_io(page);
-		put_page(page);
+		folio_clear_dirty_for_io(folio);
+		folio_put(folio);
 	}
 	return ret;
 }
-- 
2.43.0


