Return-Path: <linux-btrfs+bounces-14311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62147AC8CEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C5917E8A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0027227BB6;
	Fri, 30 May 2025 11:29:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B86FB9
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748604574; cv=none; b=LtBSyO1d4kyIaj1YSt6NlhDi++MVgvYpNAlVfIAkfppuXQL9Rrljm+3u54lxZ4Ad2bfvlNvhKswzwg4ch61ut9ZCGHwuV9EP3ZeW1XLR2/rH6oXGfxdYgrHCQ2jFGgJon6/m//qzjWITSPTxUTJadT2mCPZAlhoXKktrUOA8rbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748604574; c=relaxed/simple;
	bh=B95Uq1OrZuPA3GtSk8fSM1wAlKkn28WV0xaV4ALDEXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLb3QQYh8vmuKxivkO8g2CssmevvVC/HdhBCN81sWj5dGPuB4kHHFVu+LBjZs46nQwEEtH8kmwvbtGlAeU0Gpjw7tOBq4YAcjFlb4wdOlc4r1IrvSQ3kNl++kWlv22X0FP3Ls5RfyWyf1hADuZglBCIhqxqYY2qpVfHjRelYqWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso12766405e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 04:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748604571; x=1749209371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5W1vPF7OUcNyL/Nk/8hbtwLs+XzthDFe/hjU6ozQTs=;
        b=GkUTx0yK950m9i9Dg6nRURGr1bCUnNs7yUozbAisY5YUvEXDOxjT1YQOr+j+hyOUdB
         xlgMUYPhBNmuPP0WLSK8pUwumOS09SfBwU2GuOMeS/oY9/jZk/xcmJcyYCGfPc8WpEvN
         vPEfJFdHH3nXMQIMLE0Wy5YxIQuBP/oacDZZvColJz5AHvM3eFABfd+BpaTX1NNlKryE
         eM5s+QApqWWnb/YvscZ2IkDm4gN/ihzVpo3KldO2Jhi3QMFb+UEe7bis87RYTk1Y3JSP
         WRZKJ2ojI5YzTKR2Qz8zDH0qQgGnzlJrOgtS3zVrnEfaNgg+Zs3oH6/rtJ63/S7hhfx4
         2zRQ==
X-Gm-Message-State: AOJu0YxQO4VVH9cmobGKy1k2O3/AL+qBiWKPTIFbtlMI2fReKkhVB07x
	IamECOTl7Ykw02w2ftscmYlNtm3i4xMKlAEi5uPSx0XtjVB/4RaIK0YYvDoxuXxUjDc=
X-Gm-Gg: ASbGncuEuSW0roF5vwD+mTfx2AEGGB0gOURpVpHnd69F4QaqhjCvGoAJTw71L0ucBx9
	TGViw8ljCV5sz7udisIoT5hiMdxn040btIfC3LsKc9D0Igel+et38dKzXXmWe7D0wkcz1R9rptV
	MUdasqW7ruFmb1HepFyOfb9G+zg3va97ErVP73IBMKfvExEa/i2kLImyExJb5NLH2uFrGvSG9g7
	sUMnzwiBP6BGO1eqQKFi4Wa2EnynCaZkg+dOfeaQ7tBAGS+eJDJr1zkQtu/AXF78BYiXdPk8mT3
	ASSL4FfN+Z4w2lyrFCIouSGU5mVreqQViw6XncpJJxlN7/Sk4TjxfhVGUhe/I2C0CKi/KZgVdSZ
	eVAOl4awLXEa56iffnfBDZ/e3fQxuv15KYg==
X-Google-Smtp-Source: AGHT+IE9Bin9BSLZepVSNqo+ez3Yj4wFqmeTfvYVpLfqtzqbGvJB5VpneiBahvyn07QRA/0aKqp2Tw==
X-Received: by 2002:a05:600c:1d84:b0:441:d4e8:76c6 with SMTP id 5b1f17b1804b1-450d655fdc0mr33219705e9.30.1748604570778;
        Fri, 30 May 2025 04:29:30 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7057400fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f705:7400:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe73f67sm4505093f8f.47.2025.05.30.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:29:30 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs-progs: zoned: create a data block-group for relocation
Date: Fri, 30 May 2025 13:29:26 +0200
Message-ID: <3a53de9f92bb6e28f56b610509f5363e6726140d.1748604502.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Create a second data block-group to be used for relocation, in case a
zoned filesystem in created.

This second data block-group will then be picked up by the kernel as the
default data relocation block-group on mount.

This ensures we always have a target to relocate good data to when we
need to do garbage collection.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mkfs/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4c2ce98c784c..3e3c360e1f91 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1933,6 +1933,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_ZONED) {
+		ret = create_data_block_groups(trans, root, mixed, &allocation);
+		if (ret) {
+			errno = -ret;
+			error("failed to create data relocation block groups: %m");
+			goto error;
+		}
+	}
+
 	if (features.incompat_flags & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
 		ret = create_global_roots(trans, nr_global_roots);
 		if (ret) {
-- 
2.43.0


