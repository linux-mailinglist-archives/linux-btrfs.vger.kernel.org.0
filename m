Return-Path: <linux-btrfs+bounces-15401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A4AFF2D9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C771C2003A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9D242D78;
	Wed,  9 Jul 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEg2pBX6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD6223338
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092436; cv=none; b=t52fkaU6033rXmPxs88nPWKU7DiaP0OVptXeaPvgjLfQ6/0VVWJSJJL8Wo/Pd6GdB81r86guMKsep0K7x+s8wdgvWv5uUxNs9pu1loNnq3VX/Yrk8iUlqF+UswJdySrcYESp9NeWx4pv9Yd73pzVN4f15LUKW5EakF9J3nYIasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092436; c=relaxed/simple;
	bh=aPUBW0NMPf/rMp73XDYOE49Iexn1wJdlD83dSTba74k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PrtsqimXr93AScfc2Qab0cEhNUBtC83y3dKIjxXR1bokJhV7QsoAoX26PbVUF4pKH9HlqwOQZG/qejRQkOe7w2TBm2u1brRs8ZDYX6AqAPGWPSaa3cnRpoPWvPFVnnJGJTzu71hmLQytNeeTIuVCHcu3ansI8ukwlaGl+sEQGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEg2pBX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08C5C4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 20:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092435;
	bh=aPUBW0NMPf/rMp73XDYOE49Iexn1wJdlD83dSTba74k=;
	h=From:To:Subject:Date:From;
	b=sEg2pBX67kXT/AmsVgS+ZYZ7I2eQY9JRRZiLEF/T4EAETUmI/PFOYoZth8INuwlmF
	 a0U9akKNPJPL7iWP+RoF3eXcxn0KlAfAkgDovV5hwZYbE+LITgUMC2PZooj48jWz5p
	 /d+C2BXQDs2nvUc+lGCW/fea9/iPptFWkFKhoY6cPSY6Qudhh60k+Chv0z0wijU7oQ
	 X6O9vo+A4hcgGwWJXqgwzMSVBQO+1FzSDhqQFXwqx2d/Q06Dp1YAOtVpHHaSVvfymN
	 sPqKcAn7cqeteCVGXMeuuqrRZYyDH5bZP4ULO1QkbLfTEHepV99S0rBsp0UP5DBzE5
	 mDr1MsE7PYsMQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: some improvements around nocow checking
Date: Wed,  9 Jul 2025 21:20:27 +0100
Message-ID: <cover.1752092303.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Improve nocow write checking to avoid less iterations and less work when
doing buffered writes by checking multiple consecutive extents, plus a
couple cleanups.

Filipe Manana (3):
  btrfs: update function comment for btrfs_check_nocow_lock()
  btrfs: assert we can NOCOW the range in btrfs_truncate_block()
  btrfs: make btrfs_check_nocow_lock() check more than one extent

 fs/btrfs/file.c  | 43 +++++++++++++++++++++++++++++++++----------
 fs/btrfs/inode.c |  7 +++++--
 2 files changed, 38 insertions(+), 12 deletions(-)

-- 
2.47.2


