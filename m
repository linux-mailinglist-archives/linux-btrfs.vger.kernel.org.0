Return-Path: <linux-btrfs+bounces-15789-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0071B180A0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 13:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1950E1646BE
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Aug 2025 11:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBF121CC51;
	Fri,  1 Aug 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN0uE0vr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC8E37160
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Aug 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046205; cv=none; b=ikKA28hJfrE5nMqWQW4a7u4XiCzHZIYYxKsZdBOH4NAUrzjw3qgU2BFXTzBz3gFoM2TOJqFUvDMOPc+F9o6v+cu0ynT//nSqCo02OOAdEVywp+BTIyOENHRoX5RbwXFqxC1z99iGnAqrCx3q3rJcsWRfLSiZkVYXkSu3fnL9aEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046205; c=relaxed/simple;
	bh=BsGDXgX3GPIqPdBHr13pAhnJoNlJVadoJaaZ1xvIr0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lE8pjjfprqGsyuM33lTDg7kfFeU3e0HlbeDvRB3cEdyOsl0360hgB5WQBKFZD4K0ZU6okv8JxTT3G7K2wbtF8flJZAYnh72kv/4yTQrEiVepMYUk0ET4sgzAge4VKtw0ynnPx+emTvDsRaH9usuiIC7ydcB4djCiEIvbb3LfMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN0uE0vr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso1284217f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Aug 2025 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754046202; x=1754651002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=37SMEjAunUE38XwnF4R824rpXUPEb+Dg7QMsO30tFJ8=;
        b=aN0uE0vru4Fwxvl/khqTLZQPqyRqZPudzVK59NGij2lTAngBpCGCEurU92+PrEM1i0
         RwixWDDU7jkzzBd3IpHNTMJt3SwhptrHSvXerm7TrMnqtUTP5xzuH+vB2Zd1jfK0bAPx
         BWj1XLLwEAwAXUbdwu2yhBj/MXEoi7V1obOKe97KVnueJgkKxpD05tEFhZPW9/ATtuT1
         IF4/Y4wTVIBsCv7c2+yad4rTHhQliOZsJANWh3EAVji+tZHXuMchyGhtCr2FFQeEISa/
         F2LsbnDHPVUL5xkILIEZMRTMRNqCcQDPJKx0bYUkyRHmgmJ2bKXUuHxuFMTt/MhNUDoB
         U/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046202; x=1754651002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=37SMEjAunUE38XwnF4R824rpXUPEb+Dg7QMsO30tFJ8=;
        b=bwTjGD6EoKtWdAa77ImQEdkmUwmTPzEvpUtQVmoLezun62AjH/jsyiNQ/+V7Iy07bz
         CALksoTZyPvTIrVTETU59Ueh1303xHN1sPToMcCxWoJtLBqysVHILHv12iAjgN3DcqyG
         wqDgqBhTIEdC2RQhjD1n1mP/fwniq0BPhl0Hlwy7QuJobQ3eyXBOhj7/OGtqSFwex4zN
         U4A21m/daBwG6w4pmmrQufK1naTXMppNmv+CKfb2ohMQ6Cam7XGwU7fXd4ex4v+m2R2c
         VJaIfgAZB+gDekKJ/SlaLx4IPmd8hThuHHtX9c2VpB/7hRPABCYTtgbUYWuyB2PCr/M3
         LCIw==
X-Gm-Message-State: AOJu0Ywy1S5lpRdbBSIHLyLrarke1LmOo0zVCHpjIPpuvMkepo2S9u/0
	7DrTmpiPdq8ZI4CmiLFsFmy0zpodyZqgBs8agdb+JTqUI74XS/eXaeOXfqz0unR7
