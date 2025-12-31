Return-Path: <linux-btrfs+bounces-20052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A810CEBD92
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 884C03046FAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDD3279346;
	Wed, 31 Dec 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFGALjL2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4A2868B5
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179809; cv=none; b=eThS2ADEhNFqvR3GJGObUpvrsceFweJ2lmFDBHj2piDs+H9JwJDZIDqjlnfaGhjV2W1GQm9K1nXE3yDVHNfbun/PS2/yNGc5EqJRco3IXISoJ6nDs77FiOKDr3eLrSnpNf084g5hBMcWrghQXJ62sXGp2W34p7mChx1uK+73Wbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179809; c=relaxed/simple;
	bh=SFwp581dzpcjshO86ODoivES/fZE1hZnqwPmoqNNi08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffM3G44FDoYSdiPKgLngyNkic7YGX0/wuPfCJR9r68qhKtRDBfWMx8bUwpV9pI5pIqXEphv/9kW9ZstOLf0H984F3A2A8E3b5wyPIYH547vME2qYVYJjdzTT0QXNJVjqUXf/WHPXADmRglU6BO30UgEthH+v+Kk7y58KQG0gac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFGALjL2; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a0a8c2e822so29042895ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179807; x=1767784607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSzr5tBg4Qpva2G23hafAMsVbeT1GCEY8lqBU98gB2A=;
        b=ZFGALjL2KEeUL7EXck04d9jnyDuy4O0ItPNNVIQtb9+00E6N4fU+gfefhGwDJaB6Zt
         2VRGUrXZiBweq6TcoPTcQaGkmN7yRd0C1OysIIbKgNfkyHhph39riE345AmMfIBtrFUb
         8f7D0/6R+FDE90GpWgq46Z9zUYSFbST90k52uhntCUumBfbrOMHDT679fIp1CKHjvH3i
         JBDgWOyN9U1YJNmfGTdAD1IhBFejdsJ3rCpDqVdPM9lIF6gPaV7DSK0Pg02WV49E+w2A
         u3bX5+ytwOOB8hjA5x3lqxT28yZElxEAk+gjWB+Y4NNN1ZGWmjwluZO3yNhfGUXttnNY
         vSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179807; x=1767784607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VSzr5tBg4Qpva2G23hafAMsVbeT1GCEY8lqBU98gB2A=;
        b=HkrPDMzX0qufOTTAki7dBBMsOz4jQkw1g0yvfYiFfKM0ShQP2PLi6cWdiKrLLPUfwk
         lm6KehNfrLlbCyQukNWaeXaSLqhlDuRX9RvpNokWy/ElvkRJFfQkw+DnpHvEva7yzfHH
         tHn1GfGcQhqAXS7tUM3iXWEedfFuHPQu8BlCdLd3Fn5Kp7QRjunEj5T0TghYnGW6ANu7
         eWhdxnVmFLnG/OoerLtpIRh6PbR+bZRienVX0gs4iCkt+DeLwXI+7vqSLcibClOutHyi
         54Z+FNMlWEoOimTShAlLfDxCSNgIaKFS4n/ZS29/1vMlMXgZI5GlWXllLLzDUFryCVw1
         jW3Q==
X-Gm-Message-State: AOJu0YyIOK7wutIJIasOP5bhbN27mo9RWDETOvb5JXK27/xids/2/MKi
	yDCW8bYmgm9s9UhRVLQmyT0z/4pB/lBv1pgcf+pjPsi3WnjF5RLmAkrMtA3tFcYfMG6DxS4Q
X-Gm-Gg: AY/fxX5UuYNbmi2x4TT9EyW1zbtHq8mYH0NwQt27wbYbmpxc7CkQwpn78aYoR00j9ks
	mWyLr+9XgaEgTf1O7h1OdaEUOwrcftdzdt6KKIntyup23jRLogj1+/tQ3X4PziIrTOhe6vGEY+q
	TXYHVSXjaDenL4dBCFUHdhdMkOI+bTwPwTwMJib/7nZ9caRZkL2x8CA/So7Pi5aUZFxfE18Bg1l
	GS5a7sbjU7QuSM7iS70NqqWz5UQQjSWnkGkidLmVGbBjoFBLhAn1C9J3z4cHG1hVTD+EPbvhLOB
	4A6+cKHR/j9yV1wivBYhwlqJ6zAkXKqmRkI/3q3dweU6oSRLxvL+V5J1goDdpnNCiAnyfs5t/1w
	WR3MN0asfJuBH71QR34iaBfdKZhTHDPPWPRncSWyon0qSHlGqNR59pX9BDRJ49c9HBQsaQb8VtG
	9wOayEBQwp+KNszvckVvbZ1ss=
X-Google-Smtp-Source: AGHT+IFRXoGlTqgutVy5Y1QGt7DuAz2WQgutrY4xbw0jJ6wffKBKuTajEbmRWZYaVRIkKfoK3X6Qcg==
X-Received: by 2002:a17:902:f68b:b0:29d:7e23:629 with SMTP id d9443c01a7336-2a2f1f71de1mr259524385ad.0.1767179807223;
        Wed, 31 Dec 2025 03:16:47 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:46 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 4/7] btrfs: consolidate reclaim readiness checks in btrfs_should_reclaim()
Date: Wed, 31 Dec 2025 18:39:37 +0800
Message-ID: <20251231111623.30136-5-sunk67188@gmail.com>
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

Move the filesystem state validation from btrfs_reclaim_bgs_work() into
btrfs_should_reclaim() to centralize the reclaim eligibility logic.
Since it is the only caller of btrfs_should_reclaim(), there's no
functional change.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1dcc5dccef05..944857bd6af6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1804,6 +1804,12 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
 
 static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
+	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		return false;
+
+	if (btrfs_fs_closing(fs_info))
+		return false;
+
 	if (btrfs_is_zoned(fs_info))
 		return btrfs_zoned_should_reclaim(fs_info);
 	return true;
@@ -1838,12 +1844,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	struct btrfs_space_info *space_info;
 	LIST_HEAD(retry_list);
 
-	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
-		return;
-
-	if (btrfs_fs_closing(fs_info))
-		return;
-
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-- 
2.51.2


