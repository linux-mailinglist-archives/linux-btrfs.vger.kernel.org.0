Return-Path: <linux-btrfs+bounces-4444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989FF8AB4F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CBC1C2224D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5EF13C9BB;
	Fri, 19 Apr 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="o4bdUp39"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B11713B598
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550644; cv=none; b=jGtSRbM5GVFhCtiJU7/SDxxNF9pBmP7Lla4uDw1OrQ1HLk1UYDFQdzlAtn7ybbq5UD01t0vco7WkVT3I9uHsgJFBbTk5oyeGgvuurgDbVzrcEJRpiZgYPvKureDF85/aa4UC8Zqs96tZBF7PGAVRSjebscwmZX5pgco0QiM6Ob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550644; c=relaxed/simple;
	bh=C0tBehzN7791iUKERYw6L04mt0yxXgEDaKuy4um33xs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxwxUoR1DkyKyfi6P3IF98W55cyOGMCi1Q6ZITRf8/jOCv/AXpMBPCkcd65b207Tv1x5vrkocFrLjnPa/maguqA8alCRGXEXqoJkxgdmBx/N+eBwF16rioOkV/YmITzzLGIbbKc6CNfpuovbsmbaxkZFsudW37lKhenNWTcndDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=o4bdUp39; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f0e3b6feeso93173685a.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550642; x=1714155442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DL89FSMitRllfpEs9f5TxZiYHV2JxqhGK5Us3v7HTs0=;
        b=o4bdUp39lWJBRgw82ZVjvYBmtF9skUPx77kiw2mc04rKl0vQSpOKrbtBBCmpJRzifL
         EvTswxovzdGfIsJOHIazKOy2bHr/3ELCZVi7z9360uGrfJXo+wwg+6dM4xgB/w9c6xOx
         oK6NOC14gWa01EE68Mq+XTCnWfpZlXasxsPqcrWUIslojvdCacb4hGC13GokWqFJqYKi
         Qd4JpO+fXWgP42uYQGTgPswJeazIw6f/ZPh/DGraMLWg3H92X5XoTy3G9kM1anVyZE8L
         OtMQN5pVh38Cvz/WqCb7BpdxRkwlgere8PXbHazx5lDednhhLPCzOrf1KXVu+e5CFbxW
         yWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550642; x=1714155442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL89FSMitRllfpEs9f5TxZiYHV2JxqhGK5Us3v7HTs0=;
        b=TGLE1EJzzaCuA5X7xNx8RjOGiNG0jHxkSffZij0RdtXH99HsnA22MyQseWV1/ikc6c
         htkFBQ3wjIi1u8TkYl0NRNhm05wfU44D+oSls7Vv4Jz5n8BxhpCnVYtuPl+RJGWOpod2
         Opo7QgLVtHSvV1r9+Hz0A8F7fwsE1dxvoX+mCl8MFCavWz/erOiR2buSeI0ohoFudMAP
         FYIyhflJlmNMVZraR0lek8yaitN3vQpkqjf1h6s79mY8iJ5g8g4bQNE+fMtSeI1p9Mdk
         s+RVM/fz6RoKX38XW7yjixIl7XSq63mtCb+EsIIq2jlj9BQxwgq5uS398MscO9TPFctG
         SfpQ==
X-Gm-Message-State: AOJu0YwP7O0pObf15jKlyl9uxKwuWKV3EHTCtNxzCXtJ4eQRLV2Q7nfZ
	gcqidB5bjqw0ugsu07WzfF/IIn8D8cjLT+N0ZL77Pj8eubM6QagSkf3kJZGQKs7r57PUVVmZOjc
	9
X-Google-Smtp-Source: AGHT+IGitGjCIBZptLt4XUwMII+lQZ70eDoIqhZqNH12f1/BfpFb1aHzELdRdTO859WD68vg6SJedA==
X-Received: by 2002:a05:620a:126b:b0:78f:33e:8507 with SMTP id b11-20020a05620a126b00b0078f033e8507mr3500634qkl.36.1713550641964;
        Fri, 19 Apr 2024 11:17:21 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t4-20020a05620a004400b0078d5af15c4csm1818376qkt.38.2024.04.19.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:21 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 06/15] btrfs: remove need_account in do_walk_down
Date: Fri, 19 Apr 2024 14:17:01 -0400
Message-ID: <ce3aec3c2059431eb1eccbd9e68e8b26e65fd57f.1713550368.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713550368.git.josef@toxicpanda.com>
References: <cover.1713550368.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We only set this if wc->refs[level - 1] > 1, and we check this way up
above where we need it because the first thing we do before dropping our
refs is reset wc->refs[level - 1] to 0.  Re-order re-setting of wc->refs
to after our drop logic, and then remove the need_account variable and
simply check wc->refs[level - 1] directly instead of using a variable.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9132cfb7fee1..afe0694c675b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5480,7 +5480,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	struct extent_buffer *next;
 	int level = wc->level;
 	int ret = 0;
-	bool need_account = false;
 
 	generation = btrfs_node_ptr_generation(path->nodes[level],
 					       path->slots[level]);
@@ -5520,7 +5519,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	if (wc->stage == DROP_REFERENCE) {
 		if (wc->refs[level - 1] > 1) {
-			need_account = true;
 			if (level == 1 &&
 			    (wc->flags[0] & BTRFS_BLOCK_FLAG_FULL_BACKREF))
 				goto skip;
@@ -5563,8 +5561,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->reada_slot = 0;
 	return 0;
 skip:
-	wc->refs[level - 1] = 0;
-	wc->flags[level - 1] = 0;
 	if (wc->stage == DROP_REFERENCE) {
 		struct btrfs_ref ref = {
 			.action = BTRFS_DROP_DELAYED_REF,
@@ -5609,7 +5605,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		 * already accounted them at merge time (replace_path),
 		 * thus we could skip expensive subtree trace here.
 		 */
-		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID && need_account) {
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+		    wc->refs[level - 1] > 1) {
 			ret = btrfs_qgroup_trace_subtree(trans, next,
 							 generation, level - 1);
 			if (ret) {
@@ -5634,6 +5631,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			goto out_unlock;
 	}
 no_delete:
+	wc->refs[level - 1] = 0;
+	wc->flags[level - 1] = 0;
 	wc->lookup_info = 1;
 	ret = 1;
 
-- 
2.43.0


