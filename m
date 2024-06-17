Return-Path: <linux-btrfs+bounces-5768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A945990BFA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 01:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53777283AD8
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8B1993AF;
	Mon, 17 Jun 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="woOahLpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHJyxFeu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3C3163A97
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665906; cv=none; b=lDz3hZJ1qRRPevVlB8T7dSZgtguz3we4Bj0ZthFUTjv0DoS29iJq7uL6uSOdHQs9V04UfKJIh7Jtfb89gfSd+HvFnxp3pcQvY7UFC6r8d+7NMkmlSEbcMeyo158UrjGXDmqjxkITsa0ckjditko2pTGlzkLk2y+xmffHbvl3aiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665906; c=relaxed/simple;
	bh=4FIsWpjVjzmbj51YIwKeZOdbjBIy8ifvecxfCIV7Azc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KlP4d7XiGw/SUIyrmR4yHxYM0wJ92RDdS67zFF8BorGOK75X3eFkZlkdT3/Kjcq3E+RoqRKGbkQ+OQi54kwNWaf8jBaDkm2sKHkWBKv5S8hM0vy0+4XMUVp6KMftPNpE0jGdPih8RracGSYxO5iqj2R+so2mjRBLBfY2lHn4ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=woOahLpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHJyxFeu; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 1D61B1C0010A;
	Mon, 17 Jun 2024 19:11:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 17 Jun 2024 19:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1718665902; x=1718752302; bh=PDfq+OXKZdmIbSme+DQju
	mmG+fCnJxwZb4cKPuQRKfg=; b=woOahLpXeodTiXiIZY5b45CWsVrIOgEHQ0lW0
	t3iRQPC7VxTqyBm67ME/5spuovM6FLOXfsvRGTAigK5Zg8BnK/YFOxNXDATSuXXN
	QKDb94wXEvOfD4BGVoscQTG3Xban/peWk1TT6pPtsBdNYBLVKQvfjF9k/r/YI1nl
	AtoA7lZ/IFMqtMi3+TxMLzUWtnm2kOhdhJ/HCL0ekav82vm1XbnlVilnF6xbbqxZ
	9OnMz9u6+ZU0D/Sm4D5T91ZeniEWPFCFVjJ3gpSxl9we5E75Tyxx07z6KsIkKKCT
	Dst/u5y99NcK4/idM1eY3oaHQ1M+u+4De+59N4Zb67quPT1uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718665902; x=1718752302; bh=PDfq+OXKZdmIbSme+DQjummG+fCn
	JxwZb4cKPuQRKfg=; b=fHJyxFeucuQt9VD4+KFIQCe/bTB+5nbut9h/lDwrBoE4
	cO/yP9j+p/9jE0CtJg2/OMYNQnqSqxvoOaigjssGLKX0Ax7boCetUw0ZCrRJK9Gm
	dymkwRnFXZvX43T7hCo+hCNUTDzNYj5TFMIxMScBWbvK3lZvLAbrlNlIY19+CWhM
	liuN/UT4lAds2jKyB/kQfkHUA0WIN7DM6ssCbHpgkycKgV6XAbOlt9mA2i2uR4A7
	ovKYtRBowOj8ax6GOelEFb/Z0c9IFhv4QIiJpaIXz+quazewpLdBkOG4qONYnD8J
	xklgD3vYHJ9Cu4cLGbgUfiyHQjenTEC95ItdPQK50A==
X-ME-Sender: <xms:rsJwZuYWVO-YkKGMIfXrRtvVJ5eZ6r_OCJIbideTxD6gUcDu6oj6cg>
    <xme:rsJwZhaAXksuJU1hLs5ehkjdQYTTR36ckIPCXfmGdBn1LnLlsoKj09EhEuVSJ7Mvf
    WgLEIvbeSyPlgXC_2A>
X-ME-Received: <xmr:rsJwZo-l-B0IqGF9zi9xtWsBSsaYLUrtfSMYgtQSE7dkOrvTgVioDxT6wy6aIIobwqzbVzHN_OG_30V_QyLN3isiPJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedviedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehudehieelvdekgfduleeggfekveelteethffhudfgie
    elueeuteefkeelteefffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgsuhhrrdhi
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:rsJwZgpkVA6T-8C6rY8-FHwyVZ2ZwxwFDuAWwxoS8Jh7coY3MxO2SQ>
    <xmx:rsJwZppYSw3eGmppdhknrw9IYXcJ8zl_d3udg2iiCoE6SmNIAL_w6g>
    <xmx:rsJwZuSxjRWMXJ-yUZwNG4CkRt1S9zUhzLdDAap1LbadOElFisASuQ>
    <xmx:rsJwZpon9aNaMCb3f0vFxEE2s9x27ezrHrb3mP4CX_FaI29RglSd8g>
    <xmx:rsJwZg0fy7N-XlbBPDxp1Hd591qOL_P7lPBftjeBpnTlyZEGDq9etak2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 19:11:42 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 0/6] btrfs: dynamic and periodic block_group reclaim
