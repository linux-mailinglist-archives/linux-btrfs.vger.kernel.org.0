Return-Path: <linux-btrfs+bounces-16220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC44B30662
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A821D720DA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DF938CFB0;
	Thu, 21 Aug 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XbtCyXsE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C0372893
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807646; cv=none; b=cDInM+nHLB6TXa/bE3IXHOu4UbmuP43miGpBlq3BMEGWOV2KMn6bKPxJIfye4URCzBboDxAvYyZcpghFK1Xai/491l3j07oWGhsXe1STo+uFoggqhDMAFbadSYMSic9vxyOmYpFp+5e/P6PM86rxXsYXVhc/U3w2PZfSaOJvXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807646; c=relaxed/simple;
	bh=MCFryGt8OvI9I73T/3uykYAdJBu4EwKq4BQ7zZxDWuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbaKcXfxCCCK2E28zg+tXA2u0rNY6HF/LzjqcIucNs1oCodmEeC52UxniXMbQeCEDkodslkhB4Sxr50EaHhooeRAOIBSMdW64ocia5KOiVx1oSlSx7KUPQJmPzAXpriXcZEZBd1N8jh5R9Ap3Slda22gyBsAMe1mB3TpTjiX2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XbtCyXsE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d60504bf8so12597897b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807644; x=1756412444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSiPe2GSvHZEVcD4vFKlapaYeiYpuc+3T8lPvcFai6c=;
        b=XbtCyXsEmrWBsd6yDF9IiegwUNgVXBlCVrPUJumMYWKm7MJYHgiOSQhrDwWG76DwYN
         ZMX8+pAhrNnDAN2d9AzJUoQTUVkEq925Neajk4k8/tRVDbFiEeeHFZCYnLmN+u+oh8JP
         CqtSTnWdN8a4ABBbWzDbXBKx9UZOf3C7Jf1Xogt4mPwpIunt4vOSlUa5H2mb2gjxA1B1
         0sN38P91d53XHZkvAjCjcuLmQyM+36kwS9UR3r8AMu8/7EmQ6YZc+nhV73a1IVoN7dh1
         RjaMsoUO8PKkIsPaBJI7EvFq6PUq93VWXeWkZMkt4m0sQEsP5aJBb0OGWzckH+1smCDM
         HFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807644; x=1756412444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSiPe2GSvHZEVcD4vFKlapaYeiYpuc+3T8lPvcFai6c=;
        b=JJbx8/h5EUoPIAQLgIbWz6jke0BRbShHmZ8opPv5T8Ky68s7GIUhFE6rbpoJfcNv5j
         3QAGDxPBZ68KUW9S78dNRP2gMWQyTndbjjbZE98KX7iv0OIwJyzH87UEY2ffcpgOT8f5
         zyLUS8YpJds8B6/ELRir0qEBmD4QaMBLp0hshOuHIVqr22xMP1Cmyv8C5yf3XKBxWOnG
         0A+DU0aaAGI28qbyBNM3OiIkZH4T5dJ2UnbrUBKWMRf+8/1TvpsLvKTenNyStExXhsjv
         0WsxHNP6pqvMXi2+7rUj7NTHOEv8YKLwbhLHDvGPFI6t/EIdx71lGu7fp4msml3pqtah
         DGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWA1dccE+fSul/F3raOiqPExemiK77ZqKvBH/LX4IrlsepU+15zub3wLt7c4E1j/6cKNLpiCPFz56dZbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPEkdFFcafwt0T4HTIhFQjAKyO2CAuquLUXABHThlbN5hcfOE
	+S2T3u/H9G0P5CT1knnUbiRu8mOSeN/TdpGkOFZnL4PlzQ0XQmnM6VDRqymLfy+eorE=
X-Gm-Gg: ASbGncs2G+xZ5iuc0zSjR2Ozm8DJ95Q5+WqQpSvrLtqqXjZIWGXB8Ouk021mqj+0xRL
	KsDt2sJJVNnjwxJr8cEHcrIOtKZCrgtWU3ENOUkUHsaWHkK06SpNK2hDg6LwsrGe50S/QqyM7UK
	3Xdy14eDLMDJOrGngtLZhk3Q8s3bzAzIHzxRpJEqeYJ4BsdoxCee3zy+tngsTqqqFsSDCdKz6PA
	SQEYl3RtHxiB84oB1UNRLKt4eMPkcJ1Os8UDZCSok4A8Ymr91NW5ml7aEN6pmetxyo/nehZr8hH
	2xX1w1GC/eW4FbDJQdiHNE1mesZ+hyA8MBAavffwFczLX+Mu4DeH1cMm8jbvX2cDVPyfsr3TDrJ
	e1lH9FfoCAxs9IR5RCu0z1HA5hMfN13S9QBinziYPoOQUc8NW+hQiLskAyVGizxUsLWZp/Q==
X-Google-Smtp-Source: AGHT+IGDgf7aCeL2nL93909EYOEt+b6G5wwfK4meP/GDmXRwGfXQkKjEhZnhShlvmG9gTGb/wy4z9A==
X-Received: by 2002:a05:690c:6c0d:b0:71f:c6c5:c55c with SMTP id 00721157ae682-71fdc3d1834mr6237357b3.26.1755807643782;
        Thu, 21 Aug 2025 13:20:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e05c0bbsm46459507b3.43.2025.08.21.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:43 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 19/50] fs: make evict_inodes add to the dispose list under the i_lock
Date: Thu, 21 Aug 2025 16:18:30 -0400
Message-ID: <9aacbf6b90ed4a980a49cb4d4eaa3d2fefa1a7d8.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the future when we only serialize the freeing of the inode on the
reference count we could potentially be relying on ->i_lru to be
consistent, which means we need it to be consistent under the ->i_lock.
Move the list_add in evict_inodes() to under the ->i_lock to prevent
potential races where we think the inode isn't on a list but is going to
be added to the private dispose list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index b4145ddbaf8e..07c8edb4b58a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -991,8 +991,8 @@ void evict_inodes(struct super_block *sb)
 
 		__iget(inode);
 		inode_lru_list_del(inode);
-		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
+		spin_unlock(&inode->i_lock);
 
 		/*
 		 * We can have a ton of inodes to evict at unmount time given
-- 
2.49.0


