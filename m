Return-Path: <linux-btrfs+bounces-4609-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E178B59F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF9628CC5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE606F099;
	Mon, 29 Apr 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="A8mib3VZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FE6E60E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397405; cv=none; b=Zt1cLxNBlq13J/4D9lOtTuz3K0qFaEoWu1r3HKt3wm/04fpXC6gR2pXcbLSh6dqe/h+1NHsVYC58Qd/0Oh+RBN4MS7O5yKkqP+5uB9FPOO6OSA8WvyuiIu+eUyzAD2CbivQjbbMBWI/tIrVRXOVZfZzubY3zbxEir79H5gXbScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397405; c=relaxed/simple;
	bh=Xkik9oyzjLOjQjX8zLJDqz5ahPdSsEF6qd/+9+fLnlc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR4q4ePKrg6jfDxN2fhjlIdLxZDG4gF8exl8WgIt+0PbtcrcOJeTvwAnilY+UXXSD6VftSwHrgwIA/BFOAzHZd3DEMfATXS6tAsmBV07biz4roSPB1GI/SlMdwnyWh+PGtWIjLJ+N7vTaGT3ekJI34p5l+CH9a5P1IHDwtzU6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=A8mib3VZ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6a0c8fb3540so9553046d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397403; x=1715002203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Anif3BubDGLs9ZXWD9H+TR+TBYRn+hGnqSRX6TXZ7U=;
        b=A8mib3VZcdy6pxyeGh5/bhZ6CSFrH3FsXwIvTTXuNVUf6WAWjVOIOvtERBzwqhskzh
         UiHa8+B9hwBdQPxPdGDBs00d307QqEikLTTDHC38AaMUrZGGOTAi4bfPhVfHQr9eBUBl
         4cogcK0AfzTlcydme7BrB1AxrBR+eXzKCyy3bz8OrdJdvzzhb1Db9IFUo0hW2MqbAduB
         +59r/KDpWXj7xeaU/2fSLqTjXvyPJEFDY/7v67MiDhwW6NVtM0lEoUFAV25Zyg/ldjp5
         zOIAkZy+6f06zhgNT41gm5XCmMYpgqgSyvM9dLsvfPb9riGpA9vJfGVhLJ0OsV8v/k2H
         ZJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397403; x=1715002203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Anif3BubDGLs9ZXWD9H+TR+TBYRn+hGnqSRX6TXZ7U=;
        b=awOuByDrAuhEnNZNLYQ/e5n3ZOYypf25VxESLu+mJg+EVPbnna67pAG4Nz+prOJzfn
         txPx9hq9cjMuWzx0xxN0jBsNcxGtVL3ckc9z+7p1rlvQKeHNvL6TidsXLb1CKMqzo+6r
         FMmpQocZMtLV6TSiVyIN3efIEK6H0oS/b2WIkNlxkc9/ILSozSeTWG56hv/SsdYrSZsI
         IQnlqFX9pxj/+PS9LucnhOarZNqpG8hYQmTfTC73memV2bbf7RxAB9OQsP3GhTaceddm
         cow5KC5UWfm14/Ugu0mChzqNUtF4rX1I/9AQoXOkR0SXu0OM80VU/49v7y534U+WzgSi
         Qkmw==
X-Gm-Message-State: AOJu0YxSRe8JF9ty/ZFS0qc1dCUX8STz8vXKiiYYjezKc5nGBSKLbPVI
	0tDJEEaY7K2L3hojcsH8Pdd5MnKc3uBw6uMG3aaDh+n8GbMPkYHvwTsuurJJDbPiLKmUs3FosfU
	m
X-Google-Smtp-Source: AGHT+IHW+M5cErZiPj+RR2QiR7GdHdcV2qkvZdbwEGT3Pa6GFDq8qW4/+YbxR0VV0rbzqWMO59HXgQ==
X-Received: by 2002:ad4:4ee8:0:b0:6a0:8da7:3267 with SMTP id dv8-20020ad44ee8000000b006a08da73267mr20011183qvb.7.1714397402859;
        Mon, 29 Apr 2024 06:30:02 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d12-20020a0cea8c000000b006a0ccc14e43sm1070338qvp.18.2024.04.29.06.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 06/15] btrfs: remove need_account in do_walk_down
Date: Mon, 29 Apr 2024 09:29:41 -0400
Message-ID: <f399bb8c4287066a34f77a70ef233a72b7e0fbaf.1714397223.git.josef@toxicpanda.com>
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
index 8f5cf889e24d..ae11a2bd417e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5479,7 +5479,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	struct extent_buffer *next;
 	int level = wc->level;
 	int ret = 0;
-	bool need_account = false;
 
 	generation = btrfs_node_ptr_generation(path->nodes[level],
 					       path->slots[level]);
@@ -5519,7 +5518,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 
 	if (wc->stage == DROP_REFERENCE) {
 		if (wc->refs[level - 1] > 1) {
-			need_account = true;
 			if (level == 1 &&
 			    (wc->flags[0] & BTRFS_BLOCK_FLAG_FULL_BACKREF))
 				goto skip;
@@ -5562,8 +5560,6 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		wc->reada_slot = 0;
 	return 0;
 skip:
-	wc->refs[level - 1] = 0;
-	wc->flags[level - 1] = 0;
 	if (wc->stage == DROP_REFERENCE) {
 		struct btrfs_ref ref = {
 			.action = BTRFS_DROP_DELAYED_REF,
@@ -5608,7 +5604,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		 * already accounted them at merge time (replace_path),
 		 * thus we could skip expensive subtree trace here.
 		 */
-		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID && need_account) {
+		if (btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID &&
+		    wc->refs[level - 1] > 1) {
 			ret = btrfs_qgroup_trace_subtree(trans, next,
 							 generation, level - 1);
 			if (ret) {
@@ -5633,6 +5630,8 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			goto out_unlock;
 	}
 no_delete:
+	wc->refs[level - 1] = 0;
+	wc->flags[level - 1] = 0;
 	wc->lookup_info = 1;
 	ret = 1;
 
-- 
2.43.0


