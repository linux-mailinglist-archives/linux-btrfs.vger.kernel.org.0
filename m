Return-Path: <linux-btrfs+bounces-6762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9040C93D916
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFCF91C227B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47BF14A0A2;
	Fri, 26 Jul 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xWhTrxFH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933024F218
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022621; cv=none; b=ZdszY9x8A9qHyfycmKhVoOW0oUc5BIqeDJ+1YTcNmE029idLphIcUcRi16xKLdDjYozkrJRcCPruElWrXj3YLm65V8o4cvjL8QHm0FAPCru7PtKmWBYeI+hrfYVO5Ukm7frpvE7t7T/5+Ob0JamsmivbLerzSaA4q1VCMvnXz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022621; c=relaxed/simple;
	bh=zhmQJbZdHkNBZ6G5bU+E2kNgl1KSNHA261epgdN0HBk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQxgjfHCmW9GdhCl8SXqLhv0cxe1kW6vWNWYWU9JfSU8HyJ/mMLeYanSUusHy7B0dyyws4+FkW0LSSFwGGc1iTBzcvAsOq3iMH5rWTScq+PJYKRa2Bm8m1KclbONy01R1x2DQI1/7Tc85QVT7V5ETIZoIJnFECM0qfKMKIvbLPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xWhTrxFH; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0b167da277so21530276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022619; x=1722627419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPn+S0axWk5wx0jNFvxs9ojQnS1R3d3jhq9+IGiBmLA=;
        b=xWhTrxFHhqnnIfAyj+dHeP9pLpX1FMpTXfbZ7ha5SJYJMp9FFimvaw0YGZQUq2aOly
         cQyf8f4ch8Qo76PY8WyBqXaRdZCF8Ynj/vV4E5EcbS+5hMkynorw2usLqYG3Zny/cO/f
         w+hK5BG2+y+T+Ax/qrkfEqNDj9WP40uzcCkcCPJ2QGXauftZxYljar5h/t5BTUrU1e5+
         tR27EAPukC29RVMRsFpIYWYsJx5x/CbX2qalsxClIMSsYUg5RRgivu6LRMK78q8t9K3K
         rBl3owpay3tdRfrlKuZ1ka/T5CHgBpRd/e5m5BtYW9RAfyZdSjAzvFxOVMZcbqKOzGaa
         ReBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022619; x=1722627419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPn+S0axWk5wx0jNFvxs9ojQnS1R3d3jhq9+IGiBmLA=;
        b=xAANgFrcO/wW4/vuJTHNHv13AhGbAftL125hIUhqlqLH6b9Quz1gy3wVqaOF/DVCEh
         gEm2C/TGxb+2BmRHSHY97q+AKsTfnMA4wqYyoBxhIkzrTZJfYHOeUviztYFoAYJ6/6gd
         b5689lUw4PQ5mWsGu/0Ima8fn10qCoz0ONZVYzVJQQxTC6XkzSdXq9/r4sR1KtKUCs6F
         TbDuAbzhzmlIw8Y5U8F4FeqVXbdKnmjJlyk8t5ZlLrTzvtUL2yasMWIJxotiBH4p0uYZ
         qiUKIBzaNBUk+Z47JpC+0Bwa8EN64i7FpAdk/j77Ax4QXBty3LmkODS1GSouYcqonG/K
         at1Q==
X-Gm-Message-State: AOJu0YyA4pIPkixZv01gMlVWf5sYxTqchrZ7SX7fncRtEw3I0KWoGmgM
	GzH1gRaTZ+RpRpjHZ2SyiLhphZ4sI86Ebhtj2igmV2TpLGWfRPhTwZTCO96l8b8/Vlc7CmoK/LC
	w
X-Google-Smtp-Source: AGHT+IG+h214BhWwbPul+jCELALj1eTezGrg7VI/oMpRKIHO2crP9z2YtG+bNQmncFulvb3O69TpMw==
X-Received: by 2002:a81:6905:0:b0:65f:93c1:fee9 with SMTP id 00721157ae682-67a05c8b8f9mr9835637b3.9.1722022619532;
        Fri, 26 Jul 2024 12:36:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e7d3sm10030507b3.32.2024.07.26.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 21/46] btrfs: convert process_one_page to operate only on folios
Date: Fri, 26 Jul 2024 15:36:08 -0400
Message-ID: <8516487d309169dc2c7efadde01b3d29e6aa6038.1722022376.git.josef@toxicpanda.com>
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

Now that this mostly uses folios, update it to take folios, use the
folios that are passed in, and rename from process_one_page =>
process_one_folio.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d49f3adf7d86..b944dcd9e941 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -164,11 +164,10 @@ void __cold extent_buffer_free_cachep(void)
 	kmem_cache_destroy(extent_buffer_cache);
 }
 
-static void process_one_page(struct btrfs_fs_info *fs_info,
-			     struct page *page, const struct page *locked_page,
-			     unsigned long page_ops, u64 start, u64 end)
+static void process_one_folio(struct btrfs_fs_info *fs_info,
+			      struct folio *folio, const struct folio *locked_folio,
+			      unsigned long page_ops, u64 start, u64 end)
 {
-	struct folio *folio = page_folio(page);
 	u32 len;
 
 	ASSERT(end + 1 - start != 0 && end + 1 - start < U32_MAX);
@@ -183,7 +182,7 @@ static void process_one_page(struct btrfs_fs_info *fs_info,
 	if (page_ops & PAGE_END_WRITEBACK)
 		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
 
-	if (page != locked_page && (page_ops & PAGE_UNLOCK))
+	if (folio != locked_folio && (page_ops & PAGE_UNLOCK))
 		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
@@ -207,9 +206,8 @@ static void __process_folios_contig(struct address_space *mapping,
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			process_one_page(fs_info, &folio->page,
-					 &locked_folio->page, page_ops, start,
-					 end);
+			process_one_folio(fs_info, folio, locked_folio,
+					  page_ops, start, end);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.43.0


