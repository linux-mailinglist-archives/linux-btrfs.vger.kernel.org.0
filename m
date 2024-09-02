Return-Path: <linux-btrfs+bounces-7746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B1968F06
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229D1B22667
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169892139C1;
	Mon,  2 Sep 2024 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPY5kJC3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998841A4E6C;
	Mon,  2 Sep 2024 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310803; cv=none; b=lbkWbfEbgZKpnoXNR0aonkKdicRXa85z4pJztvDNkmAKNBUz7ODHunI3ko3tnnIXibdfiouJPfagftJlmm5eTiY45ZzTx9JBxTJb3UrQUt9qhfKOWCBG/4zfGz18ZRRZMckh230Hf8gpBSlnaxuuxBBvHxv1k3i4Vt6/JdzCvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310803; c=relaxed/simple;
	bh=Jppyu6S2zJuNblX7X/9ir0VSqKk+Z3e44Jf07nJ5r2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/ZPKIylArg4YdclQegD2iiofHSMXgu5ba/EktgAh9NZ8TN7bl4CXmzGVKYri2N8h9t+RVbtlYNh72la/w5JMc8uI69lJs2RGcnYSRW5b7ABzbXZQ3XKGfrc2sgjPKxZNsquyULmo/Cs+z9ObdwpEwCpL+dGx1UJBO4T8cBedl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPY5kJC3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bbdf7f860so29595475e9.3;
        Mon, 02 Sep 2024 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725310800; x=1725915600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ2NVfTjqOzglJM6TtSPuUyDiNFczs8rfNMhTWfviss=;
        b=ZPY5kJC3yCo5xR1TBZOwmwzhmRAAEaVmYCnoHRq3I6Udnf18RPf2gH7lWCmd0byPI+
         xJXnBoe6NszZqONxkSgXUJ4y5CEXjEMu5geetZ+B3OLpJ9xEOsuEVGX8PXE0ICFWmfQJ
         OL6Xm/4LvJhosF4x8M3FykybV8sJ1Qgt1HFLGgy2Ce1YXttTYQFzW3OV05zBL2Hmbhe8
         WtCVbe3fpYRO2Ob8jLljg9wCCDI4nA/MANByoMXWv/rgUh4I2TAfZKow06KAAOqnH0Jy
         J9YselbOPtsYIE+CpCZH2pBFkgUHmE3QVMXjlyYVX87CT9/FuI2IDDvu1Ntcpvr89wFV
         mNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310800; x=1725915600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJ2NVfTjqOzglJM6TtSPuUyDiNFczs8rfNMhTWfviss=;
        b=UF76k93NbWjZSC1NsJGA9AfGV5XW5m5HejK9+b/xJMZtDbiuaWaXtb0wET8EhMspDB
         PAi8BweMy+LjLalSkF4SuY48XlBGjoADxIlRniceCDswtr+yNd8DiIGG+1WFZjgyr1XK
         qcLJDprZoLSjhoMuWhKJzNk+0RxOaarAp/DN9NEmzCaXygyDIqt/J/Cz4yNetEDekZfh
         +xDnytz7yHlASv+F9hOUlKFjd4URezXDhC2rYhKavrUVQ5KaBRAAXLwhIN4GyAUAEHMb
         y5xwOm+msdPS+n4lc3ZjqPcBodmebA6PnHRaGtzrmmfIKtAVeTvjGW3jryUcrVbV8qU6
         WE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUBwhTf2Wzp6780H6TesXaGVtXRH8/tXrSSaovloTGZ+/LM6DIv3QH3CM2mOfMm0SK1fWLG0uCyyZupSub2@vger.kernel.org, AJvYcCVgbg8zqVmInSYunJM/t3Wj+MWNRqs3zlmXn0qwbt8YdTuSGXNsjX6uFs2XT/Xxb4EnAHKPA87yrWu4vA==@vger.kernel.org, AJvYcCWjvxjjcHwj/c5+F3RfCFuvldIQWQCX1I+izu3Yk402enNi1qpKKXvBcJfeaVAsb11d3on/84bPBRdQVAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/D4gih5+1AoB2egIii42R5QyeFq2YDlwVYSpBj1nVO00xU4I
	B2XZOFRSk+bHWdleD1JNT4l0fqFDgAnDcadLNcvBAdG0/aUWtyYv
X-Google-Smtp-Source: AGHT+IEsj8k3Ky5VdKV3IY10D71TbBEZck9sSkM+NmDRHUsGhfElw8XJqq84ljk7MDPqC9MlEfxAOQ==
X-Received: by 2002:a05:600c:4455:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42bb01fcfb6mr107126595e9.35.1725310799827;
        Mon, 02 Sep 2024 13:59:59 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42c89dca8absm2913705e9.27.2024.09.02.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:59:59 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] block: Export bio_discard_limit
Date: Mon,  2 Sep 2024 22:56:10 +0200
Message-ID: <20240902205828.943155-2-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It can be used to calculate the sector size limit of each
discard call allowing filesystem to implement their own
chunked discard logic with customized behavior, for example
cancellation due to signals.

Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 block/blk-lib.c        | 3 ++-
 include/linux/blkdev.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7..501cbfc4f112 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -10,7 +10,7 @@
 
 #include "blk.h"
 
-static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
+sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 {
 	unsigned int discard_granularity = bdev_discard_granularity(bdev);
 	sector_t granularity_aligned_sector;
@@ -34,6 +34,7 @@ static sector_t bio_discard_limit(struct block_device *bdev, sector_t sector)
 	 */
 	return round_down(UINT_MAX, discard_granularity) >> SECTOR_SHIFT;
 }
+EXPORT_SYMBOL(bio_discard_limit);
 
 struct bio *blk_alloc_discard_bio(struct block_device *bdev,
 		sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7664d593486..42d63400025b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1088,6 +1088,7 @@ static inline long nr_blockdev_pages(void)
 
 extern void blk_io_schedule(void);
 
+sector_t bio_discard_limit(struct block_device *bdev, sector_t sector);
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask);
 int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-- 
2.46.0


