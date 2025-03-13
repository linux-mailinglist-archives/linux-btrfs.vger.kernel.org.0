Return-Path: <linux-btrfs+bounces-12254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CDDA5EB38
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 06:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CFA1896416
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A51F0996;
	Thu, 13 Mar 2025 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iARlf5tw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D922E3395
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 05:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844126; cv=none; b=gKNC54L+ILZ+SRTAjHgibXT2qpDya1zgHIjTMUKO3kIrWNw0w5/Zm0LdRfhHZCIKxsrB/iBlEklgVFRWwrQErAaMUf0gF4Xy6gZLpsp+Ko6AKcjsKgcAGmf8Z0hWPm+Xo0Dx9Yjz/NmCPtaEUVewtj0fiCu2P3WXfQbGaiO3Qgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844126; c=relaxed/simple;
	bh=sLHSI/jpCnCB4kAqzkZaev8zI+KHdSEcRk0krqKu6gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O0bxwa8K5NVnIfnaFJdvV5Y92isibyuVNGpiifrUG9KdB9eV9RYb2LX7MfVueaFIb9O2YhIkVhPQjGMExmxVuipFsxuMd+HqrPTJUZA+rtM40L65U0WlcsXyVm0LK5eAvwVske9JUtn6c5oroOQFOo1rprsMLpLsxRgTAeTp7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iARlf5tw; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2ff7cf59a8fso154333a91.3
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Mar 2025 22:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741844123; x=1742448923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28+pHXvyG/HkanotYHqhMMpJsQZ+d0B6C/3Dn6hJjYo=;
        b=iARlf5twywdLXvtFVLWW0Ke/bPwTaRZqp+N410R8dCMfXCf59oWtWxc4zf/z18Hvih
         wduC1rn8lG7lf3T3II8I7fHh8SaEPyRyxl0mm+x3AwaBF3XruoUED6RGSubtjNRLrPi2
         e8dGyb2ZaoWiICl1NvHzXHkBSXEDN+LQkNjEJ1Y+hnFSMc6z2sVLTzGFSi1pj+SpQQ+a
         v+sz4iBJ5dfqf+PPj2TBJ44+mou62bz1GxcXHTBVcUB/nJe/4+gjFu+kHivfIBNTWhya
         YG04qJnHz1GY0u2vvaI8VJQf0FvvjCUYO/wsNUlOXkJ9T6EwD3NrGQmmP5+O7FGak3vn
         PH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741844123; x=1742448923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28+pHXvyG/HkanotYHqhMMpJsQZ+d0B6C/3Dn6hJjYo=;
        b=mic1l0Sn5CiZ1vB0PZn7uTBFatCt0lQQ0N6L0F5AnoEpyMIlQd0eExWxn/uL//c/jT
         1f+Ub2DUfd8ouu5hUbEaQz1zukASIr9eDzVk+Fd77r1DPufJbmkI+KhhbBxGH57wUKOi
         f9MFJ3PH9OGvd1tjwud75zoJJogP4o3Mp4SZUIPRDaYUhZ8OMSAMpGKXeudX7DW2UtFn
         Ge8/due0shiLh9cSkiQDIrIlVuYryWtL2toflaYIR8kXPXhIT3ludUzG1a905O7HlXAO
         26IjqMrWFIv0F8AXNkliwlzsmaAYXYB+1WK4fjPwxpVZZsixKG7DZ1LfrAEOH/oOyRVp
         zBdQ==
X-Gm-Message-State: AOJu0YxyVnR/Hg7gdFiYjQFBQIuhKdUPbHY6DC5R2ahVfGuQ2ZXyEgC/
	QMnWG8q5M7cOswVSqjLOeZn+3LraRd6WTo5+ZD1NDMyIneILtsuEdlwVcD4/0N87PA==
X-Gm-Gg: ASbGncuJVHfs+xoDrIlbOhg2PIOKvfE0GVhnED6Yap9HnA843rdgnmiLHRDH4/p00wm
	LMXBPakCZB6RsqN5EB6Rr4YHCg9EG5DV0MGQJSStf/uLf8R1ETWpWMsB2D4sh9qyOikh47Lj4Hd
	pNVuxP9/V/6WYA8N8YXj4AgJcA4BJJxWnJQzAN8xWIoPxP5aFppZCrSbqZojwdkmr7HDHd9lN6L
	7e/BDx8zs526qlfzd4VCv0NG7rYaOFA3LDw7bP3kMH812syC2f4kLgCDuG2ZT4ustQ5yjvM+opY
	xhMWIqQQ6fZHfb39mVCZdvvbH7ur++IjSgMU2D071VRaqGo=
