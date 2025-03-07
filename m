Return-Path: <linux-btrfs+bounces-12071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A3A55BFD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 01:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317AF189E2C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 00:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888D2944E;
	Fri,  7 Mar 2025 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Ma0ciYP3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nqeKCpY8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437F610B
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307295; cv=none; b=U7qMwj0VhfM8ZHr+XcRjGs+wbOGjhnQHuHV40/tisXawAmPA9PQjRjSAGpCJdjkhByvFkJKYRDX9K2GvMtuXKvj0MxGSpHSMiqfk8UzjG8MP0aikezoUkjUp8FOfclhZXi5O7b4Y5rdkNzUHGSy3BjjDvNX2hDico9SnZa43YRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307295; c=relaxed/simple;
	bh=NFyEo1vl1zBbplyb7AELELs8HueOUee7lHp5WsKcpqs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=l9+dKf4UDeb6W6G09wmwz24fL4Kx336gc3OHIpZfmh2bw04gS+cdShFXJGwTb253B11mHCA9hKzdFF8TC1oB2E0nXThW+Y7K6ScC7WBJnpJbbHfykLh3r3nLKqaSXJnKoVCdcyzopeRszy+DkQ4tPxkZkhUMnWzxfQ8cvIp5Uf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Ma0ciYP3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nqeKCpY8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 890D513814FA;
	Thu,  6 Mar 2025 19:28:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 06 Mar 2025 19:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1741307291; x=1741393691; bh=5HhhSbv26Z6PEaHpmwo11
	RoVFJFB8w7ty8gfnbYi+Yc=; b=Ma0ciYP3wEunkceGEEK3qVX9OVwHf+yoAN6cy
	qyq7e7DgYjJREqkFmgrcAxTc/PR3gxIt/bMVqUxFNFLD5JAx38mjlSj18kC1aKxS
	S9JmEKTMVBlG4Ht+7smCbZfpHSr4qPP+eWc2iYSKdhItmMZhfGdTc/JydfpQk6Cc
	dlDKnsPYodcurL67vbV5ZhY6c5Ksz3hSpt9Ouqf8tQxYwW1JjANZ5SmFfNX84Vfk
	1gSrIUDyHbOlkvl4qZW+lJGt/iWrMpJxcMPF2JeIPyLxuSOU/kE+7CYjWXNkiknG
	SwvE/ifUppliWD/cCaKg3k5VsvfLLCOcwG34PL2d0qdyqKqDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741307291; x=1741393691; bh=5HhhSbv26Z6PEaHpmwo11RoVFJFB8w7ty8g
	fnbYi+Yc=; b=nqeKCpY8b8eqZDF/FK6PcbT3iykt+t+c19ybxut68zqQEYkYSp2
	5cJe9kqpGQvfks8GTvkmsoI98P+3qxv7beBJBCd/0quotEWlTgRjXJoupqfjpQYD
	VXelQQyEy7cxMuyQg2RV97DJPF2E26ewXtD5/5XNZMfh8tLe3LXbjQedb4CFoLC6
	NVqcOX6Mpj+ctnxXTTS/MBWMpaBvGIdX6fFjVAQ7zVRbvPJYw2qVsLV84XMvFCw1
	y8fYXXe65efGAmtJGPauaUrvaKu4H3mc8brSPKiR9H/kFYLGhX/8pkaxC0+P1NWB
	5bsVRv4guFBKK4Xwk29C8fF5S2eNRTSstHw==
X-ME-Sender: <xms:mz3KZzPvPjozKAiCl3iy7J2aMZR5XQ2QQDaecvrPa1o1vQY7kxt8vQ>
    <xme:mz3KZ9_GrVw7Ug2REh9fsvysk9OEG4yOfRbX9dfvCpEkJ_BpyLhZbhbJpa-czd0N6
    hobPSfxTzpvDBc8cpU>
X-ME-Received: <xmr:mz3KZyRfnkV5TCXkUxS22ANmRoh-hfgiMldx29G7O2t-jF8Mm3u-axhxKzm4sb_M0PYpC-oaCJN80eMXw7BkqcGVMnI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdelvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:mz3KZ3tG_B94U2H_JC694QeWPnmSHHLDfZLisNDVYmwoPv-Ea0AdqA>
    <xmx:mz3KZ7dIZCVB1YS07CVCTeOGzZNn1iBlmmNf-n2dGSSmou0FtDd-Bg>
    <xmx:mz3KZz38oUCUJ9NFeyY9Ab9mu4DEJ0y2p38Yv4SabH8aCi0tezVUzg>
    <xmx:mz3KZ3_FcO4FxU2z-hLo5HGjNUdQD3jslSWJRdPO4g7DF6OEJ7X_2Q>
    <xmx:mz3KZ8oVVQMUJHc1LtOkw5TjYzsVlIqfEvTj5a51wbKslHwylYfdO1nt>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 19:28:10 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/5] btrfs: block_group refcounting fixes
Date: Thu,  6 Mar 2025 16:29:00 -0800
Message-ID: <cover.1741306938.git.boris@bur.io>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have observed a number of WARNINGs in the Meta fleet which are the
result of a block_group refcount underflowing. The refcount error
can happen at any point in the block group's lifetime, so it is hard to
conclude that we have reproduced/fixed all the bugs, I believe I have
found a few here that will hopefully improve things.

The main thrust of this patch series is that we need to take the
fs_info->unused_bgs_lock spin lock when modifying the bg_list of a
block_group. There are a number of code paths where we atomically check
that list_head for emptiness and then add/del get/put appropriately.
If any other thread messes with it in between without locking, then that
logic gets messed up. This is most obviously evident with
mark_bg_unused.

I could imagine universally protecting bg_list's empty/not-empty nature
with a lock with smaller scope, but this is already the locking strategy
being used to synchronize reclaim/unused lists, so it seems reasonable
to just re-use it.

In addition, I attempted to simplify the refcounting logic in the
discard workfn, as the last time I fixed a bug in there, I made it far
too subtle. Hopefully this more explicit variant is easier to analyze in
the future.

Boris Burkov (5):
  btrfs: fix bg refcount race in btrfs_create_pending_block_groups
  btrfs: fix bg->bg_list list_del refcount races
  btrfs: make discard_workfn block_group ref explicit
  btrfs: explicitly ref count block_group on new_bgs list
  btrfs: codify pattern for adding block_group to bg_list

 fs/btrfs/block-group.c | 57 +++++++++++++++++++++++++-----------------
 fs/btrfs/discard.c     | 34 ++++++++++++-------------
 fs/btrfs/extent-tree.c |  3 +++
 fs/btrfs/transaction.c |  5 ++++
 4 files changed, 58 insertions(+), 41 deletions(-)

-- 
2.48.1


