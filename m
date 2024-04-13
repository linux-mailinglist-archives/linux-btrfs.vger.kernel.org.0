Return-Path: <linux-btrfs+bounces-4232-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A6D8A3FB6
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7E4282038
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4FA5C8F4;
	Sat, 13 Apr 2024 23:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0s6X3caS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBC5BACF
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052435; cv=none; b=Ht3ZgEkoNVjP8lZRRSwaDQ+pNYgPAyeGu30LmTIfqdl5pUr7Dhbuo4XTngafPGTfJp5yq5eGcge+xtQxHzdgX8l0p7hDcaBrHdOYu1u4pu4KSHOohsjbOEhDiZfKFIGahDuLgIY5a1tReI5eO7+8KqwphSPniaYfHnsan4S6cz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052435; c=relaxed/simple;
	bh=Fh/Ckl8t7ySUbxB3HdgLeUU5qs0jd78vwtTvdtPIm4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ9EsMJ5cX2d9E0P41UWDOlCc1qGZQS/qNo0wzpI6mjApk88cd9IWuMw1fSE6uoSZCZMWFKfXDhMrSj1l8kJulWDqP/nbgEmdw24rbJgB6LzzojW57DaMDRLK6hTjlvxtuC6NSNNaY3o56NgccWcZvJ1MeVPR6V7ggH3/sjHGVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0s6X3caS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4347bcc2b47so10581551cf.3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052433; x=1713657233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+FKmU3VuxpuPlpXW54dacoXjSDsc5hEHqD06savOb4=;
        b=0s6X3caSBWMldFTyMZ3pGzhRjm1ttEH7IP7Fct2oxqXeUMTFU6Pl3iSZeo4YOlCZyt
         LMO+rniJCfsqHn0k94IFCdccEsvsWWgwBumVDUkLFsy0I4CxfVKi1ZSB86KFGVjZs/C3
         FMLQ4aMd649h4iMd6uIdvAxhlkcbAWfs5EuNIqr++Eysiq5QqcR5HAwSHRugSyjkEX0a
         7CC3uehyPLY1mmxCepCWbzgWicdHHOv5J1HYjgvlm9G2N89Q1nWGkVTExQBOWu4zf5sB
         uZvRReTCwP0UU0YKTqpfxRH1V0p4EqC00Hd3HJBT05fhjwwLeFmjTmW9/rIZQziSfEfR
         dmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052433; x=1713657233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+FKmU3VuxpuPlpXW54dacoXjSDsc5hEHqD06savOb4=;
        b=GPE6CxaigIywgL+i01R3AQGIBVjTtl5KQtE5Mv3hlwJYriZCzh9cOEr5V5NeYdRCb1
         GyQra9HCUyUxN7Y2iYhxV2KnS13RTei1shfho/f9CNE0FF7rnEAqYL1beIvg3f8cV3f0
         KSVSVE5JbxvWaLhez70bAfr5MHDfYgpvX8Vlh/DjUGPJkhzsizMKeZJ1gG8/0VLgy4tK
         UUASNTa/g/nYSwSA5T6G59xgouKWG29pOnpqX7TAKmAMsSunbrNsiLynTFZjzqJU87Tu
         QKwQvrriDeoYgiXwkiZKMur3sfGGROeOn/44HOWQqRYAE8neQ75OUhZOcmxF6riPRZpG
         xyAw==
X-Gm-Message-State: AOJu0Yxqm3qrLibGxgyKRtnD6x09XRUHJs7eCK1uztPM9QbDm3qrbCGr
	+j0LUFJk6lF3c3qM0GpjZTw6X9rBvz+x00X98/M8zkpc9r84J56MZXKCK/fWxh9ufcwjR6TkLoR
	k
X-Google-Smtp-Source: AGHT+IHRqnv22trFd30OVe4zOv5w1E6y3EH5m7loC4K1ClHBBwZw52VccNo0aOi03C6oejaRIrQGPA==
X-Received: by 2002:ac8:588c:0:b0:434:ba37:c573 with SMTP id t12-20020ac8588c000000b00434ba37c573mr8616144qta.50.1713052433435;
        Sat, 13 Apr 2024 16:53:53 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x1-20020ac85381000000b00436e0eb2346sm454657qtp.55.2024.04.13.16.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 19/19] btrfs: replace btrfs_delayed_*_ref with btrfs_*_ref
