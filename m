Return-Path: <linux-btrfs+bounces-10202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C209EB9CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD41F167596
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C1A21421A;
	Tue, 10 Dec 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efkht6Ax"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3182046AE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857636; cv=none; b=t4e8whTP5bnBOI9fWiJN1YrliK6J/6v+ePyO6bl+Fr92BBtZ4uQ8HoDpH/JN6IMXyQCs4r7Cir6xuuaKWixLiWRLQYn5vBonCEH2gJwqqFxttxrUvjMg/3gSp9msNoxjnuMVKL8bEYIijfB1PGkNEPpHu1IUDYS4YQg8YwkMLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857636; c=relaxed/simple;
	bh=0USXxJsPG17IwkGkOz+XYdZWoS8GQB32P/NpsIN6bwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9ZmO31dJtuDJYC7e/5dgA2ClKUxQkhPP6BHxFVjuSrxZUkOu5AnIP9y/XrGf1X39GjT5khLeP/P1S7NPj7946ziS02HXTvSg6Oao9TzPM9rRDyRVq8Z+PsLOWXY+45mhX16o6i0biL0MD21GePZ0aKDCcpsRZRxfbJZr9r4dwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efkht6Ax; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-844c0547717so60732939f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857633; x=1734462433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coDBx/pjraEIem/UXRQljsqpBGD/05jQgXXpDtPUOio=;
        b=efkht6AxYpZaObUzouwKcHvwkr6q3fNmV2BQ4d4sShU0SJoQkEWiJdMFQcDsm3cYED
         toP7uwPbYThxSak3n9JXnlgOfn9flSRHjizlccT5Jb8r8fq9PPItKaQ3wHpDSRH4fdD/
         GA8mfYnD59b+2Jnjn1HOmwY42Dhh4BP9g3NF2RZvRv5H26CLtsoflrLpwVAzBOTlLOU8
         IJX3qkGrzX6bDsSJh6p4YVXvECNtflnYza4A1pTPJEKcph4b8dUnfpLrvIE/Xoo8cHF5
         cRKHkdnQbgpcgGaa+tKoYpU1nokNboEWj3UR336+Yxg3G5PquEjtAbi5R8BqyiS0TXy8
         BVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857633; x=1734462433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coDBx/pjraEIem/UXRQljsqpBGD/05jQgXXpDtPUOio=;
        b=ox0odEHBMtF7us8RTy8abLVVxvMH2X6FNmzG3PVwT/ZG6p7tm8QI+Q+WuogjqRX/7E
         adMW4pWppeEsRLkGmifHkwhWWmiB/U9PvTFCbdf+NI2IGSpjK2q54IIimduvea9w4qV5
         /7B10fSCMeFidgKOWHGLKxZjbdWyhEokqnLuF0bIu/4Hpy2c9RdHgoqJS2CaVwtj9URm
         EFti9PiZK3Mknz6r2Y4toWJvpxmETD5SU12i1A8Ka6MjmVVfP2Sh7tXSNhmmH2yg01P3
         KSRtspCSThmN6D60RosNhY6OcgrPJ9Jhk7v5VOK0MC4A/5/3jc3oIdSJWGahjbU5K1/N
         mb7g==
X-Gm-Message-State: AOJu0YxMfo1m8q52W3vpTiYHdnpgwUtSKGVoj6AfBJr1Sl5JKALFBCsk
	pxq/TutX/lKJV6XK9ArpHMZNdYUSUgbLL4urr1fHnF5nUBxliDZH2b5sHm0h
X-Gm-Gg: ASbGnctchONroVqibnwrwTLuZe0HPbqgtdsNlVFDqnOCh+ZFJhzmyYgtHlQDLmEJeas
	cVfROvWDovW95zUNZ+8kb4k4+5CbrBvMJVJWIhhw6masNVZ6HGhaj36cMImaCD5hOyQrhs9i3cc
	e3n2V6wjdS0I38ZvkwXOsiwJLRByWHgpLRosc9PRBkE4gBO0CvHGaeyyadav3Kzl0Q+s7EIE8ww
	PBaDhvD4NtM1GoUpB0EqgLieREktTqmIhI8wgm26JQzws9OAeRlbNiEARfrjPU=
X-Google-Smtp-Source: AGHT+IH5BghPn5k/nDa0URkP8U4o8SrT5C+LUM+b/82jUWB6gpkkz2o73tj8/EH6GyJdXOSt7u/zxg==
X-Received: by 2002:a05:6602:27c6:b0:843:ec8f:c84a with SMTP id ca18e2360f4ac-844cb5c7f7dmr68179739f.6.1733857633606;
        Tue, 10 Dec 2024 11:07:13 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:13 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/6] btrfs: edit btrfs_add_block_group_cache() to use rb helper
Date: Tue, 10 Dec 2024 13:06:08 -0600
Message-ID: <2c3972c084ab074fd1b6a2e03ada8c20dde6d060.1733850317.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733850317.git.beckerlee3@gmail.com>
References: <cover.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Edits fs/btrfs/block-group.c to use rb_find_add_cached(),
also adds a comparison function, btrfs_add_block_blkgrp_cmp(),
for use with rb_find_add_cached().

Suggested-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/block-group.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..ccff051de43a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -173,40 +173,34 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 	}
 }
 
+static int btrfs_add_blkgrp_cmp(struct rb_node *new, const struct rb_node *exist)
+{
+	struct btrfs_block_group *cmp1 = rb_entry(new, struct btrfs_block_group, cache_node);
+	struct btrfs_block_group *cmp2 = rb_entry(exist, struct btrfs_block_group, cache_node);
+
+	if (cmp1->start < cmp2->start)
+		return -1;
+	if (cmp1->start > cmp2->start)
+		return 1;
+	return 0;
+}
+
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
 static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
 				       struct btrfs_block_group *block_group)
 {
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct btrfs_block_group *cache;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	ASSERT(block_group->length != 0);
 
 	write_lock(&info->block_group_cache_lock);
-	p = &info->block_group_cache_tree.rb_root.rb_node;
-
-	while (*p) {
-		parent = *p;
-		cache = rb_entry(parent, struct btrfs_block_group, cache_node);
-		if (block_group->start < cache->start) {
-			p = &(*p)->rb_left;
-		} else if (block_group->start > cache->start) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			write_unlock(&info->block_group_cache_lock);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&block_group->cache_node, parent, p);
-	rb_insert_color_cached(&block_group->cache_node,
-			       &info->block_group_cache_tree, leftmost);
 
+	exist = rb_find_add_cached(&block_group->cache_node,
+			&info->block_group_cache_tree, btrfs_add_blkgrp_cmp);
+	if (exist != NULL)
+		return -EEXIST;
 	write_unlock(&info->block_group_cache_lock);
 
 	return 0;
-- 
2.45.2