Date: Mon, 17 Jun 2024 16:11:12 -0700
Message-ID: <cover.1718665689.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs's block_group allocator suffers from a well known problem, that
it is capable of eagerly allocating too much space to either data or
metadata (most often data, absent bugs) and then later be unable to
allocate more space for the other, when needed. When data starves
metadata, this can extra painfully result in read only filesystems that
need careful manual balancing to fix.

This can be worked around by:
- enabling automatic reclaim
- periodically running balance

The latter is widely deployed via btrfsmaintenance
(https://github.com/kdave/btrfsmaintenance) and the former is used at
scale at Meta with good results. However, neither of those solutions is
perfect, as they both currently use a fixed threshold. A fixed threshold
is vulnerable to workloads that trigger high amounts of reclaim. This
has led to btrfsmaintenance setting very conservative thresholds of 5
and 10 percent of data block groups.
(https://github.com/kdave/btrfsmaintenance/commit/edbbfffe592f47c2849a8825f523e2ccc38b15f5)
At Meta, we deal with an elevated level of reclaim which would be
desirable to reduce.

This patch set expands on automatic reclaim, adding the ability to set a
dynamic reclaim threshold that appropriately scales with the global file
system allocation conditions as well as periodic reclaim which runs that
reclaim sweep in the cleaner thread. Together, I believe they constitute
a robust and general automatic reclaim system that should avoid
unfortunate read only filesystems in all but extreme conditions, where
space is running quite low anyway and failure is more reasonable.

At a very high level, the dynamic threshold's strategy is to set a fixed
target of unallocated block groups (10 block groups) and linearly scale
its aggression the further we are from that target. That way we do no
automatic reclaim until we actually press against the unallocated
target, allowing the allocator to gradually fill fragmented space with
new extents, but do claw back space after  workloads that use and free a
bunch of space, perhaps with fragmentation.

I ran it on three workloads (described in detail on the dynamic reclaim
patch) but they are:
1. bounce allocations around X% full.
2. fill up all the way and introduce full fragmentation.
3. write in a fragmented way until the filesystem is just about full.
script can be found here:
https://github.com/boryas/scripts/tree/main/fio/reclaim

The important results can be seen here (full results explorable at
https://bur.io/dyn-rec/)

bounce at 30%, higher relocations with a fixed threshold:
https://bur.io/dyn-rec/bounce/reclaims.png
https://bur.io/dyn-rec/bounce/reclaim_bytes.png
https://bur.io/dyn-rec/bounce/unalloc_bytes.png

hard 30% fragmentation, dynamic actually reclaims, relocs not crazy:
https://bur.io/dyn-rec/strict_frag/reclaims.png
https://bur.io/dyn-rec/strict_frag/reclaim_bytes.png
https://bur.io/dyn-rec/strict_frag/unalloc_bytes.png

fill it all the way up in a fragmented way, then keep making
allocations: 
https://bur.io/dyn-rec/last_gig/reclaims.png
https://bur.io/dyn-rec/last_gig/reclaim_bytes.png
https://bur.io/dyn-rec/last_gig/unalloc_bytes.png
--
Changelog:
v2:
- add reclaim errors counter
- refactor reclaim counter to remove extra else
- account for zone unusable in threshold calculation

Boris Burkov (6):
  btrfs: report reclaim stats in sysfs
  btrfs: store fs_info on space_info
  btrfs: dynamic block_group reclaim threshold
  btrfs: periodic block_group reclaim
  btrfs: prevent pathological periodic reclaim loops
  btrfs: urgent periodic reclaim pass

 fs/btrfs/block-group.c |  42 ++++++--
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/space-info.c  | 240 +++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/space-info.h  |  48 +++++++++
 fs/btrfs/sysfs.c       |  83 +++++++++++++-
 5 files changed, 391 insertions(+), 23 deletions(-)

-- 
2.45.2


