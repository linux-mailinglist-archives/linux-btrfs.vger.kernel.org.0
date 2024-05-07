Return-Path: <linux-btrfs+bounces-4806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE768BEB54
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E144AB29C74
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A916D4EE;
	Tue,  7 May 2024 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SzTrNn4r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D016D330
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105550; cv=none; b=jQT4uF4xp5ZoEK0IhvzWcpptJWvoocQTOngn2YDKlEaCACYTgdh+LG2xtLRHMPEZoQfafx7H1Y21Ji5/8o3XR12PPElkaygncZ5o2uLrpmGonXpxoP41of/ZvxzC8wV9d1P+T5l9ENIqfTmbdMDVcaZIuBOobjvX4Lcd+ZbNZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105550; c=relaxed/simple;
	bh=fYq78qYTSQ/+Y+QM3pFr52t3obwjC6nncoDUrZbsqLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKEgKk6fBNXH5cco/MmLRDQ0c5FrgVynLJurlMPG8ODzYRW9CuRoh0MOD8HzHWjEGzf+sHxqA74hpQiq3AEuAJ9UPHojwwS5lS6zgH+bXepDbFWsv12P206wJvNmyeOCmlFsKc6r+y8QxSEfGQ3LkrkB/V/eWEShXbntGUllukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SzTrNn4r; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c97066a668so794304b6e.0
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105547; x=1715710347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUMgMR07HOPlAJJcrUpT3nPIaH1wKehtqfxgaAiuFec=;
        b=SzTrNn4rLbGOci3YjSLPPCUAbUSTrkUGpjIVRHkKSJ2x6e7xTEuiFdxARIl89gB/vN
         +N2TChXdKZnO5fNK0YNzbJcRynmQuwI3UnZYquqHDAE00TygjmhPgN8D1SCfkJRt2tqa
         sVA/pgyKGlNoVw4e0UqETKeGqNiqSdu9I2z+oG31xqYKVwOIGFOVzJYISBHkfy1RabUa
         49IL8YfkzApznlx9hVRjo7I24G58NBNopqO3KYBLC/ZxYZfp6BQIUf0kihzfGOzljceJ
         e9VJe+8pIycnB6RP1f+/AsbwMzC3MO3ZmZYmuSMBYwyo8BLVNKI51gU+Wu24e4NusNzx
         CT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105547; x=1715710347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUMgMR07HOPlAJJcrUpT3nPIaH1wKehtqfxgaAiuFec=;
        b=DFd9dW9gpTHCTCxbmiIKuQXaexbSpYVcL96iwUWsNbk/JFOiX/G3dYFhp3fzAtOGxw
         TMK0tipSpi/dquNuRxsG6Yg2FqcBJwHejhvHtdxAkjaFBB+iyfn1NXLhgAyBHa8OAhdF
         q4fjAqKj2YNN24F2solEJZ+96vHPXOqNQ3ocUmfL9X8WyqD+94pXMSrbBfSQIyZdeD/p
         znmUa5meeWmZBampRuKU5FAkMulJKh4Q0XutaCxZsb2U7DV1N5g5pbC/BKavhDvGygiD
         ZOkV6j9y5jkHwUowA6/83WHvkCmUui3J/wFJQ6UkIdlXj9HllfJpbgFhUpccdyquuboC
         Ziow==
X-Gm-Message-State: AOJu0Yw4tQ3UnA7suAhEqEJoe0/fGWStvGB5695DaIg0TYqsly2X45Mp
	+2nwTT8P8Oh3FGORBcYNLmOsHoC9u4SqcEvvi0Yy/BaNShcwcEh5pS7IiPBvHUNX1hG1cCzuPgr
	i
X-Google-Smtp-Source: AGHT+IFwADdKRi8h/TQuy1QOP2ccM/nyeofqOSL+x+j5RZ0GdgfLHkQWuy/jJk6uD9PA6Dj/Q/lqhw==
X-Received: by 2002:aca:1308:0:b0:3c8:62c4:f44c with SMTP id 5614622812f47-3c9853066e8mr341207b6e.36.1715105547538;
        Tue, 07 May 2024 11:12:27 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w13-20020a25918d000000b00de6134b2c3esm2693468ybl.24.2024.05.07.11.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 04/15] btrfs: push lookup_info into walk_control
Date: Tue,  7 May 2024 14:12:05 -0400
Message-ID: <b992b63c3a90a2234f7ea77feb66c663137d4747.1715105406.git.josef@toxicpanda.com>
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

Instead of using a flag we're passing around everywhere, add a field to
walk_control that we're already passing around everywhere and use that
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fa59a0b5bc2d..1d59764f58b4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5220,6 +5220,7 @@ struct walk_control {
 	int reada_slot;
 	int reada_count;
 	int restarted;
+	int lookup_info;
 };
 
 #define DROP_REFERENCE	1
@@ -5316,7 +5317,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct btrfs_path *path,
-				   struct walk_control *wc, int lookup_info)
+				   struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int level = wc->level;
@@ -5331,7 +5332,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	 * when reference count of tree block is 1, it won't increase
 	 * again. once full backref flag is set, we never clear it.
 	 */
-	if (lookup_info &&
+	if (wc->lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
 		BUG_ON(!path->locks[level]);
@@ -5423,7 +5424,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root,
 				 struct btrfs_path *path,
-				 struct walk_control *wc, int *lookup_info)
+				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 bytenr;
@@ -5445,7 +5446,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	 */
 	if (wc->stage == UPDATE_BACKREF &&
 	    generation <= root->root_key.offset) {
-		*lookup_info = 1;
+		wc->lookup_info = 1;
 		return 1;
 	}
 
@@ -5477,7 +5478,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		ret = -EIO;
 		goto out_unlock;
 	}
-	*lookup_info = 0;
+	wc->lookup_info = 0;
 
 	if (wc->stage == DROP_REFERENCE) {
 		if (wc->refs[level - 1] > 1) {
@@ -5515,7 +5516,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			return ret;
 		}
 		btrfs_tree_lock(next);
-		*lookup_info = 1;
+		wc->lookup_info = 1;
 	}
 
 	level--;
@@ -5604,7 +5605,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			goto out_unlock;
 	}
 no_delete:
-	*lookup_info = 1;
+	wc->lookup_info = 1;
 	ret = 1;
 
 out_unlock:
@@ -5738,11 +5739,11 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 				   struct walk_control *wc)
 {
 	int level = wc->level;
-	int lookup_info = 1;
 	int ret = 0;
 
+	wc->lookup_info = 1;
 	while (level >= 0) {
-		ret = walk_down_proc(trans, root, path, wc, lookup_info);
+		ret = walk_down_proc(trans, root, path, wc);
 		if (ret)
 			break;
 
@@ -5753,7 +5754,7 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 		    btrfs_header_nritems(path->nodes[level]))
 			break;
 
-		ret = do_walk_down(trans, root, path, wc, &lookup_info);
+		ret = do_walk_down(trans, root, path, wc);
 		if (ret > 0) {
 			path->slots[level]++;
 			continue;
-- 
2.43.0


