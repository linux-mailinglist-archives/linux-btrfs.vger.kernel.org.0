Return-Path: <linux-btrfs+bounces-9648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 207139C8E27
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F4C1F229B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3219D886;
	Thu, 14 Nov 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="z2HqEI9Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6096A18BB9F
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598094; cv=none; b=h/kU9Zh/2PMn1AvIeQ4SAq+fAL1ID2CrS7m34F6h+Eew4bAZEPeRKfzK5IKH34el9ZdLL0R3ZzjXkt+Iq1aBlkweXdtXZt765rynVLHtRdDD0AGJqK7eFlOaSgzpC36Ci3OEETdityGinsP8nyo3Dq9j3Wf8FoXwcI+lleJZruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598094; c=relaxed/simple;
	bh=gGKnnveMfZPAg4SgJ2FOiR86boymhVofVZdPadUM3k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THKASm2H00E3G0Og/BKvhtY6oskRX4nPTZiCyC0vTt6lNMZ2AqzvNtWaFh4dfIbLF5w/7MDZoeKLvdF1ls9Y+fXscNxarA9l51hgWceOCiSSXefxTptcG5N1UZ3lqc0QUZ4tConxxaL4dBZelGEQ7PmyMSZc096b6tz0R+ufj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=z2HqEI9Q; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc0c05e25so344616eaf.3
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731598091; x=1732202891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyRvRhMBG1NsG1pjAu7RsorwHLATahyjt2W9R5OMw+k=;
        b=z2HqEI9QexiHndBsoUg/10+CpOQf0QjWppiL2AbY+qCvjAF2sEkPM+BxOECc8uUJYP
         ITB5KEBOakM51jI3hhi+wgtuKCBLO8unSpeLemgdjYbeP9omGt4OXmThSfGFTNzmff+m
         ySlzVp+v6Cuo65VBbCrNUN7HtWHIZlKpXuHVlrVuSfxmCIZNlztbNMklhaKpOBb49BcK
         gN8LuzXTsLq82DfHYF3q9nj7SKsBIWYEQk69vqjf1l3tF1khWXVCeNPHEOa6PYU+zwDD
         uUxT8igok79gqdh0Cjd3rwD8PzXyWGy8D0KOBKjUrMW7GQcn79aTvGRPJBZ+JJ2pxQn5
         plhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598091; x=1732202891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyRvRhMBG1NsG1pjAu7RsorwHLATahyjt2W9R5OMw+k=;
        b=t9s/olDaD+gUiRPXghNzT4K9GIX+v3tH3j8mTmNwX9nCDqLDeydvmRTGpOuW3FJGze
         yuM+dLHZSX7GKraZ0Cgqxrs0VkbIpnfkWN+xHINUA7JW/szWLvOiNakJCegNveYUgbsR
         Pul8itNn3ooA540muwuUcpaGKH5odLIvLln5zl62ABvT8AkWK0KyH22yHLCLDhjVvDMz
         bCyxh4s+LL8+Y7Dl16ax+mYq2glL+mr8VEgyfElkAa2ewq0FVX+pc1EausakZBZsoARF
         ojXiHVVPPFkZ4HjbijDgc39tf6/9sgSEu+iBU/4h9Tp8+XYdZXS+GtFgVVDtphWKJjr9
         trdA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHuFasdy6I7GDwCDeQlXiAKX5RryIK9opSo3FLRU0sdm69xC3MSgNiIHnur/UkatymPIGXtsczBHrsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyY4XD03D1XVzpo64tmRXlSNCAhTHbQNgvHbRfpSFL/T8H+JY
	1o0IOGNsU8p0dVIzmkTIA+XselENo0mHBcnn8Z4d965XTsIyC12KnrgoynNkGpk=
X-Google-Smtp-Source: AGHT+IHQ/GenKedH6rwQd+su0Ph/MRWIuzytWarVEOsqT+imV9hIASvSe13ZVKnr0H0iVbl20zcXwQ==
X-Received: by 2002:a05:6820:4d06:b0:5ba:ec8b:44b5 with SMTP id 006d021491bc7-5ee57c4397bmr19027877eaf.3.1731598091501;
        Thu, 14 Nov 2024 07:28:11 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea026eb41sm368250eaf.39.2024.11.14.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:28:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/17] fs: add RWF_UNCACHED iocb and FOP_UNCACHED file_operations flag
Date: Thu, 14 Nov 2024 08:25:11 -0700
Message-ID: <20241114152743.2381672-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114152743.2381672-2-axboe@kernel.dk>
References: <20241114152743.2381672-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a file system supports uncached buffered IO, it may set FOP_UNCACHED
and enable RWF_UNCACHED. If RWF_UNCACHED is attempted without the file
system supporting it, it'll get errored with -EOPNOTSUPP.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h      | 14 +++++++++++++-
 include/uapi/linux/fs.h |  6 +++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..45510d0b8de0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -320,6 +320,7 @@ struct readahead_control;
 #define IOCB_NOWAIT		(__force int) RWF_NOWAIT
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
+#define IOCB_UNCACHED		(__force int) RWF_UNCACHED
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
@@ -354,7 +355,8 @@ struct readahead_control;
 	{ IOCB_SYNC,		"SYNC" }, \
 	{ IOCB_NOWAIT,		"NOWAIT" }, \
 	{ IOCB_APPEND,		"APPEND" }, \
-	{ IOCB_ATOMIC,		"ATOMIC"}, \
+	{ IOCB_ATOMIC,		"ATOMIC" }, \
+	{ IOCB_UNCACHED,	"UNCACHED" }, \
 	{ IOCB_EVENTFD,		"EVENTFD"}, \
 	{ IOCB_DIRECT,		"DIRECT" }, \
 	{ IOCB_WRITE,		"WRITE" }, \
@@ -2116,6 +2118,8 @@ struct file_operations {
 #define FOP_HUGE_PAGES		((__force fop_flags_t)(1 << 4))
 /* Treat loff_t as unsigned (e.g., /dev/mem) */
 #define FOP_UNSIGNED_OFFSET	((__force fop_flags_t)(1 << 5))
+/* File system supports uncached read/write buffered IO */
+#define FOP_UNCACHED		((__force fop_flags_t)(1 << 6))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
@@ -3532,6 +3536,14 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 		if (!(ki->ki_filp->f_mode & FMODE_CAN_ATOMIC_WRITE))
 			return -EOPNOTSUPP;
 	}
+	if (flags & RWF_UNCACHED) {
+		/* file system must support it */
+		if (!(ki->ki_filp->f_op->fop_flags & FOP_UNCACHED))
+			return -EOPNOTSUPP;
+		/* DAX mappings not supported */
+		if (IS_DAX(ki->ki_filp->f_mapping->host))
+			return -EOPNOTSUPP;
+	}
 	kiocb_flags |= (__force int) (flags & RWF_SUPPORTED);
 	if (flags & RWF_SYNC)
 		kiocb_flags |= IOCB_DSYNC;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..dc77cd8ae1a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* buffered IO that drops the cache after reading or writing data */
+#define RWF_UNCACHED	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
+			 RWF_UNCACHED)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
-- 
2.45.2


