Return-Path: <linux-btrfs+bounces-6507-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95267932E41
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0C72836B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4744A19E7D3;
	Tue, 16 Jul 2024 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRTpaDF9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FD1DFDE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147096; cv=none; b=DnZPw7b9uBQR6k7PcsjJfz1JHc7Ju5y9xktDGprEypI2oH/SKrXMG3ABnHqxYo7looI/RyrZf6n64iXGb5GfQrntr+kItoeez6yLS/rddzfIH6hg+l1HHBHDk8gPqnURAxfTpRv/BynJMlKV9HsiUQ2ze6GsyV+TW3FAxYXlzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147096; c=relaxed/simple;
	bh=fRyJl31YGCNvNaUDWC32ZzQ5JPEBEKDaZuEPyNd7cX4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RBhm3xLCrcykNOLIVCkLXpV2ADZzhGKAuuFw/NkJ4ekRgHUfjIEpBJ/SkUyZxMnty4To2RjgYTNGHgHHvXAYAENs4WLqk2ISCebu6C7nepi6X/SkWZAohw/Q5+84icDffL4mB0Nr7GzW8+Vp89F5Q8Y1tXYKuYJSdx9FWKQEEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRTpaDF9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fbc09ef46aso41898395ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jul 2024 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721147094; x=1721751894; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUMm6XQNOlN8i1yKUlJhQrGQwQkV0evSPUze8WXo5Dk=;
        b=dRTpaDF9BQJf/HEAF43pwhQwHoQfMayQNU8LeSVHw5pX2u+dRXPJfj2LJpuvFp5ZCZ
         g+Cfo5jW4pVOMQEG/yH3ItDa8DKe5FjJjwaHqbG/N/KsJFH2WjnPys4uLibrDh5Mq5zt
         jsNIbQVzOHJteLppGFkvlaQWtJmtLSYBrjuDzCLvwStRjb3L+dytILBwwPQ4e74FJUNC
         AypLc1SZJuI+kqzHiLjwXewbjXtF8F+wvVtDoYwlUH77dvjYCqfTMM8U9AW0kOAXBpvj
         ertI3AY0ls6G4zTaqyh1vGxnbU0+wfoVY5ifxcE0OXGK7PrFcyjMmipdqbh0Q5j5yClT
         qzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721147094; x=1721751894;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUMm6XQNOlN8i1yKUlJhQrGQwQkV0evSPUze8WXo5Dk=;
        b=ZMnVCHfckUSJs5KioCOK+FcTx8r21gOjuRo2ys5swjIxVXuisW2PQwMxKViZms7i++
         EjG1w3h02eItftLHZ1pAn9TQpsm2Y4a0HdP1iC7SLMee9a6+/gfS+DUX+dckS4S5SKps
         kdH/N3y473XpJKlf9qiBgSjS4aU1d2w6Ve+iAzI+1Kpp8SOcS4od5gKL/Hs6hUyjxUuN
         S/Eup8qis+lvu9/7QZ+xDLExZ9/Rdwdq07xxI6kLWDh45LkNSAnQF27oNjpe7DzSKLxd
         fwUf7EcQr3zwYFX8qPv0zSDz3qXtGQXEXSOVzSrKlBzAYTLH4o0heMatkmjzQ/8orDuC
         obrQ==
X-Gm-Message-State: AOJu0Yy3FzygXv1ZMAT+MeAvcsBm1O6IVxfeRQq1ItK4ObRGO8MRkTNg
	eiWYUCgQheKJ169UxoJ1/Tkn5U6YSvOXCPCVYNBh2KSfI1r0FdPo/Jq44H9C
X-Google-Smtp-Source: AGHT+IEZdgoqQgw5mMy+3hdxD6T2DglIbOnWsB5LsmTM3GXT9sYhkigBVi2hB3VamA/DDk3fZABEcQ==
X-Received: by 2002:a17:902:c411:b0:1f7:26f:9185 with SMTP id d9443c01a7336-1fc3d925215mr22278405ad.10.1721147094153;
        Tue, 16 Jul 2024 09:24:54 -0700 (PDT)
Received: from zlke.localdomain ([14.145.6.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc271c1sm60356505ad.125.2024.07.16.09.24.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2024 09:24:53 -0700 (PDT)
From: Li Zhang <zhanglikernel@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V2] btrfs: print warning message if bdev_file_open_by_path function fails during mount.
Date: Wed, 17 Jul 2024 00:24:41 +0800
Message-Id: <1721147081-4813-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

[ENHANCEMENT]
When mounting a btrfs filesystem, the filesystem opens the
block device, and if this fails, there is no message about
it. Print a message about it to help debugging.

[IMPLEMENTATION]
Print warning message if bdev_file_open_by_path fails.

[TEST]
I have a btrfs filesystem on three block devices,
one of which is write-protected, so regular mounts fail,
but there is no message in dmesg.

/dev/vdb normal
/dev/vdc write protected
/dev/vdd normal

Before patch:
$ sudo mount /dev/vdb /mnt/
mount: mount(2) failed: no such file or directory
$ sudo dmesg # Show only messages about missing block devices
....
[ 352.947196] BTRFS error (device vdb): devid 2 uuid 4ee2c625-a3b2-4fe0-b411-756b23e08533 missing
....

After patch:
$ sudo mount /dev/vdb /mnt/
mount: mount(2) failed: no such file or directory
$ sudo dmesg # Show bdev_file_open_by_path failed.
....
[ 352.944328] BTRFS error: faled to open device for path /dev/vdc with flags 0x3: -13
[ 352.947196] BTRFS error (device vdb): missing devid 2 uuid 4ee2c625-a3b2-4fe0-b411-756b23e08533
....

V1:
  Use printk to print messages

V2:
  Use btrfs_err to print messages and format output

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c39145e..179419f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -476,6 +476,7 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
+		btrfs_err(NULL, "faled to open device for path %s with flags 0x%x: %d", device_path, flags, ret);
 		goto error;
 	}
 	bdev = file_bdev(*bdev_file);
-- 
1.8.3.1


