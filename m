Return-Path: <linux-btrfs+bounces-5770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2090BFA5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23FCB2152F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC87D199EBC;
	Mon, 17 Jun 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="B5dFaSjR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBn1rt9H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38192199E94
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665910; cv=none; b=Q0Ewk+bBYxrTAsWwWkcIr64vDXuSCEm0zbiMBt1el20rCjgrdw4SrghcOBUmo955EVxHwTCdcNvizS/R/8G20KPS1SMhHTSot+PtFePT+FV9BaraFyOYJf1ypgoBCKu1qsqSLpgXJbfW6E9YHpDLJSGh4ldJjSFpKcCkgbk9gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665910; c=relaxed/simple;
	bh=kO75C1mFM36NrV1Ek11JGtW84s5lIwl2K3ZyCex2bLk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILb/HBNm7k0jua0AxeUGPE+GN7gg8nxgvP/D4Nzxp2VYtMuk68E6NgiIbWmUovMB1Kfyyzlvv5CDPJRKIdX5AV2cjEAjxaaE4JxtYY5eYTGH2wE0kno95kol+oD2Y1D+8HnJQNoKpvCBrYcai8Fseu8P8NmUFCUJ3NOtZJEqxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=B5dFaSjR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBn1rt9H; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 457A31C000F6;
	Mon, 17 Jun 2024 19:11:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 17 Jun 2024 19:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1718665907; x=
	1718752307; bh=N/xpas+NVz2cj97u5QiYsX1Pa63CueybSoZU5PhqNDg=; b=B
	5dFaSjRdxlj9qK2pO/OoTi48UHh83rEPtCWk4m0u8pYvup1g8Gfj+u5k/VGH4zRf
	NUShZY/nPB3g7hXUr6t5AwaHNM9sW44LmUrvI/Dd8AoulHU8g7rJjbbhXkpIvaVE
	zHQ534+ZyOK6khHbsqEC1wooNZOk7xS7ii4E41Fxvh3U90yte4gqvdydxB8b0UC9
	pz9ZYdSUO/91Ol+aYDCAeGWemLV9ODcwApTKVKU4vzq77zThfIhz9vIWlfXvdAio
	U0tRrnsN432vLRyBLWrNYZMwBj9Jpk/FO05NyJGny63qBxXaVVQ+YljX6BPspiXx
	2QXcVSRcDvIf6E6ZLjP9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1718665907; x=1718752307; bh=N/xpas+NVz2cj
	97u5QiYsX1Pa63CueybSoZU5PhqNDg=; b=cBn1rt9HqmzrQDKYoW3zshp8OropF
	lWyM0BHgnnjGBCVoN7T6JtiT2Wvd+qkOofkv4SmsxLl7VXphj5tvTR4rHvvrxMhg
	2a9mL+99IiUg0TXQxXgXMnLrI8zqrsUVUtODqNnEP1aqUqQlNbBF5fbIeyQgVO6e
	xDw6I+nVZQkho6FvIMip+hT2MjjgB4yDwD1h81FyoK8AU2sq5Q/RCx2R+E/4A5LR
	KJHKD5UeNn9DZU+0zsAzB9pFeJIc+HyRLbPBbfCRIwGm/JF4KzGWjObV/f6pIbqu
	tH821k9r7wr4f0PJ2Ve4vZPBXrEiktY6oLjryjlACFwWZZS9Tz2OyxM7Q==
X-ME-Sender: <xms:s8JwZv3m078pBWkM6ZGYhIF9KVu8P06_aOMTXwFYfULWre-pCTWVaQ>
    <xme:s8JwZuHD8q0ifJkAx12yy_y1VBF5l7S486M37TrFRR-uUWBGM3GAk-tpcFLp3S57m
    8E3ZYLohjYLCIAvDZY>
X-ME-Received: <xmr:s8JwZv7kJdWnxyRX7XZeKcCPRdrPoiXWajMzp7TaTuOEezAcjaZ2DA9jcXKttdzO6ereeqIlnea3YQqaHK3d5zJzfTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:s8JwZk0g6m8gx2VwnIfawTF2KwSOcHhAQY9E338GxA_iin8QOvBnCg>
    <xmx:s8JwZiGz9MjF9LmGl3LY7lvylUC97mh5joeyGz0gUTxly9E1c6cnVg>
    <xmx:s8JwZl-HcqoNum5RwOSEF6cBTD0ugpZ-CbbPiqV6HZp7Q-JgLszzog>
    <xmx:s8JwZvmOlBjXzrOzD_roSlHsvvWVBivU0_u_eN34HFRDqImySPSkYw>
    <xmx:s8JwZnSjXALQhPPWNADhnUAbT_lW7CQdLuWfkCLMXcXoGYXalXe09hX6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:47 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/6] btrfs: store fs_info on space_info
Date: Mon, 17 Jun 2024 16:11:14 -0700
Message-ID: <5ecb8fd320d2c0aca46570aaa985e83f1f59e63d.1718665689.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718665689.git.boris@bur.io>
References: <cover.1718665689.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is handy when computing space_info dynamic reclaim thresholds where
we do not have access to a block group. We could add it to the various
functions as a parameter, but it seems reasonable for space_info to have
an fs_info pointer.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 1 +
 fs/btrfs/space-info.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0283ee9bf813..7384286c5058 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -232,6 +232,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	if (!space_info)
 		return -ENOMEM;
 
+	space_info->fs_info = info;
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 98ea35ae60fe..25edfd453b27 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -94,6 +94,7 @@ enum btrfs_flush_state {
 };
 
 struct btrfs_space_info {
+	struct btrfs_fs_info *fs_info;
 	spinlock_t lock;
 
 	u64 total_bytes;	/* total bytes in the space,
-- 
2.45.2


