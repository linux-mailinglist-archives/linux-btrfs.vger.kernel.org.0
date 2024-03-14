Return-Path: <linux-btrfs+bounces-3316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4387C5D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 00:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF55BB21192
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Mar 2024 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D31DF78;
	Thu, 14 Mar 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="HzqX1bxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mNHdblT9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3C110A03
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Mar 2024 23:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458295; cv=none; b=DrfsiJkvdI3aF5pI9r71YquLVX5hWZQtUEJxyY4FKhiMXOS+AfxYC95hzo7/N6LP10sTkdeQAWZipx/pCjkcXKfWjj25PC2whbFJQLewjqnzdb5NnsScpFOZkjSP9ek6dQptErJ/6RxC+YXj9/JPdKPuagfYyImiWPB4z41KXJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458295; c=relaxed/simple;
	bh=tm144TbzTCibNrqKE5ho3t1rUAnEAJOi82ZFbsXZVV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h/uh3dSoD2cHNcJ9uq3v6h4bD9m10mzfuyvvFu/x7KGX+qBOOSaqQ1+/vSgrI7f+VmrVQn83DywoiwOTsu0Oni+FvS4APPTb8GA1THQFRGpuPP3BNdWBUWpFx0B/FRyHMEIronJ5DilTreEX1ZFQ7hZ/OeCCiRMr0PMcKD8vTzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=HzqX1bxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mNHdblT9; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 871EE32001FC;
	Thu, 14 Mar 2024 19:18:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Mar 2024 19:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1710458291; x=1710544691; bh=aDe9yeuQXU05n6Vl5li2e
	AHjwhZ72WOL4Z71OQUwQ0k=; b=HzqX1bxdeMOp72Xe8CPYF3TCxhe+gurjBVHID
	6ix99q7yx5nJlckWd5FFCSlWLcdHarx6LtiiH7ZFiA+VTUdzXEBJ+YKPb3hjJzDN
	vJPJoCih0z2hx9iibkYLHoqWniGGUKhb1U322XWbTX32ILQ8tqdAQV44HKcYvfOb
	c0YupV68QV64c0sxzCIGTwW9fnPr72agSm7nFj2+mx9IY/j/TvRMNCOHFpoHJMhA
	nGXk1jJiGBFbQaViyTbu51RbudfhMVZtZQ9JIaBF29NiYL7XJHPOKYHf+mcVhhRS
	wOeWChHLJLevwVtXSAB0ywA6JoXd0ULPzCs8177v6BBU09A0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710458291; x=1710544691; bh=aDe9yeuQXU05n6Vl5li2eAHjwhZ7
	2WOL4Z71OQUwQ0k=; b=mNHdblT9eYwi3LFtisWNSQ6x2IK6HoT9WhilxKM7B0FS
	jUGvTlkan/8b9z6UMQb72Y920WGAyvUttJudO0igh/bG8WH34NE5OuzFmVwECQ3D
	Sc7yS57aAFLusuzg0LVreLzrbGOVfL3JQs8c4XVpcO7wVK3uHdR83BicQ85t76Xd
	AqyOQLJUl+Zbv2+TcLWMug6W4DIeKhka/hywFYDTo92qoB5Xu5vSWS+GGMntqxLb
	C68R1mH/wgp/uO/F/JWmQtk/C7Yu5+43i91zwY9zO1PveyEKl8QtYPXXMktIbrfZ
	01BtM9c6FZ79n4UGpCr/g80bYWV+FM5Wi84zJW/Fiw==
X-ME-Sender: <xms:soXzZawlQTwNfX-9kDLLHEpgdLRfsADhmzPYzRhifRV05u6KQomTow>
    <xme:soXzZWSuG1o-lAmZqUmWL3Gi_8HcyV-zFVClop1KeacQReWaOFHYpJkK4nuwMUohX
    auQRM0yjUoI6FFGoeQ>
X-ME-Received: <xmr:soXzZcVwB7Dp-zfTNaSW1gPWxso7OwMnOfb-9fpn9BYr-YYSGs7uCMaSzzTSFZ-VRZfuxV3sbfJgBQ-QiaOHhz7lBLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:soXzZQhu-7JRGCk8k8xzu8VQ6KKhsXIT7V7FnJV9oWohaw-zte1yxQ>
    <xmx:soXzZcDNjLVKnHtIHv_8kEF8l2g5t8n_oGzHOWyVmJCMZrALPc94Mg>
    <xmx:soXzZRK3tHvRoRs8icLvMXMoXU0TSxck7XSL2ZOohNlnXkbFdj_v3A>
    <xmx:soXzZTCwodu16ySJfYb2_p_91MFLAzVOr_CMW8oSoQH_5sgWes01pg>
    <xmx:s4XzZV4yPzYC0jdNDreJYq6gwUJdI27-jBKhIgkGIyRuDLC8KKE7kA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 19:18:10 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs-progs: use EXPERIMENTAL instead of CONFIG_BTRFS_DEBUG
Date: Thu, 14 Mar 2024 16:19:00 -0700
Message-ID: <a3d01ef26525e9730f1d94de3d7c8e57f3c73fc7.1710458248.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

not sure exactly how this ifdef was supposed to work originally, but it
currently doesn't and I don't see other use cases of this pattern.

Use EXPERIMENTAL which does work after:

        ./configure --enable-experimental

Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/send.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-shared/send.h b/kernel-shared/send.h
index 34de60ff0..ce4a99e31 100644
--- a/kernel-shared/send.h
+++ b/kernel-shared/send.h
@@ -25,7 +25,7 @@
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 /* Conditional support for the upcoming protocol version. */
-#ifdef CONFIG_BTRFS_DEBUG
+#if EXPERIMENTAL
 #define BTRFS_SEND_STREAM_VERSION 3
 #else
 #define BTRFS_SEND_STREAM_VERSION 2
-- 
2.43.0


