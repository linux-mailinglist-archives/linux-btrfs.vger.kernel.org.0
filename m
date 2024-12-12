Return-Path: <linux-btrfs+bounces-10332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBD9EFD78
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E50D28B746
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0701B6556;
	Thu, 12 Dec 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCfjXY37"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCE189B91
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035490; cv=none; b=C4wainySm0gIpTn6PE41eGhk9SsNt3TOmy9Qt4UInQhdscbomULy7aV+ozjykJO98fAnsRWveJJS3wBteXVDv1M0tsBSitGqhX2CBnqMTMKHqpH0p19jMz6U41zEkDL84na0Z+J0RdjoVSKCd0t/UddcxVlT0bPoJYuxKA+m96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035490; c=relaxed/simple;
	bh=MQxyUJqaalbeIkORNGIANIkOTKknWJrZfPgq3w57pbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbtskZrIliOylVwMMYh1zfDZDYmW1oGKP2GQgjVhKD5jk1vdEq2L/G6TTkJlbeDSELAFHmIQOj/Kv268tetcsBmwCTNHpu9IZ6g10IYc1mwHqviFdAHMzQYlU1sqrgfkFB8nzM5E3GsCJN9Hm7PTTYLmSFdZGVmtMQLi6Q1rgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCfjXY37; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83eb38883b5so36407139f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 12:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035487; x=1734640287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGnxyUBnvGdimtGOgxAJCTudkumkhvBzH4UQ1On88Bs=;
        b=QCfjXY37xLjt9o2YmUYYvIKoRfO0YmbhvH0fk3ecykykLVmiAN1eV34KG+btYs+ilj
         IeKydaFBW63ijJx3pig4Oic9JQvWhjTVm//0UfN311hydAWvuVjcET7gRYA0yBl3/T+R
         i3YwaKQfX9zkpUzKrMyA7s7YZJImO0xh02+zzvsUyO7kB6CGGV1NrzAzBcCiIkwwkfNX
         FH09xk0wYq+Jtsr0vUsWtRKxR8ZOhzwU0QlWC2s7zlNlj2zeb6qg9+hWiVuOYFPmKDrH
         Jo09JFu3FJO22bwK9ZqqIrwDlahVHHF05aTvH/o1/7Ihtc23E3/S7/Dlx3CCidbWj0pt
         407Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035487; x=1734640287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGnxyUBnvGdimtGOgxAJCTudkumkhvBzH4UQ1On88Bs=;
        b=f16bJAblaZjIAC/oDwsuY423PvjUn3Vq8nJ9hwRd984qCQGqcd4n4aaI99AaePJ4wL
         MvHZowUzOGTS+XphOoiNZO1q0DomdPgb5FCBOR/fb06KMT2A+Q1VS67Mc1Qwe6cLfBso
         s/iMkgcf/a4oEwO/8CJDoSICzQO3jTygJaZyv3BJ/fvvzmkRkR0/wdEFykqwEF+SQkwt
         OCmrQN5eXtxfzjZyBX0umcHX0WCar9inb1aUJjS4KbHWH75+shcm4OixsQ44oyVz7n4d
         nBXF/PYWLUN6720W1DfEekuVgriWGefCiplF89ocusWfjHkazKoTskU2/1M/ukpvyIUC
         JpqA==
X-Gm-Message-State: AOJu0YyxbTdmdUGWCl/KI+e2njbYcHM7Bj9lZW1VCjEtv8IzEQ4lFrjY
	pcaC0DUVsHKtQIaE2LiLyKm3djWSGMkaZondiMXPHpx/XfOKvTSgjsR1IIKNj74=
X-Gm-Gg: ASbGnctZLHTBTJBmiK/9/XsP0VXt5uCw45VMnJUEmMmeJUUW0VRzL6a2NU6/qWPbU0d
	gWxH4Ojo8dYnr5T9nuBPPSUnJJBBf/x6CHGcrgRgvHQvIIf/eWa+k/gcTRKaSkyS+iZ5nu1HNmn
	X+wAoyVP9VVqyV0IlYw2pTvY3j5ljSX8bq064pfrcfak1RSWgIxEFYZkDv6DqLzSqgX0mPmkgT6
	raGMHBxckhpG0F65/LeLtRNZlyVR0gesiMfsjZtri42o3DIWbOUkfYlBCgbRNDGfw==
X-Google-Smtp-Source: AGHT+IH5A4H6/rhGA/wpCr3DMFcLgEunrKLsq9etK9KkGUpv2WdCxnc4wZvdzABBoCkBAtIGQUj+dw==
X-Received: by 2002:a05:6602:485:b0:843:daae:e16d with SMTP id ca18e2360f4ac-844e8822360mr33089339f.6.1734035487252;
        Thu, 12 Dec 2024 12:31:27 -0800 (PST)
Received: from LeeDev.lee.dev ([2600:8804:1a84:2a00:be24:11ff:fe2b:2474])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844e29b6103sm28642939f.29.2024.12.12.12.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:26 -0800 (PST)
From: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
To: beckerlee3@gmail.com
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: update tree_insert() to use rb helpers
Date: Thu, 12 Dec 2024 14:29:44 -0600
Message-ID: <c80d0f92b73983e7454291154b3fb6ae555f6053.1734033142.git.beckerlee3@gmail.com>
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

update tree_insert() to use rb_find_add_cached().
add cmp_refs_node in rb_find_add_cached() to compare.

note: I think some of comparison functions could be further refined.

V2: incorporated changes from Filipe Manana

Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
---
 fs/btrfs/delayed-ref.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..3cd122c899cc 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -317,34 +317,27 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
+static int cmp_refs_node(struct rb_node *node, const struct rb_node *node2)
+{
+	struct btrfs_delayed_ref_node *ref1;
+	const struct btrfs_delayed_ref_node *ref2;
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


