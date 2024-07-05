Return-Path: <linux-btrfs+bounces-6229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC5928B5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 17:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA731282E1D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307A16D4D5;
	Fri,  5 Jul 2024 15:14:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599516B741;
	Fri,  5 Jul 2024 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192441; cv=none; b=rZu5Daj8mdXGnGYSLXrbQbyY8DRbDJMapbO4Ggd/Hcj7U2GMXUZaNcJczWUyC1AqwdCdZA2E54Q0XSMOTwJ1SYULZXSIrVnRk/Tc3hS6nxMkkvW3xWwQ2hhmwzNqwJUAiLW58B4blNPonUzi2Za/eGxXQT+psoWZz55haenEoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192441; c=relaxed/simple;
	bh=w4UY0qaNXatI2G4viGXg8MjSywm4bZkH/4/87SoqBg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nOYZKnrD+BMOEfsobHwjPsozvvrDOzjaj8h+KWAyVI5Psoq1lUylv0+o9nVB3+0FbmFnIQUlsG90OeufVa1ZoIJNo134eJjHxMuZek/ZBuAWJYE8EeGIdKF0mOEw3wKIMNhXkS0G3K3hU2ycNUsloFBCHllLfiuti/637A+U2dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77cb7c106dso99357266b.1;
        Fri, 05 Jul 2024 08:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720192438; x=1720797238;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w72yAYQGgwZTCvkC7UicckI1wvtaU1tCLlsJ9npFA88=;
        b=fWsM48oFvvS0Qqv6dHqp5MI4ceOLahOlkZQZd1WUVqq6owBWIpe+mVawKLr4Eiyedb
         kPImDvDSQfQNB61OJ5n4cw6IkGKlqyb7cTPhFt4vLca4ux4HWDlWI+ywDwkDqFIzstaJ
         mc1KAaXGU6xBXv2h4VeifKedJkGUftveApkPygr4XsG7uPWP1f/uoXQFKDp/l7EBcEoc
         +AP0/xJR/UYK0BZ+LhzQoPHXxthGhFXEqzI0+6aN101SWC9NGhNXXYFedmDTW9w4r8mn
         82YkbAiHKoCtRQ27jozqkdbrQRooQi1ilkS86sv3XcZcNuD8gO5XFZ7v7Oe8UAZgB7EL
         RFfg==
X-Forwarded-Encrypted: i=1; AJvYcCUKJvzLqJnV85PKpJraxCT0bVP7o2J3Hi4gtqJPaXPhlpE9u+ku/++64/HB6YcymDGp/8mE4waqxpIGsU3WWJV+KeMz+4seOgT9UdEr
X-Gm-Message-State: AOJu0YwYr/ME41IHnr2bGPM0dGy22X3dsQcUjK/vxM1BXJdSIKV9iCub
	RovCqBKofR4wUn7J/uA6AR+GdU6gq2P8ed5emmNrSr65buz9IwYfthwS9Q==
X-Google-Smtp-Source: AGHT+IH2cT61O23REW96KTq6RlJBvRtvqItIVrLumpDTfZsGclikFhH5PlbsMvaIkKhpOGMNB+lWlg==
X-Received: by 2002:a17:907:d25:b0:a77:c4a7:c421 with SMTP id a640c23a62f3a-a77c4a7c4efmr269677466b.30.1720192437732;
        Fri, 05 Jul 2024 08:13:57 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f72f3200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f72f:3200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf6336csm686226566b.70.2024.07.05.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 08:13:57 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Fri, 05 Jul 2024 17:13:48 +0200
Subject: [PATCH v4 2/7] btrfs: rst: don't print tree dump in case lookup
 fails
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-b4-rst-updates-v4-2-f3eed3f2cfad@kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
In-Reply-To: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=jth@kernel.org;
 h=from:subject:message-id; bh=oU0E8uyvg8QMXoew6S4xY7nRBEk9shMhOdx0hjavAik=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaR18G4Uf856Obz5uWglu8ySK3LbW/L125j/qjelM9bEr
 2+ZpvO4o5SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACayyIvhr2Cn5xOxuze12xzP
 LDdlZbQrrV3zto73wj6x1dkbZh/rfc/w3/fy842HFL6f3y301657bsgbnuxvx0I8T3MtzksQWaV
 eyQUA
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
index 3b32e96c33fc..84746c8886be 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -281,10 +281,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
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


