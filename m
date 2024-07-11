Return-Path: <linux-btrfs+bounces-6349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71AD92DEDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE2FB21F35
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF5219F9;
	Thu, 11 Jul 2024 03:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luCm12nR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B517597;
	Thu, 11 Jul 2024 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669372; cv=none; b=HcDkIOdunXm1BY4VE2LYf8d16DxXLBg9a0Olv2jrwBokcSL6hRVTi0S2iq5OfmkdTCd2D65329Ki2lHygbCqExIIU5OTVyW2Luc9kVMzV1GNKpTcSiD2UFTZpLX4biDyrWetvV1Xsl8t77GraUTzpImv18KuqzlFrxwjRaME88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669372; c=relaxed/simple;
	bh=lSaGeQnHnNNoOyHZNVSNPYOXeoUh9742+oAvgeRslyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a5x3kyeflraA38hFaS+xLSaVlO0U8f/HP6uToJojY4FowGBDxv5aSrbRSw1Y3uzpzH1uUUdeqV7jN0/wr5OPBOgYACoczA6ovGkwYXxoIF2tpPr4CYjOMQPvurUPbTD5qsUAriOWWGs+uJP1H3+Uh82RGOjxjoJB2b7OuZZEAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luCm12nR; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6519528f44fso4127367b3.1;
        Wed, 10 Jul 2024 20:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720669369; x=1721274169; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hI7IGZW8LkC7mU+jbdeJAOVeuDNzhFNvGgcXqutnwBg=;
        b=luCm12nR0reWpodOUZM/y8IzferhjtIbVXoZ4PsWJ2SridLZ1HhNvEuAAESCahaxCE
         LiT3oMmAIjiZyzNF5g6fjtUkmh1+J1A4gfME6y4tvhgwb/bJpdCvClVuUUHx1Ro06a8T
         cgDLMMH5SCoDDh1rBdcBi6q5ed+81GFumPlAhNj/3NgiPERU82rLzMeDNSHMCOfcu6+3
         5f//jxcmaLWuT/0TzLmuw9Ndc2tFK62aoRoMywFb3z5pvHG/kfhQC7g/FPUlfW1LBFlL
         NOg0De3wZjYDJbhyrtzyA8jecifDlf9VJLHFnipNGhgFDh9WdcpuybBe9sj/zAddSh80
         FctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720669369; x=1721274169;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI7IGZW8LkC7mU+jbdeJAOVeuDNzhFNvGgcXqutnwBg=;
        b=hEPrWgImnnJ790TGYY7tA1YlCnDdbRX9NmH6WK4VVtIDx763gFIB6fhmhcUO2PXVWQ
         29l97yyXaZP+aGdoVrIpRswrA09u1WmnC/GSdLhPOtAR6YCoJHbEisg8gFsBL0VSN1IF
         zuQb419qQ/3PQ2nOAuVl3r0TVKWLC9UNlEf1Z4hKhHtrtmsZVu6s+kzVn5cyedYZ31Az
         r7gIrIyn2LiY/mx/xxl+9+K6bHFDko1lsD4z50xwyfjHHcfwlJFdcfc+M9fI3s3fslbi
         +2YcvHhZMLbjhvuwLqkd659h4CDv48KCEk1bC3i9q7uvVpQHpGBS9aN7GUmuwc3OTHMG
         g+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV2Ftdi8EVqoSfPVSB+bPqFwu2B+4vC9JM2fjGNNe56PkpHzISkx1Yav18ViVerqrG7ALMuRWbpxI6zEff6knMFAPzn3SkJihMvLSf
X-Gm-Message-State: AOJu0YySe1u9j93K8wxYbrnsxkCZyvseyhwPH7dC/18rmzI5iD9j1247
	MW86M6y619ZZJPUSQokiyzkzurLVDbfD3m6t29ZT2WKReZGbXjkD
X-Google-Smtp-Source: AGHT+IEUh8omZx36NQsQXUtt8YolVr4+mlRQIc2219cs3Las/AYw0NAiZlwWSwvpMLSC0hk+vwziMA==
X-Received: by 2002:a81:928c:0:b0:651:a00f:6961 with SMTP id 00721157ae682-658ef05538bmr79181067b3.22.1720669369568;
        Wed, 10 Jul 2024 20:42:49 -0700 (PDT)
Received: from [127.0.1.1] (107-197-105-120.lightspeed.sntcca.sbcglobal.net. [107.197.105.120])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e64ecfa0sm9624677b3.84.2024.07.10.20.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:42:49 -0700 (PDT)
From: Pei Li <peili.dev@gmail.com>
Date: Wed, 10 Jul 2024 20:42:47 -0700
Subject: [PATCH] btrfs: Fix slab-use-after-free Read in add_ra_bio_pages
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-bug11-v1-1-aa02297fbbc9@gmail.com>
X-B4-Tracking: v=1; b=H4sIALZUj2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0MD3aTSdEND3USLxGRDi8S0JHMjEyWg2oKi1LTMCrA50bG1tQDMZei
 uVwAAAA==
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com, 
 Pei Li <peili.dev@gmail.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720669368; l=2430;
 i=peili.dev@gmail.com; s=20240625; h=from:subject:message-id;
 bh=lSaGeQnHnNNoOyHZNVSNPYOXeoUh9742+oAvgeRslyE=;
 b=Xf2utb/BH7ExAT1vPQEXuKA2y7e7hGHcB3HvBcXVZsC/aR4IeRhX2Rotu0LurmKzDfTV+caEU
 kGY4NPDu1LgC1RwsuwcCddt/24zWwCOBXCcEoq9LjiYX8k6wpV5Qs2z
X-Developer-Key: i=peili.dev@gmail.com; a=ed25519;
 pk=I6GWb2uGzELGH5iqJTSK9VwaErhEZ2z2abryRD6a+4Q=

We are accessing the start and len field in em after it is free'd.

This patch stores the values that we are going to access from em before
it was free'd so we won't access free'd memory.

Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=853d80cba98ce1157ae6
Signed-off-by: Pei Li <peili.dev@gmail.com>
---
Syzbot reported the following error:
BUG: KASAN: slab-use-after-free in add_ra_bio_pages.constprop.0.isra.0+0xf03/0xfb0 fs/btrfs/compression.c:529

This is because we are reading the values from em right after freeing it
before through free_extent_map(em).

This patch stores the values that we are going to access from em before
it was free'd so we won't access free'd memory.
---
 fs/btrfs/compression.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6441e47d8a5e..42b528aee63b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -449,6 +449,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		u64 page_end;
 		u64 pg_index = cur >> PAGE_SHIFT;
 		u32 add_size;
+		u64 start = 0, len = 0;
 
 		if (pg_index > end_index)
 			break;
@@ -500,12 +501,17 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		em = lookup_extent_mapping(em_tree, cur, page_end + 1 - cur);
 		read_unlock(&em_tree->lock);
 
+		if (em) {
+			start = em->start;
+			len = em->len;
+		}
+
 		/*
 		 * At this point, we have a locked page in the page cache for
 		 * these bytes in the file.  But, we have to make sure they map
 		 * to this compressed extent on disk.
 		 */
-		if (!em || cur < em->start ||
+		if (!em || cur < start ||
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
 		    (em->block_start >> SECTOR_SHIFT) != orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
@@ -526,7 +532,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			}
 		}
 
-		add_size = min(em->start + em->len, page_end + 1) - cur;
+		add_size = min(start + len, page_end + 1) - cur;
 		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);

---
base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
change-id: 20240710-bug11-a8ac18afb724

Best regards,
-- 
Pei Li <peili.dev@gmail.com>


