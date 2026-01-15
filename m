Return-Path: <linux-btrfs+bounces-20531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C783D22C0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 08:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EABA0310D9AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FD1326923;
	Thu, 15 Jan 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0SsITSA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1841C63
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768461026; cv=none; b=gm/0+xayh13fd7YmddZ2AGZnZZO6Zb3YOYxiG8Dg4yHHb1gRRPYUy0T+UIAuzx8Sf/Dcz4xtHrOdRSDZpc6uMDmQkdo2p67LTluDXHm5PgqHUDc+SgxAEBFDopR3rPcPMxbgUnMDxtXgTImVEeil4ohUGNtNRVsgiuJhupR4HLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768461026; c=relaxed/simple;
	bh=yiMdmTBKRrwqtK8V8o7vN72+HHJoz6mEPihezhkhuUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaaODk1YhSSVzkDwvC3Iev77os35DGZTfD/s39TvzTxhIwQjpqwZ26crgTVq0SraB21UnW5Vn/79neYdcKmq5rvWlP80uM52BQ3OQNvi6zTezoVlrQm3jL9wzksg0LDExUPa6Repj9L8H8bnPOk9q1Q+uySESBl+mWVvOKuWsxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0SsITSA; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29f2d829667so1527855ad.0
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 23:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768461025; x=1769065825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUErBZmRHlr5CluKjhAdKtQYq0291wEaMAaJzHU/k68=;
        b=h0SsITSAHvD2MTgAFLdEqJtfnscC1CgGFodRi62Mh+vmdE9LpumOzNjDGnu3/IcMQ4
         B99BnK9pxtGPdAzK7Tp7xpo3yebP1hYR1zZ+Z8KolQ8ijTG+uYCHBbUu36fM60c0zRyJ
         zMJ8qFIjhEUzmY9id/TDFXA+IilVTT28Wi/zTVsDJtzNnHsz+K87oG96ExQiU5JmJXcA
         3GB8XOT5R2PJLEWzOghfil0xEmh5KMUvb9Zqgwps5VsnTY55RYIx4HuyK7o3Xz+3V2vS
         QhrJEcYZ19N3yYu9pod8bcZshJ6FzIVSneuqEp8rhfe9nV1iCrcPjKtdrSGSpJle5epC
         jH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768461025; x=1769065825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUErBZmRHlr5CluKjhAdKtQYq0291wEaMAaJzHU/k68=;
        b=CMG7FrhhANHnsyXdAlVn2jNqMYJySo9YBLZQtHP14S6Z0VrlA1Cbs8pUzbgLbOGo2j
         xj00qFxT2G/QgtTLOVU9CaSvwX0y61h/Nqx67ojclkGBf/4Mv6Ks1rZouLvEcfVcpbxf
         WlpSYrAFEo2+MzWdyEyo+2kp9wfr8t738wvOV6fzYGi49GyJUooIHq31bW9wk/WbGuKy
         og7rPQfYuoq8X+NGL3Oo+4JPfMocttzXbq77+FWW8fWxBHEfXqzwmixdSoEzIeukvhLR
         0dhkjWwj3K6xLgikkpzx2EWjqSaXbVTykj3+IFgtRkcgEroI+Vn0YtdD/N7HHrjQsSqx
         t9RQ==
X-Gm-Message-State: AOJu0YwoqbKxnsKyM/KkBVGS+9XJxcXQL7FCRhAk5Va6MMRWljLKjvAg
	MQ3S6lV1axv36Rn01QMgRB5oDQ1QbNs22kMLFUmhCppDRCM7M2cthTdOe5M8vcF87RRkTA==
X-Gm-Gg: AY/fxX6NX2p5trC974Fk/ehP1VlKPCmK7Spmvta5FqflznaagwGwBKacmfp2GXAUve7
	i2CiCvS1Y0jUi0HyaK/F2wTmzxdYGr5BRbgLboxHISoMng2rSW4Mrp35RPYOUnuDISn4HzTyZ7+
	b00sRK47Jf9QHwxy0tsPbZyzoR+Lwe7LJTD8RJC2+8k0W3vk5XPg72M+zf7AH9asu84g4Ne7YFj
	xtRLc7IMZaP0yfKSbItUHrF/REH/V0+Yn3nVzQrSUAG7Gqcl2Te3nr+4SYX3k0xkmVlHP9xU4Gv
	SL8IiQ8SIR52ePWr27UBCqy3r8P1jigfJPpuvHePOOBvNQZVeNILWJ1VrXQBHo5TqJZIQgTEY2n
	JF+89cx69Iaf7UvanhymUnBw3EE/LUe6sKJsMYXAcMM8skEW07hJol6eLO9qYL2dIJEZaFcdp6u
	yePF+PNvUm/3VkpaRAckV1
X-Received: by 2002:a05:6a00:198a:b0:81f:43f2:786a with SMTP id d2e1a72fcca58-81f81b17416mr3938655b3a.0.1768461024847;
        Wed, 14 Jan 2026 23:10:24 -0800 (PST)
Received: from SaltyKitkat ([45.144.167.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e6a728asm1522119b3a.62.2026.01.14.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 23:10:24 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: cleanup node balancing condition for balance_level()
Date: Thu, 15 Jan 2026 15:09:58 +0800
Message-ID: <20260115071006.15012-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cfbb9308463f ("Btrfs: balance btree more often") intended to
trigger node balancing when node utilization drops below 50% (capacity/2)
by modifying the condition in setup_nodes_for_search(), which is the only
caller of balance_level(). However, an undetected early return condition
in balance_level() prevented this behavior and the change has never
worked as expected.

Since we're fine with the 25% threshold for years, remove the early
return and keep the old threshold.

No functional change intended.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/ctree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7267b2502665..48e1ef594517 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -960,9 +960,6 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 
 		return promote_child_to_root(trans, root, path, level, mid);
 	}
-	if (btrfs_header_nritems(mid) >
-	    BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4)
-		return 0;
 
 	if (pslot) {
 		left = btrfs_read_node_slot(parent, pslot - 1);
@@ -1646,8 +1643,8 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 		ret = split_node(trans, root, p, level);
 
 		b = p->nodes[level];
-	} else if (ins_len < 0 && btrfs_header_nritems(b) <
-		   BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 2) {
+	} else if (ins_len < 0 && btrfs_header_nritems(b) <=
+		   BTRFS_NODEPTRS_PER_BLOCK(fs_info) / 4) {
 
 		if (*write_lock_level < level + 1) {
 			*write_lock_level = level + 1;
-- 
2.52.0


