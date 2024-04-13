Return-Path: <linux-btrfs+bounces-4225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFCF8A3FAF
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Apr 2024 01:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6F31C21114
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 23:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719805A4C6;
	Sat, 13 Apr 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nkEbQSAp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6533E58236
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713052428; cv=none; b=irBV7ontqd4EB/5f5TaTD/SPQPixS5mR9s8FKXzzWcEx1Q2U1ZZD6/OQHj5Kv1Gub0piW7Gkrxp+p2ERf1n3I45x60hRBtUvE5owfj69o3bk5X/kOyI7/pAaW47w56ynbBdpJZy7dV4JQbZpA5cajV1PGxKutbW4elawW+VrX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713052428; c=relaxed/simple;
	bh=mpR7gur0bC9dP7fl9iUtaGIy4nIq7W+qxVx2A85aNlI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKODY4tfWod8j7AVnbnU1Kw8DwdPOoRJwxXhdqYNY/VSMbBbcTWBygyQCJ5aLnUhf8XpcuzgCED68RCgR0PV96B9m1hZ1XaZy6vaUyp7Ml70WvQeqg+pX6juwFzuqVgYxJ0Eh1DOmqjwl5pzoxm0R73IU6a2G258YKHdcTPcX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nkEbQSAp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d6021e2e3so140827885a.1
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 16:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713052426; x=1713657226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N245AS6GdcEBE7ad8Y/iwjdtveUoZ+qkkS2NsL3CiAc=;
        b=nkEbQSAp9Ah2d2T1lJCO2AtxcRjPeIi46vjo//yIFQvFGl+KW3s4LhSwI9zBoGF+Zy
         dzmEcy4s910cyHodDMJX7EMgb60pzjUE9px0mVXoeJbc0qZaesPJtDDgyAKOPNg+QrFU
         WeOIUGueSFGgs2XM2GUcNYgmno8E0XMJzJ905R7g9pu4PLI5kK3zLQNIoaojmbF+C3lD
         p1d4lomDDFj0N/A4d+VMtCiH1FycplZ/X+3IrUGqE/bNmWKdZzhRTFxFc8wF3V4THNBq
         5RLzmBd5diCd3yGjqhv8Ie+3b/0LF0Y9VhybqJtItnadySlrQiMxx+dyRHriA4BhGAUh
         EJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713052426; x=1713657226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N245AS6GdcEBE7ad8Y/iwjdtveUoZ+qkkS2NsL3CiAc=;
        b=rA0Ngv+ERXM6MpQtnHq0bRrR3V8tqX8hgFp1BZ9ashYhcGm6rwK+uFu22Dk5fd0Eeo
         LVsArbt7spe4KX/j+4ekGssBNwx67nTPb75p/HTzr/JI1reyLU4rJ8q+xgXyl6r98j86
         BoR0rCk42JFtDKzFWWwdewW3KvmkHKIgODhGRRyUfQxkiPtjk9XZYQW4mqtsCuY57qr8
         o5z45Zr0tOiHzy8r0xB9qzrHpzx4P+oXVL5nkiJPi2TkEmzYhIEd5h0fjRhE67b4lyTy
         Z9c4TYWlSYsnv4XzgVoI7r1hDJjFZZZuN3koOfrh3TXVQqXqb+F35i+RbtCrtR/m1sn0
         cEyg==
X-Gm-Message-State: AOJu0Yy4LIAu6ArJPpWvhKC0qJRAtoPppCVfwXMe1L4j+Ur07VTuFwJS
	EY3F/UcdFpijb82dqwqIBjLudQ5XTAXlfz14BYUdtmwYyZdXMsTj09f58tcjj2Ft8Uozs1VdJTT
	h
X-Google-Smtp-Source: AGHT+IGkRb1Sv95F5JAbXPFBJzdZkEOItnm9Vu7iv7zB2qJJZYLInwroWqylExGZFwnFkvZeHow6hg==
X-Received: by 2002:a05:620a:6001:b0:78d:6992:baf6 with SMTP id dw1-20020a05620a600100b0078d6992baf6mr8199873qkb.73.1713052426290;
        Sat, 13 Apr 2024 16:53:46 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id bp6-20020a05620a458600b0078ec0e6188asm4330588qkb.89.2024.04.13.16.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 16:53:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 12/19] btrfs: rename btrfs_data_ref->ino to ->objectid
Date: Sat, 13 Apr 2024 19:53:22 -0400
Message-ID: <a9d11bba7cab6dcef20c578a9546361daad1ed5f.1713052088.git.josef@toxicpanda.com>
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

This is how we refer to it in the rest of the extent reference related
code, make it consistent.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 4 ++--
 fs/btrfs/delayed-ref.h | 2 +-
 fs/btrfs/ref-verify.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index f9779142a174..397e1d0b4010 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -983,7 +983,7 @@ static void init_delayed_ref_common(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&ref->add_list);
 
 	if (generic_ref->type == BTRFS_REF_DATA) {
-		ref->data_ref.objectid = generic_ref->data_ref.ino;
+		ref->data_ref.objectid = generic_ref->data_ref.objectid;
 		ref->data_ref.offset = generic_ref->data_ref.offset;
 	} else {
 		ref->tree_ref.level = generic_ref->tree_ref.level;
@@ -1014,7 +1014,7 @@ void btrfs_init_data_ref(struct btrfs_ref *generic_ref, u64 ino, u64 offset,
 	/* If @real_root not set, use @root as fallback */
 	generic_ref->real_root = mod_root ?: generic_ref->ref_root;
 #endif
-	generic_ref->data_ref.ino = ino;
+	generic_ref->data_ref.objectid = ino;
 	generic_ref->data_ref.offset = offset;
 	generic_ref->type = BTRFS_REF_DATA;
 	if (skip_qgroup || !(is_fstree(generic_ref->ref_root) &&
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 6ad48e0a0a1a..3e7afac518ac 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -226,7 +226,7 @@ struct btrfs_data_ref {
 	/* For EXTENT_DATA_REF */
 
 	/* Inode which refers to this data extent */
-	u64 ino;
+	u64 objectid;
 
 	/*
 	 * file_offset - extent_offset
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 94bbb7ef9a13..cf531255ab76 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -688,7 +688,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 		owner = generic_ref->tree_ref.level;
 	} else if (!parent) {
 		ref_root = generic_ref->ref_root;
-		owner = generic_ref->data_ref.ino;
+		owner = generic_ref->data_ref.objectid;
 		offset = generic_ref->data_ref.offset;
 	}
 	metadata = owner < BTRFS_FIRST_FREE_OBJECTID;
-- 
2.43.0


