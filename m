Return-Path: <linux-btrfs+bounces-4813-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDD8BEB4A
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765D5283262
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6067216D9A0;
	Tue,  7 May 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Y/xKC0Z/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47116D9B9
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105559; cv=none; b=OHvSV9tocwP1SqvzY41DSDbkTRyqO5G/E5K365r9qfMFmM1HwAyI1clOPAxGgUO7wXC2B7uD4xat62qMUsxoW6NsFNfDmwaSOyv4/FJ6ocRY1hhIYrsk/5XNcyIM2aqSEHxPfanbXKyRTJGGuyo98N0FDx/TgNnX5nbBFQA54NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105559; c=relaxed/simple;
	bh=N6k4QAy6YmgIzuBv3UbjkAqckRemx80XpARWAF3yddU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP4tFwfQVrp8jaIeKxHO3jEWvqCji+Jd+5GLVyXh8cjKHDquYAMrkoAy3fHIdsJwUojsr5LxEezcQaYMfaCYN3JWKHVQPdhONIcH27kNYkrMJ9lhmRln329eXEqBUzdpZvCglQOehSf9/1GloOcca872lM0KuBMiAVYjAvDsxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Y/xKC0Z/; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-debaa161ae3so1016252276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105557; x=1715710357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o4E/zlvhEvAwve3wuYe7HKWbPGiYm3aR3FSwzZ5Rb0=;
        b=Y/xKC0Z/vEoy5VBMifBScgKoEf8y0HxmONUXjv3WLqjeDCznEfsy6l8jQQb5eSudZB
         X/HuRtZhZjAtL/3e6fIb3IhSyCxh3ZpFt7XrrYNNI8bzDuWxLJtTuOROmXb0FdlM0UmU
         pV3bQBbwkxpvy/P7QVeLXNs6EEqNL6BUKBT8FX3GiveO/3LHPEk8atFJQ4lrJJJVz1/C
         5TjePgzeGrAryazm2jb7QTXjq8wVtoqaaSPEM4ojlwyShGXHe9JJ2sI2aNK0PV69d9rj
         hGMUrYaaLueLvd70sVpNQufKmv878YA3AOlao1eNXlJz7rDi9BZYZJ1Smfxn/3t5T9bY
         BdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105557; x=1715710357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o4E/zlvhEvAwve3wuYe7HKWbPGiYm3aR3FSwzZ5Rb0=;
        b=cWq55doI7jLbXci9VE22scncHH4jRPbC8vgUXufKrFyxzM9uVhiAv80ZaZPclhAoN7
         PQVceJ6wCu18Rln3srzcbgFQ593nnDy7Eg8Bxuv3iNtgLBy0L5p/pmPIMkEvP8z3MfId
         TevlAaoyQ9tKkxzF8Kjhn1aF9LuBHm+dqxHxUw+22JPFvSc8yWJujjC7kPzB2QqJ8l+S
         oyKE6fxF6S0RWlpQKvi8LJqdV0NosypLVG3OJe1sofAbwcrXYAbpfbKEuQLOLTXdEeeg
         PcM+7HPdWmJJQ0Vq6boTs4vfXT5tSj4QAchohEChApBHAEHTfMpL8vQqXScx1vDOp1PI
         ngTQ==
X-Gm-Message-State: AOJu0YyojgrVarMKma+pd1UbpbyJ/w3f/tstg84iBTeH9JqfS80fZ62X
	c7tG7mm4tYHTiFzlO/eLvcuaV1qmJvPQJCx1+ID1Ch/XT7u8XWt6ZXFwT+lZiHrn21VMH+5aO6D
	/
X-Google-Smtp-Source: AGHT+IFtmPgojqi/jQegEQixsQWUsdrxjCFu8qW32btsyofMk8eQd8Xq+9JE1yR1h1FkWbLSf55gKQ==
X-Received: by 2002:a25:cec7:0:b0:de6:17aa:e711 with SMTP id 3f1490d57ef6-debb9cde0d6mr615605276.7.1715105557186;
        Tue, 07 May 2024 11:12:37 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z17-20020a5b0a51000000b00deb742c5d87sm1464885ybq.25.2024.05.07.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:36 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 11/15] btrfs: replace BUG_ON with ASSERT in walk_down_proc
Date: Tue,  7 May 2024 14:12:12 -0400
Message-ID: <42b7f7ebeff52747dbc1a757751319c818e41efb.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a couple of areas where we check to make sure the tree block is
locked before looking up or messing with references.  This is old code
so it has this as BUG_ON().  Convert this to ASSERT() for developers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0dc333331219..c75a5b3ddb8f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5392,7 +5392,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (wc->lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -5416,7 +5416,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
-- 
2.43.0


