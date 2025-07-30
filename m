Return-Path: <linux-btrfs+bounces-15770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941FB16902
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 00:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0A172737
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4654022A804;
	Wed, 30 Jul 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIEgPr+6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BF224B04
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914395; cv=none; b=Qg6W8kw6w+CnrSuVInZsr7ADOIFuh5jNwbuWbQIUekl70FIXNpUuDxyk/0cOl1UKD5+FaBT9tZy9h/se66+g4F3Lmqw4KosCwIU5HC5JeVUipTrTloDEr6np1fcQtB5sCRYdmcVQchzfUykowg4zN0b4pkYeS5f/nhj/ohiJFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914395; c=relaxed/simple;
	bh=0xfPpHBLXifIjDp46HVDb8EDO7xy0WY+3ETbPy4VaZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ra/o7pjhIzcg+w1KtoQD0BXbGox2yTs5UhOyf9ZxJRD4+YZvZG/B/xC1UA3jLzOw08ZR1VFjrA7wy2vCJe1Kr3zb1sq0ty2bvBEUd6OJW5Uf9bnqJoWSwY5pQe7oJUcOZ6zTbFd2K45gq1R7OsoWQR2Ld/jC3N4Q/xtb/CnLZ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIEgPr+6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b786421e36so155500f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 15:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753914392; x=1754519192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq7SvCyN3FUBkP5CA9WPQXNbvvMLHYp7hQ33Eblqja8=;
        b=kIEgPr+60NDElWvg5Yuh12YSVQOExnI8gORf7LZRSCALyF36UjVtihQkNh2IR41ST9
         QKtoxTyo4j8qDMBB+5c4vq1CFXWHon/8PgEVeOXZtGep4SmhHEy1dXxkFEg7jaP845J4
         ScCLxg+54BerQRl0IZw4vE4jzS9G7xC5UXEaTG+OUjAS1D8riIE6v/95jiNitbMPLMtU
         cJbwXGuGKGtIlN/LcYC7iJmWs3pFYaRWAmdhJccWWAvWhlElX6dG7UfQd7UjjkoQexkR
         admnrOIG8LKOwJHfCDGU1BlMdeNWuYy/5XWmF8GT4kccFWTqATNJupvSJyq03FYyDT7/
         4YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914392; x=1754519192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq7SvCyN3FUBkP5CA9WPQXNbvvMLHYp7hQ33Eblqja8=;
        b=EdaVLlQZAU1ZXNBCDPur2TMHesCFSQmzRoMBTiUrjnZ+RH8ZziyshmHsG9gncEuabV
         HiQyVAuDQNYfoani9TKcvTKIG/aACx4Fp81Mlx0G8V539zmlfaqYG6W74SJznTcTdGWo
         BKrdItHkVPLrg15hsWRYuAlSp8Vjie+4gxb1hfx7CzIFeeXkTUoxjc065g485+JAUjBB
         R466CK3Drh30BxfWyXWvPG8JdBS7Y0uc9y/HDU0H87t0wz05Mqfm6JEpLKey/5haJD9t
         Su85zy/pqmWRkeO1JnTeJXV/fezgXAbpVSbX5Eyr0xGUcMQ6T5rDsv8CN4+oB3Z+FvpK
         Ck8w==
X-Gm-Message-State: AOJu0YxBYbWywhlRI5dIYEP4JDHnKeC9TjCY4Ox4SY1Zfy+U8eiIdXJJ
	34am5HYBRaCgsXQQQJgotJJ5CcJS86POBJdQpmlvaztQibP6wEe4q+O8ZDE9oQao
