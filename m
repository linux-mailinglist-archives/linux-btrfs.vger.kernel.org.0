Return-Path: <linux-btrfs+bounces-2079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C67847D0B
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 00:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE0286353
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 23:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2BC12D751;
	Fri,  2 Feb 2024 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="c9/TP22R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQVGXPix"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7D12C7FB
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915468; cv=none; b=oIwOIu1kd5NxDb0l/QWrsB++NLfslADV1hvh2IZpz37FCNABuKK43S1+eXOEiGG2TUW74KxXROoHBY+oiGrmaiYGV4t5uSKlDA/So8rws6TTRJKk7R+MsGyp3OsE36PuL205UIuLwhjZN4F9PbFrv+6LyrLRRqirlARpymSIFKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915468; c=relaxed/simple;
	bh=+tmXvPGFvTenTJA36UobWNmOaWF2MIPR3VMENv0fAA8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hvGhK5xYPP563Q4+JZYN4phJo7aa8uPWENdlu2evCqYQuJYDydX18fwUWn+kHWAv7kb4IZizonhGxTgmhwCsS1FKiZlF36h6ljZyRW4PenzVFeQVgCk158/duH8obwUbSG6MTBn3ys7rEVCkGypyslT3O1O9kuaC8Cu2GjD/enE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=c9/TP22R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bQVGXPix; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 2D1683200AC9;
	Fri,  2 Feb 2024 18:11:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Feb 2024 18:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1706915463; x=1707001863; bh=kdKu/cRpJ/KeF9AZk6tKl
	RWknL6tblga0q32ctSyTn4=; b=c9/TP22Rc62UZARPBOOyWXOVv23CSGoNEzBTA
	6V3M53zFBL9XgoHas05Ux9hhY1NWGWJ0f5WyOVpDiQ0l2SGuHA2yDDh1KDFNFEEh
	rWkb7tU4sQrD93lSdoIfrtOXW1BMiDwAs7KQ6mpF1Tj1qkdh2Nd2HORUGxJzt8QV
	YE+EuEQQCILbZ8kXob0owpp0LBFmTqIaM+eP21lqkdZHWj/3i3gFF7QRmIc2kV8k
	TMSVUC+XGGUnOgu7E1UP0bE1dG3wpcXFEwddGjMpUcWPKdBqdzaNxRBmqM0TWJJm
	fAWEYkCMn78I0noqTfRapKZwzp7HsZcLImexqZ71/2RuCq9dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706915463; x=1707001863; bh=kdKu/cRpJ/KeF9AZk6tKlRWknL6t
	blga0q32ctSyTn4=; b=bQVGXPixvBfOwkFj8b9EknKCHjJ8Z/5X4Q4w8X1N4Ydk
	3K6EOeimTQFR1cOtYazJJFwu9MQznO/H2K2xNNAKZPX5Y6waNJQOnd57X4r8Ghb0
	McRrR/eMizDNeq09hCZcOYbyRZyrSeGBulQqfBkaxC3F9uC9k4NZMIaDN5PbdEhk
	HZwmjXBRWiDaGiCmfGPCnG+w9g+nLFqLIGiFcAmrSLQLYQhHi3x4GknLG1hzwPlf
	eeFpmh1RYo6tevra1nrVpwiN27cGznMzsHiXiIHHkJ6TnUEYyUDn6fW1SeM3VRWL
	1SKwu8ugv2G7SqTRPMhJFNxJBJpU8p2n3SmLtXdv8Q==
X-ME-Sender: <xms:h3a9ZTPlzH673M3SAoq9Ym8ieleUpwR8t3dqDFSBO4jIz_hdngmS3w>
    <xme:h3a9Zd-EI-DOzTeXoArJAQmW9yj_JrlvrUpAqQOcfcIc1FBc_o-niNrht0_lz0GJT
    7LgQyjL6eBXJ6Ow6vo>
X-ME-Received: <xmr:h3a9ZSRFdC8de4ikuMLt4bAuE2u6JFdL9t4p4V1e_PfabAy0athLm_a679C4hVf7FKhDfI-tpDcIANcScb652-D_zio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduhedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeehudehieelvdekgfduleeggfekveelteethffhudfgie
    elueeuteefkeelteefffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdgsuhhrrdhi
    ohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:h3a9ZXs0s-TKsN5cZnx7OaDkmbqsaARGrLGokSmYoEjw2I5Y23QxhQ>
    <xmx:h3a9ZbeeG6kC54US8e9aXSDWQRO-WRTajlwL34WqZa0aOscH2jzTpw>
    <xmx:h3a9ZT2a9VSpIS9UPlYDRZbv8d1DHI_MXuMifCLdttrolVb-mqb8Rw>
    <xmx:h3a9Zblib9fGzdGkF6bTUEXhiVFtlPI30K27WHaWQzGjAyXCFG-gmQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 18:11:02 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [RFC PATCH 0/6] btrfs: dynamic and periodic block_group reclaim
Date: Fri,  2 Feb 2024 15:12:42 -0800
Message-ID: <cover.1706914865.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
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

Neither of these enjoy widespread use, as far as I know, though the
former is used at scale at Meta with good results.

This patch set expands on automatic reclaim, adding the ability to set a
dynamic reclaim threshold that appropriately scales with the global file
system allocation conditions as well as periodic reclaim which runs that
reclaim sweep in the cleaner thread. Together, I believe they constitute
a robust and general automatic reclaim system that should avoid
unfortunate read only filesystems in all but extreme conditions, where
space is running quite low anyway and failure is more reasonable.

I ran it on three workloads (described in detail on the dynamic reclaim
patch) but they are:
1. bounce allocations around X% full.
2. fill up all the way and introduce full fragmentation.
3. write in a fragmented way until the filesystem is just about full.
script can be found here:
https://github.com/boryas/scripts/tree/main/fio/reclaim

The important results can be seen here (full results explorable at
bur.io/dyn-rec/)

bounce at 30%, much higher relocations with a fixed threshold:
https://bur.io/dyn-rec/bounce-30/relocs.png

hard 30% fragmentation, dynamic actually reclaims, relocs not crazy:
https://bur.io/dyn-rec/strict_frag-30/unalloc_bytes.png
https://bur.io/dyn-rec/strict_frag-30/relocs.png

fill it all the way up, not crazy churn, but saving a buffer:
https://bur.io/dyn-rec/last_gig/unalloc_bytes.png
https://bur.io/dyn-rec/last_gig/relocs.png
https://bur.io/dyn-rec/last_gig/thresh.png

Boris Burkov (6):
  btrfs: report reclaim count in sysfs
  btrfs: store fs_info on space_info
  btrfs: dynamic block_group reclaim threshold
  btrfs: periodic block_group reclaim
  btrfs: urgent periodic reclaim pass
  btrfs: prevent pathological periodic reclaim loops

 fs/btrfs/block-group.c |  26 ++++---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/space-info.c  | 165 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  28 +++++++
 fs/btrfs/sysfs.c       |  79 +++++++++++++++++++-
 5 files changed, 289 insertions(+), 10 deletions(-)

-- 
2.43.0


