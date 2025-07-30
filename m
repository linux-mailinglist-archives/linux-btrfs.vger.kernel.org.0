Return-Path: <linux-btrfs+bounces-15769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F86B168FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A95A41F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4850F2264AB;
	Wed, 30 Jul 2025 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrAewYA2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE920297C
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914325; cv=none; b=aa9BU63i622COUJmKQASNSSd2ya0aOjxh4mDLKmPZSHD5SzkE0vX9NI4zPbdDmppYLWNazXBNJoxhDIWQB4DIiyWLEulUxdkQq67V+574ilNxenvKRXJjBYqVSJqQoF/IqgWPFvCyYgjyO+UtNWmbeV77BWfkX6nuFGQVkofE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914325; c=relaxed/simple;
	bh=0xfPpHBLXifIjDp46HVDb8EDO7xy0WY+3ETbPy4VaZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNNOwBKAI9p54h4wxzC0CfO4lD7hBn1poLBVrspJ8LR7KNGd7yMR9JIrtr1GQ64myCWZepVWvxFCR1tdwB1ePzBfDxmPKtd/EEthDwExA1sOMptaYNumRK8e/Gm+z1O6PANJvdLBWTC66n83BfErITY3K6w/Hf5UyNtAnE/Qga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrAewYA2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45555e3317aso1170875e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 15:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753914322; x=1754519122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq7SvCyN3FUBkP5CA9WPQXNbvvMLHYp7hQ33Eblqja8=;
        b=FrAewYA2KHJOSyVYF1aUfVw+BRNqxo/NltzzmWmeYK+KQaSxocykOPqu9mdc5OhlCI
         NMU1A3lwfZlEoSL7sOKCc4U+fa5ukwW0Z4sONwLcAY45KMbdHVRlGQVpASC7B4hejEXL
         GpDdj3wLc8wuBxLyYHomyEws8lDnkUBtDdiY3wO3ucZPQ6YeIx6HoGnutcCSCMhlaX8D
         wPrEnELw8VLnO+ERgC6R3lVxYedsRwkYO2l+lw6Zp36D/TKvCD65nEAIQ5nd+T7y853T
         VNHwJIwZRB4oCOX3nd/w51uUZzbHLcC1pY+qFWAPGze7e3hmdQ/iqM8yIbNHk0vFqZkP
         lgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914322; x=1754519122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq7SvCyN3FUBkP5CA9WPQXNbvvMLHYp7hQ33Eblqja8=;
        b=qhyVvd2CE+bB7giwEDAP9I2xWg0weNh/BFG2w3TncRdR4yV/zvYh9eUlLietfiTXkg
         t3D1l2wB1FDRXCozz6w1xJNkP1NZSHsqtRHX+f5wHgTO3e2YMPdQ6hvT9PJWU9+R4nbO
         6Gsf+it5rKUKH+AqQvbO6IhAl6/2u2GCZVcXQtzWvOAi9SVF2uz5tN+VWa2TloV6WmwV
         B/UID/zFoxW26DgUOGh+rtAAFKNMvinmHKx+WhMGSmarCAVItbhv2Z7vL+vT79KIZCg5
         864ZqsjP3u2AD2zXCb9Q6lXuFw2MzkOJUYuTKGlmp40OLxIw6j4F0qQWBr1tyiwfdfRy
         pP2g==
X-Gm-Message-State: AOJu0Yzx8pv+bMj6899CGGbBimxDbppD5sLXDXwmLVbuO3E6ryt+TIlN
	Oc0xBAvEwKwPgcdxjd9iBNg9ojXtTQNuwFq4iYfd8La5GwCFeatOvdxV
X-Gm-Gg: ASbGncuAXp/QtFDoNZFQ0BBQgCcg74WIlguGQQC/x2ptZkQC+oCFCVgryzFBrq1ljTc
	pFvXCy2NxeDdbmVWC/B2SCvnJyrvNlZ0ubPEnrV4ePoy4FwmYADCHfGS+hRQUO8xD/h6xYHc17c
	FBUaYARQz73rPfr6uw5QpIPt9WK59X2XrNjbFqCiaHVRLYUecSTr1HGcVipJEEWeImaStHhBLBw
	lreNnk9x9fGh6WUfHQMr2NLq1RvIZH9zw/pehYmRHcmqslJdxigsKEdKtFXlbLssirndCrCx8E4
	tPLfaOD9SfXIvwpoUNpsedSWsnPGayCZaAiZD7CjAxO7SdjPVqAln6VUE+rgaXU3pt85iBoUPHw
	xswkhdFiYMp9N6kcvpqo=
X-Google-Smtp-Source: AGHT+IEnLbB77qEkLBn0T54Nr40F91Z0FeSjGgT+aoF3rN+ChQ7dup6my+MjqIrTHF19NyGLoSHaEg==
X-Received: by 2002:a05:600c:45c6:b0:455:f6cd:8703 with SMTP id 5b1f17b1804b1-45892be1c1amr52854205e9.31.1753914321603;
        Wed, 30 Jul 2025 15:25:21 -0700 (PDT)
Received: from archlinux ([84.232.135.153])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm301234f8f.4.2025.07.30.15.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:25:21 -0700 (PDT)
From: Zoltan Racz <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Zoltan Racz <racz.zoli@gmail.com>
Subject: [PATCH] Fixing invalid device size output when "btrfs device usage /" is called as normal user
Date: Thu, 31 Jul 2025 01:25:18 +0300
Message-ID: <20250730222518.25882-1-racz.zoli@gmail.com>
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


