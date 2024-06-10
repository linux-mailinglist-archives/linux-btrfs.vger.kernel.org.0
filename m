Return-Path: <linux-btrfs+bounces-5593-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEF7901D21
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410971F21A0C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 08:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC17406A;
	Mon, 10 Jun 2024 08:40:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DF47A58;
	Mon, 10 Jun 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008837; cv=none; b=CRJ62AeM0PQQzT6xGAyxx98bqO1gjR6nis82sfGmW7ZRDS+H/aUrT775ZxH6996RbLPikk5eD4ycs3Vv+3jWQv41z5+8ahtH8hLO4Otsf/ArTHpRdZr9Lkf+1FlE4D4F1ITB5SeTwgY3fDxa/UYlfybztkzjJjryS/EXtxk26NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008837; c=relaxed/simple;
	bh=ZgnRq282Xg8avPtStefDy79/71wGiQCM/TCdjOQ9xbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upND6zyC/Xyzq1uR/wW+KeF0jbNekq+A/QACb5K10FvVzl244sx2g51auyaj9g5Hvez+3kFmU+I4n3A/bA6/PO30lb9KvQELWrXFzumylAINzdQfahq7s6oVY2mteZg221Gdw1XilxDD1ke0uDAVWptA6nswae8HvApBfFZkM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c681dd692so2391892a12.3;
        Mon, 10 Jun 2024 01:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008834; x=1718613634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N4MAdKlPGuJm/oM7/MA74ckzTztDjs6jlmSPIDGTGo=;
        b=qeK7+8sEULA3zdRFoVSyEd2q1FzbpOZcYAkwOs3wAw36pAKPJzdYkapfdxQfz/6k6m
         mRU9BDG+nR/2BALRSwZaFRVk1U/GCqTJ6qreThUIEmDbAPOYlPmzxFVQvE9KOQjgUt42
         TrGQ0hJkMZKDxPZuixPSIz0X3BFpjWikIlnqp3gC7QUKHg8kqhTo3oFiAvtf9/aZO4vl
         q5JG4Zvd/gp1Jv1Ws1JfrkFNQdodHvquUWIyfd4UwD/HwRGM+dZWwZj1N0rUP3aXrIn8
         NctWWcmqMkutcwKWVfBKX8r78yT/2iyZlYM7p8rtosFVG409/Dqox4Ypa2X79PIQ3GoW
         zn3A==
X-Forwarded-Encrypted: i=1; AJvYcCUR0IUhtC5W9adPFlqtEqbNf/lo0X2hiWM2k3H07brp84lQqtKWDFO7zaJHbWp0ofk0FubPUzvEVyvpk4+rxC0knX3P1dNzgKDhy876
X-Gm-Message-State: AOJu0YzrXAA24vLnCHMkSy4OGBHhlQ5slj1412UufejJOn/nM0RUTu9h
	HjGg5iOPoKx/808RdsYrN8Zg2Eo/093IfbIo1EkF5fnVysSqLzrd
X-Google-Smtp-Source: AGHT+IHUNmOfbEjQCVSSK8LGqbsRhjBIdDI8mIen9m/sadFvpvFicPCSCD2aGSHr1qHDJdLh5pN6jQ==
X-Received: by 2002:a17:906:a2d2:b0:a6f:11f7:e8ba with SMTP id a640c23a62f3a-a6f11f7ed8fmr245546766b.6.1718008833515;
        Mon, 10 Jun 2024 01:40:33 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c72efe054sm3259581a12.66.2024.06.10.01.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 01:40:33 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 10 Jun 2024 10:40:26 +0200
Subject: [PATCH 2/3] btrfs: replace stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-b4-rst-updates-v1-2-179c1eec08f2@kernel.org>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
In-Reply-To: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2547; i=jth@kernel.org;
 h=from:subject:message-id; bh=RjuwkhOcBJ1n6NBT4CbKF+HgnoAOJLf3ccyUh8Q3p/Q=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaSl7f43Vz8uJP/Jp2/uLPcZsoO00/drttxxF3pWlcS2Z
 5vq14U6HaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjARuVRGho1vT70X+NfXyzbl
 e/3VotOcp5NXyGy6wlT00XL/1lumLTMZGba+MXp7ffOre9tvcb/64Vg0R+f61FoWfZPw1n0xRst
 yhRgA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If we can't insert a stripe extent in the RAID stripe tree, because
the key that points to the specific position in the stripe tree is
already existing, we have to remove the item and then replace it by a
new item.

This can happen for example on device replace operations.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.c            |  1 +
 fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a49b9232990..ad934c5469c4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3844,6 +3844,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index e6f7a234b8f6..3020820dd6e2 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -73,6 +73,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	return ret;
 }
 
+static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
+				    struct btrfs_key *key,
+				    struct btrfs_stripe_extent *stripe_extent,
+				    const size_t item_size)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *stripe_root = fs_info->stripe_root;
+	struct btrfs_path *path;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	ret = btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
+	if (ret)
+		goto err;
+
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto err;
+
+	btrfs_free_path(path);
+
+	return btrfs_insert_item(trans, stripe_root, key, stripe_extent,
+				 item_size);
+ err:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 					struct btrfs_io_context *bioc)
 {
@@ -112,6 +143,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_extent,
 				item_size);
+	if (ret == -EEXIST)
+		ret = replace_raid_extent_item(trans, &stripe_key,
+					       stripe_extent, item_size);
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 

-- 
2.43.0


