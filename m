Return-Path: <linux-btrfs+bounces-10387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851C9F249F
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 16:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245BE164F39
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Dec 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E2192B66;
	Sun, 15 Dec 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+qUg/KF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DB18C03E
	for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734276460; cv=none; b=HmcFUMl4sSUfDU9MKjoMUZaRz/yq4gAUoG+BxRhjaBdHKFR5GMkZ9YnbvTZRankB9a6z/gLrCPVvCk8djOLPcEYx/Gqq7s518J0ONhPu+wvvgWJonRku5af0FEm6c1VfKW0gq4ZxHfKDPJ7HvPVWaD2nFKy58+iLHksiM9cklAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734276460; c=relaxed/simple;
	bh=TL2P4Opeqi3tnSxRhznIo0tgiQ9L/P8B4TFiPWtWnx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQ7eLvAYKtJWkL0X0tONmzuo+s/45ZM1b7mKGTHFKovS3R/iEal0K/yJpPE88T8gzju7PEMncRkg6gekldd0X6kBETbudXm1PA/CrLQTOXGkVxViflFyEeNsrX9kFSCDc7rDGMsfN9429FcBlabobeoHOQUy7Y556IoKkG4LoCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+qUg/KF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9cee9d741so28954335ab.3
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Dec 2024 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734276457; x=1734881257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hKZyhAXipAmnDzSZ6XL4Y/mK7U7fiGkYAKbiVZMpAI=;
        b=T+qUg/KFBH8bbQhHCz3cEnbfd1Gcgghc5SWyzpQJnSoDG4eYGpSORqtz/7MWGXCFNX
         id4KIT9tvpnr559Bafu7BgpIPL1CCbgeCkrFPH+5F7jQV64/ghILQEiPovQSYODL2VTx
         Gz51x5Z8uPkB7KCfMcnfXS7d7UFUZXtJgqvLzhB7Wh54pcXJJEf/+MwBr6uE3oZJ/5Bl
         m7wzixzwZvJ0LKFdT8CfyNMVMXtuVAOjqSPdkiq+lu398A1FRR8ShklmM2AjfbWEsM/5
         zpMCqczqwpQRGiyF7mZFB+XzC/bguAUmZjNxPRSQXhgLo7jq7mpxpafWhEDJgisCaXwJ
         QDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734276457; x=1734881257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hKZyhAXipAmnDzSZ6XL4Y/mK7U7fiGkYAKbiVZMpAI=;
        b=udcT4r4OL5dR0BupjBc3z6dtTcFtAhp5JzyK2s6lIcee1AEgtzMOzCKDLHhkv6quer
         uaH2cLVGno2ym+OX2Yt4+u5GEdMk1lolHcIo5l7R+rqEtKANJm4hOutDuXNaWLjSvUVl
         MglZg09AiKYr/t6j1Q/5wlcaNtqX//DzefvUJw/td4ycyVa52GR8GwbGLhjjohft8k9A
         QC2OjNYuOm3D6qnHUV/sQ/1o2PbTekmREXBH2YEqWd0vxbl1+OJqZzi59zkx6D5z2FzQ
         LYhTFLkD/2QSZYOatv3BIIiJMhjcAgEn2tx6x0p4FuW7cZhiHLBEW1NVXFXVisO8IxXV
         GhtA==
X-Gm-Message-State: AOJu0YwUOwfdYlWwkIzbADBQ6F92kjweLMLYrt5eUy1voZ/wKds1x9s6
	opXrd1d7Cnq/S2nwc/FcrVdZkCwisUJKlVw56uKzD+BbZdzC94k0vZ9Bhw==
X-Gm-Gg: ASbGncviVTvsuCaYoYflWEvNGoEFbzsfuE9LTAY8fsT4w27tVJusOug71jlBvPagEpN
	Q9uOPqJ1brNqT50xqkoZ6ABCfv2E2KiJH+F7Ko+DD3AIZbimd+TIpPrXBlrN/x6a5QsfFfer5dp
	avG4AchnvzM2c/S4up9dseaPU8kZWeAfnVU7Qc0Q3vwgFCnv1nmThETXJ0loV6dkcE+HBatnHgG
	tYRRd9iGFccq4mj0TxXesRjDZ/YbzQvVU/r/Hdkx0MJb0eeFrDzjTMMH9n5DP5egg==
X-Google-Smtp-Source: AGHT+IEEVDg99A+0721vDLyfGAitoGJ+1Sise7icPOI2sQwrjtu45XNNlboEAremMvmVsYZY/14Uzg==
X-Received: by 2002:a05:6e02:2169:b0:3a7:7d26:4ce4 with SMTP id e9e14a558f8ab-3afee2d0367mr94731505ab.9.1734276457458;
        Sun, 15 Dec 2024 07:27:37 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e37817e7sm773846173.114.2024.12.15.07.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 07:27:36 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH v2 4/6] btrfs: update __btrfs_add_delayed_item() to use rb helper
Date: Sun, 15 Dec 2024 09:26:27 -0600
Message-ID: <7952094105650aa5a596cf5d6cc2a58520c14dee.1734108739.git.beckerlee3@gmail.com>
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

update __btrfs_add_delayed_item() to use rb_find_add_cached()
add btrfs_delayed_item_cmp() to use with rb_find_add_cached()

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-inode.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..4bd02e566ab2 100644
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
+	if (exist)
+		return -EEXIST;
 
 	if (ins->type == BTRFS_DELAYED_INSERTION_ITEM &&
 	    ins->index >= delayed_node->index_cnt)
-- 
2.45.2


