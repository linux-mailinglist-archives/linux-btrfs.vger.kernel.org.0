Return-Path: <linux-btrfs+bounces-18480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91FC26E96
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 21:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ADA407E10
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE7329E46;
	Fri, 31 Oct 2025 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BHzRCFab"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f226.google.com (mail-lj1-f226.google.com [209.85.208.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072D328B4E
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 20:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761942882; cv=none; b=bi7WzmRaZBpCTX2aC3qSlBYMhLDXn2cAHBnZrPcSQKzvUPMQwPcq3WyRBHbAiP03KzRRyAfGzINR20CJaxPvCrY9hI6f42CpykcD+mOeNTQV9TRfebl80RGPOGA2V3p7ak85lVGb5SZ4FrcT4lHyaDv/e4MoKk0nHtmYATaW+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761942882; c=relaxed/simple;
	bh=C6whxhY2k5fPAXSikyioIezH+fO5txoMclXOMXtXotc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxcKVRTI20JC4LsrALKcJF3SN9NTO2Cik7cXj8vpPBFNmfUH025D8LYnw4FqmBS9ypRC+EmioOl57qxwgJhmnsmjF4zC3mNc/sAm67AHCzmt9QiYpwnIhhq5BKaT/awaefT7+jEeCZF/xNQY+m2UKzC3/vxMIy/WHzzBZCR9/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BHzRCFab; arc=none smtp.client-ip=209.85.208.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f226.google.com with SMTP id 38308e7fff4ca-378debb4644so3860031fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761942878; x=1762547678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=BHzRCFabhiAWethpTxaoampQf4oPL+XouXKbBZxEG8mFL1FqS0EF9jpZN9UQ9wgzoK
         OZNRYic/S9lVXkZF+GytR7vTTrI/3+WOcb/nhJ1KpaRHfMaDUXuvOe0ncwLthQxgJWHK
         802pT0+3ovV/QNVTFvhTCms70QWPuaIXoyqkOTKNz4gSCc7BDLIReCo5noxgqf6fFK8f
         heqDvTywyL84V7XzxDYd9n/Jr+jrKlZ2YFR7+8ssV13ZkpSYevogr+pV+0FNNDU1zb86
         PkTWXQisezVYIfpyBCDOeYp2of0/y/mE2LfKODuUTdZQVDVjER8KDWxli54z8W9rrP7C
         hQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761942878; x=1762547678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI0qy1HNIsZ7APXGZu2HBwOodYb4++mraqK0FOunMAU=;
        b=Jg8cSSNb7M3gYc/wcR+NfjsiBxf3WWw5G7zHfEPkZNHZo3nj2EWI4eQHTjB8Szl33n
         JVxj7W4dEbLZHjJ5MVO6WsoMBchswPg79xLh+346CS8BJshV+7E6wwvnmuEEbVVhj0Vl
         MT3R5VtRmixep2c3F+W2tVQLVlpWFcLOqpPqQ+B0WuUkjjirwvoZbuXsMUR8ot/Pfsbq
         tODmTnx6NcdcoTRGtexkNiyQ9Ht5hkQlv/kBkBxinW/YDQNIZCGHgvxhHq8VgRFxVpN2
         3ZEan2m0kUpRABa7WdSUzmu1Ln7W7GSYXLWBkGc2GLMqYQ6XdrcnxaAfB36odP9Nd4+o
         pFBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQzamlG83GswQ8mww7WJ1rCFmYi0CZwVd04zzGJ9r8QSsZ2OyheSgURDTRaRDrugvN2satOI0VHfpv6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLyrrCMGaHlfg5wIB0NnbBR5XVDu8abUALh6C5svqqVdoRwy1T
	yJJN2aSpkeVhvQHYV/1FkFJFFAM+ULUoyhc01AH4EHcYvEvP2K8IB5IX6mWsuyseuO14PR4A19l
	LF0SaRgzRroaUSWGtboW4TzMjJddwKkEqJI+oTrWrbCRg7byM9AdG
X-Gm-Gg: ASbGncu3dLbjuAKhzwzvcklBrCTF3hJc/r5HjfOG2O6+5TyplWmSfLY4nx75a+/s5s7
	rfY+0TG4MAkOCs5X9Rcr+nZgSTXeJ6+pS74Ed/ws6PZ1LO74C9qtYrzt73x/moE6KvEdAK9+ntr
	aLUxypV3EKwCWOVSBPN6aXe+hmjjldJlwzUGLFViP8p+ML0WoxmcddEwhcYREkw2NsT+IIBPtbo
	aMey9FBpCx4GFdftnlR5z9FoB2bgUbiESzScN0oyYTmwPwKbXEABSC6gldN6eGv0E+A4Wj4fXWT
	c88WbaYrIEyT6DMMRDjdfYs9NO0L6r8mjaQMTt7XrLv1QGfhwqgMyadXFJF50vt8Wrj7etUignR
	StEztkIqBbhDpYdmV
X-Google-Smtp-Source: AGHT+IFkklfQMtwtYHctUmXUj84xAbmvWB5viNqygwZDDgD7B4MpJ/ProRXWufuferuOhixNh09lD4F7KOks
X-Received: by 2002:a05:6512:4025:b0:55f:6637:78f with SMTP id 2adb3069b0e04-5941d5539bdmr914999e87.9.1761942877597;
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5941f5b5c33sm282549e87.37.2025.10.31.13.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 13:34:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DFCEB341B91;
	Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DA9BEE41255; Fri, 31 Oct 2025 14:34:35 -0600 (MDT)
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
Subject: [PATCH v4 1/3] io_uring: only call io_should_terminate_tw() once for ctx
Date: Fri, 31 Oct 2025 14:34:28 -0600
Message-ID: <20251031203430.3886957-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251031203430.3886957-1-csander@purestorage.com>
References: <20251031203430.3886957-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_fallback_req_func() calls io_should_terminate_tw() on each req's ctx.
But since the reqs all come from the ctx's fallback_llist, req->ctx will
be ctx for all of the reqs. Therefore, compute ts.cancel as
io_should_terminate_tw(ctx) just once, outside the loop.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93a1cc2bf383..4e6676ac4662 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -287,14 +287,13 @@ static __cold void io_fallback_req_func(struct work_struct *work)
 	struct io_kiocb *req, *tmp;
 	struct io_tw_state ts = {};
 
 	percpu_ref_get(&ctx->refs);
 	mutex_lock(&ctx->uring_lock);
-	llist_for_each_entry_safe(req, tmp, node, io_task_work.node) {
-		ts.cancel = io_should_terminate_tw(req->ctx);
+	ts.cancel = io_should_terminate_tw(ctx);
+	llist_for_each_entry_safe(req, tmp, node, io_task_work.node)
 		req->io_task_work.func(req, ts);
-	}
 	io_submit_flush_completions(ctx);
 	mutex_unlock(&ctx->uring_lock);
 	percpu_ref_put(&ctx->refs);
 }
 
-- 
2.45.2


