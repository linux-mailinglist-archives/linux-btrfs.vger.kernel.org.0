Return-Path: <linux-btrfs+bounces-13095-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B201A9095F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 18:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAEB5A122E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870DC2135A3;
	Wed, 16 Apr 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ubHkqUm6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B421147A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822281; cv=none; b=RiGSxaWqqOb+Xk6Fz13mln+WhdCimRaA/lBVMnOVgia12437cGBqOmshN1otHO49lQy2yM5+/sm76BBA6buZta7DS1m2pRy/wBcmlkpVEHMXtVoVgiXZvoupOmitrv8fDcWnJN4Sw5Y9mCe4D4XygUPVEbLkH7MXESUCsaU3wKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822281; c=relaxed/simple;
	bh=ArCuQUYWobzO15BVYbZSjfOST6wDkFYzWOO89T4c3K0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEzZqeoBQlxv7m4rq2vXIbaZXqo3onKOmlHESnB8/Z3T8gDWRmQqjVkyR71Nz9wTqtayBvEvNWJHyuF9M898BJuWYS5PJHXakSFHPmF6aU2mYPtkB33tYSfUZKg4VUgCdcX+gam6MiQ6k1w/0tFdznA5Zn8q7WQt2J5smo9eqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ubHkqUm6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f6ca9a3425so84431347b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744822275; x=1745427075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s55gMYFlKZvXZOi94hbCGDee4fMLSZXQOogOlC7otM8=;
        b=ubHkqUm6D9/2fl05UMlE6izP+2zYla+rcl3XH2jKMHnSSajF4y18N0rS2JZySNVaHF
         DoqbwvPrTGnnMprDX+wUOllWy6qOU7JjhxWM2QWAhfUv8OUAUIrga9ZdFV5Tmj2iBraq
         NYbYybCZvA/lJE/7OYIufnX/sV+vVdQfntB+/qnW0bW5u7dwnNm06jNi+uaIwHgUvzIG
         6Xm6X0QIsHFQH7KJjzRATINMVw8HUz0PMZx8AifOX/NdV6lBKbyhwHRR4wS03tXCI21Q
         JRxQM/qLNZplHnis+l9CGB7P+oee8vPUr27bMWjEHFd11Hf9fdJ8MY5MzJfLcTkmFNif
         teuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744822275; x=1745427075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s55gMYFlKZvXZOi94hbCGDee4fMLSZXQOogOlC7otM8=;
        b=CHwbFDp27XZTiMzEzt3K0AgCwSBQbQf8q0wL7nbFT1NZ/Qy96n30JOPQqcda639GUX
         TEab/fjYE6NAUGFYwB1NJ9ivEa/dJaQ/k1uwz6AjF10JrAqAvIz5AfzCYj6T4iOWfxwF
         jo4VOSJeZ1p1LNZd6x1FZA4SXh3fGm+hao/YH4DrZuNdNFRBHlIHFHaSoPhDLps6IxLt
         qdRRYGXiXRi1dkXZ3RJg3syITz+5NTeu7yPWZyXaVFum8rhwdAkzabEvAHxHwfP/1OY5
         EAZYk3lVB2ttZ1eJlzvNKS8fJB5qrL+boabtUmCGL/D0acCe3I36xEy0X9j3LBc+iRr2
         Cbbg==
X-Gm-Message-State: AOJu0Yyq0OF5+Y7o00duIzBP7rvfur1ANxGCyeDOBphKLilXzHjg+CC+
	o32XTlkf/2M+/HpVM0ODuXpyj1aW1Z/OFrBov+vhd+oGs+qHTbfvFd7OWCJx9ijcFi2xYyZCkyq
	SbOV/Pw==
X-Gm-Gg: ASbGncun5ZS0Z2+H8wlzqpzFpb59doX3im/slATtIni9gwyUsNLK4/ERrFQWNGt9cfN
	yMyYw//yY8pxSIsu2bUrhhH5vsSoMJjePV1k96O5bAttUlqg/YOZGrZ3BgL4sFh77aRjNKBTe4t
	ycxkoXriN31FQXwpV/iYRN2Ioknt/ZhRFcce81F37YVulws2EQCNmPoeT6xiYpQasD7tLqeD7ae
	P9KCT2WUyC/oX2pLM64sErB96ozvTl4/HX+gOJk9Q3/bsDgoEluO+uDKs5tq6V34WyFD94MiU40
	KzvLt42YisApMkWkTw4bPKMTmvSdHcll8SNtCxxpZGM6CtYWCv9gN9gd7hHBt2udccuO0N2QfSm
	HDivbKH3wHaid
X-Google-Smtp-Source: AGHT+IHx4OnQpI7JbybAW0JrpvHC0u1SqGwkXKrBxB2+4Kji0REPufq658ifVmrq5pSblJ8Nmkr8Qg==
X-Received: by 2002:a05:690c:7202:b0:706:ae3b:cca1 with SMTP id 00721157ae682-706b3364e95mr35219807b3.29.1744822275412;
        Wed, 16 Apr 2025 09:51:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e39ce43sm42375007b3.103.2025.04.16.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 09:51:14 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: set DIRTY and WRITEBACK tags on the buffer_radix
Date: Wed, 16 Apr 2025 12:51:06 -0400
Message-ID: <be7f57e6bf33ad8f162b2bc80620373731cc5e75.1744822090.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1744822090.git.josef@toxicpanda.com>
References: <cover.1744822090.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for changing how we do writeout of extent buffers, start
tagging the extent buffer radix with DIRTY and WRITEBACK to make it
easier to find extent buffers that are in either state.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6cfd286b8bbc..e5de0f57cf7e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1801,8 +1801,19 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 	 */
 	spin_lock(&eb->refs_lock);
 	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
+		XA_STATE(xas, &fs_info->buffer_radix,
+			 eb->start >> fs_info->sectorsize_bits);
+		unsigned long flags;
+
 		set_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 		spin_unlock(&eb->refs_lock);
+
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
+		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
+		xas_clear_mark(&xas, PAGECACHE_TAG_DIRTY);
+		xas_unlock_irqrestore(&xas, flags);
+
 		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
 		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
 					 -eb->len,
@@ -1888,6 +1899,33 @@ static void set_btree_ioerr(struct extent_buffer *eb)
 	}
 }
 
+static void buffer_radix_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_radix,
+		 eb->start >> fs_info->sectorsize_bits);
+	unsigned long flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_load(&xas);
+	xas_set_mark(&xas, mark);
+	xas_unlock_irqrestore(&xas, flags);
+}
+
+static void buffer_radix_clear_mark(const struct extent_buffer *eb,
+				    xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_radix,
+		 eb->start >> fs_info->sectorsize_bits);
+	unsigned long flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_load(&xas);
+	xas_clear_mark(&xas, mark);
+	xas_unlock_irqrestore(&xas, flags);
+}
+
 /*
  * The endio specific version which won't touch any unsafe spinlock in endio
  * context.
@@ -1920,6 +1958,7 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 		btrfs_meta_folio_clear_writeback(fi.folio, eb);
 	}
 
+	buffer_radix_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -3530,6 +3569,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
+	buffer_radix_clear_mark(eb, PAGECACHE_TAG_DIRTY);
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
@@ -3578,6 +3618,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_extent_folios(eb); i++)
 			btrfs_meta_folio_set_dirty(eb->folios[i], eb);
+		buffer_radix_set_mark(eb, PAGECACHE_TAG_DIRTY);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-- 
2.48.1


