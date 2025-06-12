Return-Path: <linux-btrfs+bounces-14623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A7AD6AE7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC057A3112
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7FE21C9E8;
	Thu, 12 Jun 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlXjEAbD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E4EC2
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717346; cv=none; b=fMmiQCZf5QVHyK3gCvsP5wK+yynHQlr23nC06z9/1kvvtxhUTm1f7C64xeIAMtg2fa50IRc3NrTac5vYl2M8ypkyrzAGnxktFR/Qqh2mEt/MCrwo2Sltto/U4aynue+UASDGQ6CNwDGJgwLU+cda/bcY0d93rvKQBpH910nT+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717346; c=relaxed/simple;
	bh=z9lpIugVtbwE94RMgNdzT8cIjn+EH02wPInhGtDkd0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lreUFp38bEq0P6ah6QAvZHhgnvnYCS0uoJJ6uABkR6rCr6u/jBYCj+efhwQob04aEtFLKHihRtvhADRlWHYn2HhwB+zxwU+tqzw7XSVnwUz+K5MAiKYcZJvVF7hVW7PtYocHeeQqHrebt7ryfa3j/JYuE6pQpsKXPsr9t7tFxVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlXjEAbD; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6f0eb824f51so522196d6.0
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717344; x=1750322144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCiXEBreuiCN32H87HYJsVXpouAWFN8i8X3eNeosjJM=;
        b=hlXjEAbDrTeyGaUgodjjKGEFqMcDjfXqcx3Qha+igao+W9BkSC9ik37Au5k3ZffmOV
         L+bqIx+MOqDSehJ/5o3Qb747DuXkvv6B/V+qA8vgLlceKGYaahM9G57F2HojATcLZ8p4
         EA3+A6Ns0SYQm1FXrEf5aq/GsUYStf8vIvWeVEnuLQQ2jL5TpdCJSynh1t1h5DGfdqfW
         6Knm98s6PMoSbV44hkKb1EXuefvW2wesYk225WDcKieXBCA3JBcEU/2K4thTo/VljnSE
         d49uofmw3M5yZuX3xU01npYHlJBLWkZ/5c0DD1RemBeqhA+J64nFOF0jc6tbkS8E2x7y
         Es6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717344; x=1750322144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCiXEBreuiCN32H87HYJsVXpouAWFN8i8X3eNeosjJM=;
        b=NUeVNiJoRru7pSCISomlIE2tY23HfYrt5jGJx1JrOxgnwP8XpUdNtXnLRiEryyn0+8
         kcQAR1jBQWd5eivaKd0Dsdq08Sa8K0bGuZRNK8MyJHBjmOo1GRevoI0k13wM9ECyRA/t
         RwQWg4k1K6aLfZEaiPzYD2hftiWkPujFgruLn56Zhb+Z7TLUfApNN9UIZgTuLi2wIrlK
         lmQ1A5CCCZ0D3hYeKRAQeH3HOkBQH3Iwv/CtLRck1GAre32weY1NoknvMRixHDIixr2V
         x1GCaDiQwcjScGZ2wzbN4cq/uK/hQ5KAp8ur2QPXrm0huDTJAqKc6QYm1nXmSPa2TCzx
         IJbg==
X-Gm-Message-State: AOJu0YxARWHyLdxYpcpk7ffCidIRFja5/HHWyC8Vl5M8uVmng2N4hZK0
	m+dZ5KIzFX/SbWvHgPEEpbAg9YPzilXsAn6ixrL/xdAwyVZqJ64Kc7p3QbSAXfM24ZYIug==
X-Gm-Gg: ASbGncusmzvnMMMuYIhMEh94V1Knego/JYQ3H4LdrlzI9dH0OrCmvlPi4TlrrN0Uv2Z
	aBI3IP2rC+a+HiuZoPUXw+XOEIA2MOfI2UXUkBX5Qq6Q5KwpXRUPuc7pr+j/+0vfd+l2m3f5iJR
	P+/faBY94oFaKb8pHdE330iGS0nFi/2rK0p7ypg/j+WexYAowU6TgJkWYQeXosvwFtpJNNzsHZr
	p5zshiNGwgv9Xoxq2mKEA1L5Ww2oipeOmXxlkE32fEb/Hhk58t7hHN1h4kpv1lc/tR6A2yMWOJP
	E62e2UVyuJIdApCUEAZBYurNYrXCLqLrGazf/85tLoM8URh5hK2dsfRxaLLW1g==
X-Google-Smtp-Source: AGHT+IGLwhn9qVVrxcoGaVSc9a54Al/QsuFzJpmNK73dlfCvn9UyrDd7+AP7aDAiPu3ITI9X/5bpYg==
X-Received: by 2002:a05:620a:400e:b0:7c0:b3cd:9be0 with SMTP id af79cd13be357-7d3a883eeb4mr355120985a.10.1749717343874;
        Thu, 12 Jun 2025 01:35:43 -0700 (PDT)
Received: from SaltyKitkat.. ([154.3.36.122])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8dc9b6esm18294785a.6.2025.06.12.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:35:43 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v3] btrfs: fix nonzero lowest level handling in btrfs_search_forward()
Date: Thu, 12 Jun 2025 16:32:23 +0800
Message-ID: <20250612083522.24878-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.49.0
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

This changes the behavior when btrfs_search_forward() is called with
nonzero path->lowest_level. But this never happens in the current code
base, and the previous behavior is wrong. So the change of behavior will
not be a problem.

Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only checksums during truncate")
Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2e7979372cc..56a49d85b2a4 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4585,16 +4585,13 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 /*
  * A helper function to walk down the tree starting at min_key, and looking
- * for nodes or leaves that are have a minimum transaction id.
+ * for leaves that are have a minimum transaction id.
  * This is used by the btree defrag code, and tree logging
  *
  * This does not cow, but it does stuff the starting key it finds back
  * into min_key, so you can call btrfs_search_slot with cow=1 on the
  * key and get a writable path.
  *
- * This honors path->lowest_level to prevent descent past a given level
- * of the tree.
- *
  * min_trans indicates the oldest transaction that you are interested
  * in walking through.  Any nodes or leaves older than min_trans are
  * skipped over (without reading them).
@@ -4615,6 +4612,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 	int keep_locks = path->keep_locks;
 
 	ASSERT(!path->nowait);
+	ASSERT(path->lowest_level == 0);
 	path->keep_locks = 1;
 again:
 	cur = btrfs_read_lock_root_node(root);
@@ -4636,8 +4634,8 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 			goto out;
 		}
 
-		/* at the lowest level, we're done, setup the path and exit */
-		if (level == path->lowest_level) {
+		/* at the level 0, we're done, setup the path and exit */
+		if (level == 0) {
 			if (slot >= nritems)
 				goto find_next_key;
 			ret = 0;
@@ -4678,12 +4676,6 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 				goto out;
 			}
 		}
-		if (level == path->lowest_level) {
-			ret = 0;
-			/* Save our key for returning back. */
-			btrfs_node_key_to_cpu(cur, min_key, slot);
-			goto out;
-		}
 		cur = btrfs_read_node_slot(cur, slot);
 		if (IS_ERR(cur)) {
 			ret = PTR_ERR(cur);
@@ -4699,7 +4691,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
 out:
 	path->keep_locks = keep_locks;
 	if (ret == 0)
-		btrfs_unlock_up_safe(path, path->lowest_level + 1);
+		btrfs_unlock_up_safe(path, 1);
 	return ret;
 }
 
-- 
2.49.0


