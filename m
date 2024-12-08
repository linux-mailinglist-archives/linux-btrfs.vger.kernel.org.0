Return-Path: <linux-btrfs+bounces-10138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B38FB9E883F
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934AC1884706
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E178E197A8F;
	Sun,  8 Dec 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoyyvhED"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E2418A93E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697525; cv=none; b=CL5xBT7X8rEQw8MpqO8spENij7FH7pta1lzITbSDlzgHys0hvVd7kU7eGKRUVKy/GEE+nZiSgiONFmBnDBfnMMbdPyRjCBIIPevyaLsNosB5r+IT/uF54MdTPVPY3ecfbMhxR5utudd3fFwG2AamMmsN677+x1Au44ypS4e9v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697525; c=relaxed/simple;
	bh=hU3at8k1mkeo+yic9xu0Ws86Let4b5v01Rhrok4vaXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8/Hi8R5Otx0vA/f4gfvODk4HW3Yrj6IzUUhZJ5nVEjqD+BCv1xTx05Ff4gKVv0WPTV/ccLO8XMw1MDjOCpIpqm3OnW2O/DVsiVSngnfUaxkqSM5T/9LCDNVimY+gWFTnVrJZXQ2zFzaO7s1+ZASHIZgAO/bY3nz0Z+neC2I/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoyyvhED; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-84198252db1so128106239f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697522; x=1734302322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHLLNKlU9vvEaYdFAdxljOd+nCJ3Ro3kdf3DvNB1moM=;
        b=VoyyvhEDzYRX4agqUiX0azd/RS4t5b8O3VPIbjIXVtUkRW5KRuUFVlkGz7fK+MnA8T
         /GkgP5M2pixBbPtBIlG0hTpxIp1U881no43ESJbojeixKoltnPgNqzwfZJg105Savpkj
         8hM6MkStQ96QI3Nt/dlg0JyJ3D0ePFoHCZuhTG1FTygFCUqtIf+frempA1F0ayOjOaPa
         LeAxjMPtgKIjUDk23Y3QWxZgfYm1HSuAXyFK/JJ9DphYurcmR8J2vDHrIAcXILQGIi3C
         oq19FwbCprNlCLL0Lb6DadUt9t2Wr1j2LkVEgCBUtSQTQEZknDP7x+HDHKTk9/gCxpki
         8fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697522; x=1734302322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHLLNKlU9vvEaYdFAdxljOd+nCJ3Ro3kdf3DvNB1moM=;
        b=NG6/PkzgeuQTCaXIUZcMpucPjZw3RpRxSyzX+mb9tTwyn3U/nEqa3RR+mvPsxjx6/d
         PKNStGZUY8LK7iio7h+ZM1r4F9dPTxCFq6sRO1zPQ3hSpq50KXH6ah4uQe1yRp+IMlX5
         FJgebzEWktAp1oqAuvsxw1NaYdls3LZ9IizA8/Tl4607e144N7WHAKHMeP5u5/mC0QUi
         4+mvnogFrx68mBX52kg2vo/hxBupZD6EUwLdI7Ri6cAyONsGnYjfnnqr9yUn6m35LNcR
         hDudQtz8duMQFmIbW/Yc5pHRruQnNgP4L9Ee1nKAj8y1HXxtFrxd/nVu+3lnXs7eAQ+Z
         BIOg==
X-Gm-Message-State: AOJu0YyZXYlIjNB/uQdPJwcYXkvhIWkjVyhSTZQSozH0a+fK5W4qhSJ+
	7FRfKQOXxPheBb4irS7GPjLrHco8L/gLDMFksweUQq73XuHrLeyc6Prejw==
X-Gm-Gg: ASbGncuC7Fe+ja0gBVXSQHJBfhI/OG/vu9Qnoht55NefarSfT8gu5iQ9mXD+ECqfLmM
	zYeynWfgdN8pQVxuCvPvziekaa86CQ+azan4lPK01fviRA9WuKoT2dZH3H/vVcu7CEOD1mHmsSy
	UhD1pGXTxoKJQvnBmCgGU6Px2KoX7iKbNK28IVQRQbuEZuam+Epv8NgsRlkgxrFhYPO80vBo76t
	9dpgkM9h9h3lp6Gl2yhm55daIBga96ayZLbhAq/mL56OY28X1cQl+fZuNw=
X-Google-Smtp-Source: AGHT+IHDnUi5gjWKhWv/UqUF2EoYJBAEYMUt/uTJTToFcv1e2POSPkkhlO0q1cp60iTdtoA1ANSLng==
X-Received: by 2002:a05:6e02:1449:b0:3a7:e956:13fc with SMTP id e9e14a558f8ab-3a811d913a2mr91680155ab.5.1733697522264;
        Sun, 08 Dec 2024 14:38:42 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:41 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH] btrfs: edit prelim_ref_insert() to use rb helpers
Date: Sun,  8 Dec 2024 16:38:02 -0600
Message-ID: <8201f6ae724c5dbc7c82f2ed294d457db208b2fa.1733695544.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733695544.git.beckerlee3@gmail.com>
References: <cover.1733695544.git.beckerlee3@gmail.com>
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

Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
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


