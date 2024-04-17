Return-Path: <linux-btrfs+bounces-4369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732918A860F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F349283F9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A41428E5;
	Wed, 17 Apr 2024 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0xwVk1as"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ED2142651
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364583; cv=none; b=krFWMXUvwt646bKDe18gRt312p32pwd0Q15FuLwfghgQ+Ax7rx0BlQhcMY6bixZE5By0Do1dRGK0cSENsUzm5nAFrWJm4DvLMPUQmUTEYlxtqbNIjs016fY+KBJv8ZvLxz+4nboGuO+14N3ppF69wqGOleeI5T1QMCGBXqZFlvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364583; c=relaxed/simple;
	bh=MegFHaX8envyvqos52a//gcW7T/q+ySit9A133rRvaA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOgEARk1nx4HXVYYMe4mvmwYRmp8B7SIBsdsSQYrpa88dTKFeMOn3MoGE8+E0HBhVnKFkB7mMJtYiIlycP7YeR9SoCJ2dcgKxyuhTPtsBprVt963K359FpordOYP145uJrg371ycH1JJOEykloNmmGyZPFelHIrRkrYG1Au/ITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0xwVk1as; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78f043eaee9so30606085a.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713364580; x=1713969380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dpkO6N8nqeOoPP2URG7mI4SGd9cbCu/2Bx0uKnmuSM=;
        b=0xwVk1asq95PHE7fktvhKFw4lK1ie49ml/7KvbIFg4muu+71V3+PuK/n4fhqf0DamZ
         Ac7iydJb0pMsNVSMkasf1RNLARHh3ZVYxAV040BUyPTltJaffkM4iYxJedxB3+oUlDpv
         iuRrcURM+9QKmJVdNQ5niwiWEs6lPaIq7UgLKUdVSX3lMirKLEZVVA2mswaElkCbHnBe
         NRuuPgUw2IANeKAYm188PcGx2ME0rCyACho903pDUP/sAak6dME4DMCgia+oGvuA4cvr
         rWK/XzDPTsXA2tClvR58zJXs7rB1QC9aeOasBrcaRnqYWOuLFg3+e7SMHAxMLIrz4a21
         iSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713364580; x=1713969380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dpkO6N8nqeOoPP2URG7mI4SGd9cbCu/2Bx0uKnmuSM=;
        b=gw27Y+qri7E+w3yGYy0V7+jGwHHdXZDodVPYtJ3lOXfsV5dwvFziTLkMGvyfLMKqmr
         RoATvJOaHxa2ZnbHDxQ+o3YVOOOcMICq06p3W2GyLsfu1qMPLSH3pgboiQCQef0Bh5Dt
         4VE7emJVNzrlFsCDe44x1CwDRDmAQyS2jBwWwLpD1l+lmvVFjKhi8cM/vZGQW6e7NxHv
         GJi28msUDPcBFjJfGqEchPKsWu1SY5gE1iE50ZM9jHaucad/uuMAeM1rtYOF+h2+KqR6
         jQKPldSrIuB7Bo0Fj/bo//oU3wMAnuFzZ/4Ldd0msteSjaeVctZwoAhuzmCoHBylgO0U
         uUnA==
X-Gm-Message-State: AOJu0YxXxUHtq/KbtMGFAMJF5yrGojXG5qKzETlai9tGwpxACcisp4dH
	uvqscNgw0whiDJT8nZYg7y1tfqdFGBs65f0G+hKBZ08zYFXawHey9EqGTNxjGXkHOfN3MoQsqdS
	W
X-Google-Smtp-Source: AGHT+IGk+JSxTwD0wkkw/YjlbOZhL+7gj1eS9NWnZfzmXohr6GPeOLCu1q3LhYaucorWUQczymHw5A==
X-Received: by 2002:a05:620a:55a9:b0:78b:bef6:4066 with SMTP id vr9-20020a05620a55a900b0078bbef64066mr18634331qkn.14.1713364580696;
        Wed, 17 Apr 2024 07:36:20 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n9-20020ae9c309000000b0078eebee6a49sm2922315qkg.85.2024.04.17.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 07:36:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 12/17] btrfs: push extent lock into cow_file_range
Date: Wed, 17 Apr 2024 10:35:56 -0400
Message-ID: <2b350d711be80e83e961082d1e119813e2c7bde0.1713363472.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that cow_file_range is the only function that is called with the
range locked, push this call into cow_file_range so we can further
narrow the scope.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b1ae3308ecad..e076b91376a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1336,6 +1336,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	bool extent_reserved = false;
 	int ret = 0;
 
+	lock_extent(&inode->io_tree, start, end, NULL);
+
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
 		goto out_unlock;
@@ -1722,8 +1724,6 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 	u64 done_offset = end;
 	int ret;
 
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end, &done_offset,
 				     true, false);
@@ -1744,12 +1744,11 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	const bool is_reloc_ino = btrfs_is_data_reloc_root(inode->root);
 	const u64 range_bytes = end + 1 - start;
 	struct extent_io_tree *io_tree = &inode->io_tree;
+	struct extent_state *cached_state = NULL;
 	u64 range_start = start;
 	u64 count;
 	int ret;
 
-	lock_extent(io_tree, start, end, NULL);
-
 	/*
 	 * If EXTENT_NORESERVE is set it means that when the buffered write was
 	 * made we had not enough available data space and therefore we did not
@@ -1782,6 +1781,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	 * group that contains that extent to RO mode and therefore force COW
 	 * when starting writeback.
 	 */
+	lock_extent(io_tree, start, end, &cached_state);
 	count = count_range_bits(io_tree, &range_start, end, range_bytes,
 				 EXTENT_NORESERVE, 0, NULL);
 	if (count > 0 || is_space_ino || is_reloc_ino) {
@@ -1800,6 +1800,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 			clear_extent_bit(io_tree, start, end, EXTENT_NORESERVE,
 					 NULL);
 	}
+	unlock_extent(io_tree, start, end, &cached_state);
 
 	/*
 	 * Don't try to create inline extents, as a mix of inline extent that
@@ -2282,14 +2283,12 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 	    run_delalloc_compressed(inode, locked_page, start, end, wbc))
 		return 1;
 
-	if (zoned) {
+	if (zoned)
 		ret = run_delalloc_cow(inode, locked_page, start, end, wbc,
 				       true);
-	} else {
-		lock_extent(&inode->io_tree, start, end, NULL);
+	else
 		ret = cow_file_range(inode, locked_page, start, end, NULL,
 				     false, false);
-	}
 
 out:
 	if (ret < 0)
-- 
2.43.0


