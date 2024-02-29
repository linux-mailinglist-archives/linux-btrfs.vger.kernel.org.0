Return-Path: <linux-btrfs+bounces-2936-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048C86D267
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADE71F21BCF
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C578287;
	Thu, 29 Feb 2024 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="KkJzprOj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvEq5O43"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146B4087F
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231745; cv=none; b=Tmn3CnWbpB4Wt7LqDP1Kq4GbITsQwjO8UivNbbH11I7NC0cSoJqh/3zP3fd6YgK8GPO9f1zA/ef7pvb3AXx9yxHpVETl/myOmntxyCgjz9q4z+XHwOeVgsJ+kXDNVvENWZKgwEKBW/pfJ5sS1P2J4ADcKYVPFh0iIY33GA8S+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231745; c=relaxed/simple;
	bh=SFwEejiu8D4vTzN1WxvMd5K5P2DemEM6yCUVz9dUk44=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JcInE2SdZjcpQW8EKpkkK8ONgxaAL4Z/mUnVdbX6NHkT5PJAIQchHBFmckNY54ZGptOPP9aXEXQ83oqbEWrkZHo/sSkgg1E4PdRImqEaHyd/w5GXfDyZUHgWP1sQzVC+9ivrhqsgRz8SRq/EarkWLvAhakSas5IpxsJG2hdehbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=KkJzprOj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvEq5O43; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 5D33432009F9;
	Thu, 29 Feb 2024 13:35:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Feb 2024 13:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709231741; x=1709318141; bh=nQcarY2Dq7WCk841vJP/1
	BxKGDAjHf+hSP5jyDtbUGQ=; b=KkJzprOjot713aPQLWfILmXD5lXvZKMCKfM1A
	j2PrntW9UMxGIapFdoeau/pPCspAJLXFI8FEd0ucsJmcNDUIBHb6dJvWfENeLA9J
	+LGQYGt45dSbf81dZArHbPbBGbSDc7aZXqBrKMjvYgQjtcmtDUGauprFztoozmRY
	JRQ1ECRcQzZeu5QlLTBUA5nicTZNUNDbxv+OGS/LXnFMlyFP0yAfzjvYyEIXCTa+
	7ZR/zSFmSzporCygOesvzpSSSRogQBF+SnNR2fh13ISpL444gItH6zY+ZR0T4jSj
	w4fVmxD2ZD+4oPg+RcOjN2T+l8ULuTLItZRibq/YXepknFbiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709231741; x=1709318141; bh=nQcarY2Dq7WCk841vJP/1BxKGDAj
	Hf+hSP5jyDtbUGQ=; b=XvEq5O43GJzggCd0h4RkW1leRr9vTEDIYwK5xZtDtrFR
	Gj0Cszaec/UMpmylcFXbK2V772aA/NRSAAWekN285NcbnXZBM0/7+LR0Q+wbgvj8
	g0Vkjvon3/JPhWEdi2F8PeBjAIF3z/jxL8ztebO1YvnzK5GVtVt7ewmbBbrfeVjH
	qJqUW5enGZOE6mssZ8sSYF8C0ikyXYyOp6vJWb4M+nMZGkSqOCvP3YQCKI3MjcAV
	nbncoCBHKeygZXb6yvs+Mv3782H1D6J9glvSXsdVg0IEeKZZqYsmRrdcm9wRpmAu
	Vs2Sd7ekqBhLwV85HkQ2bY+YyaglnIg8WoVphaJw/g==
X-ME-Sender: <xms:fc7gZeBUu5BTKA3zfxXKnvYKdTUEajFbqtprsmcf6fWyCl0LMh0mTQ>
    <xme:fc7gZYh_erQcZDKvPrepIwLhEUrWTc4isFuhEUGZWNK5w3bW7omokUk3ADybEyx8h
    buWMqsNOcOVKiqHAz8>
X-ME-Received: <xmr:fc7gZRnVfF_WBbY9X3Zb2s7crsGAhvrsNYLtRoUGlzim6Kwp3U8BLk6tnwU2-xQj5GrBVLCeLymm52w6rmS_3G4zGBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:fc7gZcydijWAoUYAHzdp8sHko6V4aDplB0yh-6z1lnBwume_AmnwZA>
    <xmx:fc7gZTQ8HvIiROmwJaxQqeAxyIzD9cAI-m2wbCeF8z4C_PPJxkHAoA>
    <xmx:fc7gZXb2zFnP00DJ2snzZenjOvp-Yu8gb9jcylpQG2qBQ05hCb9Jhw>
    <xmx:fc7gZU4cXFO-kwIZk8SObX_VWyS0jsh8XvZPtMlcjuFtODQ8mn0R1A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:35:41 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/2] btrfs-progs: forget removed devices
Date: Thu, 29 Feb 2024 10:36:53 -0800
Message-ID: <cover.1709231441.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To fix bugs in multi-dev filesystems not handling a devt changing under
them when a device gets destroyed and re-created with a different devt,
we need to forget devices as they get removed.

Modify scan -u to take advantage of the kernel taking unvalidated block
dev names and modify udev to invoke this scan -u on device remove.

Boris Burkov (2):
  btrfs-progs: allow btrfs device scan -u on dead dev
  btrfs-progs: add udev rule to forget removed device

 64-btrfs-rm.rules | 7 +++++++
 Makefile          | 2 +-
 cmds/device.c     | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)
 create mode 100644 64-btrfs-rm.rules

-- 
2.43.0


