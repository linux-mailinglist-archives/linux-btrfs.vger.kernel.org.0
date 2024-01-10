Return-Path: <linux-btrfs+bounces-1380-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CE082A3C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 23:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B5F1F27953
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jan 2024 22:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE094F88B;
	Wed, 10 Jan 2024 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="suODgXZY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D31448781
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7831362c9bcso357490285a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jan 2024 14:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1704924866; x=1705529666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsVSCiAGMovzPzrv1j6L94thx1gAopZQ1Abc0l5i2xs=;
        b=suODgXZYB8GoeBxhghkZ4QPRQgeqv1MGunc+HEZqe3IJzu7DoJSCnfQgrjxEOEi0GY
         KxnjrmPayuLJYZ8cgfQYp1WuhngVY+9FaBAycnAiVXRZUP6uXJaJeNLS2Fn+EgM+iKec
         3w3tE9lQsxvVJgbocmOT1YckLTqaYg5N1njUc9H8WI8AiaRqxIlO1YnavVasFf2CzkCv
         aHcHN/4839YjSU2CnFFRjLvXmGVYDea2vnS1GdHWZy1cMWXGHdmz1vcqHgHuLy11ipvf
         sA2gS+Ov4Cqdqw490VCmnWktbd6+9nNdeGqAR8cK/kPrff/2nJvvlj6w3ZqxRSnosXFQ
         XYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704924866; x=1705529666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsVSCiAGMovzPzrv1j6L94thx1gAopZQ1Abc0l5i2xs=;
        b=JCFOpFrt8+XsLF4FmIxHnJn3aaID1jfLzd2Wug9D/HyO8aougkhzOTZlVc2RDqVi3y
         M3JSU1zBrrS+yOo7y8Y/gsvO/N4wJMifWGj15rDxO9wDTJKiMw0nURxHI7dxirCbfyKC
         BxEVUx9dHF6WIxHK7p9/vDg7VESqcqd6YWdsVcZEirfapeUfpW99ZhduW5zUOmKxyP78
         cf9JhhRJe5+5yfEe3oM87nf1xH4P03wKXc711zRgARf+jxNYy1NdDfZKGWG2ML+enrX7
         cHbpukYRg7+Tj1dKloG+tdhcwU3EoIcqlXv2MT4XHE+XTHck1VxqdANUCgiOdbsR+lHZ
         M/2g==
X-Gm-Message-State: AOJu0Yy91RFihhVcblu/Xn3af4gFqnL6Vxanr1xHUv7orWfgGzasFdDC
	0Vtv0M47THS0LhCrTR2edc6kKYm8ePTA84NmLn9ndUok/NA=
X-Google-Smtp-Source: AGHT+IGBjSF8xCmr4uNzh6cd48Nl9PypkbIg2DT/pkHRIWDKGLlHJIIYi5qJbbu+jALo4ca8Ab2u1A==
X-Received: by 2002:a05:620a:2992:b0:783:20c4:663f with SMTP id r18-20020a05620a299200b0078320c4663fmr376926qkp.67.1704924865993;
        Wed, 10 Jan 2024 14:14:25 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g21-20020ae9e115000000b007832b078596sm1912443qkm.92.2024.01.10.14.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:14:25 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: don't unconditionally call folio_start_writeback in subpage
Date: Wed, 10 Jan 2024 17:14:21 -0500
Message-ID: <cd8e40a516d86d1c58a221fa8d964a04bc226891.1704924693.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the normal case we check if a page is under writeback and skip it
before we attempt to begin writeback.

The exception is subpage metadata writes, where we know we don't have an
eb under writeback and we're doing it one eb at a time.  Since
b5612c368648 ("mm: return void from folio_start_writeback() and related
functions") we now will BUG_ON() if we call folio_start_writeback()
on a folio that's already under writeback.  Previously
folio_start_writeback() would bail if writeback was already started.

Fix this in the subpage code by checking if we have writeback set and
skipping it if we do.  This fixes the panic we were seeing on subpage.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/subpage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 93511d54abf8..0e49dab8dad2 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -475,7 +475,8 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	folio_start_writeback(folio);
+	if (!folio_test_writeback(folio))
+		folio_start_writeback(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-- 
2.43.0


