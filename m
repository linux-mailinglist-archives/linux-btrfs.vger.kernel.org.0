Return-Path: <linux-btrfs+bounces-20053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7ECEBD9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE04305EE60
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9733191BC;
	Wed, 31 Dec 2025 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDaxzuQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD025B662
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179812; cv=none; b=RiyH6vosDO2lDxoRn5cbCFP0qomRCYfSTK6tMo7AEkneWHJNHBkNTzIMoYO/Bj/SL9JWx5MPS/R9aMCal4lRHW0a4AtWknNpK1NqTGTEmV0WJ16s2GSJd+z5KGSTnQly6mMuyGsgQqS2if/A7xRmyFdP0FJ8/iimr2TY12Pd/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179812; c=relaxed/simple;
	bh=QMzgEbX1GIW5jlaKwSYOxTHmSjeNsEyZ2SYhzqV1Efc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcspdPxqoq2zkYIJgHj4WK3whff4Xa3e6UZBvsbFbmB+rGBGznk2ro1mWEQpUf2yxB3CUl0xm+m7UsuAcaBoBQ3tket6WXpKawMZ0ku8f4wlMpol7XSluwu+c+4ad45U8QZ/fwmzyNGHCrTdSa3ZsUIRVT6NnaZ5zwGxtH6UIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDaxzuQU; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a110548f10so37366335ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179809; x=1767784609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP43QVv4guU3d0Acm7Ki5Yj04cPnUrXcJ0D2tfbjGsc=;
        b=HDaxzuQUmMpBkXA5qjgpasToqLLYIlnsHIbN6vO26ebQ8OG3orwkLs6UZvdCO6PEGF
         gsgvLoH3WItRou9PiUhh3KTjBZrG2KdUHL8XuSy8luqoUWDs7KEWWCCGIDQZBBoYMx/T
         tTLEt3rvgW9D5+e2Hq9jrRSAcgEIf5UqGpLYvxq8V08nfBLX/pO+JWOfzHDe2t1MKp8/
         Tg9+WFLx1AOZys11Ds4CqLUITmrjUpyN3LvbQCSG9HKiirFo51yR+w3yowwNW3CcPG6Z
         hiHLduzNukjHF3CdGfWfcrAafDjhU47vxyEMgW2+Q7IFTlu+Lsz6ecc2HNWsDkYDGIWY
         KT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179809; x=1767784609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HP43QVv4guU3d0Acm7Ki5Yj04cPnUrXcJ0D2tfbjGsc=;
        b=S2O925QGAcqNvpjDticm/b99V+3bGxck4jjj5xYl1Ev/Ef0ft5sO7pywsQMsQlNhF1
         SkEI28BSygPcZu2SlpNefJFHPqPVy2F3ASkDJDKJcHZqNXFomTCPzL9AkNfVivMjKsGR
         dPT7grTEkiH0iU+CjMZeXVbI7xo5w+JreSTS58sRMYhdgpl2WPWtmJKQnwiYKcJ/PfVY
         +46scrVaUsw07IAshnkxAR5iem+azQnT72Cklh6IFWz92iJw6WYGIY43RoT95qdYJ1Ge
         moyxbu7+P8ip2LBu3ZJgDsrUf33zrdL45gf7eTecET+BtRsBMhGsCcigL4L5W6wbiq9p
         gdsA==
X-Gm-Message-State: AOJu0Yye6gfnTv3mLpMNqHguSk8SyyJJ2na3LCpnVkG0CXn+yirOM0i7
	rYhQdJTyhwfIFIkY+ypZF0h6COirhNdz2YAL2YZKZV52gbSAu/9kIp2RxmcAjd3yC1jE31yj
