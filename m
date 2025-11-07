Return-Path: <linux-btrfs+bounces-18800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BB6C404C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 15:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C518A4F20EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A296332A3C1;
	Fri,  7 Nov 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETVmxdsL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7067F286D7B
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525325; cv=none; b=jQpYeHcT5dMTW3V1Xr55xxfpO17w7nt7SZKXW+RB2qFZCJf0jdLBaTdNzylI8+99KqOnR/lyD0QvxyodOOOfrG+aGUW64yfULbKZTX+qrON3JV1jyRs2BhWThhZAGdh3v15QHPCPLDuS6JeNiFYqJ5jnFVcyYc+jhGzVcRJv9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525325; c=relaxed/simple;
	bh=128KSekg9ZnF2sASoMn8sOUDRGbIcWBCHawlZ+Q48b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NalZTnFgI0tigxjsnmW8TZVV1qBLfF24JMISACr4N3+LqhlkkpjKysNx2qmoaYund8Rs25f3cjX6rQFQaUUagJDBzf9HG37na1v6CRCX3ymuOyhRA5Ls5RHOVInGbXnZb5WPD/3axKapF9N0PwWrO3ApcL2eMbW/y+XYXlxT740=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETVmxdsL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b72db05e50fso27844666b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525322; x=1763130122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wT6MSCAlH/pIZcAzO5vrkwY0EcFJEg7V7STMnWnK/pQ=;
        b=ETVmxdsL50D5FLUBG/X9tr4eyj0jP+bGDTcSp4R9wzOn3zi+uVAoox6ikqXiO80Td+
         OVe/LnO45No33dcaVpNyy1rfTbEnYYO++sgWGnMx75rCSbBSgVX3q4857YpiQ6pwrX8k
         dkpZRo44UCYNbM+WXT9GrMTDL4mrdun/dzxHvNpKqOpqJuDAzGkrK2zpu36UWG0iVj0w
         xd9wkVAvTL/KqxPCgzV7l+WporwzZu8FTdaq5qC0T2BJuW49/1PXEH9gdpw4rFq7PO2b
         kRrIzLlCMm5/R3UpCTsL+HvZKb+UQZhUpgw7lzZdd/aYuXkHguc/Oee/eTeGSZv4NKEX
         0JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525322; x=1763130122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wT6MSCAlH/pIZcAzO5vrkwY0EcFJEg7V7STMnWnK/pQ=;
        b=pi4WwFvt3U/N/gwM2gvvGmlS+xSKP+1C1ExVi5wvkKqXtEQ2/ENNcQPKg/ljvXGafj
         aCp+2WmzFZOddo2fQ4FvG2i2VHiL7mynFJqVB9g5SMeMRDQrQoG+TimuhJFgsYDd3Vjp
         rhSiRjpcXC4bZ9l+bFARwkKsjTWDdTyJH43Ol2Nq1ffnGwG9GS9u7i8qRQ97Wrrexd75
         tnhj5Nwkdhz5sQyLYyOUjjbCk8VFFF/rOIusymxRo+TvKGI/lOyQFwkQdC0IWdIlCybN
         efn572VgK97uoLAQR2h0AX2Ao2r0l2EW2RgJnkEK6RHaHPncYVG3Tn4CPlroUszZQS1I
         igaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2bD8uUxQKyBs83IgLHP/8Rv9iKU0hEFcnhisKdUee6Eq8jimgNe967NADv5hYi//QO5CaBc0a8wMegQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7IPOmjTr/cTrL6y4eUwKV6dWOZW64QhsKdKl14LAk6UPMHxz
	k6oZpiMI/xDB5L1lWp5e3BNtyvmNHBAfx0QkmIBryt0/zXAnUEC0yj6h
X-Gm-Gg: ASbGncuaA1ZMyQd+ACvHnVtvN32N8hWpjdsjxsQvC62HnBo9qOLxFufwv/hWIysJOPB
	LbHMVRL3HNm8TLeQFVTEfPGRIrtfv8sISqbXI5RWcZmHNYXtk4cOYSst81lrrQkaI6zMAzwpcnX
	7o7SQpBpRvq2wcfbdby4XtCd8IUYDmBVcuKzO+GiaKcDLVE1k0L3+Ct+lx07rp0f8ln8s6U8S0W
	wqZqUwvjKByG+zSUshSgLt2RIueY5qirfTTAWDXyoC9SY0O1gI/KDrKvm2iPpWqyVgGBeNGHmDI
	ci/A9UjlcLXN6YBUd3zm4ASTzt8rZpQTTV5lf/Bh1LYJuY1PaMGMrJ7Yhz9Egd6u+bgpyeVvXtV
	nStS0xHge+rJIrR3uUTYfd7+QX21unqsrlF0eKZB4wcabAD3g1e647VktpNb6WBPY/19a3AJeK0
	lX5v24zj8KylaGuB4hAHEafrT2TdhhX595luew7CH/8vgVr/iZ
X-Google-Smtp-Source: AGHT+IGrbWD7yFMbT4C/yX4TspKvFS9f6XhDjvBKE1AYLhGSfZjTB0CFxn4t/7QjDw74UBz/8iB09w==
X-Received: by 2002:a17:907:3f1f:b0:b70:8e7d:42a4 with SMTP id a640c23a62f3a-b72c0ae2029mr426905166b.36.1762525321480;
        Fri, 07 Nov 2025 06:22:01 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:01 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 2/3] btrfs: utilize IOP_FASTPERM_MAY_EXEC
Date: Fri,  7 Nov 2025 15:21:48 +0100
Message-ID: <20251107142149.989998-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root filesystem was ext4, btrfs was mounted on /testfs.

Then issuing access(2) in a loop on /testfs/repos/linux/include/linux/fs.h
on Sapphire Rapids (ops/s):

before: 3447976
after:	3620879 (+5%)

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..1a560f7298bf 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode->vfs_inode.i_opflags |= IOP_FASTPERM_MAY_EXEC;
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode->i_opflags |= IOP_FASTPERM_MAY_EXEC;
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * we are marking them with IOP_FASTPERM_MAY_EXEC, allowing path lookup to
+ * elide calls here.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


