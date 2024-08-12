Return-Path: <linux-btrfs+bounces-7114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BB194EB4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 12:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D81F22C43
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D2170A1B;
	Mon, 12 Aug 2024 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="p9AlzTWV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BB16FF37
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459023; cv=none; b=cF3xjvKb84qYXHUZkoNmUllrFtTLnKSmdILkxYS195CskWQuvqKfowQ8h5IYxgVh1b1FaQBBKzwRbfeomiCN5vkQ2C2lvVLgqW2ZhEtnuU8RYSzpee1qs/ctyj8wNzvpNnkWphmQvOvA8VL3j8tTTEf9gfDmLBIq824CmYoCKyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459023; c=relaxed/simple;
	bh=8+LIWnQdrWxt7ycwt1k5XvF80HXWWgVGtbMU2iI1TG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8MN2qVxRKwYUnVtVeKvL+HABBej1pVC0g5FryNnryNtVeIRTQn0eWqHE7cBrHhWzgauR9FSLjqMwHxZMcD+NU4dbBf1FbPQ2UtVHx8HDfhjalPJZCHtPIJpycn/+KktlBwc3aKCcdRAUgBdn+J2UcFEMC3r2V7SoQWp0tvY4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=p9AlzTWV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f00ad303aso5619210e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723459018; x=1724063818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NHXPZC38UkK7O5TEx6SvnlkLMGTpM5Jg04F0VTZcmI=;
        b=p9AlzTWV+bcSvn84piwSb0GmqMCIJsSZl99LRvJfjrfZ7l7a9JqrpT2U/Ol/H/2cUo
         z1OUx8iAQopfRHe1J5Lb17mzJjVf9BAxRbaN6kUrKe9wccksq2TOrl0dNvVftvwG5de1
         GUYYdLAQMg/ko6jDTXlq83P1U/wxgiizbkRsIpLLKJ+ekmu8vJqmMizJcDbPtvIlgu/z
         C9gOtikTLNZ//PdMlPFHcI3liL48XcbFngJJCjJFFecNqs3e9qGAP1EqgMnBSJUC3L0+
         6cEW/bX3JCFjSFFJgenkZBvnxlbvmZhckvcPGR9vLlbyiIrstFAM3GSQOX0HN7DOOCzI
         nMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723459018; x=1724063818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+NHXPZC38UkK7O5TEx6SvnlkLMGTpM5Jg04F0VTZcmI=;
        b=Ez5B9gzbzTuu4XBCwCs6L1xj7PDvWA/vPDdi//pvsJGVgYm3Z2KjMFLieyITh0xfPV
         gSJO+JHy9GQs1aB9PNAL/cNkgvK/TYjL55j69Ogh3iju/twdhwh+Yd0HHHr+jDQVT6zq
         VK2EyFjzpjXHFvg+hvPxDTIivMIANbPDdi3/t+T2O3lf1Tdi258KQaTbRmPDTHjr85UH
         j5y6WGzi7HbMXcmOdVJl5ggq1FfpV9ywRbYW4abDqSK5BvlP5hZpwGhoyy6F81oz53oN
         aCJBNrXhepdUSQED7dJYNNIFcyzIyohRSUdFttfh47RvTH6NkSJn+D4smb6A32C+/u1T
         ktQg==
X-Gm-Message-State: AOJu0Ywj6hRRQ9rZTWTt5Gopd8SPzLRkIAIqacQ/nZgJ4OvN4hjCVl5D
	vO+1TbQFLmtxkhVMXz5KxkPYoHGXKEjfr4Y6Pq25cM3O9JvifI6KY082jO4cyx0=
X-Google-Smtp-Source: AGHT+IGhryedRog1uNgUMvSTTd6FzO5BP4X7rYeAgqKS3aPe96HVq3jG2s3kGS4P92rT09XMfGeoLg==
X-Received: by 2002:a05:6512:398c:b0:530:daee:cfb0 with SMTP id 2adb3069b0e04-530ee9ee3a3mr6043926e87.52.1723459018211;
        Mon, 12 Aug 2024 03:36:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1cce87sm221661466b.101.2024.08.12.03.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:36:57 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] btrfs: Annotate structs with __counted_by()
Date: Mon, 12 Aug 2024 12:36:20 +0200
Message-ID: <20240812103619.2720-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/btrfs/volumes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 37a09ebb34dd..f28fa318036b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -551,7 +551,7 @@ struct btrfs_io_context {
 	 * stripes[data_stripes + 1]:	The Q stripe (only for RAID6).
 	 */
 	u64 full_stripe_logical;
-	struct btrfs_io_stripe stripes[];
+	struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
 };
 
 struct btrfs_device_info {
@@ -591,7 +591,7 @@ struct btrfs_chunk_map {
 	int io_width;
 	int num_stripes;
 	int sub_stripes;
-	struct btrfs_io_stripe stripes[];
+	struct btrfs_io_stripe stripes[] __counted_by(num_stripes);
 };
 
 #define btrfs_chunk_map_size(n) (sizeof(struct btrfs_chunk_map) + \
-- 
2.46.0


