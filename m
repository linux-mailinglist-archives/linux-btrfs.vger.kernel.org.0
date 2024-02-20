Return-Path: <linux-btrfs+bounces-2573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56A85B6C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA3A1C23C98
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15102657D4;
	Tue, 20 Feb 2024 09:07:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661085F482;
	Tue, 20 Feb 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420038; cv=none; b=YFdgdO/7DYAJ5LX4MZbIxvs8+e54zWP1k3BtBb3x4jRElDf3jGuvORcSfBeNU+jHPfOlYyCYv+9vSgRmCbQago9jZ3EtOMu4SYJkxbpUpXR5Ok6tZOiNKAnv6cmNiuxhsHowCICmCfEYBx6nz2lP8BW4+6phcpwQFjYCt+Nrfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420038; c=relaxed/simple;
	bh=yCeBxkcgFf4y305eEtZ2unXBrL3xPzCq8j6YfxsJYak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F2yWvINbleGOUWFF27utVz7zGpQ/X8I4pLveXC0SZqm+BqmgZ1+yc1ygyFYe7oPZFuygrQj/KfJCHmkj9JvaJDbNSJvo7iH1GEY5a29ZLwmoua7qw6IqIKBTorpreDouOHGYPOl8X2b8azCGWEtdILeopSA1073V1CiBlv2UAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c5c450955cf741889aa72672d3c3c921-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:53ef1386-50fc-4d93-b6a6-f4f23f2612ef,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:53ef1386-50fc-4d93-b6a6-f4f23f2612ef,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:0911fefe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240220170709V9SKL47A,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: c5c450955cf741889aa72672d3c3c921-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 921392753; Tue, 20 Feb 2024 17:07:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id B4CD7E000EBC;
	Tue, 20 Feb 2024 17:07:07 +0800 (CST)
X-ns-mid: postfix-65D46BBB-548495353
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3AFBDE000EBD;
	Tue, 20 Feb 2024 17:07:07 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 2/6] btrfs: Simplify the allocation of slab caches in ordered_data_init
Date: Tue, 20 Feb 2024 17:06:41 +0800
Message-Id: <20240220090645.108625-3-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220090645.108625-1-chentao@kylinos.cn>
References: <20240220090645.108625-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/btrfs/ordered-data.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 59850dc17b22..f65d681f4c65 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1236,10 +1236,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_e=
xtent(
=20
 int __init ordered_data_init(void)
 {
-	btrfs_ordered_extent_cache =3D kmem_cache_create("btrfs_ordered_extent"=
,
-				     sizeof(struct btrfs_ordered_extent), 0,
-				     SLAB_MEM_SPREAD,
-				     NULL);
+	btrfs_ordered_extent_cache =3D KMEM_CACHE(btrfs_ordered_extent, SLAB_ME=
M_SPREAD);
 	if (!btrfs_ordered_extent_cache)
 		return -ENOMEM;
=20
--=20
2.39.2


