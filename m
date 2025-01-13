Return-Path: <linux-btrfs+bounces-10943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20294A0C17B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638E0166509
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5491CD1F1;
	Mon, 13 Jan 2025 19:31:58 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A751CC89D;
	Mon, 13 Jan 2025 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796717; cv=none; b=B0PPVdWfRlnUG587SzIx7OecCLx272knAAgeOxrE43MQxbw3PK7UUevgFOP8uHvncXfvwtXXvEQYuD+uv5HRMfk+biou3ZYbD9vqYW7Meh1WCyoJZmxP3CoCHgLhl+uC1fHU6aqqUljGI/4E1H04M/U8kBs7lyiHmseCB49iocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796717; c=relaxed/simple;
	bh=dr6eMa7aZX3mdAc3Sis8Kf7XJi6Q+T6fLGYjF8gg0FA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d42w1Bb/F7qpg598abmrz6xuo8qmvvasfK1Uq68aje8WptNmxdZYSrCPZZDY8q6UAhRr5yjacIiNPxQf/AiYQudY0g89OJKY0q016Mi9Pj1H44OQYZJ2N1NRLfU3n5pUFByUHfoUVPb9/HJIYJIdCoXpBix2pd5UfQl/TgrO6+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so44942055e9.1;
        Mon, 13 Jan 2025 11:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796714; x=1737401514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiVBZyMEPUj9kKl+Kgc4755bAqGr6clEU+UsodEl16E=;
        b=Grj471EPIyKD5qOfIhEgeYUOm0DkUXtdcl2o5NuT9IEaC8V24fZkh647tlPvIk49O1
         JuBtF53yHD5SR2rBmqQz8uFrHoVYe/5Bx2VtmvcYC5JsttgW+5Ir/UDSAcgdzbaiAAa6
         J8RK1oyuBrXqUkUoYrCxjmiXHbkXr0FuMGhc+/vKaU5dES727QTdp9gLXWddZd59GxgK
         XVUmS7xwMFxoaf3C1gBy24Xp1Itr6NU7uOHOMrPk1shQsNc83MQ8BmyBLfJLydnpRg1i
         InYBqonjs72QLxm6gBR3rRZOSpQ86TnhF/GywJC933iwzPmhiiVydxRfqRNP/FuEd0u3
         d0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLI5Iqi7aH/bGD9i6IgpExx6l0962YkeN8WeEn54IqICgxC8er0IsEerm4Hv2+v201Tw1C1dE4uVqkOw==@vger.kernel.org, AJvYcCXgzyEkRq8GO7lJR/7FSUv9CE4ZnaJ9XvB2Nm4e+pfedxb+4GF9Fg1iwK9osfyd+XYOxfu/YDJAtG5guCTl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg93cy83d/BQV7IcsVCMBWM91r6jRJVYKC+0jID8sv961oagpd
	/Kt4NwWEsDdrJUNqmvYZykNZOA8+Mg34MLe3O9hNj3kyOSf0W4bd
X-Gm-Gg: ASbGncu3/IKPjfU5PnOdbLKZGYmM0ddLUoeoz3v9CXmvcjtmEpt1x329NCJPY2mnylD
	qiezHS9x+0JnjJhsjbZSMi387yBXnIReqMEAcZJSV7tfq6AxlNe41zMRbDVFTYft37HQq+odOum
	nV6s4ZQRqixtNxi5ltJxsdK08wGStFM5OG1oNV78XTUq4Vz6mpT/kVBojNgK1BQOPvoAig0OOtt
	FNCAjZd+sZCz/TsnwM6xmWFzrHZHl+khW9Z5nUm5PmVdEvKfEWu3dOVFTupZWwzmlyiRj7BW6ds
	c+2eX4AgCe2Dq+9k7xubARtfvs9JnjU5aFTd
X-Google-Smtp-Source: AGHT+IHBVJjLIrusI1TdzQuHNKTpjig59w/jnLNSt9aCKSHuQVlXfX70Erkju2vMfbhgxRCSZz9iYQ==
X-Received: by 2002:a05:600c:524f:b0:435:d22:9c9e with SMTP id 5b1f17b1804b1-436e26d0cf9mr178309115e9.19.1736796714087;
        Mon, 13 Jan 2025 11:31:54 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:53 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:44 +0100
Subject: [PATCH v4 03/14] btrfs: assert RAID stripe-extent length is always
 greater than 0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-3-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=797; i=jth@kernel.org;
 h=from:subject:message-id; bh=5L8Yr+hmUCjhksYmwhWau8cY2+f/Vjr1c4fw/eMouPM=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqlwlXvWxDWEnN6bsDzt8sp9x5JVWE01teVTN+lGn
 7wz69vqjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZiIyEeGvxJRT4NKMh7cPxNU
 mqP95KX+12bZTs/4R2dFLDT6Qt1q2xgZ3r3SvajBEdR8cuIh4w0qS+1Crq0InLBbyLZJZUa+Vak
 wHwA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When modifying a RAID stripe-extent, ASSERT() that the length of the new
RAID stripe-extent is always greater than 0.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index be923144cc85a0ecb370dbb1ebeea44269a1f4ad..0c351eda3551efec67c35d76d06e648da5f33c71 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -28,6 +28,7 @@ static void btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
 		.offset = newlen,
 	};
 
+	ASSERT(newlen > 0);
 	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
 
 	leaf = path->nodes[0];

-- 
2.43.0


