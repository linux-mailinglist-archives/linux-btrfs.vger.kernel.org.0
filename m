Return-Path: <linux-btrfs+bounces-13464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA14A9F3D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 16:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD671A81B54
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F353270549;
	Mon, 28 Apr 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="f3KHsIrg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6526FD82
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851987; cv=none; b=XINLfdCspgOsdmAnitITgwYjFTrVOrkJIOs87fdVBXZINwISQPIAcLo6q2ccdJOfc60ckvXI3ZRT4aXAc/aUd6JEUlqIzeRFdR2tUPW6jyMZqW3IbPvdXrMU7/5phjj3rUarUcUWUHN7/Rw3kuKI2PtFwKojdMdPnGC9svCqFm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851987; c=relaxed/simple;
	bh=h6JnGb6cPDbbszLx67zS/RfZhJESBcmCU4c7ffyHpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfO7NvCHEgjWgVp66G9B+0cbO2HeH8eS9owBR3eHks7Y9O142BLXRZ6NXVMzEBffjq0bpQAeFftngag2D56zY0h+1TOEKpAYeQOLHpox+DLpe1dLwpvVmhwQYPb/CebkdIUC8HDKa231HiRns3uaDNFb/7QqeJwR98SUHsd389M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=f3KHsIrg; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fda22908d9so36738147b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1745851984; x=1746456784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxEjru/z+/GyIpQBNvHM2K5Vs+j3PC8TDX3AtT+NFc8=;
        b=f3KHsIrgDTkBKpwF8KDvrw57UxDVmDs13y+v2EAFTK12+/HZqYXL/YjBUGNj01gCQO
         YOFC1BknQM+sdPzq7sZPHJ+96TX7Yyoae6Fyd4N9ZwQBWkJSLQiinXO9x0XZto78HWbX
         1EakBaTUwNud9TwD5xh1IqD81xMxduIEGDrTgfzkW2ypngPVcbwRPu6VUdMW2BwEPltZ
         YV3JVjkm0JOOxC4gQoIlqpC1Vrl6MMXHAQusvh/IkehTinxEd6n8qlJPlZOVexOOWkKf
         jVyPDVIq+tAX7tNPsdSp3Xn8dvtbbtinr79L/I0UaLegd8JBO7hBahBB+3dLBJ2SwfhN
         rx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851984; x=1746456784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxEjru/z+/GyIpQBNvHM2K5Vs+j3PC8TDX3AtT+NFc8=;
        b=bSu1+O4McAef4+lQPDSC+3OUNPot5rd+kKWieXJZ0nRjULoDOHdrOxJdRV3jL88OhP
         MOYHtYsjrstOKE3O6H0S24BENWVQ02ytXfejMSfSFydrWQe14ngM4KQosz9kc1vlFgfz
         cWmgQvMCc+LaoClHAxFmVQYQFo2a5lrAJ7L74r8JqKaMfJ3fEXxUCeyQ0hVy/Nqec+Ob
         EOMB51J7o7VdSDUwMBEIgBcSUhl9eprri+76CO7uxjSnElQi+RjRmK1F50gvSJoLm+9q
         pbKYjrxKA+azY3JcllQKKhYykWeHBxN671Xmo/KgmFOxQWqYO1/2ky8/lbEojzQ7sP9G
         tKiw==
X-Gm-Message-State: AOJu0YzpimA8bA+ic7kjHLBHHK4KzGq07YZtgBngPz7nsigbkNNqthap
	dE2M00ioTsunsEur1OM2k6MhuXerc/or67sAb2wFANmdv9OHFEO6FQ52/FEymIcFpyk0VPw7hkw
	c710=
X-Gm-Gg: ASbGnctiqFdoXUTflhSpSf8M/wPYI4bK9vvFlnOaS12Cg3/riu2mviWjh3wD4kXM3wL
	Xu3jfLj4kp18hntS05HbFOL3BzsQ3WY1dPwe/tVphCGv/g7kpTNzr8cCHYzktSxh/dpgKgaGhyp
	9F+pq4Hdqrvw8UgecjwhKgbaxIA6B/wbkdPj9YCscmDWa2fPCiMybAEJdGXz/oXbpP64SP6P9Of
	OucXEVB6U91Rt+EF2vgtwL/dmfRE7q6pwTk4EniZC5PlHjRPaz4pvQAyHQKAAp34oNJxzk6yNWU
	maXZRgGSLTHfjADLMqLkudf9b+h4kvHWGhekjw5kcUAOqXSKkAMBFq45O2CoBPg2h50w5rfOerp
	6ow==
X-Google-Smtp-Source: AGHT+IFKkrr8/01YXxi7rrG1JOXelCBt4J/NqUy2oiEylix2tHzrQ3quv6NKepk8vsWiOdF2ca3cBw==
X-Received: by 2002:a05:690c:688c:b0:6f4:8207:c68d with SMTP id 00721157ae682-70899640f3fmr239617b3.3.1745851984301;
        Mon, 28 Apr 2025 07:53:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7084195afffsm24543997b3.41.2025.04.28.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:53:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v5 2/3] btrfs: set DIRTY and WRITEBACK tags on the buffer_tree
Date: Mon, 28 Apr 2025 10:52:56 -0400
Message-ID: <5a2c3d6f1eb9dd2e724d581fb8189e4d8b639fd3.1745851722.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1745851722.git.josef@toxicpanda.com>
References: <cover.1745851722.git.josef@toxicpanda.com>
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
index bedcacaf809f..daab6373c6a4 100644
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
@@ -1918,6 +1953,7 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 		btrfs_meta_folio_clear_writeback(fi.folio, eb);
 	}
 
+	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	smp_mb__after_atomic();
 	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
@@ -3544,6 +3580,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
 		return;
 
+	buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
@@ -3592,6 +3629,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_extent_folios(eb); i++)
 			btrfs_meta_folio_set_dirty(eb->folios[i], eb);
+		buffer_tree_set_mark(eb, PAGECACHE_TAG_DIRTY);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
-- 
2.48.1


