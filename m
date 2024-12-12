Return-Path: <linux-btrfs+bounces-10320-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084B9EE72F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 13:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5F1284005
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8B2144BA;
	Thu, 12 Dec 2024 12:56:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5B1714D7
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008174; cv=none; b=QpRpaavVxEADG8Pp4zXrqBXQ29R40Yv72KOhPvkEQH8TpupRukD0Vm96hVv6crnkr3QnT/PYLvKyjGXDXUGVa7xeifViXnopV8u2YA8F9wyeYa+z2LK6zSEb6QnQ48hb548I4KnOM3H7o5Y66Z6Cn8zE09q+cHABSeFIrA7ulis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008174; c=relaxed/simple;
	bh=8HmWO6Pezpvk2eJU42W77bp6rJ+qqtys3hdepcm2W1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCaPGjz/K+WJDaVmggn2PX0iPDqqopGs0Q1lOYSTJNwOY5cA4dRFA/Er1FvtkAMsQFd9uvXL56h+mV/83JqFQU6kP2bXd7gPpFU7e+FzoS2KMNFKs11yVNqMuauvW3P8N9RVJJQfk+pnjEmCwKdHB8ZZvApkZArOlAt3picqnJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6c0dbce1fso73765966b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 04:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008171; x=1734612971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N16ozZkdRuQ9IymP33KCupFSnR5sIv2zwQpbYefa6ck=;
        b=I2aDWO+DukF+Ij2CoK0HK5NlY6Vyse5QJslMElQUq3whJ69DwaGHoRbjdzq65yVQ4d
         7CiminH2CVbqgSIN4RGaEbhl8GM2Y9es/bSP4UbVnTW44IDJUUqGt6p/X0eDePuX02pn
         sOYaph858dYRdSUNLVK2kSIhQo8jjdE5Fa53Q/SITc2wcKf/exdo8EoBLWvraOBuxZHO
         7w7EwGIZyZQteldhQ0DIyv37SKLE6LOWF6L2w/mTfni1ql8Qv7frioO8sNOu5kJql8qy
         /QndW10SPQuL5Brot9bsoYTWRABTjCqFAp0hWAZ60TtMST7UQUlbgeSxRpPmdCzqFWCg
         naAw==
X-Forwarded-Encrypted: i=1; AJvYcCUMWCC8UbO7APrdKOP5ITkIef/C+q/jvzqD4YZ34eQqKaNOjBLIhz2juWVLhzpKm7i6dy5Xfq3Nx1RZxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF1DBXPYt8OhqiO8iDqpAVNSSBeB16NG7N1HzfMRxG6pkycY2Q
	OnZZ1CrFd/bxJUUdlNTIo+zMQGhXGKHzXA2+i4BvtAw4detxNp9h
X-Gm-Gg: ASbGncugiAksWlc9Q5s3r7BZtByPn+SxV/9qwW4OAmnXYqBtiSmTnY+QR68yNXEWsOf
	sC94jMqm5pxS5UttY4I/Xc0zmkf+Qkb+B2rxixBAH8bmxKbNN+1Rw6/liYS645p5oxk3nOuMY5D
	M8F0XmZUojdTqMV47UZGgmITnbA+EAXZT4dy90Lf5QTJeMnMzPZEkOOamyTmKlYz43sEEH3vcEr
	/CkT74Qv5Tsm1ISqj1JiSC+PQFh05DtYh1UwK5a4MqvuxFXKLnWbtn1iU2HUppuUcNW3BcrgGrD
	ANpvU6vky1OlNtNe/R5IajbZfjZ+4Icy5G28S/k=
X-Google-Smtp-Source: AGHT+IFdJTuTK1O8BIWu6wcXzak3zhOFHhTk14RnU3P6g1WPWDPD9Pyqz7FBUIxBOjzPOxeh6XquYA==
X-Received: by 2002:a05:6402:4583:b0:5d3:cf89:bd3e with SMTP id 4fb4d7f45d1cf-5d633eb0b2cmr294643a12.30.1734008171055;
        Thu, 12 Dec 2024 04:56:11 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a48ab4sm10302601a12.27.2024.12.12.04.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 04:56:10 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: removed unused variable length in btrfs_insert_one_raid_extent
Date: Thu, 12 Dec 2024 13:56:06 +0100
Message-ID: <eeb2f4fd6565f76ddce9e8af725bd613e9b50e19.1734008129.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Remove the variable length in btrfs_insert_one_raid_extent() as it is
unused.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9ffc79f250fb..45b823a0913a 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -199,12 +199,8 @@ int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 	for (int i = 0; i < num_stripes; i++) {
 		u64 devid = bioc->stripes[i].dev->devid;
 		u64 physical = bioc->stripes[i].physical;
-		u64 length = bioc->stripes[i].length;
 		struct btrfs_raid_stride *raid_stride = &stripe_extent->strides[i];
 
-		if (length == 0)
-			length = bioc->size;
-
 		btrfs_set_stack_raid_stride_devid(raid_stride, devid);
 		btrfs_set_stack_raid_stride_physical(raid_stride, physical);
 	}
-- 
2.43.0