X-Gm-Gg: AY/fxX40qcVBfEpLJjx9snNPTQRY0QQgRQOYdVM69MBNe7/DDih/gOgYHnOY5EoC3jJ
	15tPd7dY1BdGOqd/WMPwK8q3+mdDmWQIM7LasiemW6a8EOgps+dKyNyjEMF2Yqjn7L4CbqhzzMT
	7GGdfi3anZ8+hDCyYD72TitN0uzCv5oTzKGG5k7SVxC2ExjKjwzC4vqXzaH3jcfMObyqMKqmJ24
	0idX+AoCK9ltaF9Y746zbNTMxg5lBjObG2z+AM1h8RuArf1p1RF0ys9RdIMBXwQ7+d5hEp71rd/
	PjkEC+3E2M0OD7KFVw7vwmlmQlhjLH+ToheKRB7s3LT6JTccSI5lsqThG9HRklc4FbPxrOJ5kPl
	MK0Ul7sUWlmHSzgtfWr/ZxpqGxoCO9RviuQfovBgK1w1ttygLBxeYYLIvC3ETseh8GqutvCindV
	Xpbptu3sBPADBYtAHxLaE2RqOM3mnbOAuHgQ==
X-Google-Smtp-Source: AGHT+IHi2Ut61toAu3s1RShIn5I+sVobAuSlUrvtFtFS59vZhjZeT5SbVMvzEK71GJwBCl+CIftePw==
X-Received: by 2002:a17:902:da8c:b0:298:2237:7b9b with SMTP id d9443c01a7336-2a2f283f828mr256832865ad.7.1767179809452;
        Wed, 31 Dec 2025 03:16:49 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:49 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 5/7] btrfs: use u8 for reclaim threshold type
Date: Wed, 31 Dec 2025 18:39:38 +0800
Message-ID: <20251231111623.30136-6-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
References: <20251231111623.30136-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bg_reclaim_threshold field stores a percentage value (0-100), making
u8 a more appropriate type than int. Update the field and related
function return types:

- struct btrfs_space_info::bg_reclaim_threshold
- calc_dynamic_reclaim_threshold()
- btrfs_calc_reclaim_threshold()

The sysfs store function already validates the range is 0-100, ensuring
the cast to u8 is safe.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/space-info.c |  6 +++---
 fs/btrfs/space-info.h | 12 ++++++------
 fs/btrfs/sysfs.c      |  3 ++-
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 41f1507f460f..cf2c4b7105cf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2037,7 +2037,7 @@ static u64 calc_unalloc_target(struct btrfs_fs_info *fs_info)
  * Typically with 10 block groups as the target, the discrete values this comes
  * out to are 0, 10, 20, ... , 80, 90, and 99.
  */
-static int calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_info)
+static u8 calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_info)
 {
 	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 unalloc = atomic64_read(&fs_info->free_chunk_space);
@@ -2052,11 +2052,11 @@ static int calc_dynamic_reclaim_threshold(const struct btrfs_space_info *space_i
 	if (unused < data_chunk_size)
 		return 0;
 
-	/* Cast to int is OK because want <= target. */
+	/* Cast to u8 is OK because want <= target. */
 	return calc_pct_ratio(want, target);
 }
 
-int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info)
+u8 btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info)
 {
 	lockdep_assert_held(&space_info->lock);
 
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0703f24b23f7..a4fa04d10722 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -132,15 +132,15 @@ struct btrfs_space_info {
 	/* Chunk size in bytes */
 	u64 chunk_size;
 
+	int clamp;		/* Used to scale our threshold for preemptive
+				   flushing. The value is >> clamp, so turns
+				   out to be a 2^clamp divisor. */
+
 	/*
 	 * Once a block group drops below this threshold (percents) we'll
 	 * schedule it for reclaim.
 	 */
-	int bg_reclaim_threshold;
-
-	int clamp;		/* Used to scale our threshold for preemptive
-				   flushing. The value is >> clamp, so turns
-				   out to be a 2^clamp divisor. */
+	u8 bg_reclaim_threshold;
 
 	bool full;		/* indicates that we cannot allocate any more
 				   chunks for this space */
@@ -303,7 +303,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 
 void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space_info, s64 bytes);
 void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool ready);
-int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
+u8 btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f0974f4c0ae4..468c6a9acd3b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -937,7 +937,8 @@ static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (thresh < 0 || thresh > 100)
 		return -EINVAL;
 
-	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
+	/* Safe to case to u8 after checking thresh's range is between 0 and 100 */
+	WRITE_ONCE(space_info->bg_reclaim_threshold, (u8)thresh);
 
 	return len;
 }
-- 
2.51.2


