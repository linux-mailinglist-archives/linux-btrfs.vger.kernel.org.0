Return-Path: <linux-btrfs+bounces-14480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3BACF2FF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D507A2F49
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 15:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A381C5F14;
	Thu,  5 Jun 2025 15:24:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89763198A2F
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137087; cv=none; b=ePGYr1kqirPTYLRJUjVsAgvrBmNgpNfxsvgYJayv64bmvpM3o5/qOiOyHsRI9mxxzsFX+z31MAsiN/Iig9kM+IcCu/r93BiUgGNx+oLSgnwGLMXjfFe6cjJ07jl/2GOtGZi/0Sd8KoP1+6lw0QbDWJLsexDy0erx2TXsW9c8RU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137087; c=relaxed/simple;
	bh=Y3c9u4ar0IIMN8XkxJXaplsGd+1o1rMecQQ3x4KRD3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPpZXZuzpCxrZsMNhrK/+s8ksoaCVX+0xy0Aqduc8E+fLhDKVGu9KGY+iQqq9amfrK15dm1Lj14xjnEb8f8p+b2KA3DhcjgkdYQb9Inc+1qVTIrATd6CbiJ45t7lGL/p4hD0Nnh3O3t/zlMCaPJ5BaMws8zjB/xWUR57zm80BKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a51481a598so670087f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jun 2025 08:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749137081; x=1749741881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bj2kqqH6ffjZnvxSqcgjJK3qExx/Cm9vzR14ymNdrz4=;
        b=Z1iaJYJ3nN48emBLyM238ONnnF9x6+lSnZrIVVGfssz25+DlAiAJnT53IWCsEnYzJt
         dpcAkc98SCleUvXSxHryBkvEbAwp0ueD6B7GlOMiTdfDpziGpk1OwcByGxJBCVdCF8MH
         Luxe7b4b61qcqUS9dhNS08e5x3ZO+YeQn0jjw9beTqC0UZmtx9CKuQ9RKer971UjSdIp
         VO6nDja4I3GsSwcW0GYvSwkPKm1mn7+dHrFrcHHKXFl7pQVdd2PTiAmRaVOrjX8plObb
         xi/eWENTd5iREijG8o8pv07Rto2IBdq3p+ugr6Ixjmqo/xiMXOnuS2vLKvkM2ajLwwsQ
         4l/Q==
X-Gm-Message-State: AOJu0YxouD00IhzdJpIygMd+egLqy25ScMbYn8slHGXjsEPxdXT6n5WN
	zsAF6VAwLb+thTDvOB/TKRcq2MLUaL1OwilsLG+aQDPhE3AaAZ0vEApqNIZmJg==
X-Gm-Gg: ASbGncs+PmBedSCwgFpoLwAihoJGKX2sKp7Teb60RxEOK2Cijt69j3P1Go8os3Rs48p
	Ax7nMW613HRxbiD24we6MNBvwb//4bc2kjTesW8zO8vvV0G30iGKrUdylLZ66IZb0t9XDvl/XDv
	m23wf6csBB+DMur2HdNssiyiDgZNUojD1zHaIiVxbQWADTtkldM5Lkivs83NI6FLoUUBCgnZW1h
	dxHTi6CX8ChtdR1XCehW1NcrbEYkGIm7d7beDMCm/aP8WmYjxyhh5PjKEuCXAa6FRFWieuSWl2J
	VYAyBoH9+mDEAKLsPoQ4mGgFoIM5F7B+WGzuZlwugp6uClls0Ajl0zmrk8mtmq1wjsX57roXzfE
	StZ2c5mG5LFz4QOHH7bbYA6TFWpsEBmersOzUqQk=
X-Google-Smtp-Source: AGHT+IGbQn8irZDZcDz2IrICuua2pJiNpj8gf9Fh+JNo5XyjtX3brPH7fxW35sGMOmEjloUiRcqbzw==
X-Received: by 2002:a05:6000:40e1:b0:3a4:f975:30f7 with SMTP id ffacd0b85a97d-3a51d984af3mr7116294f8f.56.1749137080521;
        Thu, 05 Jun 2025 08:24:40 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451fb178379sm21861275e9.10.2025.06.05.08.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:24:39 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: add comma delimiter for zone_unusable to space_info dump
Date: Thu,  5 Jun 2025 17:24:31 +0200
Message-ID: <20250605152431.396419-1-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

On a space_info dump all values but 'zone_unusable' are delimited by a
comma.

Add the missing comma between 'readonly' and 'zone_unusable' to be
consistent and make parsing easier.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 517916004f21..a2da9b4ab3ac 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -607,7 +607,7 @@ static void __btrfs_dump_space_info(const struct btrfs_fs_info *fs_info,
 		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
+"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu, zone_unusable=%llu",
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
 		info->bytes_readonly, info->bytes_zone_unusable);
-- 
2.49.0


