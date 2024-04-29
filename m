Return-Path: <linux-btrfs+bounces-4607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9388B59EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF241C222F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33826CDA9;
	Mon, 29 Apr 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="qumU3vWj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738C471745
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397402; cv=none; b=FHitYPMb+Vv1AEzYoxCr3Ku5O5bzvP3vTxlJEETEASgVUG0PrMSBQ+Cw2X+8VOLaG+LE2rL3GQm4em6Hh9aTmEqVI31bTSL1bHIMfa/yxW8xAvpLmYmOt9A8tEe9F238x/v0UXNhtlvHuLsevUg3Qvd3jfCkm4Xl+JkBK9GuH/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397402; c=relaxed/simple;
	bh=fYq78qYTSQ/+Y+QM3pFr52t3obwjC6nncoDUrZbsqLc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMP61VJiwxcZDN0TzTiprE/14vOujsdiKNdC2JGV6so+3LaP3CGjFSaSICE+c7abREA8L9+Ot0dh4uZnzyB1id79A70Oj4v2QSfDaBOOrEnKXHSyeob3Rj5FBUS/ddyTtHpcNW/iNB8dSaRlsdvxN2idJeAETXsfxGaCqn61Oow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=qumU3vWj; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5af23552167so2908196eaf.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 06:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1714397400; x=1715002200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUMgMR07HOPlAJJcrUpT3nPIaH1wKehtqfxgaAiuFec=;
        b=qumU3vWjn0SAIvQVgIL0TGyp/oG3X0+Lcd3bPcG2G9/Jc1hDysXGvNVWc8utYvqoGT
         dMgavSYaj8WDBOC+0oKy5vWqZV6nDUFoAT/gGKIpBHlIIG+M6pBIImZ3I8+vLbb+NREG
         Z2LOZqCF4UFFJD4C/Ghl2NeoJYhupchvq/3EGFgwyMkF+3hYTeTYD55X6ChFVeZBjbYw
         Ub84qR4NBUT3RjuIXIU8LhvLlbCxPgN1dtPT7J1/cz9/cj5Ut6ujlvAJQUKb9RcGQz9q
         7CKLB0kME27idBnIP0bkmyPUXRPqXVey9q11zCTPhMtyOtm2VIzMzGFZbrvsiD6PI8MO
         NK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397400; x=1715002200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUMgMR07HOPlAJJcrUpT3nPIaH1wKehtqfxgaAiuFec=;
        b=tQB3a+LBR4MpB2AZOHHFFx+BoH+d8aP7g6hH+25TfPy5rBKcHlHJ3dmOXIkUtqxseL
         Up/0mZ6Yf+ayu8HNm2nYxpUic0nmbPalfxerJNJjy1W6+gONENtnTEh7jisej/Piy416
         CBEDGtp7VEZHSh5uUGZ+0WvQkStJ97mCdvPh2kKcetP6PBMJ2bB3OPEze3slhq22trSp
         mg1cO3Pig1a5Y99QVzxykunRWrS84ZPA9HRzdFePSflupvtsjsofTXu1MkGY/0Hw3Sq/
         xFxLynTwtuDE1HgmKWwzpiXfle6Ptv7gt4Rpq78CLJfkUQGedbsu/kEXjoVfEwdUerUV
         TzIQ==
X-Gm-Message-State: AOJu0YzYy6A+fgOqQ2nx+tS7ZNrlzbRI+L4+FtTp/ka1oHfzPCRKaPXN
	0/K6Wujm1aHN1X0XBnr7tG8RAihirntZgEe2yFrtT2fgDLUbtaOCi3VceUVqaWf9NLcVx8xScqy
	G
X-Google-Smtp-Source: AGHT+IHXCviVfTAZUGfIGqyOt/UlOdA3laBbBrVNGVaH5E6HsR4f88BUucpsXhzhG0QexXOZVVU+oA==
X-Received: by 2002:a05:6358:5394:b0:186:4ada:4256 with SMTP id z20-20020a056358539400b001864ada4256mr7194051rwe.22.1714397400248;
        Mon, 29 Apr 2024 06:30:00 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ev14-20020a05622a510e00b0043971e215a7sm8379632qtb.60.2024.04.29.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:30:00 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 04/15] btrfs: push lookup_info into walk_control
Date: Mon, 29 Apr 2024 09:29:39 -0400
Message-ID: <d5b2ade2b2d635ed8de53511d0b258ead8abebe8.1714397223.git.josef@toxicpanda.com>
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


