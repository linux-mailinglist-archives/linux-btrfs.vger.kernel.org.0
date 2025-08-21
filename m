Return-Path: <linux-btrfs+bounces-16233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B3CB306CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156A2622C2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4A938FDE7;
	Thu, 21 Aug 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T4u0tbi4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024538FDEA
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807666; cv=none; b=Rj5Dybte7HzcuWv8P/TWsQetXBkfwgzo7uZSe4+eO9aUGOaKAvh4qozb+bf9M+oA3fEeWDEYf0mTgseto4Cy44eFmEeo76yU8E90bwxajgr6kmDugK7Izu6VF9mspGABI2wWWJy5GNqgcG0Irg6KLOga1cxWB9JcxZbiAojlKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807666; c=relaxed/simple;
	bh=sLtWG4tBwYzFayC8el4qA8KAx3MpBYf6WBWbOygRAvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzggAl3mFI4R2etXGkhtz31s4LCcC5Bb+hL6oMoNE6Ca1vprrHjSI5NTF0z9TYQrXAKI0/WiXEpwjVHGyhj0B8dwbz3UGHpaUCYMk5cnVUJ1g4p8H3wi1Xr6Ig8paep9qdTYi7kbAilrqjh59eQfkNE2a+71Tm75W6a4tFT7/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T4u0tbi4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6059f490so12478537b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807664; x=1756412464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=T4u0tbi4Zb4tBUiLbA2xTner5l3xFJnADxs1QlZj+pO0Lvg+mgQ+z/ZqDKph84MOI2
         FgdvHdgatMts8XVlYQDeiGGmenaP35LFrf4LwnDO+bGSaebO/S+00/yLx2m26ml7RKJy
         zezEaoYtNkL+cCUmjfR84Yvh/o6p0vjPX1jCaakHZAPkRECg0Ytp+QWSu5pxTCsqGT/b
         9PIlNbd+K4oVbClwZAbLvsu791PeNO+JZRxSYdYfma5KtS0WuSAvQBsH+tGRgcwG5dj0
         woTsS5O8F6/ANmDqqQIpwNKolzADTvJMzuwPT4ngqPxUa+zpeD9qHRE7FrigtyiPGys7
         fCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807664; x=1756412464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=tELaOYhhe0LQe00uTjjhTV6qiG+OkUxO7A1q2gt0BbTns8a82dMd2XbgD7N23CqLlH
         yuDh4PP3AzUaTT7jW/tdP3XNovW9d4ISPw6pjuKhmPaWCnooACyPvABkm6d9xz49bwnM
         RKHDgH9qvhaHs5X8DIlIt31KVakZNC3D25m8Io5/OI8gJetJAoab4FW7lxaxcJoV7YHn
         f5IyPE2g+n0RwWLOYJ2N/KWpJVrzY/1/It5h7LrbKdKJTI6Rfu6nqN7mkBJKAMYd8PXv
         7ZQ9ADhI3h20tZ+AKC+F4LRYa7RKOcmnVseYrwdiSIkG/mQazbRXx2i+5Kh0+rdgMOzN
         g5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpfXgulMb7hTCaEttk+EAY/8SuBFQHpLmLFFk61eXcPKoU9JhidFx6gX194lcqj9HeKT+CBywOKawX0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAoihTL72aYHtEQFVM5JolkMP0ZtIgljdAwGUHuxbhWQTwQOaV
	JHd2UsqONeedFhAJq9yfTl3/OLWCRmpNlkqnAlBibf8ZMNu79Tni0n+q+3/3KBXpurM=
X-Gm-Gg: ASbGnctuv4IJRpXoTHZpNSRO4mKYo0778TBRicy1Salq1DfziN3pr1z7FgVcBAicoIj
	tIha711wj2VNzToSBPz+l0tVOL9IYwd3YrzNn8ZdaE6ThOoaxVry4+gjFdQUkulLb12Efc1+Dym
	mzNjzLs4ZKflQAEVffImiNgtW4MK6693wuSnuXKQQrztqDkuGCbG6/dzx50+eMYcWBJnTJhcwPP
	p4KQcgde94tpX1nY3bDP1IbLlLNyBbx/3D9j/nsO1j2PRB6Ho7V8pzYKgtuiUyfkgZbfCAtWrWJ
	POT2oSquoJH/0Q8xfOe3xl+PzugBewMX5rIe3JdUt+CogIaPqIisBbexvVFrviKLv/nwKWhovfS
	37TCGsJq1LGn5ZTVMl6DOY0emkvYB8wtthkch4lK+I+sMWxYDrbVHCHi3TFo=
X-Google-Smtp-Source: AGHT+IFwsNnYsC18/NFJN5WgIoo/uwdywJ99qClr9yakhuxBJ4gcZI1q3LLBJjoDD8XpK/y4+KE4Iw==
X-Received: by 2002:a05:690c:6c0d:b0:71f:a20b:6d34 with SMTP id 00721157ae682-71fdc30ab77mr7353677b3.22.1755807664570;
        Thu, 21 Aug 2025 13:21:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm46054927b3.59.2025.08.21.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 32/50] fs: use igrab in drop_pagecache_sb
Date: Thu, 21 Aug 2025 16:18:43 -0400
Message-ID: <4259ca48aec7355b3d3ab26d5d779973e5f2f721.1755806649.git.josef@toxicpanda.com>
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

Just use igrab to see if the inode is valid instead of checking
I_FREEING|I_WILL_FREE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..852ccf8e84cb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -23,18 +23,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-- 
2.49.0


