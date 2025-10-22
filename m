Return-Path: <linux-btrfs+bounces-18173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD7BFE7E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D8518C7D73
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BA2308F2A;
	Wed, 22 Oct 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FiKXf9Fa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBB3307AF0
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 23:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174824; cv=none; b=lSnqHOc1aF+NMpjy7IeKVQARrAKIKWABwPV9ghg4yxVOMFSNREOq9+jXy2X8LDmaXLjwr7pavnOrvVwQ62oGJXeaowWZLOx3rFi6In0B8lsTbeU2I3XvlBe09BbvDWwHAfoA6hoy3nHTgdVLowdXjLFatUNnx4Lp85UwMVdxajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174824; c=relaxed/simple;
	bh=5e89GXt6DhKyASePnDrD7cthV1505P8u/yKg4DMfB4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQwS0bDdGBoLbG6rEphNyzLXZnuyicOleCnnz79DeKbWrOJ2c0vuN8uYOvrAQJbEEHj64+dhqqzWBYHfgC6xgWjOpdFwP+km4r0fOOWgirJsYrXMr0PP45RjUWSG/XkpJTiDSWhtSPJYnf+S+GZ/9F58MpRSLeyOucUSAg17Qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FiKXf9Fa; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-592f40b1a40so27869e87.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 16:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761174820; x=1761779620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=FiKXf9FaU3BYrYwrRbv4OE29zmFm+UpmIvBYgzLofZvqaAxBVf6rq8d76ApJ/8nrrj
         dKOQjVnupxM/9ZAhxhDiouvB0IbrDSgQt2UJZXfTW05Nb+c7c6LmXG9YGQyNHUy7/tso
         Ag3RKol94LTq0KdLEKq7xptTBBKYtcylXgYz4By/KlJOml+8h0PTohxKK4cgmNyPFj0k
         7Hsq1gi1Y4viEOslDbTtvtDr1d2vNbdsoehrXc81loS6llfaruWLdukonzPVGFZG/s5V
         JAfW1C6lBxT7GmLFJjX5mK6NMMeb7Ns+OqJCZ/hR8e7qf20C1U8Jf7sWWugZkAVuS8ZE
         Whbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761174820; x=1761779620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96BiLrpc0TjSBBUxSZ5BCVjSp2BMxOcWJzQbIZwxLNw=;
        b=ZxqAOGXoC+U1rEVj6LtuLP+Bq3odB8C5alciS7O/ItT8j32nmb/8yL4ggGJyW7x1lV
         d4cy+Ekl7y8z7S76wt9rWGh1Ckg9tWmb8OXzvUaIMu5HE8aHgYIbLbylciijkNtTu6gr
         phnoe3OHFA1RI0tX/MX94y/GnbJcJr3X8YO4w9LtJ+79CGNz9JWyg9HxFJkqZbyeRv1b
         wWBm0ZPsR3DUlbKgAvzWaJ/5xexrV5KYxXQQjhZ1jqV/FaIPOA67jsduxRBtXX5g2Wyr
         idttHwu7C15SKDnUiZqZoisdFYXegXKIYInRMSg96P3beauyfxVQG1IFsl11jRnjOHPo
         j+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVUswoLpofr/F3TmfXeLrK7Q6fP0xpkn9RcOg8rkJa1dDgW/kCeEqsmhmnPutn4FJ8T8uXo2vW8ASsDdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgrotJ9e+kDxYpeo+2VGxJZiID/Y5xsxFi/CX5pvEXzkeFR+I
	QNlS6jQl5F6GRPChHySg1888F3QRIH5QdpvlVRu6OIb31iRFl985rvoZ+RB5VHx7oCU08drj2Wl
	cxbITbC51MUG9kOJgUXxcOP7S0fBaXuEPbDng
X-Gm-Gg: ASbGncshjuoyAn4AzwScLJwDkG9Sf8xmZqNvsLLT42wrrfNvV/riP0SJgfzVUzfEHP7
	kYwzc/Gvaf7gmLnVWVVNGV3T+dslK7IhnRRiKMEX4xef1S6hXYVjV8f/2TA85A9vFx+KtLX44nH
	86wUylPlcawhFG/Mow8C8QCJATt2XfR78gBXCjfghmaeS0KoPxDjkVqBgKNPOV+FGCOY2FXolfO
	skyUI5dZfgXtlhvai8HCgPu24Hj1pWV79OPkW+AWKxwee4mR1uOPeth9TC8ALskU1+ByCjkhe5P
	Wofir1le6xsUjkSY8XdpgV+t2ZrLHEtnT3xu7mBt+wpdBmtxcF/u+eLTbw8PRS0hSS76LImMwwz
	fQT8AH6jeFuGA4HZTzIan2uZld1IJx8Y=
X-Google-Smtp-Source: AGHT+IFL+l6RiiF9NVqqr9YCIdVCyARHhrDoK0DxchCYTCey03a/1xzZtxLnzmVhVLR9bTz6N+i4aHRAWF2/
X-Received: by 2002:a05:6512:308d:b0:55f:6637:78f with SMTP id 2adb3069b0e04-591ea31cd1cmr1457181e87.9.1761174819856;
        Wed, 22 Oct 2025 16:13:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-592f4e44e32sm33929e87.46.2025.10.22.16.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 16:13:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 372123404B4;
	Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 307C1E4181C; Wed, 22 Oct 2025 17:13:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/3] io_uring: expose io_should_terminate_tw()
Date: Wed, 22 Oct 2025 17:13:24 -0600
Message-ID: <20251022231326.2527838-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251022231326.2527838-1-csander@purestorage.com>
References: <20251022231326.2527838-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subsequent commit will call io_should_terminate_tw() from an inline
function in include/linux/io_uring/cmd.h, so move it from an io_uring
internal header to include/linux/io_uring.h. Callers outside io_uring
should not call it directly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring.h | 14 ++++++++++++++
 io_uring/io_uring.h      | 13 -------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 85fe4e6b275c..c2a12287b821 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -1,13 +1,27 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef _LINUX_IO_URING_H
 #define _LINUX_IO_URING_H
 
+#include <linux/io_uring_types.h>
 #include <linux/sched.h>
 #include <linux/xarray.h>
 #include <uapi/linux/io_uring.h>
 
+/*
+ * Terminate the request if either of these conditions are true:
+ *
+ * 1) It's being executed by the original task, but that task is marked
+ *    with PF_EXITING as it's exiting.
+ * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
+ *    our fallback task_work.
+ */
+static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
+{
+	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
+}
+
 #if defined(CONFIG_IO_URING)
 void __io_uring_cancel(bool cancel_all);
 void __io_uring_free(struct task_struct *tsk);
 void io_uring_unreg_ringfd(void);
 const char *io_uring_get_opcode(u8 opcode);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 46d9141d772a..78777bf1ea4b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -556,23 +556,10 @@ static inline bool io_allowed_run_tw(struct io_ring_ctx *ctx)
 {
 	return likely(!(ctx->flags & IORING_SETUP_DEFER_TASKRUN) ||
 		      ctx->submitter_task == current);
 }
 
-/*
- * Terminate the request if either of these conditions are true:
- *
- * 1) It's being executed by the original task, but that task is marked
- *    with PF_EXITING as it's exiting.
- * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
- *    our fallback task_work.
- */
-static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
-{
-	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
-}
-
 static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
 {
 	io_req_set_res(req, res, 0);
 	req->io_task_work.func = io_req_task_complete;
 	io_req_task_work_add(req);
-- 
2.45.2


