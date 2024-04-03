Return-Path: <linux-btrfs+bounces-3886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39016897917
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F8E1F21D94
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6499155314;
	Wed,  3 Apr 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VVqv4DtN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SNl7bIDv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33611401C
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173030; cv=none; b=CYahja2AQje1dRzzVdp2VX3fV/Afco0fodT/wMMbNnEQuGzLT4f5WufG3WtTXUPdv3YZ97Rk9RFHOYKNL9nHFUP3beYKO+ZGGfAFbZh/XsR3+DyBOfOtARUrMCdz9AHxDc+0+Nm2fFcrQSZvJPvyoy0FaP1uL7Cm0TQGvULO6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173030; c=relaxed/simple;
	bh=7Z7mizBUrnFk6TUAKpQv8gjpHHow7redeLNb7XBD8gk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mO+501oo7fJnZmQe+fyGPbP6Ni8mIAQwlxL7czf/38XShv2AnB/yBHpJoTu06pf79+hQcJh/kLfnhau5H2DblWF1AAg2qJM7C+uuAj8GS0tQGThgD0KCS3pPp844FP79Ev0jZzRNpPdx7ILFcvxJrRMFYJWHKcbsnxnDoz93mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VVqv4DtN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SNl7bIDv; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id B12A33200A4D;
	Wed,  3 Apr 2024 15:37:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 Apr 2024 15:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1712173026; x=1712259426; bh=C+ygCefgQgFYO0ZLEToY1
	PyocM0Qk5QsmBqkoy1q51Q=; b=VVqv4DtNlbEbU4AxvxVbuE52k6Y0PiV0+MCzY
	OoMAlgMf7Hrlpc4FzYwPoeY5DYRvAptySkkf+VibwfNDg5kLJUixa0p71f5Zbujf
	32ZzlGUwX2v9XWMji0+URElNQyNvYGOy9EEhPClm29C7eJYSTisXx5RhYw0Nk43j
	hhrWuFO2v324xrghUEc6ect2PEkN5IQlTuA7uyoURWkn8WOyApbHoH2flSozZqwI
	WyWG/tILXU9EuB9g8E5Lqpf2D/X7VokLyxH45PCWRszJjozIsJz3/cB13VmVQlnO
	U/hTOcwJvEln7D76rCtQmTRl1S5MAP7I9AbN13YaeggsCDkAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712173026; x=1712259426; bh=C+ygCefgQgFYO0ZLEToY1PyocM0Q
	k5QsmBqkoy1q51Q=; b=SNl7bIDv4PJ7N7eC2ztE33um5OS/Purzy9164iyZG9uG
	IFtnlh57RYlMe68dsVAgaoanAjGjj6G/ru/ltddXi+hk9769eETLezU7xX8lqUuN
	Ozj9pWZvrYFCBLRzUzqGxTxffL2ZOeDE0PJVzWB9QcdpeIC+UIF5wVN0VUoyYQNL
	Bwn122+nCbNFIwwvWg+BY/xcSUdLxfRcOy9xn+E2As/0adZp/+QbeXH4YA4zbErb
	qcODLWsoNwevXjdJ3p2GqpP2jL4OxC2nDW7h+vt3dU3fnItY26J9V3Bt6FOzkBEg
	N7sHYmHoe+010xtidEoBIqYNcD2wR6g+jSeNKkmsmg==
X-ME-Sender: <xms:4a8NZgQDJzod5LXTYCLNhnw0QRwiuKT7oF_ktlnKISOcqVUosQZTlg>
    <xme:4a8NZtz891ZGD4TCSMSymTzqvUqaIDxR5sqU5ghSuIreZSompBLh0HnE79bYq7B93
    DKDH5sIY3DTz1x8iW4>
X-ME-Received: <xmr:4a8NZt2p9K7f9ocEwln8YDw-8_dOvtvQ-yGDWwJieV84wIVqJbssJLf3A5hrh2l8kdLzyVa_d8elppdRzcxqFasVPSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehudehieelvdekgfduleeggfekveelteethffhudfgie
    elueeuteefkeelteefffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgsuhhrrdhi
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:4a8NZkBNaNFOjzBzqZPRJ8QqIu80lXK276JQu3kuH-zxwsK9qVfj2g>
    <xmx:4a8NZpgoFNJaTfnusQvKeFJFhvqvVHrFawdywR0svxHD4V7wWbnVUQ>
    <xmx:4a8NZgp1FEynJd_-ODD8VfMiWQPbuI9pmtRBG5OuYdrkkS4uvB-sYA>
    <xmx:4a8NZshissmUFyPVzwAXarMl6bYE2y-o-x04kDlN9Pu5WsbrOApsYg>
    <xmx:4q8NZsuwkpwbbYbhBJxNuM20X8Rc4l1SOwX0qXo4woj3ATYIuGTatx0ohYHd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 15:37:05 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/6] btrfs: dynamic and periodic block_group reclaim
Date: Wed,  3 Apr 2024 12:38:46 -0700
Message-ID: <cover.1712168477.git.boris@bur.io>
X-Mailer: git-send-email 2.44.0
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
 fs/btrfs/space-info.h  |  42 ++++++++
 fs/btrfs/sysfs.c       |  81 +++++++++++++-
 5 files changed, 383 insertions(+), 23 deletions(-)

-- 
2.44.0


