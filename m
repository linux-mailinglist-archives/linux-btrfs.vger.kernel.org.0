Return-Path: <linux-btrfs+bounces-16375-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAAFB36E1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2483650E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C63568E3;
	Tue, 26 Aug 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Qx7xDk2Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4542F352FCA
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222863; cv=none; b=l5VFu6YSf52k3FLDCP/MXxtbllIHp51Jyp0X/juJCKc858J8qd94JKoZq6MoReZUfMoDYZkIBNzPhvKqy2kdMn3LcEt9MudUB5SH5joUQmwQ9lbofAmaUwQ401BoebV+mVRztRYhg/QNVKD0G1Fj4JLMjLa7pN6qdb/RRKXBI0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222863; c=relaxed/simple;
	bh=vb3lgatLL22BxERk9/b+lCqLtXz3W8a2P/7Gr1XM4H4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/setnTsw1cOm31PaytK7k5hKUfvclbbgO80JEcs1v4JIM8AJzCTDCGjbrOFL9gF1AlDJwSDgA0spcha35dXChQJih0641YPSfUh0ujTe8WoOQs+lRBGLCUTQz9Gd6/EDTwew/dBr8rDLPGEjapVKqy7Y4+lk6LWfEeFwi69GhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Qx7xDk2Z; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d71bcab69so46134347b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222860; x=1756827660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TgvK09Ne5Aq6jRiEthgDjLIcJNkO/NakbksX6k8jf14=;
        b=Qx7xDk2ZZPH1b2wholEdBMKOO4Ugu9Bjzye6rSVT7PbRbJhUDERheM1oMAZR0k/jb/
         5/Ibffdz2WOiGrC1l3dKTc90rfmIvV16iXNw4tariDYGqhLaFGiq1ncqlrMYhPstSKMn
         8uHzstew7KMfdNxZUpzdGP/NKJ/b632/2eOdAN+cjiZIEkIDzorxXRMpjkz3wAAbkxFk
         v7Enw8MxdFr3Z6m/qKrTGIJ0yacWeiLBz6n3rchwtE3PiPZDqsW8msDwatxNMAEBNcsF
         G7MJv/v29W1PMa6Y3gg0MSmN1x3vnPgKWv0KUs/LE0rrjU9/jkwmxvkBiAWEE32429m4
         FtQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222860; x=1756827660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgvK09Ne5Aq6jRiEthgDjLIcJNkO/NakbksX6k8jf14=;
        b=rZkNMEtNSN+LgbsJm9f9TVtUdfCbkmGKg9bhS/rFn4XqQzErjmqNNkewDYnb8WZGsq
         G/iOIhAd6le+aOVOZj5GXCGloWF9Fl2JZ3UXxbHaMIKFVDpGatraObPhKgQWCrkLA3A4
         jRnmZ5tdrgGjcevkcerz4SvSjqlWofg5WkRwULp4CR7F1X2m4vV/nRRpcHbVi8F7EzWt
         GG7g+AJJvwKA9mVhsXuyYJhrwSBz5RM1NuaN0dpMuP3eqkOHa594yvcmC8xgQhcqBgqn
         V21GOFj8euiNOfzPDgia2jnGJJ6QE9EfuZG74EQtyV7gZZKjVEdbu/xZ+oU/PWIKAg7v
         aqeA==
X-Forwarded-Encrypted: i=1; AJvYcCXAbprM7/SYfd8ovu/CgVCj22VrLoWcAEBQ2mSmJ7RkbkeSuNJxyB5CpgJPRYu5Oc4Lx8vRgy7tL1av7w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gsX69jeRdo1WhZuXPvgXpmHnbUALBRj8UtcjbP6y3LeMTFIl
	n8dVH7cISgJI0c6Kxl0mEjuxkaEAa1C9BsmO9AKlELO9vtuKq40e05n3HAyYeNQcm8s=
X-Gm-Gg: ASbGncv0YSsWMxULM9FtnEX8PZ99H/ETnHW3YgXmgXrmt1Oe1xlGhLUzOkmOwYvZDa+
	nWZoWQxC+apMMZ2oiFwvPCt2v8PayUuwwk5J/8H/UU0PBfq5JXxRCBYB0f9KyvVMrXWkty9BjJH
	8jhXJc6afYG0nfX42WHigQ9MfrYEKuGIfWIHZdSkxKhAxie0cNMd+S7jSZ8YM7VuNy8/Hjw6Czl
	ejKMJOFYL+Hjn6OMDYpB6kr5u1M3d5frNo9SjI7dZPafK6fNrYIy9f4HBc7tihOeZFEEOUY98V6
	livVW0t1YmDX6c3vWA9J8p1K6r5pHuZgebtfBQpwh6TqroVODaluB0DAKJcch2+gyPu/5i1YOUS
	1sTd/d9MzXnmnmGupIOkyWCuj9t+F9XSTSvk7zS7WIN5CF+cjd6ZhNhx+o/A=
X-Google-Smtp-Source: AGHT+IFHc0cd1vBL1NZ56pvHPXho4UE/Yj/BshipiSC1BWzt1LmJ0zTyz+AzopKHLGkL4tZhqzzqxw==
X-Received: by 2002:a05:690c:6108:b0:720:2af3:fad6 with SMTP id 00721157ae682-7202af3fbebmr100372157b3.17.1756222860145;
        Tue, 26 Aug 2025 08:41:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff17339fdsm25180647b3.21.2025.08.26.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 08/54] fs: hold an i_obj_count reference in writeback_sb_inodes
Date: Tue, 26 Aug 2025 11:39:08 -0400
Message-ID: <1e555c73564393129833d550965e3175c142bb84.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We drop the wb list_lock while writing back inodes, and we could
manipulate the i_io_list while this is happening and drop our reference
for the inode. Protect this by holding the i_obj_count reference during
the writeback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cf7fab59e4d5..773b276328ec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1977,6 +1977,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 			trace_writeback_sb_inodes_requeue(inode);
 			continue;
 		}
+		iobj_get(inode);
 		spin_unlock(&wb->list_lock);
 
 		/*
@@ -1987,6 +1988,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 		if (inode->i_state & I_SYNC) {
 			/* Wait for I_SYNC. This function drops i_lock... */
 			inode_sleep_on_writeback(inode);
+			iobj_put(inode);
 			/* Inode may be gone, start again */
 			spin_lock(&wb->list_lock);
 			continue;
@@ -2035,10 +2037,9 @@ static long writeback_sb_inodes(struct super_block *sb,
 		inode_sync_complete(inode);
 		spin_unlock(&inode->i_lock);
 
-		if (unlikely(tmp_wb != wb)) {
-			spin_unlock(&tmp_wb->list_lock);
-			spin_lock(&wb->list_lock);
-		}
+		spin_unlock(&tmp_wb->list_lock);
+		iobj_put(inode);
+		spin_lock(&wb->list_lock);
 
 		/*
 		 * bail out to wb_writeback() often enough to check
-- 
2.49.0


