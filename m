Return-Path: <linux-btrfs+bounces-10203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AB9EB9D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0807B283A42
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C6214227;
	Tue, 10 Dec 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atPy+8JC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AB214213
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857638; cv=none; b=f2ug3cLcMEhO2roLiyGmJE4xxRZ1d72MqJvdjL6qFmJ5XTl5+0YbjcURXi39Qcbz1dG9URb5oPbMyZfsBql6xTsq+yZJfLqGnzDYHfRjvqBnJzu/SFLMCKKVwzN3ctGSXPeygBOVp7dEcrr0thC2gfton3lfg0yye/wWE+tISVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857638; c=relaxed/simple;
	bh=u9SEzsD1bJdvCYbsjeBjErmtk/VKVnl1hVIWJa9mayc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP5960W785rOOEtRaOgr5Lvgv+9BTg9rWj1SKKeIQtnCZ+PhJBs1e+PjS++KFYqv/oPCGf1PP2wLsA4EHtNnAnKsXPU/2/hqv1I4dDzy1WwkcTwU8NaNsr11q8WV/IArzuVDAgSEa4FLgvbyn+drXEofQ6vPF0lIheUx1ywLAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atPy+8JC; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-843d7f16827so220849039f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857635; x=1734462435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIWsXL+UkpVmQB5Hmm8YTXoe3HdC01zMWfLyVamraQ0=;
        b=atPy+8JCHg4UnsFiG32+yJm8xR7DN5MRfMMtdTTS7ok7S4sUfpl53FFPqwaNTQP+k+
         /bTYV1HU4N0U3qSzuuJChL+R2l8O/RoMtg745gIN/wFWB6wALG6fk1fTWNr3q8n8XatI
         B6544uGU0QqlLtBr9VvWiD64MOstzdZO3KDUEVsxomZslpo/KntZCk127L5sW37o2tAM
         8fY5FLMflJJs83h4su5HQJq5epToAQdz2L00ZLL8mQc+DEn8Jj2nA0GDvImS7A4wz3qT
         b2rLebYyLYwRNSQ19PGSL+MdHhK9x5pEZH70+vMGevBYXBchp6WnrdUFjDxlRA1uI5Xa
         1AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857635; x=1734462435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIWsXL+UkpVmQB5Hmm8YTXoe3HdC01zMWfLyVamraQ0=;
        b=WkJb/PDM1wusN5sucshDUgRNIu+N3LFjCV7iNDfBtNmRT9OTnygA4L+SNjLCNnM9oc
         osYroH/n+rOXG3YtI8uYANzX5TQnO76XZkynFdTuc9gSlF+czt+nduAkHiiDX6AlIKvi
         sWVDQxdMGu5xei+vudGdD+nz992CNF0E0GfSTNVoNSH5LL8we2yYzDoBKKOpuMw9xUBE
         089+YArVYwL7nAT6qOpMUd9+I/SV1SEwJSEkZy8P8XVfFNr1ryB4M2Cd22oBuQP82ub1
         hzg16cVSrU8MAeKhNhNHQ4xLcglD4y7D3ixKVo6fFLEM9S6vYYtuaOtW0VHdGR7qBwsb
         Bl4Q==
X-Gm-Message-State: AOJu0YyDt+Ccs8vyQLgIOhx9AAdZwOnznsuEuIMja1OXn/2/9u1xD9D1
	07j5ZpbL44OgLW9uYwiOI0zXAg/6lESM0sZvj8DBD/nGtr2DaMrhW5K/hA==
X-Gm-Gg: ASbGncu5A9zI6W/LldmbyzsfSAoEwFjrM1PT0/i+iZXZQGGPk9csh4P5/pE2232fKO7
	ZQDI9K128qMw9Mi/DxiIXcWzUOijJCsIXHUIU8AUHDx8FP2Mz4DngDPO+CVRs80d54ATsmUuB75
	ZN/dtLvXARqnjfDlp0NtfnFza9WajMnNXktG3JS/3oDwOIbGO2ExPle+4arcLqWdaUpQE3K5S0K
	Pf0btoXX1oly3pOmGHTJP1bCPVhCNelRdIY/vchwAkttMgj+KeJz4B1A6ZQ+1U=
