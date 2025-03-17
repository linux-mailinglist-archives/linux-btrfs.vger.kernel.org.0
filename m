Return-Path: <linux-btrfs+bounces-12330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11A1A6521A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 15:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006163AF9D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Mar 2025 13:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5DB23F397;
	Mon, 17 Mar 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="kW9T+5q0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFB241683
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219879; cv=none; b=mb6OpZ63hmbOfr+4d9mC0TgB0kQDJKCwZGjL1A9c8/S88Obnp6MmuPv4GSOexooIABvbchPs29Jv1z1BspoCWoICZbJgB2V4NPQ7p21mVMLVqwDJYQN4sQS6LsvXlSrSyF1FoeZYERjs1SmnYoD2PZfUO4vBFq5DnKF9Ee1fl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219879; c=relaxed/simple;
	bh=A9g/LrEtdhtW/MmP/tsNzLw+P7Qu4pr41B1T0nC/w3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1IOhlp33EyPN1GYLRS7FoRs+uSA4RnbPfDqZuDYba9keePAWu7/9qI7Kc3vf6xneCr/V2gQUS2Q50luo2/dDXViNwD9xQdGBc6N9bbC3Crtegtznc767OeT04bkGEuipqHJbm+7z5HvrnhKvDbdHAbb1xzQ9o1xbX6i9/0PMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=kW9T+5q0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so4197314a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Mar 2025 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219877; x=1742824677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpw7J2fiIuJ4upLXrHzc6RkW8KJ4iba1XK12Qdwis60=;
        b=kW9T+5q01cjNBZEQFQCCuboFl05UUxo87H3V6shasojD2qt0zQaSL5tF4lS1YryZdA
         wy3Mv12DMmLuXFgK+ZX5zBbcSWeXAVtCiI/iTbkFQL9ORjobkBYJVR2ZgkgFbSXvLCV3
         zTlNHzDTvBlBihYXGumIswzjH7aGJprN8HeCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219877; x=1742824677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xpw7J2fiIuJ4upLXrHzc6RkW8KJ4iba1XK12Qdwis60=;
        b=Neefv9JVIagdDSCNOs0DeibYLLJCNjoJRY3OP1DRAKVR2YxWne/WbBfClDecL2q/vS
         wTjlXUEF2GwUzSfL4xwWjZGyyr+unKtgw9C37hFOXTAOfzWBFaI0OUVogZN5EeA8W3Qm
         y3AwP7NTmi0MPmWEWXaKwKeRx3rqsR1mBVShRfWOQcZwlcSxBpNLnBKnupXwuL1+uIKT
         HTlEXxr9PYmGbiK2NM8cgzgsLA5Pt0e8jRnPkvrmWw1Wuj2XgWGOdJ2B+IlQ1ZEO05cP
         SzlV/1U6IwtznQFL3JMxw+CuBHj5ZVRLKaCKEkCMcjKtXQyGkESSB4kR72ox33EhUurr
         cVTw==
X-Gm-Message-State: AOJu0Yydl6jciFA4SJxHy/nvmsNHHZdg4fK/q/YEQOgeCN8rrRHwRL2g
	geJF/HqP4ZW9Dq8CL4gDMV1vUtjgH99NLoCUdPvQpkYcQWcuVmc1GyYZw3Rb1Ws=
X-Gm-Gg: ASbGncvtVbZcV11EYvZPbP9BieN7vHZF5eq7o5vo4r3AMLKTBhkNLsRgHPhSN3CXT2U
	GgxGIvK5yu0WkZ0vPMzYqSecEDzl/zsYo1upLVCjukhnjprOCQFrWf3p6Uxwo7RffXYHZXmN0O8
	Or9y1mXLPpaq/i3pYqoT2KtnoBxK+iqi3uCAIpUi0RG5i60a2Ny3Ao2Im0MIoZzQ3h+Z5W/94Nw
	Wh9FSrlmAn2ZMBqynv8fAYJQEB3msvFwuhMZfDxl8arm8LXUZB8c2GW7if5zC/wC+OripT7GqGu
	fqTaipl2ZCrMb0UVvLPoPqnw9TREpnxiTrhgiU5zFjYygJcuAKX5S+rairNCTt9uuyV1hYmdGty
	UkTxMnZTiVg/O0ek=
