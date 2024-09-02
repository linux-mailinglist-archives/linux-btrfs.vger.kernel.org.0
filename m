Return-Path: <linux-btrfs+bounces-7747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E05968F09
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 23:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067B6283260
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CFE21C174;
	Mon,  2 Sep 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6vgVZkN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582AF21019F;
	Mon,  2 Sep 2024 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310805; cv=none; b=FEtPlYLJQNJuuoBHZsUjmsX1s9StN0et/cWfCK/c6omCR3v1XZoV/6M+Zc/7NNrLb+kpRiNnjmotKkZ+Xs+F/Yku4ZYpWEHDTN7YLxIck1gC59aPyO/lJG5FBVG4XkA8wE9CZ0VM5BuIJwIk7HPNPwkanYer5/PGgUyQymOzxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310805; c=relaxed/simple;
	bh=SEj7IYFl7zC2aHPGx2VgmF2xom1uHPUOY6jDG+3Ax7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gr1Q3JP91ObWrZf/OTcYQEC7IWt8EWFNBDrkdpRlIbMVdNw3VYTQglHPliAqQAxnDJUDFFXRFuRwxzA8hDLWZAc2u+L5Cw5RXSq13BPBmjZk1bT0ZyOmWAnz2DuPri5twE+QozRzbjwMNNf4C03bVpFMuLdGCTkMNGQgtqOvnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6vgVZkN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42c7a49152aso25434695e9.2;
        Mon, 02 Sep 2024 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725310801; x=1725915601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny4ikVUi/TH1pl766OKNCnGhf37BcCI9Wb18E5567Uw=;
        b=C6vgVZkNEVjgLIHqtefcVz7uohpjzqrGBG4N/wOD4LTsW8MdDcaLyZzGRzfMlJZWin
         7gxlVHhSn48hzsjErDvMK6tzm+9i2ewJlTH6/SJbBi3aJ6RKtDXyg1Kb/tmZyjlzkdi+
         PPfC42T832B6EDGFAxtrafdM9+XVdTYTzAZJDbt5arm0AsPB8wjrA1VNbpibb1v57jWC
         5G/0kxdoaq32TpRzloCPkezbLpbGD7z3uoLZsVZXAcwUAaD1zIrjtD64FUpbNkO9qYfW
         6FmkeDDPMrwapBwfRAWbUqlKuxmRTJnRRZk/6yz57PEjbtTzW5AZ9qzYGD8dArWCiQcf
         102g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725310801; x=1725915601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny4ikVUi/TH1pl766OKNCnGhf37BcCI9Wb18E5567Uw=;
        b=KmI8jrrQ7NqK/+v+bYSZqOtbIU90c7Jkvvv67FaGndkLzWgFYmw1kAJrQz8WypX9RW
         w6JX7JAv6kolxcaenqzscEZ6+AdbJD6jrHZH/MiKUPSZods2onBaIeShOV6wL9QPxqds
         +K+RN9WLbXugY4UTsiMSSk2CzHq4JWzVl5frHwBx4fLm50GwoRtyHnvSNNMiZtGAdO79
         9V5+qCdL1LVIPg4YqP5qwlH9/+3q14h1dKSfvLdDUz4oO1dXngxo8uUDXPQJ6g2u4shU
         Kwgv21vStxkc11Mf7r3tj8KeBvKN+m6O3i4LOspkowAHorvQ+k+vIdviO6p2dR2SHgxN
         wECg==
X-Forwarded-Encrypted: i=1; AJvYcCU1gLJbLaDUYesTwhKF7OehLTGFd8B/OGYJZt0GrlurkO6ykc035FJhITbk5RMZEm1bshyocy46YPYq8/4=@vger.kernel.org, AJvYcCUu64X+MJaGj/UOFISRfiW7p6RaKwaVT7XAW3ha3Vxoa3kxEBodha3uuQnZX9c2S1C164NyK2rVlXlsnA==@vger.kernel.org, AJvYcCXVzdXncb47C64vn0UvJmegIKRe+xiJdfiNPJKtP6u+ybbr7jD+ocSaoXu4XI5TbtqaG55SBMPeHV5GG1Ny@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wE0NmQ3pQnXRG656SzyS4yP3NrLVGt0ghyM9NW1P37Rcf42J
	AqvSw6rhb3rmGGNaZzyAI4MsQdHsczpiWbxATcatFQElqymAzf/0
X-Google-Smtp-Source: AGHT+IHNKdoo6+620GdTdBdCtV5ntCT1U3cEt865NmyUtuJlPODQMIJJQAGQPSNMoHXvK+gq8Ij5HA==
X-Received: by 2002:a05:600c:cc3:b0:426:63f1:9a1b with SMTP id 5b1f17b1804b1-42bb020ba4cmr117166285e9.33.1725310801142;
        Mon, 02 Sep 2024 14:00:01 -0700 (PDT)
Received: from fedora-thinkpad.lan (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42c89dca8absm2913705e9.27.2024.09.02.14.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 14:00:00 -0700 (PDT)
From: Luca Stefani <luca.stefani.ge1@gmail.com>
To: 
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Qu Wenruo <wqu@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: Split remaining space to discard in chunks
Date: Mon,  2 Sep 2024 22:56:11 +0200
Message-ID: <20240902205828.943155-3-luca.stefani.ge1@gmail.com>
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

Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
mostly empty although we will do the split according to our super block
locations, the last super block ends at 256G, we can submit a huge
discard for the range [256G, 8T), causing a super large delay.

We now split the space left to discard based the block discard limit
in preparation of introduction of cancellation signals handling.

Reported-by: Qu Wenruo <wqu@suse.com>
Closes: https://lore.kernel.org/lkml/2e15214b-7e95-4e64-a899-725de12c9037@gmail.com/T/#mdfef1d8b36334a15c54cd009f6aadf49e260e105
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
---
 fs/btrfs/extent-tree.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..894684f4f497 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1239,8 +1239,9 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 			       u64 *discarded_bytes)
 {
 	int j, ret = 0;
-	u64 bytes_left, end;
+	u64 bytes_left, bytes_to_discard, end;
 	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
+	sector_t sector, nr_sects, bio_sects;
 
 	/* Adjust the range to be aligned to 512B sectors if necessary. */
 	if (start != aligned_start) {
@@ -1300,13 +1301,23 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		bytes_left = end - start;
 	}
 
-	if (bytes_left) {
-		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
-					   bytes_left >> SECTOR_SHIFT,
-					   GFP_NOFS);
+	while (bytes_left) {
+		sector = start >> SECTOR_SHIFT;
+		nr_sects = bytes_left >> SECTOR_SHIFT;
+		bio_sects = min(nr_sects, bio_discard_limit(bdev, sector));
+		bytes_to_discard = bio_sects << SECTOR_SHIFT;
+
+		ret = blkdev_issue_discard(bdev, sector, bio_sects, GFP_NOFS);
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


