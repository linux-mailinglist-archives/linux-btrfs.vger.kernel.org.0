Return-Path: <linux-btrfs+bounces-12306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB622A630A5
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 18:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE043BCA91
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 17:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F21A205ABF;
	Sat, 15 Mar 2025 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="mUmkojfm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A82054FE
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059438; cv=none; b=Nllhaf3/dwkS3vEoLaK6ZYi5klD3vlhiuyaXZMhsW8+JZeP41jDj19oMqhyy1tr+awCD1haz8lq1+BaN9bGffysnyU7r8ospkmsMHi4JjFh2FeY9JYMDz0DfboSgGDROkDmp6OX7LRmQ0py1Q3gb3Rt9qjcfFOLZXALw9yA5ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059438; c=relaxed/simple;
	bh=1PpG5wl2vDgUXZOFXh86OOBxn7Ar5lt5SQ/Ndxx/TgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOnhmJpKkN7Kz0k/KBRlXdbRmJfdWXl+Zf+FEG2gJo4XBFhCBRqANK5DUuVrhxpMCdUhJvQqLnXVeA0V/vuP20pB7X8jRUtMYFzy+NJ/WUl/qfCuQcFHoGuxNUkt6ATRbrIyC6MHeTBH2ph7WfuWwirkjSepOmU9Z16Rtqfg4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=mUmkojfm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22438c356c8so54646535ad.1
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1742059436; x=1742664236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgnlVIlZsctNY//AQHA0xHAjDyuSTMqzdv7gveBxpzM=;
        b=mUmkojfm4Jcb/yjrSlX2/J3IyGZbInyaXOMqgP5/oLof8lIGSJ6HRoZYeRiONfI59Z
         3OUXxBF4sXEP5gNPrld/1Y3UHULZ1TDJMruTeE1MCvgxkezjiAZUwrx1Wnf+L1TFW+ck
         fm/9ETpKMv45bMHzQdBToCzTYB0vqCiAVPeMNsC97JjHw7SlWWjWQTHvne4SlXIrGMbK
         KHxkekftWCtvV54bCCcANpfDL7krEAUXaiN+JluQ8g/KRgPm4H7o+zwDectpzfSg0WQW
         aNk65GGodAy0tDCRBmoEUYj/YrMMKj5CXJtYZBmUGlTsYyeHP80MqNeUQg8qDYmUIAW0
         yytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059436; x=1742664236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgnlVIlZsctNY//AQHA0xHAjDyuSTMqzdv7gveBxpzM=;
        b=r8E2npAGuawgXioni4JsfoIGxntqBuSE0Ets0h24juzVLGIigCeedDi12x0eFAXQ/0
         o1BiGr6VXyP74TAyc/340TmWGMuEGTMmAq1xhqkqFjpv6aWL2WMXVYlv7SZkQv1WqzmN
         CoExyUy8F+yHvy0aHItWuace4M2xXJ37aiyMuopsmnIm7nJ9DsVoTPdKwKnT7lwfXi6z
         R/8PpIqzoGToa9geM834Vnvyl+9rHZ+M0y7mPmLMnw4FdfAxAE/znhlewEG+4KQDNSuT
         ssbKmktXA6FDkO8wU+BG+/IJ0uerI9KaEtLQc5Ur8/T3tHUV9CQhJ4GS4aB0ukHqSCLd
         OOcQ==
X-Gm-Message-State: AOJu0YyqCkMHiMY6ct7JUTua89dScmmGOoI3yDsIYE4R3GLD2crixvo6
	K8XAiTNVjsWVP4aLoH3kWyPdK/nJnMV1CirCzkG1gvlnl7rrtOHZm7wXepZmJ9c=
X-Gm-Gg: ASbGncswabidZNH3dHSQTLt5pxxBJlWXXQ+TqML4ApnM+O4c4KJs+HDCnpKNAZBo1h9
	oMyG7FX+Omk7Z+n6fZC1+eYiy4N/frmFA3GkfiEfjqG/QUqyuFFOTyVt0E7HN2zgawMDXufF2ES
	AkqVYVwSLMbvF3wOU3BzdAvuAb8a3CZpy3kv3pFf/V9XahMNXpAyyeSE2OUUpCOuGFQk7UNgpPM
	CNDtb5lSPhev7pIGAlJRxxZviq+YVf6sdNzCfuYMZlZ4j5HcJxSZpzjnTxf0U1k8qgnN7mDLeGP
	VgiDIQFfe84ma2glhWKXNdyomkCNr6JwzdJwnCmH8A==
X-Google-Smtp-Source: AGHT+IFCDUOQgEkaQUJPOtUek3RyqU4kZwZOL0TnYTplGs1jgZy9U0ZODBK3dFkuMeQxYadueVihlA==
X-Received: by 2002:a05:6a00:13aa:b0:732:2923:b70f with SMTP id d2e1a72fcca58-7372237712cmr7727611b3a.11.1742059436632;
        Sat, 15 Mar 2025 10:23:56 -0700 (PDT)
Received: from sidong.. ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115512f0sm4673013b3a.49.2025.03.15.10.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 10:23:56 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v3 2/3] io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
Date: Sat, 15 Mar 2025 17:23:18 +0000
Message-ID: <20250315172319.16770-3-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315172319.16770-1-sidong.yang@furiosa.ai>
References: <20250315172319.16770-1-sidong.yang@furiosa.ai>
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
 io_uring/uring_cmd.c         | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 74b9f0aec229..2c7ae8474a56 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -45,6 +45,12 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -77,6 +83,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 315c603cfdd4..e2bf9edca9df 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -267,6 +267,25 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct io_uring_cmd_data *cache = req->async_data;
+	int ret;
+
+	ret = io_prep_reg_iovec(req, &cache->iou_vec, uvec, uvec_segs);
+	if (ret)
+		return ret;
+
+	return io_import_reg_vec(ddir, iter, req, &cache->iou_vec,
+				 cache->iou_vec.nr, issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0