X-Google-Smtp-Source: AGHT+IFsyINSKnNX/YJZhJVLttdU59Qwni+tzyDt2jgXpqDxnA+zcaDpNNycrMkWMqR2dsgH/XznyA==
X-Received: by 2002:a05:6602:280a:b0:844:cbd0:66cb with SMTP id ca18e2360f4ac-844cbd0689emr31615439f.2.1733857634875;
        Tue, 10 Dec 2024 11:07:14 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:13 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH 3/6] btrfs: edit prelim_ref_insert() to use rb helpers
Date: Tue, 10 Dec 2024 13:06:09 -0600
Message-ID: <f283c3c32d5c69339c04eafa8d996112f9f6f638.1733850317.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733850317.git.beckerlee3@gmail.com>
References: <cover.1733850317.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit edits prelim_ref_insert() in fs/btrfs/backref.c to use
rb_find_add_cached(). It also adds a comparison function for use with
rb_find_add_cached().

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/backref.c | 71 +++++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 6d9f39c1d89c..fcbcfce0f93a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -250,6 +250,17 @@ static int prelim_ref_compare(const struct prelim_ref *ref1,
 	return 0;
 }
 
+static int prelim_ref_cmp(struct rb_node *node, const struct rb_node *exist)
+{
+	int result;
+	struct prelim_ref *ref1 = rb_entry(node, struct prelim_ref, rbnode);
+	struct prelim_ref *ref2 = rb_entry(exist, struct prelim_ref, rbnode);
+
+	result = prelim_ref_compare(ref1, ref2);
+
+	return result;
+}
+
 static void update_share_count(struct share_check *sc, int oldcount,
 			       int newcount, const struct prelim_ref *newref)
 {
@@ -281,52 +292,42 @@ static void prelim_ref_insert(const struct btrfs_fs_info *fs_info,
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct prelim_ref *ref;
-	int result;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	root = &preftree->root;
 	p = &root->rb_root.rb_node;
+	parent = *p;
+	ref = rb_entry(parent, struct prelim_ref, rbnode);
 
-	while (*p) {
-		parent = *p;
-		ref = rb_entry(parent, struct prelim_ref, rbnode);
-		result = prelim_ref_compare(ref, newref);
-		if (result < 0) {
-			p = &(*p)->rb_left;
-		} else if (result > 0) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			/* Identical refs, merge them and free @newref */
-			struct extent_inode_elem *eie = ref->inode_list;
+	exist = rb_find_add_cached(&newref->rbnode, root, prelim_ref_cmp);
+	if (exist != NULL) {
+		/* Identical refs, merge them and free @newref */
+		struct extent_inode_elem *eie = ref->inode_list;
 
-			while (eie && eie->next)
-				eie = eie->next;
+		while (eie && eie->next)
+			eie = eie->next;
 
-			if (!eie)
-				ref->inode_list = newref->inode_list;
-			else
-				eie->next = newref->inode_list;
-			trace_btrfs_prelim_ref_merge(fs_info, ref, newref,
-						     preftree->count);
-			/*
-			 * A delayed ref can have newref->count < 0.
-			 * The ref->count is updated to follow any
-			 * BTRFS_[ADD|DROP]_DELAYED_REF actions.
-			 */
-			update_share_count(sc, ref->count,
-					   ref->count + newref->count, newref);
-			ref->count += newref->count;
-			free_pref(newref);
-			return;
-		}
+		if (!eie)
+			ref->inode_list = newref->inode_list;
+		else
+			eie->next = newref->inode_list;
+		trace_btrfs_prelim_ref_merge(fs_info, ref, newref,
+							preftree->count);
+		/*
+		 * A delayed ref can have newref->count < 0.
+		 * The ref->count is updated to follow any
+		 * BTRFS_[ADD|DROP]_DELAYED_REF actions.
+		 */
+		update_share_count(sc, ref->count,
+					ref->count + newref->count, newref);
+		ref->count += newref->count;
+		free_pref(newref);
+		return;
 	}
 
 	update_share_count(sc, 0, newref->count, newref);
 	preftree->count++;
 	trace_btrfs_prelim_ref_insert(fs_info, newref, NULL, preftree->count);
-	rb_link_node(&newref->rbnode, parent, p);
-	rb_insert_color_cached(&newref->rbnode, root, leftmost);
 }
 
 /*
-- 
2.45.2


