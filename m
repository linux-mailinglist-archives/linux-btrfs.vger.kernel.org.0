Return-Path: <linux-btrfs+bounces-12332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB4BA6520E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 14:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C2174C4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D5245013;
	Mon, 17 Mar 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="DzF7VrMR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94F241664
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219884; cv=none; b=J1ScBMo4VoDpPUp3oEZZ3Y2z08aQayrAG3RLzwzTV07u1DwEQGF/eFRY4rByiCPCi5XpH+MMb+97CKHFZIi8q9oSnAZDJc/IEszFXXCnSv7R/OQo9yRUHI8nDiDBxs6Q1ftz6q4addeHKrWAyJIBzLHj4H0j0BzoJwnvpm0qYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219884; c=relaxed/simple;
	bh=r1Vjqf1oCP/p83aYpJWj+A3gopug7Rxe//nacHp5G/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8GfVVRQJdjefVsoF1sr5VxCF5PTQNdjYLm2zZG0BqX3vffOMmX8eWKgJ3P1ZoYhff9YRAZL00NpA8Bf3eLqIiGW7caUGNSGU6IcW8tESqrp/Eo5XdGQsRlcJD3mZZ5n82OlWbycudyrypo60t1dqZcfyW29djMLGs8N9OVBz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=DzF7VrMR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3014678689aso2393774a91.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219882; x=1742824682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7fOqEAGiDFRx1EvcNylApPOY9CX77o6NfjwJaTL4ZI=;
        b=DzF7VrMRZRL8DfFJrTsfEAVU7WbBBNneR2QRK0SEqzTJfYSC/W7eJgqsj7y59YH9a7
         0DWz4hUEuZ6iy3SASnFtgukSlwhIWBFBGAyALBw/pOVVlQGdnHF9lZfKVlHI5xZiS/Zz
         +eV8Dh3GS8HX9NYzeGu60LPJM+cqVPZCZJVVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219882; x=1742824682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7fOqEAGiDFRx1EvcNylApPOY9CX77o6NfjwJaTL4ZI=;
        b=ZfUWbZAjXx87Jit2afsBgMOc5z7SQZsIqmPzG521lQdQ9zsso5AeIJbFwOZqHqJEHR
         dfrk7cslb+YrOitP0sAp6fRePS4JgabJRYp80ySBHWhQfq6ItEpHdfIsy7NOdTF8Wj0I
         QCo7MDHJaXEdfrFoJ18GZdDi3qnoh6ayDMltHxyYBs64yq5q/Ihi/CHLkUQMvRJNPcz4
         AUuH6Zqpl1jG0KF1FGIshP9S8qshZojsgidfogT+6EUDpef0hnXzdeqQwmsavEWBbX+g
         tPQaLwLutE15ZAuxPubwkkzWfomdFo+S1Qo28daT1WgY02yMxBGh9EzW7a/2cZyPPPhR
         27UQ==
X-Gm-Message-State: AOJu0YwPJOshLgiWT00bncWXvaHZS3PY4U4INLNqxGRfBUxjhxGvf5Yg
	bSSHX57RL+nQ7uh8IGIZ3LE+z4Y8g+HqMrqK9DtYtwDHXBLAvzs5UHZj13x3HFw=
X-Gm-Gg: ASbGncs09UKDm3JAahOXvU0VmH010xacWu7aQdAQE/0jsGF4Mds+AQYVeGLS68V9PG4
	Ftx2khQ/6+6N78Dvl+lhEIqT6fNghRAe/YeShjxfWnB5Q3fwJi8MmSkBKlcYspMrzBNuvs7dMv6
	00fOaIXzHkv8INNDtW9eqZzCzTXBySoieGK96YftCAgO/CXYrC20+JrcB8lLfAtPn/1nUWjjJJk
	Aci6wPNunk+G+7Yv4tlW/2EpaolgnSmcSQ9wjw4XqEwOj8kyJsjHLY0ObkgEZu57Q0rWm6cIUGc
	zOH1meYlDF83sk/zRssgrbLsqo8xyDitW0RTAMFfhB0e327fTRByb1rKq5HuWy/lzbCHpE6y8cv
	apxts
X-Google-Smtp-Source: AGHT+IEwHFUXeuCpBUyeil9Wg5Oba6oRQ9mFosTXz52ACT97GF4NSEeGLEXjUVwa2P9T2GloeiXqeQ==
X-Received: by 2002:a17:90b:520e:b0:2fe:baa3:b8b9 with SMTP id 98e67ed59e1d1-30151cb4009mr15615142a91.4.1742219882048;
        Mon, 17 Mar 2025 06:58:02 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b99508sm5993742a91.39.2025.03.17.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:58:01 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v4 3/5] io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
Date: Mon, 17 Mar 2025 13:57:40 +0000
Message-ID: <20250317135742.4331-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317135742.4331-1-sidong.yang@furiosa.ai>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
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
index 598cacda4aa3..ab7ecef60787 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
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
@@ -76,6 +82,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
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
index bf4002e93ec5..effcd01b8a35 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -274,6 +274,25 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct io_async_cmd *ac = req->async_data;
+	int ret;
+
+	ret = io_prep_reg_iovec(req, &ac->iou_vec, uvec, uvec_segs);
+	if (ret)
+		return ret;
+
+	return io_import_reg_vec(ddir, iter, req, &ac->iou_vec, ac->iou_vec.nr,
+				 issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0


