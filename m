Return-Path: <linux-btrfs+bounces-10944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E52A0C17C
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41D218875DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426D1D4601;
	Mon, 13 Jan 2025 19:31:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D01CD214;
	Mon, 13 Jan 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796718; cv=none; b=YCJO5SoLskqK+HoPA8Z3fCiDb1IrRVBJYn0lB5vJAYRBpU+1GpKcyPNb8b+Dr9D6iaLtAr0mBEbqSC0Gf8tuDyLEXe8e8YJ0T7DdCjLo/SKNvMEKnBSVIU1h34eIhyel55IcKP9CetglNj3zFvBcwrGfh9jFJ7TYWqB+HnwlxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796718; c=relaxed/simple;
	bh=7RU977jD6JRAc8nXAQ13ycRxUPQ4S0XJnjV+jaAEk0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RiLEWDL/KQzkLr9cGQp8CiINsC4bAegMHtwMZ21aJEf/14AgaVaajCtn5gfS7iLOxYPOIVNc8CnhSJKcApxJ+QvP2rB5m9FKwvWSsHlN0ynQNX1MqoRdlE7e1zRBYtHQP82FYdZwC+exQSKZJnFAPC8Cr9tn7rU02cvDwtfE/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so49383335e9.3;
        Mon, 13 Jan 2025 11:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796715; x=1737401515;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f7HYuc/zbqPX3K8D9UCOiwzkZM0PQUy17Tw7kvX52w=;
        b=TlB56/cg+otbaigp8YX7WfB9y9xapsWHk4ltIWIDb6A0hHE1MaONppqxMEe/q3Hvr+
         FWUrxK2nmK3uojNZAkXm3UJNdUplpzhpmgaDDS5zqFHKxTIrkdcnEYKLc1fateZeiGK2
         ygcksckY54YC0ljnn188MYsYWBQEcVMu+q2eJ2mQFbQyyZoXNy4oXkUvKILGlbGYs8mF
         yWoosNSQUmnY0H4gpOATzzjt8kPUe8yD6hiWyGT7ij74CR6Zs6kKVEuZXEHZ0ZCQJGtM
         LaSjEut5GAd6hT5MCsd8O54CTa/43NRrn9ayheqc/SfB9EbBgCtasWuveqgRPW9FrLkZ
         OHxA==
X-Forwarded-Encrypted: i=1; AJvYcCVPeSh7b/Hmaur07+cYjoVFuYLi6sWDDWZvvZx83d5KoIvAtVlLm0M690gfEowCay9D2b9p/sCbjvrbaw==@vger.kernel.org, AJvYcCXszIL2QRr1hf+/SecpBBxnUacwms8+1lc5BDSaWC45oddpubgOW4WW3QMapjIwiOiZ2pvnnNbtY7OLS8g0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99JtXY49SsXhIj3zyfsJiU98WgoFakBYaMzXW3CDr89wlJOUY
	OIuhrhv18hl3A+uTcpM8cIcBojs1zF/ZRhW/oACHlB1lLk5Nugqzw8h4MA==
X-Gm-Gg: ASbGncupwxw7BdXMKfddCAsJtaLBYz88dkHBf3y3Dtqy3CZTVOZ5B1CuOoexW8WPCgr
	Nj5wn84nfW0aPVO5/nt6CqjOejfcQOJzHq1dWtqqFKYbzeXSTyENTGoWy0OyLGiwck9kgAomlxH
	o0fMBw/UKpn8Slp6x6NbnYLCt9IvWHM/Lz6q/RF9luV2pjYFesj6UX3V4piQASyiRTX8ba+Uvd8
	P7d4h3SQ+xbAVgsekIJXfZmP+rxxbNr8U+nEz+dXD9S6v7JeXs9zQqzN+BCMrFuMyUu6Whpkbyc
	Le3UE+MhI6cTEjipGqHz4+h2fxgRUSi856pF
X-Google-Smtp-Source: AGHT+IEV6tZO9q1vLUrrCXo7HzrGsfGGmOd37KnbXPk5eWkBQpMOIoN2ppnPKkUgW0HrCSAn2Z9GRw==
X-Received: by 2002:a05:600c:3149:b0:434:f297:8e78 with SMTP id 5b1f17b1804b1-436e267fbe1mr206805665e9.7.1736796714951;
        Mon, 13 Jan 2025 11:31:54 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:54 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:45 +0100
Subject: [PATCH v4 04/14] btrfs: fix front delete range calculation for
 RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-4-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=jth@kernel.org;
 h=from:subject:message-id; bh=5+Uh5g3sT+QliGHP6NK8OMLhj3AmhkLM0KvlvFFuU6s=;
 b=kA0DAAoW0p7yIq+KHe4ByyZiAGeFaiShqW9+25+MBdI5BWqrlaTaokB2WcrOZwOA/VsXf5/Em
 Yh1BAAWCgAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAmeFaiQACgkQ0p7yIq+KHe5XUwEA0VNu
 wPUDDKjOFsAyjmQA4KR/Ynn1jZsMJy2+zfwBxjgA/3QbkFsGT11fYi+8okCAntuZWvGP3YElIw3
 Xje7xf7EA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When deleting the front of a RAID stripe-extent the delete code
miscalculates the size on how much to pad the remaining extent part in the
front.

Fix the calculation so we're always having the sizes we expect.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 0c351eda3551efec67c35d76d06e648da5f33c71..9e559ad48810b704c997ff5e51222aced0b91637 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -136,10 +136,12 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		 * length to the new size and then re-insert the item.
 		 */
 		if (found_end > end) {
-			u64 diff = found_end - end;
+			u64 diff_end = found_end - end;
 
 			btrfs_partially_delete_raid_extent(trans, path, &key,
-							   diff, diff);
+							   key.offset - length,
+							   length);
+			ASSERT(key.offset - diff_end == length);
 			break;
 		}
 

-- 
2.43.0


