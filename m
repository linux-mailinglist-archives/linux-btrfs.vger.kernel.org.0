Return-Path: <linux-btrfs+bounces-7549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8A960750
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 12:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23551C22AB0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF1719E80F;
	Tue, 27 Aug 2024 10:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhN5J9Ym"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D419D894
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754078; cv=none; b=EHES6/PRpQHg9TXKjB7qxCOQsn3ioDttEZ9bkn3SKLwd/i0KaBJhs6iNAFZSqm+HFIJ6eUYzqgB7On7qQRHIFaWgGujGZMlK2X1MAqwW3Q5Ext26uOVslsTJAlu+hXxx7M2xdZPT9caYsmOlk50YgEVrrWq+QTCxW5+QApFOL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754078; c=relaxed/simple;
	bh=WpkEbJXN36l/+w1BQOU69FzZ4FVKiYj7MJY7doQoJGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z1xJCNuX+jeDJHQ9yA/H2L5fxfkioC+8BwQSwbUGqucsxMKYc8lrQlp6wnkOz1lnFrLVUSI6MPjRKP6DNxy1JQtX+twB0AFkfXjebOVyStLrZMW9DmEtMRWUx3nNwYfY4QQsZDY3N7UKoCLLILcIidfPgvez65CAhDOjtH374Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DhN5J9Ym; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7930179a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 03:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724754074; x=1725358874; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5veQCoN8lYQBQJD74SRhygXarb8IsubhyDY9LmHaE8=;
        b=DhN5J9YmRY5Q9YoG4kQjrRIcsppKQME509CjTpkFh4nl2nac3hFv+RN1vKCz7Cmr+W
         wIPCTQWwPJqUJO5Zn+pSm4wCIdBP2s/AquB+5zOjD4aXI2e1qzfcNoKZ+3q5WU5R5O2h
         byxLi/gukyVTLoU4KTQPVg8G3RXslWgtvHdROsSWNc/EOKHLm4deRyqDAWdKP+8W1sTA
         36G18PW24493hYtUOubFHWief1aVmwZGYNsaf4r2rtSDPiX0SM+GwMaTGO7BKsi8If/8
         kKn0fXJNojyDyN6UBntldKtGLkzfzod/bqryYehgTywcIEG/KHgDDUwzZqvTlpL2hNts
         1v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724754074; x=1725358874;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5veQCoN8lYQBQJD74SRhygXarb8IsubhyDY9LmHaE8=;
        b=mVs9n0j1dyBzKHh0HTEaUZyeYDHJnoY7Cge2y7givdoJ2HO2slt/Kl5uUVMGk8AyYS
         SmuLTqILLHB/gOf/ENEemfFC2nRgBvGHH04+/+YptLY01QL7IKepr8AQ3l5DrFmGUpQf
         akSyjCFoZNV6+z+0/xfp0IFh1ZV7bu+ovdVHdLlq3NxffOda29R50w3B9RfPR4FAneDB
         iED0wFl3IyZ9omRqs7AR3Q2xBH4rS8DZmt0TMtoCgc9U+z79wN6RqoIdUJqimtFrugeX
         UjS/UfN8VIPquEqyHoZDUDy4tp4FBnGLFX6n0Vo5llIekCS1s2DESy3Mqg1DoUnCey0Y
         Rllw==
X-Forwarded-Encrypted: i=1; AJvYcCUg+H/AFpGRs5NFgEXuZWSOM3gCp1HalZEhtdM7HuqNIi0tvPjLB1zHeliUnHpi+SkBouP3Y2ixPuNN4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzswaotH+eJQBR0Yhw1V8rlvNCzkL0SzMXuyTer+X73CObJKSd4
	NH+sRYV7XJH06zYuATI2n0c1jAXdYjiknUx9aZFkz5zlYyBP15+djoGxIOdnrtY=
X-Google-Smtp-Source: AGHT+IE3u9uTSQrOf4wWogLmsvncGtloKgibZM4lvdiulZe+XAmFxDCcQwrH57K4f9IJ0qqGDj8VOQ==
X-Received: by 2002:a05:6402:1ecc:b0:5bf:38:f676 with SMTP id 4fb4d7f45d1cf-5c08915aac7mr9644088a12.1.1724754074115;
        Tue, 27 Aug 2024 03:21:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4715b0sm832135a12.62.2024.08.27.03.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:21:13 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:21:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] btrfs: Fix reversed condition in copy_inline_to_page()
Message-ID: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This if statement is reversed leading to locking issues.

Fixes: 8e603cfe05f0 ("btrfs: convert copy_inline_to_page() to use folio")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This patch is obviously correct but it's from static analysis so additional
testing would be good as well.

 fs/btrfs/reflink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 1681d63f03dd..f0824c948cb7 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -146,7 +146,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	btrfs_folio_clear_checked(fs_info, folio, file_offset, block_size);
 	btrfs_folio_set_dirty(fs_info, folio, file_offset, block_size);
 out_unlock:
-	if (IS_ERR(folio)) {
+	if (!IS_ERR(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-- 
2.43.0


