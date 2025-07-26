Return-Path: <linux-btrfs+bounces-15685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98066B12ACF
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82259189A3C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BEC286D5E;
	Sat, 26 Jul 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeKutN80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED203286D40
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537955; cv=none; b=Jai0JzRHH+Yb+G7YOI4LhYAQgdzm9+kOE57Rj8hVH+bC+01UI4mUyhDmkfvsrAxZMd4Dw82/FXxlTkFpzzKb97VdTTnyshoopM6p8HAENwraFRy+r70xZ0VUG7IkJWjIr/EV4lfJ6thzxJouC31+ZL1MlWFjLeNCVmDxMwoTnr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537955; c=relaxed/simple;
	bh=9RlJXhh1fsg5RYdgJ2cqrwdj6FDBz1XKpMLBfCghvyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5lR3IPlkohP29DvIMs7xe3W/NitGOTvjgJLNd5nvw/FZscbMEVl4jaYAs1V5o5tcrbFzPHGL/sjfp2E/XCLlHjLnfbB6SIrh2bpli8qVeuT+3BJZRqz18/0mvKPasMKzX872CShUxC2mDCZQpjgaNJg0d0EcB1gczZTQ1PJA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeKutN80; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so600989a91.1
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537953; x=1754142753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgELN42fMqny9HnzsBMuZMliBRmqsslpQWo7QZqvBHo=;
        b=DeKutN80ixDkmQp8txEoUCGuARlHmrkYFR1CIROp71CxbXCmTUBLLmai7vsGq+90XM
         Xf9Yy+TC/OjjJaecaonwH+JNr+0W2UC2EDnTskQ7KiWVoES2zOV+9iim7TsKrwEJLzoq
         /L0xsbXbUoz6DeVcNsvCmg9niHsWQde2fVnQLBtOLbejdAP8Ms14f4CVwKvIptHi0Q6i
         B4yF6rf3bincxV+jhI2N5j2wdo0P7Jlju03ZPaKK/Ri2WxKrdUPBKGee999Qyu7yMDbl
         8rxZKZjJPwSlquX1gjzkE9TYvM7BtO4tAB/THreS51LiLCxLZgcHvQk7Ot6Cpvg8dGUF
         0gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537953; x=1754142753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgELN42fMqny9HnzsBMuZMliBRmqsslpQWo7QZqvBHo=;
        b=bt5wqKrvAWMuaCO/slAnutUjSnZ3GX27iFQJu3OAGhVesR4TNQqjnnDXcmDoIRj1tr
         0EoEfO97Jn+FdS5aDnz8AD1rzuEhPbyRppK2V3+eyZOKFdHdcwZVyu28ib45vKuF6JxG
         hFTm5ZeSFDD0sN2iR0V3TOFmV33LEhovj70odR/lO21cH/Udr4YZhBGxDX1NabC8+QGO
         vkyDqWWut8XMJq1erpJGX9okAf4hqJT37+CmZKmp2jQBFiN5WVpR15+Zm+GGYbwMvLSN
         GM7L3AO+TDVpTgcG1j2gF0McBwJUYBQ1o74TwK+iK4zKBTUD41xTsRLDWeOw+6vEaRVR
         bCfA==
X-Gm-Message-State: AOJu0Yw88bInWStAnswSVPxeoL8Yzdv9KhE3aTRa3+g7fyDel7nTfTZG
	p81FegYh+/aQ41nQCm8FSxTmxXLBJoW2ImQLral9iLr+EJvD1fq4kWzA
X-Gm-Gg: ASbGncsJAV4+4Gpd4hHe4CfRv+fVtVfG93l1/FGO344vsdsPRuvO+61MEH2wsv2B/Vi
	F8cvOxFOydha/CIfyoq2/oaZxj/J6YtZDrANnJCd16Sw8djA/q+moBvbe8kGTQLsudoftkMa+zA
	kD/MvliJC+WeL5QHQs/QRVrS8rPb27+KxGG8jWo9X5ulzd9DOL5QP7Kkhd3EhqMz8QAUnHOm3XZ
	Vkz+5L+vROSgYTu/ml2Saak7IryNiOrqKwvV64vO61dDzKLL3EPgCp2M0pAVEWshjy/bShh3ChH
	lv+PX9KBbsBhrskzkiFobpGhHrXVRKoRfMutKTGxtQ/EHoTWi/y4gXbTzW7FJ/54/OIx6ER7Mpq
	NGYwhvYkE+eBF+l+LAcufL1QC9CpYs93FYA==
X-Google-Smtp-Source: AGHT+IGdOepQQRvwa59k8zqfrgIr0u3ZTC/lvZ0EJIYKhJVrfAoPqHfpry/KYhL8jTJWFAjIJgJipg==
X-Received: by 2002:a17:90b:1e02:b0:311:9c9a:58e8 with SMTP id 98e67ed59e1d1-31e77afcfcfmr3319764a91.7.1753537953123;
        Sat, 26 Jul 2025 06:52:33 -0700 (PDT)
Received: from SaltyKitkat ([2a0c:9a40:9210:2:be24:11ff:fee6:cbe9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e83580856sm1874234a91.38.2025.07.26.06.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 06:52:32 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: sunk67188@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: early exit the searching process in search_tree ioctl
Date: Sat, 26 Jul 2025 21:51:40 +0800
Message-ID: <20250726135214.16000-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250726135214.16000-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
 <20250726135214.16000-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the following two assumptions(min_key and max_key here is the
related fields in search_key):

1. When `btrfs_search_forward` returns 0, the key will always greater
   than or equal to the provided key. So the function `copy_to_sk` will
   never be called with a key less than the min_key. So we will never get
   a key less than min_key during walking forward in the leaf.

2. When we got a key greater than max_key in current leaf, we will never
   get a key in search_key range any more. So we should stop searching
   further.

So we can safely replace the continue with early exiting. This will
improve the performance of the search_tree related ioctl syscalls, which
is the bottleneck of tools like compsize.

I've run compsize with and without this patch to compare the performance.

When cache is cold, it's
1.29user 21.02system 0:34.61elapsed 64%CPU without the patch, and
1.24user 17.34system 0:30.40elapsed 61%CPU with the patch.

When cache is hot, it's
1.21user 12.95system 0:14.19elapsed 99%CPU without the patch, and
1.18user 9.37system 0:10.57elapsed 99%CPU with the patch.

This is not a serious benchmark, but can reflect the performance
difference.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9948a12fd5e3..27c294e9d68d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1502,8 +1502,10 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		item_len = btrfs_item_size(leaf, i);
 
 		btrfs_item_key_to_cpu(leaf, key, i);
-		if (!key_in_sk(key, sk))
-			continue;
+		if (!key_in_sk(key, sk)) {
+			ret = 1;
+			goto out;
+		}
 
 		if (sizeof(sh) + item_len > *buf_size) {
 			if (*num_found) {
-- 
2.50.0


