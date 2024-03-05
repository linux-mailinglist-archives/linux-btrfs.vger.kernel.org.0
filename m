Return-Path: <linux-btrfs+bounces-3008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB988718A7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9FB1C211AB
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4393B4F1F5;
	Tue,  5 Mar 2024 08:53:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254461EB4B
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628833; cv=none; b=gyFeB2swtNOTVXjpQJ1cqzSAveyD1uEsm8lF/j/TsJbi2mqhnkhDsdJIqMBqPFLvs607mSj/TFNjJF6V0U8OdOgOc/BE2FjWxvGNFaFq8u8MJZpTddGVjIOGAqGGdwp8DqYiRd5Ww2Om3EG9amLWFVf45uDmm4IXGcMEOHBUOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628833; c=relaxed/simple;
	bh=mMl7uVPREpFLjK1BaXrv0Nh5dSx8ajTOh0ssNC15ziM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dB2knvhj76/VZu1OCtNkly7x7vfIYhkusW/rK8U/UXidirFqCh/iHkvJiGvAKO7LCIGgOZP2qJOw/jzoX4WNf3fhOeTfLe6AoEUjjZi3JyaU6fgBNdE03zhvoQbjf7Pdy0/jBRTc0L52EeMk6D+SPSSnZCo187G65uLlvf7Wh0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a449c5411e1so500441666b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 00:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628830; x=1710233630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fb6Ibb44E4I0zj3JIvep9W1i7Qoe8y9wlBMNF34Xurk=;
        b=B6xCdeP85utqPJ4/FCQ8uHTB8biK8HQvKPTQ2rwJMc+E1attLGoVJICFiI3r0yMn7R
         EnwVMbdQwQEQPRzHDFC8b3gmqWcr7WWTlrcmpjXSrOR+3nOCNlpCHUKWxbLrhHyK6Gwt
         OITiNRjalTFP6kw9zLXv4aqr7Lgor3PHfRlssDc1n0nSER7WNW64wCZeGQRXq6wBNBSK
         +k/3MDuVJcxkhWUuHGPqjGNgx2y+7BPEatynLvfJPPlNZXTmYm8tvGJGC8URjg/S+8q/
         7iHQ1xH9um0/N2f4O5DSzPKK7zEW97RjelYBDMLlh1mQZA7OmG73qE4dhtEQ6ToDVa1L
         urJw==
X-Gm-Message-State: AOJu0YwA6vboBTWsmzoIAM1Af/FffzMIZBDDljgnQpxGvOQFR83T+ZrZ
	irnWDfJNSBz1sh6VShyecVLbOYpHhOUAxPlfpAuIYgzUEvmeK7kt9+cs+H6q
X-Google-Smtp-Source: AGHT+IH3bog+xihtSBLQP1XEUQO0b4a4iFuHxawz0fHu9YYKOGkrOFjbUcwIIUvSQtszH0Lew8KPUg==
X-Received: by 2002:a17:906:f0d1:b0:a45:a448:b08f with SMTP id dk17-20020a170906f0d100b00a45a448b08fmr855633ejb.54.1709628830137;
        Tue, 05 Mar 2024 00:53:50 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090640cf00b00a4354b9893csm5789710ejk.74.2024.03.05.00.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:53:49 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: fix memory leak in btrfs_read_folio
Date: Tue,  5 Mar 2024 09:53:35 +0100
Message-Id: <fb513314c27317128426ab6e84bbb644603e65f5.1709628782.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

A recent fstests run with enabled kmemleak revealed the following splat:

  unreferenced object 0xffff88810276bf80 (size 128):
    comm "fssum", pid 2428, jiffies 4294909974
    hex dump (first 32 bytes):
      80 bf 76 02 81 88 ff ff 00 00 00 00 00 00 00 00  ..v.............
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    backtrace (crc 1d0b936a):
      [<000000000fe42cf8>] kmem_cache_alloc+0x196/0x310
      [<00000000adb72ffd>] alloc_extent_map+0x15/0x40
      [<000000008d9259d5>] btrfs_get_extent+0xa3/0x8e0
      [<0000000015a05e9a>] btrfs_do_readpage+0x1a5/0x730
      [<0000000060fddacb>] btrfs_read_folio+0x77/0x90
      [<00000000509dda36>] filemap_read_folio+0x24/0x1e0
      [<00000000dee3c1b4>] do_read_cache_folio+0x79/0x2c0
      [<00000000bf294762>] read_cache_page+0x14/0x40
      [<0000000048653172>] page_get_link+0x25/0xe0
      [<0000000094b5d096>] vfs_readlink+0x86/0xf0
      [<00000000698ab966>] do_readlinkat+0x97/0xf0
      [<00000000a55a2b4c>] __x64_sys_readlink+0x19/0x20
      [<000000006e1b608e>] do_syscall_64+0x77/0x150
      [<000000008fcc6e49>] entry_SYSCALL_64_afer_hwframe+0x6e/0x76

This leaked object is the 'em_cached' extent map, which will not be freed
when btrfs_read_folio() finishes if it is set.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 65e4c8fc89b1..832be9030aa1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1162,6 +1162,8 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	ret = btrfs_do_readpage(page, &em_cached, &bio_ctrl, NULL);
+	if (em_cached)
+		free_extent_map(em_cached);
 	/*
 	 * If btrfs_do_readpage() failed we will want to submit the assembled
 	 * bio to do the cleanup.
-- 
2.35.3


