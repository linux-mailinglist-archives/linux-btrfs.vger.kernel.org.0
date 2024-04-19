Return-Path: <linux-btrfs+bounces-4442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9392C8AB4F1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 20:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B6285CE4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Apr 2024 18:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD113C911;
	Fri, 19 Apr 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qrCF/X4O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5513C69B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550642; cv=none; b=lUMoDFniw57Z8mwhxltnQExWlfSqdjdNZtdBffuxqW8keScmQhxtJoqmN+udlbnlvNGjn0LpWgieQAtSO2d9prTLPFrcUM+H2WLKVbHhR6cFbxzIjy8KsEBVwpyp4yMC9ltGi0mmBkcRpK7zKpcCjpwaH7Fq8QAr9Y+VQUMB0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550642; c=relaxed/simple;
	bh=nc2okafF/XhO8W9guLBOEqcBaz2Fd+XQKkbH9SKhqu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dettRKVF1hnr5HBTzCurLDui5WO93+FyQ0IAR5U2/1HdCh7vm9o/0UqDhD+i1U+uj6QiPXBLZwW6eoHf4mCGF6j5CnVEJ12hQloetyw8uqhzNiEIQdH0DDbTjzh5fmgXw7c4PExRtAbb+fCRw5AutZOnZfAjaG9pfYZkTQuBV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qrCF/X4O; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa2551d33dso1360275eaf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Apr 2024 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713550639; x=1714155439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=us8RMZv1QlZ/NsV2TLxfCp7jngBrjzcwfxtMS/16V0M=;
        b=qrCF/X4OXNRHwhcVBi3IxE8U4FXPVEwMXlfOtplrri854T6K4rAyw7fZDyMmV+Dln9
         FOuj8G/KZTZ4MCZ+7+ilMq1YZwNFuk+lYtLeMniYjsWFvepZ933aYOuy3/XvbLi+uQ8c
         H0hn3bCDUoyuLSmn8vDRfBfckXAN7l0T8sk7Su/mhYz11fwqQFSXD5e6RaiHzzRbeIl4
         m4IzoSObNCpk2/m5sWICUnLixwDcUxmj1bFpNL54YoPFus4vj4MmnPcLSHXeP9JMZKhl
         j5wg1vAA6/aKD61UQBuELtssCbLIijz0GtQ4hiTo11GtvVgIUpAZq5LzeoocXuor/kJh
         K2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550639; x=1714155439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=us8RMZv1QlZ/NsV2TLxfCp7jngBrjzcwfxtMS/16V0M=;
        b=DNRwCCMiCBmAoj0x6OqkYMbcm8cRtfQUV5jmxAIJirGHeus/gT/cfzpch8uIwh7vtx
         RLXEpCWHxVFrRJOSRCl/LAkuDT8lQu7PC5ageUL7aWs0SuCDbzOyBcib7KHB23KCGqBz
         qbw4OKH1X8gH4i59cC7dpBakjftdi6oej6G4kJN1mYAopmrgew+0u67r3e7pP2ZFf55W
         bbjJ457R2wcIlX19iH8tQp2m9fJ+hHejVKDaxmB0kkp/dz7flKfJ0rsFLpwCvaPBaGvz
         SoPMq7VCskZFlCBejYf6rp1tKDcXBSv1/n05vWApaH4mHsAAyU3g0Qg7+FkGntdoESDY
         RCPw==
X-Gm-Message-State: AOJu0YxZVd8GFRskQtjfKAkPoByfU7ekBVgF9jFHv6YxAwORfBK0YL4V
	4Exqr8iJKs6yJM1f4/niJvzztF3xuLVjy3CSN6r4FBxSkKlY92KB528TCpSxnvHZyvDoTtX3qGY
	u
X-Google-Smtp-Source: AGHT+IHlQEQbsh9qHjcCbt5z+Ik/n+eGb1OKG50XjyWNVc3pix5nrbtplqeYgenJGlzGlgn/6vJh8g==
X-Received: by 2002:a05:6359:4e85:b0:183:a47e:6284 with SMTP id os5-20020a0563594e8500b00183a47e6284mr3185111rwb.5.1713550639661;
        Fri, 19 Apr 2024 11:17:19 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t10-20020a0cc44a000000b006915ae114efsm1762378qvi.52.2024.04.19.11.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:17:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 04/15] btrfs: push lookup_info into walk_control
Date: Fri, 19 Apr 2024 14:16:59 -0400
Message-ID: <52e6da7480af222872e563032e8089ba07306d09.1713550368.git.josef@toxicpanda.com>
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

Instead of using a flag we're passing around everywhere, add a field to
walk_control that we're already passing around everywhere and use that
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b8ef918ee440..0ebbad032c73 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5221,6 +5221,7 @@ struct walk_control {
 	int reada_slot;
 	int reada_count;
 	int restarted;
+	int lookup_info;
 };
 
 #define DROP_REFERENCE	1
@@ -5317,7 +5318,7 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 				   struct btrfs_root *root,
 				   struct btrfs_path *path,
-				   struct walk_control *wc, int lookup_info)
+				   struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int level = wc->level;
@@ -5332,7 +5333,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	 * when reference count of tree block is 1, it won't increase
 	 * again. once full backref flag is set, we never clear it.
 	 */
-	if (lookup_info &&
+	if (wc->lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
 		BUG_ON(!path->locks[level]);
@@ -5424,7 +5425,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 				 struct btrfs_root *root,
 				 struct btrfs_path *path,
-				 struct walk_control *wc, int *lookup_info)
+				 struct walk_control *wc)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 bytenr;
@@ -5446,7 +5447,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	 */
 	if (wc->stage == UPDATE_BACKREF &&
 	    generation <= root->root_key.offset) {
-		*lookup_info = 1;
+		wc->lookup_info = 1;
 		return 1;
 	}
 
@@ -5478,7 +5479,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		ret = -EIO;
 		goto out_unlock;
 	}
-	*lookup_info = 0;
+	wc->lookup_info = 0;
 
 	if (wc->stage == DROP_REFERENCE) {
 		if (wc->refs[level - 1] > 1) {
@@ -5516,7 +5517,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			return ret;
 		}
 		btrfs_tree_lock(next);
-		*lookup_info = 1;
+		wc->lookup_info = 1;
 	}
 
 	level--;
@@ -5605,7 +5606,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 			goto out_unlock;
 	}
 no_delete:
-	*lookup_info = 1;
+	wc->lookup_info = 1;
 	ret = 1;
 
 out_unlock:
@@ -5739,11 +5740,11 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
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
 
@@ -5754,7 +5755,7 @@ static noinline int walk_down_tree(struct btrfs_trans_handle *trans,
 		    btrfs_header_nritems(path->nodes[level]))
 			break;
 
-		ret = do_walk_down(trans, root, path, wc, &lookup_info);
+		ret = do_walk_down(trans, root, path, wc);
 		if (ret > 0) {
 			path->slots[level]++;
 			continue;
-- 
2.43.0


