Return-Path: <linux-btrfs+bounces-2571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9648885B6C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 10:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E3428EBF1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 09:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A98763510;
	Tue, 20 Feb 2024 09:07:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4195D8E2;
	Tue, 20 Feb 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420036; cv=none; b=cZHC0J77LL/vcDPmZVZCOWbHXo2bbVhDRGg8NgyKxTX002YzPrQVrD4dxUdQjHCExHMy/QIbLck0VEjMsBIz2EVK55gym4el71UHogvhG6sVapHNorjCBZY2NXhfTpL4E08zLC5k1+aFSdLhee+ppqE9uNAWJU810wJQkCQA4AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420036; c=relaxed/simple;
	bh=89L7B2tPg4QQrMEoKdDuHvkjb0nFM7NCl947SdmlXpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o8GAWGUpQgMJ0IPlkNfsMUtqmnVXrqyM2tufGSZ0lrnu9BjAe/phvAjFta2wW3lcW6E4tw4osfAZ8/nXG5vLA1FZzTDE1atq2tD6GSfFLeLvRSCl0W2LX90TrH86v3MLBRB0MB/Pm03VCy9Y0MKi1P626IauBBMTkm7NMlh0NpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dba871d7a0024eac958b009188e563be-20240220
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:055f5a82-0ef4-45aa-a79f-fecd22c7680f,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:055f5a82-0ef4-45aa-a79f-fecd22c7680f,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:ce169980-4f93-4875-95e7-8c66ea833d57,B
	ulkID:2402201707031O9ANZKK,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,
	TF_CID_SPAM_SNR
X-UUID: dba871d7a0024eac958b009188e563be-20240220
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1096348071; Tue, 20 Feb 2024 17:07:00 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 14CF2E000EBD;
	Tue, 20 Feb 2024 17:07:00 +0800 (CST)
X-ns-mid: postfix-65D46BB3-873425351
Received: from kernel.. (unknown [172.20.15.254])
	by mail.kylinos.cn (NSMail) with ESMTPA id 17101E000EBC;
	Tue, 20 Feb 2024 17:06:58 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH 0/6] btrfs: Use KMEM_CACHE instead of kmem_cache_create
Date: Tue, 20 Feb 2024 17:06:39 +0800
Message-Id: <20240220090645.108625-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As David Sterba said in=20
https://lore.kernel.org/all/20240205160408.GI355@twin.jikos.cz/
I'm using a patchset to cleanup the same issues in the 'brtfs' module.

For where the cache name and the structure name match.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Kunwu Chan (6):
  btrfs: Simplify the allocation of slab caches in
    btrfs_delayed_inode_init
  btrfs: Simplify the allocation of slab caches in ordered_data_init
  btrfs: Simplify the allocation of slab caches in
    btrfs_transaction_init
  btrfs: Simplify the allocation of slab caches in btrfs_ctree_init
  btrfs: Simplify the allocation of slab caches in
    btrfs_delayed_ref_init
  btrfs: Simplify the allocation of slab caches in btrfs_free_space_init

 fs/btrfs/ctree.c            |  4 +---
 fs/btrfs/delayed-inode.c    |  6 +-----
 fs/btrfs/delayed-ref.c      | 24 ++++++++----------------
 fs/btrfs/free-space-cache.c |  4 +---
 fs/btrfs/ordered-data.c     |  5 +----
 fs/btrfs/transaction.c      |  5 ++---
 6 files changed, 14 insertions(+), 34 deletions(-)

--=20
2.39.2


