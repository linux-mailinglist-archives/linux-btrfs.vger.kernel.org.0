Return-Path: <linux-btrfs+bounces-3631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D8688D02E
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 22:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A61F81589
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 21:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997D13D89E;
	Tue, 26 Mar 2024 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JowaIUhz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oTkP52m3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51413D8A7
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489078; cv=none; b=S7HuZ/bb69SlSzZM0sugzAiIwNRqrDSJuMv+ewkXLzp6F0tPy9Vui9towaWxnHXTBSHqMJRKXwV/UWztsd02VI/YxwyRHNqrhZ2QCA6DDyUrCgXybFpowaEkQJJAyHNfQdnG3LUwHMdH3OJevoQf+xGV8ceW+WrtoWu1xq9nDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489078; c=relaxed/simple;
	bh=twwD/lT/0q+XnGhc5ZX+tLMMqF2MI8JY0gYSV7EXXNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuXDmApCVYAcisxaHkJcFZWyTMRWOEyjSXgns01s0vSgYQQr7inGecwF9zJ9Vk8aiw4YHVHJSA4jWiZvr0y79VAAHPZfcfFmsZdLiDDQlTFITcDqtg9jAaQj/R9OnU+AxYouPAH7FlsK5Xr25YrmHW4QxMZqiS7yRdOsqHxlqEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JowaIUhz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oTkP52m3; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 9D5643200A02;
	Tue, 26 Mar 2024 17:37:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 26 Mar 2024 17:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1711489075; x=
	1711575475; bh=0qrIrS1S9u+0Duo/56WgAEGQOdSzh6giLb/KCeW3akU=; b=J
	owaIUhzyXBU1lvpRwc4jOkeJTh2pttAZR/YBp2fCIQZT4A5zjO9ZX2gYpnBf1M3X
	fxUzMrH30CS7mXvFZ69llfKUgrko+AdFgc5tqvYx+2/UHQOuID+rtkyvJjD3UTLW
	F2C4rkOkS5+JElvbBffZITRlVL+jLzsVoct9iisJHHMYVmuYzk68yzqAkkOKLHsb
	QAS+/z9ou6Wya8fNErxwhTLxDH2ouvDI1ZsJHc63uUybvjcEcq8drE8C3XGDSTqm
	agKaPMvcpRkHGvgvDmU7mqU5m/LkzE9/Z1TxhevqQd5Kt5WFa3cTsbTWXhs5c3R+
	47wrmMJuADeDvy5jTE0Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1711489075; x=1711575475; bh=0qrIrS1S9u+0D
	uo/56WgAEGQOdSzh6giLb/KCeW3akU=; b=oTkP52m3ZEW1UC4b5YzGUyb8zJdCC
	G3QCyGNUf3eF5n0aKIQhLwY5b2FC9euW6kz++b6vSFCuA6DSGbGTAkVotbOwmQug
	n2GG1LGVsZUOSaL0yEJCfgL/W/1J1xzmnfw7ArysRLpxwhBlexnoanREzkPutFi+
	jBaN/r5oiD1b3x2+aqAgZvAiUXzqhv/ltz9ekFOp3c4TflE2KHeYCxQAsl35+ExB
	0BaQMssYwMoIqM5zhM/9PgB9sy/w0Ad8kD0YooMUntXTkh/YwrljeNiIMtaMwJZ4
	zsTpI/966H+/g4eI7L2MPEnEyS0pSwDDd9w6ntjn2N0K7TSuebfWFAwig==
X-ME-Sender: <xms:MkADZvBP1bSYdW6ITlKt1GcQsRgvecOK2emlN8Oq7fpyBS9FPpdxSQ>
    <xme:MkADZljF2r1v0JEfSPp3wswXXT4z-XGc8EphshGGtUNEmW7j0A8tWgo5lndZtbxUO
    dUJln64W6HSwVJkCM0>
X-ME-Received: <xmr:MkADZqlu85d9eEOuIwVzc4c-t0gc0bDU-hfkTKlJNK3Cw-5PmjE6AVkcr_or_V-TmbG_JZoT5HdMAhq0MlWdCL6IMD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:M0ADZhxgwT5wz-JS61cANks5g11vu-RF_nxCk6V8Gvx0IKrcEPF_Fw>
    <xmx:M0ADZkTYwpJ7uP0-ZmgIRVhzu4le_AoYoUe15KAHyAuvgy2fpYk47w>
    <xmx:M0ADZkbJ2WIr5-OGOEhPTnqc-zfXOJazvLNhDr1ApPBHwP0HryfQHw>
    <xmx:M0ADZlQotXQZn7DAJUUe6Kqm46tOUZKXHdAwYEpDB4aGAcmdSMWt-Q>
    <xmx:M0ADZvLSAZVlzYfU2w_w0zMr48LYNSCykDjpAMrnoSiGMhNfbh1gjg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 17:37:54 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/7] btrfs: free pertrans at end of cleanup_transaction
Date: Tue, 26 Mar 2024 14:39:39 -0700
Message-ID: <1697680236677896913e26948a76a2dd01dad235.1711488980.git.boris@bur.io>
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

Some of the operations after the free might convert more pertrans
metadata. Do the freeing as late as possible to eliminate a source of
leaked pertrans metadata.

Helps with the pass rate of generic/269 and generic/475.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3df5477d48a8..4d7893cc0d4e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4850,8 +4850,6 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans,
 				     EXTENT_DIRTY);
 	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
 
-	btrfs_free_all_qgroup_pertrans(fs_info);
-
 	cur_trans->state =TRANS_STATE_COMPLETED;
 	wake_up(&cur_trans->commit_wait);
 }
@@ -4904,6 +4902,7 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 	btrfs_assert_delayed_root_empty(fs_info);
 	btrfs_destroy_all_delalloc_inodes(fs_info);
 	btrfs_drop_all_logs(fs_info);
+	btrfs_free_all_qgroup_pertrans(fs_info);
 	mutex_unlock(&fs_info->transaction_kthread_mutex);
 
 	return 0;
-- 
2.44.0


