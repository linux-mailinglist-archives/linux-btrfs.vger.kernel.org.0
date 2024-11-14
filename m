Return-Path: <linux-btrfs+bounces-9653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB19C8E44
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88502281977
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4E81B0F05;
	Thu, 14 Nov 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SVrMbxI5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CC1AC427
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598102; cv=none; b=b6+jONVf/JIxeC4UBYaKxHzATwHT4dLM6KJw+gdDqmTrHXr+PuO1wQYphqNT7mpAgGZbaJiuFyygEQarhnw7/azO+3MLFtCGoU8qgIQNHWzlk2vrraH5lw6BCl5moFLdCGZ0cCHFHk8Q72/LbP04hSXsm7RgHRWH91zkdExBaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598102; c=relaxed/simple;
	bh=lNhwCmzwFphLkSB9taIvs4WJ/6CHD1yuvvg662y7/aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPATGdcbsM9OpdJriSYs8n3bCZvZ+LLDgtAwNDWPmN1owe3nzBSHYoUT79wWfAV1zdN5pcmuEde7iKyvrdGwTXMVMC1iKpYAutp/pTfoeNtX3LO0U+ezmR1JP/9UrIDphpXNuE2Jc8D+vxW9Wi9V4j9yfoV/01geRhWS6F/6A6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SVrMbxI5; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5eb60f6b4a7so186885eaf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598098; x=1732202898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh4vHLcSKYCCRkbDjlhjn1EJt3wp9QgKXbTvV2Vr6u0=;
        b=SVrMbxI5HUdJ+oGYj469+T374H88/9gwfszmBpWundKS7Y43s6hygEFdIBbqJzVbbl
         SbQu0RNUsOk/eju4spW3OuP2ZOiOFKEJBKgaUppYsVUy3IAhsR/qnzoXWClNIJWMbr6l
         KNM84FWUZYttbT0yYFVwyE3DaFda1vz+18ywpMEpT3mNcEZrrwP6oC2UbW84l4cOuhlz
         76nMmzfJ67XOHJ8TvfSKs7x8gaqc7pg+eU4MJhKPp7gGQvO/gNiwLHFAZZV1kSRfBt6o
         AADvjhk/iSnKTkXutc/JyULDFSc1N4QnVNkFNWDcw3OHGy/qxG6aEEXb1O93Jkdi26zm
         RNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598098; x=1732202898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bh4vHLcSKYCCRkbDjlhjn1EJt3wp9QgKXbTvV2Vr6u0=;
        b=RW0b+Imm9qY4bNu7901ZLEjkJzioTqVa1nf4CMjZGN2kyTfygnLnJ1Pgz8INr2l4z5
         vkfFJ1Q2acQ93V2hq9ogEhY4dH8mR9hXlUXshXVZyqiXerRSi2j2p76oJKXei4v5385f
         2dEzMkcbwCHRCDY+J7X/3YvYqXZOnFYYMk39XLO1C/ed3z/VzGq96f2S4IYjaxeAY+bC
         NpqJ+JdKkYC9ivf3S3xuUUv9WWu7RNWY/ke0+FtzdtPbTmlRDDW4iFT6V6icmi3zxdin
         dtvbtTC3Q5Etu6o6VT8pgZ5XYlhKYJH+8S8O//ZSB2yZ9HjOfChNW6ML5gBKzrkN7Hwe
         BA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK8eDCAmGYvir7bN2JfuCC1Y1VSXV6RfiIsAOxFOUjm20K2MmkSVWMw2aHuKdGhFqqp6ZeJBmgSzkrlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9B3FobKLsCbw5kQkGOhXENHKXQ3NFZWMSr5rcp97aFNi5O9r4
	nGCKL9843q1T1hn6w7nRimBcwi7Wu+d/37VXBJqeY87ZO/NCSzhraUCjiFpTRrU=
X-Google-Smtp-Source: AGHT+IECtJqHxvsDZk559Jqz444iSDToPVSz/2QlEeAwby3Gwu7O3Iv2UCv4dhdd6n28ENyvjODyaw==
X-Received: by 2002:a05:6820:1e0c:b0:5e3:b7a6:834 with SMTP id 006d021491bc7-5ee57b9c8e0mr20035625eaf.1.1731598098551;
        Thu, 14 Nov 2024 07:28:18 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:17 -0800 (PST)
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
Subject: [PATCH 12/17] mm: add FGP_UNCACHED folio creation flag
Date: Thu, 14 Nov 2024 08:25:16 -0700
Message-ID: <20241114152743.2381672-14-axboe@kernel.dk>
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

Callers can pass this in for uncached folio creation, in which case if
a folio is newly created it gets marked as uncached. If a folio exists
for this index and lookup succeeds, then it will not get marked as
uncached. If an !uncached lookup finds a cached folio, clear the flag.
For that case, there are competeting uncached and cached users of the
folio, and it should not get pruned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 2 ++
 mm/filemap.c            | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cc02518d338d..860807e34b8c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -721,6 +721,7 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
  * * %FGP_NOFS - __GFP_FS will get cleared in gfp.
  * * %FGP_NOWAIT - Don't block on the folio lock.
  * * %FGP_STABLE - Wait for the folio to be stable (finished writeback)
+ * * %FGP_UNCACHED - Uncached buffered IO
  * * %FGP_WRITEBEGIN - The flags to use in a filesystem write_begin()
  *   implementation.
  */
@@ -734,6 +735,7 @@ typedef unsigned int __bitwise fgf_t;
 #define FGP_NOWAIT		((__force fgf_t)0x00000020)
 #define FGP_FOR_MMAP		((__force fgf_t)0x00000040)
 #define FGP_STABLE		((__force fgf_t)0x00000080)
+#define FGP_UNCACHED		((__force fgf_t)0x00000100)
 #define FGF_GET_ORDER(fgf)	(((__force unsigned)fgf) >> 26)	/* top 6 bits */
 
 #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
diff --git a/mm/filemap.c b/mm/filemap.c
index a8a9fb986d2d..dbc3fa975ad1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2002,6 +2002,8 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			/* Init accessed so avoid atomic mark_page_accessed later */
 			if (fgp_flags & FGP_ACCESSED)
 				__folio_set_referenced(folio);
+			if (fgp_flags & FGP_UNCACHED)
+				__folio_set_uncached(folio);
 
 			err = filemap_add_folio(mapping, folio, index, gfp);
 			if (!err)
@@ -2024,6 +2026,9 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 	if (!folio)
 		return ERR_PTR(-ENOENT);
+	/* not an uncached lookup, clear uncached if set */
+	if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
+		folio_clear_uncached(folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio);
-- 
2.45.2


