Return-Path: <linux-btrfs+bounces-2659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F65860BC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690E21F2529F
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 08:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C118027;
	Fri, 23 Feb 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmld1Apk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB72179AA
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675721; cv=none; b=o1LHxmLN7aAC0OGsRll/2ojd8MRaEPt0M3CuSHzXyWo7wzLdF7snqHyYcWEE0frFyNwsik9h5CLrJWgrqttUJq+I745oBl80r6/VRSrDJo96Fhaq8zljqt0JAtiYw1qa47TTwS0t+eFjjjYc224iA9kLKWvcu6qdViqb7t3YJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675721; c=relaxed/simple;
	bh=fjBMu4ERt4Lx9BKS2h0pK9JPmh9N1D0v2ROu0z44lrg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=MuqDyZdibBtfVobcD0myd2GscgoZIpaOdqmxXkEOR8zgxzI+2J3C/Ud+yVPcUoAzjE/DOjfPEBei6qwC3fpJh11iuU1oEdDr/1s59+NkP+1luoXEua4qcLbkvLoLElyCJDeN8wQJB8rEXGaqMdtD1ARpN6GvYF2jZJKmSoTQV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmld1Apk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D566CC433C7
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675720;
	bh=fjBMu4ERt4Lx9BKS2h0pK9JPmh9N1D0v2ROu0z44lrg=;
	h=From:To:Subject:Date:From;
	b=cmld1ApktFBT6obWrfUn3lr034mJXiHZD1dZJ4APVeLc9yGcNboR8yRBuyn1fKuiF
	 aRmCY3U1jBaJWfjxxDrj741a9lTO2fRFcTeCARqahtxs8eZd2mwZWh2/QWBREFwSc4
	 25jYvdcZZcpcgTCua2jh1jgb0dGuUouYxH71V7IIuTEbS4TgU3hbOsTa/rfD3BVLnY
	 RBIhqkTDRlxeTi32qfmj+qSabDOMt/noQhFy8aZUDnHsOrAAKIYtTgWeVnXNbKw4l2
	 v7MKmrhvBJISwQKo0ss9DwgmyX79xhqoCIrW383lpsbJ7Fi2ld2InJVyKPA9rVgJ6z
	 D4KaYGfgPcM8Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: some fiemap fixes
Date: Fri, 23 Feb 2024 08:08:30 +0000
Message-Id: <cover.1708635463.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's a recent regression with fiemap due to a fix for a deadlock between
fiemap and memory mapped writes when the fiemap buffer is memory mapped to
the same file range, which leads to a race triggering a warning and making
fiemap fail. Plus one more long standing race when using FIEMAP_FLAG_SYNC.
Details in the change logs.

Filipe Manana (2):
  btrfs: fix race between ordered extent completion and fiemap
  btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given

 fs/btrfs/extent_io.c | 50 +++++++++++++++++++++++++++-----------------
 fs/btrfs/inode.c     | 22 ++++++++++++++++++-
 2 files changed, 52 insertions(+), 20 deletions(-)

-- 
2.40.1