X-Gm-Gg: ASbGncu9lV9/0mUAv6HwRN2hIhBeGTT7SDDwJNg1i/JVDsFh7uAP6AXiyHqk8QSrZCg
	t26Lnhuk0QJ4//JUBEHTmladnRtPAgo05Nmh17t+ANDCTtBg7wPtn7foGzjZboh+5eMzfnkCeAI
	dAXNlzjeK3C7w2TczLzxSuzuOA8S4y6F7iUD0PfJP5CIdlYeTa2nMr6oq/sKhX2SaFK4saL5fYo
	vF0mUg6BE8jVsjVLmL24tTf2gyiAe2zoHqTJ2XuwRnEIXxYpserUn5Jj2rpe5zdk9xxJzMeeUPW
	GXso0WZZZQhAEE7q6KG7KPbm25tgiFncy/midka/mMbeNpwmweHGLTcXUAbBJzrydWN6gLLaVzW
	QS9DBo7Hh8Xy4DE6HP+7eUl/ubrG4Kps=
X-Google-Smtp-Source: AGHT+IFjvMSz4VMCg++KFtP+sCdYgKjCLpIw24I4LZB5Jyx37ic8IHv+sdP53Tb4b1TbbyD4qxAvjg==
X-Received: by 2002:a05:6000:2887:b0:3b6:1630:9204 with SMTP id ffacd0b85a97d-3b794fb71bcmr7522507f8f.19.1754046201516;
        Fri, 01 Aug 2025 04:03:21 -0700 (PDT)
Received: from rngs-workstation.. ([84.232.135.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abedesm5622685f8f.3.2025.08.01.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:03:21 -0700 (PDT)
From: Zoltan Racz <racz.zoli@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Zoltan Racz <racz.zoli@gmail.com>
Subject: [PATCH] btrfs-progs: Fix get_partition_sector_size_sysfs() to handle loopback and device mapper devices
Date: Fri,  1 Aug 2025 14:03:18 +0300
Message-ID: <20250801110318.37249-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e39ed66 added get_partition_sector_size_sysfs() used by "btrfs device usage"
which returns the sector size of a partition (or its parent). After more testing 
it turned out it couldn`t handle loopback or mapper devices. This patch adds a fix
for them.

Signed-off-by: Zoltan Racz <racz.zoli@gmail.com>
---
 common/device-utils.c | 48 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index dd781bc5..a75194bf 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -353,26 +353,44 @@ static ssize_t get_partition_sector_size_sysfs(const char *name)
 	char sysfs[PATH_MAX] = {};
 	char sizebuf[128];
 
-	snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
+	/*
+	 * First we look for hw_sector_size directly directly under 
+	 * /sys/class/block/[partition_name]/queue. In case of loopback and
+	 * device mapper devices there is no parent device (like /dev/sda1 -> /dev/sda), 
+	 * and the partition`s sysfs folder itself contains informations regarding 
+	 * the sector size
+	 */
+	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", name);
+	sysfd = open(sysfs, O_RDONLY);
 
-	if (!realpath(link_path, real_path)) {
-		error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
-		return -1;
-	}
+	if (sysfd < 0) {
+		/*
+		 * If we couldn`t find it, it means our partition is created on a real 
+		 * device and we need to find its parent
+		 */
+		snprintf(link_path, PATH_MAX, "/sys/class/block/%s/..", name);
 
-	dev_name = basename(real_path);
+		if (!realpath(link_path, real_path)) {
+			error("Failed to resolve realpath of %s: %s\n", link_path, strerror(errno));
+			return -1;
+		}
 
-	if (!dev_name) {
-		error("Failed to determine basename for path %s\n", real_path);
-		return -1;
-	}
+		dev_name = basename(real_path);
 
-	snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
+		if (!dev_name) {
+			error("Failed to determine basename for path %s\n", real_path);
+			return -1;
+		}
 
-	sysfd = open(sysfs, O_RDONLY);
-	if (sysfd < 0) {
-		error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
-		return -1;
+		memset(sysfs, 0, PATH_MAX);
+		snprintf(sysfs, PATH_MAX, "/sys/class/block/%s/queue/hw_sector_size", dev_name);
+
+		sysfd = open(sysfs, O_RDONLY);
+
+		if (sysfd < 0) {
+			error("Error opening %s to determine dev sector size: %s\n", real_path, strerror(errno));
+			return -1;
+		}
 	}
 
 	ret = sysfs_read_file(sysfd, sizebuf, sizeof(sizebuf));
-- 
2.48.1


