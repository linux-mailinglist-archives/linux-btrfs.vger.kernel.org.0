Return-Path: <linux-btrfs+bounces-12075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3897A55C01
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F05189E647
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED9F42A8B;
	Fri,  7 Mar 2025 00:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DA/GMYP2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doo9EFRE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7D35968
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307302; cv=none; b=IRsBTgFocbxZF75140WYDWIXb12/T5syf+h4h8X0/INVsTbYokCa0EWoTIgOo5AsH0uiADp2qlt94niNyZPNrYy2uGq90hPw1Tr+ByXikV6RP3StF0ke0jMALQTD9TVl+NnCRGmMQFYaJAmjtRRnkPPEkr4LEqxu3gRNHl8X0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307302; c=relaxed/simple;
	bh=5R61vsuKej5on6uPLXupeI9ZwCWM+66F87c6WqwldG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5/ULlHg5l53C97UAs5AeCAYJE0sllqT70/CxSA5PWFafMQjgSFIelhXUFXuu39PstdRTgLZ9hpoly3ta7pxZ0PvGOckUebIgrrI4KvI7id120cowMLVXNdzVZEeo+ANVqR6RFPmoRvSF6qIzNCABKrBLWu+eAa5o+v6Dk5xAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DA/GMYP2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doo9EFRE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2640E1140161;
	Thu,  6 Mar 2025 19:28:19 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 19:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1741307299; x=
	1741393699; bh=camFk/O0eOjGXJfsCsluThCunGrAlyNqHxROmfEIKxk=; b=D
	A/GMYP2j+84iLiQkvoB0agfS/Z4bh0HXxtdOzyQ1+rH9wlOyGwKQC73JNYXyck65
	S4PuimJp7w+wt8+iYjAUf3HBf0bOHB75cyuriBwyF3Wv2yYCtNFaclWPpSftmHPl
	64b28poV0zAmUU7cR98qtst1Wq0mVPCo7ZU6/sD0jR5j2f9fO/aIDgUnul/swMmw
	BGlQ0ZpPHkLWCa73zpj6TZv0VxFPrbx02zYrm4s8Cr9HTN7yqGb50l3tkJbQ9swK
	YNHeYm4W+9u9dTj6OSg5VexpmzERBSFhD7mIhNbgmDMekm8z6hlm59K4dH/cLbXY
	s4Vh7s/Kz2qNu3Q6Cz+dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741307299; x=1741393699; bh=camFk/O0eOjGXJfsCsluThCunGrA
	lyNqHxROmfEIKxk=; b=doo9EFREtx52/I3s26jhMHKrbSP1jijDKKAy7U+PIi8A
	cgjMmAK5VgOPtBmIznD7vPLZXrEidE7P4S1blrdm9Pn16KWuDUBuFnH1Q2aZLfi6
	3o2cp57kueXirtIiXj2InFc3vFsACTcqAX5Li+QbjHHmZwJiqrrhMKUkSfVVtGFz
	fWWXycaG96Tqm/x+B1ZG/NReY7j8/n8o/IP4hbfzcdjXVMwADzJju8vptnY8viiK
	+I6v8r8qv7RjH88UFxNzYdGYr6l0kgpDYLuBaQRM3njSkCm8rh59pWV171x/tENi
	wH9iiQRaEB6VNmujdrgNP1heI04VMTdk8kqdgMSO9g==
X-ME-Sender: <xms:oj3KZ8DthiN6_PeNzUS9mU8eIx-sHO3QUEBxZMc3w-318a7YJcHnxQ>
    <xme:oj3KZ-jWA08M6qgoE3Fqke7BaLOKdwY639mv5FqYj_Ow-tQmNrT2AWNCSHvmb1GFB
    y_j90AONXVuapYdnek>
X-ME-Received: <xmr:oj3KZ_lI91xnPXwaQEdSZpZjHZxVi_wwlsbb6TXR-SrCrLCJLSpf9vilM0N6dlJOGeNpBRqR0aO7bdcAZfraR1YINgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeuje
    fhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhu
    gidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnh
    gvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:oz3KZyw0STlJ_YqsWqyeRNzexTuoU-Nv9aK84u-OlVY62M91ok43sw>
    <xmx:oz3KZxSD3qVJxUf30g2OROdVVLGx60R2bLJH2HdmX-gYtcWU0-7P4w>
    <xmx:oz3KZ9Zj2Dhy0CMITMWHARcAd5gj4yILzGSGSfTG5xnTfnjBrVZ-yw>
    <xmx:oz3KZ6RXuq2bf378sQObCqSb0GGQutHtL56t4L3WsRbDrZqEQl_jSQ>
    <xmx:oz3KZ8dex68p3daGSGx8adgI0_7F-1pqjWGZ7O_D7g0ayHqc8fg67vix>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 19:28:18 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: explicitly ref count block_group on new_bgs list
Date: Thu,  6 Mar 2025 16:29:04 -0800
Message-ID: <817581cbc85cfda4c2232fecbfdb6b615b7067ca.1741306938.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741306938.git.boris@bur.io>
References: <cover.1741306938.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All other users of the bg_list list_head inc the refcount when adding to
a list and dec it when deleting from the list. Just for the sake of
uniformity and to try to avoid refcounting bugs, do it for this list as
well.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 2db1497b58d9..e4071897c9a8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2801,6 +2801,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		btrfs_put_block_group(block_group);
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
@@ -2939,6 +2940,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	}
 #endif
 
+	btrfs_get_block_group(cache);
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
 	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
-- 
2.48.1


