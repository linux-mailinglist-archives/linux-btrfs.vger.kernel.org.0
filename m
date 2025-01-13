Return-Path: <linux-btrfs+bounces-10946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27216A0C181
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB393A94A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D4E1D9A5F;
	Mon, 13 Jan 2025 19:32:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274E1D434F;
	Mon, 13 Jan 2025 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796721; cv=none; b=pKTV0cnnmZFaPK/7+nNWd05be8RJ8OxeXILs7RPzsEtMcACK2KlO3WYor4pLFms0BrPWWMVE8iVTNe1xzct5WHPTlzSblQmjmAV6ZyDUslFOaUcOWHS405DyoOv+QsBiPJbPoAS31xhuKmIv2cDPSl+w+BQwHu+8KgO6C8kYQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796721; c=relaxed/simple;
	bh=v/AzGRElAhfmCc0Wwzrav5BH9j1J8DzovXh2zzemAak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pf+9HOB1kZvzljaULgpcPxzp6GTbfJIV4imt7QH9y/SaFTl6c0f1T4lMU5i8JufKISiYAi4dbfKwMIh4ZjWBaWC3C71SuvnhxgcqItinsMcopzSYrq3qpRL9xq4XpHg+qeDcs3bvQgpB++JmzVFG3BRgiME7Cv3/yHbpGB8iZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso33111225e9.3;
        Mon, 13 Jan 2025 11:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796717; x=1737401517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwOVTJLL2QDiljjWMMdlNJK4mSoOFW+TYjus+eD9Qm0=;
        b=dlcHc65wn5s5Pfl6tCawbEozwg+N+qOCtPkxIjbod2WxNWnTba6MHTX1t9rB3pgV1T
         jnaFcuQB2IbL5GbLTB5pjxiovReDAT2zQAsZLdFxR0Q3m3qm+b35/6faORJyIPe4Rv8J
         ZWvuvaFS24olINwxIVHJrSn+WAuqEErQergPTKrth1GP3f2nRcNF+BMIMGFe0r8c+3uF
         2Kiq0t/MSw6NMI1YGOP6wcTo2DrGGJX8ofAcIu55VrLeZj15D+OygwAvOUV1UaTTChRg
         a8JyQGOtaehUOwF84YZkT0AR1afBl9YvVmA+SjHgqOz+VmCSQRf7cYnrNxN2ZJmEISXK
         jz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsKO7mBBMIFEC9OOyepq6S9TPMU7x8+TXeXTAbOHcAo6uQY+VkeBC3vMzGTSdHnB5JDqolux6EseC1+w==@vger.kernel.org, AJvYcCXcMFWolNuVGHF4yRXT5IQBTKx/YCvh/0JWcjlf2i7UKdLsiKOHOR8AjomN6XfPprJFzAY4nqM5mYM6Ww+0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24RQfzCRtK6/Jpr1yBfCrJoR67LJlFNXLZjntgVJf7gt3F2Tv
	UZHXHNjBCNkNyiE53F58yE4qrqgnTVDaDCk15HNo3DMG8GURUDht
X-Gm-Gg: ASbGnct+4Dstk4sJalBrXps8e2Xov1aNTbibtqG1i/dHpyorwsprQQZbnqFJ2jFn2qA
	nbwELHP/hcMwgDLdWjf/KIAo3bTvvjZ/n8Mo3nZ3XpkniZuDrvxOqfvx2dz+rYc5wn3T4cTQnvP
	oMgfDRb/KnkAkWZqi8eFS8JRDDf5e3YDD/uj1lxdMf40EAjunqsIe2NjIiRRqlpmeBealFJTSSk
	+ykQ5vuI8s20VgoLDt+TRbqit4xt57v9iZVd7/+W03W4DIBywojqqt6FrTLh2EMeBvwVvS+xH7o
	pvUDa6H3GGxS/TzoqFEaT0CnHk2kFJBQmDv+
X-Google-Smtp-Source: AGHT+IEiqYxnpB9mXryVdK8Y1LbfuRKfFJIMpDEs/1Klnm6jxhrc8OXOfnAYYuNmJtW7q57Q+4ohVw==
X-Received: by 2002:a5d:5f52:0:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38a872deb1amr22369913f8f.21.1736796716564;
        Mon, 13 Jan 2025 11:31:56 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:56 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:47 +0100
Subject: [PATCH v4 06/14] btrfs: fix deletion of a range spanning parts two
 RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-6-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2290; i=jth@kernel.org;
 h=from:subject:message-id; bh=lKSxT/kooJ8KWaK7tVlSQBKGrctXAYhbadOlH5Nl02U=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqkW72Oqd300oeXLv6z24s4px75qXFcoDdP8uqtre
 o+uUmVaRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAEyE5xzD/8qmGNmlQQ7nT1R9
 7b0uF3VAQ/fC87dhU2UfnUrs2G78WJzhn1Xjp+SUE0u3xpU17ywxjX88iztyLpvFKT6Ofzf1Lur
 VMgAA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When a user requests the deletion of a range that spans multiple stripe
extents and btrfs_search_slot() returns us the second RAID stripe extent,
we need to pick the previous item and truncate it, if there's still a
range to delete left, move on to the next item.

The following diagram illustrates the operation:

 |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
        |--- keep  ---|--- drop ---|

While at it, comment the trivial case of a whole item delete as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index ef76202c3a38460c5a36d7309ac0a616f73b0cc0..439b0e63d00d0ffa3ceb2314a39f2653e8a6e9ec 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -99,6 +99,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		found_end = found_start + key.offset;
 		ret = 0;
 
+		/*
+		 * The stripe extent starts before the range we want to delete,
+		 * but the range spans more than one stripe extent:
+		 *
+		 * |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
+		 *        |--- keep  ---|--- drop ---|
+		 *
+		 * This means we have to get the previous item, truncate its
+		 * length and then restart the search.
+		 */
+		if (found_start > start) {
+			if (slot == 0) {
+				ret = btrfs_previous_item(stripe_root, path, start,
+							  BTRFS_RAID_STRIPE_KEY);
+				if (ret) {
+					if (ret > 0)
+						ret = -ENOENT;
+					break;
+				}
+			} else {
+				path->slots[0]--;
+			}
+
+			leaf = path->nodes[0];
+			slot = path->slots[0];
+			btrfs_item_key_to_cpu(leaf, &key, slot);
+			found_start = key.objectid;
+			found_end = found_start + key.offset;
+			ASSERT(found_start <= start);
+		}
+
 		if (key.type != BTRFS_RAID_STRIPE_KEY)
 			break;
 
@@ -152,6 +183,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 			break;
 		}
 
+		/*
+		 * Finally we can delete the whole item, no more special cases.
+		 */
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;

-- 
2.43.0


