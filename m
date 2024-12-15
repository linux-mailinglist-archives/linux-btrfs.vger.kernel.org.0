Return-Path: <linux-btrfs+bounces-10386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58B9F249E
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07CAB1885F24
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A119259F;
	Sun, 15 Dec 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Tyt3jD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C51922E9
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276459; cv=none; b=ueBMeFwtdm8OytFSmmflOPX6yFUZ+eZu5COiB6yMiAxfbFVM83iRZr10a6lshb9CXsEpNeaODGr8pHhWu/mnwCw5p3q7+usw//3j/f+IyFINRr9SvJrC5d5zbFtw29eyWdr9RhPW9XmMNA5gCGOArcaGIYaNq3WIh1VmRl0V/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276459; c=relaxed/simple;
	bh=haN17d5VlCoDpqqbZzb7oe3Pqu488YHYg4n2f2UgjX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMtwMeBxH+L+7RddJ3HEGIpLAe59MmZKXtDTjj/iTPmWa+qTC5K+ghggZTY/FhtbKkWx/QyvFao9Cn8jNsh5ROuPpcnYDvSd8fhwsiFJ2xNbjrKGmqe0/6DWgslIBTGT9nBUTZ+IN3gpfX++UGHaKfnsd8sGHFFUxdSZRtnviqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4Tyt3jD; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844ce6d0716so259866139f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276456; x=1734881256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6AGBEEbL3KEc1Z39BabQVoPtwwwqcya0HUExFb0a4o=;
        b=e4Tyt3jDyDQjSoKUeoVLvSF4AIDRquU9cKdGLaSQS7dMcqedeYB49MA6sls4JcCauP
         HCN7SIhcPnysjc/v8r6U1VJ1ppRG7gQ8ViH3SkndAj1d+i2FEZ+oZuClxWk9sP6Mc2Gj
         zRljJ5flOGGcsGb6cJPsZskwCAWSwkf8S3IhnuNTWZ/bj9oCr5LRCmR7he8SaMXZr+qF
         yKLcA1uZbpBosEI/MezWUznoHMTE1Hxx2A7mlmeTeS8koKFb52rKjiIanFhA3cGP+2i7
         grdTwffcLBcbiDSWZ8Cirt1ohLUaQWas4rYrvNfi/OhQhdVxxLjnadnLxQrfdTE7ycOz
         hTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276456; x=1734881256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6AGBEEbL3KEc1Z39BabQVoPtwwwqcya0HUExFb0a4o=;
        b=alFNSF17wZktpqTvfeI661VGeeOY/iytswp4POnXiCUFKGYj2C7trf/y0p465BzknA
         myfFlsZVPIfugj/nsaL8WO6Bg9pWJJ5e+NuuzxNQBief3pOsAqxJIx/XQcVlEplJmQeh
         nBCiMjPSKSE4Q9cuHRo34QkgJnifAFQH9qLKe2yj+I2PfAIkqZDQL2HBW2ZWXbf0ueIk
         RQIWkrptF/qhdR7gqL5qAjB5ywk29NP2Ny435na9XyD5kwjcTgcOtGWXeczEBOUXKCDV
         3DeKQ+g9OkLm31kKxMzrf5THlVppQmk7fz16Dub9w+gctHgpP6AXVSDoTIB+4hiCRmYU
         y5Mw==
X-Gm-Message-State: AOJu0YzibduOnyApM99OPLGO5bY5wAPOF+Z3zjMDqptmg7AgFVhe/g1E
	ifdYziYUC9LVhw35NaPS9V2pZHaAfTMe5HbJFzdWyxkowb3E9LzxdctbkQ==
X-Gm-Gg: ASbGncsVJSU8qtgQaYR2B+qhFYCDoi/rzehL9ZVDNOCxZ0viPWg3fPw10HTrihDdQFT
	RAxb4wU0Dr2G3VZDyql8BY8KG4+5AGaD01SXyawg0etLK7zNdmApb5p/Bpea5K4d2KLqPM6e+W9
	A8dzdthWjdDHfy3MItWmFBP1eRSp2eoBp7aO7H2STVHEijv1IcumRlud9WgsLbzvdA9nsydUUru
	hN2fvpYtCOXfKPvMvEzdy4RTcNobmRrhdbf84qAZ20q9QJnbn1vHRK+dWdBsaZtlw==
X-Google-Smtp-Source: AGHT+IG4EzIDV83bFxfMqTokiE2rLV2ivH3xAGrNKdataL4fTNu4q8KlJySWgYw93ggAGABFxSqjhw==
X-Received: by 2002:a05:6602:60cb:b0:844:c76a:354d with SMTP id ca18e2360f4ac-844e87b05a9mr1205381139f.2.1734276455961;
        Sun, 15 Dec 2024 07:27:35 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:34 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v2 3/6] btrfs: update prelim_ref_insert() to use rb helpers
Date: Sun, 15 Dec 2024 09:26:26 -0600
Message-ID: <f230207a6603dfce4f95532032650bf21dce5be1.1734108739.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734108739.git.beckerlee3@gmail.com>
References: <cover.1734108739.git.beckerlee3@gmail.com>
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
index 6d9f39c1d89c..1326872f172e 100644
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
+	if (exist) {
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


