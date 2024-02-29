Return-Path: <linux-btrfs+bounces-2916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E612D86C84C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E391F23D90
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA267C6C6;
	Thu, 29 Feb 2024 11:44:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B159B6A
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207048; cv=none; b=nvoS1sgW2ljAgupgPOHvDBtHym7A/xkNSgqbnxlWnwRq4oJriuLul3HXlwyqimD9cCVTu5f+6oiA9zAC3yt6Hl0dJsHUseveYUtD8NEHOp0RGAV/BPLT9etyiAGBKcJnWatnImPW7ESBKkvWFAWDkUs//oBMerVFb+LNObrjq6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207048; c=relaxed/simple;
	bh=nULYOB42vLXe1AcD65ptNWQm7A94wOs7FpstKAIgtHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u9Xl4uTMOlLd/KzZ1jqHxJSeRg/ZPylqAuAv80V8we8SGZ8Dbydfh+wgVnNTmfnrzJL2530MQfM/k/IUgEj0849dHFEhQp6BqAzEeQXtoy2RRC+aUFPnWoc3lct0/0y/EghzKU0ZAF25q6EL8L8wJ/Ozbpf//Ua03J6exjibmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565ef8af2f5so1261704a12.3
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 03:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709207045; x=1709811845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3XKwOyjvmljLBtbasbW8LOOoe3TSZI9XpGa+J2wGZU=;
        b=aqQJISdu2fruEcRb1UgMr25J+CcmSUyCi/Ub2ZzTSRgUGBvSNOYkIcMWbVVyBrOsVx
         akpHJDKmdPsoOz6yz2h80kEAE1Ey/DXxdQYYcKd3rYOOrztuijxAPBTwQxIa3ThkwSM/
         8eWtAQODNY2izRhlS0ITwC1X4ZdenAM/xljzD5e+A47RLZoF76YZwTY7HHzrKplxfEmU
         v6cDX2MKnVhWL4YYxKaJrtDCmnvTBqeNgJ/OV8ed/1Kx5VTc6KKUP1JYV52qxK/W8RTx
         brQmJ0Y1VdHbxCjUqLJAy2XOLwqgVQ/T9io+V442s5ykAOq6j+IAynji6jmT+PkC69RG
         ir3g==
X-Gm-Message-State: AOJu0YyF/cOsvrGymGQSzyqbiezn5F6Q2zg7l5wvg5hsGzsWn40VA+6s
	AENIgBlYBhVTygbKwf6D7azOLLJIv7MgnRREdsrrzLN/HG2lG0hom8S81lRE
X-Google-Smtp-Source: AGHT+IFElVRHQi0avJgTcoO7+tPzY/ZtWiGTfQyPPfz+jxjrsHRZUqswUS7gUbL31LybClAOcJV40A==
X-Received: by 2002:a05:6402:95a:b0:566:b2e1:58f with SMTP id h26-20020a056402095a00b00566b2e1058fmr221297edz.41.1709207044568;
        Thu, 29 Feb 2024 03:44:04 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id fg11-20020a056402548b00b00565efe074f4sm536790edb.85.2024.02.29.03.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:44:04 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	WA AM <waautomata@gmail.com>
Subject: [PATCH] btrfs: zoned: use zone aware sb location for scrub
Date: Thu, 29 Feb 2024 12:43:56 +0100
Message-Id: <933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

At the moment scrub_supers() doesn't grab the super block's location via
the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().

This leads to checksum errors on 'scrub' as we're not accessing the
correct location of the super block.

So use btrfs_sb_log_location() for getting the super blocks location on
scrub.

Reported-by: WA AM <waautomata@gmail.com>
Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c4bd0e60db59..3c8fd9c9fa1d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2812,7 +2812,10 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		gen = btrfs_get_last_trans_committed(fs_info);
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
+		if (ret)
+			goto out_free_page;
+
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
@@ -2828,6 +2831,13 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	}
 	__free_page(page);
 	return 0;
+
+out_free_page:
+	spin_lock(&sctx->stat_lock);
+	sctx->stat.malloc_errors++;
+	spin_unlock(&sctx->stat_lock);
+	__free_page(page);
+	return ret;
 }
 
 static void scrub_workers_put(struct btrfs_fs_info *fs_info)
-- 
2.35.3


