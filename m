Return-Path: <linux-btrfs+bounces-5202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C28CC34C
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 16:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D667B21D87
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 14:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088E31CFB9;
	Wed, 22 May 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxQqw3Pf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316951C69D
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716388600; cv=none; b=nMk2wu+xELmJs362yRp9ypQzcoOvKUFouMSXM5hgRlz6ZMGiM7Gj0UX7+ZHyZudmBNieWDpuLffZH+/uuXKYa08DSH/Gxo+LuUXjrCe0SCg/MTEag60rfO8joHZ7FGRlaua4+nVHfDLQHOzBh5Qy/VCovHjVEwiAf5juQYjDB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716388600; c=relaxed/simple;
	bh=HPPqhihrWQtl5ajI57v3eZ/pMIFmuQZ+iZvwbyNLJRI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aS7pUGTpq2/J/aXgNnhKJsjFgvItZOs1u18jnrlraeiif8hA4YazMhY+DKVZmcpKUXqS52YahDIUyB9KsKXkRsbSFyz1+EPdhXlb9ie/PnUCGRZop6IIZsfLq/2S1yBCI+lVi2Wsh0VOCmStvHqa+nNsMNEoqZWEtZFQE6y/854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxQqw3Pf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258FAC2BBFC
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716388599;
	bh=HPPqhihrWQtl5ajI57v3eZ/pMIFmuQZ+iZvwbyNLJRI=;
	h=From:To:Subject:Date:From;
	b=uxQqw3Pf9RFXnf44kRSsboJ2avXtp3Yb5DKFxIXGpa3/oppcUiQwBT6cgPBJvpXoH
	 Jh03Iz71uDMFE1g8qeckg448gR2FjPAHWsN3In9ku+HYDqtcNqqJSvm9OwU1clFqVK
	 kgnkKOPteABGGL9jUsQISodsfLeOL2lt/9QV67ppYy2eL7QQgz46d9ZKT8g1hc+JHU
	 9vYAe2rYFs9Mek0gSppe4pgxVs9KB0JfWZJu/lbx5kkWYIrY+lE9SyJrCPHL7bj3UH
	 t8TXRXX+8f7QBTyBLh6uku7G/4T+yyL6ymcX5lb7vqtWrNRnIgBUP3/YnnGFjcMCCi
	 hvnKzxh9FcU7A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: avoid some unnecessary commit of empty transactions
Date: Wed, 22 May 2024 15:36:28 +0100
Message-Id: <cover.1716386100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

A few places can unnecessarily create an empty transaction and then commit
it, when the goal is just to catch the current transaction and wait for
its commit to complete. This results in wasting IO, time and rotation of
the precious backup roots in the super block. Details in the change logs.
The patches are all independent, except patch 4 that applies on top of
patch 3 (but could have been done in any order really, they are independent).

Filipe Manana (7):
  btrfs: qgroup: avoid start/commit empty transaction when flushing reservations
  btrfs: avoid create and commit empty transaction when committing super
  btrfs: send: make ensure_commit_roots_uptodate() simpler and more efficient
  btrfs: send: avoid create/commit empty transaction at ensure_commit_roots_uptodate()
  btrfs: scrub: avoid create/commit empty transaction at finish_extent_writes_for_zoned()
  btrfs: add and use helper to commit the current transaction
  btrfs: send: get rid of the label and gotos at ensure_commit_roots_uptodate()

 fs/btrfs/disk-io.c     |  8 +-------
 fs/btrfs/qgroup.c      | 31 +++++--------------------------
 fs/btrfs/scrub.c       |  6 +-----
 fs/btrfs/send.c        | 32 ++++++++------------------------
 fs/btrfs/space-info.c  |  9 +--------
 fs/btrfs/super.c       | 11 +----------
 fs/btrfs/transaction.c | 19 +++++++++++++++++++
 fs/btrfs/transaction.h |  1 +
 8 files changed, 37 insertions(+), 80 deletions(-)

-- 
2.43.0


