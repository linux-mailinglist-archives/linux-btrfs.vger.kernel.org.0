Return-Path: <linux-btrfs+bounces-2572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000FD85B6C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB00284DE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590A651B9;
	Tue, 20 Feb 2024 09:07:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AE5F480;
	Tue, 20 Feb 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420037; cv=none; b=uCKUHNnqd2tt33jirugsmBU/Mj+0sL07Hn2vkgftiprmDfBDyxYhnm2a0GAViRzYH9GHQTOsKYO5s+8mn/119/XL7VQd/T7nBZ8T3b/KbMePmwa3ypJn5CRwAwiqwzWmkcvVETvkYqpuz7Ih1nPo3ttyhzZxBy9JhVJPZmxrTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420037; c=relaxed/simple;
	bh=r8SiPrsysAc4HZ7ufEAzyTQeBwlHaR2NNXzXGtCdN6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sD4b92E0jtVBgWAzMld03lV4oLFS8Xt9acis+78RpIk2LAVR5oYmEZ/nb3rrJFVDtrINHnu8efL0Cz+EFjazHyUk0F/Cw/xYDbf0I2wMYgQLPAtcoReInAIXqZlicThQQ9IZdOWkgtq2xGoJA6hYdmHGy0eqi2J26PVITcO8gL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 37072fb0a82f4f7498a6919f677d2ce4-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d52da3ea-fede-4560-a2c5-d9c17bc3b230,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:d52da3ea-fede-4560-a2c5-d9c17bc3b230,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:0511fefe-c16b-4159-a099-3b9d0558e447,B
	ulkID:240220170709ULYUHU0O,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 37072fb0a82f4f7498a6919f677d2ce4-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1929369233; Tue, 20 Feb 2024 17:07:07 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 28BB8E000EBC;
	Tue, 20 Feb 2024 17:07:07 +0800 (CST)
X-ns-mid: postfix-65D46BBA-972832352
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id C0381E000EBC;
	Tue, 20 Feb 2024 17:07:03 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 1/6] btrfs: Simplify the allocation of slab caches in btrfs_delayed_inode_init
Date: Tue, 20 Feb 2024 17:06:40 +0800
Message-Id: <20240220090645.108625-2-chentao@kylinos.cn>
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
Make the code cleaner and more readable.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/btrfs/delayed-inode.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 08102883f560..8c748c6cdf6d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -28,11 +28,7 @@ static struct kmem_cache *delayed_node_cache;
=20
 int __init btrfs_delayed_inode_init(void)
 {
-	delayed_node_cache =3D kmem_cache_create("btrfs_delayed_node",
-					sizeof(struct btrfs_delayed_node),
-					0,
-					SLAB_MEM_SPREAD,
-					NULL);
+	delayed_node_cache =3D KMEM_CACHE(btrfs_delayed_node, SLAB_MEM_SPREAD);
 	if (!delayed_node_cache)
 		return -ENOMEM;
 	return 0;
--=20
2.39.2


