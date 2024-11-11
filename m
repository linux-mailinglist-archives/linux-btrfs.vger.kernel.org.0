Return-Path: <linux-btrfs+bounces-9463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314D59C4A63
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 01:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DDCB2C448
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F0A1C6F59;
	Mon, 11 Nov 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WQNrJj/G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9811BF7E0
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 23:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368932; cv=none; b=LUy/yzTJBDTLC2ZQN0iEkx/g8tXt6PdaAka6S6L3hcYC5SRt3A3ViPKVHRa+efg6pLPWWnvNyxMIbvrs6u5nehGswLRwJ9Gbg3gGlrlHPqg2ylpxN74cEhqX0KHQ93daGzLt/JOyRzBxll41Q/qMrKnYPc3Aul5F5sxij955WPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368932; c=relaxed/simple;
	bh=wdE7j3SXsvf8mZ3WLeO9bDbqT1xBl9uoI5Ta1MifPnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrqRvHr61ZgDMIpfHFhgByZxV7gOeyeTH1OeBp29O9xb4YkGszTuyOUDkhHYtPxXwBNj6ugzIz/coNuYwVlOYIwf+A6PHmFdpNeIwa05K8B2mw+dBjx6ZFGA2g/R7r8a/YCEWMOzIQvL/1ZZsbEz198jQX2dNJqBCro7TSUPZJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WQNrJj/G; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso3638446b3a.0
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 15:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368930; x=1731973730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=WQNrJj/G6/aAoHDvOTSaHAPL/lSazwCCTJ7q/uUf0pSMKY+ehGBWUDahZQHQpLnDS6
         H1yNxaaRUpzjIT7CZrfu8s5tfNhRr6Bn5Me+uSbkX7suRGIpGAXfQdHQDOvIbNzHenM3
         XXhM+mF1nYdDbXK+HnT0Kfhv3eHczegGCLnBDArv56n399YX0vdS/fPgxeBG/gwP6+NJ
         eeUjji4l7C+BhQxKjIpKCY3hOkIM8UmpjO/2+Y3+ZhIcJCgc/nViVYpy6qlIfDPVzATd
         asLPc8SUbP9pvLF+RYiAIUzBzUIHVB+wHIpS9CWj74VEX3ZLOlFN+ho/SfyWGoRUE2Fz
         TFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368930; x=1731973730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7YIma1TSdS4GVKncfhre22V8DGIHalzmKUoqzgwI0E=;
        b=kDbwlEJxnciEsQwhqhVy60mIdXULrzQeBxpTJYnCXHGUAqIPlWncJPKPOp9uD5p9v1
         3m7Pu5bqEB9sXmiUvsIGwk67HidhVLqCdMM/E+MYLmMZyILhftEp0BSkm7fPb1pNS8Tg
         cHhlNHluUSUUQUKoHIL2z92LP2GCxUQqnoRD0U2ZiWDOgWTIrOO55rtIRRT+telOZRys
         g+MD2qxdstmkrngBbmb3ynSzQzLfJaZeeQqTTTErLSy1FKRF+j+yTtmwLmHz2CsWPkfc
         p+Auryf45cPZRjpJsWJ6oeBdji/7NJFVf4BFr/uzb6Br7sCUsVC306uAzZWcL1nU/E1x
         upKg==
X-Forwarded-Encrypted: i=1; AJvYcCWqpcwornosId2tuLMe0fkb6uRX9SNhVEA/uZikKecudJwcXqwK29RbQQiJPQ4O3w/FmarVDOf7aqY4OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqdLQKSnrDHgma2SAsOdEgL4oaqARyo0vFTUVw4LPoUUnbH/az
	XT54w+fpAoMm42WLQWFLvPyxmQL9l7oT6R2D5mmK4htqY2nNejTIBFn7YmK82yXIpo3eyE5SXys
	a8gg=
X-Google-Smtp-Source: AGHT+IFIT751yc6PWfScZ6t4wwtYiUFG2/DBhEvJ8IDhssjBxrF1+5xRFKTmZX93Ms0bG2KlEc/8GA==
X-Received: by 2002:a05:6a00:1801:b0:71e:427e:e679 with SMTP id d2e1a72fcca58-7241223447dmr25540831b3a.4.1731368929963;
        Mon, 11 Nov 2024 15:48:49 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:49 -0800 (PST)
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
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/16] mm/readahead: add folio allocation helper
Date: Mon, 11 Nov 2024 16:37:29 -0700
Message-ID: <20241111234842.2024180-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a wrapper around filemap_alloc_folio() for now, but add it in
preparation for modifying the folio based on the 'ractl' being passed
in.

No functional changes in this patch.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/readahead.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 3dc6c7a128dd..003cfe79880d 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -188,6 +188,12 @@ static void read_pages(struct readahead_control *rac)
 	BUG_ON(readahead_count(rac));
 }
 
+static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
+				       gfp_t gfp_mask, unsigned int order)
+{
+	return filemap_alloc_folio(gfp_mask, order);
+}
+
 /**
  * page_cache_ra_unbounded - Start unchecked readahead.
  * @ractl: Readahead control.
@@ -260,8 +266,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			continue;
 		}
 
-		folio = filemap_alloc_folio(gfp_mask,
-					    mapping_min_folio_order(mapping));
+		folio = ractl_alloc_folio(ractl, gfp_mask,
+					mapping_min_folio_order(mapping));
 		if (!folio)
 			break;
 
@@ -431,7 +437,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
 	int err;
-	struct folio *folio = filemap_alloc_folio(gfp, order);
+	struct folio *folio = ractl_alloc_folio(ractl, gfp, order);
 
 	if (!folio)
 		return -ENOMEM;
@@ -753,7 +759,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
@@ -782,7 +788,7 @@ void readahead_expand(struct readahead_control *ractl,
 		if (folio && !xa_is_value(folio))
 			return; /* Folio apparently present */
 
-		folio = filemap_alloc_folio(gfp_mask, min_order);
+		folio = ractl_alloc_folio(ractl, gfp_mask, min_order);
 		if (!folio)
 			return;
 
-- 
2.45.2


