Return-Path: <linux-btrfs+bounces-2569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB1585B6BE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7CB21F22219
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBF5F84F;
	Tue, 20 Feb 2024 09:07:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2E5BAC7;
	Tue, 20 Feb 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420036; cv=none; b=EfYq8eXijbrPEaS+bAEnL/ZElBiyX8rQ3LGIsCdhGjScU21CPvPnBW0l/d0TYz6wKaUIvZvodO84OFP8t5qL69vdDmIjt40STHhySodVqkx6WYkcanOe56tjd0rkwfRlCJW8MizGpfelJMLEIEqmfZGEAzZLIuDHquPF3fOz/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420036; c=relaxed/simple;
	bh=0ptHOpcD+8+srSvx3GCLyJlqRgc5rBeYkiEmoUZwQ6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEaY28k0+Z+SNFwBlhsqE8bXLv0Qh4EsSO/mX6zjAlA1j9bPeXQWtbHV+oK5+VQoqHlx42h2YNPUedCZBCA72ekG2mdd2t6fwWMHl1ojBPrjLwoWFPevA+gekswmYosB3Ks+wVdhzKGXEwLUHzOfxWAV+hzxEJ1H34q7QzuJ2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: eca98fc7509f40589942fbe30cfc6015-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6c8d00cb-b530-4355-85a8-529f6d000f79,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:6c8d00cb-b530-4355-85a8-529f6d000f79,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:0a11fefe-c16b-4159-a099-3b9d0558e447,B
	ulkID:2402201707093T4YQ6UG,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: eca98fc7509f40589942fbe30cfc6015-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 265101622; Tue, 20 Feb 2024 17:07:09 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D75A5E000EBC;
	Tue, 20 Feb 2024 17:07:08 +0800 (CST)
X-ns-mid: postfix-65D46BBC-690154355
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5C8B8E000EBD;
	Tue, 20 Feb 2024 17:07:08 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 4/6] btrfs: Simplify the allocation of slab caches in btrfs_ctree_init
Date: Tue, 20 Feb 2024 17:06:43 +0800
Message-Id: <20240220090645.108625-5-chentao@kylinos.cn>
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
 fs/btrfs/ctree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 33145da449cc..cb9e79eb6140 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5082,9 +5082,7 @@ int btrfs_previous_extent_item(struct btrfs_root *r=
oot,
=20
 int __init btrfs_ctree_init(void)
 {
-	btrfs_path_cachep =3D kmem_cache_create("btrfs_path",
-			sizeof(struct btrfs_path), 0,
-			SLAB_MEM_SPREAD, NULL);
+	btrfs_path_cachep =3D KMEM_CACHE(btrfs_path, SLAB_MEM_SPREAD);
 	if (!btrfs_path_cachep)
 		return -ENOMEM;
 	return 0;
--=20
2.39.2


