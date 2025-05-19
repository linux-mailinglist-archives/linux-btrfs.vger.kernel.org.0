Return-Path: <linux-btrfs+bounces-14124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57650ABC6DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 20:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6322F4A4EB5
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4B289E04;
	Mon, 19 May 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CSAk+pXd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486281EE032
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677791; cv=none; b=n/k2Zi+DcFsL0aIoc8qQjOivWcb85Qr9jKViVXOUDRfOfBnZJTznfcniM1jT8yzhnrxIIFBSPDpJhKg7QTsVvnIbTZimKrScoJvEGU3FOo+wdEs3ryadsSOZetQCA/bdIY9qFB17kurbsQayKFXLhE6XNRbHm/Wqvy0DQQPC8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677791; c=relaxed/simple;
	bh=2ZbFDm00IN4naXaxn9c/iCrAk96ImgeDHCd4bT9//kg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Qxp77MQ2RlmIxL3ryOYwCJoNWq1+7R/DabdT12uq3tpdwS/YoYe/HV7ViM/7SuE0F7Pu+w1jXJBjGLt7l4/SS2Zb2bss20syTEYpRnUWVwLI9Ohee0pz9iz4o765dA6+STUscmPxS8iHMP0AVk15To15KTAirHY48XiLrluC93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CSAk+pXd; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55500cf80so404454085a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1747677787; x=1748282587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UhZ7QiVhHeWi63c5FXSn5MshzBPrEWkzaXlX3qgzNN8=;
        b=CSAk+pXdtHrV5lf+7CiWL9ynXqWkEBBzLEoaUcFvr2+RzFq8fjAGQhIqbCEyQ3hwfm
         aK8Pk6MMpDGazs548YOtRJXUfkU2aZniyIESy1cwXWYv/ljqGoZM/dtILYS3Jh3GGShp
         EOcVie9Grd9HYdQSswghVVqVeKumJyhIEzKmU2rWJRd07yb/XN7M7AwBrwBF6KWBj9kR
         joxiBNV5zGGqt7chK/raEfGsNvo+qUPo+arlcnwMfZ4PZCsUH97XeYOqFquoo3lW8FRw
         eMmrN+uYoKHrRTch3DFh+fdeqJ9R1653SXZIxiGLrkZrcQRFsd1Dd40iO+QSZqDAjVif
         jX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677787; x=1748282587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhZ7QiVhHeWi63c5FXSn5MshzBPrEWkzaXlX3qgzNN8=;
        b=qLlEutefqrSs4QPmsUR9S0p0K8D/UrGqnV4fgSfmjGjPC59KRDTTEQg58i95J4GIod
         gdfjK8WRaXq+udzDmQA35XDNto8fXDMHgAK5QCT4RJrOcVpMtzQEXAIYLZKennS0xrfL
         yQNPMBW6LWyBi5y8Bs0D1y9YHftH5NfBDZgfjl33J8b0smLqiBRaeKFAx2HXrpbMEoXY
         SjYnz+07BpUA2Zzz+Pp1MTtXq8PPd1piiO+Fr1HnyDW10OyMSXD6r8sVjn6CvjGTdvBk
         nQVgYHp1/S/DllYnAYEug523ZaTaj17Ddkl2zDom6t5ZIkvlXG/XpXWy/cxidzvEil+Q
         6RmQ==
X-Gm-Message-State: AOJu0YzVPaxD9N5EwHmB8gvYkCzoLfljOgwk8sZWdkTAggzxySzvcMlB
	cFqsIKOAQ+Rrr/7HidAgctYsM/wIjmy/F7ViBZ4IX7cXxbGKLjxLavZpLGh3ZP+xwF94gSA7n+7
	Wi7Hq1GMxUeqr
X-Gm-Gg: ASbGncs19wNBCLBPBu6Evond6C+3bAzxkSN+XKgLrPbaICsJiSNbv30G1JAM8lSmN8J
	pbkO/vqGBXY64vZhSiYVwx3xH9GHiRLAPM/r6qJAfaDjOzN1jaL8YHB+bP4O1wRzS/iuRKFLuaN
	UgAKQedVzUYbG7YTAEFftZ+8Cly2TbRJzn1USqYuEw4KXX3BIdxddAR2QXF9RP+gBfcNPsqsDbx
	IJr7hf1R41r4GMhg0Tq3rVfot7FaI17kvY+FQsxdGnmlYKo/6zWVSL8NVVkzTbZ+8SBC0wT5Kp8
	SymsICAk5iwD2NbZFF69DAvS/hPtVlnTO+KblULoRAFFVWZd+cHz7TtcHhwaOhRhJmj9i/UShuG
	I1xWemq7KGw1T
X-Google-Smtp-Source: AGHT+IFLn8LRwfDocXd4Q72fZ5gisMYTAdA9+Pnb6uuYdDL3xXGrxgYR+UQGFu5l/23voz8Gucdv/g==
X-Received: by 2002:a05:620a:40cf:b0:7c5:5670:bd75 with SMTP id af79cd13be357-7cd467a0103mr2000815485a.46.1747677787413;
        Mon, 19 May 2025 11:03:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468e5c38sm613154485a.115.2025.05.19.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:03:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: don't drop a reference if btrfs_check_write_meta_pointer fails
Date: Mon, 19 May 2025 14:03:01 -0400
Message-ID: <b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I made a mistake in converting us to using the extent buffer xarray for
zoned, I'm dropping a reference for the eb and continuing, but the
references get dropped by releasing the batch.  This should fix
Johannes's problem and the testbot report from this morning.  I'll fold
this into the patch later today.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4d3584790cf7..a6d3deec7281 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2189,7 +2189,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 					done = 1;
 					break;
 				}
-				free_extent_buffer(eb);
 				continue;
 			}
 
-- 
2.48.1


