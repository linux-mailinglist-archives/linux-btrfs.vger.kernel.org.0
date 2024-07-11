Return-Path: <linux-btrfs+bounces-6355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3791F92DF1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 06:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAF91F22A3F
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 04:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA23C3BBF6;
	Thu, 11 Jul 2024 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y44MJ1+U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E95038398;
	Thu, 11 Jul 2024 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720672166; cv=none; b=pa6J2wzqNNM6MHOLJNoXrX9YtIQcH3eJBXVd4dHJS/vD3PculPwZ/RhrmfSUmRTjT0BZs9D+10xv3VhzUaPs4y3p64vv5RVmJJxHjHQphFQAL7k3y2fQuC06QaDZUK3/SNa/Y4nF2ou3Ru2pX6IrwusBts6UXRPnSFyTmsHsG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720672166; c=relaxed/simple;
	bh=t1Uux8oEDRjkQ1yaLaSr6zlDLKDvyg7LrLpCDTcxao4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fc8WsO4IqkMttWkXLc8QV7Yqak352295J/6n1ZV/1ERyFZg8N22VMDvscrD06NhpuqDDLz7CKwJHHYVTOgwH/Fqc9CgReHgRB+ZZbcll/3HI4+jb2J7/DOr9AYuig6X39wnr3WSTSlBr90tCeYE8uwLj3MhNFYJuXutTbdNNt5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y44MJ1+U; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24c0dbd2866so254251fac.0;
        Wed, 10 Jul 2024 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720672164; x=1721276964; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pm5wKSqcAJyUHz8lRZSzAcGOp5jdkpoDCLTobJAaN2E=;
        b=Y44MJ1+UpTytxG3A68xR5nfkD9Vf0VYn/akTiS8nn+fH/lmbx5ugtVu4JjArxpudtz
         oFG9IpHAgMOzPdg2VS/S7knITzEnlo0SGyne3XR2C6ENq31kq7XSfAjyyug7JFxlWrVf
         URnGytdjd3JFYEpnlbF8echoizZsMAVxyXLX5HUQUqs8Juorl7S+xLzye4gn+JFCQzxh
         A/tWLxgpa9ZRB0GBa/OXdsJUB4YQqmZvBa8UFGCfqGDFVjQmt9X9YdPn9eSnIJ9W/zuq
         zcjC5r+6ng2n+JChAX43QTAlHZNm00j/dNKDMdxJff2Pa3pclBCI/lDFVOux+PzBP97E
         Yy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720672164; x=1721276964;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm5wKSqcAJyUHz8lRZSzAcGOp5jdkpoDCLTobJAaN2E=;
        b=AqtwVjBhRp5oiTUqV0WYH9QLIjDwGSxQHL2V7eHOe6h8f0fPSkZNYwv7Ubf4lI/2wR
         K3FyXT7zkvy1wIbiyLJIN2Ow5EqEULsi+iAiwu93lQ5xxiOEA7frH2NESOWcy/zSpg/d
         YZ/h8NsAnPXp3qQIA14tOrcI9uDUp1H1PWvT6//X6yqjfrOmghhDmougPclKsR9jwlky
         mcmgAbTtk6gsEQHMuRngcrDpo6kXgPV//fFjg4hN1/984XEgJ2lJpO+lq6HlB9TEYsRp
         I5l9FXhDJyy0Y8UtRM8oG5qe6OD4IUhhbf1NfF61JKjBujSQuVmYg2xMkRw1GMqbChl8
         FjEA==
X-Forwarded-Encrypted: i=1; AJvYcCW1YjvDuWa0Jkhi+2ruVWlZWLtJfhOYEbl3MBX1J/JWj7w3yYCc8tU8/E76zeWyMfO1eb7sLr+I2DfpxyjUS7s4ktCwRh8NZyIgDdqnxEDxVlnsV34CJJl5kfXD/5aekuAzYwyS
X-Gm-Message-State: AOJu0YxM239k3xJ+PUZJBsi2DzW6EdkgtfnIdIT5sMil9PlGs0YP2e1E
	UR9QgqFS67vIBMkxJVkFW+1FmG2AGxZdhhEHTCLx8walJcqONRfz
X-Google-Smtp-Source: AGHT+IGgEU91R8zFIOKM0r/MONCxqdOFQvD5dhzSPqMckp8oZPJ65oonJxNJYPaD7L9TGhNZnTPHCg==
X-Received: by 2002:a05:6871:54c:b0:25e:1ca6:6d09 with SMTP id 586e51a60fabf-25eae76455amr6319946fac.8.1720672163638;
        Wed, 10 Jul 2024 21:29:23 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25eaa2a1e76sm1520640fac.50.2024.07.10.21.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:29:23 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Wed, 10 Jul 2024 21:29:21 -0700
Subject: [PATCH v2] btrfs: Fix slab-use-after-free Read in add_ra_bio_pages
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-bug11-v2-1-e7bc61f32e5d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKBfj2YC/13MQQ7CIBCF4as0sxbDkCa0rryH6WJAoJPYYqAST
 cPdxS5d/i8v3w7ZJXYZLt0OyRXOHNcW6tSBnWkNTvC9NSipeqlRCvMKiIIGsjiQN1r10L7P5Dy
 /D+c2tZ45bzF9Drbgb/0XCorGkFRq1N4YO17DQvw427jAVGv9AhUwBrCaAAAA
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, skhan@linuxfoundation.org, 
 syzkaller-bugs@googlegroups.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com, 
 Pei Li <peili.dev@gmail.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720672162; l=1993;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=t1Uux8oEDRjkQ1yaLaSr6zlDLKDvyg7LrLpCDTcxao4=;
 b=Ydee9F0C2BZyLYbU961DAb4oTQybaAXaVrKguzna5nItNECSYvuCipHlPkeSYRpdTvhzf7AtV
 Zh2UhB0tjFHCDTu8Mo8oRwAfpeRo4rutm+njiteOHhJIKNfUfxQ1JWX
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

We are accessing the start and len field in em after it is free'd.

This patch moves the line accessing the free'd values in em before
they were free'd so we won't access free'd memory.

Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=853d80cba98ce1157ae6
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
Syzbot reported the following error:
BUG: KASAN: slab-use-after-free in add_ra_bio_pages.constprop.0.isra.0+0xf03/0xfb0 fs/btrfs/compression.c:529

This is because we are reading the values from em right after freeing it
before through free_extent_map(em).

This patch moves the line accessing the free'd values in em before
they were free'd so we won't access free'd memory.

Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")
---
Changes in v2:
- Adapt Qu's suggestion to move the read-after-free line before freeing
- Cc stable kernel
- Link to v1: https://lore.kernel.org/r/20240710-bug11-v1-1-aa02297fbbc9@gmail.com
---
 fs/btrfs/compression.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6441e47d8a5e..f271df10ef1c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -514,6 +514,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			put_page(page);
 			break;
 		}
+		add_size = min(em->start + em->len, page_end + 1) - cur;
+
 		free_extent_map(em);
 
 		if (page->index == end_index) {
@@ -526,7 +528,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			}
 		}
 
-		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);

---
base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
change-id: 20240710-bug11-a8ac18afb724

Best regards,
-- 
Pei Li <peili.dev@gmail.com>


