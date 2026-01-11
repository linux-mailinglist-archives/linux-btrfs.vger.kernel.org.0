Return-Path: <linux-btrfs+bounces-20377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50827D0FA1F
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 20:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACBBD3049E35
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jan 2026 19:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540C8352C5B;
	Sun, 11 Jan 2026 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH0qpOmH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662681EDA3C
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159243; cv=none; b=CYrimflYMS4i6aosSspP7gK3Kt2liyJHzqZKnMeUDIJeUHLok40FOo2S/PoCNeU9ybU7jEJIAVkNACfLZqTf7imXJLqibkdrh711+V+TM/8JzjKgreLfdl/u5cGD/36I4yL42BmD2qenXjGtgMmujf92SnEyt5lCkH8v4+bucpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159243; c=relaxed/simple;
	bh=BSR9/TQ/p5imCEcKrAtupWmllDYKd7yJaXlCD+RS80s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g6FsnT8TTi7pEtihs2N0b3MfyHjzXebEMtQZbYCmxfeS9F7dTUsUmJeQMeD58qyMVFkDddHdryL0GpUgeqzNDmwvqCNzjI8N0z9zURhK8dB2/AbZjzSUmBV9tn6bMMmgxFcZ/gGHYN3a8Tk8Y0+811vjpkIuIKEcb7QxfCnNzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH0qpOmH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45358572a11so3586961b6e.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Jan 2026 11:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768159241; x=1768764041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ADOaRAJIPqe3P6tro1B0tkl/E3ApY8MPAlzeGxOg7q4=;
        b=GH0qpOmHbP7Uq2uqJK76OGktBUBBoMiosheyHi5jzwsEpigbCTYskActSl9hnAVWGJ
         juH04LKmDuNRwA9GM2ndWpf/VPZINf14yvhNGCnRo4QlWKUhA3HjFekUnfXOZ3DQlNFD
         JJtJAT90ZamsjLdUXRbqc8NZ6fKPTApFN0VSnx9IozQcJLumr0g7RyjAXWe28rS/tJIV
         fhvaGu7jhh0RWFMJMD+tNViZVhGVTUFsHuP1B5ohC2j61x4UAbPouEEpwFvE2/9sxYFQ
         el3ycCTWQi8jrpAJgDjc0LCstVXG6tPjVXGyRF6mDsEXxNq0/IEYMoySwGjAEJnRMNpE
         VLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159241; x=1768764041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADOaRAJIPqe3P6tro1B0tkl/E3ApY8MPAlzeGxOg7q4=;
        b=C6IwdzWp7R/NSUTJfTWzwKFzNhzGXOsm6EWmxbV/kjc8aapkXRJbc3NZScTlBabiYJ
         DQv/AexFGKJm06sphmkcK/gCMJ8XjE5HPjwbQ/2pj2odhMosUnVtA2wSgT9v1Vn0Ft7H
         bKXTWkT349cVYcKtl1f7/EOG12hPcYi1KSkw4Vm8/Wdvghq8D+OfT3NxxBBQ5PXraRye
         wsl2TeeC/S6o53FmQnTSweGIQFn79MSwbJaN4aZes+2AEtZhPqgavog0fm1XwPH8hJKg
         +1T6utsUt//znORz6em/BfTep6K1GOYZ0rn604ABroqNXdIXNpN50VdrUHrVW+nBpcGJ
         jDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXacx30FHt31w0GjIvx2QYbtqu8LAdoDRAfrEZ3PJ7oZWunXw1I7AsAIzp/MnjY37n3wFAOM7dt84ejGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmp8GA+sZsyJ5duj+NUTuCbc8vk3HZERUS8niXSanaS6erXp5/
	tvDJyYTwZtmLGokpwM9VumpXz7KK+CgCfmm0hDrckTc77lC4DoZg2xPm
X-Gm-Gg: AY/fxX5PU+agNwd48DujfI4hTqlmW+vV3Kt5MOxXbqwIo8OuLbdDy1Sular0/H7+GBt
	nBN4o/uKVYP8eT3Zqz69OrTM9X+4489i0VTJdm7x9pInFg+4P1uButM9bnf/o8qWlHrurSxEQ7M
	pCw2L87SBxVEsZeYp/hFQDoE7hfMG40LWcro5IsaH9BtPYAhjQhISpKltrYV3zXXS6t3gaHnS0l
	ZUnL0ZqtcxjvlOddDJse6keX2l0fX8Dz3/Evg8TUj8JqgxMeaO+Mnxc1ymnDrRl8ORWH/13V/Qu
	94PEMBqmQTvyK+vZ/HxRi0+jAVyHaju5+PsBJGFuJyOwhPLOZE4u2qvzMTAYLj9TheIBYUhZokL
	4jbysWcNi2r5sxehRww0+bwt7CLAV7IzKdQqkX7uJBoOAwMGZvdjF+sqEn8Jmk/yGtNV3g8B+jH
	q8lkpGbSHQak7VsZKOXhHvgL3qhjO/pQja
X-Google-Smtp-Source: AGHT+IEFZrElztYmD7bS296+b1DYXEWoHBVFfLQORqYoIZc/PkHNe4XgCvz3eOJtGLAjf72W0WGdSg==
X-Received: by 2002:a05:6808:138f:b0:44f:6a32:5364 with SMTP id 5614622812f47-45a6bd77d1amr7966780b6e.24.1768159241285;
        Sun, 11 Jan 2026 11:20:41 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa50dcd81sm10701097fac.17.2026.01.11.11.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 11:20:40 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Jeff Mahoney <jeffm@suse.com>,
	Liu Bo <bo.li.liu@oracle.com>,
	Nikolay Borisov <nborisov@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: fix memory leaks in create_space_info error paths
Date: Sun, 11 Jan 2026 19:20:37 +0000
Message-Id: <20260111192037.20932-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In create_space_info(), the 'space_info' object is allocated at the
beginning of the function. However, there are two error paths where the
function returns an error code without freeing the allocated memory:

1. When create_space_info_sub_group() fails in zoned mode.
2. When btrfs_sysfs_add_space_info_type() fails.

In both cases, 'space_info' has not yet been added to the
fs_info->space_info list, resulting in a memory leak. Fix this by
adding an error handling label to kfree(space_info) before returning.

Fixes: 2be12ef79fe9 ("btrfs: Separate space_info create/update")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/space-info.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..3f08e450f796 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -306,18 +306,22 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 							  0);
 
 		if (ret)
-			return ret;
+			goto out_free;
 	}
 
 	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
-		return ret;
+		goto out_free;
 
 	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
 		info->data_sinfo = space_info;
 
 	return ret;
+
+out_free:
+	kfree(space_info);
+	return ret;
 }
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
-- 
2.25.1