X-Google-Smtp-Source: AGHT+IFP2188UAaoN4VlSu0tKYL92dtV5f8yHioDJyjQGx6rjRnXF/au3otxmx+1j694si5SwniPrQ==
X-Received: by 2002:a17:90b:2cd0:b0:2fe:b8b9:5aa6 with SMTP id 98e67ed59e1d1-30151d8182dmr14008918a91.31.1742219876874;
        Mon, 17 Mar 2025 06:57:56 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b99508sm5993742a91.39.2025.03.17.06.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:57:56 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v4 1/5] io_uring/cmd: introduce io_async_cmd for hide io_uring_cmd_data
Date: Mon, 17 Mar 2025 13:57:38 +0000
Message-ID: <20250317135742.4331-2-sidong.yang@furiosa.ai>
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

io_uring_cmd_data should not be exposed for drivers to avoid to be
abused its private fields. io_async_cmd is new struct that has
io_uring_cmd_data for offset 0. So driver could be use async_data as
io_uring_cmd_data as used before. And private fields would be added in
io_async_cmd.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 io_uring/io_uring.c  |  2 +-
 io_uring/opdef.c     |  2 +-
 io_uring/uring_cmd.c | 21 ++++++++++++++-------
 io_uring/uring_cmd.h |  6 ++++++
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5ff30a7092ed..513f036bccbb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -335,7 +335,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 			    sizeof(struct io_async_rw),
 			    offsetof(struct io_async_rw, clear));
 	ret |= io_alloc_cache_init(&ctx->uring_cache, IO_ALLOC_CACHE_MAX,
-			    sizeof(struct io_uring_cmd_data), 0);
+			    sizeof(struct io_async_cmd), 0);
 	spin_lock_init(&ctx->msg_lock);
 	ret |= io_alloc_cache_init(&ctx->msg_cache, IO_ALLOC_CACHE_MAX,
 			    sizeof(struct io_kiocb), 0);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 7fd173197b1e..e4aa61a414fb 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -416,7 +416,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.plug			= 1,
 		.iopoll			= 1,
 		.iopoll_queue		= 1,
-		.async_size		= sizeof(struct io_uring_cmd_data),
+		.async_size		= sizeof(struct io_async_cmd),
 		.prep			= io_uring_cmd_prep,
 		.issue			= io_uring_cmd,
 	},
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..e4cd6fe9fd47 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -19,7 +19,8 @@
 static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	struct io_uring_cmd_data *cache = req->async_data;
+	struct io_async_cmd *ac = req->async_data;
+	struct io_uring_cmd_data *cache = &ac->data;
 
 	if (cache->op_data) {
 		kfree(cache->op_data);
@@ -169,12 +170,18 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
-	struct io_uring_cmd_data *cache;
+	struct io_async_cmd *ac;
 
-	cache = io_uring_alloc_async_data(&req->ctx->uring_cache, req);
-	if (!cache)
+	/*
+	 * 'data' must be at offset 0 to allow casting io_async_cmd to
+	 * io_uring_cmd_data in io_uring_cmd_get_async_data().
+	 */
+	BUILD_BUG_ON(offsetof(struct io_async_cmd, data) != 0);
+
+	ac = io_uring_alloc_async_data(&req->ctx->uring_cache, req);
+	if (!ac)
 		return -ENOMEM;
-	cache->op_data = NULL;
+	ac->data.op_data = NULL;
 
 	/*
 	 * Unconditionally cache the SQE for now - this is only needed for
@@ -183,8 +190,8 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 	 * that it doesn't read in per-op data, play it safe and ensure that
 	 * any SQE data is stable beyond prep. This can later get relaxed.
 	 */
-	memcpy(cache->sqes, sqe, uring_sqe_size(req->ctx));
-	ioucmd->sqe = cache->sqes;
+	memcpy(ac->data.sqes, sqe, uring_sqe_size(req->ctx));
+	ioucmd->sqe = ac->data.sqes;
 	return 0;
 }
 
diff --git a/io_uring/uring_cmd.h b/io_uring/uring_cmd.h
index f6837ee0955b..f3593012658c 100644
--- a/io_uring/uring_cmd.h
+++ b/io_uring/uring_cmd.h
@@ -1,5 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/io_uring/cmd.h>
+
+struct io_async_cmd {
+	struct io_uring_cmd_data data;
+};
+
 int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags);
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 
-- 
2.43.0


