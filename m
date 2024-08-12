Return-Path: <linux-btrfs+bounces-7123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ADB94ED0F
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 14:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB11B22205
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876DF17A5B9;
	Mon, 12 Aug 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QL/WXYFR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93617A5B3
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465902; cv=none; b=j2CEvDPqwEjWeV4hll/M35tvwdtTM2dnNR7wrSG4icNcaTTZmlktNeknQp23S1mYIdztx0O4mnpqw/b+2QDmCNdfmRjsaKU9fNnTxHPaVkdT/mVz2ZKNjSi+x/mDVcsSg/x7UoSDBHUMHLaw+DiICMYVbvzDbHNcbv59hoVmOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465902; c=relaxed/simple;
	bh=U7n4+TH92ZKM3kiqhlmuKED1AMdGb6qLY8i2x/CM0P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=glgw1RR0+ovTbWXUtqm5D/lhtk6YoaZfXtyygACfkfwYphghyawD99ZxxN3iPujkZGuFa+378MNuz2xjc7edootkBT1tM0wC5BZQl2shyKsF4NiduOWdNap6vO68mCemlK0hsb061cWptzyTXj/07JC4R9XCVm3pyyIzEBYuyV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QL/WXYFR; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-264545214efso2248825fac.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 05:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723465900; x=1724070700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gide8feQoTPab5gEPtBcF0Z0CmBUOXsbYbBbx76QVo=;
        b=QL/WXYFRD9LmuCrqTIw7xRfggo4paO9cWe0Sy47hAhcxTt+wR1rDxopg/RLUmsgdbL
         vH0lX3PRjxPSps4N3OLIu/eIUpariTVMinvtxVd5ssahCcR2xMN51dNRdBfv0FU4kfgU
         zjgw5s4urSpl6z2GfrfzKv4LR/fufnemjIka8is5j1v0FvcPjfLm4V0ie9bvcpG649eO
         0h6/p0pQEacprOH8MaI7lhvrm4j3RKqcK9eeRLGgGCSIsFvfdBI6jF8qkK7bObzZV/HO
         1lXcwMy4nxPiCoA2OWOf4J1Hg3/yx+nZveQDxxWnd2lNTsw0or4Ld45uR0VDqLUKFRgz
         7iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723465900; x=1724070700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gide8feQoTPab5gEPtBcF0Z0CmBUOXsbYbBbx76QVo=;
        b=EdlchSkU9Cboslnw7FQPDG5Mae/wIygNh+l+zFXAqOhLkAU8nq3UlQLezG3IjhyK4H
         PDdnt2MYTDMDoOmstoFYCXRtMx9DIMuNM06KEED7zHyUj8iaqv//PoTAUv4tLzYtI1Rc
         KKlTdAt1tc9UaJheyoim32R7ydBm1uoyOi5KCkLXxaGpThHcnKzoN2P4s+H3xdPQb+vV
         pLDkB4gAL4i+PaHhq6184j/2thLoAeq4iZoF3fCtynMufMAKI8pNNJwSUtKvsGEg6vXO
         CPjuWjAOBlpwVlkdQSoVxCHoPPzgFx9HDI0rLeXSiUTsEt7nUJqXWEPAPed26ByuDolj
         Oleg==
X-Gm-Message-State: AOJu0YyksFxb3iQpMDMrMtJYqGH+r0xz2jsEqOUS2CqCa9zvA1t8uIQj
	uvY55C3c2BKSgJ2GXTmGfpxHQb4hembr5ewKHMvtmpBQSm+sojDwEEUqe7xn
X-Google-Smtp-Source: AGHT+IHggFJomiOCwPuj8vVuksxpt+TMzUQqdZ2SqyTo6mY+rvoi7vrVpOeYlZ5nDljV5XXJqUZCew==
X-Received: by 2002:a05:6870:d38d:b0:268:75d3:40dd with SMTP id 586e51a60fabf-26c62f92696mr8410278fac.49.1723465899944;
        Mon, 12 Aug 2024 05:31:39 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbea2327sm4162211a12.79.2024.08.12.05.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:31:39 -0700 (PDT)
From: Sidong Yang <realwakka@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Roman Mamedov <rm@romanrm.net>
Subject: [PATCH v3] btrfs-progs: property: introduce drop_subtree_threshold property
Date: Mon, 12 Aug 2024 12:31:00 +0000
Message-ID: <20240812123103.8460-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces new property drop_subtree_threshold. This property
could be set/get easily by root dir without find sysfs path.

Fixes: https://github.com/kdave/btrfs-progs/issues/795

Issue: #795
Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2: error msg for -ENOENT, fix desc for prop
v3: warn msg and return 0 for -ENOENT, fix style
---
 cmds/property.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index a36b5ab2..42c372dd 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -35,6 +35,7 @@
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/filesystem-utils.h"
+#include "common/sysfs-utils.h"
 #include "cmds/commands.h"
 #include "cmds/props.h"
 
@@ -236,6 +237,49 @@ out:
 
 	return ret;
 }
+static int prop_drop_subtree_threshold(enum prop_object_type type,
+				       const char *object,
+				       const char *name,
+				       const char *value,
+				       bool force)
+{
+	int ret;
+	int fd;
+	int sysfs_fd;
+	char buf[255];
+
+	fd = btrfs_open_path(object, value, false);
+	if (fd < 0)
+		return -errno;
+
+	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold");
+	if (sysfs_fd < 0) {
+		ret = sysfs_fd;
+		if (ret == -ENOENT) {
+			warning("failed to access qgroups/drop_subtree_threshold for %s, quota should be enabled for this property: %m",
+				object);
+			ret = 0;
+		}
+		close(fd);
+		return ret;
+	}
+
+	if (value) {
+		ret = write(sysfs_fd, value, strlen(value));
+	} else {
+		ret = read(sysfs_fd, buf, 255);
+		if (ret > 0) {
+			buf[ret] = 0;
+			pr_verbose(LOG_DEFAULT, "drop_subtree_threshold=%s", buf);
+		}
+	}
+
+	ret = ret < 0 ? -errno : 0;
+
+	close(sysfs_fd);
+	close(fd);
+	return ret;
+}
 
 const struct prop_handler prop_handlers[] = {
 	{
@@ -259,6 +303,13 @@ const struct prop_handler prop_handlers[] = {
 		.types = prop_object_inode,
 		.handler = prop_compression
 	},
+	{
+		.name = "drop_subtree_threshold",
+		.desc = "subtree level threshold to mark qgroup inconsistent during snapshot deletion, can reduce qgroup workload of snapshot deletion",
+		.read_only = 0,
+		.types = prop_object_root,
+		.handler = prop_drop_subtree_threshold
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
 
-- 
2.43.0