Date: Sat, 13 Apr 2024 19:53:29 -0400
Message-ID: <803b5e1780c28bb432930ab7df4459c0f3d4edaf.1713052088.git.josef@toxicpanda.com>
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

Now that these two structs are the same, move the btrfs_data_ref and
btrfs_tree_ref up and use these in the btrfs_delayed_ref_node.  Then
remove the btrfs_delayed_*_ref structs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 10 +++-----
 fs/btrfs/delayed-ref.h | 57 ++++++++++++++++++------------------------
 2 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 397e1d0b4010..582660833c1b 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -982,12 +982,10 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	RB_CLEAR_NODE(&ref->ref_node);
 	INIT_LIST_HEAD(&ref->add_list);
 
-	if (generic_ref->type == BTRFS_REF_DATA) {
-		ref->data_ref.objectid = generic_ref->data_ref.objectid;
-		ref->data_ref.offset = generic_ref->data_ref.offset;
-	} else {
-		ref->tree_ref.level = generic_ref->tree_ref.level;
-	}
+	if (generic_ref->type == BTRFS_REF_DATA)
+		ref->data_ref = generic_ref->data_ref;
+	else
+		ref->tree_ref = generic_ref->tree_ref;
 }
 
 void btrfs_init_tree_ref(struct btrfs_ref *generic_ref, int level, u64 mod_root,
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 84bc990e34fd..dfacbafb1b00 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -30,13 +30,30 @@ enum btrfs_delayed_ref_action {
 	BTRFS_UPDATE_DELAYED_HEAD,
 } __packed;
 
-struct btrfs_delayed_tree_ref {
-	int level;
+struct btrfs_data_ref {
+	/* For EXTENT_DATA_REF */
+
+	/* Inode which refers to this data extent */
+	u64 objectid;
+
+	/*
+	 * file_offset - extent_offset
+	 *
+	 * file_offset is the key.offset of the EXTENT_DATA key.
+	 * extent_offset is btrfs_file_extent_offset() of the EXTENT_DATA data.
+	 */
+	u64 offset;
 };
 
-struct btrfs_delayed_data_ref {
-	u64 objectid;
-	u64 offset;
+struct btrfs_tree_ref {
+	/*
+	 * Level of this tree block
+	 *
+	 * Shared for skinny (TREE_BLOCK_REF) and normal tree ref.
+	 */
+	int level;
+
+	/* For non-skinny metadata, no special member needed */
 };
 
 struct btrfs_delayed_ref_node {
@@ -84,8 +101,8 @@ struct btrfs_delayed_ref_node {
 	unsigned int type:8;
 
 	union {
-		struct btrfs_delayed_tree_ref tree_ref;
-		struct btrfs_delayed_data_ref data_ref;
+		struct btrfs_tree_ref tree_ref;
+		struct btrfs_data_ref data_ref;
 	};
 };
 
@@ -222,32 +239,6 @@ enum btrfs_ref_type {
 	BTRFS_REF_LAST,
 } __packed;
 
-struct btrfs_data_ref {
-	/* For EXTENT_DATA_REF */
-
-	/* Inode which refers to this data extent */
-	u64 objectid;
-
-	/*
-	 * file_offset - extent_offset
-	 *
-	 * file_offset is the key.offset of the EXTENT_DATA key.
-	 * extent_offset is btrfs_file_extent_offset() of the EXTENT_DATA data.
-	 */
-	u64 offset;
-};
-
-struct btrfs_tree_ref {
-	/*
-	 * Level of this tree block
-	 *
-	 * Shared for skinny (TREE_BLOCK_REF) and normal tree ref.
-	 */
-	int level;
-
-	/* For non-skinny metadata, no special member needed */
-};
-
 struct btrfs_ref {
 	enum btrfs_ref_type type;
 	enum btrfs_delayed_ref_action action;
-- 
2.43.0


