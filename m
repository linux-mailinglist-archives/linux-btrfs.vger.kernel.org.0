Return-Path: <linux-btrfs+bounces-16210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E5B30646
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49305604FB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEA38B670;
	Thu, 21 Aug 2025 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PFgN+rvT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBE350D48
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807632; cv=none; b=Zb/nDvz6Rz6dWzgatr4lGnmcYEfW4SGM7oDD5d0b7FX9wMWOl5pTKmmqGkxEnn4JPneNHy2wpKu43MogaH5OKa3Wj8u4Mu9C4M4lA5IHaJTz0jRDH/8KiqrWn1T0yzlK2Zz6EAoVw4DJTsS+9vfW1wN77qrc3wR73dBbIVQbNSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807632; c=relaxed/simple;
	bh=mSQpopMs8dImzlrX65dFzEQHkhmtgotammgYg2xJShw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abkOv3+zDwvVvrb4cXCBiiMN8xiNIxyR/CW4oxegTucsy4pnSnFmLdGborGAXUVyLteQi3igr++nJy2GYIbUN9e2ri1xW+0s9hgaH3vR0O/zKrDGpPPJrMzyXplDPg1R9SGg7+z3Y8Dcce4pBlvpigEBrOry+bv17hdEX8pkWOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PFgN+rvT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d5fe46572so15101077b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807629; x=1756412429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mDquPBH/1dSQpXa532hRheL3YkOl1FWy6w71RzklVE=;
        b=PFgN+rvTFe6Jh697lf1YTLQHfjBouKpYVk5go+U5yPIR+7t8W/QQirX8BnnzjA/2Zt
         pGbo48pXs8xgFv+9nqMMvAgc7fagC0nm5kpfiFDxh2iyzjorNfO03gJ0MymoxwNo6QYZ
         wuO0kcqeePoAJWFDfn/WoFTCsgBliTkAI3l/7wSjB8/hFzEejaCxEFu92HtcP8aSsCkt
         fFTuULHPPIsgGlOA5KpRaaCi3ree7O+Az5uX1aToadK6O/gKSoZPu7U9gNJjpvqDRx4j
         wrshbWQFUNwI3CI80xtd/UF4eJXWKNPtBRCxg0N58mdztawSIzjMvKAt90cc8IGmBrfn
         lMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807629; x=1756412429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mDquPBH/1dSQpXa532hRheL3YkOl1FWy6w71RzklVE=;
        b=j3xHPK6mYW0yH6GjnjQ0IgTj3SCfU8JAutJWumlbrVw4e6nvmtrVHUc2kzcb3FTQUk
         XOVBwfJdGiDQTa9xSDdY41mzArkiigoBTA8tzRL3oSrHlNKoootoQnxC7y+dV4tZOL7b
         Po127uB1DiJv4seg2YbXjtOvY3XkdYm/OIwZJWRCcfznzDgHO1cyAsTVsCL7Bd/F8bdt
         aa46ncueFJ0DRmNUn7gVqa8/aYoPNqksDgReaqS3Bwf36bC2l53XDTK5QpAupRPTk1kT
         4XRdw6e35aO6LW6OriiSzNO0K5LI+NWKijTkkN3d378zpjaNwiXZz/0/zyVgkRYc9dV9
         VZog==
X-Forwarded-Encrypted: i=1; AJvYcCVlObKp2FACpBNdGNLtej72zjk8u+zXO+fJz1wCE6S5QTJKpO7m5oX/r1EaOBnLIPw94ivSzznwzrp6Lw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhSJqQZqzf1n+wXmrqzaO1ZLQtXtdsSyleuA6RGGUbgDTHQnqj
	STo/3PiM5Aj0KaAcUswGireHcNzL+X1XadxdplaXawFwSXrdbN+Eebkl/RJ0g2/MbrM=
X-Gm-Gg: ASbGncvcSaJlVd8NPdLjcAtFKMK2BFeNAW8SXSQyOubZm96VxPRQTICKmkfZpL8qVzs
	X/kqZzOn07LxJjaS/yFqQWn4zRBF6qOesWqI21KUDRzOXN1msLL/xAbLp2Jr1gN6/CSOl/k1MeD
	jxk/bJHqq3EuIKY5R3GkEKqY8tlvneI+Lg2t2QZHbTQm9XSl4MwS69qJA1ki2EsL7T4/70PSVi9
	jwN9ON2yB473JNbjHDO1YinpbUUJwMkUbZNTbh6Ab8n7f5Olrzq2/KCszjSmOQi7NVbg09Zd9oj
	XEbVyZvs6TWT3PuZ/2RP2sDKC/NQDL6y9kyUHiutPhhEbQvH6OToAqiY6SaN/G2B8sF3Cl9GeF0
	Y5Y4pZ5Lubrux06T3SwB3wAAJLFdoU23syHT+i0jJUxRl2BjeeTPOTKxYDip+2Z3fyl4LZw==
X-Google-Smtp-Source: AGHT+IFlxiZ33ZFGeY0+eRtjwiN/2t7a7T8FkZf43ZiG6zuU4o9brNEc8ITMkGpER2WpFIGqL1aG9Q==
X-Received: by 2002:a05:690c:370a:b0:71f:9a36:d336 with SMTP id 00721157ae682-71fc9fb83c0mr40822927b3.25.1755807628850;
        Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fa24e97bbsm19766127b3.68.2025.08.21.13.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 09/50] fs: hold an i_obj_count reference while on the sb inode list
Date: Thu, 21 Aug 2025 16:18:20 -0400
Message-ID: <000670325134458514c4600218ddce0243060378.1755806649.git.josef@toxicpanda.com>
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

We are holding this inode on a sb list, make sure we're holding an
i_obj_count reference while it exists on the list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 7e506050a0bc..12e2e01aae0c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -630,6 +630,7 @@ void inode_sb_list_add(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
+	iobj_get(inode);
 	spin_lock(&sb->s_inode_list_lock);
 	list_add(&inode->i_sb_list, &sb->s_inodes);
 	spin_unlock(&sb->s_inode_list_lock);
@@ -644,6 +645,7 @@ static inline void inode_sb_list_del(struct inode *inode)
 		spin_lock(&sb->s_inode_list_lock);
 		list_del_init(&inode->i_sb_list);
 		spin_unlock(&sb->s_inode_list_lock);
+		iobj_put(inode);
 	}
 }
 
-- 
2.49.0


