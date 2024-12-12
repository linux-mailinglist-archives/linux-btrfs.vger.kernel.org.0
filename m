Return-Path: <linux-btrfs+bounces-10334-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53729EFD9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BD816285B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5001ABECF;
	Thu, 12 Dec 2024 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/2ARlKS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AEF54723
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036517; cv=none; b=g/AHStDLjU01nNQo5UhS/wf4v6TKEYhrzGDXcKTNBdwO+mh/DanxB8YZhxzh0A+bwke1wuQMB2/6yrikk2NsZrq8PLhsiN/tRiXs1QfM3yeDnjhgFqUV/1quPfRK8AEyMxUKcicXN5lkvygkdnhjA2eoCT+6RquX7XjDHjCABIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036517; c=relaxed/simple;
	bh=1dA8jcq3xgA8qFg8itMRWTgymDUnd/EHS87ZLxIxFtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNvYRr53FXCrsawRQan4D5E1UdjhcMtuyMiq7umdVgTAfx3kD8Moq3za2z447XafKyv4ya8EBafLzvm92Dj15I4Go70PsAhVb5MLSEqvz1f9tjP8BiWocLezUPDSdWyjjgrYucet66QGijKClRD6cTBBWv9KhLXpGnc+UNOddqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/2ARlKS; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so7275395ab.2
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734036515; x=1734641315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ukUjedrPn29twgS2RyXJl/3j0v5yw5R2TD5EjtTSaE=;
        b=X/2ARlKSqOUV4Huwy8Kgk/ambPBQOMMAkBzxTJs2iSOtuGC1LM1GoZAAPrJqAHJcna
         JYOnd//hhlGM0O00lajEUE4WHY/lq2ZeinJNbnR93AWA0HsTq4s8uwcnpucb7uY9m/EY
         wS8zTbpk1nBbmfRd1EpH7FhI4dD1W8kOdNB607gJZ6xKdm150Ogh5dO9smgWJkIW8rCm
         1P9AoXBxtHG+3kY/G723LPW+2KeHE8ct80EwM39pmByjTWU3j4d3oZJaBpdx/8pzl84e
         fqtxpM59lXD22tIXbZ2KWWv9NEXIiB3EFO0hCqhF6/X+zkF/KPLCjaM9YzjeELHSkrtQ
         DnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036515; x=1734641315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ukUjedrPn29twgS2RyXJl/3j0v5yw5R2TD5EjtTSaE=;
        b=nwHRCIIKa9YBIPPM5zrEyn1NI+WEgIxcQp2B+q5uEMYRyYABLQx9vhxBFprbzKTtnO
         wVQgKtd9j/U/y+EtFiBxOjlIS6RGKMcJxwz+ENqhWHbKuIdgM39PWic2XUknY4Z6We9k
         WjeBjdGCkoQxqKSq5JlwCy9EszFmgOlVKCpx8xz4DmlZmD2xye5pt50PWsl/Fk6oC7me
         dWySKDq3t1tDmRtUy2q5NtfR3yAmBWrpM76Uey7ZmKOiVXWFyRT+NStfBiF9f6M72fKh
         Cl+aD8cuRaUd8fFY/UBbSfrvH+rXARRtD44fASC1zPF1FfppuRgFRuZ1zrhuPJxftCRH
         dmbA==
X-Gm-Message-State: AOJu0Yz2yRZuaRFyFpRjCN0PrnONrj9no23G3ZHjV1V8T97r3sCvSmTb
	tkbfh6KXHBTr1XcsWQ8XuUIJZy04QTraW1WPKxDWblhybFiXm6oC
X-Gm-Gg: ASbGncum9xzV6W909StFopj8iiiBl42xZ44XK4PrvmInO0rSUFg4db8WEiBbn5PIdZQ
	4SvJ+evKmFAu7HxdEftfXtYyXYYNA2MXjU4NzDmhK835E10H0Wd9Og7tfA3WEQB+7tQej98jiba
	382PsW8xerwiL29OV1705Llp/ATCU6wVqMFDfp9eFcQHjJ4QIBJa1SY/1W/gVhKOJTjoqyhJTWi
	BP9tCJmB3s7yyaTHmi2nFSY7nHb0+v9ioQe3nRPNvNZ1+qaL/kpauLlesQrLHQA6Q==
X-Google-Smtp-Source: AGHT+IFkzOsrb5/yL8v4szRLS5l5tfKnmoquzuR66S0cKeI8ixkxIeUoNPXlPl+uAsNP9DAxPXuySA==
X-Received: by 2002:a05:6e02:218b:b0:3a7:c072:c69a with SMTP id e9e14a558f8ab-3afed37255dmr4872855ab.3.1734036514912;
        Thu, 12 Dec 2024 12:48:34 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e2e08d5cb1sm817211173.6.2024.12.12.12.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:48:33 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
Date: Thu, 12 Dec 2024 14:48:28 -0600
Message-ID: <5d2d9a6b668aa9adafdd5b89f25136f3072586d9.1734036292.git.beckerlee3@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734036292.git.beckerlee3@gmail.com>
References: <cover.1734036292.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update tree_insert() to use rb_find_add_cached().
add cmp_refs_node in rb_find_add_cached() to compare.
removed const from the cmp_refs_node as it caused an error

V2: incorporated changes from Filipe Manana

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-ref.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..fcce73dc17be 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -317,34 +317,27 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
+static int cmp_refs_node(struct rb_node *node, const struct rb_node *node2)
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
+	exist = rb_find_add_cached(node, root, cmp_refs_node);
+	if (exist != NULL)
+		return rb_entry(exist, struct btrfs_delayed_ref_node, ref_node);
 	return NULL;
 }
 
-- 
2.45.2


