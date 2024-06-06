Return-Path: <linux-btrfs+bounces-5495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4283F8FE10F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E810128781B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53EF13D8B8;
	Thu,  6 Jun 2024 08:35:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76F13C823;
	Thu,  6 Jun 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662917; cv=none; b=PF/hrxBfbbGR+1qLXBRojBivmWMHZ1nqiWaF0wUdhLKVr0EgSp1M9oXuYJhItSyhOX+PVUvL7tuqSU73Nacm71bZq+bYH9hNeJAX/rIpi2lOHrULH49wcTB3z+OCrGhsrk15MxLqvyi9o4qkvLe7ms5BnsZJqhtdNRk9j73gqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662917; c=relaxed/simple;
	bh=zzE5bAZOBFfYggkgkFIySkkBxdOQfmS/iBbhcnPJ+XA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VOjzAUAAj0iStOyfWBqO/exRp51D4HML9rpAm2crpMN3VJNkNAjGhMiWcLvPjBNVw+r5NtDq6q3GI5yoKQloWjVz6/g8AGw1zRhLtTd2jlHwYNoh7BFrGffM0GzLeO2cyqET1/rm24VcOJyBj/XBcy4f5DKNeJj/pl46wjX47uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso1101360a12.1;
        Thu, 06 Jun 2024 01:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662914; x=1718267714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkFCExxHuTtm3UumYxMeb2p+BeqDb6wrLCHjywTupuY=;
        b=JY4F26VQtK0ExPxnAPQvK4jv6xR/FlTPjUBqWrukL5/HHngsKxu9MpZj+7/A4okKN8
         zqb4ZN/d0m1ic/bv0YSUK8kn9QebqA3Ad5ClhP2kRBDEAyyIgRpzxCc7iGU3WUsSHGGx
         xGORQTzjEvRZEujYVKg9v1+QsvBLlmLfd8EO+x+qLPGkE6mWM2QPMR0FsdkVmcbmaPlr
         LNUZvqjmUQR1/LRf6GadwAJbZreNDD/fJjDENsplQhTbmm2W1C5z7FHlkIF1g3Q3PUmX
         62hNCJMESQElymKM3dlCTLw7XI+atRrctgfAHEhaZRH5vDmU7Og+FxIoTr4dusrG0y4h
         /Oyw==
X-Forwarded-Encrypted: i=1; AJvYcCW4mPFZFi6sqMPUJmLtB5UWCkjFFNpedfS3cjIol4sGrjECfBcXUfGZIxcz8WXpc2Vc8Xe+ddgUYN4elPbgceKuA6xtho04E3PmpaKE
X-Gm-Message-State: AOJu0YwdL4dcS5C6e26pSU3cr+G2ZBEbJcg4KT6Mbko5EpVO4k6jGCv3
	tp7R3JUOMvRGKQg3Pyg3YC0CpRLPfnUPfgdxYFOQhB3Qir/T/vcf
X-Google-Smtp-Source: AGHT+IGlLwqUw/PBa7WuChUSpAbvZcsRnDYe4k4yEzuD7qI7xa5Br5PqHn41BBY+P5g4MGHB87xE1g==
X-Received: by 2002:a50:d7db:0:b0:578:69be:6e7a with SMTP id 4fb4d7f45d1cf-57aa53e0569mr1762409a12.1.1717662914242;
        Thu, 06 Jun 2024 01:35:14 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:13 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 06 Jun 2024 10:35:01 +0200
Subject: [PATCH v2 3/6] btrfs: pass a reloc_control to relocate_one_folio
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-reloc-cleanups-v2-3-5172a6926f62@kernel.org>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
In-Reply-To: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750; i=jth@kernel.org;
 h=from:subject:message-id; bh=LXiNUZKoUbEDGm+5ZVvGCnkC49++FH+noIxoB0lBoXk=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQllux99unl4ZDeWZtNr3Gl3H5lVGrzt6uOffb3L9Lrr
 fzYPCbP6yhlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJKDQwMnSknb+pPvFtluOL
 GUFbVpU98SpYpMs+Obw2fkd74gvbnjZGhvf6nnai51NNLrHN4Yn2T44S+LCsp9rjy+zN51v4DCM
 WMAEA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Pass a struct reloc_control to relocate_one_folio, instead of passing
it's members data_inode and cluster as separate arguments to the function.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index e23220bb2d53..a43118a70916 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2947,10 +2947,12 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
 	return cluster->boundary[cluster_nr + 1] - 1;
 }
 
-static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
-			      const struct file_extent_cluster *cluster,
+static int relocate_one_folio(struct reloc_control *rc,
+			      struct file_ra_state *ra,
 			      int *cluster_nr, unsigned long index)
 {
+	const struct file_extent_cluster *cluster = &rc->cluster;
+	struct inode *inode = rc->data_inode;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
@@ -3116,7 +3118,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	for (index = (cluster->start - offset) >> PAGE_SHIFT;
 	     index <= last_index && !ret; index++)
-		ret = relocate_one_folio(inode, ra, cluster, &cluster_nr, index);
+		ret = relocate_one_folio(rc, ra, &cluster_nr, index);
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
 out:

-- 
2.43.0


