Return-Path: <linux-btrfs+bounces-1948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06DF843707
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62023B25498
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 06:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884D54FAF;
	Wed, 31 Jan 2024 06:55:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A749B4F1E0;
	Wed, 31 Jan 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684102; cv=none; b=c/HshnHD6FMXutDXZhu/JQjb1ygtYiq+dQpFJOjyCn2D7oxH+851kdFhG+s443HfVE5zGf9pzKfb6+GG/5uXmuSN0i/BsyPGEiDp6SytuH6n1QTPX6Qyd1opKirOWWwRxjRLUnJK1x3ZCIaXPIy73K/GQTIi97qcgLEnZEH5izc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684102; c=relaxed/simple;
	bh=yCeBxkcgFf4y305eEtZ2unXBrL3xPzCq8j6YfxsJYak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OoEgrKCgfR9vZfQxOib4ZBq5SD5f5WEK+Pa8wjMgak9+OXE18tFltIkBiE+dmCEL9cIaiF3qTrtNn9f/sKM+JBjU4P/lhb2DqtmMy3Md1frjmP7HaJd75zvCIlM9PONwFOYjlispR2ZjxpDkg3vdf2f9g/7uVZ7C9yRcJeNQ4AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 552679d6f4c14b7fb735038d8981ffcc-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4b17965d-1a49-4592-af41-e0553309ad2b,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:4b17965d-1a49-4592-af41-e0553309ad2b,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:cb7f7383-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240131145452XYK90MR1,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 552679d6f4c14b7fb735038d8981ffcc-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2100326787; Wed, 31 Jan 2024 14:54:50 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A3780E000EB9;
	Wed, 31 Jan 2024 14:54:50 +0800 (CST)
X-ns-mid: postfix-65B9EEBA-466033342
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 1E337E000EB9;
	Wed, 31 Jan 2024 14:54:50 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] btrfs: Simplify the allocation of slab caches in ordered_data_init
Date: Wed, 31 Jan 2024 14:54:48 +0800
Message-Id: <20240131065448.133845-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
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


