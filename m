Return-Path: <linux-btrfs+bounces-2574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A188E85B6C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F061F225AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5A65BA3;
	Tue, 20 Feb 2024 09:07:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463F5F469;
	Tue, 20 Feb 2024 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420038; cv=none; b=pIac3VrLqb+zBGs5FQlllF7ZSyXvVy7EcFhpbXSCCrEqtTgHaVKUAZNgwqckwjhPjVtX5wv8G5EvasOQdcBbnC74GmaAIm77LT7fpGBh/YnpqBmKGPmVycWH/Yss7nWGy/6XBK33V7EjYEdoa2gDCM5+E2sh3mHPFiAOLA+9F+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420038; c=relaxed/simple;
	bh=Xrzg5fUejmSCuIQ7akCUFAlybcLwAP2lB3k4kNs/lTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLtoEkELHsaurUSrLpJz0AIxyxqgO+tDrFOJXWdkypKNElHUn2Usp199O6suueUKpcYKUbqpwqWcW6Z/vht9yQRrPxW10v6p6TPzwiYTHJXKPDt0E1fihjMAP5qM0iAAJh7NVz5QDniKHZERTn887pT9trUm5HS9sjnFGMwFP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f0d91d03f3374452aa7d6f3a41df18f7-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f9401f60-a917-43c9-9c1a-23e67ad71597,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:f9401f60-a917-43c9-9c1a-23e67ad71597,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:620f808f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240220170712071GGCUW,BulkQuantity:1,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: f0d91d03f3374452aa7d6f3a41df18f7-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1887075056; Tue, 20 Feb 2024 17:07:09 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7C686E000EBC;
	Tue, 20 Feb 2024 17:07:09 +0800 (CST)
X-ns-mid: postfix-65D46BBD-275354356
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id E974AE000EBD;
	Tue, 20 Feb 2024 17:07:08 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 5/6] btrfs: Simplify the allocation of slab caches in btrfs_delayed_ref_init
Date: Tue, 20 Feb 2024 17:06:44 +0800
Message-Id: <20240220090645.108625-6-chentao@kylinos.cn>
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
 fs/btrfs/delayed-ref.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 891ea2fa263c..4a352e00ffde 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1242,31 +1242,23 @@ void __cold btrfs_delayed_ref_exit(void)
=20
 int __init btrfs_delayed_ref_init(void)
 {
-	btrfs_delayed_ref_head_cachep =3D kmem_cache_create(
-				"btrfs_delayed_ref_head",
-				sizeof(struct btrfs_delayed_ref_head), 0,
-				SLAB_MEM_SPREAD, NULL);
+	btrfs_delayed_ref_head_cachep =3D KMEM_CACHE(btrfs_delayed_ref_head,
+				SLAB_MEM_SPREAD);
 	if (!btrfs_delayed_ref_head_cachep)
 		goto fail;
=20
-	btrfs_delayed_tree_ref_cachep =3D kmem_cache_create(
-				"btrfs_delayed_tree_ref",
-				sizeof(struct btrfs_delayed_tree_ref), 0,
-				SLAB_MEM_SPREAD, NULL);
+	btrfs_delayed_tree_ref_cachep =3D KMEM_CACHE(btrfs_delayed_tree_ref,
+				SLAB_MEM_SPREAD);
 	if (!btrfs_delayed_tree_ref_cachep)
 		goto fail;
=20
-	btrfs_delayed_data_ref_cachep =3D kmem_cache_create(
-				"btrfs_delayed_data_ref",
-				sizeof(struct btrfs_delayed_data_ref), 0,
-				SLAB_MEM_SPREAD, NULL);
+	btrfs_delayed_data_ref_cachep =3D KMEM_CACHE(btrfs_delayed_data_ref,
+				SLAB_MEM_SPREAD);
 	if (!btrfs_delayed_data_ref_cachep)
 		goto fail;
=20
-	btrfs_delayed_extent_op_cachep =3D kmem_cache_create(
-				"btrfs_delayed_extent_op",
-				sizeof(struct btrfs_delayed_extent_op), 0,
-				SLAB_MEM_SPREAD, NULL);
+	btrfs_delayed_extent_op_cachep =3D KMEM_CACHE(btrfs_delayed_extent_op,
+				SLAB_MEM_SPREAD);
 	if (!btrfs_delayed_extent_op_cachep)
 		goto fail;
=20
--=20
2.39.2