X-Google-Smtp-Source: AGHT+IE18/pqMR2jDguHWyUytg9UJOSTGCJmF8CZ2GiiHCrdg9HUjK5I/u3XHt0nhSk+8WTTDK5BMw==
X-Received: by 2002:a05:6a20:2d23:b0:1f3:3112:d201 with SMTP id adf61e73a8af0-1f58cad32f7mr5844800637.1.1741844123560;
        Wed, 12 Mar 2025 22:35:23 -0700 (PDT)
Received: from SaltyKitkat.. ([198.176.54.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9ddb52sm478126a12.19.2025.03.12.22.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 22:35:23 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: fix nonzero lowest level handling in btrfs_search_forward()
Date: Thu, 13 Mar 2025 13:34:14 +0800
Message-ID: <20250313053509.31946-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
checksums during truncate") changed the condition from `level == 0` to
`level == path->lowest_level`, while its origional purpose is just to do
some leaf nodes handling (calling btrfs_item_key_to_cpu()) and skip some
code that doesn't fit leaf nodes.

After changing the condition, the code path
1. also handle the non-leaf nodes when path->lowest_level is nonzero,
   which is wrong. However, it seems that btrfs_search_forward() is never
   called with a nonzero path->lowest_level, which makes this bug not
   found before.
2. makes the later if block with the same condition, which is origionally
   used to handle non-leaf node (calling btrfs_node_key_to_cpu()) when
   lowest_level is not zero, dead code.

So Use if conditions to skip the non-leaf handling code instead of using
goto to make it more clear, and handle both leaf and non-leaf node in the
lowest_level loop exit logic.

This changes the behavior when btrfs_search_forward() is called with
nonzero path->lowest_level. But this never happens in the current code
base, and the previous behavior is wrong. So the change of behavior will
not be a problem.

Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only checksums during truncate")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c982960d8a91..77e33120c3f7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4637,38 +4637,28 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			goto out;
 		}
 
-		/* at the lowest level, we're done, setup the path and exit */
-		if (level == path->lowest_level) {
-			if (slot >= nritems)
-				goto find_next_key;
-			ret = 0;
-			path->slots[level] = slot;
-			/* Save our key for returning back. */
-			btrfs_item_key_to_cpu(cur, min_key, slot);
-			goto out;
-		}
-		if (sret && slot > 0)
+		/*
+		 * Not at the lowest level and not a perfect match,
+		 * go back a slot if possible to search lower level.
+		 */
+		if (sret && slot > 0 && level > path->lowest_level)
 			slot--;
 		/*
-		 * check this node pointer against the min_trans parameters.
+		 * Check this node pointer against the min_trans parameters.
 		 * If it is too old, skip to the next one.
 		 */
-		while (slot < nritems) {
-			u64 gen;
-
-			gen = btrfs_node_ptr_generation(cur, slot);
-			if (gen < min_trans) {
+		if (level > 0) {
+			while (slot < nritems) {
+				if (btrfs_node_ptr_generation(cur, slot) >= min_trans)
+					break;
 				slot++;
-				continue;
 			}
-			break;
 		}
-find_next_key:
+		path->slots[level] = slot;
 		/*
-		 * we didn't find a candidate key in this node, walk forward
-		 * and find another one
+		 * We didn't find a candidate key in this node, walk forward
+		 * and find another one.
 		 */
-		path->slots[level] = slot;
 		if (slot >= nritems) {
 			sret = btrfs_find_next_key(root, path, min_key, level,
 						  min_trans);
@@ -4679,12 +4669,16 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
+		/* At the lowest level, we're done. Set the key and exit. */
 		if (level == path->lowest_level) {
 			ret = 0;
-			/* Save our key for returning back. */
-			btrfs_node_key_to_cpu(cur, min_key, slot);
+			if (level == 0)
+				btrfs_item_key_to_cpu(cur, min_key, slot);
+			else
+				btrfs_node_key_to_cpu(cur, min_key, slot);
 			goto out;
 		}
+		/* Search down to a lower level. */
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
-- 
2.48.1


