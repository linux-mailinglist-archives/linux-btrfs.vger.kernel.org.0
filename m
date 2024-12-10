Return-Path: <linux-btrfs+bounces-10204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4589EB9D1
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 20:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6321675C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 19:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DB21422C;
	Tue, 10 Dec 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvnBlLfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C9C2046AE
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857640; cv=none; b=c9C5duJoOLNVu+60rvRo5G4Ol+n7oIplv2rAjsS/FNPg/pPCG7L9oAhHV9VdIEGPdC7cOqEiVwr6c6JD2o8qZ8t1owOxQdY/S2ycIack6RLWuL0oKWmIjZAJqsdqHB5bx/IiXDBonYipqK/owuUBqNhoQ5Wx7jycTVa8HXFSq6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857640; c=relaxed/simple;
	bh=g2u5ICgSwJ+jY8DpCTuuvJwLuK1LmosHHuopMy5AU3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2nGc8ds/arNPe5Knv4xGB/wcYj34fB1BuSwT2XwQbF0pnszxwnfEihK/LrFdcZNabNq3vQfaZO0kT/0gBUxeWXUmAtVnAvyWD1SU7Z1ZzQgZrpYK7L7JRt///FtanXlmh4nsyA1MYCZqbNIyQ8TTkA1MDB6UTtO1+S23xWSHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvnBlLfR; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-843e9db3e65so213589739f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 11:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733857637; x=1734462437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ci4fxMwTROvKHzo/u+oWA7qVLhZcwhboGlFW8NsFTnE=;
        b=UvnBlLfR0rz72jT/UFJzinWtwryTPoRL5ubDYpmU2hp/qoDZOukXnQEIcxptnNhd5T
         rirfVjqgJwh+VPLivoY5QTGxt8JNTcsLpY6OI2JyNhT2mmyA9qmNSmP8n5MHPyGyc27A
         VAiPNfuiK5khss59hTXvXBlxrlAttB3UQuBMqZNHFGVpUGFIB6aV7Fu4SSIcdWgADlSu
         saseRYMkQ9PBw/jao2Qv29Iq1YQea6nct6XObpiZJ4OhXjW3rBqJ3sACWvkyqQbw77Xr
         8JJkE728YJtC1LaRkj5Nv8hogPiEdjX55tDgZWRO994LfjD0ChUj0OuoInTSlCLGefBr
         huKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733857637; x=1734462437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci4fxMwTROvKHzo/u+oWA7qVLhZcwhboGlFW8NsFTnE=;
        b=JeZ8T2DUai/X9EfeWvGJC001OwfMFnTUsPt7ULnV2QLfy2+ZNX+cSR1BaGN9dZuNd0
         c/tldRqvtILu4aW9PT8rXaHQqewHVf8OFCnRHkBcppXW/8JbR7EUJh4nICiPNlpacQwg
         2z3/1rD/dgFrxfTdS1h7t7neMihKyRxSrXdF1BdhDjGKipsnllgqgRFRWRm/IMPx0LV9
         5F1JaOuDYVqfNgKpzwPPjqUEtWV0rAUMY8Lzay8vjUoi1MLKDLoQRI7vk80V+Jn4AGi4
         76Do6Le/uCyRsu8R8/hYjXh/qchzuwPXbu+GtKBXk7OR2Kx8a2m/1EBPCGsEOVlBu48Y
         KmNA==
X-Gm-Message-State: AOJu0Yx8aPC27dqwbRIuyPiUPRgL4kT9xmiIdEPFNry6vrDlMkEVX7y9
	UJJtcHPVINg3PVRuvLIpF2TTGHOPFeFD+jpZLsbDBhIQLOU2dmXdNQjOBg==
X-Gm-Gg: ASbGncv90oCdlRca6oET1TkcOWfZ9ZSvFUKTfdLpRe6GYd68X2EoZtRIE1kSQCNf/8p
	6VsACt2i5WuOY+tozQv7uJB9LjqsFOz53QDcrcgknAq5buRvmZCLL0GztryUNxj2nY+k5G1DOgB
	GAjUIUNew/7jpLgQCph4u29LWmZJ06mQBrkWpj78CJdgco5eaa7oTOxMY9yJ9cN/jObz5q3+x8N
	GOAuLB2hVG0ZGsc2lhWejPyQ3Fs8Lgx/fuPNWh0i2e92gm3B6xBHGrSQaasp+w=
X-Google-Smtp-Source: AGHT+IGVKoxrQ/Vf3WE7Zzj1LHGUGRy6aklgE6IBR5QVgeoGRJqaZbK+C8TdQi1AloKh1Ee+MTWHbw==
X-Received: by 2002:a05:6602:6019:b0:844:7896:8cb4 with SMTP id ca18e2360f4ac-844b8804d31mr505804639f.1.1733857637016;
        Tue, 10 Dec 2024 11:07:17 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844cb2611b5sm7044839f.38.2024.12.10.11.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:07:16 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Subject: [PATCH 4/6] btrfs: edit __btrfs_add_delayed_item() to use rb helper
Date: Tue, 10 Dec 2024 13:06:10 -0600
Message-ID: <76d94f40a9c6333e8685375aa998199320b54101.1733850317.git.beckerlee3@gmail.com>
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

This commit edits __btrfs_add_delayed_item() to use rb_find_add_cached().
It also adds a helper function to use with rb_find_add_cached().

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


