Return-Path: <linux-btrfs+bounces-8049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C39979F1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 12:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEC71C23575
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD4154444;
	Mon, 16 Sep 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVtWhQpI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519514D2B9;
	Mon, 16 Sep 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481790; cv=none; b=a49ccJvRXt9kU/YlinqETONcyJlTaG9BYs8W1cjEbYLnzLq8J650lP6/fFWEtxa5vK2V8Gq5biYCSbrX1wkq8Es33KiGnJx5kDbDDXGSLAZLltlfvTqbKSjQfastGHAsnBY0d1NaqEvUIQgH7RhpTGVBtfXjS0vP6T8LmN6HHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481790; c=relaxed/simple;
	bh=1MSuuVdW6jpVBdVadZ9EKMcMMKnIRPuWO1ABjXKOiyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVDSxQWkC4mXlZGwbhDIPIZYb5t38A4ZTxIQDYQnpXiRg3tYhT84PHmebtBLPGfA8enj+wBOvyhYsVkyjVXcpYiXpWqS/HANlEN+kGENO78pfhSpByKdtigO+5cxKvTaniRsYBeaYcLuLqpKxY+SxzJHr/SG2KVKxiCZjE93onw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVtWhQpI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso32883435e9.0;
        Mon, 16 Sep 2024 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726481787; x=1727086587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR1zaljeSJTP/u3Pvb00FWZ1kLoJ3Nj8Q86hbGUAQ0k=;
        b=DVtWhQpIQ/cKzoe9bbh3ELwTqrRYHi24ZcRAue6cRtxBsZNvgemLXOMMPKJDJo7iMz
         ZPnnakyZcy0zFK4mQqZy9pxGTkcQgK+Qypz1KrrMSaQOIFKZZ2xri3F1krzEAyzg8kZM
         W+IzIbvLDGn0IdL+83B+v4OV494VRdaylDscfAlwV/BKlaWGVAj4Q02VxRVDkA5UTtrQ
         OkvCM2PHAzY5KaQRhHjryyQpQd9CQoNei1s+fdtGKyL0/52zeA3EiRxSpA9svLEK5V39
         P+1eTW6LBZF5rYvv5cGWNNVTc1Jyb4w1+9AvTDWlTsHk7yfSrlRdP5P3Tv/tI6C9/phC
         RdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726481787; x=1727086587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR1zaljeSJTP/u3Pvb00FWZ1kLoJ3Nj8Q86hbGUAQ0k=;
        b=wT/spGKRKL98Vd4f3hCmuscf57ODBccJ6nrJyHRrz15/4O5x+Vpa2TrPTTKZ8vR9aM
         dg+s0gQlMKmCwVoq1btMPgy0IULQY9TLpqd9ggEGH8nITIuOIctD+leS4RQgWpGnKGLL
         gcf9Vkip99dOXjhVYoSekOGb7/LOQ1OEiY+OyXnMtuI55JRJg7YjPncYKcB7N0jeeBbk
         ggf0lg3LoLvLjUClq9v2MESL2F5gNR3fEcvk2gGVOw0MGje8RycGU8zli6QZYFTLuVrm
         OncNyUJ4oHmm7fKFZqBuSEWl17BfKD8D3FMCqDMxtENT29KnykLE1TcrPH1H4wd+5Fd2
         W5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXqa8+ZsO5DLGNlrqc9TyB49FXepZjMBAvRFiIpuzZjiKf85/HOZwX1gfgVRhoVnP0ICXJjv3CwmTNHw==@vger.kernel.org, AJvYcCXBbKHA1B8onfipM+9ax7gfEdvS24lPyFyRx2BpFt7MMPFWQ900FVsQ6mYrHNQTrTrOKegfvfLp43BHh4mW@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpLYqeUuFpAtPDnPOe01ivZk12hyBC56peLccGN/z0qDe9Ij0
	SBE5USMBjRYWbJG/T23/VPUoq5z4EdO/Gqd+MHogYf4lKuQ/uEIM
X-Google-Smtp-Source: AGHT+IFXSUdImfdKL09QrcIA9ID3+Sw5Eyz6wR1bDQu6bL19FR2/UXvzOM2Y+jseSzgfQ+k1nsE0ew==
X-Received: by 2002:adf:f651:0:b0:374:c25a:f580 with SMTP id ffacd0b85a97d-378c27a925emr8234768f8f.14.1726481787220;
        Mon, 16 Sep 2024 03:16:27 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e780015dsm6814201f8f.69.2024.09.16.03.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 03:16:26 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] btrfs: Split remaining space to discard in chunks
Date: Mon, 16 Sep 2024 12:16:08 +0200
Message-ID: <20240916101615.116164-3-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
References: <20240916101615.116164-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
mostly empty although we will do the split according to our super block
locations, the last super block ends at 256G, we can submit a huge
discard for the range [256G, 8T), causing a super large delay.

We now split the space left to discard based on BTRFS_MAX_DATA_CHUNK_SIZE
in preparation of introduction of cancellation signals handling.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..cbe66d0acff8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1239,7 +1239,7 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 			       u64 *discarded_bytes)
 {
 	int j, ret = 0;
-	u64 bytes_left, end;
+	u64 bytes_left, bytes_to_discard, end;
 	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
 
 	/* Adjust the range to be aligned to 512B sectors if necessary. */
@@ -1300,13 +1300,27 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		bytes_left = end - start;
 	}
 
-	if (bytes_left) {
+	while (bytes_left) {
+		if (bytes_left > BTRFS_MAX_DATA_CHUNK_SIZE)
+			bytes_to_discard = BTRFS_MAX_DATA_CHUNK_SIZE;
+		else
+			bytes_to_discard = bytes_left;
+
 		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_left >> SECTOR_SHIFT,
+					   bytes_to_discard >> SECTOR_SHIFT,
 					   GFP_NOFS);
-		if (!ret)
-			*discarded_bytes += bytes_left;
+
+		if (ret) {
+			if (ret != -EOPNOTSUPP)
+				break;
+			continue;
+		}
+
+		start += bytes_to_discard;
+		bytes_left -= bytes_to_discard;
+		*discarded_bytes += bytes_to_discard;
 	}
+
 	return ret;
 }
 
-- 
2.46.0


