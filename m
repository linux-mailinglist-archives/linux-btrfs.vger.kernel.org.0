Return-Path: <linux-btrfs+bounces-14128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91BABD047
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 09:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C523B4B97
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FB925D1F5;
	Tue, 20 May 2025 07:21:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E110E4
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 07:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725662; cv=none; b=gTb26nFkjtbGTQNt661556+2sfWeNcT1DSXePik5WLOBP/tR4Kg+w3SHOJeeAB+AEA3JyvbnQJN+dK5Lvfstn6zkrdDs4KoIFuz/RpvBAfAShFEVjAn/fLhx6g5I8YkRlqyXgWJ0wNjrgpdCrJ3Uk7+B4fpz6Odh/+mFaOANO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725662; c=relaxed/simple;
	bh=hPJl8iMfut3OgOpEP0Gz6510jqXg6HZB7A+Tl5EhRJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZedH7hYJEKdbKCSfGmNW7Ji6xk7PdCmIoordkz7Cg+dsHmKeJEXmxTY9fRpYmjX0dOnTaDdKaV67crOTmRv+KBoIW6x5x87fOSVgMmOZF3OMagel5lIZ5ILuFWlsc0EBDoZvG5ldszJvZcRXzcMwuHIORdSzYPyW6keY4coi2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a376da332aso941031f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 00:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747725659; x=1748330459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd1MPZdAO52e1h34Womw/UzYgcMCjj0DiySHNSOEJl4=;
        b=OsQFgRFDU+D8AM0r7qjsEdqQvX6az5SKxBJGPi+L7HEfrHxE5a+7diTosg0e2PrLn6
         qdkQKbbth279lTzloMJYJFEQmspC3eX3JH3Ld87IDlHV9zDL8Ii3cA+IzE5OqtwA+VX/
         bSXB27K6kvE42iSmFLLD2oInw5eXUsHrO6E1wyT0y/dB/6FFJNlzIXvjEqKbH4yJKm8j
         n7RieQqEax6mccrf3qtA0CBDKbTWf61SLDnuEJoaaFLs52ud1LtPqgwUBfnVDHZCJHok
         ezjeixTV7dQQeq09WN4mJ+ckhe6xy9N/5StpYDjsDnGNz0U8cLC2Ca71A3qjxBd4WIh4
         /G+g==
X-Gm-Message-State: AOJu0YzpFhjatW+Rp7SwCtnpgjmpcYusXVlSiuDfcQ+0nOf/pGm7HjUy
	6kTKuDkV5mUvZkcglBq9XqeziRvDVRt3/yuTv7wBL9AzLPFRct/k+m9sU39Xm6mi
X-Gm-Gg: ASbGnctIMvqL4Gnv15Bai0+ujqlb6F5Yp2aM7i7p5iJsVQF/sukeTD+nirPXOhN6P2a
	zLGvtRUu4kthesn0GRXh1rRIIgaCDi/qIkI1nSBc+KsKYlF6yx5jaiEfmrKvjCso/zQDgHxzPOi
	7lLin3EHwdWQvJpvWVDBue0depQDwTClmAwUavLQ4wW96M54ubJwybNqLMpmhaJw9c61yuCLX6E
	7p/HxPaCv614YtAkil2pB6I5+199EfKCkoTdK2omd1n1QF8xorPuNVWYaTZf3ZoeB7CchC+p3UU
	UByROUFy3y70XoyPYCPHzOQJZp26Gwa6G4mMIru1w6D8obT3TT+HcYm6bJPtrQDLqc1fhRfpdSA
	yEll8weOKauVvmGkOxMyORAkWwQALfzMcKQ==
X-Google-Smtp-Source: AGHT+IEGFa8lR6iNxN3X6E8Ix8nSQmCJWdvKUAd/jVhnrTohye2hyY7g+eUvBH0+FocFD5+NySZmDA==
X-Received: by 2002:a05:6000:2288:b0:3a1:f937:6e7c with SMTP id ffacd0b85a97d-3a35fe67a7bmr13716459f8f.22.1747725658878;
        Tue, 20 May 2025 00:20:58 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7057400fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f705:7400:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a7cbsm15603625f8f.35.2025.05.20.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 00:20:58 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: zoned: use filesystem size not disk size for reclaim decision
Date: Tue, 20 May 2025 09:20:47 +0200
Message-ID: <ce29d9ec1af7412e3e3e481e2fc3fb23842dca23.1747725440.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When deciding if a zoned filesystem is reaching the threshold to reclaim
data block-groups, look at the size of the filesystem not to potentially
total available size  of all drives in the filesystem.

Especially if a filesystem was create with mkfs' -b option, constraining
it to only a portion of the block device, the numbers won't match and
potentially garbage collection is kicking in too late.

Fixes: 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b5b0156d5b95..19710634d63f 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2465,8 +2465,8 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
+	u64 total = btrfs_super_total_bytes(fs_info->super_copy);
 	u64 used = 0;
-	u64 total = 0;
 	u64 factor;
 
 	ASSERT(btrfs_is_zoned(fs_info));
@@ -2479,7 +2479,6 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info)
 		if (!device->bdev)
 			continue;
 
-		total += device->disk_total_bytes;
 		used += device->bytes_used;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
-- 
2.43.0


