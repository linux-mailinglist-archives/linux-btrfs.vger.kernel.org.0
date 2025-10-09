Return-Path: <linux-btrfs+bounces-17566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E502BC7E14
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 10:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561221897CAA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AB12DF12C;
	Thu,  9 Oct 2025 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO81p+lx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA12D7814
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 07:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996795; cv=none; b=nWLVpPMb57+XQJIO4gfDRwWQE1NaoOX+m/YBqodeEV1eF5ePWLTfQ1hdZa0siQJMGpTFnp+J2fE3WFaTT9Xu3geZgKzYNNxE+lJNg5K/ehgEjuPcX5z3EyaG/3kwepMnCNSq9NLV8W3yn8+YJYVGKDQVHAyr7upw7kLzT7PmTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996795; c=relaxed/simple;
	bh=xlMZC6mRkrBvKfdW9aEiJ7hmUdu0jhNwT6sk3dKhWF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atMJW1ETOhDi9uECCMsCuUwq4SQJsIfl9sIFGhoB1gprs+ScNqkdBu0zCpAYD+VF44YE7StLVP0QHdv1alceMp8RC9ciqL3+9pEBWDG88YCuI9pxODLEqzyCb5thsPnjboLjeK87pBx+gKb8WVZo6k2bjjLd4yxKG+xmQA+JQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO81p+lx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b00a9989633so1886866b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 00:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759996790; x=1760601590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW55q2BD5J3Xoi/y6lNGWsyXU6mmPNteHryX4kl4OTo=;
        b=kO81p+lxgFPhxMP0X3/LdyVOyCs64XBtcPFUwAsPIyUBMw6D0KPIVwOcT7bR/0M8g7
         JnBfSKiY0QIB1eBSw6dz8ijpJea5WgKLTs72tqSE7/ppO1QNnBtnK9WVb65IxURN6Um7
         L2beVoQ078EfQPOLJa5ZnZoEw8RT5Sa7iFx8xq2sYKz5np2rQmOvmU9XVVq5rJNCBA5k
         vNGK5j4QiMY8Z+wUvdD1Xt7C+yy+oA/Kcwv7NLOas4MCDZDjnMqetMaNxB/kF3Z/L4qW
         /pH7d93YL7JqN2prxrM4Jpud88fBY9ugK18KcWpHT3gmDQRKrDGUozgC7yIvOk0hko5X
         5/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996790; x=1760601590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW55q2BD5J3Xoi/y6lNGWsyXU6mmPNteHryX4kl4OTo=;
        b=TlORQXmgd6Xh2MbDmqXRCSZbx3L2PKWX+Mk3LTg6U/yZhwcfG57yeZXAuvMAEMM9V8
         N38xczqntNFiv15l1lo8pEcTYPmH4glHIMCmuEyMble1/vXwFgAt0ByUcuS62Niq2MJl
         TdPRlONwl0BtcSqMr0BoWcRi8x7hKiPlVJpB78XCurF/xeeKizChKAOthU27QxrLmaWA
         fEPAdHfm38oIi6bR9lYYQWyKGuf3hu1fA0rfYypdtO3tGaJIXqzz6LfDyGEzr9mJyRxI
         lLRQLqYEHHVWt0FCnwxPG6y2Cz7CIXJevQoScQa3TVMDPhXihm85h8ODUpGgFAfjqtPj
         fbUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJiNDZQe63unybu+NHsW09xQkgESLCV420mTnWvCAAPHEO0WcjNyAfNJLPPYV75P8nHtfciIa7gGx0rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQsKt0KlSmT8yHLyHWy2O0H0KOJBmCdbW0GDG571TZJH3tVh3g
	EVLI43uCXURV9NtbU6sdNbL2BzK8jIKvNKpeDk8UF/OOK9YCB95vzsC7
X-Gm-Gg: ASbGncs0WhbAkRN7hfXhGIe++MvaQY7dEe1UCesldo98wKnUqUGbNngrhSJDpbWCbRp
	7amfzGjIIyp/9NiF/otGS5fDPRMXDZiTZL4NY9HO8WqT9COpTM8QyuA2wB5p+F6hL42q9MY5+CW
	o1zX293N25zdGfd/mQjMvNvmhT79hiuSMBmlp/OpKshGSuYhL/NcEikDfjEFByLcKJN01tlXQtL
	AJVkl/IViqk/xeyFEQZcgreyoCGkpXv0gNyip82MsHMKeBjoSQq+Jm9Oo5x9InEGOatbBSRQ5Io
	bHTDr0QgvuEIbQiOnCX1vVyE3LFNn0NsX+W1yLiici2xgrUEXwbt9IgX/4SW1ceHrE1m5A/DBuB
	eJiu3pyF7UtXkMGQrltR69kyX9TgmftNbwra83HwQNp51kwJseJWQk0ME81yjqboNtlUKStU+CT
	7dCwtSA3xnmB/QDWtfDTD2inaiZH+c8l93HjXRasStSZs=
X-Google-Smtp-Source: AGHT+IG8iDfDf6yR3N0dRnqDz6+DAj20GvNetdOlNJ4ULk45euX3/T1nyJA+A6Lbbc1K12QXDvop7Q==
X-Received: by 2002:a17:907:a4c4:b0:b2a:657:e733 with SMTP id a640c23a62f3a-b4f429f034cmr1144008766b.15.1759996789761;
        Thu, 09 Oct 2025 00:59:49 -0700 (PDT)
Received: from f.. (cst-prg-66-155.cust.vodafone.cz. [46.135.66.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5007639379sm553509366b.48.2025.10.09.00.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:59:49 -0700 (PDT)
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
Subject: [PATCH v7 06/14] btrfs: use the new ->i_state accessors
Date: Thu,  9 Oct 2025 09:59:20 +0200
Message-ID: <20251009075929.1203950-7-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009075929.1203950-1-mjguzik@gmail.com>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
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

If ->i_lock is held, then:

state = inode->i_state          => state = inode_state_read(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign(inode, I_A | I_B)

If ->i_lock is not held or only held conditionally:

state = inode->i_state          => state = inode_state_read_once(inode)
inode->i_state |= (I_A | I_B)   => inode_state_set_raw(inode, I_A | I_B)
inode->i_state &= ~(I_A | I_B)  => inode_state_clear_raw(inode, I_A | I_B)
inode->i_state = I_A | I_B      => inode_state_assign_raw(inode, I_A | I_B)

 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b1b3a0553ee..433ffe231546 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3884,7 +3884,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read_once(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
 	}
 
 	return 0;
@@ -5361,7 +5361,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
+	ASSERT(inode_state_read_once(inode) & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -5799,7 +5799,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_once(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5823,7 +5823,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_once(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	path = btrfs_alloc_path();
@@ -7480,7 +7480,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = inode_state_read_once(&inode->vfs_inode) & I_FREEING;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.34.1


