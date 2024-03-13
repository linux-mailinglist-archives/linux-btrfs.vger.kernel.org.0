Return-Path: <linux-btrfs+bounces-3265-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC5787B557
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 00:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADBAB225FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E285DF2E;
	Wed, 13 Mar 2024 23:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="mBZ7dqGl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVjRrVdA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60F5D737;
	Wed, 13 Mar 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710373547; cv=none; b=EZM2jMqeDv6DHWRD38HD/yptdjGVYd0cr7ZPwTAHlS2WmTaszdqK5sTL82WibNAuXhGOjUXphaWYaeBCPPak0DUVyLCrxrz6JZ8d67YIcb4blOrl8nhDhbkfuHY2oApK+xxEEyWknZiYtILd5/4mDsqvGEQshjm+Fn2qijTePXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710373547; c=relaxed/simple;
	bh=h8mkPzgnUX3IlR3a9lyuvcU4083TWa66XLGY20iJxN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VChqfBBpKXqcgywW7LjvU46y0QoA71UkqJNFnhr8YPPQIXuN2KWzRnnhMPGa57jj9aikggVG6BeNAJ9AVT/NzD7S67zA0fxjbEpeRRYWuMHkuxLwERKl929fpD5hRTZ+D9CAM0BKcIuZoBdb4VSsQMB6Ke8W6/vAIxTu1TA3LEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=mBZ7dqGl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVjRrVdA; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 7A4A83200A03;
	Wed, 13 Mar 2024 19:45:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 13 Mar 2024 19:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710373543; x=
	1710459943; bh=qZRq43HuXV4GvR/pKfp6PYP8FDdhdxiHnx7aNK/TrtU=; b=m
	BZ7dqGlTy54j6ZXb+vM3tRlzLX+pQTcWEM1JU4nXFZXXwGwdkLKyEf3V/MkWERQE
	ycPRPErj9U5v6JCsgdusYQ8d7ioIzsedK/IAqNTCuZWW5vZ2xo+KRv1bBgVn0r+Y
	FDTOLuGCmDFcO9UmxmMmp9F1Lgze4WlPlCGCJ1EWVL6tpwM78M/8rPoqr2lufDkr
	nBTLaTLllZpNuK4GTVyq/U4Cs0kMmUgZpbz3LBVk7osgeqdh1ZGyGHjun39jGfAj
	I+TBedQERJBhJeWoXUireQo9jjtZz64d6oTgvbM5ihuGoa2+rLpTzJVQIM+g0GzO
	mJ6o2eegRCq0B1WA3Wbug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1710373543; x=1710459943; bh=qZRq43HuXV4Gv
	R/pKfp6PYP8FDdhdxiHnx7aNK/TrtU=; b=dVjRrVdA0qoIzitJ4a9QemKSkZr7U
	hF+ReAK9NLpz15MQw3e5L8v7SaQqmkW552ia3WK1toI161vRYQ9wTUCJem3clOPT
	KlEHU8SeckLkDc8NwrZq6EHTgdEeEzUvZ2ZmuONK3hzywabbdSvwM28IAAahpvdz
	usdKkNrBs2hrJGhFRjbSJ9IR6qgXM3jdWCg4fspukn7imebZ44J9/xg0LDNWrms+
	uqcJz/+ZUGJw52ZsX5LwbE4pxlXs14eP+YnG8Msl/QNFuA6lH2sd3evCkxzfK0bD
	f7JwnsdSviM8BzxpVNAe1eJ2BZtM2+KHQn9Mi4vAL8Ma5Yumfn0UYlozw==
X-ME-Sender: <xms:pzryZcHVpDL8BiMaJLl2aJtD-CUXCySP1zINoMbn9PVnVar62JxXOQ>
    <xme:pzryZVWFHFyC31D6iY49RkobsttzbGef7eJs0QpQQPhkX6icdFaJuVnkL509BCHNA
    IwM2WDzjO7wg6j_zqg>
X-ME-Received: <xmr:pzryZWJ7q2_wQK3d1esPS7gqQ-6qzMtPaBD27P8AFaXyqnowatanTsMZlAr6su2hTOyCt06JHav6TkqNTH26lPU7D4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:pzryZeEAGZx7aajJhbGFxHBnNCZfpBSjUUGSwOEG2zQxSuMTfA_1Ow>
    <xmx:pzryZSVKHxc3C5ZdYA_jy6WtXj1zuS0g-uCKOr69tG0HlrtsMtcc3g>
    <xmx:pzryZRNs8uV7ZgLPz5Aj-nC32iL6m1SBt4nBOyY9kZs6m2uDf3f84A>
    <xmx:pzryZZ2nckPFb46dghpKss9nd5uFHG42rp4yjDDWnhgWt_CYIb6g2A>
    <xmx:pzryZfiWOdnKviVGh234WNMuvT2JMnXMEE_tbGAm_-oMXajBnh7MLg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Mar 2024 19:45:43 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/316: use rescan wrapper
Date: Wed, 13 Mar 2024 16:46:30 -0700
Message-ID: <5c2dd52fecbc5ac86068a725875882e3000bc969.1710373423.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
References: <3528774789271f9e46918f8b1d1461dad0e11cc4.1710373423.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs/316 is broken on the squota configuration because it uses a raw
rescan call which fails, instead of using the rescan wrapper. The test
passes with squota, so run it (instead of requiring rescan) though I
suspect it isn't the most meaningful test.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/316 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/316 b/tests/btrfs/316
index 07a94334a..36fcad7f8 100755
--- a/tests/btrfs/316
+++ b/tests/btrfs/316
@@ -24,7 +24,8 @@ _scratch_mkfs >> $seqres.full
 _scratch_mount
 
 $BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
-$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+#$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 $BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
-- 
2.43.0


