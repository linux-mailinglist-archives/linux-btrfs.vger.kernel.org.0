Return-Path: <linux-btrfs+bounces-4604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20858B5A27
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A921DB26C16
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEF70CCB;
	Mon, 29 Apr 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="A4iskGXX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9004D67A14
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397399; cv=none; b=hzRDKEM/O25sWcJ/BRMZ83SEcK6BJ+Mus+8GHNLAUdnzILCjkqluuQqbqsJkyttKHqfoJwxsPyhErCCtft5p8mAv3OBmBSOGy7qyab4HktF6VDV+rCo5VOF9B0RcAh09Pmtl9e8ZN7Qt3N5wQFJTyQYyxCB6pAGcf8l0h80HsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397399; c=relaxed/simple;
	bh=F3d6Qihv++wQKFxkvWTlrSEB4w4EXSa83G5JD6f4ARE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrqz7PtPIytZXGSoB/12t1nts+ywZQmwYOfNV1VjLQOQfYeAjUc2hRRdNAk74e7nP9aVarfTBZpmBuKQUd03Fh3xUpD7Q3zVrxfPIFUjIsNtaL25jNXL9kppjnFVdsZuaohPFH3EAKxp65yPcN9DCCmFSLz8Fg4QDJIPZ2KNNS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=A4iskGXX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6150670d372so33300567b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397396; x=1715002196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6YgBjv6xHbxEq4dJcwOVpR1231RQWvmYFp/ZNwUhRM=;
        b=A4iskGXXF0M1L1WIhsJULQ1P84hs56zQ8c+tuxGkLLQlLdvllihWqU9bzMT0RyaxGv
         m+x+3dxhoi42/REJo5zMK/7sL1ht23YkWPWVpOkzBoKHc2ug3g6b9tykG/7zXsFKESRe
         jr8PMMDKRSqvYS9oCVYfMlMSVt1ftRFfcz0hWG3T2AHBi+739XqFyOZLnGGaFchhW966
         xSdUjdKqR5ohHp3Lcx2WCwRwMyIc2zbKooYST2gBPBA2YQd8vECMEeHi8pYWSAVRop+H
         AssRR9DgKMue0ejtw9mex5vRYbePhSFEMOp/j1S/9O+9dToEFVlNuYocXQNSxfjx9PUD
         hA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397396; x=1715002196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6YgBjv6xHbxEq4dJcwOVpR1231RQWvmYFp/ZNwUhRM=;
        b=bPor3cw76Wb8oQAJ7wPeIHKmP/KqJOetAs4A9Q2bwAZylZpAYh4P0NmLow3l99KznJ
         dW9JL34SLPuY5lGA7/1cJvBkz3UTvQD6uCHRPnp3EpLRtA4ztyoU65daWhtlR86UuUYz
         jvnbZKP/Yg/YMDDuFl22E3Leo50LrwTHsTwiCppUNb3BNB4knXw3ZVIIQrhVKdjB2MT0
         /mPPCQiNL4TRo/YccjgcRz4bhQbHJ18AIrWglwWsdcgOkQNM2MkkFVQEMwVqqw2+nGLp
         W/WztOCRph+pBAzTLdPoOZ+t4fFfTsgVC2efUY3yPb50wquKQGd/TdEu+9UA/kFybQ1g
         NjEg==
X-Gm-Message-State: AOJu0YwLp5brpM0UkJKD7MslvqVgoczk3ZrrsmyDSBFvTLv6LI8+G0VD
	XlXbIpq4Z9NJ9Dc03i6KFAXhdhPB0AQZjquGeyPI6kx6a3M3FGcHCJvFvblxSMcMXJ1GXEgTUSp
	M
X-Google-Smtp-Source: AGHT+IFodyB+9L1wOEzOh35UAb9Wnkrwcc7XidsaQnVX0b//7Jwp8qGT95CnpLWMYk1I0vDeDHV3Lg==
X-Received: by 2002:a05:690c:630c:b0:61a:b548:93a8 with SMTP id ho12-20020a05690c630c00b0061ab54893a8mr7987552ywb.1.1714397396409;
        Mon, 29 Apr 2024 06:29:56 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t16-20020ac85310000000b0043718ece8dfsm10283013qtn.12.2024.04.29.06.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:29:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2 01/15] btrfs: don't do find_extent_buffer in do_walk_down
Date: Mon, 29 Apr 2024 09:29:36 -0400
Message-ID: <bd8fa39f78cc0f691c5b947c46d95fba20948572.1714397222.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1714397222.git.josef@toxicpanda.com>
References: <cover.1714397222.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do find_extent_buffer(), and then if we don't find the eb in cache we
call btrfs_find_create_tree_block(), which calls find_extent_buffer()
first and then allocates the extent buffer.

The reason we're doing this is because if we don't find the extent
buffer in cache we set reada = 1.  However this doesn't matter, because
lower down we only trigger reada if !btrfs_buffer_uptodate(eb), which is
what the case would be if we didn't find the extent buffer in cache and
had to allocate it.

Clean this up to simply call btrfs_find_create_tree_block(), and then
use the fact that we're having to read the extent buffer off of disk to
go ahead and kick off readahead.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 47d48233b592..d020ee1a6473 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5433,7 +5433,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	struct btrfs_key key;
 	struct extent_buffer *next;
 	int level = wc->level;
-	int reada = 0;
 	int ret = 0;
 	bool need_account = false;
 
@@ -5459,14 +5458,11 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	btrfs_node_key_to_cpu(path->nodes[level], &check.first_key,
 			      path->slots[level]);
 
-	next = find_extent_buffer(fs_info, bytenr);
-	if (!next) {
-		next = btrfs_find_create_tree_block(fs_info, bytenr,
-				btrfs_root_id(root), level - 1);
-		if (IS_ERR(next))
-			return PTR_ERR(next);
-		reada = 1;
-	}
+	next = btrfs_find_create_tree_block(fs_info, bytenr,
+					    btrfs_root_id(root), level - 1);
+	if (IS_ERR(next))
+		return PTR_ERR(next);
+
 	btrfs_tree_lock(next);
 
 	ret = btrfs_lookup_extent_info(trans, fs_info, bytenr, level - 1, 1,
@@ -5517,7 +5513,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	}
 
 	if (!next) {
-		if (reada && level == 1)
+		if (level == 1)
 			reada_walk_down(trans, root, wc, path);
 		next = read_tree_block(fs_info, bytenr, &check);
 		if (IS_ERR(next)) {
-- 
2.43.0


