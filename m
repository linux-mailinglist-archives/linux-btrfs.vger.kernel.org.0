Return-Path: <linux-btrfs+bounces-2937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7F86D268
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A95F287EA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287D7BAF0;
	Thu, 29 Feb 2024 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UwG+JGyb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CDqE4P+B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B37A129
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231747; cv=none; b=TUCmxWbPHTrIleiAYxpOfivWB98bSsZ7DWuP8fhF4Vm8O2xN2I3ZtK3BJnKn9pitSuTGzGfcdRYAo2H8/YcQwxo3kogwOacJFHvbTzfH6ewWfxQ2R54lC12RWqfHVHmdCcUJtmsySijY0BuQWOzOfufyx/tIZ451Yll3umaGVHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231747; c=relaxed/simple;
	bh=2f141CeyGb6LZHuFY6AJEpqChgD7yUgJ8np/y8pkn9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPdAKgNS3S4USVbTYLnVenNcCjvJ3u4JnjR0u4pXg8JgOP63kEaGVHnzdiykZJRhr8jMSWbJFsd/ybLH9PzAxf5EN1xZSMYwDj8UU1u2sxtVcdDgRX/76NMQc06C+ohWKK2sw6xL9980RZy8qFM6a75KfWzrQsjnTsO18IAQl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UwG+JGyb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CDqE4P+B; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id ED80732009FA;
	Thu, 29 Feb 2024 13:35:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 29 Feb 2024 13:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1709231744; x=
	1709318144; bh=nfr+1EojT87M7FndXT9axj3DAlpjly4PlDf8YDn4yrc=; b=U
	wG+JGybdRunx4Kgxc3/Ib8F2u2s7P/XIOHd3PNcd4S1KcEmw2SwiHDIcfcKGGJpk
	cDv1yCTsChn0IhANlVpdYq8Cs2G4WaY9twfsXfwX7kKe5GeF2nhuoTgsjNxMV/xu
	SO+MuwV6xItc3PKHJ5Ed+RwInGg4KvAZ2T5lNOaaOoTZseTNVOY2WQhs7VTcKX5d
	oGVK0tdYyCAqpMN+hoeUlIrzkFTRfM9De6V+dh7lnd0Zz/dZDPRMZUubnBfsaSor
	vYxVooJoPWPfD3R2NcZeYeOIOBDDshn8NqDbEqOn+5rWJe+hqUyRyRud3RgLOBOT
	uNalO8Wu79oGjdWomSKJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1709231744; x=1709318144; bh=nfr+1EojT87M7
	FndXT9axj3DAlpjly4PlDf8YDn4yrc=; b=CDqE4P+BtaUe7V4INqo845xIclDhg
	683CFUBqHxGlMkLv+VZr0RtInV29bKmK545bpvlcwKyTcFzJ/G0Lby4gppEIdFH/
	Q40a+vkiqVYHb06loNcssDOFNi7NcbkL/W+dgSgI7VL4jwQzcrXNc+HIoIuVP17+
	/bkC17wEhl2a5UjwN+2o7aYL7yx5fh5f+JDUIofmwiNhfnBUaZI7+D/1ziN1npgx
	qeUtETcz6kPz7S5jpddkrXaeC2/0TG7iUZnvHI7V63IoGyu/uf4MVIwFvSVmNb0n
	3sMeuTZJNwV8w7WecCtDOEP8h6kE6tXEA/rOyLWN4YrACzk96/VCRVvYw==
X-ME-Sender: <xms:gM7gZVpjuVPF0AH0WjZx5Q_GckmQFKUkE3xSS_LGUTpRYabseha4cQ>
    <xme:gM7gZXpFICB_brkX9LhJAeLOjnHNfHRYP1Fyinj0HsgzXtyIAFmzJAlyLgz0IF4uz
    9YHizn5KIuVNHYpHDc>
X-ME-Received: <xmr:gM7gZSOJAXyqxxdT8Z3bqCWTCxeoxle3j5ipdEBC0VeUts-w7SCi4Py7OT4c_i1P_uwLfqBZT4B9Yi6ocndcSbrVqiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:gM7gZQ5CBDnZ-uck45DPLK7ViOXXnYksVEWwFKmRfv5tTGKx24j-QQ>
    <xmx:gM7gZU54VF-iuCoApPO0mWRV56EFu1kR4DZxnGZMg62Spuf_oeODjw>
    <xmx:gM7gZYjp24f5_XUJS8A1qzsGuvrl14sA78SFG1QwFi52Qt3FyXeWCw>
    <xmx:gM7gZZiHu6ffNc-gSM9GbzjqL_a32lGF2fsl5KB65ST3kefk0tT6KQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:35:43 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 1/2] btrfs-progs: allow btrfs device scan -u on dead dev
Date: Thu, 29 Feb 2024 10:36:54 -0800
Message-ID: <a53859401bc98e7266808ecfa32af54d7ea43851.1709231441.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709231441.git.boris@bur.io>
References: <cover.1709231441.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a device has been removed from the system, it lingers on in the btrfs
stale device cache. It is useful to be able to forget it, so allow that
by not checking for the file being a proper device file for the forget
path. Kernels that don't handle dead devices by name will do a devt
lookup which will fail, if there is no device, so this isn't a strictly
necessary check, so this isn't a strictly necessary check, so this isn't
a strictly necessary check.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmds/device.c b/cmds/device.c
index 4b34300b5..d52bde2e3 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -487,7 +487,7 @@ static int cmd_device_scan(const struct cmd_struct *cmd, int argc, char **argv)
 	for( i = devstart ; i < argc ; i++ ){
 		char *path;
 
-		if (path_is_block_device(argv[i]) != 1) {
+		if (!forget && path_is_block_device(argv[i]) != 1) {
 			error("not a block device: %s", argv[i]);
 			ret = 1;
 			goto out;
-- 
2.43.0


