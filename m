Return-Path: <linux-btrfs+bounces-10139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150719E8840
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 23:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D5918843A4
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80319882B;
	Sun,  8 Dec 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3kaWsOu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C5195962
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 22:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733697526; cv=none; b=MLoXbwrnlKJ++00zcXKWdep9WTEDDTKXZLoVpDL0F4yd7ucCKJZz+7DFImHBjy4BNKEZz2N1AHKRWCIq2EEXMhbwRBt1VWJ+pJVJt58h1DaICqynwzEgoe4ZPkL4Pgdglp6ufu2vcQzH34h5uU6V8AQPBOdp/l3ao/1ieH52M/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733697526; c=relaxed/simple;
	bh=YLgLc8Y4ThuJ34puer1TxHb5UGAinIMr76FBBi9S1oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBUWlPZjHmUKywzbnJKVpVN+nlTKAyqOgNCe17NfyuEx8Mtwa04r18HNMzaRJ9MWafkUKqLckeWEQIdn5CkkyC3OehzBhX66A3SlIpXmU/B/73B5E264EXi/0Oktyc/vwTV43DdoWWQfc2btTThLXVkMcNgm4ISvwoMkLCMRBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3kaWsOu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso17485825ab.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 14:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733697524; x=1734302324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTAgr/elgx/0+bsbLnyy/Rf5xK7h0Wt7hU+EHUrcdWM=;
        b=P3kaWsOuxlc2sPwLGEL5ni/CeG9du8D9l2A4UfFGh/awXG+v71DFXh2z1ykfRiA+Fh
         zgepfVm05xTIw5xuN1OLywDyNCeBrQM6egQYa0Q8XK/t3BnDWFk0bn16Ra9raYeK+PHI
         B34RpJJ9eabjxq3J1kHqqvZH7XHpUp9gtbzmF49vyJUe4GXUytbYoy9bLFS4GcPlitng
         PTXvWBdt/uEQKN73h8pW9KZj5v6bAjahggNoojcGxD3mnL4++6Q0+ZiKIAWDaIhTBLeE
         Pg248ftdmPklX01ib2KPp0x5PiFvwjVDX1GLtY0gapTDtkV6UlSc/l4O0wfoom1rPzI9
         rCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733697524; x=1734302324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTAgr/elgx/0+bsbLnyy/Rf5xK7h0Wt7hU+EHUrcdWM=;
        b=xGRahM9kU1PykemZKLasSAEDlBlf33x3l/JCiBhJw8T2J1Osz7TvwNK1uxnyt4RBa6
         YUYIsL0/Kk/XCBG1QyFMzLkin51+zBRGN2E1PPzj9ZTg3gcbvqf8KNnQwkpPC/O0o7o4
         tiZOR/tU3nS3gt38njlWAyOZDeNq/+1OluJjp4w2ndwGl5uj2dyFvDAEjGCmVLlutppy
         O9UXowqX+3Z1pWOVWMROQxCncWLBVlIO3IEQbAgu7DT/aD6C7eeC7i/vr91cfZe5hfdK
         J0iz1kcx/arrS/QE6N8zvqZiJyOZqd5eHDY9usZaxBsGQ8MW7UBtGqH2a+jcEPLXStPH
         xoEw==
X-Gm-Message-State: AOJu0YywHG0hTC7W97z9IVxZ9lCOD19aw2uefSHqrjuqKYB+gnKeWDoe
	TttgeoAueC+QMVewTwNc0D9bhDGU8gNtQlzLO7hloodvMP913UIcuXxtKw==
X-Gm-Gg: ASbGncuCkgVHBlYNoFW+pNWPQU35f98uw2oHeDF8hGH24eZqWclyPGA0gRwlCf4UMUw
	YgXvaFiUiS8DBRHAqNJBLPb9tCKDVfKiBphhkPctjPLtfsXevNPxMN3Yqhrb6bwMTT+V8zjTKKT
	GkuJSeTI/bqtmCCT/dUu3/zDJUarFo8Ds/b5A7qBfmyx95jFhvLI5yuEBQesiohKoy/51EEinHn
	nC7Gies1asfXF9KAp5TYIygaj6fTWXchIeFE/IR1wqgeFjE8tosndM5J5w=
X-Google-Smtp-Source: AGHT+IFWM0R2z29kV3eEYtlEvHk5leuHSx4J90rJeJMbboc1h8vnzRYPF+Ll4bjU18/yPGHVxjSw0w==
X-Received: by 2002:a05:6e02:1c05:b0:3a7:be5e:e22d with SMTP id e9e14a558f8ab-3a811c79ae1mr95598755ab.2.1733697523749;
        Sun, 08 Dec 2024 14:38:43 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a8f162d6dcsm12704745ab.67.2024.12.08.14.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 14:38:43 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH] btrfs: edit __btrfs_add_delayed_item() to use rb helper
Date: Sun,  8 Dec 2024 16:38:03 -0600
Message-ID: <9b85bdbc269d20886590f0a70de66c602d72aa9d.1733695544.git.beckerlee3@gmail.com>
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

This commit edits __btrfs_add_delayed_item() to use rb_find_add_cached().
It also adds a helper function to use with rb_find_add_cached().

Reviewed-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Tested-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-inode.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..7d62224bc49c 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -366,40 +366,32 @@ static struct btrfs_delayed_item *__btrfs_lookup_delayed_item(
 	return NULL;
 }
 
+static int btrfs_add_delayed_item_cmp(struct rb_node *rb_node, const struct rb_node *exist_node)
+{
+	struct btrfs_delayed_item *item = rb_entry(rb_node, struct btrfs_delayed_item, rb_node);
+	struct btrfs_delayed_item *exist = rb_entry(exist_node, struct btrfs_delayed_item, rb_node);
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
+	exist = rb_find_add_cached(&ins->rb_node, root, btrfs_add_delayed_item_cmp);
+	if (exist != NULL)
+		return -EEXIST;
 
 	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->index >= delayed_node->index_cnt)
-- 
2.45.2


