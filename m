Return-Path: <linux-btrfs+bounces-13163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0809A93827
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C61B7B1F49
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C55A143C5D;
	Fri, 18 Apr 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lDj5u4wV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CBA139D1B
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744984655; cv=none; b=qaaYKJG9Hs/fsdzHvdB7YTR4Vdmgs5oNpEX2TRQz8MRP8wcSis3zbv5UW8UXWss081OQORZQl6k2k4mr8TchNMCW462dA4SXkzUA8TqgpuPMqBrDJaeFOzQc69yFBeiE+CbVppjIxHEcFQins0VO03G5bCULcNGCs5+CSNwXm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744984655; c=relaxed/simple;
	bh=Jc/YeElEGua0Im6JDWY7UsKTbbmcOMzYPk/TQIMVyx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+7k0cz8prtThaHWUMdy+0VlPSha23JXcKwyJUroKO24rTRadaUJlw7nRL26fCJvLT99HSmKh4anuhv5X+XyzTtnjYPfIyLaTIimqd2t5VJC36m2e0LcN/wAkXaA46mUg/6FzwBZFQ8ZKW9JWlVzLrKDtSvGD3arJQQEyISkXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lDj5u4wV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6febbd3b75cso17885607b3.0
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744984652; x=1745589452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fIuQARwpq2+osUCXQnSd4QipWa4ifNx3caGytGzJ20=;
        b=lDj5u4wV160AvhxaT3t/++ms5zOZN60buTBZ1beUjDktLjDk5NdBT82CPKKv4dbtAn
         AavGtxcR6Ipzng2k98rwxNn6SiH4SyOrNOZ6G8BA716qewlHcuhMvHorE6+sztrxkqKu
         sUPmqEMUpsp5HJu3B7vJkVkrGJVVEMx49HgigicCZIDM33UD1MPsPnSyOWWi3JFIwdU9
         8IjQ8Ofa8PNsMk6/I5nyo52VBfswPjEwrqXSlY900gRjQsec9UaY2wed9Fw7rwv/Big6
         o6/9qJYV0VQQNIDJZvpfdMHHYR6cM+swzUTJDJ65suWMEOxuHMpin1OSd4LiaT/VU1Zn
         wL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744984652; x=1745589452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fIuQARwpq2+osUCXQnSd4QipWa4ifNx3caGytGzJ20=;
        b=blpys9WOlw5zeP3sv/JEBX9wg9794L0SGPpuxUm6GBG/BFOQVP96o37QgdSwMpYmfH
         oXj5H0FvHCqxOqWjCq4tAh87137GFYCTOgwIcdK5qLvJwqpZD++KQ1uxlZuXvmH32kAj
         10Nzsos6BevAbQuZb9h6hd+fGN5n1OX7s854anjrJeH3UMngw1i7KrwGa24VuW51xara
         RC42eMmqD0Ir8ZEuDBd7INP+798olMqAShFfFpDXy6bjBVI2fzzZ7slpcFiGfMwwuikQ
         9BaUjd5rtDWRXGUn0GmDICBVrp27juALE34/cfapIaLw3laSuR08VrfH6TYHMPhbaSar
         bUtw==
X-Gm-Message-State: AOJu0Yx6a/7imBcs3SlN4PTR1cq4LuNQN1r6P1XjIgml7D6S1fqtdQ2l
	QJrrShVmHmmAV2mRZ7AkmNANoOqNPRNuA4jq2fjzWAFUKeUTtXhAP65Nn0MLq8u8uTNwrzbi5ZT
	x
X-Gm-Gg: ASbGncuXa+a1f7ojXMWiq+Fwe+YHcKQrbk0HYrmSRyTO2bGDC1Qe4hqHUCpCWh84L60
	CkxPtcD3w1whroV7E9g36hThdLbf5EhIqsc69fP1yXgSMGixmjdPJMqS9mf7+tYBIKQM4LH3fr1
	lyx1MPOovJXV6QjBtcjZYT+Hcuog7XfrC75PuniW0NQX9FssSHmf1iNptEdE2Ephrnx3iK0SOvk
	6r56iZ1fpJyVcemTT/oJSFEsmVQEE4KRevbFwSlfcTbvm8vEUinwNgn295bzHLXZfNsCEfWIpxO
	2j2RP6GiHogbrcVHsgLBPF1P1Ql0ssHICIJ985nXbuSOOlR18mvOKU6VI16f+i6lIv5I3dXOqxq
	Be6j6eLSwInm8
X-Google-Smtp-Source: AGHT+IEGchbjrVXh74pYZY0pAtUrShs0YHuZ8e0D57HGja9HZcYb6Uyuq3XUYsWClw0+1V3NTJg5dg==
X-Received: by 2002:a05:690c:6101:b0:6ef:6536:bb6f with SMTP id 00721157ae682-706ccd229e5mr34871197b3.22.1744984652313;
        Fri, 18 Apr 2025 06:57:32 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca53bc02sm5197977b3.87.2025.04.18.06.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:57:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 2/3] btrfs: set DIRTY and WRITEBACK tags on the buffer_tree
Date: Fri, 18 Apr 2025 09:57:22 -0400
Message-ID: <17df8fc5c719bbe63f6269ec4b2c7bf2df226cd3.1744984487.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1744984487.git.josef@toxicpanda.com>
References: <cover.1744984487.git.josef@toxicpanda.com>
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
index aa451ad52528..ef6df7bcef5d 100644
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
@@ -1888,6 +1899,33 @@ static void set_btree_ioerr(struct extent_buffer *eb)
 	}
 }
 
+static void buffer_tree_set_mark(const struct extent_buffer *eb, xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_tree,
+		 eb->start >> fs_info->sectorsize_bits);
+	unsigned long flags;
+
+	xas_lock_irqsave(&xas, flags);
+	xas_load(&xas);
+	xas_set_mark(&xas, mark);
+	xas_unlock_irqrestore(&xas, flags);
+}
+
+static void buffer_tree_clear_mark(const struct extent_buffer *eb,
+				     xa_mark_t mark)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	XA_STATE(xas, &fs_info->buffer_tree,
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
 
+	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -3537,6 +3576,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
+	buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
@@ -3585,6 +3625,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_extent_folios(eb); i++)
 			btrfs_meta_folio_set_dirty(eb->folios[i], eb);
+		buffer_tree_set_mark(eb, PAGECACHE_TAG_DIRTY);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-- 
2.48.1


