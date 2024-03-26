Return-Path: <linux-btrfs+bounces-3627-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63C88D02A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84854321388
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E53713D89C;
	Tue, 26 Mar 2024 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="etgrXnLN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8hVW+90"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849E13D889
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489068; cv=none; b=pMOrDrRQmHtzMaLKrL4vT/wxTX5W6Esdn7Twf40Dh7ZNzN6OreL+KtPQNxavSg0Ddsz/6kK86NkRMt/zLDRFvDla4aBLV/+s7skVSd0zGj5Y3vKWs4cxcAN2mzhkTR4WMhg4YnbLOt6juPS7IK7gld2t9rBa13diRPsCBBRvtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489068; c=relaxed/simple;
	bh=b1Ze2DeTs0SqzsGvI4K8qGWRccU3rtNluXRSSyqpStk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDPq4jZv6CZWrf1WmDzXTCeK4pm3+giOnj7s7A/SYI6/tgELlnz2vGC/vwca4SG4BnDGk+5XtpJhEGXEb6Koi+QBkILKEjLWfBpWJWiUQ5F97Apt2B/Va40pqS8J17G6PvUB5/e3GVgm2/RKsBuLyee7a4pVgln0LuBjC4vk1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=etgrXnLN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8hVW+90; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id E8E0A320077A;
	Tue, 26 Mar 2024 17:37:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 17:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489064; x=
	1711575464; bh=dU8W6GrsJnn+z9NofVNq7jn8AZbc9OpPoqjgzPvwYcM=; b=e
	tgrXnLNM1yg95h3YwsmjwHDyiUUpoonpd+qmpZtNUxjYvEMWSU4mqO/5pq/kLC9T
	o7nP62kfF4iBEss8hlwkWg+XD+Cpq3DETIFtP8aZq3t5I8e6wVcZMq+rQ4HKFjqk
	5Q/nKhrT/M/Ufm1JgB0/A59/C7332LgGsuZUQiMVqmS/UH9ELwtBSB1mp8d6Rxbh
	bH4Zslxszp85m8pKZ1QecodpU3MkIO0cWtCj4EBLgm6TXqTZXuMduQj1FXhF+1Ui
	BPKKRiV5Zv4zT0pjR4FZ16RClxk6VB1ow7e3OQyCWEvzQlVETuG+foiBsZm/uh1m
	LtDWMll4RZ5CRFOwS0zCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489064; x=1711575464; bh=dU8W6GrsJnn+z
	9NofVNq7jn8AZbc9OpPoqjgzPvwYcM=; b=d8hVW+90vPwMYqGYmPR2Cd7Negl45
	uEpza/HVmfWSWbDkugtbWJz4lM0IgPFy9q8hSCV2vi1Dm2BxLwD4dihuyGaOnXbe
	Lm8Vv+g0fI2rxq+JL4z1pz9DFwANNQqIC9yrGEF95r3O86CBgCA/EwNS1KSNUvut
	z0phFmlcmIs7ggJIvGUXcb3Vp0WCb9gSdZ2Vg8QXcdug39Klf0dlxpUbKsrGKffT
	Nxsyiut9p0W39XvBZ2lPRsKoxcvyJogpkNW6RHgddVi7j+Ig0WIB6x8lhlMJn8UZ
	OY3Trs6jcyZJllhTI35WJ/wZMPY6NQ74C11mtkd8xGJ90VTulOpS+xe4g==
X-ME-Sender: <xms:KEADZjuVU_rGBk_2VQ9_Ib34ZwaF0naHvYdV7mpV4FpJFuXpdxwuig>
    <xme:KEADZkeoA7LYVA39nGpP5itxhHk1ZdII0Bq_FM25DGwC5Fr59crGWQWBTcCPCBadi
    GWRSnV21acxT07gDU8>
X-ME-Received: <xmr:KEADZmzIkr-s2-E0fFpj2lRqf_cxMnZ4vJxmHqlGsvRn6bc2aVNdkA8uOQ6XE8jO8qugwXINxKcY7O61PwBrBjRwPow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:KEADZiPKAyLv5zA4pj8rjEqtm-9mT10TxYTlCtob-ccUylmBjWg_pg>
    <xmx:KEADZj9HwNFth_b5am-U2G3bSr_Hno2l67D-24Pu_4xQKdzolEFLWQ>
    <xmx:KEADZiWM29-q8ljGvy4HXuAWPFYdkYZV91qmV1trNT7vXHWvygyqJw>
    <xmx:KEADZkd7HUsF2SeuH2bTrwQo9PLHlDATJsg1SlEgbKCCMsFHmnYgUw>
    <xmx:KEADZtnWbsxRHm4m-R4GzcxZ2Zibc6CEG7H-stFAIZ6RE36eY4xWSg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:43 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/7] btrfs: correctly model root qgroup rsv in convert
Date: Tue, 26 Mar 2024 14:39:35 -0700
Message-ID: <71f49d2923b8bff3a06006abfcb298b10e7a0683.1711488980.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711488980.git.boris@bur.io>
References: <cover.1711488980.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use add_root_meta_rsv and sub_root_meta_rsv to track prealloc and
pertrans reservations for subvols when quotas are enabled. The convert
function does not properly increment pertrans after decrementing
prealloc, so the count is not accurate.

Note: we check that the fs is not read-only to mirror the logic in
qgroup_convert_meta, which checks that before adding to the pertrans rsv.

Fixes: 8287475a2055 ("btrfs: qgroup: Use root::qgroup_meta_rsv_* to record qgroup meta reserved space")
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/qgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a8197e25192c..2cba6451d164 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4492,6 +4492,8 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
 	trace_qgroup_meta_convert(root, num_bytes);
 	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
+	if (!sb_rdonly(fs_info->sb))
+		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
 }
 
 /*
-- 
2.44.0


