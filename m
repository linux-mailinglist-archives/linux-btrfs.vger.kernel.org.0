Return-Path: <linux-btrfs+bounces-10206-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6D99EB9D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113A828394D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D75121423D;
	Tue, 10 Dec 2024 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyjdE/FC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F621422D
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857642; cv=none; b=HUO0zXEf1EYbJj7NSa2D7MbKRiIN8W31RUoSAzL2LpLTH8ek95iwLWAimvxtIjX57WQxzAxgypG2qMXrVkYOz4hxQIXF55Cj7bP0oWX0skYrayrnAvzeFjwfonGoIe0ZXcRv7j3uqjlIUBcEf2WJ6gInzxRwozqz+IlC4QrmLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857642; c=relaxed/simple;
	bh=QP2Jlvpr1efkA1p8JzqH8bk0pqKU4GIwRrPo7qsvGAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upwbI7GwnMKcZfDDu2dxbFjb82ZOnkLhfiE9q9AK6ehWxAK8439XvnwIpztHV3uhMTyfyKTl1YjTq3np1ti5Qxoi1SFaun5rkpoPwgsvA+Ip4NOvgX9qSrvj1JE9TsVwV0PgvVsNTTwrcuwUy3PMS4/bl4AMdYyqWXiJBbNOV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyjdE/FC; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-84197c469cfso185269839f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857639; x=1734462439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tulxANZghOKV09/bXuoCBRca3VDxQt6iE0t/bv0DEWc=;
        b=WyjdE/FCIlaT2PYiouNIe4SfGVAmiBfLXNJOKCxCjNahyLhLOFKbrWtj/ZP3ERHRVA
         P2z0ZNF+RMqn6tV2nmooCqsGM+WLgOiYrtBt8eEHh2IXPvUpCpImnz1TXuKBbEWXPIOe
         14OjfrRYC/2HdZNTxBXMSkQM/UXF0OIUrVVrOpe6gEk/TAy6TmVA710Hkp4TEgpSvg1i
         5Rkrc524hnBlqJhWUMJyBgjIB+5z8q38CBVC245u75azCyKyeNSDZSyq/47LDss1+2gW
         gvmm9fjJj3DwQUqccUpqdVORCNlUfpMimPQvlgsjSCS7VAtZ92nE+uopoXtoR0fbggnZ
         fJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857639; x=1734462439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tulxANZghOKV09/bXuoCBRca3VDxQt6iE0t/bv0DEWc=;
        b=emMFEjsYsCtZEkY9eoaakbD5b53sdsWmrNDyYrFrkRduC/7vbqrLRkFRLHM36kD0+1
         Yk0n/NUnHBIUina/wEMULTQ3+A7Zr6WIq9W7oV8MhYTUjlsIMqQESkx89mSbrLqG3QnX
         EFCiwtNd4eYsKsMpNGK9iNQsG8oLzggOIAy1DxmIUjDCFfIYL2KxX642Gfd2w0MOvJ1b
         QNMzjVv3TaJPB6kVfMW4PKNt3Grli/I1BLPmj5Ez4iW/9XrrfJvC3xMbCy+AW9Ylg3Kr
         5igodF4mbbar5FrPLz5vwEkUAxTBULbOMT+GPc72F5Pe5adS0vt9o0G25pGX31axWA1e
         M7KQ==
X-Gm-Message-State: AOJu0YxfocXWNWxxwQ8xikuuXgdi8Qfvx4ggidFyu1x2kfD3UIk4useh
	Yh+NYj/p4RRN2FZBPCUhi+rmCqGBIHnSPyPP5kNwpIPqV2kX9wD73+G2xQ==
X-Gm-Gg: ASbGnct2yDHqZGAB2/D5eOQp1b6MGQag+8AI5/84BeiYYyH76Zhr2RfBYTA5+SdqvNU
	kXB4mmDzMoqaivYcV/BPZQUcaf5vRlZneevJgcOiqpeHkpEo0PU+SPS9qBs24WnMDV1wreZlHWy
	kMuFTOK4iD541OSLPM7XYQtWMZVWBGz8De7gtqAwDCsrUxQVCXaA5O/TkUJaJh4D8AB0mvNJzRM
	cJ0Ws/iEEbNNL2OPAQZyYNiUP4crAdZiAQr9i580gkJZ/wM/nCnKQu5WdwQaGI=
X-Google-Smtp-Source: AGHT+IE1zFU8JqHlMZbV3LITzS5v8HrUs+X7SN9qPo27p4kYFSANrlEwg82YAQEyerBH6mY+p0yLzw==
X-Received: by 2002:a6b:f202:0:b0:844:cb6b:56b2 with SMTP id ca18e2360f4ac-844cb6b571bmr46544139f.6.1733857639161;
        Tue, 10 Dec 2024 11:07:19 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:18 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH 6/6] btrfs: edit tree_insert() to use rb helpers
Date: Tue, 10 Dec 2024 13:06:12 -0600
Message-ID: <29decaada3411dbc4c4516141a3ec7391a91e961.1733850317.git.beckerlee3@gmail.com>
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

Edits tree_insert() to use rb_find_add_cached(). Also adds a
comparison function for use in rb_find_add_cached() to compare.

V2: incorporated changes from Filipe Manana

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-ref.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..e288058f5c3c 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -317,34 +317,27 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
+static int comp_refs_node(struct rb_node *node, const struct rb_node *node2)
+{
+	struct btrfs_delayed_ref_node *ref1;
+	struct btrfs_delayed_ref_node *ref2;
+	bool check_seq = true;
+
+	ref1 = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
+	ref2 = rb_entry(node2, struct btrfs_delayed_ref_node, ref_node);
+
+	return comp_refs(ref1, ref2, check_seq);
+}
+
 static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
-	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *node = &ins->ref_node;
-	struct rb_node *parent_node = NULL;
-	struct btrfs_delayed_ref_node *entry;
-	bool leftmost = true;
-
-	while (*p) {
-		int comp;
-
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct btrfs_delayed_ref_node,
-				 ref_node);
-		comp = comp_refs(ins, entry, true);
-		if (comp < 0) {
-			p = &(*p)->rb_left;
-		} else if (comp > 0) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			return entry;
-		}
-	}
+	struct rb_node *exist;
 
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
+	exist = rb_find_add_cached(node, root, comp_refs_node);
+	if (exist != NULL)
+		return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
 	return NULL;
 }
 
-- 
2.45.2


