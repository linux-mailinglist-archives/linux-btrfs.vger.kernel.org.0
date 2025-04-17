Return-Path: <linux-btrfs+bounces-13128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A48A91BA8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0558A1C48
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED0245020;
	Thu, 17 Apr 2025 12:06:21 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79912417E4;
	Thu, 17 Apr 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891580; cv=none; b=bBYBSw3VipPJlj4GhauR6GAqnUrHzgOSwZhWGxZ7G3iF/uGvBZgfSJEU6oNhNU4SWL06/WSlGgKU0ovbukHeYgv+Uaj9Ij2NN4nrR7oivJ5t18AFRUz1V3q9dVIAcK62E22uKzXj4gFKUzl1f01CMXNAy5whbCw6A0NV1vNDvFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891580; c=relaxed/simple;
	bh=wEnFlJxRve1NFWF9I1bgzC8eynXVfr1y0Jxr3jBRRHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cklf8c2AGJQcSoQdgb55S7FZnPgfY9/mZVkVSrd/028Hl1m9pgzfHan7K5XdDSXZFg0UT19aqOwlG5b4dzx730rV+oLaqnvwQpdEWVkDI/F3mM/bEufJHGAdcKadhxuIGGOZZ7aUviom3UsPjj+GI9zRyciKgOxpPthHIZALCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso398820f8f.2;
        Thu, 17 Apr 2025 05:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744891576; x=1745496376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nJ4pFXcgEytrOoIe/LrTs8zBGh0acbfNXtudznIJufk=;
        b=sFSI0wbi8YkiSEwPEjZS6O8oCWt8OwW7gRh1/4leIS5xcQ6SfjeI0LC0rLozHNr8vW
         FwqXPvOt93Xst5ShYr359EXTSmBjeodiWh52U+DbeTaivc1fXRu9LIoB4juNsgMg6s3O
         u8M0rP9rf1z2uquMIRW3aDf7h2+tcdQq+5xkYZLWXH/jSMfd6a4W4fZYLobBqgecaL+W
         lzrVbbqE858I4j+Eibj2OuzMxJWxtsQk4wR4VehvCebhCBRa1eg9uECar7pqmkoVHQTQ
         k/5rMekP1xMpDWAxSm/UrGzgdMMrqXjOSgqjG+pR7+q1u1+Qs21h0gtGtfqNxHVL6ZbY
         0mnw==
X-Forwarded-Encrypted: i=1; AJvYcCUUmsrDq4HbBwI6DJjWXaYCcBd4YSePNgxYNejRGLayj/Gsv7yQi3rOGTMdTT4CPWCKntQW5OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgXyUGGZXnXd92iCBofwQ66FMr8Ui/sUWbHZ38sd/5ZpW/px6
	zulz0fqW3UvPTzBxKo9ETCqtAjEh2lGDuCwiLNOkWri7+2T5VJPr
X-Gm-Gg: ASbGncs95s0ecmiRoW+zGoXVHJXBVZtp/nhzN9TfjLo9oX0tSPaRFYt0zWapMw0Y6cJ
	k7MXUIFM85Peu0EVnyxGOTnZGBazqNGObxXZqcNfYTuHQ+1h0uMvXrDIa/ZDBiQyQdNKRGIrSum
	v6fx0fYC9PBumP+WUH4BcT76ijyqPyUSgK/wKmuuT/aDceKx1DnYyVji/0eZ1FcToe+iCmcM/Ud
	QJbzgXkt+oA7+rZKIWE69ecKbAJIyMmJotv4HiFa/Qxp+G6mYUmRoG0t0OAJCEF/J+EN6rV1JVo
	xCEm4ji2AicpoYNE5c9cxNxt4Iq2j0JI/ZW8HbkAkFmY5MqtyfQDqXlL9WRd5Cs00vcyS3KvKaz
	GADceAKmPsG8d0vNP3WHX6eQ=
X-Google-Smtp-Source: AGHT+IHn+d/7CeP+L3s+HAmDt7c5wzoZyQeb2ZleuZtHftjOIdXxpN03yKdm95qrFXtnzYChTlwaag==
X-Received: by 2002:a05:6000:2911:b0:390:f2f1:2a17 with SMTP id ffacd0b85a97d-39ee5bae46fmr5192363f8f.53.1744891575832;
        Thu, 17 Apr 2025 05:06:15 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f710db00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f710:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f06bf0fsm10202345a12.46.2025.04.17.05.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:06:15 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v6.1 1/2] btrfs: zoned: fix zone activation with missing devices
Date: Thu, 17 Apr 2025 14:05:58 +0200
Message-ID: <5adc66d15dd8aace14461451b9d9668795431fca.1744891500.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744891500.git.jth@kernel.org>
References: <cover.1744891500.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 2bbc4a45e5eb6b868357c1045bf6f38f6ba576e0 upstream

If btrfs_zone_activate() is called with a filesystem that has missing
devices (e.g. a RAID file system mounted in degraded mode) it is accessing
the btrfs_device::zone_info pointer, which will not be set if the device in
question is missing.

Check if the device is present (by checking if it has a valid block
device pointer associated) and if not, skip zone activation for it.

Fixes: f9a912a3c45f ("btrfs: zoned: make zone activation multi stripe capable")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 794526ab90d2..46aadef5a463 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1909,6 +1909,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
 
+		if (!device->bdev)
+			continue;
+
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 
-- 
2.43.0


