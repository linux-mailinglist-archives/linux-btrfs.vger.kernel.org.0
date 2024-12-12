Return-Path: <linux-btrfs+bounces-10330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A489EFD77
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F9F188F649
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFA21B395E;
	Thu, 12 Dec 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV/nDRpx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E31ABEB1
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035485; cv=none; b=toYWQBsDlNekh7oSnTlmYBKcfUH29r/Uq76p1Td8L6i+CVM9lEoix8iXvPXPYRkXTH1ENyADyrm0y3PHlY8YhkOzBFLCeNfKbmtcYVJpWIxplsOBMAwHrDTXQcZLkjYlisVWrB6TK1+owuDVmaIc0Pe22OHvEixoi8XPgwSyc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035485; c=relaxed/simple;
	bh=0hk3y6uOdBb1TBHDqc2BPKIC/uSBk9llQOtdIUsyfx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy08z3X+hregE2Eho0lOWOEhhrHoGdGIhRuJHYqJ23dfDlQUg7wDL03uM5/LSz21TQoe7gi7nW0sLtHJ1hE6fPLM3JWsPblWdD9uO36gehHxTCX1XekGie7cCxVXUW05Irdy/BZTCLAsC8fv+98ntRutRTqzaOH9ze2O3mKe2dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV/nDRpx; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844dac0a8f4so77102939f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035483; x=1734640283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QcB7uLiiK6eYxy4QV/NfOBh2UDPIWi7OhZUQTByQSw=;
        b=hV/nDRpxC3ToHfdeK1hkvzdf/FZOSTlWfK+i77LXJXJUev5ch6eSPgXy2hj4gLhwOe
         B7/r8XNuACSroxDP0XtBxcndMmoBG7h7aWTO7HD2rpOixp1E9FgJ+Fk4EAcdWohDmdkB
         ys6AqQ659DSJy3uNm8x1FphHfyEKxPu7i5QFmHSVMKaEWrut3fN/0Rdw8RUEPJHBfN/j
         EN1mMoPqn0JaxIddypTMIGBishNEkuD0hFgIm9ES46I5ww+E8IFqDH8ZSaV0MaaIziAR
         dhPV9y1mv7tBVP3g7W0+z54/AEJ0+b9P1ty/qHiCLK7JaUGdmaF+wvSbiJW8icSOt9+G
         qEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035483; x=1734640283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QcB7uLiiK6eYxy4QV/NfOBh2UDPIWi7OhZUQTByQSw=;
        b=b1j+A27UBms66zN1qWPu5yc5KmxGy9Az15KbFMtlxntsob6C32DIMisAL6IieBRGLn
         F97QevRMA9pgg3iXUGmVDkn1VGXHu77QFiGF1INWPcR/FDl4sbhYYOswlgKEL7jQ+rjg
         8N/c+udlKq4jfLZeDMKY6EdHQwoCYJ5kBKS+xFURgmXFqPoQ6pRXpvQLx8Y6MFu5Ygij
         50ys6Y9Vxt+p/8XYqsIk2Fdc6ua2TG+y+E45NRa6e9llq2xHsx55yWTGzOnfd31OHcwJ
         Lu64QykHKfIwHIZnIR1PElh6F5K1mG/af/5skBJi7IlmCN52r3l0+dQaVpZvZ8oCxzgA
         Qzkg==
X-Gm-Message-State: AOJu0YxyqgtbrK5S6Dv6mvUCcivwAEqFpunXfeu40rXmmLM+wFpxW2FS
	7Brb/gVgB/kAmXQQP59Ep7s6xW8vf68R1yzoR3iKI3mcS2qovTI/ZY/ZlT86f7M=
X-Gm-Gg: ASbGncs8aysUPtu0QSbyGz+/1aq8rPnN2cLsQ4zjfMnwbRQhwu9H9f+FuyQB/CU0ExT
	86ae2aOPyGgeI5hwIoEOhVIi2c5BNFoBV9PP4jbcK1ZxxcDU1SKJezO1S2d2hvEf42KyPep5c0G
	KD36MeQ1yYqPohA4ZtrqAgc/VbtWJ8W7c7H1BFYG/JWwMs2DtFtC0lR0I7s+uGmporTaPX83OV3
	Dv6Yp7H4rK5Sf1KkJN3MP4W1sXBWMunKJG7Xm/ax6QMnW+vEuj7+DaMxPWFSiQ7CQ==
X-Google-Smtp-Source: AGHT+IGK0oBSVmP3vY2kPXguI0O0Si0GI2mEgjlt0o7MsjsosqB+GLUYD1fmNVZZtDYV3cdizBFISg==
X-Received: by 2002:a05:6602:492:b0:835:3ffe:fe31 with SMTP id ca18e2360f4ac-844e88489f9mr26395139f.8.1734035482759;
        Thu, 12 Dec 2024 12:31:22 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e29b6103sm28642939f.29.2024.12.12.12.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:21 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: update __btrfs_add_delayed_item() to use rb helpers
Date: Thu, 12 Dec 2024 14:29:42 -0600
Message-ID: <e57df7841cc52f21bd1aa83e83914d9adbe44996.1734033142.git.beckerlee3@gmail.com>
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

update __btrfs_add_delayed_item() to use rb_find_add_cached()
add btrfs_delayed_item_cmp() to use with rb_find_add_cached()

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-inode.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..d705049fb381 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -366,40 +366,32 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 	return NULL;
 }
 
+static int btrfs_delayed_item_cmp(struct rb_node *rb_node, const struct rb_node *exist_node)
+{
+	struct btrfs_delayed_item *item = rb_entry(rb_node, struct btrfs_delayed_item, rb_node);
+	const struct btrfs_delayed_item *exist = rb_entry(exist_node, struct btrfs_delayed_item, rb_node);
+
+	if (item->index < exist->index)
+		return -1;
+	if (item->index > exist->index)
+		return 1;
+	return 0;
+}
+
 static int __btrfs_add_delayed_item(struct btrfs_delayed_node *delayed_node,
 				    struct btrfs_delayed_item *ins)
 {
-	struct rb_node **p, *node;
-	struct rb_node *parent_node = NULL;
 	struct rb_root_cached *root;
-	struct btrfs_delayed_item *item;
-	bool leftmost = true;
+	struct rb_node *exist;
 
 	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM)
 		root = &delayed_node->ins_root;
 	else
 		root = &delayed_node->del_root;
 
-	p = &root->rb_root.rb_node;
-	node = &ins->rb_node;
-
-	while (*p) {
-		parent_node = *p;
-		item = rb_entry(parent_node, struct btrfs_delayed_item,
-				 rb_node);
-
-		if (item->index < ins->index) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else if (item->index > ins->index) {
-			p = &(*p)->rb_left;
-		} else {
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
+	exist = rb_find_add_cached(&ins->rb_node, root, btrfs_delayed_item_cmp);
+	if (exist != NULL)
+		return -EEXIST;
 
 	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->index >= delayed_node->index_cnt)
-- 
2.45.2


