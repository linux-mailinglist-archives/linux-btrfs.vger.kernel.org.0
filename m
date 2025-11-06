Return-Path: <linux-btrfs+bounces-18780-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AE3C3D00E
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 19:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 976284F3B85
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C3B354ACD;
	Thu,  6 Nov 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksfDpozy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDF350D61
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452081; cv=none; b=GCxoSzFoVbaN86ni9PXB9rXTdLU1mEcN8jUE3bPbTT4NCRF4wQL+sc6AVPLmmsQ96rnwWLA3qeWCFbkh2e1MFvcEh5B8Ix8+nNganRiX+b+uDvpSKv49q7ydoEUzZeFBNsrEtUt8UQ0F3gZOqPoIrOAA/QKKxxN1wQtD315I4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452081; c=relaxed/simple;
	bh=5LtjXMmzmSXGmRg7hUCR8hen8AGyJaa9v1b6R+l+ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uK5Dk/d2s8hlu6k4NTmykDhBiHW08S3rcqWHsb8DqbPcuPi/CHlGsfc9KGLz+zGQWg8Q17b9iXR++YSCLODEf2PZIhIQQX9gbun/n5AzNg8eCu0JvGfjmUOe58fP0EUg+1i/G7lZcD8Xbl8AQj/uHcXqFsVc5XR18gKu9tvJuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksfDpozy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b7272012d30so218767066b.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762452078; x=1763056878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=ksfDpozy9aJfz/EUpiJfskYRq+dCuyo+MdyvKVLgQWYOKA3U/oP4V37TUcatiRcn0Y
         ozrykxYtA1iluwVsgqI2yDU4CiweuryNlQhk987UGvLDaVaqNt6iIHZU0dIL0t+ZYk2n
         9yWOyPgDDF8G20G/lRqwUOKML+RFuCPR2Tusw//LqaCCbupghIZbs9qdA4oBD1LKU31y
         eZDwOxRUp4Z1OQmjTIPQJU8g82bnK5yL28E7ZGT2C88GJFvZFniSzVtFfp8tpZ5ZhRDc
         78x5j6U0Hg/ekgDutVkCy6gs9MfJmepJKmjqPzXmNiywMX6OuadjvA4H8WH+WWThV1Kx
         lfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452078; x=1763056878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DHuntKUQFzTj1tqfj6SLYorj+0zzI3N/cN4KqeV4e68=;
        b=cypz0Qw/5ZJ5LPGHWkMDZCKymGN+E1f0lM7mpOiSdmwwPAkeIx7PxtdgTSvouZZAHG
         TGsqvjoh5upohb32gs9J/U78C1x+27sR8iPQfhUok/FqP8kNgpPndamXwtYf1lKQl+eq
         0e8cfyX+uY3JRGjk4VS927pOIdNgzgqrd3STkEqFP6oVS/hw9BGn5K7BFxOnHCdM9is4
         xusQi0xAgMjaX6DUR0QcXmfuVUEbkMsYXdPikxZCvbS0F2hmsKpdvqHaWtZqxUxv0ANH
         b/6J1NbzGZ17VVy6nWK4YByKSYfHFb4kFvtIXgwzVbijysdFHaFBGljIqyxx91kDxNDy
         WsZg==
X-Forwarded-Encrypted: i=1; AJvYcCVhvytlwif4/rVognG2psRjt0TxcPpBKIWpSWghHNlH9fIoV8ZED6zY0d7ukL8jjRMwaCb2Sq7ABf2dlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwIwcmCzphVtfj+J7t8eIzOxMCNpG2ZT+T3YecuT+a2o4jJplX
	k1L9iMtAW/6gOyxtxsUTLWrDKzWpD4PDEjfVdyyzET7/YXPe0FjXVbDo
X-Gm-Gg: ASbGncsxce1WKlQFz+Sj91TictzIr9a55XaMTe36N6KP7Ko1pUHDDILuwHasFkcDmQs
	18dw2b2jziqV4GCOo5Lws28SjtqNef3KjybAcfl/fJV1ilRSwXzQTMldJ2nOvGQSmF/ERua8bzT
	EExGdo/K88sN6RYl78fUd5Bo6rx6yaebP3tNMW5VDDf+sxHuyaQLnX235+16BAhYo/zhPUV6KKX
	Bt80pgKka3gsm5vFHGy9V+YdzFmhvFmy7dByoGlCUywEOpSqjBpCRgMvZ4s6fqaZ+fO/J8jj9BA
	gJoPTgPrrpYQd/climDnzAAxb+ah6vPN0SDOMStnBgNY5wCAivNhcWGSH3PvNV5IC8ieaG5UADj
	z9LeKifKQN8vBYw4en8N//f6jkbluziXTTkwxfKWeCQI7vFbvrfXVdYvi8gXozI12lVCFT+e0bX
	wmkeBcBdMtCaPIit54Gnil4hHhvptSldloaTHMoH6cSrUthJZu
X-Google-Smtp-Source: AGHT+IEH7VQOvOdhRi3okWflF+KjH86D1HQeDcRUW3puSes+/n0te4BbALgaZq5PqIhcusM+kRCOPA==
X-Received: by 2002:a17:907:3f91:b0:b70:b1e6:3c78 with SMTP id a640c23a62f3a-b72c0d67c80mr3453866b.34.1762452077678;
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm15430466b.65.2025.11.06.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:01:17 -0800 (PST)
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
Subject: [PATCH v2 3/4] btrfs: opt-in for IOP_MAY_FAST_EXEC
Date: Thu,  6 Nov 2025 19:01:01 +0100
Message-ID: <20251106180103.923856-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106180103.923856-1-mjguzik@gmail.com>
References: <20251106180103.923856-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 42da39c1e5b5..42df687a0126 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5852,6 +5852,8 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (S_ISDIR(inode->vfs_inode.i_mode))
+		inode_enable_fast_may_exec(&inode->vfs_inode);
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
 }
@@ -6803,8 +6805,11 @@ static int btrfs_create_common(struct inode *dir, struct dentry *dentry,
 	}
 
 	ret = btrfs_create_new_inode(trans, &new_inode_args);
-	if (!ret)
+	if (!ret) {
+		if (S_ISDIR(inode->i_mode))
+			inode_enable_fast_may_exec(inode);
 		d_instantiate_new(dentry, inode);
+	}
 
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
@@ -9163,6 +9168,11 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
+/*
+ * NOTE: in case you are adding MAY_EXEC check for directories:
+ * inode_enable_fast_may_exec() is issued when inodes get instantiated, meaning
+ * calls to this place can be elided.
+ */
 static int btrfs_permission(struct mnt_idmap *idmap,
 			    struct inode *inode, int mask)
 {
-- 
2.48.1


