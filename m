Return-Path: <linux-btrfs+bounces-6778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4893D926
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 21:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4699E285AE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F397153BC1;
	Fri, 26 Jul 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DvwPSxUG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96915350B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022638; cv=none; b=pLjP/G8ubfA3io6lTKEjdhGNGQs5rifSMIfNgXSm5qJERnMQTC2W8ZbTaq8Bb2uWky3al7khlUSHv2KJHXZfnoZ+mkLxks+GtQ4EVW8m4mZEO7EXTkkATBeCdBhll3yq9X9PgG5grKvDYJh2MeLTgdVjrwX1uvkoVYIzJtwPYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022638; c=relaxed/simple;
	bh=52yhmVRldo6fhrshj4UeNjlQ9T2sASylyx7e9qIOR0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5edXviHccDoZxDU7E52yz5cmIHVulcfkML0ko4oDFDyj3S8ohqaMPaxgPQSGINLKOltdBYGWX9XotwAJMMhwNqDsHCQtEnbYEo/sOHao3XKQl9OzGG5t9kpxIKn6mp7WYhDoTRQtz/l6yJ9xvsXwDQvbQ2LE5uzXmaEN/p8bQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DvwPSxUG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-664b4589b1aso304487b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722022636; x=1722627436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXkL2cHHcMIysYGbARqm/QB30uEPhELGuHXflxiPSGg=;
        b=DvwPSxUGCe/6svaaC9lwf9VT95oRmUMmGWeCQ1RfCTDt8fEGd6CNVsOuq4m8BhrtmG
         OPGbzCju1PBjYUlgAl8Gqp4wDuhPKjcuREf698NfRMsA2zhHUJJZkHOAUK4Kb+3GhjS0
         WX2mFGCTEagzWHdFOtO2bBkzeEbPgQKLpyzHhcdsIfhvvkbs2XArk35U/cDCDKgkuDNz
         QJkxT8qV3RC1hWaeMnwUqb89ZBpNFLhaHGCBKBvb5v1WTE6g+FQoPnVKMhOk/vXgALP3
         vRW5UE9uKy5XX9aWBxz+een5ATacrAQ4q28BuGOnbdyKA/yX0TQ45uxyVwYqpNj1ONOh
         ywWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022636; x=1722627436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXkL2cHHcMIysYGbARqm/QB30uEPhELGuHXflxiPSGg=;
        b=vESouWa51qQ8JJJlipWv/Nc3HcNqa/fS0jYdZCfbIF3GwhABDpPRylkyghBapBd4dp
         pjINgFawULpWMObFfXPsnhBEP0MWxDo5lfB/pWuslQsnLTpRTTA0fmBbsbsVoWpRhCtL
         5u1zdpI5762zmeIDZwnRq7n22EPA9GRSYK0f2/rmkvRwz0YxyjcINitf0dCZVT0e3259
         7IGDlBqSHFNFZyPMCJs9fyZymerzVfMusSTOPVu7Fn7aXpNA7lKOK5I3NJDPhNar+RqQ
         ML5TgyOY6XGnrioREq6g824KzAqN1dZYhoN5j4S3iNiA87rwYlbNRXjgiNH6/tRlvmRP
         /8zw==
X-Gm-Message-State: AOJu0YzA6kZs7dniX3ca9uSrN5792QMo+x1bW9yLzMcSaPk4uW80LHhA
	40SOzAgtcFDY0CahHc04GoNrJGf9MxLD7MwIzQLAHjthq40jnTMLXA1/pkqOWGlzVEpopAmzdiU
	P
X-Google-Smtp-Source: AGHT+IFr/h4rnpeUNA5mbwDoIkZ8BTqwb33FWDL5SgmzFrC066nIu+zc/mYM49DSqQLr/kteMIgOng==
X-Received: by 2002:a81:b54d:0:b0:62f:aa9a:93c6 with SMTP id 00721157ae682-67a29bfc4f8mr6250967b3.8.1722022636441;
        Fri, 26 Jul 2024 12:37:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67568113cf9sm9986107b3.70.2024.07.26.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:37:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 37/46] btrfs: convert btrfs_writepage_fixup to use a folio
Date: Fri, 26 Jul 2024 15:36:24 -0400
Message-ID: <d7a77c2bb42621caabf9e14208edce3ed94a889a.1722022377.git.josef@toxicpanda.com>
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

Now the fixup creator and consumer use folios, change this to use a
folio as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9234ae84175a..0667da7b1895 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2695,7 +2695,7 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 
 /* see btrfs_writepage_start_hook for details on why this is required */
 struct btrfs_writepage_fixup {
-	struct page *page;
+	struct folio *folio;
 	struct btrfs_inode *inode;
 	struct btrfs_work work;
 };
@@ -2707,8 +2707,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
-	struct page *page = fixup->page;
-	struct folio *folio = page_folio(page);
+	struct folio *folio = fixup->folio;
 	struct btrfs_inode *inode = fixup->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 page_start = folio_pos(folio);
@@ -2872,7 +2871,7 @@ int btrfs_writepage_cow_fixup(struct folio *folio)
 	btrfs_folio_set_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	folio_get(folio);
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL);
-	fixup->page = &folio->page;
+	fixup->folio = folio;
 	fixup->inode = BTRFS_I(inode);
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
 
-- 
2.43.0


