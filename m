Return-Path: <linux-btrfs+bounces-11400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624AA327F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 15:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE49166F42
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C620E71F;
	Wed, 12 Feb 2025 14:05:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7892E2AD2A;
	Wed, 12 Feb 2025 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369113; cv=none; b=YQcS8QEBVXgNnb8n1pOM8Ehg/AdNG/GxTbedH9QayJCyvixiC7EJr3x3mY/PKm3Qa9qPomp7PMQ7TYMPLoXfws6J/+0IfRgYaxO/I/4is+eQwdxKWppr1eximw4oOyshzeC/vSQ/psBJLt5L4y3EY/PfrK+707L77duEMCPN66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369113; c=relaxed/simple;
	bh=ykSp/1zD9IjT/1oxpjNAL1ynWWgDup2h4+jeC5X7X4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h9D8HkVrjed1Lu3biPgaakivRCl/DcOlwVEyAoGr7ufiT/0LLkN9f3dVn68O2kqWxxJvjuW5fY5AQdcCHU7Ifo2gN4LLAbs9/t4CtLmlACvawTRw6D3J7iCZtMFqdEdwhd5Kohv2qMwOWN437SpHARGhkR3EK/ySdr6MrhkEfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38dc73cc5acso616294f8f.0;
        Wed, 12 Feb 2025 06:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369110; x=1739973910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mqr3NuXy3fLg1RLkI7ov94kJ2kVqv3qkeHEnaJAyHJ4=;
        b=b+2hanQa7djIBW3hAisD27aoVBlCAailniRCuTjrTDAwkLEok9qyC5gmIOABS/hJTS
         HDHDdH0wEErBFpD6qE1PBfEK4bOJxCpUwUEiwaEzXuJAZcNCKXV/QXQIm8/QvHF1DcJl
         RKThXkEkYVMeirYS9+EV2GeWMlTDkP+uFIv9Kumk/+ilM4ve8cFNwXLJi46rNlh9lMTy
         wn1PyJIRFUF6/75MhCJkvayG1g9g4MDROT9NeFz8efLH/rrZ9xMgksTssKfhuY6ZWhAB
         HFvZN4sDbvdhbETxehZftN0wESUwFYQAczWEAIRHfXXkDJjOkudKQ0dU6JSk46Syr2C1
         misQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQuS0u8Roae5As1m7PqFaprzwJ0lgXIRciOZpe+LizYIKh8kJT+NREImwM4SgW24Pt98dxJFOI59HfWsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7VyzQBs1xu+kUQR1hjIHnbImPB3dXAKtMDoKRCo2RxEn8wxi2
	EU+JL0cKPT3naUVvZ2fexs71WNawFNOdFQ+YABx76WgpvwBIxRfMHhBmVQ==
X-Gm-Gg: ASbGncsqZp+hkHNCNGqViyKRHMJ3hmxDjl7LwJAJsDD9uFNbFBVySSOAoW0DA/KIZ7M
	BQ/6pRvN8+tWVkVYtQejla3lF/RlMA0RbGPihQoL+0q//la+5031NsVOvsQo1gw7Yf2qQkurX30
	PyDgcxxNtYTui/hok24viAlKk4WJqIj0GTuPxKpNVahe8ozuHy7enf7IsiIjvXILRxGSz7JjJTk
	lAqiNazQfoMEOnkHBtupuW1P9N/Ue2n1RKy6NGTAisdWl8mReiSWuYO4nVV7/2cLyqY8Oiq1vRz
	22D8I99eKLoSGEu8fIeAFHo66Cmy0WvrLFDXCs0HjF+SaAkaHHeMDZdAMvF9xjKNYEwceBIkJA=
	=
X-Google-Smtp-Source: AGHT+IERulibgq1AYPC5iCgwg3Fm5O+QJN7ufKsGSXtSCuKtU3lTTV3aYRDRKJLXjK4yevia8Yb5ZA==
X-Received: by 2002:a5d:47c2:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38de43a5bf1mr6282133f8f.15.1739369108763;
        Wed, 12 Feb 2025 06:05:08 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7229c00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f722:9c00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04cd53sm21169995e9.6.2025.02.12.06.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:05:08 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] btrfs: zoned: exit btrfs_can_activate_zone if BTRFS_FS_NEED_ZONE_FINISH is set
Date: Wed, 12 Feb 2025 15:05:00 +0100
Message-ID: <f811034c9494b256f50a0675297f072a6b65076d.1739368972.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If BTRFS_FS_NEED_ZONE_FINISH is already set for the whole filesystem, exit
early in btrfs_can_activate_zone(). There's no need to check if
BTRFS_FS_NEED_ZONE_FINISH needs to be set if it is already set.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 73e0aa9fc08a..4956baf8220a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2325,6 +2325,9 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	if (!btrfs_is_zoned(fs_info))
 		return true;
 
+	if (test_bit(BTRFS_FS_NEED_ZONE_FINISH, &fs_info->flags))
+		return false;
+
 	/* Check if there is a device with active zones left */
 	mutex_lock(&fs_info->chunk_mutex);
 	spin_lock(&fs_info->zone_active_bgs_lock);
-- 
2.43.0


