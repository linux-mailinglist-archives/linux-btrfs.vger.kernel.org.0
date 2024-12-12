Return-Path: <linux-btrfs+bounces-10329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB829EFD76
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989D416D2E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BE51AF0B4;
	Thu, 12 Dec 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8MHt1m7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AED1A4F22
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035483; cv=none; b=alPnqQlFYG6oVfTlVN8zN0tbEZDjAIfhLaZ4IuCxGaUKJU92vdHdMpHNHzKT/+1v28zfyOSeOSTRbDG1iwfSpxNLveNC2FSwEXgA1igik6HQZ/4ZdjJD8y5G3znm831gZDdryTfFCe8x5WkCPOtcELEOdvmbvSO40A1cC7TMNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035483; c=relaxed/simple;
	bh=TkliS2oHaEPuWNgijaqqLxdRvx2GTLjFdwEnagsLDSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOtUVVOCpcmPU5z0UkjbiFdRtt4wx3fGg6Kv++xzF4kViuQd+z7Vm0+FOStyMlCVqq+RCVDl/i2FJdwzRg2ThhFXZtctJ3NlNe4asL3wLZm4Wve4IUk4If+J5FkJBQsG5iXC19atbQTqtFxTdizoYiAzNecBw1RGc8HYUuPrhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8MHt1m7; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844dac0a8f4so77099839f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035480; x=1734640280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrKhWXGN+megD4dCMPT4CbRdmotjLJaXyZVNcNebOxM=;
        b=l8MHt1m7FBaTvqWbE5Gaxw/BM48s4c6iPczuLBDVSu14WfLlPG+g6toKI72hR039Gy
         nhBMz03dkNmwAaw7jUfetCx8ZZWKAdXOvCXYSCwG7J8ymZ/cjPDrbCj3FFpTssqvLCig
         jH7IpnuxCGYjRIDLEeXoshge4PphbLn+WEffJbkvvsBJVtN6y//mbFL/e6rqIMGY6U+w
         QCSfLQv2RN3+J6zJP6sXlJIfViGSsOkDoGvMJC5IcqdB11EQKe1CMwPyOsu+pKJNMsq0
         ozXZIxvsBGLUJ+//GgOKbSQbbdspip1F9a3gGLz+8PdGg1qTgUuU2/BXUfNrSeAqyOG+
         TwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035480; x=1734640280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrKhWXGN+megD4dCMPT4CbRdmotjLJaXyZVNcNebOxM=;
        b=KhpdWnZAvATBYendmU4b70NcG5Q+NxGhtI5Pp6OJGC5UkmsEYOM4s21IOYxNmU470w
         rWKI8CoSF1e++DUhq+dobupGPCtkqi17ZwZm9nCS0BpuZHZpyY37UYh2JuIORfwqn5i+
         aS+sWoZNOi40EMmYMSaBQm9wJXgMtDB46rxh1mXG3A1tBh5pIiUvIf9fCdtht+Z4n3FN
         Rq0CBWTOw7jrgq5eMnSYCoyZGjnbemPPGr3dTDmCuvPydTg+ymAzbyFWZmgl74kPl+DS
         zGFJoz9p1B7MJ9LumnC6qADEGhlHi/ugHBnkBhIYWNOLc5vsmHS75DM8EGAwmymMSGw+
         GCSA==
X-Gm-Message-State: AOJu0YyirjMqurwKAlQGfp3+vrZrllYAw9xqmKWmW1S9fW1SUHk5nF6D
	h86IsiJwqmNKfDNSzMK+eCNQnFRI1fDBszt0mJqmv1mXZt9T3ZRthh04oM0sMVc=
X-Gm-Gg: ASbGnct/8h2QzIAs3zrhM6W4BCvEkQ5JGAAQjOvzbhMvFjq/iu1yBa1AA/X8GEHFzoq
	qpvbdRuftMgTWWTpUyAkIKrwcxM2Eo4vbdjhIeQuakxSgT7VWZYxGRJJMpVjnHyKRfzXxZa7Gq3
	FbskB5HRi0ZwpM6SkqH+Pr42bO2hnEeDTeC5lLVgJgmkXz+YVR2PAM8m0qnoydczqjffTpFwxas
	TZoatgC6AyYpbKWsPQwjxPb7cqi+unIg84fVCgC6tm6Gs9h2Pm15YHYU9s41Bhgjg==
X-Google-Smtp-Source: AGHT+IE/m51xUGZKgbn0xoOshOGUZ49Munvd8q9jF1pXylVDG9zR+2h8wsw6F5mbnrvz9tIqp0C9rA==
X-Received: by 2002:a05:6602:492:b0:835:3ffe:fe31 with SMTP id ca18e2360f4ac-844e88489f9mr26385539f.8.1734035480500;
        Thu, 12 Dec 2024 12:31:20 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e29b6103sm28642939f.29.2024.12.12.12.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:19 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: update prelim_ref_insert() to use rb helpers
Date: Thu, 12 Dec 2024 14:29:41 -0600
Message-ID: <2e60a302945ddaa69abb807987fea9bcdcc36ef0.1734033142.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734033142.git.beckerlee3@gmail.com>
References: <cover.1734033142.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update prelim_ref_insert() to use rb_find_add_cached()
adds prelim_ref_cmp for use with rb_find_add_cached()

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


