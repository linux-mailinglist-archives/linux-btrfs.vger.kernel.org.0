Return-Path: <linux-btrfs+bounces-6927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED8A94374D
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 22:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A23C2840D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6869E16D9BD;
	Wed, 31 Jul 2024 20:43:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEC16CD37;
	Wed, 31 Jul 2024 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458611; cv=none; b=Cc5hhm1C7Uick7My2RSEDb3Mt2QGb/5dwPsqWshVdw+i4/amVrZ7AHxkmrWc6r1OgmbZtgterERH4MoKZ8kucL06xtXeqThbsu/uCALVc/6+djKEY8Dc7ytFz/lOB/hzJ4jcV3bbD+SgceU70ckHXtJz/dmk7r83b0Sb10f7Ytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458611; c=relaxed/simple;
	bh=tZboRP/+4mQacUKXIXwDMXZs+JVgoNI5V9YgSrvr6Xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuhTs0AJnbHEjBWmRgp5eqTBu1HRl5LKoWDY3+jjOHzOmx7fECCeHvn329WMP++pOKGHPln0GsNRjzUSDVrkXteRE1ythaihBGh6FwMxeFOstcXOjt0+VV47ailUeaUFKKycP3rtP/ogls6jb0eRVkuIXp8lqHD+vstUUOxN47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aada2358fso239370366b.0;
        Wed, 31 Jul 2024 13:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458608; x=1723063408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DT2eMmJlRPISGpF1p5jkVFugCIV2VDJkFyEE/4PTkw=;
        b=iAG2HZ6vMVQ351z3g+IByjvt500mP1+F74BHbYN4JG/hb6kIzJmuhZ8tuCI/R9opeV
         ApQC78WVEZD89I/yxpv78pU5r1FjCi8oDPtFCXifaKRdOTSlv9JPAyH38o85+9NP2euH
         yA9ZMpGedAg38mle5WY+s02oRVa5LB+2mnVGQjyZ5alsQRZoMU5WX3hVFRbQWaPmJP8g
         S7mieIcFnYd/bpbFCev1Ep8vhCmaDWss9iRg1owAV+ThtBPdpUWsVZ1c4efvO1dxCe5d
         IwEQbUhWM0mYe3EJVZncBeNAgfBBoHxGpPzchuIgRI4kTEmld/Y/X/qf8AtGPcd/7Sf6
         TjSA==
X-Forwarded-Encrypted: i=1; AJvYcCXBDb4hgmbVDZ1s2BnFZQf33qeHqipZkB8BHJnehpI86HryJ6XTbO50I2IMfZ85EbvlZ1CBbxAZyL5tDeZH9uwRLqCU7CtqpJ7qUZoU
X-Gm-Message-State: AOJu0YxuB7Xn1HOQWFhVbHHGgMLkEODQ38JEWT36U92WyeoE8qdwlfbr
	RtRtqUgmmM2ciCk6Zt5jGBKs8bW7opmMDRzLeIRR1GIJ4C388YBz
X-Google-Smtp-Source: AGHT+IEhZ7af1XwaJVMpX3tSWKyNoHRVTS48+Zbg7o9RXstO8RpmECDHgCkOQIGsxKeXjmYQ983Rvg==
X-Received: by 2002:a17:907:1b07:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a7daee5335fmr21872866b.22.1722458608428;
        Wed, 31 Jul 2024 13:43:28 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm807454366b.61.2024.07.31.13.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:43:28 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 31 Jul 2024 22:43:07 +0200
Subject: [PATCH v3 5/5] btrfs: change RST lookup error message to debug
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-debug-v3-5-f9b7ed479b10@kernel.org>
References: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
In-Reply-To: <20240731-debug-v3-0-f9b7ed479b10@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenruo <wqu@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=jth@kernel.org;
 h=from:subject:message-id; bh=ZDUzLvgB6IiCMYV7UPQGbGhRKgjVEj0Z00Tth7gECio=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaStWvhqyqlVe1hXcufPzjlUInS63r7A98GDv5aZzzeuy
 ODVvNoY2VHKwiDGxSArpshyPNR2v4TpEfYph16bwcxhZQIZwsDFKQAT2XGZkaH1XOaxg09S5ld7
 73r59ftFNT++gPQF0YkyAb9nv+u4KZvN8N+j7o/egpuSF3X/zz64uLhG3CBXMHFWntedZXc7Zq+
 /aMkMAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that RAID stripe-tree lookup failures are not treated as a fatal issue
any more, change the RAID stripe-tree lookup error message to debug level.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 28a545367be7..4c859b550f6c 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -284,7 +284,7 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (ret > 0)
 		ret = -ENOENT;
 	if (ret && ret != -EIO && !stripe->rst_search_commit_root) {
-		btrfs_err(fs_info,
+		btrfs_debug(fs_info,
 		"cannot find raid-stripe for logical [%llu, %llu] devid %llu, profile %s",
 			  logical, logical + *length, stripe->dev->devid,
 			  btrfs_bg_type_to_raid_name(map_type));

-- 
2.43.0


