Return-Path: <linux-btrfs+bounces-6923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD74F943745
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6813A282839
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9338A16C849;
	Wed, 31 Jul 2024 20:43:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E72110E;
	Wed, 31 Jul 2024 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458608; cv=none; b=KPaA2t6j0CxWSS8tq+ucVl99cstzef1ySCjSEE1HTNipq7c295SgmZA34XwlbJVbh05NVZcUPT1yZxdyIke17fahZ3ru/fA4pHjYY/ZHn1+GddlDC0EZOyitqTqR6MxbD+IhTTn/WfmZiR50cFMy3903eU3+A0dxl1Aca6T94m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458608; c=relaxed/simple;
	bh=VDkXkOu95iRKfI1QI70fg/XiU7AQpQVT4RoxVTbIVCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOa4UQGOuBoGyUCR5RKbtFqej/W3IPiCvlKPoPQOskjoHeaX7L2Iy8synTDqFPEF6G8r0R+yojwwcQETwtkjtmUmC94M0QenFdWHLIzsQQKO5o7xSrYDlsGToq7HxfeDftISZyOtOnIdKKoDMfR418u71EcXFkIGp/puGOdjCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5b214865fecso4855545a12.1;
        Wed, 31 Jul 2024 13:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458605; x=1723063405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NhD4GJEVaHbjX7LJvdBP09V5td3sJ0qN7X/ZBapLj8=;
        b=EOHRlFFKwzz1zyj3klUMk0DT1nWA1ZDq4MTLJyejdEFoQ1Zh9/eNhIF/JnuF1iORmS
         RmXv7wWhg3+tmtrbdXx8jWgrL2luPkqLra74OpPj77DRpY5gTlmfNsi72+IxzvbdYcuG
         jxpae7cGdFx1g3oq5NPlu85ruXdM/8DPeRtBxGnb2PIuu7BxoT87qh+pydlckKdvJjg8
         CEzCA+WQimMNf6Ue3MHUrGrkRI5g5PWcp+RTxh1Susuzip+piFj5DJoK4/LUhC697Oki
         g6lPivhpu5BHRr2rV51mxQHlN7ZzWtmTjnkRf03n9ztWc0Qm48gYXb4SRYS8RJuCx2Ky
         3Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCUWsD4yHAEmBWfvafSvQygs56Daw9l9QrXVDVMRzbsOvJZ1VdSWAJGdHWCnNsgCwD1HEWU6+wA7ojvJ098CH1LZq/ND9RZAMxGXC7EW
X-Gm-Message-State: AOJu0YynRILxsfLiP7Wofduz5ivqad8eHbQN2zVS23Hm9BJfXQ3wNoFG
	c2c4Xo80B1GKDuhGFYegM7cC52zI5U8QlxFHWRz8SntAa6RGdZ4oYPATBg==
X-Google-Smtp-Source: AGHT+IFInUDg/rhkFfJNcvmpaW/gBMLOjZhUNuD/sPrdAG974OoCLlKUzMrh+z99rO4ZOt6swxjUAQ==
X-Received: by 2002:a17:907:7d94:b0:a7a:8cfb:6568 with SMTP id a640c23a62f3a-a7dafd5a938mr21992866b.57.1722458604370;
        Wed, 31 Jul 2024 13:43:24 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm807454366b.61.2024.07.31.13.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:43:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 31 Jul 2024 22:43:03 +0200
Subject: [PATCH v3 1/5] btrfs: don't dump stripe-tree on lookup error
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-debug-v3-1-f9b7ed479b10@kernel.org>
References: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
In-Reply-To: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; i=jth@kernel.org;
 h=from:subject:message-id; bh=oxl8FXfjys2Y/6Kc1JUEnnmrZBWUyrK/iztpd2u46IA=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStWvgyz8aGc8LyT2k7Yn8Is6SxllVfXbhr7ixdb5nI4
 CynxxXTO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BeAmn2NkeHaGl3vh2+WSyoKO
 vn/W3bK+/qdqz4SDR8KWNjcvV2kVcmBkuHrwbrmoWzJLztXyasfHxWm/ugT6qrPkAhx5J3L2v13
 DCgA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

This just creates unnecessary noise and doesn't provide any insights into
debugging RAID stripe-tree related issues.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index bd06ff795691..c1c74f310e8b 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -284,8 +284,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret && ret != -EIO && !stripe->is_scrub) {
-		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
-			btrfs_print_tree(leaf, 1);
 		btrfs_err(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,

-- 
2.43.0


