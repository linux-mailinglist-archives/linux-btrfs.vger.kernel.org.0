Return-Path: <linux-btrfs+bounces-410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12D7FBD95
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66002823CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Nov 2023 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883535C086;
	Tue, 28 Nov 2023 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CSwjlsE1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84938182
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 07:01:04 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso5420848276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Nov 2023 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701183663; x=1701788463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c7aniDquVBjk3b69H+L2gBHam1X30AlsAqQ0Sx2DKMY=;
        b=CSwjlsE1OxXo/Y+MIzBB9sa0tVNv3pQkS2iyo+AyZEBbNX+YlZPU++pW+7jy+s2GZZ
         /xHxlhh83ZQQdEj2teJxYzh/T3W50mLH7EOGAdaCAcKKjAlJX2vOnkQ8qGjI1jk+dV8+
         c+Xqrxy7YWEpeY6wZWYHwostZ8CdI4ycyFuqAwTA+prpwqbpXQKj19PIaNNivscz0iAZ
         xAqeco6R9dvi6J1MeSkCZyl8XpNxFDQZ/Bn14ljmPrDKYQNmNMBDgLzcr61NuxGGWJUw
         5R4ve98xI8eFHd1yQk1bel/sSdEwpSE37YnAPgEi9/k8wNIAs0oEEGY6rDTcSWghfMdf
         8zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183663; x=1701788463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c7aniDquVBjk3b69H+L2gBHam1X30AlsAqQ0Sx2DKMY=;
        b=Q97tx3fVkuyonX76gAPn0aithGUknPKj9kSnYzsucBbZS8CChlfkujZva3OvDpp1k0
         j41XpTfwNHPyvTIt/CsV/jcyuCh691fN6Jf2bbbSQeVcJBT2tR7c8Kv3OjkzkhZZ0UXe
         u5jvzczRquuhjFd5ooKGeVcUsFmKIazMGrAD9BBXvc7Lkdqn2IlKY5rdRwx+qNooit5h
         Hz7hPoE3kED1415UCp+y27bCcW6kLZhEEz2hH2LJxfxGbj+OHkVNoBpSfdngVZRnwyyG
         X+AMFfXRz4csJkWHs29wkSorWgvpe54XCFTGbPUWC+yhqGYPy6eJVpSmspXLfIX33I0g
         u5ZQ==
X-Gm-Message-State: AOJu0YzjwklfO2EqNldPQRiNsWwgMfTCl2nSZ85th5rdQNApQTnlQoX0
	6+Z1kfzHCN6elNd4hhADmbCZxD8DYMMIrx2zxEnNnw==
X-Google-Smtp-Source: AGHT+IEMi0shwq5o00GrRQpK+OeJkM3bQc/JSsqvlBu3fNb925WgUnn58bOrE8oy0ivWC7wy8mVkWQ==
X-Received: by 2002:a25:2d23:0:b0:d9a:4db9:3259 with SMTP id t35-20020a252d23000000b00d9a4db93259mr16685073ybt.38.1701183663489;
        Tue, 28 Nov 2023 07:01:03 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a31-20020a25ae1f000000b00d9cbf2aabc6sm3672043ybj.14.2023.11.28.07.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:01:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: fix compile error with !CONFIG_BTRFS_FS_POSIX_ACL
Date: Tue, 28 Nov 2023 10:00:59 -0500
Message-ID: <b649ade5b712e47f4b4b3793943fa304edb26bba.1701183605.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I accidentally introduced a compile error with
!CONFIG_BTRFS_FS_POSIX_ACL in my mount api v2 patches.  Fix this by just
returning -EINVAL.

Fixes: ed6a5b9bae38 ("btrfs: add parse_param callback for the new mount api")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
The fixes tag isn't useful because it's in my local branch, I put it in there so
you have the title to fold this into the actual patch that introduced the
problem.

 fs/btrfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8ce7c880e9ce..63dcb7f7b42c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -413,8 +413,7 @@ static int btrfs_parse_param(struct fs_context *fc,
 			fc->sb_flags |= SB_POSIXACL;
 #else
 			btrfs_err(NULL, "support for ACL not compiled in!");
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 #endif
 		}
 		/*
-- 
2.41.0


