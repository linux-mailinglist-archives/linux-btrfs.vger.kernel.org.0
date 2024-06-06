Return-Path: <linux-btrfs+bounces-5496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2428FE111
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 10:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41D828418D
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 08:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C9913E051;
	Thu,  6 Jun 2024 08:35:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5613D27F;
	Thu,  6 Jun 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662918; cv=none; b=Km3C8r3koIX9vxeKmWXEFPtC2s9XEO5ebsK82/OXGQ8qO6nHMjZ/NZui8Ddl//Nd656tt2qtZSKIFGfMzqo3aUz8HQx4a92wRDVITd5uLEe9xZLhGf0yXxEca4mD9UNqGxkpTAXvbe9odoaDRz6cT7bmFZkxmJaEbxIyq5uQ3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662918; c=relaxed/simple;
	bh=yH8G6YWI06bHfK8IxhTFZTp6ZbVAWJROjgj/gnxMVT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkTymhd8MMWepUmanEkIxNKjdw9WsLyJY0tnFzp6ewyekuGzK4PfMBj8KHxz2nnnHBx09eTKctyYHRHhmwtRcY9MqS7JHBMZAogLUEGGraIlZzqv7jXKaEjj//z4VE4t69dhqfB93y9NR/dEkByEVZxzZQrc0GEmD/gt/aD5QJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so666561a12.2;
        Thu, 06 Jun 2024 01:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662915; x=1718267715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3RP1QBkoyJNi5M16iMTIkUvadwfoBKvDY6JbocbOfI=;
        b=Q46J5sY41afRRqEkUkqdRNe+LokYcEfx5Vb49+fZ4GYXUKdrdeoughF/xki7GRlZkI
         oBer86ojmNG+kR4jFW6YQ3VMQR+KujN2g/XpYWVa0sG1Sz5bM4R7CG2U4BVnaN3vCdkc
         kTlDDht02aTDcU+nk52YYmMUEnI42AzPWnoQEv5Kt+4T9saGJ4yNuLYAjhr6YyO0KNiU
         wME4yVCaZgtYpPctIWy8bEGiEKAThFALds8HDpfZm4hls5q8FX8UmpdG2kB0KZdxQ3jL
         791dAxPyVUFjQwSXMLZimq79wQzNlAKhPxBWFdbgwKcpmjH1H13Kaxjk32a7bM9j6pWi
         y/8A==
X-Forwarded-Encrypted: i=1; AJvYcCUZLz+LTQNMJqEVZ3h8oC0HlPOt7ZycW5L5fDO5oDTorinKo6LOZySMrrIXmwxWO8uaNL7tvsouItYZ9rSt+3CUp0FcZlVIXKIrF81N
X-Gm-Message-State: AOJu0YwkYx4xP/Y1Uh45UCW1ni5J5pAoseroaq4cBCGbaCLCFG3rlo4a
	kgOlfUUwGC22G7r2ZuAFSfI2qgh/+G4MvjUmdnJ++bmF2dGw5bVm
X-Google-Smtp-Source: AGHT+IGlgfBRZzajCn5Y5Wogg/58oRd7gRNxZVxxRLpYIomfORP+sEwVAUOOm5rUJH55ih3fvr55zg==
X-Received: by 2002:a50:aad4:0:b0:57a:2cf9:f614 with SMTP id 4fb4d7f45d1cf-57a8b7c62c9mr3593638a12.32.1717662915078;
        Thu, 06 Jun 2024 01:35:15 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9e99asm701338a12.17.2024.06.06.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:35:14 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 06 Jun 2024 10:35:02 +0200
Subject: [PATCH v2 4/6] btrfs: don't pass fs_info to describe_relocation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-reloc-cleanups-v2-4-5172a6926f62@kernel.org>
References: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
In-Reply-To: <20240606-reloc-cleanups-v2-0-5172a6926f62@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=jth@kernel.org;
 h=from:subject:message-id; bh=culQ18XDuWJUFEIEtoeM+ju8fL06zumM9YtkfGAAe1I=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQllux9XtU8wXups3fqPTXXRpHYW23i9mdy97pVvHxeG
 tu/UiWpo5SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACbCx87w36NPfsbCk3q+84IM
 3248usY9fee3Hx+2L5wmnL2LjS1A/zgjw56/XzisH061PNt86t6pWIYVZ9f3TJt3ZsuOhrV3V5U
 lvOYHAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In describe_relocation() the fs_info is only needed for printing
information via btrfs_info() and can easily be accessed via the passed
in 'struct btrfs_block_group'.

So we can savely remove the fs_info parameter.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
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


