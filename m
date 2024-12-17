Return-Path: <linux-btrfs+bounces-10521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978B19F5A0C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 00:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98E81705A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE41F9EA4;
	Tue, 17 Dec 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DATmz7KC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406BB18B46E;
	Tue, 17 Dec 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476469; cv=none; b=Go+xnuFI6hHcMypu2cUFK78Qrntuwm2To9KKEhtqPgTlJruxP39hXETrPia4yUm6On3jJdm6C1M0rr3Wmzetfwhj56TpCF18kwkLr14ofZHRAq+inb6fvrwXcs3++NVo732FBCfEVZRQaE6PF9cuHc7WenxkkfCm5g47xJoEI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476469; c=relaxed/simple;
	bh=2gmBJwbnhf2ZNSTCF79SKc22fvs/vLTCAS8CYCrtr14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpubswME7US0Cd5cIiEVXmiI0Qw79ONSXnPcuTya4Z5uEoOCvDisAuMt7TS5ITKUpJ+mY5bIs+/nK2ScwdwO8bhoiKOtVMRaXO7eOsGHBvG9RM7SPsayBcaBy8+wBu8xdh3VWnvhjAf8s3hf78brAMaO/gltpkQ5+cDh2ELSd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DATmz7KC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa69077b93fso873164066b.0;
        Tue, 17 Dec 2024 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734476465; x=1735081265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2Q+5lZ93c/1180fBGK9dFi80vfh3bKphGjr5C1ObCA=;
        b=DATmz7KCZwWl+YnfY5HDKS0d71QMTLUn6Hgv0yEmc8yte+Q8Ge8uLZFaUe2c6CmP2S
         zumNH8jarLdJHJ4croHCgLzZmsejMeStcoQ5vsMhV2Hf9vWek0SeOoHuUmmS2jWW9ux/
         kxoFxZD3/kkBR9qru5oYqg11c+eCQaZIvOayl6s5KnB7kqV2sg8W2jBv+qiNQ2M1AMBx
         pFlcTabFq8KTORdKU+a4nhs61iJlORElvxSeqFLzfQmYTRLwjxk5KpzpLvGBA9Jrgq5U
         26rHTUNgKQ4Rh62ScgbfCbTGWhX+oAdsYFpQn3LEb0xXWZQ79mdUgyGSwBPrKlQrTEHQ
         GsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476465; x=1735081265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Q+5lZ93c/1180fBGK9dFi80vfh3bKphGjr5C1ObCA=;
        b=bH2o/eumzSi2/OPVoc2azkdnhRPlsXQnBY5HE8qFz0oN7L6TVL4zvluccWmN1+Xgmp
         hqrd9eaQ/LJsPxMCOnonbBHHS7RpFq+5ZYJUaw9QZds94M+EICbUD4JNHWhH4itlA7A/
         ROp6kUDWZi59C4BmvnqoKThNOJywZYCeepnv9igddTcimBZSq/WRmlrIhy7YgakbyBvp
         AsM1wD2JNoJ2nvQ5/0BlX4n9kJKZ9kQDoHA1IfMrBwNm6NcRnkE3dQAG7WMXLiW3IkvV
         wMEUqLU75Th4dG2R/Ne6DmewdEsovofyVE7Jg0KFZBasImRaaVa4TAsQy6ZOc2Oe4X1f
         DEDg==
X-Forwarded-Encrypted: i=1; AJvYcCXPBRtGrJmfSlaynQ+MivbVXZiOutLOch/HVOMq8oL9XkC1PkN8P+V70p11ERdndBKUpiu/xNO5Yq3iUY+b@vger.kernel.org, AJvYcCXSdDJw5Ve+y40U7lpp/U+K1DJQdSU8NYpXZUaOd/CTbAjIQSwwe+Fb+4OU0mUyVvLJmqhqQZGh7IZxMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnz1UF7SjVAGcqoWOehGTva6+PjWc1kEzlc+THjBryCOOuedRU
	XZcFqge67+NUZHih7+V+knmbyt6/Fnb3tTte7uyxnBe/GS/Faih0
X-Gm-Gg: ASbGncuBkHAjEXFtl7nZwhPWVx/TZdYSG7pnNhH1KJwH9FTyWO+lOLt7Rz30UfRldwz
	zYp2sqpfOxxpSgOoc68tg2v7JR2tCVXVS1VLxoj+Qd6SuOSpgOZvvoy/B5/40KoaEENDDVUWIkk
	bePFyUjtZFp6VEZPczC/pLfu/P3xjK/ks05fOZj4taqYGtp2HSojppLnrMnxJX4dRzUd59xvagf
	ltC3Tpa08I4BKKXMI7AlMldu4WV8hk8xy8R8Rqf1ESQIm1oqRcdshEPc1ou8jnwxjnd7K53
X-Google-Smtp-Source: AGHT+IGDgT1XC/54LMv/yuGZqK7CHwcriAKun+hCdwFovWUgDOgR+DiY5cNn7w+69HSV/VlAf9rmcw==
X-Received: by 2002:a17:907:2d12:b0:aa6:8d51:8fe2 with SMTP id a640c23a62f3a-aabf48f9900mr33660766b.42.1734476465330;
        Tue, 17 Dec 2024 15:01:05 -0800 (PST)
Received: from localhost (dh207-43-57.xnet.hr. [88.207.43.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab960065f2sm494726366b.29.2024.12.17.15.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 15:01:04 -0800 (PST)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Victor Skvortsov <victor.skvortsov@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mirsad Todorovac <mtodorovac69@gmail.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH v1 3/3] btrfs: replace kmalloc() and memcpy() with kmemdup()
Date: Tue, 17 Dec 2024 23:58:14 +0100
Message-ID: <20241217225811.2437150-6-mtodorovac69@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217225811.2437150-2-mtodorovac69@gmail.com>
References: <20241217225811.2437150-2-mtodorovac69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The static analyser tool gave the following advice:

./fs/btrfs/ioctl.c:4987:9-16: WARNING opportunity for kmemdup

   4986                 if (!iov) {
 → 4987                         iov = kmalloc(sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
   4988                         if (!iov) {
   4989                                 unlock_extent(io_tree, start, lockend, &cached_state);
   4990                                 btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
   4991                                 ret = -ENOMEM;
   4992                                 goto out_acct;
   4993                         }
   4994
 → 4995                         memcpy(iov, iovstack, sizeof(struct iovec) * args.iovcnt);
   4996                 }

Replacing kmalloc() + memcpy() with kmemdump() doesn't change semantics.
Original code works without fault, so this is not a bug fix but proposed improvement.

Link: https://lwn.net/Articles/198928/
Fixes: 34310c442e175 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mtodorovac69@gmail.com>
---
 v1:
	initial version.

 fs/btrfs/ioctl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3af8bb0c8d75..c2f769334d3c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4984,15 +4984,13 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 		 * undo this.
 		 */
 		if (!iov) {
-			iov = kmalloc(sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
+			iov = kmemdup(iovstack, sizeof(struct iovec) * args.iovcnt, GFP_NOFS);
 			if (!iov) {
 				unlock_extent(io_tree, start, lockend, &cached_state);
 				btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 				ret = -ENOMEM;
 				goto out_acct;
 			}
-
-			memcpy(iov, iovstack, sizeof(struct iovec) * args.iovcnt);
 		}
 
 		count = min_t(u64, iov_iter_count(&iter), disk_io_size);
-- 
2.43.0


