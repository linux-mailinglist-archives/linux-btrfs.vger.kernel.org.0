Return-Path: <linux-btrfs+bounces-15782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE91CB1718D
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 14:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C3EA823FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC6C2BEC2C;
	Thu, 31 Jul 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Gdmgy6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA8C1E50E
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966394; cv=none; b=Zjohi4s11ejOILyTi7sZstDjRlbmFppsUf17jpsRAgz2aDeJfreZrIlXKBYt4zR2oAbfHfXjU4E3mcoqU2/rOTtTALHy+OVKgXOlPhFygbiyuMc8mC44FlWGm2IsvDo96Qtab9cYZT3fxFe2tC/EXEF2DS+prXs8jlG+pZyKdSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966394; c=relaxed/simple;
	bh=3Y2E15z9RShYVjNmxpqmIbhE98r2sikFzdihullaC40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnETtYTF9aPIetgHVounCTk8jF0y50AAGjhFsqM7AuW1ory8FxgASglVW0sOnRl5xVm9sREDqEDb5qaXY6JVopPzP+BaThg8hGtphvTXJ6xZveYXiO+0Ikm8v3Yc44G+TDLRXxkjlhJ+dbNGwwXpzdB/VtI42q7crZts762r9OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/Gdmgy6; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b783ea5014so533366f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753966391; x=1754571191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ATAUrY7QTxBiZHVZ1rqMjHqc/0WOp/K6BVrpGr8t0OM=;
        b=D/Gdmgy6OU3eieZbQeTmlYbVfWwbxMB2+Ww6CQCsF3FjfnwQCkZpqFHFuIBlOIh9+e
         wKoi8fTNyChAx7rKYAvzbcwpKvPgid6GVqpqfqNieFLJIML9eKfHc6thi6xUavSaA+ro
         U6Cjmt/PUiPHDNi2flW3pJzf+fIZrDVv/LyFj8C67RI55pukIj2pc8mnxASvOiJEpK83
         V5sNDf/NodcVYViJ+V6ey7hEoGdeQACIw5M8ubx4TqImliiVl2zzruJEHnZrJz+6joHb
         UGGDZt7WYpWVYyaaa48Wz6CCPgD+gNT7kdHu52flHFTAOV0z4r3GN5g4LOF09TS0563+
         F9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966391; x=1754571191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATAUrY7QTxBiZHVZ1rqMjHqc/0WOp/K6BVrpGr8t0OM=;
        b=NLq6o2orLYKgMaxhuyWxU6iZJYMjASd54PesyjrCU5H+banXFb81Xmy2OKakYaS5OE
         C20YuOFdEaeLnV3FEHFkGxDBC6DWiFa3vwqoiGrMQC5+PI0lQoKcFKFp1KSyWHyPvkrH
         8LHaLD7nFWaeL5vAg3GIG4l1DgQXGgiTt9Mi+jHWpVunNDDR1TZQKl4XnZHD6y6jAF5w
         6VE6IVe3i9wisZxUlNElKEVGyuyyEbAD4LWw5LEhlp6m1DHzhjN+YpyyKdIC8zJK37MQ
         mzZD8AsuD/OEmcdOpUGjJOSMRV58hIdfWnHV1iuyZuLyWs+6j45aGtf/OPp2NfwmvIiy
         rTiw==
X-Gm-Message-State: AOJu0Ywn3MOJ+IjpFV+i10B0bNjWP5b/BRu63RbbkvIK5HEIcQNEPDet
	mZRvdOKPv9kKIc/P9KIU9j3RTozWGcliq0fjmPLJkyhp3V6MTsVemczeWLlb+VcN
X-Gm-Gg: ASbGncuKtkW6VmcGWlVdrsBKKgDScO94m/+8x3n/SHZgMasTZrzYp9ip4JvYcSlWfWz
	ifyh4rW4Mp8gD5xTqeW0srChKLCkvaZPcAe+Bb2w412wXUVl24FaapWVcjwdhc06p4itAvIgiW4
	3HYSEcNEZOm8zgBJ5SIyyiP+kcpvc3Nez0vLultEIzid8FQr1cnVYin8Br78VNazHsRZ4E414sv
	dks3FGUDOXaO7TNFT5rY2o1danJZ5PYxDM8VN71x0fMQpAiDz9JzuXpLV9d49ghfBP+DwsDf+O5
	LBbt2AOo2DGsWhI0f2lVos/DwQqtnv9IUYkagYzNQzsF0qeqFQY0pjIJcEUjp6+IjFcZjibhzTZ
	CjAiRIU1mBRKO351s1Ek=
X-Google-Smtp-Source: AGHT+IFCWj2VyOjSDwcGYsF62qQDC6w4ztZvNws1OOfEuNQd/dJzHfdgFlwuvaX8yHfs2k+XCtKZwA==
X-Received: by 2002:a05:6000:24c2:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b794fd5d30mr5550002f8f.20.1753966391472;
        Thu, 31 Jul 2025 05:53:11 -0700 (PDT)
Received: from archlinux ([84.232.135.153])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95desm2273678f8f.20.2025.07.31.05.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:53:11 -0700 (PDT)
From: Zoltan Racz <racz.zoli@gmail.com>
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	Zoltan Racz <racz.zoli@gmail.com>
Subject: [PATCH v2] btrfs-progs: Fixing invalid device size output when "btrfs device usage /" called as normal user
Date: Thu, 31 Jul 2025 15:53:07 +0300
Message-ID: <20250731125307.11939-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue: #979

Changes since v1:
 - Added Issue: #979 tag instead of bug description
 - Added error handling to get_partition_sector_size_sysfs()
 - Changed return value of get_partition_sector_size_sysfs() to negative
   on failure

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
 common/device-utils.c | 53 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d7955..9b02a0e8 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -342,6 +342,50 @@ u64 device_get_partition_size_fd(int fd)
 	return result;
 }
 
+static ssize_t get_partition_sector_size_sysfs(const char *name)
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
+	if (!realpath(link_path, real_path)) {
+		error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
+		return -1;
+	}
+
+	dev_name = basename(real_path);
+
+	if (!dev_name) {
+		error("Failed to determine basename for path %s\n", real_path);
+		return -1;
+	}
+
+	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
+	
+	sysfd = open(sysfs, O_RDONLY);
+	if (sysfd < 0) {
+		error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
+		return -1;
+	}
+
+	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
+	close(sysfd);
+
+	if (ret < 0) {
+		error("Error reading hw_sector_size from sysfs for device %s!\n", dev_name);
+		return -1;
+	}
+
+	return atoi(sizebuf);
+}
+
+
 static u64 device_get_partition_size_sysfs(const char *dev)
 {
 	int ret;
@@ -351,6 +395,7 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 	const char *name = NULL;
 	int sysfd;
 	unsigned long long size = 0;
+	ssize_t sector_size = 0;
 
 	name = realpath(dev, path);
 	if (!name)
@@ -375,7 +420,13 @@ static u64 device_get_partition_size_sysfs(const char *dev)
 		return 0;
 	}
 	close(sysfd);
-	return size;
+
+	sector_size = get_partition_sector_size_sysfs(name);
+
+	if (sector_size < 0) 
+		return 0;
+
+	return size * sector_size;
 }
 
 u64 device_get_partition_size(const char *dev)
-- 
2.50.1


