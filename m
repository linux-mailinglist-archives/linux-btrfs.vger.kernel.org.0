Return-Path: <linux-btrfs+bounces-12724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D8A77EF8
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C5A16DEB4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3420AF99;
	Tue,  1 Apr 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeFJIS2v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EB2054E1
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521400; cv=none; b=CCFxQDD4VdeK2sy73ebGAd8OaVVfgF/Zyu6BGKC4Ax/mzJCUCNF/cm134ACI11nQCWxXoe+74X3/+29gGrFdGoAEt3+yEIWB3udELlcMqYeaAA19QWcHHWF1Ub7+QDt34T0x+SuX+ucJGGosbdvoglIV30SWNJudFSsD25iQuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521400; c=relaxed/simple;
	bh=uH/if8Gd8u2A40Tv7xGNRPVrQtFrDpn87RD0HAcLoMY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psHEOwaWhn7cSlFfVq8+VJMJeEngw0WhsKYMhZpxjxX5rMLh7zFMt6mFivm1KGTikGY0+Kd0Cbh4oO7+J6KZ6tgkhaeGGd8iHkmnDWfrHubI2QtmqQWWiSZ1+bt57AlGDwPwxyrNo7eUzNIWjF9TyWxO8ImZAo2xsjDXB5e7V9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeFJIS2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DD0C4CEE4
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743521397;
	bh=uH/if8Gd8u2A40Tv7xGNRPVrQtFrDpn87RD0HAcLoMY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UeFJIS2vtZjNbtuo9r0oMHnKozJuW3ceMW2de2JP0ZQ8oWxie0KJRNBJgLvqyic0E
	 PIn7L7jkaHyiWw/1hLEDNR3YANavLbMBlDrxFtRupSKdb6wGnGsT60CWs9VJSk3YZO
	 F1Yx39E9rhlswQFSHE5TrS76a8we500xi9LixO7X7JbhVZ7BOXqpdR40qj6gQB6q83
	 2IxXM9F6zRUMXrXHlY/rc7Pw1lQe+qK2rzaF/FI/op+0LWDKA6aW5zmLi65x517wCU
	 a8f+T8fyZ1RJRxIZR6+wRPmI/SqNdGpdV1DIhRVvOHm8kiw1/Tz95llDi/fpPBR3HU
	 nN7zZxl4RpxsA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/4] btrfs: some trivial cleanups related to io trees
Date: Tue,  1 Apr 2025 16:29:50 +0100
Message-Id: <cover.1743521098.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743508707.git.fdmanana@suse.com>
References: <cover.1743508707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some simple cleanups related to io trees that are very trivial and were
initally part of a larger patchset. Details in the change logs.

V2: Added patch 3/4.

Filipe Manana (4):
  btrfs: use clear_extent_bit() at try_release_extent_state()
  btrfs: use clear_extent_bits() at chunk_map_device_clear_bits()
  btrfs: use clear_extent_bits() instead of clear_extent_bit() where possible
  btrfs: simplify last record detection at test_range_bit_exists()

 fs/btrfs/extent-io-tree.c    |  8 +++-----
 fs/btrfs/extent_io.c         |  2 +-
 fs/btrfs/inode.c             |  3 +--
 fs/btrfs/reflink.c           |  5 ++---
 fs/btrfs/tests/inode-tests.c | 24 ++++++++++++------------
 fs/btrfs/volumes.c           |  7 +++----
 6 files changed, 22 insertions(+), 27 deletions(-)

-- 
2.45.2


