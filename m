Return-Path: <linux-btrfs+bounces-1575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A8833205
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 01:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3808284F74
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 00:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD3EA3C;
	Sat, 20 Jan 2024 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="rM1uavTJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fvx4GMpJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDD0659
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jan 2024 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712106; cv=none; b=N7nxpdo9m4cXwbLTfOlDWVQv5Nw+qNrT1Ak7mczS409kliEs3/5SzodBCs4DPPTaT/Hfcq7L0T/s/29GWJfurhsC9R+y+iz5ZBKeslQvdBAtJ5XqiSHlP8yaBXuM00kuafxHBzsx5/2T0NltLpDra6G5oD5oFXqWyTA/bqxJYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712106; c=relaxed/simple;
	bh=FZCB/eCqo+7c2DvzlX9ZF4cqQw24z7tshkAgcmT1GNQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KC5k62YPR1pnReNIyQRNZDvmnOQnnOTkd8ZPXKhCtN7W0tQwILMYrrSiEAplhhrcpOEo430NdU3zDaYeu4P3CNO8ECfgIMAZFYj2UNykL6VgccbDZFQuD8ANnDZaJRyF00IqH/Z4Ct8BU12hvFZePWY/DHSPm0cM+jn6Zl+2mng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=rM1uavTJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fvx4GMpJ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BA2DF3200AD3;
	Fri, 19 Jan 2024 19:55:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 19:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1705712102; x=1705798502; bh=d6xDyzRA/HenqQKMRPA1g
	mUNbUg0Y+McpIiMQedMFu4=; b=rM1uavTJAdT95fMQkqsyvPIS785JlMJF1a2k8
	9sifigZXt6/UzVhi8S8/4lk89MB2DlBrpD3E8ZB2pOJE6ZaWZtBNP9qX/8NA/9wD
	5kwSRCmDCDUnXxY1ntbOFur67pnpE1yskY7NKGvW82PZrRPyIlBsWbbpsJh0//EK
	61OCqRBYpIATA14VcP5tATVcD4KvHH2BHOdXNrVSRQHK5tjahMpNnlF6iZzzcOIF
	6s6mC3Hi/yG2vtp9ZKBnY/iD72/6IkkBnQ9N9uG3iOT68wfx6E0S6ZSVOEEEXqxJ
	AJrTRRSMCcYP7dESfzIh5m1BFJzdvFbdCEuQGxPWeJxffbTQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705712102; x=1705798502; bh=d6xDyzRA/HenqQKMRPA1gmUNbUg0
	Y+McpIiMQedMFu4=; b=Fvx4GMpJBYuJwJX0vIvSktMMbcjBfB4JvqB+q3MvQpWq
	uHPxobeYKmGmt7kaDQfr4rSnzPQT1srWGI2knyCxicQBajCWD4rVgmYrvn8lAKYR
	mf8n+4lMTACo/GXcOROMUA05c0LKU/Jfck/gAHpyMXTLblkhfeJwtcM8M1uJ0Crw
	ZQGKxkEV7eE1bnZ+rSZ7kiTD8nyS2HA8ei/ynI4GPTt/2xoTQpF3LNZ2541s6fdk
	xJyvS4ieedVmxaRRS5EIQBm3wVsD5kqKc/ui2Xmhy/wQeFy79qkcZ4zc7mxBlrtC
	B+nhH1RwtkqOAMXwAXCtcf8/tWqjNeD0u1PyIt/9ag==
X-ME-Sender: <xms:5RmrZVFbScm8Qy9fg_hk4CeK8LapvOnQxO8PFshMnkXXZtA5NlUkFQ>
    <xme:5RmrZaXD6FC_ONd8rkiYcK39e42hFUj7WVUhYYh4FR_w7_2kJbte8vGTy6Gvb7yS6
    K07f7Md3wtFMIa0YrQ>
X-ME-Received: <xmr:5RmrZXLjXfwaVfJb6w_T8idaYymL6lAUJfVx1_TpuU65IErI5bjHIkjYyhikn0uykTCfV1STUzujASFC2wLgSRW9p-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:5RmrZbGvTZycUNoJKwMJyHFpQAtIEW4wf_PbPsZNO-VssahePkM6ug>
    <xmx:5RmrZbWYXAqKO7Sne8b6gYtJO4LHt8eMk7C9pqHAmSeebct6bh_xCQ>
    <xmx:5RmrZWM_Yth44gHvYuUAMYzE8BEuliz8kXz04Pl0vE_FU1fj5vFkUA>
    <xmx:5hmrZcc8Ja66r13XiOeC9dqABfVNBzLaHBJPhgFQfTt1txqRIlRrMQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 19:55:01 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs: subvol qgroup lifetime invariants
Date: Fri, 19 Jan 2024 16:55:57 -0800
Message-ID: <cover.1705711967.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subvol qgroups (id 0/SUBVOLID) are special. They get created
and reaped automatically for subvols, and can never have any children by
virtue of being at level 0.

Manually managing them doesn't provide much value but does create the
possibility for weird states and races. To that end, ban deleting subvol
qgroups that still have usage and creating subvol qgroups at all.

Testing Note: this patch series breaks btrfs/303 as that test is hunting
a race to do with creating a subvol qgroup which now explicitly fails.

Boris Burkov (2):
  btrfs: forbid creating subvol qgroups
  btrfs: forbid deleting live subvol qgroup

 fs/btrfs/ioctl.c  |  5 +++++
 fs/btrfs/qgroup.c | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.43.0