X-Gm-Gg: ASbGncvsgD+T4VGpWnko5jeRGh0dbdddr6GcF8S8DB+/+99r3fxsLtNZjZIuOonRh6y
	QyoWJB2GOUGicS1BpSzEXkW/8MbPyiRXe41ew8HXyTxa0i29TWPFM84ttLvS60ReUjB29kR7ZWd
	LsxlWz8z2+NExLAn9OGrukekGIlC5DCxSm/8cF3FU6M4VqEtcK/G4GMEdaTbK5OUOhOgTK1WSnO
	rMKspeUeeS9UwthgjQ7ZPNzpu/90fr4G8OV4ouk0HaN8e0JIEmIxwbSrp9BUFflkDuRJ2cpGFgM
	1+li9H/peGvr8mhM2Heqbrhvv3zgOI3p22mZ6M9BfQQ6FCEKR3P4/Lx2y41O8ohAkmMKCJA0kJy
	UbLOfuVkmKaCWSo3doNk=
X-Google-Smtp-Source: AGHT+IH2PTvgEe/CCEJC4DeZ0dbRIcqSRg23KTc26Dm4Y+xs5LeC8q0FYWlBZH2s84vbwKaiW4VjWw==
X-Received: by 2002:adf:a1d6:0:b0:3b7:9589:1fe6 with SMTP id ffacd0b85a97d-3b79589211fmr2310454f8f.38.1753914392174;
        Wed, 30 Jul 2025 15:26:32 -0700 (PDT)
Received: from archlinux ([84.232.135.153])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm276363f8f.42.2025.07.30.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:26:31 -0700 (PDT)
From: Zoltan Racz <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Zoltan Racz <racz.zoli@gmail.com>
Subject: [PATCH] btrfs-progs: Fixing invalid device size output when "btrfs device usage /" is called as normal user
Date: Thu, 31 Jul 2025 01:26:29 +0300
Message-ID: <20250730222629.25902-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes bug #979 - "wrong and misleading" device usage output as normal user

When "btrfs device usage /" is being called as a normal user,
the function device_get_partition_size in device-utils.c calls
device_get_partition_size_sysfs() as a fallback, which reads
the size of the partition from "/sys/class/block/[partition]/size". 

The problem here is that the size read is not actually the size of
the partition but rather a number of how many 512B (or whatever the
devices sector size is) sectors the partition contains.

Ex: if read value is 104857600 the size is not 100MB but 104857600 *
512B = 50GB

This patch adds a function named get_partition_sector_size_sysfs which
based on the partition name returns the sector size of the device, and
replaces "return size" with "return size * sector_size" in
device_get_partition_size_sysfs.


---
 common/device-utils.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d7955..68aaa538 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -342,6 +342,42 @@ u64 device_get_partition_size_fd(int fd)
 	return result;
 }
 
+static u64 get_partition_sector_size_sysfs(const char *name)
+{
+	int ret = 0;
+	char real_path[PATH_MAX] = {};
+	char link_path[PATH_MAX] = {};
+	char *dev_name = NULL;
+	int sysfd;
+	char sysfs[PATH_MAX] = {};
+	char sizebuf[128];
+
+	snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
+
+	if (!realpath(link_path, real_path)) 
+		return 0;
+
+	dev_name = basename(real_path);
+
+	if (!dev_name)
+		return 0;
+
+	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
+	
+	sysfd = open(sysfs, O_RDONLY);
+	if (sysfd < 0)
+		return 0;
+
+	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
+	close(sysfd);
+
+	if (ret < 0) 
+		return 0;
+
+	return atoi(sizebuf);
+}
+
+
 static u64 device_get_partition_size_sysfs(const char *dev)
 {
 	int ret;
@@ -351,6 +387,7 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 	const char *name = NULL;
 	int sysfd;
 	unsigned long long size = 0;
+	unsigned long long sector_size = 0;
 
 	name = realpath(dev, path);
 	if (!name)
@@ -375,7 +412,10 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 		return 0;
 	}
 	close(sysfd);
-	return size;
+
+	sector_size = get_partition_sector_size_sysfs(name);
+
+	return size * sector_size;
 }
 
 u64 device_get_partition_size(const char *dev)
-- 
2.50.1


