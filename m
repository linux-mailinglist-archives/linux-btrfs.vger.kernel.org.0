Return-Path: <linux-btrfs+bounces-238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98567F2E79
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 14:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9358F2826C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 13:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACD51C3C;
	Tue, 21 Nov 2023 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXKex2oG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9796168CB
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31317C433C8
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Nov 2023 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700573923;
	bh=Vki2rmPV2F1CN72ojK9bIX1ELmRPOZSAPD/Lsar3T7U=;
	h=From:To:Subject:Date:From;
	b=hXKex2oG8qO1ZHur5RaqcaYLEyBUIWem043gxkixPXrvgd3NhplsD57eDD8gQ3dw/
	 PyxW5dKIu1vP9XuBDArG+XBH2OGfGjBB21PwfxD/LPLNiGOfmZYBuwIg/Zj65azuBJ
	 6JDSFV83jlgk3CJnYl8gbo/jcbVSCjTkPWJStMoenm7TfiOAlt9RL5LkBUV0NSCXnu
	 zqIpqRBwRo3z/6MByADZE3y8JgV7Gk9atIWGGyCAJnqkGLB0yE7BqL5yabPdIzdEsz
	 Y0ZNce9ZzdZNo21PlNPZ4nTzgjU9C2y3cK0rG9bstqEVPJTNpVcwIOu2fIfa16C5Pq
	 1QfUbdF0exGwg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/8] btrfs: add a btrfs_chunk_map structure and preparatory cleanups
Date: Tue, 21 Nov 2023 13:38:31 +0000
Message-Id: <cover.1700573313.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The following are some cleanups and introducing a dedicated data structure
for representing chunk maps, in order to make code simpler and use less
memory - this is achieved in patch 7/8. This patchset is also preparatory
work for some upcoming changes to extent maps.

Filipe Manana (8):
  btrfs: fix off-by-one when checking chunk map includes logical address
  btrfs: make error messages more clear when getting a chunk map
  btrfs: mark sanity checks when getting chunk map as unlikely
  btrfs: split assert into two different asserts when removing block group
  btrfs: unexport extent_map_block_end()
  btrfs: use btrfs_next_item() at scrub.c:find_first_extent_item()
  btrfs: use a dedicated data structure for chunk maps
  btrfs: remove stripe size local variable from insert_dev_extents()

 fs/btrfs/block-group.c            | 167 ++++-----
 fs/btrfs/block-group.h            |   6 +-
 fs/btrfs/dev-replace.c            |  28 +-
 fs/btrfs/disk-io.c                |   7 +-
 fs/btrfs/extent_map.c             |  53 +--
 fs/btrfs/extent_map.h             |  11 -
 fs/btrfs/fs.h                     |   3 +-
 fs/btrfs/inode.c                  |  25 +-
 fs/btrfs/raid56.h                 |   2 +-
 fs/btrfs/scrub.c                  |  52 ++-
 fs/btrfs/tests/btrfs-tests.c      |   3 +-
 fs/btrfs/tests/btrfs-tests.h      |   1 +
 fs/btrfs/tests/extent-map-tests.c |  40 +--
 fs/btrfs/volumes.c                | 545 ++++++++++++++++++------------
 fs/btrfs/volumes.h                |  45 ++-
 fs/btrfs/zoned.c                  |  24 +-
 include/trace/events/btrfs.h      |  11 +-
 17 files changed, 516 insertions(+), 507 deletions(-)

-- 
2.40.1


