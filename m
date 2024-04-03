Return-Path: <linux-btrfs+bounces-3888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3777897919
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 21:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657D21F23346
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBD1553B3;
	Wed,  3 Apr 2024 19:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DZdg0plV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+9c/xNh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775A14885B
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173035; cv=none; b=KIVcyOIihHu54IBLXhe43JEaFG2FXFR2VP1nsOoolMnP/oe2h54K9qkbo5wUQ/HPO0LNC/kpSdWjBvct5swZOrDkTWk4mze02OabsGOJ+PE8yaYY6EKdBnoVtnPNwo1lQWciwKuUdKimruG6Yo6pfYLWdPQV54Y6bKFMoM3iHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173035; c=relaxed/simple;
	bh=Tdgu2K+kWW8n6CKKhFmBv0XTQ4+dWVYb6NRXPSFB2Bc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2p7aJ9Wu+GS6Shr/Y93KSifm+21btUVaq9pJW9pC0GTcL0SukyPZBYvYk7iyokdGZpwoS39DZdRzaZSYd33PwfcAv82TZuqu5jvTRuJh6PAjjnSmwa3u1GE/TMBNTKBELmRgCR+FseDkOolxWxBMniRghjcGH3GkmjXWnYVJwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DZdg0plV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+9c/xNh; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id D5D0B3200A57;
	Wed,  3 Apr 2024 15:37:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 15:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1712173032; x=
	1712259432; bh=VoRznIRtCpssyfvsOc/SlWCzm5VGTTOwqSkHFs7wnvU=; b=D
	Zdg0plVVh/GBUCfDiga8vvbHITJm8Xar3hDJjTwf//f01L1Bv9DUYdZZAWfd09Ff
	p8k+fs1xefUtmpl+yBfiqsxnbiA45k4lNgxgYIMYOGONGSkOwbOgcZkC8KE0ZR+v
	f8NUvic8+g0YBnSRgjE4Mh6GraxpgkEtqFbt6C8DtLbo+PniuxybGpYNgq2CT9Zx
	F/HIv8iBd4DHf7EQ7vk5LPXOjFj0DmNNrbp3zNwaf3LlHjA/4YOLQQ9BAx/DsaLI
	u2OyFgf1t7mK1NTwQn8kzVfGxxxE91DMcJePLgNkX45eg52ZaO8W7hn1j7Rjk26d
	jBliBSuS/Z/w1MFmMCNKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1712173032; x=1712259432; bh=VoRznIRtCpssy
	fvsOc/SlWCzm5VGTTOwqSkHFs7wnvU=; b=h+9c/xNh8qkBqWggBoDMWhrAXaJY0
	k3oSlRpREBSs8xrLkyR5yia1bgQDbpLGXIYi0Vy+qFjcIus1jGc29r77L6+pu5Sz
	FunIH0h0okYMLxgVhbNB2yBDz0MilJJXVS1EPeJ7JU7+x7ljegjuLTv7AEbHL2yG
	uDGoaJ/yVvR+xNgciUiyiyuHTnweRbGaBRNXKKOYIKUSlN2lMIxCw46i7OZO+d0f
	WgsTOZ7WsOLB3us0jachxorDou9gqIU0tqE0dUkEMDJIYQyvFXVZfoYUwaGia7XY
	9DXh9hrdVPw0V3fL6wgrP+8I4J+aZv+HofSoqOoxF33hWtMJ2zefJ5q3Q==
X-ME-Sender: <xms:6K8NZpgOolTbySsbBRDQfqNXPzc_5z3LtIIxMMacRi0AvBd3mJiU5Q>
    <xme:6K8NZuDiMi76CSqNtrUDX6xPZ1XA6lTkodlVcLJnPL3kz3Hx8MnJ0uUPFUhT1Fyrh
    aHSCV1fLARd74TKRA8>
X-ME-Received: <xmr:6K8NZpExYMH1mCwUpHHGYetO8b5nCmpVIvgPm6y49tiS7PM_BcoUVBFjZc1d9JXSiLJ3WYIpCokuLRzyKFG_k8xRU1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:6K8NZuTMDHdPlTXP5nwsx9Ly_bQIruRY4m_ZSfvgxsktpeNKydKnkQ>
    <xmx:6K8NZmzZ-wYbqBVnUaveB5olWarT2Ft0T2oKIDsi9OlhZjeSQLuYRg>
    <xmx:6K8NZk43CdcI2QqHP4U8HmRoxYTit7K-mFh4c105nCTbSpETh8GG0g>
    <xmx:6K8NZrwxIunkHLlHE4fjDSVE9J3AerXtCv3CoHKG41rZDqoWFKn58A>
    <xmx:6K8NZh8o6I-uVDn3uVv2S0H8xvfOO7C2mSmNm8K00Zyg5xRm-zM78qfRknLx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:37:11 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 2/6] btrfs: store fs_info on space_info
Date: Wed,  3 Apr 2024 12:38:48 -0700
Message-ID: <6f56853ca8437b8dd7d343adff2982ad9b099543.1712168477.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712168477.git.boris@bur.io>
References: <cover.1712168477.git.boris@bur.io>
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/space-info.c | 1 +
 fs/btrfs/space-info.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d620323d08ea..d20a27f293e9 100644
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
index b42db020eba6..2eb7f74070b2 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -94,6 +94,7 @@ enum btrfs_flush_state {
 };
 
 struct btrfs_space_info {
+	struct btrfs_fs_info *fs_info;
 	spinlock_t lock;
 
 	u64 total_bytes;	/* total bytes in the space,
-- 
2.44.0


