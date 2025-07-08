Return-Path: <linux-btrfs+bounces-15313-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63DAFC373
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 08:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2D1178AF6
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EA222422E;
	Tue,  8 Jul 2025 06:55:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3250D222599
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957715; cv=none; b=HAJ0Pot6IjqtrnIQrNFROYDXfLWMKhdul+uP3r/ZEqk3HWHG5ssUg9X/ObUdfKu/zuXhS4qdkgIj/hZohn35bd+y6cZLGdYRq2Y7K22RZEKTbHK8pnMJjzQUwiIRAWcdXJji11yiH61g2ds92khubc4RN74OUiyYOhhMwZt3ZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957715; c=relaxed/simple;
	bh=FOqB8VhyvDrQuesBphR1DZBRREjsQSLUGk2hMPXdfqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnFHvq/OTNaoVnf1ffM32QJzs52E36W08v9xIIcaHtKZv7BCP03oIYN79Fl5WNqNCSaPE+7gyMhuOjbTQzGVuX0yiKJBgfoDsKHrjY4ynp7WIA681v1ytR7HhRnd5+AHzpXrpa/dGOJyd2j2873KoN7UD+n7DR5eU3QPhyzSkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cf214200so29469875e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 23:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957712; x=1752562512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUaobwralxBN2p5p1XIGwCNuIPhUc2X9KuoVwffqKmY=;
        b=IbhvBrY71ETZUz/HRDIfEX3K2dC/bjbFlG0SGUc2IjAucvG23cpx4vA+WQC5aKAkH4
         Ywz+eLuab1Axmf3jTvStJ0AQrs2foTMBp4x1RNfdoOKOqt8FJRqNSLvZtW1N4maVY4Gv
         DT5sZTx4nxWmcrLS9omw2JtPxqNaJ6pjgBEqDYYlvrJ5JTRlI506CjB3/Bd/wWri5dax
         C/3x1sbFJahrLsgO6PDONURglWfZHVjRR2e4kaX5P+Ymxv5D8VSUY7wcE9v0nIZc76P5
         nMIDVJE418LvbEplG9TH02tg3BTUgk9PRikx7h6K3rPWXgEjdfFtqjR09pz5KDezy2xO
         0ZHg==
X-Gm-Message-State: AOJu0YyAPOGqM631d7ZiHwoOG74R+HuyDvX/W1lT8oPyAOvvrlMJnsGy
	Ec6yuOGDqvhyeCew9xXKpfZ3opPOa5goW9EtUVBfsWOWAAluaZB+gxVPlxLsIY3u
X-Gm-Gg: ASbGncsCxSOEuC2huRU73DGLAlQ2vmuInMj8dK8nDUTWdV0tD3vL8E5h2YrXZBCzhyf
	Eogb5RElLWNhUiJZ9Dy6Cy8Z1kJTtjrSiUXu8qWg66xv3pw5m9mnZfMKP5J5iuULpRSadPQOgAB
	q+MR2+ptFYduxSO73oDzeUpcJXlVJpGjdd9gqAXNLSQWonziUPU1suUDo5Ka2ebPcezjZ/yYugO
	jj9yrcMOiEQzRMW30d15whHZ65cCQr/YBfuQVDVHlFuqSdlGvE8vLWSvRC/2eREdN2o+z9vs2/f
	xeEbBf7GIblb7bPWvYJarIGkS/2ZjrMqlpILr+HaAeevX0+ltynyLeYweXP1uORIw95eYJtHJ7j
	Fi9txsFBQHBITBs9EMGppgr6ocrpYoMrAA24RjoemJCARizrNqg==
X-Google-Smtp-Source: AGHT+IEABW2lWsyIaJ+fcLZjCaSUTQ7eQMt/kmK5QY3vy+I7lcj+MZkEAdpnpxPtbwO7X9EcCix5mA==
X-Received: by 2002:a05:600c:620b:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-454cdb71f90mr12665635e9.4.1751957712060;
        Mon, 07 Jul 2025 23:55:12 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d275fsm12745075e9.20.2025.07.07.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:55:11 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/2] btrfs: remove redundant auto reclaim log message
Date: Tue,  8 Jul 2025 08:55:02 +0200
Message-ID: <20250708065504.63525-2-jth@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708065504.63525-1-jth@kernel.org>
References: <20250708065504.63525-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Remove the log message before reclaiming a chunk in
`btrfs_reclaim_bgs_work()`. Especially with automatic block-group
reclaiming these messages spam the kernel log.

Note there is also a tracepoint for the same condition to ease debugging.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fb62a8cf03b3..b01408f0b92a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1963,12 +1963,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		reserved = bg->reserved;
 		spin_unlock(&bg->lock);
 
-		btrfs_info(fs_info,
-	"reclaiming chunk %llu with %llu%% used %llu%% reserved %llu%% unusable",
-				bg->start,
-				div64_u64(used * 100, bg->length),
-				div64_u64(reserved * 100, bg->length),
-				div64_u64(zone_unusable * 100, bg->length));
 		trace_btrfs_reclaim_block_group(bg);
 		ret = btrfs_relocate_chunk(fs_info, bg->start);
 		if (ret) {
-- 
2.50.0


