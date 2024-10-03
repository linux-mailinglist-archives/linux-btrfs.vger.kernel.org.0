Return-Path: <linux-btrfs+bounces-8503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE48998F2FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93545280A1D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Oct 2024 15:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227A11AB508;
	Thu,  3 Oct 2024 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Eq+YLkFc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF01D1AAE3E
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Oct 2024 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970207; cv=none; b=Ee3fwqwMxIDRTfNcOuUyprubkk1NHw8CwjQrSQssfWMB4SUYlN0k/qgki93iKP5ba3ObhRxsqHw5yXt+pNKJTxEf5QN8hFlNJ/2NQK/T/AVd2eaZzJ6+Z1Eyn9z3flijYSL5apCzL/0Tmhem6wy3NH8xy9SB3I9j7YX/Au2nTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970207; c=relaxed/simple;
	bh=xfBNQbUeaoE7dKV2f3J13ceE7gb2BQZJBcJ1lwKDZlc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIQjzLYqkPhVwxyuc4+wjHPANa2SRNTa8xMUEtCypTB38yVU0P8z/Fi2iAARXwL5ZIMVfdga/zB9SZeThNASMDPQO10zVkE0XE51p5+tI8tsYplBfZ4KIgON+vUvYWnrhw9/U10YuGC+4kl1Ubvvo363vQznmDgEU8N96R9Vp1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Eq+YLkFc; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso9253126d6.3
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Oct 2024 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727970204; x=1728575004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wy+0tsqwWv1xYobk+o+FQfC/ycfIC20KW0NSUlx+8/0=;
        b=Eq+YLkFc5pOrdJX6/55ArJ1IvZpBkqi4AkEhChjBeSdDc3ZNyrzOIkptXhAGB1xxYh
         XHHlhxl7RC5bER0l12144SlOzIQVMrGndX9oYD0zNeSiTMnETKCooGiAE7gP2edB/rhY
         YCfaOzhX9U6FNsbVPhnsQWIA6MP9q/PKm0eiZl8uZvRT7KjyssDPyrbV7Eo19iXwhL2X
         7qzPXy6//runGwOe6QJTXpGhguMoq86JRRF0F5i32rc55IhlzNrREcxK7DPLPMCy2lwD
         074iXDZpi9THY2V+EZ4YhuhBwjygcCX2xNx06hG5bUjA7OgOOtapBc/eR8PjDf4ZAACP
         8KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970204; x=1728575004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wy+0tsqwWv1xYobk+o+FQfC/ycfIC20KW0NSUlx+8/0=;
        b=O7doMUFmGBn+xk6cBvhiG03VwrRhpLojpxNpEwIhykh5iMnJTeXPxgDSkwTsvYlpko
         S2JwHIGe1OKHjjnnPAtq7KYbaoJKJhMeh2AzdVJ9RCtllwtChul78NARoEzA6VoZt8mN
         fEgUBw4Tbk30V31eOMk+Ckv5DtILCLZegVDnB9RtBfYnEjSyAghmrZuybB+q1Ik6TVKH
         v8xbR2qdL4/iVOkXomAfExDOiJkOFvIBeRikzSigWfiyjFbrwmwxUZrEOFzDitZcb8vd
         Z0QDnWOk+eStElqc2RJYfaeM/rns9zqQdSthLXHBos8wVut8OTcZaDdTao2sCUQoOMPP
         HFqQ==
X-Gm-Message-State: AOJu0YzBdnfRpQDndj8RuGI/AlHt9ZO7l4XhFyJpiDMeMO9J6Icfwa3O
	KartZbGhZeQyEWWAwT/ediUbQwh/9qrWcdRWIa3oTlsxnET87HQbQ0M5b2Nm4I/TBmWzGyf0tcG
	7
X-Google-Smtp-Source: AGHT+IHxgzaCoowcgWQnUF+2p/kC86JfOIcvwz07EA5Wd8JYCnNRwkuuIOxY/wabOg7JjuyG46jHdg==
X-Received: by 2002:ad4:5285:0:b0:6cb:8267:4a0e with SMTP id 6a1803df08f44-6cb82674c41mr87390716d6.0.1727970204424;
        Thu, 03 Oct 2024 08:43:24 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb935cd5a3sm7539436d6.43.2024.10.03.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:43:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 04/10] btrfs: cleanup select_reloc_root
Date: Thu,  3 Oct 2024 11:43:06 -0400
Message-ID: <fe72732de97d83d6f5b649fce1642019e78de981.1727970063.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727970062.git.josef@toxicpanda.com>
References: <cover.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have this setup as a loop, but in reality we will never walk back up
the backref tree, if we do then it's a bug.  Get rid of the loop and
handle the case where we have node->new_bytenr set at all.  Previous the
check was only if node->new_bytenr != root->node->start, but if it did
then we would hit the WARN_ON() and walk back up the tree.

