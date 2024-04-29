Return-Path: <linux-btrfs+bounces-4612-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3798B59F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBF128CE31
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EFA74BE2;
	Mon, 29 Apr 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="kvaYeRhu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66A74BF5
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397408; cv=none; b=ilnoiT+30nZWAPq2lgBu6mxOiHx84nbu3UlrWHh+wLjCbSGSJtVpj/uOCqx1KijuDXUPeYS7A1gpi/4zzPAuVct02vFBGMw2NfS/xgxZDtZo52s9jvf/nRO0980xSDyGiYANJB7WQ9QY2w5IH2gy0GIgX5mMMdQHuGOLmZlptzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397408; c=relaxed/simple;
	bh=eNn8v4yxlSxXI5la1doDYCLdN5AUq9c9Go4aPSjyOB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGSuD+lgUj2K+WrlE79mV3wsvwkjg8D2lT3rrLLauFw8Q3LZ1xYhn4l+erVcDfLffW2Z2NKWQBq/5cU20vfAfZoRYMOk949c+9KpAcLkBTCVBUy2gRI9Z8NGUVGRTYdZEVFQSxssO/KiOu/KF4dGBY/Llm8OOKGZA0GT596KtMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=kvaYeRhu; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c74abe247bso2395702b6e.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397406; x=1715002206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9anvl2wwYVLNkKNpL22YqkpY4M67UnyZ3hqVkAdBI=;
        b=kvaYeRhuUUBHgIsJuCgvWQXpt7WpV61N6ySmAe2sLurkKzaeCO+5BBNLF3ZsUsPXJX
         YNHVKFxKqe+QPrUywugWutIBXoD/HO/hocj9R8Ear78MnKCk9zHmnoIxO5wjRqySf5If
         Z5oupl1h5qM8M3OgINVQZ1UN14AtTCp41eGNYME2loypsDkiM94rLEI0AHVkKBpmHhbF
         jdQk/7ueuqpBJXzuLIcwvSKeuOQxmOeA0WMeSxwC6/D6fD6JV63d6y08Ubyq/8hgINOV
         5+338p4nR/xO+BsbKJUa9sypv/vbuO7/OZteMARVUslYYM7IIa9Ui2XhfNcb5HrmoIoD
         +BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397406; x=1715002206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd9anvl2wwYVLNkKNpL22YqkpY4M67UnyZ3hqVkAdBI=;
        b=PYiXh1waVYiqxDmrXJ1luAC7fz/bFVA/GsJhCUR8gF4nP+YFfkYsSW8KEGWpvfUoo0
         sovsH3minrM2vJedkzKV3qJ1gGjCSuQaCE2HTWAzOIhFVqOdBqOOk9lykQ0h7W4h0Hhm
         CGA0qFic/PsHCWfCrbhErlRHbaBATAfUSpz7GJ8J+yzIXUoMqlvEteOCtZMLTt6gwm3T
         FnFwt7ZKxkfnnp7lIe6wwiE2PkzurOKOOl6M543wPAgupM6v0XYyBIkVT1ejci7xGo6h
         GjHj5+CBIRtnE/heRSr5yvzt8ujk6looznTCSwGP4CndKfuYC5XfiRRa4/VG8IcwIf+D
         ovtQ==
X-Gm-Message-State: AOJu0YyL/JaKt9ms4Ye836NEkRKaAwdfaLFsb588Oz//zFfSZz0Ccr92
	W5wi46k8nfhUfa/flNYEm7dgsDgbeYimQuuZoplnyHxSadmijvI5xxgYXjto1TcO+BYSGB//Qum
	F
X-Google-Smtp-Source: AGHT+IHAZca9vx9FZPZSsIGYR+rq0akydBxUZDAGSJlhgFbrjHxKCZPeX5/TFiopiBpfIuOKUHdj0w==
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr13346004oiw.55.1714397406368;
        Mon, 29 Apr 2024 06:30:06 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y13-20020a056214016d00b006a0d243cd7asm596949qvs.62.2024.04.29.06.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 09/15] btrfs: don't BUG_ON ENOMEM in walk_down_proc
Date: Mon, 29 Apr 2024 09:29:44 -0400
Message-ID: <4a64650a4635ad7a0cd4fcbdb93e4344fe41660b.1714397223.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We handle errors here properly, ENOMEM isn't fatal, return the error.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index bf59e2f00ff8..df3b6acc63cf 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5398,7 +5398,6 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 					       &wc->refs[level],
 					       &wc->flags[level],
 					       NULL);
-		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
 		BUG_ON(wc->refs[level] == 0);
-- 
2.43.0


