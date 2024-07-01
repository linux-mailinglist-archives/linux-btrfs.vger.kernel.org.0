Return-Path: <linux-btrfs+bounces-6073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FD91DC6A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 12:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3034E1F2302E
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 10:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D614B943;
	Mon,  1 Jul 2024 10:25:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DF1494BC;
	Mon,  1 Jul 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829531; cv=none; b=JAP4W4dgJP2blbHqEKGG6vFpWP/cZAavHjiMhsbHu3fURuP0/DPTNZ4QsbxB+yXiRVMwO//CQAwVkXAQWNrMezAofQQFQSgbHsb7pQ37CHDQbO/pjBpinzXrYWS21u+jAmYnMwyhFIArXdsdNB0QjhsdXJQrHE+MqYhvkpjykPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829531; c=relaxed/simple;
	bh=Yj5SCX5l4/okuBvj4Ucm+ZQavcLkaJ6bqHI3fb6JgnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LSKgkCslwdOSOHZLB9FzOZF92wUy7Yq7lbTws1LL7oICb1u21gp1K5dT8UOwStgUe1Z7ebllvVAHoRaLxFzRZ8m1/OlHYirvbQgWSAAqBrvmnF+ze4/zbcUFaqQkhNNp/J5FfzyFh2tX427N1y7KCS1H5iw6VZkJpxvgojSb/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so31300041fa.2;
        Mon, 01 Jul 2024 03:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719829528; x=1720434328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP/apTv+9FNllVUJY4WmB60/Cc824SZb39Pn8gR8ark=;
        b=s8E/W/HPaIlyn04BNfG+meel8jnMtX3NfAtxZShZajH875fpd7moGfWY3LtMukyYjF
         C4oLVzaL+v7WZg32iP2t2PNRlHLjsJth7bma9ZFhxNlNwhWjZCuc+BV078E6cF2GChLG
         UXRzNyeCc3RX1mZNVN7ByzbyGY9YPIZi4mOQs/kHfF1MgQpLa1IrCwkCVEkkLOfQs8JZ
         QocuqUpYDcmb3jHusEgMj5g0GK9rtdlxXSAlKe4NaI7h0KGzPXY8WO69498/XlmS7Pmr
         mHzn1G9TO5vMLQulBHiWUdNqWv20jHoRjUQnnRLaDcSB1LJrNHBOPYlBpSCgaq0T35Sj
         lczQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB6FqyJ3oUA2317cbiMreUI0lXtisD2zDPtl+RQCnISQpd80c5+RAB8S+UxnPMYnISyjSR7UlvfXnRuN+Pa7uS3FD11zx72sAVYD0t
X-Gm-Message-State: AOJu0YxGhe6CiP1gMXpfgPrsftXsgly2RaL6/ZA4Rhi+8tftJW+E+ngh
	XKy4YSdb/P0qXdyPd/SVAugLUluXrRaVu89E6Wj//FjC1c7xUCKp+OxUAQ==
X-Google-Smtp-Source: AGHT+IEyvWjCLAYmJvHMJmrQgTbJvkpF1hnJwvFy7ZM58s2cuL8wciiAHiQp93/AHjugN5Fz0HZjCw==
X-Received: by 2002:a2e:b52f:0:b0:2ec:4eca:7487 with SMTP id 38308e7fff4ca-2ee5e359087mr29813301fa.20.1719829528290;
        Mon, 01 Jul 2024 03:25:28 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c83583sm4238901a12.5.2024.07.01.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:25:27 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 01 Jul 2024 12:25:19 +0200
Subject: [PATCH v3 5/5] btrfs: rst: don't print tree dump in case lookup
 fails
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-rst-updates-v3-5-e0437e1e04a6@kernel.org>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
In-Reply-To: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=jth@kernel.org;
 h=from:subject:message-id; bh=hPH+yDcHHSCCTGaxgQsuEn+PqYUALMNCW5mky+nNld8=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQ1tQiVuqxV3XFsTc1q7rYL5Zxz/8mFa/gl/FnL8Jpnz
 Yo8vWWNHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCRxa6MDA/dNmo37wy7eq25
 R4FP9N6T6zpP1PQydPR9jvZPvKWwhYuR4cLj4+/DOztFOLZ5fJ/bd8xyz6Ha8i+7Iz0sn89qiHl
 ozAgA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't print tree dump in case a raid-stripe-tree lookup fails.

Dumping the stripe tree in case of a lookup failure was originally
intended to be a debug feature, but it turned out to be a problem, in case
of i.e. readahead.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index c5c2f19387ff..20be7d0c52e6 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -332,10 +332,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 out:
 	if (ret > 0)
 		ret = -ENOENT;
-	if (ret && ret != -EIO && !stripe->is_scrub) {
-		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
-			btrfs_print_tree(leaf, 1);
-		btrfs_err(fs_info,
+	if (ret && ret != -EIO) {
+		btrfs_debug(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,
 			  btrfs_bg_type_to_raid_name(map_type));

-- 
2.43.0


