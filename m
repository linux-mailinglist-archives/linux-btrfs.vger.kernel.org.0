Return-Path: <linux-btrfs+bounces-1576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2F833206
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 01:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59201B230EC
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jan 2024 00:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C44DEA3;
	Sat, 20 Jan 2024 00:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="j2q4BHIs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBJ68XTh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07B7F7
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Jan 2024 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712108; cv=none; b=SRZrfEHlj6ZlCEyVxZc9C37ELS46gy5rz9Q78Ab8ZeiZLKPwlhiiU8WIPy5Kw3dK+YtOIH6ynoCQLTgmrEpidDuuWCFhNn+9/SoGSLC9d4+c7UX2koGYzQVVqLkpSYqCgV0ZAXZjdmAZVxNkpe39hmxulgVlQTpaE287EGoEpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712108; c=relaxed/simple;
	bh=MDhPdyTOcMgR5w+sxPHt80PKYxDobxBARdZrd8+3rDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAFPeHhFS2Ct8AMEuTknhV+yWU2Yy798DKi0WB3+hK+q0yErOYt69RNGk5pUJwY1WXxW2oFc3zFfAkLEfMoS5XUXOmCl3nIxyatoxHV5FD32fbVPckG+UdmFlk5x/p078BQrpIx+UnP/lEx/6x8cT7MT3VV+T+3IvkxZPza9/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=j2q4BHIs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBJ68XTh; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 610C93200AD6;
	Fri, 19 Jan 2024 19:55:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 19 Jan 2024 19:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1705712104; x=
	1705798504; bh=LzxCody8ku3TDdLnj4PvjQl1ZckzTtxmlQV1qA7nbJ8=; b=j
	2q4BHIs0h8+IYkIQ4CSdC/wP5PzjV4eFxojwgz2MIwyMJuohttUVQEXPDAqRX5Cq
	fVwEB5eY4KJosoNM/njl5HwKDQ4pQpd2DpOfhuknegbNJ4JEopkM3mPPNHwe/ZQ9
	1Q2WYTulm9NEfKpl6wdy09l2aZwZ58Ca/t4ePWDF0Ykb6TWCEaRAtE7rlEJDfl5n
	BNk+hj3o21Em7mKGfJD5TSTlSH2dsHTyab8S5v/l5JIMhvFmHhUx1X1fvjkow5ic
	ecpjnfoSwPGbILCOBbvJZMOUMcUBRP4AbP1XiBbI2K/MWjma/tP+1pryPdXEryJ4
	iq2RJSXdhTyyHcp5CHngg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1705712104; x=1705798504; bh=LzxCody8ku3TD
	dLnj4PvjQl1ZckzTtxmlQV1qA7nbJ8=; b=ZBJ68XThvF5+30XvRrLZ4RqabJ2CQ
	uvIgLZ7hlb64ZJxNZlJkUfK9M9YeSMGh6dwnWdvlFreQAMDV9IH45eRvkhkIg081
	iC4kmMydyoO1chyzl+pEZ1hVH7Zo1r6AZeBwtkt54UbI/EqA7seHpP7Jrk2tTARx
	Tb01yyKxp0BUbBinrEDMo5dywsY45mAtUaaRSLUVpswX9Twpgrss0JkO1k3Dk1D3
	PgdPbHV6jUtBwrSmZQasTnpDsLHft034dbrpQPRKvgXBmKXkK6KT2xAfbJ+/3wKe
	DCTt2eA/gBiQzXAVJl2dEbmsHFpNAS05E7507zx8SUSaLDBLpNmHJHuhg==
X-ME-Sender: <xms:6BmrZb-QOb74o2tsJVdk8-a0QK3OUR9YYEQKu4vJQJD6wW2bKsJhbg>
    <xme:6BmrZXtXmBCGJDsK_dRR03ik1fqXmWD1gq-D6cQfRIeM96MbcOZerlEDBkWcYNWhH
    T8pCzHa_8C80mjxzE4>
X-ME-Received: <xmr:6BmrZZAZOjbM1gRNsZfXCDd2tYViNq-uTLSWhj_bDxDknQ6xXgSQgCxP43cQOxlvqgLbGxbXLH2ba-PDAL0jRnwfG_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:6BmrZXeuV__MEXxFbZSSX44W5Ppmmd00twSCKaRXsLUdRHLEoHAF7A>
    <xmx:6BmrZQP3C8OoCe9iB2y_MMrLEggBKU4Tg2_E3RmueaFziWW_BQpr4A>
    <xmx:6BmrZZl6r52CgY0wR-6M7vrQ3VWq2ZRHczckcNLU5mu1XWSVTAi26A>
    <xmx:6BmrZaXYel25zh202ZCZmEPQi89spGiMrG7aKkP-kZLjX-SAwdegHA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 19:55:04 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: forbid creating subvol qgroups
Date: Fri, 19 Jan 2024 16:55:58 -0800
Message-ID: <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705711967.git.boris@bur.io>
References: <cover.1705711967.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This leads to various races and it isn't helpful, because you can't
specify a subvol id when creating a subvol, so you can't be sure it
will be the right one. Any requirements on the automatic subvol can
be gratified by using a higher level qgroup and the inheritance
parameters of subvol creation.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 58e0c59bc4cd..3d476decde52 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3815,6 +3815,11 @@ static long btrfs_ioctl_qgroup_create(struct file *file, void __user *arg)
 		goto out;
 	}
 
+	if (sa->create && is_fstree(sa->qgroupid)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
-- 
2.43.0


