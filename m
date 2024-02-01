Return-Path: <linux-btrfs+bounces-1990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E117845431
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE342B2A4B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE63415B963;
	Thu,  1 Feb 2024 09:36:14 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B814D9E8;
	Thu,  1 Feb 2024 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780174; cv=none; b=OR3zFJUqOD1jNOwHkn/bukQMvQr8YQhhz94M9xtFAURgv8c6hudUP2EDYPRhtbCjRYy7W16/5E4CKrnxIsPjBmhSMwDDQU4a48imFQ4fonGOyZ3VxSEL3tC3ng+h6uhDYmdMk4aQgvTg3SjDMjaVKq03TLfc/Ghn+/JGtmQOm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780174; c=relaxed/simple;
	bh=jViJ3zJh5S2RCOGgf/S6HMEGoMjD40/QTYwYjRnaFjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HS5GINlUtSPDHBgaxnlczysipK+I5gPDGSpz0wNN0o3sGBA+FGUSWbRqvCzgzEkrxPQW+L86I06pFk8t4pkCiI1hqGrkw0hp7kkHyAxQLrjFBQX6dwqgsm3LOuwHeZj+dRbRygE/8L8AUFdQXkuJhPDtlJb2/iKqmlhrROy4Alc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 92d47a634f2e4abcaf6f369d3549e3f8-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f6e10d24-893a-4854-8526-31f5b5cd2053,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:f6e10d24-893a-4854-8526-31f5b5cd2053,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:dc750180-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402011735594VB9L5PE,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|44|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 92d47a634f2e4abcaf6f369d3549e3f8-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1698438554; Thu, 01 Feb 2024 17:35:57 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 4C618E000EB9;
	Thu,  1 Feb 2024 17:35:57 +0800 (CST)
X-ns-mid: postfix-65BB65FD-1124251252
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 69079E000EB9;
	Thu,  1 Feb 2024 17:35:56 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] btrfs: Simplify the allocation of slab caches in btrfs_transaction_init
Date: Thu,  1 Feb 2024 17:35:54 +0800
Message-Id: <20240201093554.208092-1-chentao@kylinos.cn>
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


