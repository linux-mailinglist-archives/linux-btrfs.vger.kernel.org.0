Return-Path: <linux-btrfs+bounces-8440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A356498E103
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 18:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6649528667E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E11D0F62;
	Wed,  2 Oct 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyDKsuU3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7911D0BAC;
	Wed,  2 Oct 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887023; cv=none; b=erIYYY7hxrPTvriJ4hTV1ZJ3a4xPrA1CSSl6etl6V9mXJvlnc7wF9IM9L1/pg/+yvWRDRHjioP0KCJHzTxpkGeLSmuWpzaoLVG5S9N67G0Vrq4AqC+sJtP7MBHrGcJboZoZu8Py0jyjF12MlU5/xHvsCvsD0pR26+oHkmo8pxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887023; c=relaxed/simple;
	bh=gZ+q/3HylspRYHbKmPaYACg8f9jvXAWZjcMBF0rvSgY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LSguo0fv+v7cOmlw1n3aW5P/pFXIbMidAujIfFbLMr5hHLORhWx4muOpCNmdQyR56jOIAeOX0pxJClI+dWYtIrwM58d8blD9ZyOLMODsTDheWQFARI37TPVDx3MocZdY4CVoxpKMi0DVyDbG8LDyJ47f4buHDHX5hTTmdBrKOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyDKsuU3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so199855966b.1;
        Wed, 02 Oct 2024 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727887020; x=1728491820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M//UTXHbbwHEyllHRvBBcjCOBe3Q9AMtd7PVYn/rLSA=;
        b=UyDKsuU3Y5rN2pNhJcXEqQCj+RJcbHyCpc4SoOAoP425FXCaEPqAlm5gF4U2EH2BLQ
         7RBgpDmI0a2ycw82rlizZ9YDCh/1Xk11BhjtJAg6EBjT7cXHpdgiKHcGa9ReqClGc1Cd
         6Bb/3XxndoHcTSc5yNE60D6l2btbZgdvnkU2L3abrpeXuq075dmn1LBvwNo5WhH9CSNV
         ZJN9mxakal5wm67e2FxCrDTyUppsAAUIAaaDAJULsjQW6Ysx0KDUowKyYe9l6Q/QxT2n
         53aCdQrBO36qcipyit4wPZqHWcNZO7tKrMtTg6s/aPahkJKoEOrE46QpeKL/wIfwFcoT
         9HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727887020; x=1728491820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M//UTXHbbwHEyllHRvBBcjCOBe3Q9AMtd7PVYn/rLSA=;
        b=lxw15qk8Pi8c+lUY4/eec5/VOSCUOeMtQrn+Cl2ODT4XScuvPLL2rSxbK7gtsz7hX3
         9dtKt+HZjCJJif99bUAjgxuWjYQkz1IJPHbFDbWiXoU8T9CxQzRBP+XDmmsoiQg8JCLp
         6lECGiVLHm+bG3u4qtmBWZkTak9OZda3PW7APxfOfBFmrZU1PSkes7Vg73pIo6GFNR1i
         bxNVnEmLiu8Gc1bkQZuHPpd3V/TQlxfL1WugBRIjSLPOL8F6dPijOmsvtk8MiFHRgqRb
         juuyk6VPz/rFQt7zvIwX96LRQEVCTbcpaYVHpEgnsx9qODVg3mvMiU7+1CPBFqi7nx/B
         YqEA==
X-Forwarded-Encrypted: i=1; AJvYcCUHHW5gW6jTKAl4DC0vAO4lMxvWOMZNUrt2p68TlUZ4hAanErryospvZfPJvWM72Wyv78x878y1NySUkA==@vger.kernel.org, AJvYcCXRKYH/RrQ9QFXI5a8icafgcUoKySGcPTFOHuiQXSbHxvYnSu8xZqj/DFvOxUSEBBxB/38+NuGNWVsXDXwa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BEMTla8ynKCpe3mMhHrWuZId5ytFiYE6CKnJd1oNUFx6/O6o
	e/wWNNtIlWBnwkCfEBHe7+gL9rU+l8IHBSr6EU3+WGCoXrU3OgPS
X-Google-Smtp-Source: AGHT+IHBcFRRxzd4mOSBn67X69FSjlLZbwG/9D/EpYe89SBBXsXefSNHA21Yb/Lu9bSq50i3Fp0Sfg==
X-Received: by 2002:a17:907:2d8c:b0:a93:bc27:de24 with SMTP id a640c23a62f3a-a990a03483cmr28137866b.1.1727887020060;
        Wed, 02 Oct 2024 09:37:00 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c297bcf9sm886934466b.186.2024.10.02.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:36:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: remove redundant assignment to pointer node
Date: Wed,  2 Oct 2024 17:36:58 +0100
Message-Id: <20241002163658.957316-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The pointer node is being assigned a value that is never read, the
jump back to label 'again' re-assigns node to the return value from
the call to  btrfs_get_delayed_node. The assignment is redundant
and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/delayed-inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..4d37ed88c856 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -154,7 +154,6 @@ static struct btrfs_delayed_node *btrfs_get_or_create_delayed_node(
 		/* Somebody inserted it, go back and read it. */
 		xa_unlock(&root->delayed_nodes);
 		kmem_cache_free(delayed_node_cache, node);
-		node = NULL;
 		goto again;
 	}
 	ptr = __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
-- 
2.39.5


