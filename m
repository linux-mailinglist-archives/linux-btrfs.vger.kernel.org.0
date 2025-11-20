Return-Path: <linux-btrfs+bounces-19221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FD1C74709
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 15:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E67E9345051
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69A3469E7;
	Thu, 20 Nov 2025 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuGEwKAX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5F1A9F86
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647298; cv=none; b=QtSPsQXSBW04Tck7KYogVaURLz8jklJYTdBvadHK0AIbyZxbHFgqeFCj8AP2mpx075KwkHKOBXVhvf5zqgEDog0CfjTp1oNQYSzGxw0NyiyzMJVslc7Z8WpQk4gG+G62aXU0HIULQWcmOIkaLyvy+3wKUjsbr+GB1oPoi23JImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647298; c=relaxed/simple;
	bh=pT7y4y4wzuZERFqfJ7HGR7Hdn+6LPteWJbrUoYGCOTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jez3+HG6Z75KkaQDdkv0dFGaIgG54KhnpH0drRBXz3xJ3L8BhYskvQ6gJdVk0/kql3tBsI7jFJlJiuUJH9h6IfmQEK0/NsxyY2JT/YoJV0D8M/Kr/keYMHIcX59FzjtT6McOlxpdcNLGQOJlSRzEhI9mJfQi49CG6c8aDLv8xqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuGEwKAX; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-297ea4c2933so771315ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 06:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647296; x=1764252096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZWc3onDNZ0JIOEYQ7rMypqhZUakLN9ha/I2JKTQS2M=;
        b=TuGEwKAX901ee6lXCK369q9+4goDw+BKW7yDpXzGs+0yIinA1WWU41SzaXm9uQApW+
         JdJyJHdB76+hHn42V5CUQjPrqfDqRSCasv3S90SZk3w8Q1KZls+ZqWxV7oQz3dltx8Yb
         X7sybw+dqiyRKDNge00g3yXcujwOPiJ751DtAAv+0ZrTaT1cfbnqerlEFsB3B8Vrxt7j
         JVYAzDoXSjqLkSR5KTnwSqD2Z3VjQFNeBgGtnQUQZYDvt+sJ/xW5mKJVyIlZKquxFs1I
         dO9VjgO8w/o5rwyyJteH3H1Bphc7bl80NMCq7+JHePpVRteVIDK3IROg9o4FrB8Jwt0X
         GZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647296; x=1764252096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZWc3onDNZ0JIOEYQ7rMypqhZUakLN9ha/I2JKTQS2M=;
        b=Tack2zRfkj3NwViUiv65ovVBgPcgcg2t9uGXuV3sjIiQ/G38DxzAPnCSdLx1rzh1lS
         M3yXZcRLzGLHKXAmsW9YdFL5QcCTcRK43/mamA1vP46JodVFQSeQzpDj3PaEK1JyDVcR
         tEiiZMZW0qnRB5jOFDSSDk2U2ZhPiGKm4CIbzHTgwkrHRIUMMhypl6s3kVVnEvplfsg/
         XRLyxcQFdw3Own7jjw/RrXA3yR/Y+oaYsVdPo1CaFq4vorcroZtYKRg0U4YJhbE0cn03
         9STbzzoVKkueE1pNS4MJULCDX65zCf1/vhY3RqRWVzjzydUmEVhThkowCPaWc0ZDJX46
         fEQg==
X-Gm-Message-State: AOJu0YxXAMCVZeOUY5FTzBuAD0WpMD9VybTDFRIpEnMEVD00GfSGZdJ7
	+FiZfbb/2J+E8/ECOW+jFGd5C5T3F3UjiQ8khkEhxb4kr60y+to7cYMy6+WBF6Yv/Vw=
X-Gm-Gg: ASbGncvJW9r+yDtsGnmFWxqvcLESfS5pTXbRDIwfz9p6tJTqsyPmNSs5t1VLU6fPCbD
	kanjvJt2xdg6J+Uz9dbUvJ1gzDwQQ3wO6bnQFFiQn3c8PK/PcGsXNH9jXXSTy1SkzZWwV8VBijb
	1hqtD9GAZiHIeRwgRYkACsYKBMy6d2zfmpbcXB1lltgR4tYMGrHGvzvt3PoU84AJqpvKlhvU1SC
	+Y+QBrhilSAe1by9/Pirk32g55ZeD+enTJOcapbqSpVZ3YXPLG9Z3/3uKDcKatFL5XgvLI+P1SS
	mclmqLT7abFVBbLB8ziagdh57OkwMhqZnDavQBHrZfOOy03sSg+TaXdw7eQIEc/UKdTMI8OHz14
	uEtaFMmV81Ul+Jirp9B6damOZaLLh97htGF7Mjgn/Wb38/64zjCxIAZGNaglOkwGHFgjklpUHcR
	6TB03xhH+NVhJ7nsX1YxKDFlIws759YhE=
X-Google-Smtp-Source: AGHT+IG/mFYmg69HSnhacvXBHsJ2fJACQIz7pzeBbeflfcl6bLiVVkulzKoA7ocvoogKVQedxME9FQ==
X-Received: by 2002:a17:903:2383:b0:25a:4437:dbb7 with SMTP id d9443c01a7336-29b5eeaaa38mr15375905ad.4.1763647295800;
        Thu, 20 Nov 2025 06:01:35 -0800 (PST)
Received: from SaltyKitkat ([195.88.211.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm28660985ad.35.2025.11.20.06.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:01:35 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/2] btrfs: drop premature generation setting in btrfs_init_new_buffer()
Date: Thu, 20 Nov 2025 21:57:06 +0800
Message-ID: <20251120140030.2770-6-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251120140030.2770-2-sunk67188@gmail.com>
References: <20251120140030.2770-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_init_new_buffer() sets the header generation only to satisfy
btrfs_clear_buffer_dirty()'s transaction check, then immediately
cleared by memzero_extent_buffer(). This is introduced in
commit cbddcc4fa3443("btrfs: set generation before calling btrfs_clean_tree_block in btrfs_init_new_buffer").

However, after commit c4e54a6571168("btrfs: replace clearing extent buffer dirty bit with btrfs_clean_block")
we can pass NULL instead of the transaction handle to
btrfs_clear_buffer_dirty() so that the generation of the buffer is not
checked. So we can remove the generation assignment that was done only
for that check.

No functional change, just removes a redundant write.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/extent-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dc4ca98c3780..b22b0aaa99e4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5082,9 +5082,6 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	    !test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
 		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
 
-	/* btrfs_clear_buffer_dirty() accesses generation field. */
-	btrfs_set_header_generation(buf, trans->transid);
-
 	/*
 	 * This needs to stay, because we could allocate a freed block from an
 	 * old tree into a new tree, so we need to make sure this new block is
@@ -5093,7 +5090,8 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	btrfs_set_buffer_lockdep_class(lockdep_owner, buf, level);
 
 	btrfs_tree_lock_nested(buf, nest);
-	btrfs_clear_buffer_dirty(trans, buf);
+	/* We don't care buf's generation here. */
+	btrfs_clear_buffer_dirty(NULL, buf);
 	clear_bit(EXTENT_BUFFER_STALE, &buf->bflags);
 	clear_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &buf->bflags);
 
-- 
2.51.2


