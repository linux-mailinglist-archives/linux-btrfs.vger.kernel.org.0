Return-Path: <linux-btrfs+bounces-4229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05378A3FB3
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A1F1F21979
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EDA5B669;
	Sat, 13 Apr 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JITyo0zp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E115A7AB
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052432; cv=none; b=Btp9U4dQZE1ZmnBNZocDiyZJCJgDjrC573UfKUyobH9YwgFj+bMjfeipjW6wrI/53C87y2wYpCESqo/gy7oK2P/LF7ERiWkYTxZ93eS59tCDcL7lf9NSgg7LNhlA+AM2AfxDl79cGCOeU4LCyDYWWw3x97A3v9FGU4UXGZM3fl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052432; c=relaxed/simple;
	bh=2PzfZkbkH3I5suR/FtFMm6pqFPOsT1wMfl9g3FZ0twY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRLCFYS4I9cRk7/jhLF2JFqYgrbG2hEA1Ar0ky6BfURShzSQOz4HJxwlksfYO/6nQEmE4cUSOh/mX+ZoDuWeFMkJRjFgMBENcDdNp3rAeauzXwPgVp+Azn8GImUfrGYxPiurdqROU1jfnpqRuonWrJMqJVfu+xz1A5i7kzOyilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JITyo0zp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69b10ead8f5so10360896d6.0
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052430; x=1713657230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NngN4hvI1NSZev4xASPSYVvupu9OhNECRPZksLEoEF4=;
        b=JITyo0zp+Zm8DILmuROeihlIUIUSgUwKfMknHiEvxNjlyn7NYlXjoWu3yMh8B0dkJs
         J8/aCHLXnWnc/APFSTaSK1IwUsq+xVQnCZHOXCFBvTD/IGeDveMDODKvJEp6UnpwQpNl
         /UkE5MIZSQdKo0r79A9D8aKqqxZJlFvKl4czokAh4P7y8HWluMb7cgxpcKEwwfL03hi2
         sxos40YvtcQ5rcrAm17UK7208WiH9KECKu8gL4WSANAEV2cdsNnjYaBvvH21dYd6gUlo
         sMnJrRYbkHMaVr/ShXYYr4qZWwY/CDEjmVtuXSP2PsOpQUcHjPQkkKmlRFaSHyWD+w7R
         fxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052430; x=1713657230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NngN4hvI1NSZev4xASPSYVvupu9OhNECRPZksLEoEF4=;
        b=Sp56mqGsvXovj7hXLIxGDLb+cwsFlcucIkdzSYWYB0B0p2Ai35c/j0129mSWT7WS57
         eFSQK1hiAWs8Kekl2a9R9+cWno4VdEZ5OAuqaHxuBRs7B6Dc0Ldwp0HPUlzEu2LhnwaB
         7qcZJjKXGxm8SaO0HkTHkHz/uryPG6wgzKABhsii2iKDxYBCnH7YFM13sz8lD4KcwYsI
         3U00ixECMjehoN+yIm80Ot+ij06yjoQTnkbTETXAIVdw6LsKi9Mi4A91OkvcXdXc0KPJ
         4Sb4r5TWYw/q2oFWRjaKyjStgCjWNk5kUGbYtdyHQcXGi0Ancysd8FZ6fNwEtPWAM4oL
         DP8g==
X-Gm-Message-State: AOJu0YzPgIiSuZCVfIi6qU78S4TUAhSsIsnXp/u8SPXlXMEO8XYxYK1D
	iNE9yGmEW1RL81Bnbam5FtFNdfVM23Dbn9S1wSrfym7dE53kRtKSR6Q9sW2zgGrkUJlrQ7k7jWd
	Q
X-Google-Smtp-Source: AGHT+IElKYvqzF2is+YDCcFEh2HhiCsvX8yD02MdnW2x+PdCobhKEVOFIabHrapLGP9Ba7Eht/qfpg==
X-Received: by 2002:a05:6214:162a:b0:69b:3061:2b54 with SMTP id e10-20020a056214162a00b0069b30612b54mr5922466qvw.54.1713052430233;
        Sat, 13 Apr 2024 16:53:50 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ea13-20020ad458ad000000b0069b5602386dsm2972088qvb.145.2024.04.13.16.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:49 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 16/19] btrfs: stop referencing btrfs_delayed_data_ref directly
