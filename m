Return-Path: <linux-btrfs+bounces-12188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDFA5BF6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 12:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC64F1899E3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 11:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEBA256C66;
	Tue, 11 Mar 2025 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="eAIQqUCe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4D255E2C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693324; cv=none; b=fUxu4jOG0ImCsdLEjfXY+raZuO4MZMzCIytrt2v7XUx4QXI13UAGL3/hOShXg2R9tIcOtOiG+upXNj7IKaZ5+yxRFUWYWeCh7kWZWHu8Mcyweu+DjJHXMjELd4+vV2T4vKYqTJaqxL0EtB5fyDlqVR3aNGQFx6SDYEImsXrGmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693324; c=relaxed/simple;
	bh=RtWG1kcYXYJUxfQVm04qkDa/lg7kxL9FGZhNdQfBrt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGRwsJEX+Oqh+3/pVsQOdokeh8N+LZpkIEIVczA6e+p/4iLr8PlvIAzf2ayg6xDOLSkIrlVvoeOqm+5QTqoi9JWvTrJvZsIW/yHWjG/2aCnx7n9+3mNZPxF7ZnZ7FiwP+qfInyIysotSAvfHZF0ZUm5GaZZB0E6g2Ds8Sv/aoeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=eAIQqUCe; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff80290debso7591050a91.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741693322; x=1742298122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0Fp17O3JAMZDE/PWYetr8PB3aop95hwwptwptAErt0=;
        b=eAIQqUCerY3ew7X4PeZlrbVdKsmZIPpDKjTbz1tMgChXrHjA5i7zDVZ+xLkD1DD9nE
         1pmMP4MGRlvHHNYcQZGnUjMpwsprLLjOBtjQRpkILgBRP2krSXKvNz0+9214gfkbljfQ
         ep8j326sGnIiA2CDVpSI+cL7EiQbK/vkvtdzY7oljOX9tZ0SJZayd7arwszz0ozHqSyN
         hNiUE3lcIDfXYemXqK7JlJCCWU9IuvddeVQgp9YwagJPRsk8RwP2TqMWF2AEyk+crs0u
         CRZiXal+i9PoeGPPHSleNjx/FqM01qqQhPOHB4YoxHNiHSEFXwyLFa91glRKd4Dd2VHk
         RdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693322; x=1742298122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0Fp17O3JAMZDE/PWYetr8PB3aop95hwwptwptAErt0=;
        b=vq2ZcrSbUbT/kW07aFLXZqd8D7Z4PMYaD0MwfxWWBBwgjsiYgGaedd1JTg3BHsWfbk
         EtR5v4YDvJZiea0pSc8zx3aeO+Pd6b1OQ2z2qswMskEcPkpfGyTxMkzNLf8tthh4rh3m
         TPC4rJL81vke7tY2e0n47WYFZHqMais4w0cLHxpJyoRVgLi1uC1eAXdfezWgOOtie3JD
         V8l+NYcXhwMXFjkJrlwZG+D6YgPvp9U0CjnZJLqi9DrxvIR0cmNTlFRsI0E9X/VRKrYZ
         GW+Z2bbNtr9+B/HVcCvI08kRQcRxnX7Jp5AUkr0/cbwkJqyX4wAMW4dMrvHjmTHwIr6O
         oZlA==
X-Forwarded-Encrypted: i=1; AJvYcCXlmFcSYBz66mdvmyXh/0HTx2PyZ7Sa5wtyjQBtYaUu1iuqgpSe2Tl40n3E8kTRSD/aNoKNwCjkaUvAdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wxd//+B4Q+waCJSsr/XskLii8zYGVbvTv1kZ7f8f6+K5tI0m
	BXpFMebKoLYbDuCfUef/W7HD6qjlkx/V0BsHUuPkqNYHpZtBkckYi5Z9nq4TMMA=
X-Gm-Gg: ASbGncu2tqQlODTq+6RcjRoO5qAeTUtbvpirWS1fzy06eOf+2+qkUxu7P68tyULPVaU
	fe6u9XNuq0bbrocj7dOYpKweweciU/Uqz/NgzUDBrLr/A+DOlwVLzjAxRp1A7ih42319bPTn2eZ
	2u019hEFFXup6DNrHwwpnbHEaB3KgZ5X30gFh+KUEaXfrXSIqSqcZjTmvrccZwLL5m0wlvu3RYI
	CZEu1nRsyPy/Sz7SoWWJXIYl54+9qR9YYwsvFbsoKNi0R45lTn8OLt5bYdyBjCAUTO5F5dRnwGL
	ek+f2uvAOcS0e7bjYb1Kx4IuU5wZjxtAstTACXuEbdTOt+aJnJJp3XuB+GVg6ZtTHGMuAby7qYv
	Oiw8q
X-Google-Smtp-Source: AGHT+IFwzzGRe2jkxfHS08jzq7ZtsPhqL17dqZLhLnPKsxh8KSmAtnOqy8MNjjK7N8xAtgGZm+Y1lQ==
X-Received: by 2002:a17:90b:3fce:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-2ff7ce47c16mr27695933a91.7.1741693321657;
        Tue, 11 Mar 2025 04:42:01 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff8cfsm11647817a91.37.2025.03.11.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:42:01 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 1/2] io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
Date: Tue, 11 Mar 2025 11:40:41 +0000
Message-ID: <20250311114053.216359-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311114053.216359-1-sidong.yang@furiosa.ai>
References: <20250311114053.216359-1-sidong.yang@furiosa.ai>
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
 io_uring/uring_cmd.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..75cf25c1e730 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,13 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_import_fixed_vec(const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  struct iov_iter *iter,
+				  struct io_uring_cmd *ioucmd,
+				  struct iou_vec *iou_vec, bool compat,
+				  unsigned int issue_flags);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -76,6 +83,13 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_cmd_import_fixed_vec(int rw, struct iov_iter *iter,
+				  struct io_uring_cmd *ioucmd,
+				  struct iou_vec *vec, unsigned nr_iovs,
+				  unsigned iovec_off, unsigned int issue_flags)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..58e2932f29e7 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -255,6 +255,35 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  struct iov_iter *iter,
+				  struct io_uring_cmd *ioucmd,
+				  struct iou_vec *iou_vec, bool compat,
+				  unsigned int issue_flags)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct iovec *iov;
+	int ret;
+
+	iov = iovec_from_user(uiovec, nr_segs, 0, NULL, compat);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	ret = io_vec_realloc(iou_vec, nr_segs);
+	if (ret) {
+		kfree(iov);
+		return ret;
+	}
+	memcpy(iou_vec->iovec, iov, sizeof(*iov) * nr_segs);
+	kfree(iov);
+
+	ret = io_import_reg_vec(rw, iter, req, iou_vec, iou_vec->nr, 0,
+				issue_flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0


