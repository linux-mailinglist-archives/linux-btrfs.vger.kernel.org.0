Return-Path: <linux-btrfs+bounces-7805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA196AEB2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F9A2843BD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF740C03;
	Wed,  4 Sep 2024 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHc0orWd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9715E88;
	Wed,  4 Sep 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417480; cv=none; b=mqQFdbgvHOz+DkUTgz33X+3A5ZVIfIyWo5Q8nii/4FD4338SclQPa7ihCexm8etHQaIMeBplOZGuOLE4XZ6UnN4pplAjekAxRPdbgwzg+tqbG9BdxbCaViI3hzeGrxEtGTWnfuP6xU8s1dPuk8qrowrXauJ6vHjfWN37crHJP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417480; c=relaxed/simple;
	bh=JWamphkOtxPpLbULfIadroCg9eOJxJ3cy68UMWC+lHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lh3O9C6R52kDjHPJUXctOkaQfQawAH/znp1f09KiSKgx8xBJLJafj/bio5fF8KAA6hiVAIAMOl9NIzEMrfhkN6VI9nDlrLuYHCtLBnuwh8YGiN5txh1GH4csTMAM66ZSXfmliBwhsaJZnWK3HhQBn+wrB3pxrHi5IurSXZp2Zk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHc0orWd; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c35334dfb1so1942956d6.0;
        Tue, 03 Sep 2024 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725417478; x=1726022278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYekGKUaKfWSrHyD44gdvnmP5UY+C5X7/4YnG4ZUPCM=;
        b=IHc0orWdqLblnrwxkvfgKuK99BHa2YOKMN/lH5QKuUOeptpR1rPvF1/zKwipFi3q43
         3aoGPIOm112wygJWKLtlVpCTNQI1qtGyOR6tksngGVd9l/C7y7NjrEYeTEi6tnxMQtUV
         sWX0IYe74AOzpIK65K1MKq44ZhDK5ooOJSNE+3bJ6aygDZVgDLBOl9gg1MD81nZ0JLrw
         4cG6ASWa5A1pPqMSwsBl24dThi9wVt8m9HWnPO9yQA6efdrYQxHM1Nguzle6YuWu+ne9
         PGVszEwt+EddUrc91TPKsTDFCZuFca43JpdtluJMyNWqcnZ8nNLfMtbOR/8Rm/SG5Aby
         KhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417478; x=1726022278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYekGKUaKfWSrHyD44gdvnmP5UY+C5X7/4YnG4ZUPCM=;
        b=IVTt5Hk3VSRUX4lQSAnS4a9nf1R2MN42NLMBVvFuhtrWcUF/l8xJZg6HPqkOGgXyCP
         1SPsvEWzvhafZQbCbaqLaSD3EHeEcmZir3QxAAPJKiYA+V45zAlvzMcGJULYx4z13GJ1
         3f3cDm7+D8nu7MO1vEL5ZMloLy5kCvGYBURJdQsc0JCb4aCsvFwrY2R7WSJ7ozMs7GgJ
         rZTJeWTxMuOw7gAH5ArcEK5qHbKpcGEM9xWg6+TwLW+J54Dw5eIdRrzEKXP7O0DfjQ7t
         CVUVvJ4f0jpOw3uXgZYcdsqwC9YgOYklWWY9aGtuSC8i/HbTthZYtw35NAG6CxxxebRA
         b2DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9j6iTp9MtplDmCHHVKzJbQXGosz4LS8Z3JdwO6UBEH/6Z+y/HcGMzW10H7F9MLIYvbxWkp21Wz2ZPMijs@vger.kernel.org, AJvYcCXy1v8+VolWG7HI1JD65A+DrA4XsUYry9BcRUbg4UJNeNM1HnaCVUZ6g0+GrAboWoPIh7fUMqsICrtsKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxdysD86NxoCn/HdCBWpRybYNTe5vfkuysMEx5DArj6yUwnl70
	MTJI83rXPhMwGwIeg2otscpTJHokLmwcUcbcOjlSN9rGiSckYZwDpLd3Paof
X-Google-Smtp-Source: AGHT+IE7/4FgurudS65323F4GZJOFnqIsUTCHjI2vbFr8qatlCDqY7PYhJSLnczqzILXeA0cLUoVXg==
X-Received: by 2002:a17:90a:d809:b0:2d8:f11e:f7e with SMTP id 98e67ed59e1d1-2d8f11e118cmr6900987a91.12.1725417467200;
        Tue, 03 Sep 2024 19:37:47 -0700 (PDT)
Received: from dell-xps.. ([2401:4900:3ea8:7b27:3586:c44f:1a18:ced2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d0985062sm5673356a91.12.2024.09.03.19.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 19:37:46 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: Added null check to extent_root variable
Date: Wed,  4 Sep 2024 08:07:20 +0530
Message-Id: <20240904023721.8534-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Closes:https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/btrfs/ref-verify.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 9522a8b79d22..4e98ddf5e8df 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
 		return -ENOMEM;
 
 	extent_root = btrfs_extent_root(fs_info, 0);
+	if (!extent_root)
+		return -EIO;
+
 	eb = btrfs_read_lock_root_node(extent_root);
 	level = btrfs_header_level(eb);
 	path->nodes[level] = eb;
-- 
2.34.1


