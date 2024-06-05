Return-Path: <linux-btrfs+bounces-5472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB568FCFA6
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE811C22BB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F14F19A2B4;
	Wed,  5 Jun 2024 13:18:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738381993AE;
	Wed,  5 Jun 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593482; cv=none; b=D1Eynh5e8BazLnsqcO1E1mNFnIrmauN24k7hLiTaaUH6Cx1vEAmLhKu2oL1sZ1HRt/CPLBJzfEmqKNjgXRrT5VD08CilkCtK2BZnxaXb8rPlxpDgiARa1WXiYooXEVdTvOsaphZpMFDSQVxShnQTYawrusHglzx42pqQ1AOJwgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593482; c=relaxed/simple;
	bh=zKvIhxSqqT9FqJeBjcPR8uWxWYQnQKPGnUrKxRgCKQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7TzNSH37vEXUo4CDsMnFKKQrW+LI6WurxEdjkGh223jUqkhqr1bm3Q9pLl/TUZEalhT2yRRxuc41/4pdmxpwjpRRundNZm5ZV7bDDzce4vEOgvyeztKuJUsPe0lzu0YWjpxdVrc7UzGn06W61t4aosJIA/R0HpaR8WjaDaNk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3086204a12.0;
        Wed, 05 Jun 2024 06:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717593479; x=1718198279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0UO6kXD+1YYvRaIqQUVf1oJgFoVApkH9Bfb2EMD7Mg=;
        b=AoGy4C3U8T1aheX6q7BW0ypDRHcM/crKpyr2k70c4H4ECodhBqAzeNw16dFJs5XgWw
         zzwE+cLHqxQKlALtM6RmBe33avL76dI3Qfaf7NNx5+MaxdqsT4BnqoqfZ8uV2tDdJMau
         DK8AG/tgMUvuCH3eteXZoZ/D/a1BZx8AbtEfILjaj6VwTUZxTgVrBbGek+OAqKEqLAXy
         x3SjGIc2OTDV7F3otV2syW89wmju7e7BlnzE9kinS9d+AwZBbs/xPWZppXKv1PPTPx2X
         11yNONKevExXsDx27vT/FV8qjM35n4PLOGnGKiVFQFoCDzXlbFSEYgTbX5uDxB862yEw
         H08Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXqwmR8MHf2vvEjycyRFbDyFSuuxaUp2CIzMYv6HD/ZL05BBdeuyPs3t0UzjLyEc94Daf9B1M71ZTpSlVK3BUDozm/U/WR2JbiuuZe
X-Gm-Message-State: AOJu0Yx0zapQYX436hc2ClQpRrLSbRxd8K/CdUhvTp2zWlfZtVuMMDNV
	ogm1GEZ11ttWH6tFbdy1EAMBwRpAOKto0FuWVfHPeVrt5bkmaNsL
X-Google-Smtp-Source: AGHT+IHg3k02UXOhdyZHB6aIK2ubKiZI0k4sBYhtcpPHPogQwpj9d5yc9KJK7KzgGw+S0sIJfca1bA==
X-Received: by 2002:a50:875c:0:b0:57a:4af6:319e with SMTP id 4fb4d7f45d1cf-57a8b69d02amr1739160a12.1.1717593478760;
        Wed, 05 Jun 2024 06:17:58 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b99a3fsm9266913a12.9.2024.06.05.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 06:17:58 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 05 Jun 2024 15:17:52 +0200
Subject: [PATCH 4/4] btrfs: don't pass fs_info to describe_relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-reloc-cleanups-v1-4-9e4a4c47e067@kernel.org>
References: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
In-Reply-To: <20240605-reloc-cleanups-v1-0-9e4a4c47e067@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=jth@kernel.org;
 h=from:subject:message-id; bh=2s+AQcPtYn/L37Kl21F6nhewozdhJbQniXadYahR2ws=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQlpDbM97wqVr6wgoft2a4XLjvMxJWMt4bJ8D69dFCN8
 eYkn9XpHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCRWUqMDFP6l8iZfGZqnmV4
 7VCFhkiwmTvHoiA+j8fWe+Ye5Gtdmszw35F5VhMfQ0NycRBvi1bmm3nW13bvaGWNVY5dsojncNt
 tVgA=
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In describe_relocation() the fs_info is only needed for printing
information via btrfs_info() and can easily be accessed via the passed
in 'struct btrfs_block_group'.

So we can savely remove the fs_info parameter.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a43118a70916..df3f7c11cfce 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4005,15 +4005,13 @@ static void free_reloc_control(struct reloc_control *rc)
 /*
  * Print the block group being relocated
  */
-static void describe_relocation(struct btrfs_fs_info *fs_info,
-				struct btrfs_block_group *block_group)
+static void describe_relocation(struct btrfs_block_group *block_group)
 {
 	char buf[128] = {'\0'};
 
 	btrfs_describe_block_groups(block_group->flags, buf, sizeof(buf));
 
-	btrfs_info(fs_info,
-		   "relocating block group %llu flags %s",
+	btrfs_info(block_group->fs_info, "relocating block group %llu flags %s",
 		   block_group->start, buf);
 }
 
@@ -4121,7 +4119,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		goto out;
 	}
 
-	describe_relocation(fs_info, rc->block_group);
+	describe_relocation(rc->block_group);
 
 	btrfs_wait_block_group_reservations(rc->block_group);
 	btrfs_wait_nocow_writers(rc->block_group);

-- 
2.43.0


