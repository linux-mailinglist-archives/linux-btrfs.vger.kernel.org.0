Return-Path: <linux-btrfs+bounces-492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5598015F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94EA1F2101E
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975015E0B9;
	Fri,  1 Dec 2023 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="P2IBZhi4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A2D50
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:10 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5d2d0661a8dso29235137b3.2
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468729; x=1702073529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=P2IBZhi4s6FWT6EmTiRkmZ5vcRCji05d+/WMHHRxQbe4LzoupmN19stc4uLSe3iZHN
         sCN5EHh9Yd8ov5VdVJgJUWumvpppkmT4Mzxc/Yh3hX8ZyxDCYLSGV+G6GAoI6q/mW/dS
         seHknQP7B+O7Cq20UmzxeyesvqoY9f4qoddz8fOgtbNw1vpO+mOPh0DZgQmLrOw9M6rq
         qUazgl8K//1CAt/7dA27EWlUX4E6pv/JHIiO4vh4PuP1+Suu5Nzuzk875XMIaegGmcmS
         p9bu6jyBhJ7FnlMuRoY9zevZ8Qt3yAC0012BrVKL0cjMg1F9b2Hb5rqSXqHrb5WNQtUs
         LRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468729; x=1702073529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1X/0Zt7z+oOh2YdMAkIlfw4aC9CST8nDgU19CDUdTeo=;
        b=jkCoZXtwZj4GH0Ci6m9dkQ8ceTy2WaRito7ElT0eoJIqrsFcIcwxXbA+LoAPs7reDx
         mbAf9qRRTqA4DDjgkMoPMejyrmzvzh5wjmg7s/pNzlBeEOOLnjD88rrWJBt7SVAasEyP
         oS0npjbAmh0Iq0G43xqCJFJ+BjJEUScbG3SOTDAjjzPYPUPGnySU81jK2aJncf09Wyli
         VAhe2E+0LZmr5Rpea5qur3QZfGbqUCSfBl30rhsKl3OPxZhXpk7kIPtyU5IylsprGClS
         MGjb6VykbD5J3f+8uqT71l18kSypAsNoWUfd9Yy9IMPWRm6ivQhXrT2YmJZb+eCQkbkk
         RMiw==
X-Gm-Message-State: AOJu0YzOYHYUdo4wWRD+B4RMa5wxwgaugq+b2JbLrQRzB/mu3RpQ+zD3
	d/RyJfC4mEw9XtChtPgJL1rsdxSscjaiTZJaEoSpGg==
X-Google-Smtp-Source: AGHT+IHG4M1CczGHQ7bOVowaE9o2KJMn/AsrysW3l+8fn2dOGNuZYQus1HIZpuOo6/3GSY/TlGFAGg==
X-Received: by 2002:a81:8645:0:b0:5ca:c8ad:1717 with SMTP id w66-20020a818645000000b005cac8ad1717mr26506701ywf.44.1701468729173;
        Fri, 01 Dec 2023 14:12:09 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n127-20020a0dcb85000000b005ccf7fc2197sm380679ywd.24.2023.12.01.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:08 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Cc: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v4 10/46] btrfs: disable verity on encrypted inodes
Date: Fri,  1 Dec 2023 17:11:07 -0500
Message-ID: <9fbfdc5ea7ad2059ff0560ddf079bd1daecd971e.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Right now there isn't a way to encrypt things that aren't either
filenames in directories or data on blocks on disk with extent
encryption, so for now, disable verity usage with encryption on btrfs.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/verity.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..92536913df04 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
 
 	ASSERT(inode_is_locked(file_inode(filp)));
 
+	if (IS_ENCRYPTED(&inode->vfs_inode))
+		return -EINVAL;
+
 	if (test_bit(BTRFS_INODE_VERITY_IN_PROGRESS, &inode->runtime_flags))
 		return -EBUSY;
 
-- 
2.41.0


