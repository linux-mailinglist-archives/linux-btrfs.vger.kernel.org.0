Return-Path: <linux-btrfs+bounces-16211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6230CB30643
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0C5AA73EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4333705B1;
	Thu, 21 Aug 2025 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="HJIyusrn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AED38B65E
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807634; cv=none; b=lPr7U0KmCzaQLgnhBy85AALiIGv00m8ewrZdmab0HFPi3OhpoaJgyKy8/M0QfBbxm13ruzKTgq6CGOGNg0jJcQdtQpgRPxJQ2T9BQtEFvElxUL/796VkMhq0XR7fYz1OrgsqznJjCkhsENi+yA6zHmc0k1qY9Nu/9cEv5PX74Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807634; c=relaxed/simple;
	bh=ai2oUzPAcRJzj4bWGdjdsYHnumyQaMH/ub0qR04Gbgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBupRIs65CYOweVBK3WUDun6/pvcN3J5+JrsiFM5Tbx67YpUBZAm/JxB39wiGmGZZMIXA+9ceof7HD6RfqIPGAiBkGK934nrnZ8tB4SoJJ7GI3WO/kerhEavtYzRD39e6fX9hepc+NVeyBKg3Bma2Bpm5qMM2ckd0xOEIKDMjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=HJIyusrn; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e94d678e116so1442653276.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807630; x=1756412430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=HJIyusrn5p0YqzySCgPuwSXTOrj7WUWgzNcKljJ2uIU1Qr6qdPlsRaXxP0hgg5d1fY
         2GeN+mvpFQiaS0E6lymLMIlFUTHaB+Mbk7WNMGMCOq5QKW1pxr3F9zb0r77rLPUfw2mh
         ZOZwSh3R6+VhSC1+PxMeHs+KRTjW3F7tJqUH7dZ6ehPRmvjtMej4e8eo3tPV1VjB4Smc
         T+ulJHIQlNFYGdNtM7VW/VM/nMAqJbp1vKYAYBfCRt4IIdlbvCX8aK0TMloY6rRtk0x4
         i/FVeln2imLP8DO36EUzBkLJK9I82l3G0SyhpNc5H15Pf8j3nV/2fEqVSA21ScSdJP5S
         p25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807630; x=1756412430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opvoMbW1BQLT38gew8BsXyJcIC3tejqT6ZRE2IoYWVw=;
        b=eoRbwfJPnDXOV9ozAyl3bc8fHFo6GTVNT5Vu/57n3mWw75UHaSdH8pkj5YZX1/iH13
         rOrR1Zf67dqX2mKYcFmdYNfyiPAXlTcRq3XKo5KYfToJyFhcSpR3Vvnjwb4ARvSb9NX/
         elY5adkSy3LLwCaprSOUJN0iHpvRHf+KmHObdJBSFTz34x8tSAe7OJjgSsAMbFEh+jvc
         wOrEVm3T4Q81/W6KJmO89BYSJof6DFWZpOWjr43gS70vIIQ2EOJTRyvvCx8G6JTOUere
         O0vMFT28SLPgGHTlHhQ5kIM0OxjC+Uyvmk/4V0EdaGP7/IlXD/G46bqVWVc1cxJTmai3
         1FHw==
X-Forwarded-Encrypted: i=1; AJvYcCWATO9ZbQ6czSKv1glasS/w7+zj1Kzrqi9dGyyXe3SmBoYUSkT39ISYDAVHmXzeanzrV1d5zpLyoW4Drw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAy6yXHd18L7z7ADzeujDvKppahtcPUL+jn9Ijbl5ecsTlxzfi
	WbZdaS26xe0gzN2DgYWwFKjIGdetm23bM7BSBlV+q6iz/U77l3Q2B81sA0c1Fd3ANVQ=
X-Gm-Gg: ASbGncumgOucmJzoN9qB46T47+Y74Lj7JctXXWN9tVwYkfROFq21GoRL7ghiW74/4pQ
	fdt49riM4Jbdq+VTDbCvs+RgYINPFSoiYmigzlkiHAMn8ytOs1EQ1xBu1oat7xxKNZtyAfRyIt9
	JorcNnzgmLMIFedXM84DBetwL4kYnpwBdA4XBtGRR4fpfZxAHT22CKs3mSgaX+9oBQ5K7e1eC0T
	pPfO7izpmJE3Vj1Ul7m9T0Hs1kEzYHsqdk+KyY5jr/rvp1m8UG0C4L5VOXpK0osEzvQryP6to/B
	r0XPfL0UMPKsmi0tYd0ht1GyGhiueRgF4oIkF3fcwFmkDjaIRWDTTYRrP3R9lCd2mi1fXgxo43y
	5/19JW7gsriBL/uP/CM47NkTAOnRrNtiyQeE1WU5eaA3F/UQYDLGFQZMwwaQ=
X-Google-Smtp-Source: AGHT+IHyIwzTgpEWg8XzW3K6HAoMrfMJMt75D5zXrJVqgdg8vv7vwKweBunmDYNPDq3GubatUhjj2Q==
X-Received: by 2002:a05:6902:6b07:b0:e93:3e42:63ca with SMTP id 3f1490d57ef6-e951c3c4751mr826219276.30.1755807630352;
        Thu, 21 Aug 2025 13:20:30 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e951c976124sm141967276.34.2025.08.21.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 10/50] fs: stop accessing ->i_count directly in f2fs and gfs2
Date: Thu, 21 Aug 2025 16:18:21 -0400
Message-ID: <b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of accessing ->i_count directly in these file systems, use the
appropriate __iget and iput helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/f2fs/super.c      | 4 ++--
 fs/gfs2/ops_fstype.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1db024b20e29..2045642cfe3b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1750,7 +1750,7 @@ static int f2fs_drop_inode(struct inode *inode)
 	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {
 		if (!inode->i_nlink && !is_bad_inode(inode)) {
 			/* to avoid evict_inode call simultaneously */
-			atomic_inc(&inode->i_count);
+			__iget(inode);
 			spin_unlock(&inode->i_lock);
 
 			/* should remain fi->extent_tree for writepage */
@@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
 			sb_end_intwrite(inode->i_sb);
 
 			spin_lock(&inode->i_lock);
-			atomic_dec(&inode->i_count);
+			iput(inode);
 		}
 		trace_f2fs_drop_inode(inode, 0);
 		return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index efe99b732551..c770006f8889 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1754,7 +1754,7 @@ static void gfs2_evict_inodes(struct super_block *sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		atomic_inc(&inode->i_count);
+		__iget(inode);
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-- 
2.49.0


