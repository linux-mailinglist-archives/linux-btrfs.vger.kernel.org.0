Return-Path: <linux-btrfs+bounces-2997-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CB687011A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 13:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B328436A
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Mar 2024 12:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA63C470;
	Mon,  4 Mar 2024 12:15:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE843BB2F
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Mar 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554539; cv=none; b=Sza8S3Fn1JateAO/76EcHM/jxZDfykd6s0/L1clsrEBPoRjkS0Tglz2v2PfzVGNCkRU4r7Ldq+0SuN8/sfpA0wauuGOpwa91nZBpuiGOkwja8hIpFT7JSd5L3u8sCDnU8y58DJTd6UD7R/RCMFm+Oz310veXfded4rsbY11lEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554539; c=relaxed/simple;
	bh=qzgQp8gxSqeM4hkB8D1E8+LXGFqpHIaMr6MgaCxJCTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r75kxWtso/mlwguY90ahwv1uppBUvZZnNndUy+ByAq+aIU23TyUgnme8F3hDmVzdwUP5Sbl9RFN2O5ybnLuqU4YjwKVp1bTg5JZ6xqQstim/vGFRYP6sD/78W/MoHn48299n9jDpBeGZWZNClm1N93uHXNH4n6kKZcqxudLz4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412e6bdd454so3087875e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Mar 2024 04:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709554535; x=1710159335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYDTWcfX8rXZV9iRzGMDixgScZBE5JrpDYbG/cjPdp0=;
        b=rekvdxB1ObLgeUsE7euHd/C72g+POAPBcDYt9dPM4H7g84C+ScOXg+kjqnqqJaM17q
         IVhPgcfxDPSaYTTbDbQ7q2wDxT4RuXYYAOiAIjqw+9AVV4YLm9GDYEtVqiFODe3nPuYj
         LpJaAZ1JO3tYp6IZSKPKOQQXLyFhRZGcO7MiVlVuB2e3e7LGelIMzfZCMqGyAQyjfUIW
         8N4J89NVlyZUgwUC6rRA1t+T7ADqkaioOGIAiiBEBY7M4CILy3mp/kzgQxKwJj59pT0i
         +T1PLv9P+4SClHY45CZ+pIhofQqYy20+/OyieT1lJJx6XzY59EFcTMBQXSsJ7Tn8jYdI
         Dr8g==
X-Gm-Message-State: AOJu0YwLtqZOJpBsD6YZKPtnU0mr0Qk+z3uFlrVMASaXJ7aZc4PxIcps
	1ubk3PkL1X3k4CDnoTnlxjwZop10n+nuv+vyDjB1NyZAf+JbOZafTl/Oyg0B
X-Google-Smtp-Source: AGHT+IGLMEqpcitZ57F10xDJuDjj8GmIRlnNXCe1SGGfSaxQMvb3BWI4rNi/iHqUd2tIm5F5gRPJ4A==
X-Received: by 2002:a05:600c:4e0a:b0:412:e3a3:6e48 with SMTP id b10-20020a05600c4e0a00b00412e3a36e48mr1469335wmq.24.1709554535436;
        Mon, 04 Mar 2024 04:15:35 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00412ad64cc69sm14370433wmq.29.2024.03.04.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 04:15:34 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <jth@kernel.org>,
	WA AM <waautomata@gmail.com>
Subject: [PATCH v2] btrfs: zoned: use zone aware sb location for scrub
Date: Mon,  4 Mar 2024 13:15:24 +0100
Message-Id: <75f3da872a8c1094ef0f6ed93aac9bf774ef895b.1709554485.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment scrub_supers() doesn't grab the super block's location via
the zoned device aware btrfs_sb_log_location() but via btrfs_sb_offset().

This leads to checksum errors on 'scrub' as we're not accessing the
correct location of the super block.

So use btrfs_sb_log_location() for getting the super blocks location on
scrub.

Reported-by: WA AM <waautomata@gmail.com>
Link: http://lore.kernel.org/linux-btrfs/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
Changes to v1:
- Increase super_errors
- Don't break out after 1st error
Link to v1:
- https://lore.kernel.org/linux-btrfs/933562c5bf37ad3e03f1a6b2ab5a9eb741ee0192.1709206779.git.johannes.thumshirn@wdc.com
---
 fs/btrfs/scrub.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c4bd0e60db59..ee04bd8f5a46 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2812,7 +2812,13 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		gen = btrfs_get_last_trans_committed(fs_info);
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
+		if (ret) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.super_errors++;
+			spin_unlock(&sctx->stat_lock);
+			continue;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
-- 
2.35.3


