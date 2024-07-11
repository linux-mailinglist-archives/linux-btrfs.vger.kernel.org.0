Return-Path: <linux-btrfs+bounces-6399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0A892F103
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AB282F85
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF3419F482;
	Thu, 11 Jul 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="IxJNvxHW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZX47ZJBU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D046155741
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 21:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732777; cv=none; b=M1tQtgpRHxRyKQXvxUslkGdlJ7w8xc7FbqZVyYZ6Mgymfpl15W0ZxMKjgJ57NPsRG38FFuCdzT5m1Po3oOFJ3MgjBvQnj/hYC/tX/12kt31LzR++pwiJKX4IA1C5eVGi4o44SiKxBOgumFS7MQlJvg0zmvkQ+/ypFiM7GMQepVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732777; c=relaxed/simple;
	bh=8OEDEPgbNeVFLf9igIxuMwsP4LR9Lp58VHgnHBDC/aE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VL4V0WSggcJKKmM1EixzmFHcxzPG5tzpM3/mDILS7GP4y91wYrmjP4sZqSZs59BoihbrU1RcoUT1bWIio6gxwEQ8t0SdYBl9uMjjAFo3jrByX6w7fKn5XbrgRBaHVO/iRYw2a5IXv5HTXaplBWOAuorXSNuLwIvGhaAAQOCu1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=IxJNvxHW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZX47ZJBU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2F018138844A;
	Thu, 11 Jul 2024 17:19:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Jul 2024 17:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1720732774; x=1720819174; bh=L2EhoGMtj9BW1ndj1UI9G
	Tt9SuUTXqLYEeYHAGXus0U=; b=IxJNvxHWyWNeC1rRE5ia5CxDnIfxcn2A6xmiV
	9idHkNDE6xfJWdGxt18u0oNw88JPHaW+3n6vGWZ4JO4LA8Ae0XfJhHtxaPbIa07M
	vrrcJTLlAAarozLSOS8OWiUKGWmgzNThCGZ3rpnQTf2iNmsAkFI5DGt6dO8PPCgz
	42mq5C3cjbKgvAkXbqwjcMvILcPS9rKj5O3boYVYVLRY6WjDOdvB8wpvO6nE9pWr
	ix23MGH07unHe7QKCmN8OEN8HegXJne2uinLa6MQ8GTFxRiElagJW72CwNUbECci
	vK45yD1rSUuEy8Fxk8jX2ZnJiQeFwX/2S2HzYMaFng1NNwADw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720732774; x=1720819174; bh=L2EhoGMtj9BW1ndj1UI9GTt9SuUT
	XqLYEeYHAGXus0U=; b=ZX47ZJBUI1Sbi+gf7JrZtQ+nZyvmUd5BVkus69XvQ6LY
	Cg7o00lssezyhsQeuIy0464MAl2Hr5RP1s/WfK5lzYz2L+MDVNAwryj1/ydsnsbW
	XGzl8w+2l0xmpNQx7e88ZAZR0L0KTtmNlwdsoZCwp82GYLVb9o/OJWl1r5S/gGFM
	txm5q+ZbBCypAEmRUmkH13lIu8zNkQf5JmimOjaqsSLsb/BFk6lX8HmkenBrYzRI
	cewrA/JwvFzc9i5fn/ju11NoU1auNw80OFDjXpjbXvciCIlbtoazVoVS1c2KACIq
	IDH1z3wsom4adl7AMWSF2I7wVPV5m/QbQO63HVm6fg==
X-ME-Sender: <xms:ZUyQZnrmuS3Yo16l825-NpgT56aH10ZyhBDefoYJ-OJAydOluBPQcA>
    <xme:ZUyQZhrapgkdLCuGWhgwhJfTuNhJb15BYHV0EBFliu8XNXXeT2vcTgFW768OFXAuu
    vgKK0nDskD-D6Xi2Io>
X-ME-Received: <xmr:ZUyQZkORVperMdcxFXeBiKc4sMSNrfB3OyG7htp4i2x9mq53s-ycWZjAXpP89K-EJGW1J6mO9MCuRjk81HPFjEDgC90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:ZUyQZq53BX9jlcCLz_ljIe1fO2z6ItI5rdb7FuJLDcMA1eYF5XlQ4g>
    <xmx:ZUyQZm4NhnMyVRhCEKZ5EriE0fpot-3-cUXdN2OEJOrmHDfrY1M81Q>
    <xmx:ZUyQZigoc-YNBLvL0iIsOwknk7i9PuM0TC3KN_X5nzsM7qJa3GiD-g>
    <xmx:ZUyQZo6ambxv5vx16-f9k_RVk3iJuYKUU-Xvy1ja3qWbSgwyWR6EHw>
    <xmx:ZkyQZmEaUCbX2sTVtCBUVJjEeIwbXNN6altWzWrgqZxuLKnb93SqFmdB>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 17:19:32 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/3] btrfs-progs: btrfstune --remove-simple-quota
Date: Thu, 11 Jul 2024 14:18:21 -0700
Message-ID: <cover.1720732480.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be able to nuke simple quotas entirely if you decide you don't want
them (and especially the OWNER_REFs) in your filesystem after all.

If you run
btrfstune --remove-simple-quota <dev>
on an unmounted filesystem, it will be as if simple quotas never existed
on that filesystem.

Boris Burkov (3):
  btrfs-progs: add a helper for clearing all the items in a tree
  btrfs-progs: btrfstune: fix documentation for --enable-simple-quota
  btrfs-progs: btrfstune: add ability to remove squotas

 kernel-shared/disk-io.c                       |  39 +++++
 kernel-shared/disk-io.h                       |   2 +
 kernel-shared/free-space-tree.c               |  42 +----
 .../065-btrfstune-simple-quota/test.sh        |  33 ++++
 tune/main.c                                   |  18 +-
 tune/quota.c                                  | 160 ++++++++++++++++++
 tune/tune.h                                   |   1 +
 7 files changed, 253 insertions(+), 42 deletions(-)
 create mode 100755 tests/misc-tests/065-btrfstune-simple-quota/test.sh

-- 
2.45.2


