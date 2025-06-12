Return-Path: <linux-btrfs+bounces-14617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24282AD66D0
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 06:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B817C9D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33301DED60;
	Thu, 12 Jun 2025 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daC7r6H/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829191A3A80
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702843; cv=none; b=eVB3NsgGq2jihkMRQ/IMea7wjYwyVnf78p6t6EmMkU2/2pgnMExoqffOcnzQfd05FeWMnv6LpnqzGG+Ls9+e9AYqzOk5YTiDRZM4za2rogKc+lsla2rt25ItEPbAgQOJiu5Z4YFoyiVrdDEEyGJL5FPwk0u42lt1wdcMGVk+FC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702843; c=relaxed/simple;
	bh=a0J5FM5FInlTTARcCu/MW+JI79DdSrxyT416MuEVhHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7WjD0YhFE3FO+9l2aZBOVIjeaLbkyKtu4d6f3nV/nG1g8YJ51ACVCvsjCl3v8JgpXtco8GkyW2z7dLpDvPwY7yDhBi7E6rBaZRRlAFGXwvjKkeoUfvEqgb5FvoOEZ2w07tbM0Pj0ILH0nRL8SYvJDeVpDrCixedpbuBr2ORSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daC7r6H/; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-7c5528c98bdso12095585a.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749702840; x=1750307640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjRchHqQtQDIlaKrpdgu4UxE4CSCYXVdaSzSROi/cVA=;
        b=daC7r6H/Lq0n9DWXv6DMbWYa81OoiWiSSKK7o/YblboankhVGTujfeRu1YxRin5eY2
         2h1353frvbKsXOBFJa9HAJweywPefu+bN2/FchX4BTFXHodi61uc/Dwm1WLnWcJa22C/
         QuZOcq6gAN1aIOJF6fvoI4o77ehoRKU/eaq5WqOlh6cvub3bOJ0U72gp7ADzugz2IEsP
         WzbM7DQyMUwCc3eljfjHBZYlj1/TUcxLQ2a6YM1pJotDNbg/Ab3dstWD/SrWYJs7c5a2
         wr8Rjw2YNj2fva0OYttXrjJGw8kF21z0ymEW87nFAKFx1CEpJ2lPUDNxzx9Pd4jWONbO
         pddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749702840; x=1750307640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjRchHqQtQDIlaKrpdgu4UxE4CSCYXVdaSzSROi/cVA=;
        b=ADggYjxAnQkqKh/Nq6MzMnC/W/cB0VqXXExdeXA96Ur+B7pcs5fNf3lxm0W7C392Mc
         pfWKpHzZZlq4U4fT6yuXkJqzD0fPkomtpSGjVhn4HBisiUzbzDfr3qQa9CGTMQW7MfMd
         iVUhCoYGPk6iTs0C0HbpvuwAlkcswwR8vtbrKwuFsst1J7rYsx9EEBiu+k7whgXvl4zw
         rW/3fxdX9hemcrASSAZE6N5DqK7Ox/pbNNHhTDtmsloeWb8BdEhsENkkK3C7SzLyvLkD
         fhda2Pi4d8eKTVGonNN7NSIIJYesNqr6QSeNHl/i2oFFZP1nlt8RyKf/KorkXjq6nj9d
         mNBA==
X-Gm-Message-State: AOJu0YyK/7vFjl/oRiXecwHPXPp7IyR3k6t/mjiKlH5/2FXh171ELyaS
	r/Q7iRipLJn2SL4mVbBthM1i91iZU17tx6JgPTxBI0pTOr+v3jIon5TnSDyOzAtxUFdIBw==
X-Gm-Gg: ASbGncupNImrdnWeSWPQ6eD4O99Ns8tsilLwnRBAJ1XA/kx2Y/my1J7xPvnf2F8mz2H
	aNhFugNYzcKxBlwGZkplM2iRI9lwwpI8Kgr3VeNH4PNXy9SlVmjdsuUv7uPNLmwsSgfYUn3ZuIE
	2VCxfUaqLfkgdaToYyMNVVb7OzYC3/+hztsQd3UORnDDhhM6+yXuUkvb0aR3E36EvSwkbWowBJb
	KoDOXYcmNbvZsj4x2xLRrPWgERP9OdEIpLiOYRGhBeEM1KssMDfTQtJtHsIo8/ds0bK1MDRR2x6
	Dgf2gQsQc37vJF1wGpnfEda/H90VvK5XUR8kL74rklzFGSb/z75RsZOXaqQhIw==
X-Google-Smtp-Source: AGHT+IHZd15R1lbXYt9Zu+Vim0xV5/iN+WFdNUFaGwpVyM4Rkt04lbca5rdA/ZecKdzHDcGjVe88xA==
X-Received: by 2002:a05:620a:400e:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7d3a883eeb4mr324857285a.10.1749702840379;
        Wed, 11 Jun 2025 21:34:00 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c42a28sm5524836d6.83.2025.06.11.21.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:34:00 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/3] btrfs: early exit the searching process in search_tree ioctl
Date: Thu, 12 Jun 2025 12:31:12 +0800
Message-ID: <20250612043311.22955-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612043311.22955-1-sunk67188@gmail.com>
References: <20250612043311.22955-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the following two assumptions(min_key and max_key here is the
related fields in search_key):

1. When `btrfs_search_forward` returns 0, the key will always greater
   than or equal to the provided key. So the function `copy_to_sk` will
   never be called with a key less than the min_key. So we will never get
   a key less than min_key during walking forward in the leaf.

2. When we got a key greater than max_key in current leaf, we will never
   get a key in search_key range any more. So we should stop searching
   further.

So we can safely replace the continue with early exiting. This will
improve the performance of the search_tree related ioctl syscalls, which
is the bottleneck of tools like compsize.

I've run compsize with and without this patch to compare the performance.

When cache is cold, it's
1.29user 21.02system 0:34.61elapsed 64%CPU without the patch, and
1.24user 17.34system 0:30.40elapsed 61%CPU with the patch.

When cache is hot, it's
1.21user 12.95system 0:14.19elapsed 99%CPU without the patch, and
1.18user 9.37system 0:10.57elapsed 99%CPU with the patch.

This is not a serious benchmark, but can reflect the performance
difference.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ioctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 10c243d32b34..5e6202a417c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1502,8 +1502,10 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 		item_len = btrfs_item_size(leaf, i);
 
 		btrfs_item_key_to_cpu(leaf, key, i);
-		if (!key_in_sk(key, sk))
-			continue;
+		if (!key_in_sk(key, sk)) {
+			ret = 1;
+			goto out;
+		}
 
 		if (sizeof(sh) + item_len > *buf_size) {
 			if (*num_found) {
-- 
2.49.0


