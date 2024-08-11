Return-Path: <linux-btrfs+bounces-7099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3A494E112
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 14:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3A31C20B41
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 12:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E524C618;
	Sun, 11 Aug 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUOFdygz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF34D112
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379086; cv=none; b=n7M/pfzg5l3xHy/QYKBDmSVwMisU7XrjwI0yaQ84YXIkWv1oEl488xN6iapUL0ZzGhmxPrGvOOf5jccuWL0QeBTFRFbgU3LP8soHbdGYr3m1+h8sK+mBfo40g1rDkHRgW1rxJF40M4LMSj+xmzyuMdP9HRdV0vT5v5thJxjpkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379086; c=relaxed/simple;
	bh=5gcyc5LbJNInF0D1jtUZ7aSekjqnxEhuoXJNLJh4+Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opPkacfFIMA700iTQxC8822JuL4/AnrKtyC/qlmlgbMFsYGsgUeNcrQsIYVKQBmVChRl9RE1IKyMEEUq+BcVwARkMGZ0OhZRZ2RuDcqW/UIyhYzYS1H+3N8gnD6lR67ro8qVatH0ySexd0IVqzoLH4glIttoHJMhovoSb2Rh06g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUOFdygz; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5c2ac3410so2092965eaf.2
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723379083; x=1723983883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=um0hn4NiuTaIXW28NbcxqL6HnqLECc5dFI4XMCjZn0w=;
        b=eUOFdygzLUmnbNpaXdsq+yFyf4DwtQ3tS0a5YvENHQvGIxvJo7BfxbInlAiNbTnAXj
         6+574QVi75HRzR7IxIb146Lzl0TJ0R3vlPhSbyNqK4bkU7Gp+JQnLjmptyQ6bDpp9E++
         /P5M65EKgg4bnp618s77q9BOLoz2ePBOvDmYzhaH4Cj5GOeCfthAhM5UQ+muFY/pQwUE
         rmydm8R1E9/MXV1MQTaQlcI18pvEDMywJVcR679gyWndoVoHeE6b/3mlC7t35VMOa223
         WwfSoafATWR+JxqXZxMYy1rVLon15xDE1u8KzuMoq9sXGjYPv3nu2wAyO+E1LQtYlO/D
         0pTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723379083; x=1723983883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um0hn4NiuTaIXW28NbcxqL6HnqLECc5dFI4XMCjZn0w=;
        b=bLwcObzhHh4KgKoDhaKchs1+c3TS+HjmI0JnNDsiqoclOskz0AzX5Jtl2QftCPNeAP
         nwsekanaZ4lrhC4vE5/O9Q35p/M2M3rUB4n2jeV+iYcW8m0BK+YgndszNGeaCCXEurjt
         ZlbBClgj37em5II2R8VUOJPXfXDz5H6YxxWkIYEyUjQFs6LbX+P6pHpYXyu8Ex+AwzQ3
         okred/LiVJRn65LRRkYDUu8OBkcydll/2dMFPGYeCuiRhi1PePYXGr+XeoRN4iR2Z0qT
         2s+3ZH/E3KHxCXJ/rQejn4Q/LLG56m96AsDj/3ShjVhw7MayvcpwmZs5euSGkpNcEAob
         TmHg==
X-Gm-Message-State: AOJu0YxSNonQTmroWXqXwmVJbavX4S85aAlu82o69jd9NGMa8zS0AJQQ
	fSUo98sDJB1v7F5AeSh8N8tCRYveWC/a2fo080b/jkkQ8BnlV8ZEnDDJIc+0
X-Google-Smtp-Source: AGHT+IGGL/nCA1RY60jKqzMjmjcXdYCkuocUraJKbpyvPjoKIVDgdCKJ7pXZxMtS4lJDroemp/sLpg==
X-Received: by 2002:a05:6358:280d:b0:1aa:c71e:2b37 with SMTP id e5c5f4694b2df-1b17713bbc1mr1047772555d.21.1723379082966;
        Sun, 11 Aug 2024 05:24:42 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab7af4sm2341802b3a.208.2024.08.11.05.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:24:42 -0700 (PDT)
From: Sidong Yang <realwakka@gmail.com>
To: linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Sidong Yang <realwakka@gmail.com>
Subject: [PATCH v2] btrfs-progs: property: introduce drop_subtree_threshold property
Date: Sun, 11 Aug 2024 12:24:15 +0000
Message-ID: <20240811122415.6575-1-realwakka@gmail.com>
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
---
 cmds/property.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/cmds/property.c b/cmds/property.c
index a36b5ab2..88344001 100644
--- a/cmds/property.c
+++ b/cmds/property.c
@@ -35,6 +35,7 @@
 #include "common/utils.h"
 #include "common/help.h"
 #include "common/filesystem-utils.h"
+#include "common/sysfs-utils.h"
 #include "cmds/commands.h"
 #include "cmds/props.h"
 
@@ -236,6 +237,50 @@ out:
 
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
+		if (sysfs_fd == -ENOENT) {
+			error("failed to access qgroups/drop_subtree_threshold for %s,"
+			      " quota should be enabled for this property: %m",
+			      object);
+		}
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
@@ -259,6 +304,14 @@ const struct prop_handler prop_handlers[] = {
 		.types = prop_object_inode,
 		.handler = prop_compression
 	},
+	{
+		.name = "drop_subtree_threshold",
+		.desc = "subtree level threshold to mark qgroup inconsistent during"
+		"snapshot deletion, can reduce qgroup workload of snapshot deletion",
+		.read_only = 0,
+		.types = prop_object_root,
+		.handler = prop_drop_subtree_threshold
+	},
 	{NULL, NULL, 0, 0, NULL}
 };
 
-- 
2.43.0


