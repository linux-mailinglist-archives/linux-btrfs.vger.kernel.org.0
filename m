Return-Path: <linux-btrfs+bounces-10942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4D6A0C178
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A31887343
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3A81CEAB4;
	Mon, 13 Jan 2025 19:31:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B321B4148;
	Mon, 13 Jan 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796716; cv=none; b=Xmi7gyy1eAeP2j3vrG7wG96oKPBCTMtw8oZ2oQ/f+mWY8ockcxGc39tCM+JQnBEQm62xrf9Kdrm5Uf97MGCtwxjeZv1bnNwJ202K3htUXO+Gi7IDfn8QREn4A4FYXAChLCwfmpT37p9K0owGSXv1fIanw4ohuTBWnI/nqN+qhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796716; c=relaxed/simple;
	bh=yvho1QOJ5DawE1Hyg/ygQpn9UCmjwG2FQVhHi/Baiq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lo/on7BqicxVUAmsjabytMjaQWjm4gIWtJ3wy2b3z2mkp2Khjl8XI+mhyoGBRyeSD3buejFROg/9tY/UgROlIdTKc2imSrG3R/4LGCMvt7W1SAOiGPXf0wZ7jFR2Y7utXuxDkKZI+K14LQHZNVF+KTt4TKdgHVK21kfZyNNfVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4363ae65100so49381445e9.0;
        Mon, 13 Jan 2025 11:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796713; x=1737401513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE8XSMUUJ4gCjDUgwP7SFNvKrBjkJdUPGdOmAllFh3g=;
        b=NwO9mlvyCqIapaiFdHWdoltD5ukwvVKGOF0ONsU/gD4uDKF7XvSgl38EhvxLL0gJHp
         Nxi6XHanGaQLRADLtvFYf0H/1wSb0+nOrp39WMaHv7oaqiddwHFBrwOdPiwBhDNybflZ
         DALKJRLkNR2046U/nmEOn2upsKUggX17nwDiE2XKYgVwCHXMKpHVFvFhvysOmMBvqoRc
         1TSWDfH/Rm8yvDfmjdnFzo8yPe2QwtqKvZCfDNfyRezl8vYfMUg6zPyb88WXdxmcP3jy
         S5AQVbpL6KfIl//+je0idY4Y0rvaBqeypIEKmQ652g6GmJTLMAuUE9MdPt21zb7Q42KG
         7U4g==
X-Forwarded-Encrypted: i=1; AJvYcCV5AUU5GKGYTAAEnkx0UsaWhZ4NRffo8dM74jVEakPaC5uIWBaswA3MVVc2DqJrPvHbOaCLXtuR7j9xfXvw@vger.kernel.org, AJvYcCVQacGrJ6F0X3TPRsTMraDVIi6YoDm5iwaf+SkTGgJFoiiX8y4Uaki4GvtszjciEQHEo9oSpNRSzttI/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVX4Cu2xgbbs4KqmnSxtG8B4wyGaKS/hz9VovCmY1eicT9CTaZ
	9LAnJiCfgPdpX7rLYYyy4cY7yqEfRU2GAh52CImz0G6xAhEVxUnj
X-Gm-Gg: ASbGncuwe98rTh2CmF6NXwFDkGEAH9f7wlinlNzxU5WNngd3jmAwpT/xAUh50afwxkM
	shDHuVr1EMkm86UOcwdAMRt/M4WoDkpqWY2AiuNQeCUTbt8GOybZIjuoYzl0dDyvi3roPmSsUfo
	RThrDK6PHeaOtCrHC1sRlxePeCJkZnLGccF9oYJk9hhRdBsLRO7aMf1ecv2Yuh2VG99xKHTy/BV
	riTvkaFOFV0++tdbEIE9SDhma75h5JaAH4dvH9pjAfsO4mqj5pkeh+dL07CuViDY3RP+t1PqST0
	XpAucg5O0yQ4Aefh0wrWIAvUxpOsvYZ3jSiP
X-Google-Smtp-Source: AGHT+IGMLXP2TA1xWjQcRFg1t8Yk6OvFm3o5+ASMG1ohAaESsP663pokJPvk7znfCJOv8PBO3l6PzA==
X-Received: by 2002:a05:600c:4f4e:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-436e26e28cemr192394095e9.20.1736796713189;
        Mon, 13 Jan 2025 11:31:53 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:52 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:43 +0100
Subject: [PATCH v4 02/14] btrfs: don't try to delete RAID stripe-extents if
 we don't need to
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-2-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=jth@kernel.org;
 h=from:subject:message-id; bh=2C9jlaNt6GWgnHoLWl0KVRWkpPixzD1jfNTUzmhT44k=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqlwXV3REGF15vO7v6sd0vapvuxT10v2/1Nacdb7A
 JtKn29wRykLgxgXg6yYIsvxUNv9EqZH2Kccem0GM4eVCWQIAxenAExk62GGP3znbDZmbkwxMXoW
 zhSvUlMt5tKn1Zm94VV7VLDx1GTz5Qz/q5nMNh5y/WE++7Nqp23NofeG7Xu8zmu99WROu5k665c
 YIwA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Even if the RAID stripe-tree is not enabled in the filesystem,
do_free_extent_accounting() still calls into btrfs_delete_raid_extent().

Check if the extent in question is on a block-group that has a profile
which is used by RAID stripe-tree before attempting to delete a stripe
extent. Return early if it doesn't, otherwise we're doing a unnecessary
search.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/raid-stripe-tree.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 0bf3c032d9dc43eefe158e430813add9292c577e..be923144cc85a0ecb370dbb1ebeea44269a1f4ad 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -59,9 +59,22 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	int slot;
 	int ret;
 
-	if (!stripe_root)
+	if (!btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE) || !stripe_root)
 		return 0;
 
+	if (!btrfs_is_testing(fs_info)) {
+		struct btrfs_chunk_map *map;
+		bool use_rst;
+
+		map = btrfs_find_chunk_map(fs_info, start, length);
+		if (!map)
+			return -EINVAL;
+		use_rst = btrfs_need_stripe_tree_update(fs_info, map->type);
+		btrfs_free_chunk_map(map);
+		if (!use_rst)
+			return 0;
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;

-- 
2.43.0


