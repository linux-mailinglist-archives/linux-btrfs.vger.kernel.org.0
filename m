Return-Path: <linux-btrfs+bounces-8941-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C56999F80D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B4C286B07
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 20:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A301F819D;
	Tue, 15 Oct 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeBJwQSr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1143E1F668B;
	Tue, 15 Oct 2024 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023915; cv=none; b=lbi3IPG+Ddes/n1f73eKenpue7goqBrQpHRrp6nS4vORZzEIwPsVe9ufgiYoBD/0IKKuhtZ/jvJSKJIIRbZpUB9Gvns9UVOQbfRAaZGZsagrqNUlll43HF0dAWqbX66kVAACLslkLezOcjBpiQcurVX4APiB1Dl3FGvf3hiEXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023915; c=relaxed/simple;
	bh=21YGFtYrTpnZNmqO+X8RFoSALfAMcvTfi4fLoLGKewg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXu7mz9pxbWhjAB5Sx8eWp7AbBLFkEmLwgcF9o3CuPk+Sz3+LnyrJubSisuzOnD9Bcd/qVx/y+f+0M6HNz4oolB7JX+VcCei/zrG9WuvjBi5z/9iKVbPbZ8P9GL5Qjh5rLWG67wcqUoZfXXq0lUgsH09S1mlPbapkiC6ApQ64UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeBJwQSr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314735bca2so7265385e9.0;
        Tue, 15 Oct 2024 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729023912; x=1729628712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sBuh9qedRngbKbx/KtPG/i2ytx6KF8a3n9MhiI1P/s=;
        b=KeBJwQSrfAfBxvIZjNNeWfxlwgdY12NXCzv90qO23bTOZ7RNCoRGQHO/tvBOV2d+yS
         IUg8HLsxde0/GvwSAPxCLiXEdEhMUY6pf6Axxq9fEssl5XrBbYatFHVS/7W3ii/HJK4h
         pclUR+EJ9v15DZSEcRi3i46JH23fcvxguRIyJG9MO3LEpT1Sqeng4wUMfuvaery1EIk8
         Yry8cyYLwmT6po3Z63N0y/0+sI0ISqnWpusgdm5KaQ4VMJkWLf/FxJlP5iEBEg3yKBAM
         ake3U/clku4oxzXQEH3oUEaNyw4Gop6okQiGCDnzszmmiJXzRpge5PpUKmqCP7tmyJx8
         jOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023912; x=1729628712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sBuh9qedRngbKbx/KtPG/i2ytx6KF8a3n9MhiI1P/s=;
        b=TXxHvk/uqxxVfMbMI44xUIEEtOTUxs1jLfVzagEMkKn3hTJ3r4HQwSkAT8hKw4r9qm
         rB1WUOmdthe2loIaVIfilB8ZD3O++66L/8svdGJ8TBq9SFTzr06T+88lMlTA3t2HJiM6
         8TBP04FUdA0wkNxWCv9/G5b87tKr3zdBbDjteSX85PC62311413GO8rDMjnYJOBroGmN
         4cHv3WlY+RpBZ9jbFUIIqex1Vrqq5Mt0x5fOAmbGEhjJSZ8lp1I/K/VTF3SYkPefiFw1
         HExyB/lv65sf2HS3aWE7P7zLQY1JmvJ3dqpK48i4kmr/Dq+5iffr2Ap+19RJ7PV/ZicB
         it9A==
X-Forwarded-Encrypted: i=1; AJvYcCUAa2W7EafItxRjE8ey6+4VlkPJmMP+MK+P/sp3gkTL8W/js8puUmzJcqb51R8dxqtQe1woqOeCNVUGnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ8f7bC2+kXFK5OisxmWeeZ+584R8vkc4VDyVc2IzkWXIkXaUm
	1o/TIKt0omogKKjCJ+pSRCzscVIU/b5RmXlkU6JO/pnW/vu39e9u
X-Google-Smtp-Source: AGHT+IHtZmI8MKeOoY2/8KxiE8gn/R7hYDYyjM4LrmC9JkoBxr2KotWZ1/z7IXAOTSRXGBU1noVjsA==
X-Received: by 2002:a05:600c:1c97:b0:42c:bbd5:af60 with SMTP id 5b1f17b1804b1-4314a37ee4fmr15344365e9.24.1729023912305;
        Tue, 15 Oct 2024 13:25:12 -0700 (PDT)
Received: from 192.168.1.5 ([79.113.196.154])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4313f6b3224sm27679035e9.32.2024.10.15.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 13:25:11 -0700 (PDT)
From: Racz Zoltan <racz.zoli@gmail.com>
To: clm@fb.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Racz Zoltan <racz.zoli@gmail.com>
Subject: [PATCH] fs/btrfs/inode.c: Fixed an identation error
Date: Tue, 15 Oct 2024 23:25:05 +0300
Message-ID: <20241015202505.10149-1-racz.zoli@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed identation error

Signed-off-by: Racz Zoltan <racz.zoli@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5618ca02934a..9c737e63c339 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4226,7 +4226,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
- 	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
+	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
 	ret = btrfs_update_inode(trans, dir);
 out:
 	return ret;
-- 
2.47.0


