Return-Path: <linux-btrfs+bounces-9646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C559C8E20
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE811F226D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C817084F;
	Thu, 14 Nov 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rYyOesV0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F718BC06
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598091; cv=none; b=jLBQZTD6euMeCkX0ssTHRpCdgcqI2Y4AkgDqGJdv380EqmA/7fckV637Fj1jTxuAci/IEriYdn2lsI4xOTIHwnrz+sjj+Rk1usPIlLdDl0J1s/MwwqBQrLOaOwLkX7skBxTpQDXRybZbYmOPvDCiCqg/f3z8selprpJORl9/LmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598091; c=relaxed/simple;
	bh=HNesIF4+NCKJRgMS8RJOzPdBmK2CQSC6p10zaqTN28c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfhercN8anO47inWcSVVeejXYrrAJ4QcDsdv5UWCswJucGy9HexB52DrVIsLXqDc34jfyQ3VT7pH8NnPXo1vwqle3DTRGTAGUKzgbmqlxjrVJ4WvJ+93cqrN9slNIofbwWR49VxFIKbkDjDQPDuxA7Q/ej54iQTQOfvpd9pNLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rYyOesV0; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-295d27f9fc9so462816fac.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598088; x=1732202888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=573A7VIJaN7Phef7EPro6/84rHuXaF2Ar2GUBUbETSc=;
        b=rYyOesV0QfwRWVm1PBYChCs1Y4zCFiNHzH9R1LQaPnj2I8tT1iPTBnN31qKM66drKa
         ztxK7fRNyFXXLM/ckR1TTL3eSG9kYJpCrCGc51hfexhpkcnHvLwcZutL3r1GsGUzsaOH
         dv+7AHgPXl1JMdeWYXi1svCXaQ5X6FSFMOiGdy5M0+ymXDb6scAwHTySb9Xr9WUFmcNC
         BESPCPmyvEuqPgrLOhMtZSKuLRYN0js4dOgSguoXXFLublShL5XNWGbjzgx9Xn58vGUI
         OI7bAdPajtubR/yBEm6NRIkX7iaRt1+zNKye4zI5q+6N/m2lbdzvOJ4IlOP3mrbR6B5V
         x/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598088; x=1732202888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=573A7VIJaN7Phef7EPro6/84rHuXaF2Ar2GUBUbETSc=;
        b=CPBQr9hD3jY13i+Wjo3w/8g+LsXD9NDzuD+N7VJaT9k/Vt0TJ2ZSSNUYLgG7KU60Kz
         P+8d2KkRi7JB7gjvLBUosuOpG89wpoRxYZBlqn9GK2lkODxaOFqjlpusYRKd2ciSh+MO
         OfJASPSoWku0m/eGtnrfXabrvOd5hM6O/YlP8iULoG90+nX5jSWn5tJNnyJtzSY89Xdr
         7IULrf5O+wnFxOkWSUFSlHK0RHlswRDqWdHxJl/AZGo9MVQlii8siEFL7viXMs5cnRCQ
         JoEVfFo/0gZEh9r36c0MErbrg4DrIsKPkpslzUyil8Q8lKXhjv6jAk/XpX2WyuikRqh7
         pHlw==
X-Forwarded-Encrypted: i=1; AJvYcCULTHQEefJOASYLysC0iycPnNneaAG5MRgJnctqRJjApGIF36zwTvj8hYZRv9ML2nHeTd1+sz8CWcen4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdgNTvsPHVg2fStx7ITWBhE9MDxTlF3uAl+U+gJPXYp+HsUyg
	QuSAgaTgSI5Ui9IYS9swbR3Ay86rLv5RHZgZYH6G7rOcbGW4ycgkVlhglxGbOLg=
X-Google-Smtp-Source: AGHT+IGRJhbG3Iz8YyLsc6/0RWtRhZhYbcSZVTwigVtxhi/CGcrJEwq+4Kef8lO3NDoSjpzlANfJNQ==
X-Received: by 2002:a05:6870:5312:b0:286:f24f:c232 with SMTP id 586e51a60fabf-29610696786mr2665053fac.42.1731598088623;
        Thu, 14 Nov 2024 07:28:08 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:08 -0800 (PST)
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
Subject: [PATCH 05/17] mm/filemap: use page_cache_sync_ra() to kick off read-ahead
Date: Thu, 14 Nov 2024 08:25:09 -0700
Message-ID: <20241114152743.2381672-7-axboe@kernel.dk>
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

Rather than use the page_cache_sync_readahead() helper, define our own
ractl and use page_cache_sync_ra() directly. In preparation for needing
to modify ractl inside filemap_get_pages().

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 91974308e9bf..02d9cb585195 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2528,7 +2528,6 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 {
 	struct file *filp = iocb->ki_filp;
 	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index;
 	struct folio *folio;
@@ -2543,12 +2542,13 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
 
 	filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
 	if (!folio_batch_count(fbatch)) {
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
+
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			flags = memalloc_noio_save();
-		page_cache_sync_readahead(mapping, ra, filp, index,
-				last_index - index);
+		page_cache_sync_ra(&ractl, last_index - index);
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			memalloc_noio_restore(flags);
 		filemap_get_read_batch(mapping, index, last_index - 1, fbatch);
-- 
2.45.2