Instead we want to just freak out if ->new_bytenr is set, and then do
the normal updating of the node for the reloc root and carry on.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 144 ++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 83 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ac3658dce6a3..6b2308671d83 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2058,97 +2058,75 @@ struct btrfs_root *select_reloc_root(struct btrfs_trans_handle *trans,
 	int index = 0;
 	int ret;
 
-	next = node;
-	while (1) {
-		cond_resched();
-		next = walk_up_backref(next, edges, &index);
-		root = next->root;
+	next = walk_up_backref(node, edges, &index);
+	root = next->root;
 
-		/*
-		 * If there is no root, then our references for this block are
-		 * incomplete, as we should be able to walk all the way up to a
-		 * block that is owned by a root.
-		 *
-		 * This path is only for SHAREABLE roots, so if we come upon a
-		 * non-SHAREABLE root then we have backrefs that resolve
-		 * improperly.
-		 *
-		 * Both of these cases indicate file system corruption, or a bug
-		 * in the backref walking code.
-		 */
-		if (!root) {
-			ASSERT(0);
-			btrfs_err(trans->fs_info,
-		"bytenr %llu doesn't have a backref path ending in a root",
-				  node->bytenr);
-			return ERR_PTR(-EUCLEAN);
-		}
-		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
-			ASSERT(0);
-			btrfs_err(trans->fs_info,
-	"bytenr %llu has multiple refs with one ending in a non-shareable root",
-				  node->bytenr);
-			return ERR_PTR(-EUCLEAN);
-		}
+	/*
+	 * If there is no root, then our references for this block are
+	 * incomplete, as we should be able to walk all the way up to a block
+	 * that is owned by a root.
+	 *
+	 * This path is only for SHAREABLE roots, so if we come upon a
+	 * non-SHAREABLE root then we have backrefs that resolve improperly.
+	 *
+	 * Both of these cases indicate file system corruption, or a bug in the
+	 * backref walking code.
+	 */
+	if (!root) {
+		ASSERT(0);
+		btrfs_err(trans->fs_info,
+			  "bytenr %llu doesn't have a backref path ending in a root",
+			  node->bytenr);
+		return ERR_PTR(-EUCLEAN);
+	}
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
+		ASSERT(0);
+		btrfs_err(trans->fs_info,
+			  "bytenr %llu has multiple refs with one ending in a non-shareable root",
+			  node->bytenr);
+		return ERR_PTR(-EUCLEAN);
+	}
 
-		if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
-			ret = record_reloc_root_in_trans(trans, root);
-			if (ret)
-				return ERR_PTR(ret);
-			break;
-		}
-
-		ret = btrfs_record_root_in_trans(trans, root);
+	if (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID) {
+		ret = record_reloc_root_in_trans(trans, root);
 		if (ret)
 			return ERR_PTR(ret);
-		root = root->reloc_root;
-
-		/*
-		 * We could have raced with another thread which failed, so
-		 * root->reloc_root may not be set, return ENOENT in this case.
-		 */
-		if (!root)
-			return ERR_PTR(-ENOENT);
-
-		if (next->new_bytenr != root->node->start) {
-			/*
-			 * We just created the reloc root, so we shouldn't have
-			 * ->new_bytenr set yet. If it is then we have multiple
-			 *  roots pointing at the same bytenr which indicates
-			 *  corruption, or we've made a mistake in the backref
-			 *  walking code.
-			 */
-			ASSERT(next->new_bytenr == 0);
-			if (next->new_bytenr) {
-				btrfs_err(trans->fs_info,
-	"bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
-					  node->bytenr, next->bytenr);
-				return ERR_PTR(-EUCLEAN);
-			}
-
-			next->new_bytenr = root->node->start;
-			btrfs_put_root(next->root);
-			next->root = btrfs_grab_root(root);
-			ASSERT(next->root);
-			mark_block_processed(rc, next);
-			break;
-		}
-
-		WARN_ON(1);
-		root = NULL;
-		next = walk_down_backref(edges, &index);
-		if (!next || next->level <= node->level)
-			break;
+		goto found;
 	}
-	if (!root) {
-		/*
-		 * This can happen if there's fs corruption or if there's a bug
-		 * in the backref lookup code.
-		 */
-		ASSERT(0);
+
+	ret = btrfs_record_root_in_trans(trans, root);
+	if (ret)
+		return ERR_PTR(ret);
+	root = root->reloc_root;
+
+	/*
+	 * We could have raced with another thread which failed, so
+	 * root->reloc_root may not be set, return ENOENT in this case.
+	 */
+	if (!root)
 		return ERR_PTR(-ENOENT);
+
+	if (next->new_bytenr) {
+		/*
+		 * We just created the reloc root, so we shouldn't have
+		 * ->new_bytenr set yet. If it is then we have multiple
+		 * roots pointing at the same bytenr which indicates
+		 * corruption, or we've made a mistake in the backref
+		 * walking code.
+		 */
+		ASSERT(next->new_bytenr == 0);
+		btrfs_err(trans->fs_info,
+			  "bytenr %llu possibly has multiple roots pointing at the same bytenr %llu",
+			  node->bytenr, next->bytenr);
+		return ERR_PTR(-EUCLEAN);
 	}
 
+	next->new_bytenr = root->node->start;
+	btrfs_put_root(next->root);
+	next->root = btrfs_grab_root(root);
+	ASSERT(next->root);
+	mark_block_processed(rc, next);
+found:
 	next = node;
 	/* setup backref node path for btrfs_reloc_cow_block */
 	while (1) {
-- 
2.43.0


