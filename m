Return-Path: <linux-btrfs+bounces-12157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F07A5A45D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 21:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514E23AEAA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6131DDC07;
	Mon, 10 Mar 2025 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="n+IdWUeP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nZlJ149V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6B1CAA6E
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637180; cv=none; b=EDyzfG+9cYyJPBfvf33F2XrW+9BVsgy3aC36NJVh15wGNhyDUl6mnuGRrqG99cKuYKOzsTYNxs78/vmwkX4m26I5HZDLcVh5rbepJ8flgQ7nInk95Zmy4tTLlNZ6dP8ERtQBIarjfNSUWFDPTOrMhqW2Lv8VdM6wiAeVQwfpTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637180; c=relaxed/simple;
	bh=+yVUME66WJo9jKM30Stv6JLdfUs2qDxSOroE6aRTUx0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BlVaDswHat4hH5PifWcfFY6B1voSyqJps3MOuAGTu9JHdkLVk1B4QxO90nsEAoPK2zLJSYSLCcDP7ulgWsbHFU2Iyez/KeXKh627MkZptZjUww+eP0+yt359MWYdgiy0SW5Byhsl095JiTkv/LfR0lk2PHScZpkv1QoN2xLMSD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=n+IdWUeP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nZlJ149V; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B14425401FB;
	Mon, 10 Mar 2025 16:06:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 16:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1741637177; x=1741723577; bh=lLYRqXrpyRdD5QpBXfakt
	RD+hq5g6el/FB5DBMajRFA=; b=n+IdWUePf9qAQ7mpMjCWeZR3SHFbf5Tj3+jtm
	mPPjTlXsAMHhRvn1r1abkBdwpvFQryGCWVBaOKVmxhHT4UGHWWYiApZQ6Z5vD2AI
	c2IQ7cquWmnBw2IVdn3fOwJ0Eo7Y4HC3Vu7r1AUbPiqnOAqBUlvyBVd6zF4BiQho
	EIoOKWxn2FS7MVVEBGv81dxfVTfxpHQ4ZBYHmIZqDTM17huN5IeERxajylwz0o9p
	WtQiFVpcMzUL3qzD/H07zzi90uX88k38ZrCK243VIc3Z6Ppp1bAKxa83sHswJxro
	7r97fCEisL5NcRJVgSJwMXFW3+7bZf/5YfbzvuqARjDHBZ36w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741637177; x=1741723577; bh=lLYRqXrpyRdD5QpBXfaktRD+hq5g6el/FB5
	DBMajRFA=; b=nZlJ149VZN/brbs/VotJV0d0FRTCeppoMCEbNmmesMb5AWM9ffK
	y49hKLsQJ/S2XO9gEQnuy36nvqFviduIM/NrTqwcUK8BAFLVAu4W7uTUjQFLrz3z
	SfVzDBOYzjKOWzzKfP1Ri3S6Bgor8yZFLyZTXioBSUpA6GUfVC0gSKBuqUMznNbD
	h4yJlAFsvDKgsMQQ0XL9XWuLYsh9BlOkgZvMxfp0lFeyb95SndZKYuautzY3ITKZ
	tCu6iRrnlbS/txeTu11TGz/AdDtAn1nXunyX+a5VQCyjbaGGGPC5wjsgepEw0BYl
	pA9Pz2M/VrP//PIli9GTniWsb1AS5Oby1KQ==
X-ME-Sender: <xms:OEbPZ7qafLdq-PUVTNwEXmbZBcrdrH132kY47MSOvZs4LrYUcZq29g>
    <xme:OEbPZ1oZf0oYzerEYkM-1F50c4xR31MdL0_exH_d8Pk4BVIO5ekYwf3fYAHJRqKdo
    X1hV7VfwRNdowIE2oQ>
X-ME-Received: <xmr:OEbPZ4P_PEsHCY3-q9PtMIKUeI_5rW8v8qSn-izhf5f2jmXp-zRwtKey4HCrZ0Bl9xc0_u-wfwByq80ebWFYqrn78OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceo
    sghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelff
    evleeifefgjeejieegkeduudetfeekffeftefhvdejveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidq
    sghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlh
    dqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:OUbPZ-7oL0JAikwQvj5eWJ98TG0P2P2buEaWVbp_BJWxPiBOGmQROg>
    <xmx:OUbPZ67FV5UOIFgkG1tbttyz3hX2owShXhAY91OLoLnEXNCGdYeupw>
    <xmx:OUbPZ2gbSBMKigeZhIRNQdfT60_6-7m4MNBopjiUm3Pvh5pPKhVk8w>
    <xmx:OUbPZ86s0OS5yKXpFimaYqF2cTNF3wIc0vcXnfMYtAmfiPbsBxXrRA>
    <xmx:OUbPZ6GaCCVsvHG5ixFGw2JE5AQYmmeMQz7lOVm8lmFs3BMVMIuaojru>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 16:06:16 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/5] btrfs: block_group refcounting fixes
Date: Mon, 10 Mar 2025 13:07:00 -0700
Message-ID: <cover.1741636986.git.boris@bur.io>
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
btrfs_mark_bg_unused.

I could imagine universally protecting bg_list's empty/not-empty nature
with a lock with smaller scope, but this is already the locking strategy
being used to synchronize reclaim/unused lists, so it seems reasonable
to just re-use it.

In addition, I attempted to simplify the refcounting logic in the
discard workfn, as the last time I fixed a bug in there, I made it far
too subtle. Hopefully this more explicit variant is easier to analyze in
the future.
--
Changelog
v2:
- fix mistaken placement of a btrfs_block_group put in the 2nd
  (locking) patch, when it ought to be in the 4th (ref-counting) patch.
- improve several commit messages with more details and using full
  function names instead of shorthand.
- add comments about over-paranoid locking.
- rename second patch to reflect that it is hardening rather than
  fixing any bugs.
- fix bad comment and variable names in btrfs_link_bg_list.


Boris Burkov (5):
  btrfs: fix bg refcount race in btrfs_create_pending_block_groups
  btrfs: harden bg->bg_list against list_del races
  btrfs: make discard_workfn block_group ref explicit
  btrfs: explicitly ref count block_group on new_bgs list
  btrfs: codify pattern for adding block_group to bg_list

 fs/btrfs/block-group.c | 57 +++++++++++++++++++++++++-----------------
 fs/btrfs/discard.c     | 34 ++++++++++++-------------
 fs/btrfs/extent-tree.c |  8 ++++++
 fs/btrfs/transaction.c | 13 ++++++++++
 4 files changed, 71 insertions(+), 41 deletions(-)

-- 
2.48.1


