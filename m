Return-Path: <linux-btrfs+bounces-3729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063158900EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDCD2958AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 13:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CB12D1E9;
	Thu, 28 Mar 2024 13:56:41 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7830083A08;
	Thu, 28 Mar 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634201; cv=none; b=I3r3tbAVop4pt/5unkDJWQZWvcOZtNJopMNFrhm4OCme78SoFzbUreJeK7KacH3+Ctxc5m1VhizZcCyXiQvo2BkbFa7Q+4WEZ8XL9+sisXi68i0X3rRJUjOjMm2f+qVZaOHo16TQso9iAJlrMiv2ydZk7A0+/8ViDbD5egH0tEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634201; c=relaxed/simple;
	bh=zCWARO4cU6ipBjqQ0ides2u7RHSpySTD3YjFyt5mff8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZK8KWiHn/uqa3YPojoRqSOSrqR+GptlNXuY8Vtzf3LgLRs+hOoEiKbHR2B4XVXOPiyJFPiuEJqt8SQGBpuusC+LY15jofBP/o2qEOKr8OmtUz+YUbftkW5dHO4AiARC8EBj7tbnz4ws3yJDzfFNNAgUgAMJpMj071Ht1qvX0a84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4141156f245so6984525e9.2;
        Thu, 28 Mar 2024 06:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634198; x=1712238998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jnf2sQ/2dHHFn3aPbM4EqErtjtbBBjy2+Un0IzylCkY=;
        b=qgoxpadkEXWNa6MEDG52puX7geva75oJQGLgWSuHjjwTg6Xl4EjUL4289sWkJRlrni
         FIQgWUnLbXkq99O1ns/MPdfXhuHP6Vo9pOQjx80MVpgmq9pXAT2pKMzLP2j8NeGqa4mn
         ot8n+CE0tRIcAAj2HQi5HJq+x1ifAf+pbJ0W63/XwG6/9lccolrZJ+A2bevBLhZeC2tB
         eRiUZF1hJdfAb9FJzIc4LYiLlhuTstKq1+XDCG8sYmw8fPXtTQWsnXPcoD6gCDpg5Jng
         899G24aVF761CJssJ9u49wuMyHAqZgMow44AmpEh8r1WFKJwRxMhztlrBn5MGnwHcmlU
         x33g==
X-Forwarded-Encrypted: i=1; AJvYcCWmVkd8XM38uiAf4nYDyIJNDOtGrzjMyeM5YrgRdgG7C5sV5K7LQFJymqmSLXGor4ejfp6GenMrs8qUX9YQYQVcHQ7NXviiGSBcnDIH
X-Gm-Message-State: AOJu0YwkvY8x15Hrm7ONYHXBxDFmsBhXuiyckhNfmVMtkFvidDxT3D9q
	ndn1Sm9Fe5VXwCq6cTMIhqjJydYS4hxoS5ixmQWQJ6iNf+pVF+IA
X-Google-Smtp-Source: AGHT+IHSc0Ag57wUydtZUmvEIUV8BIzYY3xcCT7jti83u0Y+vnsmmK+sU5mP7C00IW8aorHW0nWMBg==
X-Received: by 2002:a05:600c:4593:b0:414:9456:2f61 with SMTP id r19-20020a05600c459300b0041494562f61mr2215120wmo.14.1711634197795;
        Thu, 28 Mar 2024 06:56:37 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm5519570wms.25.2024.03.28.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:56:37 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 28 Mar 2024 14:56:33 +0100
Subject: [PATCH RFC PATCH 3/3] btrfs: zoned: kick cleaner kthread if low on
 space
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-hans-v1-3-4cd558959407@kernel.org>
References: <20240328-hans-v1-0-4cd558959407@kernel.org>
In-Reply-To: <20240328-hans-v1-0-4cd558959407@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 hch@lst.de, Damien LeMoal <dlemoal@kernel.org>, Boris Burkov <boris@bur.io>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Kick the cleaner kthread on chunk allocation if we're slowly running out
of usable space on a zoned filesystem.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fb8707f4cab5..25c1a17873db 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1040,6 +1040,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	const u8 shift = zinfo->zone_size_shift;
 	u64 nzones = num_bytes >> shift;
@@ -1051,6 +1052,11 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
 	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
 
+	if (!test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags) &&
+	    btrfs_zoned_should_reclaim(fs_info)) {
+		wake_up_process(fs_info->cleaner_kthread);
+	}
+
 	while (pos < hole_end) {
 		begin = pos >> shift;
 		end = begin + nzones;

-- 
2.35.3


