Return-Path: <linux-btrfs+bounces-7736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E7596867B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 13:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA821F23CAF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268751D67A3;
	Mon,  2 Sep 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNXrlT7t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256D1D61A4;
	Mon,  2 Sep 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277390; cv=none; b=NTRZQmbKjv8SO6x8BHaN/vhf2lN1Y5t4tUP4mdCBI7IFhzVDuFLFvzfXYwEa0AGh6QV+tcc8Iq3gLgaWPpJqOzvc6ItD7KOm5K8QPWfsNWBRs2FVvN++U/nzAhab0tRotdmxUf1848SlcATHVm6C54ftbrfD4rXB7j6D5FQr0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277390; c=relaxed/simple;
	bh=KE3h6tXE+RE3rlbTABeMAqaykIvLYaMlD5zODlIksVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eAA1gxUXPwId+QxJiiypnSMTWAj4c8wqRLHDZqI6XKxuKgrdB/pNNW2MQJyWHebMNYu0YMoS84Ureuq5r+fg8qAKNZ4fNe0vW6lb9PIAySICiHcdJavjxDLEreWJQoQSazqY/dPZhPpesPhCydxxiK3ce4c+KkAdQu66b0i7V8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNXrlT7t; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so22915205e9.1;
        Mon, 02 Sep 2024 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725277387; x=1725882187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sVPD01q+sp9GhLaXZ0ALw8RcGZeWI4NIEtqmbs5IO8=;
        b=VNXrlT7tq8TeTxv5A/YI6pNhgKlLF9gpG/gZpaUvzIlgFh3G+YiddvBCujZC5khRFA
         4Ds9qGq8kiYGVOQg+0/cyLf5ki7RBRo9SqcGJzJVkRpPD1VjdbtunkvgXs+OJIUdnBbi
         QtkoJmHo/tK7RwQ3+HqF6C0PSUujQ3jW5s78A/CRDOxd7BngXyDhoA+T6c451+8EH8KY
         8jwaEsJsILSmuz2MnmQGJZ9MK/ljlgh3N/5vPZKYqNtMo3RU+ZJ6j/9IJ5o968iLFupH
         T22RYeQ1Yc/qurSs3Rd4j6iqzW3iLMFXBR8rodKJkQlegRdBI7XC3IJR8XIwWyheU4f0
         P3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277387; x=1725882187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sVPD01q+sp9GhLaXZ0ALw8RcGZeWI4NIEtqmbs5IO8=;
        b=Km31XOGwbr1jgrv84//zHy4//fDl96oKhnGm6ZYrJcZRTkmHLB+JRQDTvIFkfVu9g4
         1f/3ZOWRJhxk9OEo6u4WWG74eHfQ/okNlPbLo4M91A5TDEKl/tOAe7h3zs8zxuQkjI/P
         V4VV0phzTxZ9Mb30O0pZytfW3/Ut3vvDPUCad8BGMFQAReAT7752tB1dw0twuz3fUzUw
         AKgP/3Y6YXj7ixADuH7i7BOIvKsuIkVRNjzAWh5fIvM9qFvftTo4rXKf7fsyQIltMwE8
         eqQUfAinlXAYf5hz4uNjIhEAh98krvz/foGpXsFSGkgG5Hl/qaOyAgcVWxQH2EvTZBsa
         /tRg==
X-Forwarded-Encrypted: i=1; AJvYcCVTKhhuKLMm3lWj4dz1goyJ4V+lxZLimeI3MyzRxYXJpLfjQjnv/7h3JXgeIAgEHzQzBz3rlsOsz0RW8Q==@vger.kernel.org, AJvYcCX8m64MmaY9e5L8IlZTqq6MnWKyRKQai6f7F4xCd2hqufIDMxx0wRnQ0QMVF7+CCAt0AoItHsI6dHP6v+W6@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5oiYf86ZYC+XhrNeC2woLd1eMIii1nBL55XK0Jshfbeh3+vw
	596adQ+kiuiJjRuDEGPksmntfE2/dMS/qnqxiWQb7yU2JMxeDotg
X-Google-Smtp-Source: AGHT+IFBCaxP6BeMbZaB1F1NjtsK2uFzuEbSmm9dXk1j3mJRaUWA175Y/poi4lglTA8IHIfcXLC5dw==
X-Received: by 2002:a05:600c:1914:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-42bb02c10bemr119629185e9.4.1725277386860;
        Mon, 02 Sep 2024 04:43:06 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374b34725desm8473607f8f.81.2024.09.02.04.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 04:43:06 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Split remaining space to discard in chunks
Date: Mon,  2 Sep 2024 13:43:00 +0200
Message-ID: <20240902114303.922472-1-luca.stefani.ge1@gmail.com>
X-Mailer: git-send-email 2.46.0
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

We now split the space left to discard based off the max data
chunk size (10G) to solve the problem.

Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Closes: https://lore.kernel.org/lkml/2e15214b-7e95-4e64-a899-725de12c9037@gmail.com/T/#mdfef1d8b36334a15c54cd009f6aadf49e260e105
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..6ad92876bca0 100644
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
@@ -1300,13 +1300,25 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
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
+
 		if (!ret)
-			*discarded_bytes += bytes_left;
+			*discarded_bytes += bytes_to_discard;
+		else if (ret != -EOPNOTSUPP)
+			return ret;
+
+		start += bytes_to_discard;
+		bytes_left -= bytes_to_discard;
 	}
+
 	return ret;
 }
 
-- 
2.46.0


