Return-Path: <linux-btrfs+bounces-2570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB585B6C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC661C23ED9
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CABD63519;
	Tue, 20 Feb 2024 09:07:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6145CDC4;
	Tue, 20 Feb 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420036; cv=none; b=b4FBtX6CyQgUxvcE0bT+A2LPNHnVUuD7TpU9RAdx6WMgN0TZT9o2PjT0b4igNKDtU+MP8kaKOzzB7g/yA84f7GWk7BV/tFg75e0R9mooWq7NjLqR4kISgCZyuQiDIAaLKBe2r10F6nsvEUWVbBBv7ltiTNoyyutggKziuZ/UstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420036; c=relaxed/simple;
	bh=jViJ3zJh5S2RCOGgf/S6HMEGoMjD40/QTYwYjRnaFjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uaNRCpEQx8BjaI/REYCMpOIXkeJ++R+Sf1LjpWoP2J+sdlvNP9QPRaEt2BMPQtmGg1tOtZ1sHEmDAtKH7Fdt3g9KonvzvBSwyjZ7+TA/DCCOUkscIPiYS3jDeWJKiO0x/sOp6GIyG9RELv6OIbPIKuw/NqZ/SCxfT2iuKycA6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 723cc28d881e47c1b7ad6ba5c61e9bd4-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:990c5bfe-920c-46b6-99b4-291616874d89,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.35,REQID:990c5bfe-920c-46b6-99b4-291616874d89,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:5d391d7,CLOUDID:470f808f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2402201707097JI8SRP9,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 723cc28d881e47c1b7ad6ba5c61e9bd4-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 177855381; Tue, 20 Feb 2024 17:07:08 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4C848E000EBC;
	Tue, 20 Feb 2024 17:07:08 +0800 (CST)
X-ns-mid: postfix-65D46BBC-112189354
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id C72F4E000EBD;
	Tue, 20 Feb 2024 17:07:07 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 3/6] btrfs: Simplify the allocation of slab caches in btrfs_transaction_init
Date: Tue, 20 Feb 2024 17:06:42 +0800
Message-Id: <20240220090645.108625-4-chentao@kylinos.cn>
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
 fs/btrfs/transaction.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5b3333ceef04..0c069d44e77f 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2720,9 +2720,8 @@ void __cold __btrfs_abort_transaction(struct btrfs_=
trans_handle *trans,
=20
 int __init btrfs_transaction_init(void)
 {
-	btrfs_trans_handle_cachep =3D kmem_cache_create("btrfs_trans_handle",
-			sizeof(struct btrfs_trans_handle), 0,
-			SLAB_TEMPORARY | SLAB_MEM_SPREAD, NULL);
+	btrfs_trans_handle_cachep =3D KMEM_CACHE(btrfs_trans_handle,
+						 SLAB_TEMPORARY | SLAB_MEM_SPREAD);
 	if (!btrfs_trans_handle_cachep)
 		return -ENOMEM;
 	return 0;
--=20
2.39.2


