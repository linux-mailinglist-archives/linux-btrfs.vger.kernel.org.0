Return-Path: <linux-btrfs+bounces-574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50165803A04
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27F9B20BC4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A752DF63;
	Mon,  4 Dec 2023 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6/tSQIE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B15395
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AA5C433C7
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706837;
	bh=2GHftgR7L/GLPlW1c5jQs1erz+9hO0LxUZ9vQbCjOsA=;
	h=From:To:Subject:Date:From;
	b=S6/tSQIE2SpJJBEsJmlRPQONCPP+1jp3P3497mTPo/AVEWe03r8pTFvg7nUugCeEL
	 d2sAu3XEtNyINNbTA+n2hU8sUKV6OWCOaYPo4jx3yxPCLPuS+fKIC5qdcOGpOxCLpt
	 T8UCG03nJss8uAewfWCASTRB5lLVpM8i6OiE80gCSMzfQOLBNMqxrj3ffNA8jqA24G
	 nF1o+9kH89V2SmmTIvQgJcmD+RiDjdNU8wPEnElDgCsjQegrfT+uW4GyUsCXwCxwHn
	 1d8kl8cHiQlVIjiv+iC6ULB0oOobtf0RCsoK4hiwTmUuL22Fs6XthU4Onh9gJOfYGe
	 4bc2jlpJuZiFw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/11] btrfs: some cleanups and optimizations for extent maps
Date: Mon,  4 Dec 2023 16:20:22 +0000
Message-Id: <cover.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

These do some cleanups around extent maps and their tests, as well as
some optimizations. These are part of a larger work around extent maps,
but as they are fairly independent and the remainder will take a longer
while, sending these out separately. More details on the change logs.

Filipe Manana (11):
  btrfs: assert extent map is not in a list when setting it up
  btrfs: tests: fix error messages for test case 4 of extent map tests
  btrfs: tests: do not ignore NULL extent maps for extent maps tests
  btrfs: tests: print all values as decimal in messages for extent map tests
  btrfs: unexport add_extent_mapping()
  btrfs: remove redundant value assignment at btrfs_add_extent_mapping()
  btrfs: log messages at unpin_extent_range() during unexpected cases
  btrfs: avoid useless rbtree iterations when attempting to merge extent map
  btrfs: make extent_map_end() argument const
  btrfs: refactor mergable_maps() for more readability
  btrfs: use the flags of an extent map to identify the compression type

 fs/btrfs/compression.c            |   4 +-
 fs/btrfs/defrag.c                 |   8 +-
 fs/btrfs/extent_io.c              |  13 ++-
 fs/btrfs/extent_map.c             | 139 ++++++++++++++++--------------
 fs/btrfs/extent_map.h             |  64 +++++++++++---
 fs/btrfs/file-item.c              |   9 +-
 fs/btrfs/file.c                   |  10 +--
 fs/btrfs/inode.c                  |  35 ++++----
 fs/btrfs/relocation.c             |   2 +-
 fs/btrfs/tests/extent-map-tests.c | 103 +++++++++++++---------
 fs/btrfs/tests/inode-tests.c      |  60 ++++++-------
 fs/btrfs/tree-log.c               |  16 ++--
 include/trace/events/btrfs.h      |  21 +++--
 13 files changed, 272 insertions(+), 212 deletions(-)

-- 
2.40.1


