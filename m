Return-Path: <linux-btrfs+bounces-13109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E00BA90E02
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 23:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2BA3B1A5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 21:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4923FC41;
	Wed, 16 Apr 2025 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="zzG/Xqtx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C66234963
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840237; cv=none; b=MvW+V/D+pwxYxM08hJdUgY094G8vL0MPTEAYQMaOcb4LKkrOTsGbcTdI67TfHNCt5xAZe0P5imsRy6psTdHXL+DZZGJhqBXMQNVj/mpL+x01qcVXka5RPZ4uL83PgbKsFmDNaaM7SecS5RhyRiTpTyfYuhRrTchWRNSvHBkSNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840237; c=relaxed/simple;
	bh=npvCoMFmqnvtVPS/BKElnja4Eyqhm5NE7nfkD4v9AMQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zwak574w8iZa0DBqzHF1h3bMMUj15xmt1silZ/j0XAsB/Atv+VUi7HmWzT1TOGpJ8KFAyy9R1fUYEgGijF2IwItjxMfkVmUuh4O+HH4Z1EWWdcqIojuiWdf+dd9cIVc8zDJoDfqUSJiMOE3rGjWxY57zbjgFl9j5cL7DZDDhIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=zzG/Xqtx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6e1cd3f1c5so154804276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744840234; x=1745445034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndvw8hMR1+i2zWzq9orHnGbavKtphos3OGpZoYszMUU=;
        b=zzG/XqtxvI44b49nrWqmtzDfxMUonx8F6oZ4qWUaKeI5hXZZJDCjahJAf7LbudbIFE
         KFV8GvkbWJuW6OY1ee6Pj0cfx59cfv1TyrDNZANohXIJfTiOfKGhLF3VHYAH+ywWDmc2
         NnmfYLeAg0fDseWgIZkwABsRg6PaDNH2d2O/DWn8kkHOHZbuQAgCqdZUyp505uHAlAuo
         s9/HPe3ekkYGcVlxvXINvAnqXyTboJcoYArAaHR2XrSZA5djvsgFomSL87eYrd1t9Cim
         yetzsFFmV2fmiwFGIx3XYCJE7xM8+EUGnRJL0y859U5ozpr3KeYi2br3SOFb2K10GiLu
         DqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840234; x=1745445034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndvw8hMR1+i2zWzq9orHnGbavKtphos3OGpZoYszMUU=;
        b=khk0F5H2QfVfrts6SxaHBsYsLBrQkoBzxcGg0lRMyTWopfxzgMyaHgDA2MeJlfpYRe
         OJTTjTRkhUK8riTJVtll9XqrByiRaJpXAsNYVExhbrtYm3uWhWXoTDJ1LqN27qhyqluo
         Dq8A1vd670mzRPlQWuG/4SHSazAE8E0fiP2FB16zq4W2avq4jHha9iEhBL+q5ed4kUKh
         8DzYiRs5Zna8XWP/gK1Q1ppyg4ujf1g96oZfEFoOoozONalrxrkaGvtcb/ss12o0zdC9
         3DRUPY4PhyDV/P8jSpSKC9JNSWXbPWUNijNgs3yP8+/wIrsjxGUqAAO1WyVv2l0vkdWX
         mGdw==
X-Gm-Message-State: AOJu0Yw76BwpCjEqQVL9TkFT/mz9ZbBp6UB/lZV4B8WGgnUUAT3h9dz+
	9xmwxUni1hGk4UtIbq6D/MglF1EWNRDTEVFMuVGo1IQ0kic+ybJ9BzIYU+Urr4wFsh6wVnRRWmO
	RK88=
X-Gm-Gg: ASbGnct6JLQfUti5XAFExdyivx+xhcZlSZrPHzqZFQMStaeOd3N/FlqzF0b9Tbm3MLy
	+KVYypc+NFajVvbeizPtU5xAGBGCmTI6iixqcYaOU4YEwlsdNG12a3rhbYwvNd2xv3G6Drr+edS
	R0bH3JTm6pBKDCZc+KM1JFVpEmr71KVJs+SMrJ4oOIymML3QNnPb+lJzv3rykYj5DGBS/dJgJii
	En1UF98B0uqsH2qQaaFYkJ5XlgoyD2qJuIc5TvQIBe7y6ojTPQj/RwAW1QlV267WH/70rmaGTjo
	MFDz5aYlRmURx3jyVLCbj4vLJtpm9oLqcbBDN1nrqcZyf1Jyze72lHLF1erRAoGf/s6F83NlPad
	Avw==
X-Google-Smtp-Source: AGHT+IHv3H8JOmniiR7CdQtGg04bK02WIpB39niMRfb1Pig0J0b8NEOAty2kBbf0SKrk41Fd6oeFlQ==
X-Received: by 2002:a05:690c:3704:b0:6fb:b2de:a2c3 with SMTP id 00721157ae682-706b328eb09mr46395507b3.9.1744840233981;
        Wed, 16 Apr 2025 14:50:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e11a796sm43774237b3.41.2025.04.16.14.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:50:33 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: set DIRTY and WRITEBACK tags on the buffer_xarray
Date: Wed, 16 Apr 2025 17:50:24 -0400
Message-ID: <0eb287136c9a3ca45fceba7ecaa688a7c4d2c303.1744840038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1744840038.git.josef@toxicpanda.com>
References: <cover.1744840038.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for changing how we do writeout of extent buffers, start
tagging the extent buffer xarray with DIRTY and WRITEBACK to make it
easier to find extent buffers that are in either state.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 309c86d1a696..dfed1157ebe1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1801,8 +1801,19 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 	 */
 	spin_lock(&eb->refs_lock);
 	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
+		XA_STATE(xas, &fs_info->buffer_xarray,
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
 
+static void buffer_xarray_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_xarray,
+		 eb->start >> fs_info->sectorsize_bits);
+	unsigned long flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_load(&xas);
+	xas_set_mark(&xas, mark);
+	xas_unlock_irqrestore(&xas, flags);
+}
+
+static void buffer_xarray_clear_mark(const struct extent_buffer *eb,
+				     xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_xarray,
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
@@ -1921,6 +1959,7 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 		btrfs_meta_folio_clear_writeback(fi.folio, eb);
 	}
 
+	buffer_xarray_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -3537,6 +3576,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
+	buffer_xarray_clear_mark(eb, PAGECACHE_TAG_DIRTY);
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
@@ -3585,6 +3625,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_extent_folios(eb); i++)
 			btrfs_meta_folio_set_dirty(eb->folios[i], eb);
+		buffer_xarray_set_mark(eb, PAGECACHE_TAG_DIRTY);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-- 
2.48.1


