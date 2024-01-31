Return-Path: <linux-btrfs+bounces-1947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB9A843688
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97379B25987
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 06:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD2F3E49C;
	Wed, 31 Jan 2024 06:19:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7A3D0A8;
	Wed, 31 Jan 2024 06:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706681991; cv=none; b=aEehZOQYykqSseToVkyG1iJ0FayY8HOOWc2ZuX8l8dIK4kxMS0ENQdfGft+o47ho7qANqWQzCsxLDAX95FUtSflaawCUj/Kb3JiAzsi2kN6EsZ12Q57Z3q+wpuhs+ESLPnOQg3ugWteIqoUF/w77mngA9WYiQOXKH9vBJb6SqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706681991; c=relaxed/simple;
	bh=u5O3/gNRSdF1Vka2tF/34OTpsuldLvuRZepGrl5h7k0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SMd1/Ht+hwPMxiZzVQrytTKDNCCdD+anj/qi/Ds1xW4e3l7v/khJH85HxE1ueXqAzq2V0FYjkpG2QgRqaX4/ufGujJr9Wl5ehxhKWoJbBjQWa2TQJuZE+gXn/WP9zakGgSy9iI4/6Q2MYFtMwXI8rtXceGsQKzKQxvlwSP3gJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 40ea3aee49ee4d33a1f27c107259acbd-20240131
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c50e72fa-99b4-4905-8d10-937242d3f027,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.35,REQID:c50e72fa-99b4-4905-8d10-937242d3f027,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:5d391d7,CLOUDID:b83cf37f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240131141931X8CLJG0B,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|66|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 40ea3aee49ee4d33a1f27c107259acbd-20240131
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 297476359; Wed, 31 Jan 2024 14:19:28 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3AAC9E000EB9;
	Wed, 31 Jan 2024 14:19:27 +0800 (CST)
X-ns-mid: postfix-65B9E66F-40888197
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 74415E000EB9;
	Wed, 31 Jan 2024 14:19:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] btrfs: Simplify the allocation of slab caches in btrfs_delayed_inode_init
Date: Wed, 31 Jan 2024 14:19:24 +0800
Message-Id: <20240131061924.130083-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

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


