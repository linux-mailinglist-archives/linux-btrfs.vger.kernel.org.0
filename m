Return-Path: <linux-btrfs+bounces-16408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A70B36F4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FB1189034C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5001F3705A5;
	Tue, 26 Aug 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="QBarsf6+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA936CDFF
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222912; cv=none; b=BzRsD/lh6yPrLlhSS0pc7KJvh0ZSYrJGTECAn33TcV7uc02h0JCtVBT3sWc2o6Woj1a2OQ0z8B9xzsGsdceNZbR0XRb8DiMBx8xSI1uiKROcoysjdSNDy10x/dl2p+PgGQ1jQgidOD+kEjn4+SF1LgUai9yZCsPH5Qnlnwj3Ghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222912; c=relaxed/simple;
	bh=2zYyZLHp4D2hgXiAAGibRc45yLHOvZtgp5B6E/34V4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPTPsAbEKLSy6/9ZW5MXMCWbr0Nu+Qbiq9+DY8/n5XRR3MD2WgLH29N22Wb6HXLKABXscbto8wjOgVNKYVAUyC3K8HYewlVDXpCvvHGfn7BEqce6K8KRjY2S4YejtP4IQQUuF/Gsxo6L6R7Ca6jjfkMtyBJv2k/ixpqQKk1/akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=QBarsf6+; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so4256086276.3
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222909; x=1756827709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BE//YinxPgmUWE8hsLrFsv2AZQscov+biNx5LkG7S88=;
        b=QBarsf6+5qFf4TdDe0d3qJt9CTe1q6JApaGKRCFwzUvqQhRcE9umkfMdU6tSTYB1Ly
         GyJk22XkSTXTcDGh1XJ68x443V+YkvJ6DKF2a9rrHJ5Lot6vOpDb6hBi3SSNTy/gSECR
         5oBpg8tsiQDbgCnT2T7fqUskT3VWmcRtnRFbHtaYgxpCcTs7a++Ns2teQByV4ZWl0jkF
         9frRsgDUa9rZSfVwfXTisE2TRn4LhviWcCf5OVux/cGUZ53/Eig9dLl1C3kdZfHzaHo/
         nLRjQxJ0q5JpkChLXLguhoFUs4UH/gaYr29tmTm0AnuPxTIUZ9FlbQC23zS4V8eGcpmg
         RbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222909; x=1756827709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE//YinxPgmUWE8hsLrFsv2AZQscov+biNx5LkG7S88=;
        b=an01QaNR1OD4WiQ4/LXjQRMg3bTWyTOmqqom34VlnJt/Po/h7DHBl5JE4kpnDWAxGY
         fMR4M6Et+AShKMlidI3p8UXr25xIG+PVUKq6QLELAixRj1v6JmdcjSROvrFQZfvPO48I
         arkQcjYfWdKSRZ4ogUp+KLeLBwfXANpns5j4ceUXYL54mKyafergZv93h/4z8AkiJ7BI
         0n73LakRbeLulnF6JKwgyquTSdRithpX3quMdm/i9q33vdqsx70DZcfa4oabWuDuTZVj
         sL7EX+RNqXhCr9SHHq3951rA9VrkIzUsC/IPIdHUZazTcfBH5mnQBvvOcnRjN3c9EPKH
         NmnA==
X-Forwarded-Encrypted: i=1; AJvYcCV+b/Ord2C9eP/ctdE/0ICjSXKMlGjWr6Jad5q5IjVsr6oakCGxPxnhWq9t+NvUx0uGC16yk5/M+Ri83A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdk9FgYPxFNghhcgDhOPgJZpWg/AaWj8I5S1opa0iWRtPRluS
	5Iz/tLnUchBihcsOVV0Op67brbSjbcDxRRponC7u/5T3BCMJ7GCEFt1UNHhc5F7nPBA=
X-Gm-Gg: ASbGncvLmq1tf8HFzkjsO4ay45bgbobXIGXZozpNyWTdtNk3Jkz9Oh4VMODLhn761St
	w6iBBgx9/30lbi59B2xxaqPNcD+ml9bjGH9KKC2GBSopmONsODaMEaGwN1KdNLRINNcCJVBzT6V
	xKRGndJfcn7Tji7j64WTW2bYU7JosrRKgvaaegrB7BqV9SQqBnv010TX/Dgd44mOYpcvDl7/75K
	O8jAi9OdeOwl5ILSATSEFJUFFOZX6UDa25mBZMAUr1lbnkXvjw/a/gBujvPw/fCF4Gg58arxD2w
	dzGg5hNtO5m9zv2gDIX3fJ3MvNbj4NbKu4WWuXVhe/hZOp4FhN+MtmNLYPaxP+g49HQ+gYgQK4G
	jD1RqhHR/N0Dw7PIxwXgOEisT6hFEZ7qBO85p7507hd15kE1jQ6vlTZNU8+w=
X-Google-Smtp-Source: AGHT+IF30GxXzt31jHcfNUoY2pUyBatIJtVlXY2VZDYDljhQelnzFVQCaalCRl9Yu+PEcvaFlg6PNA==
X-Received: by 2002:a05:6902:2b10:b0:e96:c754:b4dc with SMTP id 3f1490d57ef6-e96c754b6f1mr7345665276.18.1756222908777;
        Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96c38c8efdsm1865626276.14.2025.08.26.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 41/54] xfs: remove I_FREEING check
Date: Tue, 26 Aug 2025 11:39:41 -0400
Message-ID: <830cf8502686e1bafe75ec6fa7e87c68ed49bd54.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can simply use the reference count to see if this inode is alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/xfs/xfs_bmap_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 06ca11731e43..cf6d915e752e 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -514,7 +514,7 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	if (!(VFS_I(ip)->i_state & I_FREEING))
+	if (icount_read(VFS_I(ip)))
 		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
-- 
2.49.0


