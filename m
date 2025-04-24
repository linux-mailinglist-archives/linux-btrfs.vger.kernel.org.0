Return-Path: <linux-btrfs+bounces-13396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B0A9B667
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0507D9A3866
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E9A290085;
	Thu, 24 Apr 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YJ+hofS8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C742900A8
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519590; cv=none; b=kdmyjR3GGXrCWHqxcwTo9ZnwnOMpGaY8kjEfOlScdI/NjWBfRQU6LEmni8FgY/Opx2PdB9FxLQTM0s7BjeWlgscNKCVaNlUDZuWczOQpSG+Qfy5CdbPtOcaXM73cGrINzTyBTFnQnkGi3hzx8ze8nbTT3ZgGWJaHWHDhTz/iaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519590; c=relaxed/simple;
	bh=EEWs1a0KorlBRwXg8gl+UmLFxPBHc0DZ1i/Ne9g1/tU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtuRO8EGpXWyLCb3txIF3GW/aGurdEqf58kNGUvooL8vmP7ncbU8fOlVczMHu+8F1Vh3EIlJTB3PHcnUdszybmp0zpWdas0CR6JfjFTDvZ6nnWtkKQuWKwRt8NHQfAAXIbYEz52knliWvtwgZDJbt6H8ZBXxk7Ls3DMYgP9edsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YJ+hofS8; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecfa716ec1so14510896d6.2
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745519587; x=1746124387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sdi/HtdPhS5pHlh7e/R7e1kYWPFvB/mqh6tg+7MJ5g=;
        b=YJ+hofS8amSuqpxaHJWn+MBz6gv60kdYFJQGF32CoeHwC9WuBXNFYgBBsEhY71QkvC
         wpa7nPHsJJqv8HGJaIgbk9dpZOzacYKQGjSPMEbD22InmECDmfmZckCJy2EN43q46XGt
         WXlGkx5KOs028PxE3Epsa4O6WwSgzbqAzt6Ff8KacznNVeOOvd+te1R2+xcmUnF0W95T
         mHoQeBU7eg+Ymc6oQ9xxOofnCShk8IXZCFErAZ88x5wX4cvWiwzmWDpMV0S4g83kN7/b
         XWFpulsnw2Rm/p69ay4WRIEPVb7Z7+YZTmTazjGNck+sFUDrEu8XsSC/aAtANtvcfpYL
         BpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519587; x=1746124387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sdi/HtdPhS5pHlh7e/R7e1kYWPFvB/mqh6tg+7MJ5g=;
        b=k6buK/nuPbyC2IjxKMmRViAT2YCXCQu2tLY7mQssgAy39SK2lY6wMAoViU/H+ZaafG
         sQFkIZaJUsYkUQgmi4YfFk5jqZaj2es3c8D7X+2TXD3YI44SBrWP3BSR7AQ+x1StNjYE
         ByQqNpWs183DEZ+huZxp28VpDJJOGr6ITAaIFWZV4qXhIC/R2ZjPnAGbtxlp8hL6d/Uw
         E+X0mGs67CMsnQ2QzWxp37tq/e3d/CRrUHl6JVmJh5qX6sCacx2Sk8LJFq4Iz4qh8AYc
         ylS1o/4+in/WdYk9Z9B6nlPAaf2hdm8axZgBLuhilJLuQaCMAK1dTra7YdODqJOn4Twi
         7XPQ==
X-Gm-Message-State: AOJu0YxZt0YxX0M//Tejqk2/gZiWmDfkRVEuGoOrP/JpjAZCs12qxM5S
	mRKN3dp5qzAvUgcQIZYF5atfcjtAdPqJuYMXv5lUlvq4VXMk++ART25Kwq9ye2in/VyzE3J/2r1
	OqS0XMg==
X-Gm-Gg: ASbGncupLbY2ecS0DSDv4wucKvQlCQ6PbF2iIzGDjMFXaDho6aL7ae4MD57MDebPqi2
	dyxi1jWmcRBy+kFYZLto8SzEk1Domjo6hMSlpBKZ/NY7f/KyXy9X1kYL2F+mrmwhA+2qxmD5thd
	LAuNk5Imcbhp5uYYS9uacxStcQp6pw1nUrR2qmmb2IkjmtQtqmi6/15Ny2d9GciAj5XouN0CSMN
	LM1yWdItmjL2lsn3mHkhn1NzlPYKPDbzR7tkxjVW1zWv2zpcZ6J409ASXZ1p7Vjqu1cFArbElri
	XqoVs6OhO4RXBL8TQDYoDFfHDJUTRk6atLZSXeklP7Oz0XYksPFOQCdLj+BTpteo0L0mpM+6mhO
	uvQ==
X-Google-Smtp-Source: AGHT+IFNvpFZrt5ltTakCTONcZmQNqxqqfcwyArWBf6ICXBmDLqWNdtZKrXnM++kpe9CBg0pjHW32Q==
X-Received: by 2002:a05:6214:2629:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6f4c94a8b33mr12948246d6.7.1745519587275;
        Thu, 24 Apr 2025 11:33:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7aade9sm15038281cf.40.2025.04.24.11.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:33:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 2/3] btrfs: set DIRTY and WRITEBACK tags on the buffer_tree
Date: Thu, 24 Apr 2025 14:32:57 -0400
Message-ID: <8ce353bf1c249b65b526687c307cf113a31710a8.1745519463.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1745519463.git.josef@toxicpanda.com>
References: <cover.1745519463.git.josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4f861a8ff695..65a769329981 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1801,8 +1801,19 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
 	 */
 	spin_lock(&eb->refs_lock);
 	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
+		XA_STATE(xas, &fs_info->buffer_tree,
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
@@ -1888,6 +1899,30 @@ static void set_btree_ioerr(struct extent_buffer *eb)
 	}
 }
 
+static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
+	unsigned long flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_load(&xas);
+	xas_set_mark(&xas, mark);
+	xas_unlock_irqrestore(&xas, flags);
+}
+
+static void buffer_tree_clear_mark(const struct extent_buffer *eb, xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info->sectorsize_bits);
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
@@ -1925,6 +1960,7 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 		btrfs_meta_folio_clear_writeback(fi.folio, eb);
 	}
 
+	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -3547,6 +3583,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
+	buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
@@ -3595,6 +3632,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_extent_folios(eb); i++)
 			btrfs_meta_folio_set_dirty(eb->folios[i], eb);
+		buffer_tree_set_mark(eb, PAGECACHE_TAG_DIRTY);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-- 
2.48.1


