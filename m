Return-Path: <linux-btrfs+bounces-4804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5088BEB6C
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EF3B29A11
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3DA16D4D0;
	Tue,  7 May 2024 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="rXYGCa7Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88C16ABC7
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105548; cv=none; b=RNzWYACCJALazM7u2L8lPn76GuvwT6GIuAtNDUgQ4AT+NAmnCroVFe0cz2CagBz6ejuYLLiHuYv4iMQHd4THbVXJgECbrElRw9ankQHa/UUorA61GEIcG19Klb8XVnBGEH7x1X9Cjbk3kkgKRWhKG+msv7fs0rcSQ0QHi6juYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105548; c=relaxed/simple;
	bh=F3d6Qihv++wQKFxkvWTlrSEB4w4EXSa83G5JD6f4ARE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnA7d0d8HR5ezWmHwBBJMwBth+RvWnQUUp5hAAq7hfWfu6QJzpX7AOv3I+9/gR9MRSJqr05D2nz3ziGNViBv6Dqfq2wQUeFPKH8KkXvwlvJsMFKb5X2LT06PU5PuElcYOYw8VRpb+hFyLJ4DdmaQcjeVZajgIrsAm+Rf4rEroas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=rXYGCa7Q; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61e0c2b5cd2so81207b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105545; x=1715710345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6YgBjv6xHbxEq4dJcwOVpR1231RQWvmYFp/ZNwUhRM=;
        b=rXYGCa7QCtyOFlKo7L01D0OzqwHRFjIKd/4rmBlNu1ntAFHspkG/10KTJtFRRJ6YlS
         Y99qdq05KuPKMoipeQwcTWoVmuS0UV8jgw3FFm5jOXTplIAtLMgDWeMF/LI41IsB3o5e
         OGx85gtvZwvekMkgqq6RHIe04fD/6bKYqXtHdzBtClMxEFhE9AfQ9PXknDNSzwd5l6Tn
         nn6+ov0VKKuonnGQChyd+omsi5y6Z7OfxekJgvd0ztrsNDDnlamJmudxEw4hhYr7bl/f
         IMKvS6r7dyvqRZOo+VOeQTpF6N5oh0GBev22aC98oQayg9FvdSLo+wBDDnYwk7+IaeGS
         cZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105545; x=1715710345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6YgBjv6xHbxEq4dJcwOVpR1231RQWvmYFp/ZNwUhRM=;
        b=HLGh6U+UGoouMqlQoj8zvzLAQQ6ku8EngAEvtSw4uypQEFft0px/p8h8P0FXao64wd
         dMO4IsIicEDTJ3dT2sdaIPURAv1/azmvjabDcZs3CsWdi6MJzACe3TpQEcyl+Oi9qpvx
         bt4ZoMWiJUitypAMFyYC8aK6+P2xBwZdwh0YYvQebSg9Ku6aJLayhHun9d09YRxogc0D
         9kDVvv2B4SWpRvD0TV3PyhnE4hAp+V9JkEc4m5cBy3b3QcEWsa9SUxcCZj3Y1GMTbv5u
         GmlfwU1Jwbj5Z5KzFVwuZkaEvarZLJ/OMEDzQMmvOzAdiUJYsGlxIYll1mMCXpJXUv+Z
         2V6A==
X-Gm-Message-State: AOJu0Ywmi/Dt+Tbu/JwuVaUv9HBsXd6N4uK5ykUslquJTrmR23VGPofE
	1iMGE7vUjbcnUYHFVu74JMcpZILvGSybIBSvqfboCSlCBKxkNSfFRCoibx2NUzHOG6ZacGFHldz
	Z
X-Google-Smtp-Source: AGHT+IGImF0dLaBkFkZiDM2pS3lfgfLOwpBFWoNR/Os8JkQcBpExt616mOFQTKoH+HOBkdArSeMy1Q==
X-Received: by 2002:a81:91d4:0:b0:61e:eec:ec5d with SMTP id 00721157ae682-62085a6fe8cmr5791727b3.5.1715105544114;
        Tue, 07 May 2024 11:12:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g21-20020a0ddd15000000b0061be5fe1e80sm2846482ywe.80.2024.05.07.11.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 01/15] btrfs: don't do find_extent_buffer in do_walk_down
Date: Tue,  7 May 2024 14:12:02 -0400
Message-ID: <679aea878e1a1bba534462f1f6d8d61808f0de76.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
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


