Return-Path: <linux-btrfs+bounces-4811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF2B8BEB47
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB341F22202
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D24216D9B3;
	Tue,  7 May 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wchxbVuB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9904E16D9B9
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105556; cv=none; b=E5ZFRgZPm1tgtJiEmNE7GGZBONGqnbcQFsA0GkdNorYm0+h321oviG7tJtPimpigBI1MFrT7vHlVnW8VhwuiozxutanOokGxYLseRyq8uhEkKlbo5vATwSHkVfmsySvfFr/dUry2Mxz0W/V6KIr9IqvxcxHc+7tbz1DiRMrs/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105556; c=relaxed/simple;
	bh=eNn8v4yxlSxXI5la1doDYCLdN5AUq9c9Go4aPSjyOB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1vrw9J2LOjlR38r/OEblxFLQpmrV4zxMUFpaonR/NRAGdvG4wwtZQoBF/qvF2yNvCi0+7RtMzKrliw17kPB14MR+I2GaOi16YZUSxkcCKfGPCbbZMMRhRlu6q10hpFA4kBIJyPdTvKpCfCOwqYBCjhWVvLOYlpaFmbapxgV1gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wchxbVuB; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61816fc256dso35570257b3.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105554; x=1715710354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kd9anvl2wwYVLNkKNpL22YqkpY4M67UnyZ3hqVkAdBI=;
        b=wchxbVuBx1HUR4yFkuv9AbCbsl86cEtofvEJ30g1xZ23AXNHpD9wa1y3MMej07SsVZ
         kUgE59GHU6YYg0OiJghmzehVX2t1rEJ23LKtCY9dX4X1dFIuI/BZ75HhtFx3g3Pdx2zP
         Q+k23QZ4ouahKSV3vPSbkrYa7PuuUoMDz/F4QsM+9tFKpAsuAItMhmH0H0kfbAoqMI0B
         2G+B8e7BPSBYfYvfcFyQL/cxYwpgXy0zGTKwhQgrI/LZlMIHBSpI0qkuVungnZ7AGa2e
         qhD1cMUE2LCHWQuefWqw3NPiWmjS4BHLYQUIfnngQnEMp6uDFePd/KZsoVa6m1PshI4p
         tj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105554; x=1715710354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kd9anvl2wwYVLNkKNpL22YqkpY4M67UnyZ3hqVkAdBI=;
        b=T5Py2uDukRupNaMHXmbHKkHPq3guipYhBaAqWRU9gnEmsUUwvNpYZzhJtkVrltYS9Q
         RTRc4JzwkH7AkluBC2sDwAn9clYgGgLF6AropATNygtysnXabi1/yoGI+OSen6s1Y5/4
         8Mg+tfWjMrE5d4ngx9moD878K2Uly55llTeKLwlCxtc/G0jcF3e7lK66A2RLB+ruBaxR
         ojV4S3DUYGjrlNxAqn/RAB2GK13227wERyI4i82QSmdTXPg0K+7j9WuSMFPdpTJGpkCU
         fJJhbc63MxXpFJgHxdD95Cffdb/vEYTmlNdu5H34WDjpOC/3LoFV/VSsWOV7YZXX8leP
         jZEw==
X-Gm-Message-State: AOJu0YxDFWRlClucZWQ6GiNbpViBQ9jNyH3M819mf4SHZR+Rc9E8D7ia
	PLpIObzytCLa15g52eWcpmkvpPXegj4VEUBGRZAuWKXBmtlB9wukSVmYcxSl/loBiHae2E/Y0o3
	o
X-Google-Smtp-Source: AGHT+IGPO07J2cYuP+DVIy/9DzfjBPsmmDYrtouW66iNmITWsRF3/7eEnZOE429xw7Ob5G7RWSsCTg==
X-Received: by 2002:a0d:f642:0:b0:617:d384:6135 with SMTP id 00721157ae682-62085c48a9fmr5964117b3.49.1715105554558;
        Tue, 07 May 2024 11:12:34 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h124-20020a816c82000000b0061448978753sm2831111ywc.41.2024.05.07.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 09/15] btrfs: don't BUG_ON ENOMEM in walk_down_proc
Date: Tue,  7 May 2024 14:12:10 -0400
Message-ID: <20201dbb319e76335cae0969ecd4981a9fb8d696.1715105406.git.josef@toxicpanda.com>
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