Date: Sat, 13 Apr 2024 19:53:26 -0400
Message-ID: <930cd415c44b9b034fa8a23a887275d12fad4e87.1713052088.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713052088.git.josef@toxicpanda.com>
References: <cover.1713052088.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that most of our elements are inside of btrfs_delayed_ref_node
directly and we have helpers for the delayed_data_ref bits, go ahead and
remove all direct usage of btrfs_delayed_data_ref and use the helpers
where needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/backref.c           |  7 ++-----
 fs/btrfs/extent-tree.c       | 20 +++++++++++---------
 include/trace/events/btrfs.h |  1 -
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 98a0cf68d198..eb9f2f078a26 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -947,12 +947,9 @@ static int add_delayed_refs(const struct btrfs_fs_info *fs_info,
 		}
 		case BTRFS_EXTENT_DATA_REF_KEY: {
 			/* NORMAL INDIRECT DATA backref */
-			struct btrfs_delayed_data_ref *ref;
-			ref = btrfs_delayed_node_to_data_ref(node);
-
-			key.objectid = ref->objectid;
+			key.objectid = btrfs_delayed_ref_owner(node);
 			key.type = BTRFS_EXTENT_DATA_KEY;
-			key.offset = ref->offset;
+			key.offset = btrfs_delayed_ref_offset(node);
 
 			/*
 			 * If we have a share check context and a reference for
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d85bc31f2e57..839c64d5a12d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1543,11 +1543,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 				bool insert_reserved)
 {
 	int ret = 0;
-	struct btrfs_delayed_data_ref *ref;
 	u64 parent = 0;
 	u64 flags = 0;
 
-	ref = btrfs_delayed_node_to_data_ref(node);
 	trace_run_delayed_data_ref(trans->fs_info, node);
 
 	if (node->type == BTRFS_SHARED_DATA_REF_KEY)
@@ -1562,6 +1560,8 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 			.is_inc	= true,
 			.generation = trans->transid,
 		};
+		u64 owner = btrfs_delayed_ref_owner(node);
+		u64 offset = btrfs_delayed_ref_offset(node);
 
 		if (extent_op)
 			flags |= extent_op->flags_to_set;
@@ -1571,9 +1571,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		key.offset = node->num_bytes;
 
 		ret = alloc_reserved_file_extent(trans, parent, node->ref_root,
-						 flags, ref->objectid,
-						 ref->offset, &key,
-						 node->ref_mod, href->owning_root);
+						 flags, owner, offset, &key,
+						 node->ref_mod,
+						 href->owning_root);
 		free_head_ref_squota_rsv(trans->fs_info, href);
 		if (!ret)
 			ret = btrfs_record_squota_delta(trans->fs_info, &delta);
@@ -2258,7 +2258,6 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 {
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_node *ref;
-	struct btrfs_delayed_data_ref *data_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_transaction *cur_trans;
 	struct rb_node *node;
@@ -2312,6 +2311,9 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 	 */
 	for (node = rb_first_cached(&head->ref_tree); node;
 	     node = rb_next(node)) {
+		u64 ref_owner;
+		u64 ref_offset;
+
 		ref = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
 		/* If it's a shared ref we know a cross reference exists */
 		if (ref->type != BTRFS_EXTENT_DATA_REF_KEY) {
@@ -2319,15 +2321,15 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 			break;
 		}
 
-		data_ref = btrfs_delayed_node_to_data_ref(ref);
+		ref_owner = btrfs_delayed_ref_owner(ref);
+		ref_offset = btrfs_delayed_ref_offset(ref);
 
 		/*
 		 * If our ref doesn't match the one we're currently looking at
 		 * then we have a cross reference.
 		 */
 		if (ref->ref_root != root->root_key.objectid ||
-		    data_ref->objectid != objectid ||
-		    data_ref->offset != offset) {
+		    ref_owner != objectid || ref_offset != offset) {
 			ret = 1;
 			break;
 		}
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index e6cee75c384c..89fa96fd95b4 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -17,7 +17,6 @@ struct btrfs_file_extent_item;
 struct btrfs_ordered_extent;
 struct btrfs_delayed_ref_node;
 struct btrfs_delayed_tree_ref;
-struct btrfs_delayed_data_ref;
 struct btrfs_delayed_ref_head;
 struct btrfs_block_group;
 struct btrfs_free_cluster;
-- 
2.43.0


