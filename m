Return-Path: <linux-btrfs+bounces-5890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B832B912D93
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 20:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6245D1F2758F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 18:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14817BB02;
	Fri, 21 Jun 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="kHdOIqDg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6600017B4F1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996032; cv=none; b=ajweD0mj8LsubfjVgBDOBkPtHN7V9OBR3kz8E40zCxvVYS7V+ZWW7jfa7wkbGoPhz+fIVnzKahmf2EmQUEYKc4CyYeycfh5BI5tjcHWm8bY0haa7XuShq7Fc0W4FP3CsjKz782RWHmdoedquG8GZny3wGGnVHKxmmSuolJGfOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996032; c=relaxed/simple;
	bh=+7DR7xdElxmwA/FteJcMPm6C2/D+8Q+6v72VxOtXQCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7hMliqjVdJSBAp1wRzU2WuPJwdZZ5pbxRgClOdG8zATCkMWvwZSSGmqz3uk+xDe6CqSzFt1ZN5NxPRyxyC2iCUuoPDaw4CQwKUSooeQHU3hydCLle/EeN5+uBDikNaiRPi8sYh+9cbZ8gSNRPpzXhnmmsfoP+tpTXEIXXdZRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=kHdOIqDg; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c81ce83715so777902a91.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1718996030; x=1719600830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsHrsCyN5cW6JZaDdOSJX6bAuaCSDRAlrIjrdB0BRs4=;
        b=kHdOIqDgk8dVU9aPEd/tR0ZGOZaVA5dbY8JKxAQK14ag8/fx8uTDp7YxFBbSEO3DXc
         OZcRCt4nc7c5YF7oQIC70MAowy152klL4ySRjO1xftc52ZLcLtCh1mpkCijIE0x1iiiZ
         DEVBnxYgfcW1t4+MFTMI1st4i8mY3xfjMwIfwIZqz4gd/+1b6kB5/lTVdBkmb8bAG4Fa
         kXLna7E8aCvixMuRO8JCSoXjlc4x/RCU048/3stzJ7cABjy6+OnJjc0gt9iSjzfE5v8T
         BLi53nOo66h//EVQgf5hcInMlm1tM/DANJ/K8yISPscayEH6QocMK6YbXieeXTPc52Ra
         dMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996030; x=1719600830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsHrsCyN5cW6JZaDdOSJX6bAuaCSDRAlrIjrdB0BRs4=;
        b=C1S2kF86Dw7z/ydWz3RFYnK8bTFwACGWXfwPMwo1qv44NRKKdup11nezPVg86zaeca
         XGdGpOcEp+9ib52u285zSY7wycp32PBDYUjHL3Y4VYfnV2dPXLh+lwh1IiVw9pJMsXuc
         4n4hjWHXxCRD7Tz1GnXhM3VaC3kzbF4em1mIcLLzf8Cgs1EORE+/RSjIeldVy83ndsli
         xrw6vebz5Ynfq1O+zUfHjZsMgirxtLndrRlGPYeaKnQ1dJXjLFIdLYHfny0He+AGbmTj
         UbUdYHP5llDPUEgxyPRdN+j+4it5YTYHHXp/SiHPRGp98ml0l7PfGK/g10WbX+zkr/4c
         ObdA==
X-Gm-Message-State: AOJu0Yy/0NXu0uXbMVBI8czNAGCLMzK0a2G14rpFE4L/QeJDiYrqj8N6
	Rm4dBQnkiWC5bqr7ERITUoEytlA3ECVRsC6tBCnoAU6J+wBa9Won/CvgtCklLClOOEe4txIS/2N
	T
X-Google-Smtp-Source: AGHT+IExdX8RnvT7Jb683P8nMd5QCUrICpVlZCWxlm26HFsxh8M3QkdBRpCdE34AiyFZG7R1aH/mEg==
X-Received: by 2002:a17:90b:1298:b0:2c7:af97:ccf8 with SMTP id 98e67ed59e1d1-2c7b5da57b4mr9141106a91.35.1718996030083;
        Fri, 21 Jun 2024 11:53:50 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::6:1ec7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e06e7sm3957366a91.21.2024.06.21.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:53:49 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 2/8] libbtrfsutil: don't check for UID 0 in subvolume_info()
Date: Fri, 21 Jun 2024 11:53:31 -0700
Message-ID: <0455327c82f908ef22491b40957d4f4bbd30bc60.1718995160.git.osandov@fb.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718995160.git.osandov@fb.com>
References: <cover.1718995160.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

btrfs_util_subvolume_info() explicitly checks whether geteuid() == 0 to
decide whether to use the unprivileged BTRFS_IOC_GET_SUBVOL_INFO ioctl
or the privileged BTRFS_IOC_TREE_SEARCH ioctl. This breaks in user
namespaces:

  $ unshare -r python3 -c 'import btrfsutil; print(btrfsutil.subvolume_info("/"))'
  Traceback (most recent call last):
    File "<string>", line 1, in <module>
  btrfsutil.BtrfsUtilError: [BtrfsUtilError 12 Errno 1] Could not search B-tree: Operation not permitted: '/'

The unprivileged ioctl has been supported since Linux 4.18. Let's try
the unprivileged ioctl first, then fall back to the privileged version
only if it isn't supported.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 libbtrfsutil/subvolume.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 1f0f2d2b..70f2ec70 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -451,8 +451,10 @@ PUBLIC enum btrfs_util_error btrfs_util_subvolume_info_fd(int fd, uint64_t id,
 		if (err)
 			return err;
 
-		if (!is_root())
-			return get_subvolume_info_unprivileged(fd, subvol);
+		err = get_subvolume_info_unprivileged(fd, subvol);
+		if (err != BTRFS_UTIL_ERROR_GET_SUBVOL_INFO_FAILED ||
+		    errno != ENOTTY)
+			return err;
 
 		err = btrfs_util_subvolume_id_fd(fd, &id);
 		if (err)
-- 
2.45.2


