Return-Path: <linux-btrfs+bounces-9647-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCD9C8E5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6780B32B3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670B118FC92;
	Thu, 14 Nov 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="08YR1BRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBC18CC17
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598093; cv=none; b=Pm/AJ2RrDhOLJOsEBfLUuqPnMYhs0vtC5qA9YKZlT5zFh4xZZRlz8UNj4xs7CF+1RKAW/zuQVEkmXdbKRz6Y+MCLpP9ci3E+Ugzy92ji723ZuLvPFGz1GDyiHc43UgoYGsVXAlO6RwunC6J+Du6IFooTteOUnFd8bNvdxTB5S1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598093; c=relaxed/simple;
	bh=LKB5qmpxodZQRc7Oxubcf3TF1jie3lO8rGiyoHOU3+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8tnZroVtVNptU+/E9jYiJDpTKkwldRoxpXP4+Ym8B62/kibHBqf7gnyB9xwZlRrXibL1WRgZIUpgQIS73UOIphG8LYWwu2aBHryEVz0niOWSXsWFlFpO5ukdfKYPfGUjE091Pnvyq5eTajIbN7wd8GLWlkV1lTwkVXbhrSvi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=08YR1BRR; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-288b392b8daso402476fac.2
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598090; x=1732202890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZIb5wvnGXtO89gOBSt/Tk4W0KJQpsBnaIBuXsS72Rg=;
        b=08YR1BRR7yCBt1JJYbgVC0Xty4xFN6eia0wi6XcpXntnDr49Q62c4zon5Qm9DAHzkp
         GH5nGsFMV2/o/Dr5EmvrtbleFFHcyNlcQnOeiMC0dPGIaaU/QBVGVnH4e/oORhDX2Tgj
         ul/UCZsvJ4OZcnROWf62ZTUetn58AWeDaW3PV2/xKkdnGzLzusJKs8Pvj8pFh3ZtcQWh
         oWsLks3kGL4HzhIc11x0p+JzK+rLkHwotvXwYQtJm4rA1RcgKAqAJbx9xV7poC3gpIhx
         oLcQk0py4rLNRStRwPHETNnGMECSRL5KP0D+Rz2q8Xsmvt8x1+2pOVkGEsp3eVV0m+Xm
         h1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598090; x=1732202890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZIb5wvnGXtO89gOBSt/Tk4W0KJQpsBnaIBuXsS72Rg=;
        b=BFWu48fkqjNQxsy+IhvJUA5e4xchNsQ99PFzC5buSFqsD/NsnVGIYDyxXXlGTLMkP6
         nbuLzdu++eXOyKlnBrVkmY4pboy2/Tj6ikcX2hdA13kByYWDAVCuQ6Mpd+XkGvpetw0b
         FTLcRvDNpHuDN1tnG9nDmyRMa1v+QM5HbQJEARC/pIzSNLsZl7QAB7lWRTcsMuP2Kbct
         dafAXc/ZE+toAvuTI019xeABOxfnnfY/BsNQNHHPHZT1I1mqmG4wSIFq02vDtFlHCLHU
         H2QwT0lU+EMjK8erdVRwoA+nudQKauAp4oMTRgBUJY+E9IFbcr24iEpdAH9xd7iiQD5W
         2hyw==
X-Forwarded-Encrypted: i=1; AJvYcCXcu1iGKsFKs48S4faeGWrrGsvxp6ZqjOOWj0OgXLkg7648RXTu4s+XNYuSacgJNzYC+lmcpjgHeIN7NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMqMxLr8rL6wxf3CJOywKxWfou/yG/jX1q1ushUeCeaw6zWyP
	lbeieBIybme/VPm5y9X2NNtMm6ZCWTO/SEH8X9hBnE1LEh82RUJcPK1z9EoEoLQ=
X-Google-Smtp-Source: AGHT+IF0BwKZuS0hD2QtJaajxUzrtQ2SwlZch/PHXd4jMsGrqLjoDD1qWu/LCzOrVtrsjrS2cDAn1Q==
X-Received: by 2002:a05:6870:910d:b0:277:c027:1960 with SMTP id 586e51a60fabf-29610376b59mr2544315fac.25.1731598090064;
        Thu, 14 Nov 2024 07:28:10 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/17] mm/truncate: add folio_unmap_invalidate() helper
Date: Thu, 14 Nov 2024 08:25:10 -0700
Message-ID: <20241114152743.2381672-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
given folio. The caller must already have locked the folio. Use this
new helper in invalidate_inode_pages2_range(), rather than duplicate
the code there.

In preparation for using this elsewhere as well, have it take a gfp_t
mask rather than assume GFP_KERNEL is the right choice. This bubbles
back to invalidate_complete_folio2() as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h |  2 ++
 mm/truncate.c           | 35 ++++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8afacb7520d4..d55bf995bd9e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -34,6 +34,8 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count);
 void kiocb_invalidate_post_direct_write(struct kiocb *iocb, size_t count);
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait);
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp);
 
 int write_inode_now(struct inode *, int sync);
 int filemap_fdatawrite(struct address_space *);
diff --git a/mm/truncate.c b/mm/truncate.c
index 0668cd340a46..6ea16c537534 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -547,12 +547,12 @@ EXPORT_SYMBOL(invalidate_mapping_pages);
  * sitting in the folio_add_lru() caches.
  */
 static int invalidate_complete_folio2(struct address_space *mapping,
-					struct folio *folio)
+				      struct folio *folio, gfp_t gfp_mask)
 {
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (!filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, gfp_mask))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
@@ -584,6 +584,25 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 	return mapping->a_ops->launder_folio(folio);
 }
 
+int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
+			   gfp_t gfp)
+{
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+
+	if (folio_test_dirty(folio))
+		return 0;
+	if (folio_mapped(folio))
+		unmap_mapping_folio(folio);
+	BUG_ON(folio_mapped(folio));
+
+	ret = folio_launder(mapping, folio);
+	if (!ret && !invalidate_complete_folio2(mapping, folio, gfp))
+		return -EBUSY;
+	return ret;
+}
+
 /**
  * invalidate_inode_pages2_range - remove range of pages from an address_space
  * @mapping: the address_space
@@ -641,18 +660,8 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 				folio_unlock(folio);
 				continue;
 			}
-			VM_BUG_ON_FOLIO(!folio_contains(folio, indices[i]), folio);
 			folio_wait_writeback(folio);
-
-			if (folio_mapped(folio))
-				unmap_mapping_folio(folio);
-			BUG_ON(folio_mapped(folio));
-
-			ret2 = folio_launder(mapping, folio);
-			if (ret2 == 0) {
-				if (!invalidate_complete_folio2(mapping, folio))
-					ret2 = -EBUSY;
-			}
+			ret2 = folio_unmap_invalidate(mapping, folio, GFP_KERNEL);
 			if (ret2 < 0)
 				ret = ret2;
 			folio_unlock(folio);
-- 
2.45.2


