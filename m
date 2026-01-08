Return-Path: <linux-btrfs+bounces-20295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F02FAD05E46
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DE7B3058A15
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 19:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7629732BF26;
	Thu,  8 Jan 2026 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8tHwPyt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863C32AAC5
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767901508; cv=none; b=jLQe5kCGboO3ZGvqss1m3PNXkBblpTBbFo1UuMN0uwlUtjGzOlEL4JEH+8Xh9RUTTAeySI9V3uhgnWgBzzG8bnCm+aEbDRr+MmosGRwLiD+tRuWRaPrL5uoUl4mR+M6LIsUHIwlaojRPXUdloxgyw65vrSLL4IeDuYuh1r9eA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767901508; c=relaxed/simple;
	bh=eAVXXyiGbN3gTusm+7x6VDyeyT4fFgfgDOvEzLPeHHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XNxQwwwKmNFkHBvFBdwf36v8dpC/l54ua3/lmyp7dP9lpP8tsmK3OuD+Q4MT3uukYu+28GLMedAWeAZdAn8UJocWpEGWiGzSMZkdSkfjPzqlAGx5HrJm9RYvrcDoPaa4wEmZWbVVBXm7vw1900cmK7xvkW+KKU1Of1cL8znxQzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8tHwPyt; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-64760131fc1so478442d50.2
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 11:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767901506; x=1768506306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zo5T6K6ayd5ZE20he6Wo4qsE1omj9FzcArZuU+4F42I=;
        b=P8tHwPytv/qzJX48vxDbJMydLKv1PEBxl1fTy672cixJAo0KyqjKkmB2+btUzNxT5F
         Rlsu8eWYJEtgl3TpwW9xut26S+ZH7Axhrltqi+TZqTMDAhcIsg2fDV2xt0yLqniRL/qq
         qDrVwvvjbkNCV+HeV7fCTClLm68QFCSFc9iOdkUrYxd67WxH/RwS2/zbeT5FyXhQCSKJ
         NhpIkCeIaykxRV1EirkEFPN+dsjYoBYlqq1qqZmFjqXRw0QWxYzZNlbiAikGBhckVgGU
         mbvI/jKw9VvuwW/6NaNWUETcZZSxsL/Zc+lrntEI5n4OZ98+T12vLSRwIVWA3KAdFLAx
         F4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767901506; x=1768506306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zo5T6K6ayd5ZE20he6Wo4qsE1omj9FzcArZuU+4F42I=;
        b=PGSyySLlYtTGRuS8Ph/5wZnMlQFXqeiHHcpQ59LV99/ld1bxGNDq8L0P96BJ+FABnm
         /7Rb8PRIVNVzMGR+HYCaOlOZaotL/FrOXc//Rl/qslqZARgEnlvYxbJ2Su9VgVnohS2a
         UoJQ3G3HHcBohHqLMRn/Ungv4ITvzLl8Xds5UXO4w+MInDLLiN8xwszuMdH62WGkS+r0
         EAL87N/chhDLnULTbGapRkjxm2mA7LX71L8/B/ka7EnWW+8t9FQh2WowQSjtxGFmN2a1
         R7HGHNuHWZOl9fPXH55NqF6qYbZJP3zCyhcBm5PJqUpSShv4f09CnizORmvcjMmjXnAN
         /GSg==
X-Gm-Message-State: AOJu0YxczxGWAKvdpGvSCBQ5aJYiy6XvnVaiqIilg3E4/DPz1cz5avAQ
	mJqYwNRMYozodi2IENEYO2CnJ0eIPL+M48gbZmQ05kLVotEa6BC9J7Td
X-Gm-Gg: AY/fxX6PgbRFjFJ2k29hLHSykQgn1PtPHcgkl2hzwPpSCid9iGvyPh8AETsJ9Tm87Of
	Hb1AG5H2pSN7qp5zFrzSyYB6qLIdWn+vaN2syOIkzLhFHLh26TD9j6P8wZF1DcTLarZxao5cSFS
	yKBrPT5fmyUEUBpqYvT2Bi1EVZQC3BIDFRHxF+lXob0Nri3qetQtTP7QW31g+MqiiUTtbnHkNZb
	3hEXOBQVNNsL/7BDFN4wd0t17NTaQEtCxFozDXYfCBAq8TM6jZYC78yfEnkgO8ekq7VgzDja2IT
	QekhYEN3GEDq93lF/Re7t5PVgWZ10UMPOiDpiLIAA+nS0CgtFRkCYiZzgN6uEOkxgA74bR3I2mO
	Xa3jnn9wi4xbg8thDHh3oMGbLuFt1Kx/g+lxDJF+gCAoBAhAJW1o4Hs9/YBr4+sLretGYzROu7A
	wYnHQC86Q0qzphELRwDKjLfvbnnVhh7j0L
X-Google-Smtp-Source: AGHT+IE3UY4+w0Ahx9+y2qVFAJb5T0udRQIuPVyTVXULTkItYhhorY9Vi9pr50wpMhWj4BWeB3PF5w==
X-Received: by 2002:a05:690c:30c:b0:78f:a81a:6f6b with SMTP id 00721157ae682-790b5800c9dmr151764697b3.32.1767901505782;
        Thu, 08 Jan 2026 11:45:05 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a3969sm32752087b3.43.2026.01.08.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:45:05 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: add missing ASSERT for system space_info in reserve_chunk_space
Date: Thu,  8 Jan 2026 19:45:02 +0000
Message-Id: <20260108194502.653-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In reserve_chunk_space(), btrfs_find_space_info() is called to retrieve
the space_info for the SYSTEM block group. However, the returned pointer
is immediately dereferenced by spin_lock(&info->lock) without validation.

While the SYSTEM space_info is expected to be present during normal
operations, direct dereference without checking creates a risk of a
null pointer dereference. This deviates from the coding pattern seen
in peer functions like btrfs_chunk_alloc() where such returns are
validated with an ASSERT.

Add an ASSERT() to ensure the pointer is valid before access, improving
code robustness and consistency with the rest of the block-group logic.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..f4229ee4f573 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4313,6 +4313,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 	lockdep_assert_held(&fs_info->chunk_mutex);
 
 	info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	ASSERT(info);
 	spin_lock(&info->lock);
 	left = info->total_bytes - btrfs_space_info_used(info, true);
 	spin_unlock(&info->lock);
-- 
2.25.1


