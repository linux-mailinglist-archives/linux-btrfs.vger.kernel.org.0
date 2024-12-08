Return-Path: <linux-btrfs+bounces-10141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA39E8842
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16D81884EBE
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48C319755B;
	Sun,  8 Dec 2024 22:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln2FBPIA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF81198842
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697530; cv=none; b=oUZCrrjiwLcWh+o5bXO9AP8QOGl66ODxbWcnRnrHgbS0DxMn3MdPGJVnnN/ft9Pv7VMmp6VThQSpwBLce1iKY25G75OjeKhYhkVD+MxKz9PESEZjOtFgslBLbjh6B+z/VpTNojOOo54Ly8JP10BIjHBcBeMBVOREKbuMpJcw8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697530; c=relaxed/simple;
	bh=ErvkU4nHSkxDZQcVay0Vnp7pmaQd9NIsuSetL4w+YIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGd2YU72CVGAdr+T8a9rbqR1JWeW+/c2J54JLaFu/xlaoGeB3pyRY06ygY+dIEFFRh9pCBpNGuLRBkSG/VsA0X6W6cFF8ITy6CHoEpcptzTNOFosxKXKFvh9nBHJ7WMS0svIv/0kVqbjabGtCYJ8BBlM6B/dmtzVKjj6rya98Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln2FBPIA; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83eb38883b5so124592439f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697528; x=1734302328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rt93VEM15LPRO3lyMkKqCEdwjt3Q5Iu5RMYjSCh9YQ=;
        b=ln2FBPIAe3eXyW0nF0u/rMm4J1m8oszUHT7755GQcf5VZsd1gStkgvNK7+7As6VqaY
         ZyrbaivQb6C9XwscPusAWTQLH5dEM8SCIw6DPYhycFhoyKaB99ZEE0J1OShyuC1ThpRH
         /e6XnLnpeMgcj0+gRQo9+oRL+Yl3F5/F5bjFLtjbVcMQVR+xtCPgBI1YE2Su5Tpq/1o8
         lIMZyi3K/fu7JDyvdf9t5loZgQXZ4GiaMCkEQtA3N3Jy0udBmOQrlqGo3Ni4nxKqNVmx
         B+M39bFU3f8aUqjviRJ7kfqFraQLyL2RfuvK5ug730193TaHIEdQsHy+lCeQh6Rk+HDU
         3Ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697528; x=1734302328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Rt93VEM15LPRO3lyMkKqCEdwjt3Q5Iu5RMYjSCh9YQ=;
        b=Y9pXQvHm/yqkBw0nA2F46HEV41mg5g01zv0tt+28p2j/kJ2blDonDA7sESFWhkmVm6
         cddTWaIDK0dwbBHXfOYd5ARcIc9h4MxcrkE2U33qQnKMLv6BQEBKdiusbQMnHqXDUGYH
         BxGxpsTMtxpwXNZCr3sSG193GWMvWJLOxYWHrHVdPB83XFfZCDi9+AvVxyEP8CAs/18m
         UCOKwOOyAvEVYjosU/vilZH1Hx000/AbHrDcZ8rhG/Ua/ZlUpMT5o5lBcwWWRjGRCs3R
         Qic2lK13zvLxsgpbTG4d9fuaaZPUR5hwYaZCNQ6iQIdAvjN2eItwdu6CCrjFc4+KTR7d
         4yfA==
X-Gm-Message-State: AOJu0YxMbTGeyl/s7WsbrtwozNrgGC7vPVdVWrIshzfBYSozI/K9dCUp
	vbKa4WaNESULDzg6vV07jFZqPgZ+Rxg33vDw5CyaiohCEWdnSEjEZlSn4g==
X-Gm-Gg: ASbGncvelqEWnbnuA4XEoPiW0Wx3dFI1mxBzcIGdiVklaMIaUpadHvst5POoYsPnDMD
	Cu2lttCk33a0w4zWSf6o5NHFEI8a1SOE5AytBWC0AB3HQejj0px8HoJJaKQvuSw8EWIJKvs9Mft
	i0uISJDLMMsfV03uJc41xm0WbyLZXTwZ2r79iXsrPMURqQi5ue2YM1IWIlL9C5YPO2zXBYIklkL
	vlx7pqL+EbZlzVipXSre4OZ3tA/h/zrU6zZ7Z5gutUwWIIWWrFUEnooSHE=
X-Google-Smtp-Source: AGHT+IHXiBtwENCpQeKB5FiX+3x7SvnUMfjofw3yShT4hvqNSbj2omj90AImKrvBpawS4Hm7msPHLw==
X-Received: by 2002:a05:6e02:1c8f:b0:3a7:e528:6edd with SMTP id e9e14a558f8ab-3a811db7d25mr124316505ab.12.1733697528252;
        Sun, 08 Dec 2024 14:38:48 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:47 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH] btrfs: edits tree_insert() to use rb helpers
Date: Sun,  8 Dec 2024 16:38:05 -0600
Message-ID: <5e023dcf8f086296da987f8ba2b43be0aca15b86.1733695544.git.beckerlee3@gmail.com>
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

Edits tree_insert() to use rb_find_add_cached(). Also adds a
comparison function for use in rb_find_add_cached() to compare.

Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-ref.c | 43 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..d77ac8d05b2a 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -317,34 +317,33 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
+static int comp_refs_node(struct rb_node *node, const struct rb_node *node2)
+{
+	struct btrfs_delayed_ref_node *ref1;
+	struct btrfs_delayed_ref_node *ref2;
+
+	ref1 = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
+	ref2 = rb_entry(node2, struct btrfs_delayed_ref_node, ref_node);
+
+	bool check_seq = true;
+	int ret;
+
+	ret = comp_refs(ref1, ref2, check_seq);
+	return ret;
+}
+
 static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
-	struct rb_node **p = &root->rb_root.rb_node;
 	struct rb_node *node = &ins->ref_node;
-	struct rb_node *parent_node = NULL;
+	struct rb_node *exist;
 	struct btrfs_delayed_ref_node *entry;
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
 
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
+	exist = rb_find_add_cached(node, root, comp_refs_node);
+	if (exist != NULL) {
+		entry = rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
+		return entry;
+	}
 	return NULL;
 }
 
-- 
2.45.2


