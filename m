Return-Path: <linux-btrfs+bounces-12241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECBDA5DEDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 15:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E773AD8B6
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Mar 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7D124EF95;
	Wed, 12 Mar 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="VpC7xg30"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6F24E012
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789446; cv=none; b=VHvT8x34xrN5RbuBzIbmpK2puztfvZqtuyzaUvvciSSgUjgn40oNmmebWe3V4dwbF1v73G1W1hXzf40/CQcJNSUwD0ZAG2nsj87LoARZgLcyTxFRVeCbvypuIP4PxrQMy14QMh6fviZq+Z8Lhjvxuy7/Uhf3+ezwYdazSuijGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789446; c=relaxed/simple;
	bh=ueLLfb2g6ooAKzkCZNWnsaYYsRz9CK6dnjSm/F8mDd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTgxEDWZQHm7/xjI2e96x8YPvfPofpIZrA7tNPlamVJ6FLxj2aHzOzf14WlcgECnHfgIQMceLQrQeZf9c1SdTdr0fYxyXcgWRnYKjSfkxyqSkPyS3+lZ6k39jov7BniwsWU0dF1p6jqHyG4LAqsHWsLDIpTaQ5ORFKCQLWbyGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=VpC7xg30; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2254e0b4b79so47023155ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741789445; x=1742394245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xE5xU4H97yAwT+GSMKnaXD9mzHnmpKqghu02U5UNnw=;
        b=VpC7xg30l1h4FAr8iEL6sODXobJWIdIyvkZ1BftrdM+DwlLEdrzR39EZulh7SFpX+b
         3zHRWQU798dj6mW5iKFwvkED+t6wPj16rdSVFPWvwcVgYuVKko4+hmhax2kilYLgQmfw
         rtboAnV4b0ivyBMYS7zHQ3QTXjJAgCzXCbG2eNtSbO4xf0vak15Rq1WjkPUjqrqsE1TC
         5T007ewHZr7tW3+aN3qpGTmic8aKdWf+KUnIKvyFe5GEi3UMvRfo5AmFyfwEpSrWusMH
         Wbw0T5cAe3XdiyrcGh6pEdscd+g9Y2OAsr6DgLWBm9MsyyvutjcyH9bCepgGwFd/yXnI
         j0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789445; x=1742394245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xE5xU4H97yAwT+GSMKnaXD9mzHnmpKqghu02U5UNnw=;
        b=wEJMXJgw+2rkc3VfLXHlQDOknM2m2thro2N2I75Tnq4+7eW+Dly4W6zYcxFb8Jkiv9
         uO0Xf1eYu/dHBZ8hrZ7bxOv54Hwo1Dfvc6q3VnPDREBZhC4wSR3w3dsTLjfT0b3b4Gby
         3ohMSSzdmBTVPC08cr8vgT/1vtBB8bPTaGdKdpc64dpD2UZkF+I9phwzsLTlw8YOUyaS
         dT3h1c1utIhlcR/Iw03wLcl/ftYIDnyeHktpmZ6EsFTRm1BMCpKBcdBcWT1bXDrzrDxV
         E2SOSiUBePvy/jVZ5Ct8yPVOdszz8r3Wy3V3iGCnkbsuK39GxtL6w43GOmu1mVbDP2ml
         1wIA==
X-Gm-Message-State: AOJu0YwTvnERgRkqH0bHima1Say1+Aem15YpovepxSQa5wvyfe6SIlnL
	1s9YVByxaD81ycyHSIK7s75DaZM9FTWGAz4E0juBldBi+fcoGmPcaYf6fdV3Ro8=
X-Gm-Gg: ASbGnctL4xP8RG8rvMnjaa8X9r3Tw2PzYGxdoopEzKKnNP8Wiorm4JwXxOTf0ERNycp
	DdErr7DItK1DjPMmlGqObs630He6+whWDjIVv0c6xUn6xWsjCUD2tJyN0+qEUZoWmmbIFNtHqFD
	Ds9XOAbBtJCWv3JjD5bj2S1cGnZdfkBIs6x27Zx+aMo4HY5XtsWj0Wfs/LJ1pUR60hg8TOcwL/m
	4oU5DDKBhZe7ygzhD87pdInZ6SkLBLNrQWPZNObQWwCwoYK7TKFTi3X6Djqt0uzYjbSpHSNi8AC
	lDn5hHgLucmuJCDBeJGyzfSe8uw9OAgoa2z5nUqWApr6XYHmGyU6THi+TrYBV17lZMZJUAlNY6n
	VLIXL
X-Google-Smtp-Source: AGHT+IEFkanN727wtkiJd8Cv9m0pOpd+cskICbFK6tPN+bU3UWDrxWUgeUfFa42vbUkQzGost6P7tw==
X-Received: by 2002:a05:6a00:174c:b0:736:9f20:a16c with SMTP id d2e1a72fcca58-736aa9e96e1mr28852100b3a.5.1741789444707;
        Wed, 12 Mar 2025 07:24:04 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc972eabsm7413860b3a.144.2025.03.12.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:24:04 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 1/2] io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
Date: Wed, 12 Mar 2025 14:23:25 +0000
Message-ID: <20250312142326.11660-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312142326.11660-1-sidong.yang@furiosa.ai>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cmd_import_fixed_vec() could be used for using multiple
fixed buffer in uring_cmd callback.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..b0e09c685941 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter, struct bio_vec **bvec);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -76,6 +82,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter, struct bio_vec **bvec);
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..6bf076f45e6a 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "linux/io_uring_types.h"
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -255,6 +256,36 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter, struct bio_vec **bvec)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct iovec *iov;
+	int ret;
+	bool is_compat = io_is_compat(req->ctx);
+	struct iou_vec iou_vec;
+
+	if (!bvec)
+		return -EINVAL;
+
+	iov = iovec_from_user(uiovec, nr_segs, 0, NULL, is_compat);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	iou_vec.iovec = iov;
+	iou_vec.nr = nr_segs;
+
+	ret = io_import_reg_vec(rw, iter, req, &iou_vec, iou_vec.nr, 0,
+				issue_flags);
+
+	*bvec = iou_vec.bvec;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0


