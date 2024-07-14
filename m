Return-Path: <linux-btrfs+bounces-6440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9F1930A04
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 15:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 524861C20FF6
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2024 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08821770EC;
	Sun, 14 Jul 2024 13:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mslor6Ix"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165F20EB
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720962394; cv=none; b=mVUN8Oky4QCJOL7vK4WmYgpbaKdcSyr4boFL1FwMFZsUC3RwNrnCtd7SKp+nsJGhpA2oVA+G7KSikNxt21XDAupkilz40yNwrD+NhVQbDVmnw/sbKc0WSS3YGlR7CS/zebTU5DfVZi3L/ovg4BweKnQIp2Ro0yRh/WgPwcxe9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720962394; c=relaxed/simple;
	bh=nNdKRyXsrY4QQsHjlYaH+ulo1xpotVfgy+VMaRZpyKo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UH1H0yhq5H2XkSbET48Q1DODctf0ouQkonWS46PLtNGzW24xgAQwC3htQugBUB87lEqT+ytV4F4QQLpBE2Z6cR8zd7sl5Ji1koYOhwA3ikTmXNIEe2YSUcQ/S6esTpMOxrzvJ6m+xC6QwMuo7dmNivLAlwzl01xC0UEp3Shaw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mslor6Ix; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c9785517c0so2302156a91.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2024 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720962392; x=1721567192; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujfyBAHaV/1RdTV89iqpQFniPZ7Dl0WXVEcEV0xXj4U=;
        b=mslor6IxQtL92Fa9SQGc4tZBu/3SRFrEbg++ZmDXMXROkPffozirHGusauTA9v9pzw
         viKw3mmvkRl4QIxAg66HXELTzIsZRX72+Kq9iqN2BMC/BHsfPtW3TghKaFR4Q2HBkuaP
         q4Ut2um7FSl3QktK1QINzvjyypvRTb4JChSVMCwTr1QgvEBf30hpmqA9oLz651SHoUGY
         OxenAIv2Wo20nSg9C7WDH89em3Voo8rSNxzePufrWitaRWT4uHERCAPuNJHj39auyTN8
         gMVP92qsajGqVfAtj4zsNCgoZRTQOApxhpxM2rqoR6HcC8RCvf3lUrAnWuQKb9uHfMFb
         XYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720962392; x=1721567192;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujfyBAHaV/1RdTV89iqpQFniPZ7Dl0WXVEcEV0xXj4U=;
        b=P4dHlo0PGlOsEsu1RkgIkXX0x6SwmEjlIAen3Emx9ZnZ1rwbAJbMD4ojnvLH8nna8J
         9M7yHTOFHesO2YxBCzynZdSE9Z0ZzGS7nrXFGnfOg+g3sBKgrsGBcgQNW8Z7/k+qm8q6
         n8NWgmulyTAWSGU/VugMSrGcrceOu9PrsjZ+PbeXtvnNVciZj88A7dqiDvjKSeh7/wBg
         DLgKUz9XH5+yvmcEcKvZVeksh8xJykXZNyHF/I6MJ/K5muASNatMUZ4+bN7Nw+06J+xK
         g+rsEoRnHgUFQWXyy+YeLzbdoE5dkKFhC5cZGbZJFWpoEqVKCHRoyk+sYcBnvlujIomg
         di0Q==
X-Gm-Message-State: AOJu0Yz0lW4LgPf/KduDZ49mJTw9uyAXRT6JadUcZqG3Srhe8Jg3FWNf
	7qAuZBheNvwebc3KovLuc9LbLjttjPgbvLxl0Bs2uYIMfwBgfGZ0+5r1jcd+
X-Google-Smtp-Source: AGHT+IGSo7JnPpL1PLV816CLa9qnbS+OOWShBxa9SNWONOHl1UmHks+6ZHY5Zjm24gvGJ48ttADiDg==
X-Received: by 2002:a05:6a20:4322:b0:1c2:8949:5bc5 with SMTP id adf61e73a8af0-1c298205fa9mr18590997637.11.1720962391911;
        Sun, 14 Jul 2024 06:06:31 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([14.145.8.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bbad94bsm23369285ad.90.2024.07.14.06.06.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:06:31 -0700 (PDT)
From: Li Zhang <zhanglikernel@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH]: btrfs: print warning message if bdev_file_open_by_path function fails during mount
Date: Sun, 14 Jul 2024 21:05:26 +0800
Message-Id: <1720962326-19300-1-git-send-email-zhanglikernel@gmail.com>
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
[ 352.944328] bdev_file_open_by_path failed device_path:/dev/vdc ret::-13
[ 352.947196] BTRFS error (device vdb): missing devid 2 uuid 4ee2c625-a3b2-4fe0-b411-756b23e08533
....

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---
 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c39145e..0713b44 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -476,6 +476,7 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
+		printk(KERN_WARNING "bdev_file_open_by_path failed device_path:%s ret::%d\n", device_path, ret);
 		goto error;
 	}
 	bdev = file_bdev(*bdev_file);
-- 
1.8.3.1


