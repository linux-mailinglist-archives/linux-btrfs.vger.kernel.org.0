Return-Path: <linux-btrfs+bounces-6755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4AF93D90F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260421F24846
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51656149C7D;
	Fri, 26 Jul 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="f8yjYik1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA26149C4C
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022614; cv=none; b=XUdhaQgc1uBNWzMArpIPR9bQaDzCblp6XbC9vmeOELW/XO9O2nnbcV+h2vogFK4ENHMzOM+GSitio84dGyUW4+IoLVhFpAy0yvnB/NccJUqUfGEfv4ZgTLWXX1dfU3rgBBiYIYJ30j2DgtTjTcTtubvRKSw4bNrl8Kp3ppa+9l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022614; c=relaxed/simple;
	bh=udp684RkXNYbhUh8bSqv/xFVw2PxqgIDsDcnYs2xmkM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOt6C5EggRqhVHNOlJOVdlhKTF8+xqWi+9UaONxVmm/NYrQx5S4HE/MW80FOcGH/nhXuhLh0HtL5ZWA/CKNqrAKTsVmY+RFgxX8nAR2hTK9dgFIz4W60xVASBgZcEb4hM7uNIgsBTe8pNSxxbhOM87muQ0E8aZ2MwaepiIwsMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=f8yjYik1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65f7bd30546so308177b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022612; x=1722627412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U89LoR7x+SU8mlCoGzs9YXLEUTi2x66vs1Payvo+bvo=;
        b=f8yjYik1jW9kPa1zlsZ6/U+Xa/k4nP948CkkUcy8ugSW4ZOQpp2372okrjuWB97v2I
         lmVYrL19XM4CdPk3W+C5T8unmvXTIGeLiliSa6EdYiSQSWON/OlkeuLj/gsa/t3uXme8
         Nro0VdXYCIBCPdGSHYA1MxpsktkZbn16yHk/yS3+gvyq3nQQYK15TfugAwt2bAYNcUei
         TJRol0+Xl4o5v21VFUQc0c4DgdAzo/srkmfjC0MPTtqDMcSfuFre+4Do5s5R8HA8G0ZQ
         kv1Rjru/DeK4pkvfHXFswc1KvetnL+Onw3/959u2QaSW5c6lrTsGJCcbryiZuRFzehm7
         mL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022612; x=1722627412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U89LoR7x+SU8mlCoGzs9YXLEUTi2x66vs1Payvo+bvo=;
        b=dBZPkt9hE62HtfH8A343d55LcmSzDyFn+9BVErNR35YUMBhWl8qIVizdY1Y65TW2xx
         rHcy/lKJf6CXKLoa3hGcH3JQ5gJx64YC9iCk83wEgLUoMcwBw5ueytsvvJxF0mw4+xFr
         ZDjqgpeu2Rz3TAGEacadZ4mx9Zitjq8SMBTSWUu1L0jt2l4VdVzHUgGGLgTiBIKe/mWZ
         5u1SVTpzsJXeQWNstXJlPBgJ01PdvSg2hPc9ex2L6l75aU0LWWSFn3LaaJvsss2fGqUS
         vf/Ask8s8k6P1YcmLxXKNT5nDb36STWQuy8XitiGSGBkhts++p6EkMnluoZD1sL1Qplb
         eTfg==
X-Gm-Message-State: AOJu0YwUSDCD7Cr+QQbBrD2bLZgyD7RH4v8+uU60MqYBKwSBq4ZyBY0H
	D6/4czzHZop3Y3/ZhH9d1kl+0nnpCLp/Z6ftvh/ZaaiO+ZipR9/3O6J6ELxOMB5J5IE5j14nIZZ
	8
X-Google-Smtp-Source: AGHT+IEAbTA/shjtuVGRQt6h5pne8p5dusvScColQPXgVjW4WXRfok7P7iaYyOfGm0DB49nmwiThfQ==
X-Received: by 2002:a05:690c:ecb:b0:65f:cdb7:46a7 with SMTP id 00721157ae682-67a2dcf7ad1mr6690947b3.22.1722022611959;
        Fri, 26 Jul 2024 12:36:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67566dd91ecsm10014987b3.17.2024.07.26.12.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:36:51 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 14/46] btrfs: convert btrfs_finish_ordered_extent to take a folio
Date: Fri, 26 Jul 2024 15:36:01 -0400
Message-ID: <390ffab7d7ed61dbee07947874ab11f1d5e1d155.1722022376.git.josef@toxicpanda.com>
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

The callers and callee's of this now all use folios, update it to take a
folio as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c    | 4 ++--
 fs/btrfs/ordered-data.c | 6 +++---
 fs/btrfs/ordered-data.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index da60ec1e866a..58ff09368eb9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -472,8 +472,8 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 		"incomplete page write with offset %zu and length %zu",
 				   fi.offset, fi.length);
 
-		btrfs_finish_ordered_extent(bbio->ordered,
-				folio_page(folio, 0), start, len, !error);
+		btrfs_finish_ordered_extent(bbio->ordered, folio, start, len,
+					    !error);
 		if (error)
 			mapping_set_error(folio->mapping, error);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 760a37512c7e..e97747956040 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -397,7 +397,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 }
 
 void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				 struct page *page, u64 file_offset, u64 len,
+				 struct folio *folio, u64 file_offset, u64 len,
 				 bool uptodate)
 {
 	struct btrfs_inode *inode = ordered->inode;
@@ -407,8 +407,8 @@ void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 	trace_btrfs_finish_ordered_extent(inode, file_offset, len, uptodate);
 
 	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
-	ret = can_finish_ordered_extent(ordered, page_folio(page), file_offset,
-					len, uptodate);
+	ret = can_finish_ordered_extent(ordered, folio, file_offset, len,
+					uptodate);
 	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 
 	/*
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 51b9e81726e2..90c1c3c51ae5 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -163,7 +163,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry);
 void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
 				struct btrfs_ordered_extent *entry);
 void btrfs_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
-				 struct page *page, u64 file_offset, u64 len,
+				 struct folio *folio, u64 file_offset, u64 len,
 				 bool uptodate);
 void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 				struct page *page, u64 file_offset,
-- 
2.43.0


