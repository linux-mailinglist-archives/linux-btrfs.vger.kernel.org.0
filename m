Return-Path: <linux-btrfs+bounces-16695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66BB48915
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6FC173EA1
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E862ED141;
	Mon,  8 Sep 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGB1tBnd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D91E505
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325211; cv=none; b=aSEIeoinNWzUqa0/Givzuc6aw1j3Tj2zHKeFTT2zRFJN3lqBnNQrfrz8Rvid+NK6in7/fqI6TqF+1/xI6q5yhjR4v4JSTHFgbKq3cF1GlH9+tz0x65vNfHgkbQk2R6gcjVhnWQYzI9ePSTSF5qjxhUb8RRCh3HK3ONnjKf1AuDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325211; c=relaxed/simple;
	bh=PU9TT5xvZAZmTIbeEmO0hHt/vCvIwoZ6a4Njh/7Yqf8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7sn5+FwHq0yMYRSBi1ptRmd5A5yaPwR97QWP9jTaEcXXdvKLiDakLEAi9sxCs9Vr1vf8fXRt6Y4d9uOK2vgtyGjfehn8CvPGRp/xLDPDBU+x7RBrwTtWJfqqEp7EdyFixgBks9HpfYXp32QhxKoyUlEqLkFk0+pfIATFEnmf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGB1tBnd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B17FC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325210;
	bh=PU9TT5xvZAZmTIbeEmO0hHt/vCvIwoZ6a4Njh/7Yqf8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mGB1tBndVqHWNxnc4dLMnQYNjR+NCI9bco+c2jzg9mBCw/7an+sy7mckrpJs+RaZt
	 bJmL1eaSok5DM7un2gYXLpfdNN7s7VRW2PfsxSpZoHWZmHd4SWaKbT8aElvSKgGJ9X
	 EtNqFQ8YC7GuM7G+irMXX9xWczu0p/P1oVIL4ziU2F+1hq9StEWyrCuq6auc4ssFWi
	 gIc9iKVptWDSU0kr8/LOQd9I+CVau1b54kYYOoQRkeHB/0JSw03v8i78tfTlw7HQEX
	 r/Kn6vpZOraTO5gjgpfExX7YuZDUg1VVDgN9tFs9WsBGIavr3f0DmGBHHaRSS+yN7G
	 NOJqOyUe9+rxg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/33] btrfs: log replay bug fix, cleanups and error reporting changes
Date: Mon,  8 Sep 2025 10:52:54 +0100
Message-ID: <cover.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The following are a bug fix for an extref key offset computation, several
cleanups to eliminate duplicated or not needed code, memory allocations
and preparation work for the final change which is to make log replay
failures dump contextual information useful to help debug failures during
log replay. Details in the change logs.

V2: Update subject of patch 18/33 which was a duplicate of another one
    likely due to copy paste. Update patch 33/33 to avoid use-after-free
    on a name if we had an error during replay of xattr deletes.

Filipe Manana (33):
  btrfs: fix invalid extref key setup when replaying dentry
  btrfs: use booleans in walk control structure for log replay
  btrfs: rename replay_dest member of struct walk_control to root
  btrfs: rename root to log in walk_down_log_tree() and walk_up_log_tree()
  btrfs: add and use a log root field to struct walk_control
  btrfs: deduplicate log root free in error paths from btrfs_recover_log_trees()
  btrfs: stop passing transaction parameter to log tree walk functions
  btrfs: stop setting log_root_tree->log_root to NULL in btrfs_recover_log_trees()
  btrfs: always drop log root tree reference in btrfs_replay_log()
  btrfs: pass walk_control structure to replay_xattr_deletes()
  btrfs: move up the definition of struct walk_control
  btrfs: pass walk_control structure to replay_dir_deletes()
  btrfs: pass walk_control structure to check_item_in_log()
  btrfs: pass walk_control structure to replay_one_extent()
  btrfs: pass walk_control structure to add_inode_ref() and helpers
  btrfs: pass walk_control structure to replay_one_dir_item() and replay_one_name()
  btrfs: pass walk_control structure to drop_one_dir_item() and helpers
  btrfs: pass walk_control structure to overwrite_item()
  btrfs: use level argument in log tree walk callback process_one_buffer()
  btrfs: use level argument in log tree walk callback replay_one_buffer()
  btrfs: use the inode item boolean everywhere in overwrite_item()
  btrfs: add current log leaf, key and slot to struct walk_control
  btrfs: avoid unnecessary path allocation at fixup_inode_link_count()
  btrfs: avoid path allocations when dropping extents during log replay
  btrfs: avoid unnecessary path allocation when replaying a dir item
  btrfs: remove redundant path release when processing dentry during log replay
  btrfs: remove redundant path release when overwriting item during log replay
  btrfs: add path for subvolume tree changes to struct walk_control
  btrfs: stop passing inode object IDs to __add_inode_ref() in log replay
  btrfs: remove pointless inode lookup when processing extrefs during log replay
  btrfs: abort transaction if we fail to find dir item during log replay
  btrfs: abort transaction if we fail to update inode in log replay dir fixup
  btrfs: dump detailed info and specific messages on log replay failures

 fs/btrfs/disk-io.c  |    2 +-
 fs/btrfs/fs.h       |    2 +
 fs/btrfs/tree-log.c | 1299 +++++++++++++++++++++++++------------------
 3 files changed, 767 insertions(+), 536 deletions(-)

-- 
2.47.2


