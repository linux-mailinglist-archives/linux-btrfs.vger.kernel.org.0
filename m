Return-Path: <linux-btrfs+bounces-13188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA691A94F6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 12:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1527A2DE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307226156B;
	Mon, 21 Apr 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWyAJRvn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7991A83F9;
	Mon, 21 Apr 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745231583; cv=none; b=uAUxNuilYKmxCjmGQsv7RmrjuxRklYr6CSLKAkiqlQblEdusVqAtamO+Wh8bPoOoJAoP6ZhZTCSUByvhhELNLSIJZdXbk4tIb3QQIJdcZpp9s1i59S1eVS3hDDB4RyAw9WQFiz3l8iHtzxi7KtM4u0oxuAdNhy9SCLV/DzOSWwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745231583; c=relaxed/simple;
	bh=zxsUjeLDItdjY5XPiAgnj5SQWSGExzC8k8yc4LeTOu8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=g37dH//TVXML11LhTLvSo/Fpxwmr/kThc4G+0YJ5O9iHx4EnNu9OmE35dXETFlUkW+WAPB477wJjC5LrrNzmnRNZpxV47R5iRETj3Eidb6a0j5vF/RycGoaiNV+sT75aYXhbudQehl5g3hJ72DSCEpiYB80nb9pSj3Re/JbcdGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWyAJRvn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-227cf12df27so33127295ad.0;
        Mon, 21 Apr 2025 03:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745231581; x=1745836381; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+1KbBLOyXqbGFLs9ANDAkP3Rk2DvNcr/nH0mbK+vJk=;
        b=SWyAJRvnpjJid0YonUolL0Bvi2D0VYK1HiEjvCDx8s4aGZYO8conxZNT3ICq8pAbTQ
         3VoVf71vqP4PIjQ+AZZgv6cLTQMi9IB1UeT97PPlK8h+PN7uvuFkdXUU4LjUkGez1j9q
         Mw7mdtrU/qSNW7Gj69oEkMX8eMrX4cfbhjBYY/mJIW4OhY2nSveXr31rBHl85qAwnqjM
         HTH9IUU5oUCXdUEz+aSY8HNdJ2zBG70UAWVuwV2p8jf38pTIBQeNFcA8bdDcyk+Sf3up
         8oueVGo2wOsgnFiBGn+3vT1OYZMRjt09yi9vjGJv7/AUVAuADXNmzL3yWVHKV+LspY4M
         naWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745231581; x=1745836381;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+1KbBLOyXqbGFLs9ANDAkP3Rk2DvNcr/nH0mbK+vJk=;
        b=QqbhoqBYg83He1uIpE0NerjC3ByOBta+ofNfp9g6QqPuEK+Z1ZSoJfgPUiabpdHDPq
         EhFuKumFDaNxociobRoNUs407acHcdtySYu8YH/vtQU7SUrYErIzQrMjCPzAQvBhwv9S
         +mXeD3MkY18oUgkogZG3v2ttZp1R6/vsiBBF5AApdFC+c+vyosR+QzySN6IlmB4gkGL6
         eSt+tVrHyosL8ds2l22g2zoQao9ITpYk66q0qxNcTlRbLEp7ncgK8Mr5NawtP0rux4se
         853Od9qVYvx8cd7rvzsJHnsNv6qWG7jhYvmV4aQWySr3dppH6dnMdKOjrCvabWl+d1IO
         pwQw==
X-Forwarded-Encrypted: i=1; AJvYcCWPVZYom4Azvw1ZfvvwaTQupPQWtjEHfimDmVlHiTsvgxNJi45Zb9cnorM2UPllnPE6J29aRGUqMFvDvHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD4a3zSIeaM7GApCIBAKIgTGxQJxe+EqcmE4QknVRzihKdD5G6
	QmUEtlsT4sTamaans9GYrUW2s81G0za0TFg4snUmw7GK8PSt6IcY
X-Gm-Gg: ASbGncsHMoxbxWmEt6BgULJCN/FMGbKzSnWkjbVZfaC4FsF3cqcinlHQEhB32DiH1Rv
	DBjBfv/22xXgNksMASOf7LzEyHrlbRzseGFK5fRweoV7IPgz5OlJ8nAoZJ00X+FhyaEJP9dTVtZ
	O1pRhoIfnkITY73CO7sirGklRZv+qJQtmhQ3QeFDEeUF41sGix0x17alNb1uvKi9ijTM7maGj2e
	IXByto+JuLzi53VKjE7hGhpwuqGjn4MvAq1Toz1Bk81FvEwj6ba2rOwgXRkQUZpzf75qFkzWIFd
	5gmq/EvUHe0aE9r4RscjNiTeFusQlOKJadDGRiKVGOVcJuwSCGf+Cy899F1bhw==
X-Google-Smtp-Source: AGHT+IHp4+/QV3p3/cbUQHQSndcRTOMxJzxb+wPcLm+OQvOvpoA6uuGCsRkVUeCra42coAfSuzvOgw==
X-Received: by 2002:a17:902:ea11:b0:226:194f:48ef with SMTP id d9443c01a7336-22c50cfb165mr168375595ad.13.1745231580863;
        Mon, 21 Apr 2025 03:33:00 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ecec0esm62296325ad.163.2025.04.21.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 03:33:00 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH] btrfs: fix the resource leak issue in btrfs_iget()
Date: Mon, 21 Apr 2025 03:32:52 -0700
Message-Id: <20250421103252.44509-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

When btrfs_iget() returns an error, it does not use iget_failed() to mark
and release the inode. Now, we add the missing iget_failed() call.

Reported-by: Penglei Jiang <superman.xpt@gmail.com>
Closes: https://lore.kernel.org/all/20250421102425.44431-1-superman.xpt@gmail.com
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/btrfs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc67d1a2d611..61d7f3f94090 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5681,16 +5681,22 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 		return inode;
 
 	path = btrfs_alloc_path();
-	if (!path)
-		return ERR_PTR(-ENOMEM);
+	if (!path) {
+		ret = -ENOMEM;
+		goto bad_inode;
+	}
 
 	ret = btrfs_read_locked_inode(inode, path);
 	btrfs_free_path(path);
 	if (ret)
-		return ERR_PTR(ret);
+		goto bad_inode;
 
 	unlock_new_inode(&inode->vfs_inode);
 	return inode;
+
+bad_inode:
+	iget_failed(&inode->vfs_inode);
+	return ERR_PTR(ret);
 }
 
 static struct btrfs_inode *new_simple_dir(struct inode *dir,
-- 
2.17.1


