Return-Path: <linux-btrfs+bounces-16853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10112B5989E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E191C01AF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 14:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DE3345750;
	Tue, 16 Sep 2025 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfy3Z2aZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3D319861
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031185; cv=none; b=l4OCuC6oVpY0YpHB64aJQCBtQtJ80kXl5eVVly8FI3/sD878+hF4WMta4Flpfzwkh0IjFV3RgNJaWu4xRWsV0c8o417Qr68KExyjhjKmL0OfZkQ2Dg5aLGBut3Z0NwH3Cq5bTzUXnBFwVUAxXcC1/teOOpAu+J2D426kWaxLESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031185; c=relaxed/simple;
	bh=Nc3Gee0vrTnwJ6vndyB/379w2+GYqChkKGGXlbOU7TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHGk9tZ3DnTC4FOAHqKkD1EBnPq2IX+czIGDHB1rL5/X+7Nz+EEp7Gyy/7F3mnwpHGTDLPIa+Z0+JMEpZqDZNZvwo2Nm9L2MXPb1IkGV5K8rFnYoqNTcqcpp6lD7NhFDDsg6QFMTuyHxVzIJ0GcNrPHPrEcWtgUFBdpPvnHaIMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfy3Z2aZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45ed646b656so46878035e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758031180; x=1758635980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMpr+bvOy5/2/12diBRSepmR81u8HtS5BLKXmxw+l6c=;
        b=Bfy3Z2aZLBnOB8OcwpmFwYOu2POPQiCG4qrDIkeZLAq85nJOPv1oMvqfVaKt9AsC3U
         3Uktntb0t45qL8UPokum8BSzilCUJhZhCsH8jPMbp2A3URiWK/XkKMNL1aZ8ikktgwBC
         FBu5TXgeNYsuIf4oWRiw/mUKTgisVJIz65TMwWMF5XFrST7CGgysQOapTPSkeY8OB1Po
         bHsoKAuX/XJXtM9D3Q2LAeJGNG6408NFZoxD9aTf1YH3tTR3IOlipopr6kYaWogera6L
         CkZKsIFl49pl06CdVK62sd9Pg9v0yido6U6u3FZ6zBiGjqPfOhiqLQ+7oAV6VRsKGfyS
         Dsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031180; x=1758635980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMpr+bvOy5/2/12diBRSepmR81u8HtS5BLKXmxw+l6c=;
        b=VW2FPw2Dx5KpTLTUiaSV6a7H//gNu6IbELoJXBSDBSWKnn6R5A+fckPpPfVxMb2vCV
         sQoAtLzNBD1mc+klFbaxrfxvM/sP8iYBh2yfDEuHkwcbpWqiG1S93+hmfWzm8sxsVm3a
         kX1S5GppFZxVqkg4QL+IprTr/UGcpqt4Q/xkCa8b57+DUwQ+cCbCCRs8DfUmpeCcvrhE
         wnhxNe04pXMJ8KY/QjfEA4jhVtg5Ar3l808haO0SKdWmQ9tQ9OMmDpxe15zwjcTCnoAx
         XL1p/nSdwfRH74cGz643OwkEfXXYOWGT2O/IVVxy3pRx9Ji5WDFXip3ZEMlb1ypLYLJ8
         HV8A==
X-Forwarded-Encrypted: i=1; AJvYcCWyr7d4CB7B4EQ8bGD5n5+PNqXMuexjDQwDFtF1lopYvAB5q3NAGk0HcUmsk9ljU4o59QRIxD4B9AfB7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQQ7MUzixOPXROSb04icqcwhdC1yBmu03ausDxDyfmtinUfHe
	wCRqengf3VIEGf+9OhpccQyh8op4AHwzZ3F0tZHyVUyWb+ItZAr1VpufrjarWLEY
X-Gm-Gg: ASbGncs2FAH9RfIXiVUs/sWjXbD32TM/qLBZ9jHhbQqowHYQqaj/52oTcSootP39zRQ
	09mooTT72eEnUxkOReqwujMpjEeFcWNABEKkpClFP19FALgG3TlrpIIOCMMdDomk1DXVsza6060
	9Q+j8sAx3HNzCZfkpl+7VGACxOVikdYnR1IKo4/ZYe4Mn4oNjraZbeufnseVt/G2L2qwV9YOZvp
	wgyGfBtgGCO+alSGRKo1aTnzDvVJTzkKHTTz4ppEZiCUsPlShAFOgR8xgHazyXGizjkMzJ4omZ4
	Ea/XVtcYMOBPdOpuasnN1fLUgNuC6w/lCvrQ6nZAWPjA62y3iV4G58nfhBVPxeXpNVp5wLl2GgX
	LlrZxVYmMrklwrSB02aBPZ9WZ5ifiG40497LNBBRS4H0jku1OZ7bIXf4rkUBY1K5vuqpd+ZbE3P
	dxDBuG3dg=
X-Google-Smtp-Source: AGHT+IFbHxr4sMvLl74+5elP/3RKStElte34B3ctaItgubMLw6jX0shTLa+rud5mii4r4ob7vh3LMg==
X-Received: by 2002:a05:600c:1d20:b0:45f:2b47:b06e with SMTP id 5b1f17b1804b1-45f2db8764cmr67166895e9.18.1758031179775;
        Tue, 16 Sep 2025 06:59:39 -0700 (PDT)
Received: from f.. (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7cde81491sm16557991f8f.42.2025.09.16.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:59:39 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4 04/12] btrfs: use the new ->i_state accessors
Date: Tue, 16 Sep 2025 15:58:52 +0200
Message-ID: <20250916135900.2170346-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916135900.2170346-1-mjguzik@gmail.com>
References: <20250916135900.2170346-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change generated with coccinelle and fixed up by hand as appropriate.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

cheat sheet:
Suppose flags I_A and I_B are to be handled, then if ->i_lock is held:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally, add "_once"
suffix for the read routine or "_raw" for the rest:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_add_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_del_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_set_raw(inode, I_A | I_B)

 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcd8e25fa78..eaf3c20e5b23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read_once(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
 	}
 
 	return 0;
@@ -5317,7 +5317,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
+	ASSERT(inode_state_read_once(inode) & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -5745,7 +5745,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_once(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5769,7 +5769,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_once(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	path = btrfs_alloc_path();
@@ -7435,7 +7435,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = inode_state_read_once(&inode->vfs_inode) & I_FREEING;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.43.0


