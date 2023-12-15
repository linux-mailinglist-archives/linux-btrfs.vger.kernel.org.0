Return-Path: <linux-btrfs+bounces-977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F40C814B1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 16:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9592841AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D84358BF;
	Fri, 15 Dec 2023 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Qt1U90LS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFE3A8DB
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e45405bda9so6281157b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1702652541; x=1703257341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KykM0YYCF/b8e+2Hen/sDvYlSZd6okSJaZBHu006/+U=;
        b=Qt1U90LSxfJs2Nf+pV7AGG/mh+L5xCOgtkwvWpyPWDb9frpmfrPsbhIesxOrRTMXsf
         8hp5SOwPYNmId8fOU7Y+QLPJIgl2Awsqr/C5nqTCfNohrhNUJYzv2P1cyTW7o3CPRc7I
         m2OPkVFgyai2UDpEl+GSdltJ/1mt6IOsSCkDlfTLimtGRykCEJx7NXYzkOqzHLO9XL3S
         FgLbzzLuBmnZmcnvoyUKnTJZxm+ehd191kr5AQ5vc4RjdoGCR6UVEyfxzJGn5xJD+xH1
         0bQhOD2kkUhOoVHhwP2JmACnc7RewR6zzfm2+6UkAfrpfiXmK3AgWW0YT8vyDTqAyvL2
         fkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702652541; x=1703257341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KykM0YYCF/b8e+2Hen/sDvYlSZd6okSJaZBHu006/+U=;
        b=vMGxEsRMpI3yO2FnLFiJLMY0GhkXIhP347Z+xDY4OrAvjRVPSpilJvgo3HmkuRy6ZH
         l6RU+BHqwp/59w0D3S9VBgQj+V9oqcGGHnRMs9X/zNB1q3eFymhLNQCqClRygMXRn1zC
         pJ0hA17BTAuK5vwB15+uAkOz6t73DIxZlv9kBaS6SicoeMrWoDHOTDrE3QZWNm56ovuq
         40VcIJPEY8gqmsyKQWlhXjWNDU8QPK4CgoypgyD+kua7h+3UtEKcjiTQyQwC02uXq5Te
         59Z9gc9XW2bPWah/+vLUpoOb7i3TyMe7xwoRO073r2pvWo6c7dAXK1HUc/w6j6WPhB5X
         Armw==
X-Gm-Message-State: AOJu0YwRL0yvc1GnyCDJOlLkIHO/JDXtuvZCU+UaBgBtY0H2ZABCnxkC
	nMt/NCNQIYEtSANqeJ4sT3SmoD9Bj42YhiOis0k=
X-Google-Smtp-Source: AGHT+IGa/LJ38PScWCoWP3D5dzXOBjEJ0fyIGW3Y+7tQ086WCnBKdFcQTzz7YWlzNeBDjxvf7gdh6Q==
X-Received: by 2002:a0d:c007:0:b0:5d7:1940:7d8f with SMTP id b7-20020a0dc007000000b005d719407d8fmr8955760ywd.102.1702652541222;
        Fri, 15 Dec 2023 07:02:21 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m14-20020a81d24e000000b005d8bb479c51sm6301552ywl.11.2023.12.15.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:02:01 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: do not allow non subvolume root targets for snapshot
Date: Fri, 15 Dec 2023 10:01:44 -0500
Message-ID: <27a3901ec5c2f63650441e5c99f430fce864b609.1702652494.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our btrfs subvolume snapshot <source> <destination> utility enforces
that <source> is the root of the subvolume, however this isn't enforced
in the kernel.  Update the kernel to also enforce this limitation to
avoid problems with other users of this ioctl that don't have the
appropriate checks in place.

cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4e50b62db2a8..298edca43901 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1290,6 +1290,16 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
+		} else if (btrfs_ino(BTRFS_I(src_inode)) !=
+			   BTRFS_FIRST_FREE_OBJECTID) {
+			/*
+			 * Snapshots must be made with the src_inode referring
+			 * to the subvolume inode, otherwise the permission
+			 * checking above is useless because we may have
+			 * permission on a lower diretory but not the subvol
+			 * itself.
+			 */
+			ret = -EINVAL;
 		} else {
 			ret = btrfs_mksnapshot(&file->f_path, idmap,
 					       name, namelen,
-- 
2.43.0


