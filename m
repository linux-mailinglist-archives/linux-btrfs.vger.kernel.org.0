Return-Path: <linux-btrfs+bounces-2575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A285B6CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AF228F5B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE11664B9;
	Tue, 20 Feb 2024 09:07:20 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC264A80;
	Tue, 20 Feb 2024 09:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420039; cv=none; b=UZ8ZOct1TsWLEy3MLWmXJk2GvRl2djwqFT30dESBVxMBYYdoy50mCRS6r1vB0lvA518F0xBa75XJ3vGS8p64OpDxJ8i6nn6PL8/51WdJei1OKwlMUzCsq5PD/toPiE8KWpStsopllhDPy4IKa+9iGPz7JKgENW3Yh2LWDZV3dso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420039; c=relaxed/simple;
	bh=ZVH9yOT4c7q095AZG2yUK+V7A9cFcYgpBeR49WkHhxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQMpZPQA/Ps5zJeCheUaaOuqO/+1I49AnJhPeYpQKyLTXImvGS0o4Pzr6LIdK8/QJ9tgfWT+xo7YGePWXLd0Q6awGnLfCczZEy8M6IptQV8gZZV1//BB03/7eSSdQ7OHM4/q1Oy0eQblAMsr06Z7i7NdZ7w6nIKw74iBjsHeBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8883bfd10688416286ab884bab5f6b34-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:19ada77b-d8af-4b53-90f9-792a29b09066,IP:10,
	URL:0,TC:0,Content:23,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:43
X-CID-INFO: VERSION:1.1.35,REQID:19ada77b-d8af-4b53-90f9-792a29b09066,IP:10,UR
	L:0,TC:0,Content:23,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:43
X-CID-META: VersionHash:5d391d7,CLOUDID:492b1984-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240220170712071GGCUW,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:4,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 8883bfd10688416286ab884bab5f6b34-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1037215462; Tue, 20 Feb 2024 17:07:10 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 132E0E000EBC;
	Tue, 20 Feb 2024 17:07:10 +0800 (CST)
X-ns-mid: postfix-65D46BBD-883011357
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8C7E9E000EBD;
	Tue, 20 Feb 2024 17:07:09 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 6/6] btrfs: Simplify the allocation of slab caches in btrfs_free_space_init
Date: Tue, 20 Feb 2024 17:06:45 +0800
Message-Id: <20240220090645.108625-7-chentao@kylinos.cn>
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
 fs/btrfs/free-space-cache.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d372c7ce0e6b..f62f5c339e18 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -4156,9 +4156,7 @@ int btrfs_set_free_space_cache_v1_active(struct btr=
fs_fs_info *fs_info, bool act
=20
 int __init btrfs_free_space_init(void)
 {
-	btrfs_free_space_cachep =3D kmem_cache_create("btrfs_free_space",
-			sizeof(struct btrfs_free_space), 0,
-			SLAB_MEM_SPREAD, NULL);
+	btrfs_free_space_cachep =3D KMEM_CACHE(btrfs_free_space, SLAB_MEM_SPREA=
D);
 	if (!btrfs_free_space_cachep)
 		return -ENOMEM;
=20
--=20
2.39.2


