Return-Path: <linux-btrfs+bounces-16644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76E6B45D7E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C074A462E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C12FB0AB;
	Fri,  5 Sep 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKEvEQxq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74662FB08F
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088635; cv=none; b=FN815mHCkhCuEshOEWwllbzfPoYhOKxCZ5o47jEF3z76HVxq7JTtFairXZ3nSdH4TOBluPejpoF7Tj8dUnnI2i3o3Wx0BZVdtH5YoOs3wnkfCKyM3YaPBsmuehpsCnNJyUiXvho6fGvUvrVhd6Yp0Ge08tWBmLlea/C7GtGsdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088635; c=relaxed/simple;
	bh=T6iaHz+wTvCTxY+F3xszwm2oclkptjsmKlkUkjHRv2E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g7tNg4ntp9jX9OMlm36tMtCGRZaFsJhfgYx6B13fSO57V6/AVhafj3AlBJCM/a9wIC2e4vVM/aP0XGWjnqQRZYfZkIDGVoqYW7DXtI5oEZPFusyyt14Lo5z0zWVkWd8SUJC6oNLPwzQwWLo33EiWgD/nLP9vwUtgE5BMD8rlX/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKEvEQxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31F0C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088635;
	bh=T6iaHz+wTvCTxY+F3xszwm2oclkptjsmKlkUkjHRv2E=;
	h=From:To:Subject:Date:From;
	b=OKEvEQxqQSYonO0tA1VIfohG/GeXKTDoD0KCnzb98FL/gi5YkIY2itcMJM598cxmy
	 IiXeLW6v6HEMB5B6fRg4gZBC3T3ahcBRzCibSEQVmVphVf+BYSihUb+OMfyDfWrJfX
	 dg28qlNlggkO0OPr2/+6GH8k89lhvdlLG/3wN9w8hLS5Zl9/GQHbnFQLASuLk2sf0R
	 7uS6+NXFCU7xitA/5apyo65jFV8sOyZWx+A7vSOtnxrR+oMYi1zWbX0z2M7StMYuFP
	 oME2Cqpy2PT9IcRtOaR+UU//rbcHKhC61LaOpJtE/baM0Fbd3e/Rcs80mV/mNSngtA
	 XfZhbJFqlIvjw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 00/33] btrfs: log replay bug fix, cleanups and error reporting changes
Date: Fri,  5 Sep 2025 17:09:48 +0100
Message-ID: <cover.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
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
  btrfs: pass walk_control structure to replay_one_extent()
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
 fs/btrfs/tree-log.c | 1292 +++++++++++++++++++++++++------------------
 3 files changed, 762 insertions(+), 534 deletions(-)

-- 
2.47.2


