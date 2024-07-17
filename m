Return-Path: <linux-btrfs+bounces-6526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06F9340E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 18:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A765284547
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DD21822D6;
	Wed, 17 Jul 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb3evHh0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0393A1E529
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235548; cv=none; b=HPAC010EFDYcZmER/d4nUGefWkUKy2+PghyhR4k5c2+5KenTSdPICfd7rhpQvp5HT5FPk80KR9EhP3V0cPD9DAtTFx+dc2Mi4/VkFQpY6IMGmjP8HmjkW6rqxDsqWXTqZbYscw73HrvFeHOmPtCNne6n2jk7vtY/k/xO0unqO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235548; c=relaxed/simple;
	bh=kNO/PRokB7X1eSdfJhF+DhwZE7FmhFDdsJIrFudpB+s=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DMx6Tn2Nh0rtl0D5/P/6b8J17Rme3dW9uIacH4CYghhYf1jewV1oUR/OD2wf9+n7lNx4w7GLqFsXojcls0plkdXNK/pDYqN7s7fDEGS121S/ye6zd8N3gavp2TlZcVPHoRPnaAVCqqMkyB6vBdM3MvUrnsOuCZk+atNmxblcFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb3evHh0; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d91e390601so302752b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2024 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721235546; x=1721840346; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNxhPxu/Mr2yMLOUb3a4Whm5eHrv71ldjsf7p9VXo2Q=;
        b=Jb3evHh0kf6oZOgPJf4ugGLHRQIO/KEj+j+bL6kxeQZ+wxdpGXGdWW8ky2y1f3P1WN
         e83Vyk068wOOiN3xw0PjtO3idHnJ3rmEgZAaschBiFg3RvoK2gBXxtY2aTteB8dRyhCn
         q7zN4ijDwqV4wFf2HxescgXo6lh2O4f2Bv7aSa6NHkX/hVNFUfznPWHNz3B42dowpWng
         +pieoKBQqkKv4quR/mgpissJAk94H5RRw5J9qiTkxLpRSvoFc3uQhYGMx22clHyMQlmB
         VuroWzy99We7DcbBHpjZzUfPER37e9vbGk2g+yomVho+pCAVcFo4qxNhd1QvVjveeL8P
         GiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235546; x=1721840346;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BNxhPxu/Mr2yMLOUb3a4Whm5eHrv71ldjsf7p9VXo2Q=;
        b=XFtd2n/SyJDF6xSkJtpQbLPzJ4g9xbur1az/gdXddvE0KZxBKKYnUsOQ1kQ0WyspvE
         kNvl46MPVbYiThNuofFiCv0P8uA1ucZYdnjoOwv9eBrwS7GwAwQE0VXPoB9ynPvR7VOl
         rO9lvIs75qWiy8yi+Rrku3FMuZmUkH1WBTe89UdvauZWLNG20eKR0pkW9TLfU8eoRdRv
         RFO82CxUVInm1FfaZZJ2jxnZ4zsPp4K3xSDAmtSjuTUj93v6tYUV3Hv+MzoegiVDmr+w
         CM5PgtsVs9oM0ulgxDDbD4jtDqaIXIp7Dv8D6uq5CqSXz2hPKdOGYJ3irlgvoLyUo7xp
         x16A==
X-Gm-Message-State: AOJu0YwgY1XAWh5eMmbTh8sjKPw0Z6cXomRpbXZQoX01c5VSAuni3O3s
	lx4j4Rg1T9v9wujW5hDnabLcJJSg8TizOrhtNsu8zdJ1tRXJr/cSPCo/ihEquuaEHA==
X-Google-Smtp-Source: AGHT+IFNPj3HKX2RfdaoXfl6Bf3JmJQXftZ7QgKmimbuSRzXCNhmq9WiOQDlE4jfSwVRVcfo0W8Pyw==
X-Received: by 2002:a05:6870:5253:b0:25e:4365:c5d6 with SMTP id 586e51a60fabf-260d919adf5mr1736619fac.20.1721235545941;
        Wed, 17 Jul 2024 09:59:05 -0700 (PDT)
Received: from zlke.localdomain ([14.145.46.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ec7c5b9sm8421252b3a.120.2024.07.17.09.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2024 09:59:05 -0700 (PDT)
From: Li Zhang <zhanglikernel@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Li Zhang <zhanglikernel@gmail.com>
Subject: [PATCH V3] btrfs: print error message if bdev_file_open_by_path function fails during mount.
Date: Thu, 18 Jul 2024 00:58:54 +0800
Message-Id: <1721235534-2755-1-git-send-email-zhanglikernel@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

[ENHANCEMENT]
When mounting a btrfs filesystem, the filesystem opens the
block device, and if this fails, there is no message about
it. print a message about it to help debugging.

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
[ 352.944328] BTRFS error: failed to open device for path /dev/vdc with flags 0x3: -13
[ 352.947196] BTRFS error (device vdb): missing devid 2 uuid 4ee2c625-a3b2-4fe0-b411-756b23e08533
....

Signed-off-by: Li Zhang <zhanglikernel@gmail.com>
---

V1:
  Use printk to print messages

V2:
  Use btrfs_err to print messages and format output


V3:
  Fix typo
  Format description


 fs/btrfs/volumes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c39145e..315d35a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -476,6 +476,7 @@ static noinline struct btrfs_fs_devices *find_fsid(
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
+		btrfs_err(NULL, "failed to open device for path %s with flags 0x%x: %d", device_path, flags, ret);
 		goto error;
 	}
 	bdev = file_bdev(*bdev_file);
-- 
1.8.3.1


