Return-Path: <linux-btrfs+bounces-7083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B153694DB05
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 08:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33251C20DF3
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Aug 2024 06:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F369C3CF73;
	Sat, 10 Aug 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hciHldat"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5A14A0A7
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Aug 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723270665; cv=none; b=tc9On8vW5aTnQejz9TRON1Bk+qBUIGXDsTsGg3ArvLWA5LCeLGAPlb1fykIq9VigBNmo0wUenuDxqnkiO7vQZdO8s9+yPIgyuX1u+NuEVkeQzQHgJKWGrEYBBz4IGlizhbnOIAMCOlJMMX4Af9BKVEirLqvyRMGYbv/Ztp9Zt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723270665; c=relaxed/simple;
	bh=Xh76kez3LceZ+SmY7GkH4WTSsJTxG0aON28bVGlTKEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hMBUEtV9kzHNKhhuZ/U3yyuMVYRGVpLbASBGJCUy8fM56jGbhVbFv+w2ax26vCuoJCPi0iLj3ONmpHwMcLcFK3MO+9rz+1DKZ8+wdHQFhKqlPz5BhlVqvMyn+7pora+UEaOZ3GSO13T7ub/P9hycDKdsQ/ttAPrk0sGAGuVvvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hciHldat; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093705c708so2937941a34.1
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Aug 2024 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723270663; x=1723875463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kssQgTt+qfxOKb+yUfxI1aRtaU0YT4Asy3V0PtGGYag=;
        b=hciHldatTFlWATYZXMUs0XfEt5zz0I2wBOpcmyvDheAHOx5ggWMhXCKkqVELl0dF3C
         Fq5KoVYwswBf529BYzF16LhmX0c/ff0YPLiHDNCAvTFokbpNbRIouG8qfmQ8Z37CyL2k
         GmibHgz8sMOGNPReZE4MdulbHvcEd4CXL4yPpcesF5+JeQL3jJkQZWmnf7JYjp86+d+9
         /hGZ6zqCeEY59BXJ9dr0ii5WcFtbebvk1eL6oS0x31dRRboApLveLH9DNWE2TTzkRfEc
         7PcTkDgjlrT/BNIUMmuDUwW9sXfcryd+U1FARQO5y3hnx1gfr+QaCfcx3LMoZ0nUbY2I
         EZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723270663; x=1723875463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kssQgTt+qfxOKb+yUfxI1aRtaU0YT4Asy3V0PtGGYag=;
        b=wJ6yQVMtbeAKua5gh5hh6hgOCgblTM20sRCSEvHgIq6EFyjxg3adRiRMSv+0yoQhex
         /pLGU1JljkWhvS+GDGxNzx/WnEmrxFw1qXtUYNADn9KGo/hX6aCL0Y/oVOEeg2hk7uQD
         8IFvTBMf6XjGy1o5VMHP0uJw8laxgyRJmH4Uu/eXIUelD93IyrR7QZ8o4rJ48FaCqB0T
         4Ajc9gZZPQb6/Ic23aKiVkF5mfwzJFYNosqUEWFeAD9MFA4aFpNJv+ZRCsg4R/JTk5nL
         rWowLlXREa5B56wfgYXQjI83y8mAP5JLPqz92s0PpIcAdFX+CqBprdIOP3RlMa3q/U8U
         1nvA==
X-Gm-Message-State: AOJu0YysaQ4RNUB9++YbWDuPLSZzm6h0JecB7ddkXjHgkhBLXAUmTMIW
	9X2MrxoM8sN27tmrUWFqNZcoNS1goIscLYr1efs6y6QWgFKvAk+3OjQvHjC4
X-Google-Smtp-Source: AGHT+IEbFG7dw0apUt8KSKYzIsearwmc679TakkbG31TcAZVA1UjBOrUucC2hwIMWof9C/H1e0WM1Q==
X-Received: by 2002:a05:6830:660d:b0:709:3ea3:e2d1 with SMTP id 46e09a7af769-70b77de426cmr5209453a34.27.1723270662654;
        Fri, 09 Aug 2024 23:17:42 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874e64sm703123b3a.13.2024.08.09.23.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 23:17:42 -0700 (PDT)
From: Sidong Yang <realwakka@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs-progs: property: introduce drop_subtree_threshold property
Date: Sat, 10 Aug 2024 06:17:36 +0000
Message-ID: <20240810061736.4816-1-realwakka@gmail.com>
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
 cmds/property.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index a36b5ab2..44b62af6 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -35,6 +35,7 @@
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/filesystem-utils.h"
+#include "common/sysfs-utils.h"
 #include "cmds/commands.h"
 #include "cmds/props.h"
 
@@ -236,6 +237,45 @@ out:
 
 	return ret;
 }
+static int prop_drop_subtree_threshold(enum prop_object_type type,
+				       const char *object,
+				       const char *name,
+				       const char *value,
+				       bool force) {
+	int ret;
+	int fd;
+	int sysfs_fd;
+	char buf[255];
+
+        fd = btrfs_open_path(object, value, false);
+	if (fd < 0)
+		return -errno;
+
+	sysfs_fd = sysfs_open_fsid_file(fd, "qgroups/drop_subtree_threshold");
+	if (sysfs_fd < 0) {
+		close(fd);
+		return -errno;
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
+	if (ret < 0) {
+		ret = -errno;
+	} else {
+		ret = 0;
+	}
+
+	close(sysfs_fd);
+	close(fd);
+	return ret;
+}
 
 const struct prop_handler prop_handlers[] = {
 	{
@@ -259,6 +299,13 @@ const struct prop_handler prop_handlers[] = {
 		.types = prop_object_inode,
 		.handler = prop_compression
 	},
+	{
+		.name = "drop_subtree_threshold",
+		.desc = "threshold for dropping reference to subtree",
+		.read_only = 0,
+		.types = prop_object_root,
+		.handler = prop_drop_subtree_threshold
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
 
-- 
2.43.0


