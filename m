Return-Path: <linux-btrfs+bounces-1988-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E97845304
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 09:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C451C26164
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678B215AAA2;
	Thu,  1 Feb 2024 08:44:19 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA521EEFB;
	Thu,  1 Feb 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777058; cv=none; b=oZKt9+PjSBqwAfWzrCjU8sjibeaiEL7knUZiHHRK1Z3G0iDWaZlmyIJYYED9PWlw9+E03MAbwPchhMxpO/CC41t/W5r2bOQlpRxx9MVD47gjsufhu6/bc0ZaEagMKgxwPmgPHnDOljw9wDmyG5XPXNSj0T/xRpyRj9VbjvxFEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777058; c=relaxed/simple;
	bh=LlIlYqRlTw0tojpLRBc/lbB7iBHlg68dwJ1/Jk5CGFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifZZEmMoKIcjjf/zQakDAnL++nGrZKGxjfHLOphLM0YCwLDgrGybxbAtOC9Sg3BVXS6i3/XQVflHXYgp0nzkvwzJKREbDoxua66KYpanRVmPK0iUZaD7zpIJmS2uvKKSxBZefVW4oFj2QDN7+5YtGghQEyOdd/WcuQKpC1yS6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0090f8dc9eec483697318b7e37d3278b-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:ce19592d-71d8-4082-8c7b-fbb57d2fc382,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:26
X-CID-INFO: VERSION:1.1.35,REQID:ce19592d-71d8-4082-8c7b-fbb57d2fc382,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:26
X-CID-META: VersionHash:5d391d7,CLOUDID:02d80080-4f93-4875-95e7-8c66ea833d57,B
	ulkID:240201164412W36I5V77,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|42|7
	4|102,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 0090f8dc9eec483697318b7e37d3278b-20240201
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 475640272; Thu, 01 Feb 2024 16:44:09 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3A621E000EB9;
	Thu,  1 Feb 2024 16:44:09 +0800 (CST)
X-ns-mid: postfix-65BB59D8-917845955
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 66695E000EB9;
	Thu,  1 Feb 2024 16:44:08 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	Johannes.Thumshirn@wdc.com,
	dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v2] btrfs: Simplify the allocation of slab caches in btrfs_delayed_inode_init
Date: Thu,  1 Feb 2024 16:44:06 +0800
Message-Id: <20240201084406.202446-1-chentao@kylinos.cn>
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
Make the code cleaner and more readable.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
Changes in v2:
    - Update commit msg only, no functional changes
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


